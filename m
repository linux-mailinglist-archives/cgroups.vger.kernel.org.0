Return-Path: <cgroups+bounces-7209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9CA6B015
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 22:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FD4189F419
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA4C228CB8;
	Thu, 20 Mar 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL4OlvRT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C922576E
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507060; cv=none; b=kK4LkAylYZ0t40gxKsGrM5DrXj7kdsNUtq4jiciEnjRjwSLU1YEltVcw4D29Y9cd6lTAkOoAxeFj9+M1kLr3+jUQ00pcwMsn+hA8lD3KLm9M1Rfal68AQuV4HxpqWyLGWvFvDpCQCtGsgFYYxTHuE1clHOfZoU3CMoZaIK7reIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507060; c=relaxed/simple;
	bh=dH3CJMuNKLt5T1SNjnqbJSVsJQBEkZlz8zbx3AjYlxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyxeRRdaCP8v+Srn/J8BxPF3G1MC0JTJIFXkW+vbCJGa6f933dOHRr7h06eHHxl961iWNoOnqAhihiA/6x3izoQ0DEFeoijtI7MIEXK/G/dXthVlkuSzIf67riLmxijWJZuKB+vC5bpKABF8fSit9FkQHSiWLCicrzwYKVKkmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL4OlvRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29BDC4CEDD;
	Thu, 20 Mar 2025 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742507060;
	bh=dH3CJMuNKLt5T1SNjnqbJSVsJQBEkZlz8zbx3AjYlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GL4OlvRT9oYrG11Cnp/kikGAgNDKUq/YLMalfuEzGCZ8n9FOgJUz5DjfBymL9ti+h
	 7N2Pa0ZJRKeINC4VZZ/ud6Hqxaa+0bi4yTxY6Z5ffcWmkty0zhrzQbCNVC14j1uUQ1
	 a9RAvqyoyGTSJfxN4mXr2SF0tk8oDP6Mm/KWPukTmpvstz4ED0JsPztBpuKUiCTDmz
	 k1/Ex2Kxvuc3ug72B/bB/F/sOD3i0khfEi5qaFXaLdDTRyfEzkZftSyjjE2DLkOCDX
	 naH9HgfcNwzCGDFAfI9RDqGL7aPXpNy8qTO4bbzHIn5OgHexlFvr1qP4lt+fY3yNUj
	 B8QlLhqgeE15Q==
Date: Thu, 20 Mar 2025 11:44:19 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/4 v3] cgroup: save memory by splitting cgroup_rstat_cpu
 into compact and full versions
Message-ID: <Z9yMMzDo6L7GYGec@slm.duckdns.org>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-5-inwardvessel@gmail.com>

Hello,

On Wed, Mar 19, 2025 at 03:21:50PM -0700, JP Kobryn wrote:
> The cgroup_rstat_cpu struct contains rstat node pointers and also the base
> stat objects. Since ownership of the cgroup_rstat_cpu has shifted from
> cgroup to cgroup_subsys_state, css's other than cgroup::self are now
> carrying along these base stat objects which go unused. Eliminate this
> wasted memory by splitting up cgroup_rstat_cpu into two separate structs.
> 
> The cgroup_rstat_cpu struct is modified in a way that it now contains only
> the rstat node pointers. css's that are associated with a subsystem
> (memory, io) use this compact struct to participate in rstat without the
> memory overhead of the base stat objects.
> 
> As for css's represented by cgroup::self, a new cgroup_rstat_base_cpu
> struct is introduced. It contains the new compact cgroup_rstat_cpu struct
> as its first field followed by the base stat objects.
> 
> Because the rstat pointers exist at the same offset (beginning) in both
> structs, cgroup_subsys_state is modified to contain a union of the two
> structs. Where css initialization is done, the compact struct is allocated
> when the css is associated with a subsystem. When the css is not associated
> with a subsystem, the full struct is allocated. The union allows the
> existing rstat updated/flush routines to work with any css regardless of
> subsystem association. The base stats routines however, were modified to
> access the full struct field in the union.

Can you do this as a part of prep patch? ie. Move the bstat out of rstat_cpu
into the containing cgroup before switching to css based structure? It's
rather odd to claim memory saving after bloating it up due to patch
sequencing.

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 0ffc8438c6d9..f9b84e7f718d 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -170,7 +170,10 @@ struct cgroup_subsys_state {
>  	struct percpu_ref refcnt;
>  
>  	/* per-cpu recursive resource statistics */
> -	struct css_rstat_cpu __percpu *rstat_cpu;
> +	union {
> +		struct css_rstat_cpu __percpu *rstat_cpu;
> +		struct css_rstat_base_cpu __percpu *rstat_base_cpu;
> +	};

I have a bit of difficult time following this. All that bstat is is the
counters that the cgroup itself carries regardless of the subsystem but they
would be collected and flushed the same way. Wouldn't that mean that the
cgroup css should carry the same css_rstat_cpu as other csses but would have
separate struct to carry the counters? Why is it multiplexed on
css_rstat_cpu?

Thanks.

-- 
tejun

