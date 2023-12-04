Return-Path: <cgroups+bounces-779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4895802BBA
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 07:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39C41C20837
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF67476;
	Mon,  4 Dec 2023 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHL6YQnt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781DD3
	for <cgroups@vger.kernel.org>; Sun,  3 Dec 2023 22:53:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40bda47b7c1so21179905e9.1
        for <cgroups@vger.kernel.org>; Sun, 03 Dec 2023 22:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701672808; x=1702277608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HssFuAN0FmKtkeeOfUTQqNEnbKypEzyj8/UffXjzYs=;
        b=vHL6YQnt8fqyvFd40jrM/OoLorA0Vf5lBiTOPLFprKdpvLom73+3YI7wlbvBFuTPZq
         PYPVdW5KW8MfdJCq21w5vs9s5cH5e6MUnAlg/KCSnZhd4k1SRhi1ZROndcIIYId4xS+D
         5jz/dS8pA84Vk2KcTGt4DSiG/+DtYQ/8CA+Yht5xClQQKRGSbEpovL+pzJxAOEqTL7CP
         nlSyGgIXq0M+TwKebMpLHmM83JR53b5mSeeM8bvqtIaH6IjpR0Br/hZaigzSzZWJBFj9
         RIm9YpFVYjAZNQHkUdVWjJPK6QqRDzBO9o3UpFAZ1dE3TN4NvVXy3cb2ZRbUsOj4kF9M
         1skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701672808; x=1702277608;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HssFuAN0FmKtkeeOfUTQqNEnbKypEzyj8/UffXjzYs=;
        b=lI9CAIFXVMSJYWJjxaRxAjOWy/4F5wAyy9CpFWYITJCBHua/DTYtEU1ffouGTPdllr
         oVtOE7Mf8vVr04GRUar7YQklcDR1v7IxN3t9rgVNHjAC1CmnK9Lxg3XIu7C8eR0KEp0B
         W4s7QzTpqsfDa+ZnbUqIHpFQSeM5p+oxyKAaz0B061W+VECNKKx6ptSg1BKsDgoUM/NM
         F05gs1zBoO+c7kmYnqOkc0Z2tWm9seyiwPsZWJUABXOWVpTnu5UZYwRmG3xJgGDij3T/
         +PEfLWVMzCN6K+6vwQ+YdiWj+r1Cj1XecK2xCRojCh23tb68kqVEctuZUl7Ax6TDWZm3
         T/zw==
X-Gm-Message-State: AOJu0YwOT8rHGEkghFaMxO8hQ/p0hJ8qiSySUHXWVbzvi78Ccfjcm+1U
	Jpiqdppktl9Ye41NhijspHJXyg==
X-Google-Smtp-Source: AGHT+IHtHa+5n4xN3AEKMSwT6hpelKtTdR3K3TiRCO07QqooArIjEdGOaVc05secXlj0uyQfVGAD9w==
X-Received: by 2002:a05:600c:4fcf:b0:40b:5f03:b3b7 with SMTP id o15-20020a05600c4fcf00b0040b5f03b3b7mr968898wmq.217.1701672808259;
        Sun, 03 Dec 2023 22:53:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b003333fa3d043sm4558913wrx.12.2023.12.03.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 22:53:28 -0800 (PST)
Date: Mon, 4 Dec 2023 09:53:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Huan Yang <link@vivo.com>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Liu Shixin <liushixin2@huawei.com>, Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: Re: [PATCH 2/4] mm: multi-gen LRU: MGLRU unbalance reclaim
Message-ID: <43b48148-fdfb-4ea3-8d7b-d3ebce7a04da@suswa.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108065818.19932-3-link@vivo.com>

