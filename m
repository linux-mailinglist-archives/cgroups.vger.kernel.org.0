Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72751727FBF
	for <lists+cgroups@lfdr.de>; Thu,  8 Jun 2023 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjFHMXD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjFHMXC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 08:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A7E62
        for <cgroups@vger.kernel.org>; Thu,  8 Jun 2023 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686226932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6zJ80tFIxXTVHRh/16qEQREsJv1j4C9vyoJ2KH4/8c=;
        b=AW9y+DCNh3q94I6r9c5PCL5+kN95gM/aV5bzFbXxVOo/z2qQEA3mvXLUhXGmh8db0ftOD0
        rUR+9xrkvrts/cnHbtmgZuJvrCvHGFMulV6ss+mGf7RHuUU4NK2itzP10AwMK8V6g80Rg2
        hq0expNu4UwczQykeKbH/v8c1fxRXi8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-GWZMmb5uNSyfOTz4Eqrylw-1; Thu, 08 Jun 2023 08:22:07 -0400
X-MC-Unique: GWZMmb5uNSyfOTz4Eqrylw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03CDA3803512;
        Thu,  8 Jun 2023 12:22:07 +0000 (UTC)
Received: from [10.22.8.251] (unknown [10.22.8.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 547E0C1603B;
        Thu,  8 Jun 2023 12:22:06 +0000 (UTC)
Message-ID: <7ff8c948-c5e2-ac5b-6633-8583b8cb75fe@redhat.com>
Date:   Thu, 8 Jun 2023 08:22:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: Fix comment in cpuset_hotplug_workfn
Content-Language: en-US
To:     suhua <suhua.tanke@gmail.com>, lizefan.x@bytedance.com,
        tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230608085439.27501-1-suhua.tanke@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230608085439.27501-1-suhua.tanke@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/8/23 04:54, suhua wrote:
> "synchronize cpus_allowed to cpu_active_mask"
> -> "synchronize cpu_active_mask to cpus_allowed"
>
> Signed-off-by: suhua <suhua.tanke@gmail.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b0aee733b92b..4810d29e2d63 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3739,7 +3739,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>   	if (!cpus_updated && top_cpuset.nr_subparts_cpus)
>   		cpus_updated = true;
>   
> -	/* synchronize cpus_allowed to cpu_active_mask */
> +	/* synchronize cpu_active_mask to cpus_allowed */
>   	if (cpus_updated) {
>   		spin_lock_irq(&callback_lock);
>   		if (!on_dfl)

The comment is a bit outdated. The synchronization is only meant for 
cgroup v1, but it is correct in this regard. We are matching 
cpus_allowed of top_cpuset to cpu_active_mask, not the other way around.

Cheers,
Longman

