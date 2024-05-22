Return-Path: <cgroups+bounces-2979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80728CBA43
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 06:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B51C20F4D
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 04:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53837144;
	Wed, 22 May 2024 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FfE3fogd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCF360
	for <cgroups@vger.kernel.org>; Wed, 22 May 2024 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351510; cv=none; b=Ugabr5hVjiME3DX62E6rRONc3FeQuLk96/awnSHGp+nFFtBaM/3+D4BNkXM/xuQoiVqeZ2aXyDEXWcxJtYsEx7n3LKC3n9Wjmerutse6K4c4e4euolQKnHjR/gxO+pqZBrebDSAQFsU6O2svpiLfzzenXRuaoGGuo2+tVO/Pv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351510; c=relaxed/simple;
	bh=gu/RKSScPBaAl0E9W/RHx6nZp+LazBrdJtL0L5bqqLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ALTM18/rpOS+j6fY+8wW43vWFXR8R4sGU5c8XO0EPXTfaNfDiOcFq/nJgftWq31vPOHeBpYjIUVE+n0vtukyuGYOBb6BOxJWoCPhQO/YQgCCgFx/+uJrFbb1/5O1WREHTlvSO1JR0MoIKBVm761bMqWC2Nnu2ywAa+hRH2xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FfE3fogd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716351505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1d+3K08/qEf9uOKnJMWpStQd4Xarx7Emvw7jojctgA=;
	b=FfE3fogdF398VYtflZx1VxZYjDj/XR5vEHBrBeXhj545HN3KkpD9OAScJG93qyNDvR7mwJ
	GlRWYsL9rHlJP4vJnsI5kAmPz3odXsXBTbnsGGQeN4hcGt8wRE9F6x4PFozZ693blB8WXd
	UhQyedjJkkO9VmGssl6DbEttNsvUohQ=
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: tjmercier@google.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
Date: Tue, 21 May 2024 21:18:19 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Tue, May 21, 2024 at 10:43:16AM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
[...]
> 
> we reported regression on a 2-node Skylake server. so I found a 1-node Skylake
> desktop (we don't have 1 node server) to check.
> 

Please try the following patch on both single node and dual node
machines:


From 00a84b489b9e18abd1b8ec575ea31afacaf0734b Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Tue, 21 May 2024 20:27:11 -0700
Subject: [PATCH] memcg: rearrage fields of mem_cgroup_per_node

At the moment the fields of mem_cgroup_per_node which get read on the
performance critical path share the cacheline with the fields which
might get updated. This cause contention of that cacheline for
concurrent readers. Let's move all the read only pointers at the start
of the struct, followed by memcg-v1 only fields and at the end fields
which get updated often.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..16efd9737be9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -96,23 +96,25 @@ struct mem_cgroup_reclaim_iter {
  * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
-	struct lruvec		lruvec;
+	/* Keep the read-only fields at the start */
+	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
+						/* use container_of	   */
 
 	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
 	struct lruvec_stats			*lruvec_stats;
-
-	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
-
-	struct mem_cgroup_reclaim_iter	iter;
-
 	struct shrinker_info __rcu	*shrinker_info;
 
+	/* memcg-v1 only stuff in middle */
+
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
-	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
-						/* use container_of	   */
+
+	/* Fields which get updated often at the end. */
+	struct lruvec		lruvec;
+	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
+	struct mem_cgroup_reclaim_iter	iter;
 };
 
 struct mem_cgroup_threshold {
-- 
2.43.0


