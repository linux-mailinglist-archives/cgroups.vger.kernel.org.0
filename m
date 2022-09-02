Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA65AB9BE
	for <lists+cgroups@lfdr.de>; Fri,  2 Sep 2022 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiIBVCw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Sep 2022 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiIBVCm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Sep 2022 17:02:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B11E399F
        for <cgroups@vger.kernel.org>; Fri,  2 Sep 2022 14:02:32 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id k9-20020a056e021a8900b002e5bd940e96so2630064ilv.13
        for <cgroups@vger.kernel.org>; Fri, 02 Sep 2022 14:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tjXPIVUa530Ib5lpdoYK8WIQSiEveJdJfuoCQgSxgqE=;
        b=VaMLln3XrdTH4yHtLeh+b3//66KqIqI6cLlKN6TMoPoNGI6q3H8mi1o98v9eSfdHN3
         mXmHPSSKE8pH/wkVkgsk5i75bYsQjI6V1tujN03sT1klj6KykZkD5GUt6MLaeOhnQdxO
         Um/A+kkMQ6ozzqqcON/F/V9aJ9oNjOLVBAnXK9OcLhuKd22jUVpj7eTYJO64+BH0TabK
         WDLOKDT17N00u2SGw+UZYzdA6L2Sca2YLhTf1eKfnk+1Cyzr8RnSp1XvdRwvFWPuaq+E
         m59ktBiC23jBBA4wUOa8EV+4SbS+jPkq1VzkjqlDzdJBn7+nc5IvPJW65QChvQQVcruD
         gXZg==
X-Gm-Message-State: ACgBeo1NFqV1vO+t1BSeR4cALVD2jIZZRz2Y6a0NCwYomELes97z5J0E
        rF4/5h450Iv/zpC/patdXmJpNcfcE0dttX7orgjwPYqthmDn
X-Google-Smtp-Source: AA6agR6eV7qr9Lc76oYaiU3wkpsgPRUThCL+SvlcwlzZNM6d6bT2L9r99E9sFztEYbU4438+GCtLY3NxySyGqld+3S6f61doTMVV
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:2ee:bf22:630f with SMTP id
 q14-20020a92ca4e000000b002eebf22630fmr2663381ilo.287.1662152551115; Fri, 02
 Sep 2022 14:02:31 -0700 (PDT)
Date:   Fri, 02 Sep 2022 14:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f372b05e7b80c2e@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in mem_cgroup_track_foreign_dirty_slowpath
From:   syzbot <syzbot+66ad6d47392c3113957e@syzkaller.appspotmail.com>
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

HEAD commit:    85413d1e802e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=108cec3b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=66ad6d47392c3113957e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a3b1e5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dead7d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66ad6d47392c3113957e@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 00000000000012e8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011163c000
[00000000000012e8] pgd=080000011204a003, p4d=080000011204a003, pud=080000011068f003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 926 Comm: syz-executor308 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mem_cgroup_track_foreign_dirty_slowpath+0x3c/0x1e4 mm/memcontrol.c:4595
lr : mem_cgroup_track_foreign_dirty_slowpath+0x38/0x1e4 mm/memcontrol.c:4586
sp : ffff800016c9ba80
x29: ffff800016c9ba80 x28: ffff0000d12cb500 x27: 0c00000000000001
x26: 0000000000000001 x25: ffff0000c017b000 x24: 0000000000000100
x23: ffff80000d379000 x22: 00000001000233ce x21: fffffc0003463000
x20: ffff0000c3849060 x19: 0000000000000000 x18: 000000000000013a
x17: ffff80000c04d6bc x16: ffff80000dbb8658 x15: ffff0000d12cb500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000d12cb500
x11: ff808000095ecd98 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c3849000 x7 : ffff80000856f3a4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000010 x1 : ffff80000cb90d29 x0 : 0000000000000001
Call trace:
 mem_cgroup_track_foreign_dirty_slowpath+0x3c/0x1e4
 mem_cgroup_track_foreign_dirty include/linux/memcontrol.h:1663 [inline]
 folio_account_dirtied+0x430/0x650 mm/page-writeback.c:2575
 __folio_mark_dirty+0xbc/0x180 mm/page-writeback.c:2615
 block_dirty_folio+0x10c/0x1ec fs/buffer.c:640
 folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
 filemap_page_mkwrite+0x26c/0x5dc mm/filemap.c:3418
 do_page_mkwrite+0x74/0x288 mm/memory.c:2971
 wp_page_shared+0x8c/0x4e4 mm/memory.c:3316
 do_wp_page+0x86c/0x110c mm/memory.c:3466
 handle_pte_fault mm/memory.c:4929 [inline]
 __handle_mm_fault mm/memory.c:5053 [inline]
 handle_mm_fault+0x878/0xa40 mm/memory.c:5151
 __do_page_fault arch/arm64/mm/fault.c:502 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:602
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:818
 el0_da+0x70/0x16c arch/arm64/kernel/entry-common.c:502
 el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:645
 el0t_64_sync+0x18c/0x190
Code: aa1503e0 aa1403e1 9400006c f9400288 (f9497669) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1503e0 	mov	x0, x21
   4:	aa1403e1 	mov	x1, x20
   8:	9400006c 	bl	0x1b8
   c:	f9400288 	ldr	x8, [x20]
* 10:	f9497669 	ldr	x9, [x19, #4840] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
