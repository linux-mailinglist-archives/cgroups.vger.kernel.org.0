Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B8745401
	for <lists+cgroups@lfdr.de>; Mon,  3 Jul 2023 04:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGCC6Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 2 Jul 2023 22:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGCC6X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 2 Jul 2023 22:58:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC81BC;
        Sun,  2 Jul 2023 19:58:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QvVs70rv2zMpvF;
        Mon,  3 Jul 2023 10:55:07 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 10:58:19 +0800
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
To:     Waiman Long <longman@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <9244d968-b25a-066f-2ff3-1281bf03983e@redhat.com>
 <a6c55b82-71eb-ad18-e4b2-d62f1102a0e4@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <53486caa-8ca7-78f5-71ac-d5692b482c94@huawei.com>
Date:   Mon, 3 Jul 2023 10:58:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a6c55b82-71eb-ad18-e4b2-d62f1102a0e4@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/2 7:46, Waiman Long wrote:
> On 7/1/23 19:38, Waiman Long wrote:
>> On 7/1/23 02:50, Miaohe Lin wrote:
>>> update_parent_subparts_cpumask() is called outside RCU read-side critical
>>> section without holding extra css refcnt of cp. In theroy, cp could be
>>> freed at any time. Holding extra css refcnt to ensure cp is valid while
>>> updating parent subparts cpumask.
>>>
>>> Fixes: d7c8142d5a55 ("cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 58e6f18f01c1..632a9986d5de 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>>           cpuset_for_each_child(cp, css, parent)
>>>               if (is_partition_valid(cp) &&
>>>                   cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
>>> +                if (!css_tryget_online(&cp->css))
>>> +                    continue;
>>>                   rcu_read_unlock();
>>>                   update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
>>>                   rcu_read_lock();
>>> +                css_put(&cp->css);
>>>               }
>>>           rcu_read_unlock();
>>>           retval = 0;
>>
>> Thanks for finding that. It looks good to me.
>>
>> Reviewed-by: Waiman Long <longman@redhat.com>
> 
> Though, I will say that an offline cpuset cannot be a valid partition root. So it is not really a problem. For correctness sake and consistency with other similar code, I am in favor of getting it merged.

Yes, cpuset_mutex will prevent cpuset from being offline while update cpumask. And as you mentioned, this patch makes code more consistency at least.
Thanks for your review and comment.



