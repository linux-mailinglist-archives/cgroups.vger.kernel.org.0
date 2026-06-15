Return-Path: <cgroups+bounces-16951-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /QmzL8PoL2qBIwUAu9opvQ
	(envelope-from <cgroups+bounces-16951-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:57:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AFC685E59
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:57:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HGmCN35m;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16951-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16951-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946C730534C7
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ABF3E3179;
	Mon, 15 Jun 2026 11:54:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4A145B3F;
	Mon, 15 Jun 2026 11:54:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524485; cv=none; b=SOcg68ihktvv7vcXUAHVWhbAhQHw1710i+mypUIfZCjNXAr+hgjn9QTfgPUmjIFn1ls4T5rSO1Iqm8U6gJNRht6IfCTg96MiYkgKhlR+JMvGdwHjoTfoBXRdaRdWfXdaN/OPmqst3le6PAvVp2gQXsqwhslyBgzw0aNeZbZnJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524485; c=relaxed/simple;
	bh=1WBNjzo0PorAZRcn0KdOJGVEfNPYfkA6zMBQIhfC8bE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CfvpHMUKxPiDsMD67yZD3BF+as9eFT3gS0r6sJlHjSgsKVEbqYEona1ZBkrXr6MwsMa+IxCIL4gpWmJxQGEeS0vUknYRB7bceRyReUBUZ1ojGc8fqWQyRyVykFpzKVZojsejwjv5OyXFUdGQfPu5O3ujvbF594sL98LeV3datpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGmCN35m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0571F000E9;
	Mon, 15 Jun 2026 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524484;
	bh=dA6pXgYKZb0WIDS2w3jJIvRv7wIBxlN6dP+Wu8BjXu0=;
	h=From:Subject:Date:To:Cc;
	b=HGmCN35mELvu47Clj9Yd/zpHmlPIi8WgOMfhm4P+zBXvy5oadvPdfjG3Z0Ewtygm/
	 5gjE3A0SuWkXu95LiUj4NLYERoL2xlNDinf6jKmlCi+xwXOVdR+EejK8VaCMtnM54S
	 LLDxe8OImksC1W/yslLnIWJSGajL5TPNKb62B3+IiTXpJvGh4z3Q9TM8+4GSypjhZ9
	 oJtWJn8hHK58r/4+UUthS12avoYO+bfxDzesRWwcgd5VSlkP7QzP4T4Bd9ij1CIOLW
	 G/5jZ4o6RAeJU2d31H/GyvZGLo2KlFWdQ27hudgxEbIfZVCOn+mHmiRt+WRsfaNrUq
	 kZFPZqdIfrMhw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH v3 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
Date: Mon, 15 Jun 2026 13:54:33 +0200
Message-Id: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnnL2oC/23NTQrCMBAF4KuUrI0kY39deQ+RkqTTNhoaSWpQS
 u9uWhEUZVYP3vtmIh6dRk/2yUQcBu21HWLYbRKiejF0SHUTMwEGOcsZp94IWQtjrKpbIzpPIVN
 FCZKprFAkzq4OW31fyePplf1NnlGNi7M0eu1H6x7rz8CX3puvfvnAKaMg21SkspIZ5IcLugHN1
 rqOLH6AD4GzPwJEoeAVi9dIzssvYZ7nJwCbJ3IFAQAA
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16951-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17AFC685E59

This series is now in slab/for-next, based on the slab-for-7.2 tag that
was sent as first PR to Linus. Posting new version due to many
accumulated changes, for final rounds of review. The plan is to send a
second slab PR with this early next week, if nothing explodes.

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
- SLAB_ALLOC_NOLOCK - do not spin on locks (used by kmalloc_nolock())
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
	size_t orig_size;
	unsigned int alloc_flags;
	struct list_lru *lru;
};

This also replaces the existing struct partial_context.

The last necessary piece is kmalloc_flags() which can take the
alloc_flags in addition to gfp flags and is intended for the recursive
allocations of sheaves and obj_ext arrays, so that both
SLAB_ALLOC_NOLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
Internally it decides between kmalloc_nolock() and normal kmalloc()
depending on SLAB_ALLOC_NOLOCK.

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
Changes in v3:
- Applied R-b tags from Harry, Hao, Suren (thanks!)
- Former Patch 1 "mm/slab: do not limit zeroing to orig_size when only
  red zoning is enabled" fast tracked as a fix to slab-for-7.2 PR.
- Patch 1: refactor kasan_init handling (Harry).
- Constify struct slab_alloc_context usage eveywhere (Suren)
- Rename SLAB_ALLOC_TRYLOCK to SLAB_ALLOC_NOLOCK (Suren, Alexei)
- Reorder patches 5 and 6 (formerly 6 7) (Suren)
- Move trynode_flags refactoring from 7 to 6 to avoid bisection
  hazard.
- In Patch 14, support temporarily both __GFP_NO_OBJ_EXT and
  SLAB_ALLOC_NO_RECURSE to prevent obj_ext -> sheaves -> obj_ext
  recursion (Sashiko)
- Expand OBJCGS_CLEAR_MASK to allow kmalloc_nolock() warnings
  (Hao Li, Shengming Hu).
- Link to v2: https://patch.msgid.link/20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org

Changes in v2:
- Due to Sashiko review, drop the idea of zeroing orig_size
  unconditionally, as it can break krealloc(). Thanks to that found a
  pre-existing bug fixed by the new Patch 1. The kfence zeroing related
  cleanup is implemented differently in Patch 2.
- Prevent nested kmalloc_nolock warnings due to added gfp flags
  (Sashiko)
- Fix a pre-existing issue with opportunistic slab allocation from the
  target node only effectively dropping __GFP_NOMEMALLOC and __GFP_RECLAIM.
  (Sashiko)
- Move kmalloc_flags() definitions to mm/slab.h (per Harry).
- Link to v1: https://patch.msgid.link/20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org

---
Vlastimil Babka (SUSE) (15):
      mm/slab: do not init any kfence objects on allocation
      mm/slab: stop inlining __slab_alloc_node()
      mm/slab: introduce slab_alloc_context
      mm/slab: introduce alloc_flags and SLAB_ALLOC_NOLOCK
      mm/slab: replace struct partial_context with slab_alloc_context
      mm/slab: add alloc_flags to slab_alloc_context
      mm/slab: pass alloc_flags to new slab allocation
      mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
      mm/slab: replace slab_alloc_node() parameters with slab_alloc_context
      mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
      mm/slab: pass slab_alloc_context to __do_kmalloc_node()
      mm/slab: allow __GFP_NOMEMALLOC and __GFP_NOWARN for kmalloc_nolock()
      mm/slab: introduce kmalloc_flags()
      mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
      mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves

 include/linux/slab.h |   5 +-
 mm/kfence/core.c     |   2 +-
 mm/memcontrol.c      |   5 +-
 mm/slab.h            |  29 ++-
 mm/slub.c            | 488 +++++++++++++++++++++++++++++++--------------------
 5 files changed, 329 insertions(+), 200 deletions(-)
---
base-commit: dfdfd58cce1c3f5df8733b64595448996c08e424
change-id: 20260601-slab_alloc_flags-25c782b0c57c

Best regards,
--  
Vlastimil Babka (SUSE) <vbabka@kernel.org>


