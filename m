Return-Path: <cgroups+bounces-5256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A924C9AF93E
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 07:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B6B20FA4
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005013C9B3;
	Fri, 25 Oct 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPcal5CL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B1763F8;
	Fri, 25 Oct 2024 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835149; cv=none; b=dlbetUf10+IuB2knzGlNkYjuvCDp+EaS9iglTbWV/J+186jLmlw64zKco8YXToamZnMoDQRCnU7EEo/31oBVuX8XhIi6YqqIi4xDoC7YP7S4jFN742AYgSmW97n8SPxZ++J1zY6ZTzBjh28Zw9HIWWQSTH7rpNoFYGyZnoGy4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835149; c=relaxed/simple;
	bh=VFoRwLLckE9CmXD34UHCnai2nD8CGWfBO6i1MhJP/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYSplMXywaTp74H2W4uSySFXmJ/I3pYeOyWDePOy/EzhFsWYyGQ/ntPJV0YUE8HkKDns1o9uazNCR3g+nattfw4sf2HjCxVEh69IR22VYEHjeJqDW8d5mCqRZy1f27BP3zDeQcSvilu5M4QvOPcvpionI9Y8xMpWq5kgEU7B5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPcal5CL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729835147; x=1761371147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFoRwLLckE9CmXD34UHCnai2nD8CGWfBO6i1MhJP/K8=;
  b=ZPcal5CLIez3tvsVGBmSN6L5LCSRq6sakqkeLpl6Z8mw6SEU00XyTP1q
   u0CmdrYEs14AUCTwBuuiJVC2SVk4kan56jsUKJqZfXRNhhpBDtBr/6BCs
   f12F7m5r5NymLSz/DYHwA7AV/n6GJgdjU+RVuQoZsx35NL5C1dyyCmXgG
   2jfZp1XM9wUgvZlJJwupZnL6Y/LZy/DTsj/o/8MNYb9ZQ0vBwu6SzBSlN
   DYetpKR79vRHA7U0qOJi+jE6Jn4JjlkywiOM8s7aYcdn046qLGqD47s15
   PYjdZylz3mUaP/9jd9bIXJqk4YNWumaOoIsubXvz+ZwH7FFj57zjpe4R8
   w==;
X-CSE-ConnectionGUID: I+L23OXTTEmwn6o2fx4zoA==
X-CSE-MsgGUID: 19bfxwAwS3iYantB/73Ijw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29619457"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29619457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 22:45:46 -0700
X-CSE-ConnectionGUID: Sm/IibPHSO+voWKbOv2mVw==
X-CSE-MsgGUID: sXFE2jUKSNq4j6zxgeMCTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80917407"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2024 22:45:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4D8m-000Xe0-29;
	Fri, 25 Oct 2024 05:45:40 +0000
Date: Fri, 25 Oct 2024 13:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/7] kernel/cgroup: Add "dev" memory accounting cgroup
Message-ID: <202410251311.OLEnaBoD-lkp@intel.com>
References: <20241023075302.27194-2-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023075302.27194-2-maarten.lankhorst@linux.intel.com>

Hi Maarten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-exynos/exynos-drm-next linus/master v6.12-rc4 next-20241024]
[cannot apply to tj-cgroup/for-next drm-xe/drm-xe-next akpm-mm/mm-everything drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/kernel-cgroup-Add-dev-memory-accounting-cgroup/20241023-155504
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20241023075302.27194-2-maarten.lankhorst%40linux.intel.com
patch subject: [PATCH 1/7] kernel/cgroup: Add "dev" memory accounting cgroup
config: i386-randconfig-061-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251311.OLEnaBoD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251311.OLEnaBoD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251311.OLEnaBoD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/cgroup/dev.c:423:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cgroup/dev.c:423:9: sparse:    struct list_head [noderef] __rcu *
   kernel/cgroup/dev.c:423:9: sparse:    struct list_head *
>> kernel/cgroup/dev.c:423:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cgroup/dev.c:423:9: sparse:    struct list_head [noderef] __rcu *
   kernel/cgroup/dev.c:423:9: sparse:    struct list_head *
   kernel/cgroup/dev.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +423 kernel/cgroup/dev.c

   400	
   401	/**
   402	 * dev_cgroup_unregister_device() - Unregister a previously registered device.
   403	 * @cgdev: The device to unregister.
   404	 *
   405	 * This function undoes dev_cgroup_register_device.
   406	 */
   407	void dev_cgroup_unregister_device(struct dev_cgroup_device *cgdev)
   408	{
   409		struct devcg_device *dev;
   410		struct list_head *entry;
   411	
   412		if (!cgdev || !cgdev->priv)
   413			return;
   414	
   415		dev = cgdev->priv;
   416		cgdev->priv = NULL;
   417	
   418		spin_lock(&devcg_lock);
   419	
   420		/* Remove from global device list */
   421		list_del_rcu(&dev->dev_node);
   422	
 > 423		list_for_each_rcu(entry, &dev->pools) {
   424			struct dev_cgroup_pool_state *pool =
   425				container_of(entry, typeof(*pool), dev_node);
   426	
   427			list_del_rcu(&pool->css_node);
   428		}
   429	
   430		/*
   431		 * Ensure any RCU based lookups fail. Additionally,
   432		 * no new pools should be added to the dead device
   433		 * by get_cg_pool_unlocked.
   434		 */
   435		dev->unregistered = true;
   436		spin_unlock(&devcg_lock);
   437	
   438		kref_put(&dev->ref, devcg_free_device);
   439	}
   440	EXPORT_SYMBOL_GPL(dev_cgroup_unregister_device);
   441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

