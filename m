Return-Path: <cgroups+bounces-12338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF8CB7751
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 01:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F723018F41
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B521883E;
	Fri, 12 Dec 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSb/IcFp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D4220687
	for <cgroups@vger.kernel.org>; Fri, 12 Dec 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499826; cv=none; b=Rf5o1dr+rg3AJ2wmEVkHHZNE0ltH2D1QFWMTcLt0yJ7eovg72m2EekIOxdxDQsmBp8XW7I5qZ/rRLocynlYLLFwjziHTPoj2gLVpftmtgkzctfk2Gp6S6RWi+zV3ET699METUUAY2/JGsrcv9zepwvnT8LkhyFWZ9q+ezEi6W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499826; c=relaxed/simple;
	bh=FF5zHlJXfLmExREPcWsGJ3mi3P1601As81ATZP2XveU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1FCSo8yZCa1lNzSLHBulLh0UzjamEea6JSzz6YPKBiRxK5eHtIX1HT4jjJgQ2mz0Gm23YwfCnqTfgZYfWYKEaKTxe24PmcLSLDObKpG3zq7D5hxcCjZ4ofRpOgjRC7QjiNgo726OXI8RJMwUXeBw/Ya65IVKyCKQDliGtTZpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSb/IcFp; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Dec 2025 16:36:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765499811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAHincoTK5ENt2l8A7VD7dTozjfJCW5AOpMiBUorZz8=;
	b=HSb/IcFpxJIIZt5/PosJXklalJUrHM+gU7WbmFAyuUxs2fT28/YFkoiucwKFKaodoZO0JW
	Uiy+u9NIR3phygFK2cNSVzN9aE/qsNKyYYJYeCRXQI/+yfUZdwHoQjAuKIp1eSSP2IZ8MZ
	PxAAX3FZ2/FjVZQ1a0LP99mcHuk+X0E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v3 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
Message-ID: <a3od5xvmpuehxss4bwp2dxo5jfuw5clgweh3ko5bqfidywvs7k@q5zjsb52zw6m>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 11, 2025 at 01:30:18AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, mem_cgroup_usage is only used for v1, just move it to
> memcontrol-v1.c
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

