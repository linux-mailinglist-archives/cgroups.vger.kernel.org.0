Return-Path: <cgroups+bounces-6757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED25A4B14D
	for <lists+cgroups@lfdr.de>; Sun,  2 Mar 2025 12:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37903B2EB4
	for <lists+cgroups@lfdr.de>; Sun,  2 Mar 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CAB1DC9B5;
	Sun,  2 Mar 2025 11:56:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B21D89E3
	for <cgroups@vger.kernel.org>; Sun,  2 Mar 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916591; cv=none; b=dp7I5yTb1k+CwQaSUr5f6P4SG5mMqWZzvZwEMyJvO6IpoRB487086BxoG7rI3LwVrsvEUdYj1wkFvnPBvECKdbPxP0AZgRbAcmG8/GBmVRmg3jUQRT6W6eJWjaZJxp/3rjaYm8ca/1UWf6oOrgcucVr+LPgEnkrJdhEVERG+O64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916591; c=relaxed/simple;
	bh=e/8NPDdl/C/KSXMToHEJfdK6HDA3izRuXWUlU+92O0I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dDjP97C005RmAaPobKBQ4sjA8j3N+4oH2aYUrhpbAM72JXNl8fuhsjpcdVmp0WOPaHl6BGBQM2fB07CxTqIeChvV6+3Rhy8cSnd5JqPgFx/TGd1czTjwVGB0/AJKj1Ammch6KKeY6qeZlCPIg3g7+fKeNzJLTdVLpNuxpfP0tjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-855a2ec87adso691434039f.2
        for <cgroups@vger.kernel.org>; Sun, 02 Mar 2025 03:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740916588; x=1741521388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNGiguucKv36XtMhASonsxGpIptdKPoI8VZ3oCZc80s=;
        b=RpBX0X18Y9o2ZomVuj050HXDimpdxEclxNh1u8pq9reY9Qjz0w25gyy8RpD/WrS2LM
         D26kuTcZiv6+6IOEDPMqZxEL37TnAhxlvsEVIicUQD+Kd8u2yFN5IHk9Lyfc+DmNAyzW
         lkf+Ci6oTqPP8jxGs9RBiDHXp2FqyR7AAWuL7lJkOz6xfv40akeshmFHbuuiSebQNNkg
         Zh5TIdn8b/QCnm/1/aeE8Uif6pxXtDcjwZLv02H2LzeFuKFPzy6aPnenmGAA8M4+p0Wi
         +4Q5vzSREodAYrafD7rOidJ5BHMsBSjTh5BWstlcxXr+1pWutISOSo12nDKWfG4UCJGg
         Ubgg==
X-Forwarded-Encrypted: i=1; AJvYcCUqht5blitv6bKvTocdvc/LuYnZOybO3djCt4kQT1Rf89D2SP+HGqAMo5fRKHTSE9YlDJX6zqR2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXuLLuA91lBpI1Cpot/otVK54TpOfRQ2M0QlI9J2ErRY9R6av
	83O0hQR3tseqVh+jmWnKEcZubv8+PuhyCiOOwjUGsvkKZ8uGnx7SR90+HvRoB9k2MWf1n6Cpafz
	Gb/E1EyBv1prL2RULWJmu+SderMzmLtih6phkqa5O0pDU90s5BCoWIuc=
X-Google-Smtp-Source: AGHT+IG/AxJ/rdapw6H25dl5mizA7wEBrjLdBPtMjUpEus6mGgvC4bTWY9Q58kHEpiOt4mqX6lw3sq8PW1WoYpXB7BBgzuEScVye
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180f:b0:3d3:de8a:630e with SMTP id
 e9e14a558f8ab-3d3e6f9b14fmr97696255ab.16.1740916588609; Sun, 02 Mar 2025
 03:56:28 -0800 (PST)
Date: Sun, 02 Mar 2025 03:56:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c4476c.050a0220.1dee4d.002e.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] [ntfs3?] KASAN: global-out-of-bounds Read
 in get_mem_cgroup_from_mm
From: syzbot <syzbot+7687c9b2316f07027b29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	ntfs3@lists.linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    03d38806a902 Merge tag 'thermal-6.14-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d6a864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=7687c9b2316f07027b29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144528b7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036a864580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-03d38806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67cb2018261a/vmlinux-03d38806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6169e75b74a/bzImage-03d38806.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b184f3480c95/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7687c9b2316f07027b29@syzkaller.appspotmail.com

ntfs3(loop0): Failed to initialize $Extend.
overlayfs: upper fs does not support tmpfile.
overlayfs: upper fs does not support RENAME_WHITEOUT.
==================================================================
BUG: KASAN: global-out-of-bounds in __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5091
Read of size 8 at addr ffffffff8eb38f9f by task syz-executor682/7971

CPU: 0 UID: 0 PID: 7971 Comm: syz-executor682 Not tainted 6.14.0-rc4-syzkaller-00248-g03d38806a902 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5091
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 get_mem_cgroup_from_mm+0x55/0x2a0 mm/memcontrol.c:943
 __mem_cgroup_charge+0x16/0x80 mm/memcontrol.c:4504
 mem_cgroup_charge include/linux/memcontrol.h:644 [inline]
 filemap_add_folio+0xb7/0x380 mm/filemap.c:976
 __filemap_get_folio+0x52b/0xae0 mm/filemap.c:1980
 ntfs_get_frame_pages+0xbe/0x4b0 fs/ntfs3/file.c:945
 ntfs_compress_write+0x1154/0x2170 fs/ntfs3/file.c:1101
 ntfs_file_write_iter+0x697/0x7f0 fs/ntfs3/file.c:1266
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 ovl_copy_up_file+0x5ed/0x7e0 fs/overlayfs/copy_up.c:349
 ovl_copy_up_data+0x216/0x290 fs/overlayfs/copy_up.c:654
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:796 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:1001 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1202 [inline]
 ovl_copy_up_flags+0x1e86/0x47e0 fs/overlayfs/copy_up.c:1257
 ovl_open+0x139/0x310 fs/overlayfs/file.c:211
 do_dentry_open+0xdec/0x1960 fs/open.c:956
 vfs_open+0x3b/0x370 fs/open.c:1086
 dentry_open+0x61/0xa0 fs/open.c:1109
 ima_calc_file_hash+0x16b/0x1b30 security/integrity/ima/ima_crypto.c:553
 ima_collect_measurement+0x529/0xb20 security/integrity/ima/ima_api.c:293
 process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:375
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:603
 security_file_post_open+0xb9/0x280 security/security.c:3130
 do_open fs/namei.c:3832 [inline]
 path_openat+0x2cca/0x3590 fs/namei.c:3989
 do_filp_open+0x27f/0x4e0 fs/namei.c:4016
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f492e5d8d19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f492e58f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f492e6806a8 RCX: 00007f492e5d8d19
RDX: 0000000000000083 RSI: 0000400000000000 RDI: 00000000ffffff9c
RBP: 00007f492e6806a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f492e64c920
R13: 0000400000000000 R14: 0000400000000140 R15: 0030656c69662f2e
 </TASK>

The buggy address belongs to the variable:
 rcu_expedited_nesting+0x1f/0x20

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xeb38
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00003ace08 ffffea00003ace08 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8eb38e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9
 ffffffff8eb38f00: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
>ffffffff8eb38f80: 04 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
                            ^
 ffffffff8eb39000: 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
 ffffffff8eb39080: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
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

