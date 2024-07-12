Return-Path: <cgroups+bounces-3659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8C9300A7
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 21:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F150D2835A4
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305F1C695;
	Fri, 12 Jul 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WzRGuiVQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0A20DC5
	for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811021; cv=none; b=G9CHHH1R7kANYMOzJ6e+X+GILRLVnfpn4se/PeGBz2uX1S6OG5Noj6BAbZxFi0rK+n5YhK++mO7pM5o8ntR9i6iBARDipcnWwlOJJgWJcRNCl2msBx0eBHiiLuag67SBJopXdTx/Fc+ZDQqa6u/z5Re9tFw5L3na+UqwD1bWHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811021; c=relaxed/simple;
	bh=CtM4FGwNaaAB6iqfvkVdldke1e2NZnvN4Dw2cpw8N/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlH0gj94xsel283rYFxoHLaMsvRNZV2LFS8V1/BESFA8Xf0UBQHG0qZYYYQBF2iK2WWGAnUqsDUqMrPb+Q9Zh4Jenrk7ULyKYz84zKLN+Sz1iqJGYBsqpaM7TpxT37gS7Xuy5F76/+HQvsLW+8KDXIERNztZN9qws7Q7LbS1NX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WzRGuiVQ; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720811016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xokTGIcbCZnOMGy0HZ37jDBn5F/GMmCC7eG7GDBjcFQ=;
	b=WzRGuiVQSmqYLqsiWmtfR7l++VDbVBDv/TAs2Um2Qasw8mzbR3J/WdP9pScAJrN7nRkV83
	5nyf7Pe+V7+FeWbfhTAHiYbTIYqFWb4Sr6qeE+2PTOgO1jakDakMTEfrc2gK+VWeLi9p5R
	2yuyt8gQ3Gg/sYchbg6QrbrNC3lg2iQ=
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
Date: Fri, 12 Jul 2024 19:03:31 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: kernel test robot <oliver.sang@intel.com>
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
Message-ID: <ZpF-A9rl8TiuZJPZ@google.com>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407121335.31a10cb6-oliver.sang@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> 
> 
> commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Hello,

thank you for the report!

I'd expect that the regression should be fixed by the commit
"mm: memcg: add cache line padding to mem_cgroup_per_node".

Can you, please, confirm that it's not the case?

Thank you!

