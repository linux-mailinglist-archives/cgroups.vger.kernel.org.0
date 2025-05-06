Return-Path: <cgroups+bounces-8029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4828AAB82F
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16090171064
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EF23AE66;
	Tue,  6 May 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zp+seyqp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9123D291
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491883; cv=none; b=bSEBJ7MHE+bG5rQTP8X0+s6qfQsSJ5RTCTeporn4NjzjhQtFI9YXkQofpuo1DlOIqeFEsEojjPerRVFs5oam/KjU0hvahgqEh2OBI3rXZL0Xi/ecK/p3OO4GZUkknB9RI2wTcah7uqSSAlUkL4V49DeVuNEXyOmlCpKOwnUHCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491883; c=relaxed/simple;
	bh=W1m4TUyX6YE2AfXcr0Dj6oaULHb2UhutAZWEsNC+pao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKqsmX24JYooX1MlxMPP2c3KRnCpRC6tDttZT/6WXVR5+RVRuMmeLeMcu13m/nUALbKb4KiQ3IRv8K/2LWhgIa+wtm2EfpCF/zsjc/uTlS0taVHRF1U0fnXGB+gq2TdVHj3iyyiyqzqZ1Pa5LK4yya3wS9Vn/AfzpG1KUwhpaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zp+seyqp; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 17:37:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746491876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M07/lP+pXzvLKJ6uRYjE6pVpy0jyE1Nr96MIfImu5yo=;
	b=Zp+seyqpmpxE6ZLjPBDYQUu3UlszR3XLBaWYn68BioqvHFuUitbsK5SpB+OVkUNtKKTAnp
	TW66J3b7O9mIVW1ddaY3Ekd7sKNTVesPbtjvZucLxh6MGdk/DeXoKxZtLMEJ1gUEuOTBho
	/LvH68sHxgYGAp4JbatDZkshM7WUIDI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, 
	christian.koenig@amd.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>, 
	simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <xa5d2zjyihtihuqu4zd63fqnwxwx57ss7rrfpiiubki3cxib25@kkgn26b2xcso>
References: <20250502034046.1625896-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502034046.1625896-1-airlied@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> Hey all,
> 
> This is my second attempt at adding the initial simple memcg/ttm
> integration.
> 
> This varies from the first attempt in two major ways:
> 
> 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> for pool memory, and directly hitting the GPU statistic,

Why was the first attempt abandoned? What was the issue with the above
approach?

> Waiman
> suggested I just do what the network socket stuff did, which looks
> simpler. So this adds two new memcg apis that wrap accounting.
> The pages no longer get assigned the memcg, it's owned by the
> larger BO object which makes more sense.

The issue with this approach is that this new stat is only exposed in
memcg. For networking, there are interfaces like /proc/net/sockstat and
/proc/net/protocols which expose system wide network memory usage. I
think we should expose this new "memory used by gpus" at the system
level possibly through /proc/meminfo.

> 
> 2. Christian suggested moving it up a layer to avoid the pool business,
> this was a bit tricky, since I want the gfp flags, but I think it only
> needs some of them and it should work. One other big difference is that
> I aligned it with the dmem interaction, where it tries to get space in
> the memcg before it has even allocated any pages,

I don't understand the memcg reference in the above statement. Dmem is a
separate cgroup controller orthogonal to memcg.

> I'm not 100% sure
> this is how things should be done, but it was easier, so please let 
> me know if it is wrong.
> 
> This still doesn't do anything with evictions except ignore them,
> and I've some follows up on the old thread to discuss more on them.
> 
> Dave.
> 

