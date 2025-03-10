Return-Path: <cgroups+bounces-6933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A552A599B3
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47C33A5074
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1122D7B8;
	Mon, 10 Mar 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tfWc913k"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D522B597;
	Mon, 10 Mar 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619782; cv=none; b=nRUR7TYcHgKD11hVRxmm+JEiB2twUEI4bQV+E0OT+8E/jnRnwyrgBQ2CpPbnJ46jjD93vkOoXlFQbBlsPubEyTPqb8C5hahi36HslEJvMuQ3TlMNF+AfGODnfPXPyGIfCeB0aE5YAfkkJAnOZrqDcoU2IIyM9w7FbwqzTRijp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619782; c=relaxed/simple;
	bh=i29N+u43fRtD6lnjrMAJHY4VE43Yw+EgbKOaqHTP6x4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDs22YPtpissQKRxGIvZRwh1PdFekePFp5AfoVcKBf0xWYJ3CV8q6VISjKpX7ahEdyD4Wm1lgZNuA3xS+fPp/zOphzHrxx20L1YzY8v0N0ITRnQ93RXnmidXS7haazoI/HfugYuhVq6hFpk2XMDiHBir111wIhYTNydGCrTgD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tfWc913k; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741619466;
	bh=JVydiL4Vz0YDQP+EpA5Rcz0Mj+8qQUNDN9KpCmqJyDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tfWc913ku91iXJJozwhfpdl73cCxFoWsB2Z+GWM34ZEqJ1Ln+aG7fbbbNzJaNzIYR
	 Edkk+aSL2oQunO7f11MZJyc6lP3bduw7hNhinYw8QSGfo0qNU/v0azAzUFV4GsgP+2
	 EIyK2lXnMmooDmjwmZsLO4OCfAx7KzTYHbEqve0Y=
Received: from chenyu5-mobl2 ([125.69.38.41])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 2C114417; Mon, 10 Mar 2025 23:11:01 +0800
X-QQ-mid: xmsmtpt1741619461tc0wkaf75
Message-ID: <tencent_F6079264D94CE4B445A5EE6C3DAAE162670A@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSCkstl2Z/dxjKIClzdbHnjpDbGNcHLK0GM09CJ4Z0H8DECAbmuj
	 D/WWpq0UTlL8AWQFJWd1VcPhrB5oVMgjFFfCjnokjftQAMbzZhDoP+lDLMXmueoKVTmSlI5p7FWC
	 U3Pi09l8Qh59ZzJ4p5WMyvY/aOm3rX83ZM+vC2uqGfxlTPUw8AST1nX6Gl9zeam+QVHT59OIwUj8
	 0SUszbJvwUFSIhgWwARryf2IuqtGZguVi/buYrKoR5L0VovrCz8m0fHqg4aVzhjsvcqFFKPuhAG3
	 gquK/gti2Kv+lv2T9sgXPmhKlQOy6YHLjwXQTzr32mu68RuDBfYfz8HvUXUlu/qKO4bkxv2M4LYa
	 XXahRKg5Ar7pnFm6xTm2jtuIMZfWdZIT4RQkQRiCxgtcsgu3rfeKzTMk9FarSr9fXk8xKAUf9Ynm
	 rztyvO68yQmkWO8nMUcXJ7Y/BBaSIiyjF1vWVCkBDC+hZDNsJS78BLoOx/OqKz4ZfU7ADWf9d5Am
	 cHGl1YVGDSf/nCx1JfA2jocdFZ7D/UFME7IbChIoVidkImLkKstpovjI9Ton5MJbAOMVkGLkk1GG
	 VxhzOwPccWezdjO4WNmykLdnWsljE1oaY1LF0bMGOtygKphARu4z8a7Cc6B6uQ+8tlkV5kK6xBRp
	 byM1x1fz9QzlvCFraBw95EZX8ng9q30p75lR2xaVmPMXZA/DSl4qFxJ/QW/VEGvXncI2/THScPPI
	 UwfY+Q/obj4g8QkqgsU4IAy1Jd2Zr7pDy44eqykFlALna58ALi2X7HrmVnUUUnpWuIMWJLs4f6RY
	 OjJyUycyB5OIMBAyn6Y9Ncg3AlK9BbuYAJHDljzdL0dAqzITPji+u7H2s/5/P+MT+uab4R1xZWy+
	 uMf7c6nNjnWujdzHVC4TifkyKUBoxVXsO/9Vd5wEYSCq2L52EyNbrW8HCF5jUXWgr6TqnBI/7SbM
	 vuCAegoErmwvtX6hpfsQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Date: Mon, 10 Mar 2025 23:12:31 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Cc: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched/numa: Introduce per cgroup numa balance
 control
X-OQ-MSGID: <Z88BX/TLEEzo5Oxg@chenyu5-mobl2>
References: <cover.1740483690.git.yu.c.chen@intel.com>
 <Z8hh1urLnpmMxHqW@localhost.localhost>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hh1urLnpmMxHqW@localhost.localhost>

Hi Kaiyang,

On 2025-03-05 at 14:38:14 +0000, Kaiyang Zhao wrote:
> On Tue, Feb 25, 2025 at 09:59:33PM +0800, Chen Yu wrote:
> > This per-cgroup NUMA balancing control was once proposed in
> > 2019 by Yun Wang[1]. Then, in 2024, Kaiyang Zhao mentioned
> > that he was working with Meta on per-cgroup NUMA control[2]
> > during a discussion with David Rientjes.
> > 
> > I could not find further discussion regarding per-cgroup NUMA
> > balancing from that point on. This set of RFC patches is a
> > rough and compile-passed version, and may have unhandled cases
> > (for example, THP). It has not been thoroughly tested and is
> > intended to initiate or resume the discussion on the topic of
> > per-cgroup NUMA load balancing.
> 
> Hello Chen,
> 
> It's nice to see people interested in this. I posted a set of RFC patches
> later[1] that focuses on the fairness issue in memory tiering. It mostly
> concerns the demotion side of things, and the promotion / NUMA balancing
> side of things was left out of the patch set.
>

I see, thanks for the information.
 
> I don't work for Meta now, but my understanding is that they'll attempt
> to push through a solution for per-cgroup control of memory tiering that
> is in the same vein as my RFC patches, and it may include controls for
> per-group NUMA balancing in the context of tiered memory.
>

OK, it would be nice to see that patch set. We can continue the disscussion
on this basic per-cgroup Numa balancing control, the tiered memory promotion
could be on top of that IMO.

thanks,
Chenyu
 
> Best,
> Kaiyang
> 
> [1] https://lore.kernel.org/linux-mm/20240920221202.1734227-1-kaiyang2@cs.cmu.edu/


