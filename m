Return-Path: <cgroups+bounces-15583-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hqBKNiWt92lwkwIAu9opvQ
	(envelope-from <cgroups+bounces-15583-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 22:16:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC934B73F4
	for <lists+cgroups@lfdr.de>; Sun, 03 May 2026 22:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB5C300DE37
	for <lists+cgroups@lfdr.de>; Sun,  3 May 2026 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67CC37C910;
	Sun,  3 May 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KffNInIP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE437996C;
	Sun,  3 May 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839390; cv=none; b=D8q9Ik14DFdL9jZKvg56flKd4UPVlINZP/1siEVUCbGUGnaot9LksQMEtX4XFPF/vNwKg3cbL4SaL4jTFCOJVVA+sOYgsPH/oETyhpsOdI/joy/bLjSj3lthVlNe2N8YovpXrzmZGMLBHly1GaZTLP2E+g8xLoappvtGrNtEZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839390; c=relaxed/simple;
	bh=7sTrUsryfvyq0F5rlvo82fdI2yzv2sNghEcPFvzgBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpVucYrXL0/EVkS7gCubdaBQkC4COCqdTVciBSc9ZsmpyD6AyUyZE3M/Yb1y++ONHnuJWfIpq+usMq8wgaqhxqRbJNlb0vmZIow/oxHWauIeR9dWWgLF5mW5zdAMUzv/oR4XvZxkCQNyXAYgvvgE39BFcCrHbK+KrDyefsL8i8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KffNInIP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777839386; x=1809375386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7sTrUsryfvyq0F5rlvo82fdI2yzv2sNghEcPFvzgBKQ=;
  b=KffNInIPzUykesY4A5WVal2BvEcGp/xYjlfiCOS19XV/gsx1Q8ZXs+gq
   V6MtlsfOxJqKxPA4IEsA2SYWVSLllvgCVZx3P6zIJQad8w7u7wPH5VHHa
   MbPEFfOE6Ab2iE9guaytQSRdr3ViaSYt7/2VkrJBtDpeVKiD/S8YBRqyi
   dN2s/fLz+0rCHlG0ogKQ4IWR7yWv9ya7Ko/lL579rtSR+MhJsaHBCcxS1
   ugHYbxEN+BVhR0V5kU0cuPxMiW5QyJ7PLscdzsYw0fwQUD2r8X1z/4oZD
   Zcp4Ug3SmiAhredLnETT98w2n3NneqiMkSlaLuC0B3tak/fTlC+/sxToj
   Q==;
X-CSE-ConnectionGUID: f1p7+BR8TK+zNwZUxjyM6g==
X-CSE-MsgGUID: NC9zo52cSJGzfqP+6hcpJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="96276049"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="96276049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 13:16:19 -0700
X-CSE-ConnectionGUID: QRnTZKZjSkCXwfGV0xUQrQ==
X-CSE-MsgGUID: YNGCp4LRSsa7+0IZqQsvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="228841291"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 May 2026 13:16:17 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJdEP-0000000030P-1JiC;
	Sun, 03 May 2026 20:16:07 +0000
Date: Mon, 4 May 2026 04:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>, Martin Pitt <martin@piware.de>
Cc: oe-kbuild-all@lists.linux.dev, regressions@lists.linux.dev,
	cgroups@vger.kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] cgroup: Defer css percpu_ref kill on rmdir until cgroup
 is depopulated
Message-ID: <202605040408.yt7xcKug-lkp@intel.com>
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
X-Rspamd-Queue-Id: 2EC934B73F4
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
	TAGGED_FROM(0.00)[bounces-15583-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]

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
config: powerpc-randconfig-r071-20260504 (https://download.01.org/0day-ci/archive/20260504/202605040408.yt7xcKug-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9065-ge9cc34fd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260504/202605040408.yt7xcKug-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605040408.yt7xcKug-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'cgroup_apply_control_disable':
   kernel/cgroup/cgroup.c:3391:5: error: implicit declaration of function 'kill_css_sync'; did you mean 'kill_fasync'? [-Werror=implicit-function-declaration]
        kill_css_sync(css);
        ^~~~~~~~~~~~~
        kill_fasync
   kernel/cgroup/cgroup.c:3392:5: error: implicit declaration of function 'kill_css_finish'; did you mean 'kill_cad_pid'? [-Werror=implicit-function-declaration]
        kill_css_finish(css);
        ^~~~~~~~~~~~~~~
        kill_cad_pid
   kernel/cgroup/cgroup.c: At top level:
>> kernel/cgroup/cgroup.c:6047:13: warning: conflicting types for 'kill_css_sync'
    static void kill_css_sync(struct cgroup_subsys_state *css)
                ^~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6047:13: error: static declaration of 'kill_css_sync' follows non-static declaration
   kernel/cgroup/cgroup.c:3391:5: note: previous implicit declaration of 'kill_css_sync' was here
        kill_css_sync(css);
        ^~~~~~~~~~~~~
>> kernel/cgroup/cgroup.c:6087:13: warning: conflicting types for 'kill_css_finish'
    static void kill_css_finish(struct cgroup_subsys_state *css)
                ^~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6087:13: error: static declaration of 'kill_css_finish' follows non-static declaration
   kernel/cgroup/cgroup.c:3392:5: note: previous implicit declaration of 'kill_css_finish' was here
        kill_css_finish(css);
        ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kill_css_sync +6047 kernel/cgroup/cgroup.c

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

