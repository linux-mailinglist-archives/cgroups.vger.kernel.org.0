Return-Path: <cgroups+bounces-9316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEEB30A74
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3590B7A6B09
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8E74040;
	Fri, 22 Aug 2025 00:44:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D6322E;
	Fri, 22 Aug 2025 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823472; cv=none; b=OlkG5LR5rr2jSde4xDCVk81Mbe1lOTkrHKnDbFPI9ky5/sTmHfhmOSLkIM8FsuUdNAC/S+bwzw5hf5Dp6LARCRedtuCPwmFLnVqQbSxJhltGVtAngivY4TwTVToR/TGC6KZZuasFClfynGRHl7DB1qF4l4vlDDcyybBoE+KiYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823472; c=relaxed/simple;
	bh=4bAqoNnwtkNqRPibZoBnmegFZeUogXBnjmnK73xRKKs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KX9x+7fXP5tonJWWckP/eGzHYs2PQtgPVAU12IrCztgAwf1+rFhy9tZYsg0jH3QvtnTD7pwEcw2rtx9G7yM/gde40jD9L+EGsKCxiZt7jKyBVx/7aZje2qnSsCuc/BsauA3XcDFS9DUkuorSHX7pyTWPk1mBhO6VHkPLKw7hrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c7Lzt3KtqzYQvDw;
	Fri, 22 Aug 2025 08:44:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 094E71A0848;
	Fri, 22 Aug 2025 08:44:25 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBnJrhnvadoMOi3EQ--.53464S2;
	Fri, 22 Aug 2025 08:44:24 +0800 (CST)
Message-ID: <520204d0-583f-4310-90f7-8be931543e36@huaweicloud.com>
Date: Fri, 22 Aug 2025 08:44:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cgroup: split cgroup_destroy_wq into 3 workqueues
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com,
 gaoyingjie@uniontech.com
References: <aKNeF68tmjLKB6dK@slm.duckdns.org>
 <20250819010724.1338654-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250819010724.1338654-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnJrhnvadoMOi3EQ--.53464S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1rCF45Zw4Uur45AF15twb_yoWxCr1rpF
	s5Aw15ta1rGr4DG39avayjgFySgF4Fqw47WryxWwn8AF43Xryqq3WjyFyjvF98AF93u347
	ZF4YyrnxC34jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/19 9:07, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A hung task can occur during [1] LTP cgroup testing when repeatedly
