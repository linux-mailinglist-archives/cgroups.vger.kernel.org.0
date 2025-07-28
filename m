Return-Path: <cgroups+bounces-8918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72DB143DD
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303F218C19D1
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7E19DFB4;
	Mon, 28 Jul 2025 21:30:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABEB4A33
	for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738230; cv=none; b=G3L8IHhs1D7PBffqQSpX2hrE83Z9bEpA3IFfIiZNfGlT4y18PTfscWYLwLeF0xQfE6aKvHyAu5uTSbbHPkXadY2MuU/jJ5cgLiD2eryF8i7LTLiKC02LcLosmaB3GxU5QMag/HRbxVnCzHcWo7riNZAaoOUDiOjmx/KtKvgwFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738230; c=relaxed/simple;
	bh=VDGn08fZpsOlV9unI3898MnkZMAvBOqyh+AKjJESQKg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QIoG5itahooAh+f1MeSjyii/8qz2fI63HGVEcglpbNGfrOd4/Sa75Cf7snQ9YfUJQZDz5be8EsKY8HCQqBEdfBLnZAgdOJBWxKi+PtJB8ROM26mTJd19AI5cG+7lC+4su/Fj85Ojk0EaunF4VKjeG1CO483ryfai0t9Ydb0nZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc5137992so60466155ab.2
        for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 14:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738228; x=1754343028;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAAVpHi2dnL2vQU9XMWpO330RRdxmeuo4AaHAIxsSyk=;
        b=lYSZGCEfJmbeWJlUdlAZgptOce5BCnWQ6Uc0a+1FRcwlARK0Ch2CptAVyCZUoLnveo
         4nWcvqHNMNy0ubPuC8BUMegGFmiaGUzpmjUPWRXJyk/8E8sUCI2K5I3qsNUM4PPHKJCZ
         a8spUCTMua6onW4y1rtirjucojyCNPOkOATaoNLPDqkAmZEnbVieLm0C4/LSt+DCzTjy
         ZH46F66VwZ2/G+svmoyDdifpr3ewGS4mcmL6eQb3OXJW0lFA10RicUGp/n8mUhUHWzze
         RT21OE7KJdWTZVvWjw2qvm8tuBmAGBWDszcvKgypNh7SK0aHEN5Dk1+Hub4PbuuLvFym
         pvYA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLbtTH9veIRxCAmJjdhRcICgGoWhCSO0Ifzm69xF36OzurIqCFKjHLt5T4Qoml8czA51hbsOD@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZR3+n0hNqVqpdEvEp+re0U8Rjdu8Z2bs8PV08t2vg8Dp90cH
	8+NAMWp+AAlyuoRYaWhqHwD0FwBIRLwhkf3641A45GqVGq0QLQxQ2wkCFpPQ1eA7oA/yrfK/9c1
	4w0Q1cB4TAnMU/HtjLV14RNtCErjLJhdFAyf6iYUd5y1x9JTIGzhvKBMrijo=
X-Google-Smtp-Source: AGHT+IHlf2gExfOweoRKA8xQ8U2obLJdnB/6OhrAm7XdIqeHnIUBha7KQ8KV8Q29kA1uuaIzMfe1bycPWFiD+3a6gOfQFLxPtl5n
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2681:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3e3c52c7ec8mr221635275ab.13.1753738228350; Mon, 28 Jul 2025
 14:30:28 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:30:28 -0700
In-Reply-To: <6856d355.a00a0220.137b3.007d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887ebf4.a00a0220.b12ec.00ae.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
From: syzbot <syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	jackmanb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, mhocko@suse.com, muchun.song@linux.dev, 
	netdev@vger.kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    afd8c2c9e2e2 Merge branch 'ipv6-f6i-fib6_siblings-and-rt-f..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13c71034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4bcc0a11b3192be
dashboard link: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b284a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c71034580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f29edec8e85/disk-afd8c2c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8490ef85f5cd/vmlinux-afd8c2c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1357e17669cb/bzImage-afd8c2c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (3 ticks this GP) idle=8da4/1/0x4000000000000000 softirq=18768/18768 fqs=0
rcu: 	(detected by 1, t=10502 jiffies, g=13833, q=887 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5983 Comm: syz-executor Not tainted 6.16.0-rc7-syzkaller-00100-gafd8c2c9e2e2 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__lock_acquire+0x316/0xd20 kernel/locking/lockdep.c:5188
Code: 8b 54 24 0c 83 e2 01 c1 e2 12 44 09 e2 41 c1 e6 14 41 09 d6 8b 54 24 10 c1 e2 13 c1 e5 15 09 d5 09 cd 44 09 f5 41 89 6c c7 20 <45> 89 44 c7 24 4c 89 7c 24 10 4d 8d 34 c7 81 e5 ff 1f 00 00 48 0f
RSP: 0018:ffffc90000007b40 EFLAGS: 00000002
RAX: 000000000000000a RBX: ffffffff8e13f0e0 RCX: 0000000000000007
RDX: 0000000000080000 RSI: 0000000000004000 RDI: ffff88802c368000
RBP: 00000000000a4007 R08: 0000000000000000 R09: ffffffff898d70e8
R10: dffffc0000000000 R11: ffffed100fc2785e R12: 0000000000024000
R13: 0000000000000000 R14: 0000000000024000 R15: ffff88802c368af0
FS:  0000000000000000(0000) GS:ffff888125c23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556e2015c8 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 advance_sched+0xa14/0xc90 net/sched/sch_taprio.c:985
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:debug_lockdep_rcu_enabled+0xf/0x40 kernel/rcu/update.c:320
Code: cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d 17 30 34 04 00 74 1e <83> 3d 3a 60 34 04 00 74 15 65 48 8b 0c 25 08 d0 9f 92 31 c0 83 b9
RSP: 0018:ffffc90003f0ef70 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff90d8d001 RCX: ffffc90003f0ff60
RDX: ffffc90003f0f001 RSI: dffffc0000000000 RDI: ffffc90003f0f050
RBP: dffffc0000000000 R08: ffffc90003f0ff48 R09: 0000000000000000
R10: ffffc90003f0f098 R11: fffff520007e1e15 R12: ffffc90003f0ff58
R13: ffffc90003f08000 R14: ffffc90003f0f048 R15: ffffffff8172aae5
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x195c/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf5/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x71/0x1f0 mm/page_owner.c:308
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xc66/0x14d0 mm/page_alloc.c:2763
 folios_put_refs+0x559/0x640 mm/swap.c:992
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:264
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x44c/0xb50 mm/mmap.c:1297
 __mmput+0x118/0x420 kernel/fork.c:1121
 exit_mm+0x1da/0x2c0 kernel/exit.c:581
 do_exit+0x648/0x22e0 kernel/exit.c:952
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f730c585213
Code: Unable to access opcode bytes at 0x7f730c5851e9.
RSP: 002b:00007ffe0103af48 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: fffffffffffffffc RBX: 0000000000000000 RCX: 00007f730c585213
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000055556e1e67d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000003604b R15: 00007ffe0103b0e0
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g13833 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=10563
rcu: rcu_preempt kthread starved for 10502 jiffies! g13833 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26792 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

