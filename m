Return-Path: <cgroups+bounces-12960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6531D00E04
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 04:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67F13301294A
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8225A659;
	Thu,  8 Jan 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bba9Jat9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9422DA1C
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843174; cv=none; b=qlkl3MA6OVCgZsdrmc40fjaPU7V7U5SrP/ma3BKM7gcimOR6r8My83+9NQQ0e42Hq/wOBq/1pnDdlkfM0137gTcr0dW6pkzsOcDFkP8BklL/9iPP4moM8TLOQNBD6+5mFLaHqSL1lseDftb5rrqs7b1ewRdJjfzCyibcEie/Eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843174; c=relaxed/simple;
	bh=O1H9cupxImTjG4VSJ+SQ9gmFZN5OaflzX60g018VxZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hee8AWMIBRLb7MXEzIFm8L6+8rGJ22hRX5t4q/0OrKYDLSULFRSmQ8WCRCyiWaepjsolMX4hRiweU49/+ey+YU0AErGMl+sC7VucDVOcnFwMBk6VcoDDMqY2V3Mplr0E6pSMjQfddJ0cMZaqQ/IjsJgJsmWQ42yX8BzflksLwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bba9Jat9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-121b1cb8377so3400555c88.0
        for <cgroups@vger.kernel.org>; Wed, 07 Jan 2026 19:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767843172; x=1768447972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLgkCamneE/qgvT8SRDRrY5Fa+Nn2NhKwpUQgrc0C+o=;
        b=Bba9Jat9G345BFR6Mt7050E8DfqERFsulIjdFC+2jC9vA3ackaKRQwHR6+5ul3d+7d
         yOcimVh15/EQhXGIVCNH/z2aN+olhBSuqgMORb9HV4/aVxtoFSWTK2XXsztjaXFh+xzY
         m2g/W+xgg1O081tDj8Au5DmfDMQ87coaq0o3BPyOUr/XSDZt+ihuIwbTxA5i+EVIL1nI
         vBbmmHnt2AuhE64fDEkj1M99W4xhslLszJE3+CTXBuzCAq+qblyh29wYU6NnjD4KOcW6
         z1HwCX4iPgtGO97PJUKElYv4lmUBUvbGJV8M3aySkc2Mit2urz3KcHhCXVeFd/DAgsX4
         TxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843172; x=1768447972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLgkCamneE/qgvT8SRDRrY5Fa+Nn2NhKwpUQgrc0C+o=;
        b=RmHR9S7yPB8n76vidoB8GmjLGUT9peS9EEC9BnPMNWt+6yJNVnRY73fOFk3/RfnnTM
         KlPaQil7BJH+XU9afE50DExqfadofHJaskasfbvM1Km7sdM5mp35jo29NcLJfaIe3zok
         RcATsaqj4OtmTJ217IYEF3H3NDujg4PeOXOW3ykANaigyBGtVOgi8f3hYdOkl0U5xFtR
         v7aXuT+LNdnURDtmYRBp8E9Y/3iYO2wKfK2vPycIOL/Gj7HL/s7tOHr+QEL/O+e9MUp1
         tdOPd/bgT9rX6arm7nYn+PYZJsvKXR5LItv5STjfAc3lG1gAmKjl2zZ0O0FxQFDMWR1t
         dS4w==
X-Forwarded-Encrypted: i=1; AJvYcCX31z0KRHUNAkWL/2v1N8QKr9EvCRxyzQSXWvI4cKoU/3dKeo//1mhsF1/XTgYW6ddZQ2nPHrBY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyknx2a+aBPJ1si3SpC765+L2SPuu8uwlzdczOBZ3xzZ7avUc84
	LHR3BQjTM/ISZo4OTw07omyHahpyL1/ocAep6PZb0prfsYFJobK2vME4QEE6IfXFs4vOkNtvPS7
	g5Fpmb5+/eEVJPA==
X-Google-Smtp-Source: AGHT+IHSAuslRhY4gBeVWlWCY57NP//mIwPdmFsednmABv35QVXB/P5EPW9tyKa6wChhWbzbdD3cD9E5vhcVPg==
X-Received: from dlbdx24.prod.google.com ([2002:a05:7022:e18:b0:11d:cd2a:4c1b])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:629a:b0:11b:9386:a386 with SMTP id a92af1059eb24-121f8b8ded3mr4212238c88.41.1767843172292;
 Wed, 07 Jan 2026 19:32:52 -0800 (PST)
