Return-Path: <cgroups+bounces-8433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A205EACDD9B
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532EE188DB5B
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA428ECE0;
	Wed,  4 Jun 2025 12:13:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B628D8FB
	for <cgroups@vger.kernel.org>; Wed,  4 Jun 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039223; cv=none; b=o0or8PslDGJiHeXB9No20DZ59pAlEi3l8w0JKhIrSRs6xpH12hE91vciAiYgA/Slj67SrJlMKuG1kQbKi8oqAaxjuVVWzSZ4sgJsPhWeqLOiyfV+CuwI+W32H6vSrbevrF38CmjcMxk6v8kE19Dzq3SbasO0LJnhV0q/6mR2IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039223; c=relaxed/simple;
	bh=l/tgeUW9ZxWkBuGuZhUNYwAeSn3krAwQzrrUkzZ4wj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fXroxaTRobhUiE+jpSQE02SfDrcentWAEPiv+ImjrzxcrypH+MmD0zu7EEpC5/gaYB6MuUSwDXrza2fqSWddYFcFmyS/YFlvs0ls8i2smJ7r2CtmQlIvtTU2vVbloiVTAemQlaztMokbl1WRmxVeU5LzbM3GIkOTcp80v4Iv5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddc07eea46so4712695ab.0
        for <cgroups@vger.kernel.org>; Wed, 04 Jun 2025 05:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039221; x=1749644021;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzajI+MYpH3SgRs9ff/pJQ6x8nBJe2DTOmSzXzu4lqg=;
        b=X5GC8Xt82RH2HKP9lQbyRWxaDaM6Dh3/1cd95wdnAtbXssxHcOaCw5lubFJ2ONTzQS
         vFYX8ucQCRk9dGyyDe+hXS0NoXuku42RoF8XzkbAIT0xi8pBoh1BiNd8uYiikEq08FBB
         5GxIDy8Is1WTnA3PT/2pAWbLGMADWt+IbOeRfenHtq4IWM3el7KACfCwcd/n4P2oathE
         Ldy3fxOnH0yKACyRUaD8MBZObq2XA+28Z/zJQZ8q5RrDFlUiap+VhKlOb+rvajJ/9Cc8
         r2aRPhNtG2z561oQxzvIieLQeJ/JD374cYXeYB6H3+KigB4Zo01GFVVr6PySpAKzZXtM
         JdsA==
X-Gm-Message-State: AOJu0Yw/K/ZJbgsrtF3uY45RgWGxZmGppH69fwAhG9HJv63oBMFELoaR
	ZKYZNX3gFKZaugKiIJVh6rzmGgpb1SYnoejMqihGP++zwTce8nsOPA4jRPmQwQ6BzTSjhPh5Q4/
	bTa1nZ6aEisdxeNUNbotA/r0Y08opXlCV9YrNEXmjAW/ZSbKmsa3n0i4uISZO/g==
X-Google-Smtp-Source: AGHT+IEGPEDHtyiuVX0WqAOQbTgWXRbowiKe0WnfH17r6Ih6V1RLgxslPgXXOvL+SoXMwK0pVeGoy4Tc3tkL8CL2X6FaMcEtNXZs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a87:b0:3dd:8136:a687 with SMTP id
 e9e14a558f8ab-3ddbebd825emr25413805ab.8.1749039221210; Wed, 04 Jun 2025
 05:13:41 -0700 (PDT)
