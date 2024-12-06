Return-Path: <cgroups+bounces-5782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88129E7AF0
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C11889DEB
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A921A951;
	Fri,  6 Dec 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LPQ7V0FC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99421A94C
	for <cgroups@vger.kernel.org>; Fri,  6 Dec 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520034; cv=none; b=atVCt/tiYX/2dUXivbMU80W87gy4KzzlAppzur1o1fi/4kyCJQodL4md97zYSplMJHpqIhvcbYcs1XN8F+GcezLpwT+OhfTt7lrZgzZOgNFREjXn2+CFnVLbqrNvH4CkyjNeD2MRFLRDL2BOM/dHdGpYkHEUDh3FCHUqAJyzG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520034; c=relaxed/simple;
	bh=/94yjHWQ3G8tlIAynio7AeBwA+RiSutb49WEv1QueHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEuiJFStkdJVWPsq7sw6s+OIhZxryViv++GatgfEb7lTZKoQTVVnwqPXpBohjx4d5ShQ2kLnVBXdsbiAWfl6GQJam6VFmgGQPBP8Az9cC0DA+IEVDu0wP6+fqRfznyVwMB8DQEuvYODLCmnUx0HN/j+GEAYfn/2z0m04tiw0Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LPQ7V0FC; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Dec 2024 13:20:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733520030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrpWAnhs6ZQvQvyxIqn9Hy0WnK1+L1jfbuNM5R/qsyM=;
	b=LPQ7V0FCg8YdnNhBd1fDSqLT45vBjJiaBvCuucjXf4BCu1dGQTSDHnScayMny9j48hDHox
	cMHoYhYDC8O3UzonV0esj2hOmy3KGZqQxnI8CRpK6ZBe6bJCp8a9vpPb7dXD6FETnLMFVQ
	msrNSQ9M2mtxUkzXSpF3vLLgKwTCras=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Yu Zhao <yuzhao@google.com>, 
	akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size
 function
Message-ID: <xuhsdsl2bhlrlaghar3ru7nhlhjsmaiyjxayryogylsordbwcx@e2jxsb2qdbhd>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-4-chenridong@huaweicloud.com>
 <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
 <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
 <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 12:24:54AM -0800, Hugh Dickins wrote:
[...]
> Another thing to understand: it's called before adding folio to list,
> but after removing folio from list: when it can usefully compare whether
> the emptiness of the list correctly matches lru_size 0.

I think one source of confusion might be that this "emptiness" check has
been removed by commit b4536f0c829c because of maintaining the list size
per-zone and actual list is shared between zones of a node.

> It cannot do so
> when adding if you "simplify" it in the way that you did.
> 

