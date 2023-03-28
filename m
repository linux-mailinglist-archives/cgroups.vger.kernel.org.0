Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713D06CCADB
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC1TnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjC1TnK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 15:43:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263781A7
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:43:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so54099551edd.12
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680032586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqIPDr+ZqfoCi8eQc3DTNr+ThF98a/RBvzrvNFqWYDM=;
        b=TIEXaRQDBAZ6mBWE2R4TELhNaijNMDedZH3kg6n0ljtndAxJLXXqyFQwcErH6B46Lz
         U9BN+2qoq3bDs+Ypbo1k5NzI/RQIygK7ia03C7cfrRO0ByWfBXsdRCT0alHvfQTfmvRe
         qv9IocyC7Cjb3idOoIKKeNX5YVur0irro0khGXutbTnhV67ua5rmPZ8USHumeZuOnxd8
         bw+LUtnZMfNIRTh+++D2tITNO4f5XHgKLCv401nXpXS49KzLZKP/0ycEI4wvThEYgq34
         SdVY6fUmkfV2iCF/Uacl+jKfcVLSr1puNKsWanMsSlWfcXyo+ZpeNqbzs0La62nvhfVM
         xa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqIPDr+ZqfoCi8eQc3DTNr+ThF98a/RBvzrvNFqWYDM=;
        b=jBXzfOTKqgK4NaiaWaDaiDsrxYCj2H/f+S0qA8PODR3JLh75P9NQ9rduEb3t4JbGoE
         7jrRB7kO+sCd8ng68/82cH1YVGunOZGf8a+/CsiZu1fKjTSfUW4+ZiyW3qK5UqQIqd8F
         EBWy48d8hTKq36CgvnwomsUOFmLXYaZtcNNMjKi/mf09+X3SawhbIetm4/VsGQcw74JZ
         5JZXgHSTTji4zIMX+ccmNAN1dbfHRokYheq+m9XX5PVvHTz9LsrU80sAxx3Qjbj0P3+3
         zCU+1gEWLh5eJfmHc0tRGOa5RgBT2y2OwK+l3jV+daPq7bFBt7HZ+pN1neUD3+6h7WqA
         pHsw==
X-Gm-Message-State: AAQBX9fwOiYxF55mr7VYGFzm7vIDClEcrRwPRNmFn1h5kA1Yf6IHTv0n
        BX6BZO2Gf1D5Fqal8LAqha8k44f+OdUrVek+qJKrCQ==
X-Google-Smtp-Source: AKy350Y+r8YQubYTs8R7PJEitaPs1q0OlTz1iemnZQ7KI+3/VnM/MXrQyknZBxEGhPVmnt+/5hUtEtoV/kv4VWDou8E=
X-Received: by 2002:a50:a444:0:b0:500:5463:35de with SMTP id
 v4-20020a50a444000000b00500546335demr8511392edb.8.1680032586465; Tue, 28 Mar
 2023 12:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com> <20230328141523.txyhl7wt7wtvssea@google.com>
 <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
 <CALvZod4Gsngc6MjXdk4s5+ePVjsgcVppdRmsQovN6gSrxzdbfA@mail.gmail.com> <CAJD7tkb_YA3fvo3LgCzR+X-b-r-AmAR68hNR=xT7B6TJfBa54A@mail.gmail.com>
In-Reply-To: <CAJD7tkb_YA3fvo3LgCzR+X-b-r-AmAR68hNR=xT7B6TJfBa54A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 12:42:30 -0700
Message-ID: <CAJD7tkYbZKikn8VEzuuCL9pPiD_PX1gXdK7r9v8q-skKPBYf2w@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
To:     Shakeel Butt <shakeelb@google.com>
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

On Tue, Mar 28, 2023 at 12:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 28, 2023 at 12:28=E2=80=AFPM Shakeel Butt <shakeelb@google.co=
m> wrote:
> >
> > On Tue, Mar 28, 2023 at 11:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > [...]
> > > > > +     if (atomic_xchg(&stats_flush_ongoing, 1))
> > > >
> > > > Have you profiled this? I wonder if we should replace the above wit=
h
> > > >
> > > >         if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats=
_flush_ongoing, 1))
> > >
> > > I profiled the entire series with perf and I haven't noticed a notabl=
e
> > > difference between before and after the patch series -- but maybe som=
e
> > > specific access patterns cause a regression, not sure.
> > >
> > > Does an atomic_cmpxchg() satisfy the same purpose? it's easier to rea=
d
> > > / more concise I guess.
> > >
> > > Something like
> > >
> > >     if (atomic_cmpxchg(&stats_flush_ongoing, 0, 1))
> > >
> > > WDYT?
> > >
> >
> > No, I don't think cmpxchg will be any different from xchg(). On x86,
> > the cmpxchg will always write to stats_flush_ongoing and depending on
> > the comparison result, it will either be 0 or 1 here.
> >
> > If you see the implementation of queued_spin_trylock(), it does the
> > same as well.
>
> Interesting. I thought cmpxchg by definition will compare first and
> only do the write if stats_flush_ongoing =3D=3D 0 in this case.
>
> I thought queued_spin_trylock() was doing an atomic_read() first to
> avoid the LOCK instruction unnecessarily the lock is held by someone
> else.

Anyway, perhaps it's better to follow what queued_spin_trylock() is
doing, even if only to avoid locking the cache line unnecessarily.

(Although now that I think about it, I wonder why atomic_cmpxchg
doesn't do this by default, food for thought)
