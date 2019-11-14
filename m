Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36595FC630
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNMRx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 07:17:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfKNMRw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Nov 2019 07:17:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D33131B;
        Thu, 14 Nov 2019 04:17:52 -0800 (PST)
Received: from [10.1.198.56] (e108754-lin.cambridge.arm.com [10.1.198.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB75F3F6C4;
        Thu, 14 Nov 2019 04:17:50 -0800 (PST)
Subject: Re: [PATCH 5/6] blk-cgroup: reimplement basic IO stats using cgroup
 rstat
To:     Tejun Heo <tj@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, kernel-team@fb.com,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
 <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <3c76ab1f-6836-fb60-11ed-25d6db9a2a57@arm.com>
Date:   Thu, 14 Nov 2019 12:17:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On 13/11/2019 16:35, Tejun Heo wrote:
> Hello,
> 
> Can you please see whether the following patch fixes the issue?
> 

This patch does fix the issue for me.


Thanks,
Ionela.

> Thanks.
> 
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 48a66738143d..19394c77ed99 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -626,7 +626,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>  		bis->cur.ios[rwd]++;
>  
>  		u64_stats_update_end(&bis->sync);
> -		cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
> +		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> +			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
>  		put_cpu();
>  	}
>  
> 
