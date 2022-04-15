Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B231502EB4
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiDOScF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Apr 2022 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346141AbiDOScE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Apr 2022 14:32:04 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E912AE35
        for <cgroups@vger.kernel.org>; Fri, 15 Apr 2022 11:29:34 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id j6-20020a5d93c6000000b0064fbbf9566bso5193321ioo.12
        for <cgroups@vger.kernel.org>; Fri, 15 Apr 2022 11:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FbMjEIPPAYHEIYauSBBUtIikeSC93AIJ1vmyKeWqGAg=;
        b=XVaiGxFP9NeuTFDKpKtDBkPRD6U4pU50rjaMf0xDztI/8kuspDpJhLK1k7ETUFw8Go
         cjCdplfqEjp+wtdOghmPX707VE39AYxKfq0v8RhiGorxW5myug6RdVEPqpOCUCN/vKaG
         iFNRyL1pTL11o/bM///KBLBVfJqoo+04V+tkXZYuLVwmlRocVUUf5UIa3ZunX7ulm7O+
         6N4BpIg7wIPmuPefMmEwZDpIPPqal7Rw9vrPhC0PgOoHz3bHgicn+zfA7HzX/U/5lZmx
         Xk8qMi3dDpIJZXLbKJ2SMXcwAcfAI5R1y4PF/KYdigrJ7zSjJN6AkpncX4MKYihcJFDM
         94WQ==
X-Gm-Message-State: AOAM533wya3drFHYcLvmyjoVfFzD1tlTBq0sOtftnlmfsHRUDEHwO2q8
        i6r9YlIpUc0IojDZkNwhZlhMkEObzNRKooJ+Sn39cV66NO0K
X-Google-Smtp-Source: ABdhPJxZlqhHNqJOoQiUnpe6tB2RftvFWAMfbBp3jrhvrzhir3ihmFoH0KXfKd3PoiDA0bWx3H5T09kA2WsuydwWt8n/etV6A5nj
MIME-Version: 1.0
X-Received: by 2002:a92:7f11:0:b0:2ca:50f9:63d6 with SMTP id
 a17-20020a927f11000000b002ca50f963d6mr80333ild.150.1650047373728; Fri, 15 Apr
 2022 11:29:33 -0700 (PDT)
Date:   Fri, 15 Apr 2022 11:29:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092e0d405dcb597d4@google.com>
Subject: [syzbot] possible deadlock in blkcg_deactivate_policy
From:   syzbot <syzbot+b9e4c31d0a1efb34cb03@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b9b4c79e5830 Merge tag 'sound-5.18-rc3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118c96ccf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=b9e4c31d0a1efb34cb03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab7a70f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e54770f00000

The issue was bisected to:

commit 0a9a25ca78437b39e691bcc3dc8240455b803d8d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Mar 18 13:01:43 2022 +0000

    block: let blkcg_gq grab request queue's refcnt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128129e0f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=118129e0f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=168129e0f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9e4c31d0a1efb34cb03@syzkaller.appspotmail.com
Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")

RBP: 00007ffcdacd3400 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
======================================================
WARNING: possible circular locking dependency detected
5.18.0-rc2-syzkaller-00122-gb9b4c79e5830 #0 Not tainted
------------------------------------------------------
syz-executor173/3613 is trying to acquire lock:
ffff8880168900a8 ((&sq->pending_timer)){+.-.}-{0:0}, at: del_timer_sync+0x33/0x1b0 kernel/time/timer.c:1363

but task is already holding lock:
ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: blkcg_deactivate_policy block/blk-cgroup.c:1441 [inline]
ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: blkcg_deactivate_policy+0x1e7/0x4e0 block/blk-cgroup.c:1423

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&blkcg->lock){....}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:349 [inline]
       blkg_create+0x47b/0x1030 block/blk-cgroup.c:301
       blkcg_init_queue+0xfe/0x810 block/blk-cgroup.c:1206
       __alloc_disk_node+0x260/0x610 block/genhd.c:1381
       __blk_alloc_disk+0x35/0x70 block/genhd.c:1421
       brd_alloc.part.0+0x27f/0x7a0 drivers/block/brd.c:391
       brd_alloc drivers/block/brd.c:374 [inline]
       brd_init+0x1b8/0x24b drivers/block/brd.c:477
       do_one_initcall+0x103/0x650 init/main.c:1298
       do_initcall_level init/main.c:1371 [inline]
       do_initcalls init/main.c:1387 [inline]
       do_basic_setup init/main.c:1406 [inline]
       kernel_init_freeable+0x6b1/0x73a init/main.c:1613
       kernel_init+0x1a/0x1d0 init/main.c:1502
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

