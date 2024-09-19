Return-Path: <cgroups+bounces-4905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B097CAED
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 16:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF37D284FE7
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB419F47A;
	Thu, 19 Sep 2024 14:28:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3919E827
	for <cgroups@vger.kernel.org>; Thu, 19 Sep 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756104; cv=none; b=rUVPT7WEdwWRqsJzlF/Vghqz8eoTcqcWFDE7cyaOG/xvm6BWygxHzFfSb4erJ/GabHNl6AzAs7jK8haZ43taHP4kxDMO7tFHBG2SpAiX9WBOOklhknJ3FuK6G5Wkn3TDtiuAF7UKqdBFg5NMVWAkhc793cpq4+okpmIuK8HHhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756104; c=relaxed/simple;
	bh=ARkS/TdRTX1quJ/+KneNXaNfoRa+gSBSyw6INjFOF/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=geLa7lsrv9F0gIkSI+tplKGenpBCQl1qofdjyTH+0+EFE7ndPqjg63Ks/ABZPmSxOe+Md+RbY9jh1SUTbvlMncpglscqOMcm0/JMg6Wi1XehUVtWw44SsbNgkXukpW4dPl50bNC03JhQq+MMDEe/hesCXPN4qiEwziYLysva+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so14771215ab.3
        for <cgroups@vger.kernel.org>; Thu, 19 Sep 2024 07:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726756102; x=1727360902;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhoKh0X8PkzpeoULm+kGqj4f92k1O+QVQGRIZuxdXLg=;
        b=oUcy4mBL3GdFsu8TQNiljJOZHTvdpgztvVCmwhJsNE7hFzFIhK/b7GdLeh6oJgJfj3
         t6kh01L2qUvjwGjfc5v7v+ctRqPZkBpa3SSEx6oW1qYPyG167yFuIq9ZMoNaz6rJY0Ka
         rrjZPLa6J411JO/KleCEa/mSZX6CmiQ/phJlXtsiSMcFcHRV8SMfmOw7+eBmv2F6q2m1
         hfHmQ32cijQIeV3cHmvZ0buNGplSeec67wy8U3FwnhPGoRHt02DRNPDUJQpuDQz8dBIS
         cAkl91LehtvSlhSd3ShR/xmLfaE/dvDclBqS7EB6PpPJW8e3bondSr8kj3V1Ego4KwF4
         kruA==
X-Forwarded-Encrypted: i=1; AJvYcCWzB+KsEbA1v9r7yW2F3tSmFdMQf2xcD0aZ1z3eZPr8NSv0PrrWQQuoIorNwlLl3KopGb9NRQ1z@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcPYjIet5fpY2B2Mx9QHdjKHsjBczqHIWaaA6BN5lYxZo/5Xj
	cwZGXmXysi0jmjju4M/VTtJwwYvMEfzIrxrTglFybg8jtgpiner+5NRfamFgJs2uUD0rmQHXD21
	j8KDV13wZZIABU2qbr3cOjWPVy2lY3wC2Jv6E8ISCnKjc/KdFfXHFBDM=
X-Google-Smtp-Source: AGHT+IEmWmlkU6TQc0eoIUQ2KVbgxtgRCiNv5E2vZEYIy31oMVG2AdhxLIjyKZOYLzsw5eIEbk6JaDkSir0WnjIE2Y9OOozyx7Hd
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:194e:0:b0:3a0:979d:843 with SMTP id
 e9e14a558f8ab-3a0979d0a06mr126255195ab.9.1726756102390; Thu, 19 Sep 2024
 07:28:22 -0700 (PDT)
