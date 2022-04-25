Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3528F50E386
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiDYOq3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiDYOq2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 10:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5403B543
        for <cgroups@vger.kernel.org>; Mon, 25 Apr 2022 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650897804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oj3e9OxZuBcl3Mrg5cN9YNi1sy73Km34y8js1iAThkg=;
        b=O0swqQ5esJRhS1ofHCY17Lx/QYGjtlvmgAPXze/4klBMq1PDmzlAcqX18u96CU1JKtzHt8
        C82cYuTrK48g0GedeBG4gYSi04gJIZwSwg/vz115yNSo72XM8y0qzdlLhGpkcZ0sC9g6qe
        5fWwRD9DGsqgWIfcS9qAjRHppCI+Lxk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-hFHyvsjVMym1rU2j_aShaQ-1; Mon, 25 Apr 2022 10:43:19 -0400
X-MC-Unique: hFHyvsjVMym1rU2j_aShaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEB9C29AA3B1;
        Mon, 25 Apr 2022 14:43:18 +0000 (UTC)
Received: from [10.22.9.66] (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6F5214A5067;
        Mon, 25 Apr 2022 14:43:16 +0000 (UTC)
Message-ID: <690fb0ac-6f8c-7e52-2485-4acc030bbc07@redhat.com>
Date:   Mon, 25 Apr 2022 10:43:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] cgroup/cpuset: Remove redundant cpu/node masks setup in
 cpuset_init_smp()
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, ying.huang@intel.com,
        stable@vger.kernel.org
References: <20220425020926.1264611-1-longman@redhat.com>
 <20220425073011.GJ46405@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220425073011.GJ46405@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/25/22 03:30, Feng Tang wrote:
> Hi Waiman,
>
> Thanks for the patch!
>
> On Sun, Apr 24, 2022 at 10:09:26PM -0400, Waiman Long wrote:
>> There are 3 places where the cpu and node masks of the top cpuset can
>> be initialized in the order they are executed:
>>   1) start_kernel -> cpuset_init()
>>   2) start_kernel -> cgroup_init() -> cpuset_bind()
>>   3) kernel_init_freeable() -> do_basic_setup() -> cpuset_init_smp()
>>
>> The first cpuset_init() function just sets all the bits in the masks.
>> The last one executed is cpuset_init_smp() which sets up cpu and node
>> masks suitable for v1, but not v2.  cpuset_bind() does the right setup
>> for both v1 and v2 assuming that effective_mems and effective_cpus have
>> been set up properly which is not strictly the case here. As a result,
>> cpu and memory node hot add may fail to update the cpu and node masks
>> of the top cpuset to include the newly added cpu or node in a cgroup
>> v2 environment.
>>
>> To fix this problem, the redundant cpus_allowed and mems_allowed
>> mask setup in cpuset_init_smp() are removed. The effective_cpus and
>> effective_mems setup there are moved to cpuset_bind().
>>
>> cc: stable@vger.kernel.org
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 9390bfd9f1cd..a2e15a43397e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2961,6 +2961,9 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
>>   	percpu_down_write(&cpuset_rwsem);
>>   	spin_lock_irq(&callback_lock);
>>   
>> +	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
>> +	top_cpuset.effective_mems = node_states[N_MEMORY];
>> +
>>   	if (is_in_v2_mode()) {
>>   		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
>>   		top_cpuset.mems_allowed = node_possible_map;
>> @@ -3390,13 +3393,6 @@ static struct notifier_block cpuset_track_online_nodes_nb = {
>>    */
>>   void __init cpuset_init_smp(void)
>>   {
>> -	cpumask_copy(top_cpuset.cpus_allowed, cpu_active_mask);
>> -	top_cpuset.mems_allowed = node_states[N_MEMORY];
>> -	top_cpuset.old_mems_allowed = top_cpuset.mems_allowed;
>> -
>> -	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
>> -	top_cpuset.effective_mems = node_states[N_MEMORY];
> IIUC, the init order is:
> 	cpuset_bind()
> 	smp_init()
> 	cpuset_init_smp()
>
> while all cpus except boot cpu is brought up in smp_init(), so I'm
> thinking moving the cpus_allowed init from cpuset_init_smp() to
> cpuset_bind() may cause some problem.

Good point. So cpuset_init_smp() is still useful for setting the right 
effective_cpus and probably effective_mems. I will update the patch 
accordingly.

Thanks,
Longman

>
> Thanks,
> Feng
>

