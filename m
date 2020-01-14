Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF113A393
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 10:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgANJQ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 04:16:27 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54422 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgANJQ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 04:16:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TniOLoy_1578993382;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TniOLoy_1578993382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 17:16:23 +0800
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
To:     Hugh Dickins <hughd@google.com>
Cc:     hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
 <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com>
 <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
 <alpine.LSU.2.11.2001130032170.1103@eggly.anvils>
 <24d671ac-36ef-8883-ad94-1bd497d46783@linux.alibaba.com>
 <alpine.LSU.2.11.2001131157500.1084@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <641e4c96-c79f-fbdd-9762-f4608961423c@linux.alibaba.com>
Date:   Tue, 14 Jan 2020 17:14:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2001131157500.1084@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> I tried with the mods you had appended, from [PATCH v7 02/10]
> discussion with Konstantion: no, still crashes in a similar way.> 
> Does your github tree have other changes too?  I see it says "Latest
> commit e05d0dd 22 days ago", which doesn't seem to fit.  Afraid I
> don't have time to test many variations.

Thanks a lot for testing! the github version is same as your tested.
The github branches page has a bug, it don't show correct update time.
https://github.com/alexshi/linux/branches while detailed page does. 
https://github.com/alexshi/linux/tree/lru-next 
> 
> It looks like, in my case, systemd was usually jumping in and doing
> something with shmem (perhaps via memfd) that read back from swap
> and triggered the crash without any further intervention from me.
> 
> So please try booting with mem=700M and 1.5G swap,
> mount -t tmpfs -o size=470M tmpfs /tst
> cp /dev/zero /tst; cp /tst/zero /dev/null
> 
> That's enough to crash it for me, without getting into any losetup or
> systemd complications. But you might have to adjust the numbers to be
> sure of writing out and reading back from swap.
> 
> It's swap to SSD in my case, don't think that matters. I happen to
> run with swappiness 100 (precisely to help generate swap problems),
> but swappiness 60 is good enough to get these crashes.
> 

I did use 700M memory and 1.5G swapfile in my qemu, but with a swapfile
not a disk.
qemu-system-x86_64  -smp 4 -enable-kvm -cpu SandyBridge \
	-m 700M -kernel /home/kuiliang.as/linux/qemulru/arch/x86/boot/bzImage \
	-append "earlyprintk=ttyS0 root=/dev/sda1 console=ttyS0 debug crashkernel=128M printk.devkmsg=on " \
	-hda /home/kuiliang.as/rootimages/CentOS-7-x86_64-Azure-1703.qcow2 \
	-hdb /home/kuiliang.as/rootimages/hdb.qcow2 \
	--nographic \

Anyway, although I didn't reproduced the bug. but I found a bug in my
debug function:
	VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);

 if !page->mem_cgroup, the bug could be triggered, so, seems it's a bug
for debug function, not real issue. The 9th patch should be replaced by
the following new patch. 

Many thanks for testing!
Alex

From ac6d3e2bcfba5727d5c03f9655bb0c7443f655eb Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Mon, 23 Dec 2019 13:33:54 +0800
Subject: [PATCH v8 8/9] mm/lru: add debug checking for page memcg moving

This debug patch could give some clues if there are sth out of
consideration.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h |  5 +++++
 mm/compaction.c            |  2 ++
 mm/memcontrol.c            | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 09e861df48e8..ece88bb11d0f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -421,6 +421,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *);
 struct lruvec *lock_page_lruvec_irqsave(struct page *, unsigned long*);
 void unlock_page_lruvec_irq(struct lruvec *);
 void unlock_page_lruvec_irqrestore(struct lruvec *, unsigned long);
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
@@ -1183,6 +1184,10 @@ static inline
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/mm/compaction.c b/mm/compaction.c
index 8c0a2da217d8..151242817bf4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -971,6 +971,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked_lruvec = lruvec;
 
+			lruvec_memcg_debug(lruvec, page);
+
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 00fef8ddbd08..a473da8d2275 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1238,6 +1238,17 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!page->mem_cgroup)
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+	else
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+}
+
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
@@ -1247,6 +1258,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	spin_lock_irq(&lruvec->lru_lock);
 
+	lruvec_memcg_debug(lruvec, page);
 	return lruvec;
 }
 
@@ -1259,6 +1271,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	lruvec_memcg_debug(lruvec, page);
 	return lruvec;
 }
 
-- 
2.22.0

