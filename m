Return-Path: <cgroups+bounces-8112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F372AB1D1C
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 21:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A3DA029B1
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2A24290C;
	Fri,  9 May 2025 19:04:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D7241661
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817468; cv=none; b=MLPn4lS7GTSyG+/aBta4jyGEI3Hxh4Kd+qlCRkcDznr2eoAzgkzWdKXakApJOXhUgxHOoDUIFRs7FQeYzwifb91eh32NzQ8Y2dITkv+mqhsWFw0a5+FhTv239vI6ZSWlM6JFEMBouSSjtGYR51to7IYj7GU3ivFLhi92B1lN9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817468; c=relaxed/simple;
	bh=THgDNr9PNvboh5Gv7bSf91/lHKOaEXvmCoefmhxESRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZuZdS1653LoTT9bEZSvWCUkMqMT7Hw1XD51WQWVQF60s8jpO6fEo6ApwRntvRQcMBhZ6qQFMa6Mw3wqZ9uEZP9jHyU8wz40L4tnnZi/XCIctDRkgxL/6veIcQhhJn4tbf+kGo1qKjcY2VVbFKxhUNcvC3WaArikrdszxr2yEfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so28091785ab.3
        for <cgroups@vger.kernel.org>; Fri, 09 May 2025 12:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746817466; x=1747422266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNUNcYv0Ke/2vqZcy7/UF3xFz/CGqB6MR0l8UgL0O5Q=;
        b=Ijqg8ul4P1nEA/rr3bHGtkMmtG1/Hofzhpq90+PZHWRkrc5NpN7unq4yYiwGKKHe2H
         tPXflFX1kIHeoghJNBexHxxf9M8Xq9vdqLnKAJQtPntE3SmfwrdpeHrFp0gMzcouhqnC
         c0mesisjCpzDrDCbeuX2oZXiSO4nsdNPaGi0ziJLINPmEFtUoHAOxQax2obfePK6yLI2
         m9+R+8DcNMwAOzJ3MpbuUfpyGgoIduVzkDkAx9WA3YSv/6lmcb8CF61YGI4SENLeVhC0
         l1ybDhI378F2viWo5jq6X3M/sGuq4+pPYm8/q5wfUOHfdTfUe8gw/0v5WQ6NOGf2bF5K
         e0JA==
X-Gm-Message-State: AOJu0YxbjJOKqGeO1NygT49BacsZJso9GNs0brneBqWdxUC8QNnjtL/g
	B6G/wkb63iimMdBGUou8zgNaDjOvt+bV7bnvts6Vs30wnwGPpfcMM7mI3poO+wT/uygxzGKj2hr
	QtJd8VncOx6OAF/qcIZN3nhqwMpQzJKDDNIBHEI0D0csmrLoUvBOX6meFVA==
X-Google-Smtp-Source: AGHT+IEdbhgGBnDiY1W79Tp3QKZk/O/WEbEDIP471AC3y1To2+WDq+ta0v2fiysy6CtNi9ZWwfNrqK5jA1mnGTOTsktj3sIdg3uI
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2611:b0:3da:715a:dde4 with SMTP id
 e9e14a558f8ab-3da7e1e77f5mr53142775ab.9.1746817466141; Fri, 09 May 2025
 12:04:26 -0700 (PDT)
