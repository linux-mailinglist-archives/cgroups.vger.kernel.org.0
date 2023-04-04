Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC666D6D95
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjDDUGa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 16:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjDDUG0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 16:06:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52335A2
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 13:06:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so19703660wms.1
        for <cgroups@vger.kernel.org>; Tue, 04 Apr 2023 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls+P0Xr9GN+AqIqDM/7QzVRschzZBA3eDlF0vDC4TWA=;
        b=2hN7J5l9IRxG625nnwiFHOUJ/ADmBfBXl6X69iA0fHd6UOZ20ngnJ8uQK7eVcB7EwG
         rYi2xDPXfoshddzBkvW0lmPBFkMn18Exnap//hkLKLaU4FXFGBAfDLcvQFSMPx3lDFNQ
         kqy3d23QemeTAheQbXJtfsEzNGLuIFMZM17HRC/lq5PolMQtXA/LVx3PVrlENf7TiscT
         rjyWp4xYUmyFLC+yHeZAUkixk0/qgwEWOfT3i/i++zJV0RN5OnOMDzAmsLmqDdYLL/o3
         i4Zf/4uBx39OlaarDnPV980RQx+69nvUl1iEg9fGvxIuhBGl+XR6bk+YZR/XqWH4OYAi
         ZEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls+P0Xr9GN+AqIqDM/7QzVRschzZBA3eDlF0vDC4TWA=;
        b=2SfrNy6rdpRQilTDwR9q3XpkM2kALX3UlgcJPMautrmgUGSBAHnNraUWzohlnrNtUm
         XJHiBnEhJ3GDUA7y0JmrNAxXlZed21/Gl4dndNOhiaiCfe9btVguTQzy7mf6nnE7CcgJ
         CeVqEcztgehuTfP/SR07iQf8ydPdCAlH+rXeDnKxW60AQ0fyRebw9faBjow+c5BEd7VZ
         7bdaELV0DXngJxyrwu4tHQH9qaYx2+XkxpNaDXKzOM/jBC/QNWosa4a4phTvqZlrLtDP
         Endk85jfDt0U1jkNyD2ukDEmGdcAs8Jk20fLkoO3zyEDMzUV7zbEDTYFKbPKl72paofY
         S0Ew==
X-Gm-Message-State: AAQBX9eYmXj0Wvh5bf2JKtwk4VwhbIlLTGJ7cPUmX96IJPqX19s0J7nM
        cK3C/GTszceDv1bOiuJCn2wYSg==
X-Google-Smtp-Source: AKy350ZB8Mxiw57WHKbwdcM9QRC2Mgl4ccOoIG9ILA1NLpmxX71ROfPteiwUpsdZUkFfNCw3CUdnGQ==
X-Received: by 2002:a7b:c395:0:b0:3ee:9c0e:c78f with SMTP id s21-20020a7bc395000000b003ee9c0ec78fmr2774813wmj.5.1680638773360;
        Tue, 04 Apr 2023 13:06:13 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4b82000000b002d828a9f9ddsm12979807wrt.115.2023.04.04.13.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:06:13 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:06:11 +0100
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
Subject: Re: [PATCH 6/6] cgroup/cpuset: Iterate only if DEADLINE tasks are
 present
Message-ID: <20230404200611.smho7hd4sc2qwrgf@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-7-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-7-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
> update_tasks_root_domain currently iterates over all tasks even if no
> DEADLINE task is present on the cpuset/root domain for which bandwidth
> accounting is being rebuilt. This has been reported to introduce 10+ ms
> delays on suspend-resume operations.
> 
> Skip the costly iteration for cpusets that don't contain DEADLINE tasks.
> 
> Reported-by: Qais Yousef <qyousef@layalina.io>
> Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---

Wouldn't this be better placed as patch 4? The two fixes from Dietmar look
orthogonal to me to the accounting problem. But it seems the whole lot needs to
go to stable anyway, so good to keep them together. Should Dietmar fixes be at
the end instead of this?

Anyways.

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Qais Yousef <qyousef@layalina.io>


Thanks

--
Qais Yousef

>  kernel/cgroup/cpuset.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f8ebec66da51..05c0a1255218 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>  	struct css_task_iter it;
>  	struct task_struct *task;
>  
> +	if (cs->nr_deadline_tasks == 0)
> +		return;
> +
>  	css_task_iter_start(&cs->css, 0, &it);
>  
>  	while ((task = css_task_iter_next(&it)))
> -- 
> 2.39.2
> 
