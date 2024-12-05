Return-Path: <cgroups+bounces-5764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B19E4C3F
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977002866CD
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50070FC0A;
	Thu,  5 Dec 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvrH71J7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36E22EE5;
	Thu,  5 Dec 2024 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365683; cv=none; b=oIv+wBnzuTiR51sdkx3Cmjt8yu4518TcqfUx/v7yDE7KDYFw3z1qNQboN1cXG2X2Lh9O6n15+FyZP09bXbseGyvJ25W2Gdbve9cMR+Ai1/DfeLgXMR15yN/JEElYcr3wgKZU8JihO962KqxgRIug8v5Y612ztSl7AfduoA2ccGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365683; c=relaxed/simple;
	bh=QO5IboRu4sXKDliedTe2GJzHgDQy5oh6qE/bI1NxotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaVU61WR30DtUWxWnw1P1oup4r13zLISsOWYVN0WXkB1mrRcWZVrKnlAZm7+94aCuf3rLbOPiOCvr9Noztp8ko0NkN7YDEL2v5zgj7m4RgqOje5gSM66vVhrJbC5jI3gAm6uxjga2QvkjvkIOBZTy8q7UfTVSKDOis67HUp2uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvrH71J7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733365681; x=1764901681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QO5IboRu4sXKDliedTe2GJzHgDQy5oh6qE/bI1NxotM=;
  b=KvrH71J7kf7mmQYLGHI1aqzSu9HkmKKVNYBEjNn7y5wUSezvBImi5xk+
   dHmkFPV1k54eNbqdKBErCFgqECJgprD9Zc1T4+4nwPrrnBzyy9fPybLTr
   l7+IY62hZFLosdnHU5tLtX2/Km7tikGldqLDX+duNa2OkG5CIx6siU+RI
   1ZooWkrleIHn+JYBgZObcd4fkNeQomiZ2Nknn/4v1ArOVub3P14akkGjF
   z62ipbghbM7H1u5xF1kC5caJp0T2wQJzrgkqRepfVcVFiaTaBI/ZO8iLx
   JIG7g37ez6jss+aNiyf6lS1AYIJaJ7TPRj8VOyU9vACl2pf5EOCqC4cXu
   A==;
X-CSE-ConnectionGUID: X9G2M+r3SzWhlde9RyMxUg==
X-CSE-MsgGUID: ooCSlw6eRMqZJBYH8aFuNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33906102"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33906102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:28:00 -0800
X-CSE-ConnectionGUID: Q5g3rUN6RcabXY/8BbzQOA==
X-CSE-MsgGUID: nlNLgQgxTM6qb2x9125a6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98025648"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2024 18:27:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ1as-0003gr-2k;
	Thu, 05 Dec 2024 02:27:54 +0000
Date: Thu, 5 Dec 2024 10:27:19 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	cgroups@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2.1 1/1] kernel/cgroup: Add "dmem" memory accounting
 cgroup
Message-ID: <202412051039.P06riwrP-lkp@intel.com>
References: <20241204143112.1250983-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204143112.1250983-1-dev@lankhorst.se>

