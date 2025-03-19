Return-Path: <cgroups+bounces-7168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7AA698BA
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB41423199
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3A211299;
	Wed, 19 Mar 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOagZkFG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5E20B808;
	Wed, 19 Mar 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411414; cv=none; b=JXC2WfBDPklgLz8Hzl9u28gdMy1+/VznjzlVbj+1QtOrrHigRKgeIxiI/98zAAkPteduL444X2eVhQNGhDcZVZQPf44vmdc4ThoSwOAwNsVaIpKN3rGxtOhjgXWnF3KpkGz6RXecC626USB1tvD5Z1ZQYqO/DLRLpEEyh3Uelk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411414; c=relaxed/simple;
	bh=pNv5vqizrqqlsWff5sCe16X4kvlVLEVwPXbH3wggGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5+2o5KVt/QDB/3mWw3mdwAQtcSrlphJjpmjSKEnt/nKs0bOJS5uoa2azx8xlwcYGk/b+R4vGfgtGIGBV4B1t0JlqB1ALE+mazvNTe/xtgFoL8H33DTFduzyNYy5OGQBgm4jJO9Wnd50uyaGPWBCt9Xx2iNYm64PDUmcTiMc/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOagZkFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F11C4CEE4;
	Wed, 19 Mar 2025 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411413;
	bh=pNv5vqizrqqlsWff5sCe16X4kvlVLEVwPXbH3wggGLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOagZkFG6Gc62lzuwMJRJJzkQV8CIhtugiv0P5+TKez/UD1tuO6p2NmR70OiI7REe
	 oIwLe9BZEsjadElzy0En08MveOXBp87KOOZNDCr34MIH1QYm5JJlKY47tDwr9c1d59
	 6x9tTIR+KGXCCZv9QycksYXO2ZttX65vMCYpbk7gIISItTEm3akRDXTOjFcoz4Dazw
	 F23lZVluxM1XDydRjaULvdxwZgPmOet7rn5KDgRcLzdqiGpIZKuUBNgRfm9C9fCqiQ
	 TXXnGCRFjxm6iMUGnmz9nDrKR2SPblLVpNQ8usNl4/8FDOzYo7EQLOT50trJFIiDsY
	 vaJzl3cuaTA4g==
Date: Wed, 19 Mar 2025 09:10:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Greg Thelen <gthelen@google.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9sWlCQBchKlJ_hj@slm.duckdns.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
 <Z9sOVsMtaZ9n02MZ@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sOVsMtaZ9n02MZ@google.com>

On Wed, Mar 19, 2025 at 06:35:02PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> > On Wed, Mar 19, 2025 at 05:16:02PM +0000, Yosry Ahmed wrote:
> > > @@ -365,9 +352,8 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
> > >  void cgroup_rstat_flush_hold(struct cgroup *cgrp)
> > >  	__acquires(&cgroup_rstat_lock)
> > >  {
> > > -	might_sleep();
> > > +	cgroup_rstat_flush(cgrp);
> > >  	__cgroup_rstat_lock(cgrp, -1);
> > > -	cgroup_rstat_flush_locked(cgrp);
> > >  }
> > 
> > Might as well remove cgroup_rstat_flush_hold/release entirely? There
> > are no external users, and the concept seems moot when the lock is
> > dropped per default. cgroup_base_stat_cputime_show() can open-code the
> > lock/unlock to stabilize the counts while reading.
>  
> Yeah I missed the fact that the users are internal because the functions
> are not static. I also don't see the point of keeping them.
> 
> Tejun/Greg, should I send a patch on top of this one or do you prefer
> sending a new version?

Please send a patch on top.

Thanks.

-- 
tejun

