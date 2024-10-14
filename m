Return-Path: <cgroups+bounces-5119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D899DA40
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 01:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF95328457B
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F91D9A60;
	Mon, 14 Oct 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNREWJew"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B01D9A4F;
	Mon, 14 Oct 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949208; cv=none; b=gHiPmkU6nmk5S+74YYagEI7XkcZv84fxiQt9tY7vgSoCAW1uD6zwVLItNX6abj1zHdI9aeanpb1WkIOrWotNfMhxoTlTRwYmKsVPuj+qNRmxsxI6MsbXrcVsUNGuspga3EhO4GHlIE9WM5mM1kcJESdm1y5JYt3SfmLQS4Z8xXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949208; c=relaxed/simple;
	bh=hV2Dnku3EWTu96PzCRW2R6Rs27TYxCY8SoD28gsuado=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp5qkv9MNJ8YN3/QK4zdD59oBixqMRGn0MThU7WGiz1DnF8Sm12JPzvSpJy+qmKOdI2UtUoADUMwOAu6jWsyQv9AcjawhwFhaXPoyJlpOIP2BEySMS3d1vROs9nUH3eH6Rp7lCMsOYhU8hwyn+jnT6SZgkKz4aLZgdbohe4N6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNREWJew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E67EC4CEC3;
	Mon, 14 Oct 2024 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728949207;
	bh=hV2Dnku3EWTu96PzCRW2R6Rs27TYxCY8SoD28gsuado=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNREWJewmjUQRFJbYck0YF1p6z9iicovewIsjCmSTwjg7x/y0+XWPBWLXZohSUVu3
	 umAtKEesTXtfVJNiqcPabB78hhkPWqoJvDLEb7k3IEizuEbbwFXz/o5w+rqbmHPYUi
	 XClvyXcNznsKHsQ6fN0Zs2Hqg3DoBCaqjIN4MGvy7HxJc/IvQFV5pByfe5y1xQ3TX0
	 9cLXg0bYl0+yk5yHD/CoQT5fuiA4DkbfxwiE2nURP52NzB/Abivuiu4Z0EmMiHcuVA
	 QslaKthh9voiWdyoTX2iKhlUesMZFxZatf06R0hwDiuz75Cttq9kxD08YLimGN4JTY
	 iXt7BHJUhFUDA==
Date: Mon, 14 Oct 2024 13:40:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	roman.gushchin@linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH] cgroup: Fix potential overflow issue when checking
 max_depth
Message-ID: <Zw2r1v5X33rtF7kG@slm.duckdns.org>
References: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>

On Sat, Oct 12, 2024 at 07:22:46AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> cgroup.max.depth is the maximum allowed descent depth below the current
> cgroup. If the actual descent depth is equal or larger, an attempt to
> create a new child cgroup will fail. However due to the cgroup->max_depth
> is of int type and having the default value INT_MAX, the condition
> 'level > cgroup->max_depth' will never be satisfied, and it will cause
> an overflow of the level after it reaches to INT_MAX.
> 
> Fix it by starting the level from 0 and using '>=' instead.
> 
> It's worth mentioning that this issue is unlikely to occur in reality,
> as it's impossible to have a depth of INT_MAX hierarchy, but should be
> be avoided logically.
> 
> Fixes: 1a926e0bbab8 ("cgroup: implement hierarchy limits")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.12-fixes.

Thanks.

-- 
tejun

