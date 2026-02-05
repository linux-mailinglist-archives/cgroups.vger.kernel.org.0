Return-Path: <cgroups+bounces-13687-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO4YE1BchGmn2gMAu9opvQ
	(envelope-from <cgroups+bounces-13687-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:01:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C215FF0334
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24D1F303A08E
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0381239A7FB;
	Thu,  5 Feb 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQqg/kep"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF238B999
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281811; cv=none; b=TrObzEVXEgdDyks6mImuD7ruJVJLMzHuhIHIRd1MJ1cNmUflrCYzJ/SZSKUPZu5k9OWOrhIguYmVZAwWmRXyqc4kftvEqFqfQ+vONA9rZPLV8+GHqDUYWasv6ZzDGgOhgYtx8sJPEEh5sd88QQtZVBvNvsCuQLtsjXlIue8TKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281811; c=relaxed/simple;
	bh=uzE6TRk/TNOR7vo41OybiszMLChJXprovsBl4pjzAno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1JPTb2bQzsh/DooWPN55RXRWhBtkgoP64k/gl7EaT93GDt53w57W0LTTaoNRKPBIV4Z/xqWRrQk8aB5+yAcrteh69i25tlTuHmDKligqkB6cYc1crCte8RPj7QBD9wNtmynnATnbuksCz6s+hpq2uVr6rTpuY7qVycSz7IQYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQqg/kep; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770281809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePJPKwGbZY5Eb95/OlXPN5o4YPM+nBdgDWiBKLLcLus=;
	b=PQqg/kepkrulz0AapoHwpSjj9QiJxWd4sGacVD6KgiymVlXgQu0ZTQm4ApMiK8+3st79uk
	XLu1AvC1xDsRJdvEFJFnsc4qO7kcMebA3kyosTz03MTnB3ewI57aMgkiOo7KIR7ucrWP8c
	rCfdqA3sYn+aVRw+5zkj/ansmZWBFTQ=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH v4 03/31] mm: rename unlock_page_lruvec_irq and its variants
Date: Thu,  5 Feb 2026 16:54:32 +0800
Message-ID: <edcfaf55e476356f104145ad7c35facbfdd7315f.1770279888.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1770279888.git.zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13687-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RSPAMD_EMAILBL_FAIL(0.00)[roman.gushchin.linux.dev:query timed out,chenridong.huawei.com:query timed out,david.kernel.org:query timed out];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C215FF0334
X-Rspamd-Action: no action

From: Muchun Song <songmuchun@bytedance.com>

It is inappropriate to use folio_lruvec_lock() variants in conjunction
with unlock_page_lruvec() variants, as this involves the inconsistent
operation of locking a folio while unlocking a page. To rectify this, the
functions unlock_page_lruvec{_irq, _irqrestore} are renamed to
lruvec_unlock{_irq,_irqrestore}.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            | 14 +++++++-------
 mm/huge_memory.c           |  2 +-
 mm/mlock.c                 |  2 +-
 mm/swap.c                  | 12 ++++++------
 mm/vmscan.c                |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index af352cabedbae..6a44e79a8bd23 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1480,17 +1480,17 @@ static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
 }
 
-static inline void unlock_page_lruvec(struct lruvec *lruvec)
+static inline void lruvec_unlock(struct lruvec *lruvec)
 {
 	spin_unlock(&lruvec->lru_lock);
 }
 
-static inline void unlock_page_lruvec_irq(struct lruvec *lruvec)
+static inline void lruvec_unlock_irq(struct lruvec *lruvec)
 {
 	spin_unlock_irq(&lruvec->lru_lock);
 }
 
-static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
+static inline void lruvec_unlock_irqrestore(struct lruvec *lruvec,
 		unsigned long flags)
 {
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
@@ -1512,7 +1512,7 @@ static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
-		unlock_page_lruvec_irq(locked_lruvec);
+		lruvec_unlock_irq(locked_lruvec);
 	}
 
 	return folio_lruvec_lock_irq(folio);
