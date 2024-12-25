Return-Path: <cgroups+bounces-6020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70C9FC4B5
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2024 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942A7163DE7
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BF1946CC;
	Wed, 25 Dec 2024 10:07:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD413211A
	for <cgroups@vger.kernel.org>; Wed, 25 Dec 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121241; cv=none; b=ZjlaeNkvk2kKTYjeHmb0JxhdM1n1/CMpPqJrJqyJyLi3EJDRjoq+yKN9IHnbaFIQoM0K1DO8jrmHhlPsqFfpgUB1ueCyZm5QeyU5FLhObFnGcetMBMfj6CfW73YQnrjHFO2skvZ/WFgkyIUpUbrQCfNCNlQlt2c4NwdSETKU1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121241; c=relaxed/simple;
	bh=e5c7aCkDtfs9yOx2nY7qQv/BoGNAxI3sn7ks4rF9u2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KPO3SHPaVQQ7CQ1l28S4dCJYmZy4QchNoVQozZToHkPfdY/5dkwtFFmmoUFVqd6/fw+E0tZd/puSZihKmm63Ip6rFyLNssJJE3vybwuS260GDfM7eus0xu7otZVEsiBUhg/PNCfqHYjYNYAkaeDRhmWaq5iQgWbw8BdK+Qcu9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso52809895ab.2
        for <cgroups@vger.kernel.org>; Wed, 25 Dec 2024 02:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735121239; x=1735726039;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDL/79LPU/Y7cyq2fqSebT41KpMh+KVmbUEwMqTIpwI=;
        b=Dd2YcCzyR71AKY8SE68QqHOuCT2gVGubSZzSgGEWiE2HNqbqX6z2iGYpCR1dJqeDe2
         QsUBwSye39aeEz6832HwvMY3qaHAotiFYKrgMSrVUVeNlKu8gLRu2QL0FQ2Krg0azjyA
         q+3pGHCz4KAiLFexViMJE4ewzRB9fhmhxKtGw151icHr3x6kS9Bf6DNGstJc49KHKsKe
         +SIcvfVjsL4Td8qrlYCLNydTIY9VjGU8VmN7ZGjq3f8oT39UGZ+YdLUcvgGo/CmqSFtX
         b1m9AZN2rhMNSVpuZS4k7KX07rTk438aCV7d0cQP1LHvxOHMjVQ0sMyPbOFRkJAwMH8p
         qXCA==
X-Forwarded-Encrypted: i=1; AJvYcCXRNvxe0Jg58iLd3pYw2+DWqPJqKCntRmd3ZXycc57ck3hosFcORolElLz+/z3oWP0YiyqlVT18@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1PIm9Q1htUNbO5kCPdyf1tJcrANn5ZzC+QioVsSaF/itHkS/
	SoXaYigXj0yrxOtJfrPSOmCZ33rF4g+WlMBI+NCO870BoqHgUnxAnA1gInHGA7xoNmfRmkifyUY
	Wsd5LO2WjsXD2QzPhwcNR37D+WWc12MEZEJs3OpExIwQQrzm75x36Fd4=
X-Google-Smtp-Source: AGHT+IFUlEI7qdBAZa8TdlxkXq9qEmj6fjjDYvQGQ2wt/4H9VEaG8w9bTglQuLwDy7Jp2+tGvhXpYqzYwxVSCBHA1G3fmzUcKZDB
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156d:b0:3ab:1b7a:593e with SMTP id
 e9e14a558f8ab-3c2d514f9ebmr184804185ab.19.1735121239346; Wed, 25 Dec 2024
 02:07:19 -0800 (PST)
