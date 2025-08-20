Return-Path: <cgroups+bounces-9298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09970B2E5A2
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 21:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA711C87385
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868228000A;
	Wed, 20 Aug 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AM8PeyYU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7614F9D6
	for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718334; cv=none; b=odkOrw1op2K2sJ06RoZTEwjUw2DnRgKfd6b+hy64e+CWMEgGB8/YMogDykVWg6eZbHTqwG8eaIliO3ER1HZ8/Rx5GO47h96mGSsX3YSkYQWJt+61osXxNHiUavD8hb54yxfEugSOXGyCIUZPOeKzY9jR48sUEsWtgRkhaZHE//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718334; c=relaxed/simple;
	bh=fTIxBTLa4wOFkN+npnEUXHvJzyECweac9e5WGMHnblY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP/+63bsGiBL3L83aBhRYj7NskAqxoTSKDtqgml7dDRDylJ5422KtJPL3EXhRu3ra6dcrgxOE6VID2UOdjjeNY4EZO/Jn5nAAZpMWJFAma907rle5l20CVUDq8A1V7v9V9qnc8VyfAOqia/RvlSf+euvcY+IdeC3QL5MDWDjlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AM8PeyYU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 12:31:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755718329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOyuOaWYAFtKnuh/JpQ9JhhAptxR93x2Tx2hSXqcNWA=;
	b=AM8PeyYUIFxQSds2E1ti4q5gOD0Jo2OmKPSyT2r4q5JOB5E5vzCXxr5kEY6Onf4RejPq3n
	cNjwZ9xAAsLJahg8aYdLCnre/a9sjbjNbhyy1+bcKBxa7ADpHa7QnKcZKDMJiFOr2CkrFJ
	xdnVBIDDbLgfn/ccp94IvkMfvAPIKUA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Matyas Hurtik <matyas.hurtik@cdn77.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <zldrraxaeff5gaffaltgzmnsgc7kvnlltubkaury3mhqlfmgwp@jinkxqagerjy>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
 <aKYb7_xshbtFbXjb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKYb7_xshbtFbXjb@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 09:03:11AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 20, 2025 at 06:51:07PM +0200, Matyas Hurtik wrote:
> ...
> > And the read side:
> >   total_duration = 0;
> >   for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
> >     total_duration += atomic_long_read(&memcg->socket_pressure_duration);
> > Would that work?
> 
> This doesn't make sense to me. Why would a child report the numbers from its
> ancestors?

I think Matyas might wanted to do a tree traversal under the given memcg
and by mistake did this upward traversal. However that will miss the
already deleted memcgs under the given memcg.

