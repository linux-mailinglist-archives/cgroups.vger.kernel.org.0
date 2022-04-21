Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CB50AB73
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbiDUWZ3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDUWZ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 18:25:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4921042EF4
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 15:22:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c12so6789409plr.6
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6WfdHbJCYQzab5SHoARzKzrfz2r1T0YKiP1hNGHigk=;
        b=ZO4eaJJc1D/7LWDis399vvRSyw5MBy95K81Welr1tTB6Wq6BW/lnNe2/GwfAzvcz6I
         U8IY9rPktTgn8KKX28BEbFqA2GiE6eHzQ9XWVWv7mNUeVqphiyNt+GJUxnsztz8BpCPV
         pzc//pxX7LAS0hEczz1kc/IY7mbLuU43a71tTY8CiViZu7u09/nrRr3pBLVXcrulUICa
         cIwUXxKbhjYv/yFzkWpLASqQfnmniPnwYmJUAhxZLyJJzhA6nFTI0HbFrYdvYl8E/Nh6
         JEmekiIqu9b3PmiaUaSqwKeUHq7TokiOmj5/CZqHGBre+241ESZz3lxcjwDeUbJwsIJn
         WIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y6WfdHbJCYQzab5SHoARzKzrfz2r1T0YKiP1hNGHigk=;
        b=cn6eJsX9SCdEyIVFwcieY8hlD///X4NH7t9xPTiPci3VvsbQTwa5GzQYjb7rFp4eA/
         5zoJhMlamt4ymUrpHhs2yoRML7/kFoMWhO+tCUKc5m41ZZBm5ImuNOCGrBcy3bOScVoc
         1P1kK+kcmtkbVi3d4zpgYfpuq233bbbzGkMsDcNBd2eYiLw79bpD9nLeYc8C7q3LHtko
         i/4V5FFi38o/xc0d40yRFaagCmqlqHUknpP58GuxVs9B8pVauxbWFjcCK9IjZbiNPCyN
         14bC7e99wwgHJiYzaAeZOVuTvc20fkcntDCmHK/cZfpfpWvSe9lAwxPa9o3ot/NWhaUy
         UzMA==
X-Gm-Message-State: AOAM5337f23HRso+Awl2YWB/x9+AE9VACAq2B7UMHq0coSiYuqpHskol
        prZ9gyakkm1xejty1VuEsvQ=
X-Google-Smtp-Source: ABdhPJwcH1qQPnuyd1zNvqMCwJDjmVEJquDucXk6REkrlVLU+xbI/lFSLpOuM9G+0hwzFZ+EI7nrGg==
X-Received: by 2002:a17:902:9307:b0:154:78ba:ed40 with SMTP id bc7-20020a170902930700b0015478baed40mr1609624plb.92.1650579757619;
        Thu, 21 Apr 2022 15:22:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
        by smtp.gmail.com with ESMTPSA id 129-20020a621687000000b0050579d13b1csm119388pfw.137.2022.04.21.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:22:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 12:22:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
        ying.huang@intel.com, Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] cgroup/cpuset: fix a memory binding failure for
 cgroup v2
Message-ID: <YmHZK+M470GjeJCV@slm.duckdns.org>
References: <20220419020958.40419-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419020958.40419-1-feng.tang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cc'ing Waiman and copying the whole body.

Waiman, can you please take a look?

Thanks.

On Tue, Apr 19, 2022 at 10:09:58AM +0800, Feng Tang wrote:
> We got report that setting cpuset.mems failed when the nodemask
> contains a newly onlined memory node (not enumerated during boot)
> for cgroup v2, while the binding succeeded for cgroup v1.
> 
> The root cause is, for cgroup v2, when a new memory node is onlined,
> top_cpuset's 'mem_allowed' is not updated with the new nodemask of
> memory nodes, and the following setting memory nodemask will fail,
> if the nodemask contains a new node.
> 
> Fix it by updating top_cpuset.mems_allowed right after the
> new memory node is onlined, just like v1.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Very likely I missed some details here, but it looks strange that
> the top_cpuset.mem_allowed is not updatd even after we onlined
> several memory nodes after boot.
> 
>  kernel/cgroup/cpuset.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 9390bfd9f1cd..b97caaf16374 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3314,8 +3314,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>  	/* synchronize mems_allowed to N_MEMORY */
>  	if (mems_updated) {
>  		spin_lock_irq(&callback_lock);
> -		if (!on_dfl)
> -			top_cpuset.mems_allowed = new_mems;
> +		top_cpuset.mems_allowed = new_mems;
>  		top_cpuset.effective_mems = new_mems;
>  		spin_unlock_irq(&callback_lock);
>  		update_tasks_nodemask(&top_cpuset);
> -- 
> 2.27.0
> 

-- 
tejun
