Return-Path: <cgroups+bounces-11422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D160BC1E79B
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 06:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2091888C86
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2A2F6915;
	Thu, 30 Oct 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHdG2IDw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DE2F6170
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803901; cv=none; b=qaqJiYW910KJ3OUKYYkmBvI/3GUXE8eOMO7t76wrpSLaqGdKGiDe5+OPehmfKYG++6KMU6ojHHQjfs6a/zaRUFUStAv/qUxvHlqJbymGLZgzEhKHcUDS+5+LWztMY4k0frzUZya6ChpFuwcTbIZ2dASZkJX6TqI2bUjNycOfNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803901; c=relaxed/simple;
	bh=BFsKeamwyLRenE3BOM9iEeCDRzA2vzKBMXrusRP0q+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piRctJls7Xn2IIDk3QUoc7WJu3Zamd0RNnK/f/t992bWx4xDiBoNexAHZITF4AmVr1+ihmYN/kxabYeVW+B5YneXVegzzFK3pPHN3/R/O51UQ2WxUslIN1UKMDFb5up3T+qA1glkhjDTsijpr5HiI86igiXmAI5+0wuBWBkRDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHdG2IDw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60157747so7974947b3.0
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761803898; x=1762408698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44CpAxEQd2flt1Ihx/Ia7H9Y9aQczX78AOv9CGcJyPw=;
        b=XHdG2IDwFUJtbcI/+o29DYOYr5H1SrgALhyxThL7p2cEfFPYPFmbnw6ZM4THWJzmCa
         2xQ/yHbHAe0Nh2TmQu/7rW/yzO0/8Sa/S/AHIcq8tjNrwZFahsSfQNqQjyy4scLHYcY/
         vLb8JKFDg/C7BK5UugFjpgFef+0SQCaZ/ryEgSyFK3uw8AkdNuQO2aNddzF8y2Tld2NK
         FAP7b0nCnqS21vI1aCuhM3Fr8Su/UZSs4j/xN1ekRMCQ61EIfdrHhWn2h7WpQGz92dis
         BV5+2eiTY6hbCeAHQ2RMo1NjGaAepv1erqn556MX9Q2DYJUYQPeetgiC52382GVTzZpJ
         Ah2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761803898; x=1762408698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44CpAxEQd2flt1Ihx/Ia7H9Y9aQczX78AOv9CGcJyPw=;
        b=Qu2kM/0XCQoGnjdR8IA2saf5wTFRrDpXvAhlDC/8Cuk5gGozrh27xLpDDOsK1BI7bs
         8INEt4X7bTGBbgo7m8d59V6QIaLm6klsr3akB7kh5/xVySxaGPJaFzSoQMWp7tdtjxzT
         BSCgFf3iNAEggEjxDvo3wJ6+nD6ktT1t/u/eYdIF3n8yoxN1aWYjEAopPLc57PDOPqMO
         RBhe0ZqSkmBfW8ecjMh8GA1du/HpPSuEOw7MSY4lZAzAuq7N/Yzh+KzfjFz9jN3YZfI0
         EDiuZutFmln74c0MCehKRXinvlZaBEORR4QANtyRqe0YXG4BbMSAGLCtT0LnC/oj7cUR
         5SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUciY1wRXKLgbOt5/KOtbskz5BiVj5Xc2nxAtSD0MctbaXt5JmgVYJJNrStE/fitAYAje+DgFyF@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRLqxalsNAdpx3rYiH+nRv4Y/9vtOo4WZH3VIO0oT7VTek/3Z
	F+bXSxzGzbuP0YYVvPVsnqEM2lxe7yAcVru/iaY7ylOc5Bc/PP/W7n081Ai0h70XAmdUzeY/HOS
	Kkawygg3J8us8+QKF+adOt9ewZxif1V4=
