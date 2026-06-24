Return-Path: <cgroups+bounces-17238-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Af7yMrnXO2o+eAgAu9opvQ
	(envelope-from <cgroups+bounces-17238-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:12:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190D6BE77D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Eu00yjuV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17238-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17238-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B9E93010634
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7713B42C0;
	Wed, 24 Jun 2026 13:12:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEC3B2D0D;
	Wed, 24 Jun 2026 13:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306742; cv=none; b=FxXFm2f8iNodSC7d/xWV4fNGyWAZ+nQBjX/QAS3SZlOFoFIh9oJRntwiGrV7d+9c5wSnLGAXZ0gcASJPO1m7blofUXwLc9q1G15FxROUYmYxOxilZ+Z3aFh82Aks/cxd15h7ogMm4gnYBdIQuxHJWnVnHfc3+rxaQNo8ieiTgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306742; c=relaxed/simple;
	bh=v0aDvheOcJxE3wYHWqTwVQeua8KHBXQiFNYgRSHeJ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4B96kB2uiW62gR5CyYmFO5FtwcqcUsWjaiWmJEeXZ6T7hkg1qE/t7OokdvbhlMZRJX6LGlxXKXlaztpoFjDeF5o+8ifuSC2ZYgnqxsORoGk42RJRdacE5f3hLfjgEuBhOgAws5EXITxJLva1pM1A8sd7S/xZTnSnwSz9vUxniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu00yjuV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2403F1F000E9;
	Wed, 24 Jun 2026 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782306741;
	bh=lvfxPtzoYVrETEzytIgiJXDO6q4wD9otLoJUFguuBTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Eu00yjuVHuuYZ7bvilLZYLvl9LR6tdm3Bp17QItdQ5RoopaTaAS35R0brw0AkNO0q
	 lrMp7IOUR5wQwrcdhBJWfMOqL7yXV/LVEMXG9sBCnd3/ziydWZAdsRZmb/HYY1iHzK
	 JIh3JrRilhTb6AOop2cWLnMgpoJzRYv2qkD9m6sddfs2WrVpMEEapGgTtD2Ghrwt6R
	 TNDGP/6TLsrZV/YIvjhFrTdyMe9dhM+IY4kXLhxaIqrs40qAI6oQex7rdhwhv7uBEO
	 WcJBATJzFKext9+XgKDABSyySRNpr8xoo+DgFFnT23LOnQBQszdW0SJpJDNF6lsoU5
	 ZOfZAmlbwPBvw==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 24 Jun 2026 22:11:41 +0900
Subject: [PATCH RFC 4/4] mm/slab: serialize defer_free_barrier()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-kmalloc-nolock-fixes-v1-4-fdf4d17351dd@kernel.org>
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17238-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7190D6BE77D

irq_work_sync() uses rcuwait instead of busy waiting in two cases:

  1. The kernel is using PREEMPT_RT and the irq work does not run in a
     hardirq context.

  2. The architecture cannot send inter-processor interrupts to make
     busy waiting reasonably short.

However, rcuwait.h says:
> The caller is responsible for locking around rcuwait_wait_event(),
> and [prepare_to/finish]_rcuwait() such that writes to @task are
> properly serialized.

Since defer_free_barrier() calls irq_work_sync() without any locks,
it can potentially cause a hang as writes to @task are not serialized.

Fix this by calling defer_free_barrier() under slab_mutex and
cpus_read_lock() and add lockdep asserts.

Now that defer_free_barrier() is called inside cpus_read_lock(), iterate
over online cpus instead of possible cpus.

Reported-by: Sashiko <sashiko+bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260615-kfree_rcu_nolock-v3-0-70a54f3775bb%40kernel.org?part=5
Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab_common.c | 5 ++---
 mm/slub.c        | 6 +++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 388eb5980859..27f77273fabe 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -550,11 +550,10 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		rcu_barrier();
 	}
 
-	/* Wait for deferred work from kmalloc/kfree_nolock() */
-	defer_free_barrier();
-
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
+	/* Wait for deferred work from kmalloc/kfree_nolock() */
+	defer_free_barrier();
 
 	s->refcount--;
 	if (s->refcount) {
diff --git a/mm/slub.c b/mm/slub.c
index 4a3618e3967e..52c8d3f33782 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6411,7 +6411,11 @@ void defer_free_barrier(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	/* irq_work_sync() may use rcuwait that requires serialization */
+	lockdep_assert_held(&slab_mutex);
+	lockdep_assert_cpus_held();
+
+	for_each_online_cpu(cpu)
 		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
 }
 

-- 
2.53.0


