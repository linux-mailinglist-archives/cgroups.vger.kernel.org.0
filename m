Return-Path: <cgroups+bounces-14855-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G3ALqLguWk7PAIAu9opvQ
	(envelope-from <cgroups+bounces-14855-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A97E12B408E
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB01230B5ADC
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5D3F9F31;
	Tue, 17 Mar 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNmTIL67"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4339C62A
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788845; cv=none; b=t9EmN67N2sDv8hpKLk83PmDXYbRAwoNwBDk2VyWh27RkiMjuRSoDF5BTZqSYArT0hxOwnREcyl4shTYyCsctCsFqZEhZ6H2Fs0rO5fqG446bmZyqnqArAPwuN9ampZ00voBxenk85e8qSPEnNQGQv9Lb9SAy1iDKX1oPLTGZJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788845; c=relaxed/simple;
	bh=YScM6Kr7HMm7e7moOv23pU8w0YmvqNuDylDtSGuk148=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6KSwqerRHcoHxJwZpFAkwKb42qf4PCjhrthJjm9oKhH3akrrdNtB1iRtPMGigzskAPs7Yz3R2parE8fEMI6f77E9zpBOHLua7nHyQ6jzt24YZWfombX2BAdyrCIaartzazlD3EXaSHd5BEMe2xloFOzI7/iIGKBghsRXhSQcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNmTIL67; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso122572413c88.0
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773788844; x=1774393644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrgwEjKu+QJdHEXo5hFZmjJR7NuvkUAEBDxhWygoT50=;
        b=iNmTIL67p1EKa+bS8YZjmL8jMIA4RhXiVDgMJL14pn0v6le9h+i7uFAMeSoLdo4iE6
         e0aqtrtEOaIguuFg7Vw/h0fiwV1B8BUVFD+3b/eB+uyc07oLCzKvpaBGwWuljHrci49X
         EDEgMe1ETLO3NILIFGWrziJBzqskS7xGxzbtkdHmETP6BtIOnA+hwV/aLcVf28IbdYXk
         NElcKwOPrdix8XzKclunWmi36esOZUpbW/vBx5QOF4KQJOo3VAZjnAYwtuLYvaXU6ydV
         J40Vz9a7iQ/BibgAQipqIZenJ+AR2vSoZ/h5N05EZIRc+eVVB4WjgiPc2//1hG55BTwL
         betg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788844; x=1774393644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrgwEjKu+QJdHEXo5hFZmjJR7NuvkUAEBDxhWygoT50=;
        b=Ah31U+IrBqfU85oPRy4CxVCQowWMjCkgOkXRrPksVER7XWEq4pArC5SIJ8Kv4HP9fa
         v/rS9ItKkHRAmu/ZAAWZ83/L9xa+ZjGzqSWd/+uP0WB+evxttCNYpkzn2v2heWPBytbt
         fVVplOnL6mwzIiRRMjQ6kKYf6NBolsv9f0pu1RbPtrFrlbI334sGSfXuqvg/Po/ptqsb
         w2au1nkziFwL+NecVPIQOCno+O1AGs7I1Jc2ntReiUVga9pB5M57gOc2aK1hLiFTf+kX
         1KyidVYYhwCFTPSWBLlk8oviZImGCc0MP9vCYhvVHLPiBod0uRgSRtt7m3eYLKPnsBWg
         7yyg==
X-Forwarded-Encrypted: i=1; AJvYcCUov36jO7ZPWczuCEN+wE46nHT9863beuxBxjCjUwkG3/9fuNmUB0Xln/l2b9MYLNZ0A901/vtt@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvjuhCTKbbnhgiqx+RLOva7I+4WBeXMku3VwSdcH9tcjvy4lJ
	ARaXZ2q9Lp5KfCVE6I6gxy15jwmAIxf5k1xTeXNsAUYq/O9/eadWhpfkBDe1N11iL17vJQs4LQW
	iTVMWXl0IyMoEfQ==
X-Received: from dlbep9.prod.google.com ([2002:a05:7022:1089:b0:128:e027:28aa])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:619c:b0:127:3915:76b2 with SMTP id a92af1059eb24-129a71795ccmr770593c88.27.1773788843379;
 Tue, 17 Mar 2026 16:07:23 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:07:00 +0000
In-Reply-To: <20260317230720.990329-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317230720.990329-1-bingjiao@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317230720.990329-2-bingjiao@google.com>
Subject: [PATCH 1/3] mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: Bing Jiao <bingjiao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14855-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A97E12B408E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In try_charge_memcg(), the 'reclaim_options' variable is initialized
once at the start of the function. However, the function contains a
retry loop. If reclaim_options were modified during an iteration
(e.g., by encountering a memsw limit), the modified state would
persist into subsequent retries.

This could lead to incorrect reclaim behavior, such as anon pages
cannot be reclaimed if memsw has quotas after retries.

Fix by moving the initialization of 'reclaim_options' inside the
retry loop, ensuring a clean state for every reclaim attempt.

Fixes: 73b73bac90d9 ("mm: vmpressure: don't count proactive reclaim in vmpressure")
Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f..303ac622d22d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2558,7 +2558,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
-	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	unsigned int reclaim_options;
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
@@ -2572,6 +2572,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		/* Avoid the refill and flush of the older stock */
 		batch = nr_pages;

+	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		if (page_counter_try_charge(&memcg->memory, batch, &counter))
--
2.53.0.851.ga537e3e6e9-goog


