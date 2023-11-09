Return-Path: <cgroups+bounces-268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DE7E66DB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84FC1C20ACE
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122B134A2;
	Thu,  9 Nov 2023 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C812B6A;
	Thu,  9 Nov 2023 09:33:21 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7902590;
	Thu,  9 Nov 2023 01:33:20 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SQxb02Mlgz4f3mLP;
	Thu,  9 Nov 2023 17:33:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7068C1A0181;
	Thu,  9 Nov 2023 17:33:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCn9gxZp0xlvGHKAQ--.14156S2;
	Thu, 09 Nov 2023 17:33:17 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 05/11] cgroup: Add a new helper for cgroup1
 hierarchy
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
 mkoutny@suse.com, sinquersw@gmail.com, longman@redhat.com
Cc: cgroups@vger.kernel.org, bpf@vger.kernel.org, oliver.sang@intel.com
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-6-laoar.shao@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <98fbeaf4-4c40-cca7-feb4-d91efbf4166b@huaweicloud.com>
Date: Thu, 9 Nov 2023 17:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231029061438.4215-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCn9gxZp0xlvGHKAQ--.14156S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15ZFyxKw4DCF43JFyUGFg_yoWrJw17pF
	yDA345tw45Ar12gr1Sk34jvryfW3yvqw4UK347Gr48Ar13t342qr1kur1UXr1FvFZ2g3W7
	Xr4YvryIkw1UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/29/2023 2:14 PM, Yafang Shao wrote:
> A new helper is added for cgroup1 hierarchy:
>
> - task_get_cgroup1
>   Acquires the associated cgroup of a task within a specific cgroup1
>   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
>
> This helper function is added to facilitate the tracing of tasks within
> a particular container or cgroup dir in BPF programs. It's important to
> note that this helper is designed specifically for cgroup1 only.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/cgroup.h          |  4 +++-
>  kernel/cgroup/cgroup-internal.h |  1 -
>  kernel/cgroup/cgroup-v1.c       | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b307013..e063e4c 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -71,6 +71,7 @@ struct css_task_iter {
>  extern struct file_system_type cgroup_fs_type;
>  extern struct cgroup_root cgrp_dfl_root;
>  extern struct css_set init_css_set;
> +extern spinlock_t css_set_lock;
>  
>  #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
>  #include <linux/cgroup_subsys.h>
> @@ -388,7 +389,6 @@ static inline void cgroup_unlock(void)
>   * as locks used during the cgroup_subsys::attach() methods.
>   */
>  #ifdef CONFIG_PROVE_RCU
> -extern spinlock_t css_set_lock;
>  #define task_css_set_check(task, __c)					\
>  	rcu_dereference_check((task)->cgroups,				\
>  		rcu_read_lock_sched_held() ||				\
> @@ -855,4 +855,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>  
>  #endif /* CONFIG_CGROUP_BPF */
>  
> +struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
> +
>  #endif /* _LINUX_CGROUP_H */
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 5e17f01..520b90d 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -164,7 +164,6 @@ struct cgroup_mgctx {
>  #define DEFINE_CGROUP_MGCTX(name)						\
>  	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
>  
> -extern spinlock_t css_set_lock;
>  extern struct cgroup_subsys *cgroup_subsys[];
>  extern struct list_head cgroup_roots;
>  
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index c487ffe..f41767f 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -1263,6 +1263,39 @@ int cgroup1_get_tree(struct fs_context *fc)
>  	return ret;
>  }
>  
> +/**
> + * task_get_cgroup1 - Acquires the associated cgroup of a task within a
> + * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
> + * hierarchy ID.
> + * @tsk: The target task
> + * @hierarchy_id: The ID of a cgroup1 hierarchy
> + *
> + * On success, the cgroup is returned. On failure, ERR_PTR is returned.
> + * We limit it to cgroup1 only.
> + */
> +struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
> +{
> +	struct cgroup *cgrp = ERR_PTR(-ENOENT);
> +	struct cgroup_root *root;
> +
> +	rcu_read_lock();
> +	for_each_root(root) {
> +		/* cgroup1 only*/
> +		if (root == &cgrp_dfl_root)
> +			continue;
> +		if (root->hierarchy_id != hierarchy_id)
> +			continue;
> +		spin_lock_irq(&css_set_lock);

Considering that the kfunc may be called under IRQ context, should we
use spin_lock_irqsave instead ?
> +		cgrp = task_cgroup_from_root(tsk, root);
> +		if (!cgrp || !cgroup_tryget(cgrp))
> +			cgrp = ERR_PTR(-ENOENT);
> +		spin_unlock_irq(&css_set_lock);
> +		break;
> +	}
> +	rcu_read_unlock();
> +	return cgrp;
> +}
> +
>  static int __init cgroup1_wq_init(void)
>  {
>  	/*


