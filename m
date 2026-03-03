Return-Path: <cgroups+bounces-14564-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KuKHI34pmk7bgAAu9opvQ
	(envelope-from <cgroups+bounces-14564-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:04:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1B1F1FDB
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456B8307A085
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724047DD76;
	Tue,  3 Mar 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0KG0k1k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4673DEAD5;
	Tue,  3 Mar 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549817; cv=none; b=ENr5JZwFJnhjyV/EkwL69rPbhXAulL4chAYuNnGHlQS5ZIEogfm/ve2lBgSmsQA0juGKKPGc9A2CXJz0lGL3SXWbRmQHc/+GWVqmBYZIdIKfw6urdy/dkO/lucrJqn96P5Tl7cP/Kq2eyQ9z4hWYIJueZCQQ2TN7tliVDFF7MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549817; c=relaxed/simple;
	bh=YDDRbdkOmZu4woFY/biSTxPY9XVlmlte9LluXIX79po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6enG6h6W4xuTmIvhrDJdOMQ3aMx9FCqyVbyj3NgwWys7IAEOPpU804JTVMkrek6ahFfsJVNx1h0DSyCGypaw7zjWwDjucU9l1N1WZ1KP0YvHbP6cu+d+LESdrWinR8JJ3/f9A0dQouaQ+2RRDsA92ThD4S15xb+BEdacA17ECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0KG0k1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CC0C116C6;
	Tue,  3 Mar 2026 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772549816;
	bh=YDDRbdkOmZu4woFY/biSTxPY9XVlmlte9LluXIX79po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0KG0k1kdbUbJLb4ilLyBDyMYnY2ac0zwF9AnGwtN08Mqs30xW8p6PTwiRV0xzCU1
	 1WUmDa9S22Gx5SOYFBQJn1CfcX+Arl81UgBduK30jmWV/WjU+A9HnAAcZHuKEMAZrt
	 NDm32zqff115xaiAPy83OAUrSXS1pTMn0kqTxJS3ulhjptOIuVQm4f6BlJZfIB7toZ
	 +V2oljnwyK9K3blbhGzVTagIct4fGIiu81pzZHNcTJp2ERLL4aSfGfZg0SpQIIUo6p
	 duFtMMOIxOrYJyAMZPR7CGFuOQEIXgHMdudxRzHDu6dQyXItPuQto2ZGpcRMR1GNH8
	 mROATaBd/5T+Q==
Date: Tue, 3 Mar 2026 14:56:54 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev>
 <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
 <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
X-Rspamd-Queue-Id: D3C1B1F1FDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14564-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:08:56AM +0800, Qi Zheng wrote:
> Hi Yosry,
[..] 
> > 
> > I don't think we should end up with two copies of
> > __mod_memcg_state/mod_memcg_state() and
> > __mod_memcg_lruvec_state/mod_memcg_lruvec_state(). I meant to refactor
> > mod_memcg_state() to call __mod_memcg_state(), where the latter does
> > not call get_non_dying_memcg_{start/end}(). Same for
> > mod_memcg_lruvec_state().
> 
> Okay, like the following? But this would require modifications to
> [PATCH v5 31/32]. If there are no problems, I will send the updated
> patch to [PATCH v5 29/32] and [PATCH v5 31/32].

I cannot apply the diff, seems a bit corrupted.

But ideally, instead of a @reparent argument, we just have
__mod_memcg_lruvec_state() and __mod_memcg_state() do the work without
getting parent of dead memcgs, and then mod_memcg_lruvec_state() and
mod_memcg_state() just call them after get_non_dying_memcg_start().

What about this (untested), it should apply on top of 'mm: memcontrol:
eliminate the problem of dying memory cgroup for LRU folios' in mm-new,
so maybe it needs to be broken down across different patches:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 753d76e96cc67..f0d55e1f9c49a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -527,7 +527,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 #ifdef CONFIG_MEMCG_V1
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 				     enum node_stat_item idx, int val);
 
 void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
