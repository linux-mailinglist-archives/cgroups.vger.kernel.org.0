Return-Path: <cgroups+bounces-7602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20215A90B28
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D105A4738
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5989A21ABAA;
	Wed, 16 Apr 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua092Kur"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986F21147A
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827294; cv=none; b=P/beTmW5zS+tTYhtUY6ii6NrDM5GfRQ7kZDVx0TErmMjLODVMZS3XBy3nYUQrsVexxHE3tZTXVT2KPBRSsBcoKt2lX+Lal1BmnrnJiJxtQbbwo6Xp0K6IkjnvoClnO8YzYqgdSI5mVPV1sTVSiO6hP4SfXIe7iLOJrMw5PnolFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827294; c=relaxed/simple;
	bh=2ERSk5gLUMBQhHX8zmqOzbkGspPjBe55p8jfmD2CgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2/QQS5GTi3xzEQ2Ti1RepoSqrv462Yuv/knYS1k3FFDr0e9njuazcUGWjOzhdz6vkiRu76Y25t4qwgQCrSu7Jl2HFK3UfSIRO+K5cN/fdJ/hVfkb6fqObEU3Q1UFApHqaN8Xp+8QkNvlZ3den7oSrJQsq7N0dH/Ju2cXiUlt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua092Kur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AF0C4CEE2;
	Wed, 16 Apr 2025 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744827292;
	bh=2ERSk5gLUMBQhHX8zmqOzbkGspPjBe55p8jfmD2CgZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua092KurcynR43dGLaZ/Xyqm/Z247RRN7DBkY1o0tiS+zoaN/2Fv22HDc5m26CrZE
	 u4gBV8r6VRGzBZ74qXIyv5k10kom656SZRD5pt9sjfzbqHZCms1YfppEcx4XytlG4w
	 ujuyS0pCpE5TNwP5QHWHSLIPpFnRttvRyko3XyG7eO7g5EGxpTkElThLqTFv97UrWB
	 ZwVdKoUSj+fGuyn0yA0nUEUDaeolf8ZGILcx/kBnJynYfon9X8WCzl6+tZpWhlVikQ
	 pDO36X3nJsz65DQpmTrOo/iPHECFQYxLaTY6Rhp//LvPQMLhY5GmgnlnwjE4c9kggl
	 nZ8Nx9OWV7Oyw==
Date: Wed, 16 Apr 2025 08:14:51 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	shakeel.butt@linux.dev, yosryahmed@google.com, hannes@cmpxchg.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <Z__zm-dTbQPMuSgq@slm.duckdns.org>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
 <Z_6z2-qqLI7dbl8h@slm.duckdns.org>
 <gmhy3l3dlywtytmnwl3yegwf46hshshavknurjtzyruvfysp5x@4y4axheathhx>
 <6409c074-501f-4fe4-826d-5d5004735f00@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6409c074-501f-4fe4-826d-5d5004735f00@gmail.com>

On Wed, Apr 16, 2025 at 11:10:20AM -0700, JP Kobryn wrote:
> On 4/16/25 2:50 AM, Michal Koutný wrote:
> > On Tue, Apr 15, 2025 at 09:30:35AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > I don't know whether this is a controversial opinion but I personally would
> > > prefer to not have __acquires/__releases() notations at all.
> > 
> > Thanks for pointing it out.
> > 
> > > They add unverifiable clutter
> > 
> > IIUC, `make C=1` should verify them but they're admittedly in more sorry
> > state than selftests.
> > 
> > > and don't really add anything valuable on top of lockdep.
> > 
> > I also find lockdep macros better at documenting (cf `__releases(lock)
> > __acquires(lock)` annotations) and more functional (part of running
> > other tests with lockdep).
> > 
> > So I'd say cleanup with review of lockdep annotations is not a bad
> > (separate) idea.
> 
> Maybe we can keep these intact for now while updating the text within
> to something more specific like Michal is suggesting?
> 
> Tejun, let us know if you have a strong feeling on removing them at
> this point.

No strong feelings. No need to churn for it.

Thanks.

-- 
tejun

