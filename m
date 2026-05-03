Return-Path: <cgroups+bounces-15582-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INLkAJGj92nXjwIAu9opvQ
	(envelope-from <cgroups+bounces-15582-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 21:35:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531044B727E
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 21:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E158F300CC1E
	for <lists+cgroups@lfdr.de>; Sun,  3 May 2026 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405DD311968;
	Sun,  3 May 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f72OfGU0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E637700A;
	Sun,  3 May 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836755; cv=none; b=HfWw8hYaf6rm9DnDueV9Ae35oU9xYBu/Eav5iLSIN8M9v1zM4Bj/bcE++Dih2d7W8gljGohHVUtO8hwlGXC9iuz+89q8+qqvbuHBdkpHiE8MOXX8ZgEJDjwmNFe+A+ysoz1Hc/yvq3M18DXdfXC4Se5bfmmtDAE/F6fc8v5qSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836755; c=relaxed/simple;
	bh=PJgmPFGMNo+aUZU7RYDsZtYKqYVzGFJCD9AzjJlTtJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIL43iZDPnkI1H7pmjmVu1AUrAK/LZnISQaO1JMeTi6/t5aiGs85qrby5bKU/SvGgjC7uYWuTEYH7xIPFi9tcm70BWiWQgMq+rZiAMxvmmTX+Y6KGu22GPHh101ib8xpUZYg4Xd5ErXWSROvJJLUBuTD7FCfEKUFdTUvBaEBDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f72OfGU0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777836754; x=1809372754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJgmPFGMNo+aUZU7RYDsZtYKqYVzGFJCD9AzjJlTtJo=;
  b=f72OfGU0Q1GK3yYoAR4/JLPzYcadbrFhqQdnP9H1g9y8PqdR05lNNan+
   hJ4I1WmV0RwSQBOoRq07WP++1472ASgGyLs2LEmU6AQ993TsEFoJqFzHO
   vrPLG6/A2r2zTtz+F16ayE8vY2IiPk09uXyhxEgi4Q74sQJMIl+7zjUJf
   V3/+zd/KIoLtCIkudxMyVVrgJhzHMXzBa6knF8eevdoe0bS7/A6DDLgho
   /ZulitCbKPV71CGC1XzGlH5k9RI32Qb+P/K3ymOPd0v6azVqzoUW2QZBt
   5ik5OkWdqxyua/PugEW9w6leVK3DRkpE9Bk8Q4waiMTcSJ9OgrdjKRDUU
   A==;
X-CSE-ConnectionGUID: ucldw1glT4e9QuwBp1fzZQ==
X-CSE-MsgGUID: yLUn75ZkSWGbDjj5zvrVNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78905024"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="78905024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 12:32:33 -0700
X-CSE-ConnectionGUID: Da0YIf2qRoG6zrFi3p71Zw==
X-CSE-MsgGUID: xIySiJImSBqll0oDzWNHyQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 May 2026 12:32:31 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJcY3-000000002wP-3Loe;
	Sun, 03 May 2026 19:32:19 +0000
Date: Mon, 4 May 2026 03:30:48 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>, Martin Pitt <martin@piware.de>
Cc: oe-kbuild-all@lists.linux.dev, regressions@lists.linux.dev,
	cgroups@vger.kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] cgroup: Defer css percpu_ref kill on rmdir until cgroup
 is depopulated
Message-ID: <202605040315.QbFTzfWy-lkp@intel.com>
References: <20260501022943.3714461-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501022943.3714461-1-tj@kernel.org>
X-Rspamd-Queue-Id: 531044B727E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-15582-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]

