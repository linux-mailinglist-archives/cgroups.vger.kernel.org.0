Return-Path: <cgroups+bounces-17851-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/BwJwxqV2rRMwEAu9opvQ
	(envelope-from <cgroups+bounces-17851-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:07:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49875D4D5
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:07:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Dliu1Bli;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17851-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17851-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D1DA313CA5E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5434483AA;
	Wed, 15 Jul 2026 11:03:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3B448CE6
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 11:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113428; cv=none; b=Ny7QeiFOiAcb7JDjb2mviQ1w85tqOTjx6t+3W8ZV35fik3tIEBN809OlNg70qM5ENby++BVV4VePlsSUZh1rWbfpeLR3s6E05QtvCld7C+QpEFVzBvHk6Q4+bfG9EnViwoRTjdTVYMDyw1cAgRBnRQGRQ5obbE28DZCbuskcy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113428; c=relaxed/simple;
	bh=yMYx9T08PdeyCEUHBvkxhJ5enBp6n+9uUVKhIzF7q88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KrjSrNLYLz5mgP0FZzYvfsUZH0JPIYgukN+uh7Ki5Y2VHzumXMZ50aZvYC1R3dnB0s1rj7BDERyyyTxhbnmdvxUmBUPEQhZoEd6xpH/ljdszaMLCI7U8nJMH7XLjjIjbd9XxwAUlhMiGNTxGjh8OPijenHBU4dwXKcoB3nN9jOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dliu1Bli; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so39117535e9.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113421; x=1784718221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7jfYCvKZRG50MPG0jJuxwEVxoiBrjqYJeMDmdl5htM=;
        b=Dliu1BlibDlixMgFh87Oy3oeBimkTBtDgxyB2HHO+faGVgcl65fDeJVLNLMpLnpZiS
         uWtU3TUpC64pr7YBQho0Fkq52xwTp3YOnkDfZyX0VCqSbgswvGd8q1qwpOqMJSUL/z3v
         js1AidXP+QqdCXUTv32zvEpWD2x2196AvTecpndU0Yhco6pXAW9PeRCTg8ID/kpIwFcm
         CayjHf7n4UV7sQ9cR67rhWyLd748+dHj37/OF0Zq0JUoxEiB4ydxSOfrU9X9fboDuynl
         dKyYNZghUSkwy5TyG9Sc6uXO6jE3tLl/GlkupxIEFSsk4ExOx/g/LOZFJ+7L1TbqfYaN
         CLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113421; x=1784718221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7jfYCvKZRG50MPG0jJuxwEVxoiBrjqYJeMDmdl5htM=;
        b=LYrNsHDsg51tTFVaT+ktV30sfJIEZprAxfF2et13PHVJ8m9uMTSfEamvEexFhsBT13
         5WOLqIuqQda/agL0wusWawMRtjmiJA2O5KnZ86LashPwX6Kden/fuT5Gyvxk1kIaV1hu
         C3fj6eOmEk/mJEK2557KGP1xq08dA2MQwAOkg+XRHupvQDgv0/UGivjpZBwEzQldMi+Q
         Gk0xS+EwwYFFCyJhYEIXDBkITpAaTYsA3LWne9p4OSytYEgxVQT3AiOGXs8XLR7uoI3m
         yTNt9mcV6CigNDDn7XMDaQkDmutQJMqkmNSE6CzIa+09wwPUuBEi98nu0zfkYniVXsaK
         CcIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2w6WS/9MRKhBbSAG+QARQSbfeYmtM/k81/8qbgaGXqs9o8R0MXFBzYttOxVqs22cEkvf6jMLS@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLGCouyr0rkLUtpc7NdMw7krmSN2xGNJKNHOx/cvQ3tZygyE+
	mzvOpIpEGtItbu64GoHhYpmqHym/xZW1LrGweKGX117hB5h9PXIoJ7UGMN4/OMiB5mks41xn2jQ
	HPCl974VWouIzKQ==
X-Received: from wruj11.prod.google.com ([2002:a5d:618b:0:b0:46d:8498:a146])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6989:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4953c1555a0mr25987965e9.11.1784113420581;
 Wed, 15 Jul 2026 04:03:40 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:20 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-3-fc4d246f705d@google.com>
Subject: [PATCH v3 3/4] mm/page_alloc: fixup alloc_pages_nolock_noprof() comment
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
	linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17851-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED49875D4D5

Update the comment to reflect the recent change to allow flags in
gfp_nolock.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3%40google.com?part=6
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c2da85e69a0f8..25a83a57aab66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7983,7 +7983,8 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, plus some flags that get set
+ *             internally regardless (see %gfp_nolock) are allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *

-- 
2.54.0


