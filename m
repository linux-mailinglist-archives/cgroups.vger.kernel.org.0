Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431424B776A
	for <lists+cgroups@lfdr.de>; Tue, 15 Feb 2022 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiBOSu1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 13:50:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiBOSu1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 13:50:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C274853
        for <cgroups@vger.kernel.org>; Tue, 15 Feb 2022 10:50:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b11so13992657lfb.12
        for <cgroups@vger.kernel.org>; Tue, 15 Feb 2022 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Xnr8BvsNvJcUeAT+XTUM3XKtkq81lQw2/bkBVhK17c=;
        b=Sfe/kuKEpWEWZjVJDL2psXjG9oUfvqPlmdtCHVjzjva5Wf4hgOym+ssmVRUnZneaA2
         rEkXJ6PqgGUbzerluit/C1Y3RqEu1S5bYN/tNFSYc4A5kPeu9G3E82vvyMHH6f16rRsY
         y+OdypvtdIdQcjShE2Ydr+tNu8kR1mF0qx5XOsBDCXMb09E2+SV+WVbERkryp01EqPei
         0+5L0KO/aEa5PsYc4A+s/3lgkQDYrL7LcIUbxKDZxMJD+qr4LQbpfxisHlC99/g6Rd7E
         qvdfK8AZjD7qDatwPsLGEWXQtAWkFS+YwYoq/b26HhsMtTgjy6v3qudX31TKl19Ek6Fi
         fetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Xnr8BvsNvJcUeAT+XTUM3XKtkq81lQw2/bkBVhK17c=;
        b=zIYO9HQplDcbX5aEYNopeZCyNXMqCBnMSHk5VJnKzupnekyTkenj2PMftPidOVllGs
         fQ/ikA7Rx1i63MY3QN9FcEV/SrBQsT019vDEkHA+treGGTn4aFDxP1XFJUFVWM2v3N0P
         IQH5knxrZ9srIBZ7UyBtGvMuR8w7smukowsgJeZlx9tSuO9PftIA3qzIkgFDp8sNgvnA
         1EpMczhQyJBPya56Pnmzx/sk+YT0KPZ9OGKNcdTZRZU5k90Q73rKEl1KUU4XUd+3+VEO
         v97KH17UBtvCUoxzN0X0WVaRhKi5Tuzf34QKRRxB38BwqExK8S1pI8v2rOPiMxiVYZ4h
         nF8g==
X-Gm-Message-State: AOAM53395/d+cq14vLe4Q9VC7AS5QS0Exd8ahk/K5J9hCRSDZ6kaZt3V
        6Tax99oDpvr5O1iXd5q9kddn9eCKUcaxwXqXpyp1xg==
X-Google-Smtp-Source: ABdhPJyIu9dxDVnqJmrU42bbi/YznVPRyTi+a5MPMSB6Gw1A7chbBCL0ab5yyXR171n2U9x2sWStDOrNza+8Sdgt2IU=
X-Received: by 2002:a05:6512:10ce:: with SMTP id k14mr328361lfg.210.1644951014338;
 Tue, 15 Feb 2022 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com> <20220211064917.2028469-5-shakeelb@google.com>
In-Reply-To: <20220211064917.2028469-5-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Feb 2022 10:50:03 -0800
Message-ID: <CALvZod6Fpt6ofP=f63+qdv-hwKm8RekS2qtGHrKfoFb=PcRCPA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] memcg: synchronously enforce memory.high for large overcharges
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
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

On Thu, Feb 10, 2022 at 10:49 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> The high limit is used to throttle the workload without invoking the
> oom-killer. Recently we tried to use the high limit to right size our
> internal workloads. More specifically dynamically adjusting the limits
> of the workload without letting the workload get oom-killed. However due
> to the limitation of the implementation of high limit enforcement, we
> observed the mechanism fails for some real workloads.
>
> The high limit is enforced on return-to-userspace i.e. the kernel let
> the usage goes over the limit and when the execution returns to
> userspace, the high reclaim is triggered and the process can get
> throttled as well. However this mechanism fails for workloads which do
> large allocations in a single kernel entry e.g. applications that
> mlock() a large chunk of memory in a single syscall. Such applications
> bypass the high limit and can trigger the oom-killer.
>
> To make high limit enforcement more robust, this patch makes the limit
> enforcement synchronous only if the accumulated overcharge becomes
> larger than MEMCG_CHARGE_BATCH. So, most of the allocations would still
> be throttled on the return-to-userspace path but only the extreme
> allocations which accumulates large amount of overcharge without
> returning to the userspace will be throttled synchronously. The value
> MEMCG_CHARGE_BATCH is a bit arbitrary but most of other places in the
> memcg codebase uses this constant therefore for now uses the same one.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Any comments or concerns on this patch? Otherwise I would ask Andrew
to add this series into the mm tree.

> ---
> Changes since v1:
> - Based on Roman's comment simply the sync enforcement and only target
>   the extreme cases.
>
>  mm/memcontrol.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 292b0b99a2c7..0da4be4798e7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2703,6 +2703,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>                 }
>         } while ((memcg = parent_mem_cgroup(memcg)));
>
> +       if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
> +           !(current->flags & PF_MEMALLOC) &&
> +           gfpflags_allow_blocking(gfp_mask)) {
> +               mem_cgroup_handle_over_high();
> +       }
>         return 0;
>  }
>
> --
> 2.35.1.265.g69c8d7142f-goog
>
