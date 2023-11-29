Return-Path: <cgroups+bounces-672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE67FDAF5
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7451C20BE2
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E812374E3;
	Wed, 29 Nov 2023 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="t45yazmd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB7C9
	for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:17:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cc44736f2so37888881cf.3
        for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701271047; x=1701875847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki5eAeZpOcI54YbTPSCFwp5UJ2eI9c3pK5uL2lEEtZM=;
        b=t45yazmdyT7D3V75tVpLMivlCMgeR/JvS/+C/lc7BHmzaprkmFWcankS3PQr7flX5U
         iro9DZmFQLFpz1giKu33Gx3a0hs2o5P0fXJ3nePPDmHNHJBITL4OvksYckJlpZuq6x/t
         KXpt4mDsz/Men8Xe0f6AnBNSr+ipGBke/yG6hy5keISNVDeIbmnlj0iDfO6k4wEV9XwL
         tO4AaMXr1vXUfpzmjVkE5JkVyr0ZdvPfDf38HIbti5rcMxqkXLJsocTDGnQU0Yl0KSu2
         GyQmwozT25v4QB4gsFDL0PDXLh3atKDMZbJPIKzDVL5prK9VcM1yGRM4LnUwqvYt+3N0
         wOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271047; x=1701875847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki5eAeZpOcI54YbTPSCFwp5UJ2eI9c3pK5uL2lEEtZM=;
        b=WADQSwjawZuF0owN/rMVK3QtMavMGavOgQJfgH+NqOyG5/uLvQ0KDgHHjKmisdwuOK
         kVjIPttEKEYqDd8uPzdTKiEpmRW1leLSFQAl/qmR/l2pJ2XqAhQV18JROzXcy1efTajs
         nQFVYcpjy5bBhMpx6f6M2jzmITG3Kcg9Y27PyMLp1s3ZP6/NCkG8PIm/z9MnEHTIZQRn
         WmvbZU3dCrflqLWH4QjwrnmSLRsOzn45izrFJJvmZkmo6iBkIungQjQCd64iyfeSCmKX
         nxeggxdsPg33gLDq8t56O8qDPo0QXyUEXyWoD8wZhT4DCr+KfsVWmHbD+Cx26Us5WlMX
         i10Q==
X-Gm-Message-State: AOJu0YyLA0tfwLcLXRUhzesYZAwLsLhzfDYfGX1MyMAo9vCV3DAyTTnh
	KoGNfvDNwX33s5HdyfwS5qIwJw==
X-Google-Smtp-Source: AGHT+IEZIE1AM5E8zn+REarKZMAnlku7irhSBH7MhlpFKWn2MeAvwTjAn78X+XkDrH28XBpWMoOlEQ==
X-Received: by 2002:ac8:7d12:0:b0:423:792f:d5ca with SMTP id g18-20020ac87d12000000b00423792fd5camr24998108qtb.63.1701271046994;
        Wed, 29 Nov 2023 07:17:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05622a229e00b00423a0d10d4csm4386593qtb.62.2023.11.29.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:17:26 -0800 (PST)
Date: Wed, 29 Nov 2023 10:17:21 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
	vitaly.wool@konsulko.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 3/6] zswap: make shrinking memcg-aware
Message-ID: <20231129151721.GC135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-4-nphamcs@gmail.com>

On Mon, Nov 27, 2023 at 03:45:57PM -0800, Nhat Pham wrote:
>  static void shrink_worker(struct work_struct *w)
>  {
>  	struct zswap_pool *pool = container_of(w, typeof(*pool),
>  						shrink_work);
> +	struct mem_cgroup *memcg;
>  	int ret, failures = 0;
>  
> +	/* global reclaim will select cgroup in a round-robin fashion. */
>  	do {
> -		ret = zswap_reclaim_entry(pool);
> -		if (ret) {
> -			zswap_reject_reclaim_fail++;
> -			if (ret != -EAGAIN)
> -				break;
> +		spin_lock(&zswap_pools_lock);
> +		memcg = pool->next_shrink =
> +			mem_cgroup_iter_online(NULL, pool->next_shrink, NULL, true);
> +
> +		/* full round trip */
> +		if (!memcg) {
> +			spin_unlock(&zswap_pools_lock);
>  			if (++failures == MAX_RECLAIM_RETRIES)
>  				break;
> +
> +			goto resched;
>  		}
> +
> +		/*
> +		 * Acquire an extra reference to the iterated memcg in case the
> +		 * original reference is dropped by the zswap offlining callback.
> +		 */
> +		css_get(&memcg->css);

struct mem_cgroup isn't defined when !CONFIG_MEMCG. This needs a
mem_cgroup_get() wrapper and a dummy function for no-memcg builds.

With that fixed, though, everything else looks good to me:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

