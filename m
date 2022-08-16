Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F1595CD3
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiHPNGh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiHPNGe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 09:06:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB12608
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 06:06:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so9525947pjf.5
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+6Yo80pVz7R1wbuugd0h39oHv4cQk8t0dTgRXP4VwBI=;
        b=Bm1NhmX8UPNf1PtLuZHAgWfhESmLqjvmDF7oLG7Sjrob5ZBRioBQbZD8IbmfhUAuPy
         26Pg0XP9e55a3u5kuQ5ryXTN1eqIwUYiGNTjeFnhmdbLM55bc0FxevMk8+WBBXcBYJT5
         CC+fEv2AnVaO1iGODXOqJPnAoaTxd2O8NqgXkv2mZ6mBh9kYG0x+9EMHXgGOCIk3qAR1
         n1LKoZW0wxTfg0Fcd1tVZGBrJarWd6ATeB6MjzrMVXM8Uq9zR3Tc0GPRV7NUamgreV0Y
         sIsQn/MuuGInwkkJosYPYxp8cPCoQUm4kieEJnct/L+ITnY3CRyDKA7UUzqyiZWg54Tf
         3LGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+6Yo80pVz7R1wbuugd0h39oHv4cQk8t0dTgRXP4VwBI=;
        b=Fkp7v5YwEN9KPT+fCR2kthbCUWUtcqIosQslc+vX4qB0t+LgIa0Xiu0jvb4CzNcbN1
         L5OQg2mJr7jQXQp5O/cid+bFq5bmfv0uJL2CNMRtRPIVgoZLcn0h98VEgIM9K164K0n3
         m9aSVIHiS2qDdcWMuzJqbM6KSXhnCmtauyp6iQmLqRLEui6Co1VmlkhvTzR8eZ6Ras3w
         IKzGpP7fPCl5+MAhL+JbYSdmTmkleLjEnKtMLmweGj4K6zUN0JfDUIyUUAbDu6RSO46M
         0Awy25JUg78G+xo1vjxmEKmbCyTKFOVxTyhY/N8Xmz6UWV/w+lrq3pUWwtDpdRZIHu77
         5MHA==
X-Gm-Message-State: ACgBeo3rprwj/S1Eb2EzNIrtchkqo9Rtn9S6sWmdIXafzPZgL1E43v//
        vahlkk7elBJS9mCFuTU67V8Q9g==
X-Google-Smtp-Source: AA6agR4lbXmDGaUrZOxRP8v3XjSrsDCXexABCnHXUmst8ZdJDP5gNcl6/P2X/+cQ8AFP4EeEZ46udg==
X-Received: by 2002:a17:902:d58d:b0:171:5880:3287 with SMTP id k13-20020a170902d58d00b0017158803287mr20604260plh.9.1660655192117;
        Tue, 16 Aug 2022 06:06:32 -0700 (PDT)
Received: from [10.4.196.37] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b0016f04c098ddsm9039093plx.226.2022.08.16.06.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:06:31 -0700 (PDT)
Message-ID: <904851a7-7b01-8689-3ec1-2a61f8244841@bytedance.com>
Date:   Tue, 16 Aug 2022 21:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, corbet@lwn.net, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvprI6ZL8dVWGyBO@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YvprI6ZL8dVWGyBO@cmpxchg.org>
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

