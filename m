Return-Path: <cgroups+bounces-2987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B026A8CD768
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB222824F0
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84D11720;
	Thu, 23 May 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N7u94VDX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348E1173F
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478894; cv=none; b=qLLk2EUEsLLDJRXZYXTq5J7lb7Cfx/xQR7UGgmX6zUvSsEfkedyTCA17QtCkoRqSgAIKRb5A10GABDNxzN0Egme1gMpPzQO2XnaMzTP344ow15u0WCFm572vYB0Vo+tclWWaaoitl+HNbam7MLDWdbe4agUdDFE4RONKdL/5ZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478894; c=relaxed/simple;
	bh=U8sMJ5U8bLMdKmrdSKim/u/sHA7zFr6D0hGgLLSQ+Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSwczlEWT9COSs79nhy3ts1QRST4zIAAclh+suXnqT7rC/AZNfvatSbJmyWuY6sVRn0T9hG0e30AuJfYUgEMbj96OrWIIoGysmU5Jq+KdCIbuSCWeCftHQXSRiMDJs8tGqRkcMujby48BqhWobiLL38fd053mn+SEvVH1/VbL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N7u94VDX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716478890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8YxSbs/hHqW6i+09UfLC6ZXnGQWJ1Wz3mWvda8gqJA=;
	b=N7u94VDXt68cQNxxQaj2EpeuKCUKC+rAIuIolRC9Yxz6GfmdnR8oC9t4YB8D1KD4qmfyfx
	pSLAjViiop8zBTGVV0dNNRvfpGvkodwl31UsFpOjlSy4Os4inCqet8DWIaQZdQqmI2f5su
	XUceER8lHTKERCR8CMq1HophrpI3mnY=
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
Date: Thu, 23 May 2024 08:41:25 -0700
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
Message-ID: <z6t4afo4h2oybrgtpeghohxamnaapcjhi54dexvzyflv4mpk56@xjkjq4jodtve>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
 <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
 <Zk9FGQUdcs8tqCbi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9FGQUdcs8tqCbi@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 02:31:05PM +0100, Matthew Wilcox wrote:
> On Tue, May 21, 2024 at 12:29:39PM -0700, Shakeel Butt wrote:
> > On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
> > > The memcg should not be attached to the individual pages that make up a
> > > vmalloc allocation.  Rather, it should be managed by the vmalloc
> > > allocation itself.  I don't have the knowledge to poke around inside
> > > vmalloc right now, but maybe somebody else could take that on.
> > 
> > Are you concerned about accessing just memcg or any field of the
> > sub-page? There are drivers accessing fields of pages allocated through
> > vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
> > pages should be split rather than compound").
> 
> Thanks for the pointer, and fb_deferred_io_fault() is already on my
> hitlist for abusing struct page.
> 
> My primary concern is that we should track the entire allocation as a
> single object rather than tracking each page individually.  That means
> assigning the vmalloc allocation to a memcg rather than assigning each
> page to a memcg.  It's a lot less overhead to increment the counter once
> per allocation rather than once per page in the allocation!
> 
> But secondarily, yes, pages allocated by vmalloc probably don't need
> any per-page state, other than tracking the vmalloc allocation they're
> assigned to.  We'll see how that theory turns out.

I think the tricky part would be vmalloc having pages spanning multiple
nodes which is not an issue for MEMCG_VMALLOC stat but the vmap based
kernel stack (CONFIG_VMAP_STACK) metric NR_KERNEL_STACK_KB cares about
that information.

