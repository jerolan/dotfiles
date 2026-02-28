---
name: serverless-iam-roles
description: "Use this skill whenever you create, review, audit, or modify inline IAM roles (Deployment Role and/or RBAC Execution Role) inside a Serverless Framework serverless.yml file for the fx-payments repo. Trigger when the user mentions: 'create roles', 'RBAC role', 'deployment role', 'inline IAM', 'least privilege', 'resource-level permissions', 'resource scope', 'serverless IAM', 'iam policies serverless', 'provisioning role', 'execution role', or asks 'which actions need Resource: *?'. Also trigger on audits like 'review my IAM policies', 'check my roles for least privilege', or 'split my policies by resource scope'."
---

# Serverless IAM Roles — Deployment + RBAC

Every fx-payments serverless stack that deploys Lambda functions needs **two** inline IAM roles in `resources.Resources`:

| Role | Logical ID pattern | Assumed by | Purpose |
|------|--------------------|------------|---------|
| **Deployment Role** | `Fx{Module}DeploymentRole` | `cloudformation.amazonaws.com` | Provisions/updates/deletes stack resources |
| **RBAC Role** | `Fx{Module}RbacRole` | `lambda.amazonaws.com` + any schedulers (`scheduler.amazonaws.com`) | Runtime permissions for functions |

Both roles use a single inline `Policies` entry (not managed policies) so the full definition lives in the serverless.yml, versioned with the code.

---

## The "Resource Scope" Rule

