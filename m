Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8D55719B
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 06:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiFWDFf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 23:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiFWC6Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 22:58:25 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A09403E3
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 19:58:23 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso12146207ilo.18
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 19:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=a51vqGm/DdL9V+lIX+/uIzV8OhXEtUVbd7uLKvneHzo=;
        b=sISWDH66IAynBTdi5XxaxZgkOoP25Jr1EX531hHTtrYiLo2xjzsVQCTLWcbAcCjVVV
         Xfgd4b4hh9OIudNBgSbiGajWpzbxsySusFPx5AyuMjc1FTmCTexBksjzOS4pw2+k+B/6
         gaEZsCeEYLkUZ+0jhrxWYJw3QqAV+ioYcSLUoi0NF0i1AtAfPrSE7HifzulFdc7QD85i
         nxiCwEemcXM41TFiNb+wgT4Z8gd3kCh3+S9QDTHaufYYkhJouqC+VqGxyEtlrwE/3d4W
         H0Y4j65tdjzBRjqBjADVOkwEui0ZCsrd5ADhyxR2h9sy4tjugRY990DotZQjwwimV6PI
         dhZQ==
X-Gm-Message-State: AJIora8K0BL8+1R2gE6PoIhDwtYUXBm2Inlcublmi7ovYKim0sgsNz62
        BKWv3WxmIGGOux5Uyyhx2ECO+xyyZD8GlS0FQuHStAFO5ihd
X-Google-Smtp-Source: AGRyM1vmwO7C4lYHVfo3+asJfr+G7acNSlSU0JdDGQm3hOShpBdCjxbKfmeTC4GnRoS6I7RQlG0VJI//AWP4dtHac3VHKBmJkDPC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1845:b0:2d9:2e38:4f1d with SMTP id
 b5-20020a056e02184500b002d92e384f1dmr4074655ilv.78.1655953102603; Wed, 22 Jun
 2022 19:58:22 -0700 (PDT)
Date:   Wed, 22 Jun 2022 19:58:22 -0700
In-Reply-To: <0000000000004b03c805e2099bf0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000720bbf05e214a082@google.com>
Subject: Re: [syzbot] WARNING in folio_lruvec_lock_irqsave
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac0ba5454ca8 Add linux-next specific files for 20220622
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11be76c4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12809dacb9e7c5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=ec972d37869318fc3ffb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d0f470080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145df0ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com

 proc_sys_call_handler+0x4a1/0x6e0 fs/proc/proc_sysctl.c:611
 __kernel_write+0x4e1/0xa30 fs/read_write.c:536
 kernel_write fs/read_write.c:565 [inline]
 kernel_write+0xe2/0x540 fs/read_write.c:555
 process_sysctl_arg+0x22f/0x470 fs/proc/proc_sysctl.c:1893
 parse_one kernel/params.c:153 [inline]
 parse_args+0x46e/0x8b0 kernel/params.c:188
 do_sysctl_args+0xc3/0x130 fs/proc/proc_sysctl.c:1925
 kernel_init+0x6f/0x1d0 init/main.c:1529
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
page_owner free stack trace missing
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3610 at include/linux/memcontrol.h:800 folio_lruvec include/linux/memcontrol.h:800 [inline]
WARNING: CPU: 0 PID: 3610 at include/linux/memcontrol.h:800 folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
Modules linked in:
CPU: 0 PID: 3610 Comm: syz-executor209 Not tainted 5.19.0-rc3-next-20220622-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:folio_lruvec include/linux/memcontrol.h:800 [inline]
RIP: 0010:folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
Code: 1f 44 00 00 45 31 e4 80 3d 06 3e da 0b 00 0f 85 01 fe ff ff 48 c7 c6 40 6f da 89 4c 89 f7 e8 0a 44 e2 ff c6 05 ea 3d da 0b 01 <0f> 0b e9 e4 fd ff ff e8 67 be ad 07 85 c0 0f 84 37 fd ff ff 80 3d
RSP: 0018:ffffc90002eff2c8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: fffff940005ac007 RCX: 0000000000000000
RDX: ffff888020e3ba80 RSI: ffffffff81ce36a6 RDI: 0000000000000003
RBP: dffffc0000000000 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000001 R12: 0000000000000000
R13: fffff940005ac000 R14: ffffea0002d60000 R15: 0000000000000000
FS:  0000555556f64300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004571f0 CR3: 0000000070b3d000 CR4: 00000000003506f0
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
RIP: 0033:0x7f7fdde83d89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdbc683c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7fdde83d89
RDX: 0000000020002080 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffcdbc68568 R09: 00007ffcdbc68568
R10: 0000000000000262 R11: 0000000000000246 R12: 00007f7fdde47610
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