Hi Huan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huan-Yang/mm-vmscan-LRU-unbalance-cgroup-reclaim/20231108-151757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231108065818.19932-3-link%40vivo.com
patch subject: [PATCH 2/4] mm: multi-gen LRU: MGLRU unbalance reclaim
config: x86_64-randconfig-161-20231108 (https://download.01.org/0day-ci/archive/20231204/202312040256.guajrRNm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312040256.guajrRNm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312040256.guajrRNm-lkp@intel.com/

smatch warnings:
mm/vmscan.c:4518 isolate_folios() error: uninitialized symbol 'unbalance'.

vim +/unbalance +4518 mm/vmscan.c

ac35a490237446 Yu Zhao   2022-09-18  4481  static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
ac35a490237446 Yu Zhao   2022-09-18  4482  			  int *type_scanned, struct list_head *list)
ac35a490237446 Yu Zhao   2022-09-18  4483  {
ac35a490237446 Yu Zhao   2022-09-18  4484  	int i;
ac35a490237446 Yu Zhao   2022-09-18  4485  	int type;
ac35a490237446 Yu Zhao   2022-09-18  4486  	int scanned;
ac35a490237446 Yu Zhao   2022-09-18  4487  	int tier = -1;
9da842af0b17c7 Huan Yang 2023-11-08  4488  	bool unbalance;

unbalance is never set to false.  Only to true.

ac35a490237446 Yu Zhao   2022-09-18  4489  	DEFINE_MIN_SEQ(lruvec);
ac35a490237446 Yu Zhao   2022-09-18  4490  
ac35a490237446 Yu Zhao   2022-09-18  4491  	/*
ac35a490237446 Yu Zhao   2022-09-18  4492  	 * Try to make the obvious choice first. When anon and file are both
ac35a490237446 Yu Zhao   2022-09-18  4493  	 * available from the same generation, interpret swappiness 1 as file
ac35a490237446 Yu Zhao   2022-09-18  4494  	 * first and 200 as anon first.
ac35a490237446 Yu Zhao   2022-09-18  4495  	 */
9da842af0b17c7 Huan Yang 2023-11-08  4496  	if (unlikely(unbalance_file_reclaim(sc, swappiness))) {
9da842af0b17c7 Huan Yang 2023-11-08  4497  		unbalance = true;
9da842af0b17c7 Huan Yang 2023-11-08  4498  		type = LRU_GEN_FILE;
9da842af0b17c7 Huan Yang 2023-11-08  4499  	} else if (unlikely(unbalance_anon_reclaim(sc, swappiness))) {
9da842af0b17c7 Huan Yang 2023-11-08  4500  		unbalance = true;
9da842af0b17c7 Huan Yang 2023-11-08  4501  		type = LRU_GEN_ANON;
9da842af0b17c7 Huan Yang 2023-11-08  4502  	} else if (!swappiness)
ac35a490237446 Yu Zhao   2022-09-18  4503  		type = LRU_GEN_FILE;
ac35a490237446 Yu Zhao   2022-09-18  4504  	else if (min_seq[LRU_GEN_ANON] < min_seq[LRU_GEN_FILE])
ac35a490237446 Yu Zhao   2022-09-18  4505  		type = LRU_GEN_ANON;
ac35a490237446 Yu Zhao   2022-09-18  4506  	else if (swappiness == 1)
ac35a490237446 Yu Zhao   2022-09-18  4507  		type = LRU_GEN_FILE;
ac35a490237446 Yu Zhao   2022-09-18  4508  	else if (swappiness == 200)
ac35a490237446 Yu Zhao   2022-09-18  4509  		type = LRU_GEN_ANON;
ac35a490237446 Yu Zhao   2022-09-18  4510  	else
ac35a490237446 Yu Zhao   2022-09-18  4511  		type = get_type_to_scan(lruvec, swappiness, &tier);
ac35a490237446 Yu Zhao   2022-09-18  4512  
ac35a490237446 Yu Zhao   2022-09-18  4513  	for (i = !swappiness; i < ANON_AND_FILE; i++) {
ac35a490237446 Yu Zhao   2022-09-18  4514  		if (tier < 0)
ac35a490237446 Yu Zhao   2022-09-18  4515  			tier = get_tier_idx(lruvec, type);
ac35a490237446 Yu Zhao   2022-09-18  4516  
ac35a490237446 Yu Zhao   2022-09-18  4517  		scanned = scan_folios(lruvec, sc, type, tier, list);
9da842af0b17c7 Huan Yang 2023-11-08 @4518  		if (scanned || unbalance)
                                                                       ^^^^^^^^^

ac35a490237446 Yu Zhao   2022-09-18  4519  			break;
ac35a490237446 Yu Zhao   2022-09-18  4520  
ac35a490237446 Yu Zhao   2022-09-18  4521  		type = !type;
ac35a490237446 Yu Zhao   2022-09-18  4522  		tier = -1;
ac35a490237446 Yu Zhao   2022-09-18  4523  	}
ac35a490237446 Yu Zhao   2022-09-18  4524  
ac35a490237446 Yu Zhao   2022-09-18  4525  	*type_scanned = type;
ac35a490237446 Yu Zhao   2022-09-18  4526  
ac35a490237446 Yu Zhao   2022-09-18  4527  	return scanned;
ac35a490237446 Yu Zhao   2022-09-18  4528  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


