Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186C86F6FD6
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 18:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEDQW0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 12:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDQWZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 12:22:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499559DB
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 09:22:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so497753f8f.3
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683217340; x=1685809340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsk62XwjD8JjQowiDifvFLPW2uokrx3QTotNr7V9c/A=;
        b=6NGLeWA30bcHwOn4ghW5tWONP3tIeVXLoIAwGSOlF40SYraEbii/SQhzrJIho8Ivb6
         Hpkk6vNh9E5t/cw05230dMqe0m+/H6ie+h8h31p+GrZCCgkTxJbXyMjFGjZkhz3bV6dG
         vSjHZI0HIdPfHSmqobGMchd9amOB1v/ceZjRFhmXUrjm4M4cWFnS99GIAMxh/gj5liXv
         4tj0lHTy81/1Wbpb012EhMfXD9LTcX1fI/Tm4TbQO8kVMc6YZQrPrde4R4+RJt2s2OWX
         VOgAgJHhDqiDK83jUMMdRLdqlv9RhFWhmjzvFXehDDJFCUBnHdRe0JsvmE5LyyU2xx97
         symQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217340; x=1685809340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsk62XwjD8JjQowiDifvFLPW2uokrx3QTotNr7V9c/A=;
        b=aBqeNLrHj9pk8Kyvmsz2vliZgon3AJ8XJX979FQcYNVCE/WEovjwgZ5ELZb319NxX7
         iIeNcqW6LVY0ZAPrFJqgOLINi9cTL0HqIVWi4R4Xg9wKL8Lh3pDmKFiP0+/P/dZRXFlo
         zFM/D+YSHE3Sil04W4ah/lG8Fozqh6kjT3Z3QhLG67DCWS2671jiGcwX9NHmWys474AV
         Qa3pVXhuNv+SfqReDk2IryrI9Tt5MqF+B/pmqUF4WWJAUPxld0L6o1723rmu+WCMxlDi
         dZGcreS/iXiUuZE6fcFsBsvL+35H7YgqQPqFAfyNW7JjM08ybMLcTnUrP2/dlQqHhJEC
         bKPA==
X-Gm-Message-State: AC+VfDwDbQEgApDyQEIihgKmyMJObJgZHOdvopvoo+TnkKutJKf7x3Jp
        cWt5EWh1/CnkA6iIVD0VSbJwtr2tayKvz38d+plCJg==
X-Google-Smtp-Source: ACHHUZ6W7LU6+7sJ+JIBNyUc93OdZBrKmPb6kgAM40ObN2WRJqo/GOAU298MN4AghxYk5WmY9UXzE3DSoSxQENd3Lcc=
X-Received: by 2002:a05:6000:120a:b0:2fc:7b62:f459 with SMTP id
 e10-20020a056000120a00b002fc7b62f459mr2840579wrx.32.1683217340407; Thu, 04
 May 2023 09:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-36-surenb@google.com>
 <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz> <CAJuCfpGsvWupMbasqvwcMYsOOPxTQqi1ed5+=vyu-yoPQwwybg@mail.gmail.com>
 <ZFNoVfb+1W4NAh74@dhcp22.suse.cz>
In-Reply-To: <ZFNoVfb+1W4NAh74@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 May 2023 09:22:07 -0700
Message-ID: <CAJuCfpGUtw6cbjLsksGJKATZfTV0FEYRXwXT0pZV83XqQydBgg@mail.gmail.com>
Subject: Re: [PATCH 35/40] lib: implement context capture support for tagged allocations
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 4, 2023 at 1:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-05-23 08:24:19, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 01-05-23 09:54:45, Suren Baghdasaryan wrote:
> > > [...]
> > > > +struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, si=
ze_t size)
> > > > +{
> > > > +     struct alloc_call_ctx *ac_ctx;
> > > > +
> > > > +     /* TODO: use a dedicated kmem_cache */
> > > > +     ac_ctx =3D kmalloc(sizeof(struct alloc_call_ctx), GFP_KERNEL)=
;
> > >
> > > You cannot really use GFP_KERNEL here. This is post_alloc_hook path a=
nd
> > > that has its own gfp context.
> >
> > I missed that. Would it be appropriate to use the gfp_flags parameter
> > of post_alloc_hook() here?
>
> No. the original allocation could have been GFP_USER based and you do
> not want these allocations to pullute other zones potentially. You want
> GFP_KERNEL compatible subset of that mask.

Ack.

>
> But even then I really detest an additional allocation from this context
> for every single allocation request. There GFP_NOWAIT allocation for
> steckdepot but that is at least cached and generally not allocating.
> This will allocate for every single allocation.

A small correction here. alloc_tag_create_ctx() is used only for
allocations which we requested to capture the context. So, this last
sentence is true for allocations we specifically marked to capture the
context, not in general.

> There must be a better way.

Yeah, agree, it would be good to avoid allocations in this path. Any
specific ideas on how to improve this? Pooling/caching perhaps? I
think kmem_cache does some of that already but maybe something else?
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
