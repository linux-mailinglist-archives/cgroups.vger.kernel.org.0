Return-Path: <cgroups+bounces-8298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5AC00CA
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ABE1BA2FFA
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49523AE95;
	Wed, 21 May 2025 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bhO6Mbtk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB02367AC
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871279; cv=none; b=Et5xGIqCreiwBbA8Q+drGMhYRqNv51gtZz5Dy1a4fqyPP9cqNu2FiB9uOva9fBLEMZOzSAyZmNP47PYGJzR2X7KQuDtCf8p9QlQDNUD+nRFtfFEE9L2lUXNoc27u/V84g+xKYEJceb9ohU9B2TTVYbmknTx76QoZU4gDAAclWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871279; c=relaxed/simple;
	bh=Z14KfDlTuBY+jSDHfHotsvcjQ4EltBuM635WVchgVgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlS5HLOlTA8S+bccErSAZl7m/11kCQCCDhzNA4WpAla7HOKv/KAFCUL1/vgCLg/aHTfJmcsJLk3A1ddWndbegTPrR+btn7EGf9bhIjVI20BK/vr4D+GKpGdm0bQnjyeupeWcaKENZ+Pl0njlQvvKDMRRr/OkGnB0ud+YcQtnqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bhO6Mbtk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 May 2025 16:47:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747871265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVq5FQAXCRNmQoLttDa8m6sdhR0LLw344xckKZXB3c4=;
	b=bhO6MbtkwhnOfr3CAglW8jflHAKL1cPhdZr+gZspRTtwAxmDOh7Uuccp47hd0+PNYSJ6z6
	sygfgXFUlEGwRB5lf3bbYRlaH0kfNv6LE3BSJsztoEk/n2jLSE8sJdkqOdiLEnMcqtcTyJ
	lh8K8MJ0ceeXWqCZo7uIUBLKYXE0evk=
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
Message-ID: <77zncuxd472mhhbsbj3orcwsj7pl65s4h6uy5x6fioy55cvlsd@zmvpkrh2wfry>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
 <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
 <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
X-Migadu-Flow: FLOW_OUT

On Wed, May 21, 2025 at 04:33:35PM -0700, Shakeel Butt wrote:
> On Wed, May 21, 2025 at 04:23:44PM -0700, Shakeel Butt wrote:
> > On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
> > > Hi,
> > > 
> > > On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> > > > Please ignore this patch as it was sent by mistake.
> > > 
> > > This seems to have made it into next:
> > > 
> > > 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
> > > 
> > > It causes a BUG and eventually a panic on my Raspberry Pi 1:
> > > 
> > > WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
> > > illegal size (0) or align (4) for percpu allocation
> > 
> > Ok this config is without CONFIG_SMP and on such configs we have:
> > 
> > typedef struct { } arch_spinlock_t;
> > 
> > So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).
> > 
> > Hmm, let me think more on how to fix this.
> > 
> 
> I think following is the simplest fix:
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 7dd396ae3c68..aab09495192e 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -511,7 +511,10 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
>  	int cpu;
>  
>  	if (ss) {
> -		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> +		size_t size = sizeof(raw_spinlock_t) ?: 1;
> +
> +		ss->rstat_ss_cpu_lock = __alloc_percpu(size,
> +						__alignof__(raw_spinlock_t));
>  		if (!ss->rstat_ss_cpu_lock)
>  			return -ENOMEM;
>  	}

JP suggested to avoid the allocation altogether on such configs. So,
something like the following.

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7dd396ae3c68..d0c88903d033 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -510,7 +510,7 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 {
 	int cpu;
 
-	if (ss) {
+	if (ss && sizeof(raw_spinlock_t)) {
 		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
 		if (!ss->rstat_ss_cpu_lock)
 			return -ENOMEM;


Tejun which one do you prefer?


