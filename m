Return-Path: <cgroups+bounces-12468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C4CCA240
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 04:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C92030194D9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29B20299B;
	Thu, 18 Dec 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+HPMu5E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfkNcBwD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4D125A9
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027189; cv=none; b=BdPa5ckoVmqOU57jYdD+La7s0ATIdQcwIAw9AWzaoaGuaUx3SdIEZRKu1BjNJuzql79R1YuyvJbtIXA+p6Rv578TZjpnc6oOWGRSgj2zj4XGx5gTvGvMxhKlrCJ9wBfo7tn2Sl8J02URanqTQFI7ONZx9Ud4TICPaa7L4LNT2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027189; c=relaxed/simple;
	bh=1w3K9erVeAIYiyU1ISwEyluzBAz/NH7/ljYWQPc8q2g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uwn/ppsy1VIYJuKqCc+KMXM1V10fhjm0HzBShjfiA6DH/iApwPlCAXIzLqu7cefMsi1aCwmlZadQY9rtPBGn6GQGvlwas+SJwcUN/ut3XxDS1jp+VcxnfgS0nw1VAyeO8S0xRGCWQOfvir0eg2OiOZZs8U3tq3cVF/L6HfKWdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+HPMu5E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfkNcBwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766027186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMP0RMFq2yOHg1jcSOiR2CNxZZMstan1ZeAu1gLWTB8=;
	b=Q+HPMu5E0PRkrvrt64PuADVAjsgUIOqrD/BQBRy3j8E9aqMR7nlJ4IqgNrT5GI9gW6ZAQg
	v9RgFxasgVjCnAGDtNAapuvh7wU0+sDEtrrJ4Qzun2W/nLoPKkuODJ90KrYaag5JOWZqvd
	TIj0iOapG2cSEoB0Cao8VEm1ntznz28=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-IITktprNOJaSqw93JDZtxg-1; Wed, 17 Dec 2025 22:06:25 -0500
X-MC-Unique: IITktprNOJaSqw93JDZtxg-1
X-Mimecast-MFC-AGG-ID: IITktprNOJaSqw93JDZtxg_1766027184
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24a25cff5so48382885a.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 19:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766027184; x=1766631984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMP0RMFq2yOHg1jcSOiR2CNxZZMstan1ZeAu1gLWTB8=;
        b=LfkNcBwDal4yU8OB27akMIGigxMI1Eixxem82kmJuhI3QsuwRuHa+Yy1TkW+y8BsxX
         +a7GCQKOB4gNkTtrsCcghwDZf1unne/TVLEyDYTQ1oZ2DMAC/7bNLrRqWCtPfn3txQ1t
         bfABCYo7hqGubPT1wCC7yxUMKx+WnSmPPSqK32R7cNflJJSk1NJDFJBYDfugocr8VuWp
         fxqd/Ru88TgHqB6hq9O7sLK/SsZ4JeUexRbI5FtVOM9KChMTMItZT39Yhuo54HZXqaHX
         guDHg9FHHlDEXDe6rTtAFsBunuDe6x0PMOWuJPxxh+Pw1fPE5Q4K/Wt8NWaPI4j56E6s
         l3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027184; x=1766631984;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMP0RMFq2yOHg1jcSOiR2CNxZZMstan1ZeAu1gLWTB8=;
        b=UWFj+EB5ubfFygi82KCE/jKoCBYskAxDoFeucVL0VUkYwDCioKZWIieHtgDUpGF28o
         YEUJrmkffBvnGbDTYDR4RrfxXUL+yBum1FvPGsSAToifzsYPIXAB+D9SPUpI4Ocw6DHh
         nZpk76IsOkwr8B+7Qo+4L/zJFgS6ebddJs/IlF6IbJJNnJHJvqxFJCB9hOIl+eeLPjrt
         JXgmAMDZu5t7pSxWr9mfFrFkLDmCwjB/KpVZR9PYJHdJRXrBpFGO7Mkwh8wp3Yqx/xOh
         GUd7G/N9mWZ8QMi/p2CJFrqUiLUnqDC+RyHVLEcjRaE5+P+rDyg6mAnbmQTZFVdI8Ri9
         gMrw==
