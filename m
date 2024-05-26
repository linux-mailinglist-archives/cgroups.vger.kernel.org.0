Return-Path: <cgroups+bounces-3009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84598CF694
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 00:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C82816DE
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E02139D11;
	Sun, 26 May 2024 22:55:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0E381BA
	for <cgroups@vger.kernel.org>; Sun, 26 May 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764124; cv=none; b=e+59IwEL8cT1ZEEDqiRbwCPR3NvGOYPX9HB82nlDhmhjsGwQiq/E1F6wRcQtDtGNVz7DW27Rz1HbGDrUXDxvXgW0vtVOo6nV6rKD1Ozo7G5Crz2zIGOVRLUPa0WHvUI4ZaEuiAMxRGik/YYzoceZ1CcHtRoZqEbF8f5/XIWrIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764124; c=relaxed/simple;
	bh=f144X/zmMaX2Zqxbouq98dIWUDBRmJ/WQWtA0t29/PA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U8uzF7kKipLEf7NLBzLp8QovrVT99ZTF3RMHs83wplgsf6X3uz9xSLt76j3uF0p4BDLrULAZa8Ef4WR1zSP68pLQlhHhoYJ5XKQYkWHohE5B8RHdW6hzEqKNjMiM7s5sNnWhhKJ5ISlE6TW273e52Ok29gWwJJdl9eiaIIFZZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eac3b73a53so110288939f.0
        for <cgroups@vger.kernel.org>; Sun, 26 May 2024 15:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716764122; x=1717368922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XOgSBEz+pwJtCKMr4MKKy8Z10QlH76l3/abKBewEqY=;
        b=M8zSXvy64Ons0965EOFOb6eGdYQMlXM7/l3XXbq368u3HHsAQu2GIyT98K+V5HGGMd
         FiM8HS574dRrmhmjB3c/OvlU1zpTR7JbjVCrIg7iA5ftcp+eQWph2JvnjnSATgs7b4NL
         SW5JVT/LqgS0Xf/UQEkg5WyhG/Q1quyhoJRJcmcCgz9Jk1V33XygRA+zmtQ5GFPGdd9y
         y6xZUXIhDyec/uCXISPJ1UMDu9DMtYRNarctPbgqHKQHJEKBF8VMzoixEsZmaYZFRQi2
         uU67FZSTd+yA2HPHqM8oallK7CY9tf6v/Bhf8w1ePYYr7NNjRXDOIQLvHJiXCaNms6OD
         0AZw==
X-Forwarded-Encrypted: i=1; AJvYcCVJJWoltTsaOghNe/ERVt+D3jqYAIrrTtv2oCFiEIRTg2hMhNH8OQ4xNKKoC0a6aro4tA1PN40XiKksjqbAABlcXbcaR7XX9g==
X-Gm-Message-State: AOJu0YzYol8jT2MaCE2H3wyKv/V/Ci3Fu5JWF9uK74GtHlLqdfkkMgEM
	Gg8OmWnAD4zScHbOUmNLR5JUljcRiqLAL/kRHIlpeyHleNzPm5PFDL8ulruY/q5GAnwsqAz55rb
	B58Jn56eL30S+oGmQFKfuRZ4/w6hIPeCEz34XQP33A1d8d9LSQPXFybQ=
X-Google-Smtp-Source: AGHT+IE3NM9BbUd0/JwUNy6pBhAQ7b/T1zNpzuRmJea+9LsaJ/S9ozfxyUVStFaipFxPw0gT9ls8RSommG8I+exRNmGK9Rmhk0rU
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4e:b0:373:8c59:d31b with SMTP id
 e9e14a558f8ab-3738c59d5c8mr3703645ab.2.1716764122098; Sun, 26 May 2024
 15:55:22 -0700 (PDT)
