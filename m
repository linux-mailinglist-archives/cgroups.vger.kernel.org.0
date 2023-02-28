Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7786A5536
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 10:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjB1JKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 04:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjB1JKF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 04:10:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C87A29E10
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 01:09:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13018464pjh.0
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD6LFUjaCV0Y3rxiGh/Ykg8y93935IDS5wJRL1FIbVk=;
        b=V8ikxzfit8o1ERBDuVpWZBjCJo3dBKGAYbIiDxp9M9uCoraXVlmQhSEskvLmuayfg7
         /A8wcV7Xoc0qpfJZtw6hgOyJsrSsEWnaY6cSn+3lyXcaR4wB89slxOmi+OPCGsjOAbrN
         QxvsRE8/q4humpPg/XxOfc5HxA9dOoJSpNo/FKyyoHQPu6t3Yz3jXs7uSmB0txyiTz0e
         PUi+8DPIYfsOf5AYgU8+ggxQauIYTdqvYTy8pEMolMHzGgRZoYlFxf5Gzjp17l6mhKxY
         a/KI6B9hkhoCTAhTmYKOpgcqM7aPi8tZ5WYPp2xh0paNZczkU7SJWbRcVLCujWEUckUj
         wDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD6LFUjaCV0Y3rxiGh/Ykg8y93935IDS5wJRL1FIbVk=;
        b=Xu59OEePMD/HLoxWlz1z2bgibZEtiXHXBrmwW3Lu2tqp/XJvLLbpLM/WD4Ail7BMvQ
         zV8rl02p50OsjMriaRJyOJiXb5Uy3DYx2dc3aYtHLXfp/0YSHI/K1eTEMnsGdbfL2Z4e
         ERn+p8xdUw134P/syZiTx1lGYwpwkAYeWn3FKZcDtAQ1SCnB6gx7JgnQ0JUkrsqm95sQ
         yyBjFWZyh/EwOcQIBNvDfeJvN/dMlKqPd1ZaiItRiGK5nAURo2XGTD4hIkifpzEx7ms3
         Y3BVt+fWyisK6uePUd+7r25B+1jBRFqUHHe6q0bAvz6YwujGHOo7Y4h+HoExI/8XoX+R
         xpxQ==
X-Gm-Message-State: AO0yUKXoc0rI0IMencXa2poEbH2El1/t5046Z0BXAAdzy+Rr7qIDI5My
        7tjzas9n/ttMxDUNVvFpxu1xqT2dNGYVdQ8qV1md0gRK4amwrg==
X-Google-Smtp-Source: AK7set93FN2ttcQwT7EC15gr1UiM1Y8d9QHK7DcW3SPfncAiSsZl4qdnrkpo0ulu9uB0Vhpt/THDhHb+4GpqYXzPBfk=
X-Received: by 2002:a17:902:e5d0:b0:19a:fa2f:559e with SMTP id
 u16-20020a170902e5d000b0019afa2f559emr1612340plf.3.1677575399000; Tue, 28 Feb
 2023 01:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-7-vincent.guittot@linaro.org> <20230224192919.d4fcde3dwh7betvm@blackpad>
 <CAKfTPtBorwnjU2=nprBo7aAEjoz+7x5nRYUdajZc53cuVgHSBw@mail.gmail.com> <20230227144236.z6zbgsaohlz6sl7o@blackpad>
In-Reply-To: <20230227144236.z6zbgsaohlz6sl7o@blackpad>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Feb 2023 10:09:47 +0100
Message-ID: <CAKfTPtAq-fRhgXw21RxLhT_ZZQUoMSZgGc90R_qoqkUhu+ADDw@mail.gmail.com>
Subject: Re: [PATCH v12 6/8] sched/fair: Add sched group latency support
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 27 Feb 2023 at 15:42, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Mon, Feb 27, 2023 at 02:44:22PM +0100, Vincent Guittot <vincent.guitto=
t@linaro.org> wrote:
> > Regarding the current use of latency nice to set a latency offset, the
> > problem doesn't appear because latency offset applies between entities
> > at the same level as you mentioned above
>
> Splendid, it turned out that way (latency nice analogous to bandwidth
> nice).
>
> > Does  my explanation above make sense to you ?
>
> Yes, thank you.
>
> Thus, I'd like to propose avoiding the use of "limit" in this context and
> stress the horizontal scope. For example:
>
> > +     This interface file allows reading and setting latency using the
> > +     same values used by sched_setattr(2). The latency_nice of a group=
 is
> > +     used to limit the impact of the latency_nice of a task outside th=
e
> > +     group.
>
> +     This interface file allows reading and setting latency using the
> +     same values used by sched_setattr(2). The latency_nice of a group i=
s
> +     used to modify group members' latency with respect to sibling group=
s.

That sounds reasonable to me.

>
> Regards,
> Michal
