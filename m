Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20072763AA1
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjGZPPz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjGZPPl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 11:15:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1010F8
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:15:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9540031acso100330671fa.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690384512; x=1690989312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmHtEDaViE9w7v3YPcqZQ4Gg5qZi74veSidbXAx7Uuk=;
        b=Z0sm/6YlFBVHxaxcjSwwX/bHyhr+EAoV9DMvYiCLh1gzjeElQo2oiosipQdXcgFCHC
         Dh4l2DPNInb8wFxoVcaMu053NsAepgd8juJJfi4f77Oq8z0fvgOLujl1esBDHY59v22f
         II4Ew7GK+kdxPpty5uTynOE0fZn80NMl/SqI9jM4NmWlTGldJ0png0oDQtxH5YQ2jU3C
         YHPELzG2W5BDzAJ1G9YhcsCe6V4xvHEGxMVEG09eNkGKoa5TFPuol693V9n79qX3GuTR
         7S9RI4L/pBPsq54wiwxps6KS/O679itw93JRxiFCJQL9iOnmPpwTAZkp5AOvwgnOm/En
         ohrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384512; x=1690989312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmHtEDaViE9w7v3YPcqZQ4Gg5qZi74veSidbXAx7Uuk=;
        b=T0aiQZcKVMW5hL3emY0bIngfHGI5KQPy9hM9+44q+r9qTZy3pokuIkYqYftkYDEIcu
         uIMWJVgv4lyfASjF8bOI73tBM+DF9/6DlIy79Dwxt6unhcDViXwjgKqDQX2CdatoxJgD
         CxR2YF5DRTEtmFjK61KKy6vZh3nyJNbTt/WqVNerMhqnB2UZnbyzN+rxAVRmyhnEFE+t
         xTQVk8TazjjsPhv+sefGez9PdmeMouFsI6orzpMQLHjia1flyji+Gu9AHE3D4cbHUJmR
         wwJtOZbRQX4KBU4VcGu3gPyrmkTgYrKuCY0Go2ELE29l6RuAi2uWBd7qxnUoeeudTtnr
         i9fQ==
X-Gm-Message-State: ABy/qLb0EUwF+UfEq5Z/qItQeXnSrUiEmkvDKACELHVyWEarwh2l58SG
        NZj64+MvGFyrJsTOTSWhg8PYQQaORs+EQRMH8gucDQ==
X-Google-Smtp-Source: APBJJlF4IaV8dMVHGk681fvmuBRGxHf3zOzetRpp5ir2UkpXog21NbZSidd658qxEK0FWvxvGZm3Ws8te1gUkTSCLjk=
X-Received: by 2002:a2e:9d99:0:b0:2b6:e958:5700 with SMTP id
 c25-20020a2e9d99000000b002b6e9585700mr1811458ljj.4.1690384511813; Wed, 26 Jul
 2023 08:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com> <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
 <20230726151315.GB1365610@cmpxchg.org>
In-Reply-To: <20230726151315.GB1365610@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 26 Jul 2023 08:14:35 -0700
Message-ID: <CAJD7tkYS1iSo94WhtDE2GbpTkukaKY3aAKTSaUkGj0K5ifek+A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 26, 2023 at 8:13=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 25, 2023 at 05:36:45PM -0700, Yosry Ahmed wrote:
> > On Tue, Jul 25, 2023 at 5:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > > - Fix a subtle bug where updating a local counter would be missed if =
it
> > >   was cancelled out by a pending update from child memcgs.
> >
> >
> > Johannes, I fixed a subtle bug here and I kept your Ack, I wasn't sure
> > what the Ack retention policy should be here. A quick look at the fix
> > would be great.
>
> Ah, I found it:
>
> > > @@ -5542,19 +5539,23 @@ static void mem_cgroup_css_rstat_flush(struct=
 cgroup_subsys_state *css, int cpu)
> > >                         memcg->vmstats->state_pending[i] =3D 0;
> > >
> > >                 /* Add CPU changes on this level since the last flush=
 */
> > > +               delta_cpu =3D 0;
> > >                 v =3D READ_ONCE(statc->state[i]);
> > >                 if (v !=3D statc->state_prev[i]) {
> > > -                       delta +=3D v - statc->state_prev[i];
> > > +                       delta_cpu =3D v - statc->state_prev[i];
> > > +                       delta +=3D delta_cpu;
> > >                         statc->state_prev[i] =3D v;
> > >                 }
> > >
> > > -               if (!delta)
> > > -                       continue;
> > > -
> > >                 /* Aggregate counts on this level and propagate upwar=
ds */
> > > -               memcg->vmstats->state[i] +=3D delta;
> > > -               if (parent)
> > > -                       parent->vmstats->state_pending[i] +=3D delta;
> > > +               if (delta_cpu)
> > > +                       memcg->vmstats->state_local[i] +=3D delta_cpu=
;
>
> When delta nulls out, but delta_cpu is non-zero... subtle.

Yup, led to a few missed updates, was not trivial to track down :)

>
> This fixed version looks good, please keep my ack :)

Thanks!