@@ -536,16 +536,17 @@ void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
 	int i = memcg_stats_index(idx);
 	int nid;
 
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
-		return;
-
 	for_each_node(nid) {
 		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
 		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
+		struct mem_cgroup_per_node *child_pn, *parent_pn;
 
-		__mod_memcg_lruvec_state(child_lruvec, idx, -value);
-		__mod_memcg_lruvec_state(parent_lruvec, idx, value);
+		child_pn = container_of(child_lruvec, struct mem_cgroup_per_node, lruvec);
+		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
+
+		__mod_memcg_lruvec_state(child_pn, idx, -value);
+		__mod_memcg_lruvec_state(parent_pn, idx, value);
 	}
 }
 #endif
@@ -831,39 +832,42 @@ static inline void get_non_dying_memcg_end(void)
 }
 #endif
 
-/**
- * mod_memcg_state - update cgroup memory statistics
- * @memcg: the memory cgroup
- * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
- * @val: delta to add to the counter, can be negative
- */
-void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-		       int val)
+static void __mod_memcg_state(struct mem_cgroup *memcg,
+			      enum memcg_stat_item idx, int val)
 {
 	int i = memcg_stats_index(idx);
 	int cpu;
 
-	if (mem_cgroup_disabled())
-		return;
-
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	cpu = get_cpu();
 
-	memcg = get_non_dying_memcg_start(memcg);
-
 	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
-
-	get_non_dying_memcg_end();
-
 	trace_mod_memcg_state(memcg, idx, val);
 
 	put_cpu();
 }
 
+/**
+ * mod_memcg_state - update cgroup memory statistics
+ * @memcg: the memory cgroup
+ * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		     int val)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	memcg = get_non_dying_memcg_start(memcg);
+	__mod_memcg_state(memcg, idx, val);
+	get_non_dying_memcg_end();
+}
+
 #ifdef CONFIG_MEMCG_V1
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
@@ -882,35 +886,26 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
-static void __mod_memcg_state(struct mem_cgroup *memcg,
-			      enum memcg_stat_item idx, int val)
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent, int idx)
 {
 	int i = memcg_stats_index(idx);
-	int cpu;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	cpu = get_cpu();
-
-	this_cpu_add(memcg->vmstats_percpu->state[i], val);
-	val = memcg_state_val_in_pages(idx, val);
-	memcg_rstat_updated(memcg, val, cpu);
-	trace_mod_memcg_state(memcg, idx, val);
+	unsigned long value = memcg_page_state_local(memcg, idx);
 
-	put_cpu();
+	__mod_memcg_state(memcg, idx, -value);
+	__mod_memcg_state(parent, idx, value);
 }
+#endif
 
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 				     enum node_stat_item idx, int val)
 {
-	struct mem_cgroup_per_node *pn;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = pn->memcg;
 	int i = memcg_stats_index(idx);
 	int cpu;
 
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = pn->memcg;
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
+		return;
 
 	cpu = get_cpu();
 
@@ -927,20 +922,6 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	put_cpu();
 }
 
-void reparent_memcg_state_local(struct mem_cgroup *memcg,
-				struct mem_cgroup *parent, int idx)
-{
-	int i = memcg_stats_index(idx);
-	unsigned long value = memcg_page_state_local(memcg, idx);
-
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
-		return;
-
-	__mod_memcg_state(memcg, idx, -value);
-	__mod_memcg_state(parent, idx, value);
-}
-#endif
-
 static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
@@ -948,32 +929,13 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	int i = memcg_stats_index(idx);
-	int cpu;
-
-	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
-		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = pn->memcg;
-
-	cpu = get_cpu();
-
-	memcg = get_non_dying_memcg_start(memcg);
+	memcg = get_non_dying_memcg_start(pn->memcg);
 	pn = memcg->nodeinfo[pgdat->node_id];
-
-	/* Update memcg */
-	this_cpu_add(memcg->vmstats_percpu->state[i], val);
-	/* Update lruvec */
-	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
-	val = memcg_state_val_in_pages(idx, val);
-	memcg_rstat_updated(memcg, val, cpu);
-
+	__mod_memcg_lruvec_state(pn, idx, val);
 	get_non_dying_memcg_end();
 
-	trace_mod_memcg_lruvec_state(memcg, idx, val);
-
-	put_cpu();
 }
 
 /