Hi Maarten,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.13-rc1 next-20241204]
[cannot apply to drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/kernel-cgroup-Add-dmem-memory-accounting-cgroup/20241204-233207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20241204143112.1250983-1-dev%40lankhorst.se
patch subject: [PATCH v2.1 1/1] kernel/cgroup: Add "dmem" memory accounting cgroup
config: um-randconfig-r061-20241205 (https://download.01.org/0day-ci/archive/20241205/202412051039.P06riwrP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412051039.P06riwrP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412051039.P06riwrP-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/cgroup/dmem.o: in function `set_resource_min':
>> kernel/cgroup/dmem.c:115: undefined reference to `page_counter_set_min'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `set_resource_low':
>> kernel/cgroup/dmem.c:121: undefined reference to `page_counter_set_low'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `set_resource_max':
>> kernel/cgroup/dmem.c:127: undefined reference to `page_counter_set_max'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `reset_all_resource_limits':
>> kernel/cgroup/dmem.c:115: undefined reference to `page_counter_set_min'
>> /usr/bin/ld: kernel/cgroup/dmem.c:121: undefined reference to `page_counter_set_low'
>> /usr/bin/ld: kernel/cgroup/dmem.c:127: undefined reference to `page_counter_set_max'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `dmem_cgroup_uncharge':
>> kernel/cgroup/dmem.c:607: undefined reference to `page_counter_uncharge'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `dmem_cgroup_calculate_protection':
>> kernel/cgroup/dmem.c:275: undefined reference to `page_counter_calculate_protection'
   /usr/bin/ld: kernel/cgroup/dmem.o: in function `dmem_cgroup_try_charge':
>> kernel/cgroup/dmem.c:657: undefined reference to `page_counter_try_charge'
   collect2: error: ld returned 1 exit status

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +115 kernel/cgroup/dmem.c

   111	
   112	static void
   113	set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
   114	{
 > 115		page_counter_set_min(&pool->cnt, val);
   116	}
   117	
   118	static void
   119	set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
   120	{
 > 121		page_counter_set_low(&pool->cnt, val);
   122	}
   123	
   124	static void
   125	set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
   126	{
 > 127		page_counter_set_max(&pool->cnt, val);
   128	}
   129	
   130	static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
   131	{
   132		return pool ? READ_ONCE(pool->cnt.low) : 0;
   133	}
   134	
   135	static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
   136	{
   137		return pool ? READ_ONCE(pool->cnt.min) : 0;
   138	}
   139	
   140	static u64 get_resource_max(struct dmem_cgroup_pool_state *pool)
   141	{
   142		return pool ? READ_ONCE(pool->cnt.max) : PAGE_COUNTER_MAX;
   143	}
   144	
   145	static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
   146	{
   147		return pool ? page_counter_read(&pool->cnt) : 0;
   148	}
   149	
   150	static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
   151	{
   152		set_resource_min(rpool, 0);
   153		set_resource_low(rpool, 0);
   154		set_resource_max(rpool, PAGE_COUNTER_MAX);
   155	}
   156	
   157	static void dmemcs_offline(struct cgroup_subsys_state *css)
   158	{
   159		struct dmemcg_state *dmemcs = css_to_dmemcs(css);
   160		struct dmem_cgroup_pool_state *pool;
   161	
   162		rcu_read_lock();
   163		list_for_each_entry_rcu(pool, &dmemcs->pools, css_node)
   164			reset_all_resource_limits(pool);
   165		rcu_read_unlock();
   166	}
   167	
   168	static void dmemcs_free(struct cgroup_subsys_state *css)
   169	{
   170		struct dmemcg_state *dmemcs = css_to_dmemcs(css);
   171		struct dmem_cgroup_pool_state *pool, *next;
   172	
   173		spin_lock(&dmemcg_lock);
   174		list_for_each_entry_safe(pool, next, &dmemcs->pools, css_node) {
   175			/*
   176			 *The pool is dead and all references are 0,
   177			 * no need for RCU protection with list_del_rcu or freeing.
   178			 */
   179			list_del(&pool->css_node);
   180			free_cg_pool(pool);
   181		}
   182		spin_unlock(&dmemcg_lock);
   183	
   184		kfree(dmemcs);
   185	}
   186	
   187	static struct cgroup_subsys_state *
   188	dmemcs_alloc(struct cgroup_subsys_state *parent_css)
   189	{
   190		struct dmemcg_state *dmemcs = kzalloc(sizeof(*dmemcs), GFP_KERNEL);
   191		if (!dmemcs)
   192			return ERR_PTR(-ENOMEM);
   193	
   194		INIT_LIST_HEAD(&dmemcs->pools);
   195		return &dmemcs->css;
   196	}
   197	
   198	static struct dmem_cgroup_pool_state *
   199	find_cg_pool_locked(struct dmemcg_state *dmemcs, struct dmem_cgroup_region *region)
   200	{
   201		struct dmem_cgroup_pool_state *pool;
   202	
   203		list_for_each_entry_rcu(pool, &dmemcs->pools, css_node, spin_is_locked(&dmemcg_lock))
   204			if (pool->region == region)
   205				return pool;
   206	
   207		return NULL;
   208	}
   209	
   210	static struct dmem_cgroup_pool_state *pool_parent(struct dmem_cgroup_pool_state *pool)
   211	{
   212		if (!pool->cnt.parent)
   213			return NULL;
   214	
   215		return container_of(pool->cnt.parent, typeof(*pool), cnt);
   216	}
   217	
   218	static void
   219	dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
   220					 struct dmem_cgroup_pool_state *test_pool)
   221	{
   222		struct page_counter *climit;
   223		struct cgroup_subsys_state *css, *next_css;
   224		struct dmemcg_state *dmemcg_iter;
   225		struct dmem_cgroup_pool_state *pool, *parent_pool;
   226		bool found_descendant;
   227	
   228		climit = &limit_pool->cnt;
   229	
   230		rcu_read_lock();
   231		parent_pool = pool = limit_pool;
   232		css = &limit_pool->cs->css;
   233	
   234		/*
   235		 * This logic is roughly equivalent to css_foreach_descendant_pre,
   236		 * except we also track the parent pool to find out which pool we need
   237		 * to calculate protection values for.
   238		 *
   239		 * We can stop the traversal once we find test_pool among the
   240		 * descendants since we don't really care about any others.
   241		 */
   242		while (pool != test_pool) {
   243			next_css = css_next_child(NULL, css);
   244			if (next_css) {
   245				parent_pool = pool;
   246			} else {
   247				while (css != &limit_pool->cs->css) {
   248					next_css = css_next_child(css, css->parent);
   249					if (next_css)
   250						break;
   251					css = css->parent;
   252					parent_pool = pool_parent(parent_pool);
   253				}
   254				/*
   255				 * We can only hit this when test_pool is not a
   256				 * descendant of limit_pool.
   257				 */
   258				if (WARN_ON_ONCE(css == &limit_pool->cs->css))
   259					break;
   260			}
   261			css = next_css;
   262	
   263			found_descendant = false;
   264			dmemcg_iter = container_of(css, struct dmemcg_state, css);
   265	
   266			list_for_each_entry_rcu(pool, &dmemcg_iter->pools, css_node) {
   267				if (pool_parent(pool) == parent_pool) {
   268					found_descendant = true;
   269					break;
   270				}
   271			}
   272			if (!found_descendant)
   273				continue;
   274	
 > 275			page_counter_calculate_protection(
   276				climit, &pool->cnt, true);
   277		}
   278		rcu_read_unlock();
   279	}
   280	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

