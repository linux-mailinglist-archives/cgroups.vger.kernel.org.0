Return-Path: <cgroups+bounces-13677-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJfSJHuug2lOswMAu9opvQ
	(envelope-from <cgroups+bounces-13677-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 21:39:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC192EC827
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 21:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C469430182AF
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B7436355;
	Wed,  4 Feb 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ub/vnzHu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86605436353
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237549; cv=none; b=uckG3I5KgvR6oEnqwMI9WB5DbE1ODnKuPboCUavWamtCgq4aWvwUpttCuCdCmgdq9FjHnIU0PMbvmHMPUYHwgK7clp4wNLyifQm9zIjmv2OD83bf/TqpceIftb8w3T2ptYbVZKOk/ImZZYeYWS3dYAcZo4Obpz2bo0HqMr1Eagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237549; c=relaxed/simple;
	bh=xqp2APQTK418ZK90TuqFUBCEbMo+N9RGiGQ4TV0nJ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH9mNWdWpQ3Os+UW1niXuHxb3Jr3Qnz9ZxdqpnwEytSUM/gc8scEPOHDcAqmxUwvGM5ST/mRgH0u5v4aAADkDuSbF/tsfK96fhuxZF4e5dwonMcassPreDfMd+vNKgZN0Qt/fhLOifecjuZv3mUrf3DTklU1IHCugtljWsi4hpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ub/vnzHu; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Feb 2026 12:38:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770237537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FYMhfr46SivfaufI+yrynTinQPNIgR87QHwVwyjO1Q=;
	b=ub/vnzHu3xWXTYfSKu8a2uExkd0Is5QCM8UwF88Ag1v0KbSCN1kOP6fINttLxWwFP8Or7c
	ewnv2CL/SSXXNPGoo7QBtxQuNPApxUPwqigfqQohWr7Elh1AImzObJR9iN+3HE7T3AAmg8
	LOZKuLLuUPTa03Yr4OlbJ0xSLsqNhK8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYOuCmjQ5lGm8Mup@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
 <aYAmGc6lu973jRwu@linux.dev>
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13677-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: EC192EC827
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:23:54PM +0530, Dev Jain wrote:
> 
> On 02/02/26 10:24 am, Shakeel Butt wrote:
> >>>> Hello Shakeel,
> >>>>
> >>>>  We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
> >>>>  the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
> >>>>  to munmap. Please see below if my understanding of this patch is correct.
> >>>>
> >>>  Thanks for the report. Are you seeing regression in just the benchmark
> >>>  or some real workload as well? Also how much regression are you seeing?
> >>>  I have a kernel rebot regression report [1] for this patch as well which
> >>>  says 2.6% regression and thus it was on the back-burner for now. I will
> >>>  take look at this again soon.
> >>>
> >> The munmap regression is ~24%. Haven't observed a regression in any other
> >> benchmark yet.
> > Please share the code/benchmark which shows such regression, also if you can
> > share the perf profile, that would be awesome.
> 
> https://gitlab.arm.com/tooling/fastpath/-/blob/main/containers/microbench/micromm.c
> You can run this with
> ./micromm 0 munmap 10
> 
> Don't have a perf profile, I measured the time taken by above command, with and
> without the patch.
> 

Hi Dev, can you please try the following patch?


From 40155feca7e7bc846800ab8449735bdb03164d6d Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 4 Feb 2026 08:46:08 -0800
Subject: [PATCH] vmstat: use preempt disable instead of try_cmpxchg

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/mmzone.h |  2 +-
 mm/vmstat.c            | 58 ++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e51190a55e4..499cd53efdd6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -776,7 +776,7 @@ struct per_cpu_zonestat {
 
 struct per_cpu_nodestat {
 	s8 stat_threshold;
-	s8 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
+	long vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
 };
 
 #endif /* !__GENERATING_BOUNDS.H */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 86b14b0f77b5..0930695597bb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -377,7 +377,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 				long delta)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	long __percpu *p = pcp->vm_node_stat_diff + item;
 	long x;
 	long t;
 
@@ -456,8 +456,8 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	long __percpu *p = pcp->vm_node_stat_diff + item;
+	long v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
@@ -467,7 +467,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
-		s8 overstep = t >> 1;
+		long overstep = t >> 1;
 
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
@@ -512,8 +512,8 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	long __percpu *p = pcp->vm_node_stat_diff + item;
+	long v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
@@ -523,7 +523,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
-		s8 overstep = t >> 1;
+		long overstep = t >> 1;
 
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
@@ -619,9 +619,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
        enum node_stat_item item, int delta, int overstep_mode)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	long n, t, z;
-	s8 o;
+	long __percpu *p = pcp->vm_node_stat_diff + item;
+	long o, n, t, z;
 
 	if (vmstat_item_in_bytes(item)) {
 		/*
@@ -634,32 +633,25 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		delta >>= PAGE_SHIFT;
 	}
 
+	preempt_disable();
+
 	o = this_cpu_read(*p);
-	do {
-		z = 0;  /* overflow to node counters */
+	n = o + delta;
 
-		/*
-		 * The fetching of the stat_threshold is racy. We may apply
-		 * a counter threshold to the wrong the cpu if we get
-		 * rescheduled while executing here. However, the next
-		 * counter update will apply the threshold again and
-		 * therefore bring the counter under the threshold again.
-		 *
-		 * Most of the time the thresholds are the same anyways
-		 * for all cpus in a node.
-		 */
-		t = this_cpu_read(pcp->stat_threshold);
+	t = this_cpu_read(pcp->stat_threshold);
+	z = 0;
 
-		n = delta + (long)o;
+	if (abs(n) > t) {
+		int os = overstep_mode * (t >> 1);
 
-		if (abs(n) > t) {
-			int os = overstep_mode * (t >> 1) ;
+		/* Overflow must be added to node counters */
+		z = n + os;
+		n = -os;
+	}
 
-			/* Overflow must be added to node counters */
-			z = n + os;
-			n = -os;
-		}
-	} while (!this_cpu_try_cmpxchg(*p, &o, n));
+	this_cpu_add(*p, n - o);
+
+	preempt_enable();
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
@@ -866,7 +858,7 @@ static bool refresh_cpu_vm_stats(bool do_pagesets)
 		struct per_cpu_nodestat __percpu *p = pgdat->per_cpu_nodestats;
 
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			int v;
+			long v;
 
 			v = this_cpu_xchg(p->vm_node_stat_diff[i], 0);
 			if (v) {
@@ -929,7 +921,7 @@ void cpu_vm_stats_fold(int cpu)
 
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 			if (p->vm_node_stat_diff[i]) {
-				int v;
+				long v;
 
 				v = p->vm_node_stat_diff[i];
 				p->vm_node_stat_diff[i] = 0;
-- 
2.47.3


