Return-Path: <cgroups+bounces-16672-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YzOGCPwImrmfQEAu9opvQ
	(envelope-from <cgroups+bounces-16672-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:49:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1412A649794
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:49:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hGkRBjoo;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16672-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16672-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A846430AD5D2
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7594418F2;
	Fri,  5 Jun 2026 15:36:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D03E715C
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673776; cv=none; b=QxikcBckftlaTaV4hYLiD2ZJf3vHGgi8vnBWXv01rTGAsx8ikpP5JKo+tFTqpy50qhxuwsBoWagRPSF469cdWwD4Y/lscKkdN9s+RcW/8MqWVXaK06cEXWAz7osgTVqnMj3LKB0hAn7FDJ+HOILQvv4uTYY2IFCEiAzJwXMzfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673776; c=relaxed/simple;
	bh=bIEWn8F7ak6CcMSj5/RHqMkAoowSiMeeFwKRoqLy4oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqjJjoX04s1KMqPXkXDUJRyds2Chey029DUpGJaLvvfjoiFWOIGFk14KRtJY3jjMQS08/sowMSoXbNKjZdqGKmcZOsY4c6EMLGWxplIEaLpZJPRbGGTu7ZaFIMS+5MXjN4Dux4e/jxLGfzr7jU/O9VXyp6G0FCI57w4cfNGupm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGkRBjoo; arc=none smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso926262eaf.2
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673771; x=1781278571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2POwf/K9X70lHx5WEcIKkTy5o0DDbStiw7GuBjFdd58=;
        b=hGkRBjoorE08vkSWw9XWZ9ybn3p19x/5BgvaFxUHZbac7XlPN7TU+dCnYRP2d5vlqE
         jSGjQ20foDou1QRiS9gvDh+8xX3BjVli9Q0EesOxw/TXdzDUeIjdTgDP2UssKhgawIJm
         CUMQ4T1u5BD1QmQJuQBSuvZCrVF+0KWstQflK4InW4/NxiH8ot41DWFfpBlKSjvRBKNd
         qkTiZASqL/Tsk9WPoHoF5kfU72hwLA7EKJQKDVVolysmE1EqgOteED938DwT3BZHG+ai
         vaQOGpOFhZ2ceVIQ4bMjLi795TCjfYR2ArXZchV4c//Zgf8wZOQ8URwIUJ0us6/RBkZp
         DxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673771; x=1781278571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2POwf/K9X70lHx5WEcIKkTy5o0DDbStiw7GuBjFdd58=;
        b=glRGUih9MHFlNhKrx3CB1ttkpVV/h/m0NtpamFE4FXPifZG2FMH0oaRF99FUEfYfYC
         16WqFVrWKVVN32bzIm1sT4TO4EAlsE1d2Icpj7OEcssy6kIhvsLu4soUkd0jE+GnC09f
         sB9BkBSoCrwRSMB1GXcD2aNEFWXhuDoi6SIlOTAoycZmkxIGV8keFOlj88OhT9w+mov2
         gjNFqDsbXW1k9VCIT6EkTjvCYDl0cMReYi52rRR67N6vy0fNqe3KKTn1WDre1hJk+HGY
         CEAwKrq4wvmHouXwrHoPx2exgYi0fLMkMSvX5FE6YjDXuxtwQFJ6XT9C1fR5+XYoOqbr
         Xmxw==
X-Forwarded-Encrypted: i=1; AFNElJ8AJ08UOB8q6VxaKDuQP0Yzth2jb+FGkZ4t2Gbnypb38mf/CaXtXTnIlTxYPAvNjYvHbOWwNeoK@vger.kernel.org
X-Gm-Message-State: AOJu0YwW87XLyc0JmfQYX7SNmDyYNEJxek2kJKYNhvnF+Mtv8eSdKy1B
	vzu6gkS8M4wpv/E0vK7MprppyOnDps0sUabLqZV2R6NixV7cyzs2C1wO
X-Gm-Gg: Acq92OEBHZbKuBRchz3+xhuTetGdJtW/Ujx+DilejmDpA+mz30hu6ktbxKED4CLc7nj
	afiZ0/Tlj2UQZBTIQTTlTp5PDewebaydCXC6ISV3xvvLTYWDUwInaydD3ZEVjokrOjvTIXc0vz7
	lmzvkmnhmRzU6xjn/Tp9tsJZJkqRPDjJBx9cg6ubHnQ4I5D9DazHUb8jXeBBiMrTCE1EpjkXCht
	vQMRp3ApOQ5jNQlG3GLnS/yUjYu1CZyDmLybNodhiOEi6jUHMlS9lJWsqFumIMKh8pxdg3bySe8
	BqIcYZhRtfahFaUMUfFe7v/AuOHFJXBV9oYtm3zE5YWapNRTB2JN9ghpkAFQUjF8UEtnjJEOlkC
	cc2Zo9HAtrzX/12qPPXe4broZUL3owWjFlq2O6q0aIaKIsE8ff5aKUTp/tBvN29xoc1xUeTx1eZ
	PzmcMj6InVh8tgtbUBqhwdVFYePUYiGqzbrYZOW7Bto1ZRCWXTn3zgJVgIVOswxJkp7HA2piJFS
	g==
X-Received: by 2002:a05:6820:4b03:b0:69e:59ec:f70b with SMTP id 006d021491bc7-69e68c19e22mr2043956eaf.37.1780673770989;
        Fri, 05 Jun 2026 08:36:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4620b0casm5398168eaf.3.2026.06.05.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:10 -0700 (PDT)
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
Subject: [PATCH 5/6 v3] mm/memcontrol: optimize memsw stock for cgroup v1
Date: Fri,  5 Jun 2026 08:36:01 -0700
Message-ID: <20260605153603.234296-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16672-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1412A649794

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
index 562ed9301f5a4..d0da2f842e2d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2274,8 +2274,11 @@ static long drain_stock_on_cpu(void *arg)
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
@@ -2324,8 +2327,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
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
@@ -4237,6 +4243,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	/* failure is nonfatal, charges fall back to direct hierarchy */
 	page_counter_alloc_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	if (do_memsw_account())
+		page_counter_alloc_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
 
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
@@ -4299,6 +4307,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	lru_gen_offline_memcg(memcg);
 
 	page_counter_disable_stock(&memcg->memory);
+	if (do_memsw_account())
+		page_counter_disable_stock(&memcg->memsw);
 	drain_all_stock(memcg);
 
 	mem_cgroup_private_id_put(memcg, 1);
-- 
2.53.0-Meta


