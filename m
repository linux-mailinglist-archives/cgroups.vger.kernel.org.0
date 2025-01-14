Return-Path: <cgroups+bounces-6151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB54A11053
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AE81658BF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2A1D54E2;
	Tue, 14 Jan 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0mr7wuG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAF1FA15B
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879972; cv=none; b=EG5cgdmvvbcOSG8nJEKhpyRKrb1Yip3C8YDsCr07aBF+G9OYEtoW1FkLWQm/EFSitXF3mD/qQ/DSLK6MDcrARpTkdWC2/ucHGj3G6BtpnAEDcAah3hVQNHJ98XBWtkjVkZbUMn3RkukkrRRg0TrH243ybGOElYvbgymua1+k5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879972; c=relaxed/simple;
	bh=3Qd60WO1MzYWIY/6NHCmYgT+Ufv7E2dAOkGX/fkwER0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr88KywIrYE3maW1LUM6PZ7DBjY+XqgI5a4swL5JzrKw013dmrjesDW4So4s1zc9CsW+IsrZWvD1DGtEF+xLwDERsL0ezAdUZoKsXid7AvxMd70uE93u6MsLeq+GnjFpABRU3iQWmqs6Y3mk/qbeFqKZXpE1p45t4GoqEMdSeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0mr7wuG; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 18:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736879968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3s/m86XDhNPZpeC6SALb78gz4i2UYER5cvYC+d8x0Q=;
	b=X0mr7wuGdnFj/k4VqYOqhZ6kGoaoOOC3rRbzV1tSj4OQqZY0o2zwqVhCbOZIPI9CysgfvK
	LsZj0YLVNQWpNSv3Nv7PQOS7XrSkFYqUHtP0oxKUY697ev46eSYYvzrIgbNZBPsrM2pX28
	uGjRtBSG3k8Sh3NKpcmg9Rxg+tKcKZU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 3/4] memcg: factor out the replace_stock_objcg
 function
Message-ID: <Z4avW3fQQ03YnwNr@google.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114122519.1404275-4-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 12:25:18PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Factor out the 'replace_stock_objcg' function to make the code more
> cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

