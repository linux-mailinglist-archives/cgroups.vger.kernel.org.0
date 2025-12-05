Return-Path: <cgroups+bounces-12279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DACA8B7C
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D217D3014408
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC82D6E4D;
	Fri,  5 Dec 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o3mRSowa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB42BDC29
	for <cgroups@vger.kernel.org>; Fri,  5 Dec 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957590; cv=none; b=dAKM8xMkqV/2+qag5XDxF0QfKUOuwvFwzwSJotYnCbbJBVs//WydKpUndFD0+sAOfLFY4sSyhKGe6AtEa8NqdhaVgmg+RL6z0gqhXZH6IXs3aG4P0hmJCkNshq65Jg/UNloCWcnjs+41rIYdTYVvZX7k665ry2rphpZs/qZVmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957590; c=relaxed/simple;
	bh=k7QSshx+cWMS8h2GwUMJu+mTf4KumoVbve6g8/R23ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsR3cczE0wzVqeR/SvIbjeVSHqDHZLCB4aar1aIxijU1uWeLd84ksopQxTVSpn/eLXug7YYrG++UOoKTr21P2CBBFfikBpUNd+GAEHVX2oavJbO+Kkpie3JfYDcVx9l5+TOoNqjNeAyYKiZDBEN88OBi+/JM2xjCvoFzxBBgTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o3mRSowa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Dec 2025 09:59:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764957585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZga2sY8Qmp2/WVvb8+m7PCG2wK/ft532jEwDd9YS1c=;
	b=o3mRSowaEdnSqTNDv/GCctEwZbze+Cp/dEg7ya4Hd5Y+PSfzxt0U+zKHu+prOtywXzZKwy
	CCI3/HlzDm+W/lUONFsJiNus+r8Pe2ZHpqSsmAYElGF1kSIHNogLu78kM8RBXuuS4follI
	RTOr22Hcutbcv9fLZCvM7haoxvcrFkk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <5i4ei2rbszdwlezpi63h5ksmckry27ffx6kfcg74qbvgjk22ao@2y2jeadg43y3>
References: <20251205022437.1743547-1-shakeel.butt@linux.dev>
 <aTMX4tycdzKlaqaH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTMX4tycdzKlaqaH@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 05, 2025 at 07:35:30AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Dec 04, 2025 at 06:24:37PM -0800, Shakeel Butt wrote:
> ...
> > In Meta's fleet running the kernel with the commit 36df6e3dbd7e, we are
> > observing on some machines the memcg stats are getting skewed by more
> > than the actual memory on the system. On close inspection, we noticed
> > that lockless node for a workload for specific CPU was in the bad state
> > and thus all the updates on that CPU for that cgroup was being lost. At
> > the moment, we are not sure if this CMPXCHG without LOCK is the cause of
> > that but this needs to be fixed irrespective.
> 
> Is there a plausible theory of events that can explain the skew with the use
> of this_cpu_cmpxchg()? lnode.next being set to self but this_cpu_cmpxchg()
> returning something else? It may be useful to write a targeted repro for the
> particular combination - this_cpu_cmpxchg() vs. remote NULL clearing and see
> whether this_cpu_cmpxchg() can return a value that doesn't agree with what
> gets written in the memory.

Yes, I am working on creating a repro for this and will share the
results.

> 
> > @@ -113,9 +112,8 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
> >  	 * successful and the winner will eventually add the per-cpu lnode to
> >  	 * the llist.
> >  	 */
> > -	self = &rstatc->lnode;
> > -	rstatc_pcpu = css->rstat_cpu;
> > -	if (this_cpu_cmpxchg(rstatc_pcpu->lnode.next, self, NULL) != self)
> > +	expected = &rstatc->lnode;
> > +	if (!try_cmpxchg(&rstatc->lnode.next, &expected, NULL))
> 
> Given that this is a relatively cold path, I don't see a problem with using
> locked op here even if this wasn't necessarily the culprit; however, can you
> please update the comment right above accordingly and explain why the locked
> op is used? After this patch, the commend and code disagree.

Thanks and yes I will update the comment in the next version.

