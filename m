Return-Path: <cgroups+bounces-6922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE8A58FE2
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC8E16B5BD
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0B2253FF;
	Mon, 10 Mar 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmY71huw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E8224AE1
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599613; cv=none; b=oQOFEkRIbcKBCfloqRZ8dfDwDntFsmJqNUpecDwuXaqUSEBXX2w9JQ4QIabHZlXmhyAQTCNwUJVDTxgRSlsF2eU85OK4QN/Q7hDXCz6oJc/2hKPrUyDDK6+Cue8OGCmCsbrjCM1sDSE8JEdGb1m35p80Lcq27ANc5hgVikX3Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599613; c=relaxed/simple;
	bh=cYVuCi9smgjEBwcOQ3WPdNQXmKvk2MX83ZjOV1VFGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnNxyGtKxqamjGg564qN6kSwIBYVTxYHA0trM/OTAgUz0iehmZT1I+djNcARqSA8cudimqXlPOJlvi8ILRst8Euu6GXophqJ+RWdMmI9Mp06wmxNOx9LEUAZO8CDNpBAKw0yqYNS9ncagDW7NgEGIVRtw8OoyH+5isHNXE1vu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmY71huw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUhCbqWkoIL0WYlXStoL+S8I9eid4bkKJk7tnyoFRWY=;
	b=UmY71huwFT7ztidUH8/t9mSJV2abLJLoXeRDF0nHcn2OzBAoRi0HvxP6ANenJ1pcEuj0iA
	Ynxg/AT8hjcfx0JXELHGp6d40GruSLn8Kcfghgiw9WYLNP3y/Pvt6KRoEE1ngEKy6K4GGJ
	QBAcRvkRFigtY5zibR+8OhzFcb6HRfo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-i4YQz2LUNIe4F03zB3DUzA-1; Mon, 10 Mar 2025 05:40:08 -0400
X-MC-Unique: i4YQz2LUNIe4F03zB3DUzA-1
X-Mimecast-MFC-AGG-ID: i4YQz2LUNIe4F03zB3DUzA_1741599607
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so359673f8f.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599607; x=1742204407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUhCbqWkoIL0WYlXStoL+S8I9eid4bkKJk7tnyoFRWY=;
        b=iYLxTRK9QtxbHlMQES66gpHwx9fU2SxzxWYno/ocLKTv8WovfdG9FvMr3jxIY3emT3
         Xq4LcALDaGN00lm0gyNQkPi4XGneyCVjDsVrtMv5ZTU4ZKFx4ij4xkKwMN7AZsGkbGYb
         V9+o4NTZgOz4ansUPO7aDwqKyA+DjXOZJ05xT7bQmiG0n5IbPTXeJgeIYcFc8saZsoKh
         +V6HFZZKONBgt5OQv4QmCpWcHkhq31FVk3WqbkrAVI9AKfjgHj3tJ2f7CVbD1g0lESOi
         y3natiTSf8270cGQ/aTAjjGHWEBziKfJPQAvM+Ic9KTU4wAJz90Q6uYqMUtppuMpw9Xs
         XOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7iZj8AE+OS9cbFXb8pE5ZAptTKLKmpb5iIpAkcYgjXQtfPWuLLiCkCF4BCDD/JIplaoZYGdjC@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhDHKV4LtTX3D7EsQcj1CX6z7ATtxqqQT6L39E1ykmInGLVkF
	3eOQwL2yB7fBf76HHpq65laGNc0MFBQ7W2w2XU28oEkoVw3Csfy5c0dssoYKB3QcG0dhICZ5o6u
	LX35tThpbblY3QYYRkSbtESghHmoAx8G52LRqiY1L7kvPNK97U5PKxKs=
X-Gm-Gg: ASbGnctftB/GXmVBVbNJgIiB3SS4Ipxg+5ucCevZASaO3xL/NrEIWXlbqE3GjqjzKdm
	LSOL5QvwYhSP9OWdPbh9REeEa07JU3ja0+xxmIureCWFgLd1G3RuAyVXS1L66M1Lex3Ywla8wRw
	YNR7x3SmBIaIaUqxokvnmmrO7VL3JYyT4Lj97qnenPrClUNI7NtSLQhUEiug+sahRGfZV7K7VWy
	KAaPDS5cbasVX0CPKGXZ+HQJl7VDmDO1rsvji0klifhUJIY/gWqcvD2oXz6QS/pVrRKQnIA0fMy
	OCtm66gK6NGfbNzdqBmPJHjHHg62AGaI8qadO6+4rUA=
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-3913fd26306mr4340069f8f.13.1741599606964;
        Mon, 10 Mar 2025 02:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcsHZY7qjs8N1eVHZwzlGoyokzF396DbRgaw/pRBbS6FjqadMwZdpf2flPxcgdEDc9YGKV5g==
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-3913fd26306mr4340055f8f.13.1741599606572;
        Mon, 10 Mar 2025 02:40:06 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcbdd0a7sm11669675e9.11.2025.03.10.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:40:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:40:02 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
Message-ID: <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/topology.h | 10 ----------
 kernel/sched/topology.c        |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1622232bd08b..96e69bfc3c8a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,10 +168,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void dl_rebuild_rd_accounting(void);
 
-extern void partition_sched_domains_locked(int ndoms_new,
-					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -212,12 +208,6 @@ extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
-static inline void
-partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
-{
-}
-
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2d94a57e84..95bde793651c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2688,7 +2688,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
-- 
2.48.1


