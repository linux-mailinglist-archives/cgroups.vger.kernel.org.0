Return-Path: <cgroups+bounces-11427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05673C1F580
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106D24EA33F
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB6343D70;
	Thu, 30 Oct 2025 09:38:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449A342145;
	Thu, 30 Oct 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817111; cv=none; b=mLP/X3yKmIlROuI6SFjPeRrI/RagMTR52IXFfSNfvbsFWeHEN4OuFfB0Plasse200mOqoE8JB7GeYC01CBeEMX7cG6z+IsjVKFT/0nu4+SmHu3akdwdncUC4TQI+U+xhE+r4CEjdwQjzdt4jSFQm7sO1DMn6ajeRM0ocHw2aE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817111; c=relaxed/simple;
	bh=+ZwnTMBnWIAb8iGPJ9ruuqYPni5mZ8ZCofxgvftxBms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys7ina0+pGGHwdpYqpFjZ+UprPyazDwiaE/9Yk7D8XfuOLN0O0qLIHK9t/uBRapuxJUJgNvRaAYt4srrTxXa3NJbjoUnOJkn3HDVa7VBIMHQMNQdTXcQoe3D62yRatB9snlFnMQMfpuM6cqT0njE8dRmpvLx9wvLR8hkJjaV3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cxzCF3ckdzYlcX2;
	Thu, 30 Oct 2025 17:22:01 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:23:02 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:23:02 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <tj@kernel.org>
CC: <akpm@linux-foundation.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
	<christoph.boehmwalder@linbit.com>, <corbet@lwn.net>,
	<drbd-dev@lists.linbit.com>, <dsterba@suse.com>, <feng.han@honor.com>,
	<hannes@cmpxchg.org>, <jinji.z.zhong@gmail.com>, <lars.ellenberg@linbit.com>,
	<linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mhocko@kernel.org>, <minchan@kernel.org>, <mkoutny@suse.com>,
	<muchun.song@linux.dev>, <philipp.reisner@linbit.com>,
	<roman.gushchin@linux.dev>, <senozhatsky@chromium.org>,
	<shakeel.butt@linux.dev>, <terrelln@fb.com>, <zhongjinji@honor.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Thu, 30 Oct 2025 17:22:58 +0800
Message-ID: <20251030092258.2576-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aP-Ymcsoyls04jov@slm.duckdns.org>
References: <aP-Ymcsoyls04jov@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> Hello,
> 
> On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> > This patch introduces a per-cgroup compression priority mechanism,
> > where different compression priorities map to different algorithms.
> > This allows administrators to select appropriate compression
> > algorithms on a per-cgroup basis.
> 
> I don't think it makes sense to tie this to cgroups. Is there something
> preventing this from following the process hierarchy?
> Thanks.
Hello, Tejun,

There is also a layer of page tables between the process and the page,
so making it follow the process hierarchy would be complicated.
But you make a good point; it may indeed be unnecessary to introduce
a separate per-cgroup compression priority. As Nhat suggested,
we could try reusing the per-cgroup swap priority.

> -- 
> tejun

