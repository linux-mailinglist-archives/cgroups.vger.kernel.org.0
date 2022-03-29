Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E074EB529
	for <lists+cgroups@lfdr.de>; Tue, 29 Mar 2022 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiC2VZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiC2VZD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 17:25:03 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D32D7631
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 14:23:18 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so10340365ilg.8
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 14:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=onxiv9eHFSnq69oH3p2EnpdblLTp3Le4jjM3vkXK8Ek=;
        b=5OD6P74hq4GE18GUU7ZBmf1eZBN7nM5mBZ2tuN1g5dtsZzQoU/Kep2Ym98AYeh65Vx
         /O/LYictvCZebXo5mEGFhH5aRsCMfw2iVPKeHDZVVidar9swkooXaCOHqYkQIZMGCWEa
         +TrJRvVS6lxRyZOMAr3Un0N57oFKZCxBh5L5B/JCqnrzNOComb2RxSVcCluwCiryL2W+
         19QZ1MnLVZdTOR7NDVNRW6i/lo3zsoeQQUj1yJcyViVQI0Qbqj22Uuw+v+miHcthe3oG
         lFN0sRFkswb2yfXq9RrWKrwyLuftFGnoplcetA5DVjKPu9nvJ1+3j54z6RILYnHcWEYb
         +P0Q==
X-Gm-Message-State: AOAM533+RN4mxg/OUY8O3MZg7dekPAsSse/0tInxrh5HTbrlqWyyEsDq
        YxQZkzEIAekkfJNEg0xvQ7cTI8h0WSjNIl/4iNHeC9JOYXRv
X-Google-Smtp-Source: ABdhPJwXcZXfl8ac9uiOukx60BjO3UkNr/no8LZWF7lDDwIsHP5u6LZxggOeFtf34zU+zD0QepChtIAeI6HfJFEI1UQl4ZmLgOaA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:338e:b0:321:3495:63e3 with SMTP id
 h14-20020a056638338e00b00321349563e3mr16173277jav.283.1648588997400; Tue, 29
 Mar 2022 14:23:17 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:23:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000921fd405db62096a@google.com>
