Return-Path: <cgroups+bounces-16284-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB+9Fi0WFWpoSgcAu9opvQ
	(envelope-from <cgroups+bounces-16284-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDD5D0677
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D6D9300AD83
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4F3A6B89;
	Tue, 26 May 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOqS2xMY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32B3659FB
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766802; cv=none; b=YDVta9mJvwtlxqTl8vZ+rkAgL8zhCM2nIa3fiijseDEMegxjR63JyDyxiq0j5/JzhIpFeBcqGnvhyrhRhY+/kFMXwtAgySS2deOBxJnxAcLId/Yy61A4Q1XTXdJMzGL3hJb/izudRmXAPermCfU6dPGrg8vY9ilA057Y1pT51ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766802; c=relaxed/simple;
	bh=vEkRq3gc4x7XgLRH1/Exa1P6r4/ooj7Ohe9F4HT/gRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0IAGH3a1HSIeGxBxM25r0TBAojtMAne76R/jOKlK2glNPilic+mjHf3XUPREJg0ckDadGKD2HjD8ZOiFgJzBBUroFhlrFHenYe81o8CaFq4O7sAis2O2qrSDgYOHiJ7dtFluRomT00rSQT2am43QCUjPnqpJLc1N9uBmEFeS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOqS2xMY; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779766789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIys55gPtHxFJ6YYkvug3PyqOz22t6XWNtWG1R8os4w=;
	b=VOqS2xMYTt93PtKO1VfGDeSlnh+9Tjw856bjZFZc/Ckt9sKz1geFSMDUUDXxB3778ZsyaL
	pGFWQTP6HXiirfV8Oo1Au2LTOT6r/J0/6z2JSKSIBkQrMejmRj637jsJQHsoKAkHTct7Nj
	cDsIKs7h5e76PzZ5VauqdqC0djcq3wI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3 1/4] memcg: store node_id instead of pglist_data pointer
Date: Mon, 25 May 2026 20:39:28 -0700
Message-ID: <20260526033931.1760588-2-shakeel.butt@linux.dev>
In-Reply-To: <20260526033931.1760588-1-shakeel.butt@linux.dev>
References: <20260526033931.1760588-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-16284-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 6DEDD5D0677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The struct obj_stock_pcp stores a pointer to pglist_data for the slab
stats cached on the cpu. On 64-bit machines, this costs 8 bytes. The
pointer is not strictly required: NODE_DATA() can recover it from the
node id. Replace cached_pgdat with int16_t node_id and use NUMA_NO_NODE
as the "no stats cached" sentinel.

At the moment all the archs limit MAX_NUMNODES to 1024 so int16_t is
plenty; a BUILD_BUG_ON() makes sure we notice if that ever changes.

Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Tested-by: kernel test robot <oliver.sang@intel.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1 & v2:
- Added tags in the commit message

 mm/memcontrol.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 13f5d4b2a78e..9bee9031171f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2022,7 +2022,7 @@ struct obj_stock_pcp {
 	local_trylock_t lock;
 	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
-	struct pglist_data *cached_pgdat;
+	int16_t node_id;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
 
@@ -2032,6 +2032,7 @@ struct obj_stock_pcp {
 
 static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
 	.lock = INIT_LOCAL_TRYLOCK(lock),
+	.node_id = NUMA_NO_NODE,
 };
 
 static DEFINE_MUTEX(percpu_charge_mutex);
@@ -3162,6 +3163,13 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 {
 	int *bytes;
 
+	/*
+	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
+	 * sure it does not exceed S16_MAX otherwise we need to fix node_id type
+	 * in struct obj_stock_pcp.
+	 */
+	BUILD_BUG_ON(MAX_NUMNODES >= S16_MAX);
+
 	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
 		goto direct;
 
@@ -3169,9 +3177,11 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat changes.
 	 */
-	if (stock->cached_pgdat != pgdat) {
+	if (stock->node_id == NUMA_NO_NODE) {
+		stock->node_id = pgdat->node_id;
+	} else if (stock->node_id != pgdat->node_id) {
 		/* Flush the existing cached vmstat data */
-		struct pglist_data *oldpg = stock->cached_pgdat;
+		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
 
 		if (stock->nr_slab_reclaimable_b) {
 			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
@@ -3183,7 +3193,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
-		stock->cached_pgdat = pgdat;
+		stock->node_id = pgdat->node_id;
 	}
 
 	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
@@ -3279,19 +3289,21 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 	 * Flush the vmstat data in current stock
 	 */
 	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
+		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
+
 		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, oldpg,
 					  NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, oldpg,
 					  NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
-		stock->cached_pgdat = NULL;
+		stock->node_id = NUMA_NO_NODE;
 	}
 
 	WRITE_ONCE(stock->cached_objcg, NULL);
-- 
2.53.0-Meta


