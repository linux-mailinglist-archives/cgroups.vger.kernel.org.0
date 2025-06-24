Return-Path: <cgroups+bounces-8629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD99AE69D9
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17643B67DB
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC802D4B4F;
	Tue, 24 Jun 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7yTzFUL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E45291C09
	for <cgroups@vger.kernel.org>; Tue, 24 Jun 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776441; cv=none; b=ohSbcN9V1Qgcl+2k0h9ZOnA/YIdBoo0I7uE+OB9zXRkPU5xJU14fv5PigfPVXyFHM8E+26S4Ua8FPA9txyxbJ+fgB3r643+AVOy+knz+RCus7fnX4+xpvBGbv5jKTgTUuLKsfjh1K4/3ubgRPGhat4RkqVLNqD+JEVMTeKoURs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776441; c=relaxed/simple;
	bh=8ndPHen9gVkkJ8keDVpzacmHbP27NW7V1US5clTByPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i26V1XRgf41D71JLCeixQPyH5mfxBtXFtzLYajfX+U0FhsITxaW5B4MJv7oyGQEA8YICqRncLSV4kLdJHSeB64Byd4cI/EFzzOOavyIgemHCi9yRzywlvMgDaCPLJlsocH267OIYAR8gqPPGBlyD226Ls5CAHJwBicV3YFh46Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7yTzFUL; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d0920ce388so230806fac.0
        for <cgroups@vger.kernel.org>; Tue, 24 Jun 2025 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750776438; x=1751381238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uA5wqktVLlF/6ye0p0dHnC0cgi9tO2Q4YJtZShQkDM=;
        b=S7yTzFULc5CXJsRIC5173wiH7MWg7S2jAZVWcY2Z31jCV/HO8fuVohaaCEBNBp5VfG
         9tMTMPxCa/YrWmZPBPuv26imBccyzD8O+k4T9RDv+dhE1UWbJcGM+kl+PaPVH/UgRyUG
         LHTO8i6vG51dEOvCIKRs9LTgo+BMazMKK6lWDRXlDDJJisJPGR7y0uWT+SOKU64inzAM
         S5yIuvzpsFaKYosuAOApn9M09ILykHwMln4vF1UhAkwGRtnBcfC/5/PGPJ1995WWC51j
         IA21b7m4fY7xtiw2O0mj0nvbkyRHL6nq8lrY88A2A7Rtq6ba/QxrjxW/p8wlyT+uaV7V
         MxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776438; x=1751381238;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uA5wqktVLlF/6ye0p0dHnC0cgi9tO2Q4YJtZShQkDM=;
        b=vt22jRGdCYJQJMSOSVycWNRZL/bEkv4dl7HJNQCie3DRLiS1XS4mDq9tcZYLOsRvoE
         JgFJ+W3aM2s8MRML4I3HtfSKAhhfFC4CvN2ntgsH+ExMwSX6HOY5U7LxYBKXOeGDrfMn
         tQx2bkaNsxdCiPyE3J8CpBtW3qSamY9WgnFeK0f2wylJU2ikUe6e204p35YEl5wh5KFm
         9dJ7bVsCrCgPTuqSnTaXP3d5eO5ynfE7DExGuqYSehEP8zHOgl/3OkLirvS44ggZ+VJ1
         coEfttq2+KN2TJpNb3eoXvaKrC3V2EVg8MrPenqq0lAwgw86Ecdjhi2WtTGRoFJOEo/K
         alOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUea4g4q3UoIK0U63MUcHdY3X2R+C7djBw6/EfFLntSKVQKPnMAO8T0gFazubNcxZMGIPTNKJCd@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDVzKtJVR8vdt7uoNizHRtCH9dzHofevERHmG44zSUitnViIO
	ni37LlCa7Y3b+0OLTGCv/1ksfW5vRmFq/Lg1fVCnch0PZ7brru3UISy3R1D22qGU/lM=
