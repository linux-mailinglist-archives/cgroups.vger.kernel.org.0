Return-Path: <cgroups+bounces-7299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8BA79225
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761941707CB
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5123BCE4;
	Wed,  2 Apr 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="XjwhcKjK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6120E70F
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607642; cv=none; b=c0cVAtCIBA5YXWzPlDWyuvoY0fZwhMoDv66JSH3YuNYcp5rvbRgTlw+ehvWVRlamh1h5CYvk/NI0RQC7Np2nFvpcam9+aKdxeMGFeWTbq+GY7Qn4k7s1VFSyrUPcdLNfb4RebhBPZD4WUyAcLofLhHBIAHbu++5Ft0roOctkSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607642; c=relaxed/simple;
	bh=txtat177/PlnHm55yhzLIBUhJ0o9pOS1InRhNIvgap4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrVCXuxtwZcWJORytIYSdNSN/C0/qAc9zd2v+rjqNVGy8FlLSwFy33aBwrZMISlQXhOr7c/szEWIF92s6apRAHozWKcTU2B9EpDyZcVeti3DMH/slULNfFb852mdvlLDGbeJKcCm1qtdrYEk9INUZ0bj+tjsIijirYGmvXcYrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=XjwhcKjK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c592764e24so110965985a.0
        for <cgroups@vger.kernel.org>; Wed, 02 Apr 2025 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743607637; x=1744212437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swp0ERIz+E6S0fYtrVurk6RuHTXtNkHGNmb4MbsFy44=;
        b=XjwhcKjKyJuTXM2BEZEMeEt1f2Ol7MbCxJtPm/R+W6D/B7Q6LUs97ezS1rLcVsONwL
         rCFKiYctSPiBZ4blHEy9+g3BE1gar8WBQDt3wQIGKV8Nn1W/EZXQPX2jmScHeJrX3CBt
         JqXNopPXcNShqaGWlvJn+k164OVgQ4JwX/J8thzqMAdBbZE8jlM5HUZ0g53iO9es+XVx
         1kGfhzF3YUVhT1W6TfqoAYZPIt7GUAq91qZHdT4TPvMJXHPMbpLWb4h8mA0a2LqapVp8
         sAhWIIcXJdnylM2svQpQ12Ig4xiVT+e+UfMT2qfiAkKnBT+oSqfXaQqXO+R7svCOKMoG
         g8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607637; x=1744212437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swp0ERIz+E6S0fYtrVurk6RuHTXtNkHGNmb4MbsFy44=;
        b=ru3O+hbmaFrUOWNZBAe3UMycjHTNtnimynFsGX4VndJ9w2+OCSWXb00jpmbFHmRa0X
         Ys07oQWyCE8ICFtgVnI1JlgjomdNij2xHhPQ7cEwXhz8ocGefHewn7xxqqVqpK3jgeRK
         M+rF73yR8L5TUPSLl1u7UJ4ZmNDoP90jWXulAIdTcoPygVwvsVEiTyp+PjVDqXGSyweH
         TatCtVYgv2sxiTl9ldXrbK5BIPKT+eEyAOjsMuLD0Y92oJoVuFhIt8YyKLAQngHWPDNf
         gEzOqj7eV4C/J/YyLNMhruivhOtMKaIU5sci/FWsySoFbgJY+AIG+bXiB15QwhvR53cs
         VkSg==
X-Forwarded-Encrypted: i=1; AJvYcCVAiebcZqbwuUcpL45FOFx7p4WLaodq9Cswm2G+YrHpwnMziqwnHXyQ25GARJRuAAcb4lsVqcON@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7W5Cpo24qMUA7P7r8Axr/3fsldZ+wugI/yDdQnMNMTM7hwgu3
	I9Zc90IWC32DPjfZXqOVvT5zsovtvGrQ5wIKeE5I8wEShrKIJqs0tbcV11FUr7w=
X-Gm-Gg: ASbGncvkmsJzTNCNG/ojImNzOEABz0PCfEmQRM1eaM1NFC1UhGUPNaDKuBRN6oL5n0D
	cAjfAaLYaJusYG/S0erwrGG7sJLKenxcnf70S/7YAQqTbfOAvIGiwc+cMVYZRvBuceE8ZmXe1an
	izMKeQqkz7tGIrzuTAFhDTHGDZfPCAh7yyBe10fRu3zwZNT9j+nf+AwDROEHAj5vWK9CTtSWmzx
	5Zs7z1LqwUtmAZp1VkWBtqFHsLUctnO9JF0t2URFM2IKVnWIZkCA9PtODi+cmT1QuaE1eQRMZjx
	+2SYFlSBjM5zoV9ZiiQDMxLI0Lbjbvpw5TZPem1vXuo=
X-Google-Smtp-Source: AGHT+IHJsyMfk1EJsf13VfMIMZgUAxHzVAUrgG99uJym7wCUyl4f8lI2YuB3eaEGFaakifl2T8iN8g==
X-Received: by 2002:a05:620a:2806:b0:7c5:e8c5:a307 with SMTP id af79cd13be357-7c768236b36mr334604985a.9.1743607637061;
        Wed, 02 Apr 2025 08:27:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eec9798807sm74840846d6.116.2025.04.02.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:27:16 -0700 (PDT)
Date: Wed, 2 Apr 2025 11:27:15 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups mailinglist <cgroups@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memcg, oom: do not bypass oom killer for dying tasks
Message-ID: <20250402152715.GA198651@cmpxchg.org>
References: <20250402090117.130245-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402090117.130245-1-mhocko@kernel.org>

On Wed, Apr 02, 2025 at 11:01:17AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer") has added
> a bypass of the oom killer path for dying threads because a very
> specific workload (described in the changelog) could hit "no killable
> tasks" path. This itself is not fatal condition but it could be annoying
> if this was a common case.
> 
> On the other hand the bypass has some issues on its own. Without
> triggering oom killer we won't be able to trigger async oom reclaim
> (oom_reaper) which can operate on killed tasks as well as long as they
> still have their mm available. This could be the case during futex
> cleanup when the memory as pointed out by Johannes in [1]. The said case
> is still not fully understood but let's drop this bypass that was mostly
> driven by an artificial workload and allow dying tasks to go into oom
> path. This will make the code easier to reason about and also help
> corner cases where oom_reaper could help to release memory.
> 
> [1] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/T/#u
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Thanks, yeah, the investigation stalled out over the new years break
and then... distractions.

I think we'll eventually still need the second part of [2], to force
charge from dying OOM victims, but let's go with this for now.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

[2] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..9c30c442e3b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1627,7 +1627,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = task_is_dying() || out_of_memory(&oc);
> +	ret = out_of_memory(&oc);
>  
>  unlock:
>  	mutex_unlock(&oom_lock);
> -- 
> 2.49.0

