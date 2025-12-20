Return-Path: <cgroups+bounces-12551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DCCD2CB3
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C76B13010E54
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32F3009F7;
	Sat, 20 Dec 2025 09:57:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70C279DA6
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224634; cv=none; b=ZcChGYJ1RZMVkj49QhzbKk3Jpi3YaT1nTfR8nJE76JpwyTWm4+Aa73ETmfS5xi3/U9yoWBapt8Mz4JURli0siNeZPdhJ6BESB5USIG9KouSqDc4vMpBH71MkWZD69eLDFPz8dfiDPwDTqmWy+FAZ32VAOh7zkLONOocWbvyi+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224634; c=relaxed/simple;
	bh=xFiqypgQnBHJjZXKE9H4Su3KLUlWqam3jMxsIQA3H90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLCnaztWJJbgBwiqKw8/pkCy+sWl89HPc95BAtum2LTcZgEGTSYPVBdRSB6gdcU+txNyvTnGUweqcyTvogERebkERTL8dFrPllDcSIhmFtT0wVDqjSFLhrumVGBxuT/CxzJPdmF1AfKQWhxLBn9QlJU6BnVdyrWT9dpslIA93nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYKYd4F3mzYQtjd
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 17:56:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 53B9940573
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 17:57:09 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB32PjzckZp8QlhAw--.43249S2;
	Sat, 20 Dec 2025 17:57:09 +0800 (CST)
Message-ID: <9a442808-ed53-4657-988b-882cc0014c0d@huaweicloud.com>
Date: Sat, 20 Dec 2025 17:57:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] cpuset: separate generate_sched_domains for v1 and
 v2
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Chen Ridong <chenridong@huawei.com>, Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org
References: <aUZhZUHHDsMpBwIw@stanley.mountain>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aUZhZUHHDsMpBwIw@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32PjzckZp8QlhAw--.43249S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3KrW5tFWUAry5uFyUKFg_yoW7JF48pF
	W09FWjvFWDtw1UG3yF93Wku34a9wnrJa1Ut3WFq3yFvF47tF1xCFyxZanxC3s8ur1qkr47
	uFZFqwsxWa1qgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/20 16:42, Dan Carpenter wrote:
> Hello Chen Ridong,
> 
> Commit 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1
> and v2") from Dec 18, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	kernel/cgroup/cpuset-v1.c:641 cpuset1_generate_sched_domains()
> 	warn: duplicate check 'root_load_balance' (previous on line 618)
> 
> kernel/cgroup/cpuset-v1.c
>     596 int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>     597                         struct sched_domain_attr **attributes)
>     598 {
>     599         struct cpuset *cp;        /* top-down scan of cpusets */
>     600         struct cpuset **csa;        /* array of all cpuset ptrs */
>     601         int csn;                /* how many cpuset ptrs in csa so far */
>     602         int i, j;                /* indices for partition finding loops */
>     603         cpumask_var_t *doms;        /* resulting partition; i.e. sched domains */
>     604         struct sched_domain_attr *dattr;  /* attributes for custom domains */
>     605         int ndoms = 0;                /* number of sched domains in result */
>     606         int nslot;                /* next empty doms[] struct cpumask slot */
>     607         struct cgroup_subsys_state *pos_css;
>     608         bool root_load_balance = is_sched_load_balance(&top_cpuset);
>     609         int nslot_update;
>     610 
>     611         lockdep_assert_cpuset_lock_held();
>     612 
>     613         doms = NULL;
>     614         dattr = NULL;
>     615         csa = NULL;
>     616 
>     617         /* Special case for the 99% of systems with one, full, sched domain */
>     618         if (root_load_balance) {
>     619                 ndoms = 1;
>     620                 doms = alloc_sched_domains(ndoms);
>     621                 if (!doms)
>     622                         goto done;
>     623 
>     624                 dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>     625                 if (dattr) {
>     626                         *dattr = SD_ATTR_INIT;
>     627                         update_domain_attr_tree(dattr, &top_cpuset);
>     628                 }
>     629                 cpumask_and(doms[0], top_cpuset.effective_cpus,
>     630                             housekeeping_cpumask(HK_TYPE_DOMAIN));
>     631 
>     632                 goto done;
> 
> If root_load_balance is true we are done.
> 
>     633         }
>     634 
>     635         csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>     636         if (!csa)
>     637                 goto done;
>     638         csn = 0;
>     639 
>     640         rcu_read_lock();
> --> 641         if (root_load_balance)
>     642                 csa[csn++] = &top_cpuset;
> 
> Dead code.
> 

Thank you for pointing this out.

You're correct that this can be safely removed. I'll make the fix.

>     643         cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>     644                 if (cp == &top_cpuset)
>     645                         continue;
>     646 
>     647                 /*
>     648                  * Continue traversing beyond @cp iff @cp has some CPUs and
>     649                  * isn't load balancing.  The former is obvious.  The
>     650                  * latter: All child cpusets contain a subset of the
>     651                  * parent's cpus, so just skip them, and then we call
>     652                  * update_domain_attr_tree() to calc relax_domain_level of
>     653                  * the corresponding sched domain.
>     654                  */
>     655                 if (!cpumask_empty(cp->cpus_allowed) &&
>     656                     !(is_sched_load_balance(cp) &&
>     657                       cpumask_intersects(cp->cpus_allowed,
>     658                                          housekeeping_cpumask(HK_TYPE_DOMAIN))))
>     659                         continue;
>     660 
>     661                 if (is_sched_load_balance(cp) &&
>     662                     !cpumask_empty(cp->effective_cpus))
>     663                         csa[csn++] = cp;
>     664 
>     665                 /* skip @cp's subtree */
>     666                 pos_css = css_rightmost_descendant(pos_css);
>     667                 continue;
>     668         }
>     669         rcu_read_unlock();
>     670 
>     671         for (i = 0; i < csn; i++)
>     672                 uf_node_init(&csa[i]->node);
>     673 
>     674         /* Merge overlapping cpusets */
>     675         for (i = 0; i < csn; i++) {
>     676                 for (j = i + 1; j < csn; j++) {
>     677                         if (cpusets_overlap(csa[i], csa[j]))
>     678                                 uf_union(&csa[i]->node, &csa[j]->node);
>     679                 }
>     680         }
>     681 
>     682         /* Count the total number of domains */
>     683         for (i = 0; i < csn; i++) {
>     684                 if (uf_find(&csa[i]->node) == &csa[i]->node)
>     685                         ndoms++;
>     686         }
>     687 
>     688         /*
>     689          * Now we know how many domains to create.
>     690          * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
>     691          */
>     692         doms = alloc_sched_domains(ndoms);
>     693         if (!doms)
>     694                 goto done;
>     695 
>     696         /*
>     697          * The rest of the code, including the scheduler, can deal with
>     698          * dattr==NULL case. No need to abort if alloc fails.
>     699          */
>     700         dattr = kmalloc_array(ndoms, sizeof(struct sched_domain_attr),
>     701                               GFP_KERNEL);
>     702 
>     703         for (nslot = 0, i = 0; i < csn; i++) {
>     704                 nslot_update = 0;
>     705                 for (j = i; j < csn; j++) {
>     706                         if (uf_find(&csa[j]->node) == &csa[i]->node) {
>     707                                 struct cpumask *dp = doms[nslot];
>     708 
>     709                                 if (i == j) {
>     710                                         nslot_update = 1;
>     711                                         cpumask_clear(dp);
>     712                                         if (dattr)
>     713                                                 *(dattr + nslot) = SD_ATTR_INIT;
>     714                                 }
>     715                                 cpumask_or(dp, dp, csa[j]->effective_cpus);
>     716                                 cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
>     717                                 if (dattr)
>     718                                         update_domain_attr_tree(dattr + nslot, csa[j]);
>     719                         }
>     720                 }
>     721                 if (nslot_update)
>     722                         nslot++;
>     723         }
>     724         BUG_ON(nslot != ndoms);
>     725 
>     726 done:
>     727         kfree(csa);
>     728 
>     729         /*
>     730          * Fallback to the default domain if kmalloc() failed.
>     731          * See comments in partition_sched_domains().
>     732          */
>     733         if (doms == NULL)
>     734                 ndoms = 1;
>     735 
>     736         *domains    = doms;
>     737         *attributes = dattr;
>     738         return ndoms;
>     739 }
> 
> 

-- 
Best regards,
Ridong


