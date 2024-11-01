Return-Path: <cgroups+bounces-5383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1049B94DB
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B51B222CD
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AD1CACC4;
	Fri,  1 Nov 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hz+32a0r"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CF1CACC8;
	Fri,  1 Nov 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476879; cv=none; b=dhXO/+JRkBM6LhlP0xoId/zgRkAa5dCgTqiQzdRk+m0WaD/4wepAwyikyFjEjVfns3aHByMI9togEuTCpvUzHFXzm2x4BdJJnGfr2YmipKitsh6F4K06zOuWNZiKB5V7fPMSDe+uXjNGJd1ZjYPYT3WpnYUEVcmAuxB5zw6KBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476879; c=relaxed/simple;
	bh=ghMRvEXgNx9L4Ka3475lkV//TT+3WWXy4W75C75+Osc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuWywbbX3gUNyAK2GtcJvoYD2JGz3AmZRAboX5xxN3DwDeDFczq4Vz4J/qKgLU3HY+bUvOnvUofO/7/pBLXBVClWcwW/NcS9dgKpB2DoI+/hNrdn5wGgsKBJA29arKVLfR80QFK7K/wyarc8z/j1Y+2NJuvkuOBskJesEroTE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hz+32a0r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CZ9/rERULRJvD1btUQVcVAJF24qxBXwTu8thO571uhU=; b=Hz+32a0rJoP9IwggtPueybLbHt
	FuejoVtysmHfzuUu69hiCpkZuujJ+50mPDQmNyg1/5s/+dpkxULlDt5K44VXVePxYVDjuEDRAQU2y
	Z+DihUL8XgVtoHiaETQMTbtheh3B2VElFCj/sPBBPuwVmvEua46ERd66TC9lvaaRlYD/9BZsgxOs2
	8ywmhssSrAmm0Bs8Yt0DxbqPXiwf6svYG38Mt1hnHTjx32VByhnEb9b8kiHdCa3KtHrXv7pCB3ERf
	FPmGqkttmVyNim0u74g4iXnJTcOw98/l4s73pLmly0n5NkJXyCs9jWJU0DxrQ4P9SAbH4LBAOJOe+
	IsMikANw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6u5B-0000000G0Oh-1baC;
	Fri, 01 Nov 2024 16:01:05 +0000
Date: Fri, 1 Nov 2024 16:01:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, peterx@redhat.com, hannes@cmpxchg.org,
	hocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com,
	nikita.panov@huawei-partners.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyT7QebITxOKNi_c@casper.infradead.org>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>

On Thu, Oct 31, 2024 at 05:37:12PM +0300, Stepanov Anatoly wrote:
> Don't get us wrong, we're not trying to push this into memcg specifically. 
> We're just trying to find a proper/friendly way to control
> THP mode for a group of processes (which can be tasks without common parent).
> 
> May be if the process grouping logic were decoupled from hierarchical resource control
> logic, it could be possible to gather multiple process, and batch-control some task properties.
> But it would require to build kind of task properties system, where
> a given set of properties can be flexibly assigned to one or more tasks.
> 
> Anyway, i think we gonna try alternative
> approaches first.(prctl, process_madvise).

I oppose all of these approaches.  They are fundamentally misguided.
You're trying to blame sysadmins for our inadequacies as programmers.
All of this should be automatic.  Certainly the kernel will make mistakes
and not use the perfectly optimal size at all times, but it should be able
to get close to optimal.  Please, focus your efforts on allocating memory
of the right size, not on this fake problem of "we only have 235 THPs
available and we must make sure that the right process gets 183 of them".

