Return-Path: <cgroups+bounces-4313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74F953C6F
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 23:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD71C21D82
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEC14B97E;
	Thu, 15 Aug 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHqBFdpM"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C181AC8;
	Thu, 15 Aug 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756602; cv=none; b=ggH43C4o0rhxbNKTLwKzrlUI8WoS5hTfMC+t4F9X2PD+C/j4RadBJSxLVZ84D1jJhWDf+1zLIAuMw/SZGpZwabkWOlk0F7cFaVh+SP13vVq0WahdUYIqrVDAF/fa3smCQSis5HavjnHPrrVXatFx3ppJSC9UKFLCK+VZKer6/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756602; c=relaxed/simple;
	bh=PBA4Ln8lIjVagUzDRvfyQYRjlu83b2/CSeXAl5ZAL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njHJ7U70pjU7WGuGDijSR9sP4ZnSE2odoI8mRbL+Q27QF7oBrIedhnvl8497ew0+ZEkU4tMnFXU6UBdG2kFpFXvMSf+SLIUGCR2WhbKwOXzj6KE8/XF2WGnSAmMhXPd4r0Jmd2d/dOCsXQjwRNXPajFsa6uFOwXA/yuKtvhSV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FHqBFdpM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wVrshdgc5r4mBDt3sLx4Vu72sbLxT+zdRw8VaO2LgwU=; b=FHqBFdpMR0fSUdDqEFPZ1ujvqt
	ZjOVAXoZcKmsBhvKFP2Bkm7pHlUIJ/Sa1yrQ0UKruvR7CPWMoALIhwtH8a1II/uiFHALHJasonaSP
	15JC13KaliZ75mxBzCnAaPa6i5Bh5sN9i/haxtz9I1dSodd5wXWX3N4hvKkpZf1KNwMdS25f5HGhO
	LzqDd1wy8fNskrB7q7ViaVJSO8A0WpVzfUE8qWqjxtwaRCxib2gv7g3lKnCJKsYM5WH9SVxSkRsBP
	IH5sJlXLQliZZsfnk1JTlOfgcWz1Vjol/gXnpSfnAz/JgcvxlOewEYav8qt91ydmucqj4hGa07Kal
	zuXLdElA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sehpb-00000002b12-2mPQ;
	Thu, 15 Aug 2024 21:16:27 +0000
Date: Thu, 15 Aug 2024 22:16:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-ID: <Zr5wK7oUcUoB44OF@casper.infradead.org>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
 <Zr5Xn45wEJytFTl8@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr5Xn45wEJytFTl8@google.com>

On Thu, Aug 15, 2024 at 07:31:43PM +0000, Roman Gushchin wrote:
> There is another subtle change here: xa_alloc() returns -EBUSY in the case
> of the address space exhaustion, while the old code returned -ENOSPC.
> It's unlikely a big practical problem.

I decided that EBUSY was the right errno for this situation;

#define EBUSY           16      /* Device or resource busy */
#define ENOSPC          28      /* No space left on device */

ENOSPC seemed wrong; the device isn't out of space.

