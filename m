Return-Path: <cgroups+bounces-8270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5FABD98A
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1997AC1CA
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF5242D72;
	Tue, 20 May 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpi5fQJH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748B242D94
	for <cgroups@vger.kernel.org>; Tue, 20 May 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748090; cv=none; b=t9upqGIvJOMJDwen0MNXIDaRoWrKpYGZxUwDjsfsM2h1GZyF+IrRB3X1EaNxvRCjiPZnAINwy4Uj1XuWShmE5eDfwa4ofYTNf5WrjkA+R950jU/kc7JzQRHAi6kb3XeFsVy1fB6CsZ22Fu2tUQZ4G0FGnKd8auTw5exGPwqm1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748090; c=relaxed/simple;
	bh=R5VbzDJWzrc3ZxG7WARI+XrXckegfKN14c/Dy6mUB68=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QYY0xeBRjy1zDTgVrZe2msqUsW0+pSk/DloNlmrtZ2uhYNQzRZlw2uSmAKsGmyu4z2o+iseB6tkGPPRBS3EjpY9YeWNO8eZACvuCHEKcKJ/WiOBkODYJWXwRuvUtw5oV4OXIyBTvvi/EF2ZYEDwVvZJjZg5iAK0VSU4HBtEBfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bpi5fQJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPdd0kG+A0mBSYOTCTXbGwKBOQupNoZqnxcvyos/Qtc=;
	b=Bpi5fQJH1uR4yimJToZsCpj/VA4tXVynB4w9VHyHEb8Qs9MJAf++weXajdY0rbBCIMtI+s
	FFULsr8H/KI/aen3ltY1SI2z3nt/gaKfaT+N9jtfbtAPq/EKW258hJuenqvfRSIYiAsbnZ
	9Y67eruOoxPsLoEI08tzpHbRLwMdnCo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-KSXnFbcmOSGtzDQf8WF9dQ-1; Tue, 20 May 2025 09:34:46 -0400
X-MC-Unique: KSXnFbcmOSGtzDQf8WF9dQ-1
X-Mimecast-MFC-AGG-ID: KSXnFbcmOSGtzDQf8WF9dQ_1747748085
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c790dc38b4so1019326585a.0
        for <cgroups@vger.kernel.org>; Tue, 20 May 2025 06:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748085; x=1748352885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPdd0kG+A0mBSYOTCTXbGwKBOQupNoZqnxcvyos/Qtc=;
        b=BAmtXgTe2SNKzuFh9z78JsXy77fK+/JCcpEXUgwSbXK1V/ln2GPhK/DV0cAnddrZVM
         9/TiHF5Tn6Cr7ZYbqykN4ts0suiSmzakEXaeZJIiR+jSBpnOx410DAKlxotOQi32HG5u
         cFnTFq+d+eNKc0Wy3XJEOhYFK7J8sF4codUm1A8wQBIZyBvi/C7l+d38zC0CsEIwtLyI
         jNRBqpcf/DgGFtp6O/QYiDa02+5+LwmQeuJp7Jy4DgMq52nXFDrVoeJlF1J9D59IxPp2
         mZB4zOVok3K46KluFbAKLfnHmWKBEaGSgSjL5nX5YwsIXYMfr/Palr6a8uk/L0I5NN9M
         i88A==
X-Gm-Message-State: AOJu0Yzj5v8nJrYkVvEHr9NSjBOwmyrgc5m14GQVc9zE46dWBWVgxzoK
	D6NzcNAZQvjA/meOc0vOD1SRTle1JjzrvlEGJFQMchIbBVrByd9G+Wz5v8B15Vf3tYigi1wYD+E
	6Eu766SDFIYGhWdN/+83nSrrSdaeOtQ6LTOd9lZsgbkFUPji9y2HzZXbWjEk=
