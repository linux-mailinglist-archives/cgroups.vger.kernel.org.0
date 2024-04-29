Return-Path: <cgroups+bounces-2716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40188B56E6
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACDB1F26173
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59B481BE;
	Mon, 29 Apr 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoteHLpo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82144C87;
	Mon, 29 Apr 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390585; cv=none; b=AM1ZT45M6zcI5rWoZAYiEmxtfHNBSA4Yw5RsmMOQMsPI5UNcjo97VAPGDhSI3r1xg/HwQI+GUjhIZksmzkAnD+3NKA4SIF83M8Fs8KCBGsCmXQi3Croh1jiJtQ5D04Yr0jEFCJ0Vp/twZGXUquXmgq0GP60ORGVFGMZwK0w8hCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390585; c=relaxed/simple;
	bh=pW4q+Ms5JJAaPWrYlwZ6qTOWYSfW5QeO9KUHreTbyqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSti7NZlCgnWlANPWmVtnDPq9DFA5nqnYU2PnL2l9NcowMQWvy1FyQumzkLpMUVGeL/Bk5UINykwl8i83NQKiaImJd99ygotkokxJ3xqKDBsVF/sdwYZpVXoZ0gEPhumk6KmW/EF0DKvM5droicMuPGQvUwC0Y1fn3xH605F8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoteHLpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239D8C113CD;
	Mon, 29 Apr 2024 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714390584;
	bh=pW4q+Ms5JJAaPWrYlwZ6qTOWYSfW5QeO9KUHreTbyqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GoteHLpouWGXccfFDzZzPcBUmPUzUVAXMSfKJKNFdwI6id8I5FzWv1rQGs92sLr6S
	 Gr0EblQ1T0ZRDfwhVK1vNhXEQcam5PTiqv9pDQ2ttckwwnF1H2Z3IFVzWR1klYA1zA
	 ohGQxHanHXjfv4+bUPubnhamjczy8Z+OWpl7yNl98kYNrLupoBcGIiyxs/P2baox3C
	 BfnR19jJiNLJDWybIjRToqNIK3RzVRX2Ji0ssMjEkChMl5j4IoGCZWKNGUvdNX/Y+T
	 UGNk7IT8PFg89scGqxLNk4tBj38/GHGl9lImI7KXRbKa/d0VcjjVKPP3YK86qtLYP0
	 TDANw2Q4wWMUQ==
Message-ID: <21dd3b6e-6e7b-4dcb-9050-4d63fc810749@kernel.org>
Date: Mon, 29 Apr 2024 13:36:20 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
To: Simon Horman <horms@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 shakeel.butt@linux.dev, kernel-team@cloudflare.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328988660.3930751.17537768209042139758.stgit@firesoul>
 <20240423165350.GY42092@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240423165350.GY42092@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/2024 18.53, Simon Horman wrote:
> On Tue, Apr 16, 2024 at 07:51:26PM +0200, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>   /**
>>    * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
>>    */
> 
> Hi Jesper,
> 
> as a follow-up could you add an entry for cgrp to the kernel doc above?
> 

Already fixed in TJ's tree for-6.10
  - https://lore.kernel.org/cgroups/ZiB97v73Fr-wq14f@slm.duckdns.org/
  - 
https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-6.10&id=97a46a66ad7d9126

But thanks Simon for your vigilance in noticing these things :-)
--Jesper


