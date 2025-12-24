Return-Path: <cgroups+bounces-12630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC773CDB477
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855BA300FE15
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20862EA168;
	Wed, 24 Dec 2025 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lvjG7KPr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690C4A35
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547977; cv=none; b=t9MRPhONYGdVtlsol1Owh+bTZqG2VzQ5Cu+d+dFm6InXyzJ7Bnw1EREMLz96ez63NSwoQy1G6B2+mJw3hjzsZgkdvDTvA43QFNANfZ8+lFSkD0rkUQKSueWiZDP1QlnjSL3PMT3L6Un6Tp0s6+nsKYlHkyka9JxFii268qYE7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547977; c=relaxed/simple;
	bh=iHvGdso28WEtSoP+2m3AYidMECha6ww3ar+AohPHQpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyIiiCQhTl3R72KVUNZAMBY2TSLIBIu8B+Oabl2uKvwBBxcPatxk6zTj/UgzjsC00x6FdoEohJz61r9o9vTd6VNG5/MuGdwI9y9/TNQHA7gswS4Les4krHQRaOJJBPW5egqPHCCHDEEZIrnMIsx3VTdQ9YJkT4E6ge4yCgtRTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lvjG7KPr; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766547962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SypNxq4ihkSOpwufXMhOr4v6vA4rTimGBEpmyUwAS38=;
	b=lvjG7KPr3mKzGajh8YrxhwMJQ1a8J2HScnYZq9MVlcn/asADajOhFVEAb9UP2H6Bmk6H5X
	2x7u/CdWwkIWl873VSWvPxx0RKUKhnKYDX/UxembPa88QErwNyTOmYs1kp+l08BjT30A+/
	SWXYO/277sqa4GJjcRD1rR4oDyisjQQ=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: damon: get memcg reference before access
Date: Tue, 23 Dec 2025 19:45:27 -0800
Message-ID: <20251224034527.3751306-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit b74a120bcf507 ("mm/damon/core: implement
DAMOS_QUOTA_NODE_MEMCG_USED_BP") added accesses to memcg structure
without getting reference to it. This is unsafe. Let's get the reference
before accessing the memcg.

Fixes: b74a120bcf507 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/damon/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4ad5f290d382..89982e0229f0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2051,13 +2051,15 @@ static unsigned long damos_get_node_memcg_used_bp(
 
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(goal->memcg_id);
-	rcu_read_unlock();
-	if (!memcg) {
+	if (!memcg || !mem_cgroup_tryget(memcg)) {
+		rcu_read_unlock();
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 			return 0;
 		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
 			return 10000;
 	}
+	rcu_read_unlock();
+
 	mem_cgroup_flush_stats(memcg);
 	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
 	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
@@ -2065,6 +2067,8 @@ static unsigned long damos_get_node_memcg_used_bp(
 	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
 	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
 
+	mem_cgroup_put(memcg);
+
 	si_meminfo_node(&i, goal->nid);
 	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 		numerator = used_pages;
-- 
2.47.3


