Return-Path: <cgroups+bounces-7888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B85AA08C0
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE077483AD6
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C952BEC51;
	Tue, 29 Apr 2025 10:42:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6A29B23E
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923354; cv=none; b=VA8iXvnvumxScHRgTVwLmNPZoknx1ipPGujeNRn47J9ltukuQ/TlS48ErvraOzc17oMd9DfW1GRBOcAJ0GH5oydpkzo4ua6HL2LGSkJvwsqcOTVWEQP7Bz47KCzRzkyR+k3imtW/X1+7az8ltClnJFiPxSgGNJhGQ1yzS1MRk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923354; c=relaxed/simple;
	bh=vdoTOrYjJwnGOC8m9sJkAjTzIX37lcVCVXD/5r1RONA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VKJGzT21l7ivLbE1FEig8tbgt6KeIZ2IR9aqOmULvQY5GM6IIuy8WwgTjigvJzZ4gUkJOAf//EdTMwIOvTNYS3UY9tklwwMx7spvnBRLXsdpJPXBv722Mkcn+DsJNJ6It4dzFiJtpwymlrmuvXFDkkmaPOhM9DDq3TJqrJVQq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b5875e250so655713439f.0
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 03:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745923351; x=1746528151;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRophdm8oDs35m84I8oLizHZRLNW8xoAE45y80ihuZU=;
        b=sGjTRihHXQWaVS5p32DiVMZQy6XzVThoIITRQKAeq9XY6LxBFbGM0cHRFAbaUXHuqk
         wRr2sktvSefuJp/tr/uStqCrpC0b2lFXjgCsAOuUwZL8CYCTY4SokJgj2SzKmKHkJQvI
         fEc8BjmrnTtetzTLkSyAtHkakdeRI/OSOdyHV5YhicLBGCArR+FQtS3WSvwme7fR4uM5
         o0jj3sg/F/XPIN8jQZSvB5rfjf6JVcJey67LWXT4nHtNqRbZiduKtvepx+IEDWq0bfS1
         bPOQn54CEeI5SjHMyFRXe4TJ44JRi28+qVfaiNtRuca3F8UjKCyE+8xX23oj2BL300qb
         ph+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6effa0KnRLr9ydsDhAWIl3b7epNfNJgWx0PwHZ0j9zJ1quE2PbgiZOjg/yjGo6AypDU3JFzH1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55ZJUMeKFZ+s1f2C1f0jdPSXfez3bIBk+kNA1LrDxJfmACeT/
	SWy7bd7qDNZW8Pd6CMHpnAd0r82RF/BqKpBWLLH8NnIJLxS1DHySBvb6XL6CFrPlJVw0ZseHq6i
	7GMeE9m6X7cKAqCepEh++B7YyGouhghpz6uARHWYYiwuwJynvzR3M0Yk=
X-Google-Smtp-Source: AGHT+IGw7moHf+nCnGMJd2aBCM/S+fJnJrsHsOkGXVJpN6c4An9HQFyCyZBYVRYF6E/eURVCXhzpjbvGROOh+RnsF/b/O1PbeaaL
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360c:b0:85b:619e:4083 with SMTP id
 ca18e2360f4ac-8648aed753emr240851339f.10.1745923351637; Tue, 29 Apr 2025
 03:42:31 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:42:31 -0700
In-Reply-To: <66ec3506.050a0220.29194.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6810ad17.a70a0220.23e4d2.0039.GAE@google.com>
Subject: Re: [syzbot] [mm] INFO: rcu detected stall in shmem_fault (6)
From: syzbot <syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ca91b9500108 Merge tag 'v6.15-rc4-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146608d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714654674710be70
dashboard link: https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15093374580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ca91b950.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1aed2fe3946/vmlinux-ca91b950.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1acc08824f75/bzImage-ca91b950.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P5753/1:b..l P5752/3:b..l P5754/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=25409, q=12 ncpus=1)
task:syz.1.103       state:R  running task     stack:25912 pid:5754  tgid:5754  ppid:5448   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7090
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:121 [inline]
RIP: 0010:lock_release+0x70/0x3e0 kernel/locking/lockdep.c:5879
Code: e8 c5 c8 08 00 84 c0 75 0d f6 05 1d a3 ca 0d 01 0f 84 ad 02 00 00 83 3d fd da e0 0d 00 0f 84 44 02 00 00 65 8b 05 e0 5e d7 10 <85> c0 0f 85 35 02 00 00 65 4c 8b 3c 25 08 40 75 92 41 83 bf ec 0a
RSP: 0018:ffffc90002dbec90 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffffff9017e101 RCX: 6bb510f00c406100
RDX: ffffc90002dbee01 RSI: ffffffff8bc1cdc0 RDI: ffffffff8bc1cd80
RBP: dffffc0000000000 R08: ffffc90002dbf748 R09: 0000000000000000
R10: ffffc90002dbee18 R11: fffff520005b7dc5 R12: ffffc90002dbf758
R13: ffffffff817199f5 R14: ffffffff8df3b860 R15: ffffffff817199f5
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf7/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x8d/0x4a0 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
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
RIP: 0033:0x7fb958f8e969
RSP: 002b:00007ffde50a3fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fb9591b5fa0 RCX: 00007fb958f8e969
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007fb959010ab1 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb9591b5fa0 R14: 00007fb9591b5fa0 R15: 0000000000000006
 </TASK>
