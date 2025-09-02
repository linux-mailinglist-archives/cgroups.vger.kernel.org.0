Return-Path: <cgroups+bounces-9627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCEB40BC4
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C053482015
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E20342CB8;
	Tue,  2 Sep 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7E6U/f2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225C341ABA
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833280; cv=none; b=VmeYRBrGbO7rV6iLD68XMC7zmyaoZ06tbB795toh68f/rWyhqHHMhFT26OJHZxG6XgwWBcs5yQcO/GGGbYvBuvOajaemuU6x9fqvSyvnJQXscMCk32XEtXdN4Cpx/X1Gwmww16meO5ZTfW2mCQrpU79C7IwLTRT/6FO+EAMtd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833280; c=relaxed/simple;
	bh=KP+TLtwyL8ipGtoqM7ghjMPqXCRkOL7mmitCpt9EMnE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgIx4ldkQWJRB+mUPsjAyOgleyS92Sk1vO2q+NYr6jck9W7U+u0ZHtzMQHbGMKqNA2UAYT8HT4DcQK6Cw4Q+y2g/j7xVPWRodGkpVx/RVqQUFRf/SVq8b6K6HFNv8oKHf4KisxCGzPzH0q24DHg0UP4G6PFbVgdO83/xrAnT/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7E6U/f2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756833277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
	b=i7E6U/f2SkNdJno7ZYnEdh0hTa6SEU2YjVLL12gefF4MchpIQ/za8K3BNcVjx3211yHCOZ
	ndZQBoNcGWmUdhiV3Tu8pNGB1WEfQMUpBnPaBok+BbcdsP5C03qR9wyA8zir6R3OPJdsir
	rffW0+gz5w+InHWZ+PNGBCbRIqsMfHo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-8tAqIS3zNAq53EwpmxCyFw-1; Tue, 02 Sep 2025 13:14:34 -0400
X-MC-Unique: 8tAqIS3zNAq53EwpmxCyFw-1
X-Mimecast-MFC-AGG-ID: 8tAqIS3zNAq53EwpmxCyFw_1756833274
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32b721a23so41567761cf.0
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 10:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833274; x=1757438074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
        b=p8N+pOnI6agIdx6FsCp/p5SXwCPjskEEJPnthNDAbSgh+Ej5N7H/slWA57jJC0xBOw
         s5EaCs45oEWKmauQwqgpmD5kOQ56jqfOTW8tt33hoGQCsDvZ5PBJDpSQNunTaZ6OmukX
         YDPWAUeEipPuiD8Ok/M1259TmP+mMu2e703NgVZq2VjkA9HXDlOV8fvdkfvli8/ZC8Wh
         gQ/UiEwcRZFl3PvIgGpHTbf5k6z3MStZ1XN/PV08Z5ZMCVcyR+5+psorUfELAt2EbMBd
         /jklqi8QVgOi50y4wMvrZIImV63Pt/XqdxMsCaGg5qoLOgFHwdZWtGypGXUj+itOR8MR
         FMtg==
X-Gm-Message-State: AOJu0Yz0A4kJecNIXiMwIPpVuFcJy5kcjrJLmM0CUvyNs4NsO+DSe5uG
	VoTwXC1HtvvIIhaRj0nNVdwvbz5Hi0KXO3Ajr881mflCDRnTq4+Mpg+EOTOMStKanALcCwU2EjG
	f70nr/ZcTC4i9h9xdEzMiMwiHh7SKkoxZIWBeWWKsIjbfehnvzPRdnxx4/zs=
X-Gm-Gg: ASbGncteEb1MuKHtwxd+hMKw1N09GOBcEQzyMzBKowNbuv8ROMTY2kMynOT9hRlGrVL
	dAF+Cgg0FuBVD+OC0djdbXKU8odunMst/UbMhngXwdWJvLS65qZZ81R7T4rHvw31WKeyKNR5NjA
	6oEGndyQaVF8MlFwmrcASfHWkD1EueRcTqL5R1opmzcNfiMLBiOq2R7Tb8GXJQ3La3A2S1vXrGR
	vfFz0m0GKLZ0F1BBWflIJHqlkiJNx/PKpc3nRnLHUoR4lb8GOxivyTDa/YumvmmxbnioXk8I3RW
	zN2RCOVmIezl129qW7/W0i8BVB9VrmlCaA/jydItkyawYYj+s9Ds5B99Xv7BHapM+++2uKAqdKh
	oNNOoc6i2tQ==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30038381cf.81.1756833273756;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd9q75h/QyzT7q7qh5UVGeZkAkp/BGinsKuVNoDttOlVyk/VfACSIA8Q3J9whLbhq6hXufmg==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30037991cf.81.1756833273364;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462ede0bsm15181361cf.36.2025.09.02.10.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:14:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Date: Tue, 2 Sep 2025 13:14:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>
> Free the temporary cpumasks only when they were actually allocated.
>
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)
The patch that introduces the bug is actually commit 5806b3d05165 
("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
removes the NULL check. The on_dfl check is not necessary and I would 
suggest adding the NULL check in free_tmpmasks().

Cheers,
Longman


