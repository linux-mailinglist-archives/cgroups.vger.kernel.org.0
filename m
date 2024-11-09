Return-Path: <cgroups+bounces-5493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD379C2908
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 02:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30FC1C2208A
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C71DFE3;
	Sat,  9 Nov 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+xYkVCO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F71BC3C;
	Sat,  9 Nov 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114196; cv=none; b=d/gVurfMnjQbmfEGFKNa6tl09HuokA9EOrgvjktk+jjHPzUKUp5ZISzFDOKlJo5qra6Mcl/1Rfyk2jg19ch8D4XD69lKHThEUh/kh7CBNo8XommfxCMtx8y88ujsrosS4zmcGsjBjFmjA3XmMdSXUExK3l9w0IOOOLE2UYabLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114196; c=relaxed/simple;
	bh=1dSZzFv9gjZ3IpUjNzhwfDSwFdOHj6V1+qdMKNvcbD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubK6VaBEktpzof/IF/9CTBQlfMLyIy+Hp3RhTi/8XvLfraSnkAr3hxea+mhIqqZ2GedV1NMJEs7ROGKlnvhBJsnsRwawIOLlVmDSzlfdNxnf5PUvVTEf0vcv1yUWCDV47AoHir9nCk7kAc5si3009caRPhKcWvVlw5cYgEETD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+xYkVCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8946C4CECD;
	Sat,  9 Nov 2024 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731114195;
	bh=1dSZzFv9gjZ3IpUjNzhwfDSwFdOHj6V1+qdMKNvcbD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+xYkVCOiU5+M26HAGC7DG6u5Ie9AMnuq7R1FImR6FsnzbkF+f562hQmMg+LgdObJ
	 c6tAZTzKluIkcSafKJq7DVoTKfrjAQ9GSNZPLwbbhe1OPjtVNHUYpAwvWhyUPrYX3B
	 53SHbZ8/NM3Iq6ainLaJgdwZ0qVrvpEPLT7/biY4FLsqN6EAKFTaEIHu2OLa73an9C
	 9UMrayu7e8cd+MQeRgT4vWuVVPa6Z/OgYJI8dyfaHTrVMJfv2RIxKNxGhpSZoqPHsS
	 GjJywuhd4eA748fN+ASwD/ihtkQpSZuueR568ikCmiULopVIN2DaKh6wgLUu/3H5IS
	 WLuQgv11QRmkQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Date: Fri,  8 Nov 2024 17:03:07 -0800
Message-Id: <20241109010307.74840-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Fri, 8 Nov 2024 13:29:45 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> This patch introduces mem_cgroup_charge_hugetlb, which combines the
> logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of

Nit.  Seems the regular expression is not technically correct?

> memcg in hugetlb code, and also consolidates the error path that memcg
> can take into just one point.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/hugetlb.c               | 34 ++++++++++++----------------------
>  mm/memcontrol.c            | 19 +++++++++++++++++++
>  3 files changed, 33 insertions(+), 22 deletions(-)
[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 97f63ec9c9fb..95ee77fe27af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4529,6 +4529,25 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	return 0;
>  }
>  
> +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)

Can we add a kernel-doc comment for this function?  Maybe that for
mem_cgroup_hugetlb_try_charge() can be stolen with only small updates?

> +{
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
> +	int ret = 0;
> +
> +	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
> +		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (charge_memcg(folio, memcg, gfp))
> +		ret = -ENOMEM;
> +
> +out:
> +	mem_cgroup_put(memcg);
> +	return ret;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
>   * @folio: folio to charge.
> -- 
> 2.43.5


Thanks,
SJ

