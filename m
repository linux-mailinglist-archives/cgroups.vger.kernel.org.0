Return-Path: <cgroups+bounces-13640-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFzxASj6gWmhNQMAu9opvQ
	(envelope-from <cgroups+bounces-13640-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 14:37:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92983D9F83
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 14:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 489203038873
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770239E6F3;
	Tue,  3 Feb 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt4Eh980"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514D39E195;
	Tue,  3 Feb 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125845; cv=none; b=i2mAVxZjVdE34aK+Qqdhtou8GJu+CvS55i6Emslr167OmbltTEvPy6cVOHtIyBhaqIOvS7KrHKeiFd7VQ9fUD/hrRFUZaoesY8H0RlTAmJ4KSni/fTR/IXvvCjHPoMZEY1LZfCcsjxahixVIBWlU1iB66tkB4HaBXSOjk7RL6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125845; c=relaxed/simple;
	bh=2EsoMGquMyOlbD2ictea78FL3793nbF4OYOmbSs9hGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuSBpzrOUcBZNVGniBW6/PLjCMpMpsHoPbwtQnk/5BudN0IkfPEVPZ+ZtDBoGtGpn/pPsFgZpPc9hgLnFi/w0VtTFXAp1v9cACgHrcarUhVnCcCZXIH15AfgkP6AR4KhEcXUmuS4vl8Q7Lrwx6o7TGik0Y9/LnlIpY1gJCysrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt4Eh980; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770125839; x=1801661839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EsoMGquMyOlbD2ictea78FL3793nbF4OYOmbSs9hGU=;
  b=Tt4Eh980sg52CE/QSJ50o0an6ow13xwWZqZmGP3JMnekEyo6rzQcbvIx
   R1jxTwrWyAJ3k8tr3gcWNdXR0hc0yL4Yr0w+uu8aiV1bL5YlO8imtrOvT
   nIYBJMtKOSYi6On7pE4CzcAar7JgZZW0QmOEteeOFcvCLGC3LXpvdM0Sp
   lLzXWPWYTSN+krFXZ5DRtN+9NOrsJ1kWHA0kMhUdH9BSWSPj5BfaHOdbJ
   nAcUbflw1vcSknZkKL9yCtElml6vi1TQQPx84s/KRW9aez6kZJISs5Yn7
   RhVhpbCZIZODmGVnxqYxKtx/emDUjbbgLEXwgWXA6niCcqB7UobM1HAcS
   Q==;
X-CSE-ConnectionGUID: 8gchjDJpTwecO1iMXTU8EA==
X-CSE-MsgGUID: VrUvjAJBTFaJ8Wlt8sBQBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71201994"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71201994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 05:37:15 -0800
X-CSE-ConnectionGUID: Pi+iOTn+TUmPJYJvu1hYJw==
X-CSE-MsgGUID: i7n0Rbc6QMqmKejyMb34ZQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Feb 2026 05:37:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnGab-00000000ghI-399c;
	Tue, 03 Feb 2026 13:37:09 +0000
Date: Tue, 3 Feb 2026 21:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai@fnnas.com>, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai@fnnas.com,
	zhengqixing@huawei.com, mkoutny@suse.com, hch@infradead.org,
	ming.lei@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 2/7] bfq: protect q->blkg_list iteration in
 bfq_end_wr_async() with blkcg_mutex
Message-ID: <202602032109.oYgANNeZ-lkp@intel.com>
References: <20260203080602.726505-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203080602.726505-3-yukuai@fnnas.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13640-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 92983D9F83
X-Rspamd-Action: no action

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-cgroup-protect-q-blkg_list-iteration-in-blkg_destroy_all-with-blkcg_mutex/20260203-161356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260203080602.726505-3-yukuai%40fnnas.com
patch subject: [PATCH v2 2/7] bfq: protect q->blkg_list iteration in bfq_end_wr_async() with blkcg_mutex
config: s390-randconfig-002-20260203 (https://download.01.org/0day-ci/archive/20260203/202602032109.oYgANNeZ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602032109.oYgANNeZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602032109.oYgANNeZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/bfq-iosched.c:2648:27: error: no member named 'blkcg_mutex' in 'struct request_queue'
    2648 |         mutex_lock(&bfqd->queue->blkcg_mutex);
         |                     ~~~~~~~~~~~  ^
   include/linux/mutex.h:193:44: note: expanded from macro 'mutex_lock'
     193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
   block/bfq-iosched.c:2660:29: error: no member named 'blkcg_mutex' in 'struct request_queue'
    2660 |         mutex_unlock(&bfqd->queue->blkcg_mutex);
         |                       ~~~~~~~~~~~  ^
   2 errors generated.


vim +2648 block/bfq-iosched.c

  2642	
  2643	static void bfq_end_wr(struct bfq_data *bfqd)
  2644	{
  2645		struct bfq_queue *bfqq;
  2646		int i;
  2647	
> 2648		mutex_lock(&bfqd->queue->blkcg_mutex);
  2649		spin_lock_irq(&bfqd->lock);
  2650	
  2651		for (i = 0; i < bfqd->num_actuators; i++) {
  2652			list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
  2653				bfq_bfqq_end_wr(bfqq);
  2654		}
  2655		list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
  2656			bfq_bfqq_end_wr(bfqq);
  2657		bfq_end_wr_async(bfqd);
  2658	
  2659		spin_unlock_irq(&bfqd->lock);
  2660		mutex_unlock(&bfqd->queue->blkcg_mutex);
  2661	}
  2662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

