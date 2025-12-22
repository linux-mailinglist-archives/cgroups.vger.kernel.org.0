Return-Path: <cgroups+bounces-12590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E840CD72F0
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36962300FE0F
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7683009C1;
	Mon, 22 Dec 2025 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XXc8sb9N"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEB2DEA67
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438302; cv=none; b=kPKdWG4WzrFQ7oFGRJ5pbGWB5G12I+MXptrz5AaYgVgyMDASkJQo7/rhS9JdSXqLLYe7d+U6yqaojhPji1hP2GMFmdUuioQvisya42a7M3SlWiFTtF5pB63nVlxFe/mx3B2/iGnyxdsDbkDV21cysD7EiPfzRLD7XclsegK49hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438302; c=relaxed/simple;
	bh=ttWVVM7HLB5GBVmAMxfx/AMMnlK5gq/P5KJxfQRvi6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFsP7vQNQODdYSpfAzSUrFfF1wv5xUR16y4YUb3TO9HTIenrKC3VNPqle62TGBdpfyWXI+jDPl4iCvNRTDaUSxU1oFNt+dPwmzGYTI341px4j2rVzkm31Qsssb8t3hpIIKWU2DE2TJnGZ1HEg4KfQAopKnspVLx/IRu7PdJBnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XXc8sb9N; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Dec 2025 13:18:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766438298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaxUjlZxSdQz9/5dRF6Cc68Fz36EXnwL9Uc3LhEeHkM=;
	b=XXc8sb9NyRg7njft/+mJ44wRJyMaMGjFqvXQSSqukW9hsuDuYBVGMhKnxkNAc3w+MM3YzI
	E3f3eHGP7RLPm2E+XMINKkwPm6wtt35Meyhyh572Afp0YFmi1ks3ZYGHfyQpwtensNeX4Y
	+kwmwRnsCwqmV6Orlgi6NIpWqTdZitU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, zhengqi.arch@bytedance.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 1/5] mm/mglru: use mem_cgroup_iter for global
 reclaim
Message-ID: <c4fjngkwbjlfnbjl5merldg5k2fiu43p46osagmy3ibr62cgxh@oesgt5l35kns>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-2-chenridong@huaweicloud.com>
 <gkudpvytcc3aa5yjaigwtkyyyglmvnnqngrexfuqiv2mzxj5cn@e7rezszexd7l>
 <702b6c0b-5e65-4f55-9a2f-4d07c3a84e39@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <702b6c0b-5e65-4f55-9a2f-4d07c3a84e39@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 22, 2025 at 03:27:26PM +0800, Chen Ridong wrote:
> 
[...]
> 
> >> -		if (should_abort_scan(lruvec, sc))
> >> +		if (should_abort_scan(lruvec, sc)) {
> >> +			if (cookie)
> >> +				mem_cgroup_iter_break(target, memcg);
> >>  			break;
> > 
> > This seems buggy as we may break the loop without calling
> > mem_cgroup_iter_break(). I think for kswapd the cookie will be NULL and
> > if should_abort_scan() returns true, we will break the loop without
> > calling mem_cgroup_iter_break() and will leak a reference to memcg.
> > 
> 
> Thank you for catching that—my mistake.
> 
> This also brings up another point: In kswapd, the traditional LRU iterates through all memcgs, but
> stops for the generational LRU (GENLRU) when should_abort_scan is met (i.e., enough pages are
> reclaimed or the watermark is satisfied). Shouldn't both behave consistently?
> 
> Perhaps we should add should_abort_scan(lruvec, sc) in shrink_node_memcgs for the traditional LRU as
> well?

We definitely should discuss about should_abort_scan() for traditional
reclaim but to keep things simple, let's do that after this series. For
now, follow Johannes' suggestion of lru_gen_should_abort_scan().

