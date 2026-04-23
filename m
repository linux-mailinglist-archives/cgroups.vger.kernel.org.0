Return-Path: <cgroups+bounces-15475-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGI2MiWD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15475-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:37:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCAB4574F8
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE067303B4E1
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946F346FBC;
	Thu, 23 Apr 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqdIkg/p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F2346776
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976495; cv=none; b=g8ZTQDPqXAlg7KlYbsmsQSlk+odDPIJ86zJkatfRzYMbp5JoK44VQLq+zVWurlzeI2Gmzj6aXrK2jR2gkORa6T8uiFCFLZ2UvtRaeLfKSzcRXnS5OpFthGTnLeslD/9Cm/VLYeVkjPTjXLuUAOTzxSnZ8IRAZoPeIndPjoFud88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976495; c=relaxed/simple;
	bh=m2egjhEQC0t2Vv15sybW+Jh3yKaxRsDhuxEWKn//AVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSdKLtPmnQ93QbgiIEowFY0IZdFslh7OnE3NBj/po77rwcNG0AkGWGCfFnQAIPMAyOoUtkm1QTzmGlSRC1I4BMDFdqultv4Fh9dC0lwqWzRXX7dRkEHSkOTt5fhwtg4DD6UCkuMsiDcxVwvhKzznZEz/1wttWhoGcSQhvw901qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqdIkg/p; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcd8ef572aso1912503a34.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976491; x=1777581291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE7KATctX9/flJ2U64Pj9KvPGOu/JEwhawIz5SLby7w=;
        b=LqdIkg/pl+32/D5WXRVGPF4Cb/fLswyGBJoR1Tkus3GaUzUlDmuS6XrMS0CSTL3cgm
         GNFizkLsQYdiPPGAphat09/+09J5umE339yZ1q9zR/ATemWDAcmK55cmbJK+kGgIMOvP
         an36297sY+UTdRk6lDfzoZ/qEek6hVmhvVLnz1z7ORSsjW1JD44auqq1QJ/sZrdv0tpS
         BIzg79gBVqrHqGu/TEMdP9m0PtqjGPtLwZMPjJcYl7DhXBGnym309smge1ITNSaX3OcM
         fW/bftW3XnWiEP+hx92cntPuy43khHtAmfi/hfTwJn2IItIxoW8ieDd6aBCR7PV89aNX
         QUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976491; x=1777581291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FE7KATctX9/flJ2U64Pj9KvPGOu/JEwhawIz5SLby7w=;
        b=qDM+LxveuqkmSo2qthVgdatVy9CDImzsEcyCqzUDmSxvgGXjkYP3JcU9n5qcW5gtY4
         J1bzrC76KCMw8Tz/GLy22BkK28CZIYfgpXNpmDX/VtA43QJM45NXdCZuqAmB2o8SkwLh
         sPg3EqEWfD5D49cM/AHDRkklpItpYFt/e9i2XpVIly6pqwSndy+egQ/HS0ncdMNiArXp
         o8vjbuRpee9eYHs0RKqe/uTeDzfpEpROPKbKvE6jrVILP+JoHnXZWCH9f+4vkqWsWqPp
         txUbLZv5b131Wn3I6ieCKjDLdf7eYzLjq6M4GTeDBN/8Hcg+NdPNA3RAB68Wrjf4YSgE
         3GHA==
X-Forwarded-Encrypted: i=1; AFNElJ+6FrIjvikaTosEDVumMU1B0BZ6bnv/ltnbw8+byWTVvrDYfuG6kuTL7iXK7DzkmcaQXEjExVUm@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTePBgm7Nd0FYpQptZBsU1MLIYRIR3Ft5Oyc49mVw5a0eUzGt
	/baOjZ9RPeZxtfzdOt0t2Prigj29LKig0IhflO8t0vZDxbPoYaO6tJTO
X-Gm-Gg: AeBDiev6YRI3o56G6sn3ZqjCVQwl3AAqhMjr8eVvpR0FJdME1SHPz00S7ZWN8Tu4ObR
	DyAvaewVAAx9Q9Apsq1QRznhfdYxST/3ngxghZfO5rUCfpizwZEFV08DP7CLIYWcSWVGRibVNKU
	h/VI+Mn+hSZmFemVmIOZFQKqxaFIozOj0W6Cte4X/iov4ta31waHS0px39uKv5q4Li4/r1A1jfF
	8kQKNGv0bDSqliWQsdwV3AOLtOKKVACrC+V/x7i/olpGTXpQ/9lZ3+XclO9wqKzw9h2eBibqJN/
	JstJDiOslZwqGtumsvihSo0RObwjlaE3wpewb8pE2D723/h1qLdNjn9TK17fCkIZprKhxF3Mlxr
	ZenXCkjz4xBe3WN8L/TiupTHUna0BY6W12/9QUD35wg7gYdaoBuA6y5uJBKJQQOd25f679GGqNQ
	ixtmN9FlRrnAEeLtK7CIrp4c3JIvY2i7gL
X-Received: by 2002:a05:6820:827:b0:694:97ca:9ec5 with SMTP id 006d021491bc7-69497caa1c1mr8146048eaf.51.1776976491332;
        Thu, 23 Apr 2026 13:34:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464c77c7fsm13161024eaf.0.2026.04.23.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:50 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 3/9 v2] mm/memcontrol: Refactor page_counter charging in try_charge_memcg
Date: Thu, 23 Apr 2026 13:34:37 -0700
Message-ID: <20260423203445.2914963-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15475-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BCAB4574F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for adding charging and uncharging of a new page_counter
toptier to try_charge_memcg, refactor the code so that it is easier to
roll back partial charges when any one of the three page_counters
fail to charge.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7de23ecd7cef6..8f7bedb55dbb1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2385,18 +2385,22 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 retry:
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
-	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
-			goto done_restock;
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, nr_pages);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
-	} else {
+
+	if (do_memsw_account() &&
+	    !page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
+		goto reclaim;
 	}
 
+	if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
+		goto done_restock;
+
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+	mem_over_limit = mem_cgroup_from_counter(counter, memory);
+
+reclaim:
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
-- 
2.52.0


