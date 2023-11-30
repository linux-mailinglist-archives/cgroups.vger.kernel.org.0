Return-Path: <cgroups+bounces-746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE27FFD92
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 22:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20D21C209C9
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43559151;
	Thu, 30 Nov 2023 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rq46MTa6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956A5FF0A
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 21:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE82EC433C7;
	Thu, 30 Nov 2023 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701380021;
	bh=zoLX8EMoe/pefdEhZ5q+qBiLo3+H4+isUNHHBqOWkyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rq46MTa6E0BZ7P6nDMGVHEIbqrT6a/+4vxnV3EWD+gk1kkiul2VBJcj2srNAhI2cM
	 BW10h4l1E1kHdzFRlLa2Ltn3kO9sPFHN5kHpR5qkNCox7dCislZrvCIUfaSMwsErPm
	 MpPwSzA5zgropOxblSm5gTHS6+dUOpzIZqDtgWXI=
Date: Thu, 30 Nov 2023 13:33:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, Huan Yang
 <link@vivo.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, David
 Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Huang
 Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, Hugh Dickins
 <hughd@google.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Message-Id: <20231130133340.36140526608289898acb3ac5@linux-foundation.org>
In-Reply-To: <20231130153658.527556-2-schatzberg.dan@gmail.com>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
	<20231130153658.527556-2-schatzberg.dan@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 07:36:54 -0800 Dan Schatzberg <schatzberg.dan@gmail.com> wrote:

> Allow proactive reclaimers to submit an additional swappiness=<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
> 
> For example:
> 
> echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  include/linux/swap.h |  3 ++-
>  mm/memcontrol.c      | 55 +++++++++++++++++++++++++++++++++++---------
>  mm/vmscan.c          | 13 +++++++++--

Documentation/admin-guide/cgroup-v2.rst is feeling unloved!

Please check whether this interface change can lead to
non-backward-compatible userspace.  If someone's script does the above
echo command, will it break on older kernels?  If so, does it matter?

