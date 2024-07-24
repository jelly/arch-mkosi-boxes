# arch-mkosi-boxes

Arch boxes build with mkosi, this is an work in progress project to port
[arch-boxes](https://gitlab.archlinux.org/archlinux/arch-boxes) over to mkosi.

## Images

### Basic image

A 20GB qcow2 image with a default `arch` user (password `arch`) with
password-less sudo and `sshd` enabled.

### Cloud image

An image with by default `cloud-init` installed and enabled, no user or password setup.

### Vagrant images

Vagrant "boxes" for the virtualbox and libvirt provider.

## Development

### Dependencies

* mkosi (main)
* grub
* systemd-ukify
* btrfs-progs


### Building

```
mkdir -p vagrant/mkosi.{cache,output}
mkdir -p images/mkosi.{cache,output}

mkosi -C vagrant --profile libvirt build
```

Recommended `mkosi.local.conf` for caching build steps:
```
[Host]
Incremental=true
ToolsTree=default
```

### Testing

#### Vagrant

##### Virtualbox image

```
vagrant box add archvirt /path/to/Arch-Linux-x86_64-virtualbox-latest.box
vagrant init archvirt
vagrant up
```

After the box has been booted:
```
vagrant ssh
```

To clean this up:

```
vagrant destroy
vagrant box remove archvirt
```

##### Libvirt image

Arch does not package the vagrant libvirt provider plugin, so the easiest way to use the [container image](https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#using-podman). (Note that the podman invocation only binds a few paths into the container)

```
vagrant.sh box add archlibvirt /path/to/Arch-Linux-x86_64-libvirt-latest.box
```

The other testing steps are the same as the Virtualbox image.