X-Gm-Gg: ASbGncuUSF63iBzlLNPTEDB7hPE4goVjtoVRYdfMnDirJBMh6530uUeMYIMcIFxOyWz
	7hoX58Z4FJgv9FCXHm4Z2WeSRSufhvBc2ZkAT+nNICAYleXaDYM/7Aqqss1pCKgAMdCWzWK8HtK
	/2NptPc6FNNCpy7RpjoD4ihLMKtZSvguljVD3aenOtsBfQS1d0zaXD1bc5ER6ky3p20P5J07N7d
	U1CTz+725Zm5FkzvKxtNHRzlJ7hxm6RPKBXX5TfYxj9AVA9SjsSxtAAL0OxPz/812qbglJWu0gc
	d7vL+EcdKN4FSrih1dD0ZXk7+DPZPmF/Z4rxxrKz0nhezsxzlkSZ+xMPuscaMi8V/wR4gw==
X-Google-Smtp-Source: AGHT+IGt8ie5ZbF0x4WPTsVM6n791kVfLV7Ad3NJEmRPz2hPk2XoNedp9cCuBS6gbjfhNJu6obKMeQ==
X-Received: by 2002:a05:6870:2487:b0:2c2:b9cc:afb8 with SMTP id 586e51a60fabf-2eeda4e389cmr9736316fac.7.1750776438135;
        Tue, 24 Jun 2025 07:47:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:22c9:dcd3:f442:dd1d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee6655a39asm2104434fac.15.2025.06.24.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:47:16 -0700 (PDT)
Date: Tue, 24 Jun 2025 17:47:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Zhongkun He <hezhongkun.hzk@bytedance.com>,
	akpm@linux-foundation.org, tytso@mit.edu, jack@suse.com,
	hannes@cmpxchg.org, mhocko@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, muchun.song@linux.dev,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/2] mm: memcg: introduce PF_MEMALLOC_ACCOUNTFORCE to
 postpone reclaim to return-to-userland path
Message-ID: <400e2b89-1ad7-4626-9ee0-e45a9e5b5227@suswa.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71a4bbc284048ceb38eaac53dfa1031f92ac52b7.1750234270.git.hezhongkun.hzk@bytedance.com>