On 2022/8/15 23:49, Johannes Weiner wrote:
> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
>> +static ssize_t cgroup_psi_write(struct kernfs_open_file *of,
>> +				char *buf, size_t nbytes, loff_t off)
>> +{
>> +	ssize_t ret;
>> +	int enable;
>> +	struct cgroup *cgrp;
>> +	struct psi_group *psi;
>> +
>> +	ret = kstrtoint(strstrip(buf), 0, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (enable < 0 || enable > 1)
>> +		return -ERANGE;
>> +
>> +	cgrp = cgroup_kn_lock_live(of->kn, false);
>> +	if (!cgrp)
>> +		return -ENOENT;
>> +
>> +	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
>> +	psi_cgroup_enable(psi, enable);
> 
> I think it should also add/remove the pressure files when enabling and
> disabling the aggregation, since their contents would be stale and
> misleading.
> 
> Take a look at cgroup_add_dfl_cftypes() and cgroup_rm_cftypes()

Ok, I will look.

> 
>> @@ -5115,6 +5152,12 @@ static struct cftype cgroup_base_files[] = {
>>  		.release = cgroup_pressure_release,
>>  	},
>>  #endif
>> +	{
>> +		.name = "cgroup.psi",
>> +		.flags = CFTYPE_PRESSURE,
>> +		.seq_show = cgroup_psi_show,
>> +		.write = cgroup_psi_write,
>> +	},
>>  #endif /* CONFIG_PSI */
>>  	{ }	/* terminate */
>>  };
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 58f8092c938f..9df1686ee02d 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -181,6 +181,7 @@ static void group_init(struct psi_group *group)
>>  {
>>  	int cpu;
>>  
>> +	group->enabled = true;
>>  	for_each_possible_cpu(cpu)
>>  		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>>  	group->avg_last_update = sched_clock();
>> @@ -700,17 +701,16 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  	groupc = per_cpu_ptr(group->pcpu, cpu);
>>  
>>  	/*
>> -	 * First we assess the aggregate resource states this CPU's
>> -	 * tasks have been in since the last change, and account any
>> -	 * SOME and FULL time these may have resulted in.
>> -	 *
>> -	 * Then we update the task counts according to the state
>> +	 * First we update the task counts according to the state
>>  	 * change requested through the @clear and @set bits.
>> +	 *
>> +	 * Then if the cgroup PSI stats accounting enabled, we
>> +	 * assess the aggregate resource states this CPU's tasks
>> +	 * have been in since the last change, and account any
>> +	 * SOME and FULL time these may have resulted in.
>>  	 */
>>  	write_seqcount_begin(&groupc->seq);
>>  
>> -	record_times(groupc, now);
>> -
>>  	/*
>>  	 * Start with TSK_ONCPU, which doesn't have a corresponding
>>  	 * task count - it's just a boolean flag directly encoded in
>> @@ -750,6 +750,14 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  		if (set & (1 << t))
>>  			groupc->tasks[t]++;
>>  
>> +	if (!group->enabled) {
>> +		if (groupc->state_mask & (1 << PSI_NONIDLE))
>> +			record_times(groupc, now);
> 
> Why record the nonidle time? It's only used for aggregation, which is
> stopped as well.

I'm considering of this situation: disable at t2 and re-enable at t3

state1(t1) --> state2(t2) --> state3(t3)

If aggregator has get_recent_times() in [t1, t2], groupc->times_prev[aggregator]
will include that delta of (t - t1).

Then re-enable at t3, the delta of (t3-t1) is discarded, may make that aggregator
see times < groupc->times_prev[aggregator] ?

Maybe I missed something, not sure whether this is a problem.


> 
>> @@ -1088,6 +1097,23 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
>>  
>>  	task_rq_unlock(rq, task, &rf);
>>  }
>> +
>> +void psi_cgroup_enable(struct psi_group *group, bool enable)
>> +{
>> +	struct psi_group_cpu *groupc;
>> +	int cpu;
>> +	u64 now;
>> +
>> +	if (group->enabled == enable)
>> +		return;
>> +	group->enabled = enable;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		groupc = per_cpu_ptr(group->pcpu, cpu);
>> +		now = cpu_clock(cpu);
>> +		psi_group_change(group, cpu, 0, 0, now, true);
> 
> This loop deserves a comment, IMO.

I add some comments as below, could you help take a look?

+
+void psi_cgroup_enable(struct psi_group *group, bool enable)
+{
+       int cpu;
+       u64 now;
+
+       if (group->enabled == enable)
+               return;
+       group->enabled = enable;
+
+       /*
+        * We use psi_group_change() to disable or re-enable the
+        * record_times(), test_state() loop and averaging worker
+        * in each psi_group_cpu of the psi_group, use .clear = 0
+        * and .set = 0 here since no task status really changed.
+        */
+       for_each_possible_cpu(cpu) {
+               now = cpu_clock(cpu);
+               psi_group_change(group, cpu, 0, 0, now, true);
+       }
+}

Thanks!