Date: Fri, 09 May 2025 12:04:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681e51ba.050a0220.a19a9.013a.GAE@google.com>
Subject: [syzbot] [cgroups?] general protection fault in cgroup_rstat_flush
From: syzbot <syzbot+175b931e69c9ad9e1945@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c69f8884904 Merge tag 'bcachefs-2025-05-08' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1440acf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=175b931e69c9ad9e1945
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/062b75278fb3/disk-9c69f888.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/868b31a2cf71/vmlinux-9c69f888.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e773657fdf9c/bzImage-9c69f888.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+175b931e69c9ad9e1945@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe7ffed1c349f36f7: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x3fff88e1a4f9b7b8-0x3fff88e1a4f9b7bf]
CPU: 0 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.15.0-rc5-syzkaller-00136-g9c69f8884904 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound flush_memcg_stats_dwork
RIP: 0010:cgroup_rstat_push_children kernel/cgroup/rstat.c:165 [inline]
RIP: 0010:cgroup_rstat_updated_list kernel/cgroup/rstat.c:245 [inline]
RIP: 0010:cgroup_rstat_flush+0x840/0x1e70 kernel/cgroup/rstat.c:325
Code: 70 74 08 48 89 df e8 ef e6 66 00 4c 8b 23 4b 8d 1c 3c 48 81 c3 a0 00 00 00 49 89 dd 49 c1 ed 03 48 b8 00 00 00 00 00 fc ff df <41> 80 7c 05 00 00 74 08 48 89 df e8 c0 e6 66 00 48 8b 03 48 3b 44
RSP: 0018:ffffc90000bd7920 EFLAGS: 00010003
RAX: dffffc0000000000 RBX: 3fff88e1a4f9b7bd RCX: 1ffffffff1b2b383
RDX: 0000000000000000 RSI: ffffffff8bc0fec0 RDI: ffff88806481c5c1
RBP: ffffc90000bd7b08 R08: ffffffff8f7da777 R09: 1ffffffff1efb4ee
R10: dffffc0000000000 R11: fffffbfff1efb4ef R12: ffff888126200000
R13: 07fff11c349f36f7 R14: 0000000000000000 R15: 400000607ed9b71d
FS:  0000000000000000(0000) GS:ffff888126100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005598d2923440 CR3: 000000005d74e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_memcg_stats_dwork+0x15/0x60 mm/memcontrol.c:653
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:cgroup_rstat_push_children kernel/cgroup/rstat.c:165 [inline]
RIP: 0010:cgroup_rstat_updated_list kernel/cgroup/rstat.c:245 [inline]
RIP: 0010:cgroup_rstat_flush+0x840/0x1e70 kernel/cgroup/rstat.c:325
Code: 70 74 08 48 89 df e8 ef e6 66 00 4c 8b 23 4b 8d 1c 3c 48 81 c3 a0 00 00 00 49 89 dd 49 c1 ed 03 48 b8 00 00 00 00 00 fc ff df <41> 80 7c 05 00 00 74 08 48 89 df e8 c0 e6 66 00 48 8b 03 48 3b 44
RSP: 0018:ffffc90000bd7920 EFLAGS: 00010003
RAX: dffffc0000000000 RBX: 3fff88e1a4f9b7bd RCX: 1ffffffff1b2b383
RDX: 0000000000000000 RSI: ffffffff8bc0fec0 RDI: ffff88806481c5c1
RBP: ffffc90000bd7b08 R08: ffffffff8f7da777 R09: 1ffffffff1efb4ee
R10: dffffc0000000000 R11: fffffbfff1efb4ef R12: ffff888126200000
R13: 07fff11c349f36f7 R14: 0000000000000000 R15: 400000607ed9b71d
FS:  0000000000000000(0000) GS:ffff888126100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005598d2923440 CR3: 000000005d74e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	70 74                	jo     0x76
   2:	08 48 89             	or     %cl,-0x77(%rax)
   5:	df e8                	fucomip %st(0),%st
   7:	ef                   	out    %eax,(%dx)
   8:	e6 66                	out    %al,$0x66
   a:	00 4c 8b 23          	add    %cl,0x23(%rbx,%rcx,4)
   e:	4b 8d 1c 3c          	lea    (%r12,%r15,1),%rbx
  12:	48 81 c3 a0 00 00 00 	add    $0xa0,%rbx
  19:	49 89 dd             	mov    %rbx,%r13
  1c:	49 c1 ed 03          	shr    $0x3,%r13
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	41 80 7c 05 00 00    	cmpb   $0x0,0x0(%r13,%rax,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	48 89 df             	mov    %rbx,%rdi
  35:	e8 c0 e6 66 00       	call   0x66e6fa
  3a:	48 8b 03             	mov    (%rbx),%rax
  3d:	48                   	rex.W
  3e:	3b                   	.byte 0x3b
  3f:	44                   	rex.R


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

