Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F071FBAD
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjFBIPp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 04:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjFBIPp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 04:15:45 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE699;
        Fri,  2 Jun 2023 01:15:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QXbRH3N09z4f3nTP;
        Fri,  2 Jun 2023 16:15:39 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
        by APP1 (Coremail) with SMTP id cCh0CgD3UBsrpXlkZ5KVKA--.44759S2;
        Fri, 02 Jun 2023 16:15:40 +0800 (CST)
Message-ID: <92671ed7-ca4f-48e4-f29d-a42860f93d89@huaweicloud.com>
Date:   Fri, 2 Jun 2023 16:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cgroup: Stop task iteration when rebinding subsystem
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuigaosheng1@huawei.com
References: <20230526114139.70274-1-xiujianfeng@huaweicloud.com>
 <ojymhf4m3p52py6sezwbc2zamxm46wmhxs577uucima6evj2sc@djoi3dhzbdf6>
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <ojymhf4m3p52py6sezwbc2zamxm46wmhxs577uucima6evj2sc@djoi3dhzbdf6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgD3UBsrpXlkZ5KVKA--.44759S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyUAF48ZF43ZrWUuF4DArb_yoWrGw48pF
        y5ZrZxtrs5Zw4jgr4fKa4qqayF9rWvgw4UGrW5J3ySywnrAFyxWr4Ikw13uF4SyFZrGwsx
        KF4j9ry5uw1qqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On 2023/6/2 1:33, Michal Koutný wrote:
> Hello Jianfeng.
> 
> On Fri, May 26, 2023 at 07:41:39PM +0800, Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
>> The race that cause this bug can be shown as below:
>>
>> (hotplug cpu)                | (umount cpuset)
>> mutex_lock(&cpuset_mutex)    | mutex_lock(&cgroup_mutex)
>> cpuset_hotplug_workfn        |
>>  rebuild_root_domains        |  rebind_subsystems
>>   update_tasks_root_domain   |   spin_lock_irq(&css_set_lock)
>>    css_task_iter_start       |    list_move_tail(&cset->e_cset_node[ss->id]
>>    while(css_task_iter_next) |                  &dcgrp->e_csets[ss->id]);
>>    css_task_iter_end         |   spin_unlock_irq(&css_set_lock)
>> mutex_unlock(&cpuset_mutex)  | mutex_unlock(&cgroup_mutex)
> 
> Good catch!
> 
>>
>> Inside css_task_iter_start/next/end, css_set_lock is hold and then
>> released, so when iterating task(left side), the css_set may be moved to
>> another list(right side), then it->cset_head points to the old list head
>> and it->cset_pos->next points to the head node of new list, which can't
>> be used as struct css_set.
> 
> I find your analysis sane -- the stale it->cset_head is problematic.
> 
>> To fix this issue, introduce CSS_TASK_ITER_STOPPED flag for css_task_iter.
>> when moving css_set to dcgrp->e_csets[ss->id] in rebind_subsystems(), stop
>> the task iteration.
> 
> Does it mean that iteration would not yield all tasks that are
> associated with give cs->css? That sounds like broken correctness of the
> iterator.
> 
> I may suggest a slightly different approach that should not affect
> running iterators.
> - I had to switch from all css_sets to only scgrp's css_sets since
>   css_set_table order of css_sets may be different than scgrp->e_csets
> - Not sure how portable is using array element as a `member` argument of
>   offsetof (in expansion of list_for_each_entry_safe).
> 
> This is only to illustrate the idea, i.e. merely compile tested.
> 
> WDYT?

Yes, I think this approach is better for it doesn't affect the running
iterators, and we have tested it, it can solve this issue, thank you.

So if maintainers agree, I would send a v2.

> 
> Regards,
> Michal
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..e67d2a0776c1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1798,7 +1798,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  {
>  	struct cgroup *dcgrp = &dst_root->cgrp;
>  	struct cgroup_subsys *ss;
> -	int ssid, i, ret;
> +	int ssid, ret;
>  	u16 dfl_disable_ss_mask = 0;
>  
>  	lockdep_assert_held(&cgroup_mutex);
> @@ -1842,7 +1842,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  		struct cgroup_root *src_root = ss->root;
>  		struct cgroup *scgrp = &src_root->cgrp;
>  		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
> -		struct css_set *cset;
> +		struct css_set *cset, *cset_pos;
> +		struct css_task_iter *it;
>  
>  		WARN_ON(!css || cgroup_css(dcgrp, ss));
>  
> @@ -1860,9 +1861,18 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>  		css->cgroup = dcgrp;
>  
>  		spin_lock_irq(&css_set_lock);
> -		hash_for_each(css_set_table, i, cset, hlist)
> +		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
> +		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id], e_cset_node[ss->id]) {
>  			list_move_tail(&cset->e_cset_node[ss->id],
>  				       &dcgrp->e_csets[ss->id]);
> +			/* all css_sets of scgrp together in same order to dcgrp,
> +			 * patch in-flight iterators to preserve correct iteration,
> +			 * cset_head is under css_set_lock */
> +			list_for_each_entry(it, &cset->task_iters, iters_node) {
> +				if (it->cset_head == &scgrp->e_csets[ss->id])
> +					it->cset_head = &dcgrp->e_csets[ss->id];
> +			}
> +		}
>  		spin_unlock_irq(&css_set_lock);
>  
>  		if (ss->css_rstat_flush) {

