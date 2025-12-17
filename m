Return-Path: <cgroups+bounces-12412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D6CC6699
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39990312FA62
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7334107D;
	Wed, 17 Dec 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dusw2/39"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F934106A
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956809; cv=none; b=jf4e0hE/pXkA9WuzITmyUURyR4CHBkLIRd9kIw5apapNX4JPO7NhGmjiu9wF6hv8MDHby+6DR1gcwhXuRAqogDyl7iLLzVbw4HKMCGBwJKStfvRDrvdglWPz8cuwNO8V0qAtn7Ui5qTEr3WqSNBSbjfclPLqUcfInH4RR0Ukwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956809; c=relaxed/simple;
	bh=OHFZ0LNEpKuTW12Z6kaHmQe+wuzpZdGmCCr/dTwWHsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aai5pKbfWD0ZDfqbOLV0+Ks62lGrzlfHrBlZzlaibTrh9xjOZ0yL6zeNlU26X3AuKC/uI594spPjYtw+PmEDZMT/X6jggZMQtwdNq07WJJE63f9sxSuy0UTLrE9J3uRH11Mla7bcYg0PAOHlNUx814j9rZAe4MXc0Bqluqzj3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dusw2/39; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLWSJF0nLNh7N5C/0x5tciJKSygGd9RMW0b7OeDmmlY=;
	b=Dusw2/39bPZpCKgWRmixvObH3oye1W0d2l/EI+/2d4touyB7sDcx41H6ThV+apVJtk/Yzi
	Mh3NZrd4Dfg10moPMGz7Vru+UO3Po4bUjn2yLFwclZU0w1iEms+dNnGleWkuQpAKJ4cqlr
	7M4Gnng6vNejpEIsBHdQU/5f4k5uVa0=
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
Subject: [PATCH v2 22/28] mm: workingset: prevent lruvec release in workingset_activation()
Date: Wed, 17 Dec 2025 15:27:46 +0800
Message-ID: <195a8cb47b90e48cd1ec6cb93bc33a8e794847f6.1765956026.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in workingset_activation().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 427ca1a5625e8..d6484f7a3ad28 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -595,8 +595,11 @@ void workingset_activation(struct folio *folio)
 	 * Filter non-memcg pages here, e.g. unmap can call
 	 * mark_page_accessed() on VDSO pages.
 	 */
-	if (mem_cgroup_disabled() || folio_memcg_charged(folio))
+	if (mem_cgroup_disabled() || folio_memcg_charged(folio)) {
+		rcu_read_lock();
 		workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
+		rcu_read_unlock();
+	}
 }
 
 /*
-- 
2.20.1


