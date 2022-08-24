Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A269959F8DB
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiHXLyG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiHXLyG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 07:54:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D186714
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 04:54:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f17so10096399pfk.11
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mdfwmPodCkN/tga61cvp2E/By8brPAPT4bch4OmZBrY=;
        b=jQkEZX35Ws1c7ZeEwSoJBemqsqFfAypyELXqRGaM1Iwi5lyiq2xztSyATJfhvxF75Z
         ul8dBoqZHEckEFGA2Vj+QqOizPpteP5iRhGYBJ5PgqcPGaXIQs5ZopwVs6VuSY1l5tRg
         3Iz7Q0hkGTSLDWRi2xN7rYUTm402YSXBbyMt8JPsRE032tVM8R9dHI40vgO74WPOSuv8
         l25FKg7I2R437aLqahE1+UG+kYgpxhIf1V7fiRgSC94VISztjWh5wCUYNaoDtWjm2QGX
         eRxMkA21nMzsbRc6hdRrJqqfJ8QBfsu0aKk1Ldf41vLMtxNHZFFgbr58kBl4gPrKSG0S
         oh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mdfwmPodCkN/tga61cvp2E/By8brPAPT4bch4OmZBrY=;
        b=F3iUYDnPxJQ1WrUp1CQ4gkaootVFfgi3iSRJS+sBB0a1YXqJIWqg6pm8y+GjJemuqd
         G5owyX532LLzUQgf6UNawLJYHXfk4S81GtdE164E98Qn+Xc0dxtAqvCvavu3OJHiMsko
         PLFemCCMRraVmqzA6YKgMwdLHnjw9SyOliOoStQcpeBAVeWGJml7YV1VNcXDA+Hq/YKf
         3fFc1eaVGHUzcdtJK93wJ2f5LPFrdxTDjfgw197ixLSX6TaaHcWjW9nqBmyzTDjAMN2J
         WcXh0ShBDj0qUIe4HNArCG4GXfJTjGmvHsC2KaIt1UH6elZe3HbpW8Gpqx/DVywxQcmE
         qC8w==
X-Gm-Message-State: ACgBeo3XjNvP+2vcD44tLNk9TcIPfb0M4BJLjtkHMf3sdFWLk0k3ghw7
        aTnvC1MEufyFSSfy1PtnyLpX3w==
X-Google-Smtp-Source: AA6agR4hUD37SHwdWeTevNNHwild8/Vtbrr4Wc7zIQIiAtuLWmwOFvjW9Z50/UwEJ9jdc27TVN+xWA==
X-Received: by 2002:a65:6c10:0:b0:429:4a5:a4d0 with SMTP id y16-20020a656c10000000b0042904a5a4d0mr24569071pgu.614.1661342044601;
        Wed, 24 Aug 2022 04:54:04 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id g126-20020a625284000000b0052d7cca96acsm12750758pfb.110.2022.08.24.04.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 04:54:04 -0700 (PDT)
Message-ID: <911cd0fc-0027-6da5-767a-fea4c7731c81@bytedance.com>
Date:   Wed, 24 Aug 2022 19:53:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3 07/10] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ
 pressure
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-8-zhouchengming@bytedance.com>
 <YwYBasgyIU0iQgL3@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YwYBasgyIU0iQgL3@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/24 18:46, Johannes Weiner wrote:
> On Wed, Aug 24, 2022 at 04:18:26PM +0800, Chengming Zhou wrote:
>> @@ -903,6 +903,36 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
>> +void psi_account_irqtime(struct task_struct *task, u32 delta)
>> +{
>> +	int cpu = task_cpu(task);
>> +	void *iter = NULL;
>> +	struct psi_group *group;
>> +	struct psi_group_cpu *groupc;
>> +	u64 now;
>> +
>> +	if (!task->pid)
>> +		return;
>> +
>> +	now = cpu_clock(cpu);
>> +
>> +	while ((group = iterate_groups(task, &iter))) {
>> +		groupc = per_cpu_ptr(group->pcpu, cpu);
>> +
>> +		write_seqcount_begin(&groupc->seq);
>> +
>> +		record_times(groupc, now);
>> +		groupc->times[PSI_IRQ_FULL] += delta;
>> +
>> +		write_seqcount_end(&groupc->seq);
>> +
>> +		if (group->poll_states & (1 << PSI_IRQ_FULL))
>> +			psi_schedule_poll_work(group, 1);
>> +	}
> 
> Shouldn't this kick avgs_work too? If the CPU is otherwise idle,
> times[PSI_IRQ_FULL] would overflow after two missed averaging runs.

If the CPU is idle, task->pid == 0, so no times[PSI_IRQ_FULL] would accumulate?
I was thinking if task->pid != 0, avgs_work should be active.

Not sure, maybe I missed something.

> 
> avgs_work should probably also self-perpetuate when PSI_IRQ_FULL is in
> changed_states. (Looking at that code, I think it can be simplified:
> delete nonidle and do `if (changed_states) schedule_delayed_work()`.)

```
collect_percpu_times(group, PSI_AVGS, &changed_states);
nonidle = changed_states & (1 << PSI_NONIDLE);

if (nonidle) {
	schedule_delayed_work(dwork, nsecs_to_jiffies(
			group->avg_next_update - now) + 1);
}
```

Yes, changed_states include PSI_IRQ_FULL, here we only check nonidle
= changed_states & (1 << PSI_NONIDLE), so it will not restart
if only PSI_IRQ_FULL?

If use `if (changed_states) schedule_delayed_work()`, avgs_work will
self-restart when only PSI_IRQ_FULL changes?

Thanks!

