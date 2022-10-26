Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936DB60E375
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiJZOgo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiJZOgl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 10:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005D4BA76
        for <cgroups@vger.kernel.org>; Wed, 26 Oct 2022 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666794999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RuQ473Ae4BWJHrbZgeWqzD+yGxNzK8Ar53dsUNjWpn4=;
        b=aKs9H8iLObVx3yCLgeQm1UUUgjNA7T8XFainsf0tDzbW7tj88UXzcNvbmW/48j+0QAmVnx
        xZnngoMc6VbiqImEcN/S+2IdOdlD5+tOQL+1UsdVnj4uLzvN750Arqkkqg1y+CpnpCqOkk
        epOE0pUzhLtao5wlyZCcw6+utkTZkNE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-lH-Nv13GPUiXSAnlzXpOYA-1; Wed, 26 Oct 2022 10:36:34 -0400
X-MC-Unique: lH-Nv13GPUiXSAnlzXpOYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B39F43817A68;
        Wed, 26 Oct 2022 14:36:33 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AC6C2024CB7;
        Wed, 26 Oct 2022 14:36:33 +0000 (UTC)
Message-ID: <da533477-da08-88cb-1e76-46364f1a6151@redhat.com>
Date:   Wed, 26 Oct 2022 10:36:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        tim.c.chen@intel.com, fengwei.yin@intel.com
References: <20221026074343.6517-1-feng.tang@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221026074343.6517-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/22 03:43, Feng Tang wrote:
> In page reclaim path, memory could be demoted from faster memory tier
> to slower memory tier. Currently, there is no check about cpuset's
> memory policy, that even if the target demotion node is not allowd
> by cpuset, the demotion will still happen, which breaks the cpuset
> semantics.
>
> So add cpuset policy check in the demotion path and skip demotion
> if the demotion targets are not allowed by cpuset.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Hi reviewers,
>
> For easy bisectable, I combined the cpuset change and mm change
> in one patch, if you prefer to separate them, I can turn it into
> 2 patches.
>
> Thanks,
> Feng
>
>   include/linux/cpuset.h |  6 ++++++
>   kernel/cgroup/cpuset.c | 29 +++++++++++++++++++++++++++++
>   mm/vmscan.c            | 35 ++++++++++++++++++++++++++++++++---
>   3 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..6fcce2bd2631 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>   
> +extern void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask);
>   #else /* !CONFIG_CPUSETS */
>   
>   static inline bool cpusets_enabled(void) { return false; }
> @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>   	return false;
>   }
>   
> +static inline void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask)
> +{
> +}
>   #endif /* !CONFIG_CPUSETS */
>   
>   #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3ea2e836e93e..cbb118c0502f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3750,6 +3750,35 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>   	return mask;
>   }
>   
> +/*
> + * Retrieve the allowed memory nodemask for a cgroup.
> + *
> + * Set *nmask to cpuset's effective allowed nodemask for cgroup v2,
> + * and NODE_MASK_ALL (means no constraint) for cgroup v1 where there
> + * is no guaranteed association from a cgroup to a cpuset.
> + */
> +void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup, nodemask_t *nmask)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +
> +	if (!is_in_v2_mode()) {
> +		*nmask = NODE_MASK_ALL;
> +		return;
> +	}

You are allowing all nodes to be used for cgroup v1. Is there a reason 
why you ignore v1?

> +
> +	rcu_read_lock();
> +	css = cgroup_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (css) {
> +		css_get(css);
> +		cs = css_cs(css);
> +		*nmask = cs->effective_mems;
> +		css_put(css);
> +	}
Since you are holding an RCU read lock and copying out the whole 
nodemask, you probably don't need to do a css_get/css_put pair.
> +
> +	rcu_read_unlock();
> +}
> +
Cheers,

Longman

