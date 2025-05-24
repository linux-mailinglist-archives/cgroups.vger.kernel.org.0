Return-Path: <cgroups+bounces-8339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE89AC2CD2
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 03:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418ED4A699F
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 01:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B381DEFE6;
	Sat, 24 May 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXPfZO6V"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45D1DE891;
	Sat, 24 May 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049250; cv=none; b=F37Nh7XOJwpkpx3FSNEFjfH909uLr+SE8MSdW30xj0HHvY7HnJVWwnbtP0RrCOZy2UkJBI/x1fRj7b9G8n2BduVZBCzp8lQEEi79zogiWg6S6O3AnSkT7KWUG9V9SH6fuF2niw+HKP/3Dp9NPoaprQH66HWUcGLcHXpA/SdADNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049250; c=relaxed/simple;
	bh=BxwKVIcJLgHe8zjTpF418/q03gPCOAZolLDQJUzZPns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQKoyWd2AF8sADaihOAnYo/IhXBvCYG9MYwQAqDxgGAQ2L+NAq4DveKeYiT2XySm62Sl0wMl1E9OokWH9CNAmcO8BCL7dYaklCpSR0V62mCW8ZJFtOvJjQuPGWmo3VNlVj7Tsm4c29KAgXNFmYo49J36JrHS3/FKR4Ps697e6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXPfZO6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3045C4CEE9;
	Sat, 24 May 2025 01:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748049249;
	bh=BxwKVIcJLgHe8zjTpF418/q03gPCOAZolLDQJUzZPns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXPfZO6Vv+MS9bRZTdOT3QpemaQ7NZMnTy7KPlGKISHnmyT56rKRdawPD08sDnChd
	 HDVZE9sYW1PpjgyJWTRjKC6p/xACDsg51dpOBZ/p6uNogBsROgPiYx7xLpDrysxPKb
	 FGYDWmhuQKGBUlvQ0Lu+8JvGdvpKtgVWrg+SSuOAscSw0+DRQm2CATX91S0uma9tK7
	 MRl0HwWwNA21h5nJtoG9zx7IZy5BOJMgdHg5pJ2ilutelfejneDYSm0E5bRm/V+bDo
	 wpHN2DnnLZUI2IQM2D8wADf9np9LIAI6s4z69sofJ62xpTV0E+/zAqcY1uYq3tnkeZ
	 bRHoKOyTgOsjw==
Date: Fri, 23 May 2025 15:14:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <aDEdYIEpu_7o6Kot@slm.duckdns.org>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>

Hello,

On Sat, May 24, 2025 at 09:10:21AM +0800, Zhongkun He wrote:
...
> We move the task by modifying the cpuset.cpus and cpuset.mems and
> the memory migration is an option with cpuset.memory_migrate
> interface in V1. After we relocate the threads, the memory will be
> migrated by syscall move_pages in userspace slowly, within a few
> minutes.
> 
> Presently, cpuset.mems triggers synchronous memory migration,
> leading to prolonged and unacceptable service downtime in V2.
> 
> So we hope to add back an interface similar to cgroup v1, optional
> the migration.

Ah, I see, so it's not that you aren't migrating the memory but more that
the migration through cpuset.mems is too aggressive and causes disruption.
Is that the right understanding?

If so, would an interface to specify the rate of migration be a better
interface?

Thanks.

-- 
tejun

