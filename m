Return-Path: <cgroups+bounces-8711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E9B0283A
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FD81BC4160
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 00:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F01BC13B;
	Sat, 12 Jul 2025 00:18:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CF28EA
	for <cgroups@vger.kernel.org>; Sat, 12 Jul 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279511; cv=none; b=C2U1DjU27TDd3OvivwszmrOZ4bSDUm9zwNfBIRlyTQXoT+d7K5Mhc7xTGALWexxE0kSP95Q5xF/kwxmEvdzNuGEBPo8vziSmrR0OVbkJufOATwOkiV8ZDZG9HCrFQD9z1tBUZ9ylOh4tRT136Bd+VvWKyTKs8P7MJKXquBB4OXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279511; c=relaxed/simple;
	bh=6dFTYNpFUVBQqnN1/mtDp7ng8H4jHhD+yjiIyvb8BYg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EufRBtZdZKnavz0uhcqakHo8tECbgEsgPXjEEidd63zlvc9/v0+7BSiJ83TCeqLz3zKpYco43+4fxcEyNInkHma2kkX2zO17PzGbi77ZKyB9ZmQ/zZ3JM5CZvvOB2XYgMWymU/sO2MB2AjaRdw2jbJOV7dXty+owEqXzAarXguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso199730739f.0
        for <cgroups@vger.kernel.org>; Fri, 11 Jul 2025 17:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752279507; x=1752884307;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQALLwmfA73YmVnX2LrLf/r+X6NtXvtn2shVmLr2SRY=;
        b=MFYXkAphpJSoMz04WtsfOhKMK+8ULfdd3XiLtaHjjUiV9ajtkvzE0NwbIJFVS/zvZx
         SNOFubnn/KqLFblQz8K8561fTj7ICgMRY+E7i3Hud/+cbo2awk3uDGVbfJLxRgwGHBau
         WAH6qJxI/m2mCVIS4a0IUCx08XG3JcHsdC22nM+Z0oZjwua6mOIL6sfnPc6uO1jwYURa
         8w316Fa63vu5bsDPqY4zKnA2fFpJE9hkosfy7cd5lYNjISkEP6F1hdhtHYX5Stq6Za6c
         wdivzckaX1zJlUm1GW5Mqzi/SNJbyQ7dil74jIjIbmzCYim0O3HQ9a3iN1JMITDMqncO
         nNyw==
X-Forwarded-Encrypted: i=1; AJvYcCXqZ8DmppYlr+f93ewS/+3FtXra266xkmzCsj1H8GTDoC8sFLcvzctbKk/b8fKWOE0ftKWADjIc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zuWTi14RIW0y0XRxsUt0Dtk1pCESGGAveaNMrSpcT++y0TM5
	18kgMYYBT6jvKofEKGFlytsNCX/Dfehzwq2inDs57DAcSpf3WluyPT6foKOdmyA95U0UyXSFC90
	JIcqZhNkc6fBfb6NrS0pUNN3coYHFlJhuvs4y4UV8d6AqGl/0tGznUIuGyeM=
X-Google-Smtp-Source: AGHT+IHxO/DbbBvcSrHKA8xEYK/h/4Dr6uzQnw8uAaLlIii6QiVx+AbrM4xuyKIBgPtO533CNLpI2fHnfZKZ/J6IzxpV71/9tz6N
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3102:b0:3df:5283:ac73 with SMTP id
 e9e14a558f8ab-3e2533106d4mr74812165ab.12.1752279506748; Fri, 11 Jul 2025
 17:18:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:18:26 -0700
In-Reply-To: <6856d355.a00a0220.137b3.007d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871a9d2.a00a0220.26a83e.0064.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
From: syzbot <syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    40f92e79b0aa Merge tag 'block-6.16-20250710' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139f2d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f2d82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-40f92e79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8022f6fa9a48/vmlinux-40f92e79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/565fa9fa3299/bzImage-40f92e79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com

 #5: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #5: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #5: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by fido_id/5515:
