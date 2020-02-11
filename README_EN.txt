* README_EN.txt
* 2020.02.10
* tacklelib--3dparty

1. DESCRIPTION
2. LICENSE
3. REPOSITORIES
4. PREREQUISITES
5. CATALOG CONTENT DESCRIPTION
6. CONFIGURE
7. USAGE
8. SSH+SVN/PLINK SETUP
9. KNOWN ISSUES
9.1. svn+ssh issues
9.1.1. Message `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
       `svn: E170012: Can't create tunnel`
9.1.2. Message `Can't create session: Unable to connect to a repository at URL 'svn+ssh://...': `
       `To better debug SSH connection problems, remove the -q option from ssh' in the [tunnels] section of your Subversion configuration file. `
       `at .../Git/mingw64/share/perl5/Git/SVN.pm line 310.'`
9.1.3. Message `Keyboard-interactive authentication prompts from server:`
       `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
       `svn: E210002: To better debug SSH connection problems, remove the -q option from 'ssh' in the [tunnels] section of your Subversion configuration file.`
       `svn: E210002: Network connection closed unexpectedly`
9.2. Python execution issues
9.2.1. `OSError: [WinError 6] The handle is invalid`
9.3. pytest execution issues
9.4. fcache execution issues
10. AUTHOR

-------------------------------------------------------------------------------
1. DESCRIPTION
-------------------------------------------------------------------------------
Third party projects for the tacklelib project.

-------------------------------------------------------------------------------
2. LICENSE
-------------------------------------------------------------------------------
The MIT license (see included text file "license.txt" or
https://en.wikipedia.org/wiki/MIT_License)

-------------------------------------------------------------------------------
3. REPOSITORIES
-------------------------------------------------------------------------------
Primary:
  * https://sf.net/p/tacklelib/tacklelib--3dparty/HEAD/tree/trunk
  * https://svn.code.sf.net/p/tacklelib/tacklelib--3dparty/trunk
First mirror:
  * https://github.com/andry81/tacklelib--3dparty/tree/trunk
  * https://github.com/andry81/tacklelib--3dparty.git
Second mirror:
  * https://bitbucket.org/andry81/tacklelib-3dparty/src/trunk
  * https://bitbucket.org/andry81/tacklelib-3dparty.git

-------------------------------------------------------------------------------
4. PREREQUISITES
-------------------------------------------------------------------------------

Currently tested these set of OS platforms, interpreters and modules to run
from:

1. OS platforms.

* Windows 7 (`.bat` only)

2. Interpreters:

* python 3.7.3 or 3.7.5 (3.4+ or 3.5+)
  https://python.org
  - standard implementation to run python scripts
  - 3.7.4 has a bug in the `pytest` module execution, see `KNOWN ISSUES`
    section
  - 3.5+ is required for the direct import by a file path (with any extension)
    as noted in the documentation:
    https://docs.python.org/3/library/importlib.html#importing-a-source-file-directly

3. Modules

* Python site modules:

**  xonsh/0.9.12
    https://github.com/xonsh/xonsh
    - to run python scripts and import python modules with `.xsh` file
      extension
**  plumbum 1.6.7
    https://plumbum.readthedocs.io/en/latest/
    - to run python scripts in a shell like environment
**  win_unicode_console
    - to enable unicode symbols support in the Windows console
**  pyyaml 5.1.1
    - to read yaml format files (.yaml, .yml)
**  conditional 1.3
    - to support conditional `with` statements
**  fcache 0.4.7
    - for local cache storage for python scripts
**  psutil 5.6.7
    - for processes list request
**  tzlocal 2.0.0
    - for local timezone request

Temporary dropped usage:

**  prompt-toolkit 2.0.9
    - optional dependency to the Xonsh on the Windows
**  cmdix 0.2.0
    https://github.com/jaraco/cmdix
    - extension to use Unix core utils within Python environment as plain
      executable or python function

4. Patches:

* Python site modules contains patches in the `_pyxvcs/python_patches`
  subdirectory:

** fcache
   - to fix issues from the `fcache execution issues` section.

5. Applications:

* subversion 1.8+
  https://tortoisesvn.net
  - to run svn client

* git 2.24+
  https://git-scm.com
  - to run git client

-------------------------------------------------------------------------------
5. CATALOG CONTENT DESCRIPTION
-------------------------------------------------------------------------------

The example directory structure is this:

/<root>
  |
  +-/_scripts/01_checkout
  |        - The root scripts directory, represents context for all projects
  |          together. Any script execution in that directory has to be
  |          applied for all projects represented in subdirectories
  |          respectively.
  |
  |
  +-/_src
           - The working copy root directory for a particular projects group.
             Stores sources in a subdirectory as a vcs working copy or as a
             local files.

The `01_checkout` directory contains configuration files with various
parameters along wit parameters which can be passed to command scripts in
these directories.

The system loads configuration files in directories from the root to the most
nested directory.

If a variable in a configuration file from nested directory is intersected with
the same variable in the parent directory, then the value from the nested one
is used instead (variable specialization).

-------------------------------------------------------------------------------
6. CONFIGURE
-------------------------------------------------------------------------------

From the `01_checkout` subdirectory:

1. Run the `01_configure.vars.*` script.
   Edit `config.vars` variables for correct values.
2. Run the `02_configure.private.*` script.
   Edit `*.HUB_ABBR` and `*.PROJECT_PATH_LIST` variables to define how and
   where to generate respective command scripts.
   Edit all other variables from the `config.private.yaml` file.
3. Run the `03_configure.yaml.*` script.
   Edit `SVN_SSH_ENABLED` and `GIT_SSH_ENABLED` variables to properly
   enable/disable ssh protocol usage from the svn/git utilities.
   Edit `SVN_SSH_AGENT`, `GIT_SSH_AGENT`, `GIT_SVN_SSH_AGENT` variables related
   to the ssh protocol.
   Edit the `WCROOT_OFFSET` variable in the respective `config.yaml` file
   and change the default working copies directory structure if is required to.
   Edit all other variables in `config.yaml` and `config.env.yaml` files.
4. Run the `04_configure.*` script.

Note:
  You can run respective configure scripts from a nested directory to apply
  configuration separately in that nested directory.

-------------------------------------------------------------------------------
7. USAGE
-------------------------------------------------------------------------------

Any deploy script format:
  `<HubAbbrivatedName>~<ScmName>~<CommandOperation>.*`, where:

  `HubAbbrivatedName` - Hub abbrivated name to run a command for.
  `ScmName`           - Version Source Control service name in a hub.
  `CommandOperation`  - Command operation name to request.

  `HubAbbrivatedName` can be:
    `sf` - SourceForge
    `gl` - GitLab
    `gh` - GitHub
    `bb` - BitBucket

  `ScmName` can be:
    `git` - git source control
    `svn` - svn source control

  `CommandOperation` can be:

  [ScmName=git]
    `init`      - create and initialize local git working copy directory.
    `fetch`     - fetch remote git repositories and optionally does
                  (by default is) the fetch of all subtrees.
    `pull`      - pull remote git repositories and optionally does
                  (by default is) the pull of all subtrees.
    `reset`     - reset local working copy and optionally does
                  (by default is) the reset of all subtree working copies.
  [ScmName=svn]
    `checkout`  - checks out an svn repository into new svn working copy
                  directory.
    `update`    - updates svn working copy directory from a remote svn
                  repository.
    `relocate`  - changes in the local working copy the url onto different
                  remote svn repository (for example, to change the url
                  scheme use these parameters: `https://` `svn+ssh://`).

