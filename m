Return-Path: <cgroups+bounces-12567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EFCD4A79
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E99AB3004CC3
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4757260F;
	Mon, 22 Dec 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CubJn3AN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B2199230
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375392; cv=none; b=oSfhRNJOCeECQrdnox57ZFQClTK2ncthp2yANoB8Ouje5O4XHfyo6oeZcMF2Rv3LdPOIcYNehnAGkknsw5egsUbty/VEOixdnBe5w9Gdzbxq0sB78Lk56XZzxOJNZV2ccffHtMVhZBW9mb4p/7RuQr0vtJy4cIFalqfxd+OubG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375392; c=relaxed/simple;
	bh=ZKBKDyIf9aNl9ZXxo2pKhG1CGsCvMu5NEzkBAwecv2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB/ZXEIgs/+qfwd52dW50I29a47bQTMnVzXMjMBrwiO6YPtHhrpIEOb9Vshuz9/XjVUIWtiXQq5np2CrZiYL5vwtRrHPLqbXRII+SpDnR77Kz6Xy6dlM3ZQmSCF31do84w1pFE5PtjoJ8mi48W8zT6ur//kJo459f/B4LlQdZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CubJn3AN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Dec 2025 19:49:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766375377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWtO2zr1nSZbFFTYCOCRQr/+4k/J53t+G3n+jZ7uCYk=;
	b=CubJn3ANnS6RtnAXOMiFKILfrbjbKzo5g8zBWH1n9uvolk/8eBB55AkKcKKq59hn8ynGkG
	IguJvE3mlAc4K6URHr9stf72+kL03aeSVq2yeoMTSIoGGsY0gunvROZsBErbArNjOvbPP2
	eLZIS9vLy48ZSaGr/0S20xmoUHX88Gg=
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
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen
 and non-lrugen
Message-ID: <7oyimceude4iqtc6z6e2l2l2em236qa3s6r5daf4c64mzmafp5@s5ayqhbow7s4>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-4-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 09, 2025 at 01:25:55AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, flush_reclaim_state is placed differently between
> shrink_node_memcgs and shrink_many. shrink_many (only used for gen-LRU)
> calls it after each lruvec is shrunk, while shrink_node_memcgs calls it
> only after all lruvecs have been shrunk.
> 
> This patch moves flush_reclaim_state into shrink_node_memcgs and calls it
> after each lruvec. This unifies the behavior and is reasonable because:
> 
> 1. flush_reclaim_state adds current->reclaim_state->reclaimed to
>    sc->nr_reclaimed.
> 2. For non-MGLRU root reclaim, this can help stop the iteration earlier
>    when nr_to_reclaim is reached.
> 3. For non-root reclaim, the effect is negligible since flush_reclaim_state
>    does nothing in that case.

Please decouple flush_reclaim_state() changes in a separate patch i.e.
making calls to flush_reclaim_state() similar for MGLRU and non-MGLRU.

For the remaining of the patch, I will respond on the other email chain.

