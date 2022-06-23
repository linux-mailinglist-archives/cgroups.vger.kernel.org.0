Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92B557237
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiFWEqY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 00:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiFWDtd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 23:49:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5B3DDDD
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 20:49:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1371346pjk.0
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQf1Y/9SEKggx+5f5ZKuIoWmVfhEoCl+A3wEcz5w+LY=;
        b=Ak0T4XxYb6MBacCveNhwT5VcQkrXKnxNShf2IKJScaoj+d/OQZDM7GeZph6XL2lXza
         mBm7tjtxsSYdjHC/2w4IwAxqYOjarFLKyJtK+ElwryZ2EFB1j/CjzXGEz1t7qmSTRCeZ
         jNr7v+xThI3oSWn/37KxouJR4mg1hODfBLfEWxApSnaZPxFecKQoS6aaU8cZ8nJCrm9S
         t1aQYVWv/2k5Pw0PNr4m53KjaMfMOCrWDT+G8h9TeYWKu7yG/8mp4N8r6GAUhcQeMgx3
         RdN2aYvT/cVgxWfRvitDNTSEKdPFcMg+rNlO/tTLZdXr1uOG3Hyr27UiUx6NW/NLkFEm
         XYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQf1Y/9SEKggx+5f5ZKuIoWmVfhEoCl+A3wEcz5w+LY=;
        b=Jm6cADC27Ged0P5GCOIXJTtSl+rqkRHmEqGldF+EUHUaao5E0X2O3WEDkK1hHDIiof
         sRye5RcSoV6KDcEJ2Nnc9a0e2sLILR95MjExYr+Mr5XSOuu5GwQvlFM+ScTzqoDT8x8S
         YBX2Fp1cX9iTVEzNyu0iTkhAF2oa6mKSPDt+HqdqEi7NoT7ZCDbTb53sroC9rtR4WHv6
         Shlun3PUzBZtOYmTDR+bTvporOJ70mXdwmwCy0OObGgk3Q0tWZ8SQJN9yXzxE/T9hrF4
         tDz2gRlqFHxXXCXVn92/4OAPVuJdBVorqDuSVMhmduAWGxD8uhAmwuUf2W3u/Bibpy2U
         +Y7Q==
X-Gm-Message-State: AJIora8kC4X/7kcUyTR70TNCmDd+DJf9EFeGUsfvBPjPIW1C6MO9pL4H
        pUKeCiOqT7Dh+tHpoFPRP09PuA==
X-Google-Smtp-Source: AGRyM1t7pENtWGGHfanhgrVu3zIWlInI7/GYtHGC+Acc92oGcO5ryKj+1voesnR0yqLHzlCPuO4Wbw==
X-Received: by 2002:a17:90a:4944:b0:1ec:7585:3167 with SMTP id c62-20020a17090a494400b001ec75853167mr1827195pjh.35.1655956170312;
        Wed, 22 Jun 2022 20:49:30 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b005254eb7627fsm1323314pfj.203.2022.06.22.20.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:49:29 -0700 (PDT)
Date:   Thu, 23 Jun 2022 11:49:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     syzbot <syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in folio_lruvec_lock_irqsave
Message-ID: <YrPixVCHk0ZEzcFp@FVFYT0MHHV2J.usts.net>
References: <0000000000004b03c805e2099bf0@google.com>
 <YrM2XCwzu65cb81r@FVFYT0MHHV2J.googleapis.com>
 <YrPQwPzyzfFoXFom@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPQwPzyzfFoXFom@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 23, 2022 at 10:32:32AM +0800, Muchun Song wrote:
