Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92F3CF86C
	for <lists+cgroups@lfdr.de>; Tue, 20 Jul 2021 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhGTKOg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jul 2021 06:14:36 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37842 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbhGTKKq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jul 2021 06:10:46 -0400
Received: by mail-il1-f197.google.com with SMTP id h11-20020a056e021b8bb029020d99b97ad3so12939734ili.4
        for <cgroups@vger.kernel.org>; Tue, 20 Jul 2021 03:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ole8b2cR6lQoDSXLNb5l4NYhygBr3zVA6T0AtIVglTc=;
        b=NZ1/kwSjdsSq1K9GZ8xihHWgZOXzj3zPC1zjQlkGodOwAjZuEoaWGaM7bng+sQmC6s
         W+VoaB+rt5fd2LZfZioz9AM6ghv/rNset75uDXW+JypoCv6B6GrirY0dQals3fQyeG84
         UqNwjFgDTiDFIGEXTNyDGlcQ4dlE7EMJkjZC8LR7k0VBrzsQD99aeofqaISKC9kppBl6
         +CJW3mhSkETnda+8dVmoOSShEMUSSdmvdhkxP4yf6ipdMS27p81qIQyp+7D9EU/eHYdh
         3SNEDDt9+ibVBvYdLIUYmCc7mA4ZDmJH1OsDhjfcsjBIklGvXjC07iVtlIzmNSZefT/n
         9WTg==
X-Gm-Message-State: AOAM530Nn6ICsc2jjewWJ5xgG2+CBFjDzVSFThQe2/rR4YSaql6YmDbU
        PsAtUGye7/XeFjxU+VDRgzDRlQ4qOhh3yBWbBbu0v/ScrHxQ
X-Google-Smtp-Source: ABdhPJzrg1xbwj9UVISbQgfhQpJ0AXZpQnVvU/gpeRDUY2fKFNkOEYZTFzgFeOOaXAO+KHJa+QEprVV74Yx3q4DnDsSE2p1Jq8k1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:: with SMTP id u6mr20003836ilv.135.1626778282613;
 Tue, 20 Jul 2021 03:51:22 -0700 (PDT)
Date:   Tue, 20 Jul 2021 03:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9e38905c78bd588@google.com>
Subject: [syzbot] linux-next boot error: BUG: sleeping function called from
 invalid context in cgroup_rstat_flush
From:   syzbot <syzbot+0e2d06632863e7ddb1c7@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        lizefan.x@bytedance.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6e235535ce82 Add linux-next specific files for 20210716
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f3d7e2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b07a961928126747
dashboard link: https://syzkaller.appspot.com/bug?extid=0e2d06632863e7ddb1c7

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e2d06632863e7ddb1c7@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:200
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 39, name: kworker/u4:3
3 locks held by kworker/u4:3/39:
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x871/0x1630 kernel/workqueue.c:2247
 #1: ffffc90000e2fdb0 (stats_flush_work){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1630 kernel/workqueue.c:2251
 #2: ffffffff8bad45d8 (stats_flush_lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:369 [inline]
 #2: ffffffff8bad45d8 (stats_flush_lock){+.+.}-{2:2}, at: mem_cgroup_flush_stats mm/memcontrol.c:5358 [inline]
 #2: ffffffff8bad45d8 (stats_flush_lock){+.+.}-{2:2}, at: flush_memcg_stats_work+0xd/0x50 mm/memcontrol.c:5373
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 39 Comm: kworker/u4:3 Not tainted 5.14.0-rc1-next-20210716-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_memcg_stats_work
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 ___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9182
 cgroup_rstat_flush+0x1c/0x50 kernel/cgroup/rstat.c:200
 mem_cgroup_flush_stats mm/memcontrol.c:5361 [inline]
 mem_cgroup_flush_stats mm/memcontrol.c:5356 [inline]
 flush_memcg_stats_work+0x39/0x50 mm/memcontrol.c:5373
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
