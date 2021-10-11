Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B6428C5A
	for <lists+cgroups@lfdr.de>; Mon, 11 Oct 2021 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhJKLvW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Mon, 11 Oct 2021 07:51:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:44790 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhJKLvU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 07:51:20 -0400
Received: by mail-il1-f200.google.com with SMTP id i11-20020a92540b000000b0025456903645so9866753ilb.11
        for <cgroups@vger.kernel.org>; Mon, 11 Oct 2021 04:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=TnEitHNzdA9HsooGUO748c/vR4kBUtuiJ/0q2LO2DIw=;
        b=cRtAF/F6NFDH5lqr2u3qpdeyE8LL6DRKEcxb1TKNpawpijnq35SZbDKxOWt3QwZ0VX
         4ItPVNV4UMkzfQ/3Hn9/ItaBXDpAXx7qBpe7WYfaFeX4HzYt/3TX5FX50E7CKY8nSPls
         bFAMrw+XxdHixQKrzp6UoG1OxFC5W1rSiSQQnqFJZYmdD9Co8TrPD/Jeqh+o9vGBS8D6
         WEKHxgJtg7yoJLLgAmYwRNgXJOsbjhg4ddLy/0Z8rySWYLm92DJOvXLSfHPgv0kdGt9P
         fVtzaNkgf24VuAidPQmmDHcm96tc9/axHEnpGyK/S1s0z8NXWQBuon3iMUbpEETE5GFF
         Oodg==
X-Gm-Message-State: AOAM533lzlYK7pn+x4ACS3c+Mqy15auz2m5v3NdXq6ZGm/Ei0mx+vexZ
        uJV7Jx/sbi18wehzWsgxTd6071GZf2y5DtCxdnrAHWxPQ7CB
X-Google-Smtp-Source: ABdhPJx9z3ElWhuCq5L6gnAUMHMflf8yH6Ho9Whsj2KtnirfUlfzVnTQqCFp2Sbf6ALEmf44t5F+tnGvHpWw16uP4F9ZaCExtIFA
MIME-Version: 1.0
X-Received: by 2002:a02:6027:: with SMTP id i39mr18025369jac.91.1633952960208;
 Mon, 11 Oct 2021 04:49:20 -0700 (PDT)
Date:   Mon, 11 Oct 2021 04:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5e69805ce12519c@google.com>
Subject: [syzbot] possible deadlock in cgroup_rstat_updated
From:   syzbot <syzbot+9738c8815b375ce482a1@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d32c14b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a845d34d07474
dashboard link: https://syzkaller.appspot.com/bug?extid=9738c8815b375ce482a1
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9738c8815b375ce482a1@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.12.0-rc3-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/4395 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ff78b3ec
 (
&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq
){+.+.}-{0:0}, at: cgroup_rstat_flush_locked+0x424/0x624 kernel/cgroup/rstat.c:162

