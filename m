Return-Path: <cgroups+bounces-3126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA0900572
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74412B22CAD
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAA194AD1;
	Fri,  7 Jun 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxUbegs5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5769194A5A;
	Fri,  7 Jun 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768091; cv=none; b=aMFuUoOmxYOLj6RsjysHgiZnLR/tEFE9yK/K6LrHW3Zi1s+QkvFRaiQPLjke+IGzh6VwpGS0/piDChxLLYKKO8BPAIw/xMNdLxuJ92CitP8z3QmoO3ibF9x+rHspCXGPhiIkXUNM6D8buDaj00bhRQmdPA2f6ZotQ7foj+QWZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768091; c=relaxed/simple;
	bh=TQyKi7DdPGzpHrY7zAT+50KqIFo9l+0hqUZDJ1H9PuA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=foHJAF+9cSyqCdYIWMMDs1mgapoLPjm4pC5AsBVAdpeKtbUsufr5umtvydIdkroJj39nVnnEmNtlc+dbrSu8G94bXLg9kyUwcYdLJtXX5DUIcC5tq5lK3oqoEkKXLjt6YcEjuP+3uFkUDMUfJTxBU59dZ2wuFTC4KlVmlBfgLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxUbegs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B10C32782;
	Fri,  7 Jun 2024 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768091;
	bh=TQyKi7DdPGzpHrY7zAT+50KqIFo9l+0hqUZDJ1H9PuA=;
	h=Subject:From:To:Cc:Date:From;
	b=jxUbegs50WXk2Yd4F4sXnmPaVFzxACNse6F2pABiZWF8OZDrk1Sx0xEbZR9w2VuWi
	 bf/sJ8HBjGMEqnyj+7U4yHbljoQVJZGcfmBsnlvmiD7NxHCv9RrUiobIA5WsUec0Gg
	 YQCY5UCpAwyo6gS5JXEr2QiIr8aDnst6qXkj7bNVP+HYWV2MVzNDJs2u8OXNCcwzXE
	 kxC7eFcF3DR38BlqtcZS7hqsvP8MJnaurmOfg92rgO/UCG5yF9C9UjPh7BKXR6HAx0
	 K3C5ISy9fHOpK1I7Rg2ueH5yACJ44rWz8RntfKEA9y8apUhZivpvsRNMOoSuOwXnk2
	 KuxTGt73+csaQ==
Subject: [PATCH 6.6.y] mm: ratelimit stat flush from workingset shrinker
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: stable@vger.kernel.org, yosryahmed@google.com, shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 longman@redhat.com, linux-mm@kvack.org, kernel-team@cloudflare.com
Date: Fri, 07 Jun 2024 15:48:06 +0200
Message-ID: <171776806121.384105.7980809581420394573.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Shakeel Butt <shakeelb@google.com>

commit d4a5b369ad6d8aae552752ff438dddde653a72ec upstream.

One of our workloads (Postgres 14 + sysbench OLTP) regressed on newer
upstream kernel and on further investigation, it seems like the cause is
the always synchronous rstat flush in the count_shadow_nodes() added by
the commit f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical
stats").  On further inspection it seems like we don't really need
accurate stats in this function as it was already approximating the amount
of appropriate shadow entries to keep for maintaining the refault
information.  Since there is already 2 sec periodic rstat flush, we don't
need exact stats here.  Let's ratelimit the rstat flush in this code path.

Link: https://lkml.kernel.org/r/20231228073055.4046430-1-shakeelb@google.com
Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

---
On production with kernel v6.6 we are observing issues with excessive
cgroup rstat flushing due to the extra call to mem_cgroup_flush_stats()
in count_shadow_nodes() introduced in commit f82e6bf9bb9b ("mm: memcg:
use rstat for non-hierarchical stats") that commit is part of v6.6.
We request backport of commit d4a5b369ad6d ("mm: ratelimit stat flush
from workingset shrinker") as it have a fixes tag for this commit.

IMHO it is worth explaining call path that makes count_shadow_nodes()
cause excessive cgroup rstat flushing calls. Function shrink_node()
calls mem_cgroup_flush_stats() on its own first, and then invokes
shrink_node_memcgs(). Function shrink_node_memcgs() iterates over
cgroups via mem_cgroup_iter() for each calling shrink_slab(). The
shrink_slab() calls do_shrink_slab() that via shrinker->count_objects()
invoke count_shadow_nodes(), and count_shadow_nodes() does
a mem_cgroup_flush_stats() call, that seems unnecessary.

Backport differs slightly due to v6.6.32 doesn't contain commit
7d7ef0a4686a ("mm: memcg: restore subtree stats flushing") from v6.8.
---
 mm/workingset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 2559a1f2fc1c..9110957bec5b 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -664,7 +664,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats_ratelimited();
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,



