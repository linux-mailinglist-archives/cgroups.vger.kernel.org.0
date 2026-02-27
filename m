Return-Path: <cgroups+bounces-14459-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qdLjD8czoWmFrAQAu9opvQ
	(envelope-from <cgroups+bounces-14459-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 07:03:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937181B302C
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 07:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECFBF30965BB
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C43DA7C7;
	Fri, 27 Feb 2026 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSqtfDLF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1862556E
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172228; cv=none; b=Xpen7ucQYUmP7FcND0k70sjCfTLVB+mCyuL/K7qRyegdTX+RQDGmQHOZYaLwngBNrVkUhxx2lCKMpjv0eQC2UJLeQygpVigauJ5UA+u0Pg9XnlnbBMN8QL5lk4vi2cKWWCoN0Xn+geIfevwm72eY5vFYlGFpcHm+scVCQRbwIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172228; c=relaxed/simple;
	bh=womFZoMcXmoknjkJ674fsDEBofqxqg/e+sw1HuqnxWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmENWKCJ1dh5f0QtzOyeE/fpmfCvP6npZ6plYzgvI2sJIp1NhO+X21rjSo5qL8thyjHCryAuHzI0LwKW0Itv446wJW95PVl412FKPZuu3Vi1uqVgGeC/btRArpkF3XwXqLq3Rh+QCQT62EtRLlhnTnv8Vxf/PuzYKTNEab4ueGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSqtfDLF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772172225; x=1803708225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=womFZoMcXmoknjkJ674fsDEBofqxqg/e+sw1HuqnxWc=;
  b=DSqtfDLFKm7JGuI/purbvs6xhjF4d/m2rTtSdrY6GIelvHjzI49RqOxh
   7/soZyuIxORZF6lxqugAv/8vwQh/V+kiI8vhDo6EsHX+bkddr7xMNGAG1
   hGVLhQaZ5u8zYiYTCVECQNJtdDIOy4ifZXz0aKVOmRIiYmCz312r5uava
   rHkDO0NLbOgolFdznMdexTE0AYAbRHdjoYgo+BKUYHcu54+RO6buEKFEK
   w9j+qRqav6Z3/CSpMPWSD2JJRba4ZrIMqIYPk9TkvtK/Ral2voMdTphA9
   CzOOLjgpjsgftjneTqVBu8ZnVB1mNHF15AZMOSuv8jXP020ZMRcEhWPxA
   Q==;
X-CSE-ConnectionGUID: nk7taQmETyeS8D8KdLq3vQ==
X-CSE-MsgGUID: 7yI1hjo7Tc+Rzk016qhM2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95868718"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="95868718"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:03:44 -0800
X-CSE-ConnectionGUID: vtUqWWtBTrqQu561y1GaXQ==
X-CSE-MsgGUID: VE5jgSE6RpmJV3IxR2vKag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="214690739"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Feb 2026 22:03:40 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvqwq-00000000AEF-2p3i;
	Fri, 27 Feb 2026 06:03:36 +0000
Date: Fri, 27 Feb 2026 14:02:59 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>, venkat88@linux.ibm.com
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	ast@kernel.org, cgroups@vger.kernel.org, cl@gentwo.org,
	hannes@cmpxchg.org, hao.li@linux.dev, harry.yoo@oracle.com,
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
	rientjes@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH] mm/slab: a debug patch to investigate the issue further
Message-ID: <202602271339.xhIvS2iX-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14459-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937181B302C
X-Rspamd-Action: no action

Hi Harry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Harry-Yoo/mm-slab-a-debug-patch-to-investigate-the-issue-further/20260227-111246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260227030733.9517-1-harry.yoo%40oracle.com
patch subject: [PATCH] mm/slab: a debug patch to investigate the issue further
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260227/202602271339.xhIvS2iX-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602271339.xhIvS2iX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602271339.xhIvS2iX-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/slub.c: In function 'slab_pad_check':
>> mm/slub.c:1330:13: error: implicit declaration of function 'obj_exts_in_slab'; did you mean 'obj_exts_in_object'? [-Werror=implicit-function-declaration]
    1330 |         if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
         |             ^~~~~~~~~~~~~~~~
         |             obj_exts_in_object
>> mm/slub.c:1332:30: error: implicit declaration of function 'obj_exts_offset_in_slab'; did you mean 'obj_exts_offset_in_object'? [-Werror=implicit-function-declaration]
    1332 |                 remainder -= obj_exts_offset_in_slab(s, slab);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
         |                              obj_exts_offset_in_object
>> mm/slub.c:1333:30: error: implicit declaration of function 'obj_exts_size_in_slab' [-Werror=implicit-function-declaration]
    1333 |                 remainder -= obj_exts_size_in_slab(slab);
         |                              ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1330 mm/slub.c

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

