Return-Path: <cgroups+bounces-258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADC7E615D
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4821C20B64
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D651809;
	Thu,  9 Nov 2023 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQWf7Pw9"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9F7FC;
	Thu,  9 Nov 2023 00:25:32 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211A268D;
	Wed,  8 Nov 2023 16:25:31 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5b9a7357553so252156a12.0;
        Wed, 08 Nov 2023 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489531; x=1700094331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of70rUTdf0QdbQCNfJN7g62PDHTFajfmsuYYkD/l5Bw=;
        b=WQWf7Pw9JwFJf774rZF45x/Vdl/cXxILHNIcKpk28BcACAAMrHkSQnDXCkhz07z5o0
         wi/bRLe1j8SkjGP3I0sJRFaw/hYiYCocbOarQ6foMsUzM0EB81EkxVvT7wsRIrjmnewe
         oDy0gg86aYCAw0gN1Alhe18ZI3DVbXYpk9rKmyZusSM7U1iHcQID29FnGC0WDFLc7Kdx
         Ualvry6J8LGU1I2xVBJb1cKP+rbmtjsz+rFNs/pC9Ey8MdYyu5clMGI9eu78qyBYE4J9
         oekXTyWot+RTts+rDJwHu3dUJr19RUjPcjtgdGDcyRDF7e5x9Uz/7VQpHxdJc2aNvSZc
         Zxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489531; x=1700094331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of70rUTdf0QdbQCNfJN7g62PDHTFajfmsuYYkD/l5Bw=;
        b=q0HKKolO9Y4z7SEaFQpqEyxsPFMDHN0kc2yr2IepSbeCOn+f5y5bcRUqWp4/k8EmsY
         h41ALRtDoGpAZMwtyU3s2m0PHI/K+rJSfw7VOGFHJJ3l5Xvx1HvAf5G/CdnOlhJdnnkP
         D5vLs+vOYXqAS57aUXWcbhf8NHnQMyxjxvXbPOLjEYEdUOrIqj/l8a0AfgSOqtd3Y2qt
         q4I28zBD0PhUrOOo+39Fz83xn8M5DTjkvaONwUR4/uBsodvh+WbOEDccWZrOTwQGDTaq
         e4zOibWIvxysWiNZous519isLUai/Bc9iTHYnms6K39f5ZXSGqr6Zx+JBwBHDqqrw/7+
         0h9A==
X-Gm-Message-State: AOJu0Yx790v4VXMRoi481g8zBF72S7NRM0iBYB2yiEBHUXO1/1uBktmF
	/M+WOXXKixhPbvOgTfqNHjNCmiAaitep
X-Google-Smtp-Source: AGHT+IHbwFVdwphwt7gr3UzzhUHfqfxDv14F7XVPq9KZV1yJ2tp1Uqm1Do7o8FIgS8mNhqzO/PmdGQ==
X-Received: by 2002:a05:6a21:7985:b0:180:d17a:7677 with SMTP id bh5-20020a056a21798500b00180d17a7677mr3646043pzc.36.1699489531028;
        Wed, 08 Nov 2023 16:25:31 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bc21222e34sm2219073plr.285.2023.11.08.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:25:30 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ying.huang@intel.com,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v4 2/3] mm/mempolicy: implement weighted interleave
Date: Wed,  8 Nov 2023 19:25:16 -0500
Message-Id: <20231109002517.106829-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements interleave weighting for bandwidth optimization.

The mempolicy MPOL_INTERLEAVE utilizes the node weights to implement
weighted interleave.

There are 3 integration points:

interleave_nodes:
  Counts the number of allocations as they occur, and applies the
  weight for the current node.  When the weight reaches 0, switch
  to the next node.

offset_il_node:
  Gets the total weight of the nodemask as well as each individual
  node weight, then calculates the node based on the given index n.

bulk_array_interleave:
  Gets the total weight of the nodemask as well as each individual
  node weight, then calculates the number of "interleave rounds" as
  well as any delta ("partial round").  Calculates the number of
  pages for each node and allocates them.

  If a node was scheduled for interleave via interleave_nodes, the
  current weight (pol->cur_weight) will be allocated first, before
  the remaining bulk calculation is done. This simplifies the
  calculation at the cost of an additional allocation call.

The functions mempolicy_get_il_weight and mempolicy_get_il_weights
were added so that should mempolicy be extended in the future to
include local mempolicy weights, there is a clear integration point.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h |   3 +
 mm/mempolicy.c            | 153 +++++++++++++++++++++++++++++++-------
 2 files changed, 128 insertions(+), 28 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..b1ca63077fc4 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -48,6 +48,9 @@ struct mempolicy {
 	nodemask_t nodes;	/* interleave/bind/perfer */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
+	unsigned char cur_weight;  /* weight of current il node */
+	unsigned char il_weights[MAX_NUMNODES]; /* used during allocation */
+
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 29ebf1e7898c..231b9bbd391a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -300,6 +300,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->cur_weight = 0;
 
 	return policy;
 }
@@ -334,6 +335,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 		tmp = *nodes;
 
 	pol->nodes = tmp;
+	pol->cur_weight = 0;
 }
 
 static void mpol_rebind_preferred(struct mempolicy *pol,
@@ -881,8 +883,10 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && new->mode == MPOL_INTERLEAVE) {
 		current->il_prev = MAX_NUMNODES-1;
+		new->cur_weight = 0;
+	}
 	task_unlock(current);
 	mpol_put(old);
 	ret = 0;
