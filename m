Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8D6D6D8D
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjDDUFn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbjDDUFm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 16:05:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DDE52
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 13:05:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so34027489wrr.12
        for <cgroups@vger.kernel.org>; Tue, 04 Apr 2023 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFPo6vLpdwROFw5FNiJbZtKSQ4a0CmbJfxVbod1mMGg=;
        b=fno1tiY9rBhhOuM2df2ewT0wd3fPnGEDZeT7u2R/9NgBGXE4sBFyZUoEsTJj552o2G
         eBw3h3aQX+R2r9UFRTstZ3pkQO5kG0ZydD18fzZyFwrCk4k58DtKBcFm+oQlRZVOUyQS
         ZZWycYR/GLxiimAq/G77KpUhr6DTOdqsvnzWPxHUlvEX79eQBcT8oGHsBFhRdV9SyTup
         +mRJLBiyBqEMcRF9eqs+Oot7YfHVyg/56WeCk1+tSak91mLav/Dc2dbjkPnFskA0mswW
         a9Nyp3WBw0lFRQ9Zr2n+/g2+B/3US2I7YsD6dQOyfe3swaIM5sH1VtuUdg3c7sZ6P5hw
         zQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFPo6vLpdwROFw5FNiJbZtKSQ4a0CmbJfxVbod1mMGg=;
        b=pIh7LnszV4LU/2sIhVntKYoQE6m3/w4YYL1jM37pH+rHKK6fDrMV+XRQNuVu1kapBX
         AR/pBqyK2e2L4/98MZuh/Yjdg4jbpnU2yFxyf3ZVMUNNRLnCutVzCay5IC6MwGR8vuWs
         C5yOImLhEn23csTJfu/++UAhrIWDG3+b2+Jd/dLKbHCXq0sVzoRL0/mb2RWnDFgBgHE3
         fxeZ0iykXxdE3OhyO1g9WPFrlv5s6bbyIR/OkTFSBb3EMfsdywrqTK9veRaToK/uTgzZ
         skrHOvMBzRsZxqbSIy5waE1XWq5SGSBwC3LQtYE8AuyHL+5wvymJgY0Foqu/NpuZLOAB
         BMXQ==
X-Gm-Message-State: AAQBX9f9BC3SpG1XOeqk5CFcbEcDbyDnoDmtysFifWZQ6vTiLomkFisg
        Dzkx5lLh1Op+l2xYYiI9lVnABw==
X-Google-Smtp-Source: AKy350aLxU7DKfB4/xT8bwUVRJL4VX6+UiDqnaGoqBj+5vNcGvt4cLJNSB6mV3h1BqNAvpOuagttyw==
X-Received: by 2002:a05:6000:1b84:b0:2ce:a758:d6fb with SMTP id r4-20020a0560001b8400b002cea758d6fbmr314105wru.1.1680638739550;
        Tue, 04 Apr 2023 13:05:39 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id e38-20020a5d5966000000b002d78a96cf5fsm13171657wri.70.2023.04.04.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:05:39 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:05:37 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/6] cgroup/cpuset: Rename functions dealing with
 DEADLINE accounting
Message-ID: <20230404200537.l57oqyixbneuvxis@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-2-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-2-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
> rebuild_root_domains() and update_tasks_root_domain() have neutral
> names, but actually deal with DEADLINE bandwidth accounting.
> 
> Rename them to use 'dl_' prefix so that intent is more clear.
> 
> No functional change.
> 
> Suggested-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

>  kernel/cgroup/cpuset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 636f1c682ac0..501913bc2805 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1066,7 +1066,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  	return ndoms;
>  }
>  
> -static void update_tasks_root_domain(struct cpuset *cs)
> +static void dl_update_tasks_root_domain(struct cpuset *cs)
>  {
>  	struct css_task_iter it;
>  	struct task_struct *task;
> @@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
>  	css_task_iter_end(&it);
>  }
>  
> -static void rebuild_root_domains(void)
> +static void dl_rebuild_rd_accounting(void)
>  {
>  	struct cpuset *cs = NULL;
>  	struct cgroup_subsys_state *pos_css;
> @@ -1107,7 +1107,7 @@ static void rebuild_root_domains(void)
>  
>  		rcu_read_unlock();
>  
> -		update_tasks_root_domain(cs);
> +		dl_update_tasks_root_domain(cs);
>  
>  		rcu_read_lock();
>  		css_put(&cs->css);
> @@ -1121,7 +1121,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  {
>  	mutex_lock(&sched_domains_mutex);
>  	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	rebuild_root_domains();
> +	dl_rebuild_rd_accounting();
>  	mutex_unlock(&sched_domains_mutex);
>  }
>  
> -- 
> 2.39.2
> 
