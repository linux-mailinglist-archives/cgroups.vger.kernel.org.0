Return-Path: <cgroups+bounces-5718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEEE9DF4E0
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 07:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA1162DEB
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CF3D3B8;
	Sun,  1 Dec 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rIh2oIaQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BFE552;
	Sun,  1 Dec 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733035938; cv=none; b=mws3KQdS4HVgo2lKYy8/0PqpX1UXRGZ814PyElvRqF9Q5zEchhgS/VaFuV087WN8tWiGIVBkz9mVzbXUCKsgkclHXdWGPdbM0FAn/izLeqQqyk/yeQiS7QCWGLipqFDa7WLFecnQUv+TWrdV0SLryNQrWB9Grkp2c8pi088mNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733035938; c=relaxed/simple;
	bh=LlAIxB8N/0m2snCylgWlUAAyLHpPp5k+nBPFKFA41Ic=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WKmyUzc4FF3D0FdoofjAJaIGMapRsi3VWT5TZHmU+mbsIk+R2qV4/3kqynObLMK610YZKXJtepqkEtEmszANF06GPFevkHrVd9XjKJ9Nbcrp/1xnXnUqG7TwKcWwC9/I7CfJdp1MjxO9E0Si2RQml3JFOIMUxT8qo2gCTSMwke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rIh2oIaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0AFC4CECF;
	Sun,  1 Dec 2024 06:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733035938;
	bh=LlAIxB8N/0m2snCylgWlUAAyLHpPp5k+nBPFKFA41Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rIh2oIaQhCt58+TnxD62w8JKisKb9VciI8ivfsm7Sxm4DZpIFD5vY5ITRmpO89vQ9
	 KZLjISKRT7drej/nBlQj+2ESs/ndpOFv0ZtyQklHxwXxv5zyvwjasB78cBM2uOIu02
	 jZPIuDNXi3imwpVWMfIVn2gBgDVsTqqk1H8TN8OU=
Date: Sat, 30 Nov 2024 22:52:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
 <corbet@lwn.net>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak
 to v2
Message-Id: <20241130225217.6949f9f87d3f7fbbc1748948@linux-foundation.org>
In-Reply-To: <20240702125728.2743143-1-xiujianfeng@huawei.com>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Introduce peak and rsvd.peak to v2 to show the historical maximum
> usage of resources, as in some scenarios it is necessary to configure
> the value of max/rsvd.max based on the peak usage of resources.
> 

The review for this patch was not compelling, so I'll drop this copy
for now.  If you continue to believe that we should add this to Linux,
please resend, perhaps with additional changelog details to help
convince others.


From: Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: mm/hugetlb_cgroup: introduce peak and rsvd.peak to v2
Date: Tue, 2 Jul 2024 12:57:28 +0000

Introduce peak and rsvd.peak to v2 to show the historical maximum usage of
resources, as in some scenarios it is necessary to configure the value of
max/rsvd.max based on the peak usage of resources.

Since HugeTLB doesn't support page reclaim, enforcing the limit at page
fault time implies that, the application will get SIGBUS signal if it
tries to fault in HugeTLB pages beyond its limit.  Therefore the
application needs to know exactly how many HugeTLB pages it uses before
hand, and the sysadmin needs to make sure that there are enough available
on the machine for all the users to avoid processes getting SIGBUS.

When running some open-source software, it may not be possible to know the
exact amount of hugetlb it consumes, so cannot correctly configure the max
value.  If there is a peak metric, we can run the open-source software
first and then configure the max based on the peak value.  In cgroup v1,
the hugetlb controller provides the max_usage_in_bytes and
rsvd.max_usage_in_bytes interface to display the historical maximum usage,
so introduce peak and rsvd.peak to v2 to address this issue.

Link: https://lkml.kernel.org/r/20240702125728.2743143-1-xiujianfeng@huawei.com
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/admin-guide/cgroup-v2.rst |    8 ++++++++
 mm/hugetlb_cgroup.c                     |   19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

--- a/Documentation/admin-guide/cgroup-v2.rst~mm-hugetlb_cgroup-introduce-peak-and-rsvdpeak-to-v2
+++ a/Documentation/admin-guide/cgroup-v2.rst
@@ -2659,6 +2659,14 @@ HugeTLB Interface Files
         hugetlb pages of <hugepagesize> in this cgroup.  Only active in
         use hugetlb pages are included.  The per-node values are in bytes.
 
+  hugetlb.<hugepagesize>.peak
+	Show historical maximum usage for "hugepagesize" hugetlb.  It exists
+        for all the cgroup except root.
+
+  hugetlb.<hugepagesize>.rsvd.peak
+	Show historical maximum usage for "hugepagesize" hugetlb reservations.
+        It exists for all the cgroup except root.
+
 Misc
 ----
 
--- a/mm/hugetlb_cgroup.c~mm-hugetlb_cgroup-introduce-peak-and-rsvdpeak-to-v2
+++ a/mm/hugetlb_cgroup.c
@@ -583,6 +583,13 @@ static int hugetlb_cgroup_read_u64_max(s
 		else
 			seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
+	case RES_RSVD_MAX_USAGE:
+		counter = &h_cg->rsvd_hugepage[idx];
+		fallthrough;
+	case RES_MAX_USAGE:
+		val = (u64)counter->watermark;
+		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
+		break;
 	default:
 		BUG();
 	}
@@ -739,6 +746,18 @@ static struct cftype hugetlb_dfl_tmpl[]
 		.seq_show = hugetlb_cgroup_read_u64_max,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "peak",
+		.private = RES_MAX_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "rsvd.peak",
+		.private = RES_RSVD_MAX_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "events",
 		.seq_show = hugetlb_events_show,
_


