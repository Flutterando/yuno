# Contribution Guidelines

**Note:** If these contribution guidelines are not followed your issue or PR might be closed, so
please read these instructions carefully.

## Contribution types

### Bug Reports
- If you find a bug, please first report it using [Github issues].
    - First check if there is not already an issue for it; duplicated issues will be closed.

### Bug Fix
- If you'd like to submit a fix for a bug, please read the [How To](#how-to-contribute) for how to
  send a Pull Request.
- Indicate on the open issue that you are working on fixing the bug and the issue will be assigned
  to you.
- Write `Fixes #xxxx` in your PR text, where xxxx is the issue number (if there is one).
- Include a test that isolates the bug and verifies that it was fixed.

### New Features
- If you'd like to add a feature to the library that doesn't already exist, feel free to describe
  the feature in a new [GitHub issue].
- If you'd like to implement the new feature, please wait for feedback from the project maintainers
  before spending too much time writing the code. In some cases, enhancements may not align well
  with the project objectives at the time.
- Implement the code for the new feature and please read the [How To](#how-to-contribute).

### Documentation & Miscellaneous
- If you have suggestions for improvements to the documentation, tutorial or examples (or something
  else), we would love to hear about it.
- As always first file a [Github issue].
- Implement the changes to the documentation, please read the [How To](#how-to-contribute).

## How To Contribute

### Requirements
For a contribution to be accepted:

- Documentation should always be updated or added.*
- Examples should always be updated or added.*
- Tests should always be updated or added.*
- Format the Dart code accordingly with `flutter format`.
- Your code should pass all tests `flutter run test`.
- Start your PR title with a [conventional commit] type
  (`feat:`, `fix:` etc).

*When applicable.

If the contribution doesn't meet these criteria, a maintainer will discuss it with you on the issue
or PR. You can still continue to add more commits to the branch you have sent the Pull Request from
and it will be automatically reflected in the PR.

## Open an issue and fork the repository
- If it is a bigger change or a new feature, first of all
  [file a bug or feature report][GitHub issues], so that we can discuss what direction to follow.
- [Fork the project][fork guide] on GitHub.
- Clone the forked repository to your local development machine
  (e.g. `git clone git@github.com:<YOUR_GITHUB_USER>/yuno.git`).

### Environment Setup
Yuno uses [Puro] to manage the Flutter version.

To install Puro, you can take a look at the documentation [here][Puro install].

After installation, run the following command from your terminal changing `x.xx.x` for flutter version see in pubspec.yaml file:

```bash
puro create yuno x.xx.x
```

Next, at the root of your locally cloned repository run the `use` command to switch to the environment you created:

```bash
puro use yuno
```

Get all project dependencies:
```bash
flutter pub get
```

And finally, run the project:
```bash
flutter run --flavor dev --dart-define-from-file=.env
```

### Performing changes
- Create a new local branch from `main` (e.g. `git checkout -b my-new-feature`)
- Make your changes.
- When committing your changes, make sure that each commit message is clear
  (e.g. `git commit -m '[yuno_ui] Added LoadAnimation on buttons'`).
- Push your new branch to your own fork into the same remote branch
  (e.g. `git push origin my-username.my-new-feature`, replace `origin` if you use another remote.)

### Open a pull request
Go to the [pull request page of yuno][PRs] and in the top
of the page it will ask you if you want to open a pull request from your newly created branch.

The title of the pull request should start with a [conventional commit] type.

Examples of such types:
- `fix:` - patches a bug and is not a new feature.
- `feat:` - introduces a new feature.
- `docs:` - updates or adds documentation or examples.
- `test:` - updates or adds tests.
- `refactor:` - refactors code but doesn't introduce any changes or additions to the public API.

If you introduce a **breaking change** the conventional commit type MUST end with an exclamation
mark (e.g. `feat!: The intent to get titles and images don't works for linux`).

Examples of PR titles:
- feat!: New auto-dispose configuration.
- feat: Added Page.setArguments.
- docs: Add Contribution Guidelines.
- test: Add Export bind test.
- chore: Removed triple dependency.
- refactor: Now the default theme is dark.

[GitHub issue]: https://github.com/Flutterando/yuno/issues/new
[GitHub issues]: https://github.com/Flutterando/yuno/issues/new
[PRs]: https://github.com/Flutterando/yuno/pulls
[fork guide]: https://guides.github.com/activities/forking/#fork
[Puro]: https://puro.dev/
[Puro install]: https://puro.dev/#installation
[pubspec doc]: https://dart.dev/tools/pub/pubspec
[conventional commit]: https://www.conventionalcommits.org