This is the most important concept in the skill and the reason it exists. **AWS IAM actions fall into two categories** (per the [fogsecurity/aws-iam](https://github.com/fogsecurity/aws-iam) Service Authorization Reference):

### Actions WITHOUT resource-level permissions

When an action has **no resource type** listed in the Service Authorization Reference (SAR), it does not support resource-level restrictions. You **must** use `Resource: '*'`.

Group these together under dedicated `Sid` statements clearly labeled — this makes reviewers instantly see why `'*'` is used and that it's intentional, not lazy.

### Actions WITH resource-level permissions

These actions support restricting to specific ARNs. Always scope them to the narrowest ARN pattern possible (`${self:service}-*`, specific table names, etc.).

Group these by service/purpose, each with its own `Sid`.

---

## Known Actions WITHOUT Resource Support

These are the most commonly needed actions that **require** `Resource: '*'` because the SAR lists no resource type for them.

### CloudFormation (deployment role)

All CloudFormation stack-level actions lack resource types in the SAR:

```yaml
- cloudformation:CreateChangeSet
- cloudformation:CreateStack
- cloudformation:DeleteChangeSet
- cloudformation:DeleteStack
- cloudformation:DescribeChangeSet
- cloudformation:DescribeStackEvents
- cloudformation:DescribeStacks
- cloudformation:ExecuteChangeSet
- cloudformation:GetTemplate
- cloudformation:GetTemplateSummary
- cloudformation:ListStacks
- cloudformation:UpdateStack
- cloudformation:UpdateTerminationProtection
- cloudformation:ValidateTemplate
```

### STS

```yaml
- sts:GetCallerIdentity        # no resource type
```

### Lambda — Event Source Mapping

Function-level Lambda actions (CreateFunction, InvokeFunction, etc.) **do** support resource scope. But ESM actions do not:

```yaml
- lambda:CreateEventSourceMapping
- lambda:DeleteEventSourceMapping
- lambda:GetEventSourceMapping
- lambda:ListEventSourceMappings
- lambda:UpdateEventSourceMapping
```

### ECR

```yaml
- ecr:GetAuthorizationToken     # no resource type (registry-level)
```

Repository-level actions (BatchGetImage, CreateRepository, etc.) **do** support resource scope.

### CloudWatch Logs

```yaml
- logs:DescribeLogGroups        # no resource type
```

Log-group-level actions (CreateLogGroup, PutLogEvents, etc.) **do** support resource scope.

### X-Ray (RBAC role)

```yaml
- xray:PutTelemetryRecords     # no resource type
- xray:PutTraceSegments        # no resource type
```

---

## Deployment Role Template

```yaml
Fx{Module}DeploymentRole:
  Type: AWS::IAM::Role
  Properties:
    RoleName: ${self:service}-${self:custom.stage}-${self:custom.region}-deployment-role
    AssumeRolePolicyDocument:
      Version: '2012-10-17'
      Statement:
        - Effect: Allow
          Principal:
            Service: cloudformation.amazonaws.com
          Action: sts:AssumeRole
    Policies:
      - PolicyName: ${self:service}-${self:custom.stage}-deployment-policy
        PolicyDocument:
          Version: '2012-10-17'
          Statement:
            # ── Actions WITHOUT resource-level permissions ─────────
            - Sid: CloudFormationAndStsGlobal
              Effect: Allow
              Action:
                - cloudformation:CreateChangeSet
                - cloudformation:CreateStack
                - cloudformation:DeleteChangeSet
                - cloudformation:DeleteStack
                - cloudformation:DescribeChangeSet
                - cloudformation:DescribeStackEvents
                - cloudformation:DescribeStacks
                - cloudformation:ExecuteChangeSet
                - cloudformation:GetTemplate
                - cloudformation:GetTemplateSummary
                - cloudformation:ListStacks
                - cloudformation:UpdateStack
                - cloudformation:UpdateTerminationProtection
                - cloudformation:ValidateTemplate
                - sts:GetCallerIdentity
              Resource: '*'
            # Add more global Sids as needed (ESM, ECR auth, etc.)

            # ── Actions WITH resource-level permissions ────────────
            # Add scoped Sids per service the stack provisions
```

### Common Scoped Statements (Deployment)

Pick the ones that match what the stack actually provisions:

| Sid | When to include | Resource pattern |
|-----|----------------|-----------------|
| `S3DeploymentBucket` | Always (every stack has one) | `arn:aws:s3:::{bucket}`, `…/*` |
| `LambdaFunctionProvisioning` | Stack has Lambda functions | `arn:aws:lambda:{region}:{account}:function:{service}-*` |
| `DynamoDbTableProvisioning` | Stack has DynamoDB tables | `arn:aws:dynamodb:{region}:{account}:table/{table-name}` + `…/*` |
| `CloudWatchLogsProvisioning` | Always (Lambda creates log groups) | `arn:aws:logs:{region}:{account}:log-group:/aws/lambda/{service}-*` + `:*` |
| `SsmParameterProvisioning` | Stack creates SSM params | `arn:aws:ssm:{region}:{account}:parameter/gbm/fx-payments/*` |
| `SnsTopicProvisioning` | Stack has alerts/SNS topics | `arn:aws:sns:{region}:{account}:{service}-*-alerts-alarm` |
| `SqsQueueProvisioning` | Stack has SQS queues or DLQs | `arn:aws:sqs:{region}:{account}:{service}-*` |
| `CloudWatchAlarmProvisioning` | Stack has alarms | `arn:aws:cloudwatch:{region}:{account}:alarm:*` |
| `EcrRepositoryProvisioning` | Stack builds Docker images | `arn:aws:ecr:{region}:{account}:repository/serverless-{service}-*` |
| `SchedulerProvisioning` | Stack has EventBridge Scheduler | `arn:aws:scheduler:{region}:{account}:schedule/default/*` |
| `IamRoleManagement` | Always (manages own RBAC role) | `arn:aws:iam::{account}:role/{service}-*` |

---

## RBAC Role Template

```yaml
Fx{Module}RbacRole:
  Type: AWS::IAM::Role
  Properties:
    RoleName: ${self:service}-${self:custom.stage}-${self:custom.region}-rbac-role
    AssumeRolePolicyDocument:
      Version: '2012-10-17'
      Statement:
        - Effect: Allow
          Principal:
            Service:
              - lambda.amazonaws.com
              # Add scheduler.amazonaws.com if the stack uses EventBridge Scheduler
          Action: sts:AssumeRole
    Policies:
      - PolicyName: ${self:service}-${self:custom.stage}-rbac-policy
        PolicyDocument:
          Version: '2012-10-17'
          Statement:
            # ── Actions WITHOUT resource-level permissions ─────────
            - Sid: XrayGlobal
              Effect: Allow
              Action:
                - xray:PutTelemetryRecords
                - xray:PutTraceSegments
              Resource: '*'
            # Add ecr:GetAuthorizationToken here if stack uses Docker images

            # ── Actions WITH resource-level permissions ────────────
            # Add scoped Sids per what lambdas actually do at runtime
```

### Common Scoped Statements (RBAC)

Pick the ones that match what the functions actually do:

| Sid | When to include | Resource pattern |
|-----|----------------|-----------------|
| `CloudWatchLogsWrite` | Always | `arn:aws:logs:{region}:{account}:log-group:/aws/lambda/{service}-*` + `:*` |
| `DynamoDbTableOperations` | Lambdas read/write DynamoDB | Table ARN + `/index/*` (use `${construct:X.tableArn}` if Lift) |
| `DynamoDbStreamRead` | Lambda triggered by DDB stream | `${construct:X.tableStreamArn}` |
| `LambdaInvoke` | Lambda invokes other lambdas | `arn:aws:lambda:{region}:{account}:function:{service}-*` |
| `EcrImagePull` | Docker-based functions | `arn:aws:ecr:{region}:{account}:repository/serverless-{service}-*` |
| `SsmParameterRead` | Lambdas read SSM at startup | `/gbm/fx-payments/*`, `/devops*`, `/gbm/sre*` |
| `SqsDlqWrite` | Lambda has a dead-letter queue | `arn:aws:sqs:{region}:{account}:{service}-*Dlq` |
| `SqsReadWrite` | Lambda consumed from / sends to SQS | Specific queue ARN pattern |
| `SnsPublish` | Lambda publishes to SNS | Specific topic ARN pattern |
| `S3ReadWrite` | Lambda accesses S3 buckets | Specific bucket ARN |

---

## Provider Wiring

```yaml
provider:
  iam:
    role:
      Fn::GetAtt:
        - Fx{Module}RbacRole
        - Arn
    deploymentRole: arn:aws:iam::${aws:accountId}:role/${self:service}-${self:custom.stage}-${self:custom.region}-deployment-role
  deploymentBucket:
    name: ${self:custom.deployment_bucket}
```

> **Bootstrap note**: on the very first deploy the deployment role doesn't exist yet (it's created by the stack itself). Comment out `deploymentRole` for the first deploy, then uncomment it.

---

## Workflow

When building roles for a stack:

1. **Read the serverless.yml** — identify all functions, event sources, constructs, and environment variables.
2. **Read the generated CloudFormation** (`.serverless/cloudformation-template-update-stack.json`) if available — it shows the exact resources CF provisions and the actions the existing auto-generated role uses.
3. **Catalog the services** the stack touches (Lambda, DynamoDB, S3, ECR, SQS, SNS, SSM, Scheduler, CloudWatch, X-Ray, etc.).
4. **For each service**, use the reference above to classify actions as global (`Resource: '*'`) or scoped.
5. **Write the DeploymentRole** — what CF needs to provision the resources.
6. **Write the RbacRole** — what the functions need at runtime.
7. **Group statements** — all global actions first (clearly commented), then scoped actions by service.
8. **Add the `provider.iam` wiring**.

### Audit checklist

When reviewing existing roles:

- [ ] Every `Resource: '*'` statement uses only actions that genuinely have no resource type in the SAR
- [ ] No action that supports resource scope is lumped into a `Resource: '*'` statement
- [ ] Scoped resources use the narrowest possible ARN pattern (service prefix, not wildcard)
- [ ] DynamoDB table + stream are in separate statements (different action sets)
- [ ] ECR `GetAuthorizationToken` is in a global statement; image actions are scoped to repository ARN
- [ ] Lambda ESM actions are in a global statement; function actions are scoped
- [ ] Each `Sid` has a descriptive name indicating the purpose
- [ ] `AssumeRolePolicyDocument` lists only the services that actually assume the role

---

## Research with context7

When you need to verify whether a specific action supports resource-level permissions:

1. Use `mcp_context7_resolve-library-id` with `fogsecurity/aws-iam`
2. Query with `mcp_context7_query-docs` for the specific action or service
3. Cross-reference with the "Actions without Resources" listing in the SAR

The fogsecurity/aws-iam repository maintains a programmatic listing of all IAM actions and flags which ones have no resource type defined. When an action appears in the `actions_without_resources` dataset, it requires `Resource: '*'`.
