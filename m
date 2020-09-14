Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258B4268365
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgINEPd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 00:15:33 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50838 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbgINEPc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 00:15:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U8ps8Kn_1600056928;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U8ps8Kn_1600056928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Sep 2020 12:15:28 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] mm: memcg: yield cpu when we fail to charge pages
To:     Julius Hemanth Pitti <jpitti@cisco.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
References: <20200908185051.62420-1-jpitti@cisco.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <c21b1788-6bf0-b675-7066-396f21da2c76@linux.alibaba.com>
Date:   Mon, 14 Sep 2020 12:15:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908185051.62420-1-jpitti@cisco.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/9/9 AM2:50, Julius Hemanth Pitti wrote:
> For non root CG, in try_charge(), we keep trying
> to charge until we succeed. On non-preemptive
> kernel, when we are OOM, this results in holding
> CPU forever.
> 
> On SMP systems, this doesn't create a big problem
> because oom_reaper get a change to kill victim
> and make some free pages. However on a single-core
> CPU (or cases where oom_reaper pinned to same CPU
> where try_charge is executing), oom_reaper shall
> never get scheduled and we stay in try_charge forever.
> 
> Steps to repo this on non-smp:
> 1. mount -t tmpfs none /sys/fs/cgroup
> 2. mkdir /sys/fs/cgroup/memory
> 3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
> 4. mkdir /sys/fs/cgroup/memory/0
> 5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
> 6. echo $$ > /sys/fs/cgroup/memory/0/tasks
> 7. stress -m 5 --vm-bytes 10M --vm-hang 0
> 
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0d6f3ea86738..4620d70267cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2652,6 +2652,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (fatal_signal_pending(current))
>  		goto force;
>  
> +	cond_resched();
> +
>  	/*
>  	 * keep retrying as long as the memcg oom killer is able to make
>  	 * a forward progress or bypass the charge if the oom killer
> 

This should be fixed by:
https://lkml.org/lkml/2020/8/26/1440

Thanks,
Xunlei
