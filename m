Return-Path: <cgroups+bounces-4169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD294B5AA
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 05:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B861C20D70
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3685FB9C;
	Thu,  8 Aug 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fb8NVz0y"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF707F484;
	Thu,  8 Aug 2024 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089304; cv=none; b=SIeGx1dYpA3Cu7ejs+a1HvA8xq4pvlggNoD41nbk4UySJBev7LRIoYIrY+FpB2dJyQGta48cwdlizUJ7lc3deYXfX99g5tb/mUyxkXUOYwke7V8zmnLGQJVL9wvtvbfnKNBAHi6bS5r5eB0uO5a6NTQu6xVB4/3WNfXssu0nq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089304; c=relaxed/simple;
	bh=Jt0xf7AxI4s7Fi7IoEWWpcFgBpMLkLgYiNLR//fD85E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykuiwc38UzYDhrsazH7VW1Npw4V+lDqxlnERFkLuG3cCtgJCGSWVaxojkWwfaxUPANfgRhXrHZKOyA9yTIAbL5LSIWa8zy12QNJipHN+fYSViRGP8UT0NKKKfLIEeAai57n4QSLE9CWQmrOhEQTmTzVS3xm2tllD+/18HygTTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fb8NVz0y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6q1FGMfI2KVEld5fCujSHWf4dHOR4tKUlx8SbJHfQSE=; b=Fb8NVz0ycYOEq9QTId37x+8Zc8
	VLCVzCSA+L++LK1nO/xA4+bq/rtLhCHk1LKbw1KciETfDFN8VDHjbev0Uo9Ag2W9+amrjC/cE2gX1
	BpHmV66EJgoA8Xb/e+axAW8J93Jt6oQdt7ahjCAZOuNc4h8aR8dRO4owLkPuSPsIFmjvyxhplNvL0
	PjAteG5fnSoIdIDL+PKY7gDtBZd11/geHqhakYpgTPRffsr0QHP+hvLqQfi/le1sdpxxiJwaWAxgY
	FOYEaIsODO0NvttBkarD52abeT5NnsW+0Gd6yJpHEPvEN4TNlVlQjVNaGACfxhHi65+le9jv0X4u7
	70y8LCTg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbuEr-00000008KNr-1Fjc;
	Thu, 08 Aug 2024 03:54:57 +0000
Date: Thu, 8 Aug 2024 04:54:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <ZrRBkVu8QrDOBOgs@casper.infradead.org>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802235822.1830976-1-shakeel.butt@linux.dev>

On Fri, Aug 02, 2024 at 04:58:22PM -0700, Shakeel Butt wrote:
>  #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
>  static DEFINE_IDR(mem_cgroup_idr);
> +static DEFINE_SPINLOCK(memcg_idr_lock);
> +
> +static int mem_cgroup_alloc_id(void)
> +{
> +	int ret;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&memcg_idr_lock);
> +	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
> +			GFP_NOWAIT);
> +	spin_unlock(&memcg_idr_lock);
> +	idr_preload_end();
> +	return ret;
> +}

You know, this works much better as an xarray:

static int mem_cgroup_alloc_id(void)
{
	u32 id;
	int ret;

	ret = xa_alloc(&mem_cgroup_ids, &id, XA_LIMIT(1, MEM_CGROUP_ID_MAX),
			GFP_KERNEL);
	if (ret < 0)
		return ret;
	return id;
}

No messing around with preloading, the spinlock is built in and the MAX
works the way you want it to.

