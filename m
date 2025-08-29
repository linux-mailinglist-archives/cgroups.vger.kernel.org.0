Return-Path: <cgroups+bounces-9491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDAB3C3AB
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AA47B8AB9
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC5D253F21;
	Fri, 29 Aug 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEAbGD/4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9858246BAA
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498352; cv=none; b=LuBHIlOmspO9EzsA0McSoWP4gyVokbcI8WL62IviVZBbjsF658fJK5prBMCERzczw3wLRrgq0YWRFPAsMSzCta/28tR4B8fdTUINn9r3OQSBmL3H+UbeEtg3QkrnTD69VhBS4Srm2xg0ipv4sLSRUJTqbVo5TH3V7Vnwg7gFUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498352; c=relaxed/simple;
	bh=WUKFCfzEQIecsUfn03qUxdeTfr6N7kWQTIklobLyuo4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D02V1RCHajY3NiATxVhNAMgh3mclgHdgezHlxbX7k7qXG64sa73QxllNYhd6vz9UGckTZrrySq6JPyrrKUntJ/MiJf/GNMr7jrvseiD4wlT4rGoYmKKb4cMYMxhg9GLPn6mdKEl7/fkzQ0wvl90RMXbncvScIbbwTXut01xJZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEAbGD/4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756498349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rmuHyT0KcZrdRyc50Eyd5M0OE5Q+EdTIaRuRiJIYIo=;
	b=OEAbGD/4VLN1cRaVJF1dqA42AplMRGSuaJb5unwlKKeuGOwJrTro6N7EgUk2phBl5amFs6
	14OeRwdLWK4M2s+2WGhnPkinxNF6Tq/897yaQEXeui0p6492Myjsli16TQznz+ne+AAw7k
	cAoZULoVe392BkD6p91bqowYu1oDeAM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-BAb4x2CyNFeeQjVWDqQKTQ-1; Fri, 29 Aug 2025 16:12:27 -0400
X-MC-Unique: BAb4x2CyNFeeQjVWDqQKTQ-1
X-Mimecast-MFC-AGG-ID: BAb4x2CyNFeeQjVWDqQKTQ_1756498347
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7f95f654931so550154185a.3
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 13:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756498347; x=1757103147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rmuHyT0KcZrdRyc50Eyd5M0OE5Q+EdTIaRuRiJIYIo=;
        b=GrVEtuZqbbwagd1FxkQX908r/1IupmwqCnS/4jB0tMA37z9VOfTjdb7h4BPSDU+szJ
         FeFRvfxnm37t7m+hKFQMx6Fm9L7c94cDzG0GeRU8Yi2mAGbHy+e/OPaM7fu4tymZQsHI
         m/EUC5ASlcr8vur82LJuYjmzTg3wuaOpJTJ5WL2ZOx05uWF4G89ZjUwmIWfxe4qpxq5t
         1xVvgDrx62vmuFKQMzprixZfG8EIOKJZAAvP7aL+XqusP/BODPlMlvIUdWtgAnXR9dZ5
         4my8mN7gXIT5a7GzwX/QDJJQL3r1Ww7swTybHd/0733ufdG+XJhEZvG04IKe3WmwKjSe
         Yh5w==
X-Gm-Message-State: AOJu0YwAkJy3kIe4Ra2wySraP9X1utTDdvgUCkbk90bXo/D/Zcf8z3Kp
	MS6NtJYSIlOblSLvJsCjBO/66vJoFf6wg5pu+vwiakKBXWahN12Q2mHXG1DHMAHTqtzwLTmxMSy
	+a1PL/6WIodbYD5cRIm37DlJzz+ptdgFqTmdoPe/80/67xGW9wW23Pyw3F0k=
X-Gm-Gg: ASbGncuSkXBaNz8DB7lpR4sysY7+9gLq8UaNZ9aoxpqdyk885KcudyFqcqYG2gTlbHM
	/RwN65BtcIw4oNZqAYxbItBteq+QyPWU1gb/uV9+wMlYUp3w6olx2isBNo2qluZ8Y0CZhU1TCxV
	gBYYzLcuca0UD6O9S1v3O3PjKCVypjPF5J0uqv4x7hFWdX1MHLTQ/2k0UC4bJ7SNZ25jiFEzAzv
	mHT7DGDXdLxLgLi8j7URxW/Mtn3+Dm0AdRPcR25u6634C1JIdQ9RQQpR8KaA5z8L+R+gwAPt9e/
	EonSGcCB0Or2teQ3S3quUqIIoSLl2Wf8h1wd+GYXQQEngfj+csr93bPDyh7TuFyHyE9vcVQZAAG
	kYNn32grFLA==
X-Received: by 2002:a05:620a:3902:b0:7f9:b87f:212c with SMTP id af79cd13be357-7f9b87f23f9mr954919685a.20.1756498347244;
        Fri, 29 Aug 2025 13:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA7fYPqivxZa0nwJ4I4Zi1pIaXNPPOHdBA1vCUTZhYrmfMgXx7WxOATxzDYa+my+y3Ry9L6w==
X-Received: by 2002:a05:620a:3902:b0:7f9:b87f:212c with SMTP id af79cd13be357-7f9b87f23f9mr954916685a.20.1756498346695;
        Fri, 29 Aug 2025 13:12:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484ac70sm239229785a.36.2025.08.29.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:12:26 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ca3bcede-2289-4e51-a2db-0da75d85fcbc@redhat.com>
Date: Fri, 29 Aug 2025 16:12:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 08/11] cpuset: refactor acpus_validate_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-9-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-9-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor acpus_validate_change to handle the special case where
> cpuset.cpus can be set even when violating partition sibling CPU
> exclusivity rules. This differs from the general validation logic in
> validate_change. Add a wrapper function to properly handle this
> exceptional case.
>
> Since partition invalidation status can be determined by trialcs->prs_err,
> the local variable 'bool invalidate' can be removed.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 83 +++++++++++++++++++++++-------------------
>   1 file changed, 45 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 71190f142700..75ad18ab40ae 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2410,43 +2410,11 @@ static bool invalidate_cs_partition(struct cpuset *cs)
>   	return false;
>   }
>   
> -/**
> - * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
> - * @cs: the cpuset to consider
> - * @trialcs: trial cpuset
> - * @buf: buffer of cpu numbers written to this cpuset
> - */
> -static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> -			  const char *buf)
> +static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)

What does "acpu" stand for? I suppose it means cpus_allowed. I will 
suggest to use a more descriptive name even if it is longer. I did use 
xcpus for exclusive_cpus, but 'x' is a seldomly used English alphabet 
that can associate with exclusive_cpus rather easily, but 'a' is not.

Cheers,
Longman