and this task is already holding:
ddfc5a0c (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-...}-{2:2}, at: cgroup_rstat_flush_locked+0xa0/0x624 kernel/cgroup/rstat.c:153
which would create a new lock dependency:
 (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-...}-{2:2} -> (&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq){+.+.}-{0:0}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-...}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
  lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x54/0x70 kernel/locking/spinlock.c:159
  cgroup_rstat_updated+0x54/0xac kernel/cgroup/rstat.c:46
  cgroup_base_stat_cputime_account_end+0x40/0x74 kernel/cgroup/rstat.c:354
  __cgroup_account_cputime_field+0x54/0x70 kernel/cgroup/rstat.c:388
  cgroup_account_cputime_field include/linux/cgroup.h:799 [inline]
  task_group_account_field+0x100/0x210 kernel/sched/cputime.c:110
  account_system_index_time+0x88/0x94 kernel/sched/cputime.c:173
  irqtime_account_process_tick+0x388/0x3b4 kernel/sched/cputime.c:390
  account_process_tick+0x1ac/0x1f8 kernel/sched/cputime.c:477
  update_process_times+0x64/0xcc kernel/time/timer.c:1794
  tick_sched_handle kernel/time/tick-sched.c:226 [inline]
  tick_sched_timer+0x84/0x3f4 kernel/time/tick-sched.c:1369
  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
  __hrtimer_run_queues+0x294/0x690 kernel/time/hrtimer.c:1601
  hrtimer_interrupt+0x14c/0x2e0 kernel/time/hrtimer.c:1663
  timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
  arch_timer_handler_virt+0x30/0x38 drivers/clocksource/arm_arch_timer.c:658
  handle_percpu_devid_irq+0xa4/0x19c kernel/irq/chip.c:930
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  generic_handle_irq kernel/irq/irqdesc.c:652 [inline]
  __handle_domain_irq+0xb0/0x120 kernel/irq/irqdesc.c:689
  handle_domain_irq include/linux/irqdesc.h:176 [inline]
  gic_handle_irq+0x84/0xac drivers/irqchip/irq-gic.c:370
  __irq_svc+0x5c/0x94 arch/arm/kernel/entry-armv.S:205
  arch_local_irq_enable arch/arm/include/asm/irqflags.h:39 [inline]
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
  _raw_spin_unlock_irq+0x2c/0x60 kernel/locking/spinlock.c:199
  spin_unlock_irq include/linux/spinlock.h:404 [inline]
  cgroup_migrate_execute+0x250/0x4b8 kernel/cgroup/cgroup.c:2434
  cgroup_migrate+0xec/0x15c kernel/cgroup/cgroup.c:2703
  cgroup_attach_task+0x224/0x520 kernel/cgroup/cgroup.c:2736
  __cgroup_procs_write+0xf0/0x1f0 kernel/cgroup/cgroup.c:4759
  cgroup_procs_write+0x18/0x24 kernel/cgroup/cgroup.c:4772
  cgroup_file_write+0xa4/0x26c kernel/cgroup/cgroup.c:3698
  kernfs_fop_write_iter+0x128/0x1ec fs/kernfs/file.c:296
  call_write_iter include/linux/fs.h:1977 [inline]
  new_sync_write fs/read_write.c:518 [inline]
  vfs_write+0x260/0x350 fs/read_write.c:605
  ksys_write+0x68/0xec fs/read_write.c:658
  __do_sys_write fs/read_write.c:670 [inline]
  sys_write+0x10/0x14 fs/read_write.c:667
  ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
  0x7e93d100

to a HARDIRQ-irq-unsafe lock:
 (&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq){+.+.}-{0:0}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
  lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
  do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
  do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
  u64_stats_update_begin include/linux/u64_stats_sync.h:129 [inline]
  blk_cgroup_bio_start+0x9c/0x174 block/blk-cgroup.c:1913
  submit_bio_checks+0x200/0xad0 block/blk-core.c:893
  submit_bio_noacct+0x28/0x3fc block/blk-core.c:1032
  submit_bio+0x58/0x21c block/blk-core.c:1118
  submit_bh_wbc+0x188/0x1b8 fs/buffer.c:3055
  submit_bh fs/buffer.c:3061 [inline]
  block_read_full_page+0x520/0x624 fs/buffer.c:2340
  blkdev_readpage+0x1c/0x20 fs/block_dev.c:640
  do_read_cache_page+0x258/0x52c mm/filemap.c:3263
  read_cache_page+0x1c/0x24 mm/filemap.c:3362
  read_mapping_page include/linux/pagemap.h:500 [inline]
  read_part_sector+0x100/0x23c block/partitions/core.c:673
  read_lba+0xb4/0x174 block/partitions/efi.c:250
  find_valid_gpt block/partitions/efi.c:603 [inline]
  efi_partition+0x154/0xb5c block/partitions/efi.c:710
  check_partition block/partitions/core.c:148 [inline]
  blk_add_partitions+0x148/0x82c block/partitions/core.c:610
  bdev_disk_changed+0x13c/0x224 fs/block_dev.c:1268
  __blkdev_get+0x2b0/0x334 fs/block_dev.c:1315
  blkdev_get_by_dev fs/block_dev.c:1454 [inline]
  blkdev_get_by_dev+0x128/0x238 fs/block_dev.c:1422
  disk_scan_partitions block/genhd.c:493 [inline]
  register_disk block/genhd.c:540 [inline]
  __device_add_disk+0x4e8/0x698 block/genhd.c:621
  device_add_disk+0x14/0x18 block/genhd.c:639
  add_disk include/linux/genhd.h:231 [inline]
  brd_init+0x148/0x1e0 drivers/block/brd.c:514
  do_one_initcall+0x8c/0x59c init/main.c:1226
  do_initcall_level init/main.c:1299 [inline]
  do_initcalls init/main.c:1315 [inline]
  do_basic_setup init/main.c:1335 [inline]
  kernel_init_freeable+0x2cc/0x330 init/main.c:1537
  kernel_init+0x10/0x120 init/main.c:1424
  ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
  0x0

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq);
                               local_irq_disable();
                               lock(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
                               lock(&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq);
  <Interrupt>
    lock(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));

 *** DEADLOCK ***

