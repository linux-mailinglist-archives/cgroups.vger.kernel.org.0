Return-Path: <cgroups+bounces-2959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEDC8C9585
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 19:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D598B20D17
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE605482FF;
	Sun, 19 May 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RwJ//AYT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748B1DFCB
	for <cgroups@vger.kernel.org>; Sun, 19 May 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716139238; cv=none; b=VRzz2oZp30AmWoNiBAZ2HqR0G6VkQTfaAEZIqSC11PQ2KGt8CkesLZg5KcN45tpCPKs9Pv4sxVVr68kqG+GAr6fS0nSH2pFAL2E1UmCIttkyVYteNfmruj6nDDv8Ozol2XAMWeHAlfRHquKWDSlAfdVplIhXI8R9aJg1A2eXsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716139238; c=relaxed/simple;
	bh=taMqArjcxCqatw4IfFUnrIiQ1im3npdTcAzunmO0uks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAaTSkoRM93dsecoRHexLDAxUlyO25G/sG9ezA9WAHouyPNKNoFm2hijUsK6yh6E7O5Xo0coPXew3s7968VBv8phapsnOhuwRPUQPLg8e8Dujw6tncUWPH9XwXnvuX2Vpro2wbVZFtj+2esldVZ942RYpC55NG5Tp8/3OEHIneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RwJ//AYT; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716139234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvHbKMGIEEBbCjoVkxZXKJCvmBxbvIxeoNE8YxwoCwI=;
	b=RwJ//AYTEDyiz2yzSohwa8IO2PtoG8C+lvATn39MWMuKVDRNLGjDpoVgUwhAUiDy5raEBW
	MyApbcTF4EDOxY43mINP7aSblMpeac/cBmEBZpWBd+wqhcVGbajwpzYfSB2wwWoR1LWadZ
	vnNlzct3wlmV3ENmtPNIqPqjK8H6YNE=
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
Date: Sun, 19 May 2024 10:20:28 -0700
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
Message-ID: <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Sun, May 19, 2024 at 05:14:39PM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
> On Fri, May 17, 2024 at 11:28:10PM -0700, Shakeel Butt wrote:
> > On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> > > 
> > > 
> > > commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > 
> > Thanks for the report. Can you please run the same benchmark but with
> > the full series (of 8 patches) or at least include the ff48c71c26aa
> > ("memcg: reduce memory for the lruvec and memcg stats").
> 
> while this bisect, ff48c71c26aa has been checked. it has silimar data as
> 70a64b7919 (a little worse actually)
> 
> 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>      91713           -11.9%      80789           -13.2%      79612        will-it-scale.per_process_ops
> 
> 
> ok, we will run tests on tip of the series which should be below if I understand
> it correctly.
> 
> * a94032b35e5f9 memcg: use proper type for mod_memcg_state
> 
> 

Thanks a lot Oliver. One question: what is the filesystem mounted at
/tmp on your test machine? I just wanted to make sure I run the test
with minimal changes from your setup.

> > 
> > thanks,
> > Shakeel
> > 