Hi Tejun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on linus/master next-20260430]
[cannot apply to v7.1-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/cgroup-Defer-css-percpu_ref-kill-on-rmdir-until-cgroup-is-depopulated/20260503-165802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20260501022943.3714461-1-tj%40kernel.org
patch subject: [PATCH] cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260504/202605040315.QbFTzfWy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260504/202605040315.QbFTzfWy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605040315.QbFTzfWy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'cgroup_apply_control_disable':
   kernel/cgroup/cgroup.c:3391:33: error: implicit declaration of function 'kill_css_sync'; did you mean 'kill_fasync'? [-Wimplicit-function-declaration]
    3391 |                                 kill_css_sync(css);
         |                                 ^~~~~~~~~~~~~
         |                                 kill_fasync
   kernel/cgroup/cgroup.c:3392:33: error: implicit declaration of function 'kill_css_finish' [-Wimplicit-function-declaration]
    3392 |                                 kill_css_finish(css);
         |                                 ^~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: At top level:
>> kernel/cgroup/cgroup.c:6047:13: warning: conflicting types for 'kill_css_sync'; have 'void(struct cgroup_subsys_state *)'
    6047 | static void kill_css_sync(struct cgroup_subsys_state *css)
         |             ^~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6047:13: error: static declaration of 'kill_css_sync' follows non-static declaration
   kernel/cgroup/cgroup.c:3391:33: note: previous implicit declaration of 'kill_css_sync' with type 'void(struct cgroup_subsys_state *)'
    3391 |                                 kill_css_sync(css);
         |                                 ^~~~~~~~~~~~~
>> kernel/cgroup/cgroup.c:6087:13: warning: conflicting types for 'kill_css_finish'; have 'void(struct cgroup_subsys_state *)'
    6087 | static void kill_css_finish(struct cgroup_subsys_state *css)
         |             ^~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6087:13: error: static declaration of 'kill_css_finish' follows non-static declaration
   kernel/cgroup/cgroup.c:3392:33: note: previous implicit declaration of 'kill_css_finish' with type 'void(struct cgroup_subsys_state *)'
    3392 |                                 kill_css_finish(css);
         |                                 ^~~~~~~~~~~~~~~


vim +6047 kernel/cgroup/cgroup.c

  6040	
  6041	/**
  6042	 * kill_css_sync - synchronous half of css teardown
  6043	 * @css: css being killed
  6044	 *
  6045	 * See cgroup_destroy_locked().
  6046	 */
> 6047	static void kill_css_sync(struct cgroup_subsys_state *css)
  6048	{
  6049		struct cgroup_subsys *ss = css->ss;
  6050	
  6051		lockdep_assert_held(&cgroup_mutex);
  6052	
  6053		if (css->flags & CSS_DYING)
  6054			return;
  6055	
  6056		/*
  6057		 * Call css_killed(), if defined, before setting the CSS_DYING flag
  6058		 */
  6059		if (css->ss->css_killed)
  6060			css->ss->css_killed(css);
  6061	
  6062		css->flags |= CSS_DYING;
  6063	
  6064		/*
  6065		 * This must happen before css is disassociated with its cgroup.
  6066		 * See seq_css() for details.
  6067		 */
  6068		css_clear_dir(css);
  6069	
  6070		css->cgroup->nr_dying_subsys[ss->id]++;
  6071		/*
  6072		 * Parent css and cgroup cannot be freed until after the freeing
  6073		 * of child css, see css_free_rwork_fn().
  6074		 */
  6075		while ((css = css->parent)) {
  6076			css->nr_descendants--;
  6077			css->cgroup->nr_dying_subsys[ss->id]++;
  6078		}
  6079	}
  6080	
  6081	/**
  6082	 * kill_css_finish - deferred half of css teardown
  6083	 * @css: css being killed
  6084	 *
  6085	 * See cgroup_destroy_locked().
  6086	 */
> 6087	static void kill_css_finish(struct cgroup_subsys_state *css)
  6088	{
  6089		lockdep_assert_held(&cgroup_mutex);
  6090	
  6091		/*
  6092		 * Skip on re-entry: cgroup_apply_control_disable() may have killed @css
  6093		 * earlier. cgroup_destroy_locked() can still walk it because
  6094		 * offline_css() (which NULLs cgrp->subsys[ssid]) runs async.
  6095		 */
  6096		if (percpu_ref_is_dying(&css->refcnt))
  6097			return;
  6098	
  6099		/*
  6100		 * Killing would put the base ref, but we need to keep it alive until
  6101		 * after ->css_offline().
  6102		 */
  6103		css_get(css);
  6104	
  6105		/*
  6106		 * cgroup core guarantees that, by the time ->css_offline() is invoked,
  6107		 * no new css reference will be given out via css_tryget_online(). We
  6108		 * can't simply call percpu_ref_kill() and proceed to offlining css's
  6109		 * because percpu_ref_kill() doesn't guarantee that the ref is seen as
  6110		 * killed on all CPUs on return.
  6111		 *
  6112		 * Use percpu_ref_kill_and_confirm() to get notifications as each css is
  6113		 * confirmed to be seen as killed on all CPUs.
  6114		 */
  6115		percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
  6116	}
  6117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

