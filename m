Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6874BBE51
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiBRR0J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 12:26:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiBRR0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 12:26:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5BA2B5BB7
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 09:25:44 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s21so5324846ljp.2
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJsUkkYuKsFjmFuSrzJx6Z65BOc8raptsVlPvLM8N1M=;
        b=DQrnOr+7ZnH78FYvqffaE346vGIkV2x2C9ECWU9yqE4RVKdgMog75eA1y87iH06bUW
         xH0/fu78Skp4CvfXhzy6o2zYv3LGx/qwRJulidi4KrOjrA2U42XmP28RlZShOeNgqbka
         Cs4C0ETSQhG/vv/IDOf0o2HHaiUmd1ZFgIfwxIZLWbO/MOvqIYCazVduLcs8zp0wuuhI
         4+v5fciZgeeBNgdpAYcl2j/woTbUupNnDfY1AItJjxVg8pIpsVMjcLjfamvYsBd9zqnU
         mIcZXICCAD8nhgSnUNP4ziv0mZr+imOkr6s1d5lyGDxGlLaYYsjX1lA1RAZE9JqtUBeI
         EzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJsUkkYuKsFjmFuSrzJx6Z65BOc8raptsVlPvLM8N1M=;
        b=G7t4PHmW835EDSYnGpTQgSHcQVlK2b06F9LkG/yoiUbyNTHSgGPoG2sILh1+U5hslf
         UXQNmFjg+05jB4O9sLZrLT3VrPXjf9L6LWmaoYAkxr4SXTQ++23wTETePmWH0k2agCg2
         Rp2Q3z2YuVNXrDCilp0QXHvNWc2k9gRCpD3QmU129YyOqSH8vG40RZIEGAcDwuVMySmj
         IFEvc6631AF/CWSLBWInXPebxm4a+uh2Ma84lmuBlXaGdWMhcWG6HgKgVTqrTwzcWIAx
         +xAO3v30gzF+bbFJPww0801l+sGetCpO9St4RN/GeBgS5ulre+0CX7pebR3R0WWGKTCj
         Piqw==
X-Gm-Message-State: AOAM533HJN1WP3fMSkObp3dqCE9ZJHPVnGQ59QFCKP7NlOUP2rJSnfSQ
        DQ9/ITF7bfjCKo7lM5Rh0/fDLCdWpbh4fkxrfmfiMQ==
X-Google-Smtp-Source: ABdhPJz7B845uKGybPywxSqX/oQBwMJEoTY1oe+5SmrKHMrw+7UPwyBsRDz8K3Lsg8DgAiBpIvy8JJxQkuPWYU4456I=
X-Received: by 2002:a2e:9cd3:0:b0:23e:53fd:a7e5 with SMTP id
 g19-20020a2e9cd3000000b0023e53fda7e5mr6418436ljj.475.1645205142357; Fri, 18
 Feb 2022 09:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20220217094802.3644569-1-bigeasy@linutronix.de> <20220217094802.3644569-4-bigeasy@linutronix.de>
In-Reply-To: <20220217094802.3644569-4-bigeasy@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 18 Feb 2022 09:25:29 -0800
Message-ID: <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 17, 2022 at 1:48 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The per-CPU counter are modified with the non-atomic modifier. The
> consistency is ensured by disabling interrupts for the update.
> On non PREEMPT_RT configuration this works because acquiring a
> spinlock_t typed lock with the _irq() suffix disables interrupts. On
> PREEMPT_RT configurations the RMW operation can be interrupted.
>
> Another problem is that mem_cgroup_swapout() expects to be invoked with
> disabled interrupts because the caller has to acquire a spinlock_t which
> is acquired with disabled interrupts. Since spinlock_t never disables
> interrupts on PREEMPT_RT the interrupts are never disabled at this
> point.
>
> The code is never called from in_irq() context on PREEMPT_RT therefore
> disabling preemption during the update is sufficient on PREEMPT_RT.
> The sections which explicitly disable interrupts can remain on
> PREEMPT_RT because the sections remain short and they don't involve
> sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).
>
> Disable preemption during update of the per-CPU variables which do not
> explicitly disable interrupts.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b5117ed2ae08..36ab3660f2c6d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -630,6 +630,28 @@ static DEFINE_SPINLOCK(stats_flush_lock);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>
> +/*
> + * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
> + * not rely on this as part of an acquired spinlock_t lock. These functions are
> + * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
> + * is sufficient.
> + */
> +static void memcg_stats_lock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +      preempt_disable();
> +#else
> +      VM_BUG_ON(!irqs_disabled());
> +#endif
> +}
> +
> +static void memcg_stats_unlock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +      preempt_enable();
> +#endif
> +}
> +
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
>         unsigned int x;
> @@ -706,6 +728,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>         memcg = pn->memcg;)
>
> +       memcg_stats_lock();

The call chains from rmap.c have not really disabled irqs. Actually
there is a comment in do_page_add_anon_rmap() "We use the irq-unsafe
__{inc|mod}_zone_page_stat because these counters are not modified in
interrupt context, and pte lock(a spinlock) is held, which implies
preemption disabled".

VM_BUG_ON(!irqs_disabled()) within memcg_stats_lock() would be giving
false error reports for CONFIG_PREEMPT_NONE kernels.
