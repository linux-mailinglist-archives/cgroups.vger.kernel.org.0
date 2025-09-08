Return-Path: <cgroups+bounces-9794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCAB49B8D
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 23:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2E03AED38
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3E2DCF63;
	Mon,  8 Sep 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="E2CMeczk"
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A92C1587;
	Mon,  8 Sep 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365757; cv=none; b=LuU+d/xvtngvHZdC/wMVsfIXdjgPZTCCYoMAgBL5S4Y2pdN2L54/nOB1a//k+i3Q0PlC3zgmywF1fns0KVFH/yy8vUizfrJs5oj+RslRHOIRtXvxFe402i+fU7TObNEDH14yiY0MsdUQKZ//f33sJi+YgfZjERNDsvLZw7b4JT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365757; c=relaxed/simple;
	bh=/P0P7qBcbcYDutF7YAaxCs97+nxv2gaQfytGlpB/5p8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f96FcZkrrjlmKOGFNQQNyYnkkVYREbbzq71XyGePuc3W+IbhGtY8jgevNqlrOU/aDaT2q1MDdn3ZnKK5UECkFqGOadocGU0GyAMthJLd2AnOen/ijvZLex19sBxAnGUYzNqhQFmdO6IiAzw2T9+u4NJVsgW/TXaKVEDKd45fkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=E2CMeczk; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757365756; x=1788901756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQiAiwFq2l0plLev52Qgg3ckSPW1kQUzFe2aH9v9SLY=;
  b=E2CMeczkDyHjG7+TbixoqKAC+6RRcaAS2F8g0KHBbVXW4dUeaZB7flCb
   wCI2UWlEeKXJmY0QDj3lMRLZPNSPYQ2fZ/Cp52LJLdH3CBN1u5HMlT5PG
   JiDknlGzYcsm0q2ocIpABJHeOoA7yRn60o8863ow5OfIxxnioKRcE5VkL
   wQh4yB/a+baEwWSu1nORfeVujcWycMdxeHNo85nimM0lVLeOl8ZNZusRj
   NzIZreyix+G2ZtJNIalCUfJj8lNijDUTW4OyhI/SiJhmUyj/3wgGaNvx5
   Qk1f2+zoPRdcFFB5QZnvhnVw4473rXjuNLsOFA5jZrl4cMua/jzWVNTSt
   Q==;
X-CSE-ConnectionGUID: HNW4PmLhTby4S2UJFDMUVg==
X-CSE-MsgGUID: NyZMZRApT9qBGIzBV4tvyA==
X-IronPort-AV: E=Sophos;i="6.18,249,1751241600"; 
   d="scan'208";a="2524191"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 21:09:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:23813]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.90:2525] with esmtp (Farcaster)
 id a7cc81e2-07cb-4676-b62c-df1fbd09d378; Mon, 8 Sep 2025 21:09:15 +0000 (UTC)
X-Farcaster-Flow-ID: a7cc81e2-07cb-4676-b62c-df1fbd09d378
Received: from EX19D032UWA001.ant.amazon.com (10.13.139.62) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 8 Sep 2025 21:09:15 +0000
Received: from dev-dsk-ajgja-2a-6a9b5603.us-west-2.amazon.com (172.22.68.79)
 by EX19D032UWA001.ant.amazon.com (10.13.139.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 8 Sep 2025 21:09:15 +0000
From: Andrew Guerrero <ajgja@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <ajgja@amazon.com>, <akpm@linux-foundation.org>,
	<cgroups@vger.kernel.org>, <gunnarku@amazon.com>, <guro@fb.com>,
	<hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@kernel.org>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <stable@vger.kernel.org>,
	<vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Date: Mon, 8 Sep 2025 21:09:00 +0000
Message-ID: <20250908210900.24088-1-ajgja@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025090735-glade-paralegal-cdd1@gregkh>
References: <2025090735-glade-paralegal-cdd1@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D032UWA001.ant.amazon.com (10.13.139.62)

On 2025-09-07 13:10 UTC, Greg KH wrote:
> On Sat, Sep 06, 2025 at 03:21:08AM +0000, Andrew Guerrero wrote:
> > This patch is intended for the 5.10 longterm release branch. It will not apply
> > cleanly to mainline and is inadvertantly fixed by a larger series of changes in 
> > later release branches:
> > a3d4c05a4474 ("mm: memcontrol: fix cpuhotplug statistics flushing").
> 
> Why can't we take those instead?
> 
> > In 5.15, the counter flushing code is completely removed. This may be another
> > viable option here too, though it's a larger change.
> 
> If it's not needed anymore, why not just remove it with the upstream
> commits as well?

Yeah, my understanding is the typical flow is to pull commits from upstream into
stable branches. However, I'm not confident I know the the answer to "which
upstream commits?" To get started,

`git log -L :memcg_hotplug_cpu_dead:mm/memcontrol.c linux-5.10.y..linux-5.15.y`

tells me that the upstream changes to pull are:

- https://lore.kernel.org/all/20210209163304.77088-1-hannes@cmpxchg.org/T/#u
- https://lore.kernel.org/all/20210716212137.1391164-1-shakeelb@google.com/T/#u

However, these are substantial features that "fix" the issue indirectly by
transitioning the memcg accounting system over to rstats. I can pick these 10
upstream commits, but I'm worried I may overlook some additional patches from
5.15.y that need to go along with them. I may need some guidance if we go this
route.

Another reasonable option is to take neither route. We can maintain this patch
internally and then drop it once we upgrade to a new kernel version.

Let me know how you would like to proceed.

Thanks!
Andrew