@@ -1526,7 +1526,7 @@ static inline void folio_lruvec_relock_irqsave(struct folio *folio,
 		if (folio_matches_lruvec(folio, *lruvecp))
 			return;
 
-		unlock_page_lruvec_irqrestore(*lruvecp, *flags);
+		lruvec_unlock_irqrestore(*lruvecp, *flags);
 	}
 
 	*lruvecp = folio_lruvec_lock_irqsave(folio, flags);
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c6..c3e338aaa0ffb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -913,7 +913,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -964,7 +964,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			}
 			/* for alloc_contig case */
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 
@@ -1053,7 +1053,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (unlikely(page_has_movable_ops(page)) &&
 			    !PageMovableOpsIsolated(page)) {
 				if (locked) {
-					unlock_page_lruvec_irqrestore(locked, flags);
+					lruvec_unlock_irqrestore(locked, flags);
 					locked = NULL;
 				}
 
@@ -1158,7 +1158,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
@@ -1226,7 +1226,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_fail_put:
 		/* Avoid potential deadlock in freeing page under lru_lock */
 		if (locked) {
-			unlock_page_lruvec_irqrestore(locked, flags);
+			lruvec_unlock_irqrestore(locked, flags);
 			locked = NULL;
 		}
 		folio_put(folio);
@@ -1242,7 +1242,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 */
 		if (nr_isolated) {
 			if (locked) {
-				unlock_page_lruvec_irqrestore(locked, flags);
+				lruvec_unlock_irqrestore(locked, flags);
 				locked = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
@@ -1274,7 +1274,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_abort:
 	if (locked)
-		unlock_page_lruvec_irqrestore(locked, flags);
+		lruvec_unlock_irqrestore(locked, flags);
 	if (folio) {
 		folio_set_lru(folio);
 		folio_put(folio);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d487649e4ded..580376323124c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3899,7 +3899,7 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 		folio_ref_unfreeze(folio, folio_cache_ref_count(folio) + 1);
 
 		if (do_lru)
-			unlock_page_lruvec(lruvec);
+			lruvec_unlock(lruvec);
 
 		if (ci)
 			swap_cluster_unlock(ci);
diff --git a/mm/mlock.c b/mm/mlock.c
index 2f699c3497a57..66740e16679c3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -205,7 +205,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	folios_put(fbatch);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index bb19ccbece464..245ba159e01d7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -91,7 +91,7 @@ static void page_cache_release(struct folio *folio)
 
 	__page_cache_release(folio, &lruvec, &flags);
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
 void __folio_put(struct folio *folio)
@@ -175,7 +175,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	}
 
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	folios_put(fbatch);
 }
 
@@ -349,7 +349,7 @@ void folio_activate(struct folio *folio)
 
 	lruvec = folio_lruvec_lock_irq(folio);
 	lru_activate(lruvec, folio);
-	unlock_page_lruvec_irq(lruvec);
+	lruvec_unlock_irq(lruvec);
 	folio_set_lru(folio);
 }
 #endif
@@ -963,7 +963,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 		if (folio_is_zone_device(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			if (folio_ref_sub_and_test(folio, nr_refs))
@@ -977,7 +977,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		/* hugetlb has its own memcg */
 		if (folio_test_hugetlb(folio)) {
 			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
+				lruvec_unlock_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
 			free_huge_folio(folio);
@@ -991,7 +991,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		j++;
 	}
 	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+		lruvec_unlock_irqrestore(lruvec, flags);
 	if (!j) {
 		folio_batch_reinit(folios);
 		return;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 01d3364fe506f..a4892f5e3d347 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1836,7 +1836,7 @@ bool folio_isolate_lru(struct folio *folio)
 		folio_get(folio);
 		lruvec = folio_lruvec_lock_irq(folio);
 		lruvec_del_folio(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 		ret = true;
 	}
 
@@ -7878,7 +7878,7 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
 	if (lruvec) {
 		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-		unlock_page_lruvec_irq(lruvec);
+		lruvec_unlock_irq(lruvec);
 	} else if (pgscanned) {
 		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 	}
-- 
2.20.1


