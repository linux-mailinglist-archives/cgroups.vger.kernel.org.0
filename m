Return-Path: <cgroups+bounces-9361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06EB33193
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117C03BFD5C
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB41FDE09;
	Sun, 24 Aug 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYvqWYfp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418B224F3
	for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055227; cv=none; b=KFT2qHBkQFmbRXsh0SMXeFMNjlymbic0Qq0rMG5F8sez2zmcQYo9yIigIrs1jNxvZlkDcQk+HPlrhbNCBf4S/NVOUoNCKHE53iNvTXNq5/yDWXs776EQPXqLpCdRDf55VF5OhBpMyMXfq/a2JaY01u1fcxXvY1alqnzU5udGbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055227; c=relaxed/simple;
	bh=lDaltKtNEh/B3D1Afd8rwi6dnA/KnseN9WIhGSPgo7o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tFE0s/KMnmsvAWcG46WlzKlei8+sPxUnVOGbtHxHQlVkGR03sPIuyDfnIRvqgmV5DYj8m08xUa8J5OQsYjcpKyS8/bp3E59sGE7KQlY26XL0350P6438urUeTAL+gCsSMwcewHVpANThqIaa6+ElqsWmHX+++N+bfvYG40X93Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYvqWYfp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNrAqXg/v+cm7+zI5j2sPacYW1E0XzgSJ3O3WFJ2ZYo=;
	b=AYvqWYfpAS2EvPihBYTRZK7LiAWVCDbxGduGGXR9VH9/feiPBr7VacDQsqwrUC2fHSwG0s
	1hi1XNma+548BGcOSJcNPkoW+203UDu3f1tcsoKcTPpePrSbnHaogL/10UsG6v6lyT8ArJ
	UX/cgObtPjc3cIj5HqW7VDmJ57mscLI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-qrdiGWW4NlyX26B7_vQttg-1; Sun, 24 Aug 2025 13:07:03 -0400
X-MC-Unique: qrdiGWW4NlyX26B7_vQttg-1
X-Mimecast-MFC-AGG-ID: qrdiGWW4NlyX26B7_vQttg_1756055222
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71e81ca12b7so50017997b3.1
        for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055222; x=1756660022;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNrAqXg/v+cm7+zI5j2sPacYW1E0XzgSJ3O3WFJ2ZYo=;
        b=uhJC3kLZikEdfPYN6o73pIn/zTlQXlH/0Wu1NpZCvnS7CxDpXtcEAPeZuDrXcYTZp6
         xDPIdOi4/aCepxbMIG9RC6gNJJBz/EPVJDT4nPkPOODW9c2v1A+WJ+nfsPfhSM4Z9aQ1
         DlTWGsn24e9bcg+jZOhjk7/UfEzU3aT0N/hI83eT+uEM2GkOGXTM9yHStdYI61LgchIC
         qnp2SpmiURYvE3xKgWNrDnNyuZW/m7Egx2WRDhCjdmY8H20DNqx41pRFVH5qKQLzbdzv
         akin+nAYF8JCcHD4FQlI3OZuwu89AAE8Q/RhGgyDXdFDYxh93WprT5ahfNqQZw0X036u
         LwUQ==
X-Gm-Message-State: AOJu0YzMGhTkCklOdI5wpLeIk/642eLoTXYi6/nGIWWZt/BxV/1K4IM5
	WobDaM0lGkHqhUuVRbakS+6cGSYnbfztDvWK2FpZxGjtrZOcfoORojBFz7eW6E3BzLPTUBYjpoX
	b0NYobKJgmfU8e18Ctw2RWdz3z+ZDubqLCXlGRjSAuOid6h82BalXN9SrcJM=