-------------------------------------------------------------------------------
8. SSH+SVN/PLINK SETUP
-------------------------------------------------------------------------------
Based on: https://stackoverflow.com/questions/11345868/how-to-use-git-svn-with-svnssh-url/58641860#58641860

The svn+ssh protocol must be setuped using both the private and the public ssh
key.

In case of in the Windows usage you have to setup the ssh key before run the
svn client using these general steps related to the native Windows `svn.exe`
(should not be a ported one, for example, like the `msys` or `cygwin` tools
which is not fully native):

1. Install the `putty` client.
2. Generate the key using the `puttygen.exe` utility and the correct type of
   the key dependent on the svn hub server (Ed25519, RSA, DSA, etc).
3. Install the been generated public variant of the key into the svn hub server
   by reading the steps from the docs to the server.
4. Ensure that the `SVN_SSH` environment variable in the generated
   `config.env.yaml` file is pointing a correct path to the `plink.exe` and
   uses valid arguments. This would avoid hangs in scripts because of
   interactive login/password request and would avoid usage svn repository
   urls with the user name inside.
5. Ensure that all svn working copies and the `externals` properties in them
   contains valid svn repository urls with the `svn+ssh://` prefix. If not then
   use the `*~svn~relocate.*` scrtip(s) to switch onto it. Then fix all the
   rest urls in the `externals` properties, for example, just by remove the url
   scheme prefix and leave the `//` prefix instead.
6. Run the `pageant.exe` in the background with the previously generated
   private key (add it).
7. Test the connection to the svn hub server through the `putty.exe` client.
   The client should not ask for the password if the `pageant.exe` is up and
   running with has been correctly setuped private key. The client should not
   ask for the user name either if the `SVN_SSH` environment variable is
   declared with the user name.

The `git` client basically is a part of ported `msys` or `cygwin` tools, which
means they behaves a kind of differently.

The one of the issues with the message `Can't create session: Unable to connect
to a repository at URL 'svn+ssh://...': Error in child process: exec of ''
failed: No such file or directory at .../Git/mingw64/share/perl5/Git/SVN.pm
line 310.` is the issue with the `SVN_SSH` environment variable. The variable
should be defined with an utility from the same tools just like the `git`
itself. The attempt to use it with the standalone `plink.exe` from the `putty`
application would end with that message.

So, additionally to the steps for the `svn.exe` application you should apply,
for example, these steps:

