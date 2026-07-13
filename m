Return-Path: <cgroups+bounces-17692-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ek6MLFuqVGpWpAMAu9opvQ
	(envelope-from <cgroups+bounces-17692-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:05:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0D749182
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wLpg6rxP;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17692-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17692-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0DB2303DADE
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09183D9DC0;
	Mon, 13 Jul 2026 09:00:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41A39098E
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 09:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933240; cv=none; b=Xy9YN/Q+1uNUTZwFJbiL+DydfPNZevPp5n61VcKwAWfS8s5FByU2vT00P4i6f2mVGceOgeljwxcPie7NV/7a9SpAVBlhYgI1HainMYAEZ9dmoHz15o4GMzb4YKf9RzX65PkbIGle8CbznO8iN0u9yPovHACT3Iz99cBZhZGz5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933240; c=relaxed/simple;
	bh=BEaOcSCFY3l1EWKgxkGj/Hxta6DQzxUzB0uglzdkM/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DR8F383kP1hSS9MeVcgIwvXCkaLRvNRgJNI4qyvUzbs6AldYCXw6RY+5rgbR5NurXotN8qvcDQ/701MFulIVd08uTe1N0fXoAQFYBu1dXMkR9wXIFZGt6RX95GzKX6rQ0YBjHQQP+tiIf54HTjSPdvICmU3CpCVwYQTXlWaGYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLpg6rxP; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783933237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioPagpwFTzNhXNYobwbUxjWhxbMrCA+AnLrRpW24boU=;
	b=wLpg6rxPUtfwOyQVfL2Js9q33etD4FyUadaKjSztAoGnsIdTn4pC0n1JcIqDuc+pj97Am9
	T2IicbGvIvptI1eR2hi+k4KtVZRKqplZG2+h5QqWOYGfoUScieHCo0trS8+v1e9M3qlm5t
	zosLKgCrRF+HDHSGNm9pb9p1hq7cdjE=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] mm: memcontrol: drop unused cpu argument from flush_nmi_stats
Date: Mon, 13 Jul 2026 17:00:10 +0800
Message-ID: <20260713090010.2991906-1-guopeng.zhang@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17692-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2F0D749182

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

flush_nmi_stats() does not use its cpu argument. Remove it from the
function and its !CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC stub. The
caller still uses cpu for the subsequent per-CPU rstat flush.

No functional change.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 mm/memcontrol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22f55aeb94f3..86ed741cc5cd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4433,8 +4433,7 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 }
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
-			    int cpu)
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	int nid;
 
@@ -4480,8 +4479,7 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 	}
 }
 #else
-static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
-			    int cpu)
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {}
 #endif
 
@@ -4493,7 +4491,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct aggregate_control ac;
 	int nid;
 
-	flush_nmi_stats(memcg, parent, cpu);
+	flush_nmi_stats(memcg, parent);
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
-- 
2.43.0


