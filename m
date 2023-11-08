Return-Path: <cgroups+bounces-234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B97E5134
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7543F1C20D3E
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D9D2F0;
	Wed,  8 Nov 2023 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9h86v1a"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF150D2EA;
	Wed,  8 Nov 2023 07:37:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3391710;
	Tue,  7 Nov 2023 23:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699429078; x=1730965078;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TpGd3HGFIDIBnfCapFtkocNEgRH8g9vMjuBQGrRQR0M=;
  b=Q9h86v1awSG09m3j9c/gb2ndWh6v/mkvdL8O7vrdIICCAV7ockpj6lUL
   dGj51C8dXqQkgUi6Rd/PCNnUE2+1JZexOUEOoRxwk61aChaumf63AZs6G
   ece9nCdIpR/fvaDOVRCbjRjAYRiQE5W4ZJnhTyn99g0NKPyKpKP+GfM8G
   Qr+KMby23OiOlJi9gKYWVwtuPi48SyEDZIKTu3rN4vW6SnDsy/sLdLA0D
   isVvo/5O9my3F5ST97L1V/2d4rGrRSUGSrRjcyBb3lERFtC6rtpsbwpCc
   Ah3PRd/1C0FuPq0Kbzb/tNWF7Cq3hz9MP9/Qi2OgMYVYfWTi0qa9x8IiZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="454012833"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="454012833"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="853651335"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="853651335"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:37:50 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Huan Yang <link@vivo.com>
Cc: Tejun Heo <tj@kernel.org>,  Zefan Li <lizefan.x@bytedance.com>,
  "Johannes Weiner" <hannes@cmpxchg.org>,  Jonathan Corbet
 <corbet@lwn.net>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeelb@google.com>,  Muchun
 Song <muchun.song@linux.dev>,  Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand <david@redhat.com>,  "Matthew Wilcox"
 <willy@infradead.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Peter
 Xu <peterx@redhat.com>,  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
  Yosry Ahmed <yosryahmed@google.com>,  "Liu Shixin"
 <liushixin2@huawei.com>,  Hugh Dickins <hughd@google.com>,
  <cgroups@vger.kernel.org>,  <linux-doc@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
In-Reply-To: <20231108065818.19932-1-link@vivo.com> (Huan Yang's message of
	"Wed, 8 Nov 2023 14:58:11 +0800")
References: <20231108065818.19932-1-link@vivo.com>
Date: Wed, 08 Nov 2023 15:35:50 +0800
Message-ID: <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Huan Yang <link@vivo.com> writes:

> In some cases, we need to selectively reclaim file pages or anonymous
> pages in an unbalanced manner.
>
> For example, when an application is pushed to the background and frozen,
> it may not be opened for a long time, and we can safely reclaim the
> application's anonymous pages, but we do not want to touch the file pages.
>
> This patchset extends the proactive reclaim interface to achieve
> unbalanced reclamation. Users can control the reclamation tendency by
> inputting swappiness under the original interface. Specifically, users
> can input special values to extremely reclaim specific pages.

From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
swappiness.  So you need to add that firstly?

> Example:
>   	echo "1G" 200 > memory.reclaim (only reclaim anon)
> 	  echo "1G" 0  > memory.reclaim (only reclaim file)
> 	  echo "1G" 1  > memory.reclaim (only reclaim file)
>
> Note that when performing unbalanced reclamation, the cgroup swappiness
> will be temporarily adjusted dynamically to the input value. Therefore,
> if the cgroup swappiness is further modified during runtime, there may
> be some errors.

If cgroup swappiness will be adjusted temporarily, why not just change
it via a script before/after proactive reclaiming?

> However, this is acceptable because the interface is dynamically called
> by the user and the timing should be controlled by the user.
>
> This patchset did not implement the type-based reclamation as expected
> in the documentation.(anon or file) Because in addition to extreme unbalanced
> reclamation, this patchset can also adapt to the reclamation tendency
> allocated according to swappiness, which is more flexible.
>
> Self test
> ========
> After applying the following patches and myself debug patch, my self-test
> results are as follows:
>
> 1. LRU test
> ===========
>   a. Anon unbalance reclaim
>   ```
>   cat memory.stat | grep anon
>     inactive_anon 7634944
>     active_anon 7741440
>
>   echo "200M" 200 > memory.reclaim
>
>   cat memory.stat | grep anon
>     inactive_anon 0
>     active_anon 0
>
>   cat memory.reclaim_stat_summary(self debug interface)
>     [22368]sh total reclaimed 0 file, 3754 anon, covered item=0
>   ```
>
>   b. File unbalance reclaim
>   ```
>   cat memory.stat | grep file
>     inactive_file 82862080
>     active_file 48664576
>
>   echo "100M" 0 > memory.reclaim
>   cat memory.stat | grep file
>     inactive_file 34164736
>     active_file 18370560
>
>   cat memory.reclaim_stat_summary(self debug interface)
>     [22368]sh total reclaimed 13732 file, 0 anon, covered item=0
>   ```
>
> 2. MGLRU test
> ============
> a. Anon unbalance reclaim
> ```
> echo y > /sys/kernel/mm/lru_gen/enabled
> cat /sys/kernel/mm/lru_gen/enabled
>   0x0003
>
> cat memory.stat | grep anon
>   inactive_anon 17653760
>   active_anon 1740800
>
> echo "100M" 200 > memory.reclaim
>
> cat memory.reclaim_stat_summary
>   [8251]sh total reclaimed 0 file, 5393 anon, covered item=0
> ```
>
> b. File unbalance reclaim
> ```
> cat memory.stat | grep file
>   inactive_file 17858560
>   active_file 5943296
>
> echo "100M" 0 > memory.reclaim
>
> cat memory.stat | grep file
>   inactive_file 491520
>   active_file 2764800
> cat memory.reclaim_stat_summary
>   [8251]sh total reclaimed 5230 file, 0 anon, covered item=0
> ```
>
> Patch 1-3 implement the functionality described above.
> Patch 4 aims to implement proactive reclamation to the cgroupv1 interface
> for use on Android.
>
> Huan Yang (4):
>   mm: vmscan: LRU unbalance cgroup reclaim
>   mm: multi-gen LRU: MGLRU unbalance reclaim
>   mm: memcg: implement unbalance proactive reclaim
>   mm: memcg: apply proactive reclaim into cgroupv1

We will not add new features to cgroupv1 in upstream.

>  .../admin-guide/cgroup-v1/memory.rst          |  38 +++++-
>  Documentation/admin-guide/cgroup-v2.rst       |  16 ++-
>  include/linux/swap.h                          |   1 +
>  mm/memcontrol.c                               | 126 ++++++++++++------
>  mm/vmscan.c                                   |  38 +++++-
>  5 files changed, 169 insertions(+), 50 deletions(-)

--
Best Regards,
Huang, Ying

