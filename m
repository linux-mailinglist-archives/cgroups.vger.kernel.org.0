Return-Path: <cgroups+bounces-164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF57DFFAF
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 09:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831D0B21313
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CC8470;
	Fri,  3 Nov 2023 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWyU66Zk"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B258460;
	Fri,  3 Nov 2023 08:19:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D1123;
	Fri,  3 Nov 2023 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698999588; x=1730535588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7x+HLMrPHU1vmeH3n+XslylsbnDpCawoU8xBczXjVn0=;
  b=kWyU66Zk9+EcbYS+0sdQqQaiRtZlFFLCvr1LJsWnO/fMFOubPFjacDxf
   AZVfztTN5X8LINvYehX4fGmebWnjvQ1Bga4n8HXBp8guCx9K05i5/qzeI
   4LyHNwMyhgljp7VRzUqYdKXl3AGOxVbGm8YjdABAy4Ykoacmy/0opIIW6
   hZFwkBiiKZvTgNRcOnAbFFzZgqFl1QCOT/PrE7m3NrUoCZAK9BsYIYvM9
   Wlhf5YEeC3d2i9TDcwUGgpVK5A57Y/2RxmltDxYQ3PZ2RfmxSOgFVH7uK
   wcmAG1kiRdA8qPEw8GdU2VnkxgknljyZ+2UxGa9QssYrWHuIcltDKybLy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475141063"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="475141063"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="827416501"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="827416501"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2023 01:19:43 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qypP2-0002Me-1y;
	Fri, 03 Nov 2023 08:19:40 +0000
Date: Fri, 3 Nov 2023 16:18:49 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1
 hierarchy
Message-ID: <202311031651.A7crZEur-lkp@intel.com>
References: <20231029061438.4215-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-7-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup-Remove-unnecessary-list_empty/20231029-143457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231029061438.4215-7-laoar.shao%40gmail.com
patch subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
config: x86_64-randconfig-004-20231103 (https://download.01.org/0day-ci/archive/20231103/202311031651.A7crZEur-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031651.A7crZEur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1893:19: warning: no previous prototype for 'bpf_obj_new_impl' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1907:19: warning: no previous prototype for 'bpf_percpu_obj_new_impl' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1941:18: warning: no previous prototype for 'bpf_obj_drop_impl' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1949:18: warning: no previous prototype for 'bpf_percpu_obj_drop_impl' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
                     ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1955:19: warning: no previous prototype for 'bpf_refcount_acquire_impl' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2000:17: warning: no previous prototype for 'bpf_list_push_front_impl' [-Wmissing-prototypes]
    __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2010:17: warning: no previous prototype for 'bpf_list_push_back_impl' [-Wmissing-prototypes]
    __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
                    ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2043:35: warning: no previous prototype for 'bpf_list_pop_front' [-Wmissing-prototypes]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2048:35: warning: no previous prototype for 'bpf_list_pop_back' [-Wmissing-prototypes]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2053:33: warning: no previous prototype for 'bpf_rbtree_remove' [-Wmissing-prototypes]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2109:17: warning: no previous prototype for 'bpf_rbtree_add_impl' [-Wmissing-prototypes]
    __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
                    ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2119:33: warning: no previous prototype for 'bpf_rbtree_first' [-Wmissing-prototypes]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2132:33: warning: no previous prototype for 'bpf_task_acquire' [-Wmissing-prototypes]
    __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2143:18: warning: no previous prototype for 'bpf_task_release' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_task_release(struct task_struct *p)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2155:28: warning: no previous prototype for 'bpf_cgroup_acquire' [-Wmissing-prototypes]
    __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2167:18: warning: no previous prototype for 'bpf_cgroup_release' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2179:28: warning: no previous prototype for 'bpf_cgroup_ancestor' [-Wmissing-prototypes]
    __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
                               ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2199:28: warning: no previous prototype for 'bpf_cgroup_from_id' [-Wmissing-prototypes]
    __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2219:18: warning: no previous prototype for 'bpf_task_under_cgroup' [-Wmissing-prototypes]
    __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
                     ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:2240:1: warning: no previous prototype for 'bpf_task_get_cgroup1' [-Wmissing-prototypes]
    bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
    ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2256:33: warning: no previous prototype for 'bpf_task_from_pid' [-Wmissing-prototypes]
    __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2297:19: warning: no previous prototype for 'bpf_dynptr_slice' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2381:19: warning: no previous prototype for 'bpf_dynptr_slice_rdwr' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2412:17: warning: no previous prototype for 'bpf_dynptr_adjust' [-Wmissing-prototypes]
    __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2430:18: warning: no previous prototype for 'bpf_dynptr_is_null' [-Wmissing-prototypes]
    __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2435:18: warning: no previous prototype for 'bpf_dynptr_is_rdonly' [-Wmissing-prototypes]
    __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
                     ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2443:19: warning: no previous prototype for 'bpf_dynptr_size' [-Wmissing-prototypes]
    __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2451:17: warning: no previous prototype for 'bpf_dynptr_clone' [-Wmissing-prototypes]
    __bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2464:19: warning: no previous prototype for 'bpf_cast_to_kern_ctx' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
                      ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2469:19: warning: no previous prototype for 'bpf_rdonly_cast' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2474:18: warning: no previous prototype for 'bpf_rcu_read_lock' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_rcu_read_lock(void)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2479:18: warning: no previous prototype for 'bpf_rcu_read_unlock' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_rcu_read_unlock(void)
                     ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2508:18: warning: no previous prototype for 'bpf_throw' [-Wmissing-prototypes]
    __bpf_kfunc void bpf_throw(u64 cookie)
                     ^~~~~~~~~
   cc1: warning: unrecognized command line option '-Wno-attribute-alias'


vim +/bpf_task_get_cgroup1 +2240 kernel/bpf/helpers.c

  2229	
  2230	/**
  2231	 * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task within a
  2232	 * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
  2233	 * hierarchy ID.
  2234	 * @task: The target task
  2235	 * @hierarchy_id: The ID of a cgroup1 hierarchy
  2236	 *
  2237	 * On success, the cgroup is returen. On failure, NULL is returned.
  2238	 */
  2239	__bpf_kfunc struct cgroup *
> 2240	bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
  2241	{
  2242		struct cgroup *cgrp = task_get_cgroup1(task, hierarchy_id);
  2243	
  2244		if (IS_ERR(cgrp))
  2245			return NULL;
  2246		return cgrp;
  2247	}
  2248	#endif /* CONFIG_CGROUPS */
  2249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

