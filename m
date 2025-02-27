Return-Path: <cgroups+bounces-6736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9BA48C3D
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 00:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060717A4C66
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25781AB6D8;
	Thu, 27 Feb 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HV9OM5/D"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2C27780C
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697296; cv=none; b=uFmn1g7mn1m+THRR4ga/lyXkxd/FIB8MirnvQ1TAKIMPE4rZAKBgrGJ7n59F3L7XmFWL24ls1bcNyqZClOgfKoqtJTeVs2vN/YD6NsJRfE04DNUNlDX6rTyvI9v52WYb3CV9HSbTmEKgoi48A4e6+hQCYo2vMxf+q0PNBzNiUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697296; c=relaxed/simple;
	bh=1NWOS11L2TSKfIWNZX7tFO/ymFgypwRbLBD14bAu2+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRuTRIdarmyk3H4ZJ5zxKSVoAAokzy6NtRsZaEHsVahhwW/+WAjSwLzMlTzYKK5XTo2zcR4Feo/N4cIl05G8sImay6qNT1Dn7/P8wMVBy04jSNmvwRso90ILQ34KZcutb44XDTuTSyUvWyvykeHLRukHJglfUNbBn3rnVXO+U/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HV9OM5/D; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 15:01:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740697292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OoTaQAGzX8rjvV6FcqqXocN/Sg8kBNDVleKgzUwS4Yk=;
	b=HV9OM5/D8AqGYFntEo2xAxZZKYH+R3tRKiP3D+3XTCbDUc9oCYeES4RITiFJUWHL1pYFmD
	roCdIuTlLimk02enlly2j/p8MJXRVLOB56F5D6UO0h9AEms9GNYAmY0maiDv6WUVQyxD3c
	nFdRAjitbOjMVtahfexg7ZWhsJrF7/4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, yosryahmed@google.com, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/4 v2] cgroup: separate rstat list pointers from base
 stats
Message-ID: <3asrhag2zfxzlmtjqwzmmuyt5tn57d3se7uvhpuloavsc4dvwa@2my4xmpabl2o>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-5-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:43PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> A majority of the cgroup_rstat_cpu struct size is made up of the base
> stat entities. Since only the "self" subsystem state makes use of these,
> move them into a struct of their own. This allows for a new compact
> cgroup_rstat_cpu struct that the formal subsystems can make use of.
> Where applicable, decide on whether to allocate the compact or full
> struct including the base stats.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

One nit below otherwise:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

[...]
> @@ -438,17 +444,31 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
>  
>  	/* the root cgrp's self css has rstat_cpu preallocated */
>  	if (!css->rstat_cpu) {

Early return here for root to eliminate one indent in this function.

> -		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> -		if (!css->rstat_cpu)
> -			return -ENOMEM;
> -	}
> +		if (is_base_css(css)) {
> +			css->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
> +			if (!css->rstat_base_cpu)
> +				return -ENOMEM;
>  
> -	/* ->updated_children list is self terminated */
> -	for_each_possible_cpu(cpu) {
> -		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
> +			for_each_possible_cpu(cpu) {
> +				struct cgroup_rstat_base_cpu *rstatc;
> +
> +				rstatc = cgroup_rstat_base_cpu(css, cpu);
> +				rstatc->self.updated_children = css;
> +				u64_stats_init(&rstatc->bsync);
> +			}
> +		} else {
> +			css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
> +			if (!css->rstat_cpu)
> +				return -ENOMEM;
> +
> +			for_each_possible_cpu(cpu) {
> +				struct cgroup_rstat_cpu *rstatc;
> +
> +				rstatc = cgroup_rstat_cpu(css, cpu);
> +				rstatc->updated_children = css;
> +			}
> +		}
>  
> -		rstatc->updated_children = css;
> -		u64_stats_init(&rstatc->bsync);
>  	}

