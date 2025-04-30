Return-Path: <cgroups+bounces-7954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7608AA4CFA
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D81F163A0D
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EE25DCE9;
	Wed, 30 Apr 2025 13:02:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3F25D544
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018167; cv=none; b=ku9An4W7RsHlntAw913EnpMQq5LR2XugE8gMxQLPDF1rAQ4yQk5k1gYnnvu1qG2eJCZ2DgA/Milp3LGSAcBdXeBZUciV7P0N205gSWLZPjiQEM5H4E5kV68xoB6bTyOp9p7UndC1/ZxV9af/H8bByAx/ulUv8hnmeQYSFmHEEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018167; c=relaxed/simple;
	bh=x2ti7/R5nDhd7tDM2yYsl6Li6KD9V2vS1surI/MyTMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RFTIBakpy+yjnitIefWGgRdwd4lEBVDSi7zqgWPt7zVD0peEOogbCdNKZ8T0MWFscYiNq7qj91fTctInnYD1lqocrvWoqNDrIx0/oYGdBLYr2O4YKJw3PR9k5riPIdTPFSpxM8PlpEbAK+VQrQ4o2oxyXj0U/hza/mqDvQpRLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d458e61faaso10714105ab.0
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 06:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746018164; x=1746622964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmOoeQf9gPzkDmiMisSnG7s0f6SHLuIsdiddQpOp3vM=;
        b=f05EgtYXWE+6TRtp4RkFn/1N3dOVuileLCkxYRE2ZhfLxARliaDpgQ/I54ax9m7K4j
         ujXHbc04auLuda/PgpuZFY+Fs2r+XeHkK+F+S24LolXrcVP7DPtuBM14QSydzx9xZOCV
         ZHRFrFlD11dB7XdRee+Q4BKQHW6dPUBiFO1v4Li9BqqghgybLjZ1NjdJvzIryCLW9jOm
         Oq/8cImCCpHhuPvKo4mDfhr7QkQtmwmI2UP9vslLpg4F11m0aJHyEpKJXPaqnUNuRNxp
         r0bOlwbyfI5Vi3Wa9syw55PpVFZPNI8I6/Mjxh2kZWUxH/9+cyXUXo/ZJKdj43paeqdS
         C2pA==
X-Forwarded-Encrypted: i=1; AJvYcCU+RtIa78ONDhfYwCh2JxQj3MLs6+OVHD6YzgLo9/FRnc0CfqKDoTBEyTZPgA2yuHFlkQiYw3Ny@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUt1NAgrabTUuAcP638h0egLkiV8YdHx1ISf0vhClQf9mmWMR
	TogIM/oW+n7mmUIOJP8G6NjL4AT3l89f6qr+zFt0vm9A8U5V8b6gcjZhv7In9emM9KqsO1qdgVC
	fsbvXZGGAUZUQX2uveT6YYdGMnCVTzrc35dDSsviIVKK7spmaW2c1Qlw=
X-Google-Smtp-Source: AGHT+IGWcJ9YH5i+42cHHNOMi/JmDtuM5N80ImmfT0BnlCFeXpfXN7ODPcasb/JJ6wxdcH4O0ruiTAy82WsY5JUmj3MDYNGL4fEu
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de6:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d96792b52cmr21081175ab.5.1746018153312; Wed, 30 Apr 2025
 06:02:33 -0700 (PDT)
Date: Wed, 30 Apr 2025 06:02:33 -0700
In-Reply-To: <66ec3506.050a0220.29194.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68121f69.050a0220.14dd7d.0000.GAE@google.com>
Subject: Re: [syzbot] [mm] INFO: rcu detected stall in shmem_fault (6)
From: syzbot <syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156131b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1390502f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e4fecc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8bac8898.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a76d594c0f5/vmlinux-8bac8898.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dae09c25780d/bzImage-8bac8898.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P6103/1:b..l P6106/1:b..l P6104/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=24761, q=25 ncpus=1)
task:syz-executor384 state:R  running task     stack:26008 pid:6104  tgid:6104  ppid:5332   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 preempt_schedule_common+0x83/0xd0 kernel/sched/core.c:6947
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:6971
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3f/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 finish_fault+0xd97/0x1020 mm/memory.c:5388
 do_read_fault mm/memory.c:5522 [inline]
 do_fault mm/memory.c:5652 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:5997 [inline]
 __handle_mm_fault+0x3666/0x5380 mm/memory.c:6140
 handle_mm_fault+0x3f6/0x8c0 mm/memory.c:6309
 faultin_page mm/gup.c:1193 [inline]
 __get_user_pages+0x16f0/0x2a40 mm/gup.c:1491
 populate_vma_page_range+0x26b/0x340 mm/gup.c:1929
 __mm_populate+0x24c/0x380 mm/gup.c:2032
 mm_populate include/linux/mm.h:3487 [inline]
 vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc94d0ef959
RSP: 002b:00007ffed9bc6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000005d4df RCX: 00007fc94d0ef959
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00007ffed9bc61dc
R13: 00007ffed9bc6210 R14: 00007ffed9bc61f0 R15: 000000000000003c
 </TASK>
