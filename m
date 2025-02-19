Return-Path: <cgroups+bounces-6600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBFA3B238
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 08:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0219E16A220
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EADC1BBBDC;
	Wed, 19 Feb 2025 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cok/vA95"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC91A9B5D
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949759; cv=none; b=H+vfk4zw8gfs+ZyX+mh9mD+NgOphn9+Ai+lrSof+uqtcUDfG9eIXWwYha8IvK+9+alQ6JgSE1H4zSSQDKGb63WMfIC6qNks2Hyk4q5OUQRd4EDvrzndg6KFVkvl73buj2xNKKb1WxTIWaFAKo1Kk1FIF0b6pQEwxPc8bFzJvVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949759; c=relaxed/simple;
	bh=eG7Opms5bxKXHu4QwYtttvZV/gOZn8yV8H4ck1U/Qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlFVkMnB9jFl0Ltj9dP1J+W27H9x6FX1cKQwXlnSLXZzmUKY/7fygLZMpnQQb2vxzLONxkl0v6Ahxp5n+2XQ4NeALV2jCIsCCqHqa5XIaG0EAmggoNnW+uhvlyt/E6o3bG2pUQLnVLciaWtkDxDPP6xmILmboIGVysxd48l4nhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cok/vA95; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739949757; x=1771485757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eG7Opms5bxKXHu4QwYtttvZV/gOZn8yV8H4ck1U/Qsk=;
  b=cok/vA95CAUptTJQz6cetNUhw3L/+9PRmMBMSirk9P+zq4YBJ7KAoXR6
   3GLCO+oFo2m9UsHffNoCLgCC6KBNszEJQb9j+XmPfv3HPTmI1oLP5faWm
   PeGfH6Tc7Z+zim4gGTqu/Xhs5iVmhPlK0bHc3z/j5Tbk07KZMdNe8zDDZ
   HH/uRq9skX++0mWSEebokESiCGJQw/ZrAWKsXSxvFtmGRB92vjOhrEAHn
   uhlJB4lDoCoJk4F57BN//XZSx6YZLm7uw1hiSdnurHjWGW5WQR1hB5PDk
   kttdS3UiOfcRr9PALYDGbYIaM9ikdboiniaz9dxEDZfhubyVN+lH1xgMJ
   w==;
X-CSE-ConnectionGUID: eROOXvASRUCr4VdzOjLZgA==
X-CSE-MsgGUID: WXBObcffSMukbojWfiflwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44322292"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="44322292"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 23:22:36 -0800
X-CSE-ConnectionGUID: sfFSKR1ZSW2a2xM4czPbBg==
X-CSE-MsgGUID: HjLPVzB2QV6DOny0ngffrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="115147883"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Feb 2025 23:22:33 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkePZ-0001Lz-1d;
	Wed, 19 Feb 2025 07:22:26 +0000
Date: Wed, 19 Feb 2025 15:21:05 +0800
From: kernel test robot <lkp@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
	tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/11] cgroup: introduce cgroup_rstat_ops
Message-ID: <202502191558.xCTZRkPs-lkp@intel.com>
References: <20250218031448.46951-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-5-inwardvessel@gmail.com>

Hi JP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn/cgroup-move-rstat-pointers-into-struct-of-their-own/20250218-111725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250218031448.46951-5-inwardvessel%40gmail.com
patch subject: [PATCH 04/11] cgroup: introduce cgroup_rstat_ops
config: arc-randconfig-002-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191558.xCTZRkPs-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191558.xCTZRkPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191558.xCTZRkPs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:210: warning: Function parameter or struct member 'ops' not described in 'cgroup_rstat_push_children'
>> kernel/cgroup/rstat.c:269: warning: Function parameter or struct member 'ops' not described in 'cgroup_rstat_updated_list'
>> kernel/cgroup/rstat.c:465: warning: Function parameter or struct member 'ops' not described in '__cgroup_rstat_flush_release'
   kernel/cgroup/rstat.c:465: warning: expecting prototype for cgroup_rstat_flush_release(). Prototype was for __cgroup_rstat_flush_release() instead


vim +210 kernel/cgroup/rstat.c

