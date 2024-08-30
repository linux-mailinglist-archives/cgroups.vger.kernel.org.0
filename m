Return-Path: <cgroups+bounces-4652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43910966A97
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02622284A2E
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6711BF808;
	Fri, 30 Aug 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BOti94d7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582D1BE256
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050098; cv=none; b=hJva3yw4QC4wOyjNsjo9jJW1Q7CDSutg2fmm1qmKwHwqGT9F7rMWkBPTSO6mGOy3yFLE2eg9OveCw5F4S5bEfrLBODNDNEBlEuKdl6/5X2gILB2CHeGkGYTLus0py2Ad7ylM0k/GZl9tJ2sazUeRDV1RTAEQF3uRI30pSIshrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050098; c=relaxed/simple;
	bh=oGI9YR13810+qfWg8KknXvRTSXv+EhfiLvOHw7EJAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krp3xubXxebYYU7EFpb6HPDDtYPdm3MYzP7BLzptsuKrE4WjvJLo8xqgoXLgLuAB/NeSZ7aV4lKcJkDKAO0xBDnTkZ08/X8UD05NqT5j+nbGI7/IeNLSAoDq0x3oFA8AIEmBox7iOfbMdiEzs/gvb7sGAJwPIvBtdodJ/LXnQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BOti94d7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Aug 2024 20:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725050093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2MSZCjedrpsmWdTZ6nvWovh/uXXPtdm+g3LPj1tQbc=;
	b=BOti94d7W0NPg/IHRInQnb6PRJY9TO9UZceWZQtPuLKwNaHmSFPyhW/a1EFIupa4RsHq4G
	OUmVh944d6mSiaejsihDCCf568qT6aj+JhSkM44cEXYP9nTaQQLCh3NijTC6OjUEodkVB1
	7nL2FE4ym7bVmNk7Lz6fIoEX7R+B9hA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <ZtIs5qx0QBB8FqGI@google.com>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827235228.1591842-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 04:52:28PM -0700, Shakeel Butt wrote:
41;2500;0c> At the moment, the slab objects are charged to the memcg at the
> allocation time. However there are cases where slab objects are
> allocated at the time where the right target memcg to charge it to is
> not known. One such case is the network sockets for the incoming
> connection which are allocated in the softirq context.
> 
> Couple hundred thousand connections are very normal on large loaded
> server and almost all of those sockets underlying those connections get
> allocated in the softirq context and thus not charged to any memcg.
> However later at the accept() time we know the right target memcg to
> charge. Let's add new API to charge already allocated objects, so we can
> have better accounting of the memory usage.
> 
> To measure the performance impact of this change, tcp_crr is used from
> the neper [1] performance suite. Basically it is a network ping pong
> test with new connection for each ping pong.
> 
> The server and the client are run inside 3 level of cgroup hierarchy
> using the following commands:
> 
> Server:
>  $ tcp_crr -6
> 
> Client:
>  $ tcp_crr -6 -c -H ${server_ip}
> 
> If the client and server run on different machines with 50 GBPS NIC,
> there is no visible impact of the change.
> 
> For the same machine experiment with v6.11-rc5 as base.
> 
>           base (throughput)     with-patch
> tcp_crr   14545 (+- 80)         14463 (+- 56)
> 
> It seems like the performance impact is within the noise.
> 
> Link: https://github.com/google/neper [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

