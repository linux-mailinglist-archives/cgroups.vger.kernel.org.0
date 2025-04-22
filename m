Return-Path: <cgroups+bounces-7692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324BA95A13
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 02:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C99F174973
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8329712E7E;
	Tue, 22 Apr 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tw9+yQZZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CA2F2E
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280985; cv=none; b=Kg8SrllThUk1fFG46a5U4MG1Sffd18aaCEEVCXjaXuiCbK+xnLoAlBYGhBLsnNJwDykuoSh1Ei699yWp7NxoV6lfqoWeRiyy5WIvdedBNhvEh9SUD0R7UjboFftlVbdgJYEev4NNEKpUT1jNEFd2JXPVccxdpiVPh7T8TcWDnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280985; c=relaxed/simple;
	bh=7L50QVG2uKi53FRnC9wV3KNzRZjEwxKphCt0l9NBvkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxlj75PLiiZE1RnQHCDZB65+AttEKbhStNUuF3WKYVoHWd8DP9xlM01lVvcLzVO3f7T/tFhzIZNqvgzPrkxHeNXxCXeUYQWxpEnJxtEBFcTUU2A6nmojCn9urc/zK47I5US7wie4o/RxfNcuZw3h7dBeMD2YiFvmhu5VVoHzXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tw9+yQZZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 17:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745280971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kltmpeeeQXYojmYSTMp3YORACo5B4JEzEwh7/cdoB9c=;
	b=Tw9+yQZZVktLYL5BVwsAnRNmcYOKnInrbY4CI5zP1kWJRz1smRHRQsnVzxT9wBXOmcVGuZ
	p5qxbOfY9ZLUnr9SurDwYWYWGmrTJEYzcxM61XmcMIY9s/4e7PsjgLxl/C0yJ3FeEsj1xb
	hI2eDep1wKW+wIsipcIEvF+TVapALrw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Waiman Long <llong@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <zkxyks2csfnpjy7x5zaxvros3vtz32q7gftimynraamxzaoosb@ypilp6ds32qg>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
 <3478a69d-b4e9-4561-a09a-d64397ced130@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3478a69d-b4e9-4561-a09a-d64397ced130@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 08:10:41PM -0400, Waiman Long wrote:
> On 4/21/25 7:15 PM, Shakeel Butt wrote:
> > On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
> > > On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
> > > > On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> > > > > On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > > > > > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > > > > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > > > > > +{
> > > > > > > +	struct cgroup_subsys_state *css;
> > > > > > > +	unsigned long flags;
> > > > > > > +	struct cpuset *cs;
> > > > > > > +	bool allowed;
> > > > > > > +
> > > > > > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > > > > > +	if (!css)
> > > > > > > +		return true;
> > > > > > > +
> > > > > > > +	cs = container_of(css, struct cpuset, css);
> > > > > > > +	spin_lock_irqsave(&callback_lock, flags);
> > > > > > Do we really need callback_lock here? We are not modifying and I am
> > > > > > wondering if simple rcu read lock is enough here (similar to
> > > > > > update_nodemasks_hier() where parent's effective_mems is accessed within
> > > > > > rcu read lock).
> > > > > The callback_lock is required to ensure the stability of the effective_mems
> > > > > which may be in the process of being changed if not taken.
> > > > Stability in what sense? effective_mems will not get freed under us
> > > > here or is there a chance for corrupted read here? node_isset() and
> > > > nodes_empty() seems atomic. What's the worst that can happen without
> > > > callback_lock?
> > > Fairly sure nodes_empty is not atomic, it's a bitmap search.
> > For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
> > smaller than 64 in all the archs.
> 
> RHEL sets MAX_NUMNODES to 1024 for x86_64. So it is not really atomic for
> some distros. In reality, it is rare to have a system with more than 64
> nodes (nr_node_ids <= 64). So it can be considered atomic in most cases.

Thanks for the explanation.

> 
> 
> > 
> > Anyways I am hoping that we can avoid taking a global lock in reclaim
> > path which will become a source of contention for memory pressure
> > situations.
> 
> It is a valid conern. I will not oppose to checking effective_mems without
> taking the callback_lock, but we will have to take rcu_read_lock to make
> sure that the cpuset structure won't go away and clearly document that this
> is an exceptional case as it is against our usual rule and the check may be
> incorrect in some rare cases.

Oh this function is doing cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys)
i.e. taking a reference on cpuset, so with rcu_read_lock, we can avoid
that as well.


