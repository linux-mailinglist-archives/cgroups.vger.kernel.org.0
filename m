Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683DC492F2F
	for <lists+cgroups@lfdr.de>; Tue, 18 Jan 2022 21:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiARUVx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jan 2022 15:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233125AbiARUVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jan 2022 15:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642537311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8gyhqFvKMeBPNaQH3F4JAzHy306fMW6cgpFncW//cw=;
        b=QV53UVZ/BYqP0ijap8Pv1d1/rtme04KvBjm9FN4cjeMpcMXivtSPd2p0P+EpmpD7muhDC2
        qfw2w0/daZe3WYQyna3k+Z6gZofX7xK6u+yGRej+zRHVjV7ySHqrDKk3pzVww7eOWBO4PT
        1erNdqDiBUfLYXhPfq5UNs0FNGguifo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-l7AtTti0MtW_Yr3i9Q5H5g-1; Tue, 18 Jan 2022 15:21:48 -0500
X-MC-Unique: l7AtTti0MtW_Yr3i9Q5H5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36BB784B9A4;
        Tue, 18 Jan 2022 20:21:46 +0000 (UTC)
Received: from [10.22.35.127] (unknown [10.22.35.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD365DB83;
        Tue, 18 Jan 2022 20:21:44 +0000 (UTC)
Message-ID: <7610638e-9954-a6b2-63b2-e1df334a288f@redhat.com>
Date:   Tue, 18 Jan 2022 15:21:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] cpuset: Fix the bug that subpart_cpus updated wrongly in
 update_cpumask()
Content-Language: en-US
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/18/22 05:05, Tianchen Ding wrote:
> subparts_cpus should be limited as a subset of cpus_allowed, but it is
> updated wrongly by using cpumask_andnot(). Use cpumask_and() instead to
> fix it.
>
> Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bb3531e7fda7..804ff5738c5f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1635,8 +1635,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 * Make sure that subparts_cpus is a subset of cpus_allowed.
>   	 */
>   	if (cs->nr_subparts_cpus) {
> -		cpumask_andnot(cs->subparts_cpus, cs->subparts_cpus,
> -			       cs->cpus_allowed);
> +		cpumask_and(cs->subparts_cpus, cs->subparts_cpus, cs->cpus_allowed);
>   		cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
>   	}
>   	spin_unlock_irq(&callback_lock);

Thanks for the fix.

Reviewed-by: Waiman Long <longman@redhat.com>

