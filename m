Return-Path: <cgroups+bounces-14458-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHfcAjsxoWkorAQAu9opvQ
	(envelope-from <cgroups+bounces-14458-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:52:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8611B2FBF
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DDE03030053
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68F362151;
	Fri, 27 Feb 2026 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjwBXqKB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE9336EC2
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772171564; cv=none; b=atFCh3xy2Cm3tHdPA98aWdk6htQ7ztmP2luZPhqOamiHQnGdjUq5kcrm++OniAxNWxWR70NVQdEEiQvAt/L/vn5AaX6wg4Bp1HClw33OilOu/zsD9gt+FVfz0VbwlrZ3/oFxUeihQicQwyXXQvG7F0DTTr0inTTSSOAhrLEs0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772171564; c=relaxed/simple;
	bh=LWOdmL0uan22tNsv3PGdyHuaOVgzT4VqOM5Rm/fNGco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSzaH639I1n9oXNBbkt8BUSeX2Y/MgWZHEpS5A49cVzFhs5o9kK3snnBFm5yqL2e58zEib1WnIWM3y/MrlRFrr+oB5rIVjB9KgFPkD6T7/onBId6Zj+VdydTAJZuxeFHWm+XwqY91c6X++q7BgJniON+bu9LnIMf+80deK0p194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjwBXqKB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772171562; x=1803707562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LWOdmL0uan22tNsv3PGdyHuaOVgzT4VqOM5Rm/fNGco=;
  b=cjwBXqKBaDRWYKsDGUBHcPgp8tFST9wsOMbwx1XQ4yiN2sL8h/QQKze4
   4cUO6+UR3W0UVB2Ie4ezaesSPFktQf88KY28VoKxEMC/9a0ujPBRDKxGR
   gfc0ISBmoEqsFQQ7J3PSkJJta6VcRKDkeUWbUy/0f3lc+h9s+d7mFsaXW
   6wO4ORbIr1BXOX+HMORt6s0UM0FuiAOvr/BGYAGeqF4zQa8S8cCMK1UVe
   wJAzDemJCxamUF4inFk24A6nqht/D1VowBT4SPxlRYTZRdNwIDnls2XA4
   7z90vzLAENR9jTqJnlF1wepbo7JSBEwhz/Ab6b03kwXck8SYjwNyYBuei
   g==;
X-CSE-ConnectionGUID: 9sBRR7WoSfeVJkTe4J0mlQ==
X-CSE-MsgGUID: Zx0N2sP5RcSqJAMYpno3jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73121978"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73121978"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 21:52:41 -0800
X-CSE-ConnectionGUID: 62b9Y3uDQlyrKfLirF6oHQ==
X-CSE-MsgGUID: vnQDeMXOQSSCRScW/BACmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="214993740"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Feb 2026 21:52:37 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvqmA-00000000AE3-0V4y;
	Fri, 27 Feb 2026 05:52:34 +0000
Date: Fri, 27 Feb 2026 13:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>, venkat88@linux.ibm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, ast@kernel.org, cgroups@vger.kernel.org,
	cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
	harry.yoo@oracle.com, linux-mm@kvack.org, mhocko@kernel.org,
	muchun.song@linux.dev, rientjes@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH] mm/slab: a debug patch to investigate the issue further
Message-ID: <202602271320.ywOCYQx4-lkp@intel.com>
References: <20260227030733.9517-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227030733.9517-1-harry.yoo@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14458-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F8611B2FBF
X-Rspamd-Action: no action

Hi Harry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Harry-Yoo/mm-slab-a-debug-patch-to-investigate-the-issue-further/20260227-111246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260227030733.9517-1-harry.yoo%40oracle.com
patch subject: [PATCH] mm/slab: a debug patch to investigate the issue further
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20260227/202602271320.ywOCYQx4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602271320.ywOCYQx4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602271320.ywOCYQx4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:1330:6: error: call to undeclared function 'obj_exts_in_slab'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1330 |         if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
         |             ^
>> mm/slub.c:1332:16: error: call to undeclared function 'obj_exts_offset_in_slab'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1332 |                 remainder -= obj_exts_offset_in_slab(s, slab);
         |                              ^
   mm/slub.c:1332:16: note: did you mean 'obj_exts_offset_in_object'?
   mm/slub.c:793:28: note: 'obj_exts_offset_in_object' declared here
     793 | static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
         |                            ^
>> mm/slub.c:1333:16: error: call to undeclared function 'obj_exts_size_in_slab'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1333 |                 remainder -= obj_exts_size_in_slab(slab);
         |                              ^
   3 errors generated.


