Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C668A808
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjBDDyn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 22:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjBDDyk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 22:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53918A7EB
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 19:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675482834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buEB2MhYiHkTXl+iJ+h97A75R8p42T/127lL4Ay8x+c=;
        b=eO79/BEPnqvzBaGGR6bNTn06GIzHyL7XAFjfiw2zxPZDbNH5eXNrKZfXAM4DsTlAVpkf/y
        qhLl/p0s/ey1dZmbw1VulQsNhZFEN8RUy+sNxtfdGl2dWyQh+SZ9tTYxBTm50JU6Yzpigj
        CCnWDtzs4ysRVvAnYLK82y2awDOeJA0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-nr6ADI9gO0uj9McKK4iG3g-1; Fri, 03 Feb 2023 22:53:48 -0500
X-MC-Unique: nr6ADI9gO0uj9McKK4iG3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAA54800050;
        Sat,  4 Feb 2023 03:53:47 +0000 (UTC)
Received: from [10.22.8.92] (unknown [10.22.8.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67A8C18EC6;
        Sat,  4 Feb 2023 03:53:46 +0000 (UTC)
Message-ID: <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
Date:   Fri, 3 Feb 2023 22:53:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-3-frederic@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230203232409.163847-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/3/23 18:24, Frederic Weisbecker wrote:
> Provide this new API to check if a CPU has been isolated either through
> isolcpus= or nohz_full= kernel parameter.
>
> It aims at avoiding kernel load deemed to be safely spared on CPUs
> running sensitive workload that can't bear any disturbance, such as
> pcp cache draining.
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index b645cc81fe01..088672f08469 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -53,4 +53,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   	return true;
>   }
>   
> +static inline bool cpu_is_isolated(int cpu)
> +{
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> +		 !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +}
> +
>   #endif /* _LINUX_SCHED_ISOLATION_H */

CPUs in an isolated cpuset partition is similar to HK_TYPE_DOMAIN CPUs 
as load balancing is disabled. I can add an API to access the cpumask 
and add to this API. However, that list is dynamic as it can be changed 
at run time. Will that be a problem? Or should that be used separately?

Cheers,
Longman

