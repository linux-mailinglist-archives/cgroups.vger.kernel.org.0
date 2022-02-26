Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF274C5459
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 08:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiBZHX7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Feb 2022 02:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiBZHX7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Feb 2022 02:23:59 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDC28E20
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 23:23:24 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id p9-20020a056e02144900b002c28aea4485so4922044ilo.20
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 23:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ni4lvJQUTghS0A94JZkFOwka6WIVFnjt5N9mjzzU6a4=;
        b=o1lSPK1uZfFlvSCr4UJnmoi6x55gWJHWTLYmvy2DUys7N3cBQba0dSlVkfGous71Oa
         y2lRZfNDXDKSbaUtMwhl8BiY8ijfH731Z7+UZFlWNf6x0PzgaBQumMmLwaBhVnv43ojp
         nd4bED+a2Q0VNyAe9uwnGsLolZRkAXIrvwilQMjDj37SKi/JhEexu1U6QemfN8Mm3hi8
         P91gwW5o1MUB2Jq6w5TAgW0fpIV8Jodyou86//kji42yGveMU62F2gPjJMzdpYwidrpL
         iJdH3yO+qynnss/6tJ9Pi9d5dTyIJIjTRxJ/JcnKmlQd8VUaUUnj+49fzEneQO0XCQeR
         1b6Q==
X-Gm-Message-State: AOAM5334eYKwzkBALGlzt83e6DOF+EqvbcTs18gLAPZKeSQbu02H/2TW
        GSRoLixn4+HQL0xeDja9faePE2Ho26C0LCKBF+wZ+4EkNoL6
X-Google-Smtp-Source: ABdhPJzx4DUBAx43q5XkKlSSWv/3LQS5YxNMm76ElPyAHBb7zrVHBi5LdDdAO+6ZiEkqMGxMpYthJqCrWFpq4t0tvyVcm1cfgfvm
MIME-Version: 1.0
X-Received: by 2002:a02:ccd7:0:b0:30d:21d0:51d6 with SMTP id
 k23-20020a02ccd7000000b0030d21d051d6mr8894823jaq.138.1645860203526; Fri, 25
 Feb 2022 23:23:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 23:23:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7fde605d8e6b085@google.com>
Subject: [syzbot] linux-next test error: WARNING in __mod_memcg_lruvec_state
From:   syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, sfr@canb.auug.org.au,
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

HEAD commit:    06aeb1495c39 Add linux-next specific files for 20220225
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a69c8e700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d8bf144f45f9b3
dashboard link: https://syzkaller.appspot.com/bug?extid=a526c269335f529d25c8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3590 at mm/memcontrol.c:749 __mod_memcg_lruvec_state+0x1ab/0x220
Modules linked in:
CPU: 1 PID: 3590 Comm: syz-fuzzer Not tainted 5.17.0-rc5-next-20220225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__mod_memcg_lruvec_state+0x1ab/0x220
Code: bb 23 92 0e 48 c7 c7 e0 b6 d9 89 e8 af d9 95 07 65 c7 05 f4 c8 37 7e 00 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9 a6 fe ff ff 4c 89 f6 48 c7 c7 60 63 ee 8b e8 8f d3 45 02
RSP: 0000:ffffc900039efbc0 EFLAGS: 00010202
RAX: 0000000000000206 RBX: 0000000000000200 RCX: ffffffff81aafa53
RDX: 1ffff1100218fa8d RSI: 000000000000001c RDI: ffff888010c7d468
RBP: ffff888010c7d000 R08: 0000000000000001 R09: ffffffff8ba144e7
R10: fffffbfff174289c R11: 0000000000000001 R12: 000000000000001c
R13: ffff88813fe38000 R14: ffff88813fe38000 R15: ffff88813fffa000
FS:  000000c0001d2c90(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000e00000 CR3: 000000001cfb0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mod_lruvec_page_state+0x1e5/0x3e0
 page_add_new_anon_rmap+0x2e5/0x930
 do_huge_pmd_anonymous_page+0x102c/0x2350
 __handle_mm_fault+0x2a66/0x4110
 handle_mm_fault+0x1c8/0x790
 do_user_addr_fault+0x489/0x11c0
 exc_page_fault+0x9e/0x180
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x465e33
Code: 00 00 c5 fe 6f 06 c5 fe 6f 4e 20 c5 fe 6f 56 40 c5 fe 6f 5e 60 48 81 c6 80 00 00 00 c5 fd e7 07 c5 fd e7 4f 20 c5 fd e7 57 40 <c5> fd e7 5f 60 48 81 c7 80 00 00 00 48 81 eb 80 00 00 00 77 b5 0f
RSP: 002b:000000c0003533b8 EFLAGS: 00010202
RAX: 000000c000db4000 RBX: 0000000000423fe0 RCX: 000000c001224000
RDX: 000000c001224001 RSI: 000000c000990020 RDI: 000000c000dfffa0
RBP: 000000c000353418 R08: 000000c000db4000 R09: 0000000000000000
R10: 0000000000000020 R11: 0000000000000206 R12: 000000c000243f18
R13: 000000000000002e R14: 000000c0000001a0 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
