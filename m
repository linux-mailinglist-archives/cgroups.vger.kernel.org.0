Return-Path: <cgroups+bounces-3036-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED28D289B
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 01:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA932883C5
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994713E8BD;
	Tue, 28 May 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+jemmQP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86413E3E7;
	Tue, 28 May 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937925; cv=none; b=Lu6dbs6B//piOcsZcje7QCJ5B8kNHCxuRdMFpC2Eo3d3+gzYWOudHSPY4r2+PrAQ3RccDrTfuQ/nNoXEZOu0nycpnuhNHjjvsY1gYlQJnu+vyx/ivoHh5OENlnOfGNwcXhKo92TQJawTI/CZKzZV1V5ccbOXK05EXjAsJd0+BQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937925; c=relaxed/simple;
	bh=r77ZwpbD5kVI2FcMc87+IC9CALwP9+VlEff4OSQCUTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJrCgUkUrA4MV2trRlz1ti4CUWsVrPSWZpRiNocrMZMx1bGMqB7q7YeVhFYEfyGZNX7J7s/yu2Anw62L1q1dMyhCEexJjq2wJqD9Ie9CeCWWyubLj+ELpGh2yu6rjdjh5V6d6L6vwlRY4xVqALJ6UV9TI5oRFOb22GnhJ8BzD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+jemmQP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937924; x=1748473924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r77ZwpbD5kVI2FcMc87+IC9CALwP9+VlEff4OSQCUTw=;
  b=g+jemmQPj8jz2jdEfYereQ1G6CliKR3YXH52/+7LulLSB5ifNbawIZ4c
   WKvgVF6hE2UMqzLd1rOTGuyLJ9wxIVtFPj+Py7XweZ/MANNEeRaYmv14O
   ADq4dEeyrdDzWDDqsdlSJOriw8vlDwKktyTmeHiNLgWge2yljW8MY0dbv
   8ROwDe+G+V7WNvalqW/cbRvx0TJukd/G5CIoavlfgv7V+5l8RaMf43v+L
   nNTdNkqU20m1FhV3y4ymepp+BkqTjDW9yyJZFifZfwyuYLysEPZiFLWlH
   enziwmeyMUizwZViwvlc/4Pqm14NSeHL5K1uUkuh4F5+zeSB//pFcVhAl
   A==;
X-CSE-ConnectionGUID: Gjqw0NxeTbCczA5Yk4l9DA==
X-CSE-MsgGUID: McdugWWQR66Hrk9oZvThIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30840753"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30840753"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:12:03 -0700
X-CSE-ConnectionGUID: 9vGfEpv5SSOht6al1I5yBA==
X-CSE-MsgGUID: /P1axXlDR0adAjBrmPJhYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35298493"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 16:11:59 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC5z1-000Cr1-2r;
	Tue, 28 May 2024 23:11:55 +0000
Date: Wed, 29 May 2024 07:11:10 +0800
From: kernel test robot <lkp@intel.com>
To: "T.J. Mercier" <tjmercier@google.com>, mkoutny@suse.com,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: oe-kbuild-all@lists.linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: Remove nr_cgrps
Message-ID: <202405290609.I4LQ4GZ3-lkp@intel.com>
References: <20240528163750.2025330-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528163750.2025330-1-tjmercier@google.com>

Hi Mercier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6fbf71854e2ddea7c99397772fbbb3783bfe15b5]

url:    https://github.com/intel-lab-lkp/linux/commits/T-J-Mercier/cgroup-Remove-nr_cgrps/20240529-004057
base:   6fbf71854e2ddea7c99397772fbbb3783bfe15b5
patch link:    https://lore.kernel.org/r/20240528163750.2025330-1-tjmercier%40google.com
patch subject: [PATCH 2/2] cgroup: Remove nr_cgrps
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240529/202405290609.I4LQ4GZ3-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290609.I4LQ4GZ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290609.I4LQ4GZ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'cgroup_setup_root':
>> kernel/cgroup/cgroup.c:2071:31: warning: variable 'ss' set but not used [-Wunused-but-set-variable]
    2071 |         struct cgroup_subsys *ss;
         |                               ^~


