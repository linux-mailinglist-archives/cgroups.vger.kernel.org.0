Return-Path: <cgroups+bounces-16507-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE7TFnsoHWq6VwkAu9opvQ
	(envelope-from <cgroups+bounces-16507-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 08:36:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B761A3EA
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 08:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2725303D12F
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03138367292;
	Mon,  1 Jun 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ngy8hvkP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FE35F602
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295683; cv=none; b=l3AU0xtWARkIQ+FtFdZ+PgH1T/B/x/RdA9xg2GMWqfOTsMJF5qpH6p70/3S3BuDznmci9fSQAwTaQxUlUQ1NWLUBiK88jltrVFYE4hRA2MZCzw8fR540pt5LoS4lpJwtcvn9RrI/XaKxuFxdbd9mPnylZPYj5IiJ5m4E13T2L2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295683; c=relaxed/simple;
	bh=qqBWByypUKq2FsizaIPyo4COr5T8Ke5xWvws1jGf5p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRe49ZzVlG+ydhR9gE92OrRu3VU3jsYmQt7ju9u/mC0vzAeTsidg3XI6Lgk1QRKgU5Fn3BT0KCZHK3BabAjaz2z0e1HyV0uUBe1ySVJirK30alW+c0TmAK+6Rjfj/E1E5JOIh0HUzQSv8oVnNtvB6CmIm0LKWavhrL3Wk8lJbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ngy8hvkP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780295679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QiRzdMswPgawDFLq5HRk8E4c2GK+uK4ZKIh/iRxMht8=;
	b=Ngy8hvkPHXVBJz6JxI/RWTNHm8G9rzOSN+P+SvwhC3BCDsRo0S8N97K8OJN2VBDNdnG52P
	/uv1anMx9+ccsvLgSQT869Dzi8ZbFTKpTdkaSyZlnHISVsVlstrE44d3lKJse6MCqw6d0l
	9VKmneou8Ozl4GvRBqHN3Pug+JGxW6M=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: [PATCH] mm/list_lru: drain before clearing xarray entry on reparent
Date: Sun, 31 May 2026 23:34:08 -0700
Message-ID: <20260601063408.2879011-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16507-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 897B761A3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
xas_store(&xas, NULL) before reparenting its per-node lists into the
parent. This opens a window where a concurrent list_lru_del() arriving
for the dying memcg sees xa_load() == NULL, walks to the parent in
lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
list_del_init() on an item still physically linked on the dying
memcg's list.

If another in-flight thread holds the dying memcg's per-node lock at
the same moment (another list_lru_del, or a list_lru_walk_one running
an isolate callback), both threads modify ->next/->prev pointers on the
same physical list under different locks. Adjacent items can corrupt
each other's links.

Fix it by reversing the order: reparent each per-node list and mark the
child's list lru dead and then clear the xarray entry. Any concurrent
list_lru op that finds the still-set xarray entry either takes the dying
memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
and walks to the parent, where the items now live.

Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Chris Mason <clm@fb.com>
---
 mm/list_lru.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dd29bcf8eb5f..ae55a52307db 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -473,26 +473,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list) {
 		struct list_lru_memcg *mlru;
-		XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
 
-		/*
-		 * Lock the Xarray to ensure no on going list_lru_memcg
-		 * allocation and further allocation will see css_is_dying().
-		 */
-		xas_lock_irq(&xas);
-		mlru = xas_store(&xas, NULL);
-		xas_unlock_irq(&xas);
+		mlru = xa_load(&lru->xa, memcg->kmemcg_id);
 		if (!mlru)
 			continue;
 
 		/*
-		 * With Xarray value set to NULL, holding the lru lock below
-		 * prevents list_lru_{add,del,isolate} from touching the lru,
-		 * safe to reparent.
+		 * Reparent each per-node list and mark the child dead
+		 * (LONG_MIN) before clearing xarray entry otherwisw a
+		 * concurrent list_lru_del() may corrupt the list if it arrives
+		 * after xarray clear but before reparenting as
+		 * lock_list_lru_of_memcg will acquire parent's lock while the
+		 * item is still on child's list.
 		 */
 		for_each_node(i)
 			memcg_reparent_list_lru_one(lru, i, &mlru->node[i], parent);
 
+		xa_erase(&lru->xa, memcg->kmemcg_id);
+
 		/*
 		 * Here all list_lrus corresponding to the cgroup are guaranteed
 		 * to remain empty, we can safely free this lru, any further
-- 
2.52.0