Date: Thu, 19 Sep 2024 07:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec3506.050a0220.29194.002c.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] INFO: rcu detected stall in shmem_fault (6)
From: syzbot <syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162de407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d6146edacfa/disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2593d4fb261a/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5e44e1e0eba/bzImage-0babf683.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4145b11cdf925264bff4@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P9592/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=41797, q=358 ncpus=2)
task:syz.1.962       state:R  running task     stack:24176 pid:9592  tgid:9589  ppid:9183   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6851
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5763
Code: 2b 00 74 08 4c 89 f7 e8 ea e1 87 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90003d47020 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920007a8e10 RCX: baa91729e815a300
RDX: dffffc0000000000 RSI: ffffffff8beae6e0 RDI: ffffffff8c3fbb00
RBP: ffffc90003d47168 R08: ffffffff93fa6847 R09: 1ffffffff27f4d08
R10: dffffc0000000000 R11: fffffbfff27f4d09 R12: 1ffff920007a8e0c
R13: dffffc0000000000 R14: ffffc90003d47080 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 filemap_get_entry+0x144/0x3b0 mm/filemap.c:1837
 shmem_get_folio_gfp+0x29a/0x2370 mm/shmem.c:2104
 shmem_fault+0x252/0x6f0 mm/shmem.c:2388
 __do_fault+0x135/0x460 mm/memory.c:4672
 do_read_fault mm/memory.c:5078 [inline]
 do_fault mm/memory.c:5208 [inline]
 do_pte_missing mm/memory.c:3964 [inline]
 handle_pte_fault+0x321f/0x6fc0 mm/memory.c:5538
 __handle_mm_fault mm/memory.c:5681 [inline]
 handle_mm_fault+0x1056/0x1ad0 mm/memory.c:5849
 faultin_page mm/gup.c:1194 [inline]
 __get_user_pages+0x6ec/0x16a0 mm/gup.c:1493
 populate_vma_page_range+0x264/0x330 mm/gup.c:1932
 __mm_populate+0x27a/0x460 mm/gup.c:2035
 mm_populate include/linux/mm.h:3430 [inline]
 vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:593
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f848877def9
RSP: 002b:00007f848949c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f8488936058 RCX: 00007f848877def9
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f84887f0b76 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8488936058 R15: 00007ffd36b2c578
 </TASK>
rcu: rcu_preempt kthread starved for 10184 jiffies! g41797 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26448 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2236
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 9590 Comm: syz.4.963 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__bpf_trace_run kernel/trace/bpf_trace.c:2397 [inline]
RIP: 0010:bpf_trace_run2+0x159/0x540 kernel/trace/bpf_trace.c:2447
Code: 08 42 80 3c 30 00 74 08 48 89 df e8 81 a7 58 00 48 89 5c 24 38 48 8b 03 bb 01 00 00 00 65 0f c1 18 31 ff 89 de e8 f7 87 f4 ff <85> db 0f 85 b4 02 00 00 49 83 c5 70 4c 89 e8 48 c1 e8 03 42 80 3c
RSP: 0018:ffffc9000318fde0 EFLAGS: 00000297
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888026beda00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000318fec8 R08: ffffffff819f08a9 R09: 0000000000000000
R10: ffffc9000318fe40 R11: fffff52000631fca R12: ffffc90003b05000
R13: ffff888033723100 R14: dffffc0000000000 R15: ffffc9000318fe40
FS:  00007fc00c8a16c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3f657a CR3: 0000000088454000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 trace_sys_enter+0x93/0xd0 include/trace/events/syscalls.h:18
 syscall_trace_enter+0xf8/0x150 kernel/entry/common.c:61
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc00bb19869
Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 c7 c0 0f 00 00 00 0f 05 <0f> 1f 80 00 00 00 00 48 81 ec 48 01 00 00 49 89 d0 64 48 8b 04 25
RSP: 002b:00007fc00c8a0b40 EFLAGS: 00000246 ORIG_RAX: 000000000000000f
RAX: ffffffffffffffda RBX: 00007fc00bd35f88 RCX: 00007fc00bb19869
RDX: 00007fc00c8a0b40 RSI: 00007fc00c8a0c70 RDI: 0000000000000011
RBP: 00007fc00bd35f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc00bd35f8c
R13: 0000000000000000 R14: 00007ffc51e12cf0 R15: 00007ffc51e12dd8
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

