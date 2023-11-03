Return-Path: <cgroups+bounces-165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02477DFFD4
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A6AB21360
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC58826;
	Fri,  3 Nov 2023 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxjIYueu"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B82D604;
	Fri,  3 Nov 2023 08:50:18 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CFD65;
	Fri,  3 Nov 2023 01:50:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7fb84f6ceso22004687b3.1;
        Fri, 03 Nov 2023 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699001412; x=1699606212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsLmB2JI4tHI9bgr0LXKs68cueMThNaONQwvT92FNE8=;
        b=KxjIYueu/JPayokm3yVd6Fpkt7/FFc3UNh1ePOedTbWR9k9od173SWzItDqizE05i6
         c64So8EB8nImu/WS2BGFS0UuzvJpldN46OIWYzkmbrDwdzUwaZ9AgsBwVZ3aLAEtutE2
         RR2joS3agyA4cCjR2q1zwRGN2yo4da79J+Lt5SEX52y63wwsUdZGD4PWfsi9UzWhqBtE
         O2r025bFHSjaKaY/2uJQLblxF9VKxDKPnIBFhFXk8NLq9qZU1gye9n9+NSL/TNIfdPWk
         9Kzu5hAQc9fQOM720UGOGimytvLA7AQMEkutuSAzStzpHSXnXl21+5ZyBhQNnL/pmv2k
         7gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001412; x=1699606212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsLmB2JI4tHI9bgr0LXKs68cueMThNaONQwvT92FNE8=;
        b=J9dtiF54Qzk5QtWWzTfnmf/X+BRvioIc378Byb9Vy80u0GodMRFIIfPhidr4jsKz8c
         oPNYX++c0sbvjyLRLH5+fUt+5atj2Iu2XIIYsghfx9i+2aK3LJ9zD0b2/cGBBkY7fb/a
         FJ7ytm2gqNbkr4VS/Ms7C127aDk+aPB1UQqC9jnyQ0NREXrh6Vqy8ac0hPzrJFpPoIJT
         DdhjvDXep/P6hb6rLkfukX4eiOE5g1mScrf6IVWQuntVLS3a6FkKUKrHBumo5xsbZr5w
         0tWhxJ8SdjxlTLxDx9I0kl6aUY7NO403GlvhFwgC+PVfNOH8kqVsub5SJemmu6/FWo3K
         u5iw==
X-Gm-Message-State: AOJu0YyuHaMUazfZatu7ExWVDyBUh76+IzlkwOXBHh2CBAeAtrzzWKt9
	fh4m/3H1oXiXkpJ7a3VS+bhGlgX/wZm251HJJCU=
X-Google-Smtp-Source: AGHT+IGlPuM2lrFrnQg6JhE9/qyLVG+sSgkWU9jV3Fh6wEWhnukLHvKRV39p9Gex9SnvxMmYVDmzO0YHRYgBQsn5k2c=
X-Received: by 2002:a05:690c:fd0:b0:5a7:ab4c:c7bf with SMTP id
 dg16-20020a05690c0fd000b005a7ab4cc7bfmr2137594ywb.0.1699001412179; Fri, 03
 Nov 2023 01:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-7-laoar.shao@gmail.com> <202311031651.A7crZEur-lkp@intel.com>
In-Reply-To: <202311031651.A7crZEur-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 3 Nov 2023 16:49:35 +0800
Message-ID: <CALOAHbB7df7amW++bNqqncETYE8AL=o0UPd43L3XvCiqkXJSVg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
To: kernel test robot <lkp@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, longman@redhat.com, oe-kbuild-all@lists.linux.dev, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 4:19=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Yafang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup=
-Remove-unnecessary-list_empty/20231029-143457
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.shao=
%40gmail.com
> patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1=
 hierarchy
> config: x86_64-randconfig-004-20231103 (https://download.01.org/0day-ci/a=
rchive/20231103/202311031651.A7crZEur-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

__diag_ignore_all() is supported for gcc >=3D 8.0.0.
It seems that we should also support it for older gcc ?

> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231103/202311031651.A7crZEur-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/helpers.c:1893:19: warning: no previous prototype for 'bpf_=
obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__=
ign)
>                       ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1907:19: warning: no previous prototype for 'bpf_=
percpu_obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void =
*meta__ign)
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1941:18: warning: no previous prototype for 'bpf_=
obj_drop_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>                      ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1949:18: warning: no previous prototype for 'bpf_=
percpu_obj_drop_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta_=
_ign)
>                      ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1955:19: warning: no previous prototype for 'bpf_=
refcount_acquire_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr,=
 void *meta__ign)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2000:17: warning: no previous prototype for 'bpf_=
