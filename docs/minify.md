# Clean and Minify

## From Guest

### Compress Windows OS Files (Optional)

You can try compacting the OS from within Windows to reduce the size taken up
by the OS. Whether or not this makes a difference is yet to be proved (see the
pidgeon hole principle), so use at your own peril.

To compress the OS files, open an administrator command prompt and run
`compact.exe /CompactOS:always`. To disable OS file compression, run
`compact.exe /CompactOS:never` from an admin prompt.


### Clear Data from Previously Uninstalled Programs

If you have installed and then later uninstalled programs, check both
AppData and both Program Files folders for any storage used by these programs
that's no longer needed.

In addition, registry entries from uninstalled programs may be found in the
registry locations `Computer\HKEY_CURRENT_USER\SOFTWARE` and
`Computer\HKEY_LOCAL_MACHINE\SOFTWARE`.


### Use the Built-In Windows Cleanup Tool

Windows comes pre-packaged with a tool for freeing up space on disk by deleting
temporary and/or old system files. While this tool is not as thorough as others
in this document, it is still valuable in the pursuit of the smallest possible
VM image size.

To use the tool, just search for 'Disk Cleanup'. The program should be very
easy to use from the GUI, and should be run for both user and system files.


### Cleanup the WinSxS Folder

Run `dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase` and then
`dism /Online /Cleanup-Image /SPSuperseded` from an
administrator command prompt.


### Clear the SoftwareDistribution folder

This folder is safe to remove. Windows will try to redownload it, but of
course it can't if you shrink the drive afterwards. Run the following from an
administrator command prompt:

```
net stop wuauserv
net stop bits
```

then remove the folder (if you start the services again windows will
re-download it)


### Remove things from WindowsApps

Go ham deleting things in `C:\Program Files\WindowsApps`. The easiest way is to
mount the image in Linux first:

```
/path/to/util/qemu_mnt.sh /path/to/img.qcow2
sudo mount /dev/nbd0p3 /path/to/mount/point
# delete the stuff
sudo umount /path/to/mount/point
/path/to/utiu/qemu_umnt.sh
```

You may then need to go into *Settings -> Apps and Features -> [Broken App] ->
Advanced options -> Reset* for each one.


### Defragment the Virtual Disk

Windows has a built-in tool for defragging the disk,
[`defrag.exe`][defrag-docs]. You'll want to run this on the `C:` drive from an
administrator prompt, and may want to use some of the following useful options:
- `/u`: Print the progress of the operation on the screen.
- `/v`: Print verbose output containing the fragmentation statistics.
- `/x`: Perform free space consolidation on the specified volumes.
- `/h`: Run the operation at normal priority (default is low).

The recommended command (by Henry) is `defrag.exe c: /u /x /h`. Free space
consolidation in particular is recommended in trying to reduce the size
of the disk, but your mileage may vary.


### Shrink the Windows Partition

Windows could be considered gaseous, in that it tends to fill the volume of
whatever container it's in. To stop Windows from taking any and all free space,
you can shrink the partition with the built-in Disk Manager GUI. Make sure to
note down the final disk size.


### Zero Empty Disk Space

The 'empty' space on the virtual hard disk may be full of junk data, and
Windows would never tell you. To truly clear this space, you will need to use
the Windows sysinternals tool [SDelete][sdelete-dl].

To use SDelete, open an administrator command prompt and run (from within
the downloaded folder) `sdelete64.exe -c c:` followed by `sdelete64.exe -z c:`.
What these commands do is first clean, then zero the free space respectively.


## From Host

### Shrink VM Image

QEMU provides a tool for resizing a qcow2 image, `qemu-img resize`. To shrink
the size of the disk (make sure not to make it smaller than the Windows
partition!), use `qemu-img resize --shrink img.qcow2 SIZE` (see `man qemu-img`
for SIZE).


### Sparsify and Compress VM Image

An important step in minimising image size is to sparsify it. Optionally, you
can compress the image at the same time, although this can make disk speeds
slower). To sparsify and compress the image, run
`qemu-img convert -c -O qcow2 img.qcow2 img-compressed.qcow2`, and leave the
`-c` flag out if you would rather not compress the image.

To undo this change, you can use
`qemu-img convert -O qcow2 img-compressed.qcow2 img.qcow2`.

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

[defrag-docs]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/defrag
[sdelete-dl]: https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete
