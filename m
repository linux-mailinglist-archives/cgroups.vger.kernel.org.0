Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21C7B0505
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjI0NOj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjI0NOh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 09:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E968F5
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695820434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgZz7s6OjsVA3iD+wDSANk03wfe8Z4jKIykypmODx90=;
        b=WlFWCb11WhkCyXbtAbmM7wn8RaI15bivNJl0HBrZd3KdRF8AWGU6mrx5WApwOu4ND4UDJl
        zhwLfJzgLpvHkJrC1JynFaD3GCAfcppKKxh7dj2F61BgpHRVqxdxp+HIi1UnfbIvUxcTBQ
        cQbG1/rEGup3vhNWXup5+7d+yfMq33o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-EzV1qdJ5MUidfBf-x9yyig-1; Wed, 27 Sep 2023 09:13:51 -0400
X-MC-Unique: EzV1qdJ5MUidfBf-x9yyig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D830811E88;
        Wed, 27 Sep 2023 13:13:50 +0000 (UTC)
Received: from [10.22.33.167] (unknown [10.22.33.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 739A9100651E;
        Wed, 27 Sep 2023 13:13:49 +0000 (UTC)
Message-ID: <01f5d9c9-31c1-1b55-f4b1-8153104faa76@redhat.com>
Date:   Wed, 27 Sep 2023 09:13:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH next] cgroup/cpuset: Cleanup signedness issue in
 cpu_exclusive_check()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kamalesh.babulal@oracle.com,
        kernel test robot <lkp@intel.com>
References: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/27/23 02:58, Harshit Mogalapalli wrote:
> Smatch complains about returning negative error codes from a type
> bool function.
>
> kernel/cgroup/cpuset.c:705 cpu_exclusive_check() warn:
> 	signedness bug returning '(-22)'
>
> The code works correctly, but it is confusing.  The current behavior is
> that cpu_exclusive_check() returns true if it's *NOT* exclusive.  Rename
> it to cpusets_are_exclusive() and reverse the returns so it returns true
> if it is exclusive and false if it's not.  Update both callers as well.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202309201706.2LhKdM6o-lkp@intel.com/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on sattic analysis, only compile tested
> ---
>   kernel/cgroup/cpuset.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 15f399153a2e..afefddd33c3e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -719,18 +719,18 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
>   }
>   
>   /*
> - * cpu_exclusive_check() - check if two cpusets are exclusive
> + * cpusets_are_exclusive() - check if two cpusets are exclusive
>    *
> - * Return 0 if exclusive, -EINVAL if not
> + * Return true if exclusive, false if not
>    */
> -static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
> +static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   {
>   	struct cpumask *xcpus1 = fetch_xcpus(cs1);
>   	struct cpumask *xcpus2 = fetch_xcpus(cs2);
>   
>   	if (cpumask_intersects(xcpus1, xcpus2))
> -		return -EINVAL;
> -	return 0;
> +		return false;
> +	return true;
>   }
>   
>   /*
> @@ -833,7 +833,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>   	cpuset_for_each_child(c, css, par) {
>   		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
>   		    c != cur) {
> -			if (cpu_exclusive_check(trial, c))
> +			if (!cpusets_are_exclusive(trial, c))
>   				goto out;
>   		}
>   		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
> @@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			cpuset_for_each_child(child, css, parent) {
>   				if (child == cs)
>   					continue;
> -				if (cpu_exclusive_check(cs, child)) {
> +				if (!cpusets_are_exclusive(cs, child)) {
>   					exclusive = false;
>   					break;
>   				}

Thanks for fixing that.

Acked-by: Waiman Long <longman@redhat.com>

