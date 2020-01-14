Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0713AA4F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgANNFq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 08:05:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbgANNFq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Jan 2020 08:05:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16B3622E53E8E50BEE1A;
        Tue, 14 Jan 2020 21:05:43 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 21:04:45 +0800
Subject: Re: [PATCH] cgroup: remove for_each_e_css
To:     Alex Shi <alex.shi@linux.alibaba.com>
References: <1579003772-46038-1-git-send-email-alex.shi@linux.alibaba.com>
CC:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <285c371f-da93-1bf1-4ace-5a74bb08ca5b@hisilicon.com>
Date:   Tue, 14 Jan 2020 21:04:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1579003772-46038-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

https://spinics.net/lists/cgroups/msg23131.html

Thanks,

On 2020/1/14 20:09, Alex Shi wrote:
> After commit 37ff9f8f4742 ("cgroup: make cgroup[_taskset]_migrate()
> take cgroup_r', No one use this macro.
> So it'e better to remove.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/cgroup/cgroup.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 735af8f15f95..7d916ad33e59 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -663,21 +663,6 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
>  		else
>  
>  /**
> - * for_each_e_css - iterate all effective css's of a cgroup
> - * @css: the iteration cursor
> - * @ssid: the index of the subsystem, CGROUP_SUBSYS_COUNT after reaching the end
> - * @cgrp: the target cgroup to iterate css's of
> - *
> - * Should be called under cgroup_[tree_]mutex.
> - */
> -#define for_each_e_css(css, ssid, cgrp)					    \
> -	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	    \
> -		if (!((css) = cgroup_e_css_by_mask(cgrp,		    \
> -						   cgroup_subsys[(ssid)]))) \
> -			;						    \
> -		else
> -
> -/**
>   * do_each_subsys_mask - filter for_each_subsys with a bitmask
>   * @ss: the iteration cursor
>   * @ssid: the index of @ss, CGROUP_SUBSYS_COUNT after reaching the end
> 

