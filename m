Return-Path: <cgroups+bounces-11431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF2C1FE23
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922781A6375A
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC833F384;
	Thu, 30 Oct 2025 11:51:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB402641FB;
	Thu, 30 Oct 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825064; cv=none; b=Kfzm7Cq/bW3BSIyJOVBI50XJt3yacI0+qI1coqBuKpSFn7uidt49i10enOZ4SFwcGhXq85rf3FtQ1RAsMx86R4un+zjXO4yP3BFGeHDjT3RhGNzj9DiEdB0vt0w+kaJ8evzEaDXMgZBotZIF77n8m/QyRcZKPs+uz/hEMnIJW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825064; c=relaxed/simple;
	bh=QIS0nTgd8Yks5rn0YdXxKcA8EFMyWIsZaG7wRpISRlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qryfKVqIHufxSodYhDrdUP5ai0p5LtTqfTZTrZw42vqOrtZqBRiGGKd3PA9VFG34GK1gFFyzFk01BEStPBTALKtGgoXo8zzK6FM1wapBWu5b4ArV+DCEJLYeyn6JiB4Z30j/UB/d2Vraocl7KHQBdI15DwdgaEhlBG9OOsNEBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cy24h54rFzYkxgw;
	Thu, 30 Oct 2025 19:31:32 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 19:32:33 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 19:32:32 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <shakeel.butt@linux.dev>
CC: <akpm@linux-foundation.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
	<christoph.boehmwalder@linbit.com>, <corbet@lwn.net>,
	<drbd-dev@lists.linbit.com>, <dsterba@suse.com>, <feng.han@honor.com>,
	<hannes@cmpxchg.org>, <jinji.z.zhong@gmail.com>, <lars.ellenberg@linbit.com>,
	<linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mhocko@kernel.org>, <minchan@kernel.org>, <mkoutny@suse.com>,
	<muchun.song@linux.dev>, <philipp.reisner@linbit.com>,
	<roman.gushchin@linux.dev>, <senozhatsky@chromium.org>, <terrelln@fb.com>,
	<tj@kernel.org>, <zhongjinji@honor.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Thu, 30 Oct 2025 19:32:28 +0800
Message-ID: <20251030113228.18817-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <k6jwua5rlkds7dxomwvxotwtjq4hauyevvyoxd5hjz733k7kk5@mmezlradxhpu>
References: <k6jwua5rlkds7dxomwvxotwtjq4hauyevvyoxd5hjz733k7kk5@mmezlradxhpu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

> Hi Jinji,
> 
> On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> > Hello everyone,
> > 
> > On Android, different applications have varying tolerance for
> > decompression latency. Applications with higher tolerance for
> > decompression latency are better suited for algorithms like ZSTD,
> > which provides high compression ratio but slower decompression
> > speed. Conversely, applications with lower tolerance for
> > decompression latency can use algorithms like LZ4 or LZO that
> > offer faster decompression but lower compression ratios. For example,
> > lightweight applications (with few anonymous pages) or applications
> > without foreground UI typically have higher tolerance for decompression
> > latency.
> > 
> > Similarly, in memory allocation slow paths or under high CPU
> > pressure, using algorithms with faster compression speeds might
> > be more appropriate.
> > 
> > This patch introduces a per-cgroup compression priority mechanism,
> > where different compression priorities map to different algorithms.
> > This allows administrators to select appropriate compression
> > algorithms on a per-cgroup basis.
> > 
> > Currently, this patch is experimental and we would greatly
> > appreciate community feedback. I'm uncertain whether obtaining
> > compression priority via get_cgroup_comp_priority in zram is the
> > best approach. While this implementation is convenient, it seems
> > somewhat unusual. Perhaps the next step should be to pass
> > compression priority through page->private.
> > 
> 
> Setting aside the issues in the implementation (like changing
> compression algorithm of a cgroup while it already has some memory

Zram uses flags to track the compression priority of each page,
which should be ok when the page is decompressed.

> compressed using older algo), I don't think memcg interface is the right
> way to go about it. We usually add interfaces to memcg that have
> hierarchical semantics.

Thanks a lot, Shakeel. I got it.

> Anyways if you want to have this feature, I think BPF might be the way
> to get this flexibility without introducing any stable API and then you
> can experiment and evaluate if this really helps.


