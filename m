Return-Path: <cgroups+bounces-8484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F309AD4A65
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 07:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280DC7A74F7
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1AB225A39;
	Wed, 11 Jun 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcj1FQp1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FC17BB6;
	Wed, 11 Jun 2025 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619436; cv=none; b=JNedICMiTzBybk59oD8n1k5+zQOgxTzd3O4ef+6vYYjlCJ7uklGUdeU/Hdbh3PBOc4ixaTVZ8T4jTKnV8d0S3eMjQg2e8JI3ddo/hgNHAjKU1iDR5yC5z3GT/NReUlE7eICc7DcyGuEY7j11USWCIa3pzjDeUvQ79ax0t0H9y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619436; c=relaxed/simple;
	bh=QdkrtsbUzTDgsS/mT7ppoJf+YPJWtOY2mETjuHwI8bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDnDvzPBOnwb5iqy5y3IMQs0m3eD25gfvoMVCfUPVkFEHQzvWhK9jA9EVVrWpmy/rS865i751nNDoptaM5ZhA8ohs+jlG/6pI+qSIeO4YfIRSYn7nzll6fByTgg5AIimPCfEV66hkWJo7ZnmlkpriyM9zSrhmnRQM12PjDSwLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vcj1FQp1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2363616a1a6so15664565ad.3;
        Tue, 10 Jun 2025 22:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749619435; x=1750224235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2130SYJpBwgCGHXYYTpNm5sjUlFw+z+qbv0CH8rq1ec=;
        b=Vcj1FQp1PhGuXiyJO+dGE4calnsN2EGldJYYwmYijs5a5AY5Y+r1Uvb2YokrJot2mA
         n7S3bvaIW539ZXaIbyfmHRW9RP8tbJ6xkcBME4DtTh0/cDuGveS7O1R1Xlc2J7DnjyfU
         GTQltmeP8VQ0bRCMTUmjFLqXUnyT1ESXZN30flDuLA8PNVljjgoQI4f5ltDi5w+QDn+7
         zKWNr9Ai0FPyDPsNJO3GqU7qbxLqeAC01NUlDv5W6gL7uVDENAKMjfqmPjX+TmZTjQXl
         pWFAg7A9z+QVRMBi/FvEoBAAhGC1/r8v1dKUPOAmP+oREhuSyIOBw3bOxKjd0VuW7yZ6
         hk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749619435; x=1750224235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2130SYJpBwgCGHXYYTpNm5sjUlFw+z+qbv0CH8rq1ec=;
        b=KHqs0Zt9+eoNOc0n2uCFWWoz/WWE6nBwUiBbsTsCjMdO05VRAf3ieTZpRmgHtjYYBD
         Bm86X1Y1p2fKSXB8M1/usP4zgvGsD81yrOrzSiOfavAPedI1VuqpDXdY1NtFYNqRfEN3
         PQhiPVRvmvTc0lfCpCjkLjtDO0f/jvsKcuDyX3JL0xJH5UfPyIeWvntq++uwBHHtlKDp
         l7l9Xcdy1SLBELpRMMEyJQm+zkN2KBqMDZIkdQIRtLMLZgVaVk2kfWUWNg/8eZ11bLwM
         1pWk5o9nbzP/0EX1hPo3hC/ejEKm+dOPzkIYGqyls/f9+VYIQgakr3gMytwEANdH1EqV
         y6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8BuaHBcDjURyyADhi9qQM1QQy4/hhe0uM633tPP/AIfGCtxKAKOluyDxrhKYjEn8CzjIuEXi8Uo0eqEs@vger.kernel.org, AJvYcCV+AQQxwxGhu2QM32eUMV0x+ChPCq9rjh2+y+XDomGggoQdOqsySXyBIC3nGK9aRYfrgrM=@vger.kernel.org, AJvYcCVVnv0CYICJGzi7l+F/NtgFv0bhkkDJ9BcRNZ6qVUFn8g8eDkeMdEpHH3d/qPF+k+N37fuwV+d0zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqfTkfqsEdZWo6TFd/Q4ALsBZjyMf53NSx9hFSqWyQvNk2q6P
	cfGWAjgx6Oe/u86vqoFe1YP6K/0P25a++jT2ENlD4Tfes5/QYSTEuM2uHUe+5Q==
