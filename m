Return-Path: <cgroups+bounces-5945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B269F5542
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E850177D9D
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72F1F8F0C;
	Tue, 17 Dec 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ThbVEsqV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C11FBEAD
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457653; cv=none; b=LaRBl2ayDF41kQrXa1KKjszd8vSgGOWRS+j3bz8BYrbV6tvNJb3tThEQYyBcNhj312S92Jay9QYiQN+xrAsF7GL3E+kEmL0sQXYLS1l9OptQR70KSYldEhAKdQEvvP2Liw3kAfS+GqcHcVh1PK7JDva8m/kOhEF888F8NvcZK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457653; c=relaxed/simple;
	bh=nAhnRDYH5N9e9AsjkG0LCK1Ez9FQFMjqHZOKdMPC40k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUD/yAiEA6C6dihRHAG6JKWdhqr/htluXb5YYSzDQK7lWFyQm1Nh/wJx/WENC5b5/2zXfxYQ4eT8zMH7iL4NYEVFx0f/BWIhZUKzoqP+RsJKUdgB2uhEAdDLJ0ihrpPFcluUnic8NsZVOw+t6NdxDFSUEk1FViIDqc0Fwm/5FFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ThbVEsqV; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 09:47:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734457648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oT6qdtt4X2SclLzmcXRZduUzcDzTjo2eXbPGBENWVY=;
	b=ThbVEsqVkf95WzUk5bKSc72HXekSTw1guo5ila3Hxv9wAGBxCFf+KtMqCN6YnrUFSJSdan
	hF5KxuRSidKFxoNAex0UIz2d8/n0f1WDG2IpZzPt5UafxBgKJ0Tox2KTBEVZ461kXNBiwR
	7LzftM+UoYgn4VD2dCj5QSJmKnW//Co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <axqbyleou7rovp6ib4urclqlxca6sotwopmtf6gxyezbeaom4q@t3s23xq3ecjl>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 01:35:08AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

