Return-Path: <cgroups+bounces-14679-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KfLNC0lqmmUMAEAu9opvQ
	(envelope-from <cgroups+bounces-14679-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 01:51:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94C21A05B
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 01:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F66D3060BF5
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCC2F1FD7;
	Fri,  6 Mar 2026 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xsQ3RRU9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC32D73AE;
	Fri,  6 Mar 2026 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758280; cv=none; b=CYi6KO7oUF9zsiKRLFJeqOoPOhhXa5aVyjIP3NXmU/K/o7sv5sIVhe/MB12hN9QwbZ+d18iDhNq6q6eAWm95iVAc2zZ6f27oyyPnrwg3CRjMvb2bYPGMLt4q4H2RH8Ml5i2atjpfsZLMc/hwRCYJpqeEEbg7R7Pc4Tv8YoU+TxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758280; c=relaxed/simple;
	bh=I/BWr/0mA1g8/sbDHYUZiwRMeSm+NWbDKYSZFZTO4DI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t4mlvxmyPMtMSKpfQ8i+YQ4H4x70bqUMykYQHhJh2EosEkNbe0m/1zU7tRAwOo1FDXHxghVFP6ozXgsHtydkHiXN+5YkKROw3CombK1eg41RhWmuDbkmX+4d9Q6xhmiuBAf2G0Rn+68pPDmmalaRz635PRNh+2/AH5BSHuJ079k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xsQ3RRU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F46BC116C6;
	Fri,  6 Mar 2026 00:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772758280;
	bh=I/BWr/0mA1g8/sbDHYUZiwRMeSm+NWbDKYSZFZTO4DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xsQ3RRU9VHWVxisor/UYVoad0VPyF40BQePhkZZlongLargaRVbJpy4ll1hJcJpYG
	 uUM3qylVY1DIxL/4r0sQ2KzwOo/C1AJZkWTzXswFmSgdAhKnPGTglRtFPdVoUdnm4r
	 K6RyzCGxZH8G7WELzz98N2cfM488udhsxHIqEV/o=
Date: Thu, 5 Mar 2026 16:51:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 00/33] Eliminate Dying Memory Cgroup
Message-Id: <20260305165118.33c0af5b7742e18f18b7231a@linux-foundation.org>
In-Reply-To: <cover.1772711148.git.zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2F94C21A05B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14679-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid,linux.dev:email]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 19:52:18 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

>  - refactor mod_memcg_state() and mod_memcg_lruvec_state()
>    (suggested by Yosry Ahmed)
>  - use non-atomic method to reparent non-hierarchical stats
>    (suggested by Yosry Ahmed)
>  - remove the redundant declaration in  [PATCH v5 29/32]
>    (pointed by Shakeel Butt)
>  - collect Acked-bys

Updated, thanks.

Appended is how this update altered mm.git.

Hopefully we'll be able to move this into mm-unstable (and hance
linux-next) soon,

--- a/kernel/cgroup/cgroup.c~b
+++ a/kernel/cgroup/cgroup.c
@@ -6043,8 +6043,9 @@ out_unlock:
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
-				struct cgroup_subsys_state, destroy_rwork);
+	struct cgroup_subsys_state *css;
+
+	css = container_of(to_rcu_work(work), struct cgroup_subsys_state, destroy_rwork);
 
 	cgroup_lock();
 
--- a/mm/memcontrol.c~b
+++ a/mm/memcontrol.c
@@ -526,25 +526,25 @@ unsigned long lruvec_page_state_local(st
 }
 
 #ifdef CONFIG_MEMCG_V1
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 				     enum node_stat_item idx, int val);
 
 void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
 				       struct mem_cgroup *parent, int idx)
 {
-	int i = memcg_stats_index(idx);
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
@@ -830,39 +830,43 @@ static inline void get_non_dying_memcg_e
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
+		       int val)
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
@@ -881,35 +885,25 @@ unsigned long memcg_page_state_local(str
 	return x;
 }
 
-static void __mod_memcg_state(struct mem_cgroup *memcg,
-			      enum memcg_stat_item idx, int val)
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent, int idx)
 {
-	int i = memcg_stats_index(idx);
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
 
@@ -926,20 +920,6 @@ static void __mod_memcg_lruvec_state(str
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
@@ -947,32 +927,14 @@ static void mod_memcg_lruvec_state(struc
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
 
-	/* Update memcg */
-	this_cpu_add(memcg->vmstats_percpu->state[i], val);
-	/* Update lruvec */
-	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
-	val = memcg_state_val_in_pages(idx, val);
-	memcg_rstat_updated(memcg, val, cpu);
+	__mod_memcg_lruvec_state(pn, idx, val);
 
 	get_non_dying_memcg_end();
-
-	trace_mod_memcg_lruvec_state(memcg, idx, val);
-
-	put_cpu();
 }
 
 /**
_


