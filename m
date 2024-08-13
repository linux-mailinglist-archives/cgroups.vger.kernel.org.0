Return-Path: <cgroups+bounces-4245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35D950FC2
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A41F2426C
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3DA17C7BD;
	Tue, 13 Aug 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mBRKlPf1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A6370
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588249; cv=none; b=N6sMG5zGLfxgWdOxAmt2UGT+OpNURV5WsqUv7gtiwPWMZM7mIkK/2SwGqVJRY61wDS3CCKurU+ohhTUU2k9swOKlCqTcO0haRa7dk2B4UppywFrNKGk5CDE9SHLw7UzITbp+N7ft5Hbb91qyROAQzPhIV0Bc/xXqqgd1i2YUyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588249; c=relaxed/simple;
	bh=gQOJ+4j78T6EtE908WMXHt3z2FLrSRsdpVclT7uyjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CINEXsfnHO0iPbMUFr/dXek1H7e2rCo6/gB9OxGALOL3gWUgK7Q8/gghlGXKwz90PZxeDf8Ess1fmuWhX5b03y4onwdlGv7L+eYQGBMCfv6phveph4ywBJkCG0I8ogA117B1CPqjofZitJs91KN7ExdH3AV76sdQr9SjgUg6soM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mBRKlPf1; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Aug 2024 15:30:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723588245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aS5ftMGKo/Ru7Ti/UB5xv32zI9bpFTAyHk1po8m4DE=;
	b=mBRKlPf19qmSOJKwWoZtfmEMPwu4TlmUiCfA0BhVZYOH71LHF+YSnZoHvNl7uW6RssnpVb
	bsl025VbXhHtN977rOKoz7tcGu9vw1qzO6HpTczdlJGeiiPiLiWjDYOtkZANgMGVEoLY9c
	v9612sDqGPK+yFjIpDes0ugxnCoukaA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
Message-ID: <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 13, 2024 at 02:58:51PM GMT, Yosry Ahmed wrote:
> On Tue, Aug 13, 2024 at 2:54 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The Meta prod is seeing large amount of stalls in memcg stats flush
> > from the memcg reclaim code path. At the moment, this specific callsite
> > is doing a synchronous memcg stats flush. The rstat flush is an
> > expensive and time consuming operation, so concurrent relaimers will
> > busywait on the lock potentially for a long time. Actually this issue is
> > not unique to Meta and has been observed by Cloudflare [1] as well. For
> > the Cloudflare case, the stalls were due to contention between kswapd
> > threads running on their 8 numa node machines which does not make sense
> > as rstat flush is global and flush from one kswapd thread should be
> > sufficient for all. Simply replace the synchronous flush with the
> > ratelimited one.
> >
> > One may raise a concern on potentially using 2 sec stale (at worst)
> > stats for heuristics like desirable inactive:active ratio and preferring
> > inactive file pages over anon pages but these specific heuristics do not
> > require very precise stats and also are ignored under severe memory
> > pressure.
> >
> > More specifically for this code path, the stats are needed for two
> > specific heuristics:
> >
> > 1. Deactivate LRUs
> > 2. Cache trim mode
> >
> > The deactivate LRUs heuristic is to maintain a desirable inactive:active
> > ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
> > and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
> > check if there is a refault since last snapshot and the LRU size are
> > needed for the desirable ratio between inactive and active LRUs. See the
> > table below on how the desirable ratio is calculated.
> >
> > /* total     target    max
> >  * memory    ratio     inactive
> >  * -------------------------------------
> >  *   10MB       1         5MB
> >  *  100MB       1        50MB
> >  *    1GB       3       250MB
> >  *   10GB      10       0.9GB
> >  *  100GB      31         3GB
> >  *    1TB     101        10GB
> >  *   10TB     320        32GB
> >  */
> >
> > The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
> > 100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
> > LRU size information to calculate this ratio. In addition, if
> > deactivation is skipped for some LRU, the kernel will force deactive on
> > the severe memory pressure situation.
> >
> > For the cache trim mode, inactive file LRU size is read and the kernel
> > scales it down based on the reclaim iteration (file >> sc->priority) and
> > only checks if it is zero or not. Again precise information is not
> > needed.
> >
> > This patch has been running on Meta fleet for several months and we have
> > not observed any issues. Please note that MGLRU is not impacted by this
> > issue at all as it avoids rstat flushing completely.
> >
> > Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Just curious, does Jesper's patch help with this problem?

If you are asking if I have tested Jesper's patch in Meta's production
then no, I have not tested it. Also I have not taken a look at the
latest from Jesper as I was stuck in some other issues.


