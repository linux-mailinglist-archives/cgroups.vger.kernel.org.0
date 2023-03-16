Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F56BC3B2
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCPCUF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 22:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCPCUE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 22:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D812BEA
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 19:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678933156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6EX5i+Qe8tR7m3emFCoOQSet9tLg5nf9Z6njJr0SW8=;
        b=VHHIX4M4ie28nnJ+7JrDUlhvbMBhHts+bM/szhKL3AqWGAGV+zXMnOBVoLsTJTKRrrQ82K
        FrbEoYd9Hz3UBRcBVmXPOuTLJxLq2DKaBhvN2GJEZn8XLmdCe5Zn2Phg/vVqqgwCM41KCq
        mpENXwHAUOnViBqgXUdUo1z4i8jnOrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-vs5EAvEfNtyU1kYM7NFEMQ-1; Wed, 15 Mar 2023 22:19:11 -0400
X-MC-Unique: vs5EAvEfNtyU1kYM7NFEMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19FC685CE66;
        Thu, 16 Mar 2023 02:19:11 +0000 (UTC)
Received: from [10.22.34.146] (unknown [10.22.34.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4E882166B29;
        Thu, 16 Mar 2023 02:19:10 +0000 (UTC)
Message-ID: <bfbdef64-1b8c-4168-2576-f6d4a112686b@redhat.com>
Date:   Wed, 15 Mar 2023 22:19:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup: fix display of forceidle time at root
Content-Language: en-US
To:     Josh Don <joshdon@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315214029.899573-1-joshdon@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230315214029.899573-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/15/23 17:40, Josh Don wrote:
> We need to reset forceidle_sum to 0 when reading from root, since the
> bstat we accumulate into is stack allocated.
>
> To make this more robust, just replace the existing cputime reset with a
> memset of the overall bstat.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>   kernel/cgroup/rstat.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 831f1f472bb8..0a2b4967e333 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -457,9 +457,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
>   	struct task_cputime *cputime = &bstat->cputime;
>   	int i;
>   
> -	cputime->stime = 0;
> -	cputime->utime = 0;
> -	cputime->sum_exec_runtime = 0;
> +	memset(bstat, 0, sizeof(*bstat));
>   	for_each_possible_cpu(i) {
>   		struct kernel_cpustat kcpustat;
>   		u64 *cpustat = kcpustat.cpustat;

How about adding the following fixes tag?

Fixes: 1fcf54deb767 ("sched/core: add forced idle accounting for cgroups")

Cheers,
Longman

