Return-Path: <cgroups+bounces-6135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B6A10B52
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49612167B24
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F511FA267;
	Tue, 14 Jan 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV67hLS0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26111189B8F
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869295; cv=none; b=qPGt1x0gHLGcGzlXPJwA1P0WmsMq0VIU5wpkBqhixeR2WiS6/GgpuavwCreVmnzesJGrOxX/dZVcB56HXfDgXiLyDm2B9++3MH71YjsyF/HZcL8D2FLblPCMn+G2ZDz5j690tx1M9jv6DlkrCizPPtoDCQxyyCUrlg+jB5Fbnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869295; c=relaxed/simple;
	bh=lZpCCutA/CbPigHFtrskRu1RVNEiw1a9netEUw/2lbs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ot3JDY2T+NKLapa87JuNvyJdcCQ/jSXkinRrBRx6kyXkwkhRy7qS+G5OGftiw3eStdhSRZpNm+TvWfCEoHELVHyF0Jder8RFnVimbVxDbpp37ek1uv7ne1oINtXOZRTrux475xrO4/IUlVY29pspNauCS9Cwr/iVUPZ6Wk9ngyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YV67hLS0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736869292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xqmc4JqRCRjuTXMj6uCnUXvyXgljI74YchgEbr0/MWI=;
	b=YV67hLS0TnvRBwKYppCVaFlbj/0ckKxgMAcBIIJpB/Sn2G87CY6dj7aftntSAN8djLO1re
	SSbH92Fhd9pGBSSd4zn9leaRCTOg3Odo5Y9GA5EiY4MiAKCRp6jBdeUnXHzL9Qm4cjU1QT
	/3IPVTsYlKmoVe9128t4qzqtb2vZXZo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-uWz3kRcfNn2UsNO_i-sFvA-1; Tue, 14 Jan 2025 10:41:31 -0500
X-MC-Unique: uWz3kRcfNn2UsNO_i-sFvA-1
X-Mimecast-MFC-AGG-ID: uWz3kRcfNn2UsNO_i-sFvA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6f482362aso892272085a.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 07:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869290; x=1737474090;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqmc4JqRCRjuTXMj6uCnUXvyXgljI74YchgEbr0/MWI=;
        b=IrQjTMYMpa6grxrrbB3krF37jwqq6W0lLic8OITtf8Y2anlRLvfZmwzh3y76XpG6lH
         3Uc1KMlVSNkZVJiis1CdLtmkZudg+94Sr6z7m6ghVtfYk5UYcg34kwWLE6MZO8sfeM5q
         qMFqOSnAGg2705FOLy+/XiXUN3Tim4BrhLZrdvAZXvcI5YaRuas3liLwl9coAaKa60u0
         S5WxYx/6X5+cbvuWT7Y762ltHjAr73ZDbpCjwoyhArHFZXrIIVCT07dhOBdgZ/62esPp
         jqT3DdadQO5tgBbKqD3QjVVJEnSghh+V5uSMPuSMsjU9jNb/hApt0Ed7u38ritAc+6uM
         yE8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgH3EwO7d0PLvjNjR9Wd0o41+Krg0/whPXwLcTbPSzqI5o9EsUXsip8+bL1L91mvz27ACgMLse@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTnBFwLiIElxP5xUwjQIo0vvYV4TppjeFUpT2H0LX+5V51o0n
	HpeS86mBxIjXvGv2BGVpEdbtr/fOx9SMoijlojr16c4bYTU7Tt0dBFPwWQZ9eUmatop69gd1lJ9
	PmLPRyVSJEo7XSXqGLQzRAs+vHF4TK56SZNhG/DI+Yg5CJMjEQmWXCGFqXgEKfoc=
X-Gm-Gg: ASbGncunclBvin4UebGV1Rkb+7tzU7SjiHfdTAcG+aAXRxKHCq1RzFKR9JS/6pAX7tC
	Dg6vE2R7IZiFfyGbk+ZaNHxI6Wxp6GMBE0zQZjrYzUCTUcZda8206U5QO7ZGCjhgkLbE5lR+Btr
	O7oLng6eQFO+124BG71OyPd0By2E6epwa5CUqr6G5662koLopXDdM73Q1YpLJtaVZwfqOyueL4G
	B4R3LHANcX6Y6UTrObP7tsapxQ0cce6e0qdyQk7LP9nvvctMzT/BCz4Gkkx1W/DM1LvpydREOgG
	E7qdY1lWHb8/gEqZDnyxAcgK
X-Received: by 2002:a05:620a:404b:b0:7b6:eab3:cdd4 with SMTP id af79cd13be357-7bcd97705fcmr3971956085a.50.1736869290264;
        Tue, 14 Jan 2025 07:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoF8KflFQkBU1z1CPRdQUSNcytu3l6aQTRzFXvRsUMgy6cBmJFQ96jGR481AFHGK/TUIo9Gg==
X-Received: by 2002:a05:620a:404b:b0:7b6:eab3:cdd4 with SMTP id af79cd13be357-7bcd97705fcmr3971953385a.50.1736869289999;
        Tue, 14 Jan 2025 07:41:29 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327b8a0sm615290685a.60.2025.01.14.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:41:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f502ee68-7743-48c6-9024-83431265a6b8@redhat.com>
Date: Tue, 14 Jan 2025 10:41:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] kernel/cgroup: Remove the unused variable climit
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, tj@kernel.org
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
References: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/25 1:28 AM, Jiapeng Chong wrote:
> Variable climit is not effectively used, so delete it.
>
> kernel/cgroup/dmem.c:302:23: warning: variable ‘climit’ set but not used.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13512
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   kernel/cgroup/dmem.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 52736ef0ccf2..78d9361ed521 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -299,7 +299,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>   				      bool ignore_low, bool *ret_hit_low)
>   {
>   	struct dmem_cgroup_pool_state *pool = test_pool;
> -	struct page_counter *climit, *ctest;
> +	struct page_counter *ctest;
>   	u64 used, min, low;
>   
>   	/* Can always evict from current pool, despite limits */
> @@ -324,7 +324,6 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>   			{}
>   	}
>   
> -	climit = &limit_pool->cnt;
>   	ctest = &test_pool->cnt;
>   
>   	dmem_cgroup_calculate_protection(limit_pool, test_pool);

The dmem controller is actually pulled into the drm tree at the moment.

cc relevant parties on how to handle this fix commit.

Cheers,
Longman


