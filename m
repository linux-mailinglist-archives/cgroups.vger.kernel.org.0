Return-Path: <cgroups+bounces-4790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E652C972A45
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C997D283EEB
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 07:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72F17CA03;
	Tue, 10 Sep 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVSTO2TF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B99183CA0
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952111; cv=none; b=o1ttGkIEXEM2gOKwToQPk0ZCLl+sN6Paaf7b68sKGihOAyOKduxV6pqo0ytjuVw7cBpDUsJHSTaJDuEO0lCXec5qAD6CGWYysvEQba1tQOv2TqNH9SKDTl/y7PJn6BHcjzbpS2WbZfu+qWCl51x70WjVx64ky32XNHeWiANGp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952111; c=relaxed/simple;
	bh=OLklJSVQNOQI9DT75fzTGObFLfetL3kq3g7TnME/nQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPsuzvswdUkEm3JWPBRu5tR+fbNVe0ZuDQzRfrlgSEeLsdLpzagdEcFEbJqRC1mN4jldrVMZaUipTnriR4EI7pYug3/v84iOHcskfsvZ/UO1ywqpco71pdUF43aVvBMWIlts+OJha2drqb23e5q+Nb3Jnlcq4GtCyrm0sYsZuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVSTO2TF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 00:08:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725952106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vplBtqjlTg4eBgWma6lIzm6/3ie/7e5vk9lsOVwoc9o=;
	b=vVSTO2TFJfh1EBJG/XSokcOFNomrhN3BkYDziVC4NY2avzIdL6S/ILOCI72lp+3AsqkUmD
	IJkeVKGcSo68y2a+HxMZyf5W+b18idowDgAk3gy7qu1MQ1hnmkRuvVOi+EMIedD5CNhRAh
	7Rv1kTIzsdPeW7p7GQLEJ5U36BCkjeM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Message-ID: <e5k22kuavnli72v3lmeezrewut6hvhfdpteouj3ii6dmcdiiin@2e3dlbs4ahe2>
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 30, 2024 at 04:22:44PM GMT, Jingxiang Zeng wrote:
> From: Jingxiang Zeng <linuszeng@tencent.com>
> 
> In proactive memory reclamation scenarios, it is necessary to
> estimate the pswpin and pswpout metrics of the cgroup to
> determine whether to continue reclaiming anonymous pages in
> the current batch. This patch will collect these metrics and
> expose them.

Please explain a bit more on how these metrics will be used to make
a decision to continue to do proactive reclaim or not.

> 
> Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> ---
>  mm/memcontrol-v1.c | 2 ++
>  mm/memcontrol.c    | 2 ++
>  mm/page_io.c       | 4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..44803cbea38a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] = {
>  static const unsigned int memcg1_events[] = {
>  	PGPGIN,
>  	PGPGOUT,
> +	PSWPIN,
> +	PSWPOUT,
>  	PGFAULT,
>  	PGMAJFAULT,
>  };

As Yosry said, no need to add these in v1.

thanks,
Shakeel

