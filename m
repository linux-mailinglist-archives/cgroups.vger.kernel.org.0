Return-Path: <cgroups+bounces-7306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18AA796AF
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 22:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B02817190B
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F51F0E4A;
	Wed,  2 Apr 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j4fLLZig"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADE2E3385
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626447; cv=none; b=C1PRuOk0WGagmInGS0Qtd0bcGcTk17kShSjHwyhL1+UvF7C8+yHFPIE12OFKFI9aj+J/8NM8U3GLl7Qt2bn37DyYDu60eFvl7pUrRcYE5msaLNgiSwy+hwJDqfgUEpnNSxErYJdi0AZhSrEzpMEax7ErZvU+xs5s9RzOKJelQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626447; c=relaxed/simple;
	bh=M6izjJ19FzNMpDoOopDflX3Gio1ppr1X73iDCJb3ilw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hagO3JKZ7Fo1kIeIslZYGbsITF+PZesxs88jXrKBVXoULu8kinF+kXNVJjRS+9c7RoZrCsd4yVHBYdZZJLELGTfw8nGy97nVFBu0IPix2GoURS8qxfbrCXUlEMb0I1tKCixovae1mT8O4wEf9gIniHRHa7ezNz3HFrTObtjp9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j4fLLZig; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 13:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743626443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RZMkniPgYF7yEHpJ0ur96d00xfQ37h9uWuSz7BKHZA=;
	b=j4fLLZigrWiWx5c+0xQ49FwOeYE+R0bvmtSdTbTL+iSqEtYCA50xrfpuuscwXkZOzCdsYw
	/LqBcCUNoX5HYXtruGk703vmpIsjPKDtwF/j8iqx8vsCTjnEKzM8gj1DR2kiPyJ/p+4uNH
	P+Au0BtNd0aZlVeRoBhZLWKwfOr/IGE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-ID: <5fyk3ek22txixx74d7ww3tzrpejazhrsdmu4p26nhzc5kbf2wu@4huj4lohqbmb>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:21AM -0700, Shakeel Butt wrote:
> This is a cleanup series which is trying to simplify the memcg per-cpu
> stock code, particularly it tries to remove unnecessary dependencies on
> local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> optimizes the charge path by combining the charging and accounting.
> 
> This series is based on next-20250314 plus two following patches:
> 
> Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> 
> Shakeel Butt (8):
>   memcg: remove root memcg check from refill_stock
>   memcg: decouple drain_obj_stock from local stock
>   memcg: introduce memcg_uncharge
>   memcg: manually inline __refill_stock
>   memcg: no refilling stock from obj_cgroup_release
>   memcg: do obj_cgroup_put inside drain_obj_stock
>   memcg: use __mod_memcg_state in drain_obj_stock
>   memcg: manually inline replace_stock_objcg
> 
> Vlastimil Babka (1):
>   memcg: combine slab obj stock charging and accounting
> 
>  mm/memcontrol.c | 195 +++++++++++++++++++++++-------------------------
>  1 file changed, 95 insertions(+), 100 deletions(-)
> 

I am waiting for [1] to merge into linus tree and then I will rebase and
resend this series.

[1] https://lore.kernel.org/all/20250401205245.70838-1-alexei.starovoitov@gmail.com/

