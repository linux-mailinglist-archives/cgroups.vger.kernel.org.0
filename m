Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA556FF83E
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjEKRR7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjEKRRy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 13:17:54 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEED8A5B
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 10:17:53 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c48b53e16so322479939f.1
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 10:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825472; x=1686417472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8ijAVJR8UtwTEq/33Oyoz1MV1kB3wAS4jrsh1IBdqg=;
        b=kHMPdNu/RHRgsyJhNODMuKhZZuF4J08TarpitljAplIuw/f2R/8ybm9//GU7RL6lLc
         tiMRIXB3CGvDKjPBvTOUFOPgSAqONN5NBUwSRs4tgmIgo2D55k4YVPfDfm04xiPcpAqO
         d7KgqLwjLniJgkDwBGucN8Qx8SvwaQnzhv2I8VQvQHcDKsm9Lzr+xA8HaQwAMlSJE+bT
         sCxoB7mMlFXJa0CRsPi30gpDmRpsqjzoa1525vM8cNZ/q+EPe4yZyFtVt4//dFj50zom
         ijRXX4/+AS8zSJrHxYwPqQpJxJODBsGrPfPM2mVs3jpjABIN2VtQGvxLpKkPT4fKkfo5
         87cw==
X-Gm-Message-State: AC+VfDwF5ltBm4WH0HadNuVh4dMhrs8vYA+w2qNk9iNhPXPXbmknfkxY
        3NsSF5b2MfAa1T2y2fj+IS4b5z6F6T3LK8s0GzSuzve8OvQb51M=
X-Google-Smtp-Source: ACHHUZ7lpdOT6c6OLVumQlVAZJcDX3oJcVLas4fJVyygRyx/wTwgdJ9oIwOudj5BrlUwIhPlCC6CFtRpEuLy2dFgOG+9uhXDTItv
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2481:b0:76c:69f7:9b2 with SMTP id
 g1-20020a056602248100b0076c69f709b2mr3101531ioe.2.1683825472557; Thu, 11 May
 2023 10:17:52 -0700 (PDT)
Date:   Thu, 11 May 2023 10:17:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027e2a105fb6e2bd3@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in freezer_write
From:   syzbot <syzbot+6c9dbef55920042a75f7@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
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

HEAD commit:    950b879b7f02 riscv: Fixup race condition on PG_dcache_clea..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=171f6afa280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecebece1b90c0342
dashboard link: https://syzkaller.appspot.com/bug?extid=6c9dbef55920042a75f7
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/5ab53d394dbf/non_bootable_disk-950b879b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/938475579d6c/vmlinux-950b879b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcf263d8c574/Image-950b879b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c9dbef55920042a75f7@syzkaller.appspotmail.com

523776 pages RAM
0 pages HighMem/MovableOnly
184025 pages reserved
4096 pages cma reserved
======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc1-syzkaller #0 Tainted: G        W         
------------------------------------------------------
syz-executor.0/4635 is trying to acquire lock:
ffffffff8505b470 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x14/0x1c kernel/cpu.c:310

but task is already holding lock:
ffffffff851ad348 (freezer_mutex){+.+.}-{3:3}, at: freezer_change_state kernel/cgroup/legacy_freezer.c:387 [inline]
ffffffff851ad348 (freezer_mutex){+.+.}-{3:3}, at: freezer_write+0xa0/0x866 kernel/cgroup/legacy_freezer.c:426

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (freezer_mutex){+.+.}-{3:3}:
       lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5668
       lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5641
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x114/0xb42 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       freezer_attach+0x96/0x19a kernel/cgroup/legacy_freezer.c:163
       cgroup_migrate_execute+0x818/0xa3a kernel/cgroup/cgroup.c:2621
       cgroup_migrate kernel/cgroup/cgroup.c:2877 [inline]
       cgroup_attach_task+0x418/0x7ac kernel/cgroup/cgroup.c:2910
       __cgroup1_procs_write.constprop.0+0x250/0x2be kernel/cgroup/cgroup-v1.c:523
       cgroup1_procs_write+0x24/0x32 kernel/cgroup/cgroup-v1.c:536
       cgroup_file_write+0x1b2/0x3b8 kernel/cgroup/cgroup.c:4061
       kernfs_fop_write_iter+0x264/0x32e fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2186 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x4a4/0x568 fs/read_write.c:584
       ksys_write+0x10a/0x224 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       sys_write+0x28/0x36 fs/read_write.c:646
       ret_from_syscall+0x0/0x2

