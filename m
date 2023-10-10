Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473457BFBA2
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJJMhr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJJMhq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 08:37:46 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D771A9
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 05:37:44 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3af5b5d80d9so8175445b6e.1
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 05:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941463; x=1697546263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pponouXnqkcYZoPXbWW1Fsdf1AYfuvQyCDKNQFeeDk0=;
        b=l439i6inPhQx5T8YudUlne2jmAZ745xMhGU1YWZ5xqYZD6lETZm0TiOC4vKHhdQYT/
         TMGwj+MVD7AtbGPvJvnhpkPnjgH866/tU9VimkVZhqNLSr4UOCMpkZHMbEYaI6AduQ24
         ooHNfCmVzQwZuCIBvWny99PV6+oi98lMIIXAH1JQQ8TBz+Bs5/7f2IUua2mMGOl82Z3y
         6QRq4oEliQ84hxA8G/80S5T5Zrd82tsi2OvifvSmjmcIFplBowX9yCKRsMKzVJSxxJjB
         7FKrmPlc1gysFSs/G7L2jHIOwAtC2XeKYN7Gb68T4oFSUo5MgXH/Xc5UB449ueYIKdvC
         Rzsg==
X-Gm-Message-State: AOJu0YzHhyPHg7ScgH0oACU7t1d3LbJds2pFngWFBjkheTWZYZ4p49PI
        Run6dasNZ3xSXt6olLKq9zqovIUNP9IpGASha7ZEAoa9AwOf
X-Google-Smtp-Source: AGHT+IGV8JkQD9+eCvp0PToixaq0hIGnXiistcWaxSEL6WBdKodmwabUTy23YrVoAKGB0LReRRe0YsB6yFPV/mWhpR0MiGxuHiH2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0d:b0:3ae:1691:c59f with SMTP id
 bk13-20020a0568081a0d00b003ae1691c59fmr9548394oib.1.1696941463154; Tue, 10
 Oct 2023 05:37:43 -0700 (PDT)
Date:   Tue, 10 Oct 2023 05:37:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001db97f06075bf98b@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in mem_cgroup_migrate
From:   syzbot <syzbot+831ba898b5db8d5617ea@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1716036e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=831ba898b5db8d5617ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+831ba898b5db8d5617ea@syzkaller.appspotmail.com

 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5208 at mm/memcontrol.c:7552 mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Modules linked in:
CPU: 1 PID: 5208 Comm: syz-executor.1 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Code: f7 ff e9 36 ff ff ff 80 3d 84 b2 d1 0c 00 0f 85 54 ff ff ff 48 c7 c6 a0 9e 9b 8a 48 89 ef e8 0d 5c df ff c6 05 68 b2 d1 0c 01 <0f> 0b e9 37 ff ff ff 48 c7 c6 e0 9a 9b 8a 48 89 df e8 f0 5b df ff
RSP: 0018:ffffc90004b2fa38 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffea0005338000 RCX: ffffc90005439000
RDX: 0000000000040000 RSI: ffffffff81e76463 RDI: ffffffff8ae96da0
RBP: ffffea0001d98000 R08: 0000000000000000 R09: fffffbfff1d9db9a
R10: ffffffff8ecedcd7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000200 R14: 0000000000000000 R15: ffffea0001d98018
FS:  00007fc15e89d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31820000 CR3: 000000007f5e1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hugetlbfs_migrate_folio fs/hugetlbfs/inode.c:1066 [inline]
 hugetlbfs_migrate_folio+0xd0/0x120 fs/hugetlbfs/inode.c:1049
 move_to_new_folio+0x183/0x690 mm/migrate.c:966
 unmap_and_move_huge_page mm/migrate.c:1428 [inline]
 migrate_hugetlbs mm/migrate.c:1546 [inline]
 migrate_pages+0x16ac/0x27c0 mm/migrate.c:1900
 migrate_to_node mm/mempolicy.c:1072 [inline]
 do_migrate_pages+0x43e/0x690 mm/mempolicy.c:1171
 kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1682
 __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc15da7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc15e89d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007fc15db9bf80 RCX: 00007fc15da7cae9
RDX: 0000000020000340 RSI: 0000000000000080 RDI: 0000000000000000
RBP: 00007fc15dac847a R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200003c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc15db9bf80 R15: 00007ffd87d7c058
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
