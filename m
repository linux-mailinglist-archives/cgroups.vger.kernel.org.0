Return-Path: <cgroups+bounces-2839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F18C1589
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D65E1C21EF9
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF087F7FD;
	Thu,  9 May 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dEnNutMH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192CC2ED
	for <cgroups@vger.kernel.org>; Thu,  9 May 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283602; cv=none; b=QXPwhL5pBdTJs5zDN9xzTrR6TocdYR2ws8rkaeQmQ+LFHaG8DHWQemVF1DyiHyEDRiQ78ea0zParVb6erW2ur+y3PkeMM7wdm0YPKLFO0YvzAkNFY3fI3dvJtqhesQv7PE+nSHddijE8WpWDIYVH4kqCUDSJPI+XH0d0MmZLN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283602; c=relaxed/simple;
	bh=33YiG0HHFn7Toxrl49o9QS85+iLhQwTRtyY5FSXgMNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOsY1HSTD9x0bdd+hokWsYejjJK70SAxskyDNZsg/vGy/zeTNh5wxpLQcf4tMEcrXE96JIDmGE7JqkLNVcmyJva5VlN/wACMMsc8kvKKMbuLE4H3m/60xvqUnejcTOdMDHmqinXL1ipvk/3R/9FWVu+frJiLkfXN8YSqSQ6xjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dEnNutMH; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 May 2024 12:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715283598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYesDn+O5XueBD2iRG4Yeb7y/n1q00cYL+tni2WKRCc=;
	b=dEnNutMHE2g2IVGC4BD3yZr1suL5BKzhi6hktJbbFim/4OcvUqZjCpcNzKdMRqXROBEas6
	VAxpRV+yUQMX8/r3Vpm0olo3SyolKhE4v9nYsin07pNM3vu8+rPbJBFaXI+bwhOdBgDyNk
	Bw4pJuKcKBzL2qdeXTmvzgIWJ/SJnBA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next] memcg, oom: cleanup unused memcg_oom_gfp_mask and
 memcg_oom_order
Message-ID: <Zj0mhySM4BQbeMoh@P9FQF9L96D.corp.robot.car>
References: <20240509032628.1217652-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509032628.1217652-1-xiujianfeng@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 09, 2024 at 03:26:28AM +0000, Xiu Jianfeng wrote:
> Since commit 857f21397f71 ("memcg, oom: remove unnecessary check in
> mem_cgroup_oom_synchronize()"), memcg_oom_gfp_mask and memcg_oom_order
> are no longer used any more.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Good catch!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