@@ -1900,15 +1904,50 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	return nd;
 }
 
+static unsigned char mempolicy_get_il_weight(struct mempolicy *policy,
+					     unsigned int nid)
+{
+	int weight = mem_cgroup_get_il_weight(nid);
+
+	return weight ? weight : 1;
+}
+
+static unsigned int mempolicy_get_il_weights(struct mempolicy *policy,
+					     nodemask_t *nodes,
+					     unsigned char *weights)
+{
+	unsigned int total = 0;
+	unsigned int nid;
+
+	total = mem_cgroup_get_il_weights(nodes, weights);
+	if (total)
+		return total;
+
+	for_each_node_mask(nid, *nodes) {
+		weights[nid] = 1;
+		total += 1;
+	}
+	return total;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
 	unsigned next;
+	unsigned char next_weight;
 	struct task_struct *me = current;
 
 	next = next_node_in(me->il_prev, policy->nodes);
-	if (next < MAX_NUMNODES)
+	if (!policy->cur_weight) {
+		/* If the node is set, at least 1 allocation is required */
+		next_weight = mempolicy_get_il_weight(policy, next);
+		policy->cur_weight = next_weight ? next_weight : 1;
+	}
+
+	policy->cur_weight--;
+	if (next < MAX_NUMNODES && !policy->cur_weight)
 		me->il_prev = next;
+
 	return next;
 }
 
@@ -1967,8 +2006,8 @@ unsigned int mempolicy_slab_node(void)
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
 	nodemask_t nodemask = pol->nodes;
-	unsigned int target, nnodes;
-	int i;
+	unsigned int target, nnodes, il_weight;
+	unsigned char weight;
 	int nid;
 	/*
 	 * The barrier will stabilize the nodemask in a register or on
@@ -1982,10 +2021,18 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
-	target = (unsigned int)n % nnodes;
+
+	il_weight = mempolicy_get_il_weights(pol, &nodemask, pol->il_weights);
+	target = (unsigned int)n % il_weight;
 	nid = first_node(nodemask);
-	for (i = 0; i < target; i++)
-		nid = next_node(nid, nodemask);
+
+	while (target) {
+		weight = pol->il_weights[nid];
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
 	return nid;
 }
 
@@ -2319,32 +2366,82 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
-	int nodes;
-	unsigned long nr_pages_per_node;
-	int delta;
-	int i;
-	unsigned long nr_allocated;
+	struct task_struct *me = current;
 	unsigned long total_allocated = 0;
+	unsigned long nr_allocated;
+	unsigned long rounds;
+	unsigned long node_pages, delta;
+	unsigned char weight;
+	unsigned long il_weight;
+	unsigned long req_pages = nr_pages;
+	int nnodes, node, prev_node;
+	int i;
 
-	nodes = nodes_weight(pol->nodes);
-	nr_pages_per_node = nr_pages / nodes;
-	delta = nr_pages - nodes * nr_pages_per_node;
-
-	for (i = 0; i < nodes; i++) {
-		if (delta) {
-			nr_allocated = __alloc_pages_bulk(gfp,
-					interleave_nodes(pol), NULL,
-					nr_pages_per_node + 1, NULL,
-					page_array);
-			delta--;
-		} else {
-			nr_allocated = __alloc_pages_bulk(gfp,
-					interleave_nodes(pol), NULL,
-					nr_pages_per_node, NULL, page_array);
+	prev_node = me->il_prev;
+	nnodes = nodes_weight(pol->nodes);
+	/* Continue allocating from most recent node */
+	if (pol->cur_weight) {
+		node = next_node_in(prev_node, pol->nodes);
+		node_pages = pol->cur_weight;
+		if (node_pages > nr_pages)
+			node_pages = nr_pages;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/* if that's all the pages, no need to interleave */
+		if (req_pages <= pol->cur_weight) {
+			pol->cur_weight -= req_pages;
+			return total_allocated;
 		}
-
+		/* Otherwise we adjust req_pages down, and continue from there */
+		req_pages -= pol->cur_weight;
+		pol->cur_weight = 0;
+		prev_node = node;
+	}
+
+	il_weight = mempolicy_get_il_weights(pol, &pol->nodes,
+					     pol->il_weights);
+	rounds = req_pages / il_weight;
+	delta = req_pages % il_weight;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, pol->nodes);
+		weight = pol->il_weights[node];
+		node_pages = weight * rounds;
+		if (delta > weight) {
+			node_pages += weight;
+			delta -= weight;
+		} else if (delta) {
+			node_pages += delta;
+			delta = 0;
+		}
+		/* The number of requested pages may not hit every node */
+		if (!node_pages)
+			break;
+		/* If an over-allocation would occur, floor it */
+		if (node_pages + total_allocated > nr_pages) {
+			node_pages = nr_pages - total_allocated;
+			delta = 0;
+		}
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
+		prev_node = node;
+	}
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->cur_weight
+	 * If the last node allocated on has un-used weight, apply
+	 * the remainder as the cur_weight, otherwise proceed to next node
+	 */
+	if (node_pages) {
+		me->il_prev = prev_node;
+		node_pages %= weight;
+		pol->cur_weight = weight - node_pages;
+	} else {
+		me->il_prev = node;
+		pol->cur_weight = 0;
 	}
 
 	return total_allocated;
-- 
2.39.1