-> #1 (&q->queue_lock){..-.}-{2:2}:
       __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
       _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
       spin_lock_irq include/linux/spinlock.h:374 [inline]
       throtl_pending_timer_fn+0xf7/0x1690 block/blk-throttle.c:1152
       call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
       expire_timers kernel/time/timer.c:1466 [inline]
       __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
       __run_timers kernel/time/timer.c:1715 [inline]
       run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
       __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
       invoke_softirq kernel/softirq.c:432 [inline]
       __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
       irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
       sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
       asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
       native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
       acpi_safe_halt drivers/acpi/processor_idle.c:115 [inline]
       acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
       acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:691
       cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
       cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
       call_cpuidle kernel/sched/idle.c:155 [inline]
       cpuidle_idle_call kernel/sched/idle.c:236 [inline]
       do_idle+0x3e8/0x590 kernel/sched/idle.c:303
       cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
       start_secondary+0x265/0x340 arch/x86/kernel/smpboot.c:266
       secondary_startup_64_no_verify+0xc3/0xcb

-> #0 ((&sq->pending_timer)){+.-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3065 [inline]
       check_prevs_add kernel/locking/lockdep.c:3188 [inline]
       validate_chain kernel/locking/lockdep.c:3803 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
       lock_acquire kernel/locking/lockdep.c:5641 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
       del_timer_sync+0x5b/0x1b0 kernel/time/timer.c:1364
       throtl_pd_free+0x15/0x40 block/blk-throttle.c:500
       blkcg_deactivate_policy block/blk-cgroup.c:1445 [inline]
       blkcg_deactivate_policy+0x2d2/0x4e0 block/blk-cgroup.c:1423
       blk_throtl_exit+0x8a/0x1a0 block/blk-throttle.c:2335
       blkcg_init_queue+0x225/0x810 block/blk-cgroup.c:1226
       __alloc_disk_node+0x260/0x610 block/genhd.c:1381
       __blk_mq_alloc_disk+0x133/0x1c0 block/blk-mq.c:3930
       loop_add+0x33d/0x910 drivers/block/loop.c:2012
       loop_control_ioctl+0x130/0x4d0 drivers/block/loop.c:2186
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (&sq->pending_timer) --> &q->queue_lock --> &blkcg->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&blkcg->lock);
                               lock(&q->queue_lock);
                               lock(&blkcg->lock);
  lock((&sq->pending_timer));

 *** DEADLOCK ***

2 locks held by syz-executor173/3613:
 #0: ffff88801dd168e0 (&q->queue_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
 #0: ffff88801dd168e0 (&q->queue_lock){..-.}-{2:2}, at: blkcg_deactivate_policy block/blk-cgroup.c:1434 [inline]
 #0: ffff88801dd168e0 (&q->queue_lock){..-.}-{2:2}, at: blkcg_deactivate_policy+0xfe/0x4e0 block/blk-cgroup.c:1423
 #1: ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: blkcg_deactivate_policy block/blk-cgroup.c:1441 [inline]
 #1: ffffffff9070b710 (&blkcg->lock){....}-{2:2}, at: blkcg_deactivate_policy+0x1e7/0x4e0 block/blk-cgroup.c:1423

stack backtrace:
CPU: 1 PID: 3613 Comm: syz-executor173 Not tainted 5.18.0-rc2-syzkaller-00122-gb9b4c79e5830 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2145
 check_prev_add kernel/locking/lockdep.c:3065 [inline]
 check_prevs_add kernel/locking/lockdep.c:3188 [inline]
 validate_chain kernel/locking/lockdep.c:3803 [inline]
 __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 del_timer_sync+0x5b/0x1b0 kernel/time/timer.c:1364
 throtl_pd_free+0x15/0x40 block/blk-throttle.c:500
 blkcg_deactivate_policy block/blk-cgroup.c:1445 [inline]
 blkcg_deactivate_policy+0x2d2/0x4e0 block/blk-cgroup.c:1423
 blk_throtl_exit+0x8a/0x1a0 block/blk-throttle.c:2335
 blkcg_init_queue+0x225/0x810 block/blk-cgroup.c:1226
 __alloc_disk_node+0x260/0x610 block/genhd.c:1381
 __blk_mq_alloc_disk+0x133/0x1c0 block/blk-mq.c:3930
 loop_add+0x33d/0x910 drivers/block/loop.c:2012
 loop_control_ioctl+0x130/0x4d0 drivers/block/loop.c:2186
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fde66153079
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdacd33e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fde66153079
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007ffcdacd3400 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
