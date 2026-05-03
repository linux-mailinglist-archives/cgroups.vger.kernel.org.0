Return-Path: <cgroups+bounces-15584-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S9xfFR7Q92nUmQIAu9opvQ
	(envelope-from <cgroups+bounces-15584-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 00:45:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301D4B7B5B
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 00:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A85D3001466
	for <lists+cgroups@lfdr.de>; Sun,  3 May 2026 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67873B2FD0;
	Sun,  3 May 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkacReHF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A773A7851;
	Sun,  3 May 2026 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777848348; cv=none; b=r8xT0aYAtG7aGoxL5Hura+03DKHyiL9WCpcbyljFP6Iu50vZBUjUBlXJv93/lx9PKqHILkG6BcKbuI8RwR7zpPw5kaiWmYgHoGOidDcDbQQbd3wheJWWb0D2tc4GSc22TE5CypsesOJmIxKQq80RFpEIXuubTlgFo+Pv0UmP+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777848348; c=relaxed/simple;
	bh=AAyHbzBvyL2UV1y21LRWM37ouRKjbIPd9+CyuyXeHQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkd9szJeaD46POJmIceLslCzESfcBtc9zNdYQo7CWIuIta0q1RlzPTww3q5zbIRjuZzqmxR+2GobQaFjfXCJg1iEWJnK++YdCmgO80GYi/cIemgxRPB4Y1J0nxuWVeoDKfrdnxg2Y6J5cuMIQTPSw4p/Aed5k6ZTKwSCy6wZzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkacReHF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777848346; x=1809384346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AAyHbzBvyL2UV1y21LRWM37ouRKjbIPd9+CyuyXeHQk=;
  b=PkacReHF3CzOge6dnplYxrDQKCiB7q0UDAycftKEnAmMpjLHiA0QG1OD
   1dqe8ln9/f/k+3VZN5g9c97rfrS+5fTtm3Zhd94EVvFpQG9ILPEjXBMCO
   dpEL94opI+9wAOvaZt7+xcoTTFVMtv4oF7YkjLDwGNt2oi0l+lXR3/MXt
   0HAePHo3PNXLJjHKjJA9urts8YccBmH59e4RpXhwkE0iq0rfev9P+HNad
   ad+80yhyQgeUS8koLVWB9ZesofH9wTif+hqy4v82ngJIs07XoaDu8nRpA
   FtZCaUOivDxmtRb41rh0igYhkWR7pnIp/sNztt/+iDFF/tq5wBM0kLA4d
   g==;
X-CSE-ConnectionGUID: LcN4m+TdSiW4FdzfKAPH/w==
X-CSE-MsgGUID: TgQZPPUcR1KKzjgScd15YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78576160"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="78576160"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 15:45:46 -0700
X-CSE-ConnectionGUID: 5u+0s58jQ1mAlsnmNdb2bA==
X-CSE-MsgGUID: GZvdY1OqTd6tpK5FJD24cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="258996776"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 May 2026 15:45:43 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJfZ6-0000000038f-0moS;
	Sun, 03 May 2026 22:45:34 +0000
Date: Mon, 4 May 2026 06:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>, Martin Pitt <martin@piware.de>
Cc: oe-kbuild-all@lists.linux.dev, regressions@lists.linux.dev,
	cgroups@vger.kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] cgroup: Defer css percpu_ref kill on rmdir until cgroup
 is depopulated
Message-ID: <202605040655.KI0GsBVb-lkp@intel.com>
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
X-Rspamd-Queue-Id: 0301D4B7B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-15584-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]

Hi Tejun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on linus/master next-20260430]
[cannot apply to v7.1-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/cgroup-Defer-css-percpu_ref-kill-on-rmdir-until-cgroup-is-depopulated/20260503-165802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20260501022943.3714461-1-tj%40kernel.org
patch subject: [PATCH] cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260504/202605040655.KI0GsBVb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260504/202605040655.KI0GsBVb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605040655.KI0GsBVb-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'cgroup_apply_control_disable':
>> kernel/cgroup/cgroup.c:3391:33: error: implicit declaration of function 'kill_css_sync'; did you mean 'kill_fasync'? [-Wimplicit-function-declaration]
    3391 |                                 kill_css_sync(css);
         |                                 ^~~~~~~~~~~~~
         |                                 kill_fasync
>> kernel/cgroup/cgroup.c:3392:33: error: implicit declaration of function 'kill_css_finish' [-Wimplicit-function-declaration]
    3392 |                                 kill_css_finish(css);
         |                                 ^~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: At top level:
   kernel/cgroup/cgroup.c:6047:13: warning: conflicting types for 'kill_css_sync'; have 'void(struct cgroup_subsys_state *)'
    6047 | static void kill_css_sync(struct cgroup_subsys_state *css)
         |             ^~~~~~~~~~~~~
>> kernel/cgroup/cgroup.c:6047:13: error: static declaration of 'kill_css_sync' follows non-static declaration
   kernel/cgroup/cgroup.c:3391:33: note: previous implicit declaration of 'kill_css_sync' with type 'void(struct cgroup_subsys_state *)'
    3391 |                                 kill_css_sync(css);
         |                                 ^~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:6087:13: warning: conflicting types for 'kill_css_finish'; have 'void(struct cgroup_subsys_state *)'
    6087 | static void kill_css_finish(struct cgroup_subsys_state *css)
         |             ^~~~~~~~~~~~~~~
>> kernel/cgroup/cgroup.c:6087:13: error: static declaration of 'kill_css_finish' follows non-static declaration
   kernel/cgroup/cgroup.c:3392:33: note: previous implicit declaration of 'kill_css_finish' with type 'void(struct cgroup_subsys_state *)'
    3392 |                                 kill_css_finish(css);
         |                                 ^~~~~~~~~~~~~~~


vim +3391 kernel/cgroup/cgroup.c

  3359	
  3360	/**
  3361	 * cgroup_apply_control_disable - kill or hide csses according to control
  3362	 * @cgrp: root of the target subtree
  3363	 *
  3364	 * Walk @cgrp's subtree and kill and hide csses so that they match
  3365	 * cgroup_ss_mask() and cgroup_visible_mask().
  3366	 *
  3367	 * A css is hidden when the userland requests it to be disabled while other
  3368	 * subsystems are still depending on it.  The css must not actively control
  3369	 * resources and be in the vanilla state if it's made visible again later.
  3370	 * Controllers which may be depended upon should provide ->css_reset() for
  3371	 * this purpose.
  3372	 */
  3373	static void cgroup_apply_control_disable(struct cgroup *cgrp)
  3374	{
  3375		struct cgroup *dsct;
  3376		struct cgroup_subsys_state *d_css;
  3377		struct cgroup_subsys *ss;
  3378		int ssid;
  3379	
  3380		cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
  3381			for_each_subsys(ss, ssid) {
  3382				struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
  3383	
  3384				if (!css)
  3385					continue;
  3386	
  3387				WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
  3388	
  3389				if (css->parent &&
  3390				    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
> 3391					kill_css_sync(css);
> 3392					kill_css_finish(css);
  3393				} else if (!css_visible(css)) {
  3394					css_clear_dir(css);
  3395					if (ss->css_reset)
  3396						ss->css_reset(css);
  3397				}
  3398			}
  3399		}
  3400	}
  3401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

