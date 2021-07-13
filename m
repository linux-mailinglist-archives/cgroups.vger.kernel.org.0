Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2A3C6F0B
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhGMLAu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jul 2021 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhGMLAt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jul 2021 07:00:49 -0400
X-Greylist: delayed 624 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jul 2021 03:58:00 PDT
Received: from birdy.pmhahn.de (birdy.pmhahn.de [IPv6:2a01:4f8:222:1f02::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46E49C0613DD
        for <cgroups@vger.kernel.org>; Tue, 13 Jul 2021 03:58:00 -0700 (PDT)
Received: from [IPv6:2003:e2:7738:c200:a5ae:ca72:d4d5:6724] (p200300E27738C200A5aEca72D4D56724.dip0.t-ipconnect.de [IPv6:2003:e2:7738:c200:a5ae:ca72:d4d5:6724])
        by birdy.pmhahn.de (Postfix) with ESMTPSA id 4E0ED220905A;
        Tue, 13 Jul 2021 12:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=202002;
        t=1626173254; bh=eTMdADUqObM4eEKPymzPZw+9ocq15Mp1m/GK12GR0pg=;
        h=To:Cc:From:Subject:Date:From;
        b=Z370E7GFrCJvOvdpJAz8M3XcA/a544H4UfZTbnBpy7YCnJvIxxNxti9Mmzn2RgPW4
         /pvO70h3ilQmQ6GHlQfNCkzN9sjTP7jSRK5wdsJrmlWlCvqbuRrOWfwISO6AxIg7Il
         FFcvdsLWDPR2LXHnDSr3WtDUggp8WoIdcJauxaPYCL7yleHkJgFL/ExlEW3GN1v/So
         3l9qGyaTmas49sQPeYGH4yFgWjpO7P/M4MFoqeMsLOIWhQ6ArOaJLhVaPx0hqP7E1m
         e/xaAJKsC8ZXr2Mu3Gio5oeyqM1kwO6rTuvPYS+oKmEHmPbIXTiC6tggbrAe/o5GdN
         paichGQBjFG9w==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
From:   Philipp Hahn <pmhahn@pmhahn.de>
Subject: OOPS: v4.19.171 kernfs_sop_show_options - Invalid "root->syscall_ops"
 ?
Message-ID: <8d3e59c9-8c2a-6024-5681-563453d7fb34@pmhahn.de>
Date:   Tue, 13 Jul 2021 12:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Some time ago one of my VMs crashed running Debian-10-Buster using Linux 
kernel 4.19.171:

> [Feb16 06:50] general protection fault: 0000 [#1] SMP PTI
> [  +0,000065] CPU: 1 PID: 17450 Comm: nfsmounts Not tainted 4.19.0-14-amd64 #1 Debian 4.19.171-2
> [  +0,000052] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1 04/01/2014
> [  +0,000067] RIP: 0010:kernfs_sop_show_options+0x2d/0x40
> [  +0,000035] Code: 00 00 48 8b 46 30 48 85 c0 74 07 48 8b 80 50 02 00 00 48 8b 50 08 48 85 d2 48 0f 44 d0 48 8b 72 50 48 8b 46 30 48 85 c0 74 0e <48> 8b 40 08 48 85 c0 74 05 e9 05 57 72 00 31 c0 c3 66 90 0f 1f 44
> [  +0,000106] RSP: 0018:ffff9e5f01fffe20 EFLAGS: 00010202
> [  +0,000032] RAX: 0105028102951075 RBX: ffff8b0c7af66680 RCX: 00000000656f6e2c
> [  +0,000041] RDX: ffff8b0c351de440 RSI: ffff8b0c34a74840 RDI: ffff8b0c7af66680
> [  +0,000040] RBP: ffff8b0c34286c20 R08: 6d6974616c65722c R09: 656d6974616c6572
> [  +0,000041] R10: ffff9e5f01fffddc R11: ffff8b0c75e123bc R12: ffff8b0c7cfec000
> [  +0,000040] R13: ffff8b0c77e50e80 R14: ffff8b0c7abb4900 R15: ffff8b0c7af66680
> [  +0,000042] FS:  00007ff4bb68e740(0000) GS:ffff8b0c7db00000(0000) knlGS:0000000000000000
> [  +0,000045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0,000033] CR2: 00007ff4bb634e10 CR3: 000000007ac0c000 CR4: 00000000000006e0
> [  +0,000069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  +0,000041] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  +0,000041] Call Trace:
> [  +0,000053]  show_vfsmnt+0x124/0x170
> [  +0,000038]  seq_read+0x2e9/0x410
> [  +0,000026]  vfs_read+0x91/0x140
> [  +0,000023]  ksys_read+0x57/0xd0
> [  +0,000058]  do_syscall_64+0x53/0x110
> [  +0,000051]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  +0,000053] RIP: 0033:0x7ff4bb77d461
> [  +0,000058] Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
> [  +0,000135] RSP: 002b:00007ffc1c076e68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  +0,000067] RAX: ffffffffffffffda RBX: 000055f6fceab250 RCX: 00007ff4bb77d461
> [  +0,000070] RDX: 0000000000002000 RSI: 000055f6fd162e10 RDI: 0000000000000004
> [  +0,000096] RBP: 00007ff4bb84b2a0 R08: 0000000000000b40 R09: 000055f6fceab250
> [  +0,000089] R10: 000055f6fcda0010 R11: 0000000000000246 R12: 0000000000002000
> [  +0,000093] R13: 000055f6fd162e10 R14: 0000000000000d68 R15: 00007ff4bb84a760
> [  +0,000100] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt_addrtype br_netfilter bridge stp llc ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_state xt_conntrack nft_compat nft_counter nft_chain_route_ipv6 nft_chain_rou
> [  +0,009114]  raid1 raid0 multipath linear md_mod dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_mod hid_generic usbhid hid sr_mod cdrom sd_mod virtio_gpu ttm drm_kms_helper ahci libahci drm virtio_net net_failover failover virtio_scsi xhci_pci libata xhci_hcd 
> [  +0,009397] ---[ end trace b63534c6f4770b73 ]---

