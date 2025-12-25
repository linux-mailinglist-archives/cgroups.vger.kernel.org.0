Return-Path: <cgroups+bounces-12734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B8CDE2AD
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3921300C6D3
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E82C0F6E;
	Thu, 25 Dec 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wK8SnNRU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007422C08A8
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766705002; cv=none; b=Ty7MRw5QHEqx36KLTY9DDjgQ9jjkVAOtpSt0FMn1RMG0OvHwXwnNvFFnm0Lpzev7o9Bcyrs78z9WxPBpaU7Lr+lx5f8w6HgTiqgOo+ZI8a5o6CGssp/aoYe+8euP9aAqQVYhw3bslcMADM+C4YIJyPtgiemEicJmW5d97WLB9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766705002; c=relaxed/simple;
	bh=BHUaYQ2SOvX9SLyQ8sr8h3ipQ7+x6bAYum/l5cnUuYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFAOQlfMSTSOcqk83OEvqW3zrKDeuRaMSgAHd7rstrZ5oqrq5rmnJYyOzn6FRshYVNgSeaRfC30DPz3qhzpq8q6LL4ivBep5RpDE6gkq03f40uwAMTtPqEDK/LjNf0vUypiqYDxnqhFFodXyb4hStPxR6MGZHQ0gOGKhjGMIdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wK8SnNRU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpBdbnOOzwb8ZbK7UEBGlSGeYSG5qka67j2LUFyR/ao=;
	b=wK8SnNRUM+obbgwNDLw8wPAU74br+bFne6Qn2KeZ5l2hSZ+3DWjbscYBBjXr68/7gdx1g2
	unc7D8bhz2pfNQaWQvFJ7/qahdnoD2wTfLWKgEiDURM3DvaSCnfvYNIhy2nJsNIFflmQ9g
	No/uUKzufd7eR+DI/Mz5Yv9RbchG2jc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] memcg: remove unused mem_cgroup_id() and mem_cgroup_from_id()
Date: Thu, 25 Dec 2025 15:21:15 -0800
Message-ID: <20251225232116.294540-8-shakeel.butt@linux.dev>
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that all callers have been converted to use either:
 - The private ID APIs (mem_cgroup_private_id/mem_cgroup_from_private_id)
   for internal kernel objects that outlive their cgroup
 - The public cgroup ID APIs (mem_cgroup_ino/mem_cgroup_get_from_ino)
   for external interfaces

Remove the unused wrapper functions mem_cgroup_id() and
mem_cgroup_from_id() along with their !CONFIG_MEMCG stubs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 18 ------------------
 mm/memcontrol.c            |  5 -----
 2 files changed, 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c823150ec288..3e7d69020b39 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -830,12 +830,6 @@ static inline unsigned short mem_cgroup_private_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id);
 
-static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
-{
-	return mem_cgroup_private_id(memcg);
-}
-struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
-
 static inline u64 mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return memcg ? cgroup_id(memcg->css.cgroup) : 0;
@@ -1282,18 +1276,6 @@ static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 }
 
-static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
-{
-	return 0;
-}
-
-static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
-{
-	WARN_ON_ONCE(id);
-	/* XXX: This should always return root_mem_cgroup */
-	return NULL;
-}
-
 static inline unsigned short mem_cgroup_private_id(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ff2f9bd820c..ede39dde05df 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3615,11 +3615,6 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return xa_load(&mem_cgroup_private_ids, id);
 }
 
-struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
-{
-	return mem_cgroup_from_private_id(id);
-}
-
 struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
 {
 	struct cgroup *cgrp;
-- 
2.47.3


