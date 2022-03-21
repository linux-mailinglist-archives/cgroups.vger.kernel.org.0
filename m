Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779FA4E2FC3
	for <lists+cgroups@lfdr.de>; Mon, 21 Mar 2022 19:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiCUSSH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Mar 2022 14:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352070AbiCUSRz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Mar 2022 14:17:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714AC17ECFC;
        Mon, 21 Mar 2022 11:16:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so13466943plg.5;
        Mon, 21 Mar 2022 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ls4ppSzcwTphO5fl7/cnR5YWXHZaUFCeJodB7pVCrnU=;
        b=bayZTwU/9OUWkVg+QqtcVV1j1Ad8zFbewV2DckvEs4eUP0KmVFLQPCXlYku22qs0q4
         zM49m1PcjGur8W0lk9CJ7B9Bs5b044DrxlaNWyaY9TSZTF9rRyVrsO1mJQg2S3WDeXgm
         HtWjErAnUi6OMAcvPs/Qv1dm+IkGmF8WjQVeWA0yHP7b0TKjcU+NUwSGG+v1kdmRGdWN
         rgAKCyMEkYbcHbEQ8pGZvCV54/VfaUQOEz7jXvNyT0aycIrBNasLt1KDTvpdXD8Paq9l
         6Z+oGHIkWCgFaXp4xbcSZmEjKuNoo6Vk5fHwoVuj6J4+oAsyR7HqN8d5M5+hu5YgFdrD
         PIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ls4ppSzcwTphO5fl7/cnR5YWXHZaUFCeJodB7pVCrnU=;
        b=p/vmj1NkhdA7V3eTKo5fXiZSkuimLLIUhiPvvpx8vIWM80KEHgTjAqz/ZldboOb2Ep
         Wa2C5r9bBG7Fyw/naiPRx6eEsrNenZy+i9Y6lkMVYhDMKXO9m4uKk6V3BGUNjCv17mLT
         Brk7VZtgj8SCc+ol817p9iO9NiOvDaRiP0rnnhVwyjMqg+Fgm4aZkyHQH9saH4uTqDHD
         ZcFwmDDTVdV1+RbxYuq3L9hydWOHzzj4Wjr63rBALkw8u1cORW3YB6DJXWTORTL0eRB8
         a0awRMH8ox8Hf22Zzh4k3CpvH6/A+yJ1I8fkm+Pl18/RR58RelA0c7vMCaGk+2ML+v0c
         uurQ==
X-Gm-Message-State: AOAM533wMrjNW41jyr6kz/Iyx74A0lp/USbVzRtBZOfSPo6mlOEjaaiS
        C/9zZm6oLuIdLsuF3u2ePUc=
X-Google-Smtp-Source: ABdhPJzjYlZZl7OOBIipGbQEYnldtJe0DY15tFkroj2aUWhxl4BxvokM8S1i/lY6WZesYrOWfEXD1A==
X-Received: by 2002:a17:902:e9c2:b0:153:c185:c7b1 with SMTP id 2-20020a170902e9c200b00153c185c7b1mr13961034plk.92.1647886588695;
        Mon, 21 Mar 2022 11:16:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm19778027pfk.88.2022.03.21.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:16:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 08:16:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Introduce group balancer
Message-ID: <YjjA+vyQuh5fNeLG@slm.duckdns.org>
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
 <YieOvaqJeEW2lta/@slm.duckdns.org>
 <defa02c1-9660-f335-a764-d89dbe2f502e@linux.alibaba.com>
 <YijrVmzG8/yT9a0f@slm.duckdns.org>
 <014c8afe-e57f-0f31-32bb-cf4ff3d3cb95@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014c8afe-e57f-0f31-32bb-cf4ff3d3cb95@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Mar 10, 2022 at 01:47:34PM +0800, Tianchen Ding wrote:
> If we want to build group balancer in userspace, we need:
>   1) gather load info from each rq periodically
>   2) make decision to set cpuset.cpus of each cgroup
> 
> However, there're some problems about this way.
> 
> For 1), we need to consider how frequently collecting these info, which may
> impact performance and accuracy. If the load changes hugely right after we
> get it once, our data are expired and then the decision may be wrong. (If we
> are in kernel, faster action can be taken.)

We now have a pretty well established way to transport data to userspace at
really low overhead. If you piggy back on bpf interfaces, they can usually
be pretty unintrusive and low effort as long as you have the right kind of
data aggregated already, which shouldn't be that difficult here.

> We believe 2) is harder. The specific policy may be complex and alter
> according to different scenes. There's not a general method.
> e.g., with 16cpus and 4 cgroups, how to decide when we set one of them
> 0-3(when busy)or 0-7(when some of other cgroups are idle)? If there are much
> more threads in cgroupA than cgroupB/C/D , and we want to satisfy cgroupA as
> far as possible(on the premise of fairness of B/C/D)， dynamically
> enlarging(when B/C/D partly idle) and shrinking(when B/C/D busy) cpuset of
> cgroupA requires complex policy. In this example, fairness and performance
> can be provided by existing scheduler, but when it comes to grouping hot
> cache or decreasing competion, both scheduler in kernel and action in
> userspace are hard to solve.

So, I get that it's not easy. In fact, we don't even yet know how to
properly compare loads across groups of CPUs - simple sums that you're using
break down when there are big gaps in weight numbers across tasks and can
become meaningless in the presence of CPU affinities. They can still work
when the configuration is fairly homogeenous and controlled but the standard
should be far higher for something we bake into the kernel and expose
userland-visible interface for.

> What's more, in many cloud computing scenes, there may be hundreds or
> thousands of containers, which are much larger than partition number. These
> containers may be dynamically created and destroyed at any time. Making
> policy to manage them from userspace will not be practical.
> 
> These problems become easy when going to kernelspace. We get info directly
> from scheduler, and help revising its decision at some key points, or do
> some support work(e.g., task migration if possible).

I don't think they become necessarily easy. Sure, you can hack up something
which works for some cases by poking into existing code; however, the bar
for acceptance is also way higher for a kernel interface - it should be
generic, consistent with other interfaces (I won't go into cgroup interface
issues here), and work orthogonally with other kernel features (ie. task /
group weights should work in an explainable way). I don't think the proposed
patches are scoring high in those axes.

I'm not against the goal here. Given that cgroups express the logical
structure of applications running on the system, it does make sense to
factor that into scheduling decisions. However, what's proposed seems too
premature and I have a hard time seeing why this level of functionality
would be difficult to be implement from userspace with some additions in
terms of visibility which is really easy to do these days.

Thanks.

-- 
tejun
