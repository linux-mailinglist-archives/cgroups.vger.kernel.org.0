Return-Path: <cgroups+bounces-4095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6594803A
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 19:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104331F2375F
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B215EFC1;
	Mon,  5 Aug 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pJ9HXd8k"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92D15E5D6
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878737; cv=none; b=E3AIdZ9R0xVXMvHUgg/YAFqLz3cpSuc0iNyVPTtzLv7sGnB14vIHJgqVfXEkH+rLOGzkQ6BXQZAmlNUO5iA7fVsU1LefCX8seIdPB60QDjGCPwClDYx6CUiIMlq5dz63gLesNoprjAW5cyZwsNoDDQz5p02AO3eD5yYo8H8ulJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878737; c=relaxed/simple;
	bh=7U3dA9WJ1nSbD9BK478v5XFq5q47fjoaS/XE+g12PTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y444X4kIJoj5G3C3AqmKtH3RJ3zkxQnta2tjohN8/uT+fGqEQaZkSSiH8Fd6Qig4XpMp3UQpioRmA7POqU7FXiSRn46AgInjKXFqK60NXvOgBKQxu9KmOMEdrjiM2vVOvFxLjnHJmiDOI0Pz1X9IXsHEZVBJPezojNEn4WI6pXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pJ9HXd8k; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 17:25:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722878731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSyIpocgo4EjXlHcEmDY7pMivTvSufzck5K4nc0PmSE=;
	b=pJ9HXd8kIZl7wly61z0L0jQolO/0ZwVJmeDFniZGVaVBCJSlJ8YDC2+ch0yunrst6sntqO
	vvGVqOcGhjZSe2ROPbys/LDgZPHv2Dno1J2AREnPUa7d4FcRszQC4U2EkZs9xHXSrlXkpy
	4PBOA4ZTqLynya7x7OeZMGdZOT2ol/A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <ZrELBVxrf7tM1NjI@google.com>
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
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 02, 2024 at 04:58:22PM -0700, Shakeel Butt wrote:
> The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
> after many small jobs") decoupled the memcg IDs from the CSS ID space to
> fix the cgroup creation failures. It introduced IDR to maintain the
> memcg ID space. The IDR depends on external synchronization mechanisms
> for modifications. For the mem_cgroup_idr, the idr_alloc() and
> idr_replace() happen within css callback and thus are protected through
> cgroup_mutex from concurrent modifications. However idr_remove() for
> mem_cgroup_idr was not protected against concurrency and can be run
> concurrently for different memcgs when they hit their refcnt to zero.
> Fix that.
> 
> We have been seeing list_lru based kernel crashes at a low frequency in
> our fleet for a long time. These crashes were in different part of
> list_lru code including list_lru_add(), list_lru_del() and reparenting
> code. Upon further inspection, it looked like for a given object (dentry
> and inode), the super_block's list_lru didn't have list_lru_one for the
> memcg of that object. The initial suspicions were either the object is
> not allocated through kmem_cache_alloc_lru() or somehow
> memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
> returned success. No evidence were found for these cases.
> 
> Looking more deeper, we started seeing situations where valid memcg's id
> is not present in mem_cgroup_idr and in some cases multiple valid memcgs
> have same id and mem_cgroup_idr is pointing to one of them. So, the most
> reasonable explanation is that these situations can happen due to race
> between multiple idr_remove() calls or race between
> idr_alloc()/idr_replace() and idr_remove(). These races are causing
> multiple memcgs to acquire the same ID and then offlining of one of them
> would cleanup list_lrus on the system for all of them. Later access from
> other memcgs to the list_lru cause crashes due to missing list_lru_one.

Great catch!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

