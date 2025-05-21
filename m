Return-Path: <cgroups+bounces-8295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C880AC00AE
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEABB7AE96F
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B923BCFF;
	Wed, 21 May 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7utqQ74"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689123BF91
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869845; cv=none; b=PSw6aHmuWTkFPPt1iExxj733OXDpH4l2HhO+Rjycw6Bw/Xe6qiC7jD0Kvf/6H5CIdsvbcDFY+2/Z8ZrjTfUJ81RYWnkxc6SFUx87VRuPAnEN82P6DuAEMVb7h7e9qI4bQnIrOBcEprCNQHjLLPfasEdpH7GCqtZ7ExKf8k2DBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869845; c=relaxed/simple;
	bh=AOg2Ufxf/+K6vIJlmYxGSKnDvI/dlwEhatiSMegapz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcJLnsv6sQu21ihce54b3CodEsyDy3J720lZs7YAGKJe8nRDxp+bDuKjl7JkuR+A+b84xH/uNaErGXhdAADrL78Q+1ySbDwAVAezBntnHwPlX3Ibi7xdqCqAONaI3/ev2dMwelOA1wH8jG56xh+M3ZfoXgi07O/AhX4nodffMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7utqQ74; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 May 2025 16:23:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747869831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4OYdCpZ51bnfOA4PAne9tr3HLdFlk4cbhBVWDz71Pw=;
	b=d7utqQ74NwAwJsLfRRD2KdAWeQlwgSX33niK3aby8u9BjkUJibGzpwixayPre1taWmwFIa
	cd5nAqUOoIGg2fal9mQeBu5PVhhvUNX87PrG1D5HdT//SsGPcGHP9zoJ6b5aXFyWFEZF/O
	Olb3kkbKawnvqKPoXd3AilwArGnDJX8=
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
Message-ID: <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
X-Migadu-Flow: FLOW_OUT

On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
> Hi,
> 
> On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> > Please ignore this patch as it was sent by mistake.
> 
> This seems to have made it into next:
> 
> 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
> 
> It causes a BUG and eventually a panic on my Raspberry Pi 1:
> 
> WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
> illegal size (0) or align (4) for percpu allocation

Ok this config is without CONFIG_SMP and on such configs we have:

typedef struct { } arch_spinlock_t;

So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).

Hmm, let me think more on how to fix this.