X-Gm-Gg: ASbGncvwZdCiTLAyyOPuZmT6ZTiPWMku++Ii5IUKkvilFqF6YZ7I+1MYTtPDCAjVMGC
	IqAIzFNl5SSTp9qkyFgQtI3kUVNDuQj/jJy5FlOvsCMwOzT/Gef0UF4Ty0AcfhDOY4qh+UfLODs
	tqD962FHEYwa9IffEs2+dzsjiCblCjy02vkMcYFm5rsSULR9b3QqoqVjcUNaHxt3p0A43Ge3dzr
	WegRh782IfhSH8He44qfkCtAMa33K0fQdXI+Y3oGezq+OJ9q8LCDqJb0OcxOuJ01aOyABTkVhTO
	7HlYDLLfHGCJ5SvT4kwCvBAqqjR+jcNh4zkxatywNasAtleZJMIHrUNwdDi12PRPbJ0WI90Vv/T
	h4gjSd8oyrA==
X-Received: by 2002:a05:6902:33c5:b0:e90:637a:cb36 with SMTP id 3f1490d57ef6-e951c2cf43dmr8789879276.6.1756055222340;
        Sun, 24 Aug 2025 10:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlAMw/iT5DD8US/YGBjHap8VpxFfxypzkaG2QlsBxLEjQEgd+0LTI7IL8yRIgM8JIKNlfDHQ==
X-Received: by 2002:a05:6902:33c5:b0:e90:637a:cb36 with SMTP id 3f1490d57ef6-e951c2cf43dmr8789845276.6.1756055221861;
        Sun, 24 Aug 2025 10:07:01 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358904sm1722045276.24.2025.08.24.10.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:07:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <54e1466c-8db7-4fd1-a60f-5590015afaf2@redhat.com>
Date: Sun, 24 Aug 2025 13:07:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 1/3] cpuset: decouple tmpmasks and cpumasks
 freeing in cgroup
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Currently, free_cpumasks() can free both tmpmasks and cpumasks of a cpuset
> (cs). However, these two operations are not logically coupled. To improve
> code clarity:
> 1. Move cpumask freeing to free_cpuset()
> 2. Rename free_cpumasks() to free_tmpmasks()
>
> This change enforces the single responsibility principle.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3466ebbf1016..aebda14cc67f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -459,23 +459,14 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
>   }
>   
>   /**
> - * free_cpumasks - free cpumasks in a tmpmasks structure
> - * @cs:  the cpuset that have cpumasks to be free.
> + * free_tmpmasks - free cpumasks in a tmpmasks structure
>    * @tmp: the tmpmasks structure pointer
>    */
> -static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +static inline void free_tmpmasks(struct tmpmasks *tmp)
>   {
> -	if (cs) {
> -		free_cpumask_var(cs->cpus_allowed);
> -		free_cpumask_var(cs->effective_cpus);
> -		free_cpumask_var(cs->effective_xcpus);
> -		free_cpumask_var(cs->exclusive_cpus);
> -	}
> -	if (tmp) {
> -		free_cpumask_var(tmp->new_cpus);
> -		free_cpumask_var(tmp->addmask);
> -		free_cpumask_var(tmp->delmask);
> -	}
> +	free_cpumask_var(tmp->new_cpus);
> +	free_cpumask_var(tmp->addmask);
> +	free_cpumask_var(tmp->delmask);
>   }
>   
>   /**
> @@ -508,7 +499,10 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
>    */
>   static inline void free_cpuset(struct cpuset *cs)
>   {
> -	free_cpumasks(cs, NULL);
> +	free_cpumask_var(cs->cpus_allowed);
> +	free_cpumask_var(cs->effective_cpus);
> +	free_cpumask_var(cs->effective_xcpus);
> +	free_cpumask_var(cs->exclusive_cpus);
>   	kfree(cs);
>   }
>   
> @@ -2427,7 +2421,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   out_free:
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return retval;
>   }
>   
> @@ -2530,7 +2524,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return 0;
>   }
>   
> @@ -2983,7 +2977,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	notify_partition_change(cs, old_prs);
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_locked();
> -	free_cpumasks(NULL, &tmpmask);
> +	free_tmpmasks(&tmpmask);
>   	return 0;
>   }
>   
> @@ -4006,7 +4000,7 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_cpumasks(NULL, ptmp);
> +	free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)
Reviewed-by: Waiman Long <longman@redhat.com>


