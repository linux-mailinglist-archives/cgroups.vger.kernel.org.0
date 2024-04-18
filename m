Return-Path: <cgroups+bounces-2593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF868A9FCA
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BC6B24C79
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FF16F8F9;
	Thu, 18 Apr 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDVYX5TI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C73156F54;
	Thu, 18 Apr 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456873; cv=none; b=Y/Vpjy+ifdg0dze4F+88AptmgZakR4AKMKLhiKQcUzN1c17gB+8q/BpMCQrNVpAvIOsUDU9c8UAahIsC6mjm9f+64GR5YWYr2knqA3kXZ8dd9G2m6jjMdnmJ20+blxBS1isYam/YeAWfOZ8K3hlMgh027gYIKwXC12HczuA3Pug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456873; c=relaxed/simple;
	bh=9r4p8A+grzt9+R6tG2B3r+bIJI41c+ksyzkS1k6re2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpwsWFJWQZlF+qnl/ybwYpAFtqpVU3WMWGRs4P4k9/kJldBMn+vlpsQ4hSGzb+8TcBp7mawF5zB43ateccHY3T/Geu8fj3GRYqEFkqW4GDL9tMB+nVL5J04B4lhQYSjTCeus+x4mIOsCKqgGMx72i5u3jVKmGj/QlSrxHeTn2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDVYX5TI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e40042c13eso8650525ad.2;
        Thu, 18 Apr 2024 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713456870; x=1714061670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz5AqVbMIQVzagVfr43mCYrmlccOEhqDHxOQ5R4Qr/E=;
        b=gDVYX5TIIEl+Kx4MhzpPKClTswucuZYXmJvfeTWcT0+7p5Epf9n2Cq2dgBWcYPhL48
         shwZE8RZO1GCRmN3awT+MPCBEu4KEc99dgubD/0GIzXIWRBdstxJI2bH2C3jg8A9pw6w
         ogJUWw7LmUVn4rvo597SmF6bqB17gAxBVsxnjp2zaNGhEUe7Fg+fXtY8P9TVFzE1O3E5
         3W32Q8Y9Wv02VBBkDM1Ep4Nfcya/dCm2kVcOu9fUGHongZWPyaar6prv55atK/rcNU0n
         jq6oRyBhszwKOC+YNa/TvOxOtaNKjriehlC6zyp63c1Sd5kIFlL4pE1acRL7q4XwJFYP
         MaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456870; x=1714061670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz5AqVbMIQVzagVfr43mCYrmlccOEhqDHxOQ5R4Qr/E=;
        b=mfP1Xkpryo6fN5ojqGj3aqMjUMeUJhTeXX6JVKQhuSy4+Lrsqc9nJDygAtZBojOjBw
         vUpO9oqL31exUPHmZ12ouyVclCPDVQnfokItcIjMKoEb8OxIT4riQ72OAPZc1RkIdRTO
         Gf4RMXnpTSxvrbaGEywyeX2vtxswYHCAS39+wE2RhZRNucpwrHAK8byLxdSODRlwGxnK
         cE7ZTwGgJKRECgm6gsOHwxL/U4V0hH7iCJu2PvrtpSRCzhKRuXvsZoY9W/ZXYvCv5WBL
         QnufYy0jJAzs2A0zUW6ldJ9Sqw38eFh7ZqrQytR8nnHhrFEZcS5RUxixsAM56ZevsHlH
         aRYw==
X-Forwarded-Encrypted: i=1; AJvYcCXvMtvtEmjiMiRCvyqvWnTpRDF+wBqrzNszQMwv5yqIbM4F9ckRooARQ0og0ghjC0byAM9QMz4DIUAWaacNX7dJC7Gl9IyLX+2zXtd0lHZXyGl53r0TjlJxUiyQtP8Afm+H12Ca42WdFTyxojvcLFgtQrpU+pPsT16KhdbvaaD1XN4i
X-Gm-Message-State: AOJu0Yz+MsxDlzyeR2Y8w9b9dRHwDQwyiEuiWGE3+VHe3X2XtPdXOJBl
	gZ1hxBbXCW0RgDMQ9tEqZZlu6mWnccDNHnIN154fyX0y/e0wzNOx
X-Google-Smtp-Source: AGHT+IEMg34T9/sHL1htsox4qC0LnWXh8YAzs15J15MH+wNZC7UiWdVMZSp+B14Rj9cBheMe3xORLg==
X-Received: by 2002:a17:902:ec92:b0:1e4:9ac6:1f3f with SMTP id x18-20020a170902ec9200b001e49ac61f3fmr4223968plg.5.1713456869965;
        Thu, 18 Apr 2024 09:14:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001e0da190a07sm1707307plq.167.2024.04.18.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:14:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 06:14:28 -1000
From: Tejun Heo <tj@kernel.org>
To: linan666@huaweicloud.com
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-iocost: do not WARNING if iocg has already offlined
Message-ID: <ZiFG5KtGGpYdOmnY@slm.duckdns.org>
References: <20240418072340.2090877-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418072340.2090877-1-linan666@huaweicloud.com>

Hello,

On Thu, Apr 18, 2024 at 03:23:40PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
> is intended to confirm iocg is avitve when it has debt. However, warn
> can be triggered during removing cgroup controller, as

Maybe saying "a blkcg is being removed" is clearer?

> iocg_waitq_timer_fn() is awakened at that time.
> 
>   WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
>   Call trace:
>   iocg_pay_debt+0x14c/0x190
>   iocg_kick_waitq+0x438/0x4c0
>   iocg_waitq_timer_fn+0xd8/0x130
>   __run_hrtimer+0x144/0x45c
>   __hrtimer_run_queues+0x16c/0x244
>   hrtimer_interrupt+0x2cc/0x7b0
> 
> The warn in this situation is meaningless. Since this iocg is being
> removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
> is canceled after removing 'active_list' in ioc_pd_free(), which ensure
> iocg is freed after iocg_waitq_timer_fn() returns.
> 
> Therefore, add the check if iocg has already offlined to avoid warn
> when removing cgroup controller.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-iocost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index baa20c85799d..2e109c016a39 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1440,7 +1440,7 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
>  	lockdep_assert_held(&iocg->waitq.lock);
>  
>  	/* make sure that nobody messed with @iocg */
> -	WARN_ON_ONCE(list_empty(&iocg->active_list));
> +	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);

Can you add a comment explaining why we need the pd.online test?

Other than the above nits, looks great to me. Please feel free to add

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

