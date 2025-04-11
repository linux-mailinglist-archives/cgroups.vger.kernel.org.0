Return-Path: <cgroups+bounces-7480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D1A867E5
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B61BA0578
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C128F927;
	Fri, 11 Apr 2025 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpQPmEMN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF828CF6D
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405786; cv=none; b=bUBy+QCCt/G6s16LAQ/TgU5qi0UhZrR4QEb9jMFf1gXoYtoQNJteWk9NAFPsuzSoiap9F4W/50poJWZSqAjwcpYx2cguSKGh201wxnfxJsgX5kRXzqJUm0fXHVMSw0YefxJ1WrqeP05RJNce25EkW2iVoWbnkgfQ30zFwFkFXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405786; c=relaxed/simple;
	bh=vwjrDtO8vu3q7AzPRougVdG6M89UkfX5qhhy45R4EJQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZGAZv6KKsIa4gaEB+QZZcpLiXippMPRZRDl9LSkuSI2954vxnvQfd0jCNRfIiMnCOOsa6xlPT0co6dVh/BgcKFhorba7mtRsWjs8vUT29gRm+Qh7rtY2/y63gtoYRggUMfKKm3xtVzmdAqwkllT4MgTjMovbhj1tAvuun17fB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpQPmEMN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744405780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W9KclZfqlYgP7Iz+t99weLE980bndnAhFOf+DRnuYg=;
	b=PpQPmEMNV8i9wDr7npJYgBMkGtywywITzTtF2Xi7HvGMXvNgm7G8Y+2PZSq0sK1nckn3dd
	v9lioAccDSzjw5lyO3QDryGlcr+cxrk8JNfauaEzAoicpV3lTFRcp2avurvovwCSCprioD
	iSOl/spypfwSddWURoPKiZznMgZOK5I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0KfEzGV5Ot2c8bkIEavbTQ-1; Fri, 11 Apr 2025 17:08:35 -0400
X-MC-Unique: 0KfEzGV5Ot2c8bkIEavbTQ-1
X-Mimecast-MFC-AGG-ID: 0KfEzGV5Ot2c8bkIEavbTQ_1744405715
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-478f78ff9beso61987831cf.1
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 14:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405715; x=1745010515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3W9KclZfqlYgP7Iz+t99weLE980bndnAhFOf+DRnuYg=;
        b=b1+P/bD3arVGySKFDFP6Yjk4lNkOFWxa6FmGnV7Zsp6HEy3A2UWEZ88JPrG6gs1pRA
         b4tIsCIaIl22yOz+1t+WsXOHV6e8G+oHAAy5k0LQawsTrjxShnGzgLahV1rLmHemJQb6
         XEgCdf794GOJLK2GzlMMg21dJRRnmLqoGENypWu+NyaZ3lUguc/t0Y7I3Y3Yc8KjBJBk
         FG5Etyc3w3bijKjZEiA6DCQzIxBK9lEdnRtqq3MH/z+kIFytHTC/gFJBSqCpo3HCPqvX
         i8H5CiBOaJcDo/mayryL45mg/ccIWPtLRbNNtsXvUiv5kJm+WVf4RvX2g6KXR2ZqCyR2
         rEQw==
X-Forwarded-Encrypted: i=1; AJvYcCWPnb19v28Yq2vbwxAjhXD0tEYhusEpjjGOMXNRElN8sC7RSF3Hrmjz6vw1Uolsw10c6TMWcFwv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0MXofbnyq31n7xGSMoTWhtOzmtZR+61zdBUSTnkIWnmX4IsJ
	s7Lv8qtLCJDo6q2Vou/2WUf7eKs4NuBDA+RLCCN26ndGf9q6IUsZXNKNYBB4QdkU39mWdsfae5y
	h1DZWf+egtUwHkYlbNuyaz4oJzgcFJpbSjLg6oqR8mB+nQCBT1YAvsS8=