list_push_front_impl' [-Wmissing-prototypes]
>     __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2010:17: warning: no previous prototype for 'bpf_=
list_push_back_impl' [-Wmissing-prototypes]
>     __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>                     ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2043:35: warning: no previous prototype for 'bpf_=
list_pop_front' [-Wmissing-prototypes]
>     __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_=
head *head)
>                                       ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2048:35: warning: no previous prototype for 'bpf_=
list_pop_back' [-Wmissing-prototypes]
>     __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_h=
ead *head)
>                                       ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2053:33: warning: no previous prototype for 'bpf_=
rbtree_remove' [-Wmissing-prototypes]
>     __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root =
*root,
>                                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2109:17: warning: no previous prototype for 'bpf_=
rbtree_add_impl' [-Wmissing-prototypes]
>     __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct =
bpf_rb_node *node,
>                     ^~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2119:33: warning: no previous prototype for 'bpf_=
rbtree_first' [-Wmissing-prototypes]
>     __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *=
root)
>                                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2132:33: warning: no previous prototype for 'bpf_=
task_acquire' [-Wmissing-prototypes]
>     __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *=
p)
>                                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2143:18: warning: no previous prototype for 'bpf_=
task_release' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_task_release(struct task_struct *p)
>                      ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2155:28: warning: no previous prototype for 'bpf_=
cgroup_acquire' [-Wmissing-prototypes]
>     __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
>                                ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2167:18: warning: no previous prototype for 'bpf_=
cgroup_release' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
>                      ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2179:28: warning: no previous prototype for 'bpf_=
cgroup_ancestor' [-Wmissing-prototypes]
>     __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, i=
nt level)
>                                ^~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2199:28: warning: no previous prototype for 'bpf_=
cgroup_from_id' [-Wmissing-prototypes]
>     __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
>                                ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2219:18: warning: no previous prototype for 'bpf_=
task_under_cgroup' [-Wmissing-prototypes]
>     __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
>                      ^~~~~~~~~~~~~~~~~~~~~
> >> kernel/bpf/helpers.c:2240:1: warning: no previous prototype for 'bpf_t=
ask_get_cgroup1' [-Wmissing-prototypes]
>     bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
>     ^~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2256:33: warning: no previous prototype for 'bpf_=
task_from_pid' [-Wmissing-prototypes]
>     __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
>                                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2297:19: warning: no previous prototype for 'bpf_=
dynptr_slice' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr,=
 u32 offset,
>                       ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2381:19: warning: no previous prototype for 'bpf_=
dynptr_slice_rdwr' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern =
*ptr, u32 offset,
>                       ^~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2412:17: warning: no previous prototype for 'bpf_=
dynptr_adjust' [-Wmissing-prototypes]
>     __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 st=
art, u32 end)
>                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2430:18: warning: no previous prototype for 'bpf_=
dynptr_is_null' [-Wmissing-prototypes]
>     __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
>                      ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2435:18: warning: no previous prototype for 'bpf_=
dynptr_is_rdonly' [-Wmissing-prototypes]
>     __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
>                      ^~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2443:19: warning: no previous prototype for 'bpf_=
dynptr_size' [-Wmissing-prototypes]
>     __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
>                       ^~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2451:17: warning: no previous prototype for 'bpf_=
dynptr_clone' [-Wmissing-prototypes]
>     __bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
>                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2464:19: warning: no previous prototype for 'bpf_=
cast_to_kern_ctx' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>                       ^~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2469:19: warning: no previous prototype for 'bpf_=
rdonly_cast' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
>                       ^~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2474:18: warning: no previous prototype for 'bpf_=
rcu_read_lock' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_rcu_read_lock(void)
>                      ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2479:18: warning: no previous prototype for 'bpf_=
rcu_read_unlock' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_rcu_read_unlock(void)
>                      ^~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2508:18: warning: no previous prototype for 'bpf_=
throw' [-Wmissing-prototypes]
>     __bpf_kfunc void bpf_throw(u64 cookie)
>                      ^~~~~~~~~
>    cc1: warning: unrecognized command line option '-Wno-attribute-alias'
>
>
> vim +/bpf_task_get_cgroup1 +2240 kernel/bpf/helpers.c
>
>   2229
>   2230  /**
>   2231   * bpf_task_get_cgroup1 - Acquires the associated cgroup of a tas=
k within a
>   2232   * specific cgroup1 hierarchy. The cgroup1 hierarchy is identifie=
d by its
>   2233   * hierarchy ID.
>   2234   * @task: The target task
>   2235   * @hierarchy_id: The ID of a cgroup1 hierarchy
>   2236   *
>   2237   * On success, the cgroup is returen. On failure, NULL is returne=
d.
>   2238   */
>   2239  __bpf_kfunc struct cgroup *
> > 2240  bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
>   2241  {
>   2242          struct cgroup *cgrp =3D task_get_cgroup1(task, hierarchy_=
id);
>   2243
>   2244          if (IS_ERR(cgrp))
>   2245                  return NULL;
>   2246          return cgrp;
>   2247  }
>   2248  #endif /* CONFIG_CGROUPS */
>   2249
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Regards
Yafang

