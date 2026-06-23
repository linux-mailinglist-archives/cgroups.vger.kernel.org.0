Return-Path: <cgroups+bounces-17192-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ru3MAa3KOmpnHAgAu9opvQ
	(envelope-from <cgroups+bounces-17192-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:04:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F248C6B95A6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:04:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ptVNkGT5;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17192-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17192-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6554530A6A88
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4838D3E6;
	Tue, 23 Jun 2026 18:01:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB8391846
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:01:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237692; cv=none; b=DNUqUwfP+JCXFvFcduIIVpk+gE3JO6sZoatxL+35YdxYj4U0VRL/LdzdVHq2VB+HIp74Iz0MVU9srK42onBQtie2i8xRfR56Qo2MhrouBfi9PAHQJe5czYtDlYC8vb8H+iwZ/fRNUDGMk0MFdXvSdtG6Jt0aWcr1btAXg7DEko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237692; c=relaxed/simple;
	bh=ZZ9V3z/btQd038efIhrlg2T/8T5h48YyZVg+hDwwQEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdkVmJujfYputoxVRd8J97dnQehgjjlOVBLBRcz/SpGX4kmFI1rnJUn7AUWPiko2Ee/TYC2AqrhmulvRMvXbmeJNEsqccTmmNnLvwHbH3hHCZiYGRHezx76kNIhGTsgHzIosaDeg3dkYI9sxqLd2pBUJP++JBa1/+UF5aUanCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptVNkGT5; arc=none smtp.client-ip=209.85.210.52
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e93e0a3364so121593a34.3
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237689; x=1782842489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0cD7xT/1LEgCqENdxhvxeeA9K5MWSbIZS67SSvT22o=;
        b=ptVNkGT5QQ110GDjmiow/PsR15hBXV37lH8sSIpe4PZ7E0hhyWCttBtcFpyRsSfGT/
         6Fp9plZ17G6q1d/srcU01z1QTlEp7vy68y/M7hMHac6FcfOn+l7pWw9CQ0j6MNABbU/f
         3QC+xLccvpnQFInRiPwv1DIAapTzWiI5Elx45KT+xgJg0a+WjrBtojJbiYiq/6zw1Mfe
         8jexl5FUplNF8xxIPJHZiyXiBYT+Nbv0I+1uZcdCnvZ9h0n5wMV5/NBue3M9mbRunvDv
         mLhpjsmSeGq3qeu3IS6h0ZgBrRvzyPEOeD2UdyBQ1ShMZ8agHfFMc18KN77MxG8FOcLc
         wK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237689; x=1782842489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0cD7xT/1LEgCqENdxhvxeeA9K5MWSbIZS67SSvT22o=;
        b=IeJnoTcYUc3pyZ1Kl7iyx6/Y3xMsRkwdmWk/oLywpwnOjmIOeZf7oKxtoOlGJEpmoj
         Vd1xNnZsYCNfhAO3fH3P21//o2foWpwXpLHSX/s2rjt4dJ2PX+3zsbkdM1xwDGLRCEuX
         Y46Fkb0WnVcpOoe7j6b9+dNaD2+mZPkNTzS0IXCeyoIYflbcx6vSfT6C9lzN5+dSWHAr
         2l7JczLhASXb08ibQnP87zqlleNJiJfAa5AiORFA8p34MQS7QAxJdflgmZirCRLWu5DH
         XLw4dqvECxwsj0+4zFs7j4ms7fBG8zVS1o/nS2A5witBEzVPmNhB5G9YmSXYn+0eMkSI
         DJIg==
X-Forwarded-Encrypted: i=1; AFNElJ8eoFzMZkGGDFaSWJ4XpV6ocmR7JLYPhhUoF+Py7G9u6n151M6gv5zDTOdnYLgRbDQZfmtnwowh@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmmH5LeAK1ZOzTSse2T5hhdKX6SHsF1vy2amIxPFfeSRju1kR
	TeUoKjcyncbosgoxbkVDV/5MeEwlQ34AUsHxIsJjoUohgj7sa6GrYkMo
X-Gm-Gg: AfdE7clG3YD4k4aLg/CeRGGAk1C5Zde3zA6trVDeGTgT0VAcHypr4lMTiYP9B7rRoza
	lmCtAhKOH5RMyvOxUAPbzELXoTSQvA79n9BZKt09Se25NCgFePaDVE28jhKk+aja07/5XIbQgr+
	21159o4WL4A4FDNOZ9pfdtKaHsS4bhJ5ybXkAElWP5myqcvbYXJx01pA5+2h845B2dDxuuONrWb
	U40trenusC7NrEqjtc1wrDzHeyk2jj4vNpZKPB+UmwWkAjcJLqbkux29JOLs1RCPtRxN8FORWsP
	ZE53fn8O0VUS5RuOEER3oAzhq3FiXgOuqDwg9DnpECYjT6KmTl3J/r3C1+KDv6FFWFQcnEcoVtm
	8Ab9cC8LT/Xti5o0t8vqndXPtV/fVMjdP95Zr/p1jY18HKzU5Pq8e9UZOj2CB/Uocba1HDLcB4N
	0Hvh1qHcqp50Fe83vZxq36Gmo6oygJ3fxOvW8Ayw4pCw==
X-Received: by 2002:a05:6830:210d:b0:7e6:ed97:ce5a with SMTP id 46e09a7af769-7e986a0e11bmr74036a34.4.1782237688802;
        Tue, 23 Jun 2026 11:01:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424c93fsm10349972a34.14.2026.06.23.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:01:28 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 2/5] mm/memcontrol: flatten try_charge_memcg control flow
Date: Tue, 23 Jun 2026 11:01:20 -0700
Message-ID: <20260623180124.868655-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
References: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17192-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F248C6B95A6

Refactor try_charge_memcg by flattening the nested memsw/memory
page_counter operations to separate the logic between the two.

When page_counter_try_charge is made stock-aware, this flattening makes
the control flow easier to follow since each page counter now has its
own success/failure paths.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af082326..306658fd55512 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2616,18 +2616,21 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		batch = nr_pages;
 
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
-	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
-			goto done_restock;
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
-	} else {
+	if (do_memsw_account() &&
+	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
+		goto reclaim;
 	}
 
+	if (page_counter_try_charge(&memcg->memory, batch, &counter))
+		goto done_restock;
+
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, batch);
+	mem_over_limit = mem_cgroup_from_counter(counter, memory);
+
+reclaim:
 	if (batch > nr_pages) {
 		batch = nr_pages;
 		goto retry;
-- 
2.53.0-Meta


