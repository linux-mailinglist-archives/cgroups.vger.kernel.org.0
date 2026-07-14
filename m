Return-Path: <cgroups+bounces-17765-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f+4eHIEEVmoyyAAAu9opvQ
	(envelope-from <cgroups+bounces-17765-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:42:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E395C752FC0
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:42:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JApYbygb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17765-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17765-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77539309E3C2
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C63F4128;
	Tue, 14 Jul 2026 09:32:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598933F20F4
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 09:32:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021540; cv=none; b=o2j3PZHKMsITezx9/YFPgl0wt06pFrGlxHHeuQlQ4nbfHk35Eaqq4VzUZ9CdESNKauIoaJSfpS+L7OTbI6XtuxrYJp39kXmBhTuMKov914dadzTMDDwQYG6VtMe1IeXXqWTBn6Jpww7aE4d8vMKeefk796vMhSDMJEAITlUu2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021540; c=relaxed/simple;
	bh=I2nIXiqF8CDBIeJinazIeMEO150+FXNKrVJTAwrcGMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8cWSWYOVtD87t++rucwGi2c8gG6kr6i0E8PyXb1SBNo0MSW4lI9LM02T9CuSzzhtr87qE9qvjMJTiI++rTCKtLNUCBYNPkIGklu/SDCbcyWsgxpLIaCnLtac5Bor2KU8Hu40aPLIqf5xzut623ZYhVXJgtsS6uXWKXJAax+E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JApYbygb; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493b21b1fe8so7345195e9.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784021536; x=1784626336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXBjnrDZv69VqIXFsxu8XfktPLqyg9BDT74BtCfYp/c=;
        b=JApYbygbfKcI8OpuymHJYWSBFIGxwxLYk4SU+7r2nQxHmzzEKBfH8usxBsuMPyxpRm
         t2QvkruvGrYb+/SLN+b4OuFu3b0WivFwlYcvK7SxTSE7S73E8yZwWPltSZlMvsW6fvqI
         DKGCfr4NayHxva4djJRJBhJVOnc6RMmXP5Bt4qtqP04PH9ctACfevjzDgzV+HQP3Roy4
         IetoPxW8NTiK26LavYVNvjP+yhmdcr0Or8zBNa6enciJ1cE8zh3WgrmlFeFdACBVDnMO
         EsGGJJRSOxz/pHBxStq92BFI2X52lai3TzRWJO66unA7zaQn5MQuJypCpKdvn25dhxob
         pQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021536; x=1784626336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXBjnrDZv69VqIXFsxu8XfktPLqyg9BDT74BtCfYp/c=;
        b=VvSSgtOf4Mxyxrqbb0nJheHE5q1GH+nUDP/EZps3W+xY+fuT4ufcUo6bchqx8Wj17O
         gKKtyf8TcFcfB110VRQYiYPCP/fF2Fc/oGDKV2GCMpY8VrmF1Dq/oqlf1Rc98uEjrwXG
         DrGlIxRsKphNer+zsGj2bYP7e7Iz6X7T4smBor06iwpqqAblhipUrHgo2WsW469IdHGP
         oRQnZeRMF1aHDVIiCCengaQoKr7PcVs/PThPtK4D7qc3oVwJTP8hqdjYk8Jc9Of0/i1G
         d7AbA7LkQ0mRwgQQRZGT8fdlw+LfBfWlleUpEy2aRtkwaE0+EnUUVMPCf9JGGA2TnFK1
         vRaA==
X-Forwarded-Encrypted: i=1; AHgh+RosB06IWrgyyVv1syE4fiUp1eCdZbiMIIFDZ8thvMA9UQiHRYqyaFGM905P9YQea9+LmxUbywor@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbH9Prfl0O7/KBS4S765+0ivrfsTl76BE+FxP7hVsPnwIPacv
	fmEZ8gotkbqFd9Gc3OdDTtDWbynccuQmItBss3ssr/ByIns9/Aih3OWd5kGJ8fueH0oRC3LGSVX
	g5XrsPnxsV3Gk6w==
X-Received: from wmcu5.prod.google.com ([2002:a7b:c045:0:b0:493:b008:cbb9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b77:b0:495:f31:7340 with SMTP id 5b1f17b1804b1-4950f3174e5mr30731045e9.5.1784021536099;
 Tue, 14 Jul 2026 02:32:16 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:32:00 +0000
In-Reply-To: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260714-spin-trylock-followup-v2-2-3c20ed032b14@google.com>
Subject: [PATCH v2 2/4] cgroup/cpuset: update some comments about the page allocator
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
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
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17765-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E395C752FC0

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


