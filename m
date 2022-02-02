Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA44A6DCD
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 10:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiBBJaX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 04:30:23 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37778 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBBJaX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 04:30:23 -0500
Received: by mail-il1-f199.google.com with SMTP id 20-20020a056e020cb400b002b93016fbccso13760884ilg.4
        for <cgroups@vger.kernel.org>; Wed, 02 Feb 2022 01:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NZ7WdYtQrNmVol7I4UetJhUqWcjgf5izWYmBss2fDeI=;
        b=HW5S1q59cMtDZWW3gQri0jjf7gTDWwbh/OyCvoVe9crf/s0D+EbaW5LSOqBtWO2WEt
         H1KDzQcCAUG33lRF0LfEpeDx6Mh8xdUHDzJZuuElUvln/E1tYrtp/1td9tOHxT4MI1L4
         nOFRiFIAlH8i04DxvIWWoNoQcOZTwiXJkshdFGzyoQYzEVQ1ab6ZiIzHiPkPhI1+ki5d
         by/GrvuJr/zx3/OcpIlz0gBTRoWKTyceKNWl5VFYlU0f5Jv/vC/ALtG4is3kRqsGS0m6
         6A5dmDii8eVNe+ucgtVpjDMc7+qhom+p26S+srbO/pqC5pMcFBXv5Zr4Cd/M+xLoXedJ
         dbJw==
X-Gm-Message-State: AOAM5309ylGzF99RfnEq1igG4Cye5Py9LTqybuHYi+ZsbA28wjmjLy+s
        kEVVKcQVjZTfOkKW1nwqEDWPrj0dw3ZOydNPVpxhQxgFjaNG
X-Google-Smtp-Source: ABdhPJzxRGFGHD/f8nz9jewR6Z8HVVhEyTz1BpTtYuPo9LSEN5UQM2YwD+bThGxUUYDBD1kyZWz0kY7by3sKLnFQTZKMf0QgqeLM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a47:: with SMTP id u7mr7869536ilv.33.1643794222593;
 Wed, 02 Feb 2022 01:30:22 -0800 (PST)
Date:   Wed, 02 Feb 2022 01:30:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8c08805d705aaa2@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in __init_work (3)
From:   syzbot <syzbot+13b13d204fb13cfda744@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, christian@brauner.io,
        daniel@iogearbox.net, hannes@cmpxchg.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b76bbb34dc80 net: stmmac: dwmac-sun8i: make clk really gat..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cccccbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae0d71385f83fe54
dashboard link: https://syzkaller.appspot.com/bug?extid=13b13d204fb13cfda744
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13b13d204fb13cfda744@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: work_struct hint: css_killed_work_fn+0x0/0x5e0 kernel/cgroup/cgroup.c:3947
WARNING: CPU: 0 PID: 13 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:

CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.17.0-rc1-syzkaller-00460-gb76bbb34dc80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 30 06 8a 4c 89 ee 48 c7 c7 40 24 06 8a e8 0c 57 27 05 <0f> 0b 83 05 55 7f b2 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90000d27ba8 EFLAGS: 00010286

RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888011928000 RSI: ffffffff815fa1d8 RDI: fffff520001a4f67
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815f3f3e R11: 0000000000000000 R12: ffffffff89ab5380
R13: ffffffff8a062940 R14: ffffffff814bda70 R15: ffffffff90788e18
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2eb22000 CR3: 0000000053d45000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x524/0xd10 lib/debugobjects.c:593
 __init_work+0x48/0x50 kernel/workqueue.c:518
 css_release+0x1a/0x110 kernel/cgroup/cgroup.c:5213
 percpu_ref_put_many.constprop.0+0x22b/0x260 include/linux/percpu-refcount.h:335
 rcu_do_batch kernel/rcu/tree.c:2527 [inline]
 rcu_core+0x7b8/0x1540 kernel/rcu/tree.c:2778
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