> On Wed, Jun 22, 2022 at 11:33:48PM +0800, Muchun Song wrote:
> > On Wed, Jun 22, 2022 at 06:49:31AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    ac0ba5454ca8 Add linux-next specific files for 20220622
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14354c18080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=12809dacb9e7c5e0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ec972d37869318fc3ffb
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+ec972d37869318fc3ffb@syzkaller.appspotmail.com
> > > 
> > >  folio_put include/linux/mm.h:1227 [inline]
> > >  put_page+0x217/0x280 include/linux/mm.h:1279
> > >  unmap_and_move_huge_page mm/migrate.c:1343 [inline]
> > >  migrate_pages+0x3dc3/0x5a10 mm/migrate.c:1440
> > >  do_mbind mm/mempolicy.c:1332 [inline]
> > >  kernel_mbind+0x4d7/0x7d0 mm/mempolicy.c:1479
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > page has been migrated, last migrate reason: mempolicy_mbind
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 18925 at include/linux/memcontrol.h:800 folio_lruvec include/linux/memcontrol.h:800 [inline]
> > 
> > The warning here is "VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio)",
> > the memcg returned by folio_memcg() seems to be NULL which has 2 possibility, one is
> > that objcg returned by folio_objcg() is NULL, another is that obj_cgroup_memcg(objcg)
> > returns NULL. However, obj_cgroup_memcg() always returns a valid memcg. So Most likely
> > objcg is NULL meaning this page is not charged to memcg. Is this possible for LRU pages?
> > 
> > I am not sure if this issue is caused by my commit cca700a8e695 ("mm: lru: use lruvec
> 
> I have asked Andrew to drop this individual commit (to reduce potential impact) since
> this commit can be treated as a separate optimization patch compared to LRU page
> reparenting work.  I will resend this patch again after LRU page reparenting work
> stabilizes.
> 
> Thanks.
> 
> > lock to serialize memcg changes") since I have removed folio_test_clear_lru() check
> > from folio_batch_move_lru(). We know that a non-lru page may be not charged to memcg.
> > But is it possible for a non-lru page to be passed to folio_batch_move_lru()? Seems

Seems my guess is right. The console log said:

[ 2295.057051][T21698] page:ffffea00013f0000 refcount:3 mapcount:0 mapping:ffff88804394b830 index:0x0 pfn:0x4fc00
[ 2295.057088][T21698] head:ffffea00013f0000 order:9 compound_mapcount:0 compound_pincount:0
[ 2295.057112][T21698] aops:hugetlbfs_aops ino:4 dentry name:"SYSV00000000"
[ 2295.057200][T21698] flags: 0xfff0000001000c(uptodate|dirty|head|node=0|zone=1|lastcpupid=0x7ff)
[ 2295.057237][T21698] raw: 00fff0000001000c ffffea0000458008 ffffffff90f93ad8 ffff88804394b830
[ 2295.057261][T21698] raw: 0000000000000000 0000000000000002 00000003ffffffff 0000000000000000
[ 2295.057275][T21698] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[ 2295.057288][T21698] page_owner tracks the page as allocated
[ 2295.057295][T21698] page last allocated via order 9, migratetype Movable, gfp_mask 0x146cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 15372, tgid 15365 (syz-executor.2), ts 992774327150, free_ts 992742358974
[ 2295.057342][T21698]  get_page_from_freelist+0x1f18/0x3a40
[ 2295.057378][T21698]  __alloc_pages+0x1c7/0x510
[ 2295.057408][T21698]  alloc_fresh_huge_page+0x49a/0x700
[ 2295.057443][T21698]  alloc_surplus_huge_page+0x171/0x460
[ 2295.057478][T21698]  gather_surplus_pages+0x1e1/0x6c0
[ 2295.057513][T21698]  hugetlb_acct_memory.part.0+0x74/0xd0
[ 2295.057550][T21698]  hugetlb_reserve_pages+0x4d8/0xde0
[ 2295.057586][T21698]  hugetlbfs_file_mmap+0x40c/0x5c0
[ 2295.057610][T21698]  shm_mmap+0xf1/0x230
[ 2295.057666][T21698]  mmap_region+0x6bf/0x1bf0
[ 2295.057693][T21698]  do_mmap+0x825/0xf60
[ 2295.057725][T21698]  do_shmat+0xe42/0x10d0
[ 2295.057757][T21698]  __x64_sys_shmat+0xcc/0x160
[ 2295.057786][T21698]  do_syscall_64+0x35/0xb0
[ 2295.057844][T21698]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

This page is a HugeTLB page which should not be put to LRU list.  So I think the following diff can
fix this issue.

diff --git a/mm/swap.c b/mm/swap.c
index ae256e333713..a877a2324be8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -671,7 +671,7 @@ void deactivate_file_folio(struct folio *folio)
        struct folio_batch *fbatch;

        /* Deactivating an unevictable folio will not accelerate reclaim */
-       if (folio_test_unevictable(folio))
+       if (!folio_test_lru(folio) || folio_test_unevictable(folio))
                return;

        folio_get(folio);

> > impossible. Right? I am not very confident about this commit, hopefully, someone can
> > review it.
> > 
> > Thanks.
> > 
> > > WARNING: CPU: 1 PID: 18925 at include/linux/memcontrol.h:800 folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
> > > Modules linked in:
> > > CPU: 1 PID: 18925 Comm: syz-executor.3 Not tainted 5.19.0-rc3-next-20220622-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > RIP: 0010:folio_lruvec include/linux/memcontrol.h:800 [inline]
> > > RIP: 0010:folio_lruvec_lock_irqsave+0x2fd/0x4f0 mm/memcontrol.c:1424
> > > Code: 1f 44 00 00 45 31 e4 80 3d 06 3e da 0b 00 0f 85 01 fe ff ff 48 c7 c6 40 6f da 89 4c 89 f7 e8 0a 44 e2 ff c6 05 ea 3d da 0b 01 <0f> 0b e9 e4 fd ff ff e8 67 be ad 07 85 c0 0f 84 37 fd ff ff 80 3d
> > > RSP: 0018:ffffc9000b84f2c8 EFLAGS: 00010246
> > > RAX: 0000000000040000 RBX: fffff9400027e007 RCX: ffffc900135af000
> > > RDX: 0000000000040000 RSI: ffffffff81ce36a6 RDI: fffff52001709e28
> > > RBP: dffffc0000000000 R08: 000000000000003c R09: 0000000000000000
> > > R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000000
> > > R13: fffff9400027e000 R14: ffffea00013f0000 R15: 0000000000000000
> > > FS:  00007f5cfbb96700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000002073f000 CR3: 0000000074b9f000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  folio_lruvec_relock_irqsave include/linux/memcontrol.h:1666 [inline]
> > >  folio_batch_move_lru+0xf9/0x500 mm/swap.c:242
> > >  folio_batch_add_and_move+0xd4/0x130 mm/swap.c:258
> > >  deactivate_file_folio+0x222/0x580 mm/swap.c:678
> > >  invalidate_mapping_pagevec+0x38d/0x5c0 mm/truncate.c:535
> > >  drop_pagecache_sb+0xcf/0x2a0 fs/drop_caches.c:39
> > >  iterate_supers+0x13c/0x290 fs/super.c:694
> > >  drop_caches_sysctl_handler+0xdb/0x110 fs/drop_caches.c:62
> > >  proc_sys_call_handler+0x4a1/0x6e0 fs/proc/proc_sysctl.c:611
> > >  call_write_iter include/linux/fs.h:2057 [inline]
> > >  do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:742
> > >  do_iter_write+0x182/0x700 fs/read_write.c:868
> > >  vfs_iter_write+0x70/0xa0 fs/read_write.c:909
> > >  iter_file_splice_write+0x723/0xc70 fs/splice.c:689
> > >  do_splice_from fs/splice.c:767 [inline]
> > >  direct_splice_actor+0x110/0x180 fs/splice.c:936
> > >  splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
> > >  do_splice_direct+0x1a7/0x270 fs/splice.c:979
> > >  do_sendfile+0xae0/0x1240 fs/read_write.c:1262
> > >  __do_sys_sendfile64 fs/read_write.c:1321 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1313 [inline]
> > >  __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1313
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > RIP: 0033:0x7f5cfaa89109
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f5cfbb96168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> > > RAX: ffffffffffffffda RBX: 00007f5cfab9c030 RCX: 00007f5cfaa89109
> > > RDX: 0000000020002080 RSI: 0000000000000005 RDI: 0000000000000006
> > > RBP: 00007f5cfaae305d R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000262 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007fff1ef394df R14: 00007f5cfbb96300 R15: 0000000000022000
> > >  </TASK>
> > > 
> > > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > 
> > 
> 
