Return-Path: <cgroups+bounces-9488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5AB3C2F1
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE9CA2679E
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC4423A9AD;
	Fri, 29 Aug 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTbGqE+w"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A823507E
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495288; cv=none; b=Fa+F/9S6qhjOsmiySIZLYSSN3cwpI+E5eRuQw9cytehJkVL/NRKrXovdyRlXJmucK44K25heuLjSc+uiWG0n+CNy9A8cQCz4Zdtvmkd3jcF5dTE/GxNrD4jdrQ57e0ILGNcUU6PFx0Cwg15VlnRa8cElAvSzWHGBRtucp1N6K4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495288; c=relaxed/simple;
	bh=hK17IfEkQPKPDjCpfxZ5JVNVvlsbIV7qS2oZLI8Q3Tw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lf9TGIgETC0O2QWu7JQ8JFCdCVBqg3bqHbpVhvg8xHEnxSvWGoa/YBI2o46hX8tO7Ur5wqwfNJMbDvYa3MIqeEXI2LSTZFQXVDa+kzLCuLJMAlZDsViAjLaYxP1XcE2A9PWLfZO8yvpBCUDnyknYDLBsbQUzKbnF5O+t+m16DHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTbGqE+w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756495285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCaI/X8aeKRskP+b5t1n4+81zkWLAo/N0Osp8Y6VlhE=;
	b=CTbGqE+wBvWPNoZF2nBxdO+zcHpaJpY4zN3FLfl46eRbcgw97lIYr3rV520cexqLi5Wa4r
	wpV621bYAY3uxur2r77lcZ2UKxtOAt2Y5lTI7HhTSuqK9m/TblbrvBtBEgpVpCojczJeat
	Uocp0WMQwMKape4b3Ppqxbhd11+h7+I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-cNP3oAEQP6iL1YGlTI2rIA-1; Fri, 29 Aug 2025 15:21:24 -0400
X-MC-Unique: cNP3oAEQP6iL1YGlTI2rIA-1
X-Mimecast-MFC-AGG-ID: cNP3oAEQP6iL1YGlTI2rIA_1756495283
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7f7ff7acb97so358025385a.0
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 12:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495283; x=1757100083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCaI/X8aeKRskP+b5t1n4+81zkWLAo/N0Osp8Y6VlhE=;
        b=k4Z/UCmxijymXUZ0yD7VtaMIiX7ZdiXfH3ge/6Iz0zBPmZkrBuLSfZlaw6yg1gQHwP
         JM6Cm3sAMAsQOiC9iZ3AwdC5WbUOsQ72zp0fIkIVXnGC+VGaBg33K6R2RbCF9SYt8p9A
         lpKRUpDS12vPWbTYZliOGXQ8lhTplXg4rL+PzbzTqEm5i45wNm3mvgCF65qU7rVcKq0L
         JyHs2ZaQIQpe8NKjVaGyHLC3fyEDP8DWQQW4l98ZrLG1RDg79LNGxJAKzDZjex6QIbn4
         pUdSiPXw67XkGIK0PcJ2JnchZSCJvg50+s9p4v2sM8DnMJnRpzUOIYxRCcld9sx1MKn3
         lkEg==
X-Gm-Message-State: AOJu0YzlsST05bRc+p0J2l/o7N37GmLA4xK/7vu73pZnHfOeQrQojcd4
	nulfAo0Ole0+Uy++xeNhkOLGVbecvOrjz+QmNZnekcT0+aLspiolwkrSQIgmL4ZU253V6M2SS2c
	6Sumh9AtDlne89h670E1E8GeEgTke3tJfD9kY1E5QwZZH9DgpojLqwZH4CWA=
X-Gm-Gg: ASbGncs+hrnzS8nNr9ccD9pWutiVScQSN8I8fl/UE3nu5RbP95sATIj7XoaVY98eWQB
	onVNeN/Nu95WB6XFlOczJ1BstVUCNEBs9MSNt5+q7mHrMgxGP5gI1ZtASqO/nduls4Y9Cte7cUW
	UrqaUvCqAsfiWN27yS41XWI7uE4EX5LiRzjsu5K9gGjJnOEfcd0Pqp14xXswHZvAqNwikXpX7bk
	GFuchK1k+2Iykvi55s7uTlmbKK1NEXZvFXtrA0f1zduuPWHh9eFcQS7gKlCWtmPJlC4wOCFBcXm
	UvhJj3phZr/OxxFeF5vY//9gJcuzy4pBM/Ku0h19sZVcWRT9SzhrYBhYb9k9fv+Zd9LP9VCrAnq
	dsDpw9gEF5w==
X-Received: by 2002:a05:620a:c51:b0:7ea:38b:9bca with SMTP id af79cd13be357-7ea11075b20mr3290210585a.69.1756495283012;
        Fri, 29 Aug 2025 12:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcX6A58rjCSp6Jxt7PGZZgXeT2tZeDBtT/FBp3FFU8n7BGDi8emJG8OVjlbjfcQI6MHyAdfA==
X-Received: by 2002:a05:620a:c51:b0:7ea:38b:9bca with SMTP id af79cd13be357-7ea11075b20mr3290207885a.69.1756495282598;
        Fri, 29 Aug 2025 12:21:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484e8e8sm233378085a.40.2025.08.29.12.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:21:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e02b9c35-c51e-45c0-a2ca-3d1f0492af23@redhat.com>
Date: Fri, 29 Aug 2025 15:21:21 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/11] cpuset: move the root cpuset write check
 earlier
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'cpus' or 'mems' lists of the top_cpuset cannot be modified.
> This check can be moved before acquiring any locks as a common code
> block to improve efficiency and maintainability.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b..7e6a40e361ea 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -337,6 +337,11 @@ static inline bool cpuset_v2(void)
>   		cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
>   }
>   
> +static inline bool cpuset_is_root(struct cpuset *cs)
> +{
> +	return (cs == &top_cpuset);
> +}
> +
>   /*
>    * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>    * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
> @@ -2334,10 +2339,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
> -	if (cs == &top_cpuset)
> -		return -EACCES;
> -
>   	/*
>   	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
>   	 * Since cpulist_parse() fails on an empty mask, we special case
> @@ -2783,15 +2784,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   {
>   	int retval;
>   
> -	/*
> -	 * top_cpuset.mems_allowed tracks node_stats[N_MEMORY];
> -	 * it's read-only
> -	 */
> -	if (cs == &top_cpuset) {
> -		retval = -EACCES;
> -		goto done;
> -	}
> -
>   	/*
>   	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
>   	 * Since nodelist_parse() fails on an empty mask, we special case
> @@ -3257,6 +3249,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	struct cpuset *trialcs;
>   	int retval = -ENODEV;
>   
> +	/* root is read-only */
> +	if (cpuset_is_root(cs))
> +		return -EACCES;
> +
>   	buf = strstrip(buf);
>   	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))

The (cs == &top_cpuset) check is pretty straight forward. So if the 
cpuset_is_root() helper is only used once, I don't think we need a new 
helper here.

Cheers,
Longman


