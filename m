Return-Path: <cgroups+bounces-16811-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UJcPNiqHKWr8YgMAu9opvQ
	(envelope-from <cgroups+bounces-16811-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:47:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5AE66AFFF
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q5gNJkTh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16811-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16811-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D342130F9BBC
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E7428859;
	Wed, 10 Jun 2026 15:40:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA383F888F;
	Wed, 10 Jun 2026 15:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106021; cv=none; b=jrmLBQU0FFe6G6+uqAC2MgNrw9fFGFNyXY2BDMUDphFE93fnFA189RgahVoXjccwDpYfv/Il8MyR1MfnN3OOaR+eXoInl9ZSFarM4qKc2gM5Y1cdMrVwogYi0VRgcWAwePj9DWOTdLmhn6nEabzct41JccLFcg8dPJf3YxafJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106021; c=relaxed/simple;
	bh=xte04xdEje1GOGQhHnKnSLer2ZCrbbfb6ar17VBuod0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6iv2mS02abovp5v7D8AXJRth2wRpM1GrNrabaMFfJ62WiVpuhwRSvqKmza6IUw3ozUN2mo7ezloxRiqXagYy5VFGidxemHgbUMkihAhm2dliV+h/QpLL2ExS/NkgFh7Lik2pE3EVbTM6cHfTb0xXjC7XSkF08/3QLu8CFuQzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5gNJkTh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417291F00898;
	Wed, 10 Jun 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106020;
	bh=rh6k92Y5yfUvQ1Ydl5es3+m24euL6hyzwkyjlD+xQ1I=;
	h=From:Subject:Date:To:Cc;
	b=Q5gNJkThO/m2qp1lkXJFqQaBB8SIHT6CIi8Qj5jPW5jfIX8YyEvV7VIB4Nn4+aG2X
	 hLuXcz3sIQz6ljVMErk3JkZNmqUGJpd2nSXULBASDJbfQF5YyUFx3bu0s+n0YlzFRl
	 Jxu3ly32wNL/+kRr0G5N+6zH/jHTURY85x5I2ayOpOHtaCvhx7fD9wMxkCNN7g/1ms
	 iebecj6TSgrh6xha2dzaTCfpgDOd9SpX4z20D3I7Vg3lybrTtVH1gwCufq0LG8iwhs
	 kPPP6tZsPBPtvswVFKD/1ULSU7THWCJy5ZKvm+o6quJzm6rTOzK94drCj8PZFtqXlD
	 iTW114BWt6elA==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH v2 00/16] mm/slab: introduce alloc_flags and
 slab_alloc_context
Date: Wed, 10 Jun 2026 17:40:02 +0200
Message-Id: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKFKWoC/2WNyw6CMBBFf4XM2poy4SGu+A9DSFsHqDat6SDRE
 P5dwLhyeZJzz52BKVpiOCczRJos2+BXwEMCZlC+J2GvKwNKLGQhU8FO6VY5F0zbOdWzwNyUJ9T
 S5KWBdfaI1NnXnrw0X+anvpEZt85mDJbHEN/755Ru3i9f/eenVEiBustUpiudY1HfKXpyxxB7a
 JZl+QAQBFkpwwAAAA==
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
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-16811-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B5AE66AFFF

This series is based on slab/for-next. As suggested by Alexei I will
try to put it there ASAP (hence the early respin) and see if it looks
stable enough to be send in the second 7.2 merge window week.

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
Vlastimil Babka (SUSE) (16):
      mm/slab: do not limit zeroing to orig_size when only red zoning is enabled
      mm/slab: do not init any kfence objects on allocation
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
      mm/slab: allow __GFP_NOMEMALLOC and __GFP_NOWARN for kmalloc_nolock()
      mm/slab: introduce kmalloc_flags()
      mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
      mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves

 include/linux/slab.h |   5 +-
 mm/kfence/core.c     |   2 +-
 mm/memcontrol.c      |   5 +-
 mm/slab.h            |  29 +++-
 mm/slub.c            | 439 +++++++++++++++++++++++++++++++--------------------
 5 files changed, 304 insertions(+), 176 deletions(-)
---
base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
change-id: 20260601-slab_alloc_flags-25c782b0c57c

Best regards,
--  
Vlastimil Babka (SUSE) <vbabka@kernel.org>


