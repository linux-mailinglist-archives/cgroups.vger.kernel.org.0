Return-Path: <cgroups+bounces-15079-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNCrAFzWxmnlPAUAu9opvQ
	(envelope-from <cgroups+bounces-15079-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:11:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013C349EBE
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECC723056A16
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F236B06C;
	Fri, 27 Mar 2026 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI/YXARW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B234A3DA;
	Fri, 27 Mar 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638423; cv=none; b=TN3jOPCc+f2SXVig/mRQ6HGqZbAj/TFcspmYNeVHYngdwItHg5v8JD5w8e6utJnYuYR5/mNZ/U3msvbcQTBawwz77y/ZnwpQgUAlCP5Amrbr8uhgRtieWP+tZYNuMOQya9eiJoGUTB0w006lTmuJbb9xn8vfr4hzQscKCCv51Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638423; c=relaxed/simple;
	bh=8LZlpASHsA/Y6GOiRodaZwiHzKtI3/rlF/snT/eGlms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXxFzxogPJ04vpcjOw5LuUj74JYfr7QTbDYzpIkkaQQUZp8uvzBxoYtuRQZU+fDFuYE9ibR6AHYZe/3s0u64kd7ktogE6nmCqz8WLpDhrkxexJzAJ/TIfPQg61KGQLFAbh2UYtZYkjbcoBmLtiHcG6rjZ3RytQi+ty8QG7mWm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI/YXARW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774638420; x=1806174420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LZlpASHsA/Y6GOiRodaZwiHzKtI3/rlF/snT/eGlms=;
  b=OI/YXARWAMdQM4Ry7jZsrjoom0WibrfH2d2RjGGoOv+YBas0rCikCOVw
   VIaYF9pxjKm2OuzyeNEvhHJkwlApMnQOOhDs4bYrtCcOzgrp3/xHTwnw3
   lhXRQKmcrCBw/HOa/BXeyHS3BrHUbiYMCdByDD2bf5oajzlfDSmSC/ki+
   tSdnuMKs2ySB4nNqmC09wLiOzxPJmATouj/3NnqgqWPxxbaK5yPe8WvIT
   EiXPTdplm00A0bdl1A51iyWS1Tdnir8egjNp+5autzMcJVupiUzv7ItsB
   i3hpDKHQ2o0DtWqWuF30aHfmKcpoHxYliJdPTGZJvEhWYG0lS0UAq51f7
   w==;
X-CSE-ConnectionGUID: sjW1jvxdTxuWGz6gzjFN5w==
X-CSE-MsgGUID: Y4GSMUmsTR+lVLBYlKe0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87106856"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="87106856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 12:07:00 -0700
X-CSE-ConnectionGUID: Z5niJQO1RvmVh1ZvWMioiw==
X-CSE-MsgGUID: 9x50k4KTT0Ox7iyJ5PzXxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="222529332"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 12:06:56 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6CWD-000000007Xh-48qU;
	Fri, 27 Mar 2026 19:06:53 +0000
Date: Fri, 27 Mar 2026 20:06:53 +0100
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com
Subject: Re: [PATCH v5 2/4] mm: swap: associate swap devices with tiers
Message-ID: <202603271922.UNxxB12b-lkp@intel.com>
References: <20260325175453.2523280-3-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325175453.2523280-3-youngjun.park@lge.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15079-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kvack.org,kernel.org,lge.com,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 8013C349EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6381a729fa7dda43574d93ab9c61cec516dd885b]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-introduce-swap-tier-infrastructure/20260327-203639
base:   6381a729fa7dda43574d93ab9c61cec516dd885b
patch link:    https://lore.kernel.org/r/20260325175453.2523280-3-youngjun.park%40lge.com
patch subject: [PATCH v5 2/4] mm: swap: associate swap devices with tiers
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260327/202603271922.UNxxB12b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271922.UNxxB12b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Non-Preserved Properties
   ======================== [docutils]
>> Documentation/mm/swap-tier.rst:19: WARNING: Title underline too short.
--
   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:45: ERROR: Unknown target name: "network flags". [docutils]
   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:50: ERROR: Unknown target name: "scope flags". [docutils]
   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:24: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:535: ./include/uapi/linux/landlock.h:166: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:535: ./include/uapi/linux/landlock.h:189: ERROR: Unknown target name: "network flags". [docutils]
>> Documentation/mm/swap-tier.rst: WARNING: document isn't included in any toctree [toc.not_included]
   Documentation/networking/skbuff:36: ./include/linux/skbuff.h:181: WARNING: Failed to create a cross reference. A title or caption not found: 'crc' [ref.ref]


vim +19 Documentation/mm/swap-tier.rst

    17	
    18	Use case
  > 19	-------
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

