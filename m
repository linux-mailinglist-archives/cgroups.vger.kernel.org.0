Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E1681AC4
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjA3Tsb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 14:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjA3Tsb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 14:48:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A482DE69
        for <cgroups@vger.kernel.org>; Mon, 30 Jan 2023 11:48:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q19so2167331edd.2
        for <cgroups@vger.kernel.org>; Mon, 30 Jan 2023 11:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/epT0HthGo9idR6/JygM4Ut5nxd0mtqhcl73FuFnvd0=;
        b=7ljygM0/w5DNcasAIz5MI5w4X5iB/ltvNZmvQySKVYguKptUKrtlzinPn+xu+Sy6rJ
         Vmd10HamiCKQqveQDxwxcR3lkoBkHDt3kskrpVIYosLqwsOZdlzOHuC9TP8VVy2btYhk
         W8mHyEvXBcyCfLFFxNR0VMAeM8s2952pu0M/y51/qt6+tJohzDLZCPXiDGXefiwqTQC9
         +QJB5VA68w5pYfvRW/UZCvBzytpl9aanZeo5Ynbblp/nxXgvDXMYydOipM0t2v3HsqyQ
         AXenRldr5bFR7o/f45HcJvu+D3h29A5fkCKVxpL4vPI63yjJCxdMXmD4aUzs7pEgETA6
         3URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/epT0HthGo9idR6/JygM4Ut5nxd0mtqhcl73FuFnvd0=;
        b=lowZElfNpqqftatN0VuKKolmYPrEdSmCrKga/sXDaUuet4ricdHPE2ByRRmweC1OY0
         bdomXbdr3hAiGpSQelXABEJx5Fj9+7X2V9gngXHsou8MRZaGdJtXxzn8NTODaKmie9Tp
         msq9LzK2mCgqTkaNHO7yMCAr66r+SnSEOCHPx86WMu1NegVtCoSqjZi4GCPnxJgbZW7x
         VjgO3xh9xFn5IQFg4Fodk4bCm5BBPgG6XfCf3vz1YFg1iR/6n2Xn7EC3mBygkZDXroIC
         jj1vpnkWXAulOCD8UykWqEIiYCgnkVnLDlY/6WegwaKud9iASlmkv5bq8HKk4sAio8Oo
         k90g==
X-Gm-Message-State: AFqh2krGwuz5cWlUZdyxFWAsMYvAC7zdB5a8T3Yr0WRIahOJuYy6h2uO
        ZIVJo+6JflLhCv8cDarMUzlZRg==
X-Google-Smtp-Source: AMrXdXuHigsktqMYOylLlxDD8w+OZZVmBwn48RRn9LL4W9fvKG5cwx0H51Bbnh5LjWPsBTqUs2BeJw==
X-Received: by 2002:a05:6402:1946:b0:48b:c8de:9d20 with SMTP id f6-20020a056402194600b0048bc8de9d20mr57848750edz.32.1675108108503;
        Mon, 30 Jan 2023 11:48:28 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id t26-20020a17090616da00b007aee7ca1199sm7391442ejd.10.2023.01.30.11.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:48:28 -0800 (PST)
Date:   Mon, 30 Jan 2023 19:48:26 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
Message-ID: <20230130194826.rxwk4ryvpyxemflm@airbuntu>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
 <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
 <20230130130038.2qx3pkzut6ypqdub@airbuntu>
 <253ced33-c3a8-269f-90cc-b69e66b10370@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <253ced33-c3a8-269f-90cc-b69e66b10370@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/30/23 11:29, Waiman Long wrote:
> On 1/30/23 08:00, Qais Yousef wrote:
> 
>         just skip the call here if the condition is right? Like
> 
>                 /* rebuild sched domains if cpus_allowed has changed */
>                 if (cpus_updated || (force_rebuild && !cpuhp_tasks_frozen)) {
>                         force_rebuild = false;
>                         rebuild_sched_domains();
>                 }
> 
>         Still, we will need to confirm that cpuhp_tasks_frozen will be cleared
>         outside of the suspend/resume cycle.
> 
>     I think it's fine to use this variable from the cpuhp callback context only.
>     Which I think this cpuset workfn is considered an extension of.
> 
>     But you're right, I can't use cpuhp_tasks_frozen directly in
>     rebuild_root_domains() as I did in v1 because it doesn't get cleared after
>     calling the last _cpu_up().
> 
> That is what I suspect. So we can't use that cpuhp_tasks_frozen variable here
> in cpuset.
> 
>      force_rebuild will only be set after the last cpu
>     is brought online though - so this should happen once at the end.
> 
> Perhaps you can add another tracking variable for detecting if suspend/resume
> is in progress.

I think cpuhp_tasks_frozen is meant for that. All users who cared so far
belonged to the cpuhp callback. I think reading it from cpuset_hotplug_workfn()
is fine too as this function will only run as a consequence of the cpuhp
callback AFAICS. cpuset_cpu_active() takes care of not forcing a rebuild of
sched_domains until the last cpu becomes active - so the part of it being done
once at the end at resume is handled too.

It's just rebuild_sched_domains() will always assume it needs to clear and
rebuild deadline accounting - which is not true for suspend/resume case. But
now looking at other users of rebuild_sched_domains(), others might be getting
the hit too. For example rebuild_sched_domains_locked() is called on
update_relax_domain_level() which AFAIU should not impact dl accounting.

FWIW, I did capture a worst case scenario of 21ms because of
rebuild_root_domains().

/me thinks rebuild_root_domains() is a misleading name too as it just fixes
dl accounting but not rebuild the rd itself.

What makes sense to me now is to pass whether dl accounting requires updating
to rebuild_sched_domains() as an arg so that the caller can decide whether the
reason can affect dl accounting.

Or maybe pull rebuild_root_domains() out of the chain and let the caller call
it directly. And probably rename it to update_do_rd_accounting() or something.

I'll continue to dig more..


Thanks!

--
Qais Yousef