-> #1 (cgroup_threadgroup_rwsem){++++}-{0:0}:
       lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5668
       lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5641
       percpu_down_write+0x4e/0x1d4 kernel/locking/percpu-rwsem.c:227
       cgroup_attach_lock kernel/cgroup/cgroup.c:2437 [inline]
       cgroup_procs_write_start+0x12a/0x46c kernel/cgroup/cgroup.c:2939
       __cgroup_procs_write+0xc2/0x3be kernel/cgroup/cgroup.c:5139
       cgroup_procs_write+0x22/0x48 kernel/cgroup/cgroup.c:5175
       cgroup_file_write+0x1b2/0x3b8 kernel/cgroup/cgroup.c:4061
       kernfs_fop_write_iter+0x264/0x32e fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2186 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x4a4/0x568 fs/read_write.c:584
       ksys_write+0x10a/0x224 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       sys_write+0x28/0x36 fs/read_write.c:646
       ret_from_syscall+0x0/0x2

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_noncircular+0x1de/0x1fe kernel/locking/lockdep.c:2177
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x198a/0x347a kernel/locking/lockdep.c:5055
       lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5668
       lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5641
       percpu_down_read.constprop.0+0x40/0x216 include/linux/percpu-rwsem.h:51
       cpus_read_lock+0x14/0x1c kernel/cpu.c:310
       static_key_slow_inc+0x1e/0x6a kernel/jump_label.c:185
       freezer_apply_state+0x156/0x17c kernel/cgroup/legacy_freezer.c:353
       freezer_change_state kernel/cgroup/legacy_freezer.c:398 [inline]
       freezer_write+0x552/0x866 kernel/cgroup/legacy_freezer.c:426
       cgroup_file_write+0x1b2/0x3b8 kernel/cgroup/cgroup.c:4061
       kernfs_fop_write_iter+0x264/0x32e fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2186 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x4a4/0x568 fs/read_write.c:584
       ksys_write+0x10a/0x224 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       sys_write+0x28/0x36 fs/read_write.c:646
       ret_from_syscall+0x0/0x2

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock --> cgroup_threadgroup_rwsem --> freezer_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(freezer_mutex);
                               lock(cgroup_threadgroup_rwsem);
                               lock(freezer_mutex);
  lock(cpu_hotplug_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.0/4635:
 #0: ff6000001455f4e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xc2/0xc4 fs/file.c:1046
 #1: ff6000000fa6a460 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x1e8/0x568 fs/read_write.c:580
 #2: ff60000027486c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1fc/0x32e fs/kernfs/file.c:325
 #3: ff60000014ce31d8 (kn->active#13){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x32e fs/kernfs/file.c:326
 #4: ffffffff851ad348 (freezer_mutex){+.+.}-{3:3}, at: freezer_change_state kernel/cgroup/legacy_freezer.c:387 [inline]
 #4: ffffffff851ad348 (freezer_mutex){+.+.}-{3:3}, at: freezer_write+0xa0/0x866 kernel/cgroup/legacy_freezer.c:426

stack backtrace:
CPU: 0 PID: 4635 Comm: syz-executor.0 Tainted: G        W          6.2.0-rc1-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000b9ea>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff83402b96>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff83442726>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff83442726>] dump_stack_lvl+0xe0/0x14c lib/dump_stack.c:106
[<ffffffff834427ae>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff8012199a>] print_circular_bug+0x370/0x3fa kernel/locking/lockdep.c:2055
[<ffffffff80121c02>] check_noncircular+0x1de/0x1fe kernel/locking/lockdep.c:2177
[<ffffffff80125e68>] check_prev_add kernel/locking/lockdep.c:3097 [inline]
[<ffffffff80125e68>] check_prevs_add kernel/locking/lockdep.c:3216 [inline]
[<ffffffff80125e68>] validate_chain kernel/locking/lockdep.c:3831 [inline]
[<ffffffff80125e68>] __lock_acquire+0x198a/0x347a kernel/locking/lockdep.c:5055
[<ffffffff80128932>] lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5668
[<ffffffff80128bda>] lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5641
[<ffffffff8005b3f6>] percpu_down_read.constprop.0+0x40/0x216 include/linux/percpu-rwsem.h:51
[<ffffffff8005b5e0>] cpus_read_lock+0x14/0x1c kernel/cpu.c:310
[<ffffffff8037974e>] static_key_slow_inc+0x1e/0x6a kernel/jump_label.c:185
[<ffffffff801f863c>] freezer_apply_state+0x156/0x17c kernel/cgroup/legacy_freezer.c:353
[<ffffffff801f912c>] freezer_change_state kernel/cgroup/legacy_freezer.c:398 [inline]
[<ffffffff801f912c>] freezer_write+0x552/0x866 kernel/cgroup/legacy_freezer.c:426
[<ffffffff801d9e1e>] cgroup_file_write+0x1b2/0x3b8 kernel/cgroup/cgroup.c:4061
[<ffffffff806c57c4>] kernfs_fop_write_iter+0x264/0x32e fs/kernfs/file.c:334
[<ffffffff80548b2c>] call_write_iter include/linux/fs.h:2186 [inline]
[<ffffffff80548b2c>] new_sync_write fs/read_write.c:491 [inline]
[<ffffffff80548b2c>] vfs_write+0x4a4/0x568 fs/read_write.c:584
[<ffffffff80548f54>] ksys_write+0x10a/0x224 fs/read_write.c:637
[<ffffffff80549096>] __do_sys_write fs/read_write.c:649 [inline]
[<ffffffff80549096>] sys_write+0x28/0x36 fs/read_write.c:646
[<ffffffff80005ff6>] ret_from_syscall+0x0/0x2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
