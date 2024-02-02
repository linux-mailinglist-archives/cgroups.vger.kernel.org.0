Return-Path: <cgroups+bounces-1310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5B846769
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 06:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655AD2872E9
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5441F513;
	Fri,  2 Feb 2024 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="QQWV+MJh"
X-Original-To: cgroups@vger.kernel.org
Received: from mailhk01.kuaishou.com (mailhk01.kuaishou.com [129.226.226.143])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A1F9C1;
	Fri,  2 Feb 2024 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.226.226.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850786; cv=none; b=kbu0S089KYUQMBu2DyY8GN7y5e7P3PrTLQUnb4+puR/M9tnPGL7yVaIyBkDQsCOgCp2GufySd2SoZfoWhxpC3UQy3bAAEO+k/0N+z3lSwYhhNLTBCNsSJBooWtV6/njCWKsID4a/5S/ixjl/kcweW6SslDIuMBHllsZrlTJKoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850786; c=relaxed/simple;
	bh=mYuHHfEOYOGi1nsgDmOkYGVusfzPZT1V5vLWKFjwW/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHKON2+SXh7OI6UpirWKws0HFAeTGGtwltYtAc5WxgUPCOyPQq9chmZJ//1HH0sHP6i/qfV9Ud7gXkLdH9+NyM4eAbf1v98IZCMmzwPBGXvbKHgqj7dRcQybPNZH/IYVOv3pBQIdOqXHWTOmRXq//PYNVHC7ZRXlnq9Ein/LA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=QQWV+MJh; arc=none smtp.client-ip=129.226.226.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
	by mailhk01.kuaishou.com (Postfix) with ESMTP id A211C60E6A;
	Fri,  2 Feb 2024 13:03:35 +0800 (CST)
Received: from bjm7-pm-mail12.kuaishou.com (unknown [172.28.1.94])
	by bjm7-spam01.kuaishou.com (Postfix) with ESMTPS id 03C101809C7D9;
	Fri,  2 Feb 2024 13:03:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1706850201; h=from:subject:to:date:message-id;
	bh=kv+uNlFkCs164PfgZgLvFPjj78x8QizrenyK8Lktg0o=;
	b=QQWV+MJhP60Pv53iohRRniqcjlILuV8vNvm3yaM1x7hjrjqNS2VcHSwMJoced3vO6+ZZlMbCrHL
	VKC05bAjppcJuYW+jZzavBAR51WEhNlpKzWz9rNW0hkSVHIp5d54dv4UuCKftMKjUamguqPk4c8DQ
	KIKijLk2FBNHQRS2C+I=
Received: from infra-bjy-rs-infra-kernel6.idchb1az2.hb1.kwaidc.com
 (172.28.1.32) by bjm7-pm-mail12.kuaishou.com (172.28.1.94) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 2 Feb 2024 13:03:21 +0800
From: Efly Young <yangyifei03@kuaishou.com>
To: <hannes@cmpxchg.org>
CC: <akpm@linux-foundation.org>, <android-mm@google.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mhocko@kernel.org>, <mkoutny@suse.com>,
	<muchun.song@linux.dev>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<tjmercier@google.com>, <yangyifei03@kuaishou.com>, <yuzhao@google.com>
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Date: Fri, 2 Feb 2024 13:02:47 +0800
Message-ID: <20240202050247.45167-1-yangyifei03@kuaishou.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240201153428.GA307226@cmpxchg.org>
References: <20240201153428.GA307226@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: bjxm-pm-mail10.kuaishou.com (172.28.128.10) To
 bjm7-pm-mail12.kuaishou.com (172.28.1.94)

> On Thu, Feb 01, 2024 at 02:57:22PM +0100, Michal Koutný wrote:
> > Hello.
> > 
> > On Wed, Jan 31, 2024 at 04:24:41PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> > >     reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > -         min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > > +         max((nr_to_reclaim - nr_reclaimed) / 4,
> > > +             (nr_to_reclaim - nr_reclaimed) % 4),
> > 
> > The 1/4 factor looks like magic.
> 
> It's just cutting the work into quarters to balance throughput with
> goal accuracy. It's no more or less magic than DEF_PRIORITY being 12,
> or SWAP_CLUSTER_MAX being 32.
> 
> > Commit 0388536ac291 says:
> > | In theory, the amount of reclaimed would be in [request, 2 * request).
> 
> Looking at the code, I'm not quite sure if this can be read this
> literally. Efly might be able to elaborate, but we do a full loop of
> all nodes and cgroups in the tree before checking nr_to_reclaimed, and
> rely on priority level for granularity. So request size and complexity
> of the cgroup tree play a role. I don't know where the exact factor
> two would come from.

I'm sorry that this conclusion may be arbitrary. It might just only suit
for my case. In my case, I traced it loop twice every time before checking
nr_reclaimed, and it reclaimed less than my request size(1G) every time.
So I think the upper bound is 2 * request. But now it seems that this is
related to cgroup tree I constucted and my system status and my request
size(a relatively large chunk). So there are many influencing factors,
a specific upper bound is not accurate.

> IMO it's more accurate to phrase it like this:
> 
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small request batches to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batches to manage error while
> maintaining reasonable throughput.
> 
> > Doesn't this suggest 1/2 as a better option? (I didn't pursue the
> > theory.)
> 
> That was TJ's first suggestion as well, but as per above I suggested
> quartering as a safer option.
> 
> > Also IMO importantly, when nr_to_reclaim - nr_reclaimed is less than 8,
> > the formula gives arbitrary (unrelated to delta's magnitude) values.
> 
> try_to_free_mem_cgroup_pages() rounds up to SWAP_CLUSTER_MAX. So the
> error margin is much higher at the smaller end of requests anyway.
> But practically speaking, users care much less if you reclaim 32 pages
> when 16 were requested than if you reclaim 2G when 1G was requested.

Yes, I agreed completely that the bigger the request the bigger the
absolute overreclaim error. The focus now is the tradeoff between 
accurate reclaim and efficient reclaim. I think TJ's test is suggestive.

