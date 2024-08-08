Return-Path: <cgroups+bounces-4171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481094B656
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 07:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7AA286347
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0B18133F;
	Thu,  8 Aug 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ENr4EcDJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878762A02
	for <cgroups@vger.kernel.org>; Thu,  8 Aug 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096030; cv=none; b=vEXjfsnuGynbgCK0+PeibVi8NlzNUq3JubKgQMbcggM/iTOoAxJkLXtoqesrf+ERBdyVWLhhLNC41jcP6zWOe1gx7WPQX7fVMPKrHjF7X1ayP1MRed2xSwCWWEzUdcIZEPjmW7U7mxZXkPDrgwhwk9C23MqQkaAYKRK0g3hfMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096030; c=relaxed/simple;
	bh=mYzK2qmGJmBQgUCud/GSsYc9jyCsG+LQw45kxZ+OFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG8sjWEVe7CRp3Ol51v8cYMSr+2RBPGopkOIVLsgqX4UUg0gbUF5vXa035KIlqlDqX2NWboGuNKF78VMmvTcBTSnlU0seRQIX4Xai/YTwoPJ05u+H0TqaDTzv2H+jY2xW/aHcWM+AN0DUUxW72m7CnqNUEQLDQIoeDjITQt3fCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ENr4EcDJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Aug 2024 22:46:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723096025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2/TZxJ/7ZFO1z4dz0iQcMYz/Zcm7hyIlihqc22yaag=;
	b=ENr4EcDJzJPFyLv3lfEWK5D9KQCUzTBNdGnCu8sq2WuQQgpcmjm6XxTF0qxjEtrOA1skoY
	1SLzQPo9Z0gl+cqcijP2IE/l3sYvbR7aywcqlsAngwslFLskJ4XLF85TDAbW1pQcSKIwUF
	PgaIwfzfpKCxS83lI/xRPDTaVtgCeQA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <j3iziqvqi6tgnv2gzdggq67iheiytkrhsnjuqj4ez7qdwv2hjz@l55uz3fmtp4o>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
 <ZrRBkVu8QrDOBOgs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrRBkVu8QrDOBOgs@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 08, 2024 at 04:54:57AM GMT, Matthew Wilcox wrote:
> On Fri, Aug 02, 2024 at 04:58:22PM -0700, Shakeel Butt wrote:
> >  #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
> >  static DEFINE_IDR(mem_cgroup_idr);
> > +static DEFINE_SPINLOCK(memcg_idr_lock);
> > +
> > +static int mem_cgroup_alloc_id(void)
> > +{
> > +	int ret;
> > +
> > +	idr_preload(GFP_KERNEL);
> > +	spin_lock(&memcg_idr_lock);
> > +	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
> > +			GFP_NOWAIT);
> > +	spin_unlock(&memcg_idr_lock);
> > +	idr_preload_end();
> > +	return ret;
> > +}
> 
> You know, this works much better as an xarray:
> 
> static int mem_cgroup_alloc_id(void)
> {
> 	u32 id;
> 	int ret;
> 
> 	ret = xa_alloc(&mem_cgroup_ids, &id, XA_LIMIT(1, MEM_CGROUP_ID_MAX),
> 			GFP_KERNEL);
> 	if (ret < 0)
> 		return ret;
> 	return id;
> }
> 
> No messing around with preloading, the spinlock is built in and the MAX
> works the way you want it to.

Thanks. I would keep the current for the backports and change to xarray
from idr for next release. Please correct me if the following
alternatives are not correct.

1. You already mentioned idr_alloc() -> xa_alloc()
2. idr_remove() -> xa_erase()
3. idr_repalce() -> xa_cmpxchg()

thanks,
Shakeel

