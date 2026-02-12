Return-Path: <cgroups+bounces-13888-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD6rNbaOjWl54QAAu9opvQ
	(envelope-from <cgroups+bounces-13888-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:26:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D712B417
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638F431A621F
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90BA2D73B1;
	Thu, 12 Feb 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJ0OIcoA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8F2D592D
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884640; cv=none; b=g+eA+qsvYoZfYsuczYFnhfgD8Jh75Ul4CqZn09wxEziXqb4vrdJsHwJcjeECDfbRNyYe3blFwKxrEHAVykCFxjDoz2/T65WG+A2OOhR0+mKDEmSWwOqXWcCKsYE9WrBAP8FuBaeTF4cc8sOoWVXkY4BneTcc27r3UdXYVrYvWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884640; c=relaxed/simple;
	bh=r6OgvQEi15eLD8Z0lMy3VJnZSrA8sKhWevT7njpVbU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebuWRURsOvlMv6dgqn6ZSuKxKKxr5SoJOH1hqzixx9Y6LegrxrW04wdt3ThKdgGO9v1pxYKSfY3w5dFc1MBSb54c0N5aWPNtY9QZjJq+modmEgdw/GWXKl8c7ufLjfRUJ5sal14Wo04vqvI2XMMWSXu1e4+4c4K6pkpyzBeHyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJ0OIcoA; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770884637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JEGc5je/wM02pWehmFOl3sKJ7z0YxNGSRtnUE/RPCI=;
	b=HJ0OIcoA3oOP4U35yiAgKDYaQEY7TuX0qZLIDHgEFaDpBmCxjWW09jCTIjMQzH8JMX5S9F
	xrjh3BlaT9jvCMCDi44I3clcJ/Li+Q3ml5I/JJo7Viwh8gqwadztOu8XjVc6gL933c7r54
	OCbBi0K4vo3sxio7V14h6YbB0bfqkCg=
From: Hui Zhu <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hui Zhu <zhuhui@kylinos.cn>,
	JP Kobryn <inwardvessel@gmail.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/3] mm/memcontrol: Return error when accessing kmem with nokmem
Date: Thu, 12 Feb 2026 16:23:15 +0800
Message-ID: <733422f72ccbac94126ae67b9e49f4a3d460b76a.1770883926.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1770883926.git.zhuhui@kylinos.cn>
References: <cover.1770883926.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13888-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email,linux.dev:dkim]
X-Rspamd-Queue-Id: 606D712B417
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

When running tests on hosts with cgroup.memory=nokmem enabled for
performance reasons, test_kmem always gets a value of 0 for kmem
statistics.

Since BPF programs cannot easily determine whether kmem is enabled,
add a check in memcg_stat_item_valid() to return an error when
attempting to access MEMCG_KMEM statistics while kmem accounting
is disabled via cgroup_memory_nokmem.

This prevents BPF programs from silently receiving zero values and
allows them to properly handle the case where kmem accounting is
unavailable.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 129eed3ff5bb..4d8419623d1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -667,7 +667,8 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 
 bool memcg_stat_item_valid(int idx)
 {
-	if ((u32)idx >= MEMCG_NR_STAT)
+	if ((u32)idx >= MEMCG_NR_STAT ||
+	    (cgroup_memory_nokmem && (u32)idx == MEMCG_KMEM))
 		return false;
 
 	return !BAD_STAT_IDX(memcg_stats_index(idx));
-- 
2.43.0


