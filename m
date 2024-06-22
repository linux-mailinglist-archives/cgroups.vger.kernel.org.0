Return-Path: <cgroups+bounces-3275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A59131DB
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 05:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B8B284C6D
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 03:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F2DDB3;
	Sat, 22 Jun 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7N8p+Hp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8FC8C7
	for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028748; cv=none; b=i32olDyg2yHoazFx8C4ElLoCnpHTrW5ama0Tl175h+Tn+ZtH6XMhdLTaE0RXyunaoHlTSTgbXjeooY7nUFg+3mGjSy8inLFCu29feP41WGUp82smEl6OllCKJV57725iOUcsLo5cHiRmx9E3TMtJXBy7oLUg8p0qIO70WWzFs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028748; c=relaxed/simple;
	bh=/ufCsQJXWSGzeKck9gEeAyEHT7TWU+q2u595g0WVpMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkNoNHteQFDpEGN4fgiPBsDRu6aIpg2mbXAYyuChQyKdeonpcJsahuxoc2wNq5tcsurdqr1xcNJbs8pgBHacsCOuP1kfjIDPMR9j1DFyWbtEJiiXe2TYSuX9cs2ER7exTlfjdd4bVGGjkrxuSC6z5ia2i6wgBV0qENbYnUBt/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7N8p+Hp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr/4mKEcg1BO/1nqaoL0eifI3AwTZgGcUhIFK99x5ho=;
	b=I7N8p+Hp3rXmFsIjs8dtlu5fFxH0SOErHKDCuBm5Fidx762iuZ93iCPQFN/wwrqdbw+a55
	OAJVPC6cg6WZp1Y/Mre9erAqVRImaEeHuSeLtFVK/3YwzUDZYUb7J9gFlxt7YIXtZCVT9+
	TWwpcWzK143qzjs49J/PW222FJqCdcw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-DTKC7_4wP3CK17hD_7Ajaw-1; Fri, 21 Jun 2024 23:59:03 -0400
X-MC-Unique: DTKC7_4wP3CK17hD_7Ajaw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so2878114a91.0
        for <cgroups@vger.kernel.org>; Fri, 21 Jun 2024 20:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028742; x=1719633542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr/4mKEcg1BO/1nqaoL0eifI3AwTZgGcUhIFK99x5ho=;
        b=G/eWPwXwPl7bidXMtDs6LI1Xj6LxzbgbnIGVDNeLX8RHZ8k54w6B+Tsy9ZLH7LDxaX
         sVpZqVbGc4jobIWDi/2I9Gpl72IST9Jl7kqyH2o8Y17GqW6hcthIsQ75ST4I6ujRiAoC
         qo86aEkhTd5eW2VArG2DcRVOR1Xs1A+eC68CjjE2Xhr8lRt2xkdV/prLrww5IOlaXSc6
         X81pO+m+bTjfdfaPWMhWOstZZbHuRXycksT3QlYOET/4lKiCacKuKSUZsUvcbS7JtN4/
         /QFGwf4Aaye9u8zdjdw6sV9vk42O+YWSR7FszycOhm4U3ttgsxM5fM7e928SYmmOPRq2
         FNNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTtApHj372XtDMnnb3sTPut/aHRSc+GNkMcK9CrRiw5AOMz4Pw1nnDEVGhN4wmnPE8veT/T7XPCotxcbKxmg+z4BARuWiKxg==
X-Gm-Message-State: AOJu0Yw3HBrt+ZtRxABYykzpuR4rX3FcvPegcwEhnAyLMMISgnQCNMDN
	TyhCpOIAtN7zhYhNoFqhe3WC9FEP+ggZPn/2+n7nk9Rv8Lsfbl4d3R8utUXemHrzB9KWWtlSWf4
	aK7Kk+LODtZnBx3O3g4auJQgRVVifTtJjrBGq0Lv5cyuEzNA7M9X4zEk=
X-Received: by 2002:a17:90a:6006:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c7b59fa68cmr10387334a91.2.1719028742282;
        Fri, 21 Jun 2024 20:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqsAmN/2usMDnEbfUaqXha6LBh1OFap3JUlsvia0ZFkQTobQ3J2rvz24LicWySb2pIwxdrA==
X-Received: by 2002:a17:90a:6006:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c7b59fa68cmr10387308a91.2.1719028741834;
        Fri, 21 Jun 2024 20:59:01 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:59:01 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 4/4] slub: apply new queue_percpu_work_on() interface
Date: Sat, 22 Jun 2024 00:58:12 -0300
Message-ID: <20240622035815.569665-5-leobras@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622035815.569665-1-leobras@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
interface to improve performance & latency on PREEMTP_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
queue_percpu_work_on(). The same happens for flush_work() and
flush_percpu_work().

This change requires allocation of qpw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/slub.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1373ac365a46..5cd91541906e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -35,20 +35,21 @@
 #include <linux/math64.h>
 #include <linux/fault-inject.h>
 #include <linux/kmemleak.h>
 #include <linux/stacktrace.h>
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#include <linux/qpw.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
 
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
  *   2. node->list_lock (Spinlock)
@@ -3073,36 +3074,37 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 }
 
 #else	/* CONFIG_SLUB_CPU_PARTIAL */
 
 static inline void put_partials(struct kmem_cache *s) { }
 static inline void put_partials_cpu(struct kmem_cache *s,
 				    struct kmem_cache_cpu *c) { }
 
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      int cpu)
 {
 	unsigned long flags;
 	struct slab *slab;
 	void *freelist;
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	qpw_lock_irqsave(&s->cpu_slab->lock, flags, cpu);
 
 	slab = c->slab;
 	freelist = c->freelist;
 
 	c->slab = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	qpw_unlock_irqrestore(&s->cpu_slab->lock, flags, cpu);
 
 	if (slab) {
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
 }
 
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
@@ -3115,82 +3117,84 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 
 	if (slab) {
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
 
 	put_partials_cpu(s, c);
 }
 
 struct slub_flush_work {
-	struct work_struct work;
+	struct qpw_struct qpw;
 	struct kmem_cache *s;
 	bool skip;
 };
 
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
+
 /*
  * Flush cpu slab.
  *
  * Called from CPU work handler with migration disabled.
  */
 static void flush_cpu_slab(struct work_struct *w)
 {
 	struct kmem_cache *s;
 	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
+	int cpu = qpw_get_cpu(w);
 
-	sfw = container_of(w, struct slub_flush_work, work);
+	sfw = &per_cpu(slub_flush, cpu);
 
 	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
+	c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->slab)
-		flush_slab(s, c);
+		flush_slab(s, c, cpu);
 
 	put_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	return c->slab || slub_percpu_partial(c);
 }
 
 static DEFINE_MUTEX(flush_lock);
-static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
 static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
 	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (!has_cpu_slab(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
-		INIT_WORK(&sfw->work, flush_cpu_slab);
+		INIT_QPW(&sfw->qpw, flush_cpu_slab, cpu);
 		sfw->skip = false;
 		sfw->s = s;
-		queue_work_on(cpu, flushwq, &sfw->work);
+		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
 	}
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (sfw->skip)
 			continue;
-		flush_work(&sfw->work);
+		flush_percpu_work(&sfw->qpw);
 	}
 
 	mutex_unlock(&flush_lock);
 }
 
 static void flush_all(struct kmem_cache *s)
 {
 	cpus_read_lock();
 	flush_all_cpus_locked(s);
 	cpus_read_unlock();
-- 
2.45.2


