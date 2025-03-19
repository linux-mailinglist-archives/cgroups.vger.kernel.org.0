Return-Path: <cgroups+bounces-7167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D612A6981B
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1827E7AFE47
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB8207DF9;
	Wed, 19 Mar 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EkYkbJ1t"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E251DE3C5
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409321; cv=none; b=ToqWSEVbpb9g2GM9PttAXn1nHW2jiItRJUVAPpqE+jgHvvwfBlJujTxUpS7ptxQUKTW/+jsmrsgPsOm83wRolI9eBbtHi1yXLd+4YxTpJKNgYT+uHPW3oFVbLUshCpYJ8eF2SHea2dd1HyBGJnQAd3DQE1RlZ/U54e2VmCNypoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409321; c=relaxed/simple;
	bh=E7/9Oi777npF+nDuoJ3nAXnfNqMvowjQVRd9godZYos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FueCR5wtg81YKLNFx8yrLJ/LgMEuRf7n3dxQF2DFqKqlEpRKYd/elEx01f8cKWVju9+8Z1/Ewo9Y6lrkRnepkzWe1LIXZdQ2/pEWahDLoSWdsQdU6TBefxubcXpfatCdu3oC3F1Wb03KSqfD5cz2V8u3Z0nYmSmFmAcNxY677XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EkYkbJ1t; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 18:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742409307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHSVnsYV0So9Z+A1VzS0RGmPulR4DlPUT0ZKsxRunMY=;
	b=EkYkbJ1toAdG1iPS2Z6GkomvwZebUOiZbKGqB5p1BJsVzwJokcCo8NAv84dZhoqIF6UuTM
	X1ZXJwJchtIUPUCgUhC1aAK84AZKSn2GjQASKlEU4MB5AJCHf/eYIWuQUgdkdhU/diHZCP
	1fGtdHcMm7s1ajnernfdkMLaoxmJMjw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9sOVsMtaZ9n02MZ@google.com>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319180643.GC1876369@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> On Wed, Mar 19, 2025 at 05:16:02PM +0000, Yosry Ahmed wrote:
> > @@ -365,9 +352,8 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
> >  void cgroup_rstat_flush_hold(struct cgroup *cgrp)
> >  	__acquires(&cgroup_rstat_lock)
> >  {
> > -	might_sleep();
> > +	cgroup_rstat_flush(cgrp);
> >  	__cgroup_rstat_lock(cgrp, -1);
> > -	cgroup_rstat_flush_locked(cgrp);
> >  }
> 
> Might as well remove cgroup_rstat_flush_hold/release entirely? There
> are no external users, and the concept seems moot when the lock is
> dropped per default. cgroup_base_stat_cputime_show() can open-code the
> lock/unlock to stabilize the counts while reading.
 
Yeah I missed the fact that the users are internal because the functions
are not static. I also don't see the point of keeping them.

Tejun/Greg, should I send a patch on top of this one or do you prefer
sending a new version?


> (btw, why do we not have any locking around the root stats in
> cgroup_base_stat_cputime_show()? There isn't anything preventing a
> reader from seeing all zeroes if another reader runs the memset() on
> cgrp->bstat, is there? Or double times...)


(I think root_cgroup_cputime() operates on a stack allocated bstat, not
cgrp->bstat)