=============================================
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (8 ticks this GP) idle=07d4/1/0x4000000000000000 softirq=37345/37345 fqs=0
rcu: 	(t=11778 jiffies g=24965 q=168 ncpus=1)
rcu: rcu_preempt kthread starved for 11778 jiffies! g24965 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28200 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
CPU: 0 UID: 0 PID: 5507 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-00193-g40f92e79b0aa #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 3b 0d 56 f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 03 2e 1f f6 65 8b 05 ac 9a 2e 07 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc90000007b00 EFLAGS: 00000206
RAX: fdeecc9c1cd86500 RBX: 0000000000000a02 RCX: fdeecc9c1cd86500
RDX: 0000000000000002 RSI: ffffffff8d998a4b RDI: 0000000000000001
RBP: ffffc90000007b90 R08: ffffffff8fa1f3f7 R09: 1ffffffff1f43e7e
R10: dffffc0000000000 R11: fffffbfff1f43e7f R12: dffffc0000000000
R13: ffff8880596dc110 R14: ffff8880596dc218 R15: 1ffff92000000f60
FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005626cd793a30 CR3: 000000000df38000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__memcg_slab_free_hook+0x292/0x3d0 mm/memcontrol.c:3214
Code: 00 44 89 e1 d3 eb 4d 89 ef 4c 8b 6c 24 28 4c 8d 24 dd 00 00 00 00 4d 01 ec 4c 89 e3 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 03 00 74 08 4c 89 e7 e8 20 ed f7 ff 49 8b 2c 24 48 85 ed 0f
RSP: 0018:ffffc90002a3f518 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: 1ffff11009b39429 RCX: 0000000000000008
RDX: 00000000fffffee8 RSI: ffffea00010d1e40 RDI: ffffc90002a3f5b8
RBP: 0000000000000801 R08: ffff88804d9ca100 R09: 1ffff110086b40ab
R10: dffffc0000000000 R11: ffffed10086b40ac R12: ffff88804d9ca148
R13: ffff88804d9ca100 R14: 0000000000000000 R15: ffffea00010d1e40
 memcg_slab_free_hook mm/slub.c:2206 [inline]
 slab_free mm/slub.c:4640 [inline]
 kmem_cache_free+0x223/0x400 mm/slub.c:4745
 anon_vma_free mm/rmap.c:137 [inline]
 __put_anon_vma+0x12b/0x2d0 mm/rmap.c:2756
 put_anon_vma include/linux/rmap.h:117 [inline]
 unlink_anon_vmas+0x503/0x670 mm/rmap.c:444
 free_pgtables+0x7bf/0xaf0 mm/memory.c:402
 exit_mmap+0x444/0xb50 mm/mmap.c:1295
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
RIP: 0033:0x7f506cd8e52b
Code: Unable to access opcode bytes at 0x7f506cd8e501.
RSP: 002b:00007fff239d9450 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffc RBX: 00000000ffffff75 RCX: 00007f506cd8e52b
RDX: 00007fff239d94d0 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007f506d0e0320 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00002000000002c0
R13: 0000000000000000 R14: 00007f506cfb5fa0 R15: 0000000000000004
 </TASK>
task:init            state:S stack:18776 pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_hrtimeout_range_clock+0x1c5/0x2f0 kernel/time/sleep_timeout.c:207
 do_sigtimedwait+0x386/0x680 kernel/signal.c:3782
 __do_sys_rt_sigtimedwait kernel/signal.c:3826 [inline]
 __se_sys_rt_sigtimedwait+0x1cd/0x2b0 kernel/signal.c:3804
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd0ae646407
RSP: 002b:00007ffc586c2070 EFLAGS: 00000202 ORIG_RAX: 0000000000000080
RAX: ffffffffffffffda RBX: 00007fd0ae4f6c80 RCX: 00007fd0ae646407
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fd0ae860498
RBP: 00007fd0ae860490 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000202 R12: 00007fd0ae860490
R13: 00007ffc586c20ec R14: 00007fd0ae8a0000 R15: 0000559f223e1d98
 </TASK>