vim +/ss +2071 kernel/cgroup/cgroup.c

  2065	
  2066	int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
  2067	{
  2068		LIST_HEAD(tmp_links);
  2069		struct cgroup *root_cgrp = &root->cgrp;
  2070		struct kernfs_syscall_ops *kf_sops;
> 2071		struct cgroup_subsys *ss;
  2072		struct css_set *cset;
  2073		int i, ret;
  2074	
  2075		lockdep_assert_held(&cgroup_mutex);
  2076	
  2077		ret = percpu_ref_init(&root_cgrp->self.refcnt, css_release,
  2078				      0, GFP_KERNEL);
  2079		if (ret)
  2080			goto out;
  2081	
  2082		/*
  2083		 * We're accessing css_set_count without locking css_set_lock here,
  2084		 * but that's OK - it can only be increased by someone holding
  2085		 * cgroup_lock, and that's us.  Later rebinding may disable
  2086		 * controllers on the default hierarchy and thus create new csets,
  2087		 * which can't be more than the existing ones.  Allocate 2x.
  2088		 */
  2089		ret = allocate_cgrp_cset_links(2 * css_set_count, &tmp_links);
  2090		if (ret)
  2091			goto cancel_ref;
  2092	
  2093		ret = cgroup_init_root_id(root);
  2094		if (ret)
  2095			goto cancel_ref;
  2096	
  2097		kf_sops = root == &cgrp_dfl_root ?
  2098			&cgroup_kf_syscall_ops : &cgroup1_kf_syscall_ops;
  2099	
  2100		root->kf_root = kernfs_create_root(kf_sops,
  2101						   KERNFS_ROOT_CREATE_DEACTIVATED |
  2102						   KERNFS_ROOT_SUPPORT_EXPORTOP |
  2103						   KERNFS_ROOT_SUPPORT_USER_XATTR,
  2104						   root_cgrp);
  2105		if (IS_ERR(root->kf_root)) {
  2106			ret = PTR_ERR(root->kf_root);
  2107			goto exit_root_id;
  2108		}
  2109		root_cgrp->kn = kernfs_root_to_node(root->kf_root);
  2110		WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
  2111		root_cgrp->ancestors[0] = root_cgrp;
  2112	
  2113		ret = css_populate_dir(&root_cgrp->self);
  2114		if (ret)
  2115			goto destroy_root;
  2116	
  2117		ret = cgroup_rstat_init(root_cgrp);
  2118		if (ret)
  2119			goto destroy_root;
  2120	
  2121		ret = rebind_subsystems(root, ss_mask);
  2122		if (ret)
  2123			goto exit_stats;
  2124	
  2125		ret = cgroup_bpf_inherit(root_cgrp);
  2126		WARN_ON_ONCE(ret);
  2127	
  2128		trace_cgroup_setup_root(root);
  2129	
  2130		/*
  2131		 * There must be no failure case after here, since rebinding takes
  2132		 * care of subsystems' refcounts, which are explicitly dropped in
  2133		 * the failure exit path.
  2134		 */
  2135		list_add_rcu(&root->root_list, &cgroup_roots);
  2136		cgroup_root_count++;
  2137	
  2138		/*
  2139		 * Link the root cgroup in this hierarchy into all the css_set
  2140		 * objects.
  2141		 */
  2142		spin_lock_irq(&css_set_lock);
  2143		hash_for_each(css_set_table, i, cset, hlist) {
  2144			link_css_set(&tmp_links, cset, root_cgrp);
  2145			if (css_set_populated(cset))
  2146				cgroup_update_populated(root_cgrp, true);
  2147		}
  2148		spin_unlock_irq(&css_set_lock);
  2149	
  2150		BUG_ON(!list_empty(&root_cgrp->self.children));
  2151		do_each_subsys_mask(ss, i, ss_mask) {
  2152			BUG_ON(atomic_read(&root->nr_css[i]) != 1);
  2153		} while_each_subsys_mask();
  2154	
  2155		ret = 0;
  2156		goto out;
  2157	
  2158	exit_stats:
  2159		cgroup_rstat_exit(root_cgrp);
  2160	destroy_root:
  2161		kernfs_destroy_root(root->kf_root);
  2162		root->kf_root = NULL;
  2163	exit_root_id:
  2164		cgroup_exit_root_id(root);
  2165	cancel_ref:
  2166		percpu_ref_exit(&root_cgrp->self.refcnt);
  2167	out:
  2168		free_cgrp_cset_links(&tmp_links);
  2169		return ret;
  2170	}
  2171	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

