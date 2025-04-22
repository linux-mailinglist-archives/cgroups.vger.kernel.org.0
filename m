Return-Path: <cgroups+bounces-7711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33690A967F4
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF751188A4A1
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634B274FD0;
	Tue, 22 Apr 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OrJ4b/Ry"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374A2AEE9
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322092; cv=none; b=d3hNMJ8LACESWstIhyDREO88kdVU+8BGfLy3tSDQp2N7UxPf4bNWTc4zaF5UmNFKLvAIu+FJS7VsigeDoHCNhDRKwt4J7VwNJwNBLuTzRhv3vSnmXsfVZjLWf9svatsmwJXwFL2eS00tCnfYS1QI+eYb1ZwDIcRrSjLWxs5dPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322092; c=relaxed/simple;
	bh=Z0xoBCce+obPuklML8DLSrfIsk7iPcapdXWIqrL45pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR814nj0C7ruqBNBIaYQCjjvK7TPIcReIFuwJUxbTYvDu4mwzCSeuzEp0dHSuucDhs0akXp07C7Qn8szLYkh2qmOx/eBMJS933L2BcWaIVc+wXhUUN6Bmp1l5FW4c1odDUHbDNPVurBiWQG/63mpvgzWpjk2u+l8HY7fW2FurVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OrJ4b/Ry; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 04:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745322078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGjfUa0VdFNE7pAhfj1k3sXWx23PmVKsC+WEqb2v1XU=;
	b=OrJ4b/RydEPGLVaiWvtAx95vFvpu/zp46RuMAmWS9/Cr+90MRK1LqVWwpdv/Hz+Mt82UTo
	trAATCdjYc4rBJ3UmmsIKTRGqbBcib7sjLJG2PWf19npjz+4cbk+5UFlL72k1dEN3aJHDt
	ggPkHh9W7H6TCuUS83qhIBmwtwMDZmI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Waiman Long <llong@redhat.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: optimize memcg_rstat_updated
Message-ID: <aAeAWVeLJT9bygA3@Asmaa.>
References: <20250410025752.92159-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410025752.92159-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 09, 2025 at 07:57:52PM -0700, Shakeel Butt wrote:
> Currently the kernel maintains the stats updates per-memcg which is
> needed to implement stats flushing threshold. On the update side, the
> update is added to the per-cpu per-memcg update of the given memcg and
> all of its ancestors. However when the given memcg has passed the
> flushing threshold, all of its ancestors should have passed the
> threshold as well. There is no need to traverse up the memcg tree to
> maintain the stats updates.

Nice. We also skip updating the per-CPU stats updates counter, which is
unnecessary in this case as well.

> 
> Perf profile collected from our fleet shows that memcg_rstat_updated is
> one of the most expensive memcg function i.e. a lot of cumulative CPU
> is being spent on it. So, even small micro optimizations matter a lot.
> This patch is microbenchmarked with multiple instances of netperf on a
> single machine with locally running netserver and we see couple of
> percentage of improvement.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