vim +/obj_exts_in_slab +1330 mm/slub.c

81819f0fc8285a Christoph Lameter          2007-05-06  1311  
39b264641a0c3b Christoph Lameter          2008-04-14  1312  /* Check the pad bytes at the end of a slab page */
adea9876180664 Ilya Leoshkevich           2024-06-21  1313  static pad_check_attributes void
adea9876180664 Ilya Leoshkevich           2024-06-21  1314  slab_pad_check(struct kmem_cache *s, struct slab *slab)
81819f0fc8285a Christoph Lameter          2007-05-06  1315  {
2492268472e7d3 Christoph Lameter          2007-07-17  1316  	u8 *start;
2492268472e7d3 Christoph Lameter          2007-07-17  1317  	u8 *fault;
2492268472e7d3 Christoph Lameter          2007-07-17  1318  	u8 *end;
5d682681f8a2bd Balasubramani Vivekanandan 2018-01-31  1319  	u8 *pad;
2492268472e7d3 Christoph Lameter          2007-07-17  1320  	int length;
2492268472e7d3 Christoph Lameter          2007-07-17  1321  	int remainder;
81819f0fc8285a Christoph Lameter          2007-05-06  1322  
81819f0fc8285a Christoph Lameter          2007-05-06  1323  	if (!(s->flags & SLAB_POISON))
a204e6d626126d Miaohe Lin                 2022-04-19  1324  		return;
81819f0fc8285a Christoph Lameter          2007-05-06  1325  
bb192ed9aa7191 Vlastimil Babka            2021-11-03  1326  	start = slab_address(slab);
bb192ed9aa7191 Vlastimil Babka            2021-11-03  1327  	length = slab_size(slab);
39b264641a0c3b Christoph Lameter          2008-04-14  1328  	end = start + length;
70089d01880750 Harry Yoo                  2026-01-13  1329  
a77d6d33868502 Harry Yoo                  2026-01-13 @1330  	if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
70089d01880750 Harry Yoo                  2026-01-13  1331  		remainder = length;
70089d01880750 Harry Yoo                  2026-01-13 @1332  		remainder -= obj_exts_offset_in_slab(s, slab);
70089d01880750 Harry Yoo                  2026-01-13 @1333  		remainder -= obj_exts_size_in_slab(slab);
70089d01880750 Harry Yoo                  2026-01-13  1334  	} else {
39b264641a0c3b Christoph Lameter          2008-04-14  1335  		remainder = length % s->size;
70089d01880750 Harry Yoo                  2026-01-13  1336  	}
70089d01880750 Harry Yoo                  2026-01-13  1337  
81819f0fc8285a Christoph Lameter          2007-05-06  1338  	if (!remainder)
a204e6d626126d Miaohe Lin                 2022-04-19  1339  		return;
81819f0fc8285a Christoph Lameter          2007-05-06  1340  
5d682681f8a2bd Balasubramani Vivekanandan 2018-01-31  1341  	pad = end - remainder;
a79316c6178ca4 Andrey Ryabinin            2015-02-13  1342  	metadata_access_enable();
aa1ef4d7b3f67f Andrey Konovalov           2020-12-22  1343  	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
a79316c6178ca4 Andrey Ryabinin            2015-02-13  1344  	metadata_access_disable();
2492268472e7d3 Christoph Lameter          2007-07-17  1345  	if (!fault)
a204e6d626126d Miaohe Lin                 2022-04-19  1346  		return;
2492268472e7d3 Christoph Lameter          2007-07-17  1347  	while (end > fault && end[-1] == POISON_INUSE)
2492268472e7d3 Christoph Lameter          2007-07-17  1348  		end--;
2492268472e7d3 Christoph Lameter          2007-07-17  1349  
3f6f32b14ab354 Hyesoo Yu                  2025-02-26  1350  	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
e1b70dd1e6429f Miles Chen                 2019-11-30  1351  		 fault, end - 1, fault - start);
5d682681f8a2bd Balasubramani Vivekanandan 2018-01-31  1352  	print_section(KERN_ERR, "Padding ", pad, remainder);
3f6f32b14ab354 Hyesoo Yu                  2025-02-26  1353  	__slab_err(slab);
2492268472e7d3 Christoph Lameter          2007-07-17  1354  
5d682681f8a2bd Balasubramani Vivekanandan 2018-01-31  1355  	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
81819f0fc8285a Christoph Lameter          2007-05-06  1356  }
81819f0fc8285a Christoph Lameter          2007-05-06  1357  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

