Return-Path: <cgroups+bounces-5382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F59B94C5
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB52B2152C
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CD1C7B9C;
	Fri,  1 Nov 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FH3erEBV"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D4145A17;
	Fri,  1 Nov 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476472; cv=none; b=p76VKy4Qsuiuf2n1LGumZnNxFQRYLobBImpEgwec7RTOmRxLbXgatHU7shEwbkPKU61lRduNHgDjLeQWJjM3YTerrxbqCk2k8NrNtwGwC88z/Et8r/MtKWo2QRiI0tTizDRJqAqq1HQIPJSL45Jg8yo2KDdBQgYyTP41VeOxp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476472; c=relaxed/simple;
	bh=c8vzJp8mUlLCVOG1/gaZBZdCC2A1PmwSCORRUbrMsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkMoq16oGYeLi/uqF8mTo3fkQlZupSilW49+3Mt1DGCSxoNdpnKDDfEDrqyrrdKSTZjmYtyjKSdzpf+Kcy9HnAo7CUyW7G7CjSSffTwX5xZEKnsmoygLFkVHFoEqOPHVEnQttciinMZyjuUVMUpdcm2fTA91kKEZQHqZfnp3MPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FH3erEBV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hjp3B+rMiaFuvfOkDbxYf9shcT++p3671+VOrmTNNXU=; b=FH3erEBVmqrsdXeUC5kWsCJZJp
	3q+RJ5ZBBEKw647tqmBYHGs52Kxaon0ld49HdHUoqJXzYS61Nn6NXjX0U6MRorAt+iONxJEBtW/uk
	LdqM6FbFH9HW2KM7TtuV8omH13hSOlHlqvUAWvaFad9g5r8oQxCDV99U/jUMkodXU5/pACYNKWgfY
	4Crey+HLXqo6JIrYfXd6g6khMsa/DaLEWT6WoQR9lC3PpSVX0WY9jyjFdu15DZ2TufAUdYoFuRIIe
	YV6UXQdJuCsEVs7ew2tsEWI0eRfApznQm0UtFLVEyvxTkLign6EdG8YUPHF/FY8yakSePzrIUss8A
	haNfQ7ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6tyb-0000000G08N-24M3;
	Fri, 01 Nov 2024 15:54:17 +0000
Date: Fri, 1 Nov 2024 15:54:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kinsey Ho <kinseyho@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Sourav Panda <souravpanda@google.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
Message-ID: <ZyT5qROhtuWeuxga@casper.infradead.org>
References: <20241031224551.1736113-1-kinseyho@google.com>
 <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>

On Thu, Oct 31, 2024 at 04:06:04PM -0700, Andrew Morton wrote:
> Possibly dumb question: can we switch swap_cgroup_prepare to kmalloc()
> (or kmem-cache_alloc()) and use slab's accounting to satisfy this
> requirement?

It looks to me like a bad reimplemention of vmalloc().  It looks like
this code used to make more sense once upon a time, but now it's really
just vmalloc().  Or did I miss something?

