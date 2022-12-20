Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A865250F
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiLTQ7y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiLTQ7v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 11:59:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8005618695
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671555545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRZ5NBQkSBEMSzVXiSUDsWEBTOjISuGVrqOh0e75EmM=;
        b=gUb1ar3FA9jIQMgMFmjoB3CAfUSSsRO80YQAz8kSE0/QxXF22l8G4cCH7+e3V9zWd9zsHC
        9KOxqbaOTi7Wg0ECmL7Mf6yTX3ef7Q16Ets7EAqEHk7FjNoU2+xZkHltPHY/SrVDuBGAYx
        gmCU/fYxr4rLwbIYERL6/MCIdDCo7vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-16qy3JQhNAGn_wza0obbDw-1; Tue, 20 Dec 2022 11:59:02 -0500
X-MC-Unique: 16qy3JQhNAGn_wza0obbDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7819B88B7A7;
        Tue, 20 Dec 2022 16:59:01 +0000 (UTC)
Received: from [10.22.18.106] (unknown [10.22.18.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EE61112132C;
        Tue, 20 Dec 2022 16:59:01 +0000 (UTC)
Message-ID: <9295b73a-5a3c-b1f6-d892-0da1d356ab9f@redhat.com>
Date:   Tue, 20 Dec 2022 11:59:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global static
 variable
Content-Language: en-US
To:     Daniel Vacek <neelx@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220151415.856093-1-neelx@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221220151415.856093-1-neelx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/20/22 10:14, Daniel Vacek wrote:
> cpuset_rwsem is a static variable. It's initialized at build time and so
> there's no need for explicit runtime init leaking one percpu int.
>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a29c0b13706bb..87fe410361b3d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3281,8 +3281,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>   
>   int __init cpuset_init(void)
>   {
> -	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
> -
>   	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
>   	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
>   	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));

It will be clearer if you mention that DEFINE_STATIC_PERCPU_RWSEM() is 
used to set up cpuset_rwsem at build time. Other than that, the patch 
looks good to me.

Cheers,
Longman

