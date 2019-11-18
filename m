Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC30710008A
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfKRIjG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 03:39:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47080 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIjF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 03:39:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAI8cmmB033613;
        Mon, 18 Nov 2019 02:38:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574066328;
        bh=2FmC6WnguELH0WljaqAvUXHz4oovTIg5XA3M9m7laOM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JQk58HK+KG2z9Y7+qVN3JLPmEHQ+wsw40VdDVyonlPjWTyUovUDwXsKg1NKgobvMG
         bMeoY97hekPv8YSMIffnOMGmbk6NqrB+OONU9gvN1GMg5ZC4CsTUDHdz3DUrVk3pZ7
         D8vjzUdjnTP5OwUMqW61010vvke/PcVkUYYejwB8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAI8cmZ5055342
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 02:38:48 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 02:38:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 02:38:47 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAI8ciXl127055;
        Mon, 18 Nov 2019 02:38:45 -0600
Subject: Re: [PATCH block/for-next] blk-cgroup: cgroup_rstat_updated()
 shouldn't be called on cgroup1
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <kernel-team@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
 <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
 <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <6f791736-2728-be53-9544-e0a0f0d09dd0@ti.com>
Date:   Mon, 18 Nov 2019 14:09:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 15/11/19 4:01 AM, Tejun Heo wrote:
> Currently, cgroup rstat is supported only on cgroup2 hierarchy and
> rstat functions shouldn't be called on cgroup1 cgroups.  While
> converting blk-cgroup core statistics to rstat, f73316482977
> ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> accidentally ended up calling cgroup_rstat_updated() on cgroup1
> cgroups causing crashes.
> 
> Longer term, we probably should add cgroup1 support to rstat but for
> now let's mask the call directly.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  include/linux/blk-cgroup.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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

Thanks,
Faiz