X-Gm-Gg: ASbGnctFBeFcHq0PvoFI8HfsOa8qr9TYUxkU8SaX0KNeOwN+ntPtGlJlM+Jt3UMQ1jq
	RIgg2iMr1VzlPsH52EZPNrzWCoaT1Pf8k/Zic5j49HjOLnjPYARGaDVE57ae4NrGDfjXUJGSpzR
	OXRdyyNH7sEPytfJO9IhuYyMTGgZWt6zX1tZd70CfgjVlQW5nJKiexDSLPBYxhPr/z/VmvT9d/9
	7qroTGoPOakKdT/uP3nRknKifDeJQilBAR29kNtW7B/Ij/Lw0d8Ug2IHj3tES44P5NY3CunBxEA
	Tm1457Z/7ahWnfG/tpnZkBGPfnQf20bQSSTmYQsDk4y3q2NEOUNJFiY=
X-Received: by 2002:a05:620a:2892:b0:7c5:9480:7cb4 with SMTP id af79cd13be357-7cd46af8d25mr2512086985a.9.1747748085222;
        Tue, 20 May 2025 06:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQL2KB+rwh53zo4Wgg3ScYG1+9jtH2wb4ybzSByGI2RDMfJa/SzjeXrDk8HgE9LBFKy6qW6g==
X-Received: by 2002:a05:620a:2892:b0:7c5:9480:7cb4 with SMTP id af79cd13be357-7cd46af8d25mr2512082385a.9.1747748084686;
        Tue, 20 May 2025 06:34:44 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:627d:9ff:fe85:9ade? ([2601:188:c180:4250:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468cd124sm730874585a.100.2025.05.20.06.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:34:44 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
Date: Tue, 20 May 2025 09:34:42 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, tj@kernel.org,
 hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 11:15 PM, Zhongkun He wrote:
> Setting the cpuset.mems in cgroup v2 can trigger memory
> migrate in cpuset. This behavior is fine for newly created
> cgroups but it can cause issues for the existing cgroups.
> In our scenario, modifying the cpuset.mems setting during
> peak times frequently leads to noticeable service latency
> or stuttering.
>
> It is important to have a consistent set of behavior for
> both cpus and memory. But it does cause issues at times,
> so we would hope to have a flexible option.
>
> This idea is from the non-blocking limit setting option in
> memory control.
>
> https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux.dev/
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>   kernel/cgroup/cpuset.c                  | 11 +++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..d9e8e2a770af 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2408,6 +2408,13 @@ Cpuset Interface Files
>   	a need to change "cpuset.mems" with active tasks, it shouldn't
>   	be done frequently.
>   
> +	If cpuset.mems is opened with O_NONBLOCK then the migration is
> +	bypassed. This is useful for admin processes that need to adjust
> +	the cpuset.mems dynamically without blocking. However, there is
> +	a risk that previously allocated pages are not within the new
> +	cpuset.mems range, which may be altered by move_pages syscall or
> +	numa_balance.
> +
>     cpuset.mems.effective
>   	A read-only multiple values file which exists on all
>   	cpuset-enabled cgroups.
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 24b70ea3e6ce..2a0867e0c6d2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3208,7 +3208,18 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   		retval = update_exclusive_cpumask(cs, trialcs, buf);
>   		break;
>   	case FILE_MEMLIST:
> +		bool skip_migrate_once = false;
> +
> +		if ((of->file->f_flags & O_NONBLOCK) &&
> +			is_memory_migrate(cs) &&
> +			!cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 0))
> +			skip_migrate_once = true;
> +
>   		retval = update_nodemask(cs, trialcs, buf);
> +
> +		/* Restore the migrate flag */
> +		if (skip_migrate_once)
> +			cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 1);
>   		break;
>   	default:
>   		retval = -EINVAL;

I would prefer to temporarily make is_memory_migrate() helper return 
false by also checking an internal variable, for example, instead of 
messing with the cpuset flags.

Cheers,
Longman


