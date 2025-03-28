Return-Path: <cgroups+bounces-7253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA8A74D25
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 15:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F6718962D7
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289ED1C84B4;
	Fri, 28 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYYaFo4u"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09931C1F02;
	Fri, 28 Mar 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173501; cv=none; b=TGrwL9I2H5qhOwDlswcx41+VZ+tsqv6VP1/2x5w8UFjwSp2mT0jjnh5k0dZkDc87gLsWbPf03MYHJgkVIzcyqL1hY6/aM2erdIPKKjRAkIf9k8WbqZzmX2lX1Wdkr06qgFwF+9Oqgqdex1e1LDg4/0Gr+tbknXX3D/eaUbRjroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173501; c=relaxed/simple;
	bh=9Ko1zCw5PgKobVezCRHe8rzxVottTxwWuuTYMvwB0MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpkBgd9zqEqZlwdxT+Y1hWc4R+VZVKDgEG+yePNiji2J3rxZQdfcg/++Qg6D/dTK82XNi7P+iXu9geBUo35tEvqTtKTfvuliXvbxb28+6lOaC3uimGkqM2ttdUfsSXQLlh8D3hloMnMbLCd+TIuW2NXyeO/pSA4jHt7eu1JaToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYYaFo4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B41EC4CEE4;
	Fri, 28 Mar 2025 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743173501;
	bh=9Ko1zCw5PgKobVezCRHe8rzxVottTxwWuuTYMvwB0MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYYaFo4uXheh0d67c16C2dLyHGmxAhNjvFaGpzCuuPHNdANoA/5eBgqXoL6JpeGuZ
	 IsaUakIs7XGF1+XW8NdB0ppyjupLXbTHut2LtKrmQEuFzZDXAhHCxF+cPFw1fTi/KL
	 baj5fTRR8ZvmWe3vrqvccAOusgXQRHdSLdARsaZc=
Date: Fri, 28 Mar 2025 15:51:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
Message-ID: <2025032828-chirpy-morbidity-7264@gregkh>
References: <20250326154346.820929475@linuxfoundation.org>
 <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
 <CA+G9fYtdg6OopeUQWkVmW9CYoprtqzWVTQfaoaY1vUtXKEXD2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtdg6OopeUQWkVmW9CYoprtqzWVTQfaoaY1vUtXKEXD2Q@mail.gmail.com>

On Fri, Mar 28, 2025 at 08:12:45PM +0530, Naresh Kamboju wrote:
> On Fri, 28 Mar 2025 at 17:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 26 Mar 2025 at 21:16, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.6.85 release.
> > > There are 76 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Regressions on arm64 devices cpu hotplug tests failed with gcc-13 and
> > clang-20 the stable-rc 6.6.85-rc2
> >
> > These regressions are the same as stable-rc 6.1 cpu hotplug regressions.
> >
> > First seen on the 6.6.85-rc2
> > Good: v6.6.83
> > Bad: 6.6.85-rc2
> 
> I have reverted this patch and confirms that reported regressions fixed,
>   memcg: drain obj stock on cpu hotplug teardown
>   commit 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb upstream.

Thanks for confirming, let me push out a -rc3...

