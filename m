Return-Path: <cgroups+bounces-6601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB90A3B611
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 10:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CE3189B26B
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1681DED5C;
	Wed, 19 Feb 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIHcVAql"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5731DE3BB
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955065; cv=none; b=OdDvm5PDsqrPnRSyUORSviDNcoWPv8f1oRwKbuCSHrUvG/bpwpIRmoB3r/avaT+7x3Cr7SMMY3JLwHmsTxv0tZCASPyhOGw6R7IfCaB46Cxvp9vxT8MqPkDBQKNEb68BsfF3jku8BGmd+5Oir5MHQlOK0g0K56O0Kew62VVLfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955065; c=relaxed/simple;
	bh=hbSqsiykuNDWOokYPnx5zxrp0p4HqkViEANBANJlSFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoqHIkK1qQTmuSPwB5miQWn0xw9g6kPO+gtM0bjcWGaKIG7U9eVlPfKMKX6B2ErSm+y4Fs07un26WfcboXe039YteMalKWC707gFAy3tvgMxCzcVUZ1nlwnXGrzE17wIG0zQL+X7u9x0lthcReDYL4qjkBtxOyyi7RXjU9x0sds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIHcVAql; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739955063; x=1771491063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbSqsiykuNDWOokYPnx5zxrp0p4HqkViEANBANJlSFs=;
  b=TIHcVAqlb7PwBaQAJtms7SHEaJPvDSdYeNodntS2f915ip8d7CWjAPlv
   EcUMPMdIms6/tIq3wECZHh0CCIdJ7NJtvVDfPX8ZIXsm4KBXmbGhu9v4e
   YGVTexwrlNr0LsGdnSB90XVluHfqRSq/wqHOfNNx15Y77ybM1DtjbF4TW
   3RBKPd5HVg2jsHPRwFlsa3gtFCiDiex/Z9XUmCnO6a8EhvTCkLPd2WU/D
   laemIysiGII9+hYp3fDMDlYfWtsSHH9kIa00b8UzodJMa2YI/Z30hJCVZ
   xm8n9xsnSvbykXYqKAhrw+zLvE5pY+odsgq9ZPQ4SyeEhoh0SVhu5zzqe
   Q==;
X-CSE-ConnectionGUID: Aq97VrlVSze5BgR1iu2Hog==
X-CSE-MsgGUID: /ZfTjZ97STun7RqPq02mdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51323284"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="51323284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 00:50:29 -0800
X-CSE-ConnectionGUID: zwUy2+s6Qiiluj1yN7OmHA==
X-CSE-MsgGUID: xDmN3XvTSOKjgikhTWzITw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119631744"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2025 00:50:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkfmh-0001d1-0i;
	Wed, 19 Feb 2025 08:50:23 +0000
Date: Wed, 19 Feb 2025 16:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
	tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 08/11] cgroup: rstat cpu lock indirection
Message-ID: <202502191619.0t8nOsuQ-lkp@intel.com>
References: <20250218031448.46951-9-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-9-inwardvessel@gmail.com>

Hi JP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn/cgroup-move-rstat-pointers-into-struct-of-their-own/20250218-111725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250218031448.46951-9-inwardvessel%40gmail.com
patch subject: [PATCH 08/11] cgroup: rstat cpu lock indirection
config: arc-randconfig-002-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191619.0t8nOsuQ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191619.0t8nOsuQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191619.0t8nOsuQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/rstat.c:266: warning: Function parameter or struct member 'ops' not described in 'cgroup_rstat_push_children'
   kernel/cgroup/rstat.c:326: warning: Function parameter or struct member 'ops' not described in 'cgroup_rstat_updated_list'
>> kernel/cgroup/rstat.c:326: warning: Function parameter or struct member 'cpu_lock' not described in 'cgroup_rstat_updated_list'
   kernel/cgroup/rstat.c:532: warning: Function parameter or struct member 'ops' not described in '__cgroup_rstat_flush_release'
>> kernel/cgroup/rstat.c:532: warning: Function parameter or struct member 'lock' not described in '__cgroup_rstat_flush_release'
   kernel/cgroup/rstat.c:532: warning: expecting prototype for cgroup_rstat_flush_release(). Prototype was for __cgroup_rstat_flush_release() instead


vim +326 kernel/cgroup/rstat.c

d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  304  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  305  /**
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  306   * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  307   * @root: root of the cgroup subtree to traverse
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  308   * @cpu: target cpu
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  309   * Return: A singly linked list of cgroups to be flushed
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  310   *
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  311   * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  312   * each returned cgroup is unlinked from the updated tree.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  313   *
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  314   * The only ordering guarantee is that, for a parent and a child pair
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  315   * covered by a given traversal, the child is before its parent in
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  316   * the list.
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  317   *
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  318   * Note that updated_children is self terminated and points to a list of
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  319   * child cgroups if not empty. Whereas updated_next is like a sibling link
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  320   * within the children list and terminated by the parent cgroup. An exception
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  321   * here is the cgroup root whose updated_next can be self terminated.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  322   */
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  323  static struct cgroup_rstat *cgroup_rstat_updated_list(
85c7ff288b9391 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  324  		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops,
85c7ff288b9391 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  325  		raw_spinlock_t *cpu_lock)
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25 @326  {
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  327  	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  328  	struct cgroup_rstat *head = NULL, *parent, *child;
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  329  	struct cgroup *cgrp;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  330  	unsigned long flags;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  331  
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  332  	cgrp = ops->cgroup_fn(root);
85c7ff288b9391 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  333  	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  334  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  335  	/* Return NULL if this subtree is not on-list */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  336  	if (!rstatc->updated_next)
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  337  		goto unlock_ret;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  338  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  339  	/*
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  340  	 * Unlink @root from its parent. As the updated_children list is
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  341  	 * singly linked, we have to walk it to find the removal point.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  342  	 */
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  343  	parent = ops->parent_fn(root);
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  344  	if (parent) {
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  345  		struct cgroup_rstat_cpu *prstatc;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  346  		struct cgroup_rstat **nextp;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  347  
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  348  		prstatc = rstat_cpu(parent, cpu);
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  349  		nextp = &prstatc->updated_children;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  350  		while (*nextp != root) {
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  351  			struct cgroup_rstat_cpu *nrstatc;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  352  
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  353  			nrstatc = rstat_cpu(*nextp, cpu);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  354  			WARN_ON_ONCE(*nextp == parent);
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  355  			nextp = &nrstatc->updated_next;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  356  		}
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  357  		*nextp = rstatc->updated_next;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  358  	}
9a9e97b2f1f27e kernel/cgroup/rstat.c Tejun Heo       2018-04-26  359  
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  360  	rstatc->updated_next = NULL;
e76d28bdf9ba53 kernel/cgroup/rstat.c Waiman Long     2023-11-03  361  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  362  	/* Push @root to the list first before pushing the children */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  363  	head = root;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  364  	root->rstat_flush_next = NULL;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  365  	child = rstatc->updated_children;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  366  	rstatc->updated_children = root;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  367  	if (child != root)
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  368  		head = cgroup_rstat_push_children(head, child, cpu, ops);
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  369  unlock_ret:
85c7ff288b9391 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  370  	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
e76d28bdf9ba53 kernel/cgroup/rstat.c Waiman Long     2023-11-03  371  	return head;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  372  }
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  373  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

