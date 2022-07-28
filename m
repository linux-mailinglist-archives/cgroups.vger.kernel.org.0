Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE9584674
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiG1S5j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1S5j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 14:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AF0918B31
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659034657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjIYWUhlmn952PQamHyhfurxBgzciXNRkjegJKiOJW4=;
        b=FhjAJENaHhXfD5B+jqIGHbSqqAeTTQf0FZ0iwJq0my7EJXn9NjJXCGwGepCrlCDYK1RNKB
        Zg2VqeUlo5PrKgWiEER6nO4j7gp4DjHx024dpArJXXR72eTdNiNRYBK2mwu1DGpieebpQ2
        73b4cPRFwSruTPYwPkRXTDPOZnuAv00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-sdLg74s2Nye9Wp21UThKiA-1; Thu, 28 Jul 2022 14:57:31 -0400
X-MC-Unique: sdLg74s2Nye9Wp21UThKiA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4515E102BCDB;
        Thu, 28 Jul 2022 18:57:30 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B68040315E;
        Thu, 28 Jul 2022 18:57:29 +0000 (UTC)
Message-ID: <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
Date:   Thu, 28 Jul 2022 14:57:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YuLF+xXaCzwWi2BR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/28/22 13:23, Tejun Heo wrote:
> Hello,
>
> On Wed, Jul 27, 2022 at 08:58:14PM -0400, Waiman Long wrote:
>> It was found that any change to the current cpuset hierarchy may reset
>> the cpus_allowed list of the tasks in the affected cpusets to the
>> default cpuset value even if those tasks have cpus affinity explicitly
>> set by the users before. That is especially easy to trigger under a
>> cgroup v2 environment where writing "+cpuset" to the root cgroup's
>> cgroup.subtree_control file will reset the cpus affinity of all the
>> processes in the system.
>>
>> That is especially problematic in a nohz_full environment where the
>> tasks running in the nohz_full CPUs usually have their cpus affinity
>> explicitly set and will behave incorrectly if cpus affinity changes.
>>
>> Fix this problem by adding a flag in the task structure to indicate that
>> a task has their cpus affinity explicitly set before and make cpuset
>> code not to change their cpus_allowed list unless the user chosen cpu
>> list is no longer a subset of the cpus_allowed list of the cpuset itself.
>>
>> With that change in place, it was verified that tasks that have its
>> cpus affinity explicitly set will not be affected by changes made to
>> the v2 cgroup.subtree_control files.
> I think the underlying cause here is cpuset overwriting the cpumask the user
> configured but that's a longer discussion.
>
>> +/*
>> + * Don't change the cpus_allowed list if cpus affinity has been explicitly
>> + * set before unless the current cpu list is not a subset of the new cpu list.
>> + */
>> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
>> +				       const struct cpumask *new_mask)
>> +{
>> +	if (p->cpus_affinity_set && cpumask_subset(p->cpus_ptr, new_mask))
>> +		return 0;
>> +
>> +	p->cpus_affinity_set = 0;
>> +	return set_cpus_allowed_ptr(p, new_mask);
>> +}
> I wonder whether the more predictable behavior would be always not resetting
> the cpumask if it's a subset of the new_mask.
There can be a counter argument that if a user found out that there is 
not enough cpus in a cpuset to meet its performance target, one can 
always increase the number of cpus in the cpuset. Generalizing this 
behavior to all the tasks irrespective if they have explicitly set cpus 
affinity before will disallow this use case.
> Also, shouldn't this check
> p->cpus_mask instead of p->cpus_ptr?

You are right. I should have used cpus_mask instead. Will send out a v2.

Cheers,
Longman

