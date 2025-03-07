Return-Path: <cgroups+bounces-6897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1101A56D29
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2362D188CD5C
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7702253B7;
	Fri,  7 Mar 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0cfEB99"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B822539E;
	Fri,  7 Mar 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363658; cv=none; b=trBqLBVzbPvk8dmL3JwbbTFj/Rqe/AFORGSkTeoZAZglV00L6Xmst2NAeaBXjoPKPU5XEB0hBDFwH0//ySE4CVmTQKAE4lnoB1mNx2K7/dUPMI55dlJdiRXxS41+QaPY6+6meHoUvoLTa6kzi6K3ONWwzX8AdXHakORGP4RwjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363658; c=relaxed/simple;
	bh=dcm0Hs9gMi5hesN2kdGvOo6rsOd3t+0dAqIv5xGKQKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3FZy1NbXPuXh82gAkfxUV3pCRHFTFSQdUQs2zx6wLWxAeaD5wTKzce9+wx34EWjYmkYeJwsqZPmQLov4bMh/hhhUjyIfJ5DY3TlYlzz5FnhLvmQyvr4kEZlb4a0Mu+j1eKPIyvzC9cyML+ykGHuD4lL8odEXH6OlmZB4PFsj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0cfEB99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7814CC4CEE3;
	Fri,  7 Mar 2025 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363657;
	bh=dcm0Hs9gMi5hesN2kdGvOo6rsOd3t+0dAqIv5xGKQKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0cfEB99EdFUY4VmHqJ1fkK2VCAgct+T9BI5TdsqJTdTMUdpp1JrYZbW6YtTQfEHB
	 ezEI6nTGTVP0KRw17aPzG1XDGYAL3FPZRmP9loDJjRb58U4GPIT+p7IwbYdbWaaeV0
	 z2knmkZD/pP2wy8iR2Y4KedPST5SpQ8jdrJCoi6rLH0ZK6o/WSnumydyWHJ90pWvKq
	 zIrQmqoXQWNiUayzSeV6Hht6VsmQwX80WSHcfdAppiFAQFqD9bpbfcfX97pL4v9h+W
	 q1XjlcugTSdzDTk64FjIKugqz1rh2sCkotVVJcRMxMezuOn9ymf60qr9QMNSh/ZZwM
	 Q25WZcvDY6aTw==
Date: Fri, 7 Mar 2025 06:07:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
Message-ID: <Z8sZyElaHQQwKqpB@slm.duckdns.org>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307090152.4095551-1-yukuai1@huaweicloud.com>

Hello,

On Fri, Mar 07, 2025 at 05:01:52PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> support to account split IO for iops limit, because block layer provides
> io accounting against split bio.
> 
> However, io merge is still not handled, while block layer doesn't
> account merged io for iops. Fix this problem by decreasing io_disp
> if bio is merged, and following IO can use the extra budget. If io merge
> concurrent with iops throttling, it's not handled if one more or one
> less bio is dispatched, this is fine because as long as new slice is not
> started, blk-throttle already preserve one extra slice for deviation,
> and it's not worth it to handle the case that iops_limit rate is less than
> one per slice.
> 
> A regression test will be added for this case [1], before this patch,
> the test will fail:
> 
> +++ /root/blktests-mainline/results/nodev/throtl/007.out.bad
> @@ -1,4 +1,4 @@
>  Running throtl/007
>  1
> -1
> +11
>  Test complete
> 
> [1] https://lore.kernel.org/all/20250307080318.3860858-2-yukuai1@huaweicloud.com/

For blk-throtl, iops limit has meant the number of bios issued. I'm not
necessarily against this change but this is significantly changing what a
given configuration means. Also, if we're now doing hardware request based
throttling, maybe we should just move this under rq-qos. That has the
problem of not supporting bio-based drivers but maybe we can leave
blk-throtl in deprecation mode and slowly phase it out.

Also, can you please make atomic_t conversion a separate patch and describe
why that's being done?

Thanks.

-- 
tejun

