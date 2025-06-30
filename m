Return-Path: <cgroups+bounces-8656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA8AEE303
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5073BE733
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352F28F94E;
	Mon, 30 Jun 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqV1JNfi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7D28F92F;
	Mon, 30 Jun 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298494; cv=none; b=PE82SEr0KfF5OAQBxyyCUYk/nTyFOiFDyMR2rt6ZMnbhU0Je/+HiPIAq7oRIF4sph4oQktIyZ3SunaCf2c7wYLRjacJDo5gv/UfPkl/Q4ogMZxZqLTDg2I6sOU+NtqMRoeirA6WrbR1TZddNl+hjPrfbc4qjQknwlUaFkmOImcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298494; c=relaxed/simple;
	bh=eIE0i202yBSVq2vFvn7H0pZzWtP/NNzlLy34uoqAuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GooX3mxTl73ZC8fsIgriWLB3LemkGf8O/cVFihvX1Nbj/+sEUHYlBZ4A4bqDzQVPbTy5HImjV1woEk8sWWRDyxcr6J9aPv4AVCEsXDE2qTaWNWjZz+Qdy6uxmMDFlmok53B9kDZxQ2bwlnXoPQPbOS+f5+hOYK+3nwV9S1GrrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqV1JNfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4147AC4CEE3;
	Mon, 30 Jun 2025 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751298494;
	bh=eIE0i202yBSVq2vFvn7H0pZzWtP/NNzlLy34uoqAuCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqV1JNfiEoc5CZt4vqohqNOYgJodmRJGG3smmMQJ1+KiCvNI753OSDqD+Zqq6EKIz
	 9pPzYfZJQT+KGw2lSLCRk+t618nmU54t7/W9QghzuKFAot2y+qi1zviTyO1V6plAqS
	 YF0Hh4OTLbfTqO36YinjdVPht1K6mHGJL8MisQaK9pdE+I/l6PkDQuP0BqzRkXGVDy
	 n1fxI7rBCgoqAvFCeFsC1pCTZnwpei3AvXRIAyHgWn5CtoqwVJGgn8TYXcePaeH5lj
	 9DZWUV7vPkiBif7cjNTLKARjyS0f6SqPhV3ZYNqfoiObPcur9yTlvWziPEGYcqXOMZ
	 kcflmECOlx45Q==
Date: Mon, 30 Jun 2025 05:48:13 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <aGKxvQdAZ-vSd48D@slm.duckdns.org>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aF7L8jRkWm1TrwSu@slm.duckdns.org>
 <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>

Hello,

On Mon, Jun 30, 2025 at 02:25:27PM +0000, Wlodarczyk, Bertrand wrote:
> >  > Also the response to the tearing issue explained by JP is not satisfying.
> > 
> > In other words, the claim is: "it's better to stall other cpus in 
> > spinlock plus disable IRQ every time in order to serve outdated snapshot instead of providing user to the freshest statistics much, much faster".
> > In term of statistics, freshest data served fast to the user is, in my opinion, better behavior.
> 
> > This is a false choice, I think. e.g. We can easily use seqlock to remove strict synchronization only from user side, right?
> 
> Yes, that's second possibility to solve a problem.
> I choose atomics approach because, in my opinion, incremental statistics are somewhat natural use case for them.

They're good for individual counters but I'm not sure they're natural fit
for a group of stats. A series of atomic ops can be significantly more
expensive than locked updates and it also comes with problems like split
updates as discussed in this thread. I think most of resistance is from the
use of atomics. Can you please try a different approach?

> > I wouldn't be addressing this issue if there were no customers 
> > affected by rstat latency in multi-container multi-cpu scenarios.
> 
> > Out of curiosity, can you explain the case that you observed in more detail?
> > What were the customer doing?
> 
> Single hierarchy, hundreds of the containers on one server, multiple independent owners.
> Some of them wants to have current stats available in their webgui.
> They are hammering the stats for their cgroups. 
> Server experience inefficiencies, perf shows visible percentage of cpu cycles spent in cgroup_rstat_flush.
> 
> I prepared benchmark which can be example of the issue faced by the customer:
> https://gist.github.com/bwlodarcz/21bbc24813bced8e6ffc9e5ca3150fcc
> 
> qemu vm:
>                +---------+---------+
>      mean (s)  |8dcb0ed8 | patched |
> +--------------+---------+---------+
> |cpu, KCSAN on |16.13*   |3.75     |
> +--------------+---------+---------+
> |cpu, KCSAN off|4.45     |0.81     |
> +--------------+---------+---------+
> *race condition still present
> 
> It's not hammering the lock so much as previous stressor, so the results are better for for-6.17 branch.
> The customer has much bigger scale than 4 cgroups in benchmark. 
> There are workarounds implemented so it's not that hot now (for them).
> Anyway, I think it's worth to try improving the scalability situation, 
> especially that as far as I see it, there are no downsides.
>  
> There also reports about similar problems in memory rstats but I didn't look on them yet. 

Yeah, I saw the benchmark but I was more curious what actual use case would
lead to behaviors like that because you'd have to hammer on those stats
really hard for this to be a problem. In most use cases that I'm aware of,
the polling frequencies of these stats are >= 1sec. I guess the users in
your use case were banging on them way harder, at least previously.

I don't think switching to atomics is a good idea, but improving the read
scalability would definitely be nice.

Thanks.

-- 
tejun

