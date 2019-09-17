// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // updateChannel
    updateChannel: 'stable',

    // lineHeight
    lineHeight: 1.5,

    // default font size in pixels for all tabs
    fontSize: 15,

    // font family with optional fallbacks
    fontFamily: 'Fantasque Sans Mono',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // set to true for blinking cursor
    cursorBlink: false,

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: ``,

    // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: '',

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // Plugin configs
    // MaterialTheme: https://github.com/equinusocio/hyper-material-theme
    MaterialTheme: {
      theme: 'Darker',
      vibrancy: 'ultra-dark'
    },

    // hyperborder: https://github.com/webmatze/hyperborder
    hyperBorder: {
      animate: true,
      borderColors: ['#F1A5AB', '#91C5D3', '#A9D0A4', '#FFE3A9']
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    // make sure to use a full path if the binary name doesn't work
    // (e.g `C:\\Windows\\System32\\bash.exe` instead of just `bash.exe`)
    // if you're using powershell, make sure to remove the `--login` below
    shell: '/usr/local/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',
    // bellSoundURL: 'https://archive.org/download/ANDHISNAMEISJOHNCENAWhoAreBassbeasts/AND%20HIS%20NAME%20IS%20JOHN%20CENA%20%5BWho%20are%20bassbeasts%5D.mp3'

    // for advanced config flags please refer to https://hyper.is/#cfg
    // if true, Hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    /* 'hyperborder', */
    'hypercwd',
    'hyper-pane',
    'hyper-tab-icons',
    'hyper-subliminal'
  ]

  // plugins: ['hyper-material-theme', 'hyper-seoul256']

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  // localPlugins: ['/Users/jerolan/workspace/hyper-seoul256']
};
