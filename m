Return-Path: <cgroups+bounces-13262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C8D28F04
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 23:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00FA23016927
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685D32B9BD;
	Thu, 15 Jan 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIusGAXN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02230BB87
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514991; cv=none; b=kbv5jgJ7GS9u7GmLmqpwFSnwtTLPFv4LncZtnjcoTe9ZQDrJw2VWSp1tJSPCQxR6a3qyJBwxODsU1bKlZnlQRhuzvj7S89PLS8sW3pYoQTqUiTYW6i1e1VqG9qLwrNVBt1E1HdVFOZDf3mYapp3/IL2yq4YcdzJVGrNlv2dhdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514991; c=relaxed/simple;
	bh=VRWbceNOpYxJG/pXnzBrtC/69uqaDhIJ1H90ANTzV5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD+ojFEhX5vxNSYy4ai1n3VjdZ69UdJDWr3Nw18lhyX7a1MUIHRxJpwpLe+K9DsKLb2qKGS/M3RW3PbJ0a0jzYG34LzFsMc3F0dH+HPLv3Bt+4xG/0IB4LdetsN2RrHwTy3SMwRGVqUrCh93+0tnpxdLcReiImf92GoagXJp5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIusGAXN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 22:09:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768514986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntiyNJN8HUkrpuQ5dePzjgUJxHCqX6FK7kqJzCegw+E=;
	b=OIusGAXNYjd6pQKnQb4pYZB362R/Uq6SZMD7NGXJxBHnNS69t8wrcQtIbBJNqaTuC80Pna
	1B1aJhYUHEnszVjYApCXTd+Gt9K1YVjlQad72LjRCUqhY/vzPj45CjoTETaH4jFO+s4zRB
	NM4IMy0XAzy0qYMp5GRNYklKDReZHSQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	ziy@nvidia.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <a3zwoccozpnpum3dkvdytjl4aookymmuuhzcnswznxft5jy6mi@wfcyp4euizrx>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
 <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>
 <aWkjUXpyLEJyc-C0@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkjUXpyLEJyc-C0@gourry-fedora-PF4VCD3F>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 15, 2026 at 12:26:41PM -0500, Gregory Price wrote:
> > > For the first go, yeah.  A cram.c would need special page table handling
> > > bits that will take a while to get right.  We can make use of the
> > > hardware differently in the meantime.
> > 
> > Makes sense.
> > 
> > I just want to point out that using compressed memory with zswap doesn't
> > buy us much in terms of reclaim latency, so the main goal here is just
> > saving memory on the top tier, not improving performance, right?
> >
> 
> Yeah first goal is to just demonstrate such an accelerator can even work
> as a top-tier memory saving mechanism.  But hard to say whether reclaim
> latency will be affected appreciably - won't know until we get there :]
> 
> I'm totally prepared for this to be a science experiment that gets
> thrown away.

If that's the case I would put the zswap stuff under an experimental
config option that's not enabled by default, so that we can rip it out
later if needed. 

> 
> > > 
> > > I will probably need some help to get the accounting right if I'm being
> > > honest.  I can't say I fully understanding the implications here, but
> > > what you describe makes sense.
> > > 
> > 
> > Yeah it's counter-intuitive. Zswap needs to charge less than PAGE_SIZE
> > so that memcg tracking continues to make sense with reclaim (i.e. usage
> > goes down), but if zswap consumed a full page from the system
> > perspective, the math won't math.
> > 
> > Separate limits *could* be the answer, but it's harder to configure and
> > existing configuration won't "just work" with compressed memory.
> >
> 
> I think you are right. I am also inquiring whether individual page
> compression data is retrievable.  If so, then this actually should be a
> trivial integration.
> 
> If not then this is probably ending up on the cutting room floor and
> going straight to a full cram.c implementation.
> 
> ~Gregory

