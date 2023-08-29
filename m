Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0F78CD82
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjH2UVj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjH2UVW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 16:21:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C304CFC
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 13:21:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so56102301fa.2
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693340471; x=1693945271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOlYcqn8beQHjGoc0Rc5zdI+Fp8S0JCnlA3frimuCzk=;
        b=nyA6kP+bHHClyA0VkxrhbCG/koc4svjXIbKSdfDmP78sWe3Ayia11iC026uAdafagz
         8ciYB3b+09qlidGWMzXKopliiQwcRAp+xJ4qWmDolr4c46z2IKMPdivb4GtLBXLtFCZv
         Uy+Ji531qs3ohqkb8KreIiL66sROhCex/56AxE8K3Fb7MDMa4hmWlK4lJTaSF2Ma6TAs
         0rj11UPJqPlyOsO29bMF6q+ZNzafjpHv4ZEprOuHPx9twewVv/O19eKzKP8faKvhOJ/5
         9PBCKtrwhPExRIqMZoDDq+PgKfyDktXCfdO18uKbnlf0ip0xrvnZj0n2BlS4CBcNWDcM
         YSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340471; x=1693945271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOlYcqn8beQHjGoc0Rc5zdI+Fp8S0JCnlA3frimuCzk=;
        b=fPNwnWwPp+X52+pTnBbW5S6A2McGho5Igvdu4auye44NHTiDdsTxX5VYMyXpZh1vVG
         2TLbUcn+St6unbFqF9yZ/xgfqyMSWwjvlxflXecccrkVr4Fntvo5QoaPR4Abo5f2xkSW
         Ny53uYI/EXq8wbCrDYIRH6q+P8GNIL/q5cDhg4r9xOeo7D+8Vcfp5ihCBD0QNJ4z8G3l
         cO4xb1VYKHi/34SCdX+xW45fZ2VGHJLAjJ8LxvoXOQcwIKVUS7fCVI3OnNbRriGnGvbA
         aDxzqZcGvcO2AxJXEZr3FRoVRXI4rPludmREtAlrsIeRnFjHxOrVSqO2ZuAXxCyJoQK2
         rTEw==
X-Gm-Message-State: AOJu0YzzN3yikRyUyPpGaFuqb5Q3ljOy3dFEBy+1f3VvfKDhJu0T24ed
        hrlcJ7wssO/rQyCz/khnyTo+o9zP3aS9j/HySfxBonrARFHditmk/tUObA==
X-Google-Smtp-Source: AGHT+IH2KIgoRggLZTMZmzajJlmhBlCx1wDfnHukX1Z8/CBs4EOept/nxD6OEIylcZqOv7fs6UbIYycFpg0THTHewZU=
X-Received: by 2002:a2e:9290:0:b0:2bd:10ee:7d22 with SMTP id
 d16-20020a2e9290000000b002bd10ee7d22mr213747ljh.51.1693340471248; Tue, 29 Aug
 2023 13:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <ZO48h7c9qwQxEPPA@slm.duckdns.org>
 <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
 <ZO5IuULSCXMe9_pN@slm.duckdns.org> <CAJD7tkYtnhemCLBqFqOVurfWEaCjKtyEM745JYRxFS0r5cpZwQ@mail.gmail.com>
 <ZO5RROsZ1VESCsMG@slm.duckdns.org>
In-Reply-To: <ZO5RROsZ1VESCsMG@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 29 Aug 2023 13:20:34 -0700
Message-ID: <CAJD7tkZn_7ppFB1B1V8tBEw12LXCnEOue2Beq6e19PkUAVHUSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 29, 2023 at 1:12=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 29, 2023 at 12:54:06PM -0700, Yosry Ahmed wrote:
> ...
> > > Maybe leave the global lock as-is and gate the userland flushers with=
 a
> > > mutex so that there's only ever one contenting on the rstat lock from
> > > userland side?
> >
> > Waiman suggested this as well. We can do that for sure, although I
> > think we should wait until we are sure it's needed.
> >
> > One question. If whoever is holding that mutex is either flushing with
> > the spinlock held or spinning (i.e not sleepable or preemptable),
> > wouldn't this be equivalent to just changing the spinlock with a mutex
> > and disable preemption while holding it?
>
> Well, it creates layering so that userspace can't flood the inner lock wh=
ich
> can cause contention issues for kernel side users. Not sleeping while
> actively flushing is an side-effect too but the code at least doesn't loo=
k
> as anti-patterny as disabling preemption right after grabbing a mutex.

I see. At most one kernel side flusher will be spinning for the lock
at any given point anyway, but I guess having that one kernel side
flusher competing against one user side flusher is better competing
with N flushers.

I will add a mutex on the userspace read side then and spin a v3.
Hopefully this addresses Michal's concern as well. The lock dropping
logic will still exist for the inner lock, but when one userspace
reader drops the inner lock other readers won't be able to pick it up.

>
> I don't have a strong preference. As long as we stay away from introducin=
g a
> new user interface construct and can address the noticed scalability issu=
es,
> it should be fine. Note that there are other ways to address priority
> inversions and contentions too - e.g. we can always bounce flushing to a
> [kthread_]kworker and rate limit (or rather latency limit) how often
> different classes of users can trigger flushing. I don't think we have to=
 go
> there yet but if the simpler meaures don't work out, there are still many
> ways to solve the problem within the kernel.

I whole-heartedly agree with the preference to fix the problem within
the kernel with minimal/none user space involvement.

Thanks!
