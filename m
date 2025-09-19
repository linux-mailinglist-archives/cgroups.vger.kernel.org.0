Return-Path: <cgroups+bounces-10300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B01B8B5AA
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 23:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A545C05E1
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 21:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198B2D374D;
	Fri, 19 Sep 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hF8zs77A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2631A2C25
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317599; cv=none; b=uwa8xAnSxAeJSzoW0VrgrRbzYpuVDUot4z16LNyzjwWs0HjWSaopsq+rMbgFGzDYptEDGgMFKH593HiIgZKST6GnbeBYB/gr5/e/c24os2UizlzoeUq9bYSdysZIS/UM8u6vQShnqGNQt7d51wsDIcBaQwyZM7DW1R9jiYSP4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317599; c=relaxed/simple;
	bh=Ns/+VPk0JRgcfRhAmovRGTcun/6s1/Z3qmXA/COi+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMq4ERCpw8OE0S/cvqEobwk1o350+cdTMbtteK5YSvHszbb4D0W3mpIyHVQ8jwGAwplJMM5dRw+rxNBhcK8tKMLRYVEq8PfZjUr7QJKXpRV7EHblopJGbSj8wLjYpSahXKT1lfIJBTvcp+GNIn+WjubRR8whpsClBK9keOT3q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hF8zs77A; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 14:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758317594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Px33pcPC/3cjqyKF20QTwtd0R9MElM1aDgx8WhLopuE=;
	b=hF8zs77AfTFqlzlADpfZ/I7F7naSbcZ69FSeZIbmveId4wYFEwCfzXnvB5Tjn0Gobf3UdO
	hAdxcxsrW3C/Mg31+iUDWuwpH3FbvB/BbwVcwKoY6fvkgvd+00iOU5Gk4BYUEevJML37Wh
	qIjX/uLm5bn1uKBDZXMUdk1dq4tbzTM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/4] reparent the THP split queue
Message-ID: <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Hi Qi,

On Fri, Sep 19, 2025 at 11:46:31AM +0800, Qi Zheng wrote:
> Hi all,
> 
> In the future, we will reparent LRU folios during memcg offline to eliminate
> dying memory cgroups,

Will you be driving this reparent LRU effort or will Muchun be driving
it? I think it is really important work and I would really like to get
this upstreamed sooner than later.

thanks,
Shakeel

