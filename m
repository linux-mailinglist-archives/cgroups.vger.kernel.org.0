Return-Path: <cgroups+bounces-14857-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICf2IbfguWlhPAIAu9opvQ
	(envelope-from <cgroups+bounces-14857-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:16:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDA2B40E5
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3E4A30CDF20
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844513FA5E6;
	Tue, 17 Mar 2026 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5UjtZbv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59F3F9F2A
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788849; cv=none; b=DQIkuL4qI86nhNZqYkIglXiSynxsjiAagX8CqSEqU6mW/mmxZFsJPPDhH0ceCH1ZDTyrmbA/ADzn7YYRcxogiQFp//21N1faHFWF5QYxS0hL9UzvAFaFL0Ur/SSO2RiYpbUeemogYD7KAIQ7uwdlw14I3dt8eSGz1YuvhvbKLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788849; c=relaxed/simple;
	bh=ZfWE2COIH+ldGUo90wdzJ/MxDEymNSaHSsDjounjNKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZrMq1fDXkZp9bQjcvASk3mbMOq45nNjXHGCNkOM0aPnSplH1WQUP/XsbxOfn5rVldDeAqgeGFuhheNhWhC8LX8lV42Qgy+hMbknyJ0dXMc+gMKjxSqFdgqw2qI0/TMnmYsbiwhphFWrDuVGrD9rSBRd8tuqEiiKMiDKkqOZ+mrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5UjtZbv; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128d59030d0so2037787c88.0
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773788847; x=1774393647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sLkrHizaGZBp890B7+nzygesvVkoY/tFf4Qx2iHrc0=;
        b=D5UjtZbv3NJS6j8ZtyKUljmjPFX3Bd52ycLqWXTKwyBlR+Ebja4J3fpcSYNqFAF8/k
         ox4ickECjfEHg8yBCX1MJiyB755Qk0eClW52q7t1+dLc4gyHnBS70m8PESLg5N2Nj5a9
         jKlx8WzWsxun/9DUxHMDrCr7GVZoRMImoMC/WLnkhRusFdAGAE/eSZ/FeN5yJmCOlLxb
         0ZD1jOvHx8+1/cEpfnhFMjkhIrJsK8pri6gSKxLQYR+it8VbuDZ2LRp9V94oYyNVpvgB
         r9LY0IgvBFpsAPS+FhGqkUGRX+nhupv4+cFFE5xErxQkadnfIwGzQXz0R6C//bPvNqKS
         tlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788847; x=1774393647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sLkrHizaGZBp890B7+nzygesvVkoY/tFf4Qx2iHrc0=;
        b=oz2SnARlqpC1Z0XT0DUwSwqwSa7obUY9ijiShXxnWvVletAMc0rq/r4sMKx8l0pZKn
         uF48Fmc+iuPV8sABwgCXIiiwlWn2SyNNarJhgZrB2pjLVDHZxbec9XD6OvolocxiFvYp
         PIOd6jVjJ8ZcOzJFnP7v1h3I4jZ1+96lJ57znvB5rlmOSnCAxgJKqd+KXrUMfwjpkj9P
         dzltWe/ZQVpEZPgxQNrKuJlMAb+IZfL1eYYjU+aXvs0UahjJu/gQWP7Bd2aXbf+UVsdO
         KrdGhk6BndlDir4l9mjYQCL8gX730zPF16ca1YgJjLr27XZMeju4Re2e8gSIIHhYK8qu
         Kykg==
X-Forwarded-Encrypted: i=1; AJvYcCX26DTflgP24cq1HOd02bgFsQO2howxl2vJ6aLd9LUXFJzvlG+usQ94kgEegW2Hc33PJKO/AGFM@vger.kernel.org
X-Gm-Message-State: AOJu0YzziTiPKN5IJYwnIlS9mhaGDbAz7XCfzUcTyHs94TiDGHlBkFRT
	1HSiNVmBGnNg76TrV7xU43iE7tqrUKYarAw47ngmhP1Z64jjSVvqMh+q/zsnSGZGxrtJdm6BMV5
	Jxc6phnNMcF9sNw==
X-Received: from dlbrn2.prod.google.com ([2002:a05:7022:1502:b0:128:d185:c6ff])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2218:b0:119:e569:fb9b with SMTP id a92af1059eb24-129a7111483mr694227c88.10.1773788846767;
 Tue, 17 Mar 2026 16:07:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:07:02 +0000
In-Reply-To: <20260317230720.990329-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317230720.990329-1-bingjiao@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317230720.990329-4-bingjiao@google.com>
Subject: [PATCH 3/3] mm/vmscan: add demote= option to proactive reclaim
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14857-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64FDA2B40E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tiered-memory systems, proactive memory reclaim (via the cgroup
memory.reclaim interface) can demote pages to a lower memory tier
before eventually reclaiming them to swap.

Add a 'demote=%u' option to memory.reclaim to allow users to control
this behavior. Setting 'demote=1' enables demotion, while 'demote=0'
disables it. By default, demote is disabled (0).

This change ensures that proactive reclaim behaves consistently with
cgroup limit-based reclaim (e.g., memory.high), where the goal is
typically to reduce the overall memory footprint rather than migrating
it to slower tiers.

Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 mm/vmscan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7a8617ba1748..80194270fa2e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7878,11 +7878,13 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
 	MEMORY_RECLAIM_SWAPPINESS_MAX,
+	MEMORY_RECLAIM_ALLOW_DEMOTION,
 	MEMORY_RECLAIM_NULL,
 };
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
 	{ MEMORY_RECLAIM_SWAPPINESS_MAX, "swappiness=max"},
+	{ MEMORY_RECLAIM_ALLOW_DEMOTION, "demote=%u"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };

@@ -7890,6 +7892,7 @@ int user_proactive_reclaim(char *buf,
 			   struct mem_cgroup *memcg, pg_data_t *pgdat)
 {
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned int allow_demotion = 0;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	int swappiness = -1;
 	char *old_buf, *start;
@@ -7922,6 +7925,10 @@ int user_proactive_reclaim(char *buf,
 		case MEMORY_RECLAIM_SWAPPINESS_MAX:
 			swappiness = SWAPPINESS_ANON_ONLY;
 			break;
+		case MEMORY_RECLAIM_ALLOW_DEMOTION:
+			if (match_uint(&args[0], &allow_demotion))
+				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -7947,6 +7954,8 @@ int user_proactive_reclaim(char *buf,

 			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
 					  MEMCG_RECLAIM_PROACTIVE;
+			if (!allow_demotion)
+				reclaim_options |= MEMCG_RECLAIM_NO_DEMOTION;
 			reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						 batch_size, gfp_mask,
 						 reclaim_options,
@@ -7962,6 +7971,7 @@ int user_proactive_reclaim(char *buf,
 				.may_unmap = 1,
 				.may_swap = 1,
 				.proactive = 1,
+				.no_demotion = !(allow_demotion),
 			};

 			if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED,
--
2.53.0.851.ga537e3e6e9-goog


