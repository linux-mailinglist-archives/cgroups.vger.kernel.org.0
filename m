Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B633EB631
	for <lists+cgroups@lfdr.de>; Fri, 13 Aug 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhHMNq2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Aug 2021 09:46:28 -0400
Received: from m32-153.88.com ([43.250.32.153]:63056 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240668AbhHMNqA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 13 Aug 2021 09:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=tAXVWm0idpsgfMdPUOxAxDYEFga7SVeTb9uhp
        GKFKzM=; b=lQbVvncA7iEB+zQ6ccliaknsrjdL06uRKVfj9Gv9uMLRMcO7X5p8E
        uYOqbEYheRS5BrEd7eAmJ/l9QVTn3YxhMzWv5P1gpT2i5hp+VtpzdvGkzCgXqaN4
        t6QUzVYfkthKK4u5W+5ifJkwtIDBvIoNwmkxHQUwS4brOQ3a/M+Tok=
Received: from [0.0.0.0] (unknown [113.251.11.184])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAnp6cZdxZh_L4uAA--.61173S3;
        Fri, 13 Aug 2021 21:43:55 +0800 (CST)
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     yongw.pur@gmail.com, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, tglx@linutronix.de, peterz@infradead.org,
        shakeelb@google.com, guro@fb.com, alexs@kernel.org,
        richard.weiyang@gmail.com, sh_def@163.com, sfr@canb.auug.org.au,
        wang.yong12@zte.com.cn, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.yang29@zte.com.cn
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <7ca54e3d-b797-bcd1-8e3c-c66fa4e367e7@email.cn>
Date:   Fri, 13 Aug 2021 21:43:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgAnp6cZdxZh_L4uAA--.61173S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr47uFWDCFyUZr4kJr1xAFb_yoWDJrWxp3
        Z3JFWfKrn7tr9xGa13X3WjgF13Aw18GrW5Cr97G34xJ3ZIy34kXrnFvr18JFyDGFyfAa9r
        AFs0yr45Cw15ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLSdPUUUUU==
X-Originating-IP: [113.251.11.184]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2021/8/13 ÏÂÎç7:57, yongw.pur@gmail.com Ð´µÀ:
> From: wangyong <wang.yong12@zte.com.cn>
>
> Inspired by PSI features, vmpressure inotifier function should also be
> configured to decide whether it is used, because it is an independent
> feature which notifies the user of memory pressure.
>
> Since the vmpressure interface is used in kernel common code, for
> users who do not use the vmpressure function, there will be
> additional overhead.
>
> So we add configuration to control whether vmpressure notifier is
> enabled, and provide a boot parameter to use use vmpressure notifier
> flexibly
>
> Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst  |  3 ++-
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  include/linux/memcontrol.h                      |  2 ++
>  include/linux/vmpressure.h                      |  7 +++++--
>  init/Kconfig                                    | 20 +++++++++++++++++++
>  mm/Makefile                                     |  3 ++-
>  mm/memcontrol.c                                 |  7 ++++++-
>  mm/vmpressure.c                                 | 26 +++++++++++++++++++++++++
>  8 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 41191b5..967418a 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -388,6 +388,7 @@ a. Enable CONFIG_CGROUPS
>  b. Enable CONFIG_MEMCG
>  c. Enable CONFIG_MEMCG_SWAP (to use swap extension)
>  d. Enable CONFIG_MEMCG_KMEM (to use kmem extension)
> +e. Enable CONFIG_MEMCG_VMPRESSURE (to use vmpressure extension)
>  
>  3.1. Prepare the cgroups (see cgroups.txt, Why are cgroups needed?)
>  -------------------------------------------------------------------
> @@ -855,7 +856,7 @@ At reading, current status of OOM is shown.
>            The number of processes belonging to this cgroup killed by any
>            kind of OOM killer.
>  
> -11. Memory Pressure
> +11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
>  ===================
>  


Please replace:

11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
===================

with:

11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
=============================================

Cheers,
Hu Haowen


>  The pressure level notifications can be used to monitor the memory
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4042a82..d119fb8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6158,6 +6158,9 @@
>  	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
>  			Format: <command>
>  
> +	vmpressure=	[KNL] Enable or disable vmpressure notifier.
> +			Format: <bool>
> +
>  	vsyscall=	[X86-64]
>  			Controls the behavior of vsyscalls (i.e. calls to
>  			fixed addresses of 0xffffffffff600x00 from legacy
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0ff1464..b201d8e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -257,8 +257,10 @@ struct mem_cgroup {
>  
>  	unsigned long soft_limit;
>  
> +#ifdef CONFIG_MEMCG_VMPRESSURE
>  	/* vmpressure notifications */
>  	struct vmpressure vmpressure;
> +#endif
>  
>  	/*
>  	 * Should the OOM killer kill all belonging tasks, had it kill one?
> diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
> index 6a2f51e..dcae02e 100644
> --- a/include/linux/vmpressure.h
> +++ b/include/linux/vmpressure.h
> @@ -29,7 +29,8 @@ struct vmpressure {
>  
>  struct mem_cgroup;
>  
> -#ifdef CONFIG_MEMCG
> +#ifdef CONFIG_MEMCG_VMPRESSURE
> +extern bool vmpressure_enable;
>  extern void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		       unsigned long scanned, unsigned long reclaimed);
>  extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio);
> @@ -48,5 +49,7 @@ static inline void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  			      unsigned long scanned, unsigned long reclaimed) {}
>  static inline void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg,
>  				   int prio) {}
> -#endif /* CONFIG_MEMCG */
> +static inline void vmpressure_init(struct vmpressure *vmpr) {}
> +static inline void vmpressure_cleanup(struct vmpressure *vmpr) {}
> +#endif /* CONFIG_MEMCG_PRESSURE */
>  #endif /* __LINUX_VMPRESSURE_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 71a028d..d3afeb2 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -948,6 +948,26 @@ config MEMCG_KMEM
>  	depends on MEMCG && !SLOB
>  	default y
>  
> +config MEMCG_VMPRESSURE
> +	bool "Memory pressure notifier"
> +	depends on MEMCG
> +	default y
> +	help
> +	  Vmpressure extension is used to monitor the memory allocation cost.
> +	  The pressure level can be set according to the use scenario and
> +	  application will be notified through eventfd when memory pressure is at
> +	  the specific level (or higher).
> +
> +config VMPRESSURE_DEFAULT_DISABLED
> +	bool "Require boot parameter to enable memory pressure notifier"
> +	depends on MEMCG_VMPRESSURE
> +	default n
> +	help
> +	  If set, memory pressure notifier will be disabled  but can be
> +	  enabled through passing vmpressure=1 on the kernel commandline
> +	  during boot.
> +	  For those who want to use memory pressure notifier flexibly.
> +
>  config BLK_CGROUP
>  	bool "IO controller"
>  	depends on BLOCK
> diff --git a/mm/Makefile b/mm/Makefile
> index 970604e..e4f99c1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -92,7 +92,8 @@ obj-$(CONFIG_MEMTEST)		+= memtest.o
>  obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> -obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> +obj-$(CONFIG_MEMCG) += memcontrol.o
> +obj-$(CONFIG_MEMCG_VMPRESSURE) += vmpressure.o
>  obj-$(CONFIG_MEMCG_SWAP) += swap_cgroup.o
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3e7c205..ee060ae2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -248,6 +248,7 @@ static inline bool should_force_charge(void)
>  		(current->flags & PF_EXITING);
>  }
>  
> +#ifdef CONFIG_MEMCG_VMPRESSURE
>  /* Some nice accessors for the vmpressure. */
>  struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
>  {
> @@ -260,6 +261,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
>  {
>  	return container_of(vmpr, struct mem_cgroup, vmpressure);
>  }
> +#endif
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  extern spinlock_t css_set_lock;
> @@ -4794,9 +4796,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	} else if (!strcmp(name, "memory.oom_control")) {
>  		event->register_event = mem_cgroup_oom_register_event;
>  		event->unregister_event = mem_cgroup_oom_unregister_event;
> -	} else if (!strcmp(name, "memory.pressure_level")) {
> +#ifdef CONFIG_MEMCG_VMPRESSURE
> +	} else if (vmpressure_enable &&
> +		   !strcmp(name, "memory.pressure_level")) {
>  		event->register_event = vmpressure_register_event;
>  		event->unregister_event = vmpressure_unregister_event;
> +#endif
>  	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
>  		event->register_event = memsw_cgroup_usage_register_event;
>  		event->unregister_event = memsw_cgroup_usage_unregister_event;
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index 76518e4..b0d4358 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -67,6 +67,19 @@ static const unsigned int vmpressure_level_critical = 95;
>   */
>  static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
>  
> +DEFINE_STATIC_KEY_FALSE(vmpressure_disabled);
> +#ifdef CONFIG_VMPRESSURE_DEFAULT_DISABLED
> +bool vmpressure_enable;
> +#else
> +bool vmpressure_enable = true;
> +#endif
> +static int __init setup_vmpressure(char *str)
> +{
> +	return kstrtobool(str, &vmpressure_enable) == 0;
> +}
> +__setup("vmpressure=", setup_vmpressure);
> +
> +
>  static struct vmpressure *work_to_vmpressure(struct work_struct *work)
>  {
>  	return container_of(work, struct vmpressure, work);
> @@ -246,6 +259,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  
>  	vmpr = memcg_to_vmpressure(memcg);
>  
> +	if (static_branch_likely(&vmpressure_disabled))
> +		return;
> +
>  	/*
>  	 * Here we only want to account pressure that userland is able to
>  	 * help us with. For example, suppose that DMA zone is under
> @@ -326,6 +342,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>   */
>  void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio)
>  {
> +	if (static_branch_likely(&vmpressure_disabled))
> +		return;
>  	/*
>  	 * We only use prio for accounting critical level. For more info
>  	 * see comment for vmpressure_level_critical_prio variable above.
> @@ -450,6 +468,11 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
>   */
>  void vmpressure_init(struct vmpressure *vmpr)
>  {
> +	if (!vmpressure_enable) {
> +		static_branch_enable(&vmpressure_disabled);
> +		return;
> +	}
> +
>  	spin_lock_init(&vmpr->sr_lock);
>  	mutex_init(&vmpr->events_lock);
>  	INIT_LIST_HEAD(&vmpr->events);
> @@ -465,6 +488,9 @@ void vmpressure_init(struct vmpressure *vmpr)
>   */
>  void vmpressure_cleanup(struct vmpressure *vmpr)
>  {
> +
> +	if (static_branch_likely(&vmpressure_disabled))
> +		return;
>  	/*
>  	 * Make sure there is no pending work before eventfd infrastructure
>  	 * goes away.

