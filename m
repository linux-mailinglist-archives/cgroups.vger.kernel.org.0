Return-Path: <cgroups+bounces-13798-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIBqGUVAiWkb5QQAu9opvQ
	(envelope-from <cgroups+bounces-13798-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:02:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAD10AF53
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431E63007882
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3F280329;
	Mon,  9 Feb 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf3lCWvu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2483C1F;
	Mon,  9 Feb 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770602561; cv=none; b=EmujbUGIf9pl/pwM+7XhRkdVsedSas0s3bYNOPfieIMJWGdBlfb8cq9avBm2+EvpbQySqWJ9siZ65KjIPIA3lBUgD/cus3Nq2djgsK316ZZY0zbb2Ox7DaynMi8T9QgFD0RE76XMYnZ8Yi2uUJntsKB3bwrdYJHKVDijML45nCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770602561; c=relaxed/simple;
	bh=Hyof1hGtCKND6soMP6y8pogc5xszODf48CdRWrawknk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9NfK/PFH4LYj/oR1A6pq66KRuYLBq5r1SWRVd5HeUHWvO9FaIwtjQCnrZiiG98WkBySsoJhqUOtrMu6jbEhrmQSByRS0okKDN8Ju31DRs82pgNewYU6xZH648ZMPjHgMiqgSRnGgb+0DxP3x0XE/m0nUA7ixPS50+PDvb9DLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf3lCWvu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770602561; x=1802138561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hyof1hGtCKND6soMP6y8pogc5xszODf48CdRWrawknk=;
  b=Rf3lCWvu5WM2dvdYXuAXF0l7Bc65vvsvcvpl26wUnbV/eId4atOgOUVx
   45Ea/OGZOTL6drVdfpW5ErphsxbIPXkQXWU3iPU7DMM21rPvrHTIUM1P+
   /WJJngfU1N7JWJoA39BswRSeFkEyGfCDQihhmhPjETx7CQJxAUa41Q/4w
   G+88yGo0q6tvMQUStEEW7BAJHizLXr5b2eaIX5SRCeKxgxvmA88f9+t+x
   KhF/BL5yvR71QmKm5gOZ/kl22Id9a5F68QpOW7A7DlQHyRlox3rG7HCIi
   3Tb6u3ulFg1/7oE+X5PxU56YR5G8ROunzlfWl3/DSqri76VxUsGwP/Tax
   g==;
X-CSE-ConnectionGUID: 4DSLdlL+TGWoLmt9KIvV1Q==
X-CSE-MsgGUID: HkScuB+3SLiviO91/qQqeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71776011"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71776011"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:02:40 -0800
X-CSE-ConnectionGUID: neDeqpouQsGET94hZxYgPw==
X-CSE-MsgGUID: FuDPVoH/TLet4b2DxkH+dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="234374661"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Feb 2026 18:02:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpGbf-00000000mVY-03Cp;
	Mon, 09 Feb 2026 02:02:31 +0000
Date: Mon, 9 Feb 2026 10:01:32 +0800
From: kernel test robot <lkp@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com
Subject: Re: [PATCH v3 18/20] memcg: swap: only charge physical swap slots
Message-ID: <202602090941.opY2jzUD-lkp@intel.com>
References: <20260208215839.87595-19-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208215839.87595-19-nphamcs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-13798-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: D2AAD10AF53
X-Rspamd-Action: no action

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19]
[cannot apply to akpm-mm/mm-everything tj-cgroup/for-next tip/smp/core next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/swap-rearrange-the-swap-header-file/20260209-065842
base:   linus/master
patch link:    https://lore.kernel.org/r/20260208215839.87595-19-nphamcs%40gmail.com
patch subject: [PATCH v3 18/20] memcg: swap: only charge physical swap slots
config: hexagon-randconfig-001-20260209 (https://download.01.org/0day-ci/archive/20260209/202602090941.opY2jzUD-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602090941.opY2jzUD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602090941.opY2jzUD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memcontrol-v1.c:688:3: error: call to undeclared function 'mem_cgroup_clear_swap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   mem_cgroup_clear_swap(entry, nr_pages);
                   ^
   mm/memcontrol-v1.c:688:3: note: did you mean 'mem_cgroup_uncharge_swap'?
   include/linux/swap.h:658:20: note: 'mem_cgroup_uncharge_swap' declared here
   static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
                      ^
   1 error generated.


vim +/mem_cgroup_clear_swap +688 mm/memcontrol-v1.c

   651	
   652	/*
   653	 * memcg1_swapin - uncharge swap slot
   654	 * @entry: the first swap entry for which the pages are charged
   655	 * @nr_pages: number of pages which will be uncharged
   656	 *
   657	 * Call this function after successfully adding the charged page to swapcache.
   658	 *
   659	 * Note: This function assumes the page for which swap slot is being uncharged
   660	 * is order 0 page.
   661	 */
   662	void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
   663	{
   664		/*
   665		 * Cgroup1's unified memory+swap counter has been charged with the
   666		 * new swapcache page, finish the transfer by uncharging the swap
   667		 * slot. The swap slot would also get uncharged when it dies, but
   668		 * it can stick around indefinitely and we'd count the page twice
   669		 * the entire time.
   670		 *
   671		 * Cgroup2 has separate resource counters for memory and swap,
   672		 * so this is a non-issue here. Memory and swap charge lifetimes
   673		 * correspond 1:1 to page and swap slot lifetimes: we charge the
   674		 * page to memory here, and uncharge swap when the slot is freed.
   675		 */
   676		if (do_memsw_account()) {
   677			/*
   678			 * The swap entry might not get freed for a long time,
   679			 * let's not wait for it.  The page already received a
   680			 * memory+swap charge, drop the swap entry duplicate.
   681			 */
   682			mem_cgroup_uncharge_swap(entry, nr_pages);
   683	
   684			/*
   685			 * Clear the cgroup association now to prevent double memsw
   686			 * uncharging when the backends are released later.
   687			 */
 > 688			mem_cgroup_clear_swap(entry, nr_pages);
   689		}
   690	}
   691	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

