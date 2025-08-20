Return-Path: <cgroups+bounces-9286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81213B2D165
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FBD2A7E00
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA42147FB;
	Wed, 20 Aug 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BI/zpu6D"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3919D09C
	for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653337; cv=none; b=mkks3uSx2RJU77TatjeuMklEV6+7VH4HYg4//HP3QlREIA10q8AluJOe9otLbczEHwiFxHdf/NjQBqtUc+dcGvFS71aKdNIl0dA9kLusIjnBdXWbINI+UELCRbxkJCdEyUNcejbGnogS1Zca8XqKMgcHmDEwur/9NdaEXiW6wjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653337; c=relaxed/simple;
	bh=W02lzqXP9JxBOiA401TSgZasoakHztbJssqNTbHmUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmfri9ij6YvlHLMUVOdEhPc8vAIL84wWynd8MkmqTxNLZLySm0KFtlpNhuxbkpPWXe2T7SuAS2eEU8yNWovm2wMDwE2OLqGIIL063FCLxfDvpk6C+aV+Pv/yEjj6BMBTX9WCjmx+6TISm+/py/HHVVf4bz14jKe4IKweY/oM3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BI/zpu6D; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 18:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755653333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ddgBw3mCPWmcVg5SkIp/yrU07evHNFdC+LuzP4v9Gc=;
	b=BI/zpu6DhZSKL3XzZ/VJbPaPs+hvb9svdPgDr5znV2PbyuEuBNzKNER2kvRp/123+Q1Pna
	MDIzeU1CeYqyXkeEanv26zU+d7IrsDT9Mv1E1HDnm+3Q3i3jgem3C7LaBfh1oSE+n/H3Y3
	gWkzqIMzE5KOtXr9pGq8XCn4BsDVUP0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 net-next 09/10] net-memcg: Pass struct sock to
 mem_cgroup_sk_under_memory_pressure().
Message-ID: <2v2te3knj66aszw6chn6m2u7chtje7r5ayrtufwop5c4vftx7o@kbf2ry2bgo3r>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-10-kuniyu@google.com>
 <20250819182356.75aa4996@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819182356.75aa4996@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 06:23:56PM -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 20:16:17 +0000 Kuniyuki Iwashima wrote:
> > We will store a flag in the lowest bit of sk->sk_memcg.
> > 
> > Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().
> > 
> > Let's pass struct sock to it and rename the function to match other
> > functions starting with mem_cgroup_sk_.
> > 
> > Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Hi Shakeel, looks like you acked every single patch here but this one.
> Is this intentional? :)

Nopes, sorry I missed it somehow. Please add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

