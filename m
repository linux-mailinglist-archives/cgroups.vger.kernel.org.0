Return-Path: <cgroups+bounces-4701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99596C858
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83E61F25D61
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614A1482F6;
	Wed,  4 Sep 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYOQtf2u"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F101EBFEC;
	Wed,  4 Sep 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481528; cv=none; b=X7Sfqh7xNR2N325MQl5/JRMNDfV9umNjBwGUFjGMYQiLvRktZGM6Uz6+INpPYCWf4Hv0qwMWqA7msLaFVl6TniXTLA2cV1JY52G0PciCOpxXr6zjVj/UKrLfgzVK1nTd/qBMCwme0VZitRuPAX5mXAbszWaXh6dPAqCYKmOciuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481528; c=relaxed/simple;
	bh=43aHIKNm+uwD8JFpzzEm3c7p34nh/C+jP5YA/JV9aCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO+6NyfThJCEVGGZi6B9SrTbDH5U4sXfUtwPSfRusIFUuax1YjmfMmwC8yx/tg4avYrDQDxXjSkIL5pQL4gwrN2+Y1nnaWPFIjGkTwGJ6K9wUHYT6xm6YiY6QiirSFK44r6epWzhhGAnEJ9xa0n6udfmMNQGXbjsoBPLVwMbNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYOQtf2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32ECC4CEC2;
	Wed,  4 Sep 2024 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481528;
	bh=43aHIKNm+uwD8JFpzzEm3c7p34nh/C+jP5YA/JV9aCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYOQtf2uu31gqEXgfXzlC2nCvn+zym3kL3RytM3AA4jUMEzTmlE+t7ndRmWsQ3nFW
	 W1txZOKNLNO9gBQJzoiTKyj+wuFI/D2hGt5M1pzxeSpSTcrFCDXdp7S2sGqYjh14Og
	 SzH7M4WX9gG5KIaVw2BwLJT+rVnVeWMtE4scSkupLK+98zLY9gD9Jz0Y/eRU2xzYdt
	 cWcYaVRR/+bM9vaEm/f+KMIo+c0Jtk16m+5YSvgZTmKPx+TFy3LVekcOqIXox6nitt
	 pfYIS5yG3vCj0XnLyFuoIt24oNXgNdhvX8sKYXO6sG7I+UgOpLlei77Mm191pbFpPP
	 MIjqpJfl8LwxQ==
Date: Wed, 4 Sep 2024 10:25:27 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org, mingo@redhat.com
Cc: cgroups@vger.kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mkoutny@suse.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-6.12] sched_ext: Add cgroup support
Message-ID: <ZtjCN6p98-aVjHHh@slm.duckdns.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>

On Mon, Aug 26, 2024 at 12:57:38PM -1000, Tejun Heo wrote:
> This is v2 of sched_ext cgroup support patchset. Changes from v1
> (http://lkml.kernel.org/r/20240808002550.731248-1-tj@kernel.org) are:
> 
> - cgroup interface file visiblity toggling based on SCX_OPS flags is dropped
>   as it caused more confusion than helping anything. sched_ext now just
>   warns when unimplemented features are used.
> 
> This was originally taken from the cgroup integration part of the sched_ext
> v6 patchset:
> 
>   http://lkml.kernel.org/r/20240501151312.635565-1-tj@kernel.org
> 
> This patchset is on top of sched_ext/for-6.12 (9ad2861b773d ("sched_ext:
> Allow dequeue_task_scx to fail")) and contains the following patches:
> 
>  0001-sched-Expose-css_tg.patch
>  0002-sched-Make-cpu_shares_read_u64-use-tg_weight.patch
>  0003-sched-Introduce-CONFIG_GROUP_SCHED_WEIGHT.patch
>  0004-sched_ext-Add-cgroup-support.patch
>  0005-sched_ext-Add-a-cgroup-scheduler-which-uses-flattene.patch

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