X-Gm-Message-State: AOJu0Ywyv62TYc6KPrG1YSN2uwECKJHk1if5hluuDbRsq/Euhjq6dnXQ
	XYmKHJzcsm8zKM+/Dpe1SUb9muUqqnXz76WeQA0VQDKeYV3QjyXgMY0uFZ1UU4NMmV0kSRmvkzU
	BDggvXCEPfG/TrQenIlfEKytg/QtiC0CmdQXFeTMOEA74JoZNFm14kXA4GjE=
X-Gm-Gg: AY/fxX7iuI16ajRkn3SHxeduUpXUYw6KImBVr1szvY6sIJbKnzYYkV0CsZD8FHLUG1D
	mfJ/MHUwryYTWAryRw6Yl06p5b4LPjsP1nyg+oD4+GEjVEMcpcb8WWtCftpPM7qqQOq9kEPMUfA
	mLIL/fVl3U+Yve7mlY163KnOsqnHWpoc1VOUCZ/baBsED80whdmUChklE4a7oDzacy++zsJl+R0
	LYvtLlVe3V1uCc7q3lYjOuuuFQr89FW6yjoI9fKiPJcIz355nczKTWdPJV+gtj9zA3u+xDt3wir
	Zby67dn/KcBF+hgxJ0Hslsf1emYBGGMhEdStKshhRUUuvbr5nIlLk5x96QZZ3apSHNj6adfsASY
	sydpoP7FhlcOwVZS2go8aMaSWsffPnoLbZLLtCaK3yWr8O+Y/kuY5DVzx
X-Received: by 2002:a05:620a:400b:b0:8b1:2fab:30cd with SMTP id af79cd13be357-8bb3a36d380mr3021107585a.52.1766027184439;
        Wed, 17 Dec 2025 19:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDZjilkkrLLT8zrlhycK20SmmaPwGqIv7DftZyLv8nxFly8G3Hq2cQQ873v8E2YciAYPZ5NQ==
X-Received: by 2002:a05:620a:400b:b0:8b1:2fab:30cd with SMTP id af79cd13be357-8bb3a36d380mr3021105385a.52.1766027184025;
        Wed, 17 Dec 2025 19:06:24 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beebb3b75bsm75364685a.52.2025.12.17.19.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:06:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67cabea9-b74f-43da-a860-139e0f52f0e1@redhat.com>
Date: Wed, 17 Dec 2025 22:06:22 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/6] cpuset: move update_domain_attr_tree to
 cpuset_v1.c
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-5-chenridong@huaweicloud.com>
 <249786b2-f715-4a46-be47-d6d3d6f35c10@redhat.com>
 <3d9464bd-77ee-4ff7-a9e8-90930b994d00@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <3d9464bd-77ee-4ff7-a9e8-90930b994d00@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 7:44 PM, Chen Ridong wrote:
