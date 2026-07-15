Return-Path: <cgroups+bounces-17849-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kCAzButpV2rHMwEAu9opvQ
	(envelope-from <cgroups+bounces-17849-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:07:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFB75D4C7
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=idqdw5SQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17849-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17849-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7843E31220BD
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46842CB14;
	Wed, 15 Jul 2026 11:03:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2764483A4
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 11:03:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113427; cv=none; b=rbbY5isjkv5vVFXFkyj+bkKSskan9cW71ONnqDiZrBrc7pj+mSakUA0D4H21iTYJe7CTBeywFpLGpM0sr6a0Omv/FbdVzotD9SNSXWyHoK5AhSifdwucnLeJhIVY5O14tnf3s8b9oswbKDQ2R1QaudkKUbmjsxKwsH4tzAF7vuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113427; c=relaxed/simple;
	bh=yp7DtpLSpDTNqGYFYJZ54fWV2cqq9H1TNl9IkEg5RcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qloXNrNNnqB2Eo3yrDdCfNjQd81KjVlau18LGgEDVawk8wCIvZtgAvGoco7LHZRaWsFnnxKKY4sANHZRU5lfd/aURff+BcU83SBn0JcdgjzgI2penCI58x0uzNhm4qXnNL1eFZCBlCZRTCtz4oX3vbrk0mKJgyqq4c/s9HSkgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idqdw5SQ; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c55d5ce5so29315145e9.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113420; x=1784718220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29O54/g86I/UhsnFuKm5xVq389jfQYeh9pI8FKcXiJI=;
        b=idqdw5SQstnbIxWinBCL/EG9TvKh0Z/APZPPYTR8NLVzVLyxyCxU873ZZ6hziigj2m
         1jSoIzRye9npjbDczF78Q/bfRwp9KV6dbn6PpP1SwEdSKMvePE7ToOn4xbDxYGlCQ4cC
         geju6Xxcy+GNhROZb4O2tABPmvGp22A3wGK+EI18UkzaeBQgkUyrdPpfBCMedLebvfUo
         2COZa1/yQqMo/s/CT1mwn6vclWOD8HjmH/BdQHAWpRF44FGFMw/TmaINll7ZXvUzVLmX
         EH12xbvbhMQXANm7i/WyoUASoZh+F5cmt4P/ehTgiej7t6IoYByH0rTqR2J+8keCcsLa
         3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113420; x=1784718220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29O54/g86I/UhsnFuKm5xVq389jfQYeh9pI8FKcXiJI=;
        b=iLL5jVcmVSC8dHkJCjZptAJyxn9/HzwFtXCN6YTFB4vJsQF/GHTeIuwBySTLAsz0Ws
         1e1j0jaYJxc4zHcbLRgg4DRnXqjzpWc/j97kIgufqoMZ6HNl1tJ58xxfHrakbYuvpsl4
         funyfmC412Gni7PVCGUQVxRFYG/WgTEtn2sies6bOOUxMlI3dkhrPdbOdwUuCj24d6aq
         3zU0IiFb2G2XDYxw0iPDZeimGBxM8E0HZ/0Yx3XvCYxjBVkRcb26j4o0joYNn6FsoOTh
         oPkZjP34cd8/kmOCzvqiKBt8GqyL3SJcolYd/B6a0CFaJyQrzyQqp0MLTsDFgiAdBPIK
         frsw==
X-Forwarded-Encrypted: i=1; AHgh+RoT4CT9OxGyJnGE3IyrLAxZB+feK8kem0Vl/ZC0d8t1fq3WCRz06GhTCRtNbx/wIets4kIJi8sz@vger.kernel.org
X-Gm-Message-State: AOJu0YxdB6zz1TTc+IMidj+UY5dsTAprL0CGmPS2ueaiCWhJTSu33m5j
	rV2UOG+pkR4bYPl1QVdSrYtZfsj7syb7A4K83cuZcgtpwgc1+Fa6GbLjahTa7aeVO8BRKOCdpXp
	sQy46zHymtZsUcw==
X-Received: from wmqa14.prod.google.com ([2002:a05:600c:348e:b0:48a:79a9:335c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1393:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-4953c273bb2mr27821985e9.25.1784113419548;
 Wed, 15 Jul 2026 04:03:39 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:19 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-2-fc4d246f705d@google.com>
Subject: [PATCH v3 2/4] cgroup/cpuset: update some comments about the page allocator
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17849-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FEFB75D4C7

These comments describing the page allocator are out of date:

- __alloc_pages() is no longer a public API and has no business being
  described outside of mm/.

- The `wait` variable is gone.

It may be out of date for other reasons too but this patch is just
fixing the issues that stood out.

To fix it:

- Instead of referring to a specific function, instead to "the page
  allocator"

- Completely drop out-of-date details of that function's internal
  behaviour, since they were irrelevant anyway.

Suggested-by: Zi Yan <ziy@nvidia.com>
Link: https://lore.kernel.org/all/DJP11T5V7BDW.2FZZZ8R6LOY4I@nvidia.com/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/cgroup/cpuset.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 24ea2d09cdbdb..dfd0f827e3b92 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4193,7 +4193,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * nearest enclosing hardwalled ancestor cpuset.
  *
  * Scanning up parent cpusets requires callback_lock.  The
- * __alloc_pages() routine only calls here with __GFP_HARDWALL bit
+ * page allocator only calls here with __GFP_HARDWALL bit
  * _not_ set if it's a GFP_KERNEL allocation, and all nodes in the
  * current tasks mems_allowed came up empty on the first pass over
  * the zonelist.  So only GFP_KERNEL allocations, if all nodes in the
@@ -4206,11 +4206,8 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * come before the __GFP_HARDWALL check, otherwise a dying task
  * would be blocked on the fast path.
  *
- * The second pass through get_page_from_freelist() doesn't even call
- * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
- * variable 'wait' is not set, and the bit ALLOC_CPUSET is not set
- * in alloc_flags.  That logic and the checks below have the combined
- * affect that:
+ * The second pass through get_page_from_freelist() doesn't even call here for
+ * GFP_ATOMIC calls.  That, and the checks below have the combined affect that:
  *	in_interrupt - any node ok (current task context irrelevant)
  *	GFP_ATOMIC   - any node ok
  *	tsk_is_oom_victim   - any node ok
@@ -4327,8 +4324,8 @@ void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
  * should not be possible for the following code to return an
  * offline node.  But if it did, that would be ok, as this routine
  * is not returning the node where the allocation must be, only
- * the node where the search should start.  The zonelist passed to
- * __alloc_pages() will include all nodes.  If the slab allocator
+ * the node where the search should start.  The zonelist used by
+ * the allocator will include all nodes.  If the slab allocator
  * is passed an offline node, it will fall back to the local node.
  * See kmem_cache_alloc_node().
  */

-- 
2.54.0


