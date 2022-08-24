Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99259F839
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiHXKzQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiHXKzO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 06:55:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852B5FF2
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:55:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w138so13497524pfc.10
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qenSJNlQcmsHihiPBle2MpvTNh+6JGq1GdYHK+MFsEo=;
        b=GdRPGMdKwlwOOyGiW0JubXH8Id59RVjZ6fEvJvwKqZeGUc3Uw0cL3gGNUkAECdJ4iF
         cV5Y+HE1wv3dg9mnGAi3NQaJJWU0/IAm//QEz1Gi7jez37RK/zmPQ8Ix5FR9WMlEuggJ
         5rYMIkn+e1k4NwcNOTvO5VH+j0U+GrUlW+6p64aheNFqUum88lVa0K0+ztGNdzq2hsBQ
         Tj+t4+HcEYdnL+l4MhW6HfIM8CJpUb3eWM3CxmNli57BCMVr11I/nQop7TIrQFLBymM3
         tnG2f7gcm2PQq8s00QuV8t5T+aNI112Txm0bPRm1gadrO3IH1udUL0qqDhTMELUeZgGh
         vz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qenSJNlQcmsHihiPBle2MpvTNh+6JGq1GdYHK+MFsEo=;
        b=zhMqungt+MfrQkpyrXDx7tiP5tXz2A9pz81Svoeh+ms/GfcNeQa78Z5FnQeT2uYDDa
         r+zY3VxGyVVgQbyTp76ZYXk1HqajVHlL5aVaHPOQW1SWkKuHNHvpL/rhjjV974xkrgQ/
         WhuG2tE3Ia2UG7ti9ZhB7wxNujloyr7vGczG1JSB0zZv+f/AHq0bqsbXHHVLhwpEYygd
         NbjcLcQ72xfpWKNp1v60JCOD9JcFDl1la/9PvwlqXMS544ODtyE7EP7GJeXIoZPvF0tI
         zY92377bhLAdsi8K/Pxvip70yS4A9XJllw81dkv946SFXWiEdeGYyH5xktksGTeTIoVc
         ONqQ==
X-Gm-Message-State: ACgBeo3YGAmh59dPwlse9ZrPkMoEZDhRf/O7gXlrBYJZRwByQTIAFb9c
        yEgAtiwbeIRipqkHSeqoySLBUA==
X-Google-Smtp-Source: AA6agR4kqx9X0QoUay3yeto0Av3nrPd4v1spEzX053k1ENoXWYQ8wQ97kdVRXyzUBD1I5fNn/QC+hQ==
X-Received: by 2002:a05:6a02:207:b0:41c:9e7d:775e with SMTP id bh7-20020a056a02020700b0041c9e7d775emr23629791pgb.227.1661338510743;
        Wed, 24 Aug 2022 03:55:10 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b00172ea32fa9bsm6322402plf.287.2022.08.24.03.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 03:55:10 -0700 (PDT)
Message-ID: <2207ff74-a5ca-8324-0e10-717f235ca161@bytedance.com>
Date:   Wed, 24 Aug 2022 18:55:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3 10/10] sched/psi: per-cgroup PSI accounting
 disable/re-enable interface
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-11-zhouchengming@bytedance.com>
 <YwX2jC2UQ/zeY2E8@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YwX2jC2UQ/zeY2E8@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/24 17:59, Johannes Weiner wrote:
> Hi Chengming,
> 
> Thanks for incorporating all the feedback. I have a few nitpicks
> below, but with those considered, please add:
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> On Wed, Aug 24, 2022 at 04:18:29PM +0800, Chengming Zhou wrote:
>> @@ -5171,12 +5220,19 @@ static struct cftype cgroup_base_files[] = {
>>  	{
>>  		.name = "irq.pressure",
>>  		.flags = CFTYPE_PRESSURE,
>> +		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
>>  		.seq_show = cgroup_irq_pressure_show,
>>  		.write = cgroup_irq_pressure_write,
>>  		.poll = cgroup_pressure_poll,
>>  		.release = cgroup_pressure_release,
>>  	},
>>  #endif
>> +	{
>> +		.name = "cgroup.pressure",
>> +		.flags = CFTYPE_PRESSURE,
>> +		.seq_show = cgroup_psi_show,
>> +		.write = cgroup_psi_write,
> 
> To match the naming convention, these should be called
> cgroup_pressure_show() and cgroup_pressure_write().

Hello,

I forgot to change the names, will do.

> 
>> @@ -745,6 +745,14 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  		if (set & (1 << t))
>>  			groupc->tasks[t]++;
>>  
>> +	if (!group->enabled) {
>> +		if (groupc->state_mask & (1 << PSI_NONIDLE))
>> +			record_times(groupc, now);
> 
> Thanks for the explanation in the other thread, it made sense. But can
> you please add a comment to document it? Something like:
> 
> 	/*
> 	 * On the first group change after disabling PSI, conclude
> 	 * the current state and flush its time. This is unlikely
> 	 * to matter to the user, but aggregation (get_recent_times)
> 	 * may have already incorporated the live state into times_prev;
> 	 * avoid a delta sample underflow when PSI is later re-enabled.
> 	 */
> 
> An unlikely() would also make sense on that branch.

The comment is very helpful, unlikely() is also very good point,
will add in the next version.

> 
>> @@ -1081,6 +1092,40 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
>>  
>>  	task_rq_unlock(rq, task, &rf);
>>  }
>> +
>> +void psi_cgroup_enabled_sync(struct psi_group *group)
>> +{
>> +	int cpu;
>> +
>> +	/*
>> +	 * After we disable psi_group->enabled, we don't actually
>> +	 * stop percpu tasks accounting in each psi_group_cpu,
>> +	 * instead only stop test_state() loop, record_times()
>> +	 * and averaging worker, see psi_group_change() for details.
>> +	 *
>> +	 * When disable cgroup PSI, this function has nothing to sync
>> +	 * since cgroup pressure files are hidden and percpu psi_group_cpu
>> +	 * would see !psi_group->enabled and only do task accounting.
>> +	 *
>> +	 * When re-enable cgroup PSI, this function use psi_group_change()
>> +	 * to get correct state mask from test_state() loop on tasks[],
>> +	 * and restart groupc->state_start from now, use .clear = .set = 0
>> +	 * here since no task status really changed.
>> +	 */
>> +	if (!group->enabled)
>> +		return;
> 
> Thanks for adding the comment, that's helpful.
> 
> I think the function would be a tad clearer and self-documenting if
> you called it psi_cgroup_restart(), and only call it on enabling.

Ok, it's better, will do.

Thanks for your review!

> 
>> +	for_each_possible_cpu(cpu) {
>> +		struct rq *rq = cpu_rq(cpu);
>> +		struct rq_flags rf;
>> +		u64 now;
>> +
>> +		rq_lock_irq(rq, &rf);
>> +		now = cpu_clock(cpu);
>> +		psi_group_change(group, cpu, 0, 0, now, true);
>> +		rq_unlock_irq(rq, &rf);
>> +	}
>> +}
>>  #endif /* CONFIG_CGROUPS */
> 
> Thanks,
> Johannes
