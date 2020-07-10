Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9221B127
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2020 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJIYS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 04:24:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60707 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgGJIYS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 04:24:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2HLiLc_1594369452;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2HLiLc_1594369452)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 16:24:13 +0800
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
 <20200706113513.GY25523@casper.infradead.org>
 <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
 <20200709154816.wieg5thfejyv2h2l@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e87f7dd1-41c4-3392-f1df-982dd28c0617@linux.alibaba.com>
Date:   Fri, 10 Jul 2020 16:23:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200709154816.wieg5thfejyv2h2l@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/9 ÏÂÎç11:48, Kirill A. Shutemov Ð´µÀ:
> On Mon, Jul 06, 2020 at 09:52:34PM -0700, Hugh Dickins wrote:
>> On Mon, 6 Jul 2020, Matthew Wilcox wrote:
>>> On Mon, Jul 06, 2020 at 05:15:09PM +0800, Alex Shi wrote:
>>>> Hi Kirill & Johannes & Matthew,
>>
>> Adding Kirill, who was in patch's Cc list but not mail's Cc list.
>>
>> I asked Alex to direct this one particularly to Kirill and Johannes
>> and Matthew because (and I regret that the commit message still does
>> not make this at all clear) this patch changes the lock ordering:
>> which for years has been lru_lock outside memcg move_lock outside
>> i_pages lock, but here inverted to lru_lock inside i_pages lock.
>>
>> I don't see a strong reason to have them one way round or the other,
>> and think Alex is right that they can safely be reversed here: but
>> he doesn't actually give any reason for doing so (if cleanup, then
>> I think the cleanup should have been taken further), and no reason
>> for doing so as part of this series.
> 
> I've looked around and changing order of lru_lock wrt. i_pages lock seems
> safe. I don't have much experience with memcg move_lock.

Hi Kirill,

Thanks for response!
mem_cgroup_move_account(page) could not reach here since 2 blocks,
1, isolate_lru_page() before it will take page from lru, this compete for
   page reclaim path, list non-null.

2, try_lock_page in it, will guard split_huge_page(), !list.

> 
> Alex, if you are going ahead with the patch, please document the locking
> order. We have some locking orders listed at the beginning of filemap.c
> and rmap.c.

Thanks for reminder!
Hugh Dickins did this in above 2 files at the end of patchset, any comments?

diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..1b42aaae4d3e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -101,8 +101,8 @@
  *    ->swap_lock		(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->i_pages lock		(try_to_unmap_one)
- *    ->pgdat->lru_lock		(follow_page->mark_page_accessed)
- *    ->pgdat->lru_lock		(check_pte_range->isolate_lru_page)
+ *    ->lruvec->lru_lock	(follow_page->mark_page_accessed)
+ *    ->lruvec->lru_lock	(check_pte_range->isolate_lru_page)
  *    ->private_lock		(page_remove_rmap->set_page_dirty)
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d5e56be42f21..926d7d95dc1d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3057,7 +3057,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 /*
- * Because tail pages are not marked as "used", set it. We're under
+ * Because tail pages are not marked as "used", set it. Don't need
  * lruvec->lru_lock and migration entries setup in all page mappings.
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
diff --git a/mm/rmap.c b/mm/rmap.c
index 5fe2dedce1fc..7fbc382e6f9e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -28,12 +28,12 @@
  *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *           anon_vma->rwsem
  *             mm->page_table_lock or pte_lock
- *               pgdat->lru_lock (in mark_page_accessed, isolate_lru_page)
  *               swap_lock (in swap_duplicate, swap_info_get)
  *                 mmlist_lock (in mmput, drain_mmlist and others)
  *                 mapping->private_lock (in __set_page_dirty_buffers)
- *                   mem_cgroup_{begin,end}_page_stat (memcg->move_lock)
+ *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
  *                     i_pages lock (widely used)
+ *                       lock_page_lruvec_irq lruvec->lru_lock
  *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
  *                 bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
  *                   sb_lock (within inode_lock in fs/fs-writeback.c)

> 
> local_irq_disable() also deserves a comment.
> 

yes, I will add a comment for this. Do you mind give reviewed-by for this patch?

Thanks
Alex
