Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25274FCE1
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGLB5B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 21:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLB5A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 21:57:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33523171E;
        Tue, 11 Jul 2023 18:56:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R116S2Y4CzVjZf;
        Wed, 12 Jul 2023 09:55:44 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:56:56 +0800
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
CC:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
 <74f1906e-fe58-c745-a851-b160374f7acf@redhat.com>
 <30b1f809-a11b-efe8-289c-04a801f20207@huawei.com>
 <tebnrmbl6ouz567vlalojcynk25siwwom7et7yn2vvi6zyv6nv@jj3r5o3kl52j>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7233195b-63bc-ff1a-3b14-6eca0db7cc25@huawei.com>
Date:   Wed, 12 Jul 2023 09:56:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <tebnrmbl6ouz567vlalojcynk25siwwom7et7yn2vvi6zyv6nv@jj3r5o3kl52j>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/7/11 19:52, Michal Koutný wrote:
> On Tue, Jul 11, 2023 at 10:52:02AM +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:
>> commit 2bdfd2825c9662463371e6691b1a794e97fa36b4
>> Author: Waiman Long <longman@redhat.com>
>> Date:   Wed Feb 2 22:31:03 2022 -0500
>>
>>     cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning
> 
> Aha, thanks for the pointer.
> 
> I've also found a paragraph in [1]:
>> In addition, the -rt patchset turns spinlocks into a sleeping locks so
>> that the corresponding critical sections can be preempted, which also
>> means that these sleeplockified spinlocks (but not other sleeping
>> locks!) may be acquire within -rt-Linux-kernel RCU read-side critical
>> sections.
> 
> That suggests (together with practical use) that dicussed spinlocks
> should be fine in RCU read section. And the possible reason is deeper in
> generate_sched_domains() that do kmalloc(..., GFP_KERNEL).

update_parent_subparts_cpumask() would call update_flag() that do kmemdup(..., GFP_KERNEL)?

> 
> Alas update_cpumask_hier() still calls generate_sched_domains(), OTOH,
> update_parent_subparts_cpumask() doesn't seem so.

It seems update_parent_subparts_cpumask() doesn't call generate_sched_domains().

> 
> The idea to not relieve rcu_read_lock() in update_cpumask() iteration
> (instead of the technically unneeded refcnt bump) would have to be
> verified with CONFIG_PROVE_RCU && CONFIG_LOCKDEP. WDYT?

The idea to relieve rcu_read_lock() in update_cpumask() iteration was initially introduced
via the below commit:

commit d7c8142d5a5534c3c7de214e35a40a493a32b98e
Author: Waiman Long <longman@redhat.com>
Date:   Thu Sep 1 16:57:43 2022 -0400

    cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule

    Currently, changes in "cpust.cpus" of a partition root is not allowed if
    it violates the sibling cpu exclusivity rule when the check is done
    in the validate_change() function. That is inconsistent with the
    other cpuset changes that are always allowed but may make a partition
    invalid.

    Update the cpuset code to allow cpumask change even if it violates the
    sibling cpu exclusivity rule, but invalidate the partition instead
    just like the other changes. However, other sibling partitions with
    conflicting cpumask will also be invalidated in order to not violating
    the exclusivity rule. This behavior is specific to this partition
    rule violation.

    Note that a previous commit has made sibling cpu exclusivity rule check
    the last check of validate_change(). So if -EINVAL is returned, we can
    be sure that sibling cpu exclusivity rule violation is the only rule
    that is broken.

It would be really helpful if @Waiman can figure this out.

Thanks both.

