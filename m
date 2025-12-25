Return-Path: <cgroups+bounces-12689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F5CDD27C
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 01:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAAB3026A9A
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1F19E968;
	Thu, 25 Dec 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u0/s1HHP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BE1494C3
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766622576; cv=none; b=NRlO4iYjMSqCmJX40spLM+BS7ZKYQFM9CqZw6QBQjYW7wZLi7ZEIv5i1dXP8h6m1MJ+xoTuhZylllejwfANf7dpVT6ymyGkzc8lXDJt/eeN3nNZk2/5QiDBJRA8glyzudD0tZbUGkhm7Y0iwjsMJ0TciWZgy/wArsWko3D1RAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766622576; c=relaxed/simple;
	bh=4FQytIhVIzXZMikPaItf/j18QYRslFIgfG3U7DUBtho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXtEIE2kt2ndF2lYYatIlexW8ndIBooK3CHBZN4Mh/ZiXTXHC3mQgsYaEDN2AB4uu5ztq3mhWRiH1tM9XvEljA56a0fG41aCdyliCQMbMSbYdJ77DDUtfbjWGahfzmEHSrxmdFnPw5a3/VQKJ6gQnS9Il0ZZV2zzvvw2VDK/Rto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u0/s1HHP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766622560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a6/TuFgHDhkQPqtZC3cXUeXixV3IdjP9zJRQmDjzS7I=;
	b=u0/s1HHPacfKvQQHZLVvK3I8siddC98FD4MUpujV9KIwdGqDxzF+xqMNUFlJXs+Gtbvp1y
	XwvgQ/kDtVyG+BNBAtdFHUVBC21vcrcWZbpjMBG9DbaIvaDCWcmuab0iX1O7s3CVDvarSG
	WN2LsF682W2XPgFKuH+W7pR1o7RNxbs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2] mm/damon/core: get memcg reference before access
Date: Wed, 24 Dec 2025 16:29:04 -0800
Message-ID: <20251225002904.139543-1-shakeel.butt@linux.dev>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
---
Changes since v1:
- Changed the subject as requested by SJ.

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


