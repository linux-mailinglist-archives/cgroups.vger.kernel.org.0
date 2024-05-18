Return-Path: <cgroups+bounces-2957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4C8C8FCF
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E4228413F
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5570BA33;
	Sat, 18 May 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UyRL1vRZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9C1A2C10
	for <cgroups@vger.kernel.org>; Sat, 18 May 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716013701; cv=none; b=s0rlynidRqX/5DwFeA0e4AMN/8jkNXxrsp7qjJfIn1XtyZ9sVB7GNsimw4BhrlOcWfsRXSg+hUpGKBG/PIYhsCe0RAawDjuZBiqiypF5UUEWM668yMRujJxQk760dPF1uJfOxjFy7lnWsQQ9tovMm2mk3PB3dVCQeZXCA+KoUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716013701; c=relaxed/simple;
	bh=vvMlznBsKNTSBWhpwp2ZqTfZ52TtDPKmHr9jXo/qxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLCsifhUKrMwKRUmxgz+cMZfD7cRERkv63oxSzOK/D9+3jjWu9yZFzySIncUmyf3KZITCc9wUcDbaZOa/kPVh4nYXCmjygGFB5PUWRKEr/UMvNm+T3zOD+QLasH6KnPVmEQ5qQPUN0rt7Dg9GTOwGCJzPS1IaqqiFS2l9KNP8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UyRL1vRZ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716013696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7h+APmB8dtD6YiYGS84ZpIBmAIBGFHKOILm27LTujM=;
	b=UyRL1vRZJVcs8BWpDnqy6b3oLE/H/c2c2L4dWsPdpPtJC/wnHQu3z9KGXpddLuMBFBDR2V
	IOef7GTIxejZY1aQpGvfEefbwKng1hfHaR7V3QuodyCQQ90DPBoebZft0XteKKesJMmaxg
	GbvPP78Hh+iXZClYsdH3RkQtTh4oJkU=
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
Date: Fri, 17 May 2024 23:28:10 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
References: <202405171353.b56b845-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405171353.b56b845-oliver.sang@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> 
> 
> commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 

Thanks for the report. Can you please run the same benchmark but with
the full series (of 8 patches) or at least include the ff48c71c26aa
("memcg: reduce memory for the lruvec and memcg stats").

thanks,
Shakeel


