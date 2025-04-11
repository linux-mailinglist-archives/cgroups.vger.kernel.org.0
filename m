Return-Path: <cgroups+bounces-7483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724EA8686D
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A48C5C6D
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2229C341;
	Fri, 11 Apr 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFhTO1B+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6B270ED8
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407739; cv=none; b=i3j1HVM8SxToC7Adcj3lokY/3a2nfw+cXVLUkQomEnVsFpJdxAdaAyLYhZ87aGD0dlkp++BTIa/6gTA42E/DNjmPi1SQ/hfzr6gKTcieFNdxJqZ/RGJ4eK+O6hMAYveNJO2E614u/JuPC3ACu8qKE7qwcbPhihW4TIXHgp9a83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407739; c=relaxed/simple;
	bh=VGgUuxdv1xzGXXZSD6ZHULfD1Juf1McLzuRi+iTVC90=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GEj5lhfRPYObjHwY0AgMuxFeFCiGPOtsKeWNHu1KvEkYfcEm9cDu20HT97XgJN9QsDdLbWOQpk32Jv6ivMpvTxmna1vD2b0cDG45YM6njdNeH7vWeaDSJNLmDNQXS3zPM1+I9h9xM+mcGkCJmH2kURoDxTmyCHosIgWVQorkYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFhTO1B+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744407736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gi9jx3ynN0Fvs6xU8s9qk3uwTlKkqCTwIN8L/fT3WM=;
	b=MFhTO1B+xOcqLf/+nAGrCF+yfV3rabt1iQyzeoVsQouikY0lXE8aZvewYnp3aTZkdQcQf7
	yMM4TroHQiONTAvQa5hAhmlGBKiShlvVhvx1kYYs64ePTPzm8jlfuxabNiQWgR28J3R1/G
	iCmcDtTS3gjMNfgT2/qD9cTdfbQtJIU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-gjiQ8sRdPOaEF1m8R-Y8dQ-1; Fri, 11 Apr 2025 17:42:15 -0400
X-MC-Unique: gjiQ8sRdPOaEF1m8R-Y8dQ-1
X-Mimecast-MFC-AGG-ID: gjiQ8sRdPOaEF1m8R-Y8dQ_1744407734
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5f3b94827so439713585a.0
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407734; x=1745012534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gi9jx3ynN0Fvs6xU8s9qk3uwTlKkqCTwIN8L/fT3WM=;
        b=ihASGq0+ewBP0NKnKg9TePMSwnt5mIwqmkEwh7LsMgtWv8eNW56RdKszOqZ5Grk9qM
         BUkjU1T+CC0g8U5ZSd18IYEZbrjbMU15pwKWK7dgsUrx+P+iEIVO1ajaf1yVAk9K4lhN
         5y3D/3SLsXMf43xiNAVbtMRNXmqdz1riVH64rSZG66iwZM+FTcOSth4ZU0xk6BROLaL+
         5pKNxy5sI0AFYiTXIIrL7mOTdCVCNy++TyaxmMt0irpFNwdgm//WXT8l9XT8JRqZ6c6E
         +Aek6dYjHhIzx8+T7/5voL2ydJn9VOB66aoGzp7Lk1g2JkuD14z9t/bxhRQ1XYK7yw60
         4OcA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxeoe+hlI9HMovVdhqAQxSnaM8L6qE8ivgzvGXsf68Haf/ohJoNcgG7DY5rXupY5eLE0wk7+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrzi7d3q0DewQ/4KgYFWyzdSc5GeZTbTy2VJMbMDn3M6JwRxrC
	HsDbEz/10x2/4fkZMBRE+hawenOoGQQDGG69CTY39ltX16UKAyroBYvKfs3hJrMSePTO4qMhnHC
	Vk2+7Kg6CVZ85HII0nuGjUnlhZwhfxeAndqCYgr8flbXbt+UFF3nYwvo=
