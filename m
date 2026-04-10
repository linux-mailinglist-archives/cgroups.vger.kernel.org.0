Return-Path: <cgroups+bounces-15215-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGxKDNBm2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15215-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F923DCBD7
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2711F3054BB7
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302F32ED40;
	Fri, 10 Apr 2026 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akywdp/s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D823AA4ED
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855277; cv=none; b=nqZTC7Xnz5cXB1Zhvt56poA1febIspxOYG5H1oXYGTjJZ2nBiwcMeK4B4Ze67LvlbmzUf8dZ362FVTRzJiSuOvWNwGjOXc5iCH9Oh9mPLCr8EoeV/nK4MaGCtkUmf2bA1hafb4/I7wOV3IkOH7bC6Wb0VnzggnaLNQdkm+arPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855277; c=relaxed/simple;
	bh=fNBJAySEqaEJuZHafhBMXn/gZ8VxBkV7g0IuVKIaHHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnGLiRJoo1jnIsFmw2zQA/WPKH7yGUasuXT1dyix4kV5ge1/UJwhRuCfox8PCnHHO8dvq+9psLxvucgvz5p8tFnFqcntLzFTIQ4H62W+HUPcHT/WIy6eQt/C5RPZfUeUiqQnvb3g9CsQtQKGBhikFndfWrkWljX2jBNTeLVSSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akywdp/s; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1285075a34.1
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855274; x=1776460074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPucxgysmex46OWvxebyn8gwYFbxkYWxk7oOg4s3POI=;
        b=akywdp/sY9WaRGsdI5CBnKquJwydApWBhDEI10AzpK95dTt+oBRmUOTenGqBOc1iAB
         5XZOLawq+7z9F3JN9Cg8W6ackRo/bQZA9OeuNJT5u2Qb3q626PfoWNtn5NmPSaVL8e5Y
         yBhuUxgUk6G1IE5Jtkxiiq899UoGpKWAj4ALZBvkfuzrKo8axyqvu5JqgqJvpk1SAlZ+
         G81SE0a7aoCOWs5lx/+apUVYrclKyJJkSJNOVHXoaEHr5LmB0YFYJm+UtRCLKdmbuBda
         oymgntVikPugPCRnKBGjGy34wsZGteDQ49uR6aQjgmx4ZOo3AbB108HUUQB18ywH7nHc
         LAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855274; x=1776460074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HPucxgysmex46OWvxebyn8gwYFbxkYWxk7oOg4s3POI=;
        b=EWcSzgYYOrlOXshJLDORc0hOEOEdkbcbBegXaQ2PavAruPDEXBJJGdmqbNfeYJa7e8
         x38STI90cyJoGVDR5WT/xB1rtVCkuN/EIzANyEIcXNNdxZIS8oehUXphvaJEdnGFc9oo
         GJ0BXFQTfDkbvUGLYQQB6S+bpLwRxLBfqQjZI+69lZEum1/sKUkbf32D7nDKzvxygFbm
         NCABrgmXLPbS5hYeh1j1mtQWOqSxxGtoRvnM/EQRXUpamTjNSuoSXy5BTLtoI77m5Cvx
         tyFbcEXUctsccMUmIMloApRzQMPZnVmEpE8K/U2Z9apZeo81OFkN1cO7ujdIbL90XvIL
         kkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUBt7gKlpFAt1XlVJhzFp1+7j+C9cctPDUH9fv5l4NsdrxtgjJgG8MrDX8ZPN1oEoJIPvtz7X5L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ddRBlB9mw/cZY5OKlYov82KLRMknk0rzAE1ZMyQj8EQziwEz
	wrbrwa8WYnGyNw9fXLYfkSSBH5R71jgzMR5WcxyfelHNNrz1BBxAxkb/
X-Gm-Gg: AeBDiespIHASYZM+em8Ad76GvCfJZQNYjQi5keqUesbOyuKwlP6UMvo0xk8Nj00UkOL
	vO2kR6ESg/KBqLA/G0KNH41zDsSlPwLTca2jqS8oNnzwcivCPiyRi8awvyysQ0mLdJ9uc58TtrV
	9S1BxU3TMnuE8JLR4j9wgCciPFnLf3umzOUxhSJHk510CreZtv1SMTpFsCjLxbfMrDux3eozd7v
	HNEtFF6EmSCtWXoL6sRbq78mt9IaxitOim8RmQPPTlJjPX7u556vA6ureGbcVbnDFR9cwUV7nwa
	hYq5HLwmHYlzBIqw96qpV7560Kvtq/xu578jtwv4b9SWtT4Yk0Eg8D9DrLrB3EXBw597phcrOrH
	nHzfDExK46FxY/LsMe56AA61Q8V8UXSeiUHPCh0YraJdgiDVcO5F3k9qzx3ap2FVAZBQhufOqb7
	OHf3tE8EB7f6Ttv23ObB8xbQFXlsgskEUL
X-Received: by 2002:a05:6830:828e:b0:7d7:5113:f83a with SMTP id 46e09a7af769-7dc27e4ed34mr2752617a34.25.1775855274137;
        Fri, 10 Apr 2026 14:07:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26576d30sm3085434a34.4.2026.04.10.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/8 RFC] mm/memcontrol: optimize memsw stock for cgroup v1
Date: Fri, 10 Apr 2026 14:07:00 -0700
Message-ID: <20260410210742.550489-7-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15215-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: D9F923DCBD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, each memcg had its own stock, which was shared by all page
counters within it. Specifically in try_charge_memcg, the stock limit
check would occur before the memsw and memory page_counters were
charged hierarchically.

Now that the memcg stock was folded into the page_counter level, and we
have replaced try_charge_memcg's stock check against the memory
page_counter's stock, this leaves no fast path available for cgroup v1's
memsw check.

Introduce a new stock for the memsw page_counter, charged and uncharged
independently from the memory page_counter. This provides better caching
on cgroup v1:

The best case scenario is when both the memsw and memory page_counters
can use their cached stock charge; this is the old behavior.

The halfway scenario is when either the memsw or memory page_counter
is within the stock size, but the other isn't. This requires one
hierarchical charge.

The worst case scenario is when both memsw and memory page_counters
are over their limit, and must walk two page_counter hierarchies. This
is the same as the old behavior.

By introducing an indepednent stock for memsw, we can avoid the worst
case scenario more often and can fail or succeed separately from the
memory page counter.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 27d2edd5a7832..6d50f5d667434 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2245,8 +2245,10 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 	if (!mutex_trylock(&percpu_charge_mutex))
 		return;
 
-	for_each_mem_cgroup_tree(memcg, root_memcg)
+	for_each_mem_cgroup_tree(memcg, root_memcg) {
 		page_counter_drain_stock(&memcg->memory);
+		page_counter_drain_stock(&memcg->memsw);
+	}
 
 	/* Drain obj_stock on all online CPUs */
 	migrate_disable();
@@ -2275,8 +2277,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
 
-	for_each_mem_cgroup(memcg)
+	for_each_mem_cgroup(memcg) {
 		page_counter_drain_cpu(&memcg->memory, cpu);
+		page_counter_drain_cpu(&memcg->memsw, cpu);
+	}
 
 	return 0;
 }
@@ -4111,6 +4115,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	/* failure is nonfatal, charges fall back to direct hierarchy */
 	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	if (do_memsw_account())
+		page_counter_enable_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
 
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
@@ -4175,6 +4181,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 	page_counter_disable_stock(&memcg->memory);
+	page_counter_disable_stock(&memcg->memsw);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
-- 
2.52.0