Date: Thu,  8 Jan 2026 03:32:47 +0000
In-Reply-To: <20260108033248.2791579-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260106075703.1420072-1-bingjiao@google.com> <20260108033248.2791579-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108033248.2791579-3-bingjiao@google.com>
Subject: [PATCH v7 2/2] mm/vmscan: select the closest preferred node in demote_folio_list()
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, gourry@gourry.net, 
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, 
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com, 
	cgroups@vger.kernel.org, joshua.hahnjy@gmail.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"

The preferred demotion node (migration_target_control.nid) should be
the one closest to the source node to minimize migration latency.
Currently, a discrepancy exists where demote_folio_list() randomly
selects an allowed node if the preferred node from next_demotion_node()
is not set in mems_allowed.

To address it, update next_demotion_node() to return preferred nodes,
allowing the caller to select the preferred one.
Also update demote_folio_list() to traverse the demotion targets
hierarchically until a preferred node within mems_allowed is found.
It ensures that the selected demotion target is consistently
the closest available node.

Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 include/linux/memory-tiers.h |  6 +++---
 mm/memory-tiers.c            | 11 +++++++----
 mm/vmscan.c                  | 25 ++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 7a805796fcfd..87652042f2c2 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -53,11 +53,11 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 						  struct list_head *memory_types);
 void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
-int next_demotion_node(int node);
+int next_demotion_node(int node, nodemask_t *preferred_nodes);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
 #else
-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, nodemask_t *preferred_nodes)
 {
 	return NUMA_NO_NODE;
 }
@@ -101,7 +101,7 @@ static inline void clear_node_memory_type(int node, struct memory_dev_type *memt

 }

-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, nodemask_t *preferred_nodes)
 {
 	return NUMA_NO_NODE;
 }
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 864811fff409..286e4b5fa0e5 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -320,13 +320,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
+ * @preferred_nodes: The pointer to nodemask of all preferred nodes to return
  *
  * Return: node id for next memory node in the demotion path hierarchy
- * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
- * @node online or guarantee that it *continues* to be the next demotion
- * target.
+ * from @node; NUMA_NO_NODE if @node is terminal. Also returns all preferred
+ * nodes in @preferred_nodes. This does not keep @node online or guarantee
+ * that it *continues* to be the next demotion target.
  */
-int next_demotion_node(int node)
+int next_demotion_node(int node, nodemask_t *preferred_nodes)
 {
 	struct demotion_nodes *nd;
 	int target;
@@ -357,6 +358,8 @@ int next_demotion_node(int node)
 	 * target node randomly seems better until now.
 	 */
 	target = node_random(&nd->preferred);
+	if (preferred_nodes)
+		nodes_copy(*preferred_nodes, nd->preferred);
 	rcu_read_unlock();

 	return target;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 94ff5aa7c4fb..213ee75b3306 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1024,9 +1024,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 				      struct pglist_data *pgdat,
 				      struct mem_cgroup *memcg)
 {
-	int target_nid = next_demotion_node(pgdat->node_id);
+	int target_nid;
 	unsigned int nr_succeeded;
 	nodemask_t allowed_mask;
+	nodemask_t preferred;

 	struct migration_target_control mtc = {
 		/*
@@ -1052,8 +1053,26 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (nodes_empty(allowed_mask))
 		return 0;

-	if (!node_isset(target_nid, allowed_mask))
-		target_nid = node_random(&allowed_mask);
+	target_nid = next_demotion_node(pgdat->node_id, &preferred);
+	while (target_nid != NUMA_NO_NODE &&
+	       !node_isset(target_nid, allowed_mask)) {
+		/* Filter out preferred nodes that are not in allowed. */
+		nodes_and(preferred, preferred, allowed_mask);
+		if (!nodes_empty(preferred)) {
+			/* Randomly select one node from preferred. */
+			target_nid = node_random(&preferred);
+			break;
+		}
+		/*
+		 * Preferred nodes in the lower tier are not set in allowed.
+		 * Recursively get preferred from the next lower tier.
+		 */
+		target_nid = next_demotion_node(target_nid, &preferred);
+	}
+
+	if (target_nid == NUMA_NO_NODE)
+		/* Nodes are gone (e.g., hot-unplugged). */
+		return 0;
 	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
--
2.52.0.457.g6b5491de43-goog


