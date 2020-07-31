Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81FD234CC0
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgGaVOT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 17:14:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:49415 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgGaVOT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 31 Jul 2020 17:14:19 -0400
IronPort-SDR: 3VaBLj2IOBGb8V5QfRvIcDNKdtKpvoUdrkq60bbke8ZyM9u8sJ7Pmkd4c7gVmtihMacWmkHaca
 goF218ZntJoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="151074467"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="151074467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 14:14:18 -0700
IronPort-SDR: HCByFcJfDHuvlCPmBTSbpM+7/9LR9XGUoyxIA6CLKTQXzi2LS8ZBBR5E4moE+Dk9E/JPGlOEL1
 QbvQqKMOyETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="287297713"
Received: from eaarrasx-mobl.amr.corp.intel.com (HELO ahduyck-desk1.jf.intel.com) ([10.212.61.153])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2020 14:14:16 -0700
Subject: [PATCH RFC] mm: Add function for testing if the current lruvec lock
 is valid
From:   alexander.h.duyck@intel.com
To:     alex.shi@linux.alibaba.com
Cc:     akpm@linux-foundation.org, alexander.duyck@gmail.com,
        aryabinin@virtuozzo.com, cgroups@vger.kernel.org,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        iamjoonsoo.kim@lge.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lkp@intel.com, mgorman@techsingularity.net,
        richard.weiyang@gmail.com, rong.a.chen@intel.com,
        shakeelb@google.com, tglx@linutronix.de, tj@kernel.org,
        willy@infradead.org, yang.shi@linux.alibaba.com
Date:   Fri, 31 Jul 2020 14:14:16 -0700
Message-ID: <159622999150.2576729.14455020813024958573.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

When testing for relock we can avoid the need for RCU locking if we simply
compare the page pgdat and memcg pointers versus those that the lruvec is
holding. By doing this we can avoid the extra pointer walks and accesses of
the memory cgroup.

In addition we can avoid the checks entirely if lruvec is currently NULL.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/memcontrol.h |   52 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6e670f991b42..7a02f00bf3de 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -405,6 +405,22 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+	const struct mem_cgroup *memcg;
+	struct mem_cgroup_per_node *mz;
+
+	if (mem_cgroup_disabled())
+		return lruvec == &pgdat->__lruvec;
+
+	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	memcg = page->mem_cgroup ? : root_mem_cgroup;
+
+	return lruvec->pgdat == pgdat && mz->memcg == memcg;
+}
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
@@ -880,6 +896,14 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
 	return &pgdat->__lruvec;
 }
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+		pg_data_t *pgdat = page_pgdat(page);
+
+		return lruvec == &pgdat->__lruvec;
+}
+
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
@@ -1317,18 +1341,12 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
-	bool locked;
+	if (locked_lruvec) {
+		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+			return locked_lruvec;
 
-	rcu_read_lock();
-	locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
-	rcu_read_unlock();
-
-	if (locked)
-		return locked_lruvec;
-
-	if (locked_lruvec)
 		unlock_page_lruvec_irq(locked_lruvec);
+	}
 
 	return lock_page_lruvec_irq(page);
 }
@@ -1337,18 +1355,12 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 		struct lruvec *locked_lruvec, unsigned long *flags)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
-	bool locked;
-
-	rcu_read_lock();
-	locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
-	rcu_read_unlock();
-
-	if (locked)
-		return locked_lruvec;
+	if (locked_lruvec) {
+		if (lruvec_holds_page_lru_lock(page, locked_lruvec))
+			return locked_lruvec;
 
-	if (locked_lruvec)
 		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
+	}
 
 	return lock_page_lruvec_irqsave(page, flags);
 }


