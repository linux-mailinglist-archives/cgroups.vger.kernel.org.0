Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4247486D1
	for <lists+cgroups@lfdr.de>; Wed,  5 Jul 2023 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjGEOtv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jul 2023 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGEOtu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jul 2023 10:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDC1719
        for <cgroups@vger.kernel.org>; Wed,  5 Jul 2023 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688568547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyM5IDrf51eZ/kcZjAxbwOacXO+LNKpyPjbVqqLXG8s=;
        b=MMaGuDVo1P7aAu01hJhP5+UX3J7ElnyWbx1gmE0hF/mztoGrcQJLHs8+TGo0wHuznPKF1j
        V1LH4ADtZhyVwqOJex0efP2Hlk9OBAA9aCxOVRtAHOdfzGWrjuGysOAsAiZVsUuYzf1XPF
        1dCW7W5gbnbOcyH+97DJ/1Ve4JT1jSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-pI7A_wqlP9eWF9sY32YdEA-1; Wed, 05 Jul 2023 10:49:03 -0400
X-MC-Unique: pI7A_wqlP9eWF9sY32YdEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0CD8185A7A2;
        Wed,  5 Jul 2023 14:49:02 +0000 (UTC)
Received: from [10.22.8.133] (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67DBF2166B25;
        Wed,  5 Jul 2023 14:49:02 +0000 (UTC)
Message-ID: <fd99f1a3-c38c-f344-b581-7df4a3937eef@redhat.com>
Date:   Wed, 5 Jul 2023 10:49:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: simplify the percpu kthreads check in
 update_tasks_cpumask()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com
References: <20230704113049.1019118-1-linmiaohe@huawei.com>
 <bc8202fd-a31c-2b08-bd01-8b5868aab230@redhat.com>
 <33c2bf85-6def-fce9-9ea7-3b3e80db67b7@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <33c2bf85-6def-fce9-9ea7-3b3e80db67b7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/5/23 01:56, Miaohe Lin wrote:
> On 2023/7/5 11:14, Waiman Long wrote:
>> On 7/4/23 07:30, Miaohe Lin wrote:
>>> kthread_is_per_cpu() can be called directly without checking whether
>>> PF_KTHREAD is set in task->flags. So remove PF_KTHREAD check to make
>>> code more concise.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 58e6f18f01c1..601c40da8e03 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1230,7 +1230,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>>>                /*
>>>                 * Percpu kthreads in top_cpuset are ignored
>>>                 */
>>> -            if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
>>> +            if (kthread_is_per_cpu(task))
>>>                    continue;
>>>                cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
>>>            } else {
>> The initial intention was to ignore only percpu kthreads. The current code likely ignore all the kthreads. Removing the PF_KTHREAD flag, however, may introduce unexpected regression at this point. I would like to hold off for now until more investigation are done.
> IMHO, the current code will ignore only percpu kthreads:
>    1.If PF_KTHREAD is set in task->flags, this patch doesn't make any difference.
>    2.If PF_KTHREAD is not set in task->flags, kthread_is_per_cpu will *always return false*. So this patch doesn't make any functional change.
>
>      bool kthread_is_per_cpu(struct task_struct *p)
>      {
>          struct kthread *kthread = __to_kthread(p);
> 	if (!kthread)
> 		return false;
>          ....
>      }
>
>      static inline struct kthread *__to_kthread(struct task_struct *p)
>      {
> 	void *kthread = p->worker_private;
> 	if (kthread && !(p->flags & PF_KTHREAD))
> 			 ^^^^^^^^^^^^^^^^^^^^^^
> 			 PF_KTHREAD is not set, so kthread = NULL.
> 		kthread = NULL;
> 	return kthread;
>      }
>
> Or am I miss something? Thanks for comment and review.

Yes, you are right. I was that conscious when I reviewed the patch last 
night :-)

Reviewed-by: Waiman Long <longman@redhat.com>

