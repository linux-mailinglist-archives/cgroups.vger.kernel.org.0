Return-Path: <cgroups+bounces-16257-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGT+E6adFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16257-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 084595CDEB0
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CD030254A7
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BD3939A6;
	Mon, 25 May 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNrvbyvB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F1393DC0
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735910; cv=none; b=Dwu+0X3JEdwcbFC8j5fBAlrFmFtdWSqPywfKk+7w01KZTzJLDQ16x1+0CAo1NqgPFeDQFsKz5pIE6qJwP+AyEernh7yTvzF2LxR4BvUegRf/bIoLAzIApmDHYtGcWaeL/0Fx+pX0BNwtQ5sLfnoA5EnkSKyfRYtzW4ZO/YjqC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735910; c=relaxed/simple;
	bh=UapiZIDwIAH3hwELIidQYiIyRmDbdsmxK5RqCHCIn6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxDcx/83y2uS1L/6sHbWNDhBFhpl+OFKq1xzc98eE3bDdoXLvEN+R7G+Jtse+JVTdKV7ikIrI9ad5kuS4XKmGRmZbN2XWBtx4Jw5J8slpxFZmDF9Sr+KMNyWbqarxvCtxpGZ2H507bhL+C+AkTrBMWvhmEUibUA62hVi8rAHDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNrvbyvB; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bfe055ffbso72146fac.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735908; x=1780340708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbriz7dbk9TD0L3VAQpwYxY9mGZG6ZyIbAJOMgP+gHw=;
        b=MNrvbyvBZOu0lqPp5vvG8wE1uDZNizxxCrcyMBUDBOIa2JVXIV5ETxEpkuWsYARRrU
         pKMwkqGdjGhlwiXIfBSW5PqVDoPEMhEQLa5p0eb9N6LFpVSoG43/oac+wGY1ahhoN+mf
         AjleL1cKj02/79fR+Lojrub9OdBD/H/js1C6A1QmlFIx17UXWtsvj4MIX8FdrEOfKYcs
         7Yw9Pl1gHwwAXDYyd/0TjzM92NTSlJ42Amjv1zcQiKt2laXTs0ok85Y2ZXkb9joAjPt6
         fQmE311dyoQBKnw7rDOIj/E70gn3qlUaxXLGIX+yhBt63qFi6oudQu2vQe6v3LSzGcBy
         zkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735908; x=1780340708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbriz7dbk9TD0L3VAQpwYxY9mGZG6ZyIbAJOMgP+gHw=;
        b=YmWlM5v4Xbtu1nzMIM+h1G4Z6aMPXOrk3elIqtleNwj4fuGq9prL9OIEKJHM6kR4Rx
         rKB1HVE6UzS2gjUJ/qM12iG5hxA2HlGKuFNWvzQbuAcvEbAwQ5F16LUGqketz5Dpw0BV
         UlIV5WoWQRFYqQdgnL5nZkzIYlGNUt4U0vldTpbiEtRQn/5gyzBHTA+9impqauTBwIUL
         23Nx2xkPA5U6pW2ByoClzkDRjxTiLSyI78ue/L3msv4cotgvsW9Fjn2IgNsXS1r3e3cU
         VHjIPsv3UIS7bvPYugVE6UqRjcsjuCUVLmHowlTDhB6xgHHN5n29gkz5JIqMgLskwfxW
         nWAA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZnMLMcaMc0fk9cglxw3y9MnlFlW/mQrwLwFbhnZX2+mjN7I1tswM5rzPIsG8FAA/SJU5znteT@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXVlhQiWoRYYQvBT8XedHssJOvUGU+T8mxIaD1rTOC/v7SFmH
	Ii/+RExZZEbVNdcF22TAqp5ZDzOTpb/Qkp3nJd2IV3/43jKuST2HuxvW
