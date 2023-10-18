Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971F77CEAF3
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 00:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJRWF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRWF5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 18:05:57 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4164D112
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 15:05:55 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e98eca4206so189184fac.0
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 15:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697666754; x=1698271554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTQJcyaeM6LRzyyDdrRyZA+dLcCMc9wKY0k4oIJ2DsE=;
        b=llHLnut9zlTG/2xeHa5Gwhd2quxa2GCDnK9ZLUj2eqSalpnbmHMxccXxOzh6p/5QC5
         x1r70Qai7fKdTa1wRYJzAcOGB4KXagUCx+G8bd9CiOqIYRc38QoNjhmJ5X8EjFL33Q9T
         n8GQqfWZOAql83vtkxVrvB0ps3iR81i5xAye6jOksXZo46cBNMf1qZEt3TurJzZr7NPO
         JGd9Nb+yfvGBxdA7zYA60E79IAahDTnyOMRl8AFDUgE+dhEhQ43QyEASnQcCK5RpC4MT
         DnNxZqq8eHpYqde+ufEzKZlfRMol4OxKroiBfEXz0vql+6UjQ+NTC2iQSwo3K98uJgqt
         9kOw==
X-Gm-Message-State: AOJu0Yxb4rj7NVojZ3kR13Ls6/wsazv3cIpTwaduDUDVXRQcC40XcNnT
        N272wJnU3vD8jGgmajAGjVHO6PbShKcC5KjQuYX1y7dcfoWE
X-Google-Smtp-Source: AGHT+IGCIvbWExqsv18olfM9C9/3MHgyJV7VBMPHO5ozj+KhzGCTfPzXnKk8MPkXvNLWBCDtzPtmhc8u7QeCMOECxk3D1uF+bjhA
MIME-Version: 1.0
X-Received: by 2002:a05:6870:4589:b0:1e9:6d19:935b with SMTP id
 y9-20020a056870458900b001e96d19935bmr42439oao.5.1697666754574; Wed, 18 Oct
 2023 15:05:54 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:05:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da806a060804d749@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in mem_cgroup_migrate (2)
From:   syzbot <syzbot+038716e59282db4b4608@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        roman.gushchin@linux.dev, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc4ee5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=038716e59282db4b4608
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+038716e59282db4b4608@syzkaller.appspotmail.com

 __kernel_write fs/read_write.c:537 [inline]
 kernel_write fs/read_write.c:558 [inline]
 kernel_write+0x1f8/0x6c0 fs/read_write.c:548
 process_sysctl_arg+0x22c/0x5f0 fs/proc/proc_sysctl.c:1668
 parse_one kernel/params.c:154 [inline]
 parse_args+0x587/0x8b0 kernel/params.c:189
 do_sysctl_args+0xc8/0x150 fs/proc/proc_sysctl.c:1700
 kernel_init+0x75/0x2a0 init/main.c:1460
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5210 at mm/memcontrol.c:7552 mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Modules linked in:
CPU: 0 PID: 5210 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Code: f7 ff e9 36 ff ff ff 80 3d 84 b2 d1 0c 00 0f 85 54 ff ff ff 48 c7 c6 a0 9e 9b 8a 48 89 ef e8 0d 5c df ff c6 05 68 b2 d1 0c 01 <0f> 0b e9 37 ff ff ff 48 c7 c6 e0 9a 9b 8a 48 89 df e8 f0 5b df ff
RSP: 0018:ffffc9000497fa18 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffea0005338000 RCX: ffffc90004f11000
RDX: 0000000000040000 RSI: ffffffff81e76463 RDI: ffffffff8ae96da0
RBP: ffffea00004a8000 R08: 0000000000000000 R09: fffffbfff1d9db9a
R10: ffffffff8ecedcd7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000200 R14: 0000000000000000 R15: ffffea00004a8018
FS:  00007f2fd9cb96c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bc6f77978 CR3: 00000000206cc000 CR4: 00000000003506f0
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
 do_move_pages_to_node mm/migrate.c:2039 [inline]
 move_pages_and_store_status+0xf4/0x230 mm/migrate.c:2129
 do_pages_move mm/migrate.c:2244 [inline]
 kernel_move_pages+0xc47/0x18e0 mm/migrate.c:2424
 __do_sys_move_pages mm/migrate.c:2438 [inline]
 __se_sys_move_pages mm/migrate.c:2433 [inline]
 __x64_sys_move_pages+0xe0/0x1b0 mm/migrate.c:2433
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2fd8e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2fd9cb90c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000117
RAX: ffffffffffffffda RBX: 00007f2fd8f9bf80 RCX: 00007f2fd8e7cae9
RDX: 0000000020000040 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007f2fd8ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2fd8f9bf80 R15: 00007fffc11f8338
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