X-Gm-Gg: ASbGncsjy1fqOAllM4SsRR3OGUilhm5aTC/Bd+zZrpHKjjJfTApkKNX3Fjda/+3NHgD
	K/rl1EWD2QsMzfJY7DO5t0rnORVdlG7vbF23lAweffA0m/zO4Zi/unXD8MFfew7QlOt7wRMjBmz
	D8CJKFH0xrnwzadrY+K8ZPRRRszWuE/+LjKWAoIP254HZ15vJtZtTAD3WF8BLvkE2lyUonYmWPx
	IJHgTenXOpnI3QdZuTcKUFMZ9tMp9yirup4UJ/EcvrPyrEGDYsAPPMCk6mkDbTLSHdhiUazYsPF
	aOjOaznETtP1dOflHAnHQ63zt7kMiR0pjGfL4at19TJIEwWsUU9vDj9Pxg==
X-Received: by 2002:a05:622a:178e:b0:476:6a3d:de44 with SMTP id d75a77b69052e-4797753b8ecmr60226601cf.18.1744405715392;
        Fri, 11 Apr 2025 14:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0y+vSo6hGThZEztK8iK0sDkq82eXR0S+/0TDkk0ytOKTiwg9dU/ESnAPHOzVuad6BuHXsiQ==
X-Received: by 2002:a05:622a:178e:b0:476:6a3d:de44 with SMTP id d75a77b69052e-4797753b8ecmr60226251cf.18.1744405715042;
        Fri, 11 Apr 2025 14:08:35 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2c07fsm31907501cf.44.2025.04.11.14.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:08:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6d81d576-7e94-4523-af9a-d43298ea64ba@redhat.com>
Date: Fri, 11 Apr 2025 17:08:33 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407014159.1291785-1-longman@redhat.com>
 <20250407014159.1291785-2-longman@redhat.com>
 <awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5>
Content-Language: en-US
In-Reply-To: <awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 11:25 AM, Michal Koutný wrote:
> Hi Waiman.
>
> On Sun, Apr 06, 2025 at 09:41:58PM -0400, Waiman Long <longman@redhat.com> wrote:
>   ...
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 16f5d74ae762..bab826b6b7b0 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> I'd suggest updating also the header of the test for clarity and then
> exempt the Child 2 ('E') conditionally from comparisons, something like:
>
> @@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long goal);
>    *
>    * Then it checks actual memory usages and expects that:
>    * A/B    memory.current ~= 50M
> - * A/B/C  memory.current ~= 29M
> - * A/B/D  memory.current ~= 21M
> - * A/B/E  memory.current ~= 0
> - * A/B/F  memory.current  = 0
> + * A/B/C  memory.current ~= 29M, memory.events:low > 0
> + * A/B/D  memory.current ~= 21M, memory.events:low > 0
> + * A/B/E  memory.current ~= 0,   memory.events:low not specified (==0 w/out memory_recursiveprot)
> + * A/B/F  memory.current  = 0,   memory.events:low == 0
>    * (for origin of the numbers, see model in memcg_protection.m.)

Sorry for the late reply. I think it is a good idea to update the header 
as well. This function is actually used by both test_memcg_low and 
test_memcg.min. So I will use low/min instead.

Cheers,
Longman

>    *
>    * After that it tries to allocate more than there is
> @@ -527,6 +527,7 @@ static int test_memcg_protection(const char *root, bool min)
>
>          for (i = 0; i < ARRAY_SIZE(children); i++) {
>                  int no_low_events_index = 1;
> +               int ignore_low_events_index = has_recursiveprot ? 2 : -1;
>                  long low, oom;
>
>                  oom = cg_read_key_long(children[i], "memory.events", "oom ");
> @@ -534,6 +535,8 @@ static int test_memcg_protection(const char *root, bool min)
>
>                  if (oom)
>                          goto cleanup;
> +               if (i == ignore_low_events_index)
> +                       continue;
>                  if (i <= no_low_events_index && low <= 0)
>                          goto cleanup;
>                  if (i > no_low_events_index && low)


