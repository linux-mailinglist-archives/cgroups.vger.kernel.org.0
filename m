Return-Path: <cgroups+bounces-8143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EAFAB3F02
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7913419E432E
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D3248F71;
	Mon, 12 May 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmEJxIhe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890D2522BA
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071015; cv=none; b=C5tw8paDfI1qdpZOR8huYxb8nD0Oujeu6vYbJEN6TkxnAwbcL19IVvK21Teqw3mT/2m0XoHFZkmtSK/JeScI4FhkjLmBkXIbO8wkTK/nusFPZ9G+iClfya6Bbo3rHfwo8CuBdJ9CYYy7Yx5eQC4d+1sbvZp2kEFEktzuwsD05cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071015; c=relaxed/simple;
	bh=QpR6FTmdLt83epWjtUAngP8jfpfjpY/z0lo6xg9Hv5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0r96pFE2Nfq1zUIDxBFV8sIO9Io9BYDEnj0/01UbbRh56s0TIGQXM+aY8F5aInQX3jnofS2sKBWkBJxGQltbom0Kl467FyIqEVwk6k5ntKIBntG0seJG63JGqKuXp4mh16ucH2Po4bcHfDmLepta9UVLqDTFa1aR14m2Qn92LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmEJxIhe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e45088d6eso61360905ad.0
        for <cgroups@vger.kernel.org>; Mon, 12 May 2025 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071012; x=1747675812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Oohpf1ZkVjODZV3gPAW0cFtjTk5gH8ECsCQ1p0CS0=;
        b=PmEJxIheFQ5TwaKAFyhjLeGxwYSA73HUeZLek/+PdNvxobk9DWF7Az+i7yjK9hFEKS
         8mk2KMvwdu0+vrPZAbO8PWu/7jkqpekl84vMG8FE2qtXVpAyHuiodzxheFpkXxv3sTJv
         5O44MFuTqbp/h6rf2PcfiSQ+2rpFXW8AlDhg0bz+R+9QFDOUMjgUDq2gUvxv6Yi08ZYP
         qdkD/P5axnH7THT/Nqmp+hVR5q0LKxu78XtPGX3MtCw7Nl9n2qW34jk4FELkGpBhngGE
         Md3shnteN3+Pms36mep+YfUiZ20XqSEycOI4GOF8YKdMsfdIrnXbsvEUCGtUJ7e96wAK
         l8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071012; x=1747675812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Oohpf1ZkVjODZV3gPAW0cFtjTk5gH8ECsCQ1p0CS0=;
        b=hqQ+Q8OZinzJVsO53U1UsTOTNbYVk1jkCMOL7d1GVUEn/FTRWyrvYjdKoocmPqenQm
         S1MXjSnRBL+tWmh/riI4T3Xxc/GBTo4+gh2aUzyLnUlk0LiE1libCiZERBRQYcxFlC8w
         Z6ySVZab/TQ34ciZlu42TXW9zPcZbcT4ubzuN3G5TGrF7wfC7iH1PQFNqd2CeMBrxWre
         UL3xPWk8f/WenbLy2A6CUwzsoHgtSJDjHge1Y2OA/gLCytz0kRMmDOzen6sVve/pnQ5A
         aIiGtrmyITUZ73xHW4HaOPmRjWlwlSe0bujnETBBVdf59YnzxJDlQDRKgwg8a7E66nD9
         tYhw==
X-Forwarded-Encrypted: i=1; AJvYcCVUfrxTwKaqEMjUqdcN55y+WVFGGlWt1hk4T14z0P9abKJ35Ydc5razpw9Rd5TgfV9MyZjtocSB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8xx8EiSv5mv/vbBSCDW5/ERsXLQTrGRNpf0pUNtVK+GYUGTb
	1UuBNwo9eUY7KDyIz6UpiOJdoZbN+xFHMmO9o9DYht0eOaAlFvx2
