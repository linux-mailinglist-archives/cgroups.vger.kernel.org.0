Return-Path: <cgroups+bounces-2962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B88C9884
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CDF1F22410
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 03:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46071E554;
	Mon, 20 May 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZOl4Brx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128ED27D
	for <cgroups@vger.kernel.org>; Mon, 20 May 2024 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176985; cv=none; b=kWfmV/h4Oa9fWv+JfZI13ahXmlTWR1jevIMApHGbiKLBG2kyrIDbm4QMZxQKCtv+93LmbqRR3x10Uq17MYgMzKqY8bIRntvG76hoUIaGCGlaal0+6P62tXONxNYm/s1Qe8FC5QMxUFlwz6JFBzWi/1sadyJd853+jT3BPT8To38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176985; c=relaxed/simple;
	bh=6cCGa9/+ukACx/UoNT66OKid7I5/EO9l5H48Y3iZ/ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5ZuDJJRBYFQLiCd2SwlxCOf1VPBu4v5JsteO2hDmTJt60SLet/iTO9fKvRYavVamhMd0KsOyC1Swx1y1+7tULnmMVrRSFod4281EdTcmRLZRAS5pmE32+X3eTQ3wZ4Gc5zRVe7MBgJuQnxrw1F4QySTJDsqO/EKvhUh9xHEQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZOl4Brx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716176979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sO8t5Z6tRQdA5UqsCIe7yGv+cRLvsFB3v+ulXQlOA0U=;
	b=HZOl4BrxH2xaTjntz5P+91eo0G/SyyS6jMnMQmiAPs5e6E4BOtricSyypKxXtyOswCa3bI
	FdoBMK1LI+NCtMMdA6DIrkDzy2mVe5tcUjMp6UdPDeguoj6Id9ct004huuAvAXIDxzCM+Z
	vnV9UqmYHh29S3CdlD0qrn5Z1lH31F4=
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
Date: Sun, 19 May 2024 20:49:33 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <20240520034933.wei3dffiuhq7uxhv@linux.dev>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Mon, May 20, 2024 at 10:43:35AM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
> On Sun, May 19, 2024 at 10:20:28AM -0700, Shakeel Butt wrote:
> > On Sun, May 19, 2024 at 05:14:39PM +0800, Oliver Sang wrote:
> > > hi, Shakeel,
> > > 
> > > On Fri, May 17, 2024 at 11:28:10PM -0700, Shakeel Butt wrote:
> > > > On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> > > > > 
> > > > > 
> > > > > commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > 
> > > > Thanks for the report. Can you please run the same benchmark but with
> > > > the full series (of 8 patches) or at least include the ff48c71c26aa
> > > > ("memcg: reduce memory for the lruvec and memcg stats").
> > > 
> > > while this bisect, ff48c71c26aa has been checked. it has silimar data as
> > > 70a64b7919 (a little worse actually)
> > > 
> > > 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803
> > > ---------------- --------------------------- ---------------------------
> > >          %stddev     %change         %stddev     %change         %stddev
> > >              \          |                \          |                \
> > >      91713           -11.9%      80789           -13.2%      79612        will-it-scale.per_process_ops
> > > 
> > > 
> > > ok, we will run tests on tip of the series which should be below if I understand
> > > it correctly.
> > > 
> > > * a94032b35e5f9 memcg: use proper type for mod_memcg_state
> > > 
> > > 
> > 
> > Thanks a lot Oliver. One question: what is the filesystem mounted at
> > /tmp on your test machine? I just wanted to make sure I run the test
> > with minimal changes from your setup.
> 
> we don't have specific partition for /tmp, just use tmpfs
> 
> tmp on /tmp type tmpfs (rw,relatime)
> 
> 
> BTW, the test on a94032b35e5f9 finished, still have similar score to 70a64b7919
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale
> 
> 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
> ---------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \
>      91713           -11.9%      80789           -13.2%      79612           -13.0%      79833        will-it-scale.per_process_ops
> 

Thanks again. I am not sure if you have a single node machine but if you
have, can you try to repro this issue on such machine. At the moment, I
don't have access to such machine but I will try to repro myself as
well.

Shakeel

