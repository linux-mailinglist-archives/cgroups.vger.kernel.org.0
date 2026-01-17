Return-Path: <cgroups+bounces-13289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 927ACD39176
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321983016DF8
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EED2E8B8F;
	Sat, 17 Jan 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtWFrOyI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921F1F1932
	for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768691309; cv=none; b=NAwtiGk+rV+vbx/YdbrvxLOykpNOtgOClJtwkVXh3I7qTBzjOQVWRJopJrLgoi0+2cAI7gx59hkJzc+mGCIPCCfzZKF6cbVzMlKesrVN+zGGzvxBC0PrUqwZmMRDUh5Qxxj89V55UKk4hcJX8o/D11TRj4uUCvMFi17xMk8xMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768691309; c=relaxed/simple;
	bh=GBY9U3Q5WDR6+zDzhvCh1otWv3FPrzeZqgKC5f1rW8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFb4InLgd0p5zZCtxlge3FIBwwqBhravAgL+uKwouLdz5m0D1IuVH8BrlO6OMlZiFJ4kDxaWorte6xrDtPNpJ8uLCPEQOhwFtSSESJN2G/vBcQebuFoxgmsVToKBkMPo/j8wDbXngxjokAhYMlRpLBE6W+VCcjI+7p5UJXN/P9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mtWFrOyI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 15:08:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768691295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DFWm2S+c8ymkzaWvDvvgfT+b2tyB8NQqNbP2dpBT00=;
	b=mtWFrOyIwlpVWe4P59H5gsd36MF3xE4tf+ECKFmq/FFoCaUdm0KbhTqLgGX8IHU1RFhaX4
	kWA7Cg8pZSY2FHefC4Y2ap/iVa32oQA4lcb3M8ZsSykrEnUJ+28JYhoExEp9fUAF5pjHdi
	e+JKOtcbMXpRe0uokGZb8OG7POHAuoo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 23/30] mm: do not open-code lruvec lock
Message-ID: <qmlnijwopkgvq27czg6qjc2umd4dwb5bufvb7q2zetn2pqiqmm@yhggvkcudtkf>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:50PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Now we have lruvec_unlock(), lruvec_unlock_irq() and
> lruvec_unlock_irqrestore(), but not the paired lruvec_lock(),
> lruvec_lock_irq() and lruvec_lock_irqsave().
> 
> There is currently no use case for lruvec_lock_irqsave(), so only
> introduce lruvec_lock() and lruvec_lock_irq(), and change all open-code
> places to use these helper function. This looks cleaner and prepares for
> reparenting LRU pages, preventing user from missing RCU lock calls due to
> open-code lruvec lock.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

