Return-Path: <cgroups+bounces-3248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6F91042E
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 14:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC761C218F0
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E51ACE96;
	Thu, 20 Jun 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uyYxtf5f"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE01AC229;
	Thu, 20 Jun 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886597; cv=none; b=GBRDyBVzHGxkvOQDgSJo6WzvKWeZbQSmlrNRSfcTbBpXiA1hqNLOYDUNY0sMAi5fpqNGugV1ffusw4NNKqgZS1bIRJJA5g/gfntb3ZOA60N1XlgYS8E7krPDyS3xC144Od3xWGbXFsagncxvDfobBs32UjkVgaCLW/trj8o7plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886597; c=relaxed/simple;
	bh=TbXzmIvEO7TjjoHW3NdmWzbgPUbd6HxMNpznqg0zLUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL9944OsR2e4jC0GnC021/MrEC+fdfSrOLdQexwKAzkU1tGkvRSk4cT0OnHA3F9KSu1OyKfMKlHl3Eq8mYzGXUxJNgc6DcLgsxnwAebvVdKvES7U0JqUROS9aKig+zQ1xU4mRebBDvknz6h1w5TP+mdnaPVOkCSNpu/kKT7jx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uyYxtf5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B8C2BD10;
	Thu, 20 Jun 2024 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718886596;
	bh=TbXzmIvEO7TjjoHW3NdmWzbgPUbd6HxMNpznqg0zLUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyYxtf5f9af/GSBjoWdLh0kD+eKh3XfeErWbdm7wMgVmh8r0tFM3nTNhzKLG8PitN
	 h+uA3y2BoOThihevb1dlLDH/vGEfgWNdggjpfzcP48aUZw52muSvTR8XMmI6VHu6Cy
	 8IL8J8nDCkw5OkKiWYylDmD2Qv2/Yxs6uVMQLxQ8=
Date: Thu, 20 Jun 2024 14:29:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com,
	LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Message-ID: <2024062028-caloric-cost-2ab9@gregkh>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>

On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.9.6 release.
> > There are 281 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 1)
> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> on arm64 Juno-r2 with
> compat mode testing with stable-rc 6.9 kernel.
> 
> In the recent past I have reported this issues on Linux mainline.
> 
> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>   - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> 
> it goes like this,
>   Unable to handle kernel NULL pointer dereference at virtual address
>   ...
>   Insufficient stack space to handle exception!
>   end Kernel panic - not syncing: kernel stack overflow
> 
> 2)
> The LTP controllers cgroup_fj_stress test suite causing kernel oops on
> arm64 Juno-r2 (with the clang-night build toolchain).
>   Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000009
>   Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
>   pc : xprt_alloc_slot+0x54/0x1c8
>   lr : xprt_alloc_slot+0x30/0x1c8

And these are regressions?  Any chance to run 'git bisect'?

thanks,

greg k-h

