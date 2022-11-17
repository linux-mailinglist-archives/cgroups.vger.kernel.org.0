Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7662DC74
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiKQNQn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiKQNQl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 08:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB46D4AB
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668690936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+KNz2jWZW3hJMabpbKj/Uks1DudAWiqFYQrQhlfd2E=;
        b=g/Nme7GWJNmvUeNDhym2xRrWVB0CVUchBNqDp7eBUoiib7mgGilbDO3xuyT2zl98vWr++U
        UeH8jbjkt3YmxjG3Vd+nFLxUxhQKngRTkyDRlZvkPj9yiIi1zlsEbYW0hgkU114XyRvep8
        CqDWAiidp2opLdk+Bu9ckWIF/TGo4Tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-N4fdgOpWPwev7lsUORQnig-1; Thu, 17 Nov 2022 08:15:32 -0500
X-MC-Unique: N4fdgOpWPwev7lsUORQnig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEC75101A528;
        Thu, 17 Nov 2022 13:15:31 +0000 (UTC)
Received: from [10.22.16.250] (unknown [10.22.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AC3C40C83AA;
        Thu, 17 Nov 2022 13:15:31 +0000 (UTC)
Message-ID: <6f619bb3-e5ff-73c3-6dcb-afa64aabc729@redhat.com>
Date:   Thu, 17 Nov 2022 08:15:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] cgroup/cpuset: Improve cpuset_css_alloc() description
Content-Language: en-US
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
References: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/22 02:15, Kamalesh Babulal wrote:
> Change the function argument in the description of cpuset_css_alloc()
> from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
> argument type was introduced by commit eb95419b023a ("cgroup: pass
> around cgroup_subsys_state instead of cgroup in subsystem methods").
> Also, add more information to its description.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
> v2: Reworded the description to be more accurate, as suggested
>      by Waiman Long
>
>   kernel/cgroup/cpuset.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..ce789e1b2a2f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3046,11 +3046,15 @@ static struct cftype dfl_files[] = {
>   };
>   
>   
> -/*
> - *	cpuset_css_alloc - allocate a cpuset css
> - *	cgrp:	control group that the new cpuset will be part of
> +/**
> + * cpuset_css_alloc - Allocate a cpuset css
> + * @parent_css: Parent css of the control group that the new cpuset will be
> + *              part of
> + * Return: cpuset css on success, -ENOMEM on failure.
> + *
> + * Allocate and initialize a new cpuset css, for non-NULL @parent_css, return
> + * top cpuset css otherwise.
>    */
> -
>   static struct cgroup_subsys_state *
>   cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   {
Acked-by: Waiman Long <longman@redhat.com>

