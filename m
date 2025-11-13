Return-Path: <cgroups+bounces-11941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD6C5A713
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D344EFF7A
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE62324B3A;
	Thu, 13 Nov 2025 22:58:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE6318149
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074711; cv=none; b=h3IjDZ1UAdsBpYR8z1KnCVH9W5uGsHOQFsBwBT6g1Ylzu/uMg3hayWagoryAjdQgX3qahRmbKtSxP5hx82wClTScUpz58ka3GUcKDpzV9RMAvgfGZlxdrqsZBj9JIW7UXoVj2RhaPcK1Ns/6RrXBL0wkJh+P/xn09Fbc43XKKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074711; c=relaxed/simple;
	bh=lSnLSpH9yQtYLu9Cf0IZtLu/UJTSJFKK+fhiJhNtdlw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E0/+C2qX+HHByZs4IvdTeRHO1OQQCCS8/Ch5BJRxUYgzk/UtuO+s6V54dE6+AcZloV1KYyNgBGOSrH3MWIVCNN8bVt60CsT0zS3dWtjtmkYr/Magz0JO7eFxSkYqR+nB/J6PrTIHmZkYioTC0DsAiGCQkDYQeKVy5IjbcSsnVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43321627eabso48438905ab.3
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 14:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074709; x=1763679509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbtkDKlNE4tc2jFqlzeAg93Hnuv/kf1WNddQKsE9QL8=;
        b=Q1qqj7O2pRuT8EncC/lSqPYCsS9eFI4KuusOW69hiO7+DWJDHw2q3XG/bTw/2O6IL3
         YU9LFX2KOnzOsbsUJNJf4JlXsuYbUJLdv9bEOuLMn+xeENdbuVnzGlZLNkQVhVM4r6rz
         Z882XETHdu7rDMBIWaROAiMBz50ks3U7QjBUTcAwp/rgxFeO0bCulLDoADReqDFvSjPP
         Ry8vQxxJXnf5bslqIx0ntB8DhrzTO9Cr1T4Ce2T0NHuyb6UFGBLuXigXgq/mJoLvXXAp
         nyiHX/1yZ7j0EVLHqt74OuffbVpmnHOx/OolmHvXY57O4mV1IZ2bq6TVIVCiUaT32Vvz
         /vbA==
X-Gm-Message-State: AOJu0YweIAybpwvG0GrZIaopyWT6WGRqvFvahPgk5hYy9DAXkrbrJq5X
	5a7kSitu6krSia5yy3D02k74fO22iRBj4IGvkgkFPDXQGhEOB+kOAwWaYGQBSaChfmcx1v+sptS
	3rYH7hy8HKxDna/OaxV0jtKojvIirbvzW2FUXRawu+9mB+RhGema1L/+qg3vo7A==
X-Google-Smtp-Source: AGHT+IFZJDGEH7soMYdKCftMSeID1zI6Cg6qNpr8QZgqxXCre2smu0EBx/q8FxAr3JZ/bP0D5YT4lFehfPPfWBcMOPxI8jdX2f1I
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2292:b0:433:4fc9:7b3d with SMTP id
 e9e14a558f8ab-4348c91d7b2mr19702505ab.22.1763074709149; Thu, 13 Nov 2025
 14:58:29 -0800 (PST)
Date: Thu, 13 Nov 2025 14:58:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69166295.a70a0220.3124cb.0036.GAE@google.com>
Subject: [syzbot] [cgroups?] WARNING in cgroup_file_release
From: syzbot <syzbot+da9171e60819297fc1d3@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a5d0b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
dashboard link: https://syzkaller.appspot.com/bug?extid=da9171e60819297fc1d3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b76dc0ec17f/disk-9c0826a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/522b6d2a1d1d/vmlinux-9c0826a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a58225d70f3/bzImage-9c0826a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da9171e60819297fc1d3@syzkaller.appspotmail.com

netlink: 16 bytes leftover after parsing attributes in process `syz.2.623'.
------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#1: syz.2.623/8079
WARNING: ./include/linux/ns_common.h:255 at put_cgroup_ns include/linux/cgroup_namespace.h:39 [inline], CPU#1: syz.2.623/8079
WARNING: ./include/linux/ns_common.h:255 at cgroup_file_release+0x196/0x1d0 kernel/cgroup/cgroup.c:4282, CPU#1: syz.2.623/8079
Modules linked in:
CPU: 1 UID: 0 PID: 8079 Comm: syz.2.623 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_cgroup_ns include/linux/cgroup_namespace.h:39 [inline]
RIP: 0010:cgroup_file_release+0x196/0x1d0 kernel/cgroup/cgroup.c:4282
Code: 3b 00 74 08 4c 89 ef e8 a8 44 6e 00 49 c7 45 00 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 bb d8 07 00 90 <0f> 0b 90 eb 9d e8 b0 d8 07 00 4c 89 e7 be 03 00 00 00 e8 e3 d2 df
RSP: 0018:ffffc9000eaef8c8 EFLAGS: 00010293
RAX: ffffffff81b9f775 RBX: 1ffff1100bc32a83 RCX: ffff88802990db80
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffff8880796780bb R09: 1ffff1100f2cf017
R10: dffffc0000000000 R11: ffffed100f2cf018 R12: ffff8880796780b8
R13: ffff88805e195418 R14: ffff88805c63a100 R15: ffff888079678000
FS:  0000000000000000(0000) GS:ffff888125b79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000011c0 CR3: 000000007b8ee000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kernfs_release_file+0x131/0x2d0 fs/kernfs/file.c:764
 kernfs_fop_release+0x113/0x190 fs/kernfs/file.c:779
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6bd/0x2300 kernel/exit.c:970
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1111
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b5b38f6c9
Code: Unable to access opcode bytes at 0x7f9b5b38f69f.
RSP: 002b:00007f9b5c2910e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f9b5b5e5fa8 RCX: 00007f9b5b38f6c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9b5b5e5fa8
RBP: 00007f9b5b5e5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9b5b5e6038 R14: 00007ffe297b11d0 R15: 00007ffe297b12b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

