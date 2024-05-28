Return-Path: <cgroups+bounces-3023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529F8D1468
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A742826CB
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 06:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE08F48;
	Tue, 28 May 2024 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzyKk+rF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEC22067
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877848; cv=none; b=mI9tmbNp1ffDGMtPYx67yj4M8KxIbMQvt+oEU1Y29VIYYT/iq2BwV9vw9sAZIbTtIDnWrBMdvdUQH28U92WWivriuhHJ004CwN94UShj0535/xmtYQoHGiQBDDn/qLndreJqHFYvqE+9sTEhjy6nn4zlsjY3t2qG8zQ1Sn1P9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877848; c=relaxed/simple;
	bh=MbLS+hldK79Ntn839dxW3kttgjPsUGk4+ECEhPAEkeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMx4CpDKZq5dQ0wddXfkNBWhmPbDIYaabeOpWu/soDeJJsxnbGYxhLyxugw1WTbgmYofBUoQpEmbU3dme/EnsN3nG8aRLf6jYmJ9hhfnPsU0HuyTcNeiyu3O3ujBuRiaPxsSRVKLHxcxkdgPvE+t5spv/jmqlycb99NdW1mN24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzyKk+rF; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716877844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbLS+hldK79Ntn839dxW3kttgjPsUGk4+ECEhPAEkeY=;
	b=hzyKk+rF3/zR5yFq3NVthNkP/0ysnZGdyis/A9KfUVFaJ981RBccwGUJcVpsy2MErLg5F3
	t1zNnua1YEqvKpayuzNqDbWlwicG0Ia1zfdlnQMgyh2gQYV++SJ83FAy2/fyAoVM+VBWk9
	W6rEhw4ym5c5/MZaMVz4knO+QvgyJYY=
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: tjmercier@google.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
Date: Mon, 27 May 2024 23:30:38 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <6gtp47pv4h27txb7lxvxjavrsamxvzamsclrsbpsl62i3nn2bp@yhamzxapsmsf>
References: <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
 <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
 <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
 <ZlBFskeX3Wj3UGYJ@xsang-OptiPlex-9020>
 <uzqh6xvoe6xgef3i6743m7gld5tlqp6h2krcqgjre3nzfcogwz@gsllvs77r57a>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uzqh6xvoe6xgef3i6743m7gld5tlqp6h2krcqgjre3nzfcogwz@gsllvs77r57a>
X-Migadu-Flow: FLOW_OUT

On Fri, May 24, 2024 at 11:06:54AM GMT, Shakeel Butt wrote:
> On Fri, May 24, 2024 at 03:45:54PM +0800, Oliver Sang wrote:
[...]
> I will re-run my experiments on linus tree and report back.

I am not able to reproduce the regression with the fix I have proposed,
at least on my 1 node 52 CPUs (Cooper Lake) and 2 node 80 CPUs (Skylake)
machines. Let me give more details below:

Setup instructions:
-------------------
mount -t tmpfs tmpfs /tmp
mkdir -p /sys/fs/cgroup/A
mkdir -p /sys/fs/cgroup/A/B
mkdir -p /sys/fs/cgroup/A/B/C
echo +memory > /sys/fs/cgroup/A/cgroup.subtree_control
echo +memory > /sys/fs/cgroup/A/B/cgroup.subtree_control
echo $$ > /sys/fs/cgroup/A/B/C/cgroup.procs

The base case (commit a4c43b8a0980):
------------------------------------
$ python3 ./runtest.py page_fault2 295 process 0 0 52
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
52,2796769,0.03,0,0.00,0

$ python3 ./runtest.py page_fault2 295 process 0 0 80
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
80,6755010,0.04,0,0.00,0


The regressing series (last commit a94032b35e5f)
------------------------------------------------
$ python3 ./runtest.py page_fault2 295 process 0 0 52
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
52,2684859,0.03,0,0.00,0

$ python3 ./runtest.py page_fault2 295 process 0 0 80
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
80,6010438,0.13,0,0.00,0

The fix on top of regressing series:
------------------------------------
$ python3 ./runtest.py page_fault2 295 process 0 0 52
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
52,3812133,0.02,0,0.00,0

$ python3 ./runtest.py page_fault2 295 process 0 0 80
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
80,7979893,0.15,0,0.00,0


As you can see, the fix is improving the performance over the base, at
least for me. I can only speculate that either the difference of
hardware is giving us different results (you have newer CPUs) or there
is still disparity of experiment setup/environment between us.

Are you disabling hyperthreading? Is the prefetching heuristics
different on your systems?

Regarding test environment, can you check my setup instructions above
and see if I am doing something wrong or different?

At the moment, I am inclined towards asking Andrew to include my fix in
following 6.10-rc* but keep this report open, so we continue to improve.
Let me know if you have concerns.

thanks,
Shakeel

