Return-Path: <cgroups+bounces-11246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CADC15074
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D07189D98E
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758443346B6;
	Tue, 28 Oct 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m5pB3ZWQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2B331A4A
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660133; cv=none; b=WzOe99+IJTbk6GT4ql2s2+nfUJdJoh6g5fWXKCY2YefBbn0nWqWxNq5SYnxSaItC8ljBOUntyfua/xpKcGvqusbbNATi4mBtANPbsBD3Avz4jqowPoK7GEL/Ve/BiDJaLjnT9Vcc33v1ekP1Qv4EJDpzfg3aE2HEljmG4KWn7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660133; c=relaxed/simple;
	bh=ubuHyVoQfOTWzax2RiUiR/WKVhO7tZd2MTZFWOARtno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCIF0BhaySFV8Up9O5h5QcRK+VwA9L7/Ct0lyVhWyduo+76TrL1hVNMXy8Yat9ghRBI6QJXHNLFw1ZOBjWq9EtgLw6Tu5M5yUlREi12Q85P7YNfyo5ya8Sg8fNKcnr6fLaHsJvu1bF95qpioWuVtRqPtrInrxL8r4S3/ZNd1lcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m5pB3ZWQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moQWsyM34kheODhB4m6le5EmBuxmXNZC4RNHBl5yhm4=;
	b=m5pB3ZWQxP+sPvfEGsIWUd01+4Ud8CDRin+yJXxv+vXSeS/tvgW6+9V1cnAIEUEP3kL5MZ
	RaHdbjXmDsivF+rDsb1cYJID3SmV1vSRE9OWuD5IA/+/ky8Jp1kroJNOvTdF4t7i7+aH52
	RZkxvRVNH2wWtx9OLxFAJtiTkeNOIqU=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 01/26] mm: memcontrol: remove dead code of checking parent memory cgroup
Date: Tue, 28 Oct 2025 21:58:14 +0800
Message-ID: <b13ff669bc3f52922e97fa0cc99e54df05585810.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

Since the no-hierarchy mode has been deprecated after the commit:

  commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").

As a result, parent_mem_cgroup() will not return NULL except when passing
the root memcg, and the root memcg cannot be offline. Hence, it's safe to
remove the check on the returned value of parent_mem_cgroup(). Remove the
corresponding dead code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 5 -----
 mm/shrinker.c   | 6 +-----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 93f7c76f0ce96..d5257465c9d75 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3339,9 +3339,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		return;
 
 	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	memcg_reparent_list_lrus(memcg, parent);
 
 	/*
@@ -3632,8 +3629,6 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 			break;
 		}
 		memcg = parent_mem_cgroup(memcg);
-		if (!memcg)
-			memcg = root_mem_cgroup;
 	}
 	return memcg;
 }
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4a93fd433689a..e8e092a2f7f41 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -286,14 +286,10 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 {
 	int nid, index, offset;
 	long nr;
-	struct mem_cgroup *parent;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct shrinker_info *child_info, *parent_info;
 	struct shrinker_info_unit *child_unit, *parent_unit;
 
-	parent = parent_mem_cgroup(memcg);
-	if (!parent)
-		parent = root_mem_cgroup;
-
 	/* Prevent from concurrent shrinker_info expand */
 	mutex_lock(&shrinker_mutex);
 	for_each_node(nid) {
-- 
2.20.1


