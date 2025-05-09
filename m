Return-Path: <cgroups+bounces-8119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC0AB2042
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B5E7BC251
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 23:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184D266585;
	Fri,  9 May 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+oxtdCM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F917265CBC
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833395; cv=none; b=Lb4Hb/EtCsrLyeKy03nXqNrYTXilN/TzbLg+9RYYDNB5TD217rLnlExlV/LlCP/2gAvA2zbJuh/LaqQZbV2Ro3rdPWYxtNbS+cqlcwhQREvwYVGVM4GU4sCOajVplS53qLzqRjK1cUke3iTcGstMXqmrfTGo0AG+IS8Kr2zRu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833395; c=relaxed/simple;
	bh=dYWwVP3irHW2AJj409gQ+qz1uErmtJI3nywUBhznVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA6XZ1nZoKqcp5vMNidwq4b8H5KcXDjdd3wrNRSv+L7jR0Y9k9+3lsY02e7D9ASDbndYLhizSOEo015lCFDQalRJa9xR4yVFj7bXjVyPAGhkqJzzyGKLohWfos7QseyvFA97QLnzIFN7d3YvpeP1FnlYSUKRD/OBzHb6IEptrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+oxtdCM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjeZme6BAMobUjCjG2z0qjC/1Yske6Cpmp1xAs83skQ=;
	b=m+oxtdCM5BMnzgXfUZ8NPy8CALAnzpZ8hufWr/HeL7VCTTyzAttbaajYXA1MdPrj7C+97H
	BKHiGesp4mJ3M99Unz3w04sBcgQH1D79ysCFaTIucM/DE8akOLV7G9bTtgaMQ4NuRWRzdr
	e1K1aKcrw0xF+yHoCreEsHSMboObmWg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 3/4] memcg: nmi-safe slab stats updates
Date: Fri,  9 May 2025 16:28:58 -0700
Message-ID: <20250509232859.657525-4-shakeel.butt@linux.dev>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The objcg based kmem [un]charging can be called in nmi context and it
may need to update NR_SLAB_[UN]RECLAIMABLE_B stats. So, let's correctly
handle the updates of these stats in the nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e91e4368650f..bba549c1f18c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2591,8 +2591,18 @@ static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_memcg_lruvec_state(lruvec, idx, nr);
+	if (likely(!in_nmi())) {
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		__mod_memcg_lruvec_state(lruvec, idx, nr);
+	} else {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
+
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		if (idx == NR_SLAB_RECLAIMABLE_B)
+			atomic64_add(nr, &pn->slab_reclaimable);
+		else
+			atomic64_add(nr, &pn->slab_unreclaimable);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.47.1


