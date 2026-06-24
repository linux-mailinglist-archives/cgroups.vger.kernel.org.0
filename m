Return-Path: <cgroups+bounces-17234-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jA2VBn3YO2ppeAgAu9opvQ
	(envelope-from <cgroups+bounces-17234-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:15:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A94D6BE7DB
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jfSQ2JUb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17234-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17234-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F41E303ADEA
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA193B27D6;
	Wed, 24 Jun 2026 13:12:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABE3B0AC8;
	Wed, 24 Jun 2026 13:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306724; cv=none; b=QzDIaIA45496buxqQnO9gTfgoaWkMonp/2zQ/T8Z8YAVNpwll/wW0DLu6rvJd086CQ8tomw0zBj4ANL+BAdQU91eNqqg33eMCKU+uNhsb0fOMicaXwCi/JstxXvuYIMf9OssA01eQzo3uhbvgvzC8in9g/0uF5XCSYlsHR1yRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306724; c=relaxed/simple;
	bh=OKtIB1vXnCJ33GVvy8DiZZJC221kV7m/zWGpT82XWRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fy0viW6Et6P/qGfAIJ7Zd5NnKkFw1M9qQzPXV3UOK0RFlB1HaU80t3oIRdbXCXO2rW+kC3uumNxhLwpKD+8RpTEQcSU+qVxh3eFXa+huczjE0CU6Hal6S/lkUpuGQlGG33NbCFXu+uckiKFUrgEP9fwqL7UUnHwewY5AYYQfuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfSQ2JUb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2DE1F000E9;
	Wed, 24 Jun 2026 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782306723;
	bh=7H6w+2jY/f6FuMYxVOvZHmer+ikNgecUTmJ2xQG7VNI=;
	h=From:Subject:Date:To:Cc;
	b=jfSQ2JUbJgnkNkzGlxGTJWufs8jewQhqySJsyXEr6f2bz6OIPbF27kPc9YfBJayl0
	 HB/6Pd5iCPMOXdHI6BFfndarPuxQPTNseXaoH41ku9bD+i9FGPtkCzSOAv4KaC6qep
	 I5mAkcpnvwVRHEaHYwDurvEsrXtZ40JNsZK6/Lm0wOPaPzj0EDjCejAdlgBURf++s7
	 8chQRbB03Ks5yGrh44kl1TN0WepN76vdD/o3vmI9Xf7O49tuop23xpvyZPzM3sFn2Q
	 uMO614azVJ+xEzRM42mLsdUK01cSn3E0nwZPZrImzYY00DuyGCT6sA9fcZ61Gs8Bvz
	 2cJYpa+1Znf0g==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Subject: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
Date: Wed, 24 Jun 2026 22:11:37 +0900
Message-Id: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMT3ezcxJyc/GTdvHwgma2bllmRWqybbGluZm5qbGRhbm6sBNRaUJQ
 KlgDqjFYKcnNWiq2tBQCHyxi0awAAAA==
X-Change-ID: 20260624-kmalloc-nolock-fixes-c97675328773
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17234-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A94D6BE7DB

Apologies for posting another series during the merge window.
But these are bug fixes and there are other features that need to be
rebased on top, so...

Overview
========

This patchset tries to fix three kmalloc_nolock() bugs.

1. obj_cgroup_put() takes a spinlock in the release path
   when it is holding the last reference.
   (This needs some thoughts from the memcg folks)

2. A spinlock may be taken in the following path and may lead
   to deadlock:

   kmalloc_nolock()
   -> slab_post_alloc_hook()
   -> memcg_slab_post_alloc_hook()
   -> memcg_alloc_abort_single().

3. irq_work_sync() is called without synchronization for rcuwait
   (on PREEMPT_RT or some architectures), potentially causing a
   hang.

Bug 1 was reported by lockdep, and bugs 2 [2] and 3 [3] were
reported by Sashiko.

To MEMCG folks: obj_cgroup_put() is not safe in unknown context
===============================================================

I tried to fix the bug 1 in the __refill_obj_stock() path in patch 1.

Patch 1 considers correctness aspect only, and performance may
degrade because we have to fall back to per-objcg atomics unless
some else drains it for us.

Ouch, while writing the cover letter, I realized that two paths need
some attention:

  1. __memcg_slab_free_hook() -> obj_cgroup_put() and
  2. current_obj_cgroup() -> current_objcg_update() -> obj_cgroup_put()

An easy solution would be to somehow defer obj_cgroup_put() or
obj_cgroup_release(). I would like to hear thoughts from the memcg folks
on which is the preferred way.

To BPF folks: do we need to backport kmalloc_nolock() support
for architectures without __CMPXCHG_DOUBLE to v6.18?
=============================================================

Originally I intended to fix this as part of this series.
However, the issue reported by Levi Zim [1] was on kernel v6.19,
(Thanks to Vlastimil for mentioning this), and v6.18 does not use
kmalloc_nolock() for BPF local storage.

There are still few users in v6.18, but I can't tell whether it is
necessary to backport it to v6.18 (hopefully not as urgent as other
bugfixes).

Thoughts?

[1] https://lore.kernel.org/linux-mm/9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev
[2] https://sashiko.dev/#/patchset/20260610-slab_alloc_flags-v2-0-7190909db118%40kernel.org?part=9
[3] https://sashiko.dev/#/patchset/20260615-kfree_rcu_nolock-v3-0-70a54f3775bb%40kernel.org?part=5

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
Harry Yoo (Oracle) (4):
      mm/memcontrol: do not drain objcg stock when spinning is not allowed
      mm/slab: handle allow_spin in slab_free_hook() instead of open coding
      mm/slab: fix a deadlock in memcg_alloc_abort_single()
      mm/slab: serialize defer_free_barrier()

 mm/memcontrol.c  |  34 ++++++++-----
 mm/slab.h        |   3 +-
 mm/slab_common.c |   5 +-
 mm/slub.c        | 148 +++++++++++++++++++++++++++++++------------------------
 4 files changed, 111 insertions(+), 79 deletions(-)
---
base-commit: 892a7864730775c3dbee2a39e9ead4fa8d4256e7
change-id: 20260624-kmalloc-nolock-fixes-c97675328773

Best regards,
-- 
Harry Yoo (Oracle) <harry@kernel.org>


