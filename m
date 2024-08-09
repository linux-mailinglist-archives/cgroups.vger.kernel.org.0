Return-Path: <cgroups+bounces-4187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FB094D7D7
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 22:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249001C21528
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7771607BF;
	Fri,  9 Aug 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPDT8Gse"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC01D551;
	Fri,  9 Aug 2024 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233984; cv=none; b=DB1aHbHyCtQ1aZxepeztgJJOnS64hJAeL3khjMvlwniOTBuwwkAJ4FHsoi/0r81V1HGN/+ZSBJpd9maqAZrdwcLmwJz0jwRwIrlJUt6VRT9fzgQFFrxcukMbZpWy3kcsdlXQuRNJPzxSxb7/29emuUmovvM111OZuX6s1OeLffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233984; c=relaxed/simple;
	bh=mJdzdK8m5noSq0toiPWF7HbNribzPwd6/Nm7+l+vt8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfmCphRbJnmU7F9G3t22Ehm+q8wPjz3S1CDacW5veLNqTK1z+AdI7dC4IYVj+faUMnP625zF13DE0sMCbh+D0JRKIYREO8IU2iFl05eRs7uvTqvcINXJ0Vo+iAw8EcYfCs86woZR+yYTqzioItGySWvyQTfhktGeWqI3vyTMyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gPDT8Gse; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dGa/8ZLokAbzEb+tPZ9uqejoZTdxPyVA0LUvs3W+vgQ=; b=gPDT8GseHd3nE2TMAodTAnIf5z
	HwKGNyCeucouDI8j0QOvSlHeQ61R2p6udfKuIvrmZRxOGphLXqFBffnj9CDP3icU7fLaUY7KW6JUD
	EEsr9PcVEvNLrBbpQIDHsrfybinmJOPPTQFsnZpON6htk8HnOfCkgKexF0WCXkk6Q7k0ShcljHE+3
	8apRgvM9iLPQmINmzZf6WyyjLIN+ubmqS+1YaIA/J5nzAHgxtBoHWR7WnMuJoNWJR3PIduHGxoc6a
	EtWTkaFud/KB09W+ET/IZGeVVFlzeFj92D8GLSOKM/jlvl0ZwZc7wg9L08OyHBspf8YLt2dQyK6lx
	LGVAlcRg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scVsF-0000000B6dr-34eA;
	Fri, 09 Aug 2024 20:06:07 +0000
Date: Fri, 9 Aug 2024 21:06:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
Message-ID: <ZrZ2r_8RAjtYVkmG@casper.infradead.org>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>

On Fri, Aug 09, 2024 at 10:26:18AM -0700, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Looks great.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

