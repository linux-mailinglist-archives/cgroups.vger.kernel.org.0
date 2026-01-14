Return-Path: <cgroups+bounces-13224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A52D213B6
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB223078881
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556A3559FC;
	Wed, 14 Jan 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV+dwNDx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A0357A32
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423991; cv=none; b=K/RFKF+JEFb746zOPq6zFptE5grH3ekKwlVlGpMSjKAEEQ7xFul1Z1Yx1hEgwY3pQpvFGUU7eDdWAXxheeHsRKy4XoJrZA/+lCOONk42v5ex8X1ogLw5axV/ZZ80yuiUsgqWqiepZJz/ay9MDEGGyYtJs48Ueg84PeMHFag2nNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423991; c=relaxed/simple;
	bh=9B0HAws0jD6ktvEqCEUvq5OCM9p89Vzub9JqPk8brWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k6ir+nVuIANZpQs6KUMoPQSff1897OxPIN1XSIOpGb6KebX1nKeBgQsyZ+fznlDPodbCpNYMSKPr+0Lkvdf7+caoG2Lqn7nF1pawuu1Z3x1SsFn1lFrL9LCD6/rDejxYbpz+fecvovynMPqToJOG2lSoPYt3eopIG+6wDOf9Hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV+dwNDx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1233b91de6bso349203c88.1
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768423989; x=1769028789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCsRJ41+Ggq8G+xRjLn+/BFhG0UFmGF8M8WZhyAL+Ls=;
        b=MV+dwNDx3WDh5Q2Hcv0ZS66h9V3205AxXvfXKMhmwuPFRI4TOcJf6jy6Ljo1qNNeFV
         TlDQ+XYPPwL1vBVDn8vM6l6fO8SJ8PI6OhzFxU93JqVDmtwULkL5VtfR9LLb2GmzCa1A
         R3JyUsmCENAPCgwgOSeI3GXAelLgshVQvEdcRc8FViP1RkKkqGN1hLzFCKU22s6K34F5
         1JGiWcJeMxvpwgtWIRLjAPK+qBj2DXGpTVVal+9V5BVABVghTk7O4q32gokZxw+Qvo/U
         ZrWcrCSqQ0JpJWLSgZyD1fFZbXFbZ4qLH91achfhBEcFTPJYx0GkCViIucRZ2tWU//jN
         vYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423989; x=1769028789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCsRJ41+Ggq8G+xRjLn+/BFhG0UFmGF8M8WZhyAL+Ls=;
        b=u0JIx/u0+DZwZ85MQb2hUOczjhKRZcZsQa03sI7Tlf1hfyW9aEd5sYhfXmfAN6S9MG
         TJdaah0YzoT642MbsGxOwE9UCBTOx8XWoW2Qcftihq+V+AzQVGBap3Va/x+OZ2qGNsB0
         ohszWiOjZ9HDB1NaDr0p99i7zsjFm4akWJ3FuCrjA9ubwsHENgjtRVcO+2c+QQccNeHD
         Z9DHgAJweoG7YIWMClkeCrWuvJS0pezhfQo2egxBxuS5vAVAdJ3O37AAkFt8647XOXuC
         mrheAtNJX+9qBhA6jWsEy9y9xmcYjgskIn75Bvd+z77idHKfHH6TkPqW8J41Zk6MuvXL
         UvCg==
X-Forwarded-Encrypted: i=1; AJvYcCXaGzE9hfQDqq8VhrxaHDb77sZa6FBVxalyykkORcrp38FXw5i8RyPtDpF2muDRJd674q7n64Li@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbbgbYMj+1AmLJrmiE94RmzcDCM4zsNTQBx/UgDNxnYqKlxNE
	KNJHymPNZ/crrGTilWoO/Um5DGfD6sGSZ7zLvJcLGrNXMpOp+XcGpvt5iiGZ+/DdoTwEh42PehB
	hmkE83A3d5DFNRA==
X-Received: from dybic39.prod.google.com ([2002:a05:7300:c727:b0:2a4:612e:b41f])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701a:ca03:b0:11b:923d:7753 with SMTP id a92af1059eb24-12336a12704mr4017500c88.3.1768423989308;
 Wed, 14 Jan 2026 12:53:09 -0800 (PST)