3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  194  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  195  /**
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  196   * cgroup_rstat_push_children - push children cgroups into the given list
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  197   * @head: current head of the list (= subtree root)
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  198   * @child: first child of the root
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  199   * @cpu: target cpu
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  200   * Return: A new singly linked list of cgroups to be flush
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  201   *
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  202   * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  203   * level and push all the parents first before their next level children
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  204   * into a singly linked list built from the tail backward like "pushing"
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  205   * cgroups into a stack. The root is pushed by the caller.
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  206   */
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  207  static struct cgroup_rstat *cgroup_rstat_push_children(
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  208  	struct cgroup_rstat *head, struct cgroup_rstat *child, int cpu,
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  209  	struct cgroup_rstat_ops *ops)
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30 @210  {
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  211  	struct cgroup_rstat *chead = child;	/* Head of child cgroup level */
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  212  	struct cgroup_rstat *ghead = NULL;	/* Head of grandchild cgroup level */
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  213  	struct cgroup_rstat *parent, *grandchild;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  214  	struct cgroup_rstat_cpu *crstatc;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  215  
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  216  	child->rstat_flush_next = NULL;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  217  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  218  next_level:
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  219  	while (chead) {
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  220  		child = chead;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  221  		chead = child->rstat_flush_next;
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  222  		parent = ops->parent_fn(child);
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  223  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  224  		/* updated_next is parent cgroup terminated */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  225  		while (child != parent) {
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  226  			child->rstat_flush_next = head;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  227  			head = child;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  228  			crstatc = rstat_cpu(child, cpu);
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  229  			grandchild = crstatc->updated_children;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  230  			if (grandchild != child) {
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  231  				/* Push the grand child to the next level */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  232  				crstatc->updated_children = child;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  233  				grandchild->rstat_flush_next = ghead;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  234  				ghead = grandchild;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  235  			}
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  236  			child = crstatc->updated_next;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  237  			crstatc->updated_next = NULL;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  238  		}
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  239  	}
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  240  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  241  	if (ghead) {
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  242  		chead = ghead;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  243  		ghead = NULL;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  244  		goto next_level;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  245  	}
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  246  	return head;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  247  }
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  248  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  249  /**
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  250   * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  251   * @root: root of the cgroup subtree to traverse
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  252   * @cpu: target cpu
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  253   * Return: A singly linked list of cgroups to be flushed
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  254   *
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  255   * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  256   * each returned cgroup is unlinked from the updated tree.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  257   *
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  258   * The only ordering guarantee is that, for a parent and a child pair
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  259   * covered by a given traversal, the child is before its parent in
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  260   * the list.
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  261   *
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  262   * Note that updated_children is self terminated and points to a list of
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  263   * child cgroups if not empty. Whereas updated_next is like a sibling link
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  264   * within the children list and terminated by the parent cgroup. An exception
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  265   * here is the cgroup root whose updated_next can be self terminated.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  266   */
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  267  static struct cgroup_rstat *cgroup_rstat_updated_list(
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  268  		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops)
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25 @269  {
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  270  	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  271  	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  272  	struct cgroup_rstat *head = NULL, *parent, *child;
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  273  	struct cgroup *cgrp;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  274  	unsigned long flags;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  275  
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  276  	cgrp = ops->cgroup_fn(root);
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  277  	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  278  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  279  	/* Return NULL if this subtree is not on-list */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  280  	if (!rstatc->updated_next)
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  281  		goto unlock_ret;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  282  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  283  	/*
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  284  	 * Unlink @root from its parent. As the updated_children list is
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  285  	 * singly linked, we have to walk it to find the removal point.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  286  	 */
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  287  	parent = ops->parent_fn(root);
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  288  	if (parent) {
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  289  		struct cgroup_rstat_cpu *prstatc;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  290  		struct cgroup_rstat **nextp;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  291  
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  292  		prstatc = rstat_cpu(parent, cpu);
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  293  		nextp = &prstatc->updated_children;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  294  		while (*nextp != root) {
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  295  			struct cgroup_rstat_cpu *nrstatc;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  296  
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  297  			nrstatc = rstat_cpu(*nextp, cpu);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  298  			WARN_ON_ONCE(*nextp == parent);
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  299  			nextp = &nrstatc->updated_next;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  300  		}
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  301  		*nextp = rstatc->updated_next;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  302  	}
9a9e97b2f1f27e kernel/cgroup/rstat.c Tejun Heo       2018-04-26  303  
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  304  	rstatc->updated_next = NULL;
e76d28bdf9ba53 kernel/cgroup/rstat.c Waiman Long     2023-11-03  305  
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  306  	/* Push @root to the list first before pushing the children */
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  307  	head = root;
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  308  	root->rstat_flush_next = NULL;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  309  	child = rstatc->updated_children;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  310  	rstatc->updated_children = root;
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  311  	if (child != root)
d67ed623c585f2 kernel/cgroup/rstat.c JP Kobryn       2025-02-17  312  		head = cgroup_rstat_push_children(head, child, cpu, ops);
d499fd418fa159 kernel/cgroup/rstat.c Waiman Long     2023-11-30  313  unlock_ret:
3d844899ba042a kernel/cgroup/rstat.c JP Kobryn       2025-02-17  314  	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
e76d28bdf9ba53 kernel/cgroup/rstat.c Waiman Long     2023-11-03  315  	return head;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  316  }
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  317  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

