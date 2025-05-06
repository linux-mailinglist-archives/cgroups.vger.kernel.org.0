Return-Path: <cgroups+bounces-8044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9326AAD12D
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86F81C0234C
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1421C18D;
	Tue,  6 May 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iSjtP7kZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0227610D;
	Tue,  6 May 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572162; cv=none; b=lNK8+myNEvsf04+sXUkozXQgPeFenHAZLNKL+00e0YEtLdGhPZobvbBvoce1VugQv6IlFlz+eqTfcFiLG4ouAJlPgJ3bIZo0/FrKP5Nze7IZvJ+T6oSaAu8tN3UycAHVnfb+Vt79+1MW+7GZ8QlVRIIBc3/HYXkkXpfH8uySO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572162; c=relaxed/simple;
	bh=hgDnOk091a2SDBWDtm9E/QTPNSNLsUmS0GA8gvXeYcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs+vMmFT7y7SkaEPHhyZW8k6nvrwdM9pn+obgrMJVPTaPt/ReyKzswXsWbmF6gJ0Dyxs8jtX80XOtDCAEivt36yu/FCMuAzz8FY9qKwWA18gnfTDlsJp/MU++FjtHx11ZCxs0jiosJoe5fB3xzKtzJomV3AEGQHMxenyY6k0eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iSjtP7kZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746572157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+q7Zfy+PEXSZi9n40T4a1BJaXa9SzRLJNKzWtXA3xc=;
	b=iSjtP7kZmALU52Zfo7EVlqEX0JO2Oj2pl4FpW9j/rJu6q6ZogQsaII5F4yOR+xPnStVBow
	Do6Xap5yivv1BYV9ZPq5gQU1UcSsj9p3rNtvl9Ze+LY/iy4fYdceo216vtENZt0fHMHMri
	UIDbkO9EGdVSYdZhnYFnvchYBg5RGg8=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/4] memcg: simplify consume_stock
Date: Tue,  6 May 2025 15:55:30 -0700
Message-ID: <20250506225533.2580386-2-shakeel.butt@linux.dev>
In-Reply-To: <20250506225533.2580386-1-shakeel.butt@linux.dev>
References: <20250506225533.2580386-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The consume_stock() does not need to check gfp_mask for spinning and can
simply trylock the local lock to decide to proceed or fail. No need to
spin at all for local lock.

One of the concern raised was that on PREEMPT_RT kernels, this trylock
can fail more often due to tasks having lock_lock can be preempted. This
can potentially cause the task which have preempted the task having the
local_lock to take the slow path of memcg charging.

However this behavior will only impact the performance if memcg charging
slowpath is worse than two context switches and possibly scheduling
delay behavior of current code. From the network intensive workload
experiment it does not seem like the case.

We ran varying number of netperf clients in different cgroups on a 72 CPU
machine for PREEMPT_RT config.

 $ netserver -6
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

number of clients | Without series | With series
  6               | 38559.1 Mbps   | 38652.6 Mbps
  12              | 37388.8 Mbps   | 37560.1 Mbps
  18              | 30707.5 Mbps   | 31378.3 Mbps
  24              | 25908.4 Mbps   | 26423.9 Mbps
  30              | 22347.7 Mbps   | 22326.5 Mbps
  36              | 20235.1 Mbps   | 20165.0 Mbps

We don't see any significant performance difference for the network
intensive workload with this series.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c44124ea3d08..7561e12ca0e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1808,16 +1808,14 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
  * @nr_pages: how many pages to charge.
- * @gfp_mask: allocation mask.
  *
- * The charges will only happen if @memcg matches the current cpu's memcg
- * stock, and at least @nr_pages are available in that stock.  Failure to
- * service an allocation will refill the stock.
+ * Consume the cached charge if enough nr_pages are present otherwise return
+ * failure. Also return failure for charge request larger than
+ * MEMCG_CHARGE_BATCH or if the local lock is already taken.
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			  gfp_t gfp_mask)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
@@ -1825,12 +1823,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	bool ret = false;
 	int i;
 
-	if (nr_pages > MEMCG_CHARGE_BATCH)
-		return ret;
-
-	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	if (nr_pages > MEMCG_CHARGE_BATCH ||
+	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2333,7 +2327,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages, gfp_mask))
+	if (consume_stock(memcg, nr_pages))
 		return 0;
 
 	if (!gfpflags_allow_spinning(gfp_mask))
-- 
2.47.1