task:syz.3.101       state:R  running task     stack:26008 pid:5752  tgid:5752  ppid:5463   task_flags:0x400040 flags:0x00004002
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
 filemap_map_pages+0x1115/0x1740 mm/filemap.c:3748
 do_fault_around mm/memory.c:5476 [inline]
 do_read_fault mm/memory.c:5509 [inline]
 do_fault mm/memory.c:5652 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:5997 [inline]
 __handle_mm_fault+0x34d8/0x5380 mm/memory.c:6140
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
RIP: 0033:0x7f3d22d8e969
RSP: 002b:00007ffdda08b858 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f3d22fb5fa0 RCX: 00007f3d22d8e969
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007f3d22e10ab1 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3d22fb5fa0 R14: 00007f3d22fb5fa0 R15: 0000000000000006
 </TASK>
task:syz.5.102       state:R  running task     stack:25816 pid:5753  tgid:5753  ppid:5468   task_flags:0x400040 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7090
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x2b5/0x3e0 kernel/locking/lockdep.c:5891
Code: 51 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 75 56 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 7b 20 d7 10 <48> 3b 44 24 28 0f 85 8b 00 00 00 48 83 c4 30 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc9000ce7f918 EFLAGS: 00000206
RAX: 6383ecbdc47abd00 RBX: 0000000000000206 RCX: 6383ecbdc47abd00
RDX: 0000000000000001 RSI: ffffffff8d93404f RDI: ffffffff8bc1cde0
RBP: ffff888000aa5398 R08: ffff888056076303 R09: 1ffff1100ac0ec60
R10: dffffc0000000000 R11: ffffed100ac0ec61 R12: 0000000000000001
R13: 0000000000000001 R14: ffffffff8df3b860 R15: ffff888000aa4880
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 pte_unmap include/linux/pgtable.h:136 [inline]
 follow_page_pte+0xde9/0x13c0 mm/gup.c:941
 follow_pmd_mask mm/gup.c:-1 [inline]
 follow_pud_mask mm/gup.c:1027 [inline]
 follow_p4d_mask mm/gup.c:1044 [inline]
 follow_page_mask mm/gup.c:1087 [inline]
 __get_user_pages+0x8eb/0x2a40 mm/gup.c:1489
 populate_vma_page_range+0x26b/0x340 mm/gup.c:1929
 __mm_populate+0x24c/0x380 mm/gup.c:2032
 mm_populate include/linux/mm.h:3487 [inline]
 vm_mmap_pgoff+0x3f0/0x4c0 mm/util.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fa6d8e969
RSP: 002b:00007fff5c171558 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f0fa6fb5fa0 RCX: 00007f0fa6d8e969
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000200000000000
RBP: 00007f0fa6e10ab1 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0fa6fb5fa0 R14: 00007f0fa6fb5fa0 R15: 0000000000000006
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! g25409 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=17963
rcu: rcu_preempt kthread starved for 10500 jiffies! g25409 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27864 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
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
CPU: 0 UID: 0 PID: 1311 Comm: aoe_tx0 Not tainted 6.15.0-rc4-syzkaller-00021-gca91b9500108 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:check_kcov_mode kernel/kcov.c:194 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x37/0x90 kernel/kcov.c:300
Code: 08 40 75 92 65 8b 0d 48 7e b5 10 81 e1 00 01 ff 00 74 11 81 f9 00 01 00 00 75 5b 83 ba 3c 16 00 00 00 74 52 8b 8a 18 16 00 00 <83> f9 03 75 47 48 8b 8a 20 16 00 00 44 8b 8a 1c 16 00 00 49 c1 e1
RSP: 0018:ffffc90002b7f7e8 EFLAGS: 00000246
RAX: ffffffff853aa1d2 RBX: ffffffff99b4c7c8 RCX: 0000000000000000
RDX: ffff8880355ca440 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000001 R08: ffff888000ad8f87 R09: 1ffff1100015b1f0
R10: dffffc0000000000 R11: ffffed100015b1f1 R12: dffffc0000000000
R13: 0000000000000000 R14: 1ffffffff33698f9 R15: ffff888000ad8b00
FS:  0000000000000000(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555574dc5808 CR3: 0000000011179000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_atomic_dec_and_test arch/x86/include/asm/atomic.h:67 [inline]
 raw_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:2278 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1384 [inline]
 uart_port_deref drivers/tty/serial/serial_core.c:74 [inline]
 uart_write_room+0x412/0x840 drivers/tty/serial/serial_core.c:649
 handle_tx+0x163/0x610 drivers/net/caif/caif_serial.c:212
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

