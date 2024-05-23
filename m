Return-Path: <cgroups+bounces-2989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4578CD8AD
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737EC1F230F3
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45017C77;
	Thu, 23 May 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjsl3iax"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D717BD9
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482860; cv=none; b=M19WBjomd/rBNAH4cL5OFZDbkJwag/e4So8pbOjY57SjbkjnTdRDMbFnzGSbK8Z0f4w584idF5S1EYhNJ4de9ViTO1eQeihTyI2vzGBfHdiibA476Cdyihy91z+XqNHKGDy2rNyjIB/KoV++T/lFoJrsI6taq06vJRsG/mC/llc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482860; c=relaxed/simple;
	bh=CIxCH6YcsQLLa6WaI9HryHRGmwk1TiYPorLZqSeDpwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTCAGr4yYU6gculonfVrgLCTYteiKI3DLVRHCI2ltERtfNvNPdcWFpraFpcnLG1kvRYB682Aa5GsdpPBZ9ifHbgM+EvEGPQLi3B4pxeJS7LE7KYDAAjsFtRfPTi1lit5n+53KEG7qu1dK4+t29XZ5bxvJBtc36o4QeQ0pxzHAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjsl3iax; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716482855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yxyw2zAEWN0qKyw9lUKHC/W91e6x9aQtxaZ2fTDMCmw=;
	b=vjsl3iaxU+RHw65eH+palqJsGUULJewGhcQljNK+CS9L4f4UpVkRt9aNeVcTPJ4mbH6QdL
	Y6154HLxwqG3Ocg16EbQ5kfNs9AcaZcQCnGvmI3bTyFy94itcvMlPr62u4EzhHEMy8e14l
	3yHgjhViAat5ZktvQg5ew7tSoD/fIeQ=
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
Date: Thu, 23 May 2024 09:47:30 -0700
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
Message-ID: <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
 <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 03:48:40PM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
> On Tue, May 21, 2024 at 09:18:19PM -0700, Shakeel Butt wrote:
> > On Tue, May 21, 2024 at 10:43:16AM +0800, Oliver Sang wrote:
> > > hi, Shakeel,
> > > 
> > [...]
> > > 
> > > we reported regression on a 2-node Skylake server. so I found a 1-node Skylake
> > > desktop (we don't have 1 node server) to check.
> > > 
> > 
> > Please try the following patch on both single node and dual node
> > machines:
> 
> 
> the regression is partially recovered by applying your patch.
> (but one even more regression case as below)
> 
> details:
> 
> since you mentioned the whole patch-set behavior last time, I applied the
> patch upon
>   a94032b35e5f9 memcg: use proper type for mod_memcg_state
> 
> below fd2296741e2686ed6ecd05187e4 = a94032b35e5f9 + patch
> 

Thanks a lot Oliver. I have couple of questions and requests:

1. What is the baseline kernel you are using? Is it linux-next or linus?
If linux-next, which one specifically?

2. What is the cgroup hierarchy where the workload is running? Is it
running in the root cgroup?

3. For the followup experiments when needed, can you please remove the
whole series (including 59142d87ab03b8ff) for the base numbers.

4. My experiment [1] on Cooper Lake (2 node) and Skylake (1 node) shows
significant improvement but I noticed that I am directly running
page_fault2_processes with -t equal nr_cpus but you are running through
runtest.py. Also it seems like lkp has modified runtest.py. I will try
to run the same setup as yours to repro.


[1] https://lore.kernel.org/all/20240523034824.1255719-1-shakeel.butt@linux.dev

thanks,
Shakeel