Hi Zhongkun,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongkun-He/mm-memcg-introduce-PF_MEMALLOC_ACCOUNTFORCE-to-postpone-reclaim-to-return-to-userland-path/20250618-194101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/71a4bbc284048ceb38eaac53dfa1031f92ac52b7.1750234270.git.hezhongkun.hzk%40bytedance.com
patch subject: [PATCH 1/2] mm: memcg: introduce PF_MEMALLOC_ACCOUNTFORCE to postpone reclaim to return-to-userland path
config: i386-randconfig-141-20250619 (https://download.01.org/0day-ci/archive/20250624/202506242032.uShv7ASV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202506242032.uShv7ASV-lkp@intel.com/

smatch warnings:
mm/memcontrol.c:2341 mem_cgroup_handle_over_max() warn: use 'gfp_mask' here instead of GFP_KERNEL?

vim +/gfp_mask +2341 mm/memcontrol.c

b5db553cc19549 Zhongkun He 2025-06-18  2320  void mem_cgroup_handle_over_max(gfp_t gfp_mask)
                                                                                   ^^^^^^^^
b5db553cc19549 Zhongkun He 2025-06-18  2321  {
b5db553cc19549 Zhongkun He 2025-06-18  2322  	unsigned long nr_reclaimed = 0;
b5db553cc19549 Zhongkun He 2025-06-18  2323  	unsigned int nr_pages = current->memcg_nr_pages_over_max;
b5db553cc19549 Zhongkun He 2025-06-18  2324  	int nr_retries = MAX_RECLAIM_RETRIES;
b5db553cc19549 Zhongkun He 2025-06-18  2325  	struct mem_cgroup *memcg, *mem_over_limit;
b5db553cc19549 Zhongkun He 2025-06-18  2326  
b5db553cc19549 Zhongkun He 2025-06-18  2327  	if (likely(!nr_pages))
b5db553cc19549 Zhongkun He 2025-06-18  2328  		return;
b5db553cc19549 Zhongkun He 2025-06-18  2329  
b5db553cc19549 Zhongkun He 2025-06-18  2330  	memcg = get_mem_cgroup_from_mm(current->mm);
b5db553cc19549 Zhongkun He 2025-06-18  2331  	current->memcg_nr_pages_over_max = 0;
b5db553cc19549 Zhongkun He 2025-06-18  2332  
b5db553cc19549 Zhongkun He 2025-06-18  2333  retry:
b5db553cc19549 Zhongkun He 2025-06-18  2334  	mem_over_limit = get_over_limit_memcg(memcg);
b5db553cc19549 Zhongkun He 2025-06-18  2335  	if (!mem_over_limit)
b5db553cc19549 Zhongkun He 2025-06-18  2336  		goto out;
b5db553cc19549 Zhongkun He 2025-06-18  2337  
b5db553cc19549 Zhongkun He 2025-06-18  2338  	while (nr_reclaimed < nr_pages) {
b5db553cc19549 Zhongkun He 2025-06-18  2339  		unsigned long reclaimed;
b5db553cc19549 Zhongkun He 2025-06-18  2340  
b5db553cc19549 Zhongkun He 2025-06-18 @2341  		reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit,
b5db553cc19549 Zhongkun He 2025-06-18  2342  					nr_pages, GFP_KERNEL,

I guess GFP_KERNEL is fine.  The gfp_mask is used below.  Don't worry
about this one if the GFP_KERNEL is intended.  Just ignore the warning
message.

b5db553cc19549 Zhongkun He 2025-06-18  2343  					MEMCG_RECLAIM_MAY_SWAP,
b5db553cc19549 Zhongkun He 2025-06-18  2344  					NULL);
b5db553cc19549 Zhongkun He 2025-06-18  2345  
b5db553cc19549 Zhongkun He 2025-06-18  2346  		if (!reclaimed && !nr_retries--)
b5db553cc19549 Zhongkun He 2025-06-18  2347  			break;
b5db553cc19549 Zhongkun He 2025-06-18  2348  
b5db553cc19549 Zhongkun He 2025-06-18  2349  		nr_reclaimed += reclaimed;
b5db553cc19549 Zhongkun He 2025-06-18  2350  	}
b5db553cc19549 Zhongkun He 2025-06-18  2351  
b5db553cc19549 Zhongkun He 2025-06-18  2352  	if ((nr_reclaimed < nr_pages) &&
b5db553cc19549 Zhongkun He 2025-06-18  2353  	    (page_counter_read(&mem_over_limit->memory) >
b5db553cc19549 Zhongkun He 2025-06-18  2354  	    READ_ONCE(mem_over_limit->memory.max)) &&
b5db553cc19549 Zhongkun He 2025-06-18  2355  	    mem_cgroup_oom(mem_over_limit, gfp_mask,
b5db553cc19549 Zhongkun He 2025-06-18  2356  			  get_order((nr_pages - nr_reclaimed)  * PAGE_SIZE))) {
b5db553cc19549 Zhongkun He 2025-06-18  2357  		nr_retries = MAX_RECLAIM_RETRIES;
b5db553cc19549 Zhongkun He 2025-06-18  2358  		goto retry;
b5db553cc19549 Zhongkun He 2025-06-18  2359  	}
b5db553cc19549 Zhongkun He 2025-06-18  2360  
b5db553cc19549 Zhongkun He 2025-06-18  2361  out:
b5db553cc19549 Zhongkun He 2025-06-18  2362  	css_put(&memcg->css);
b5db553cc19549 Zhongkun He 2025-06-18  2363  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


