Return-Path: <cgroups+bounces-5442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E99BC481
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 06:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D157B21D1E
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BF1B6D0B;
	Tue,  5 Nov 2024 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfjY4M4p"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD51B5EA4;
	Tue,  5 Nov 2024 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782874; cv=none; b=hn0AwFVN2mctqJEevs6tsDF04nO5hadIE73q0/tuVnMKZL0lgPwd/BmLGpalW1JWMichyUNZkthURyZ8FhMOarDqB4Jm54mFujHUZQM3hwuTH1jy/TM5NSLLib8FBeXp61KFmqIUQwPVhj/sVGY+rK0A5iLOqJ3ESV+LCWW6Go8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782874; c=relaxed/simple;
	bh=u6bRqQE/rACICogM0u4/js7LHshRVSLExADHVgfgOx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOk3k7TjCN86HmkMFcmsgxuD68bIK7g4C9DQYADlZxARwBGx/tdWkil9B3TRGfQoh0v3IHpBrKTUh6/yHCUmYsF5T72CJ4dTNKn69UAQ8wtvLNQ7f99G1vNbNWR/kgDjP27hlZB0plGRq8Tva7bDEU4vmfrYGJyoVsP6kJsh4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfjY4M4p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730782872; x=1762318872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6bRqQE/rACICogM0u4/js7LHshRVSLExADHVgfgOx4=;
  b=cfjY4M4pmWfPgLRpMz2nDs0dopduYgZ+oHpIoCrq26mHYfP5qXVW6rwO
   1C39IwnD7F86VVCMuquO/CUzc0apFMUONvzn6lf3j0tRMJZdQVXCsg/3U
   1zyAnNEK5Y+lPEI78S09YpyoaZ2ArfhoS/GpL+ETFEipJhSx2VLXffudg
   O1Rd8IvDIGb78z5xKYMfyWwgp7/q/TCcDQfrCf8lwIEvFtqqfZ2rTXxha
   uj3cO3V7APMYejikmMg5WXMCgbDrA91whVUjdfXwWcJPM3lmJ2+uG+a5E
   4SBjTSfNwdgJbVQXN4PyYtiSWkdckp1oSd8Kfx1bzL7Lb3Oe6dvH/4+mA
   Q==;
X-CSE-ConnectionGUID: HP2DuI3FQ8+TPOT/3KLEig==
X-CSE-MsgGUID: rIH9bsGOQHWhdm3MklwXJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33347599"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="33347599"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:01:11 -0800
X-CSE-ConnectionGUID: O2lx8TIdTeu6hNByHNJPYA==
X-CSE-MsgGUID: Fp+vrJckSvqSTOSJWCnivA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84688056"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Nov 2024 21:01:08 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Bge-000ldx-1z;
	Tue, 05 Nov 2024 05:01:04 +0000
Date: Tue, 5 Nov 2024 13:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: Keren Sun <kerensun@google.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Keren Sun <kerensun@google.com>
Subject: Re: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
Message-ID: <202411051248.C33eJ43V-lkp@intel.com>
References: <20241104222737.298130-5-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-5-kerensun@google.com>

