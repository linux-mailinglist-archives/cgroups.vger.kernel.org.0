Return-Path: <cgroups+bounces-7506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D59EA871F7
	for <lists+cgroups@lfdr.de>; Sun, 13 Apr 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C440C1888ED1
	for <lists+cgroups@lfdr.de>; Sun, 13 Apr 2025 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F81AB6C8;
	Sun, 13 Apr 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SGufiG16"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0918E3F;
	Sun, 13 Apr 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548524; cv=none; b=C2KuQOk9hHxjgbNQlzLe/UIlOQYdBPpIaFgK2hHeQqRjCfvji+/NuPFrKV6OWmKN3XtL6NEWxKxX3lkfxx3yEFGP1aMrWYTMbayPOTVtqmndRh5C7cNBJtx2+fBYxlBRYlaVQ4IdL3HuBTrXV3r3C/X3E40y9QDfUKOYFUVeMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548524; c=relaxed/simple;
	bh=inTSUzpY4HkgLJjo5Y9sPgarm2uGUrVEaFbir5x5xiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJiYPBKoejavyRJoY1e0pFvb0ewNYJ8e4Wdpc5DN1pyikxfTVD85EckkHW858Fvqi3L61zQeut66/++rCdkZIzK/xnVHaURaWvGXRb5HBdTIUlYXhAdYt1pEksyae7QQsqg7MB6YyIdXytg/pa4v3IkHKBs7SW1MvOAoh5Z25mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SGufiG16; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BYd9ghzIbvgBQxn74x2yQL2hqEOdpaPt3okp+tYy+YI=; b=SGufiG16PzYig2XsU0/e5Eg5VY
	Nrz1kUIZf1J4TK69G0cSJe88bZuAFUerzAYATIWklMfuyBy4evF9LW3qlxdb+o+zZCdfFGVTeniUK
	hl0Hi7DdUVsKYEAcu/47Gf1HK+3N4KGc5bvAmePpdih0gKpX9X4LwBR3g3vMsr//bmQUZVWp4g1pz
	GVWbgGoEAhrwg4HJCxlh+1lCzdaKxnHWVgkEdrDimsA9bryaMCCLZMixbN0PZeJ9YZo2gClBAUMAr
	6xyHlkg+FWPhMKZ2mMr6rYCTze1Bijcfaf+c/87MnHxgKTJZbXC9SKGCNHaahwveAINGGXaUYaGcP
	dSH+632Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3wl8-00000006o5h-3PQP;
	Sun, 13 Apr 2025 12:48:26 +0000
Date: Sun, 13 Apr 2025 13:48:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_uymiNhC6doPD23@casper.infradead.org>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
 <f4131737-fe1b-46a9-acde-73d1e29cda98@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4131737-fe1b-46a9-acde-73d1e29cda98@linux.ibm.com>

On Sun, Apr 13, 2025 at 10:53:48AM +0530, Donet Tom wrote:
> 
> On 4/12/25 5:19 AM, Matthew Wilcox wrote:
> > On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
> > > Unmapped page cache pages can be demoted to low-tier memory, but
> > No.  Page cache should never be demoted to low-tier memory.
> > NACK this patchset.
> 
> Hi Mathew,
> 
> I have one doubt. Under memory pressure, page cache allocations can
> fall back to lower-tier memory, right? So later, if those page cache pages
> become hot, shouldn't we promote them?

That shouldn't happen either.  CXL should never be added to the page
allocator.  You guys are creating a lot of problems for yourselves,
and I've been clear that I want no part of this.
> 

