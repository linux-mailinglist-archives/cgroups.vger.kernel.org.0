Return-Path: <cgroups+bounces-5280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725709B15C5
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA637B21B33
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541917E00E;
	Sat, 26 Oct 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MoOsBK0K"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ACD7083C
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729926732; cv=none; b=pVa7UxOOSTBzHobhORIPZd7uoVJg4viNWosflUFD7Mi+mc+wTPru7D7OzSynclCpyavOCB3CouzZ2LVwN60z1C0jFrx6Ids//hQ4gwLbHQT2pK6dt5VRwpL4VPaHrf5WKde61MGpmYFAmLGyOp5+0y/SEHFjvDheYNU+IzxIaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729926732; c=relaxed/simple;
	bh=XDML6MBeqH9GTywNpsaCBldEoQEmJ5QjMHiS4ludu9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TikorWfigks83FMJ8sumQ4XyGU2EB7XRUWeYt3n7kW5lKC41oed05he/5ZZMrmj7s3pqOjzXxKbXXjSskmyIkHZ0GnlcNCqdnVMQ1VbVcHYv2Yvilsx2NyqB11y+jO9C5rPTlcGvGdD486Hl0cfD4UpdIORrRtMsd6kU3O6M7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MoOsBK0K; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729926727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GxQOGmQPdgw5Cv/LfTKFz+nlFJDJQN96Dif2xmEC5v8=;
	b=MoOsBK0KzMJ5rNWJ9B2Hf9HOvvhnjmEahVjjoMdczDmHzO7F19hXEYtfn4+JwsIoP3Yjsb
	MhtDC5RvwwYjrtHLqgm+f7k/MbWy1+sKZDC95w6r6tc0rt+QVZ5psu6uh1kQYmGYxXMGbD
	ct1sldQHsH3uIhYL6Lvog1T76qr2hUU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH] memcg: workingset: remove folio_memcg_rcu usage
Date: Sat, 26 Oct 2024 00:11:45 -0700
Message-ID: <20241026071145.3287517-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function workingset_activation() is called from
folio_mark_accessed() with the guarantee that the given folio can not be
freed under us in workingset_activation(). In addition, the association
of the folio and its memcg can not be broken here because charge
migration is no more. There is no need to use folio_memcg_rcu. Simply
use folio_memcg_charged() because that is what this function cares
about.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Yu Zhao <yuzhao@google.com>
---

Andrew, please put this patch after the charge migration deprecation
series.

 include/linux/memcontrol.h | 35 -----------------------------------
 mm/workingset.c            | 10 ++--------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 932534291ca2..89a1e9f10e1b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -443,35 +443,6 @@ static inline bool folio_memcg_charged(struct folio *folio)
 	return __folio_memcg(folio) != NULL;
 }
 
-/**
- * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
- * @folio: Pointer to the folio.
- *
- * This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios.
- *
- * Return: A pointer to the memory cgroup associated with the folio,
- * or NULL.
- */
-static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
-{
-	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-}
-
 /*
  * folio_memcg_check - Get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
@@ -1084,12 +1055,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return NULL;
 }
 
-static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return NULL;
-}
-
 static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
 	return NULL;
diff --git a/mm/workingset.c b/mm/workingset.c
index 4b58ef535a17..c47aa482fad5 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -591,9 +591,6 @@ void workingset_refault(struct folio *folio, void *shadow)
  */
 void workingset_activation(struct folio *folio)
 {
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
 	/*
 	 * Filter non-memcg pages here, e.g. unmap can call
 	 * mark_page_accessed() on VDSO pages.
@@ -601,12 +598,9 @@ void workingset_activation(struct folio *folio)
 	 * XXX: See workingset_refault() - this should return
 	 * root_mem_cgroup even for !CONFIG_MEMCG.
 	 */
-	memcg = folio_memcg_rcu(folio);
-	if (!mem_cgroup_disabled() && !memcg)
-		goto out;
+	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
+		return;
 	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
-out:
-	rcu_read_unlock();
 }
 
 /*
-- 
2.43.5