Date: Wed, 25 Dec 2024 02:07:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676bd957.050a0220.2f3838.02e1.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] general protection fault in __memcg_kmem_charge_page
From: syzbot <syzbot+6c87d9f0b4ba556c9d83@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e9b8ffafd20a Merge tag 'usb-6.13-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1788dcf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=6c87d9f0b4ba556c9d83
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e4fdb0e4f25/disk-e9b8ffaf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d81695cd1d6/vmlinux-e9b8ffaf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/976c7fc4c5da/bzImage-e9b8ffaf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c87d9f0b4ba556c9d83@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 9346 Comm: syz.4.804 Not tainted 6.13.0-rc3-syzkaller-00193-ge9b8ffafd20a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__memcg_kmem_charge_page+0x1c5/0x2b0 mm/memcontrol.c:2676
Code: ad 00 00 00 4c 89 e7 be 01 00 00 00 49 83 cc 02 e8 60 1c ff ff 48 8d 7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cf 00 00 00 4c 89 63 38 e9 5f ff ff ff 48 3b 2d
RSP: 0018:ffffc900195afa80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900195afa00
RDX: 0000000000000007 RSI: ffffffff8b4cd480 RDI: 0000000000000038
RBP: ffff888028d10000 R08: 0000000000000000 R09: fffffbfff2039c72
R10: ffffffff901ce397 R11: 0000000000000000 R12: ffff888031d4df82
R13: 0000000000000001 R14: 0000000000000cc0 R15: dffffc0000000000
FS:  00005555870d9500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe63461cd58 CR3: 00000000250b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 memcg_kmem_charge_page include/linux/memcontrol.h:1697 [inline]
 memcg_charge_kernel_stack kernel/fork.c:265 [inline]
 memcg_charge_kernel_stack+0xc3/0x1f0 kernel/fork.c:256
 alloc_thread_stack_node kernel/fork.c:299 [inline]
 dup_task_struct kernel/fork.c:1121 [inline]
 copy_process+0x5a3/0x6f20 kernel/fork.c:2225
 kernel_clone+0xfd/0x960 kernel/fork.c:2807
 __do_sys_clone3+0x1f9/0x270 kernel/fork.c:3111
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6337ba589
Code: 1b 08 00 48 8d 3d 9c 1b 08 00 e8 12 29 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffc6268d038 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007fe63373c9a0 RCX: 00007fe6337ba589
RDX: 00007fe63373c9a0 RSI: 0000000000000058 RDI: 00007ffc6268d080
RBP: 00007fe63461c6c0 R08: 00007fe63461c6c0 R09: 00007ffc6268d167
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000006e R14: 00007ffc6268d080 R15: 00007ffc6268d168
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__memcg_kmem_charge_page+0x1c5/0x2b0 mm/memcontrol.c:2676
Code: ad 00 00 00 4c 89 e7 be 01 00 00 00 49 83 cc 02 e8 60 1c ff ff 48 8d 7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cf 00 00 00 4c 89 63 38 e9 5f ff ff ff 48 3b 2d
RSP: 0018:ffffc900195afa80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900195afa00
RDX: 0000000000000007 RSI: ffffffff8b4cd480 RDI: 0000000000000038
RBP: ffff888028d10000 R08: 0000000000000000 R09: fffffbfff2039c72
R10: ffffffff901ce397 R11: 0000000000000000 R12: ffff888031d4df82
R13: 0000000000000001 R14: 0000000000000cc0 R15: dffffc0000000000
FS:  00005555870d9500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4aaa7452d8 CR3: 00000000250b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ad                   	lods   %ds:(%rsi),%eax
   1:	00 00                	add    %al,(%rax)
   3:	00 4c 89 e7          	add    %cl,-0x19(%rcx,%rcx,4)
   7:	be 01 00 00 00       	mov    $0x1,%esi
   c:	49 83 cc 02          	or     $0x2,%r12
  10:	e8 60 1c ff ff       	call   0xffff1c75
  15:	48 8d 7b 38          	lea    0x38(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 cf 00 00 00    	jne    0x103
  34:	4c 89 63 38          	mov    %r12,0x38(%rbx)
  38:	e9 5f ff ff ff       	jmp    0xffffff9c
  3d:	48                   	rex.W
  3e:	3b                   	.byte 0x3b
  3f:	2d                   	.byte 0x2d


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

