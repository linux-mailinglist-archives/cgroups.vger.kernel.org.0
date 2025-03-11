Return-Path: <cgroups+bounces-6952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4FA5B21D
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 01:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E322518914AA
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A48156CA;
	Tue, 11 Mar 2025 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRA07OU8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE6B67E
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652177; cv=none; b=l+hG92mOgiaLq1gHMP5WvMeOVvzI8rhyqikLCppWJnNb9JTgdevK24EoC98C7ya/so0vPXPJfl6/FLzrxd6Jw3IM7CSlcyCH/ySC8LYDzlXJZ77ZwWypjmbUWl7bmPWVCAfW/LopuPkg7QO0fgx3xrQYvlheAC3g1CZ0xZ3SJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652177; c=relaxed/simple;
	bh=Ey6JwDGKnsBMava30DtiyH1F5pVTlJSO/weiq6Cy+yE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tdGAeM+t0J9Wm+x05ZRMAl4p77878O7FwWzZ1kTCLd9eZ+NKruhKytUhaZhVAbpbzZNNBMFy1PgRKOQntALWnTmkSGAOpPvyPRC1cDUU2K50AplVu2OtBKzCE2yRoJbR1eaFQQ0VXRZta+wmiRfFHac8m2LcpztEJwrwwgd+y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRA07OU8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741652172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236a/XneA0NJVrGstNl+HaEyiafUIjCWkYDwdiIp5UY=;
	b=XRA07OU8ciMUnftHUriScz+dgGTN8oADX9OWDCM+omKI7M5NySijKSP4yYy5/6gXzo+IS0
	FfidXLQdtOgHDHNLpqFkLn+NprDF4dI4f8dk77pBPecYNi/RE+JJW+y3oN/VW//FYM5wWZ
	3lcQkYb/P8UWXRLKmX/mh5CVmniAfEI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-0_CQJVrZO7OndRah-p7E_A-1; Mon, 10 Mar 2025 20:16:11 -0400
X-MC-Unique: 0_CQJVrZO7OndRah-p7E_A-1
X-Mimecast-MFC-AGG-ID: 0_CQJVrZO7OndRah-p7E_A_1741652171
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e9125db6eeso44575436d6.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652171; x=1742256971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=236a/XneA0NJVrGstNl+HaEyiafUIjCWkYDwdiIp5UY=;
        b=r6x/AB0WNgY9/QU+Vo2awmCKm6ObNvXEOb5eUVsdZho4lfdBQu7kGNvmGbU5A3PMm5
         GyQUCEwXGUSgShV+veQhSUos9AjAW9LwtiWKzk1ek2UfzrmaPKou+HXeoVOwNH9q1eJZ
         eo6ISw06kb/cNS5jUuxQUnA0NnWgtMkFrntFdFDYomjSTS6rmUJITf4M9/Omdam8IT0J
         9LZgjIzhh+3vgru3AQG7ZFUJWymkaPDE6PXWYrYUjW6ovNXaLw22uyUMB6VR8+SW3Ar2
         REELwQAnB8DWIkdLbFdkQYYwLlgvW7ValDVbEISVpaO5ieAqqY3kh5TsXHOmHoFWISK2
         K0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKmbjosHjbgT+biC+dKWjWSLxuBiQYVY6bhUjG0V2MbQT2ItlVsKGiIIkjD6KyjWKlNGUAVdIw@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfcUuTA5KxSZLwJyy1/8z4EfTAga/u4HovfCySCVvdcGuTbcd
	KuBvbk4RaY6DmFwO6ayxcOkydCPJvPPw0+xaSVOeT8zqEY4R0HhNvcgXmYxJzf+dMz2shKlSKj+
	Hwq5vv9AWzZJO1/FqeVIXToGAamsnF9VYd3/D+thjLUN87MbniUY0EsY=
X-Gm-Gg: ASbGncstutKJ7Pbe66bDVMLi2lFlHwM5/UzRJlHURb9Fy8x1/fG/l66g9dUzjKYPVdK
	GzLRkCysG5bR68jOF61o3MvXBWpLh1lOv71DXLW8XvLz8Byh2hsPus7Xiw7ONZfv1qUq08PAzeB
	4a2yCw/RDfcKdTxl3mJ2cII/dW+/bMwVnVpYvIXlt7BJnIWwMc6TC1T4UdTP6o6rqK5+x8HyIIV
	rYu7ONIkftgn45kaNXxCveyYkGK6VOTuC9G21UO8PCfnGK0QBd6o3yXUwaWnQ8NFBMt65/LcGsH
	s08CPxAXWeZ0OmG/vm1Bvl/kZA02KO0+uGksJO1D+YX/OwOcYEPiwpdzLE9C/w==
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e900693d5cmr243734576d6.38.1741652171089;
        Mon, 10 Mar 2025 17:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWcI9s5pAmz4x20etgpOydCiO3vtCen7TrgltEqQDA01TRQzGQLBKhlzBXzVBLM06ntNbtVA==
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e900693d5cmr243734086d6.38.1741652170777;
        Mon, 10 Mar 2025 17:16:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b650sm64118486d6.89.2025.03.10.17.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 17:16:10 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
Date: Mon, 10 Mar 2025 20:16:08 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Content-Language: en-US
In-Reply-To: <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/25 3:18 PM, Waiman Long wrote:
>
> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>> On 10/03/2025 10:37, Juri Lelli wrote:
>>> Rebuilding of root domains accounting information (total_bw) is
>>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
>> Nit: Couldn't spot any arch dependency here. I guess it was just tested
>> on Arm64 platforms so far.
>>
>> [...]
>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 44093339761c..363ad268a25b 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int 
>>> ndoms_new, cpumask_var_t doms_new[],
>>>       ndoms_cur = ndoms_new;
>>>         update_sched_domain_debugfs();
>>> +    dl_rebuild_rd_accounting();
>> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
>> barf when called via cpuhp's:
>>
>> sched_cpu_deactivate()
>>
>>    cpuset_cpu_inactive()
>>
>>      partition_sched_domains()
>>
>>        partition_sched_domains_locked()
>>
>>          dl_rebuild_rd_accounting()
>>
>> ?
>>
>> [...]
>
> Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will 
> be called without holding cpuset mutex.
>
> Well, I think we will need an additional wrapper in cpuset.c that 
> acquires the cpuset_mutex first before calling 
> partition_sched_domains() and use the new wrapper in these cases.

Actually, partition_sched_domains() is called with the special arguments 
(1, NULL, NULL) to reset the domain to a single one. So perhaps 
something like the following will be enough to avoid this problem.

BTW, we can merge partition_sched_domains_locked() into 
partition_sched_domains() as there is no other caller.

Cheers,
Longman

------------------------------------------------------------------------------------------------

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 95bde793651c..39b9ffa6a39a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2692,6 +2692,7 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
                                     struct sched_domain_attr *dattr_new)
  {
         bool __maybe_unused has_eas = false;
+       bool reset_domain = false;
         int i, j, n;
         int new_topology;

@@ -2706,6 +2707,7 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
         if (!doms_new) {
                 WARN_ON_ONCE(dattr_new);
                 n = 0;
+               reset_domain = true;
                 doms_new = alloc_sched_domains(1);
                 if (doms_new) {
                         n = 1;
@@ -2778,7 +2780,8 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
         ndoms_cur = ndoms_new;

         update_sched_domain_debugfs();
-       dl_rebuild_rd_accounting();
+       if (!reset_domain)
+               dl_rebuild_rd_accounting();
  }

  /*