task:kthreadd        state:S stack:25752 pid:2     tgid:2     ppid:0      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kthreadd+0x3e3/0x770 kernel/kthread.c:835
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:pool_workqueue_ state:S stack:28552 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kthread_worker_fn+0x4c2/0xb60 kernel/kthread.c:1017
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-rcu_g state:I stack:30152 pid:4     tgid:4     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-sync_ state:I stack:30248 pid:5     tgid:5     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-kvfre state:I stack:30248 pid:6     tgid:6     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-slub_ state:I stack:30248 pid:7     tgid:7     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-netns state:I stack:30328 pid:8     tgid:8     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/0:0     state:R  running task     stack:19848 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/0:1     state:I stack:25032 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg2)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/0:0H    state:I stack:27880 pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u4:0    state:I stack:23016 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u4:1    state:I stack:22472 pid:13    tgid:13    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-mm_pe state:I stack:30248 pid:14    tgid:14    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:ksoftirqd/0     state:R  running task     stack:21512 pid:15    tgid:15    ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 smpboot_thread_fn+0x5bd/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:rcu_preempt     state:R  running task     stack:28200 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:rcu_exp_par_gp_ state:S stack:30312 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kthread_worker_fn+0x4c2/0xb60 kernel/kthread.c:1017
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:rcu_exp_gp_kthr state:S stack:29000 pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kthread_worker_fn+0x4c2/0xb60 kernel/kthread.c:1017
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:migration/0     state:R  running task     stack:29952 pid:19    tgid:19    ppid:2      task_flags:0x4208040 flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 smpboot_thread_fn+0x5bd/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:cpuhp/0         state:S stack:25336 pid:20    tgid:20    ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 smpboot_thread_fn+0x5bd/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kdevtmpfs       state:S stack:25416 pid:21    tgid:21    ppid:2      task_flags:0x208140 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 devtmpfs_work_loop+0xce2/0xd20 drivers/base/devtmpfs.c:413
 devtmpfsd+0x4d/0x50 drivers/base/devtmpfs.c:446
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-inet_ state:I stack:30248 pid:22    tgid:22    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:rcu_tasks_kthre state:I stack:28168 pid:23    tgid:23    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rcu_tasks_one_gp+0x877/0xdf0 kernel/rcu/tasks.h:611
 rcu_tasks_kthread+0x195/0x1c0 kernel/rcu/tasks.h:658
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:rcu_tasks_trace state:I stack:28584 pid:24    tgid:24    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rcu_tasks_one_gp+0x877/0xdf0 kernel/rcu/tasks.h:611
 rcu_tasks_kthread+0x195/0x1c0 kernel/rcu/tasks.h:658
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kauditd         state:S stack:28776 pid:25    tgid:25    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kauditd_thread+0x894/0x9a0 kernel/audit.c:911
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:khungtaskd      state:R  running task     stack:29496 pid:26    tgid:26    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 watchdog+0x90/0x1030 kernel/hung_task.c:474
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:oom_reaper      state:S stack:30184 pid:27    tgid:27    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 oom_reaper+0x112/0xae0 mm/oom_kill.c:650
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-write state:I stack:30248 pid:28    tgid:28    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kcompactd0      state:R  running task     stack:25480 pid:29    tgid:29    ppid:2      task_flags:0x210040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 kcompactd+0x406/0x1290 mm/compaction.c:3223
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kcompactd1      state:R  running task     stack:25088 pid:30    tgid:30    ppid:2      task_flags:0x210040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 kcompactd+0x406/0x1290 mm/compaction.c:3223
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u4:2    state:R  running task     stack:23512 pid:31    tgid:31    ppid:2      task_flags:0x4208160 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:ksmd            state:S stack:29800 pid:32    tgid:32    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 ksm_scan_thread+0x38e/0x4b0 mm/ksm.c:2692
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:khugepaged      state:S stack:29384 pid:33    tgid:33    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 khugepaged_wait_work mm/khugepaged.c:2586 [inline]
 khugepaged+0x13b3/0x1690 mm/khugepaged.c:2598
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-kbloc state:I stack:30248 pid:34    tgid:34    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-blkcg state:I stack:30248 pid:35    tgid:35    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-kinte state:I stack:30248 pid:36    tgid:36    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:irq/9-acpi      state:S stack:30152 pid:37    tgid:37    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 irq_wait_for_interrupt kernel/irq/manage.c:1065 [inline]
 irq_thread+0x482/0x670 kernel/irq/manage.c:1253
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-tpm_d state:I stack:30248 pid:38    tgid:38    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-ata_s state:I stack:30248 pid:39    tgid:39    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-md    state:I stack:30248 pid:40    tgid:40    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-md_bi state:I stack:30248 pid:41    tgid:41    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-edac- state:I stack:30248 pid:42    tgid:42    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u4:3    state:I stack:21720 pid:43    tgid:43    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-ib-co state:I stack:30248 pid:44    tgid:44    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u5:0    state:I stack:25400 pid:45    tgid:45    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (hci0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-ib-co state:I stack:30248 pid:46    tgid:46    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-ib_mc state:I stack:30248 pid:47    tgid:47    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-ib_nl state:I stack:30248 pid:48    tgid:48    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/0:1H    state:I stack:24056 pid:49    tgid:49    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-rpcio state:I stack:30248 pid:50    tgid:50    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-xprti state:I stack:30248 pid:51    tgid:51    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cfg80 state:I stack:30248 pid:52    tgid:52    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/u4:4    state:I stack:23272 pid:54    tgid:54    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/0:2     state:I stack:23912 pid:55    tgid:55    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg2)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 worker_thread+0xa82/0xda0 kernel/workqueue.c:3417
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kswapd0         state:S stack:27544 pid:78    tgid:78    ppid:2      task_flags:0x220840 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kswapd_try_to_sleep mm/vmscan.c:7271 [inline]
 kswapd+0x6ea/0x2830 mm/vmscan.c:7329
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kswapd1         state:S stack:23512 pid:79    tgid:79    ppid:2      task_flags:0x220840 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kswapd_try_to_sleep mm/vmscan.c:7271 [inline]
 kswapd+0x6ea/0x2830 mm/vmscan.c:7329
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:ecryptfs-kthrea state:S stack:30280 pid:84    tgid:84    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 ecryptfs_threadfn+0x14e/0x3c0 fs/ecryptfs/kthread.c:48
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nfsio state:I stack:30248 pid:87    tgid:87    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cifsi state:I stack:30248 pid:88    tgid:88    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-smb3d state:I stack:30248 pid:89    tgid:89    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cifsf state:I stack:30248 pid:90    tgid:90    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cifso state:I stack:30248 pid:91    tgid:91    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-defer state:I stack:30248 pid:92    tgid:92    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-serve state:I stack:30248 pid:93    tgid:93    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cfid_ state:I stack:30248 pid:94    tgid:94    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-cifs- state:I stack:30248 pid:95    tgid:95    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:jfsIO           state:S stack:30440 pid:102   tgid:102   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 jfsIOWait+0x10a/0x270 fs/jfs/jfs_logmgr.c:2331
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:jfsCommit       state:S stack:30152 pid:103   tgid:103   ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 jfs_lazycommit+0x852/0xa90 fs/jfs/jfs_txnmgr.c:2761
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:jfsSync         state:S stack:30344 pid:104   tgid:104   ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 jfs_sync+0x4b4/0x650 fs/jfs/jfs_txnmgr.c:2948
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-xfsal state:I stack:30248 pid:105   tgid:105   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-xfs_m state:I stack:30248 pid:106   tgid:106   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-user_ state:I stack:30248 pid:108   tgid:108   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-gfs2_ state:I stack:30248 pid:110   tgid:110   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-pencr state:I stack:30248 pid:113   tgid:113   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-pdecr state:I stack:30248 pid:115   tgid:115   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-crypt state:I stack:30248 pid:117   tgid:117   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-kthro state:I stack:30248 pid:119   tgid:119   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:irq/26-aerdrv   state:S stack:30152 pid:138   tgid:138   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 irq_wait_for_interrupt kernel/irq/manage.c:1065 [inline]
 irq_thread+0x482/0x670 kernel/irq/manage.c:1253
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-acpi_ state:I stack:30248 pid:157   tgid:157   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nfit  state:I stack:30248 pid:162   tgid:162   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:hwrng           state:R  running task     stack:29336 pid:756   tgid:756   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 hwrng_fillfn+0x2f0/0x400 drivers/char/hw_random/core.c:515
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:card1-crtc0     state:S stack:30392 pid:778   tgid:778   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 kthread_worker_fn+0x4c2/0xb60 kernel/kthread.c:1017
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd0- state:I stack:30248 pid:840   tgid:840   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd1- state:I stack:30248 pid:843   tgid:843   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd2- state:I stack:30248 pid:844   tgid:844   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd3- state:I stack:30248 pid:849   tgid:849   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd4- state:I stack:30248 pid:852   tgid:852   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd5- state:I stack:30248 pid:855   tgid:855   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd6- state:I stack:30248 pid:858   tgid:858   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd7- state:I stack:30248 pid:861   tgid:861   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd8- state:I stack:30248 pid:864   tgid:864   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd9- state:I stack:30248 pid:867   tgid:867   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd10 state:I stack:30248 pid:870   tgid:870   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd11 state:I stack:30248 pid:873   tgid:873   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd12 state:I stack:30248 pid:876   tgid:876   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd13 state:I stack:30248 pid:879   tgid:879   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd14 state:I stack:30248 pid:882   tgid:882   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nbd15 state:I stack:30248 pid:885   tgid:885   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-iscsi state:I stack:30248 pid:945   tgid:945   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvme- state:I stack:30248 pid:962   tgid:962   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvme- state:I stack:30248 pid:965   tgid:965   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvme- state:I stack:30248 pid:967   tgid:967   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvme_ state:I stack:30248 pid:978   tgid:978   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvmet state:I stack:30248 pid:980   tgid:980   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvmet state:I stack:30248 pid:981   tgid:981   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-nvmet state:I stack:29912 pid:982   tgid:982   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 rescuer_thread+0xc69/0xdd0 kernel/workqueue.c:3552
 kthread+0x70e/0x8a0 kernel/kthread.c:46

---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