> mounting/unmounting perf_event and net_prio controllers with
> systemd.unified_cgroup_hierarchy=1. The hang manifests in
> cgroup_lock_and_drain_offline() during root destruction.
> 
> Related case:
> cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
> cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio
> 
> Call Trace:
> 	cgroup_lock_and_drain_offline+0x14c/0x1e8
> 	cgroup_destroy_root+0x3c/0x2c0
> 	css_free_rwork_fn+0x248/0x338
> 	process_one_work+0x16c/0x3b8
> 	worker_thread+0x22c/0x3b0
> 	kthread+0xec/0x100
> 	ret_from_fork+0x10/0x20
> 
> Root Cause:
> 
> CPU0                            CPU1
> mount perf_event                umount net_prio
> cgroup1_get_tree                cgroup_kill_sb
> rebind_subsystems               // root destruction enqueues
> 				// cgroup_destroy_wq
> // kill all perf_event css
>                                 // one perf_event css A is dying
>                                 // css A offline enqueues cgroup_destroy_wq
>                                 // root destruction will be executed first
>                                 css_free_rwork_fn
>                                 cgroup_destroy_root
>                                 cgroup_lock_and_drain_offline
>                                 // some perf descendants are dying
>                                 // cgroup_destroy_wq max_active = 1
>                                 // waiting for css A to die
> 
> Problem scenario:
> 1. CPU0 mounts perf_event (rebind_subsystems)
> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
> 3. A dying perf_event CSS gets queued for offline after root destruction
> 4. Root destruction waits for offline completion, but offline work is
>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> 
> Solution:
> Split cgroup_destroy_wq into three dedicated workqueues:
> cgroup_offline_wq – Handles CSS offline operations
> cgroup_release_wq – Manages resource release
> cgroup_free_wq – Performs final memory deallocation
> 
> This separation eliminates blocking in the CSS free path while waiting for
> offline operations to complete.
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/runtest/controllers
> Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
> Reported-by: Gao Yingjie <gaoyingjie@uniontech.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Suggested-by: Teju Heo <tj@kernel.org>
> ---
>  kernel/cgroup/cgroup.c | 43 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..79b1d79f86a3 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -126,8 +126,31 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>   * of concurrent destructions.  Use a separate workqueue so that cgroup
>   * destruction work items don't end up filling up max_active of system_wq
>   * which may lead to deadlock.
> + *
> + * A cgroup destruction should enqueue work sequentially to:
> + * cgroup_offline_wq: use for css offline work
> + * cgroup_release_wq: use for css release work
> + * cgroup_free_wq: use for free work
> + *
> + * Rationale for using separate workqueues:
> + * The cgroup root free work may depend on completion of other css offline
> + * operations. If all tasks were enqueued to a single workqueue, this could
> + * create a deadlock scenario where:
> + * - Free work waits for other css offline work to complete.
> + * - But other css offline work is queued after free work in the same queue.
> + *
> + * Example deadlock scenario with single workqueue (cgroup_destroy_wq):
> + * 1. umount net_prio
> + * 2. net_prio root destruction enqueues work to cgroup_destroy_wq (CPUx)
> + * 3. perf_event CSS A offline enqueues work to same cgroup_destroy_wq (CPUx)
> + * 4. net_prio cgroup_destroy_root->cgroup_lock_and_drain_offline.
> + * 5. net_prio root destruction blocks waiting for perf_event CSS A offline,
> + *    which can never complete as it's behind in the same queue and
> + *    workqueue's max_active is 1.
>   */
> -static struct workqueue_struct *cgroup_destroy_wq;
> +static struct workqueue_struct *cgroup_offline_wq;
> +static struct workqueue_struct *cgroup_release_wq;
> +static struct workqueue_struct *cgroup_free_wq;
>  
>  /* generate an array of cgroup subsystem pointers */
>  #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,
> @@ -5558,7 +5581,7 @@ static void css_release_work_fn(struct work_struct *work)
>  	cgroup_unlock();
>  
>  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
> -	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> +	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
>  }
>  
>  static void css_release(struct percpu_ref *ref)
> @@ -5567,7 +5590,7 @@ static void css_release(struct percpu_ref *ref)
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
>  
>  	INIT_WORK(&css->destroy_work, css_release_work_fn);
> -	queue_work(cgroup_destroy_wq, &css->destroy_work);
> +	queue_work(cgroup_release_wq, &css->destroy_work);
>  }
>  
>  static void init_and_link_css(struct cgroup_subsys_state *css,
> @@ -5701,7 +5724,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>  	list_del_rcu(&css->sibling);
>  err_free_css:
>  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
> -	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> +	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
>  	return ERR_PTR(err);
>  }
>  
> @@ -5939,7 +5962,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
>  
>  	if (atomic_dec_and_test(&css->online_cnt)) {
>  		INIT_WORK(&css->destroy_work, css_killed_work_fn);
> -		queue_work(cgroup_destroy_wq, &css->destroy_work);
> +		queue_work(cgroup_offline_wq, &css->destroy_work);
>  	}
>  }
>  
> @@ -6325,8 +6348,14 @@ static int __init cgroup_wq_init(void)
>  	 * We would prefer to do this in cgroup_init() above, but that
>  	 * is called before init_workqueues(): so leave this until after.
>  	 */
> -	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);
> -	BUG_ON(!cgroup_destroy_wq);
> +	cgroup_offline_wq = alloc_workqueue("cgroup_offline", 0, 1);
> +	BUG_ON(!cgroup_offline_wq);
> +
> +	cgroup_release_wq = alloc_workqueue("cgroup_release", 0, 1);
> +	BUG_ON(!cgroup_release_wq);
> +
> +	cgroup_free_wq = alloc_workqueue("cgroup_free", 0, 1);
> +	BUG_ON(!cgroup_free_wq);
>  	return 0;
>  }
>  core_initcall(cgroup_wq_init);

Hi, Tj,

Just checking in on the v6 I sent here. I am not sure whether you miss it.

-- 
Best regards,
Ridong


