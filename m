Return-Path: <cgroups+bounces-7339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC9A7A946
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29030176384
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406782528EA;
	Thu,  3 Apr 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vmw5H+da"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E395C8E0
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704642; cv=none; b=oZQKJWy+6B5pVmFV6F/QbhJZfCmgk8SDF2Rq/6z8YAC13F913EXAdxMOnyyO4HUmstXKUUwui3e7u4j2xaScXQ/JsBgzmFst6xGoYdzx1xYMMt8KZ8S8/ag84FD9noCgz1psACdWwrutMB2KhQuQYRw8vltZ15ARkG6sb11P9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704642; c=relaxed/simple;
	bh=ypJTi/xQZJoVjQDNDn4da8jz+gtow7vMgLZqcpFUOHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/g984zAymfjzX+7HiwOE9IN1gvIcgTDYBvSCOS6/d08A6h1m7AifnPsfHONA/Wvy0x7uKPOUMgwLl/xqDiMB1aRzgIgNdRX/lMevKA0B16iHCb7AHtVwlaMfICYNaSCj/JQd3xsBi5eaeqC1BgN0zfuO4JzFAdRAp8ChO63XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vmw5H+da; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Apr 2025 11:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJhZ3CYu+p3ITqOxO4GkI86MxLYVyuTVhe7EULRD/lU=;
	b=Vmw5H+daUqRu13FczLvS4tjCsC5LCyWwbJOW2bOMko2YOpzSYVV0jY7PE3UztJWzzuESA8
	f565BFwdL2sWgBJ4erQAafS4UGUwWGihKxaLId+fPUdtcVo/KXigeJLzECykUIpJaYPBbc
	ToZAPxE6/UUMMsH6zNSrzei4lr5371k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <axnnvibukeqk6l4mijzy4yv73zlzoecbctfb2smw45qs2pwmlc@srlg4hlujaj5>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
 <20250403164741.GB368504@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403164741.GB368504@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 12:47:41PM -0400, Johannes Weiner wrote:
> On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> > The vmalloc region can either be charged to a single memcg or none. At
> > the moment kernel traverses all the pages backing the vmalloc region to
> > update the MEMCG_VMALLOC stat. However there is no need to look at all
> > the pages as all those pages will be charged to a single memcg or none.
> > Simplify the MEMCG_VMALLOC update by just looking at the first page of
> > the vmalloc region.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> It's definitely pointless to handle each page with the stat being
> per-cgroup only. But I do wonder why it's not a regular vmstat item.
> 
> There is no real reason it *should* be a private memcg stat, is there?

Yes, it can be a regular vmstat item (enum node_stat_item). However then
we have go over each page as node_stat_item are per-node and vmalloc
region can have pages from different nodes (I think but let me check).

