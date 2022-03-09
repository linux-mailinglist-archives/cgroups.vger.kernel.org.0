Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C434D385B
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiCISB6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiCISB5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 13:01:57 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB89106C8D;
        Wed,  9 Mar 2022 10:00:57 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id bc27so2619703pgb.4;
        Wed, 09 Mar 2022 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwDlrDADymvuEvHXEeAaoGU1H0sTeVDarhXCy/fUKn8=;
        b=IsL8LuurpdDpc0AEUobmmiq89FZUOGuAFYA8VyBDP2OUqbxgJ2B0YxLzuItup4B017
         DKmjObLAh3EyyNNvbJxuzTG9SaerxZQ9rClPzKCwe/En/+7SuQ7tSd/W1F/Fnxbsn47O
         tuAP36lsbfl9uz7ukzXnOa2w2FRIcTU+UPZZ7DhgX2VwyoRjNeeJhSzqMq2z5FneAco7
         EauVlyWMy1iZCN+AOFEuElRK+yY9h2lIuu6EOmSLaJNgLvq7fZZsBwDujdLOwTUa/spN
         HylYD6x3a2IV/6BndyQbgUjFjzFjwGgRmP4xPtSt+B/quHQvEwzXw5vQYEsL3aO34Cst
         HSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZwDlrDADymvuEvHXEeAaoGU1H0sTeVDarhXCy/fUKn8=;
        b=Q4RO8lpVRpucWPYgktJmNTRXa4rgG1g4eZr3pqElalB/wDkg+u3lWwSDWlt4LWA31U
         sH5KWNf4Hm9D7d+67u1LY2bZHbo+wnNBHW1nWJddlu8F4faZg8IAqFqw1ScOnjYAsOGI
         lbOqRlVdKBCEWLAKKJgK/BPL4Ln4HCAOaR7qJNiRrBDennCzal/hSaIbPqM2h52R+VNg
         w2zhFsHW5+F4nixguPT+Nm4sbq3ocqu9Ixwx4LLItxSzBnF2h8tcznWJTXHmahinib2A
         Wja47mxj2uCjF2t0B96MDDYok5cG6j7B8Wq1TuQWEZ8HTImzvAeLT2Hb9qmBNkxnkVu8
         n/OA==
X-Gm-Message-State: AOAM530EQo3CeHr5L2Ko5OgHlpEgdSVFST5tvG60AbnDrulrCcXwK2Uy
        oB4VECZoFncYQ3PIGva9cYA=
X-Google-Smtp-Source: ABdhPJzHQoGA45JS5iFaAdN2veUuSYqvFSFvSSpV8jGYgwtrA4RUfj3/114F7FNowHVooi8nwa5JVA==
X-Received: by 2002:a65:4143:0:b0:375:89f4:b46a with SMTP id x3-20020a654143000000b0037589f4b46amr717001pgp.335.1646848856669;
        Wed, 09 Mar 2022 10:00:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d25-20020a639919000000b00364f999aed5sm2892295pge.20.2022.03.09.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:00:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 9 Mar 2022 08:00:54 -1000
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
Message-ID: <YijrVmzG8/yT9a0f@slm.duckdns.org>
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
 <YieOvaqJeEW2lta/@slm.duckdns.org>
 <defa02c1-9660-f335-a764-d89dbe2f502e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defa02c1-9660-f335-a764-d89dbe2f502e@linux.alibaba.com>
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

On Wed, Mar 09, 2022 at 04:30:51PM +0800, Tianchen Ding wrote:
> "the sched domains and the load balancer" you mentioned are the ways to
> "balance" tasks on each domains. However, this patchset aims to "group" them
> together to win hot cache and less competition, which is different from load
> balancer. See commit log of the patch 3/4 and this link:
> https://lore.kernel.org/all/11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com/

I read that but it doesn't make whole lot of sense to me. As Peter noted, we
already have issues with cross NUMA node balancing interacting with in-node
balancing, which likely indicates that it needs more unified solution rather
than more fragmented. I have a hard time seeing how adding yet another layer
on top helps the situation.

> > * If, for some reason, you need more customizable behavior in terms of cpu
> >    allocation, which is what cpuset is for, maybe it'd be better to build the
> >    load balancer in userspace. That'd fit way better with how cgroup is used
> >    in general and with threaded cgroups, it should fit nicely with everything
> >    else.
> > 
> 
> We put group balancer in kernel space because this new policy does not
> depend on userspace apps. It's a "general" feature.

Well, it's general for use cases which are happy with the two knobs that you
defined for your use case.

> Doing "dynamic cpuset" in userspace may also introduce performance issue,
> since it may need to bind and unbind different cpusets for several times,
> and is too strict(compared with our "soft bind").

My bet is that you're gonna be able to get just about the same bench results
with userspace diddling with thread cgroup membership. Why not try that
first? The interface is already there. I have a hard time seeing the
justification for hard coding this into the kernel at this stage.

Thanks.

-- 
tejun