X-Gm-Gg: ASbGncsF0OcTa8OqA/tsmUBVGFFj+B8I9YkYUd6bx6Gi5dLfHIRMiZ7HYRAyXEIG/Dl
	vE1+ke28rJdLTqsywNnLI8n53ebKWsBZ2LhXEXwUGrTL2nsRFdMTmmfTuDuXc0J3evGls1XaSdC
	dUzoxQN+6mF/4MEQrl7NxrDtmNYWoHfOPoZ5C/ZhYbjCXtAsiAMU5+/QuOX7Sw2i4XeGzyODM/y
	O5j80mIPSGkvZIUye0Y01dSBnjS+kVmLUorXwFUF8jPJR2o2Pnvz5QoOlwS7sLNtmp9qpYuEOoM
	YpDdSl0Xu+YzWtIQi4jtyZPj/Fs/uVOBeiHaMgO0BXMn/9b34Jd1TOiCJojjkenenndU6PvTGbA
	2XEDYlpEe
X-Google-Smtp-Source: AGHT+IEaSyLJVmLs7PPhJpaV0pzj326vzlBTcqgbKYJa9OH2+AXRMs3xkrTBdexAwpUy3ZC9uOwIRQ==
X-Received: by 2002:a17:902:f682:b0:224:a79:5fe9 with SMTP id d9443c01a7336-22fc8b59bd0mr186119875ad.30.1747071011993;
        Mon, 12 May 2025 10:30:11 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:fe23:5aa8:9def:b916? ([2620:10d:c090:500::4:17ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742e2asm65561935ad.88.2025.05.12.10.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 10:30:11 -0700 (PDT)
Message-ID: <d532450f-42b0-42a8-9a43-31f46e2143e2@gmail.com>
Date: Mon, 12 May 2025 10:30:10 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] cgroup: use separate rstat trees for each
 subsystem
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-3-inwardvessel@gmail.com>
 <aBsm22A8qWjGJgY9@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aBsm22A8qWjGJgY9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 2:24 AM, Yosry Ahmed wrote:
> On Fri, May 02, 2025 at 05:12:19PM -0700, JP Kobryn wrote:
[..]
>> @@ -383,32 +395,45 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>>   
>>   int css_rstat_init(struct cgroup_subsys_state *css)
>>   {
>> -	struct cgroup *cgrp = css->cgroup;
>> +	struct cgroup *cgrp;
>>   	int cpu;
>> +	bool is_cgroup = css_is_cgroup(css);
>>   
>> -	/* the root cgrp has rstat_cpu preallocated */
>> -	if (!cgrp->rstat_cpu) {
>> -		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
>> -		if (!cgrp->rstat_cpu)
>> -			return -ENOMEM;
>> -	}
>> +	if (is_cgroup) {
>> +		cgrp = css->cgroup;
> 
> You can keep 'cgrp' initialized at the top of the function to avoid the
> extra level of indentation here, right?
> 

I can move this initialization to the top but the indentation of this
conditional branch will remain. See more thoughts below related to this
block.

>>   
>> -	if (!cgrp->rstat_base_cpu) {
>> -		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
>> +		/* the root cgrp has rstat_base_cpu preallocated */
>>   		if (!cgrp->rstat_base_cpu) {
>> -			free_percpu(cgrp->rstat_cpu);
>> +			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
>> +			if (!cgrp->rstat_base_cpu)
>> +				return -ENOMEM;
>> +		}
>> +	} else if (css->ss->css_rstat_flush == NULL)
>> +		return 0;
> 
> We can probably just do this at the beginning of the function to be able
> to use the helper:
> 
> 	if (!css_is_cgroup(css) && css->ss->css_rstat_flush == NULL)
> 		return 0;

If we did this we would be wasting extra memory allocating the base
stats for every subsystem css. The intention behind the way I wrote it
was to optimize the memory overhead needed for split rstat trees.

