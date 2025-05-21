Return-Path: <cgroups+bounces-8290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5BABFC15
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805934E3828
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66276264F9D;
	Wed, 21 May 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOW1dKcU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E701A288;
	Wed, 21 May 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847670; cv=none; b=V4BHnmOkBufb/Gxr7djzIrH5pApoI9JpamgHKFdNS+wFOGBcNnPhMerGJpdDPXre7TBZvap2Tj3eSHn12DEJMvrMrAWSQUFjT6/yBfLMtLpqR2Zwdf9Jiy6WEBjC3cE642FJt/GMTNPOk9sW8n/dxfwl5qa1g9Iu28/SPzE6nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847670; c=relaxed/simple;
	bh=RigXieu3Efy9tDkmzkivNBDaPQsEBF1Ay8aFp3bZls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgtISp7OHeNzTXaanuRPSQwHOpDml3lOB/NnHRCR24sSeDpSjpO4nb0Tk3RXKyCgdZJjDXgQbJKarrAkaJq4R3DOBmSmMFjmo4b9bREKDFkDsCxdwRFbgaPLi482HYWI3jztJ+h2OwfOrkwq2B5vKtxw9zxrVafdfYjU9fH6sQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOW1dKcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D4EC4CEE4;
	Wed, 21 May 2025 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847669;
	bh=RigXieu3Efy9tDkmzkivNBDaPQsEBF1Ay8aFp3bZls4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOW1dKcUbMh76xghkD6PgvOpYe80jVf9dQzGv4rRIzcXvG+d2Pzfc+5zjzmEf+jbE
	 PQ0MsRbeh99aqEJbgpQGGE1D1XSb937L1XrJrU9WzVT0YoDGEuQFaTPvHhWbqgclJW
	 wxg9yCP9p3F4CjIgbczyHfe88Rb0Jbt5d63crh+zTIZ+yvYRnu14E8kThYHrbky8NV
	 lqriSfEo8VTT2td0fTeqfEjJBc02MWINxxiJI/lLBHLHtBZBSbz3ogElC1O90qldbt
	 NyPkl3dFYvKRw2B9pSf9vpz6viDqpzgmszRlm9ijiWpnD1g+ESNk+zEg5zJ3seKHFt
	 lRNLOtV7sHduA==
Date: Wed, 21 May 2025 07:14:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <aC4J9HDo2LKXYG6l@slm.duckdns.org>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>

On Wed, May 21, 2025 at 10:35:57AM +0800, Zhongkun He wrote:
> On Tue, May 20, 2025 at 9:35 PM Waiman Long <llong@redhat.com> wrote:
> >
> > On 5/19/25 11:15 PM, Zhongkun He wrote:
> > > Setting the cpuset.mems in cgroup v2 can trigger memory
> > > migrate in cpuset. This behavior is fine for newly created
> > > cgroups but it can cause issues for the existing cgroups.
> > > In our scenario, modifying the cpuset.mems setting during
> > > peak times frequently leads to noticeable service latency
> > > or stuttering.
> > >
> > > It is important to have a consistent set of behavior for
> > > both cpus and memory. But it does cause issues at times,
> > > so we would hope to have a flexible option.
> > >
> > > This idea is from the non-blocking limit setting option in
> > > memory control.
> > >
> > > https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux.dev/
> > >
> > > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > > ---
> > >   Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> > >   kernel/cgroup/cpuset.c                  | 11 +++++++++++
> > >   2 files changed, 18 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 1a16ce68a4d7..d9e8e2a770af 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -2408,6 +2408,13 @@ Cpuset Interface Files
> > >       a need to change "cpuset.mems" with active tasks, it shouldn't
> > >       be done frequently.
> > >
> > > +     If cpuset.mems is opened with O_NONBLOCK then the migration is
> > > +     bypassed. This is useful for admin processes that need to adjust
> > > +     the cpuset.mems dynamically without blocking. However, there is
> > > +     a risk that previously allocated pages are not within the new
> > > +     cpuset.mems range, which may be altered by move_pages syscall or
> > > +     numa_balance.

I don't think this is a good idea. O_NONBLOCK means "don't wait", not "skip
this".

Thanks.

-- 
tejun

