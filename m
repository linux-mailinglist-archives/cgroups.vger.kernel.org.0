Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C56D6A9A
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjDDRay (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjDDRac (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 13:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4619B6
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680629235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+yJ2HBFPQ7R/vP49e1zoV0yoKAMKg83JKUSNAzQmCY=;
        b=FB9m9UcPKN8UZP1jbyjg0t2VF79UGUH1n7Pa0+OkNDbsylYV6hf9HuzEVjRZBYGtdsrxJU
        y9w/DJpbtUcOBuZEl8v74Yf/zDGM4effnRW1SZJbIZ1dwu+fNL15VqTKiEJ6UAREeVWrjs
        9VAGZbbQ0S2v8yEwWLuBS21GVQjCwTI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-wV2LJ1KSPv-3hBGwhkWILA-1; Tue, 04 Apr 2023 13:24:04 -0400
X-MC-Unique: wV2LJ1KSPv-3hBGwhkWILA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C89642999B2E;
        Tue,  4 Apr 2023 17:24:03 +0000 (UTC)
Received: from [10.22.32.153] (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E587140EBF4;
        Tue,  4 Apr 2023 17:24:03 +0000 (UTC)
Message-ID: <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
Date:   Tue, 4 Apr 2023 13:24:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Gang Li <ligang.bdlg@bytedance.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/4/23 10:31, Michal Hocko wrote:
> [CC cpuset people]
>
> On Tue 04-04-23 19:55:09, Gang Li wrote:
>> When a process in cpuset triggers oom, it may kill a completely
>> irrelevant process on another numa node, which will not release any
>> memory for this cpuset.
>>
>> It seems that `CONSTRAINT_CPUSET` is not really doing much these
>> days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
>> by selecting victim from all cpusets with the same mems_allowed as
>> the current cpuset.
> This should go into more details about the usecase, testing and ideally
> also spend couple of words about how CONSTRAINT_CPUSET is actually
> implemented because this is not really immediately obvious. An example
> of before/after behavior would have been really nice as well.
>
> You should also go into much more details about how oom victims are
> actually evaluated.
>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
>> ---
>> Changes in v2:
>> - Select victim from all cpusets with the same mems_allowed as the current cpuset.
>>    (David Rientjes <rientjes@google.com>)
>>
>> v1:
>> - https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/
>>
>> ---
>>   include/linux/cpuset.h |  6 ++++++
>>   kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++++++++++
>>   mm/oom_kill.c          |  4 ++++
>>   3 files changed, 38 insertions(+)
> As this is a userspace visible change it should also be documented
> somewhere  in Documentation.
>
> I am not really familiar with cpusets internals so I cannot really judge
> cpuset_cgroup_scan_tasks implementation.
>
> The oom report should be explicit about this being CPUSET specific oom
> handling so unexpected behavior could be nailed down to this change so I
> do not see a major concern from the oom POV. Nevertheless it would be
> still good to consider whether this should be an opt-in behavior. I
> personally do not see a major problem because most cpuset deployments I
> have seen tend to be well partitioned so the new behavior makes more
> sense.
>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index 980b76a1237e..fc244141bd52 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>>   	task_unlock(current);
>>   }
>>   
>> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
>> +
>>   #else /* !CONFIG_CPUSETS */
>>   
>>   static inline bool cpusets_enabled(void) { return false; }
>> @@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>>   	return false;
>>   }
>>   
>> +static inline int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
>> +{
>> +	return 0;
>> +}
>>   #endif /* !CONFIG_CPUSETS */
>>   
>>   #endif /* _LINUX_CPUSET_H */
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index bc4dcfd7bee5..b009c98ca19e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4013,6 +4013,34 @@ void cpuset_print_current_mems_allowed(void)
>>   	rcu_read_unlock();
>>   }
>>   
>> +int cpuset_cgroup_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
>> +{
>> +	int ret = 0;
>> +	struct css_task_iter it;
>> +	struct task_struct *task;
>> +	struct cpuset *cs;
>> +	struct cgroup_subsys_state *pos_css;
>> +
>> +	/*
>> +	 * Situation gets complex with overlapping nodemasks in different cpusets.
>> +	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
>> +	 *
>> +	 * But for now, let's make it simple. Just iterate through all cpusets
>> +	 * with the same mems_allowed as the current cpuset.
>> +	 */
>> +	rcu_read_lock();
>> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>> +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
>> +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
>> +			while (!ret && (task = css_task_iter_next(&it)))
>> +				ret = fn(task, arg);
>> +			css_task_iter_end(&it);
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +	return ret;
>> +}

You will also need to take cpuset_rwsem to make sure that cpusets are 
stable. BTW, the cpuset_cgroup_scan_tasks() name is kind of redundant. I 
will suggest you just name it as cpuset_scan_tasks(). Please also add a 
doctext comment about its purpose and how it should be used.

Cheers,
Longman

