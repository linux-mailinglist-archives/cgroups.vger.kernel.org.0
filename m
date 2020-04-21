Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC11B22EB
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUJgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:36:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52607 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgDUJgP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:36:15 -0400
Received: by mail-io1-f72.google.com with SMTP id c15so15851062iom.19
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 02:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bXMKuEMVNvJ938hbxaMdfVLd8oEOqxl5+yrMgmXZ3FU=;
        b=ZKBncMsZIqoCVQz1K6wZSnCeK/xW88EsGRDk+GqLq7QjbhLRTARg4mUu0oqBnGBqw0
         SDxB/kxTRG+o7lS5lNnSy9YQo1CfkHq81RT2+vmVbGKAcI5R/IyOr4uiLUbCmtfDeDQW
         E00SnLyfnbbuknPLT2D3GKSEMv5uAsoUt6V8JWMkv1Rp/phkOJMVoD5vwQPlP2oF9f/Z
         nRo5vZNGZXZc2TgdBxcQlEI/erhWL0l4NJrSHDsC+DTdlI6nQ9Kk9mQPM9lhjJzuaLbi
         85/Gv4DoPi/ld1pbEPbDINys6vGVJrSBEKZQXAHSi86T2r2uM41no86g/9C0bgOp29Xv
         T/Jg==
X-Gm-Message-State: AGi0PuYqRmTqAyM5LRSf6Xv6owmj1o15ESaAMK+lMgG++Ha1a1KQX2zo
        VXa4P2oZGJFxecfHC/fo7sDmDd0dnYrD7FwGNkm3qA/hFEWB
X-Google-Smtp-Source: APiQypJinovxSvL4KTXr9Tqzf+1q1R+53iuv6UFYl06/PuKz3No5OXFLCCyNVMyBVAZtiA8hucKZLLzQf36cC+SffBlJeSd7/E+8
MIME-Version: 1.0
X-Received: by 2002:a6b:6618:: with SMTP id a24mr12582024ioc.85.1587461774308;
 Tue, 21 Apr 2020 02:36:14 -0700 (PDT)
Date:   Tue, 21 Apr 2020 02:36:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026f90605a3c9bf64@google.com>
Subject: WARNING in cgroup_apply_control_disable
From:   syzbot <syzbot+5b142e89a1b402a24801@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, christian@brauner.io,
        daniel@iogearbox.net, hannes@cmpxchg.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7a56db02 Merge tag 'nfs-for-5.7-3' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e336abe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
dashboard link: https://syzkaller.appspot.com/bug?extid=5b142e89a1b402a24801
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f0c6abe00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1113ec5fe00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1313ec5fe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1513ec5fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b142e89a1b402a24801@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8613 at kernel/cgroup/cgroup.c:3111 cgroup_apply_control_disable+0x404/0x4d0 kernel/cgroup/cgroup.c:3111
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8613 Comm: syz-executor.1 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:cgroup_apply_control_disable+0x404/0x4d0 kernel/cgroup/cgroup.c:3111
Code: ff ff ff e8 5e 9c 06 00 48 89 ef 41 ff d5 e9 1a ff ff ff e8 4e 9c 06 00 48 89 ef e8 b6 e5 fe ff e9 08 ff ff ff e8 3c 9c 06 00 <0f> 0b e9 ab fd ff ff 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f e9
RSP: 0018:ffffc90005247a90 EFLAGS: 00010293
RAX: ffff888096aba5c0 RBX: dffffc0000000000 RCX: ffffffff816c956d
RDX: 0000000000000000 RSI: ffffffff816c97c4 RDI: 0000000000000007
RBP: ffff8880a601b000 R08: ffff888096aba5c0 R09: ffffed1015cc7104
R10: ffff8880ae63881b R11: ffffed1015cc7103 R12: 0000000000000008
R13: 0000000000000002 R14: ffffffff89a30640 R15: ffff8880917de000
 cgroup_finalize_control kernel/cgroup/cgroup.c:3178 [inline]
 rebind_subsystems+0x3cd/0xb00 kernel/cgroup/cgroup.c:1750
 cgroup_setup_root+0x36a/0xa30 kernel/cgroup/cgroup.c:1984
 cgroup1_root_to_use kernel/cgroup/cgroup-v1.c:1190 [inline]
 cgroup1_get_tree+0xd69/0x13b6 kernel/cgroup/cgroup-v1.c:1207
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2816 [inline]
 do_mount+0x1306/0x1b30 fs/namespace.c:3141
 __do_sys_mount fs/namespace.c:3350 [inline]
 __se_sys_mount fs/namespace.c:3327 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3327
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45f2da
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 4d 8c fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 2a 8c fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc7dbf09e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc7dbf0a40 RCX: 000000000045f2da
RDX: 00000000004cad69 RSI: 00000000004c1465 RDI: 00000000004c1428
RBP: 0000000000000000 R08: 00000000004cf6b0 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000418390
R13: 00007ffc7dbf0c68 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
