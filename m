Return-Path: <cgroups+bounces-17386-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +H9NOEccQ2pJQwoAu9opvQ
	(envelope-from <cgroups+bounces-17386-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 03:30:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1846DF9BB
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 03:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jszc46Un;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17386-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17386-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5661F30254EE
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EC736A34C;
	Tue, 30 Jun 2026 01:30:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6B36F8EA
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 01:29:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783010; cv=none; b=em5Hbrx7t9krwpUKs6O6mIooSgKte9LSwpNuPeleeTN0LBEPhZ6trAY0BXMN5X3GwOKSQL/Dy8U2CcvMUGVE1+uLcppO7iSePtU7LRGssOCF8uXcygtxg//IxrevAoEVjcnA3cVmE738e62lkMCOzezkvshjG2oCn8Mccplz9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783010; c=relaxed/simple;
	bh=fC2utO8KjnM+7TkHp1lSHynKJ6hfdXI72U5IvjcQtbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVUe5f9uaKSovpf1JV8ufKMc/AuWOPHttUuIKSGeDXpHbQDKUXusoRimEDfDCGAHwztziVZGWB1eUqLYIMawWjp1WgjUT4YkuS49y/RDOLTGbEOYXu6lXiVmGmzVFbM8plG6OMwgZ8wBDuoYUtwKEeBpuLhsdRnQctdSP5R7MVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jszc46Un; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782782997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNMKfSq2rmG4Tk4WWqhPVEGirGb4v0bYHt6h2drRT1Y=;
	b=jszc46UnWBKJ802otRkO/5UZQNkUddnQJ9ptKfEgL1K0FluYSyc/NeY2+PMS5KLYXodKyE
	EKseZFhOVvRVUt3u1GyTV8gcFigA3N7nO9AhQ5ldaJ4KmbPdIfGuVAxHmzGMcDTYXjOXvX
	LJUoJ0SbQcQPsYoct3bDxCkxemu3efk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com,
	yingfu.zhou@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] memcg-v1: bail out reclaim when memcg is dying
Date: Tue, 30 Jun 2026 09:29:04 +0800
Message-ID: <20260630012909.144372-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260630012909.144372-1-jiayuan.chen@linux.dev>
References: <20260630012909.144372-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17386-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:yingfu.zhou@shopee.com,m:jiayuan.chen@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:qi.zheng@linux.dev,m:ljs@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C1846DF9BB

From: Jiayuan Chen <jiayuan.chen@shopee.com>

The legacy memory.limit_in_bytes and memory.memsw.limit_in_bytes writers
retry page_counter_set_max() by reclaiming synchronously in the writer
context. memory.force_empty similarly loops in synchronous reclaim until
the cgroup is empty or reclaim stops making progress.

These writes hold a kernfs active reference on the file. If cgroup removal
starts in parallel, the remover sets CSS_DYING and then waits in
kernfs_drain() under cgroup_mutex for the active reference to drain.
Continuing reclaim after the memcg is dying can therefore delay cgroup
removal and keep cgroup_mutex held for a long time.

Stop the v1 reclaim loops once the memcg is dying. For limit resizing,
keep the existing -EBUSY semantics when the new limit could not be
installed. For memory.force_empty, keep the existing best-effort success
semantics.

Reported-by: Zhou Yingfu <yingfu.zhou@shopee.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/memcontrol-v1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 765069211567..ad23de985d9a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1513,6 +1513,9 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		if (!ret)
 			break;
 
+		if (memcg_is_dying(memcg))
+			break;
+
 		if (!drained) {
 			drain_all_stock(memcg);
 			drained = true;
@@ -1551,6 +1554,9 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 		if (signal_pending(current))
 			return -EINTR;
 
+		if (memcg_is_dying(memcg))
+			break;
+
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
 						  MEMCG_RECLAIM_MAY_SWAP, NULL))
 			nr_retries--;
-- 
2.43.0


