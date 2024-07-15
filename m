Return-Path: <cgroups+bounces-3690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F702931D1B
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 00:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B9E1C21992
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D313C918;
	Mon, 15 Jul 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGceJGDY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF061FFA
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081930; cv=none; b=CKzyayD2qWOZdN8T/oKXPYAQbINKAEeXGDqshANZJPBrojEC8m73bYUTtLhjJkc/isikLgmyGq+uK21rm8DBTxGe3MBmN0KhV6tisJ7J+cfqbE+oBcOHyYv3l+s9GEpRGSPqftx43EhtIlJszrzCkZy0cmaBBNkpQX1nqvsvMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081930; c=relaxed/simple;
	bh=uUDJlFQNtryZCyjLm2hTdZxko2VvJirRXSKkH/hzgS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWX5+3hPSC1uS7e+JWysk+uG8mAb+d8DaLIAwhV6Mj1fjkSCAJSPZgJ/OHihDTJVhazOWxSgPTE4IZJ/k8eZ1N+ghH2YZW/7lGd1p4z9XUZIa89DmF5q0VWTBH+Oi9vG57epX2xiMomxcuXGZxIjEbmfzGjYKCYEkhRcWhbwfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGceJGDY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721081925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7bEFxNiJqRfyC/mXt6ygUCHixC1nCej/Q7vGVmvLrw=;
	b=GGceJGDYQ/HGmUtPaoTlyt96ECaP1FIhIW0AY3LKqmjh4Q9yhl4Zj7AY/FDB+vi/7SAExK
	a4pqcAtHvmdSImaH3nCx721Eqy/xNaljA/ym5F8sht88enRNAOGHQu8Bo5V97612h9ELFP
	IP9Yq5cjcXyv6qDDX/bLbv1T5AUpNGE=
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
Date: Mon, 15 Jul 2024 22:18:39 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <ZpWgP-h5X7GKj1ay@google.com>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> hi, Roman Gushchin,
> 
> On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > 
> > > 
> > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > Hello,
> > 
> > thank you for the report!
> > 
> > I'd expect that the regression should be fixed by the commit
> > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > 
> > Can you, please, confirm that it's not the case?
> > 
> > Thank you!
> 
> in our this aim7 test, we found the performance partially recovered by
> "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully

Thank you for providing the detailed information!

Can you, please, check if the following patch resolves the regression entirely?

Thanks,
Roman

--

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 60418934827c..3aae347cda09 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -110,6 +110,7 @@ struct mem_cgroup_per_node {
        /* Fields which get updated often at the end. */
        struct lruvec           lruvec;
        unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
+       CACHELINE_PADDING(_pad2_);
        struct mem_cgroup_reclaim_iter  iter;
 };

