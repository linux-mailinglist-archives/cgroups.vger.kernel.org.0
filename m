Return-Path: <cgroups+bounces-14210-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHkXMURlnWlgPQQAu9opvQ
	(envelope-from <cgroups+bounces-14210-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:45:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550D183EDB
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F8E312CB8E
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2231F30A9;
	Tue, 24 Feb 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTLmWGuF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BA366DB1
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922561; cv=none; b=MDMtbCfMfLWQCL2dVhzIlKTBVVwCOtuhTk62SQqEe2X2xOfuii1nXSimc2J6RUjknHUaRvMdFwHYFEBVna7QhgoHLjaX/aAkk4FLe87ZJ1rg25GytWG1MGDU03/U46FwqbLFzL+BYngesRJAEb6KmyoGaCESslAJmdEG08Z9Y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922561; c=relaxed/simple;
	bh=NDxi//Dba1wbPUsIKoTjHMV/rNScnA7634AbsOEXxHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeOYOQ1dYy63hEaKP6+TUpFL5ev92YuIhxzqFwMInjvUk3A5yCgxWI7bd/txKSXUDdAD6b5DQoae0khdXKGnn9LmWFbW6T0GzM0kSH8dKkK7bxKiayEZBGLXZJce4TpWZum4uzTdNCbMUXO8ibF0GY/vOWyN6p8TEgVBwMu3+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTLmWGuF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771922560; x=1803458560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDxi//Dba1wbPUsIKoTjHMV/rNScnA7634AbsOEXxHg=;
  b=bTLmWGuFsJWdjAaunP0z+gMQNtXx6AZQ2KH/cfb+8X2FQEvu9iIqFK5i
   mt5KutF/GshqGA1IswyQ6oalZVox+abARM0sa+Y3dCGdIx4SMJJvbLVFm
   cjdMZ7f8tXS5BxlaELA5vEO44/a0DjwZof3ML5EPT62TMlShX+GmiPLti
   jSBktxpOgYaNk4HfuloEdsYcGZ+r3ylHAdhjltjHgNrLGNCT5S3emWZWz
   i9u6RlY5lmWrrBRjk381cijIOYEwVoff5JmpPuLxTc0id1ivfxOjTOlHl
   S0l/KgJbZqA3aDRgaNZMP20ca18e7HQw5rpoHML0OqpVv5EJQLrPQEuKz
   Q==;
X-CSE-ConnectionGUID: 9xDGaZ7OTJGhAZvii8zxQw==
X-CSE-MsgGUID: F4NsVfU7Td2QM9MqVHvqEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83642183"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83642183"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:42:40 -0800
X-CSE-ConnectionGUID: Ih7jRUjiRqeS0ekoFBczOw==
X-CSE-MsgGUID: rAxfmtZlS9uByqyoIN3Itg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="243832914"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 00:42:36 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vuo02-000000001hQ-30Zg;
	Tue, 24 Feb 2026 08:42:34 +0000
Date: Tue, 24 Feb 2026 16:42:19 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [PATCH 08/16] ttm: add a memcg accounting flag to the
 alloc/populate APIs
Message-ID: <202602241625.E8sX98Qb-lkp@intel.com>
References: <20260224020854.791201-9-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224020854.791201-9-airlied@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14210-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,kernel.org,amd.com,cmpxchg.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 2550D183EDB
X-Rspamd-Action: no action

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.0-rc1 next-20260223]
[cannot apply to akpm-mm/mm-everything drm-xe/drm-xe-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/drm-ttm-use-gpu-mm-stats-to-track-gpu-memory-allocations-v4/20260224-112019
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260224020854.791201-9-airlied%40gmail.com
patch subject: [PATCH 08/16] ttm: add a memcg accounting flag to the alloc/populate APIs
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260224/202602241625.E8sX98Qb-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260224/202602241625.E8sX98Qb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602241625.E8sX98Qb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/ttm/ttm_bo.c:1264 function parameter 'memcg_account' not described in 'ttm_bo_populate'
>> Warning: drivers/gpu/drm/ttm/ttm_bo.c:1264 function parameter 'memcg_account' not described in 'ttm_bo_populate'
--
>> Warning: drivers/gpu/drm/ttm/ttm_pool.c:867 function parameter 'memcg_account' not described in 'ttm_pool_alloc'
>> Warning: drivers/gpu/drm/ttm/ttm_pool.c:867 function parameter 'memcg_account' not described in 'ttm_pool_alloc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

