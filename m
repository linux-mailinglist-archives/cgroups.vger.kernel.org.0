Return-Path: <cgroups+bounces-7104-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B3A65CFF
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E052188E088
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A041C5F3F;
	Mon, 17 Mar 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGuuttoH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CDA47;
	Mon, 17 Mar 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236787; cv=none; b=R3gRkiI2CgWnBzk4UkSYaFUzaKBzVYaifSwLNK4dqfeWbTtk+yuPiWwL1UdLAbwcje/8X56EWHqgMGBt/SOzqugX0un61cv/xQvRafm4DkbYVR6DvNWzAMpYDcPaXWZPsaxZfbIdvQDY14H4WUXWKpZIp1BUoHuM1wQMD2xfvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236787; c=relaxed/simple;
	bh=vUX45IpvzkZ02AKd/IPVjrW9oSbaLGh6sBQvAFq19HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1n+fY4yIoIc6s1uXvAL/Cd3h4Ka3M5t8K22CB51WJGpFtoi87J69A38ONRbr1LYK5Kyatd9Tnu/YtDoLTdemwCgWiraQyNT1YddFbR1bRdV71WPsMetQWe+rMLr/WUtg2WpXMwhVpwnvK2KuUWTv0aNV2xbkofHpfr0hP+yV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGuuttoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD18EC4CEE3;
	Mon, 17 Mar 2025 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742236787;
	bh=vUX45IpvzkZ02AKd/IPVjrW9oSbaLGh6sBQvAFq19HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGuuttoHaD6RxL8XyLcH8U/Eze2zBL1LfSMf4UoEBLdE1Qb6R6B+I2ir38qrpN8RT
	 NJUKQcY7FEya0MNZQGnwmHFoiGecAxvcYA/FsGVW5H7Xl8txUn7D7UGnjhbh53evO1
	 dVo44wh+dEkVYp2d0kdPWEXhsV9UBU0oIM3+VTeB/eMfIFlf9f5ZCCIgNkbSPTSrNt
	 Z0G/pZd1lWIzCw1yBrVcs+dGv9/OW8cUYsXSxn6UGyOKjkxE5JG3IFO2WJYorL0rus
	 bQd8mX53MU3/oIWREW1Zev0HsYRHB8AE3eFqjvygceJfN92Fddnp87GnEbmp+QsDC7
	 6EEdwMZf75HWw==
Date: Mon, 17 Mar 2025 08:39:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration error
 handling
Message-ID: <Z9hscRtPa76fdank@slm.duckdns.org>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>

On Mon, Mar 17, 2025 at 10:29:24AM +0800, Chen Linxuan wrote:
> This patch improve the returned error code of blkcg_policy_register().
> 
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
> 
>    Those locks should not contention any problems, as error of policy
>    registration is a super cold path.
> 
> 2. Return -ENOMEM when cpd_alloc_fn() failed.
> 
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

