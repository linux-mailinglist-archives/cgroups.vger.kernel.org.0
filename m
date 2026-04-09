Return-Path: <cgroups+bounces-15201-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CoxO9l612mXOggAu9opvQ
	(envelope-from <cgroups+bounces-15201-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 12:09:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0D3C8F5C
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F5EB300B87D
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2026 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8D364924;
	Thu,  9 Apr 2026 10:04:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0427456
	for <cgroups@vger.kernel.org>; Thu,  9 Apr 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729074; cv=none; b=diFbb85mr832l2ysmtpggXZFPi6SCZ+7FmFYpHo/fqt+xffRvjm3NHKhAfRtFG59tXZjKC22HVHjnVXfaqBtQY5E6vbum1gokD/Bp+tUVMS9aXkAS8kyUcGGxCkecqlRBUsK+m+tegj9+OC4CIm0O9pXOxAtJ6QV7IAcSpZDdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729074; c=relaxed/simple;
	bh=0vp7hbRLcFGw0j36lHY9/NjMIx6QICcuxTWyXCNh2e0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oz1WOZtkmo1yARfsw9Np6ROVZuTBeNsMiSrfV9aMsQbXVOFe/65OkEdMXminCCa6bo2sj/dfChkAV6zKhAXHhK3fLdBv4vOnzuuFV/6OMY74dUalqIQXRcJ6kAm+MF8Nn0FDrMJ18teHHHWliBLvhwKVD8nMUjT1pcsWRPPQdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6888581ca85so572691eaf.2
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2026 03:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775729072; x=1776333872;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmGvNG8JecyjBjhM/6CtSwXzK6HgU2KjJLVLKKVakcQ=;
        b=sOHFRiNodZ6TXE4QGdq/VQrHzplBlh9Dawj6WmebUwMrV5ND7OcbjtOXGxTiD9jqMe
         LSsBTweRGu3OBK0c1fKOwIGzHZjFyVR4EWAnH8HTvHh0s6a8O414oFvL9+2rXQ6w7blW
         yuhHeadDg6cJgCQmhv+95TE8k6dfcWzzy4uwXkTWH6i+rO27IVB3IhWtYOcrjn2Wscu9
         6LbOUj9ziqYUitJxojkg6ZuY8zAdGSrUajvzhTZwnf5vr9BJQ5lIZawSOi/trFSuwnHy
         5SP6/c4ZGm9664t1vvQBjSafxqvQDig7m93NFi7fGsHUOfKmWOdlIbYkM+BaU4MnNgx/
         DtVA==
X-Gm-Message-State: AOJu0YzuUvz+w74Y5ECBTC6GrwuwxMeK+cZlZz7d4lioZb/dX0Wb6m13
	2/RwpCiDvvDxN+yWUn3l3+wm/r6/aB32LdY46i+74WjNdFzf55eaQ2FWvs5ap8B3/LxauLc9W9u
	DpDr8qBrhm+noLAH0fpsKMNxIRYrqsi168xEguM/dgqSRP786NXM7OL6XlXPA6A==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1985:b0:67e:1ce7:77cb with SMTP id
 006d021491bc7-68a62520f0cmr1331903eaf.24.1775729072292; Thu, 09 Apr 2026
 03:04:32 -0700 (PDT)
Date: Thu, 09 Apr 2026 03:04:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d779b0.a00a0220.468cb.0018.GAE@google.com>
Subject: [syzbot] [cgroups?] KASAN: slab-use-after-free Read in pressure_write
From: syzbot <syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15201-lists,cgroups=lfdr.de,33e571025d88efd1312c];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 5DA0D3C8F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    591cd656a1bf Linux 7.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114a36ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
dashboard link: https://syzkaller.appspot.com/bug?extid=33e571025d88efd1312c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb33da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12648bd6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87739bfd4864/disk-591cd656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/56be68f80e4e/vmlinux-591cd656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08638816d82a/bzImage-591cd656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
Read of size 8 at addr ffff88803160f208 by task syz.3.1283/9352

CPU: 0 UID: 0 PID: 9352 Comm: syz.3.1283 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
 cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4311
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f73f541c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73f4a76028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f73f5695fa0 RCX: 00007f73f541c819
RDX: 000000000000002f RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f73f54b2c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f73f5696038 R14: 00007f73f5695fa0 R15: 00007ffe5707b838
 </TASK>

Allocated by task 9352:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5380
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 cgroup_file_open+0x90/0x3a0 kernel/cgroup/cgroup.c:4256
 kernfs_fop_open+0x9eb/0xcb0 fs/kernfs/file.c:724
 do_dentry_open+0x83d/0x13e0 fs/open.c:949
 vfs_open+0x3b/0x350 fs/open.c:1081
 do_open fs/namei.c:4677 [inline]
 path_openat+0x2e43/0x38a0 fs/namei.c:4836
 do_file_open+0x23e/0x4a0 fs/namei.c:4865
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9353:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1c1/0x6c0 mm/slub.c:6483
 cgroup_file_release+0xd6/0x100 kernel/cgroup/cgroup.c:4283
 kernfs_release_file fs/kernfs/file.c:764 [inline]
 kernfs_drain_open_files+0x392/0x720 fs/kernfs/file.c:834
 kernfs_drain+0x470/0x600 fs/kernfs/dir.c:525
 __kernfs_remove+0x3cf/0x660 fs/kernfs/dir.c:1513
 kernfs_remove_by_name_ns+0xaf/0x130 fs/kernfs/dir.c:1722
 kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
 cgroup_rm_file kernel/cgroup/cgroup.c:1758 [inline]
 cgroup_addrm_files+0x684/0xc30 kernel/cgroup/cgroup.c:4483
 cgroup_destroy_locked+0x321/0x630 kernel/cgroup/cgroup.c:6197
 cgroup_rmdir+0x3e8/0x710 kernel/cgroup/cgroup.c:6311
 kernfs_iop_rmdir+0x203/0x350 fs/kernfs/dir.c:1291
 vfs_rmdir+0x400/0x6f0 fs/namei.c:5344
 filename_rmdir+0x292/0x520 fs/namei.c:5399
 __do_sys_rmdir fs/namei.c:5422 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5419
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803160f200
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 freed 192-byte region [ffff88803160f200, ffff88803160f2c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3160f
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88813fe1a3c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 17504889254, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x28bb/0x2950 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x334/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x35c/0x710 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __kmalloc_cache_noprof+0x44e/0x690 mm/slub.c:5375
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 call_usermodehelper_setup+0x8e/0x270 kernel/umh.c:362
 kobject_uevent_env+0x65b/0x9e0 lib/kobject_uevent.c:628
 device_add+0x557/0xb80 drivers/base/core.c:3672
 netdev_register_kobject+0x178/0x310 net/core/net-sysfs.c:2358
 register_netdevice+0x12d7/0x1d10 net/core/dev.c:11441
 register_netdev+0x40/0x60 net/core/dev.c:11557
 nr_proto_init+0x14a/0x720 net/netrom/af_netrom.c:1424
 do_one_initcall+0x250/0x8d0 init/main.c:1382
 do_initcall_level+0x104/0x190 init/main.c:1444
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803160f100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803160f180: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803160f200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88803160f280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88803160f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

