Return-Path: <cgroups+bounces-13161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4CD1AC8E
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4666306E591
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FED2D7DC4;
	Tue, 13 Jan 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlHeVN7y"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41ACE555
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327400; cv=none; b=FtdOl+e60wXU+SfnOYcrFSE4Zq2wY0yNnZ55byYFmtPR0BqRFMGayqXSkwze+HpnJDuUrxi+hnmWuUNJRu8Uru20Sc3qKLHM6JlNAWgq7BPTcy27HRWM/dU2WOBsr9s34dLrerN4EhFtaOItds/rSUR2uF0KEworYFoU7UKsolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327400; c=relaxed/simple;
	bh=vO49vK5pMUvwf0YTRaeHEuRLpSt4tRR/SKeQS79ALcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMOOBWOOXRAgkEShAJY2b83AxOsAP0dfpX+zbPwoh+QgadFIUFXxFayet0UOUoWSXx8/9nOTat9e+4EB/6PQecJKjAOZOohXgT0F21HnAIH0XZC3Epw/g8/qvbAi9kfJJHbiMbHdEUk+CF23G4sJR0UAtpLJ5ACZPwQU86kEt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlHeVN7y; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Jan 2026 10:02:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768327386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6vnju4rgxejMiIuLIDciDiSFQtiQcgq3dIXAnV1zY0=;
	b=SlHeVN7yg51Kwf2Jww/oqTDrxn9DAqIBMIrjHQrUO7r27AAwJ76KRU+P3gIdaLxjHwuSp6
	UgnwfHzU+oLleRo7xSnFvSEjHsqQSpAK31KqNSz6pPvCR7l2nmeuHpt1efaFiwhNv1AsR5
	Jh/iqXjkDCbfORrnKhQY0MdrCtZWZlQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org, hughd@google.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <oo7re4nov5jar6nzu7awvbwlclh6esp3mltiflylzltjt57dca@jbt3hs7kgb7i>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <aWUDXtsdnk0gFueK@tiehlicka>
 <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Qi,

On Tue, Jan 13, 2026 at 10:34:08AM +0800, Qi Zheng wrote:
> Hi Michal,
> 
> On 1/12/26 10:21 PM, Michal Hocko wrote:
> > I can see that Johannes, Shakeel and others have done a review and also
> > suggested some minor improvements/modifications. Are you planning to
> 
> Yes. I'm working on them (mainly non-hierarchical stats issue reported
> by Yosry Ahmed).
> 
> > consolidate those and repost anytime soon?
> 
> I'm testing it locally and will try to release v3 this week.

Please take a look at the AI review posted by Roman. IMO it does have very
interesting comments, so at least go through them and check if those
makes sense. Please point out if something doesn't make sense which we
help us to further improve the AI review process.

thanks,
Shakeel

