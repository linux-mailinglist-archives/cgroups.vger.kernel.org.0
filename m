Return-Path: <cgroups+bounces-8296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE8AC00B7
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF697A8460
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132023C4EA;
	Wed, 21 May 2025 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EH5EUkuE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE56EB79
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870437; cv=none; b=iPkkmJ9kE5MpoRj7pUg6S702G4i0OwsG63Mqm3XN51kPYpT9CDmbgEgO9jq+cOd5udh4YCfWItMU9PhjIBLyMvk7KZ0zCTrcp3hqIGkoz8Y21zyu3z3p8+MVxxZpqmH7V+BZrAuFy0zpB11JFNxpBu42G8pDrErJ9QQJVhlXZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870437; c=relaxed/simple;
	bh=ypGle7kHRl1MnihGO/vMI64ZNjg/4RzE1sAUEi9QX80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBarXCCXcqBGtS2yOfLe/Y4WAwf0Jc0aweuEM7onuHm+1ihupetLc7QqqH8DIoarTPJ0wyQZgomGy8SdSokn1Mwl/syx7y17IyN8HCsapkPBKa6mWlSI4IrZfk+kV7r3FDIkdGTroS7PskQjwlpbCK19X4Lq46M87V82QBPbdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EH5EUkuE; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 May 2025 16:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747870423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxBHcO2OStLwZGLgLdCMqlriVkxYivQ6RlwIYKIM/tc=;
	b=EH5EUkuEmwWVmqrUOXyVACQnMwIjko7zqEz8WjuYyHPBRP7gLyO4t5VysG2Tw1KFk0mQyp
	nGu1pjABkI4+QKpDvhF7jMMXWdZdXv131lPPGi6OLeT9ZgvK4+KVNoiHlZ5ea9o7V6kf81
	S8DbSMEk8ZfouCXwhwKrn4eDXE9Uef0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks
 to avoid contention
Message-ID: <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
 <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
X-Migadu-Flow: FLOW_OUT

On Wed, May 21, 2025 at 04:23:44PM -0700, Shakeel Butt wrote:
> On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
> > Hi,
> > 
> > On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> > > Please ignore this patch as it was sent by mistake.
> > 
> > This seems to have made it into next:
> > 
> > 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
> > 
> > It causes a BUG and eventually a panic on my Raspberry Pi 1:
> > 
> > WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
> > illegal size (0) or align (4) for percpu allocation
> 
> Ok this config is without CONFIG_SMP and on such configs we have:
> 
> typedef struct { } arch_spinlock_t;
> 
> So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).
> 
> Hmm, let me think more on how to fix this.
> 

I think following is the simplest fix:

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7dd396ae3c68..aab09495192e 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -511,7 +511,10 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 	int cpu;
 
 	if (ss) {
-		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
+		size_t size = sizeof(raw_spinlock_t) ?: 1;
+
+		ss->rstat_ss_cpu_lock = __alloc_percpu(size,
+						__alignof__(raw_spinlock_t));
 		if (!ss->rstat_ss_cpu_lock)
 			return -ENOMEM;
 	}

