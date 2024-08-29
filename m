Return-Path: <cgroups+bounces-4573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F6964B88
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9B0283089
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D611B5817;
	Thu, 29 Aug 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHFy6zh3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B21B531C
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948440; cv=none; b=hI0sYy+WVMq3rbwJ+vCRky/ObQJeIARhGDtXd/d+xISTzFEzDjWxWU1PUUtvBq3D5Ng2fNU4r2f/xzuyVGVmxOKnhdWXKSBrt5M9AltzidHYp0+5EkllxmIEKRs8g+jWJCz5xyjW10iUAsIx3CcVEudi7/CoqU2LtpeFLdJS9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948440; c=relaxed/simple;
	bh=7U6Nmbh114G96KtGYBVDLAbK4d6lfvn2XssOHsbTrO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDLATdPTsl8FXmz/7L2wYHGwQ098WY1doDZixmVA1eRI46HVgbJXq7dBoP9SCMur25CXwWxpXoaQTZFDCyzyl3XxdvJYLbQm3z+UgtsFzy2lpBX3gT/HYq0w8opX2kcxbeq87VkFg3T1Eay9EI2fufKaX0UmCDWV93A4lMAj4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHFy6zh3; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 16:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724948436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqnxVaBjgZfealincCR2Zh7tFE8qlNsIgLvhONXdZ1c=;
	b=qHFy6zh3aSVycnfwMPa+TGK1S86Y8eGqQ+lER+GugiPaxKDt1qqI5UdERHZKWVvCiRP0uJ
	mAc/ne4Mph2X8TNL/fp/s9L8udkV8DXLIkPNwe4JgfQchKfQE2x81o0YNdAjhxdcFzEtRz
	eepH/wLlvDilwHkme1dwivldLtoMDfI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <ZtCfzHNUSVjGsXGS@google.com>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <9fb06d9b-dec5-4300-acef-bbce51a9a0c1@suse.cz>
 <mvxyevmpzwatlt7z4fdjakvuixmp5hcqmvo3467kzlgp2xkbgf@xumnm2y6xxrg>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvxyevmpzwatlt7z4fdjakvuixmp5hcqmvo3467kzlgp2xkbgf@xumnm2y6xxrg>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 09:10:53AM -0700, Shakeel Butt wrote:
> On Thu, Aug 29, 2024 at 11:42:10AM GMT, Vlastimil Babka wrote:
> > On 8/28/24 01:52, Shakeel Butt wrote:
> > > At the moment, the slab objects are charged to the memcg at the
> > > allocation time. However there are cases where slab objects are
> > > allocated at the time where the right target memcg to charge it to is
> > > not known. One such case is the network sockets for the incoming
> > > connection which are allocated in the softirq context.
> > > 
> > > Couple hundred thousand connections are very normal on large loaded
> > > server and almost all of those sockets underlying those connections get
> > > allocated in the softirq context and thus not charged to any memcg.
> > > However later at the accept() time we know the right target memcg to
> > > charge. Let's add new API to charge already allocated objects, so we can
> > > have better accounting of the memory usage.
> > > 
> > > To measure the performance impact of this change, tcp_crr is used from
> > > the neper [1] performance suite. Basically it is a network ping pong
> > > test with new connection for each ping pong.
> > > 
> > > The server and the client are run inside 3 level of cgroup hierarchy
> > > using the following commands:
> > > 
> > > Server:
> > >  $ tcp_crr -6
> > > 
> > > Client:
> > >  $ tcp_crr -6 -c -H ${server_ip}
> > > 
> > > If the client and server run on different machines with 50 GBPS NIC,
> > > there is no visible impact of the change.
> > > 
> > > For the same machine experiment with v6.11-rc5 as base.
> > > 
> > >           base (throughput)     with-patch
> > > tcp_crr   14545 (+- 80)         14463 (+- 56)
> > > 
> > > It seems like the performance impact is within the noise.
> > > 
> > > Link: https://github.com/google/neper [1]
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > > v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> > > Changes since v1:
> > > - Correctly handle large allocations which bypass slab
> > > - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> > > 
> > > RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> > > Changes since the RFC:
> > > - Added check for already charged slab objects.
> > > - Added performance results from neper's tcp_crr
> > > 
> > >  include/linux/slab.h            |  1 +
> > >  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
> > >  net/ipv4/inet_connection_sock.c |  5 ++--
> > >  3 files changed, 55 insertions(+), 2 deletions(-)
> > 
> > I can take the v3 in slab tree, if net people ack?
> 
> Thanks.
> 
> > 
> > BTW, will this be also useful for Linus's idea of charging struct files only
> > after they exist? But IIRC there was supposed to be also a part where we
> > have a way to quickly determine if we're not over limit (while allowing some
> > overcharge to make it quicker).

It should work and speed up the case when we can drop the object before charging.
I'd suggest to implement it in a separate change though.

Thanks!

