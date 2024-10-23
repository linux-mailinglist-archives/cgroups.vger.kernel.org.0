Return-Path: <cgroups+bounces-5205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094BD9AD4F2
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE982282F8E
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECC1D1F51;
	Wed, 23 Oct 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbCPwqep"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948213BC11;
	Wed, 23 Oct 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712430; cv=none; b=f0LRVDevEEUO7e+Teilb0zFfITRvlEPvqrU0dX2Q/Gc55jXgZ4DEgjMm/g+ehP1UwMn8o3wtZyF8/SGyyX1O69OK/634gN9o9S5DRtxPmNnlchbV42KNQ1TH4tNhDy73/nI80kjBK6CbqRfoSsSQSizLshNt0tSGVrVwN7vJif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712430; c=relaxed/simple;
	bh=EzbjkPV90UV6QSJhV+s0C5L6lHibDPt+fsO73VymlbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE8WLtrjwD0dWV5m0joak7tG1FmWdgFtoQrwM7WK6QzdcS8vRrx2ZuI3Npx9ZpbUq7f/yuoU4pX9sdJpxFl8X/RV6z9AUS9l6IN9GFTm3FDnad7wWAAsjRjaEg67nl6Og8RX6pOW7XBlOtuZ4rCbgM1WbHv5oPknP0BiWlugq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbCPwqep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CEBC4CEC6;
	Wed, 23 Oct 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729712430;
	bh=EzbjkPV90UV6QSJhV+s0C5L6lHibDPt+fsO73VymlbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbCPwqepSOehGxvj4gxImQczmfNz6ssonAwXnbbgdnyvPL/xrQiub53FEqxdCV80o
	 DkG/ZkcumVc7HGvXQg1oCnjbO0fWI1cd9oekU3fUc8kUzkzALUdJzLJ1xSKOLAx5Uy
	 SWOtIgR5BVQfUCpaOvtXh1InOxF1+VyPK6f/2jal2UlIWa6sq9RBOIChEiAQRs+NDb
	 0rA3fu8lV6jjh/VEGsfd1lOoV3ucJvs4gS7seWhJ8SfPlRpA3LfeFhT8KchgCW/aOC
	 NwZPM5I45elC7TC3Wy8ZnOueGG9M7xLkcJJc3flG57bViAFasvRZfxtIS1+cqq3BHO
	 /S6imokpMEAkQ==
Date: Wed, 23 Oct 2024 09:40:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <ZxlRLMwkabTaOrjc@slm.duckdns.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>

Hello,

On Wed, Oct 23, 2024 at 09:52:53AM +0200, Maarten Lankhorst wrote:
> New submission!
> I've added documentation for each call, and integrated the renaming from
> drm cgroup to dev cgroup, based on maxime ripard's work.
> 
> Maxime has been testing this with dma-buf heaps and v4l2 too, and it seems to work.
> In the initial submission, I've decided to only add the smallest enablement possible,
> to have less chance of breaking things.
> 
> The API has been changed slightly, from "$name region.$regionname=$limit" in a file called
> dev.min/low/max to "$subsystem/$name $regionname=$limit" in a file called dev.region.min/low/max.
> 
> This hopefully allows us to perhaps extend the API later on with the possibility to
> set scheduler weights on the device, like in
> 
> https://blogs.igalia.com/tursulin/drm-scheduling-cgroup-controller/
> 
> Maarten Lankhorst (5):
>   kernel/cgroup: Add "dev" memory accounting cgroup

Yeah, let's not use "dev" name for this. As Waiman pointed out, it conflicts
with the devices controller from cgroup1. While cgroup1 is mostly
deprecated, the same features are provided through BPF in systemd using the
same terminologies, so this is going to be really confusing.

What happened with Tvrtko's weighted implementation? I've seen many proposed
patchsets in this area but as far as I could see none could establish
consensus among GPU crowd and that's one of the reasons why nothing ever
landed. Is the aim of this patchset establishing such consensus?

If reaching consensus doesn't seem feasible in a predictable timeframe, my
suggesstion is just extending the misc controller. If the only way forward
here is fragmented vendor(s)-specific implementations, let's throw them into
the misc controller.

Thanks.

-- 
tejun

