Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5F190D69
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 13:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCXMa4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 24 Mar 2020 08:30:56 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55097 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbgCXMa4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 08:30:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TtWSYmA_1585053034;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TtWSYmA_1585053034)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Mar 2020 20:30:43 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200324110034.GH19542@dhcp22.suse.cz>
Date:   Tue, 24 Mar 2020 20:30:32 +0800
Cc:     Hui Zhu <teawater@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, chris@chrisdown.name,
        tj@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <816B70EC-20AD-4BB8-AD13-4F5640EBAB35@linux.alibaba.com>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
 <20200324110034.GH19542@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 2020年3月24日 19:00，Michal Hocko <mhocko@kernel.org> 写道：
> 
> On Tue 24-03-20 18:31:56, Hui Zhu wrote:
>> /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
>> control if the application can use THP in system level.
>> Sometime, we would not want an application use THP even if
>> transparent_hugepage/enabled is set to "always" or "madvise" because
>> thp may need more cpu and memory resources in some cases.
> 
> Could you specify that sometime by a real usecase in the memcg context
> please?


Thanks for your review.

We use thp+balloon to supply more memory flexibility for vm.
https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
This is another thread that I am working around thp+balloon.

Other applications are already deployed on these machines.  The transparent_hugepage/enabled is set to never because they used to have a lot of THP related performance issues.
And some of them may call madvise thp with itself.

Then even if I set transparent_hugepage/enabled to madvise.  These programs are still at risk of THP-related performance issues.  That is why I need this cgroup thp switch.

> 
>> This commit add a new interface memory.transparent_hugepage_disabled
>> in memcg.
>> When it set to 1, the application inside the cgroup cannot use THP
>> except dax.
> 
> Why should this interface differ from the global semantic. How does it
> relate to the kcompactd. Your patch also doesn't seem to define this
> knob to have hierarchical semantic. Why?
> 

According to my previous description, I didn’t get any need to add transparent_hugepage/enabled like interface.
That is why just add a switch.

What about add a transparent_hugepage/enabled like interface?

Thanks,
Hui

> All that being said, this patch is lacking both proper justification and
> the semantic is dubious to be honest. I have also say that I am not a
> great fan. THP semantic is overly complex already and adding more on top
> would require really strong usecase.
> 
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>> include/linux/huge_mm.h    | 18 ++++++++++++++++--
>> include/linux/memcontrol.h |  2 ++
>> mm/memcontrol.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
>> mm/shmem.c                 |  4 ++++
>> 4 files changed, 64 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 5aca3d1..fd81479 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -91,6 +91,16 @@ extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
>> 
>> extern unsigned long transparent_hugepage_flags;
>> 
>> +#ifdef CONFIG_MEMCG
>> +extern bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma);
>> +#else
>> +static inline bool
>> +memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>> /*
>>  * to be used on vmas which are known to support THP.
>>  * Use transparent_hugepage_enabled otherwise
>> @@ -106,8 +116,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>> 	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> 		return false;
>> 
>> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>> -		return true;
>> 	/*
>> 	 * For dax vmas, try to always use hugepage mappings. If the kernel does
>> 	 * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
>> @@ -117,6 +125,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>> 	if (vma_is_dax(vma))
>> 		return true;
>> 
>> +	if (memcg_transparent_hugepage_disabled(vma))
>> +		return false;
>> +
>> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>> +		return true;
>> +
>> 	if (transparent_hugepage_flags &
>> 				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
>> 		return !!(vma->vm_flags & VM_HUGEPAGE);
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index a7a0a1a5..abc3142 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -320,6 +320,8 @@ struct mem_cgroup {
>> 
>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> 	struct deferred_split deferred_split_queue;
>> +
>> +	bool transparent_hugepage_disabled;
>> #endif
>> 
>> 	struct mem_cgroup_per_node *nodeinfo[0];
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 7a4bd8b..b6d91b6 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5011,6 +5011,14 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>> 	if (parent) {
>> 		memcg->swappiness = mem_cgroup_swappiness(parent);
>> 		memcg->oom_kill_disable = parent->oom_kill_disable;
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +		memcg->transparent_hugepage_disabled
>> +			= parent->transparent_hugepage_disabled;
>> +#endif
>> +	} else {
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +		memcg->transparent_hugepage_disabled = false;
>> +#endif
>> 	}
>> 	if (parent && parent->use_hierarchy) {
>> 		memcg->use_hierarchy = true;
>> @@ -6126,6 +6134,24 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>> 	return nbytes;
>> }
>> 
>> +static u64 transparent_hugepage_disabled_read(struct cgroup_subsys_state *css,
>> +					      struct cftype *cft)
>> +{
>> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +	return memcg->transparent_hugepage_disabled;
>> +}
>> +
>> +static int transparent_hugepage_disabled_write(struct cgroup_subsys_state *css,
>> +					       struct cftype *cft, u64 val)
>> +{
>> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +	memcg->transparent_hugepage_disabled = !!val;
>> +
>> +	return 0;
>> +}
>> +
>> static struct cftype memory_files[] = {
>> 	{
>> 		.name = "current",
>> @@ -6179,6 +6205,12 @@ static struct cftype memory_files[] = {
>> 		.seq_show = memory_oom_group_show,
>> 		.write = memory_oom_group_write,
>> 	},
>> +	{
>> +		.name = "transparent_hugepage_disabled",
>> +		.flags = CFTYPE_NOT_ON_ROOT,
>> +		.read_u64 = transparent_hugepage_disabled_read,
>> +		.write_u64 = transparent_hugepage_disabled_write,
>> +	},
>> 	{ }	/* terminate */
>> };
>> 
>> @@ -6787,6 +6819,16 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>> 	refill_stock(memcg, nr_pages);
>> }
>> 
>> +bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
>> +{
>> +	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
>> +
>> +	if (memcg && memcg->transparent_hugepage_disabled)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> static int __init cgroup_memory(char *s)
>> {
>> 	char *token;
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index aad3ba7..253b63b 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1810,6 +1810,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>> 		goto alloc_nohuge;
>> 	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
>> 		goto alloc_nohuge;
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	if (memcg_transparent_hugepage_disabled(vma))
>> +		goto alloc_nohuge;
>> +#endif
>> 	if (shmem_huge == SHMEM_HUGE_FORCE)
>> 		goto alloc_huge;
>> 	switch (sbinfo->huge) {
>> -- 
>> 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs

