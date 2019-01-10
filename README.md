`eselect stage` allows to fetch, extract and setup a chroot from latest stage
tarballs from gentoo distfiles hosts.

Basic setup is handled and the init file mount-chroot handles bind (u)mounting
necessary directories as well as additional ones such as PKGDIR, DISTDIR or the
gentoo repository.

```
Usage: eselect stage <action> <options>

Standard actions:
  help                      Display help text
  usage                     Display usage information
  version                   Display version information

Extra actions:
  add <name> <arch> <profile_idx>
                            Add a chroot directory with a stage3 Gentoo install
    name                      Name of the chroot
    arch                      alpha amd64 arm hppa ia64 ppc s390 sh sparc x86
    profile_idx               Per arch index of the latest stages
  enable <name>             Start mount-chroot.<name> service and chroot into installed stage
    name                      chroot name
  list <chroots|cache|latest [arch]>
                            List managed chroot directories and stage tarballs
    chroots                   List installed chroot directories
    cache                     List downloaded stage tarballs
    latest                    List latest tarballs available
    arch                      Specify arch to list
  remove <name>             Remove given chroot directory
    name                      chroot name
```
