Return-Path: <cgroups+bounces-9523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30AB3D6D3
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 04:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE85F3B8B90
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11241F9A89;
	Mon,  1 Sep 2025 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC4NPwnK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BA1E1DE5
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695094; cv=none; b=WixhDt0o8tvRn218Rm26/EiHFhr4AA3lp/rmwwKRzTSGIMyn4PwrvBNxi3t3Pc4dF3V2mfOgh/xl9LdS+Xemc0K2OAxqN/uA+IJ18dhjFTkk5Edumy4K+zzyNKb9wmxZB4hCRtOQEcFMlsLDnuTaJs88UAj5uUkBUGTZqa2h7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695094; c=relaxed/simple;
	bh=Ph3PHxH3IDjbrn6uZoSPtSu21RAn/NfeUzKOS+rTGHE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QknS5LoFQvdgIH5xgQsTqUj05w6euzDaDAU0z5lunqriDK2F0gp0KwPzQ66apeLzIjEBha0cjUFcugZ9zVnNTXSE3OOzlzuYtraZKmbOw6PqBsPnZIR7MHsGQUIq5vNVyMjxuWepYgiLZr5X8kHV+pTCrsZ8rik/AUFaqLHBEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC4NPwnK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756695091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BkoUn/3LVi8bOJIvIwXSjQ7FkDfIUIzvpCA+z3b9AI=;
	b=AC4NPwnK3WKfgYCCzJzRFwLg/tlvf9c4ITYInhFxEUTfijTXcNm4MSAWA+4qugSSxZnZlW
	NBRBvoDFpVFXUubd+KgVwMOtnG9O97Hmm6MxsRRrPhU+puu/+Jdy5mrKladhSOK0hQEB7I
	v1PzFyizSRuf+mPufAGmjMcOAlGCzMA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-X3xUpIxWPCasouFTawpIWg-1; Sun, 31 Aug 2025 22:51:29 -0400
X-MC-Unique: X3xUpIxWPCasouFTawpIWg-1
X-Mimecast-MFC-AGG-ID: X3xUpIxWPCasouFTawpIWg_1756695089
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7193fc78b68so15135126d6.2
        for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 19:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756695089; x=1757299889;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BkoUn/3LVi8bOJIvIwXSjQ7FkDfIUIzvpCA+z3b9AI=;
        b=M9Bt3HHnYjLPfDaQAK69ChW3ZpMXfcefu/cfwiqTAWIig5Y8ntJt+BFj3Z4JSpTBBS
         6XDa7dMp1aOwBS/6ncJl/KD/RGVgolHdkj47bKQc2zCSjdRwH1HGAyxZs5Erv8rB8zLA
         ol2uZ39oDy+XBwb6qxU7+kMNtxktEJEAOnFc56kg8r1131qTHEH+WbDTBrkhpzo+9dxs
         zesetuTi+kPJ4D109ZBwbZo1vvUJOmCONi0X/7tJBtoJkGXlkjWiakCiXdL/jZutmZQ0
         jmwOF3+FEca/o4zNWFnGrIRfjordlVE4T8NydszRB0iFQSleyMjajfgKZNkjdslqB69n
         0Xlg==
X-Forwarded-Encrypted: i=1; AJvYcCVqDIb/vtrMl9v/lZPUFM2urym6gENneHWaw5wVimC3hMsHaCaJUwGAAo+eNRLqDLgAqTiF8iQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fHhV+Zs0v/ZAM/ElMhJZ5uzQHDxA/EfrkA0Lc0pEj1Y/2+Rq
	l3td6+kXcMiKUmzmuvXD3GDCu9Y2fjHpSNIl+645mcaGZLQfUtbeTSJYhH6tJG3eziirSOEAGpn
	SDJ8rzAKmcHDFv5CTc6MAIwVnKHll9R7x3Diz9sB6uZAIumClmDbVynxdT88=
X-Gm-Gg: ASbGnctHne7f3o05ARwo77t+r+578ejwMqqTAscjrabnNLekczM3IxFdLr9otUR9JxE
	RQSlfL9mbfCdCc8Av7SSwMjD/p2Ip8/5dEadxYhgBcTsRllzp3gCALn/MSWkLDdiZmO+0ccfyNM
	NcFcQQDLCCM4YFcdNMl3g8Znd45oO3AUoY39KlwFnrU/BNOPC1E9yF6h/btG9a7JpP4UXmJPsyO
	m9zCqd449ko70rIH0nK7bcXq+MtcUdxxhlozZv/3xyzCUNOzJnh8d60pls7i2h0Az7tZCDVIHes
	j+xilbRPOyl7Ao5kcU3F31vTwbtw0nyBKg5jvq6GftBfCjKKz+82t2O2ay2rglCKJJ/08/QsNHa
	cTWe8tG1Y6g==
X-Received: by 2002:ac8:58c1:0:b0:4b2:dfc5:fbee with SMTP id d75a77b69052e-4b31da099cbmr70781141cf.32.1756695089408;
        Sun, 31 Aug 2025 19:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkoufCnFgjbgzFW+oNc3o0VuyQRzDbMe1YkLx0QJxMgDX5ZpbTSK/aus3UJJV/ZoqngeX9tw==
X-Received: by 2002:ac8:58c1:0:b0:4b2:dfc5:fbee with SMTP id d75a77b69052e-4b31da099cbmr70780971cf.32.1756695089001;
        Sun, 31 Aug 2025 19:51:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b54d06csm53949631cf.13.2025.08.31.19.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 19:51:28 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <197dd0c0-f4cc-4e75-accb-6bf85ea5291d@redhat.com>
Date: Sun, 31 Aug 2025 22:51:27 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-18-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-18-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>   int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   {
>   	struct cpumask *trial, *old = NULL;
> +	int err;
>   
>   	if (type != HK_TYPE_DOMAIN)
>   		return -ENOTSUPP;
> @@ -126,10 +127,11 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   
>   	mem_cgroup_flush_workqueue();
>   	vmstat_flush_workqueue();
> +	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
>   
>   	kfree(old);
>   
> -	return 0;
> +	return err;
>   }

Actually workqueue_unbound_exclude_cpumask() expects a cpumask of all 
the CPUs that have been isolated. IOW, all the CPUs that are not in 
housekeeping_cpumask(HK_TYPE_DOMAIN). So we do the inversion here or we 
rename the function to, e.g. workqueue_unbound_cpumask_update() and make 
the change there.

Cheers,
Longman


