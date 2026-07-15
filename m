Return-Path: <cgroups+bounces-17833-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cconMCldV2q7KQEAu9opvQ
	(envelope-from <cgroups+bounces-17833-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:12:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84775CCE1
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:12:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JU3vARhF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17833-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17833-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918793086545
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FBF43B6E2;
	Wed, 15 Jul 2026 10:10:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAA43B6E3;
	Wed, 15 Jul 2026 10:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110249; cv=none; b=jTz6BJRJJUT/hA5OQ1nzPi2bsEZNN+Mlsf698mYXNl81Vorz/hu6ni9FA9wip9YAfpcL5sY/wnv6ovuXqv8G9S8flv6iUXC7OZp4+evBJig9lU9WagkGKAFS8ntrjvWR8RaGE05iVSHSUxZFZdmXVvo/mSJflyAhP1nxUlERexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110249; c=relaxed/simple;
	bh=I6licoBYJt2IPq6ni1XuHA7t5SbrCb1JYja/oImYC7Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M1LdeNkQPdt9dRFR97gyo3v3gK3R8fSbbHJtGwUqXMLEOouR09rSm18F1h9trtGzKlrVu4lL4OykY+vpbmQhn4fvLMaRtBd5J+Ynm+XOwGFnltxFJfx/+OR09GD4Q2B4bqF54C+S66/bc0033PJW+4aqZz/QH0sSksTvm7QwGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU3vARhF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD891F00A3A;
	Wed, 15 Jul 2026 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110247;
	bh=1yU7j6WD00tXKLJoBL+C1KnfNcZ9lkNAuc1rdIev1d4=;
	h=From:Subject:Date:To:Cc;
	b=JU3vARhFBqxgcz6dtnOdhN7PYUEXO65XU+mwWT3/Ssyk7TsI2WUDdQc6/M/xbv/eR
	 MBcjsnv0YVtFKSDYLs4gk+uR8Qvzkx1fI4QhArEvC17fYjIycTOr4sfMMLOW6EuW0p
	 JkzKagZn1p5HZRTOonNyW6m6fVzfjuaOujpqHxRIwnDLdT37HNSAZ7IPmpJtYynYJ9
	 qrLL0X0DpEVIE+unsg2ZgN+fDLJKCDRCew4/5Luy78zv83VTH0RSQuiMkf6kZyiFdF
	 NON6T2iFQD4Uv9AeEwBWJfLoYuYMrjkNRypzrxm4H0LsBF3NbQ6ZzG6s1H3RbEQQIc
	 sbn8zdI9dbxXQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH RFC 00/12] mm/slab, alloc_tag: reduce obj_ext memory waste
Date: Wed, 15 Jul 2026 12:10:40 +0200
Message-Id: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBcV2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MT3SQT3fykrNSKkvjigpzMEt2URAsjEyMzI1PzFFMloK6CotS0zAq
 widFKQW7OSrEQweJSoK7kEpBZSrW1AO5kJnV4AAAA
X-Change-ID: 20260714-b4-objext_split-da82426257d5
To: Harry Yoo <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
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
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17833-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C84775CCE1

The recent fixes for objext array handling inspired me to look into this
finally. It's been bothering me that the memory usage of struct
slabobj_ext depend only on config options and not whether the fields are
actually used. So with both CONFIG_MEMCG=y and
CONFIG_MEM_ALLOC_PROFILING=y there is always objcg field and codetag_ref
field. And thus:

1) Having memory allocation profiling config-enabled but not
   boot-enabled means wasted memory on unused codetag_refs. This makes
   it less suitable for a general distro config and the page allocator
   side doesn't suffer from this, only slab and percpu.

2) Complementary, with memory allocation profiling enabled, there are
   caches/slabs that don't need the objcg field, so memory is wasted on
   those.

This series should solve the point 1) fully for slab, pcpuobj_ext
handling can be perhaps improved similarly, haven't looked into that.

For 2) it avoids allocating objcg fields for KMALLOC_NORMAL caches where
we know they are not necessary because kmalloc() with __GFP_ACCOUNT will
pick a KMALLOC_CGROUP type.

The named kmem_caches are tricky. They can be created with SLAB_ACCOUNT
and then we know objcg fields are always needed. But also they can be
created without SLAB_ACCOUNT and then some allocations have
__GFP_ACCOUNT and some not and we don't know that in advance.

A possible future solution is to introduce e.g. SLAB_MAYBE_ACCOUNT, add
it to caches where we know __GFP_ACCOUNT is used, and only honour
__GFP_ACCOUNT for those, while warning for an unexpected usage
elsewhere.

Only lightly tested, need to run at least some microbenchmarks to see if
the now somewhat more complicated access to objcg is visible or not.

Based on slab/for-next-fixes

Git branch: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/objext_split

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Vlastimil Babka (SUSE) (12):
      mm/slab: skip kfence objects in allocation profiling
      mm/slab: remove objs_per_slab()
      mm: move struct slabobj_ext to mm/slab.h
      mm/slab: make slab_obj_ext() determine object index
      mm/slab: abstract slabobj_ext.objcg access
      mm/slab: abstract slabobj_ext.ref access
      mm/slab: replace slab.stride with obj_exts_in_object
      mm/slab: change struct slabobj_ext to a union
      mm/slab: introduce slab_obj_ext_has_codetag()
      mm/slab: reduce slabobj_ext memory with allocation profiling disabled
      mm/slab: add slab_needs_objcg() helper
      mm/slab: stop allocating objcg pointers when unnecessary

 include/linux/memcontrol.h |  13 ----
 mm/kfence/core.c           |   5 +-
 mm/kfence/kfence_test.c    |   2 +-
 mm/memcontrol.c            |  41 ++++++-----
 mm/slab.h                  | 169 ++++++++++++++++++++++++++++++++++++---------
 mm/slub.c                  | 162 +++++++++++++++++++++++++++----------------
 6 files changed, 267 insertions(+), 125 deletions(-)
---
base-commit: d9e6a7623938968e3752b67e37eaff097e559a54
change-id: 20260714-b4-objext_split-da82426257d5


