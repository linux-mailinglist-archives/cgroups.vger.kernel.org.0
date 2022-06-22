Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46927554BBD
	for <lists+cgroups@lfdr.de>; Wed, 22 Jun 2022 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbiFVNth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357609AbiFVNtd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 09:49:33 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD227B1B
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 06:49:32 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so9223179iov.9
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2n6CjIwNzX6e9eJPj/9OKv9MH6eZszALXBbe374CiSA=;
        b=4xKXyBqXo6Vb0JtONWTaJAUJvxpq74C5Dhs0teK/owxiAYcy4QVcen6BbgdAmy0jRt
         yH5Dphhz/aGQYJa9811xNyhM+vXCMxJlwbtL51guVsqch2Fpmkrb8CKrLa5E/3Cl+lxx
         AuYgJYTJ1etUQnyIaKWARfQVOIE4bfVzL9NzczaIsaT6840Aeqjhgf6PvMMIL1K0YbrZ
         EXJRb8bsUIUQSaMBt9rmz3I8cTblaql7M42g6zfDAoyqYSZ5S+aUPXJ6szMcHbW5lcmR
         twdyP5f9/L2/bV0u6ltMIir5jJreQDLwxu3qdiWncHt9xr76+1XhDRF9r1dWFCYLKhmJ
         QFZA==
X-Gm-Message-State: AJIora8e15ys+GW/yAhkoguXzU43TDi8S25ToFQHIUbrkEokXLTmtrcA
        rgr3zp7U2ZRUL+KmbkVe6KLRyNJb1rmY32XLoiCueSXxfbtU
X-Google-Smtp-Source: AGRyM1sX/BnL2GnymFvihvSyNOTAYTtbDL1HQLhgp1k4ScEDU1ogZpUUgxrtrNVmgY9JSXX+Lto72bbIkIF6PDOtf2eAefv6uccE
MIME-Version: 1.0
X-Received: by 2002:a92:c7ce:0:b0:2d9:1c03:f891 with SMTP id
 g14-20020a92c7ce000000b002d91c03f891mr2199758ilk.258.1655905771519; Wed, 22
 Jun 2022 06:49:31 -0700 (PDT)
Date:   Wed, 22 Jun 2022 06:49:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b03c805e2099bf0@google.com>
Subject: [syzbot] WARNING in folio_lruvec_lock_irqsave
From:   syzbot <syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac0ba5454ca8 Add linux-next specific files for 20220622
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14354c18080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12809dacb9e7c5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=ec972d37869318fc3ffb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com

 folio_put include/linux/mm.h:1227 [inline]
 put_page+0x217/0x280 include/linux/mm.h:1279
 unmap_and_move_huge_page mm/migrate.c:1343 [inline]
 migrate_pages+0x3dc3/0x5a10 mm/migrate.c:1440
 do_mbind mm/mempolicy.c:1332 [inline]
 kernel_mbind+0x4d7/0x7d0 mm/mempolicy.c:1479
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page has been migrated, last migrate reason: mempolicy_mbind
------------[ cut here ]------------
WARNING: CPU: 1 PID: 18925 at include/linux/memcontrol.h:800 folio_lruvec include/linux/memcontrol.h:800 [inline]
WARNING: CPU: 1 PID: 18925 at include/linux/memcontrol.h:800 folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
Modules linked in:
CPU: 1 PID: 18925 Comm: syz-executor.3 Not tainted 5.19.0-rc3-next-20220622-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:folio_lruvec include/linux/memcontrol.h:800 [inline]
RIP: 0010:folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
Code: 1f 44 00 00 45 31 e4 80 3d 06 3e da 0b 00 0f 85 01 fe ff ff 48 c7 c6 40 6f da 89 4c 89 f7 e8 0a 44 e2 ff c6 05 ea 3d da 0b 01 <0f> 0b e9 e4 fd ff ff e8 67 be ad 07 85 c0 0f 84 37 fd ff ff 80 3d
RSP: 0018:ffffc9000b84f2c8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: fffff9400027e007 RCX: ffffc900135af000
RDX: 0000000000040000 RSI: ffffffff81ce36a6 RDI: fffff52001709e28
RBP: dffffc0000000000 R08: 000000000000003c R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000000
R13: fffff9400027e000 R14: ffffea00013f0000 R15: 0000000000000000
FS:  00007f5cfbb96700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002073f000 CR3: 0000000074b9f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_lruvec_relock_irqsave include/linux/memcontrol.h:1666 [inline]
 folio_batch_move_lru+0xf9/0x500 mm/swap.c:242
 folio_batch_add_and_move+0xd4/0x130 mm/swap.c:258
 deactivate_file_folio+0x222/0x580 mm/swap.c:678
 invalidate_mapping_pagevec+0x38d/0x5c0 mm/truncate.c:535
 drop_pagecache_sb+0xcf/0x2a0 fs/drop_caches.c:39
 iterate_supers+0x13c/0x290 fs/super.c:694
 drop_caches_sysctl_handler+0xdb/0x110 fs/drop_caches.c:62
 proc_sys_call_handler+0x4a1/0x6e0 fs/proc/proc_sysctl.c:611
 call_write_iter include/linux/fs.h:2057 [inline]
 do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:742
 do_iter_write+0x182/0x700 fs/read_write.c:868
 vfs_iter_write+0x70/0xa0 fs/read_write.c:909
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1a7/0x270 fs/splice.c:979
 do_sendfile+0xae0/0x1240 fs/read_write.c:1262
 __do_sys_sendfile64 fs/read_write.c:1321 [inline]
 __se_sys_sendfile64 fs/read_write.c:1313 [inline]
 __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1313
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5cfaa89109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5cfbb96168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f5cfab9c030 RCX: 00007f5cfaa89109
RDX: 0000000020002080 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00007f5cfaae305d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000262 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff1ef394df R14: 00007f5cfbb96300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
