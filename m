Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D416260A4
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 18:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKKRpK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 12:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKRpJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 12:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68367124
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668188651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhLBpkoMD/PMp7RL3yXpMD5wg9+NONrdfcEcahalhC8=;
        b=YkqAeIZI8Jw1EOMJhYURibVvxJm9+VzCdtFNdz9Ko9XBC3wHdszpOTDy7akQbWXWAx7N8V
        xShBF4FjAwF6l5UxsvMlFPo2tNdP91H1EO/6fYTkwVYp7lUfAYYAFwK9GgrhLISp3AcPxY
        YY4zZAp0eQtan6+5pHOQRtCcgBhf+Sc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-NPiMH7vENEqUfeeGTpPk0Q-1; Fri, 11 Nov 2022 12:44:06 -0500
X-MC-Unique: NPiMH7vENEqUfeeGTpPk0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 344DF3826A54;
        Fri, 11 Nov 2022 17:44:05 +0000 (UTC)
Received: from [10.22.32.235] (unknown [10.22.32.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2B9F2166B26;
        Fri, 11 Nov 2022 17:44:04 +0000 (UTC)
Message-ID: <00c9a4e1-c94d-29c9-dea3-72d342a07997@redhat.com>
Date:   Fri, 11 Nov 2022 12:44:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 0/2] cpuset: Skip possible unwanted CPU-mask updates.
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
 <d0b43b7d-54d3-00bd-abe0-78212ee9355a@redhat.com>
 <Y25rcHYzix+kAJF9@linutronix.de>
 <6948de71-a3e3-b6c2-bc67-1bb39cbdff69@redhat.com>
 <Y259IcCb937bw3AZ@linutronix.de>
 <f28a00c4-534c-d74a-a14a-f85a1849566e@redhat.com>
In-Reply-To: <f28a00c4-534c-d74a-a14a-f85a1849566e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/11/22 12:34, Waiman Long wrote:
>
> On 11/11/22 11:49, Sebastian Andrzej Siewior wrote:
>> On 2022-11-11 11:37:03 [-0500], Waiman Long wrote:
>>> On 11/11/22 10:34, Sebastian Andrzej Siewior wrote:
>>>> On 2022-11-02 09:20:48 [-0400], Waiman Long wrote:
>>>> Hi,
>>>>
>>>>> Yes, that is a known issue which is especially problematic when 
>>>>> cgroup v2 is
>>>>> used. That is why I have recently posted a set of patches to enable
>>>>> persistent user requested affinity and they have been merged into 
>>>>> tip:
>>>>>
>>>>> 851a723e45d1 sched: Always clear user_cpus_ptr in 
>>>>> do_set_cpus_allowed()
>>>>> da019032819a sched: Enforce user requested affinity
>>>>> 8f9ea86fdf99 sched: Always preserve the user requested cpumask
>>>>> 713a2e21a513 sched: Introduce affinity_context
>>>>> 5584e8ac2c68 sched: Add __releases annotations to affine_move_task()
>>>>> They should be able to address the problem that you list here. 
>>>>> Please let me
>>>>> know if there are still problem remaining.
>>>> Thank you. This solves the most pressing issue. The CPU-mask is still
>>>> reset upon activation of the cpuset controller.
>>>> This is due to the set_cpus_allowed_ptr() in cpuset_attach().
>>>>
>>>> Is is possible to push these patches stable?
>>> Actually, I prefer to not call set_cpus_allowed_ptr() if the cpumask 
>>> of the
>>> old and new cpusets are the same. That will save some cpu cycles. 
>>> Similarly
>>> for node_mask. If there is any changes in the cpumask, we have to call
>>> set_cpus_allowed_ptr(). I will work out a patch to that effect when 
>>> I have
>>> spare cycle.
>> But couldn't we skip that set_cpus_allowed_ptr() if the current mask is
>> a subset of the new mask and keep the behavior that the mask isn't
>> changed if the cgroup's mask changes but is still a subset?
>> That cpuset_attach() callback is only invoked while the task is
>> initially added to the cgroup which happens during enabling of the
>> controller. Or do I miss another common usecase?
>
> The only way a userspace task can have a cpumask different from that 
> of its cpuset is by calling sched_setaffinity() which will be covered 
> by the persistent user requested mask change. So your patch 2 isn't 
> really needed.
>
> Your patch 1 is relatively simple and I don't have a big objection to 
> that. I will let others chime in on what their thoughts are.

I am sorry, patch 1 is still not OK.

Suppose you move a task from a cpuset of CPUs 1,2 to another one with 
CPUs 1,2,3, for example. With your patch 1, the cpumask will not change 
at all and that is not right.

Cheers,
Longman

