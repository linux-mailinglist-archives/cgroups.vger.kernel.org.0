Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E24B2E90
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiBKUgz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 15:36:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352677AbiBKUgy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 15:36:54 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7AD53
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 12:36:46 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e17so14063903ljk.5
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCAsjj+/2EPlyUQtiVo8WDkzcxXnQjrZ0PEqMW7wI0o=;
        b=ppE7RooPi4WL00e0ZLJbFk100+IS02OV5QywrNLcKaCJbEtR4YxukPIudnLp8SeKMe
         1NpTHSxW8chgPGf7JOY4Ea15KZrCmewdQuJqeHkqMC3F2oB8XRhcoJdjL6j9/F+7f8WJ
         uUAPTnA1DepzO0Qt+pe0IQN9d9vuPEWAghF7tyEwP6gcUibW6u7V60dsZ2Om7MgSwh3u
         hnqtLmgCUXP8KKVYUrxRFdwOov2m9joI3QdDjxk8pE/fUxhg1L3y/BZJCLku2CDajQza
         5EbbCjrTyKK1IaSFwD9Kfjiz5aTiqTn7xQlm4sYnrDALmXTu3uE6ySHxWdrZ9XJkKkF2
         1Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCAsjj+/2EPlyUQtiVo8WDkzcxXnQjrZ0PEqMW7wI0o=;
        b=ii4gH819B/ugN6Ug87DnMnGD8rAa4OSB99lHccMxm51EDD2XVzLsM962bjOkst/zcC
         vNCI7wc9UPuia1c79xGAMaO70ElFObkIZ2M7HvLnuREd+Ft5VtOq4SmZ2xesuc/0qFUu
         Kcv21T02D60FxCnbzR7nlLYP/22yheUWd4ADozJV7yzJdMAp6gSaGpa7sz5gWug8cUJ+
         85InypMt2nRdyW/snLjutDbdUveb0tlmlJBI5iQDaIO6FJ+0hruhbJ/7Be0+jlpX0XJW
         oQFTxdGV/Vqu0P45/F2HuFcQ8qOPDkb2h/wUtTzwUqc1Ew4un+qtuT0AA3EwVJqQPAQm
         bprw==
X-Gm-Message-State: AOAM531hrngj0AEt+BtWPJWCB+E//d1AMJV9tT/qBHU6IF+JvFfCTusR
        tem71/Z3P6tvkTIR3Jrp4pAUtShF6qIats2TaOWBfg==
X-Google-Smtp-Source: ABdhPJwVEa48rkJ6G8rmFGKX6ejD7MgqMsPEy2hj6bqYfREd84v21zv7mlJcxID3H7rLs2teXuRiEvkPefLlwn+Djcc=
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr1959958ljm.35.1644611804994;
 Fri, 11 Feb 2022 12:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com> <20220211064917.2028469-5-shakeelb@google.com>
 <YgZS+YijLo0/WmEd@chrisdown.name>
In-Reply-To: <YgZS+YijLo0/WmEd@chrisdown.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Feb 2022 12:36:33 -0800
Message-ID: <CALvZod6FwcSyi3B-3fkw4e+7BGrjFF2iRLEZVeurLp2+v-k-dg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] memcg: synchronously enforce memory.high for large overcharges
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 4:13 AM Chris Down <chris@chrisdown.name> wrote:
>
[...]
> >To make high limit enforcement more robust, this patch makes the limit
> >enforcement synchronous only if the accumulated overcharge becomes
> >larger than MEMCG_CHARGE_BATCH. So, most of the allocations would still
> >be throttled on the return-to-userspace path but only the extreme
> >allocations which accumulates large amount of overcharge without
> >returning to the userspace will be throttled synchronously. The value
> >MEMCG_CHARGE_BATCH is a bit arbitrary but most of other places in the
> >memcg codebase uses this constant therefore for now uses the same one.
>
> Note that mem_cgroup_handle_over_high() has its own allocator throttling grace
> period, where it bails out if the penalty to apply is less than 10ms. The
> reclaim will still happen, though. So throttling might not happen even for
> roughly MEMCG_CHARGE_BATCH-sized allocations, depending on the overall size of
> the cgroup and its protection.
>

Here by throttling, I meant both reclaim and
schedule_timeout_killable(). I don't want to say low level details
which might change in future.

[...]
>
> Thanks, I was going to comment on v1 that I prefer to keep the implementation
> of mem_cgroup_handle_over_high if possible since we know that the mechanism has
> been safe in production over the past few years.
>
> One question I have is about throttling. It looks like this new
> mem_cgroup_handle_over_high callsite may mean that throttling is invoked more
> than once on a misbehaving workload that's failing to reclaim since the
> throttling could be invoked both here and in return to userspace, right? That
> might not be a problem, but we should think about the implications of that,
> especially in relation to MEMCG_MAX_HIGH_DELAY_JIFFIES.
>

Please note that mem_cgroup_handle_over_high() clears
memcg_nr_pages_over_high and if on the return-to-userspace path
mem_cgroup_handle_over_high() finds that memcg_nr_pages_over_high is
non-zero, then it means the task has further accumulated the charges
over high limit after a possibly synchronous
memcg_nr_pages_over_high() call.

> Maybe we should record if throttling happened previously and avoid doing it
> again for this entry into kernelspace? Not certain that's the right answer, but
> we should think about what the new semantics should be.

For now, I will keep this as is and will add a comment in the code and
a mention in the commit message about it. I will wait for others to
comment before sending the next version and thanks for taking a look.
