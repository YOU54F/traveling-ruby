# Traveling Ruby: self-contained, portable Ruby binaries

![](https://openclipart.org/image/300px/svg_to_png/181225/Travel_backpacks.png)

Traveling Ruby is a project which supplies self-contained, "portable" Ruby binaries: Ruby binaries that can run on any Linux disto, MacOS or Windows. 

This allows Ruby app developers to bundle these binaries with their Ruby app, so that they can distribute a single package to end users, without needing end users to first install Ruby or gems.

Supports Linux (glib & musl), MacOS & Windows, in both x64 & arm64 flavours.

Flavours of Ruby have been provided from Ruby 2.6.10 to the current.

Recent CI builds, will generate the latest non-eol versions of Ruby, but the system is setup to still be able to create older versions.

## Building binaries

The Traveling Ruby project supplies binaries that application developers can use. These binaries are built using the build systems in this repository. As an application developer, you do not have to use the build system. You only have to use the build systems when contributing to Traveling Ruby, when trying to reproduce our binaries, or when you want to customize the binaries.

For the Linux build system, see [linux/README.md](linux/README.md).

For the macOS build system, see [macos/README.md](macos/README.md).

## History

This project was forked from https://github.com/phusion/traveling-ruby, due to lack of maintainence, and our neccessity for use in the [Pact](docs.pact.io) project for end-users. We have now built replacement tooling in Rust, but look to preserve traveling-ruby for as long as possible, in a highly automated fashion.

We, from the Pact team, thank Phusion and Hong Li for their work, and I am sure I can be safe in extending my gratitude to the many Ruby developers who were able to share their applications with the world, thanks to yours, and others hard work.