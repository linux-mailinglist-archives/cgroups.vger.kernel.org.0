Return-Path: <cgroups+bounces-17460-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /WTDGRdZR2pRWgAAu9opvQ
	(envelope-from <cgroups+bounces-17460-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:39:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A16FF20B
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Kf+KTADP;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17460-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17460-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D16A303D0B2
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 06:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915B383325;
	Fri,  3 Jul 2026 06:38:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C743806C1
	for <cgroups@vger.kernel.org>; Fri,  3 Jul 2026 06:38:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060729; cv=none; b=eDl/Xk7xa6j/6/c2j1UoZtyIjfjxlDwOfoU7wOk6M1T4X+bcgBBS7u9SGVGFQyuoqDrCRgFPCsNehqAs+UkHRfMncAvajljZ7AA+1O15djmsbZDEkehzcvB4/MgJOPh7R4evPCYIbNoW6R++UkyySqnzhFzpEQMTj9YCCQ2fM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060729; c=relaxed/simple;
	bh=S1dwmhLP7HXeAgFQGef9hM0uREtmrK4DVQcBOln1gmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQxN94pSRcriapE/lSwCIRxofNK7+EtSf8snhevZUAKawF8dPOwcfUh59JzlX3KvQkiTtIoDlOT7rnxyBYMGYOWUGrarixfgTwDcIOAs/t4OCLHvfGu5VwFCAk64COaN4UItuF7RpzjxJCLHDLjEUQytpPaPQiRQ3uUJycrE6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kf+KTADP; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783060724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fEkK9pnSJD0txsSBPtdtsEE+U5WFOOOSBGYT3LbvKE=;
	b=Kf+KTADPxIaSTV+fpz3zkI31900PahAzK4oDrKTYL2hq76L6jqeC1Z6rsae9oA+qGkPsrb
	MmUFdtb27N8LjAkSWVFxCJNOTAjLsHP2MnhQG2EvGZ1Jlw5nlmfsM1ioniGKXkzUH/zN8v
	c15uJL34DaqaCj6QOnE0Iw+ptapp6c0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: memcg: reset oom_group in css_reset
Date: Fri,  3 Jul 2026 14:38:24 +0800
Message-ID: <20260703063826.306878-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260703063826.306878-1-jiayuan.chen@linux.dev>
References: <20260703063826.306878-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17460-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:jiayuan.chen@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 055A16FF20B

From: Jiayuan Chen <jiayuan.chen@shopee.com>

memory.oom.group defaults to disabled, but css_reset did not clear
memcg->oom_group when a disabled memory css is kept alive by another
controller dependency.

Reset it with the other memory controller policies so a hidden memcg
cannot keep applying stale group OOM kill policy.

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
It is found when Sashiko reviewed my previous patch.
https://sashiko.dev/#/patchset/20260702024827.353185-1-jiayuan.chen%40linux.dev
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c20ef3c1d6fe..c7de62c8f86f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4362,6 +4362,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
+	WRITE_ONCE(memcg->oom_group, false);
 #ifdef CONFIG_ZSWAP
 	WRITE_ONCE(memcg->zswap_max, PAGE_COUNTER_MAX);
 	WRITE_ONCE(memcg->zswap_writeback, true);
-- 
2.43.0


