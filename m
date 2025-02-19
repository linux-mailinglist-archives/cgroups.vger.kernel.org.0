Return-Path: <cgroups+bounces-6595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E322AA3AE8E
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 02:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384171888E6D
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A41DFE1;
	Wed, 19 Feb 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1mpzZqq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001B286292
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927160; cv=none; b=rtZXWz1anenEXV9cOJJGZvgq2ADqMu8Ng5QDs+HQMF1I6wDBOa7IOwWMiHXFNluSS7Oz8aXzEFCfxrmDp7KqGm15mVExNiv5yOmtMpELqE6JjbIu8Js95iTlASrYu58LB9qQiWh1qfo1OAydr/mOxNU5aTe9dBDg4PKvaCv3kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927160; c=relaxed/simple;
	bh=8ZrxQtI6q0BcwS1Y79Wtjz/86GXDbgzhJqBXInwtRfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaSi5504iQpgtS33+HTDDHK6tBTGt0l/5gslEZF4idaa2Z2nu89nwWLwZPlWWPQHt7gZapmIJTHgNOOKkAaozZof0obrBH/s5i8sXNjV30/fLug1a10GjvF5hVhVEt25nBY8Mu+UJIaNB8msDlk97aNsrz7dAf4mPoaEjrr9Tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1mpzZqq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Feb 2025 17:05:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739927156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DS0VsgA0eFjWLaMuwoiKCDQIrGChx+ZK3MKy/ATOvs=;
	b=C1mpzZqqJ5P4mCKrnlLKsgB5i2b13m+IvcuHp+kdkyG/5+uUPy3CuK8kobQhHvWTUpmfSB
	stXXaafnrbWP9X9QBJQzS8lyQ53i62KspEt3PhTq0oxC9jcMMmH0p5xGvPIqRmFYCvLIFC
	0O2CnbHmZb8jVpScmw0bRgxJ+gkCcJk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 01/11] cgroup: move rstat pointers into struct of their
 own
Message-ID: <v56w5fmzw7ugztktnupdzkthedtm6k7u4o7k2tro4ignqkpt4p@3qekpprnmmgr>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Thanks JP for awesome work. I am doing a quick first iteration and later
will do the deep review.

On Mon, Feb 17, 2025 at 07:14:38PM -0800, JP Kobryn wrote:
>  struct cgroup_freezer_state {
>  	/* Should the cgroup and its descendants be frozen. */
>  	bool freeze;
> @@ -517,23 +445,9 @@ struct cgroup {
>  	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>  
>  	/* per-cpu recursive resource statistics */
> -	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +	struct cgroup_rstat rstat;
>  	struct list_head rstat_css_list;

You might want to place rstat after rstat_css_list just to keep
(hopefully) on the same cacheline as before other this will put
rstat_css_list with rstat_flush_next which the current padding is trying
to avoid. This is just to be safe. Later we might want to reevaluate the
padding and right cacheline alignments of the fields of struct cgroup.

>  
> -	/*
> -	 * Add padding to separate the read mostly rstat_cpu and
> -	 * rstat_css_list into a different cacheline from the following
> -	 * rstat_flush_next and *bstat fields which can have frequent updates.
> -	 */
> -	CACHELINE_PADDING(_pad_);
> -
> -	/*
> -	 * A singly-linked list of cgroup structures to be rstat flushed.
> -	 * This is a scratch field to be used exclusively by
> -	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
> -	 */
> -	struct cgroup	*rstat_flush_next;
> -
>  	/* cgroup basic resource statistics */
>  	struct cgroup_base_stat last_bstat;
>  	struct cgroup_base_stat bstat;
> diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
> new file mode 100644
> index 000000000000..f95474d6f8ab
> --- /dev/null
> +++ b/include/linux/cgroup_rstat.h
> @@ -0,0 +1,92 @@
[...]
> +struct cgroup_rstat {
> +	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +
> +	/*
> +	 * Add padding to separate the read mostly rstat_cpu and
> +	 * rstat_css_list into a different cacheline from the following
> +	 * rstat_flush_next and containing struct fields which can have
> +	 * frequent updates.
> +	 */
> +	CACHELINE_PADDING(_pad_);
> +	struct cgroup *rstat_flush_next;
> +};

