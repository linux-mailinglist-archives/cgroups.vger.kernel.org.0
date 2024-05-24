Return-Path: <cgroups+bounces-2998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692F8CE958
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC913B21629
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B293BBE8;
	Fri, 24 May 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CzCYRIqk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA23B290
	for <cgroups@vger.kernel.org>; Fri, 24 May 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574026; cv=none; b=MqY8KlxZE2qn2PfygCf/31KHxzm5oiFp2azZfNwz3nRVYgjV5ckzimvJpYrz4MT2Gl3nXKVm90dYZN64PZ/npxSeMME7SKAm/YrRKHgIdrEHn+piI9cWcfzTEKWhhTTkdAESMsX66EbAQ9UKflBC/9fZNF7/osz/h+8p+m9HmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574026; c=relaxed/simple;
	bh=+yalLxB4yvGtdiSeqqSVRqVwmlqPZu8e/vNX5Nr/pDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He78EeXWCpzcoxtQP6R16kqb0JI/qhXkespQci2q136aSBgJu28GvHeQKTxUv1ggfYz0aPz7et3h+sptY1c1Jerr9fLacTGQCol3+cMYS9Zp0Z6dOF8S5VMBp5bGQhcsePkbmyg7n/f9ywW8/hbPOBQKPUld34lPxyS6hKGD1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CzCYRIqk; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716574020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDgNlxcmbX6SMIrBizByyCwxnmHxeA7yY8zL5+NMTsw=;
	b=CzCYRIqkeylIyXvDionKYbCNCGay0hGXS99GHgIWwd5C1jk5WaZbGpZtxmm3noUHV9XG2k
	mgDWUyTmEjb329zjGJQLfbvwnEOC1eETy7qHmDXsHb1RaRUfQ6gJdEqM+tI3KCRe4qWLVu
	ddJny1VrghI8tNtIKYq1S192KtbQpqU=
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
Date: Fri, 24 May 2024 11:06:54 -0700
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
Message-ID: <uzqh6xvoe6xgef3i6743m7gld5tlqp6h2krcqgjre3nzfcogwz@gsllvs77r57a>
References: <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
 <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
 <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
 <ZlBFskeX3Wj3UGYJ@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlBFskeX3Wj3UGYJ@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Fri, May 24, 2024 at 03:45:54PM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
[...]
> 
> > 
> > 1. What is the baseline kernel you are using? Is it linux-next or linus?
> > If linux-next, which one specifically?
> 
> base is just 59142d87ab03b, which is in current linux-next/master,
> and is already merged into linus/master now.
> 
> linux$ git rev-list linux-next/master | grep 59142d87ab03b
> 59142d87ab03b8ff969074348f65730d465f42ee
> 
> linux$ git rev-list linus/master | grep 59142d87ab03b
> 59142d87ab03b8ff969074348f65730d465f42ee
> 
> 
> the data for it is the first column in the tables we supplied.
> 
> I just applied your patch upon a94032b35e5f9, so:
> 
> linux$ git log --oneline --graph fd2296741e2686ed6ecd05187e4
> * fd2296741e268 fix for 70a64b7919 from Shakeel  <----- your fix patch
> * a94032b35e5f9 memcg: use proper type for mod_memcg_state   <--- patch-set tip, I believe
> * acb5fe2f1aff0 memcg: warn for unexpected events and stats
> * 4715c6a753dcc mm: cleanup WORKINGSET_NODES in workingset
> * 0667c7870a186 memcg: cleanup __mod_memcg_lruvec_state
> * ff48c71c26aae memcg: reduce memory for the lruvec and memcg stats
> * aab6103b97f1c mm: memcg: account memory used for memcg vmstats and lruvec stats
> * 70a64b7919cbd memcg: dynamically allocate lruvec_stats   <--- we reported this as 'fbc' in original report
> * 59142d87ab03b memcg: reduce memory size of mem_cgroup_events_index   <--- base
> 

Cool, let's stick to the linus tree. I was actually taking next-20240521
and reverting all the patches in the series to treat as the base. One
request I have would be to make the base the patch previous to the
59142d87ab03b i.e. not 59142d87ab03b.

> 
> > 
> > 2. What is the cgroup hierarchy where the workload is running? Is it
> > running in the root cgroup?
> 
> Our test system uses systemd from the distribution (debian-12). The workload is
> automatically assigned to a specific cgroup by systemd which is in the
> sub-hierarchy of root, so it is not directly running in the root cgroup.
> 
> > 
> > 3. For the followup experiments when needed, can you please remove the
> > whole series (including 59142d87ab03b8ff) for the base numbers.
> 
> I cannot understand this very well, if the patch is to fix the regression
> cause by this series, seems to me the best way is to apply this patch on top
> of the series. anything I misunderstood here?
> 

Sorry I just meant to make the 'base' case to compare against the commit
previous to 59142d87ab03b as I said above.

I will re-run my experiments on linus tree and report back.

