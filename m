Return-Path: <cgroups+bounces-12339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D9CB775A
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5454300BA37
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFB223705;
	Fri, 12 Dec 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkRJhWfy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CD1F419F
	for <cgroups@vger.kernel.org>; Fri, 12 Dec 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499884; cv=none; b=YauFvbmoTWySScRHYdt0u0mnEVQLHvLyrmq7MvWs0nKkV4i6Y+K6PFtZpJfvXN3r61rRWbPHwmTt5zHsVvfpKvCXGvUygpV6pyNJeVDlsbFvecQD50fLFEIQn57W6EOMQs+qi+1+tq2M/xPZxeJJSZuSnp+J4VIWr5JM5koq9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499884; c=relaxed/simple;
	bh=b6p12NQ2a7BBDAttBzymyEBMAXfquK0jWfHzLE+B4cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbcJKtYHLvsBKvH925VtEOib/8NEv50CffJN7R/ro6ie6iJsLd1p6qsPNhwNk9okV+TRQTt5RSOpzQiEDtthGpEclgkSwpv2kMzSrsjW3Xi59QwoMRYEcxejjVvFrOqKYRqHoZ4mX4O9zDtEZo9c9rhtXYZZFPnuzBmBjAqDEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkRJhWfy; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Dec 2025 16:37:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765499880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/84buoVRor3AbyQ4XPUysinXJkE6bFyrJbz8JP5bRgA=;
	b=kkRJhWfydO7d1jxdqMBv3LXHEOzvjDzYGajVGH9l65XdjBMd6hClnw5LY65i8Juy3CjBey
	6asRv5hsSuxaamKAJ2mh/o0O9PL4dGed84piozgm5rfscxthnmK/Gy2NGsPqNHAN6neC7j
	/mAN46k3Th+KwwE3eIjTuERi93dHb2Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Message-ID: <2es3ycavnjvejeawchua6d6ueetxhlr3ldmkdd3d2vn5gkzne4@aho56i5oslmd>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-3-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 11, 2025 at 01:30:19AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
> 
> Remove this helper and get its usage via mem_cgroup_protection for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.
> 
> No functional changes intended.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

