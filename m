Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887757746F5
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjHHTH5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjHHTHg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 15:07:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E06132CF;
        Tue,  8 Aug 2023 09:29:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63ce8bea776so33642706d6.0;
        Tue, 08 Aug 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512153; x=1692116953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5jWDe5wn3rMqNcO4b1gbGyhh2S63llVj6tRKZkmEkI=;
        b=nClH4hqUumhc5ncPR9uFyByCM7+yqL2gwOXGECS46FF8ujEELgbfd4uWIiHhBoFNIL
         4yh+nl4uQZH7DRUO57TRW3uBOKWYno1/+Sd/gNr7y/TXi2GSZCNvHlaIwzsFgYHQWLoy
         lF+Y185xvk02OEoe66FXDKrKZcdzFCpwg6RISl7S6w4nEgyVsL1o8Fk/pJSfgw61O8jV
         d2eqqsKXFS9/QUm3Fvx9lCagHdooxEYFI8ZGhO24usFkYUUn89xr7tjy3TEmNj11F5Dq
         1lj5NQjGC0nTu5CCaf1dpwfQeZxiGc5ZS6WXPaA6y4poTI44Ep13/OHQ0V66DrhAS9b4
         3EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512153; x=1692116953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5jWDe5wn3rMqNcO4b1gbGyhh2S63llVj6tRKZkmEkI=;
        b=f9oR5zNoeXCRH8BO+p7LZJb+EHGD0bpjW5F2bn6SzWJ+eEW386R4F9B9z5F2Fcw0cH
         MiIpoxP65EnyjzbmAcjXYhFkZ4f5HmZBIRk0SSnKclyh+jLnbQg3A1K9Cun4oa+3CaQP
         EeqrElRAvnSlu7Q887jhVesYdDUSzZcNf97ZEIfiRI36PilZe+drPZQDa1fGj5YumzM2
         BXOQAKZ+jxWBa63jRj56121NQ1wLwEL3k6/3SMKlm6IrP1ybd97usJWx0JgTmnOx70R/
         UmpFNMvK9fcpUKuSgnVJJLL6LYt8jEg0f5DTOGjKFQlI5UxUdp83a1/QtskKMpkdYOKB
         Ft9w==
X-Gm-Message-State: AOJu0YwUdWHRP8KpFfa9hDJvFqWlp5U+EWO6HZTTXrgQOPhAs9pTgMVg
        kn4g7xi0Ue1VvcfVPEwYahoajeKjRyl5ZzAkEN+UjJOdwow=
X-Google-Smtp-Source: AGHT+IEZFGI/rIxXz15siVfjvagtds6b5btNLG1LoGhGH29pxEDr1Yukfrn12+OLzkInX/pKT4mqPFAjHOhXMPGhKwQ=
X-Received: by 2002:a05:6870:c6a2:b0:1bf:1a58:c4f with SMTP id
 cv34-20020a056870c6a200b001bf1a580c4fmr15623793oab.55.1691496528336; Tue, 08
 Aug 2023 05:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230808022229.1560559-1-xiongwei.song@windriver.com>
 <ZNG9vwg1K6fn1SvN@P9FQF9L96D> <ZNHu8m3h3ckn+HeI@dhcp22.suse.cz>
In-Reply-To: <ZNHu8m3h3ckn+HeI@dhcp22.suse.cz>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 8 Aug 2023 20:08:26 +0800
Message-ID: <CAEVVKH-+L8O_wyzj7nueSPN7c0wbG0iUrM61hYXQOm7R7KCjiw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        xiongwei.song@windriver.com, hannes@cmpxchg.org,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 8, 2023 at 3:30=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 07-08-23 20:59:59, Roman Gushchin wrote:
> > On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com w=
rote:
> > > From: Xiongwei Song <xiongwei.song@windriver.com>
> > >
> > > No any output from kmem.slabinfo, which is not friendly. Adding
> > > tips for it.
> > >
> > > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > > ---
> > >  mm/memcontrol.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index e8ca4bdcb03c..58d3bd93890b 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5002,10 +5002,8 @@ static ssize_t memcg_write_event_control(struc=
t kernfs_open_file *of,
> > >  #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(C=
ONFIG_SLUB_DEBUG))
> > >  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
> > >  {
> > > -   /*
> > > -    * Deprecated.
> > > -    * Please, take a look at tools/cgroup/memcg_slabinfo.py .
> > > -    */
> > > +   seq_puts(m, "This file is deprecated.\n"
> > > +           "Please use tools/cgroup/memcg_slabinfo.py, which is in k=
ernel source.\n");
> >
> > It'll break the ABI.
>
> Agreed
>
> > The only possible option here is to use WARN_ON_ONCE(), which will prin=
t once to dmesg.
> > But honestly I'm not sure we need it.
>
> There are systems with panic_on_warn configured. I do not think we want
> those to go down just becasue some random tool tries to read this file.

Thank you for the comments.

> --
> Michal Hocko
> SUSE Labs
>
