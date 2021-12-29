Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22256481562
	for <lists+cgroups@lfdr.de>; Wed, 29 Dec 2021 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhL2QyY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Dec 2021 11:54:24 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54994 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhL2QyX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Dec 2021 11:54:23 -0500
Received: by mail-io1-f69.google.com with SMTP id s8-20020a056602168800b005e96bba1363so9679981iow.21
        for <cgroups@vger.kernel.org>; Wed, 29 Dec 2021 08:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fMiBLIj8KOO/or1Oc8vOJsVBTBozaPamYpfEl8x9F6A=;
        b=cnhfU8VeCndIycADXyo705ejBCLs4fHvFhCnWK2uxO/LrfTXhGN8vy2hXT8sQbH8un
         svSolDRz7XXi+rJ182Nefw+28rB+2IxNc6LwnhnNz3QzgUueHtQkQi7iNDqJc4x9TQKp
         l+/dyPOPAZGt0CZzsB2hqUkXIryycIJJc7flaFNpEFaEgR+02e/iTjz/vW1RPoeaYMMX
         S9mB6pJIFDcnkyHxUgV1iuZVn/cXB8eLQvK7FiNFmRUEYz5+qACQJAzimrwrFT01GW+V
         xC+oXVRD+K4hJFF9eJKPBL+oeZlIq/+lJQH9+Zvre6PjBTStRQiZZCha94iOzke0OaFW
         XtUQ==
X-Gm-Message-State: AOAM533SjfP1IL3znFFOM5n9zNATxt2yrdnD4uK/ami0VNsA3OhcpMFu
        i5xR/k2wI0/vbPz+AnIfEqD9eEC3bQjEj69nx09fMsqtJAoO
X-Google-Smtp-Source: ABdhPJz6CdwIP5ahIkqvMOqlVk4YsmKGkA/4CP7BaJuxX/Sv4sj82utpYXkMkzGKN7XF98MtwfBk+ry7OanD4i4VP1J9Bi1HAvCR
MIME-Version: 1.0
X-Received: by 2002:a02:271f:: with SMTP id g31mr12360372jaa.147.1640796862694;
 Wed, 29 Dec 2021 08:54:22 -0800 (PST)
Date:   Wed, 29 Dec 2021 08:54:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000264b2a05d44bca80@google.com>
Subject: [syzbot] WARNING in cpuset_write_resmask
From:   syzbot <syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15677063b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
dashboard link: https://syzkaller.appspot.com/bug?extid=568dc81cd20b72d4a49f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5329 at kernel/cgroup/cpuset.c:1817 update_nodemasks_hier kernel/cgroup/cpuset.c:1817 [inline]
WARNING: CPU: 0 PID: 5329 at kernel/cgroup/cpuset.c:1817 update_nodemask kernel/cgroup/cpuset.c:1890 [inline]
WARNING: CPU: 0 PID: 5329 at kernel/cgroup/cpuset.c:1817 cpuset_write_resmask+0x167b/0x20f0 kernel/cgroup/cpuset.c:2457
Modules linked in:
CPU: 0 PID: 5329 Comm: syz-executor.3 Not tainted 5.16.0-rc6-next-20211224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:update_nodemasks_hier kernel/cgroup/cpuset.c:1817 [inline]
RIP: 0010:update_nodemask kernel/cgroup/cpuset.c:1890 [inline]
RIP: 0010:cpuset_write_resmask+0x167b/0x20f0 kernel/cgroup/cpuset.c:2457
Code: 3c 08 00 0f 85 ed 08 00 00 49 8b 9c 24 38 01 00 00 48 89 ef 48 89 de e8 53 4a 04 00 48 39 dd 0f 84 dd ef ff ff e8 d5 46 04 00 <0f> 0b e9 d1 ef ff ff e8 c9 46 04 00 e8 34 9d ef ff e8 bf 46 04 00
RSP: 0018:ffffc900094af970 EFLAGS: 00010212
RAX: 0000000000003f9c RBX: 0000000000000001 RCX: ffffc90003eba000
RDX: 0000000000040000 RSI: ffffffff8173bdab RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000003 R09: ffffffff8ffb5957
R10: ffffffff8173bd9d R11: 0000000000000001 R12: ffff88807c37f800
R13: ffff88807c37f854 R14: ffff88807c37f938 R15: 0000000000000000
FS:  00007fa6a243a700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5868fc51b8 CR3: 000000003c8a6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cgroup_file_write+0x1ec/0x780 kernel/cgroup/cgroup.c:3853
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2079 [inline]
 do_iter_readv_writev+0x47a/0x750 fs/read_write.c:725
 do_iter_write+0x188/0x710 fs/read_write.c:851
 vfs_writev+0x1aa/0x630 fs/read_write.c:924
 do_writev+0x139/0x300 fs/read_write.c:967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa6a3ac4e99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa6a243a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fa6a3bd7f60 RCX: 00007fa6a3ac4e99
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007fa6a3b1eff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd7ace88ff R14: 00007fa6a243a300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
