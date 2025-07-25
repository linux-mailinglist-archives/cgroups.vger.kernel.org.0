Return-Path: <cgroups+bounces-8904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BACB115F7
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 03:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0D3B0EF9
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0C1F473C;
	Fri, 25 Jul 2025 01:42:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A143ABC;
	Fri, 25 Jul 2025 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753407733; cv=none; b=hAlxeOWaBsOO41uUNR8SGPNjgZAu2takdmIHId7Xzypq5JAKV0nOxYVvqpTVy/CErbPExDQpqJukNPbnQvdh9iHhR5XLwTUVzOdVcTtG9/K4nY/hteyQ+XNfmcvTkuEldwuSgBJ/Su+h5Jgn1k/Se8Oxn7RzAhst3U+nY92gIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753407733; c=relaxed/simple;
	bh=dDHviIQONWxc/W6Bgu7MlVwadsOFY/p9+CHQfXL0yyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+zovY7GscBLBkhVJBInwzLXC5fHeHwX//OJCXCP1WqMjyGDjbXyt5TkkIYxtXOUfhy1AVdNPjjaMm1wDXSozO1ETUCjpNFElceVInyqjNoaQKMMa+i6/OR6pmR2zPeKwdSOVMXcALrWXr69YhGfmvxKDt47yAPX2E3XAD7AEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bp9bN5HzCzKHMhm;
	Fri, 25 Jul 2025 09:42:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7D4BC1A129D;
	Fri, 25 Jul 2025 09:42:07 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC3wrTu4IJoUryBBQ--.45808S2;
	Fri, 25 Jul 2025 09:42:07 +0800 (CST)
Message-ID: <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
Date: Fri, 25 Jul 2025 09:42:05 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3wrTu4IJoUryBBQ--.45808S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3uFWkXryUJry3Xw4Dtwb_yoWrGF1fpF
	s8Cw12ya1rJayYgrWkta4jga4F9an7Zw45tr17Ww4UJr13JasFqa1IyFyUZF15ArsrCa47
	ZF4Fvwn7Gw15t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/24 21:35, Michal Koutný wrote:
> Hi Ridong.
> 
> On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> CPU0                            CPU1
>> mount perf_event                umount net_prio
>> cgroup1_get_tree                cgroup_kill_sb
>> rebind_subsystems               // root destruction enqueues
>> 				// cgroup_destroy_wq
>> // kill all perf_event css
>>                                 // one perf_event css A is dying
>>                                 // css A offline enqueues cgroup_destroy_wq
>>                                 // root destruction will be executed first
>>                                 css_free_rwork_fn
>>                                 cgroup_destroy_root
>>                                 cgroup_lock_and_drain_offline
>>                                 // some perf descendants are dying
>>                                 // cgroup_destroy_wq max_active = 1
>>                                 // waiting for css A to die
>>
>> Problem scenario:
>> 1. CPU0 mounts perf_event (rebind_subsystems)
>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>> 3. A dying perf_event CSS gets queued for offline after root destruction
>> 4. Root destruction waits for offline completion, but offline work is
>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> 
> What's concerning me is why umount of net_prio hierarhy waits for
> draining of the default hierachy? (Where you then run into conflict with
> perf_event that's implicit_on_dfl.)
> 

This was also first respond.

> IOW why not this:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
> 
>         trace_cgroup_destroy_root(root);
> 
> -       cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
> +       cgroup_lock_and_drain_offline(cgrp);
> 
>         BUG_ON(atomic_read(&root->nr_cgrps));
>         BUG_ON(!list_empty(&cgrp->self.children));
> 
> Does this correct the LTP scenario?
> 
> Thanks,
> Michal

I've tested this approach and discovered it can lead to another issue that required significant
investigation. This helped me understand why unmounting the net_prio hierarchy needs to wait for
draining of the default hierarchy.

Consider this sequence:

mount net_prio			umount perf_event
cgroup1_get_tree
// &cgrp_dfl_root.cgrp
cgroup_lock_and_drain_offline
// wait for all perf_event csses dead
prepare_to_wait(&dsct->offline_waitq)
schedule();
				cgroup_destroy_root
				// &root->cgrp, not cgrp_dfl_root
				cgroup_lock_and_drain_offline
				rebind_subsystems
				rcu_assign_pointer(dcgrp->subsys[ssid], css);
				dst_root->subsys_mask |= 1 << ssid;
				cgroup_propagate_control
				// enable cgrp_dfl_root perf_event css
				cgroup_apply_control_enable
				css = cgroup_css(dsct, ss);
				// since we drain root->cgrp not cgrp_dfl_root
				// css(dying) is not null on the cgrp_dfl_root
				// we won't create css, but the css is dying
								
// got the offline_waitq wake up
goto restart;
// some perf_event dying csses are online now
prepare_to_wait(&dsct->offline_waitq)
schedule();
// never get the offline_waitq wake up

I encountered two main issues:
1.Dying csses on cgrp_dfl_root may be brought back online when rebinding the subsystem to cgrp_dfl_root
2.Potential hangs during cgrp_dfl_root draining in the mounting process

I have tried calling  cgroup_lock_and_drain_offline with the subtree_ss_mask, It seems that can fix
this issue I encountered. But I am not sure there are scenarios [u]mounting mutil legacy subsystem
in the same time.

I believe waiting for a wake-up in cgroup_destroy_wq is inherently risky, as it requires that
offline css work(the cgroup_destroy_root need to drain) cannot be enqueued after cgroup_destroy_root
begins. How can we guarantee this ordering? Therefore, I propose moving the draining operation
outside of cgroup_destroy_wq as a more robust solution that would completely eliminate this
potential race condition. This patch implements that approach.

Best regards,
Ridong


