Return-Path: <cgroups+bounces-12779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B82CE0289
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60563008E99
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254A2698AF;
	Sat, 27 Dec 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svlL/IHA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC611E868;
	Sat, 27 Dec 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766873534; cv=none; b=FPkO2BqkirjT0kzvTu3hBt2UoCZ9CfrJ7IqQqcJG05wN6Y34Lg7U+MktJVbRO7i9wgC63xclnkr234b69zL/Q3bUZFH87LOkKwttTGImdSljwxMSMdr189byB7icNJ6Xy0x5FOYsRiaZImSPaogIsAqyRfoLA3CskIiMj1tAt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766873534; c=relaxed/simple;
	bh=VOh/YL2n8G3f+/QICIKeFajquKb19s2MloMaGXxPaq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3yYQ9VIEDQwW50/6Mk+d9Dc7egNdZdMDePakpKVrU2GYbtGkKiGSTFuqb1sfdpesZOu/Q7VBQ8QVvS7clxmrQy5QPf/bV6rfTHxo/KMUh4JXWMXSX2AwBoT+aDZepZxFGU2bNYgUzTPuKioPQJEVrPz4XkYVa6Tcb8wqMP2Ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svlL/IHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F66C4CEF1;
	Sat, 27 Dec 2025 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766873533;
	bh=VOh/YL2n8G3f+/QICIKeFajquKb19s2MloMaGXxPaq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svlL/IHAsDuzcsygJQQL6bqUfHBQ8mf1KQDuQC628cQfUO5fgZbkggax/Xp9mYZxf
	 /kGaXzp7Xi8L17G7bpdrQUyIwYnJnS1PrAG2EIXZ/q8VVU9pZiUyEewb5inI0uroUL
	 fqOcS9lBr1s5tC/cZup5FFUXo6EsH0iiXUK09Riavai75+mTex0/z63bVZhZ8qEv+L
	 uzTkoHX9qPbbm5uy2h0dx92dZDtRFCdpXX/UQ86wpLAXqmy+8+QEUMqneU53wGsRMm
	 sQaNgp5O3D2u6GzM1hJwKJ7aHNxJP+BFESWpcHumR8vRGAzb6Z/eQBktZgXH3E3fq0
	 s4fut9++L5D9A==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Date: Sat, 27 Dec 2025 14:12:05 -0800
Message-ID: <20251227221206.282703-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202512262045.CkWwCNp7-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Dec 2025 20:31:38 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Shakeel,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on sj/damon/next]
> [cannot apply to akpm-mm/mm-everything tj-cgroup/for-next linus/master v6.19-rc2 next-20251219]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/memcg-introduce-private-id-API-for-in-kernel-users/20251226-072954
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next

damon/next tree contains some debugging-purpose only changes that not aim to be
upstreamed.

> patch link:    https://lore.kernel.org/r/20251225232116.294540-9-shakeel.butt%40linux.dev
> patch subject: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
> config: arm64-randconfig-001-20251226 (https://download.01.org/0day-ci/archive/20251226/202512262045.CkWwCNp7-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512262045.CkWwCNp7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512262045.CkWwCNp7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/damon/sysfs.c:2704:33: warning: format specifies type 'unsigned int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
>     2704 |                 pr_info("id: %u, path: %s\n", mem_cgroup_id(memcg), path);
>          |                              ~~               ^~~~~~~~~~~~~~~~~~~~
>          |                              %llu

And this issue happens due to a damon/next chage that made for only debugging
and thus not aiming to be upstreamed.  Hence, no action from Shakeel is needed.

I will resolve this issue after this patch is added to damon/next.


Thanks,
SJ

[...]

