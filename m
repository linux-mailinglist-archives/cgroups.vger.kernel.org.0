Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246D4747BB6
	for <lists+cgroups@lfdr.de>; Wed,  5 Jul 2023 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGEDK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jul 2023 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGEDK6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jul 2023 23:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98F10FE
        for <cgroups@vger.kernel.org>; Tue,  4 Jul 2023 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688526612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdjVolfunLG09gIQv/MDbIflC0qYXjY8Y9Vwr+tdYRk=;
        b=S3i1ZP4K6E2txNxQruf0yb2TYd5El7xkzlBBLTJ1NWrivPeu6/vX5JDqTTBXvRtkhDK7/W
        cxrPshPMf5LrVPOxQeaxBs3YgUdqL2BqDyIo/OHxaWadsVBABqvOgfLxec4JpB+0pZjlif
        6Tii5YlzXw0mMakFou1iV/EffVmVglU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-Ss35LKCFNOWqx6SuxYUh_A-1; Tue, 04 Jul 2023 23:10:03 -0400
X-MC-Unique: Ss35LKCFNOWqx6SuxYUh_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B865B3810B0E;
        Wed,  5 Jul 2023 03:10:02 +0000 (UTC)
Received: from [10.22.16.39] (unknown [10.22.16.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18795200B415;
        Wed,  5 Jul 2023 03:10:01 +0000 (UTC)
Message-ID: <974a48a8-7402-6303-10e8-9d5fe475bb42@redhat.com>
Date:   Tue, 4 Jul 2023 23:10:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: avoid unneeded cpuset_mutex re-lock
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230704120352.1226787-1-linmiaohe@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230704120352.1226787-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On 7/4/23 08:03, Miaohe Lin wrote:
> cpuset_mutex unlock and lock pair is only needed when transferring tasks
> out of empty cpuset. Avoid unneeded cpuset_mutex re-lock when !is_empty
> to save cpu cycles.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 601c40da8e03..e136269c152c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3521,17 +3521,16 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>   	is_empty = cpumask_empty(cs->cpus_allowed) ||
>   		   nodes_empty(cs->mems_allowed);
>   
> -	mutex_unlock(&cpuset_mutex);
> -
>   	/*
>   	 * Move tasks to the nearest ancestor with execution resources,
>   	 * This is full cgroup operation which will also call back into
>   	 * cpuset. Should be done outside any lock.
>   	 */
> -	if (is_empty)
> +	if (is_empty) {
> +		mutex_unlock(&cpuset_mutex);
>   		remove_tasks_in_empty_cpuset(cs);
> -
> -	mutex_lock(&cpuset_mutex);
> +		mutex_lock(&cpuset_mutex);
> +	}
>   }
>   
>   static void
Reviewed-by: Waiman Long <longman@redhat.com>