1. Drop the usage of the `SVN_SSH` environment variable and remove it.
2. Run the `ssh-pageant` from the `msys` or `cygwin` tools (the `putty`'s
   `pageant` must be already run with the valid private key). You can read
   about it, for example, from here: https://github.com/cuviper/ssh-pageant
   ("ssh-pageant is a tiny tool for Windows that allows you to use SSH keys
   from PuTTY's Pageant in Cygwin and MSYS shell environments.")
3. Create the environment variable returned by the `ssh-pageant` from the
   stdout, for example: `SSH_AUTH_SOCK=/tmp/ssh-hNnaPz/agent.2024`.
4. Use urls in the `git svn ...` commands together with the user name as stated
   in the documentation
   (https://git-scm.com/docs/git-svn#Documentation/git-svn.txt---usernameltusergt ):
   `svn+ssh://<USERNAME>@svn.<url>.com/repo`
   ("For transports that SVN handles authentication for (http, https, and plain
   svn), specify the username. For other transports (e.g. svn+ssh://), you
   **must include the username in the URL**,
   e.g. svn+ssh://foo@svn.bar.com/project")

These instructions should help to use `git svn` commands together with the
`svn` commands.

NOTE:
  The scripts does all above automatically. All you have to do is to ensure
  that you are using valid paths and keys in the respective configuration
  files.

-------------------------------------------------------------------------------
9. KNOWN ISSUES
-------------------------------------------------------------------------------
For the issues around python xonsh module see details in the
`README_EN.python_xonsh.known_issues.txt` file.

-------------------------------------------------------------------------------
9.1. svn+ssh issues
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
9.1.1. Message `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
       `svn: E170012: Can't create tunnel`
-------------------------------------------------------------------------------

Issue #1:

The `svn ...` command was run w/o properly configured putty plink utility or
w/o the `SVN_SSH` environment variable with the user name parameter.

Solution:

Carefully read the `SSH+SVN/PLINK SETUP` section to fix most of the cases.

Issue #2

The `SVN_SSH` environment variable have has the backslash characters - `\`.

Solution:

Replace all the backslash characters by forward slash character - `/` or by
double baskslash character - `\\`.

Issue #3

The `config.private.yaml` contains invalid values or was regenerated to
default values.

Solution:

Manually edit variables in the file for correct values.

-------------------------------------------------------------------------------
9.1.2. Message `Can't create session: Unable to connect to a repository at URL 'svn+ssh://...': `
       `To better debug SSH connection problems, remove the -q option from ssh' in the [tunnels] section of your Subversion configuration file. `
       `at .../Git/mingw64/share/perl5/Git/SVN.pm line 310.'`
-------------------------------------------------------------------------------

Issue:

The `git svn ...` command should not be called with the `SVN_SSH` variable
declared for the `svn ...` command.

Solution:

Read docs about the `ssh-pageant` usage from the msys tools to fix that.

See details: https://stackoverflow.com/questions/31443842/svn-hangs-on-checkout-in-windows/58613014#58613014

NOTE:
  The scripts does automatic maintain of the `ssh-pageant` utility startup.
  All you have to do is to ensure that you are using valid paths and keys in
  the respective configuration files.

-------------------------------------------------------------------------------
9.1.3. Message `Keyboard-interactive authentication prompts from server:`
       `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
       `svn: E210002: To better debug SSH connection problems, remove the -q option from 'ssh' in the [tunnels] section of your Subversion configuration file.`
       `svn: E210002: Network connection closed unexpectedly`
-------------------------------------------------------------------------------

Related command: `git svn ...`

Issue #1:

Network is disabled:

Issue #2:

The `pageant` application is not running or the provate SSH key is not added.

Issue #3:

The `ssh-pageant` utility is not running or the `git svn ...` command does run
without the `SSH_AUTH_SOCK` environment variable properly registered.

Solution:

Read the deatils in the `SSH+SVN/PLINK SETUP` section.

-------------------------------------------------------------------------------
9.2. Python execution issues
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
9.2.1. `OSError: [WinError 6] The handle is invalid`
-------------------------------------------------------------------------------

Issue:

The python interpreter (3.7, 3.8, 3.9) sometimes throws this message at exit,
see details here: https://bugs.python.org/issue37380

Solution:

Reinstall a different python version.

-------------------------------------------------------------------------------
9.3. pytest execution issues
-------------------------------------------------------------------------------
* `xonsh incorrectly reorders the test for the pytest` :
  https://github.com/xonsh/xonsh/issues/3380
* `a test silent ignore` :
  https://github.com/pytest-dev/pytest/issues/6113
* `can not order tests by a test directory path` :
  https://github.com/pytest-dev/pytest/issues/6114


-------------------------------------------------------------------------------
9.4. fcache execution issues
-------------------------------------------------------------------------------
* `fcache is not multiprocess aware on Windows` :
  https://github.com/tsroten/fcache/issues/26
* ``_read_from_file` returns `None` instead of (re)raise an exception` :
  https://github.com/tsroten/fcache/issues/27
* `OSError: [WinError 17] The system cannot move the file to a different disk drive.` :
  https://github.com/tsroten/fcache/issues/28

-------------------------------------------------------------------------------
10. AUTHOR
-------------------------------------------------------------------------------
Andrey Dibrov (andry at inbox dot ru)