Date: Sun, 26 May 2024 15:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a93f2c0619634b13@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in shmem_file_write_iter (2)
From: syzbot <syzbot+3acfdc6a28244a4f4039@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127ed4b2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=3acfdc6a28244a4f4039
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4428368407e9/disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d250915da349/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7d2d995f217/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3acfdc6a28244a4f4039@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P62/2:b..l P5270/1:b..l P5260/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=9633, q=1038 ncpus=2)
task:syz-executor.5  state:R  running task     stack:25776 pid:5260  tgid:5257  ppid:5110   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7067
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
Code: 2b 00 74 08 4c 89 f7 e8 ca 7e 89 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90003c9f520 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000793eb0 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcaca00 RDI: ffffffff8c1fe480
RBP: ffffc90003c9f680 R08: ffffffff92fa8587 R09: 1ffffffff25f50b0
R10: dffffc0000000000 R11: fffffbfff25f50b1 R12: 1ffff92000793eac
R13: dffffc0000000000 R14: ffffc90003c9f580 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 percpu_ref_get_many+0x36/0x140 include/linux/percpu-refcount.h:202
 percpu_ref_get include/linux/percpu-refcount.h:222 [inline]
 css_get include/linux/cgroup_refcnt.h:11 [inline]
 mem_cgroup_commit_charge+0x9f/0x380 mm/memcontrol.c:3132
 charge_memcg+0xb1/0x160 mm/memcontrol.c:7501
 __mem_cgroup_charge+0x27/0x80 mm/memcontrol.c:7512
 mem_cgroup_charge include/linux/memcontrol.h:691 [inline]
 shmem_alloc_and_add_folio+0x394/0xdb0 mm/shmem.c:1677
 shmem_get_folio_gfp+0x82d/0x1f50 mm/shmem.c:2055
 shmem_get_folio mm/shmem.c:2160 [inline]
 shmem_write_begin+0x170/0x4d0 mm/shmem.c:2743
 generic_perform_write+0x324/0x640 mm/filemap.c:4015
 shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2919
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa74/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe4ac07bc2f
RSP: 002b:00007fe4ace12e80 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007fe4ac07bc2f
RDX: 0000000001000000 RSI: 00007fe4a1e00000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000050e7
R10: 0000000000000002 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fe4ace12f80 R14: 00007fe4ace12f40 R15: 00007fe4a1e00000
 </TASK>
task:syz-executor.0  state:R  running task     stack:25360 pid:5270  tgid:5269  ppid:5112   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7067
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d ec 8d 45 0c 48 89 de 5b e9 b3 4c 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 15 10 c0
RSP: 0000:ffffc90003d07cd0 EFLAGS: 00000282
RAX: fffffffffffffff9 RBX: 00007f1a930e9000 RCX: ffff88801fd05a00
RDX: ffffc90009e3b000 RSI: 00007f1a930e9000 RDI: 0000001b32d1ffff
RBP: 0000000000000004 R08: ffffffff8b7a9ef8 R09: ffffffff8b7a9d42
R10: 0000000000000003 R11: ffff88801fd05a00 R12: ffff8880225ac028
R13: 0000001b32d1ffff R14: ffff8880225ac008 R15: fffffffffffffff5
 mtree_range_walk+0x2c4/0x8e0 lib/maple_tree.c:2781
 mas_state_walk lib/maple_tree.c:3678 [inline]
 mas_walk+0x83/0x280 lib/maple_tree.c:4909
 lock_vma_under_rcu+0x231/0x6e0 mm/memory.c:5840
 do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x17b/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f1a9d228800
RSP: 002b:00007f1a9dfda530 EFLAGS: 00010282
RAX: 00000000000e9000 RBX: 00007f1a9dfda5d0 RCX: 0000000000000016
RDX: 000000000000007f RSI: 0000000000000200 RDI: 00007f1a9dfda670
RBP: 00000000000000e8 R08: 00007f1a93000000 R09: 00000000000000fe
R10: 0000000000000000 R11: 00007f1a9dfda5e0 R12: 0000000000000181
R13: 00007f1a9d2ebfc0 R14: 0000000000000011 R15: 00007f1a9dfda670
 </TASK>
task:kworker/u8:4    state:R  running task     stack:22992 pid:62    tgid:62    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __local_bh_enable_ip+0x179/0x200 kernel/softirq.c:389
 neigh_forced_gc net/core/neighbour.c:293 [inline]
 neigh_alloc net/core/neighbour.c:485 [inline]
 ___neigh_create+0x5b5/0x2470 net/core/neighbour.c:648
 ip6_finish_output2+0x1629/0x1670 net/ipv6/ip6_output.c:128
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xab0/0x1380 net/ipv6/ndisc.c:509
 addrconf_dad_completed+0x76c/0xcd0 net/ipv6/addrconf.c:4359
 addrconf_dad_work+0xdc2/0x16f0
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 10588 jiffies! g9633 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25936 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2202
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d5 03 00 48 f7 00 08 00 00 00 75 10 eb 07 0f 00 2d b5 56 a3 00 f3 0f 1e fa fb f4 <fa> e9 54 23 2a 00 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff8880176a8000 RBX: ffff8880186af064 RCX: 0000000000053c99
RDX: 0000000000000001 RSI: ffff8880186af000 RDI: ffff8880186af064
RBP: 000000000003a5b8 R08: ffff8880b9537d0b R09: 1ffff110172a6fa1
R10: dffffc0000000000 R11: ffffffff8b861960 R12: ffff88801a384000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8eacd960
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f17cddd3000 CR3: 0000000079cca000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x114/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
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

