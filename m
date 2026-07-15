Return-Path: <cgroups+bounces-17850-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fkd3CTNpV2qHMwEAu9opvQ
	(envelope-from <cgroups+bounces-17850-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:04:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0475D456
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=i3lNIw2x;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17850-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17850-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A924130113A0
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DA4483B0;
	Wed, 15 Jul 2026 11:03:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A382931D7
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 11:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113428; cv=none; b=gXF06xBIO7pkI9oJSmDv+3O5uQQ5quuZasLOCKMI6/KyZpaJ5b44GJ8tcXg9vRwogKzCcCSEPobRfEvSZ66I08M6NMxE9RVoHP8IyFhT6Cc4sXtajYCqKlTlcPZ2FuTh1XZBS1If4vjj3bmNNnh+Ufy5Mi4GpYc64h9iIwB1Ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113428; c=relaxed/simple;
	bh=J6H+FoeqiU5MQFbzUvf2h1acD2Gc0AUhstmNBmOjGho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTD7hWN12ugQzG0qLQ5EpGel3Nki1lJ8AsEUT/VZ3w+nqQhWghOlSmner9MZ53NRCGmZQaexpJn/LKHsD78xBHxm67NZW8x5ZTXKKZyqLPw1TdVUY0hex+U37iF0j7YQfbfsFSkd7SGhOehmtMQHQQnHRUdIo/kqxHdOBlHfClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3lNIw2x; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso40499805e9.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113422; x=1784718222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dz86EwLqIg9rsRKy2+oVo0cZ8RAfDlpYQ8xyeR+GWfk=;
        b=i3lNIw2xeMpxYwYzM8naVyRgQp5PAXiLHUy9V2K3GirLBocN7FuHOV6gTAti6kTAKH
         G08pbVe0UvruAdcd13goBm1+Ztg2tTfSHAw3mUc6ze++QCSKQb42yIdcWdIfOi34kOGF
         DfpiMyE3/aDfd7MoFj5VZdI9LLsD5BjQhDKUU83SuHdWW2hUFh29iCisakKMfuppuYM9
         EaPki2aK+TR0zt+PHgkYk5ku/e0wZJ5doD9fZPk9rfwbVAxL4ngGvp7+Mr5OvL6pAMtt
         qoC/bxOCSlhs9cRTS+yC6NSS6IFlqicq6nZeChJ/blBhdZXURLGZ2nKbaOTDAzCu0qP3
         9goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113422; x=1784718222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz86EwLqIg9rsRKy2+oVo0cZ8RAfDlpYQ8xyeR+GWfk=;
        b=Rv/dVvOdSqsISI5sd0dhK6aYlZV+4S+HyTELaywHqp2j9UbQs1/+xgXBTrX2npDiR7
         nOf92XZ5HTeGvH/uujc67Uu+ZBWcNvHdGhAkrspou4J4AZ1o8NuQnZIqsWZV6aUL5Blb
         WZW5Y6KWMolHtelNmq3UYV93dpwdWfjyPSjJSU938VdEgHwuXxiJKi0B6mCa0ZrvJBfI
         vlR42gFDvF+p7SoJdIR+Mc/XyAH4kfyuilYXkM2hs59kq7xdTdrBFxFm4D09pMbrSKma
         ZqqlNPsPUGX9JY3DFxgEgQR5Hj5AXQguVxkgMj9wXZxunAMYG4qBtb63pDxtXWDJ8qqC
         +h0w==
X-Forwarded-Encrypted: i=1; AHgh+RoBNyLwe7cpMtaj1iEUlvDFH2oYRskYHqRgKuDMB1gZSsxqgFK4XgwvFFZA6s0TUFLzkxibhyEI@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJXsWXkzNUTQur024vSFoFKiIgZMhf8+3KnaUFij0R+ml/eTA
	Q5G7qirNbZn1R0iseVuoZ0esxLtegjlUyLgz/u+SEvpiIZa44XO4TPKI9PCmh/gWeVbc7YoCiEw
	yDzfsrOsRQAG2qw==
X-Received: from wmoh4.prod.google.com ([2002:a05:600c:3144:b0:490:b2a6:e6f5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0d:b0:493:b499:3ef2 with SMTP id 5b1f17b1804b1-4953c299474mr25989985e9.37.1784113421736;
 Wed, 15 Jul 2026 04:03:41 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:21 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-4-fc4d246f705d@google.com>
Subject: [PATCH v3 4/4] mm/page_alloc: remove a couple of VM_BUG_ON()st
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17850-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AD0475D456

VM_BUG_ON() is out of favour and on the way to removal, since I recently
touched alloc_pages_node_noprof() I am removing that invocation, and
also removing the __folio_alloc_node_noprof() one for consistency. If
this precondition is violated, the system will soon crash anyway.

Suggested-by: Zi Yan <ziy@nvidia.com>
Link: https://lore.kernel.org/all/7F866265-3F2E-4765-B9D4-9AB898A9C4AC@nvidia.com/
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 1 -
 mm/page_alloc.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 4d57e9c0bf204..872bc53f32ec8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -255,7 +255,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 static inline
 struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp);
 
 	return __folio_alloc_noprof(gfp, order, nid, NULL);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 25a83a57aab66..4c6815f84adc6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5427,7 +5427,6 @@ struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp_mask);
 
 	return __alloc_pages_noprof(gfp_mask, order, nid, NULL, ALLOC_DEFAULT);

-- 
2.54.0


