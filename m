Return-Path: <cgroups+bounces-4877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B897864B
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07EBB21FC7
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F716811F1;
	Fri, 13 Sep 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TX2SlihM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D76BFA3
	for <cgroups@vger.kernel.org>; Fri, 13 Sep 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246716; cv=none; b=reLX+j+nulancJZnoXsjVU3rGXqwghpwTHm9GxKLdLDFuVym1CPbwxcZMuLmyAShAHZWxFrcq+qkUnuyODZ4Tp6LA92s/l71jPPXTXRLZD+DPIgGg/VzSWQsxPpErNBoFwUOhGTTRfDmz4XkotrAaU4TUcD+eZJ6bjdjTzJ3frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246716; c=relaxed/simple;
	bh=s6js11SGlzM0KOLSKZk3M20pwu1yi2EIiBYKKMBg+1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0ffgUHa1oMikuXaz84SvOv4ugS3ZaarwglHpeI2TmIpJxkmOn7fDY1HD5W8QYlqe4xyLPCXhdddrF1PfqcGXyWOHvG/v8cOYLujRZSw972YuFIRJ1ZYirUimEJq0ULp+cGEQucdHUnWFaaGo9MY7mRkL1FI4Z4sIoPKy8ln6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TX2SlihM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Sep 2024 09:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726246712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6G5mMKC6xXn5CUvXE/ulqU9/kZwXpk5g17KcNxtbO38=;
	b=TX2SlihM1SEdJ9sQHg5KxZ/yV9N6GBhaa67Qk8E4pRlGH9eJOk5/ZDoyY4FPG9B5fSIZGr
	TCIcmStF17IMEd4+Iik6keHBXpY0k4wk0xy05/dd2mxzdfEqW6GFSbIenNCKOkqN3lVUGW
	Ay1pARFw5aXE3PURYjV1IGzRWd+HkYk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Message-ID: <idy4zi4d5xk2sk7qxczmkdnxw35bohr6o5exj6oeee4lipm3dk@pbw35acxapov>
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
 <e5k22kuavnli72v3lmeezrewut6hvhfdpteouj3ii6dmcdiiin@2e3dlbs4ahe2>
 <CAJqJ8ig2=UqSTemAEU_5Shtc_S=deEuHyq1fJ1QUi1PU=_8pCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqJ8ig2=UqSTemAEU_5Shtc_S=deEuHyq1fJ1QUi1PU=_8pCQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 13, 2024 at 04:05:51PM GMT, jingxiang zeng wrote:
> On Tue, 10 Sept 2024 at 15:10, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Aug 30, 2024 at 04:22:44PM GMT, Jingxiang Zeng wrote:
> > > From: Jingxiang Zeng <linuszeng@tencent.com>
> > >
> > > In proactive memory reclamation scenarios, it is necessary to
> > > estimate the pswpin and pswpout metrics of the cgroup to
> > > determine whether to continue reclaiming anonymous pages in
> > > the current batch. This patch will collect these metrics and
> > > expose them.
> >
> > Please explain a bit more on how these metrics will be used to make
> > a decision to continue to do proactive reclaim or not.
> 
> Currently there is simply no way to know exactly how many anon page
> was faulted in through SWAP for each cgroup. One may use
> workingset refault as an indicator but it is inaccurate due to shadow reclaim.
> 
> We have a proactive reclaim agent that sets a forced swappiness
> dynamically for each reclaim, so we can reclaim file or anon pages striclty.
> Knowing the anon page swapin status is a huge win for estimating the
> workload status.
> 
> And the swapout info is also important for getting an idea of how much
> swapout is effective for a cgroup.
> 

Please add all these details on your proactive reclaim agent in the
commit message. It would be beneficial to others doing proactive
reclaim.