X-Gm-Gg: ASbGncvbHEsUnXPDCiE/d8uBBC0jeeAZqh2Uhs/Aa5os51X3ueA6kkEf6ryk7SCHFmh
	9ZnwTPjq9yd2/QLvWec/njGbXU22r41EnXD5SVafLlqSOgKjOr54DOCylz9U8SZtTUyrpR2GOlp
	9+raVos3MYRpkd0RZ61brR09T32g9DN39b2ZNVgLdZN37bl/Gi1uFTrqNrFxXteJB1JdG/Wm6T0
	OVRf/uXfCH9ztxYXlZ9BbIAMZrwOM5KF/GvVlfMdHu61dNeESXd5CcXxPLIrZHEHNdeEnsyAVC8
	yNZIH5+2RAds2sbrdpNmm06iRMgart25atcBQ+WyPYpA6eDA4S61Ur428A==
X-Received: by 2002:a05:620a:4608:b0:7c7:70dc:e921 with SMTP id af79cd13be357-7c7af12df3emr861620185a.36.1744407734612;
        Fri, 11 Apr 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrW3e7AIHhIu7AXBF5LC5KsZhgZcA6ahLpM5fFHEpeXmV2PCGX62skPo0rxtAIqHbrxnoQTQ==
X-Received: by 2002:a05:620a:4608:b0:7c7:70dc:e921 with SMTP id af79cd13be357-7c7af12df3emr861618085a.36.1744407734327;
        Fri, 11 Apr 2025 14:42:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a895163asm317581185a.27.2025.04.11.14.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:42:13 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <22368dc1-e026-4e9d-bb65-6df62f960a15@redhat.com>
Date: Fri, 11 Apr 2025 17:42:12 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407162316.1434714-1-longman@redhat.com>
 <20250407162316.1434714-3-longman@redhat.com>
 <pcxsack4hwio6ydm6r3e36bkwt6fg5i7vvarqs3fvuslswealj@bk2xi55vrdsn>
Content-Language: en-US
In-Reply-To: <pcxsack4hwio6ydm6r3e36bkwt6fg5i7vvarqs3fvuslswealj@bk2xi55vrdsn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/11/25 1:22 PM, Michal Koutný wrote:
> On Mon, Apr 07, 2025 at 12:23:16PM -0400, Waiman Long <longman@redhat.com> wrote:
>>    Child   Actual usage    Expected usage    %err
>>    -----   ------------    --------------    ----
>>      1       16990208         22020096      -12.9%
>>      1       17252352         22020096      -12.1%
>>      0       37699584         30408704      +10.7%
>>      1       14368768         22020096      -21.0%
>>      1       16871424         22020096      -13.2%
>>
>> The current 10% error tolerenace might be right at the time
>> test_memcontrol.c was first introduced in v4.18 kernel, but memory
>> reclaim have certainly evolved quite a bit since then which may result
>> in a bit more run-to-run variation than previously expected.
> I like Roman's suggestion of nr_cpus dependence but I assume your
> variations were still on the same system, weren't they?
> Is it fair to say that reclaim is chaotic [1]? I wonder what may cause
> variations between separate runs of the test.
Yes, the variation I saw was on the same system with multiple runs. The 
memory.current values are read by the time the parent cgroup memory 
usage reaches near the target 50M, but how much memory are remaining in 
each child varies from run-to-run. You can say that it is somewhat chaotic.
>
> Would it help to `echo 3 >drop_caches` before each run to have more
> stable initial conditions? (Not sure if it's OK in selftests.)

I don't know, we may have to try it out. However, I doubt it will have 
an effect.


>
> <del>Or sleep 0.5s to settle rstat flushing?</del> No, page_counter's
> don't suffer that but stock MEMCG_CHARGE_BATCH in percpu stocks.
> So maybe drain the stock so that counters are precise after the test?
> (Either by executing a dummy memcg on each CPU or via some debugging
> API.)

The test itself is already sleeping up to 5 times in 1s interval to wait 
until the parent memory usage is settled down.

Cheers,
Longman


