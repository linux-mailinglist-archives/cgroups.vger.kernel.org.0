Return-Path: <cgroups+bounces-5891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA679F126C
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2CB163BF2
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128A1E25F8;
	Fri, 13 Dec 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZA1oZxm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035315573A;
	Fri, 13 Dec 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108184; cv=none; b=Sm72qr0oG7bf+zQ14XfbVj6Ws96ePu6wOEnyzRjb9nkZ58szIeJATbtaslu/kDaTA1GxnqF2HY1335LSPqjTqS94EoACoNirxbdsjD47AeIAPFhaSnsmrPK+wimDs/I9ajOsTuysiJqfx1Ua7yJ9IJSkKM9/kTSZTPzuwDxfycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108184; c=relaxed/simple;
	bh=LUVhGgRIvsSsSQ2enpdZuHi3wSsjKOOK3X6TXOkK7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCG39UQXZ3RwGEMCoQKZv9QpBZpcIBsv9D4eg7VMHc4GP5l0uorp84IyMWdGVtZ2ADwXuWB5fo5wpWtkmhRsffcchq3TZ86X7wCpSVaoz0rsSIPfHz/79QtDRZEPvSdZcTfQSI+ZqhvrQy2XGgdeqy5ci+wpzV3qqCl4gdj42oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZA1oZxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D2C4CEDD;
	Fri, 13 Dec 2024 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108183;
	bh=LUVhGgRIvsSsSQ2enpdZuHi3wSsjKOOK3X6TXOkK7PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZA1oZxm8+9Svte+qBAcxsPOoC1s/bXdtiDs9d/UpJR6+kpA1sN7pFpH88Y9AvT0W
	 F0YtV7rzh4g0cCaepzJ5qnQ/7lf0OoJoUXahkKjvXhlmmeOfBhvyM4XpGCQpuXPYvZ
	 oZcr6XYwbig1gVELWzFbajUkudrQg12rpBs4+rETrQ5ZtbehhhJDIp/2jPmzERTZsQ
	 lWBMFkuRJIvngh/ukIAsydh7rXJg8LX6MqPIlg01t2bn976m8Ih1I4X02tHnhHWnZG
	 /eYCDObZQigHre9zAkzsI5XAq4BnUjiso9lTXY/rr3Yy1fWKEnFP1xtwNUX2r6ANAz
	 JFiNYpFBxYfIw==
Date: Fri, 13 Dec 2024 06:43:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, mkoutny@suse.com, roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v2] freezer, sched: report the frozen task stat as 'D'
Message-ID: <Z1xkFq9WIeF-MvHr@slm.duckdns.org>
References: <20241213110332.3105932-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213110332.3105932-1-chenridong@huaweicloud.com>

On Fri, Dec 13, 2024 at 11:03:32AM +0000, Chen Ridong wrote:
...
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..dbe0cb97461f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  	 * We're lying here, but rather than expose a completely new task state
>  	 * to userspace, we can make this appear as if the task has gone through
>  	 * a regular rt_mutex_lock() call.
> +	 * Report the frozen task uninterruptible.
>  	 */
> -	if (tsk_state & TASK_RTLOCK_WAIT)
> +	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)

Can you please add ()'s so that it's if ((a & b) || (c & d))? Other than
that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