X-Gm-Gg: Acq92OGajADQGE8R5vhw/8BrZWpj8a9jCnXnUaQeR7uow8V1AVqPdqeyeVui2Si5Ysi
	yIvRqn8cGtbwLiM2V3ISanzjiECt8aPZbteniOtlOKN1qpSEZP/wCxOJXvI04jBrZT83tPyAXCI
	f5ZnkNqhuC/Vof+PiLwh5UCXO0hgbDuURNzQxky8ZDgfLpfG1aU3R047YRxkpMuYlZfKhFIosls
	+L/MpCbU5csy2HfiIL1keFmVWLtzQNC4VQ/Ytb8VOVRZcCvfiPvsWIh+VtbTx0VlSSreBfO0VtU
	serAyVivl97nYlm8iuCkwRS5YYxI8PzhmvBihpzEYpHUkSsD7VQZwF9x8WF+p92ETWcp0pI1CrS
	gak4EbJnrPU5vlnb2aZqC5Cgv/K2hoUdSQOaWcti2cdbOL1xHqfVjVecL4RIM8r+LlbMslMuGUd
	9UoUCjrlbvvCPcF85QvjyD3C5hFeQ0PDXuthR61xBP+qVluPhuoe6jFuN/eDL4E41x
X-Received: by 2002:a05:6870:b0e5:b0:439:ca41:d517 with SMTP id 586e51a60fabf-43b5ae106d7mr9194388fac.27.1779735908121;
        Mon, 25 May 2026 12:05:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm10931364fac.6.2026.05.25.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:05:07 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/7 v3] mm/memcontrol: optimize memsw stock for cgroup v1
Date: Mon, 25 May 2026 12:04:52 -0700
Message-ID: <20260525190455.2843786-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16257-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 084595CDEB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, each memcg had its own stock, which was shared by all page
counters within it. Specifically in try_charge_memcg, the stock limit
check would occur before the memsw and memory page_counters were
charged hierarchically. Now that the memcg stock was folded into the
page_counter level, and we have replaced try_charge_memcg's stock check
against the memory page_counter's stock, this leaves no fast path available
for cgroup v1's memsw check.

Introduce a new stock for the memsw page_counter, charged independently
from the memory page_counter. This provides better caching on cgroup v1:

The best case scenario is when both the memsw and memory page_counters
can use their cached stock charge; this is the old behavior.

The halfway scenario is when either the memsw or memory page_counter
is within the stock size, but the other isn't. This requires one
hierarchical charge.

The worst case scenario is when both memsw and memory page_counters
are over their limit, and must walk two page_counter hierarchies. This
is the same as the old behavior.

By introducing an independent stock for memsw, we can avoid the worst
case scenario more often and can fail or succeed separately from the
memory page counter.

One user-visible change is that reported memsw usage may transiently
be lower than memory usage. This happens because each counter
independently batches the stock charges, so the visible values can
differ by up to the stock batch size (MEMCG_CHARGE_BATCH) pages.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 952c6f7430395..f20c9b829224a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2265,8 +2265,11 @@ static long drain_stock_on_cpu(void *arg)
 	struct mem_cgroup *root_memcg = arg;
 	struct mem_cgroup *memcg;
 
-	for_each_mem_cgroup_tree(memcg, root_memcg)
+	for_each_mem_cgroup_tree(memcg, root_memcg) {
 		page_counter_drain_stock_local(&memcg->memory);
+		if (do_memsw_account())
+			page_counter_drain_stock_local(&memcg->memsw);
+	}
 
 	return 0;
 }
@@ -2313,8 +2316,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
 
-	for_each_mem_cgroup(memcg)
+	for_each_mem_cgroup(memcg) {
 		page_counter_drain_stock_cpu(&memcg->memory, cpu);
+		if (do_memsw_account())
+			page_counter_drain_stock_cpu(&memcg->memsw, cpu);
+	}
 
 	return 0;
 }
@@ -4259,6 +4265,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	/* failure is nonfatal, charges fall back to direct hierarchy */
 	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	if (do_memsw_account())
+		page_counter_enable_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
 
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
@@ -4323,6 +4331,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 	page_counter_disable_stock(&memcg->memory);
+	if (do_memsw_account())
+		page_counter_disable_stock(&memcg->memsw);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
-- 
2.53.0-Meta