Date: Wed, 04 Jun 2025 05:13:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68403875.a00a0220.d4325.000a.GAE@google.com>
Subject: [syzbot] [cgroups?] BUG: unable to handle kernel paging request in css_rstat_flush
From: syzbot <syzbot+36ca05bdc071f7ba8f75@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4cb6c8af8591 selftests/filesystems: Fix build of anon_inod..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17967ed4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43b7075a5c42ffca
dashboard link: https://syzkaller.appspot.com/bug?extid=36ca05bdc071f7ba8f75
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d9970580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e88c82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4cb6c8af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91b28032d866/vmlinux-4cb6c8af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cf2a9f8c096/bzImage-4cb6c8af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36ca05bdc071f7ba8f75@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffed1011a4ca01
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5ffcd067 P4D 5ffcd067 PUD 2fff7067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5328 Comm: kworker/0:3 Not tainted 6.15.0-syzkaller-10402-g4cb6c8af8591 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: cgroup_destroy css_free_rwork_fn
RIP: 0010:css_rstat_updated_list kernel/cgroup/rstat.c:284 [inline]
RIP: 0010:css_rstat_flush+0x5ff/0x1fa0 kernel/cgroup/rstat.c:413
Code: 1e 75 d1 0d 01 0f 85 e6 14 00 00 e8 1b 1e 07 00 4c 03 6c 24 20 4d 8d 7d 08 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 03 00 74 08 4c 89 ff e8 e3 51 6a 00 49 83 3f 00 0f 84 5d 01
RSP: 0018:ffffc9000d68f780 EFLAGS: 00010802
RAX: dffffc0000000000 RBX: 1ffff11011a4ca01 RCX: ffff88801f4ea440
RDX: 0000000000000000 RSI: ffffffff8be266a0 RDI: ffffffff8be26660
RBP: ffffc9000d68f9b8 R08: ffffffff8fa0aaf7 R09: 1ffffffff1f4155e
R10: dffffc0000000000 R11: fffffbfff1f4155f R12: ffff88801fc42590
R13: ffff88808d265000 R14: 0000000000000000 R15: ffff88808d265008
FS:  0000000000000000(0000) GS:ffff88808d265000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1011a4ca01 CR3: 0000000042fe0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 css_rstat_exit+0xa9/0x320 kernel/cgroup/rstat.c:479
 css_free_rwork_fn+0x8b/0xc50 kernel/cgroup/cgroup.c:5449
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: ffffed1011a4ca01
---[ end trace 0000000000000000 ]---
RIP: 0010:css_rstat_updated_list kernel/cgroup/rstat.c:284 [inline]
RIP: 0010:css_rstat_flush+0x5ff/0x1fa0 kernel/cgroup/rstat.c:413
Code: 1e 75 d1 0d 01 0f 85 e6 14 00 00 e8 1b 1e 07 00 4c 03 6c 24 20 4d 8d 7d 08 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 03 00 74 08 4c 89 ff e8 e3 51 6a 00 49 83 3f 00 0f 84 5d 01
RSP: 0018:ffffc9000d68f780 EFLAGS: 00010802
RAX: dffffc0000000000 RBX: 1ffff11011a4ca01 RCX: ffff88801f4ea440
RDX: 0000000000000000 RSI: ffffffff8be266a0 RDI: ffffffff8be26660
RBP: ffffc9000d68f9b8 R08: ffffffff8fa0aaf7 R09: 1ffffffff1f4155e
R10: dffffc0000000000 R11: fffffbfff1f4155f R12: ffff88801fc42590
R13: ffff88808d265000 R14: 0000000000000000 R15: ffff88808d265008
FS:  0000000000000000(0000) GS:ffff88808d265000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1011a4ca01 CR3: 0000000042fe0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	0f 85 e6 14 00 00    	jne    0x14ec
   6:	e8 1b 1e 07 00       	call   0x71e26
   b:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
  10:	4d 8d 7d 08          	lea    0x8(%r13),%r15
  14:	4c 89 fb             	mov    %r15,%rbx
  17:	48 c1 eb 03          	shr    $0x3,%rbx
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
* 25:	80 3c 03 00          	cmpb   $0x0,(%rbx,%rax,1) <-- trapping instruction
  29:	74 08                	je     0x33
  2b:	4c 89 ff             	mov    %r15,%rdi
  2e:	e8 e3 51 6a 00       	call   0x6a5216
  33:	49 83 3f 00          	cmpq   $0x0,(%r15)
  37:	0f                   	.byte 0xf
  38:	84 5d 01             	test   %bl,0x1(%rbp)


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

