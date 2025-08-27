Return-Path: <cgroups+bounces-9450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DBB38B53
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 23:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CD2685F85
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AD30C62E;
	Wed, 27 Aug 2025 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0fgOo7+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6923093A8
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329924; cv=none; b=suyPLBCdHUWCcYJCZWS8KD9csB50PlsDqtqgk1XP8GZFrGjO6qSVMN7t9VOlGZMlme+XdwHRDxGIPdMSsAWr/S31u4fmuDh5UpnV6DU2wrmPpwZwUuwChKvLLxVI6K1FGzRIGhcESXtK8He3pKMBxGLdDv/XecJ1aJauNNv78OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329924; c=relaxed/simple;
	bh=5OMYFTfAZenqHJvI/KeLzgzyAGUa92DP82jO8Lk7lCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG/ShwZ366YhP+32qpqT0dYv5F5wIiHEnZZVsMXJFhGbiU2ycIILtjs8dcMAXSOkDD/AryumtvvNXDQknhAkrZ6/JakCAQwxjaFw6aZH10y+9kNq3Yo3g6SP4vUHjpmi99xaH0iW4KIDNpgZyVBXyjhSQV2sH7/JXS1BhFoWdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0fgOo7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD487C4CEEB;
	Wed, 27 Aug 2025 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756329923;
	bh=5OMYFTfAZenqHJvI/KeLzgzyAGUa92DP82jO8Lk7lCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0fgOo7+ta+dTLjSrZ6sX7jIbKdge8pTD8E5C6sujcDi9UNHrAMZXYlHTHMgcxDJt
	 uk5LDr/L4xQgimz1UQvN36+mu0aA1jKLmDPY7HRlNAADZ95Hj1FBUgwpjXGamQPfDo
	 KhhtXXBazYj7DR9iqTbL3y5Wo1KA+P6Wnz+vetjAsYFozXKdooipRpTngEh//hoCmX
	 wt/unKt9FqgqWteDJ/2t2dnfUBGbrPhBN+/YLtYJegqTUS1tk5vLmnRuYznZ+4GWQg
	 8jPyK9CFoiZ0dKQC4Hd+ay9+JLHzby8mw0bxPelLr4NQ59ybjtagIC/3LZfSkbaydl
	 R2lx5+wx1RudQ==
Date: Wed, 27 Aug 2025 11:25:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	muchun.song@linux.dev
Subject: Re: [PATCH v4] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aK93wg5kdgVuL6rc@slm.duckdns.org>
References: <20250827204557.90112-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827204557.90112-1-sunjunchao@bytedance.com>

On Thu, Aug 28, 2025 at 04:45:57AM +0800, Julian Sun wrote:
> Recently, we encountered the following hung task:
> 
> INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
> [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
> [Wed Jul 30 17:47:45 2025] Call Trace:
> [Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
> [Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
> [Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
> [Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
> [Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
> [Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
> [Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
> [Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
> [Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
> [Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
> [Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
> [Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
> [Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
> [Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30
> 
> The direct cause is that memcg spends a long time waiting for dirty page
> writeback of foreign memcgs during release.
> 
> The root causes are:
>     a. The wb may have multiple writeback tasks, containing millions
>        of dirty pages, as shown below:
> 
> >>> for work in list_for_each_entry("struct wb_writeback_work", \
> 				    wb.work_list.address_of_(), "list"):
> ...     print(work.nr_pages, work.reason, hex(work))
> ...
> 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
> 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
> 1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
> 1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
> 1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
> 2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
> 2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
> 3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
> 3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
> 3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
> 3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
> 3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
> 3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
> 3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
> 3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
> 3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
> 3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
> 3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
> 3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
> 3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
> 3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
> 3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
> 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
> 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
> 
>     b. The writeback might severely throttled by wbt, with a speed
>        possibly less than 100kb/s, leading to a very long writeback time.
> 
> >>> wb.write_bandwidth
> (unsigned long)24
> >>> wb.write_bandwidth
> (unsigned long)13
> 
> The wb_wait_for_completion() here is probably only used to prevent
> use-after-free. Therefore, we manage 'done' separately and automatically
> free it.
> 
> This allows us to remove wb_wait_for_completion() while preventing
> the use-after-free issue.
> 
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