task:dhcpcd-run-hook state:R  running task     stack:23928 pid:6106  tgid:6106  ppid:5016   task_flags:0x400000 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 preempt_schedule_notrace+0xd1/0x110 kernel/sched/core.c:7040
 preempt_schedule_notrace_thunk+0x16/0x30 arch/x86/entry/thunk.S:13
 rcu_is_watching+0x7f/0xb0 kernel/rcu/tree.c:737
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x4b/0x3e0 kernel/locking/lockdep.c:5877
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3202
 ma_free_rcu lib/maple_tree.c:211 [inline]
 mas_free lib/maple_tree.c:1313 [inline]
 mas_topiary_replace lib/maple_tree.c:2584 [inline]
 mas_wmb_replace+0x209d/0x25f0 lib/maple_tree.c:2641
 mas_split lib/maple_tree.c:3368 [inline]
 mas_commit_b_node+0xa6e/0xf40 lib/maple_tree.c:3388
 mas_wr_bnode lib/maple_tree.c:4049 [inline]
 mas_wr_store_entry+0x510/0x2550 lib/maple_tree.c:4090
 mas_store_prealloc+0xb02/0xf60 lib/maple_tree.c:5475
 vma_iter_store_new mm/vma.h:455 [inline]
 vma_link+0x254/0x450 mm/vma.c:1754
 insert_vm_struct+0x2d0/0x3d0 mm/mmap.c:1357
 __install_special_mapping mm/mmap.c:1507 [inline]
 _install_special_mapping+0x1b0/0x350 mm/mmap.c:1543
 map_vdso+0x1ff/0x480 arch/x86/entry/vdso/vma.c:174
 load_elf_binary+0x1c85/0x27b0 fs/binfmt_elf.c:1277
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1810 [inline]
 bprm_execve+0x999/0x1440 fs/exec.c:1862
 do_execveat_common+0x510/0x6a0 fs/exec.c:1968
 do_execve fs/exec.c:2042 [inline]
 __do_sys_execve fs/exec.c:2118 [inline]
 __se_sys_execve fs/exec.c:2113 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7677a0ef7
RSP: 002b:00007ff76764ae78 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00007ffc285c39b0 RCX: 00007ff7677a0ef7
RDX: 0000557645b67700 RSI: 00007ffc285c3ea0 RDI: 000055761bc40df6
RBP: 00007ff76764aff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc285c3cc8
R13: 00007ff76764af28 R14: 0000000000000000 R15: 0000000000000041
 </TASK>
task:syz-executor384 state:R  running task     stack:26008 pid:6103  tgid:6103  ppid:5336   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7090
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_cmp8+0x0/0x90 kernel/kcov.c:293
Code: 7c 11 10 48 89 74 11 18 48 89 44 11 20 c3 cc cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 08 40 75 92 65 8b 15 e8 7e
RSP: 0018:ffffc9000d9d70a0 EFLAGS: 00000293
RAX: ffffffff822c9a9b RBX: 0000000000000000 RCX: ffff88801f920000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff822c998a R12: ffff888030e42f70
R13: 0000000000000000 R14: 00000000000473cc R15: ffffea00011cf2f0
 __page_table_check_zero+0x1d6/0x510 mm/page_table_check.c:139
 page_table_check_alloc include/linux/page_table_check.h:33 [inline]
 post_alloc_hook+0x1eb/0x230 mm/page_alloc.c:1719
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4970
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2320
 shmem_alloc_folio mm/shmem.c:1854 [inline]
 shmem_alloc_and_add_folio+0x447/0xf60 mm/shmem.c:1893
 shmem_get_folio_gfp+0x597/0x15f0 mm/shmem.c:2533
 shmem_fault+0x179/0x390 mm/shmem.c:2734
 __do_fault+0x135/0x390 mm/memory.c:5098
 do_read_fault mm/memory.c:5518 [inline]
 do_fault mm/memory.c:5652 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:5997 [inline]
 __handle_mm_fault+0x363e/0x5380 mm/memory.c:6140
 handle_mm_fault+0x3f6/0x8c0 mm/memory.c:6309
 faultin_page mm/gup.c:1193 [inline]
 __get_user_pages+0x16f0/0x2a40 mm/gup.c:1491
 populate_vma_page_range+0x26b/0x340 mm/gup.c:1929
 __mm_populate+0x24c/0x380 mm/gup.c:2032
 mm_populate include/linux/mm.h:3487 [inline]
 vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc94d0ef959
RSP: 002b:00007ffed9bc6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000005d4c4 RCX: 00007fc94d0ef959
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00007ffed9bc61dc
R13: 00007ffed9bc6210 R14: 00007ffed9bc61f0 R15: 000000000000003c
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g24761 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=26096
rcu: rcu_preempt kthread starved for 10502 jiffies! g24761 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27640 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2046
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2248
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 1311 Comm: aoe_tx0 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 8b e1 6e f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 73 63 38 f6 65 8b 05 5c e5 1c 07 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc900029cf740 EFLAGS: 00000206
RAX: b3874e252c70ba00 RBX: 0000000000000a06 RCX: b3874e252c70ba00
RDX: 0000000000000002 RSI: ffffffff8d749f9b RDI: 0000000000000001
RBP: ffffc900029cf7d0 R08: ffffffff8f7ed377 R09: 1ffffffff1efda6e
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff99b4c6c0 R15: 1ffff92000539ee8
FS:  0000000000000000(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22234160d0 CR3: 0000000035bd2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 uart_port_unlock_irqrestore include/linux/serial_core.h:786 [inline]
 uart_write+0x4cd/0xa40 drivers/tty/serial/serial_core.c:628
 handle_tx+0x23c/0x610 drivers/net/caif/caif_serial.c:222
 __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
 netdev_start_xmit include/linux/netdevice.h:5212 [inline]
 xmit_one net/core/dev.c:3776 [inline]
 dev_hard_start_xmit+0x2ff/0x880 net/core/dev.c:3792
 __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4629
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 tx+0x6b/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1cd/0x3e0 drivers/block/aoe/aoecmd.c:1237
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