Hi Keren,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc6]
[also build test ERROR on linus/master]
[cannot apply to akpm-mm/mm-everything next-20241104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keren-Sun/mm-fix-quoted-strings-spliting-across-lines/20241105-063007
base:   v6.12-rc6
patch link:    https://lore.kernel.org/r/20241104222737.298130-5-kerensun%40google.com
patch subject: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241105/202411051248.C33eJ43V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051248.C33eJ43V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051248.C33eJ43V-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memcontrol-v1.c: In function 'memcg_write_event_control':
>> mm/memcontrol-v1.c:1926:27: error: passing argument 3 of 'kstrtoul' makes pointer from integer without a cast [-Wint-conversion]
    1926 |         kstrtoul(buf, 10, efd);
         |                           ^~~
         |                           |
         |                           unsigned int
   In file included from mm/memcontrol-v1.c:3:
   include/linux/kstrtox.h:30:90: note: expected 'long unsigned int *' but argument is of type 'unsigned int'
      30 | static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
         |                                                                           ~~~~~~~~~~~~~~~^~~
   mm/memcontrol-v1.c:1931:27: error: passing argument 3 of 'kstrtoul' makes pointer from integer without a cast [-Wint-conversion]
    1931 |         kstrtoul(buf, 10, cfd);
         |                           ^~~
         |                           |
         |                           unsigned int
   include/linux/kstrtox.h:30:90: note: expected 'long unsigned int *' but argument is of type 'unsigned int'
      30 | static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
         |                                                                           ~~~~~~~~~~~~~~~^~~
   mm/memcontrol-v1.c:1918:15: warning: unused variable 'endp' [-Wunused-variable]
    1918 |         char *endp;
         |               ^~~~
   mm/memcontrol-v1.c:1926:9: warning: ignoring return value of 'kstrtoul' declared with attribute 'warn_unused_result' [-Wunused-result]
    1926 |         kstrtoul(buf, 10, efd);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   mm/memcontrol-v1.c:1931:9: warning: ignoring return value of 'kstrtoul' declared with attribute 'warn_unused_result' [-Wunused-result]
    1931 |         kstrtoul(buf, 10, cfd);
         |         ^~~~~~~~~~~~~~~~~~~~~~


vim +/kstrtoul +1926 mm/memcontrol-v1.c

  1897	
  1898	/*
  1899	 * DO NOT USE IN NEW FILES.
  1900	 *
  1901	 * Parse input and register new cgroup event handler.
  1902	 *
  1903	 * Input must be in format '<event_fd> <control_fd> <args>'.
  1904	 * Interpretation of args is defined by control file implementation.
  1905	 */
  1906	static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
  1907						 char *buf, size_t nbytes, loff_t off)
  1908	{
  1909		struct cgroup_subsys_state *css = of_css(of);
  1910		struct mem_cgroup *memcg = mem_cgroup_from_css(css);
  1911		struct mem_cgroup_event *event;
  1912		struct cgroup_subsys_state *cfile_css;
  1913		unsigned int efd, cfd;
  1914		struct fd efile;
  1915		struct fd cfile;
  1916		struct dentry *cdentry;
  1917		const char *name;
  1918		char *endp;
  1919		int ret;
  1920	
  1921		if (IS_ENABLED(CONFIG_PREEMPT_RT))
  1922			return -EOPNOTSUPP;
  1923	
  1924		buf = strstrip(buf);
  1925	
> 1926		kstrtoul(buf, 10, efd);
  1927		if (*buf != ' ')
  1928			return -EINVAL;
  1929		buf++;
  1930	
  1931		kstrtoul(buf, 10, cfd);
  1932		if (*buf == ' ')
  1933			buf++;
  1934		else if (*buf != '\0')
  1935			return -EINVAL;
  1936	
  1937		event = kzalloc(sizeof(*event), GFP_KERNEL);
  1938		if (!event)
  1939			return -ENOMEM;
  1940	
  1941		event->memcg = memcg;
  1942		INIT_LIST_HEAD(&event->list);
  1943		init_poll_funcptr(&event->pt, memcg_event_ptable_queue_proc);
  1944		init_waitqueue_func_entry(&event->wait, memcg_event_wake);
  1945		INIT_WORK(&event->remove, memcg_event_remove);
  1946	
  1947		efile = fdget(efd);
  1948		if (!fd_file(efile)) {
  1949			ret = -EBADF;
  1950			goto out_kfree;
  1951		}
  1952	
  1953		event->eventfd = eventfd_ctx_fileget(fd_file(efile));
  1954		if (IS_ERR(event->eventfd)) {
  1955			ret = PTR_ERR(event->eventfd);
  1956			goto out_put_efile;
  1957		}
  1958	
  1959		cfile = fdget(cfd);
  1960		if (!fd_file(cfile)) {
  1961			ret = -EBADF;
  1962			goto out_put_eventfd;
  1963		}
  1964	
  1965		/* the process need read permission on control file */
  1966		/* AV: shouldn't we check that it's been opened for read instead? */
  1967		ret = file_permission(fd_file(cfile), MAY_READ);
  1968		if (ret < 0)
  1969			goto out_put_cfile;
  1970	
  1971		/*
  1972		 * The control file must be a regular cgroup1 file. As a regular cgroup
  1973		 * file can't be renamed, it's safe to access its name afterwards.
  1974		 */
  1975		cdentry = fd_file(cfile)->f_path.dentry;
  1976		if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
  1977			ret = -EINVAL;
  1978			goto out_put_cfile;
  1979		}
  1980	
  1981		/*
  1982		 * Determine the event callbacks and set them in @event.  This used
  1983		 * to be done via struct cftype but cgroup core no longer knows
  1984		 * about these events.  The following is crude but the whole thing
  1985		 * is for compatibility anyway.
  1986		 *
  1987		 * DO NOT ADD NEW FILES.
  1988		 */
  1989		name = cdentry->d_name.name;
  1990	
  1991		if (!strcmp(name, "memory.usage_in_bytes")) {
  1992			event->register_event = mem_cgroup_usage_register_event;
  1993			event->unregister_event = mem_cgroup_usage_unregister_event;
  1994		} else if (!strcmp(name, "memory.oom_control")) {
  1995			pr_warn_once("oom_control is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.\n");
  1996			event->register_event = mem_cgroup_oom_register_event;
  1997			event->unregister_event = mem_cgroup_oom_unregister_event;
  1998		} else if (!strcmp(name, "memory.pressure_level")) {
  1999			pr_warn_once("pressure_level is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.\n");
  2000			event->register_event = vmpressure_register_event;
  2001			event->unregister_event = vmpressure_unregister_event;
  2002		} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
  2003			event->register_event = memsw_cgroup_usage_register_event;
  2004			event->unregister_event = memsw_cgroup_usage_unregister_event;
  2005		} else {
  2006			ret = -EINVAL;
  2007			goto out_put_cfile;
  2008		}
  2009	
  2010		/*
  2011		 * Verify @cfile should belong to @css.  Also, remaining events are
  2012		 * automatically removed on cgroup destruction but the removal is
  2013		 * asynchronous, so take an extra ref on @css.
  2014		 */
  2015		cfile_css = css_tryget_online_from_dir(cdentry->d_parent,
  2016						       &memory_cgrp_subsys);
  2017		ret = -EINVAL;
  2018		if (IS_ERR(cfile_css))
  2019			goto out_put_cfile;
  2020		if (cfile_css != css) {
  2021			css_put(cfile_css);
  2022			goto out_put_cfile;
  2023		}
  2024	
  2025		ret = event->register_event(memcg, event->eventfd, buf);
  2026		if (ret)
  2027			goto out_put_css;
  2028	
  2029		vfs_poll(fd_file(efile), &event->pt);
  2030	
  2031		spin_lock_irq(&memcg->event_list_lock);
  2032		list_add(&event->list, &memcg->event_list);
  2033		spin_unlock_irq(&memcg->event_list_lock);
  2034	
  2035		fdput(cfile);
  2036		fdput(efile);
  2037	
  2038		return nbytes;
  2039	
  2040	out_put_css:
  2041		css_put(css);
  2042	out_put_cfile:
  2043		fdput(cfile);
  2044	out_put_eventfd:
  2045		eventfd_ctx_put(event->eventfd);
  2046	out_put_efile:
  2047		fdput(efile);
  2048	out_kfree:
  2049		kfree(event);
  2050	
  2051		return ret;
  2052	}
  2053	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

