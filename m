Return-Path: <cgroups+bounces-13206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A94D1E7B2
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BEF2315D666
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE5396B8F;
	Wed, 14 Jan 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYiOKqSC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20F396B73
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390605; cv=none; b=hUYsFIQHGku8m47PQcIA+q76QbCM/vO3l3P9FijLvV9+AQ2MxVYTaVxgWrZMbfB1lsAdQCH6F+rWiH3cPPBdHckNsQRkuMNvAlnmLVw61tzbwrBAotUH25ChY5hXG+K+3Sn3J9lpIKvPpuAzfK+uYmiwbNl1iv6RrsYhznnYGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390605; c=relaxed/simple;
	bh=fOy6oVILIRVezRqIAkkMQR2mLcxOB6Vgz0y/UCKHqGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAfcgoJzMVeGWVRdhvetRxixbW0fmQUYIQ5PEDgScmuFlyG2GGt8jKbQwDZxm30P7UhRM07yqcGGEQpTIRnNqMNlDbF2MywHDO3qS8GYvVn+N4SsC7vPMvHgQgYCTgVLRLvg5qBiW+y7Bb9gNP/bBJjg7kTWVZfK2dTtGusYKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYiOKqSC; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs9GVF7LIvQ9XqxorxYvjeDNqFvIg9IUXns1kdaiOGk=;
	b=BYiOKqSCDSAyg1H55pIlV8GWS+W2vUkKXMGTEPXMRLHd59AdRVC7UHKdBOkHVj0waadkfD
	I7pwse5Im3PqcxJja4etRPmxO60fGbYA9zXJ6Nw0Cpn66iCq3No0LNMAp1azTCCas00j9S
	alQu2NJg/5YUInMj4TcfygSsqTffRdI=
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
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 30/30] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
Date: Wed, 14 Jan 2026 19:32:57 +0800
Message-ID: <de04c58aca36fbf1f2b4f06d5b4c79a35a856a8d.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

We must ensure the folio is deleted from or added to the correct lruvec
list. So, add VM_WARN_ON_ONCE_FOLIO() to catch invalid users. The
VM_BUG_ON_PAGE() in move_pages_to_lru() can be removed as
add_page_to_lru_list() will perform the necessary check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index fa2d6ba811b53..ad50688d89dba 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -342,6 +342,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_add_folio(lruvec, folio, false))
 		return;
 
@@ -356,6 +358,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_add_folio(lruvec, folio, true))
 		return;
 
@@ -370,6 +374,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_del_folio(lruvec, folio, false))
 		return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6bc8047b7aec5..56714f3bc6f88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1939,7 +1939,6 @@ static unsigned int move_folios_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
 		lruvec_add_folio(lruvec, folio);
 		nr_pages = folio_nr_pages(folio);
 		nr_moved += nr_pages;
-- 
2.20.1


