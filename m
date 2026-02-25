Return-Path: <cgroups+bounces-14340-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPj8K1OsnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14340-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 09:01:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D7193DF5
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 09:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0204E3129B19
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2D30DD1C;
	Wed, 25 Feb 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+YS4KV8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAD30BF69
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006170; cv=none; b=OlgaJYo9c/zJQEJmT9ay3VsAa+T8nvTCX2zawf0le1yM1ptyoiaF5RvhIUEsGrv+scHtjsaPAx8qibL2HqtlGu/zNjYkalUJjZfsRkjEPEbicobXKRWufxUWHOkd9l+SSy2dTTe+istIvXn64EMwzrevz1QdRZtNSokxd/kM7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006170; c=relaxed/simple;
	bh=JN7pBv8VkkKncPOYW80zogZZnT96T/hdsZkXkiHcEpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyIIm5yNzzTYeI2N7kEJYqIC2+2YyUmg4oSKBEKcZWIV0LbBzZkQ8nUfINcf2k1jinfTWPIx7IkkNUjk/qarZKEDDCVLY+KFwOAs6kE7PC3elXLKFrd5opDu6a5DaaXfDGPZ3turVGUhb8kUFQHpA2R0e0LVKGgHUDl4rCbYwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+YS4KV8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AoaAnBbgsYhG9W1u4+1KzMV1vTbFtNuDB1KSaR3wOM=;
	b=L+YS4KV8J6CG30cbEUTbgZPtn2Qvmsnvy7e92wBxgBxOLws5u9CYgL2aMUjNpsbdCwodhE
	RHJydHzbA3e2oRsDbuEnsXDBM8Ly4lk0InbW93ldb3hPvoQP1d5TWsnIc+VzCU+iwmucAq
	IA4DuOx1dYoitp+SLdwYX/Ao0qemnGs=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 28/32] mm: workingset: use lruvec_lru_size() to get the number of lru pages
Date: Wed, 25 Feb 2026 15:53:11 +0800
Message-ID: <b1d448c667a8fb377c3390d9aba43bdb7e4d5739.1772005110.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772005110.git.zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14340-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:mid,bytedance.com:email,linux.dev:email,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 258D7193DF5
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

For cgroup v2, count_shadow_nodes() is the only place to read
non-hierarchical stats (lruvec_stats->state_local). To avoid the need to
consider cgroup v2 during subsequent non-hierarchical stats reparenting,
use lruvec_lru_size() instead of lruvec_page_state_local() to get the
number of lru pages.

For NR_SLAB_RECLAIMABLE_B and NR_SLAB_UNRECLAIMABLE_B cases, it appears
that the statistics here have already been problematic for a while since
slab pages have been reparented. So just ignore it for now.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 include/linux/swap.h | 1 +
 mm/vmscan.c          | 3 +--
 mm/workingset.c      | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 64af9462ae8af..9d0e292875398 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -354,6 +354,7 @@ extern void swap_setup(void);
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
+unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0fb81fb7985e2..7f9f66e0b40e1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -390,8 +390,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  * @lru: lru to use
  * @zone_idx: zones to consider (use MAX_NR_ZONES - 1 for the whole LRU list)
  */
-static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
-				     int zone_idx)
+unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
 	unsigned long size = 0;
 	int zid;
diff --git a/mm/workingset.c b/mm/workingset.c
index 95d722a452e1c..07e6836d05020 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -691,9 +691,10 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 
 		mem_cgroup_flush_stats_ratelimited(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
+
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
-			pages += lruvec_page_state_local(lruvec,
-							 NR_LRU_BASE + i);
+			pages += lruvec_lru_size(lruvec, i, MAX_NR_ZONES - 1);
+
 		pages += lruvec_page_state_local(
 			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
 		pages += lruvec_page_state_local(
-- 
2.20.1


