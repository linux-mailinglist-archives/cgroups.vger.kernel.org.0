Return-Path: <cgroups+bounces-8911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB40B12845
	for <lists+cgroups@lfdr.de>; Sat, 26 Jul 2025 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F01567241
	for <lists+cgroups@lfdr.de>; Sat, 26 Jul 2025 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA5189F3F;
	Sat, 26 Jul 2025 00:52:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F02188713;
	Sat, 26 Jul 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491177; cv=none; b=Vv9dDKpvoWwV12iyI0SvmzvAr7BK0EH8F84gaqr5idZbKmUEB/AOx1G0FAGEJCaQUTSYile6ykplIKQscP0Tsqhs7/PTkDRkWvt2NySzeoK+CSU3Aw7eJxNeBTiAIJUHrAZaHKUythMlg+jSW2oZtgM3jbb6dylBqj/ke5D1LVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491177; c=relaxed/simple;
	bh=It3v84FvEyIgsN41q1wzPslZzCABIVQHro6nB6+wysg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8eiunU64r9DT9zpdsJDOOB74SE3wqdJH4Zw8LG88GkOVekda/qbG1eq2c5b3dtbdNZ9bRUO34nwdxRCsOiTzQlezfyX79NrYUosdoAIFni+xuJkdvzTx+DOaMQPbm2uUF4dpLgqR+iytRhUqDcmr5wME26kdvcnnWbHbEr/XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bpmRz5MLVzKHMZB;
	Sat, 26 Jul 2025 08:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8696E1A0E8D;
	Sat, 26 Jul 2025 08:52:46 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDnpbHdJoRo46HlBQ--.48129S2;
	Sat, 26 Jul 2025 08:52:46 +0800 (CST)
Message-ID: <179f706c-b04d-4fd5-b896-0abfc546528f@huaweicloud.com>
Date: Sat, 26 Jul 2025 08:52:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnpbHdJoRo46HlBQ--.48129S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4kWF1rKF43Kry3WF48WFg_yoW7WF4rpF
	s8A3WayF4rtrWYkw1kta4jga4F9a1Ivw4UXw13Ww4IyrnxWas2qF4Iyry5ZFW5Ars7C3WI
	yF4Fvwn7u34YyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/26 1:17, Michal Koutný wrote:
> On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> CPU0                            CPU1
>>>> mount perf_event                umount net_prio
>>>> cgroup1_get_tree                cgroup_kill_sb
>>>> rebind_subsystems               // root destruction enqueues
>>>> 				// cgroup_destroy_wq
>>>> // kill all perf_event css
>>>>                                 // one perf_event css A is dying
>>>>                                 // css A offline enqueues cgroup_destroy_wq
>>>>                                 // root destruction will be executed first
>>>>                                 css_free_rwork_fn
>>>>                                 cgroup_destroy_root
>>>>                                 cgroup_lock_and_drain_offline
>>>>                                 // some perf descendants are dying
>>>>                                 // cgroup_destroy_wq max_active = 1
>>>>                                 // waiting for css A to die
>>>>
>>>> Problem scenario:
>>>> 1. CPU0 mounts perf_event (rebind_subsystems)
>>>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>>>> 3. A dying perf_event CSS gets queued for offline after root destruction
>>>> 4. Root destruction waits for offline completion, but offline work is
>>>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
>>>
>>> What's concerning me is why umount of net_prio hierarhy waits for
>>> draining of the default hierachy? (Where you then run into conflict with
>>> perf_event that's implicit_on_dfl.)
>>>
>>
>> This was also first respond.
>>
>>> IOW why not this:
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
>>>
>>>         trace_cgroup_destroy_root(root);
>>>
>>> -       cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
>>> +       cgroup_lock_and_drain_offline(cgrp);
>>>
>>>         BUG_ON(atomic_read(&root->nr_cgrps));
>>>         BUG_ON(!list_empty(&cgrp->self.children));
>>>
>>> Does this correct the LTP scenario?
>>>
>>> Thanks,
>>> Michal
>>
>> I've tested this approach and discovered it can lead to another issue that required significant
>> investigation. This helped me understand why unmounting the net_prio hierarchy needs to wait for
>> draining of the default hierarchy.
>>
>> Consider this sequence:
>>
>> mount net_prio			umount perf_event
>> cgroup1_get_tree
>> // &cgrp_dfl_root.cgrp
>> cgroup_lock_and_drain_offline
>> // wait for all perf_event csses dead
>> prepare_to_wait(&dsct->offline_waitq)
>> schedule();
>> 				cgroup_destroy_root
>> 				// &root->cgrp, not cgrp_dfl_root
>> 				cgroup_lock_and_drain_offline
> 								perf_event's css (offline but dying)
> 
>> 				rebind_subsystems
>> 				rcu_assign_pointer(dcgrp->subsys[ssid], css);
>> 				dst_root->subsys_mask |= 1 << ssid;
>> 				cgroup_propagate_control
>> 				// enable cgrp_dfl_root perf_event css
>> 				cgroup_apply_control_enable
>> 				css = cgroup_css(dsct, ss);
>> 				// since we drain root->cgrp not cgrp_dfl_root
>> 				// css(dying) is not null on the cgrp_dfl_root
>> 				// we won't create css, but the css is dying
> 
> 				What would prevent seeing a dying css when
> 				cgrp_dfl_root is drained?
> 				(Or nothing drained as in the patch?)

> 				I assume you've seen this warning from
> 				cgroup_apply_control_enable
> 				WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt)); ?
>
> 
				WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt)); ?
				-- Yes
				Draining the cgrp_dfl_root can prevent seeing the dying css.
				Q:When the task can be woken up if it is waiting on offline_waitq?
				A:The offline_css is invoked, and:
				RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);

				If we drain the cgrp_dfl_root, it traverses all the csses
				That means cgroup_lock_and_drain_offline can only return when all
				the dying have disappeared, thus preventing seeing a dying css.
>> 								
>> // got the offline_waitq wake up
>> goto restart;
>> // some perf_event dying csses are online now
>> prepare_to_wait(&dsct->offline_waitq)
>> schedule();
>> // never get the offline_waitq wake up
>>
>> I encountered two main issues:
>> 1.Dying csses on cgrp_dfl_root may be brought back online when rebinding the subsystem to cgrp_dfl_root
> 
> Is this really resolved by the patch? (The questions above.)
> 
>> 2.Potential hangs during cgrp_dfl_root draining in the mounting process
> 
> Fortunately, the typical use case (mounting at boot) wouldn't suffer
> from this.
> 
>> I believe waiting for a wake-up in cgroup_destroy_wq is inherently risky, as it requires that
>> offline css work(the cgroup_destroy_root need to drain) cannot be enqueued after cgroup_destroy_root
>> begins.
> 
> This is a valid point.
> 
>> How can we guarantee this ordering? Therefore, I propose moving the draining operation
>> outside of cgroup_destroy_wq as a more robust solution that would completely eliminate this
>> potential race condition. This patch implements that approach.
> 
> I acknowledge the issue (although rare in real world). Some entity will
> always have to wait of the offlining. It may be OK in cgroup_kill_sb
> (ideally, if this was bound to process context of umount caller, not
> sure if that's how kill_sb works).
> I slightly dislike the form of an empty lock/unlock -- which makes me
> wonder if this is the best solution.

Thank you, I’d appreciate it if you could suggest a better solution.

Thanks,
Ridong


