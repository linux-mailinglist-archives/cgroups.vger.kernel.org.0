Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8461744BCB
	for <lists+cgroups@lfdr.de>; Sun,  2 Jul 2023 01:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGAXju (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Jul 2023 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGAXjt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Jul 2023 19:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A31728
        for <cgroups@vger.kernel.org>; Sat,  1 Jul 2023 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688254742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBpTTsf34Ze+Ldbjs7Ryu+fiBB4ZKbtnHCMlWFpbQvc=;
        b=Jvu3NWrLo2qApa9LYbXd0YJ26vOHSpyg/nxzUOsPtExjMhLFErU/yCzOln8tPCKRNfJSBv
        HpFXHi6CaMqthxuJYL12di9ZspouS6A6PrQb/eekcaJxl5kJTN8Omr6DwQxY3vIen8MbaK
        KfV6lItX3nv9WnVKf4Dpa47h7ei6B2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-A6JHkaInPa6ji1KJgx27-g-1; Sat, 01 Jul 2023 19:38:58 -0400
X-MC-Unique: A6JHkaInPa6ji1KJgx27-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70ED886F122;
        Sat,  1 Jul 2023 23:38:58 +0000 (UTC)
Received: from [10.22.32.52] (unknown [10.22.32.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D37B84067A00;
        Sat,  1 Jul 2023 23:38:57 +0000 (UTC)
Message-ID: <9244d968-b25a-066f-2ff3-1281bf03983e@redhat.com>
Date:   Sat, 1 Jul 2023 19:38:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230701065049.1758266-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On 7/1/23 02:50, Miaohe Lin wrote:
> update_parent_subparts_cpumask() is called outside RCU read-side critical
> section without holding extra css refcnt of cp. In theroy, cp could be
> freed at any time. Holding extra css refcnt to ensure cp is valid while
> updating parent subparts cpumask.
>
> Fixes: d7c8142d5a55 ("cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58e6f18f01c1..632a9986d5de 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		cpuset_for_each_child(cp, css, parent)
>   			if (is_partition_valid(cp) &&
>   			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
> +				if (!css_tryget_online(&cp->css))
> +					continue;
>   				rcu_read_unlock();
>   				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
>   				rcu_read_lock();
> +				css_put(&cp->css);
>   			}
>   		rcu_read_unlock();
>   		retval = 0;

Thanks for finding that. It looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>

