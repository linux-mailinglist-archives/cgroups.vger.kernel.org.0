Return-Path: <cgroups+bounces-16183-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF/8HgOKD2qnNAYAu9opvQ
	(envelope-from <cgroups+bounces-16183-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 00:41:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30185AC6DC
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 00:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859173058761
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D40357CF1;
	Thu, 21 May 2026 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v9g1XUQp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43105215F42
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403110; cv=none; b=RnOUutQIU5wAy6vz11sowiJHOUl/QaNxSeEztrI1cC8QA6E9++LlEaoPXaBcLYVm2/RekUhQyY4hByR/MXuFnf+WNRYgYdnJeh0C/2DBjIcFc1+UeSQatFZYjHAl1WQCLDYsKhUA1+euV5+Vp7IljlO303aRefpq0cAc8HsZSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403110; c=relaxed/simple;
	bh=cjoM5LSmWQBwTgtLHebSs5jQ0kPflzmMH4iiNReCfBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKulHfJ1RjZcjSy1rIou4iN0h67Lism3LtVmHgRtWo6deGrrjpszlJJwB2NYwpyZoOXXu+mfWq2KF1jWxnYj1yptnC/vBaEB9X8XrEmny1I+ZOtNaPJKXPCPmXSPzL09mB25TsIcRL0XE6btb4FmDJ6XoEWzMyX6YfwGlfpYRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v9g1XUQp; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779403096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tUi5+SVB2s9OC9ZFGLX4sLcZOUGZkUOYCUsvpkjnlcM=;
	b=v9g1XUQp0LjMCL5Wl+pmKwYTOD40EbXI0cC8p0Hy5ftbqmMQR7n+LPH2sK7JHitDRO9Ash
	pjlzVYFAkEAw4trzcwLdI+efv+bkiEua81mve2flffuu9mXyR5TnAtupzahMU/8vGoKNNg
	GjpSLF2YLa61lwDpo4H6YlePn7/Z4Uw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memcg: use round-robin victim selection in refill_stock
Date: Thu, 21 May 2026 15:37:51 -0700
Message-ID: <20260521223751.3794625-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16183-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: D30185AC6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Harry Yoo reported that get_random_u32_below() is not safe to call in
the nmi context and memcg charge draining can happen in nmi context.

More specifically get_random_u32_below() is neither reentrant- nor
NMI-safe: it acquires a per-cpu local_lock via local_lock_irqsave() on
the batched_entropy_u32 state. An NMI that lands on a CPU mid-update of
the ChaCha batch state and recurses into the random subsystem would
corrupt that state. The memcg_stock local_trylock prevents re-entry
on the percpu stock itself, but cannot protect an unrelated
subsystem's per-cpu lock.

Replace the random pick with a per-cpu round-robin counter stored in
memcg_stock_pcp and serialized by the same local_trylock that already
guards cached[] and nr_pages[]. No atomics, no random calls, no extra
locks needed.

Fixes: f735eebe55f8f ("memcg: multi-memcg percpu charge cache")
Reported-by: Harry Yoo <harry@kernel.org>
Closes: https://lore.kernel.org/4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org/
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0eb50e639f0a..6392a2704441 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2031,6 +2031,7 @@ struct memcg_stock_pcp {
 
 	struct work_struct work;
 	unsigned long flags;
+	uint8_t drain_idx;
 };
 
 static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
@@ -2214,7 +2215,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (!success) {
 		i = empty_slot;
 		if (i == -1) {
-			i = get_random_u32_below(NR_MEMCG_STOCK);
+			i = stock->drain_idx++;
+			if (stock->drain_idx == NR_MEMCG_STOCK)
+				stock->drain_idx = 0;
 			drain_stock(stock, i);
 		}
 		css_get(&memcg->css);
-- 
2.53.0-Meta


