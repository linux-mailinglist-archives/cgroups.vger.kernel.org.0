Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480EC4BF172
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 06:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiBVFly (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 00:41:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiBVFlx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 00:41:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F62A27A2
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 21:41:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gi6so7720019pjb.1
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 21:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF/LA0DJAyi2WkgDraeDPTQYetYLIgsh4V0sksoNxzk=;
        b=pauzJMJQ80pndaDK1GCL00PrQYlmURkbBHxp5EYP4alcPDhwEYiE3PGsaVWmuzwyx8
         yDc0O6G+EKinFKPyAVhHXNSWWrlhN5V6Nwj10pGm1+cZoXVlCcqVfw2Z8kWDsFCJ1lKp
         V9ijY5loDbTA2wnRyzF2T9aP/i6DiUxCLLzqoJb90HxytGV6d6/guf58n+b4D1CMiQfJ
         deQRBEHB14gFWu+UocLv+P81SyQ/l/ay467CP/26OKI2k7cl1Xn2yTH2Adb+0VxKm39a
         1EffzbbcUUiJsLSjNtqEP0lDEuk9j4lx6X6bqQITLpdzcIG9peoaS+FN+4kfPi7x6fYc
         DZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF/LA0DJAyi2WkgDraeDPTQYetYLIgsh4V0sksoNxzk=;
        b=r0BiHQC+P21JWSyT4y/xc+VsQpkSa0rqkogz80PWfNZebbF614AD4xsywPOnxmjuEI
         XLVjtHCD8YJ1wwtkxKLSKvRP8rts2CtVyHC90ykP2Zl7WVrvXb6++K2Z+AHbLjnYFvqs
         7VybCEZYJQOCqyA4EcYTzZiLJeVVADh3HPBZpGfbcAk6vu58A0p5Q3lkqn5eI2dZsmcR
         6nik4JvqBdSoVOoU2FaRpBbuLThD1ZO6feDbxAPnsIpjZ6bczLtPeYcZYLn8aaLTBJlZ
         MSPV7mKO0woZoQxeHe3LBjPJ8Gu3cHfphfFO8AC6RTafXukbcBRB/v8F1gT6licAqZZV
         W2Iw==
X-Gm-Message-State: AOAM531eQvbwKwuBv9WV8k+Y+h54ViEQmemuKNKfQPgqe27VTeEwCAm7
        SAIo2OiquAMurZ82M8/KGW/TXA3SqsZlBMJuGkpMAg==
X-Google-Smtp-Source: ABdhPJwZgkpqy+pZ8gDweXscqKjdRcJzeUeapNsNrGvI0e1FCqTYp6CiISQbcks56p8KzThnUZ+zUi+2jWzNNxeXEmc=
X-Received: by 2002:a17:90a:ac14:b0:1bc:2b81:4f5d with SMTP id
 o20-20020a17090aac1400b001bc2b814f5dmr2441754pjq.207.1645508480157; Mon, 21
 Feb 2022 21:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20220221182540.380526-1-bigeasy@linutronix.de> <20220221182540.380526-4-bigeasy@linutronix.de>
In-Reply-To: <20220221182540.380526-4-bigeasy@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Feb 2022 21:41:08 -0800
Message-ID: <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] mm/memcg: Protect per-CPU counter by disabling
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

On Mon, Feb 21, 2022 at 10:26 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
[...]
> +       /*
> +        * The caller from rmap relay on disabled preemption becase they never
> +        * update their counter from in-interrupt context. For these two
> +        * counters we check that the update is never performed from an
> +        * interrupt context while other caller need to have disabled interrupt.
> +        */
> +       __memcg_stats_lock();
> +       if (IS_ENABLED(CONFIG_DEBUG_VM)) {
> +               if (idx == NR_ANON_MAPPED || idx == NR_FILE_MAPPED)

NR_ANON_THPS, NR_SHMEM_PMDMAPPED, NR_FILE_PMDMAPPED are missing and
the switch statement would be cleaner.
