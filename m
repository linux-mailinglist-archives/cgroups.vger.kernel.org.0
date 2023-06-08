Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC097285DD
	for <lists+cgroups@lfdr.de>; Thu,  8 Jun 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjFHQ45 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjFHQ44 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 12:56:56 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D02121
        for <cgroups@vger.kernel.org>; Thu,  8 Jun 2023 09:56:55 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77abce06481so67182439f.2
        for <cgroups@vger.kernel.org>; Thu, 08 Jun 2023 09:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243414; x=1688835414;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvkErGDG8q4I6B6SAMHYoXshOeNz/BP52Cqr8deJdX8=;
        b=gr0IQsjTT7YK4iDFO1Iwo9Ec/gCT+M/VUeRRoGrY6bNgpf2OBg/pmWRhFsOZKpJOTE
         Ji8VnlNu9vDcTI09GPjqcSNAoT1iHdak98iFMlOe9MoxwQ+0T4WYnCtDhsyYf4A360xw
         cyrQEwM97UyBEIQtG3n26uQ3j4ZT4BXSbS5Cr7wA9GW12RuOdVHYavcr0ER4Scgbfb91
         FJzhwVv44LjJUeC/+fFdVtAixKhqgEpzZFbzJqiNDv8LHh43xv1bmFmracyTsbzDAFiR
         a9eXZBuUFnK3V7lDXlz9HgaIMw/obKfPCKe9QTD6hAxfSUR2d2NeCpyAKiLpbYDJyX4l
         WFtw==
X-Gm-Message-State: AC+VfDx/4dpf2qu43FSKrh1xORb0NykVXDcv8Kp9c/sG0/I5yn7GRU19
        y2DeXAT0fvh1Nbta2BKW5q5ZH1gOXnZG6qEZEXNfym21ZEFN+wOOwA==
X-Google-Smtp-Source: ACHHUZ7pqid1LP/7VE6xphzDnh55GoUNGvTCEPgbZnslx8JlQQ3kMLckf28gda+yelz3mev7u0hUNroQZqukfaBul7yxXiSgMhhb
MIME-Version: 1.0
X-Received: by 2002:a02:a14c:0:b0:420:ced6:a88a with SMTP id
 m12-20020a02a14c000000b00420ced6a88amr46037jah.6.1686243414719; Thu, 08 Jun
 2023 09:56:54 -0700 (PDT)
Date:   Thu, 08 Jun 2023 09:56:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd448705fda123f5@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in static_key_slow_inc (3)
From:   syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
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

HEAD commit:    5f63595ebd82 Merge tag 'input-for-v6.4-rc5' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=153fcc63280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=2ab700fe1829880a2ec6
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1321e2fd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11946afd280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d12b9e46ffe8/disk-5f63595e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9044ded7edd/vmlinux-5f63595e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09f0fd3926e8/bzImage-5f63595e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc5-syzkaller-00024-g5f63595ebd82 #0 Not tainted
------------------------------------------------------
syz-executor324/4995 is trying to acquire lock:
ffffffff8cdc3ff0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc+0x12/0x30 kernel/jump_label.c:185

but task is already holding lock:
ffffffff8cf5a688 (freezer_mutex){+.+.}-{3:3}, at: freezer_css_online+0x4f/0x150 kernel/cgroup/legacy_freezer.c:111

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (freezer_mutex){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       freezer_change_state kernel/cgroup/legacy_freezer.c:389 [inline]
       freezer_write+0xa8/0x3f0 kernel/cgroup/legacy_freezer.c:429
       cgroup_file_write+0x2ca/0x6a0 kernel/cgroup/cgroup.c:4071
       kernfs_fop_write_iter+0x3a6/0x4f0 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:1868 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x790/0xb20 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain+0x166b/0x58f0 kernel/locking/lockdep.c:3847
       __lock_acquire+0x1316/0x2070 kernel/locking/lockdep.c:5088
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       cpus_read_lock+0x42/0x150 kernel/cpu.c:310
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:185
       freezer_css_online+0xc6/0x150 kernel/cgroup/legacy_freezer.c:117
       online_css+0xba/0x260 kernel/cgroup/cgroup.c:5491
       css_create kernel/cgroup/cgroup.c:5562 [inline]
       cgroup_apply_control_enable+0x7d1/0xae0 kernel/cgroup/cgroup.c:3249
       cgroup_mkdir+0xd8f/0x1000 kernel/cgroup/cgroup.c:5758
       kernfs_iop_mkdir+0x279/0x400 fs/kernfs/dir.c:1219
       vfs_mkdir+0x29d/0x450 fs/namei.c:4115
       do_mkdirat+0x264/0x520 fs/namei.c:4138
       __do_sys_mkdirat fs/namei.c:4153 [inline]
       __se_sys_mkdirat fs/namei.c:4151 [inline]
       __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4151
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(freezer_mutex);
                               lock(cpu_hotplug_lock);
                               lock(freezer_mutex);
  rlock(cpu_hotplug_lock);

 *** DEADLOCK ***

4 locks held by syz-executor324/4995:
 #0: ffff88807da6c460 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
 #1: ffff888075c6eee0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff888075c6eee0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: filename_create+0x260/0x530 fs/namei.c:3884
 #2: ffffffff8cf4f768 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:370 [inline]
 #2: ffffffff8cf4f768 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0xe9/0x290 kernel/cgroup/cgroup.c:1683
 #3: ffffffff8cf5a688 (freezer_mutex){+.+.}-{3:3}, at: freezer_css_online+0x4f/0x150 kernel/cgroup/legacy_freezer.c:111

stack backtrace:
CPU: 0 PID: 4995 Comm: syz-executor324 Not tainted 6.4.0-rc5-syzkaller-00024-g5f63595ebd82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain+0x166b/0x58f0 kernel/locking/lockdep.c:3847
 __lock_acquire+0x1316/0x2070 kernel/locking/lockdep.c:5088
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 cpus_read_lock+0x42/0x150 kernel/cpu.c:310
 static_key_slow_inc+0x12/0x30 kernel/jump_label.c:185
 freezer_css_online+0xc6/0x150 kernel/cgroup/legacy_freezer.c:117
 online_css+0xba/0x260 kernel/cgroup/cgroup.c:5491
 css_create kernel/cgroup/cgroup.c:5562 [inline]
 cgroup_apply_control_enable+0x7d1/0xae0 kernel/cgroup/cgroup.c:3249
 cgroup_mkdir+0xd8f/0x1000 kernel/cgroup/cgroup.c:5758
 kernfs_iop_mkdir+0x279/0x400 fs/kernfs/dir.c:1219
 vfs_mkdir+0x29d/0x450 fs/namei.c:4115
 do_mkdirat+0x264/0x520 fs/namei.c:4138
 __do_sys_mkdirat fs/namei.c:4153 [inline]
 __se_sys_mkdirat fs/namei.c:4151 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4151
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7e55624e09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7236ac98 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7e55624e09
RDX: 00000000000001ff RSI: 0000000020000180 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff7236acc0 R09: 00007fff7236acc0
R10: 00007fff7236acc0 R11: 0000000000000246 R12: 00007fff7236acbc
R13: 00007fff7236acd0 R14: 00007fff7236ad10 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