Subject: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-syzkaller-10734-gcb7cbaae7fd9 #0 Not tainted
------------------------------------------------------
syz-executor.2/3698 is trying to acquire lock:
ffff888014034fc8 (&q->queue_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
ffff888014034fc8 (&q->queue_lock){..-.}-{2:2}, at: throtl_pending_timer_fn+0xf7/0x1690 block/blk-throttle.c:1152

but task is already holding lock:
ffffc900007f8d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:35 [inline]
ffffc900007f8d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1411

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ((&sq->pending_timer)){+.-.}-{0:0}:
       del_timer_sync+0x5b/0x1b0 kernel/time/timer.c:1364
       throtl_pd_free+0x15/0x40 block/blk-throttle.c:500
       blkg_free.part.0+0xb2/0x1f0 block/blk-cgroup.c:83
       blkg_free block/blk-cgroup.c:207 [inline]
       blkg_alloc+0x507/0x690 block/blk-cgroup.c:206
       blkg_create+0xac4/0x1030 block/blk-cgroup.c:262
       blkg_lookup_create block/blk-cgroup.c:370 [inline]
       blkg_tryget_closest block/blk-cgroup.c:1821 [inline]
       bio_associate_blkg_from_css+0xa7a/0xee0 block/blk-cgroup.c:1856
       bio_associate_blkg+0xcd/0x3c0 block/blk-cgroup.c:1884
       bio_init+0x2ae/0x5a0 block/bio.c:272
       bio_alloc_bioset+0x233/0x4e0 block/bio.c:517
       bio_alloc include/linux/bio.h:423 [inline]
       submit_bh_wbc+0x276/0x6b0 fs/buffer.c:3028
       submit_bh fs/buffer.c:3055 [inline]
       block_read_full_page+0xe88/0x18f0 fs/buffer.c:2336
       do_read_cache_folio+0x454/0x760 mm/filemap.c:3515
       do_read_cache_page mm/filemap.c:3594 [inline]
       read_cache_page_gfp+0x27/0x270 mm/filemap.c:3627
       btrfs_read_disk_super fs/btrfs/volumes.c:1296 [inline]
       btrfs_scan_one_device+0x295/0x5f0 fs/btrfs/volumes.c:1365
       btrfs_mount_root+0x4b5/0xc10 fs/btrfs/super.c:1758
       legacy_get_tree+0x105/0x220 fs/fs_context.c:610
       vfs_get_tree+0x89/0x2f0 fs/super.c:1497
       fc_mount fs/namespace.c:1043 [inline]
       vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1073
       vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
       btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1856
       legacy_get_tree+0x105/0x220 fs/fs_context.c:610
       vfs_get_tree+0x89/0x2f0 fs/super.c:1497
       do_new_mount fs/namespace.c:3039 [inline]
       path_mount+0x1320/0x1fa0 fs/namespace.c:3369
       do_mount fs/namespace.c:3382 [inline]
       __do_sys_mount fs/namespace.c:3590 [inline]
       __se_sys_mount fs/namespace.c:3567 [inline]
       __x64_sys_mount+0x27f/0x300 fs/namespace.c:3567
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&q->queue_lock){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3065 [inline]
       check_prevs_add kernel/locking/lockdep.c:3188 [inline]
       validate_chain kernel/locking/lockdep.c:3803 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
       lock_acquire kernel/locking/lockdep.c:5641 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
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
       asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
       lock_is_held_type+0xe/0x140 kernel/locking/lockdep.c:5669
       lock_is_held include/linux/lockdep.h:283 [inline]
       rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
       trace_lock_release include/trace/events/lock.h:58 [inline]
       lock_release+0x522/0x720 kernel/locking/lockdep.c:5652
       rcu_lock_release include/linux/rcupdate.h:273 [inline]
       rcu_read_unlock include/linux/rcupdate.h:727 [inline]
       ext4_get_group_info+0x211/0x3d0 fs/ext4/ext4.h:3369
       ext4_validate_block_bitmap.part.0+0x2c/0xd50 fs/ext4/balloc.c:376
       ext4_validate_block_bitmap fs/ext4/balloc.c:373 [inline]
       ext4_read_block_bitmap_nowait+0xb33/0x1ad0 fs/ext4/balloc.c:509
       ext4_read_block_bitmap+0x1d/0xa0 fs/ext4/balloc.c:550
       ext4_mb_clear_bb fs/ext4/mballoc.c:5928 [inline]
       ext4_free_blocks+0x60e/0x2060 fs/ext4/mballoc.c:6164
       ext4_remove_blocks fs/ext4/extents.c:2538 [inline]
       ext4_ext_rm_leaf fs/ext4/extents.c:2704 [inline]
       ext4_ext_remove_space+0x1f4f/0x4520 fs/ext4/extents.c:2952
       ext4_ext_truncate+0x33f/0x400 fs/ext4/extents.c:4412
       ext4_truncate+0xecc/0x1440 fs/ext4/inode.c:4224
       ext4_evict_inode+0xa73/0x1950 fs/ext4/inode.c:286
       evict+0x2ed/0x6b0 fs/inode.c:664
       iput_final fs/inode.c:1744 [inline]
       iput.part.0+0x562/0x820 fs/inode.c:1770
       iput+0x58/0x70 fs/inode.c:1760
       d_delete_notify include/linux/fsnotify.h:261 [inline]
       vfs_rmdir.part.0+0x496/0x5a0 fs/namei.c:4032
       vfs_rmdir fs/namei.c:4004 [inline]
       do_rmdir+0x3a6/0x430 fs/namei.c:4080
       __do_sys_rmdir fs/namei.c:4099 [inline]
       __se_sys_rmdir fs/namei.c:4097 [inline]
       __x64_sys_rmdir+0xc6/0x110 fs/namei.c:4097
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((&sq->pending_timer));
                               lock(&q->queue_lock);
                               lock((&sq->pending_timer));
  lock(&q->queue_lock);

 *** DEADLOCK ***

7 locks held by syz-executor.2/3698:
 #0: ffff888018e6a460 (sb_writers#5){.+.+}-{0:0}, at: do_rmdir+0x1d0/0x430 fs/namei.c:4063
 #1: ffff8880470a35c0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:813 [inline]
 #1: ffff8880470a35c0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_rmdir+0x21b/0x430 fs/namei.c:4067
 #2: ffff888018e6a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:664
 #3: ffff8880437d8990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14a0 fs/jbd2/transaction.c:461
 #4: ffff88804737f408 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x631/0x1440 fs/ext4/inode.c:4219
 #5: ffffffff8bd7ea60 (rcu_read_lock){....}-{1:2}, at: ext4_get_group_info+0xf2/0x3d0 fs/ext4/ext4.h:3368
 #6: ffffc900007f8d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:35 [inline]
 #6: ffffc900007f8d70 ((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1411

stack backtrace:
CPU: 3 PID: 3698 Comm: syz-executor.2 Not tainted 5.17.0-syzkaller-10734-gcb7cbaae7fd9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2145
 check_prev_add kernel/locking/lockdep.c:3065 [inline]
 check_prevs_add kernel/locking/lockdep.c:3188 [inline]
 validate_chain kernel/locking/lockdep.c:3803 [inline]
 __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
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
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:lock_is_held_type+0xe/0x140 kernel/locking/lockdep.c:5669
Code: 89 44 24 04 e8 33 8d bb ff 0f 0b 8b 44 24 04 eb bd 66 66 2e 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 bd ff ff ff ff 41 54 <55> 53 48 83 ec 08 8b 0d 12 7a 56 04 85 c9 0f 84 d9 00 00 00 65 8b
RSP: 0018:ffffc9000229f540 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000003 RCX: ffffffff815ce081
RDX: 000000000000000f RSI: 00000000ffffffff RDI: ffffffff8bd7e9a0
RBP: 1ffff92000453eb1 R08: 0000000000000000 R09: ffffffff8db49557
R10: fffffbfff1b692aa R11: 0000000000000000 R12: 0000000000000001
R13: 00000000ffffffff R14: 0000000000000001 R15: 0000000000000006
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x522/0x720 kernel/locking/lockdep.c:5652
 rcu_lock_release include/linux/rcupdate.h:273 [inline]
 rcu_read_unlock include/linux/rcupdate.h:727 [inline]
 ext4_get_group_info+0x211/0x3d0 fs/ext4/ext4.h:3369
 ext4_validate_block_bitmap.part.0+0x2c/0xd50 fs/ext4/balloc.c:376
 ext4_validate_block_bitmap fs/ext4/balloc.c:373 [inline]
 ext4_read_block_bitmap_nowait+0xb33/0x1ad0 fs/ext4/balloc.c:509
 ext4_read_block_bitmap+0x1d/0xa0 fs/ext4/balloc.c:550
 ext4_mb_clear_bb fs/ext4/mballoc.c:5928 [inline]
 ext4_free_blocks+0x60e/0x2060 fs/ext4/mballoc.c:6164
 ext4_remove_blocks fs/ext4/extents.c:2538 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2704 [inline]
 ext4_ext_remove_space+0x1f4f/0x4520 fs/ext4/extents.c:2952
 ext4_ext_truncate+0x33f/0x400 fs/ext4/extents.c:4412
 ext4_truncate+0xecc/0x1440 fs/ext4/inode.c:4224
 ext4_evict_inode+0xa73/0x1950 fs/ext4/inode.c:286
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 d_delete_notify include/linux/fsnotify.h:261 [inline]
 vfs_rmdir.part.0+0x496/0x5a0 fs/namei.c:4032
 vfs_rmdir fs/namei.c:4004 [inline]
 do_rmdir+0x3a6/0x430 fs/namei.c:4080
 __do_sys_rmdir fs/namei.c:4099 [inline]
 __se_sys_rmdir fs/namei.c:4097 [inline]
 __x64_sys_rmdir+0xc6/0x110 fs/namei.c:4097
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f93106889b7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc98d5ac78 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f93106889b7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc98d5be00
RBP: 00007ffc98d5ad40 R08: 0000000000000000 R09: 00007ffc98d5ab10
R10: 0000555555c118e3 R11: 0000000000000207 R12: 00007f93106e21ea
R13: 00007ffc98d5be00 R14: 0000555555c11810 R15: 00007ffc98d5be40
 </TASK>
BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4095, name: kworker/u16:5
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 3 PID: 4095 Comm: kworker/u16:5 Not tainted 5.17.0-syzkaller-10734-gcb7cbaae7fd9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9733
 blk_release_queue+0x1f/0x320 block/blk-sysfs.c:766
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x105/0x160 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 do_softirq.part.0+0xde/0x130 kernel/softirq.c:459
 </IRQ>
 <TASK>
 do_softirq kernel/softirq.c:451 [inline]
 __local_bh_enable_ip+0x102/0x120 kernel/softirq.c:383
 pneigh_ifdown_and_unlock net/core/neighbour.c:835 [inline]
 __neigh_ifdown.isra.0+0x15e/0x330 net/core/neighbour.c:387
 neigh_ifdown+0x1b/0x30 net/core/neighbour.c:403
 addrconf_ifdown.isra.0+0x133a/0x16b0 net/ipv6/addrconf.c:3887
 addrconf_notify+0xeb/0x1ba0 net/ipv6/addrconf.c:3662
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:84
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1938
 call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
 call_netdevice_notifiers net/core/dev.c:1990 [inline]
 unregister_netdevice_many+0x92e/0x18a0 net/core/dev.c:10741
 vti6_exit_batch_net+0x3a0/0x670 net/ipv6/ip6_vti.c:1190
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:167
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:594
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 44 24 04          	mov    %eax,0x4(%rsp)
   4:	e8 33 8d bb ff       	callq  0xffbb8d3c
   9:	0f 0b                	ud2
   b:	8b 44 24 04          	mov    0x4(%rsp),%eax
   f:	eb bd                	jmp    0xffffffce
  11:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  18:	00 00 00 00
  1c:	41 57                	push   %r15
  1e:	41 56                	push   %r14
  20:	41 55                	push   %r13
  22:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  28:	41 54                	push   %r12
* 2a:	55                   	push   %rbp <-- trapping instruction
  2b:	53                   	push   %rbx
  2c:	48 83 ec 08          	sub    $0x8,%rsp
  30:	8b 0d 12 7a 56 04    	mov    0x4567a12(%rip),%ecx        # 0x4567a48
  36:	85 c9                	test   %ecx,%ecx
  38:	0f 84 d9 00 00 00    	je     0x117
  3e:	65                   	gs
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
