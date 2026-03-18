Return-Path: <cgroups+bounces-14880-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICbDLSYlu2nIfgIAu9opvQ
	(envelope-from <cgroups+bounces-14880-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:20:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFC2C3541
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B7B530A585A
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CB372664;
	Wed, 18 Mar 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1itBfS8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404C351C18
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872416; cv=none; b=jhOSkdCCSjwpzqoAne0C9/jf8L34Kb1x90BZDzppC0Q+oQ8IJrNHAyOyuU5LqfyEpMvGTX6pr2Ykn63JbFHT3lz/qlOisBwT8a5B0YBCnJyP1BBjtVc3IC6u0FD4gLCSICkivONpxp7aS5jkrcaG32rgLK2QXogoPrjUbf5RsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872416; c=relaxed/simple;
	bh=PXrce2FV4fNoIetAEQuoqhiTqGcIX9SnWgvXZgFZL0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KGXDUARmry05yjFY+zruSrMrpDEzoSJLzcevHoxTElLhLIA7RVAiPyNJWGtdS5OFMWQYLufCAxcGkFQoh5IFkoBfxbDy9m2fcR+5d5SbIFO59m7Do3uhJ8iG8VKtTA4sizeilLwl/NLU78czgi/c3RUggCx+hwPD1m4aEdSe43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1itBfS8; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd327d970so185879eec.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773872413; x=1774477213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XjdRK+apGY2bi7TFVCOUhj0XNVIb0zT+0LrkX1AC80=;
        b=F1itBfS8gIK6/b5BnHvTHBeHfyBTLwdTOufZ8bFatpvc/BBhZ1JTLZVyhb2EkgKAIh
         BZSVkxShYoep2glD28OLTa/0dbwOl3HDtUqmiF3qWzKkHu5OU7xnzsByGCzc6lXmGWNw
         zUzzYuwCu1v1MEmX/fBnZdmC9dosJvhN+uR/ztcauHcZ4EXH2ku5OlzylhCSPfPO3cyX
         SYNMD7fLSr25YmVuELqcXsDUe+4STbbGZeePyI5IaufYpiUnhwu7KAg69VjfsCO0ItxU
         EisEjdynGZpX8Be9HXZHNPMJgwl87YY7P+n4HxOjmOWceHC4jL3GdPD6HlxuVQn6i1Bo
         AOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872413; x=1774477213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XjdRK+apGY2bi7TFVCOUhj0XNVIb0zT+0LrkX1AC80=;
        b=p5HxvCfDQsv23QpD2f6YMmtyAwuSUTR1vnL4L3VrY8TWUkNC1RpI8S9YFjFfNUGsrX
         X4IycUq6UVxVqHz0gccJ6NZa3zles4act5lCqtzuAf+n3LPdvDx5a2525+VKJaIi5zvO
         +/xqxGsVG01ihss0dH1VdFpD2tJrr+wn+9KwOU/5YrwQeyl18jfu/vRpMoVVjnURaZRF
         3RTQmUHQRcCUXtfKnnPD5XyeQHfXeAdsblftfgZuCRZg4VNjZOY0jLsv0jSuPqMJvMJ/
         tABOMWJBLZ7s0JjYJQp2Ss8drvlCOnVECb1kyWij2+fdDMzdmTXIbOP3jqMHylZ/rKBA
         0Xjw==
X-Forwarded-Encrypted: i=1; AJvYcCUDpqexxQ0F5ao492crm5XE+M/uZqZg34ZhE9nqEkYywRCNng5tGOlxYHcVExc5l4M2YU5Dw9S9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn10B5vpRLw2mAx79ZwnhDFCpZ77i4DAyXhz8iWtVqI5GpXlqe
	98k9pl+qdGevWgd9jGToM94mGcvru8+sWCx+c7mrr8YjZ37hjXi7EecekbXv256naViS3pLTH6k
	bAykwuZIYRijhog==
X-Received: from dybmn16.prod.google.com ([2002:a05:7300:d210:b0:2c0:d899:d1a2])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e82c:b0:2be:1a8e:10bb with SMTP id 5a478bee46e88-2c0f3c333d0mr528958eec.12.1773872412419;
 Wed, 18 Mar 2026 15:20:12 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:19:46 +0000
In-Reply-To: <20260318215629.2849052-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318215629.2849052-1-bingjiao@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318221957.2979346-1-bingjiao@google.com>
Subject: [PATCH v3] mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
From: Bing Jiao <bingjiao@google.com>
To: bingjiao@google.com
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nphamcs@gmail.com, 
	rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, yosry@kernel.org, 
	youngjun.park@lge.com, yuanchu@google.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14880-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.907];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BDFC2C3541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In try_charge_memcg(), the 'reclaim_options' variable is initialized
once at the start of the function. However, the function contains a
retry loop. If reclaim_options were modified during an iteration
(e.g., by encountering a memsw limit), the modified state would
persist into subsequent retries.

This leads to incorrect reclaim behavior. Specifically,
MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
is reached. After reclaimation attemps, a subsequent retry may
successfully charge memcg->memsw but fail on the memcg->memory charge.
In this case, swapping should be permitted, but the carried-over state
prevents it.

Fix by moving the initialization of 'reclaim_options' inside the
retry loop, ensuring a clean state for every reclaim attempt.

Fixes: 6539cc053869 ("mm: memcontrol: fold mem_cgroup_do_charge()")
Signed-off-by: Bing Jiao <bingjiao@google.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
---
v3:
- Corrected the Fixes tag (Yosry).

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


