Return-Path: <cgroups+bounces-17688-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvg+A3uoVGrVowMAu9opvQ
	(envelope-from <cgroups+bounces-17688-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:57:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12574904A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=YFbttWYz;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17688-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17688-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992363064E28
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 08:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B33D25BC;
	Mon, 13 Jul 2026 08:51:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593973CF661
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:51:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932676; cv=none; b=Rpp8YWKq/oCYbWpwdZyRhE3B/2OYgyssLBl4f65Wj78+VrzHZQDLJX8JYZ5LcFiCcs/YG5ZU0hQZx60jIOeRJOr8tD9KKjwQVntuU+VspLy+mXYC20/ZPoIfq9pPZx/YuLFMjE4YC599msh4rQZVrZyTHP01rls1BZtrLu9eJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932676; c=relaxed/simple;
	bh=iYe+P+u2o9M1YbWj85doUi4Vn5sWEc2uvUVMc3O+5wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0Z/2g1bLQiPxguZdVVTfsQgMQjDWYjF+JZ2E1PnMjo/LqMRhzk6lAGqv5CnhPRWCgY7Fni2r7Go0t7moJP02cTpBQyqqywAUDaEIl7EQ7FrQHLJSA1ig2Us+Z7eVoqVScx577SxlH/iRzct/OV/mdq9eDdh0UWvf0rwgATv7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YFbttWYz; arc=none smtp.client-ip=95.215.58.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783932672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6M0rnHHSOu73KIHVgHsaucxNbMa7/bd9HvhJ1ASs3fI=;
	b=YFbttWYzCN6AS81vKL8HDEaktJR5eLQ01C5Tt79DZbw9nxJvTlyfzrvLOZlLRvgBRBQpUW
	xkCoAT/Vt2Lw+A/ZlhsZq1e9Aou7lN7TDCSa508sU4LKhFdIWbPJV4j8V5PH8THv5gqFs9
	c/tb3vqRNNWVH+sMh5Qb6szf4W5ZDj8=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] mm: memcontrol: update state_local when flushing NMI stats
Date: Mon, 13 Jul 2026 16:50:53 +0800
Message-ID: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17688-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:vbabka@kernel.org,m:alex@ghiti.fr,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C12574904A

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

flush_nmi_stats() updates state[] for kmem and slab counters but leaves
the corresponding state_local[] counters unchanged. Local kmem and
slab statistics therefore miss updates collected through the NMI-safe
atomic path.

Update state_local[] together with state[].

Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22f55aeb94f3..02599b8b6bd5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4443,6 +4443,7 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 		int index = memcg_stats_index(MEMCG_KMEM);
 
 		memcg->vmstats->state[index] += kmem;
+		memcg->vmstats->state_local[index] += kmem;
 		if (parent)
 			parent->vmstats->state_pending[index] += kmem;
 	}
@@ -4460,9 +4461,11 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
 
 			lstats->state[index] += slab;
+			lstats->state_local[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
 			memcg->vmstats->state[index] += slab;
+			memcg->vmstats->state_local[index] += slab;
 			if (parent)
 				parent->vmstats->state_pending[index] += slab;
 		}
@@ -4471,9 +4474,11 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
 
 			lstats->state[index] += slab;
+			lstats->state_local[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
 			memcg->vmstats->state[index] += slab;
+			memcg->vmstats->state_local[index] += slab;
 			if (parent)
 				parent->vmstats->state_pending[index] += slab;
 		}
-- 
2.43.0