X-Gm-Gg: ASbGncvBryj8QhgwftfA2AJslJ/8mfWJ0v8my+id/nalaLXDDsN24Y60SnByNZFcrp6
	wEl5BgiN5FMkdyME3Bcz65svR6vmav+VIWc9bpotyTICTkTrCdAIT9GtP6ALIusba4qI2n0OnLo
	bKw/lby8AhPoWSmcKa5QxbVxpIZOCKT6k69uORCPQ8/zJ07y9731x9lWLerR2hoWTLt50nza+oL
	+OImB9NYEs21gf6mzht6tcDt5aYYZOsVkXLmzV5UJNteFW1cYRqOtegx0d8WhfYFy2/5/8p
X-Google-Smtp-Source: AGHT+IEkqTShipMaEL0Xz6lVmMBlYFoNnJAmvAxJI8GnivPdsxuC3uaQU9h3KfORjbsr6qUGYSBm+EG1Eo+umq+dmao=
X-Received: by 2002:a05:690c:600e:b0:784:ae5b:672e with SMTP id
 00721157ae682-786390b1042mr23512867b3.44.1761803898047; Wed, 29 Oct 2025
 22:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 Oct 2025 13:57:41 +0800
X-Gm-Features: AWmQ_bnrGvSDvqcO1gz0my1IRVwq5iqm8EZUd991D3gWW54pYf-XPYtuxndhzy0
Message-ID: <CALOAHbDmD2sTw6SLcZ3zikGO54GTyUSyFwTmak2UhA02oo4C-w@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:22=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce a bpf struct ops for implementing custom OOM handling
> policies.
>
> It's possible to load one bpf_oom_ops for the system and one
> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> cgroup tree is traversed from the OOM'ing memcg up to the root and
> corresponding BPF OOM handlers are executed until some memory is
> freed. If no memory is freed, the kernel OOM killer is invoked.
>
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. If both are set, OOM is
> considered handled, otherwise the next OOM handler in the chain
> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
> killer) is executed.
>
> The bpf_handle_out_of_memory() callback program is sleepable to enable
> using iterators, e.g. cgroup iterators. The callback receives struct
> oom_control as an argument, so it can determine the scope of the OOM
> event: if this is a memcg-wide or system-wide OOM.
>
> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.
>
> BPF OOM struct ops provides the handle_cgroup_offline() callback
> which is good for releasing struct ops if the corresponding cgroup
> is gone.
>
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=3D<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.
>
> [  112.696676] test_progs invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL=
), order=3D0, oom_score_adj=3D0
>                oom_policy=3Dbpf_test_policy
> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0=
-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-5.fc42 04/01/2014
> [  112.698167] Call Trace:
> [  112.698177]  <TASK>
> [  112.698182]  dump_stack_lvl+0x4d/0x70
> [  112.698192]  dump_header+0x59/0x1c6
> [  112.698199]  oom_kill_process.cold+0x8/0xef
> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> [  112.698250]  out_of_memory+0xab/0x5c0
> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> [  112.698288]  charge_memcg+0x2f/0xc0
> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> [  112.698299]  do_anonymous_page+0x40f/0xa50
> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698335]  handle_mm_fault+0xe6/0x370
> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> [  112.698354]  exc_page_fault+0x75/0x1d0
> [  112.698363]  asm_exc_page_fault+0x26/0x30
> [  112.698366] RIP: 0033:0x7fa97236db00
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf_oom.h    |  74 ++++++++++
>  include/linux/memcontrol.h |   5 +
>  include/linux/oom.h        |   8 ++
>  mm/Makefile                |   3 +
>  mm/bpf_oom.c               | 272 +++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c            |   2 +
>  mm/oom_kill.c              |  22 ++-
>  7 files changed, 384 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/bpf_oom.h
>  create mode 100644 mm/bpf_oom.c
>
> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> new file mode 100644
> index 000000000000..18c32a5a068b
> --- /dev/null
> +++ b/include/linux/bpf_oom.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_OOM_H
> +#define __BPF_OOM_H
> +
> +struct oom_control;
> +
> +#define BPF_OOM_NAME_MAX_LEN 64
> +
> +struct bpf_oom_ctx {
> +       /*
> +        * If bpf_oom_ops is attached to a cgroup, id of this cgroup.
> +        * 0 otherwise.
> +        */
> +       u64 cgroup_id;
> +};
> +
> +struct bpf_oom_ops {
> +       /**
> +        * @handle_out_of_memory: Out of memory bpf handler, called befor=
e
> +        * the in-kernel OOM killer.
> +        * @ctx: Execution context
> +        * @oc: OOM control structure
> +        *
> +        * Should return 1 if some memory was freed up, otherwise
> +        * the in-kernel OOM killer is invoked.
> +        */
> +       int (*handle_out_of_memory)(struct bpf_oom_ctx *ctx, struct oom_c=
ontrol *oc);
> +
> +       /**
> +        * @handle_cgroup_offline: Cgroup offline callback
> +        * @ctx: Execution context
> +        * @cgroup_id: Id of deleted cgroup
> +        *
> +        * Called if the cgroup with the attached bpf_oom_ops is deleted.
> +        */
> +       void (*handle_cgroup_offline)(struct bpf_oom_ctx *ctx, u64 cgroup=
_id);
> +
> +       /**
> +        * @name: BPF OOM policy name
> +        */
> +       char name[BPF_OOM_NAME_MAX_LEN];
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory condition using bpf
> + * @oc: OOM control structure
> + *
> + * Returns true if some memory was freed.
> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +
> +
> +/**
> + * @bpf_oom_memcg_offline: handle memcg offlining
> + * @memcg: Memory cgroup is offlined
> + *
> + * When a memory cgroup is about to be deleted and there is an
> + * attached BPF OOM structure, it has to be detached.
> + */
> +void bpf_oom_memcg_offline(struct mem_cgroup *memcg);
> +
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       return false;
> +}
> +
> +static inline void bpf_oom_memcg_offline(struct mem_cgroup *memcg) {}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +#endif /* __BPF_OOM_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 50d851ff3f27..39a6c7c8735b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -29,6 +29,7 @@ struct obj_cgroup;
>  struct page;
>  struct mm_struct;
>  struct kmem_cache;
> +struct bpf_oom_ops;
>
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
> @@ -226,6 +227,10 @@ struct mem_cgroup {
>          */
>         bool oom_group;
>
> +#ifdef CONFIG_BPF_SYSCALL
> +       struct bpf_oom_ops *bpf_oom;
> +#endif
> +
>         int swappiness;
>
>         /* memory.events and memory.events.local */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 7b02bc1d0a7e..721087952d04 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -51,6 +51,14 @@ struct oom_control {
>
>         /* Used to print the constraint info. */
>         enum oom_constraint constraint;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* Used by the bpf oom implementation to mark the forward progres=
s */
> +       bool bpf_memory_freed;
> +
> +       /* Policy name */
> +       const char *bpf_policy_name;
> +#endif
>  };
>
>  extern struct mutex oom_lock;
> diff --git a/mm/Makefile b/mm/Makefile
> index 21abb3353550..051e88c699af 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
>  endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-y +=3D bpf_oom.o
> +endif
>  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
>  obj-$(CONFIG_DMAPOOL_TEST) +=3D dmapool_test.o
> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> new file mode 100644
> index 000000000000..c4d09ed9d541
> --- /dev/null
> +++ b/mm/bpf_oom.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BPF-driven OOM killer customization
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/oom.h>
> +#include <linux/bpf_oom.h>
> +#include <linux/srcu.h>
> +#include <linux/cgroup.h>
> +#include <linux/memcontrol.h>
> +
> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
> +static struct bpf_oom_ops *system_bpf_oom;
> +
> +#ifdef CONFIG_MEMCG
> +static u64 memcg_cgroup_id(struct mem_cgroup *memcg)
> +{
> +       return cgroup_id(memcg->css.cgroup);
> +}
> +
> +static struct bpf_oom_ops **bpf_oom_memcg_ops_ptr(struct mem_cgroup *mem=
cg)
> +{
> +       return &memcg->bpf_oom;
> +}
> +#else /* CONFIG_MEMCG */
> +static u64 memcg_cgroup_id(struct mem_cgroup *memcg)
> +{
> +       return 0;
> +}
> +static struct bpf_oom_ops **bpf_oom_memcg_ops_ptr(struct mem_cgroup *mem=
cg)
> +{
> +       return NULL;
> +}
> +#endif
> +
> +static int bpf_ops_handle_oom(struct bpf_oom_ops *bpf_oom_ops,
> +                             struct mem_cgroup *memcg,
> +                             struct oom_control *oc)
> +{
> +       struct bpf_oom_ctx exec_ctx;
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_MEMCG) && memcg)
> +               exec_ctx.cgroup_id =3D memcg_cgroup_id(memcg);
> +       else
> +               exec_ctx.cgroup_id =3D 0;
> +
> +       oc->bpf_policy_name =3D &bpf_oom_ops->name[0];
> +       oc->bpf_memory_freed =3D false;
> +       ret =3D bpf_oom_ops->handle_out_of_memory(&exec_ctx, oc);
> +       oc->bpf_policy_name =3D NULL;
> +
> +       return ret;
> +}
> +
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> +       struct mem_cgroup __maybe_unused *memcg;
> +       int idx, ret =3D 0;
> +
> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> +
> +#ifdef CONFIG_MEMCG
> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upward=
s */
> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memc=
g)) {
> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> +               if (!bpf_oom_ops)
> +                       continue;
> +
> +               /* Call BPF OOM handler */
> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> +               if (ret && oc->bpf_memory_freed)
> +                       goto exit;
> +       }
> +#endif /* CONFIG_MEMCG */
> +
> +       /*
> +        * System-wide OOM or per-memcg BPF OOM handler wasn't successful=
?
> +        * Try system_bpf_oom.
> +        */
> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> +       if (!bpf_oom_ops)
> +               goto exit;
> +
> +       /* Call BPF OOM handler */
> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> +exit:
> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> +       return ret && oc->bpf_memory_freed;
> +}
> +
> +static int __handle_out_of_memory(struct bpf_oom_ctx *exec_ctx,
> +                                 struct oom_control *oc)
> +{
> +       return 0;
> +}
> +
> +static void __handle_cgroup_offline(struct bpf_oom_ctx *exec_ctx, u64 cg=
roup_id)
> +{
> +}
> +
> +static struct bpf_oom_ops __bpf_oom_ops =3D {
> +       .handle_out_of_memory =3D __handle_out_of_memory,
> +       .handle_cgroup_offline =3D __handle_cgroup_offline,
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_oom_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog=
)
> +{
> +       return tracing_prog_func_proto(func_id, prog);
> +}
> +
> +static bool bpf_oom_ops_is_valid_access(int off, int size,
> +                                       enum bpf_access_type type,
> +                                       const struct bpf_prog *prog,
> +                                       struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_oom_verifier_ops =3D {
> +       .get_func_proto =3D bpf_oom_func_proto,
> +       .is_valid_access =3D bpf_oom_ops_is_valid_access,
> +};
> +
> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, struc=
t bpf_struct_ops_link, link);
> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> +       struct mem_cgroup *memcg =3D NULL;
> +       int err =3D 0;
> +
> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +               /* Attach to a memory cgroup? */
> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +               if (IS_ERR_OR_NULL(memcg))
> +                       return PTR_ERR(memcg);
> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> +       } else {
> +               /* System-wide OOM handler */
> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> +       }
> +
> +       /* Another struct ops attached? */
> +       if (READ_ONCE(*bpf_oom_ops_ptr)) {
> +               err =3D -EBUSY;
> +               goto exit;
> +       }
> +
> +       /* Expose bpf_oom_ops structure */
> +       WRITE_ONCE(*bpf_oom_ops_ptr, bpf_oom_ops);

The mechanism for propagating this pointer to child cgroups isn't
clear. Would an explicit installation in every cgroup be required?
This approach seems impractical for production environments, where
cgroups are often created dynamically.

--=20
Regards
Yafang

