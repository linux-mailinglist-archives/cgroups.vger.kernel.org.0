Return-Path: <cgroups+bounces-16761-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VabgLsfbJ2oO3gIAu9opvQ
	(envelope-from <cgroups+bounces-16761-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:24:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D465E4C0
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=InpuJTdi;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16761-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16761-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81471311FEDB
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCF3ACEF8;
	Tue,  9 Jun 2026 09:17:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628F38553F;
	Tue,  9 Jun 2026 09:17:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996676; cv=none; b=u8zfEXBQnAieL1TMabV4vuChDQfGNC9MCpsHnoLqOXVKoVw9oAg5MdqqhvasQ+UUjtu9WBAhNrW1Uzo8wKvU+fhfaobIWp7k7AScm/CmRKxvSI8oCgk1C6NeuddImccVGOtVG98rVvOggneKfMAKKqyZcOCXJ5YY6f5O8iTkO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996676; c=relaxed/simple;
	bh=edk1gWq6wJegftSJ6gxR54wjWbnVE8DBfhA2Ljpkr30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+AL+i8mLbyP9tvf2ZSw2ssbv2ONEz6iSj2CvOGW7IMEl4j/Nmtj8sLpyoTThOuESWgminHqD7K/FaHwibk/Vy9n9dK4nL6dX9veNS4qudJyPL2fUc9eb4d3OJaqVC/6LzABw8n3EXxUdunPbPvfYpO2unESiOrD209vJCGYGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InpuJTdi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428AB1F00893;
	Tue,  9 Jun 2026 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996674;
	bh=JklGHxBs/e7WoHWY8zy6xxkN2IXkLn5LKgi5O76JqdY=;
	h=From:Subject:Date:To:Cc;
	b=InpuJTdixIWUvPPcFY6VIL8TLmanaDGHTbitvz3Ypi3itXf5Wqncv9tnKBpDPSicn
	 wokRauUzVrN38x7gCY9XFJFFNcFtk3EGI+QotA50dpBp2jrGsZSLaqPe9hkaj4lHgc
	 QVQpfUUWcFqM6IVplaSZMt6Y4tNd9lw9RktAlsS2UzgLTZMHBVYF0Vi5PLYiytcfy3
	 rNXaaeWM4zj3ct4b4kxLDzM52lMrq4N3oSIIZDPH2lnEDWhWspSrtHndryL1y64PKG
	 dqyA/Mto7LbJZuiHUeWCVSR/AAxYjocA7zmzTsDBcaUg2o6+3L7ZeKfdPw8rHqDGZm
	 0HFWmqQQXoFtw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
Date: Tue, 09 Jun 2026 11:17:45 +0200
Message-Id: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnaJ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwND3eKcxKT4xJyc/OT4tJzE9GJdI9NkcwujJINkU/NkJaC2gqLUtMw
 KsJHRSkFuzkqxEMHi0qSs1OQSkGFKtbUAms3VdHkAAAA=
X-Change-ID: 20260601-slab_alloc_flags-25c782b0c57c
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16761-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E6D465E4C0

This series is based on slab/for-next. If all goes well, it would
hopefully go to slab/for-next soon after the 7.2 merge window, so any
other work can be based on it to avoid conflicts, as it touches a lot
parts of slab.

Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slab_alloc_flags

The slab implementation currently relies on gfp flags to convey
some context information internally:

- The absence of both __GFP_RECLAIM flags is interpreted as "cannot spin
  on locks", and intended to be used by kmalloc_nolock(). But false
  positives are possible e.g. during early boot where gfp_allowed_mask
  clears __GFP_RECLAIM from all allocations. This leads to unnecessary
  allocation failures and workarounds such as fd3634312a04 ("debugobject:
  Make it work with deferred page initialization - again").

- __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
  space, only to prevent recursive kmalloc() allocations for obj_ext
  arrays and sheaves.

The page allocator uses its internal alloc_flags to convey various
context information, including ALLOC_TRYLOCK (meaning "cannot spin").
This series copies that concept for the slab allocator, with its own
slab-specific internal flags:

- SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
- SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock())
- SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
			for allocating obj_ext arrays
- SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT

To reduce the amount of parameters in various internal functions, we
additionally introduce slab_alloc_context (also inspired by page
allocator's alloc_context) for passing a number of existing arguments
and the new alloc_flags:

/* Structure holding extra parameters for slab allocations */
struct slab_alloc_context {
	unsigned long caller_addr;
	unsigned long orig_size;
	unsigned int alloc_flags;
	struct list_lru *lru;
};

This also replaces the existing struct partial_context.

The last necessary piece is kmalloc_flags() which can take the
alloc_flags in addition to gfp flags and is intended for the recursive
allocations of sheaves and obj_ext arrays, so that both
SLAB_ALLOC_TRYLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
Internally it decides between kmalloc_nolock() and normal kmalloc()
depending SLAB_ALLOC_TRYLOCK.

The rest of the series is gradually expanding the usage of both
alloc_flags and slab_alloc_context as necessary, with bits of
refactoring. Then, __GFP_NO_OBJ_EXT is removed completely.

Note that some usage of gfpflags_allow_spinning() relying on absence of
__GFP_RECLAIM remains outside of slab (and page allocator) in memcg,
page_owner and stackdepot code. These can thus yield false-positive
decisions that spinning is not allowed, but should not result in
important allocations failing anymore.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Vlastimil Babka (SUSE) (15):
      mm/slab: always zero only requested size on alloc
      mm/slab: stop inlining __slab_alloc_node()
      mm/slab: introduce slab_alloc_context
      mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
      mm/slab: add alloc_flags to slab_alloc_context
      mm/slab: replace struct partial_context with slab_alloc_context
      mm/slab: pass alloc_flags to new slab allocation
      mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
      mm/slab: replace slab_alloc_node() parameters with slab_alloc_context
      mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
      mm/slab: pass slab_alloc_context to __do_kmalloc_node()
      mm/slab: introduce kmalloc_flags()
      mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
      mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves
      mm: remove the __GFP_NO_OBJ_EXT flag

 include/linux/gfp_types.h       |   7 -
 include/linux/slab.h            |  14 +-
 include/trace/events/mmflags.h  |  10 +-
 lib/alloc_tag.c                 |   2 +-
 mm/kfence/core.c                |   6 +-
 mm/memcontrol.c                 |   5 +-
 mm/slab.h                       |  16 +-
 mm/slub.c                       | 423 ++++++++++++++++++++++++----------------
 tools/include/linux/gfp_types.h |   7 -
 9 files changed, 288 insertions(+), 202 deletions(-)
---
base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
change-id: 20260601-slab_alloc_flags-25c782b0c57c

Best regards,
--  
Vlastimil Babka (SUSE) <vbabka@kernel.org>


