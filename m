Return-Path: <cgroups+bounces-10375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1BB93A92
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 02:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD44716B3C5
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14C3BB48;
	Tue, 23 Sep 2025 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbi9ITEc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D328FD
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585656; cv=none; b=ZFy2nIEEAge92cvcC0ZnrO4Yqx5LQGFo8jYYrllEJ71eaeLPa1G9jB6Q3/2aosxYqcchx5DY6ZuhtfZVy4NsIWiZAe62ZA5MrWiyypszpX9H1FyZNFiBqp7UZxakb1zWun4hXgMjFZOOqsdHEnRhsYZmEsLd1J3x41Mdnfg0of8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585656; c=relaxed/simple;
	bh=Iuj3ujrNKyTx8OvoiktIH9vvg+ZikwuYukI5bLzJ5hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnSKRulZ5I7XrrpC5o90CeTz9p/LodTGxtojxMnFKzmRArSeZLmQX/BhJ8xLNpyk4aAsYhRoocfgCJUj1WvJUe06/rGpw/yaLTErb6CJWowcOf5JLq8REKUkN4oTXwvQChXXFOnWwAV8ByixcGcS/1tM5PyHWzEkrjJbOacYOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbi9ITEc; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 17:00:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758585652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCni9d/eLTgrwvyJGOCo83l5nU1UneMhuwcVyu2h7ZU=;
	b=nbi9ITEca9rnd1tCCtP0aY+2jP9DfRuQMRhbjpXws3XvI9iUVKTjrzdZQoaHsMVQmiVlyB
	QswcSVIRWORB4DTVq21V9uuCChILFasgsvPjCHjwUeTdVPMZtSM0nIm1k/tUTzHVpF0Jft
	bOxd5Ys5tT3QGW6ugPwD/FNxVmVWlIQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-ID: <24cnhpqz7d6rnkyowfmlgbcx6mt3qaztsxfwgtwafnktbeikya@bex2bp33mub6>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
 <20250922160443.f48bb14e2d055e6e954cd874@linux-foundation.org>
 <552lz3qxc3z45r446rfndi7gx6nsht5iuhrhaszljofka2zrfs@odxfnm2blgdd>
 <20250922165509.3fe07892054bb9e149e7cc06@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922165509.3fe07892054bb9e149e7cc06@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 04:55:09PM -0700, Andrew Morton wrote:
> On Mon, 22 Sep 2025 16:39:53 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > On Mon, Sep 22, 2025 at 04:04:43PM -0700, Andrew Morton wrote:
> > > On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > 
> > > > Generally memcg charging is allowed from all the contexts including NMI
> > > > where even spinning on spinlock can cause locking issues. However one
> > > > call chain was missed during the addition of memcg charging from any
> > > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > > cgroup_file_notify().
> > > > 
> > > > The possible function call tree under cgroup_file_notify() can acquire
> > > > many different spin locks in spinning mode. Some of them are
> > > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > > just skip cgroup_file_notify() from memcg charging if the context does
> > > > not allow spinning.
> > > > 
> > > > Alternative approach was also explored where instead of skipping
> > > > cgroup_file_notify(), we defer the memcg event processing to irq_work
> > > > [1]. However it adds complexity and it was decided to keep things simple
> > > > until we need more memcg events with !allow_spinning requirement.
> > > > 
> > > > Link: https://lore.kernel.org/all/5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd/ [1]
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Fixes a possible kernel deadlock, yes?
> > > 
> > > Is a cc:stable appropriate and can we identify a Fixes: target?
> > > 
> > > Thanks.
> > > 
> > > (Did it ever generate lockdep warnings?)
> > 
> > The report is here:
> > https://lore.kernel.org/all/20250905061919.439648-1-yepeilin@google.com/
> > 
> > I am not sure about the Fixes tag though or more like which one to put
> > in the Fixes as we recently started supporting memcg charging for NMI
> > context or allowing bpf programs to do memcg charged allocations in
> > recursive context (see the above report for this recursive call chain).
> > There is no single commit which can be blamed here.
> 
> I tend to view the Fixes: as us suggesting which kernel versions should
> be patched.  I'm suspecting that's 6.16+, so using the final relevant
> patch in that release as a Fixes: target would work.
> 

Sounds good. Let use the following.

Fixes: 3ac4638a734a ("memcg: make memcg_rstat_updated nmi safe")

