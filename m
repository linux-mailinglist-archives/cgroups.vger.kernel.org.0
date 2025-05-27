Return-Path: <cgroups+bounces-8362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC599AC5A5A
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 21:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF55B1BA82FB
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11912750E7;
	Tue, 27 May 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoVICZlC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6A1990A7;
	Tue, 27 May 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372687; cv=none; b=fsCRWTgXT6fRuiBye80b+JKOxyaqOiDGt2UXCZk9ZFLRjqdYXWiL8Sy4dXkSc4QJnLR286+ah7PVL5sbkyPccZldIXnXkGKYU9Ypkq+RE7LSJUG83FMMuPK3yF12mdhFK3dhxJiupESKVTpfphAW+MFhnB0tzm+E69/rYyDL5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372687; c=relaxed/simple;
	bh=MwRofHnla/VucXUYUgL45YwvUyP3cAoOdQAxIpjk/CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+sjbZgK37EvNiH0DtvJbGfdAhIrqIOx2O8vZGshaSr5tjg3kjdODMd0ahu7wWRXbPZBik7WtUrlkAo7hYHdtcSS1/Ll53s7tbb2E/HYS4QB3QKpGOYfIq7dGtpMJN3pMkHc5dobM4S40ftIM4HHPs0tT57oAq87msV+eJhaMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoVICZlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBACC4CEE9;
	Tue, 27 May 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748372686;
	bh=MwRofHnla/VucXUYUgL45YwvUyP3cAoOdQAxIpjk/CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoVICZlCHB8xSxvLnEzulZSHz5/U1iOGrgZWk6lvGV359Dq1EXdx6rH3sIOuXum7d
	 Nk9r6dmpR+NLJR7JNhpgfdJLFhG/qbqXlaR7pm1OCpPdoCD4PljoXzfxNc6byYz2ac
	 O+nSE0Zlw3wo4HObz1WbCwjMdENnGrBp4WYmuDTBcvJmqLFtu488iXWDnbJm8+449D
	 9kx/2EoyiZELVnIpdeZaDGvTgJNhXCgjrS5IfjP5yS7odBZuQx4RlSkzLYO/MWyNPO
	 iLj1KFUKMa4tZ72M7zoJ69wCIDCaLICz3bxTqUS0rFIkvOJJD/IG+GCQTIFnp3YtBG
	 I/Qk0ANn8Q5iw==
Date: Tue, 27 May 2025 09:04:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <aDYMzfYYSS8ly1Nt@slm.duckdns.org>
References: <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <aDEdYIEpu_7o6Kot@slm.duckdns.org>
 <CACSyD1N2CjY-yqcSg+Q6KHKGzzQnio9HjwUHutup+FEX08wg0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1N2CjY-yqcSg+Q6KHKGzzQnio9HjwUHutup+FEX08wg0g@mail.gmail.com>

Hello,

On Sat, May 24, 2025 at 10:09:36AM +0800, Zhongkun He wrote:
> On Sat, May 24, 2025 at 9:14 AM Tejun Heo <tj@kernel.org> wrote:
> Per my understanding,  the interface of migration rate is far more complex.
> To slow down the migration, moving it to the userspace can also help determine
> when to carry out this operation.

(cc'ing Johannes for mm)

The user interface can be pretty simple. It can just be an approximate
bandwidth of scan or migration, but yeah, I don't know whether this is going
to be too complex. Pacing migration from user side isn't trivial either,
tho. If this is something necessary, it'd be nice if kernel can provide
something relatively simple to use and can cover most usecases.

Johannes, what do you think?

Thanks.

-- 
tejun

