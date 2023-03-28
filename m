Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309B6CCA98
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 21:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1T2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1T2M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 15:28:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5F3582
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:28:12 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5456249756bso249860457b3.5
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YujjpUZD+Q1jEde3/ZaCZtJJBkVmO1XlOY4kEzyMtns=;
        b=PhhYKJhXpGjlraKgnxTA1ox1zCuQDINg4H+NjqECLIwcVewsJ2UmF/XldtrOxzUW8F
         FtkMxK9XYIcC/gvDvo1cxA29U3ULWGCBaajKqJk4rgMHA4ss0Alf25G8t46R7Lp02Xut
         O+DxLHWvNCJdltEaU/xNOPwle2JDPTEN6cuVv0Zhrr8Lkz33KxXfau2W3yTNNCA9y3Xp
         LQiDdGk9NrgkoMvxC8Ehixwa8p3N51flc75mRDOp0exVkF6k6E4Hs69JMi+L3/TWelEW
         6mlpBQZHrXZuZqhCm7o9gUs274DyVLH9j018hTkghuZN3NqPxQMPN2+CHF+Zi2aGJdO3
         GnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YujjpUZD+Q1jEde3/ZaCZtJJBkVmO1XlOY4kEzyMtns=;
        b=cWFVXrT01O6lK3tF5TpG2KRHsnBRWMjeWSHM9aLGYir992hAt+YyOiBASzG8tEL2pH
         naBOAkuamlIXSP9/GE4fiZ9bAxfe1BPhnu2A2dYLmcjRSRpWrJ3Q39DTWL6BGMLpyMSC
         jjV7iCKoaD5of9WfzIPsIQC+mbzdnfdxpGUrpbTmUTmiOFpfNgpTTg0Mxt3iHCZp/MO3
         qXLMLYX0jxmZQ8/9V1Cd9HhJNpCQLtf0F4k9vbXC4FfOyqjjF3a2HuVd5htNopByCyFV
         ZdJDCzTuwtNv34CHxSoSGAs6uqX1L/5i6rJ3WLkwbGdBMzyptp3HCfwy1iG3FJ4sHkjI
         iz+w==
X-Gm-Message-State: AAQBX9f1l+O2oxteem+wfnXSKcXMsc98cSUZe1Bpf8vQwLgONPjU4RiQ
        t8Q6LjsXtnueuXd18i3zPwRdyw8gCQYezoY9ip+YnA==
X-Google-Smtp-Source: AKy350as29FZcp4Hu0tcOiv3iwZMMe8Tutrvh0MvK9Mp8FSELCYsBga7jimfk6sxXcp6Bx7kDkhWcd+YkT9zVUBO2h4=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr8104683ywj.0.1680031691214; Tue, 28 Mar
 2023 12:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com> <20230328141523.txyhl7wt7wtvssea@google.com>
 <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
In-Reply-To: <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 12:28:00 -0700
Message-ID: <CALvZod4Gsngc6MjXdk4s5+ePVjsgcVppdRmsQovN6gSrxzdbfA@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 11:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
> > > +     if (atomic_xchg(&stats_flush_ongoing, 1))
> >
> > Have you profiled this? I wonder if we should replace the above with
> >
> >         if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_flu=
sh_ongoing, 1))
>
> I profiled the entire series with perf and I haven't noticed a notable
> difference between before and after the patch series -- but maybe some
> specific access patterns cause a regression, not sure.
>
> Does an atomic_cmpxchg() satisfy the same purpose? it's easier to read
> / more concise I guess.
>
> Something like
>
>     if (atomic_cmpxchg(&stats_flush_ongoing, 0, 1))
>
> WDYT?
>

No, I don't think cmpxchg will be any different from xchg(). On x86,
the cmpxchg will always write to stats_flush_ongoing and depending on
the comparison result, it will either be 0 or 1 here.

If you see the implementation of queued_spin_trylock(), it does the
same as well.
