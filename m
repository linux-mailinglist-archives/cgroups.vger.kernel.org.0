Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6578E747BB9
	for <lists+cgroups@lfdr.de>; Wed,  5 Jul 2023 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGEDOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jul 2023 23:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjGEDOy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jul 2023 23:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80510D5
        for <cgroups@vger.kernel.org>; Tue,  4 Jul 2023 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688526847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrkEIq6dhRR9ar//G8iVT0D1nMSlQSq+xiDuYGm9BDg=;
        b=NX0ENdAXG2I5kH3R72J9gVnjgGNp2O1xGmbust3klMAh6st8PpkPUohq/TuBIsmDvDLGso
        HPfdet+KzngdKins42sDfQXmNF5Oodqs23khyL60dgHjS1IkckNPKU+R7F3koVcvH6esER
        tF9PQWR5Iu09E6B1ZkGx7tzcaetY2rk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-67tYLv16ODq-ae5T52CHXA-1; Tue, 04 Jul 2023 23:14:02 -0400
X-MC-Unique: 67tYLv16ODq-ae5T52CHXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95B3D3806060;
        Wed,  5 Jul 2023 03:14:01 +0000 (UTC)
Received: from [10.22.16.39] (unknown [10.22.16.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51F374087C6A;
        Wed,  5 Jul 2023 03:14:01 +0000 (UTC)
Message-ID: <bc8202fd-a31c-2b08-bd01-8b5868aab230@redhat.com>
Date:   Tue, 4 Jul 2023 23:14:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: simplify the percpu kthreads check in
 update_tasks_cpumask()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230704113049.1019118-1-linmiaohe@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230704113049.1019118-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/4/23 07:30, Miaohe Lin wrote:
> kthread_is_per_cpu() can be called directly without checking whether
> PF_KTHREAD is set in task->flags. So remove PF_KTHREAD check to make
> code more concise.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58e6f18f01c1..601c40da8e03 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1230,7 +1230,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>   			/*
>   			 * Percpu kthreads in top_cpuset are ignored
>   			 */
> -			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
> +			if (kthread_is_per_cpu(task))
>   				continue;
>   			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
>   		} else {

The initial intention was to ignore only percpu kthreads. The current 
code likely ignore all the kthreads. Removing the PF_KTHREAD flag, 
however, may introduce unexpected regression at this point. I would like 
to hold off for now until more investigation are done.

Thanks,
Longman

