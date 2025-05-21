Return-Path: <cgroups+bounces-8291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C661CABFC19
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814354E4CE5
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02972673BE;
	Wed, 21 May 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goD2IQSg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB942AE7F;
	Wed, 21 May 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847729; cv=none; b=S/mQhD5mO3z8U9E4MUP/znDbzmOHxsgGuZzxKKxNyAfAk0hbVzK9htnAmC2smDijTBeZT1nT6cws1jA3ebhq7hiN30QXr2RFCmmG2YK4HJkuiK+O2F4FFe7pMOhWFtC7VLivTqNzpOseEjew1Gr/LYKTWB0U8O9x4ZFLHZPewOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847729; c=relaxed/simple;
	bh=q52XUM2vSxcxPQEQuuOUFa3+mPV81gHnnS0ZTj1olr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQhYGlWxh83Sv0IxSX2o8Io3xI9eJM85IAk3q18xFD8aJd8KXBd9Bw/b8w8pEX93BBWphmzZuJe9rM93LvSh+n/0OkvyMxovu+7owpscomB2TvBxIBJArKWYqmn8/iO9kGz0/+tXVIwLRrR8y3iu9byLLVpoVa/vLCmquhYUAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goD2IQSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3188C4CEE4;
	Wed, 21 May 2025 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847729;
	bh=q52XUM2vSxcxPQEQuuOUFa3+mPV81gHnnS0ZTj1olr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goD2IQSg8Iqr75Mxh+L0hjRvVyLcWNBcRMB0Od+bjEQB3lJbYdeYvDgFxLp5ROt3B
	 EmQijeb9nrDPglumQlJVuaM2JL+5YdhhbhT3B2BxZTGTbhK6MquF9P5gpKjzfxbljN
	 LIHijBT1EOvXeajeGNkttpyjDWqbV2YQhQNWJ8PwJacrsPW/ma5/bBXVmGFfjkmpi3
	 aXzEOQ9RrPjdl3u+jHASMO0FBObtLljOtO8AXbp9zG6L6NMiecqYmHbiXDgis+5d1Y
	 VjPe//Pg3yjQp0mG3rcneq7CVF/Kf3bZLqeE9oq2/Qq+eJcS2zPMu7XIy/3ZxkYArq
	 sdLHmapanRKCw==
Date: Wed, 21 May 2025 07:15:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: hannes@cmpxchg.org, longman@redhat.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
Message-ID: <aC4KMCK9JIbLCFcl@slm.duckdns.org>
References: <20250521034527.3476332-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521034527.3476332-1-hezhongkun.hzk@bytedance.com>

On Wed, May 21, 2025 at 11:45:27AM +0800, Zhongkun He wrote:
> Setting the cpuset.mems in cgroup v2 can trigger memory
> migrate in cpuset. This behavior is fine for newly created
> cgroups but it can cause issues for the existing cgroups.
> In our scenario, modifying the cpuset.mems setting during
> peak times frequently leads to noticeable service latency
> or stuttering.
> 
> It is important to have a consistent set of behavior for
> both cpus and memory. But it does cause issues at times,
> so we would like to have a flexible option.
> 
> This idea is from the non-blocking limit setting option in
> memory control.
> 
> https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux.dev/
> 
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 7 +++++++
>  kernel/cgroup/cpuset-internal.h         | 6 ++++++
>  kernel/cgroup/cpuset.c                  | 7 +++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..d9e8e2a770af 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2408,6 +2408,13 @@ Cpuset Interface Files
>  	a need to change "cpuset.mems" with active tasks, it shouldn't
>  	be done frequently.
>  
> +	If cpuset.mems is opened with O_NONBLOCK then the migration is
> +	bypassed. This is useful for admin processes that need to adjust
> +	the cpuset.mems dynamically without blocking. However, there is
> +	a risk that previously allocated pages are not within the new
> +	cpuset.mems range, which may be altered by move_pages syscall or
> +	numa_balance.

As said in the other thread, nack on this approach.

Thanks.

-- 
tejun

