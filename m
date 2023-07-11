Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305B74E477
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGKCwI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 22:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKCwH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 22:52:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5633910D;
        Mon, 10 Jul 2023 19:52:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0QL63WXZzMqbJ;
        Tue, 11 Jul 2023 10:48:46 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:52:02 +0800
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
To:     Waiman Long <longman@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
 <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <30b1f809-a11b-efe8-289c-04a801f20207@huawei.com>
Date:   Tue, 11 Jul 2023 10:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/10 23:40, Waiman Long wrote:
> On 7/10/23 11:11, Michal Koutný wrote:
>> Hello.
>>
>> On Sat, Jul 01, 2023 at 02:50:49PM +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:
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
>> Apologies for a possibly noob question -- why is RCU read lock
>> temporarily dropped within the loop?
>> (Is it only because of callback_lock or cgroup_file_kn_lock (via
>> notify_partition_change()) on PREEMPT_RT?)
>>
>>
>>
>> [
>> OT question:
>>     cpuset_for_each_child(cp, css, parent)                (1)
>>         if (is_partition_valid(cp) &&
>>             cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
>>             if (!css_tryget_online(&cp->css))
>>                 continue;
>>             rcu_read_unlock();
>>             update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
>>               ...
>>               update_tasks_cpumask(cp->parent)
>>                 ...
>>                 css_task_iter_start(&cp->parent->css, 0, &it);    (2)
>>                   ...
>>             rcu_read_lock();
>>             css_put(&cp->css);
>>         }
>>
>> May this touch each task same number of times as its depth within
>> herarchy?
> 
> I believe the primary reason is because update_parent_subparts_cpumask() can potential run for quite a while. So we don't want to hold the rcu_read_lock for too long. There may also be a potential that schedule() may be called.

IMHO, the reason should be as same as the below commit:

commit 2bdfd2825c9662463371e6691b1a794e97fa36b4
Author: Waiman Long <longman@redhat.com>
Date:   Wed Feb 2 22:31:03 2022 -0500

    cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning

    It was found that a "suspicious RCU usage" lockdep warning was issued
    with the rcu_read_lock() call in update_sibling_cpumasks().  It is
    because the update_cpumasks_hier() function may sleep. So we have
    to release the RCU lock, call update_cpumasks_hier() and reacquire
    it afterward.

    Also add a percpu_rwsem_assert_held() in update_sibling_cpumasks()
    instead of stating that in the comment.

Thanks both.

