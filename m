Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD176D7B0
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHBT0j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjHBT0i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 15:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEAE119
        for <cgroups@vger.kernel.org>; Wed,  2 Aug 2023 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691004349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Prrsefdk3q3EqmcQR6Ob1G4yDp+W6OWglyjzE+QR0R8=;
        b=Xml2rYQY+/9npUwZWTghhexNNk0+7ytN1YzJzF5/EGR6AZ0JWUIXB3L0Jdm7wQgtGguRwH
        iHRGqPrh5gCAMp2fUF+E8/EAuHTrBFexdrruIaHTdmxXb0FJLkHJUhc85ioFjXv3umT/dW
        q8xlqhW4Lx9PTqnze0p9FoMdkL1pGWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-LH98YhVxPBS9sJOewe5S7g-1; Wed, 02 Aug 2023 15:25:47 -0400
X-MC-Unique: LH98YhVxPBS9sJOewe5S7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D553E858290;
        Wed,  2 Aug 2023 19:25:46 +0000 (UTC)
Received: from [10.22.18.41] (unknown [10.22.18.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7854B1415115;
        Wed,  2 Aug 2023 19:25:46 +0000 (UTC)
Message-ID: <2dffccd0-d7a3-58aa-6dc6-d44ac67f6e99@redhat.com>
Date:   Wed, 2 Aug 2023 15:25:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] cgroup/cpuset: fix kernel-doc
Content-Language: en-US
To:     Cai Xinchen <caixinchen1@huawei.com>, lizefan.x@bytedance.com,
        tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org
References: <20230802030412.173344-1-caixinchen1@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230802030412.173344-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/1/23 23:04, Cai Xinchen wrote:
> Add kernel-doc of param @rotor to fix warnings:
>
> kernel/cgroup/cpuset.c:4162: warning: Function parameter or member
> 'rotor' not described in 'cpuset_spread_node'
> kernel/cgroup/cpuset.c:3771: warning: Function parameter or member
> 'work' not described in 'cpuset_hotplug_workfn'
>
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b278b60ed788..58ec88efa4f8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3753,6 +3753,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   
>   /**
>    * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
> + * @work: unused
>    *
>    * This function is called after either CPU or memory configuration has
>    * changed and updates cpuset accordingly.  The top_cpuset is always
> @@ -4135,6 +4136,7 @@ bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>   
>   /**
>    * cpuset_spread_node() - On which node to begin search for a page
> + * @rotor: round robin rotor
>    *
>    * If a task is marked PF_SPREAD_PAGE or PF_SPREAD_SLAB (as for
>    * tasks in a cpuset with is_spread_page or is_spread_slab set),

Looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

