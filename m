Return-Path: <cgroups+bounces-15089-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOnoINoDyWmitQUAu9opvQ
	(envelope-from <cgroups+bounces-15089-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 12:50:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAD351A21
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75AF53016299
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E8313E2F;
	Sun, 29 Mar 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6gNuJPS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238430F547;
	Sun, 29 Mar 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781390; cv=none; b=pqAIDU0Rd+4/NC7/oCeCVx4EDEGfpmVWmFsQmt5Q5Ry+afDSqiW5Yeuf4PiQaKCNEC8Y/gwjD5/Cakh6g1cqIg+/zoJmizzssCiFUU96G4tsgg2z1QWk9nw47klNlqdO/PF2FENtrknEfS54LagRkgg7EPHvVK+dauwEeurwdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781390; c=relaxed/simple;
	bh=Wo9L+4YxAfzYxpX8JuNszX9GlkiF3V/LfsPNcswQzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsvnokLliE3SG9I1NwUqJRZdZuhnANgbW9XqDir3/d7enrKi8Jc31HcPQVjJt8HZwKgxllVS6E3GUowiYlYJvfXghd7mqOBBzhkqCX9LI8EtCQpQZK8l8AkHFSqXvpJ8N6biXkrTavAEMZEJS2aUYdw91rqUb7dbMp/Df+56a/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6gNuJPS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774781389; x=1806317389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wo9L+4YxAfzYxpX8JuNszX9GlkiF3V/LfsPNcswQzMA=;
  b=E6gNuJPSkI3qB846e/UZDwHdABAxVGU1AFtxwQFv4MmW1aeEwmPD2kny
   hBnm/1jiiWZwSYpG8K8q0DxSdP4AM8HM6EKDFOr8/Shm6XkJmb/Cp4eif
   KzjXWCpWD+uQpo2epA++Y2xx4f4eIx/or8u71zdB9uk91Dfe4gsg05xdN
   JH3ePCuF8L5kt+fQi2AQN7fPymra2xCQ6qlD+l/lC+tjn1loBqlDDgKq/
   rK59Ok7r6j67ebd4lpKCqKVbDJOC1myvKYmxsmZfsQCLP0vG3YiuXZEJH
   ZlhHAXGA+PO5BbCQCTvPI4Y5oVuKsmy2lH8gYTsduFSrDSOUwtLvb9mR1
   g==;
X-CSE-ConnectionGUID: xGr2yEvzQ/CzhrcN1uvgxg==
X-CSE-MsgGUID: LTa7Eo2SQniX3AnBjSO61Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93374047"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="93374047"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 03:49:48 -0700
X-CSE-ConnectionGUID: 4DZ0cFH/QmyjtdyajyTJuQ==
X-CSE-MsgGUID: UnsA4Ta0QEe71fYcLSvvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="225782046"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Mar 2026 03:49:43 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6ni8-00000000CIF-0opa;
	Sun, 29 Mar 2026 10:49:40 +0000
Date: Sun, 29 Mar 2026 18:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com
Subject: Re: [PATCH v5 1/4] mm: swap: introduce swap tier infrastructure
Message-ID: <202603291831.wZLe8bqg-lkp@intel.com>
References: <20260325175453.2523280-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325175453.2523280-2-youngjun.park@lge.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15089-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kvack.org,kernel.org,lge.com,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07EAD351A21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6381a729fa7dda43574d93ab9c61cec516dd885b]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20260327-203639
base:   6381a729fa7dda43574d93ab9c61cec516dd885b
patch link:    https://lore.kernel.org/r/20260325175453.2523280-2-youngjun.park%40lge.com
patch subject: [PATCH v5 1/4] mm: swap: introduce swap tier infrastructure
config: hexagon-randconfig-002-20260329 (https://download.01.org/0day-ci/archive/20260329/202603291831.wZLe8bqg-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291831.wZLe8bqg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603291831.wZLe8bqg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/swap_tier.c:118:10: warning: format specifies type 'long' but the argument has type '__ptrdiff_t' (aka 'int') [-Wformat]
     116 |                 len += sysfs_emit_at(buf, len, "%-16s %-5ld %-11d %-11d\n",
         |                                                       ~~~~~
         |                                                       %-5td
     117 |                                      tier->name,
     118 |                                      TIER_IDX(tier),
         |                                      ^~~~~~~~~~~~~~
   mm/swap_tier.c:33:24: note: expanded from macro 'TIER_IDX'
      33 | #define TIER_IDX(tier)  ((tier) - swap_tiers)
         |                         ^~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +118 mm/swap_tier.c

   105	
   106	ssize_t swap_tiers_sysfs_show(char *buf)
   107	{
   108		struct swap_tier *tier;
   109		ssize_t len = 0;
   110	
   111		len += sysfs_emit_at(buf, len, "%-16s %-5s %-11s %-11s\n",
   112				 "Name", "Idx", "PrioStart", "PrioEnd");
   113	
   114		spin_lock(&swap_tier_lock);
   115		for_each_active_tier(tier) {
   116			len += sysfs_emit_at(buf, len, "%-16s %-5ld %-11d %-11d\n",
   117					     tier->name,
 > 118					     TIER_IDX(tier),
   119					     tier->prio,
   120					     TIER_END_PRIO(tier));
   121		}
   122		spin_unlock(&swap_tier_lock);
   123	
   124		return len;
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

