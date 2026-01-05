Return-Path: <cgroups+bounces-12922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1DCF49BC
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C32300A507
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562C3491E8;
	Mon,  5 Jan 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BzCISz4B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48D348458
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628484; cv=none; b=MXcxEqrSSHowcFH6REOX46N6JmBTgWNrqSlqtCjFvzIu1hge/SKtAS6MqQtqJfxLOCkftBU96t+8GGm/Uu3j8DJTnETXxEItWxCq331Bzgge0m8oeN9/2nAGfoOeB22ItC2iMK04CAIy84JKEaCPeWcKPOODTuoB33paHsxm8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628484; c=relaxed/simple;
	bh=JtFC32xi6j5IfxixNuzP6FWQBzCxLH1+Y75+kOMFwC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz7WeSqEGsSztuFlfUfPKfdcbQay8VMCVuFo5FvUCNazIo1TvSx6VhA5SVdR1hE8fr0oTh7GUzkhVOpjVKREvsABG/CnD7SB6oY4dA1RLb1udiuknL5PuwUePEwyxS6o5e95vkyHkokHuMyDBr+4zKeV2e1CiuRF+txzuHF1lT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BzCISz4B; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2d7c38352so195213185a.0
        for <cgroups@vger.kernel.org>; Mon, 05 Jan 2026 07:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767628481; x=1768233281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqeiK1L0ygc2pzqeCiF6H1L5F3hBzQyLyjzKsWaL6zQ=;
        b=BzCISz4BLAJEQLOVROpdHYPjSkC+D2AT+CCCCFaLrg1PaqG+gUeQ5BcU1pkC+Qzpa9
         eFi5Zji+OtVhNBhFnvpPdgH6l9/mKqfjQtlStyFJMWbAa2CvytHDJQvv5slFz/UxpDZA
         ZWQZFWZ2fUswu5AMWcGr9jpitIFmUbpTt/2tVsa54LNjQe4yX1eEMJGCgX5EVtOxRU1H
         vFRfuQh7OKYyfW7ngzDpzhzAKWPAV/fFQhcNcc1Wlg/U+q97LOU4hOaublPUR5ieNZ1C
         wXolWM0jh/VP7j6bixlKjI0ddK29m1WWD41lRDux4o0b7YpkaTYaxYZVNbEg11lR1qMm
         js6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767628481; x=1768233281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqeiK1L0ygc2pzqeCiF6H1L5F3hBzQyLyjzKsWaL6zQ=;
        b=DMViSi6zXECi0tQFfgR+KYe8FxSqwwTAKiF6ZqiupAapogEWBFW+Z6gweyswfIon1X
         mjS++hE+2cBU1yJSJVBojaQpJiP6gd07nWYRUQBJw4jMzPNCR1Dg84F6X12zkdnfLhAf
         RS+rXLEehm7H0eaLIVtOPuEfgGtfohfz+DTfnyhtPyXuAgNhUtgB5BY3fYGt6ymetZKi
         dr6pzqtvmI56Sb6vDIL55AzIBp0X+50XQctsXzyZ0d966zcKOXqBcan5e4OzACoLtPBQ
         DyjyKg/3bh+Nz9uPTSp4XlecSHhF5+qQLkY43r8uZGeLKRPWKh8A86T0uNKEmTKU9ZHG
         +68w==
X-Forwarded-Encrypted: i=1; AJvYcCX9sJaxCtjLem17yxDx5zI2mIG+sksaAEKs14nCjMb4mjoBpaULvY1A8jDH+FpuhRLXKbnrBB2h@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuuU3vsTIRzTDpTXgYSebFH/Wi3N8PNmQTPbcnwtj2+hUrsjJ
	FIXxiXiPBinAIWEXaKI7n3Y86z7MD/vfC7pSnlO/fBnyB1/yivx5bamj16bUVR0sxbM=
