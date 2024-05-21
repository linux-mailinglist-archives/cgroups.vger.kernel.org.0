Return-Path: <cgroups+bounces-2977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705F8CB43E
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEFC1F20FA5
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D0149005;
	Tue, 21 May 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PeGr+tAM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93614883E
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319790; cv=none; b=fJQLabp7y60YiD7ieNRqQXwhZ0+BZ46h+Ulr4xM361xb4IWpPa7BlZXW6i5AvlovgHzXLu9FHnRrCWyLgjw+O+2QPMsT1xUqb9QeUTTfbHrLtRnR7wNtMan58kqSGHqxXnwyA38FNwadflojTKX3uTdnbpvMSOGtI8s807posJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319790; c=relaxed/simple;
	bh=6OvXjUWh9RLjfyeSJ9clNr/oAlqZigwi2jQgBOjvsBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6rULGT7tYINv2fL9Ikue3F2lzdD04xP15asyxXvkWvpLdvKEa7GsEEVhHlTo3HvQgMaf6IAPqVt6hDnbROVIvsoQNfAh0oLIB0+OkbW9NkZbI0JW3Nwf5CQgJBYKtqRy7/O12ZUkLU28Uc4rkIoE1jE1Z/Sl81SN7uyOkRxgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PeGr+tAM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716319783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jalEsNaUolsuLrS6kfuLi9+NeOcqrQKeJyldtUe5VCw=;
	b=PeGr+tAMufg5tm3E5oOpzYZtLInc+EAmNTJjUioYd2Mdx5dZkptLmQoNTeKMFbOO8yPO7S
	CUesLkwFtTJM2f7U6Vy4/bL7JJgi5jyZInPq1PUyMggO6fDEhTzn3WAnMfbL9Y5XtQwf0F
	VPLrs1q6+KbA5VS/YuGXZTex1WTWx+c=
X-Envelope-To: wangkefeng.wang@huawei.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: urezki@gmail.com
X-Envelope-To: hch@infradead.org
X-Envelope-To: lstoakes@gmail.com
Date: Tue, 21 May 2024 12:29:39 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkyzRVe31WLaepSt@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
> On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
> > The page_memcg() only called by mod_memcg_page_state(), so squash it to
> > cleanup page_memcg().
> 
> This isn't wrong, except that the entire usage of memcg is wrong in the
> only two callers of mod_memcg_page_state():
> 
> $ git grep mod_memcg_page_state
> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
> include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
> mm/vmalloc.c:           mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> mm/vmalloc.c:                   mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
> 
> The memcg should not be attached to the individual pages that make up a
> vmalloc allocation.  Rather, it should be managed by the vmalloc
> allocation itself.  I don't have the knowledge to poke around inside
> vmalloc right now, but maybe somebody else could take that on.

Are you concerned about accessing just memcg or any field of the
sub-page? There are drivers accessing fields of pages allocated through
vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
pages should be split rather than compound").