Date: Wed, 14 Jan 2026 20:53:03 +0000
In-Reply-To: <20260114205305.2869796-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260114070053.2446770-1-bingjiao@google.com> <20260114205305.2869796-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114205305.2869796-3-bingjiao@google.com>
Subject: [PATCH v9 2/2] mm/vmscan: select the closest perferred node in demote_folio_list()
From: Bing Jiao <bingjiao@google.com>
To: bingjiao@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	tj@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The preferred demotion node (migration_target_control.nid) should be the
one closest to the source node to minimize migration latency.  Currently,
a discrepancy exists where demote_folio_list() randomly selects an allowed
node if the preferred node from next_demotion_node() is not set in
mems_effective.

To address it, update next_demotion_node() to select a preferred target
against allowed nodes; and to return the closest demotion target if all
preferred nodes are not in mems_effective via next_demotion_node().

It ensures that the preferred demotion target is consistently the closest
available node to the source node.

Signed-off-by: Bing Jiao <bingjiao@google.com>
---
v7 -> v8:
Fix bugs in v7.
Remove the while loop of getting the preferred node via
next_demotion_node().
Use find_next_best_node() to find the closest demotion target.

v8 -> v9:
Move allowed node checks and identification of the closest demotion
target into next_demotion_node() for better function splitting.

 include/linux/memory-tiers.h |  6 +++---
 mm/memory-tiers.c            | 21 ++++++++++++++++-----
 mm/vmscan.c                  |  5 ++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 7a805796fcfd..96987d9d95a8 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -53,11 +53,11 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 						  struct list_head *memory_types);
 void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
-int next_demotion_node(int node);
+int next_demotion_node(int node, const nodemask_t *allowed_mask);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
 #else
-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, const nodemask_t *allowed_mask)
 {
 	return NUMA_NO_NODE;
 }
@@ -101,7 +101,7 @@ static inline void clear_node_memory_type(int node, struct memory_dev_type *memt

 }

-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, const nodemask_t *allowed_mask)
 {
 	return NUMA_NO_NODE;
 }
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 864811fff409..2d6c3754e6a8 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -320,16 +320,17 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
+ * @allowed_mask: The pointer to allowed node mask
  *
  * Return: node id for next memory node in the demotion path hierarchy
  * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
  * @node online or guarantee that it *continues* to be the next demotion
  * target.
  */
-int next_demotion_node(int node)
+int next_demotion_node(int node, const nodemask_t *allowed_mask)
 {
 	struct demotion_nodes *nd;
-	int target;
+	nodemask_t mask;

 	if (!node_demotion)
 		return NUMA_NO_NODE;
@@ -344,6 +345,10 @@ int next_demotion_node(int node)
 	 * node_demotion[] reads need to be consistent.
 	 */
 	rcu_read_lock();
+	/* Filter out nodes that are not in allowed_mask. */
+	nodes_and(mask, nd->preferred, *allowed_mask);
+	rcu_read_unlock();
+
 	/*
 	 * If there are multiple target nodes, just select one
 	 * target node randomly.
@@ -356,10 +361,16 @@ int next_demotion_node(int node)
 	 * caching issue, which seems more complicated. So selecting
 	 * target node randomly seems better until now.
 	 */
-	target = node_random(&nd->preferred);
-	rcu_read_unlock();
+	if (!nodes_empty(mask))
+		return node_random(&mask);

-	return target;
+	/*
+	 * Preferred nodes are not in allowed_mask. Filp bits in
+	 * allowed_mask as used node mask. Then, use it to get the
+	 * closest demotion target.
+	 */
+	nodes_complement(mask, *allowed_mask);
+	return find_next_best_node(node, &mask);
 }

 static void disable_all_demotion_targets(void)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5ea1dd2b8cce..7a631de46064 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1048,12 +1048,11 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (nodes_empty(allowed_mask))
 		return 0;

-	target_nid = next_demotion_node(pgdat->node_id);
+	target_nid = next_demotion_node(pgdat->node_id, &allowed_mask);
 	if (target_nid == NUMA_NO_NODE)
 		/* No lower-tier nodes or nodes were hot-unplugged. */
 		return 0;
-	if (!node_isset(target_nid, allowed_mask))
-		target_nid = node_random(&allowed_mask);
+
 	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
--
2.52.0.457.g6b5491de43-goog