X-Gm-Gg: ASbGnctNG1pnLSEoo4cQuzIIrIwqDp+hOckVB7TgnLFkxMsbsidymrqM7UM7CvihOM5
	XEtCMkRGtRL3x02/Y1IMuQdHhy9DX+jCSu/4JoRexlcML+thsTxuzmby/wJWZV+iZDjBqaNcSz2
	lOFJEAn94eAYo8BI38ZDTAm2/Yn0s92JIENoI06/Z67zV4oed8uzQKFSpgsduyxEWjpSpkO903Y
	/Wmqg05VNxFit0YIW/2XtacKGt9lkOO5/RlHvhmpFCZA1xR5ivQ4LkQ3Kjw0anwX0a1R3Q/NZt5
	a4RrKHkLiY4LcqETUNOaZKTtTDgG+EBQgtWZrsH/nmZmiSi7SBSL0an1IA8lfvgye2kxase2tj9
	YC/P5TyeZKExEJxHV6+ZSwGWKBQa/+6AnbqY=
X-Google-Smtp-Source: AGHT+IEYoGt2DW8dmU8G7W8VbLXAXyReelYumM1CpQ6rdvCFn1U5bH0sa6DJ8R25zLoOr18TTOa5+g==
X-Received: by 2002:a17:902:cf0f:b0:234:e0c3:8406 with SMTP id d9443c01a7336-23641a8ac31mr24808175ad.1.1749619434535;
        Tue, 10 Jun 2025 22:23:54 -0700 (PDT)
Received: from [192.168.4.196] (c-76-103-195-132.hsd1.ca.comcast.net. [76.103.195.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603c6c325sm78316115ad.173.2025.06.10.22.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 22:23:53 -0700 (PDT)
Message-ID: <9cf00007-f068-4ced-8977-f39a792eef6a@gmail.com>
Date: Tue, 10 Jun 2025 22:23:51 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20250609225611.3967338-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 3:56 PM, Shakeel Butt wrote:
[..]
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index a5608ae2be27..4fabd7973067 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -138,13 +138,15 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
>    * @css: target cgroup subsystem state
>    * @cpu: cpu on which rstat_cpu was updated
>    *
> - * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
> - * rstat_cpu->updated_children list. See the comment on top of
> - * css_rstat_cpu definition for details.
> + * Atomically inserts the css in the ss's llist for the given cpu. This is nmi
> + * safe. The ss's llist will be processed at the flush time to create the update
> + * tree.
>    */
>   __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>   {
> -	unsigned long flags;
> +	struct llist_head *lhead = ss_lhead_cpu(css->ss, cpu);
> +	struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
> +	struct llist_node *self;
>   
>   	/*

> -	flags = _css_rstat_cpu_lock(css, cpu, true);
> +	llist_add(&rstatc->lnode, lhead);
> +}
[..]
> +
> +static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
> +{
> +	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
> +	struct llist_node *lnode;
> +
> +	while ((lnode = llist_del_first_init(lhead))) {
> +		struct css_rstat_cpu *rstatc;
>   
> -	_css_rstat_cpu_unlock(css, cpu, flags, true);
> +		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
> +		__css_process_update_tree(rstatc->owner, cpu);
> +	}
>   }
>   
>   /**
> @@ -300,6 +331,8 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
>   
>   	flags = _css_rstat_cpu_lock(root, cpu, false);

The subsystem per-cpu locks were used to synchronize updater and flusher
on a given cpu. Since you no longer use them on the updater side, it
seems these locks can be removed altogether.

