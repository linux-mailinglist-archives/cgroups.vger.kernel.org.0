Return-Path: <cgroups+bounces-6625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E964AA3E275
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ADE3B5D31
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A020F09D;
	Thu, 20 Feb 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="av6Tc4h9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53231D5CC7
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072185; cv=none; b=Hfx0AOAoY35uAKwo/8Nhnwj8k3wilCVkHRDlML8Ry5X0jVlnpcbROnkK+5xr3lCZVQGOTsSRSHemcGnaIar8MYhRufRFuHSjbG4DC5S/knyH0En0VrTqB2eqnoZ/+x81VmrdoEg3gCT0c4DF2y4kYQg5zRxdR8DhrDriKo/+cZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072185; c=relaxed/simple;
	bh=ErbN5MraGaIutHdXUtXe3HTBIYCFKpWypKAqrI9odm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbTAZp3Yyl5N1AJhj6g0fDS6PxnwPl8aUloFstBj4lEdKGr+Itqtaeet4SFKWuYz3q+L60gseUFFZZ/g94yTFMhLp0zFfOoQs09bajUm1LRlRrx8GUlxWeDLlkuesc9QNeKWg8xHudWcPOvbhQanjoGKyREEziHTVpK+cZBZwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=av6Tc4h9; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740072179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqR3McEPoN/3liWwZxJzw4SmNTxJQsXfHYMg6UfHTuQ=;
	b=av6Tc4h9bvfum3W+ur8r794eb6SWxbWtO8o4WY8kGtBfX2nDcPGXeCHlhlP8Nwq1ul/+VQ
	eFCEMDy68Oky1ZblBxGCPBP4WwB2cs8dDf5EBD+aJK9qK/GmAfpP5QKzaq9kAhndYCNyDb
	WsgE0lPhcSkbGhmuQ+7AR4wGdGH+O6I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 03/11] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <Z7dk7t9vH42FYSBG@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-4-inwardvessel@gmail.com>
 <yz6jmggzhbejzybcign2k3mfxvkx5zb6fxlacscrprbjsoplki@6x5dtnmzks7u>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yz6jmggzhbejzybcign2k3mfxvkx5zb6fxlacscrprbjsoplki@6x5dtnmzks7u>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 09:06:44AM -0800, Shakeel Butt wrote:
> On Mon, Feb 17, 2025 at 07:14:40PM -0800, JP Kobryn wrote:
> [...]
> > @@ -3240,6 +3234,12 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
> >  				css = css_create(dsct, ss);
> >  				if (IS_ERR(css))
> >  					return PTR_ERR(css);
> 
> Since rstat is part of css, why not cgroup_rstat_init() inside
> css_create()?
> 
> > +
> > +				if (css->ss && css->ss->css_rstat_flush) {
> > +					ret = cgroup_rstat_init(css);
> > +					if (ret)
> > +						goto err_out;
> > +				}
> >  			}
> >  
> >  			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
> > @@ -3253,6 +3253,21 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
> >  	}
> >  
> >  	return 0;
> 
> Why not the following cleanup in css_kill()? If you handle it in
> css_kill(), you don't need this special handling.

Also, I don't think we are currently calling cgroup_rstat_exit() for
every css when it is destroyed, so moving the cleanup to css_kill()
should handle this as well.

> 
> > +
> > +err_out:
> > +	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
> > +		for_each_subsys(ss, ssid) {
> > +			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
> > +
> > +			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
> > +				continue;
> > +
> > +			if (css && css->ss && css->ss->css_rstat_flush)
> > +				cgroup_rstat_exit(css);
> > +		}
> > +	}
> > +
> > +	return ret;
> >  }
> 