X-Gm-Gg: AY/fxX6k7G9s0wWvz+VMzXdDUU6M+dJyzVcg0UxDjktC+rtUE8dCUOIhRpt47luCmsO
	6fWR0KPaCopwr/9JgY4KM6iFkoXju0g9xRh9gNH9sdwBcXX6WqcpRCCSW5LHBVks9jaD91sT3fP
	T+FMmuuAgtDg69Aw1F8LagDkzG3RJv4upIuZ+wytIjbz6Y/jzdXvNAogcnA8bDDYK74H31HQ3rN
	6VwrMFfeRcTVl//jcZ1n6XogUt6D66/TUEuJdG4Sfje2Nibl+Qd4jN/0J8ET/FoNTWdCcJb1ODO
	a7sMhP1HWhM8Bkdtv/GRX7/X3deqKeI1dtzD1ldxbDK/6S6qQ7o1tdZGSU7sKijT/THGQI0bEhW
	A32MBVNJQ2kKUplbBIzBkD6VtvqnEpmLoFYwgAczRypXiSK43fL7MHjDyK7QX0wuKeZ+OZ885y/
	ZMa/JDyhDpFP+CtEa0SVxsenUZYZrcwvjnqRs9Nb/1CdZ3ssLpSqrAU3LUpGAcx1l3hLfzWg==
X-Google-Smtp-Source: AGHT+IFjadPoIlIw6SGjI59tZCwclSAcWIXhM7W6liSGa0PXOk8e+eEyYSDeMbDYFUQqM4JsPhO5iA==
X-Received: by 2002:a05:620a:44ce:b0:89f:cc73:386 with SMTP id af79cd13be357-8c356acd43dmr1062406285a.13.1767628480647;
        Mon, 05 Jan 2026 07:54:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37ea0f713sm5250085a.15.2026.01.05.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:54:40 -0800 (PST)
Date: Mon, 5 Jan 2026 10:54:05 -0500
From: Gregory Price <gourry@gourry.net>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v5] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVvenfzgCU9uKJN8@gourry-fedora-PF4VCD3F>
References: <20260104085439.4076810-1-bingjiao@google.com>
 <20260105050203.328095-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105050203.328095-1-bingjiao@google.com>

On Mon, Jan 05, 2026 at 05:01:52AM +0000, Bing Jiao wrote:
... snip ...
> +/**
> + * cpuset_nodes_allowed - return mems_allowed mask from a cgroup cpuset.
> + * @cgroup: pointer to struct cgroup.
> + * @mask: pointer to struct nodemask_t to be returned.
> + *
> + * Returns mems_allowed mask from a cgroup cpuset if it is cgroup v2 and
> + * has cpuset subsys. Otherwise, returns node_states[N_MEMORY].
> + *
> + * Returned @mask may be empty, and nodes in @mask are not guaranteed
> + * to be online.
> + **/
> +void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
> +void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  {
... snip ...
>  	/*
>  	 * Normally, accessing effective_mems would require the cpuset_mutex
> -	 * or callback_lock - but node_isset is atomic and the reference
> +	 * or callback_lock - but not doing so is acceptable and the reference


"node_isset is atomic" is an argument that not taking cpuset_mutex is
acceptable since it's a singular operation against a nodemask (one bit
it checked) - and therefore for a moment in time the node is either
allowed or not (and we make no absolute guarantee of corrected when this
race occurs, we just note that we're corrected).

nodes_copy is not atomic, and in fact this can result in returning an
empty nodemask if cs->effective_mems is being recalculated at the time
this copy occurs.

Rather than just saying "not doing so is acceptable" - can you please
change this comment to explain the implications of not acquiring the
mutex a little more clearly?

Example:
```
We do not acquire cpuset_mutex during this check because the correctness
of this information is stale immediately after the query anyway - this
saves lock contention in exchange for racing against mems_allowed rebinds.

As a result, @mask may be empty because cs->effective_mems can be rebound
during this call.  Callers must check the mask for validity on return.
```

The rest of the comments in the function explains a about this, but I
think with this update the comments need a little more rework.

~Gregory

