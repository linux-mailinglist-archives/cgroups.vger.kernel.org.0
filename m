Return-Path: <cgroups+bounces-7680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB54A95561
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 19:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862AD188FBEE
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63A1E7C11;
	Mon, 21 Apr 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhMeyPXf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478E1E7C23
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257208; cv=none; b=syuJlFaK1G+8Bzy1rxVMfoJ+e24LM5nHRQ1/tIunTH2ca2z60eT23XfARleKq3aK8EugO+zTqLhkJ9iaWu/ec5oAW318eHlLFOPvAf6O3bQeGhjU7TdZksU3qFCGGmVIdtPO+bMHGhp6DUGoQPn3pJDboikNXVtMOWDDUv6J+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257208; c=relaxed/simple;
	bh=useqJap+ezRoHVTkg1sAXR5EWKTh9ETeAM945golY8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqTWp88a5Q9dus0xvDa5Go29VmSzdYbbzJjaD5zDvL327wgIPypfHYKcNpUMk+11DMvMxoFJKqF6PLvJqbjgoamBBmXchTBx4lZbpLHed9YxiEx+zO3g+wJNIqZrtOYhpSzWwPf8E3yEESPXQQnVk5MFAfj8apILheXoliY5qGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhMeyPXf; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 10:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745257203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ic0U5IhV6YzKvNqJCWbnzKQPn3EXM2vY2FdYHIFi4Do=;
	b=nhMeyPXfb/xhlGRDoRZa/FULAGL/+tgPjy7ix20MhqCwjvxqpwRtbHeugUorGOKVbJZH+v
	JMSDGVHWrMHtvM6rRnEcqj/8QmZVRqo09RbMoynz/TcmZMjTZ8vUatAPqFG6d5xJ/DJ/P2
	j6oY4ngT20gFuZsRBQEvNYigZLeoGQs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Waiman Long <llong@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> 
> On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > +{
> > > +	struct cgroup_subsys_state *css;
> > > +	unsigned long flags;
> > > +	struct cpuset *cs;
> > > +	bool allowed;
> > > +
> > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > +	if (!css)
> > > +		return true;
> > > +
> > > +	cs = container_of(css, struct cpuset, css);
> > > +	spin_lock_irqsave(&callback_lock, flags);
> > Do we really need callback_lock here? We are not modifying and I am
> > wondering if simple rcu read lock is enough here (similar to
> > update_nodemasks_hier() where parent's effective_mems is accessed within
> > rcu read lock).
> 
> The callback_lock is required to ensure the stability of the effective_mems
> which may be in the process of being changed if not taken.

Stability in what sense? effective_mems will not get freed under us
here or is there a chance for corrupted read here? node_isset() and
nodes_empty() seems atomic. What's the worst that can happen without
callback_lock?