8 locks held by syz-executor.0/4395:
 #0: 859646c4 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x50/0x58 fs/file.c:961
 #1: 857cd170 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x4c/0x5a8 fs/seq_file.c:179
 #2: 86bb1a48 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x24/0xb4 fs/kernfs/file.c:112
 #3: 86ad7dd8 (kn->active#57){.+.+}-{0:0}, at: kernfs_seq_start+0x2c/0xb4 fs/kernfs/file.c:113
 #4: 82b10604 (cgroup_rstat_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
 #4: 82b10604 (cgroup_rstat_lock){....}-{2:2}, at: cgroup_rstat_flush_hold kernel/cgroup/rstat.c:228 [inline]
 #4: 82b10604 (cgroup_rstat_lock){....}-{2:2}, at: cgroup_base_stat_cputime_show+0x5c/0x1c4 kernel/cgroup/rstat.c:436
 #5: ddfc5a0c (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-...}-{2:2}, at: cgroup_rstat_flush_locked+0xa0/0x624 kernel/cgroup/rstat.c:153
 #6: 82b09c5c (rcu_read_lock){....}-{1:2}, at: cgroup_base_stat_add kernel/cgroup/rstat.c:301 [inline]
 #6: 82b09c5c (rcu_read_lock){....}-{1:2}, at: cgroup_base_stat_flush kernel/cgroup/rstat.c:336 [inline]
 #6: 82b09c5c (rcu_read_lock){....}-{1:2}, at: cgroup_rstat_flush_locked+0x3b4/0x624 kernel/cgroup/rstat.c:157
 #7: 82b09c5c (rcu_read_lock){....}-{1:2}, at: blkcg_rstat_flush+0x0/0x61c block/blk-cgroup.c:946

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-...}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                    lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x54/0x70 kernel/locking/spinlock.c:159
                    cgroup_rstat_updated+0x54/0xac kernel/cgroup/rstat.c:46
                    cgroup_base_stat_cputime_account_end+0x40/0x74 kernel/cgroup/rstat.c:354
                    __cgroup_account_cputime_field+0x54/0x70 kernel/cgroup/rstat.c:388
                    cgroup_account_cputime_field include/linux/cgroup.h:799 [inline]
                    task_group_account_field+0x100/0x210 kernel/sched/cputime.c:110
                    account_system_index_time+0x88/0x94 kernel/sched/cputime.c:173
                    irqtime_account_process_tick+0x388/0x3b4 kernel/sched/cputime.c:390
                    account_process_tick+0x1ac/0x1f8 kernel/sched/cputime.c:477
                    update_process_times+0x64/0xcc kernel/time/timer.c:1794
                    tick_sched_handle kernel/time/tick-sched.c:226 [inline]
                    tick_sched_timer+0x84/0x3f4 kernel/time/tick-sched.c:1369
                    __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
                    __hrtimer_run_queues+0x294/0x690 kernel/time/hrtimer.c:1601
                    hrtimer_interrupt+0x14c/0x2e0 kernel/time/hrtimer.c:1663
                    timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
                    arch_timer_handler_virt+0x30/0x38 drivers/clocksource/arm_arch_timer.c:658
                    handle_percpu_devid_irq+0xa4/0x19c kernel/irq/chip.c:930
                    generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                    generic_handle_irq kernel/irq/irqdesc.c:652 [inline]
                    __handle_domain_irq+0xb0/0x120 kernel/irq/irqdesc.c:689
                    handle_domain_irq include/linux/irqdesc.h:176 [inline]
                    gic_handle_irq+0x84/0xac drivers/irqchip/irq-gic.c:370
                    __irq_svc+0x5c/0x94 arch/arm/kernel/entry-armv.S:205
                    arch_local_irq_enable arch/arm/include/asm/irqflags.h:39 [inline]
                    __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
                    _raw_spin_unlock_irq+0x2c/0x60 kernel/locking/spinlock.c:199
                    spin_unlock_irq include/linux/spinlock.h:404 [inline]
                    cgroup_migrate_execute+0x250/0x4b8 kernel/cgroup/cgroup.c:2434
                    cgroup_migrate+0xec/0x15c kernel/cgroup/cgroup.c:2703
                    cgroup_attach_task+0x224/0x520 kernel/cgroup/cgroup.c:2736
                    __cgroup_procs_write+0xf0/0x1f0 kernel/cgroup/cgroup.c:4759
                    cgroup_procs_write+0x18/0x24 kernel/cgroup/cgroup.c:4772
                    cgroup_file_write+0xa4/0x26c kernel/cgroup/cgroup.c:3698
                    kernfs_fop_write_iter+0x128/0x1ec fs/kernfs/file.c:296
                    call_write_iter include/linux/fs.h:1977 [inline]
                    new_sync_write fs/read_write.c:518 [inline]
                    vfs_write+0x260/0x350 fs/read_write.c:605
                    ksys_write+0x68/0xec fs/read_write.c:658
                    __do_sys_write fs/read_write.c:670 [inline]
                    sys_write+0x10/0x14 fs/read_write.c:667
                    ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
                    0x7e93d100
   INITIAL USE at:
                   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x54/0x70 kernel/locking/spinlock.c:159
                   cgroup_rstat_updated+0x54/0xac kernel/cgroup/rstat.c:46
                   cgroup_base_stat_cputime_account_end+0x40/0x74 kernel/cgroup/rstat.c:354
                   __cgroup_account_cputime_field+0x54/0x70 kernel/cgroup/rstat.c:388
                   cgroup_account_cputime_field include/linux/cgroup.h:799 [inline]
                   task_group_account_field+0x100/0x210 kernel/sched/cputime.c:110
                   account_system_index_time+0x88/0x94 kernel/sched/cputime.c:173
                   irqtime_account_process_tick+0x388/0x3b4 kernel/sched/cputime.c:390
                   account_process_tick+0x1ac/0x1f8 kernel/sched/cputime.c:477
                   update_process_times+0x64/0xcc kernel/time/timer.c:1794
                   tick_sched_handle kernel/time/tick-sched.c:226 [inline]
                   tick_sched_timer+0x84/0x3f4 kernel/time/tick-sched.c:1369
                   __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
                   __hrtimer_run_queues+0x294/0x690 kernel/time/hrtimer.c:1601
                   hrtimer_interrupt+0x14c/0x2e0 kernel/time/hrtimer.c:1663
                   timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
                   arch_timer_handler_virt+0x30/0x38 drivers/clocksource/arm_arch_timer.c:658
                   handle_percpu_devid_irq+0xa4/0x19c kernel/irq/chip.c:930
                   generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                   generic_handle_irq kernel/irq/irqdesc.c:652 [inline]
                   __handle_domain_irq+0xb0/0x120 kernel/irq/irqdesc.c:689
                   handle_domain_irq include/linux/irqdesc.h:176 [inline]
                   gic_handle_irq+0x84/0xac drivers/irqchip/irq-gic.c:370
                   __irq_svc+0x5c/0x94 arch/arm/kernel/entry-armv.S:205
                   arch_local_irq_enable arch/arm/include/asm/irqflags.h:39 [inline]
                   __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
                   _raw_spin_unlock_irq+0x2c/0x60 kernel/locking/spinlock.c:199
                   spin_unlock_irq include/linux/spinlock.h:404 [inline]
                   cgroup_migrate_execute+0x250/0x4b8 kernel/cgroup/cgroup.c:2434
                   cgroup_migrate+0xec/0x15c kernel/cgroup/cgroup.c:2703
                   cgroup_attach_task+0x224/0x520 kernel/cgroup/cgroup.c:2736
                   __cgroup_procs_write+0xf0/0x1f0 kernel/cgroup/cgroup.c:4759
                   cgroup_procs_write+0x18/0x24 kernel/cgroup/cgroup.c:4772
                   cgroup_file_write+0xa4/0x26c kernel/cgroup/cgroup.c:3698
                   kernfs_fop_write_iter+0x128/0x1ec fs/kernfs/file.c:296
                   call_write_iter include/linux/fs.h:1977 [inline]
                   new_sync_write fs/read_write.c:518 [inline]
                   vfs_write+0x260/0x350 fs/read_write.c:605
                   ksys_write+0x68/0xec fs/read_write.c:658
                   __do_sys_write fs/read_write.c:670 [inline]
                   sys_write+0x10/0x14 fs/read_write.c:667
                   ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
                   0x7e93d100
 }
 ... key      at: [<832bcebc>] __key.0+0x0/0x8
 ... acquired at:
   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
   seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline]
   __u64_stats_fetch_begin include/linux/u64_stats_sync.h:165 [inline]
   u64_stats_fetch_begin include/linux/u64_stats_sync.h:176 [inline]
   blkcg_rstat_flush+0xfc/0x61c block/blk-cgroup.c:777
   cgroup_rstat_flush_locked+0x424/0x624 kernel/cgroup/rstat.c:162
   cgroup_rstat_flush_hold kernel/cgroup/rstat.c:229 [inline]
   cgroup_base_stat_cputime_show+0x68/0x1c4 kernel/cgroup/rstat.c:436
   cpu_stat_show+0x48/0x4b4 kernel/cgroup/cgroup.c:3532
   cgroup_seqfile_show+0x50/0xc4 kernel/cgroup/cgroup.c:3759
   kernfs_seq_show+0x2c/0x30 fs/kernfs/file.c:168
   seq_read_iter+0x1c4/0x5a8 fs/seq_file.c:227
   kernfs_fop_read_iter+0x138/0x1a8 fs/kernfs/file.c:241
   call_read_iter include/linux/fs.h:1971 [inline]
   new_sync_read fs/read_write.c:415 [inline]
   vfs_read+0x214/0x33c fs/read_write.c:496
   ksys_read+0x68/0xec fs/read_write.c:634
   __do_sys_read fs/read_write.c:644 [inline]
   sys_read+0x10/0x14 fs/read_write.c:642
   ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
   0x76ff0038


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&(&({ do { const void *__vpp_verify = (typeof((blkg->iostat_cpu) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ unsigned long __ptr; __asm__ ("" : "=r"(__ptr) : "0"((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))); (typeof((typeof(*((blkg->iostat_cpu))) *)((blkg->iostat_cpu)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->sync)->seq){+.+.}-{0:0} {
   HARDIRQ-ON-W at:
                    lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                    lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                    do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
                    u64_stats_update_begin include/linux/u64_stats_sync.h:129 [inline]
                    blk_cgroup_bio_start+0x9c/0x174 block/blk-cgroup.c:1913
                    submit_bio_checks+0x200/0xad0 block/blk-core.c:893
                    submit_bio_noacct+0x28/0x3fc block/blk-core.c:1032
                    submit_bio+0x58/0x21c block/blk-core.c:1118
                    submit_bh_wbc+0x188/0x1b8 fs/buffer.c:3055
                    submit_bh fs/buffer.c:3061 [inline]
                    block_read_full_page+0x520/0x624 fs/buffer.c:2340
                    blkdev_readpage+0x1c/0x20 fs/block_dev.c:640
                    do_read_cache_page+0x258/0x52c mm/filemap.c:3263
                    read_cache_page+0x1c/0x24 mm/filemap.c:3362
                    read_mapping_page include/linux/pagemap.h:500 [inline]
                    read_part_sector+0x100/0x23c block/partitions/core.c:673
                    read_lba+0xb4/0x174 block/partitions/efi.c:250
                    find_valid_gpt block/partitions/efi.c:603 [inline]
                    efi_partition+0x154/0xb5c block/partitions/efi.c:710
                    check_partition block/partitions/core.c:148 [inline]
                    blk_add_partitions+0x148/0x82c block/partitions/core.c:610
                    bdev_disk_changed+0x13c/0x224 fs/block_dev.c:1268
                    __blkdev_get+0x2b0/0x334 fs/block_dev.c:1315
                    blkdev_get_by_dev fs/block_dev.c:1454 [inline]
                    blkdev_get_by_dev+0x128/0x238 fs/block_dev.c:1422
                    disk_scan_partitions block/genhd.c:493 [inline]
                    register_disk block/genhd.c:540 [inline]
                    __device_add_disk+0x4e8/0x698 block/genhd.c:621
                    device_add_disk+0x14/0x18 block/genhd.c:639
                    add_disk include/linux/genhd.h:231 [inline]
                    brd_init+0x148/0x1e0 drivers/block/brd.c:514
                    do_one_initcall+0x8c/0x59c init/main.c:1226
                    do_initcall_level init/main.c:1299 [inline]
                    do_initcalls init/main.c:1315 [inline]
                    do_basic_setup init/main.c:1335 [inline]
                    kernel_init_freeable+0x2cc/0x330 init/main.c:1537
                    kernel_init+0x10/0x120 init/main.c:1424
                    ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
                    0x0
   SOFTIRQ-ON-W at:
                    lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                    lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                    do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
                    u64_stats_update_begin include/linux/u64_stats_sync.h:129 [inline]
                    blk_cgroup_bio_start+0x9c/0x174 block/blk-cgroup.c:1913
                    submit_bio_checks+0x200/0xad0 block/blk-core.c:893
                    submit_bio_noacct+0x28/0x3fc block/blk-core.c:1032
                    submit_bio+0x58/0x21c block/blk-core.c:1118
                    submit_bh_wbc+0x188/0x1b8 fs/buffer.c:3055
                    submit_bh fs/buffer.c:3061 [inline]
                    block_read_full_page+0x520/0x624 fs/buffer.c:2340
                    blkdev_readpage+0x1c/0x20 fs/block_dev.c:640
                    do_read_cache_page+0x258/0x52c mm/filemap.c:3263
                    read_cache_page+0x1c/0x24 mm/filemap.c:3362
                    read_mapping_page include/linux/pagemap.h:500 [inline]
                    read_part_sector+0x100/0x23c block/partitions/core.c:673
                    read_lba+0xb4/0x174 block/partitions/efi.c:250
                    find_valid_gpt block/partitions/efi.c:603 [inline]
                    efi_partition+0x154/0xb5c block/partitions/efi.c:710
                    check_partition block/partitions/core.c:148 [inline]
                    blk_add_partitions+0x148/0x82c block/partitions/core.c:610
                    bdev_disk_changed+0x13c/0x224 fs/block_dev.c:1268
                    __blkdev_get+0x2b0/0x334 fs/block_dev.c:1315
                    blkdev_get_by_dev fs/block_dev.c:1454 [inline]
                    blkdev_get_by_dev+0x128/0x238 fs/block_dev.c:1422
                    disk_scan_partitions block/genhd.c:493 [inline]
                    register_disk block/genhd.c:540 [inline]
                    __device_add_disk+0x4e8/0x698 block/genhd.c:621
                    device_add_disk+0x14/0x18 block/genhd.c:639
                    add_disk include/linux/genhd.h:231 [inline]
                    brd_init+0x148/0x1e0 drivers/block/brd.c:514
                    do_one_initcall+0x8c/0x59c init/main.c:1226
                    do_initcall_level init/main.c:1299 [inline]
                    do_initcalls init/main.c:1315 [inline]
                    do_basic_setup init/main.c:1335 [inline]
                    kernel_init_freeable+0x2cc/0x330 init/main.c:1537
                    kernel_init+0x10/0x120 init/main.c:1424
                    ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
                    0x0
   INITIAL USE at:
                   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                   do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
                   do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
                   u64_stats_update_begin include/linux/u64_stats_sync.h:129 [inline]
                   blk_cgroup_bio_start+0x9c/0x174 block/blk-cgroup.c:1913
                   submit_bio_checks+0x200/0xad0 block/blk-core.c:893
                   submit_bio_noacct+0x28/0x3fc block/blk-core.c:1032
                   submit_bio+0x58/0x21c block/blk-core.c:1118
                   submit_bh_wbc+0x188/0x1b8 fs/buffer.c:3055
                   submit_bh fs/buffer.c:3061 [inline]
                   block_read_full_page+0x520/0x624 fs/buffer.c:2340
                   blkdev_readpage+0x1c/0x20 fs/block_dev.c:640
                   do_read_cache_page+0x258/0x52c mm/filemap.c:3263
                   read_cache_page+0x1c/0x24 mm/filemap.c:3362
                   read_mapping_page include/linux/pagemap.h:500 [inline]
                   read_part_sector+0x100/0x23c block/partitions/core.c:673
                   read_lba+0xb4/0x174 block/partitions/efi.c:250
                   find_valid_gpt block/partitions/efi.c:603 [inline]
                   efi_partition+0x154/0xb5c block/partitions/efi.c:710
                   check_partition block/partitions/core.c:148 [inline]
                   blk_add_partitions+0x148/0x82c block/partitions/core.c:610
                   bdev_disk_changed+0x13c/0x224 fs/block_dev.c:1268
                   __blkdev_get+0x2b0/0x334 fs/block_dev.c:1315
                   blkdev_get_by_dev fs/block_dev.c:1454 [inline]
                   blkdev_get_by_dev+0x128/0x238 fs/block_dev.c:1422
                   disk_scan_partitions block/genhd.c:493 [inline]
                   register_disk block/genhd.c:540 [inline]
                   __device_add_disk+0x4e8/0x698 block/genhd.c:621
                   device_add_disk+0x14/0x18 block/genhd.c:639
                   add_disk include/linux/genhd.h:231 [inline]
                   brd_init+0x148/0x1e0 drivers/block/brd.c:514
                   do_one_initcall+0x8c/0x59c init/main.c:1226
                   do_initcall_level init/main.c:1299 [inline]
                   do_initcalls init/main.c:1315 [inline]
                   do_basic_setup init/main.c:1335 [inline]
                   kernel_init_freeable+0x2cc/0x330 init/main.c:1537
                   kernel_init+0x10/0x120 init/main.c:1424
                   ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
                   0x0
   INITIAL READ USE at:
                        lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
                        lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
                        seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline]
                        __u64_stats_fetch_begin include/linux/u64_stats_sync.h:165 [inline]
                        u64_stats_fetch_begin include/linux/u64_stats_sync.h:176 [inline]
                        blkcg_rstat_flush+0xfc/0x61c block/blk-cgroup.c:777
                        cgroup_rstat_flush_locked+0x424/0x624 kernel/cgroup/rstat.c:162
                        cgroup_rstat_flush_hold kernel/cgroup/rstat.c:229 [inline]
                        cgroup_base_stat_cputime_show+0x68/0x1c4 kernel/cgroup/rstat.c:436
                        cpu_stat_show+0x48/0x4b4 kernel/cgroup/cgroup.c:3532
                        cgroup_seqfile_show+0x50/0xc4 kernel/cgroup/cgroup.c:3759
                        kernfs_seq_show+0x2c/0x30 fs/kernfs/file.c:168
                        seq_read_iter+0x1c4/0x5a8 fs/seq_file.c:227
                        kernfs_fop_read_iter+0x138/0x1a8 fs/kernfs/file.c:241
                        call_read_iter include/linux/fs.h:1971 [inline]
                        new_sync_read fs/read_write.c:415 [inline]
                        vfs_read+0x214/0x33c fs/read_write.c:496
                        ksys_read+0x68/0xec fs/read_write.c:634
                        __do_sys_read fs/read_write.c:644 [inline]
                        sys_read+0x10/0x14 fs/read_write.c:642
                        ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
                        0x76ff0038
 }
 ... key      at: [<832fe198>] __key.3+0x0/0x8
 ... acquired at:
   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
   seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline]
   __u64_stats_fetch_begin include/linux/u64_stats_sync.h:165 [inline]
   u64_stats_fetch_begin include/linux/u64_stats_sync.h:176 [inline]
   blkcg_rstat_flush+0xfc/0x61c block/blk-cgroup.c:777
   cgroup_rstat_flush_locked+0x424/0x624 kernel/cgroup/rstat.c:162
   cgroup_rstat_flush_hold kernel/cgroup/rstat.c:229 [inline]
   cgroup_base_stat_cputime_show+0x68/0x1c4 kernel/cgroup/rstat.c:436
   cpu_stat_show+0x48/0x4b4 kernel/cgroup/cgroup.c:3532
   cgroup_seqfile_show+0x50/0xc4 kernel/cgroup/cgroup.c:3759
   kernfs_seq_show+0x2c/0x30 fs/kernfs/file.c:168
   seq_read_iter+0x1c4/0x5a8 fs/seq_file.c:227
   kernfs_fop_read_iter+0x138/0x1a8 fs/kernfs/file.c:241
   call_read_iter include/linux/fs.h:1971 [inline]
   new_sync_read fs/read_write.c:415 [inline]
   vfs_read+0x214/0x33c fs/read_write.c:496
   ksys_read+0x68/0xec fs/read_write.c:634
   __do_sys_read fs/read_write.c:644 [inline]
   sys_read+0x10/0x14 fs/read_write.c:642
   ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64
   0x76ff0038


stack backtrace:
CPU: 1 PID: 4395 Comm: syz-executor.0 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<81802550>] (dump_backtrace) from [<818027c4>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
 r7:00000080 r6:60000093 r5:00000000 r4:82b58344
[<818027ac>] (show_stack) from [<81809e98>] (__dump_stack lib/dump_stack.c:79 [inline])
[<818027ac>] (show_stack) from [<81809e98>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
[<81809de0>] (dump_stack) from [<802ba4a8>] (print_bad_irq_dependency+0x3e0/0x434 kernel/locking/lockdep.c:2460)
 r7:86a11b38 r6:86a11b1c r5:86d26180 r4:830ee2f8
[<802ba0c8>] (print_bad_irq_dependency) from [<802bd780>] (check_irq_usage kernel/locking/lockdep.c:2689 [inline])
[<802ba0c8>] (print_bad_irq_dependency) from [<802bd780>] (check_prev_add kernel/locking/lockdep.c:2940 [inline])
[<802ba0c8>] (print_bad_irq_dependency) from [<802bd780>] (check_prevs_add kernel/locking/lockdep.c:3059 [inline])
[<802ba0c8>] (print_bad_irq_dependency) from [<802bd780>] (validate_chain kernel/locking/lockdep.c:3674 [inline])
[<802ba0c8>] (print_bad_irq_dependency) from [<802bd780>] (__lock_acquire+0x1af8/0x3318 kernel/locking/lockdep.c:4900)
 r10:86d26908 r9:86d26180 r8:81f47d20 r7:83278fe8 r6:81f4cd38 r5:86d268a8
 r4:86d268a8
[<802bbc88>] (__lock_acquire) from [<802bfb90>] (lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510)
 r10:00000080 r9:60000093 r8:00000000 r7:00000000 r6:828a2680 r5:828a2680
 r4:86a11b88
[<802bfaa0>] (lock_acquire.part.0) from [<802bff28>] (lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483)
 r10:803432fc r9:00000000 r8:00000001 r7:00000002 r6:00000000 r5:00000000
 r4:ff78b3ec
[<802bfebc>] (lock_acquire) from [<807bf6f0>] (seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline])
[<802bfebc>] (lock_acquire) from [<807bf6f0>] (__u64_stats_fetch_begin include/linux/u64_stats_sync.h:165 [inline])
[<802bfebc>] (lock_acquire) from [<807bf6f0>] (u64_stats_fetch_begin include/linux/u64_stats_sync.h:176 [inline])
[<802bfebc>] (lock_acquire) from [<807bf6f0>] (blkcg_rstat_flush+0xfc/0x61c block/blk-cgroup.c:777)
 r10:86c26e00 r9:a0000093 r8:00000001 r7:ff78b3ec r6:ff78b400 r5:ff78b418
 r4:ff78b3e8
[<807bf5f4>] (blkcg_rstat_flush) from [<803432fc>] (cgroup_rstat_flush_locked+0x424/0x624 kernel/cgroup/rstat.c:162)
 r10:86b24000 r9:82a22928 r8:00000000 r7:82b0e4c8 r6:86bd8c00 r5:86b241d4
 r4:86b24000
[<80342ed8>] (cgroup_rstat_flush_locked) from [<80343a18>] (cgroup_rstat_flush_hold kernel/cgroup/rstat.c:229 [inline])
[<80342ed8>] (cgroup_rstat_flush_locked) from [<80343a18>] (cgroup_base_stat_cputime_show+0x68/0x1c4 kernel/cgroup/rstat.c:436)
 r10:00000001 r9:00400cc0 r8:857cd110 r7:857cd128 r6:85964640 r5:857cd110
 r4:86b24000
[<803439b0>] (cgroup_base_stat_cputime_show) from [<80337e68>] (cpu_stat_show+0x48/0x4b4 kernel/cgroup/cgroup.c:3532)
 r9:00400cc0 r8:86a11f08 r7:857cd128 r6:85964640 r5:857cd110 r4:86b24000
[<80337e20>] (cpu_stat_show) from [<80336224>] (cgroup_seqfile_show+0x50/0xc4 kernel/cgroup/cgroup.c:3759)
 r8:86a11f08 r7:857cd128 r6:85964640 r5:857cd110 r4:80337e20
[<803361d4>] (cgroup_seqfile_show) from [<805ba62c>] (kernfs_seq_show+0x2c/0x30 fs/kernfs/file.c:168)
 r7:857cd128 r6:85964640 r5:00000000 r4:857cd110
[<805ba600>] (kernfs_seq_show) from [<8050f06c>] (seq_read_iter+0x1c4/0x5a8 fs/seq_file.c:227)
[<8050eea8>] (seq_read_iter) from [<805bab68>] (kernfs_fop_read_iter+0x138/0x1a8 fs/kernfs/file.c:241)
 r10:00000000 r9:86a11f68 r8:00000000 r7:86a11ef0 r6:85964640 r5:86a11f08
 r4:86bb1a00
[<805baa30>] (kernfs_fop_read_iter) from [<804da704>] (call_read_iter include/linux/fs.h:1971 [inline])
[<805baa30>] (kernfs_fop_read_iter) from [<804da704>] (new_sync_read fs/read_write.c:415 [inline])
[<805baa30>] (kernfs_fop_read_iter) from [<804da704>] (vfs_read+0x214/0x33c fs/read_write.c:496)
 r10:00000000 r9:86a11f68 r8:00000000 r7:00000000 r6:85964640 r5:00000000
 r4:00000051
[<804da4f0>] (vfs_read) from [<804dabe4>] (ksys_read+0x68/0xec fs/read_write.c:634)
 r10:00000003 r9:86a10000 r8:80200224 r7:00000000 r6:00000000 r5:85964640
 r4:85964643
[<804dab7c>] (ksys_read) from [<804dac78>] (__do_sys_read fs/read_write.c:644 [inline])
[<804dab7c>] (ksys_read) from [<804dac78>] (sys_read+0x10/0x14 fs/read_write.c:642)
 r7:00000003 r6:ffffffff r5:00000000 r4:00000000
[<804dac68>] (sys_read) from [<80200060>] (ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64)
Exception stack(0x86a11fa8 to 0x86a11ff0)
1fa0:                   00000000 00000000 00000004 200000c0 00000051 00000000
1fc0: 00000000 00000000 ffffffff 00000003 7e93d32a 76ff06d0 7e93d4b4 76ff020c
1fe0: 76ff0048 76ff0038 00018d54 0004b8b0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