>
> On 2025/12/18 1:09, Waiman Long wrote:
>> On 12/17/25 3:49 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Since relax_domain_level is only applicable to v1, move
>>> update_domain_attr_tree() to cpuset-v1.c, which solely updates
>>> relax_domain_level,
>>>
>>> Additionally, relax_domain_level is now initialized in cpuset1_inited.
>>> Accordingly, the initialization of relax_domain_level in top_cpuset is
>>> removed. The unnecessary remote_partition initialization in top_cpuset
>>> is also cleaned up.
>>>
>>> As a result, relax_domain_level can be defined in cpuset only when
>>> CONFIG_CPUSETS_V1=y.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset-internal.h | 11 ++++++++---
>>>    kernel/cgroup/cpuset-v1.c       | 28 ++++++++++++++++++++++++++++
>>>    kernel/cgroup/cpuset.c          | 31 -------------------------------
>>>    3 files changed, 36 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index a32517da8231..677053ffb913 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -150,9 +150,6 @@ struct cpuset {
>>>         */
>>>        int attach_in_progress;
>>>    -    /* for custom sched domain */
>>> -    int relax_domain_level;
>>> -
>>>        /* partition root state */
>>>        int partition_root_state;
>>>    @@ -182,6 +179,9 @@ struct cpuset {
>>>      #ifdef CONFIG_CPUSETS_V1
>>>        struct fmeter fmeter;        /* memory_pressure filter */
>>> +
>>> +    /* for custom sched domain */
>>> +    int relax_domain_level;
>>>    #endif
>>>    };
>>>    @@ -296,6 +296,8 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>>    int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>>>    void cpuset1_init(struct cpuset *cs);
>>>    void cpuset1_online_css(struct cgroup_subsys_state *css);
>>> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> +                    struct cpuset *root_cs);
>>>    #else
>>>    static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>>                        struct task_struct *tsk) {}
>>> @@ -307,6 +309,9 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>>>                    struct cpuset *trial) { return 0; }
>>>    static inline void cpuset1_init(struct cpuset *cs) {}
>>>    static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>>> +static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> +                    struct cpuset *root_cs) {}
>>> +
>>>    #endif /* CONFIG_CPUSETS_V1 */
>>>      #endif /* __CPUSET_INTERNAL_H */
>>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>> index 574df740f21a..95de6f2a4cc5 100644
>>> --- a/kernel/cgroup/cpuset-v1.c
>>> +++ b/kernel/cgroup/cpuset-v1.c
>>> @@ -502,6 +502,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>>>    void cpuset1_init(struct cpuset *cs)
>>>    {
>>>        fmeter_init(&cs->fmeter);
>>> +    cs->relax_domain_level = -1;
>>>    }
>>>      void cpuset1_online_css(struct cgroup_subsys_state *css)
>>> @@ -552,6 +553,33 @@ void cpuset1_online_css(struct cgroup_subsys_state *css)
>>>        cpuset_callback_unlock_irq();
>>>    }
>>>    +static void
>>> +update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
>>> +{
>>> +    if (dattr->relax_domain_level < c->relax_domain_level)
>>> +        dattr->relax_domain_level = c->relax_domain_level;
>>> +}
>>> +
>>> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> +                    struct cpuset *root_cs)
>>> +{
>>> +    struct cpuset *cp;
>>> +    struct cgroup_subsys_state *pos_css;
>>> +
>>> +    rcu_read_lock();
>>> +    cpuset_for_each_descendant_pre(cp, pos_css, root_cs) {
>>> +        /* skip the whole subtree if @cp doesn't have any CPU */
>>> +        if (cpumask_empty(cp->cpus_allowed)) {
>>> +            pos_css = css_rightmost_descendant(pos_css);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (is_sched_load_balance(cp))
>>> +            update_domain_attr(dattr, cp);
>>> +    }
>>> +    rcu_read_unlock();
>>> +}
>>> +
>>>    /*
>>>     * for the common functions, 'private' gives the type of file
>>>     */
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index e836a1f2b951..88ca8b40e01a 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -215,8 +215,6 @@ static struct cpuset top_cpuset = {
>>>        .flags = BIT(CS_CPU_EXCLUSIVE) |
>>>             BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>>        .partition_root_state = PRS_ROOT,
>>> -    .relax_domain_level = -1,
>> As the cpuset1_init() function will not be called for top_cpuset, you should not remove the
>> initialization of relax_domain_level. Instead, put it inside a "ifdef CONFIG_CPUSETS_V1 block.
>>
> In patch 3/6, I've made cpuset_init call cpuset1_init to initialize top_cpuset.fmeter. Thus, I think
> we could remove the relax_domain_level initialization here.

I missed that. You are right. Remove the initialization here should be 
all right.

Cheers,
Longman

>
>>> -    .remote_partition = false,
>> Yes, this is not really needed and can be removed.
>>
>> Cheers,
>> Longman
>>


