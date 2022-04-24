Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256E50D5E8
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiDXXJS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 24 Apr 2022 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDXXJQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 24 Apr 2022 19:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92BC137AAA
        for <cgroups@vger.kernel.org>; Sun, 24 Apr 2022 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650841572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7XA6qZFd8437OWVU75dRpEhyqgGrVi83OVbXYwckLs=;
        b=b22Kv+cisBNr1lm3faqpeHbH0YhyNBQgInjIrUkD5nCeyrVsP3dudK/VItbyKqt3EcyXLH
        EMgvNZAqJu4wARN1vBGg88pzfRuWftltQtZ1HqHh3YbpCjQsijfiu7Ox7QQHQbARz6RGqW
        IkECPWP2wxCl1rehawc5f3Lj9RKewOw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-MH12Y-nIP2a4jPMKuvI0eA-1; Sun, 24 Apr 2022 19:06:09 -0400
X-MC-Unique: MH12Y-nIP2a4jPMKuvI0eA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BB1E3806736;
        Sun, 24 Apr 2022 23:06:08 +0000 (UTC)
Received: from [10.22.8.132] (unknown [10.22.8.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 628A754CE43;
        Sun, 24 Apr 2022 23:06:07 +0000 (UTC)
Message-ID: <47477e7f-9d35-d5d1-faa1-d1538b806e94@redhat.com>
Date:   Sun, 24 Apr 2022 19:06:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] cgroup/cpuset: fix a memory binding failure for
 cgroup v2
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Feng Tang <feng.tang@intel.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
        ying.huang@intel.com
References: <20220419020958.40419-1-feng.tang@intel.com>
 <YmHZK+M470GjeJCV@slm.duckdns.org>
 <e278054c-098a-4859-4cef-2509f77ef0ca@redhat.com>
In-Reply-To: <e278054c-098a-4859-4cef-2509f77ef0ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/24/22 12:04, Waiman Long wrote:
> On 4/21/22 18:22, Tejun Heo wrote:
>> cc'ing Waiman and copying the whole body.
>>
>> Waiman, can you please take a look?
>>
>> Thanks.
>>
>> On Tue, Apr 19, 2022 at 10:09:58AM +0800, Feng Tang wrote:
>>> We got report that setting cpuset.mems failed when the nodemask
>>> contains a newly onlined memory node (not enumerated during boot)
>>> for cgroup v2, while the binding succeeded for cgroup v1.
>>>
>>> The root cause is, for cgroup v2, when a new memory node is onlined,
>>> top_cpuset's 'mem_allowed' is not updated with the new nodemask of
>>> memory nodes, and the following setting memory nodemask will fail,
>>> if the nodemask contains a new node.
>>>
>>> Fix it by updating top_cpuset.mems_allowed right after the
>>> new memory node is onlined, just like v1.
>>>
>>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>>> ---
>>> Very likely I missed some details here, but it looks strange that
>>> the top_cpuset.mem_allowed is not updatd even after we onlined
>>> several memory nodes after boot.
>>>
>>>   kernel/cgroup/cpuset.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 9390bfd9f1cd..b97caaf16374 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -3314,8 +3314,7 @@ static void cpuset_hotplug_workfn(struct 
>>> work_struct *work)
>>>       /* synchronize mems_allowed to N_MEMORY */
>>>       if (mems_updated) {
>>>           spin_lock_irq(&callback_lock);
>>> -        if (!on_dfl)
>>> -            top_cpuset.mems_allowed = new_mems;
>>> +        top_cpuset.mems_allowed = new_mems;
>>>           top_cpuset.effective_mems = new_mems;
>>>           spin_unlock_irq(&callback_lock);
>>>           update_tasks_nodemask(&top_cpuset);
> The on_dfl check was added by commit 7e88291beefb ("cpuset: make 
> cs->{cpus, mems}_allowed as user-configured masks"). This is the 
> expected behavior for cgroup v2 as we don't want to remove a node 
> because it is hot-removed. However, I do see a problem in case we are 
> adding a node that is not originally in top_cpuset.mems_allowed. We 
> should be allowed to add the extra memory node. So something like
>
>         if (!on_dfl)
>                 top_cpuset.mems_allowed = new_mems;
>         else if (!nodes_subset(new_mems, top_cpuset.mems_allowed))
>                 nodes_or(top_cpuset.mems_allowed, 
> top_cpuset.mems_allowed, new_mems);
>
> For v2, top_cpuset.mems_allowed is set to node_possible_map in 
> cpuset_bind(). Perhaps node_possible_map may not include all the nodes 
> that are hot-pluggable.
>
> I don't know if that is similar problem with cpu_possible_mask or not.


Ah, I know why the top_cpuset.mems_allowed isn't correctly set. There 
are 2 places where it is set:

  - cpuset_bind(): top_cpuset.mems_allowed = node_possible_map
  - cpuset_init_smp(): top_cpuset.mems_allowed = node_states[N_MEMORY];

The first one is correct, but the second isn't. It turns out that 
cpuset_init_smp() can be called later than cpuset_bind().

[    2.611207] cpuset_bind called
[    2.631182] cblist_init_generic: Setting adjustable number of 
callback queues.
[    3.082357] cpuset_init_smp called

So the proper fix may be to make sure that top_cpuset.mems_allowed is 
initialized correctly.

Cheers,
Longman

