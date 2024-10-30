Return-Path: <cgroups+bounces-5333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF529B63D2
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4F01C2091A
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2D1EABAD;
	Wed, 30 Oct 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBgKJV4r"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB1EABAC;
	Wed, 30 Oct 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294093; cv=none; b=Bqmr9ii1kddP6/Fcc1dbRTGs1goQd5luKankqUvTyir8+AxE1H1nvQogPf99WNA7tZDPAYFaiY9JGD6ycTSTeT9FXkbaSvBoSW5aiK1LRD3dNr5u4mzemlhupLMbh9MBxGefA+hJJ4+SA0I02s9g4QKO7hVdh7Aa4sctIFpNJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294093; c=relaxed/simple;
	bh=DBpB3f2LtL7b0wNdnmohkKojIifWOS9El0hw2Q97fPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Cq4WQMakQeoAYdzyd7LmejxyqCXQCWgKSa63vb2fIChbRqbL4OW5pGSvQu4gbom1o/tpRir7mxFYFvvNYieSEefnfb0FqvY+YmR5+rNH6F3xERmzNqaM1k9ycG8NW9M3fpdVLg5mL2LYtYHVk91YWR4JT5I/+g1wM5PgQud6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hBgKJV4r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aPn2CLHEdywlk/89aJTVPvPxOEZTzXSZFssJ/Vt2G94=; b=hBgKJV4rkBrR5hKeykMpwtktYa
	mbR/CQVm4fPurnul+pfrdEDnmKvZk5Mw24sAUsUpH/xMvbwblJmv+YH/hKFp0VMCh4hkDv8OcIlFs
	pb9bgnnYBE+rWXRdzdkO0ogWpi65Oq7Jg3GHpqiigBILZGdRiQtddo+Swfn+wCHwvPJSLZl40hlym
	mf3T66fF5T1mzRSeWVdaw4BgOJXa80Xc+OEFTqdzoQdO+496H+b248y46mp3mJSlNPmJSLgkt663w
	tm0/IYRhSuXNiEI9aUz3fo6n/6LVAvPeZOB5pNjvjZ6YPAOdjoFeW5H+bMhfE2ce+GwdzdPwI8C/Z
	z4lHHvnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t68X6-0000000DDen-2WSw;
	Wed, 30 Oct 2024 13:14:44 +0000
Date: Wed, 30 Oct 2024 13:14:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gutierrez.asier@huawei-partners.com
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, peterx@redhat.com, hannes@cmpxchg.org,
	hocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyIxRExcJvKKv4JW@casper.infradead.org>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>

On Wed, Oct 30, 2024 at 04:33:08PM +0800, gutierrez.asier@huawei-partners.com wrote:
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Currently THP modes are set globally. It can be an overkill if only some
> specific app/set of apps need to get benefits from THP usage. Moreover, various
> apps might need different THP settings. Here we propose a cgroup-based THP
> control mechanism.

Or maybe we should stop making the sysadmin's life so damned hard and
figure out how to do without all of these settings?