Here's the dis-assembly of said code:

# scripts/decodecode
>   0:   INCOMPLETE
>   2:   48 8b 46 30             mov    0x30(%rsi),%rax
>   6:   48 85 c0                test   %rax,%rax
>   9:   74 07                   je     0x12
>   b:   48 8b 80 50 02 00 00    mov    0x250(%rax),%rax
>  12:   48 8b 50 08             mov    0x8(%rax),%rdx
>  16:   48 85 d2                test   %rdx,%rdx
>  19:   48 0f 44 d0             cmove  %rax,%rdx
>  1d:   48 8b 72 50             mov    0x50(%rdx),%rsi
>  21:   48 8b 46 30             mov    0x30(%rsi),%rax
>  25:   48 85 c0                test   %rax,%rax
>  28:   74 0e                   je     0x38
>  2a:*  48 8b 40 08             mov    0x8(%rax),%rax           <-- trapping instruction
>  2e:   48 85 c0                test   %rax,%rax
>  31:   74 05                   je     0x38
>  33:   e9 05 57 72 00          jmpq   0x72573d
>  38:   31 c0                   xor    %eax,%eax
>  3a:   c3                      retq   
>  3b:   STRIPPED

# objdump -S fs/kernfs/mount.o --start-address=0x30 --stop-address=0x60
> 0000000000000030 <kernfs_sop_show_options>:
> static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
> {
>   00:   e8 00 00 00 00          callq  35 <kernfs_sop_show_options+0x5>
> };
> #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
> static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
> {
>         if (d_really_is_negative(dentry))
>   05:   48 8b 46 30             mov    0x30(%rsi),%rax
>   09:   48 85 c0                test   %rax,%rax
>   0c:   74 07                   je     45 <kernfs_sop_show_options+0x15>
>                 return NULL;
>         return d_inode(dentry)->i_private;
>   0e:   48 8b 80 50 02 00 00    mov    0x250(%rax),%rax
>         if (kn->parent)
>   15:   48 8b 50 08             mov    0x8(%rax),%rdx
=== RDX: ffff8b0c351de440 -> kn->parent
>   19:   48 85 d2                test   %rdx,%rdx
>   1c:   48 0f 44 d0             cmove  %rax,%rdx
>         return kn->dir.root;
    20:   48 8b 72 50             mov    0x50(%rdx),%rsi
=== RSI: ffff8b0c34a74840 -> root
>         struct kernfs_root *root = kernfs_root(kernfs_dentry_node(dentry));
>         struct kernfs_syscall_ops *scops = root->syscall_ops;
>   24:   48 8b 46 30             mov    0x30(%rsi),%rax
=== RAX: ffffffffffffffda -> root->syscall_ops ?= -ENOSYS ???
>         if (scops && scops->show_options)
>   28:   48 85 c0                test   %rax,%rax
>   2b:   74 0e                   je     6b <kernfs_sop_show_options+0x3b>
>   2d:   48 8b 40 08             mov    0x8(%rax),%rax
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   31:   48 85 c0                test   %rax,%rax
>   34:   74 05                   je     6b <kernfs_sop_show_options+0x3b>
>                 return scops->show_options(sf, root);
>   36:   e9 00 00 00 00          jmpq   6b <kernfs_sop_show_options+0x3b>
>         return 0;
> }
>   3b:   31 c0                   xor    %eax,%eax
>   3d:   c3                      retq   


I don't know how to trigger that again, but here are my findings to far:

- The bug seems to be triggered by a Python script 
`/usr/lib/univention-directory-policy/nfsmounts` reading 
`/proc/self/mounts` AKA `/etc/mtab`.

- `syscall_ops` seems to be invalid, which is only ever initialized by 
fs/kernfs/dir.c:kernfs_create_root()

- This function seems to be used for every cgroup by 
kernel/cgroup/cgroup.c:cgroup_setup_root()


Does that ring any bells?

I had a look at some changes between v4.19.171...HEAD in that area and 
have found the following changes, which might be interesting - but I'm 
no Kernel guru
- 630faf81b3e6 cgroup: don't put ERR_PTR() into fc->root
- 35ac1184244f cgroup: saner refcounting for cgroup_root
- 399504e21a10 fix cgroup_do_mount() handling of failure exits
- 2fd60da46da7 kernfs: fix potential null pointer dereference

Debian and many other LTS users would probably like to get this fixed 
for stable/linux-4.19.y.
I'm willing to spend more time on this, but currently I'm out of ideads 
what else to do or where else to look.

Thank you in advance

Philipp Hahn
