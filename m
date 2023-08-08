Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DA77451E
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjHHShO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjHHSgy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 14:36:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D111F7A;
        Tue,  8 Aug 2023 09:28:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bba04b9df3so51305595ad.0;
        Tue, 08 Aug 2023 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512091; x=1692116891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n17U5qh0OrK3kvBv9V9L+D0ClJ7otAlPJK+8puyUKR0=;
        b=op5CWRxvHjjyEtH3oLTE+U9+SdV4muy6/SahtYDfPvEw7u7NCepCKVp4NvTaueKPBY
         DXR02edJ/mpI7koxuloBEu5VhrqBG7s0PV4u3njEhKiEBoet+IvTeexpCZfPfXCasMqF
         oC8MXWdotPpTILLtEp4leXwUSQzmosI67ghXcBrus2OsUR331ISsDWo7eVHMZGQ31nig
         cLl/BLQPTM+DtOOM23qw2NLnpTMsGiPctZj+X8Bu6Mgy1qwpXzxq+YVjPMVaDQ4VNdNg
         CDCctlX7pActT8jlkHPq4I0Otu11HlWkbn0M4PerKJ0zzzlcaqFwRfM074WVMZugSik3
         j9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512091; x=1692116891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n17U5qh0OrK3kvBv9V9L+D0ClJ7otAlPJK+8puyUKR0=;
        b=AkW7DQi/fbKA828RLfr5Io45pR5oEPH+jwKFrpaHaElCfjY8f9HLZ+WRuV7xV+xMc4
         aRsNJFBPOq659Hh4M3XYwdETDpgdNQNtBjenMXKk8LkVXaeupMbXr5oDPXJCNyopEyNd
         fXxX9JkEcCDBTHPz7eA96m0C2rId8fRLlrOnCFvdb8gc6XfN5jLpGhvnTsmh2PpXrJ7w
         1PHh1Faf7mqjc+Ev850/5wfDEIqUeTXNcAOM6kKRRy37fRXTdSQ08VPrRzfTtFa7hzvL
         mSf3N5mSav1HJydpEwlxuMKasiCFga1vGj0mFBNNXgNqGBwp4SiGboaNADbbq2wgMBmG
         N3vw==
X-Gm-Message-State: AOJu0YzBJf+uHc1/OcfUTfctAke2QVqYyz89NZMCBlHJifRl+UApaUKZ
        HYTBvqpkQQi2dBvxcw10PTorp4MEdLGiL9Mhrd4XsO3aVeI=
X-Google-Smtp-Source: AGHT+IG30KmbMbbDaYtdMmOkxgv/uetQA+YC5M2Co9rM0xOLArq1znaHye1BkMKO/WBSoz7ZRimYeFGXyPEKt5HXhuA=
X-Received: by 2002:a05:6870:c1cc:b0:1bb:89b1:77b7 with SMTP id
 i12-20020a056870c1cc00b001bb89b177b7mr15189629oad.16.1691496560111; Tue, 08
 Aug 2023 05:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230808022229.1560559-1-xiongwei.song@windriver.com> <ZNG9vwg1K6fn1SvN@P9FQF9L96D>
In-Reply-To: <ZNG9vwg1K6fn1SvN@P9FQF9L96D>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 8 Aug 2023 20:08:57 +0800
Message-ID: <CAEVVKH-hdpVwLZMzW41fvvwUDGAYpsUHwfOf=_VM9OuDrmmkcg@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     xiongwei.song@windriver.com, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 8, 2023 at 12:00=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com wro=
te:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > No any output from kmem.slabinfo, which is not friendly. Adding
> > tips for it.
> >
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > ---
> >  mm/memcontrol.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e8ca4bdcb03c..58d3bd93890b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5002,10 +5002,8 @@ static ssize_t memcg_write_event_control(struct =
kernfs_open_file *of,
> >  #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CON=
FIG_SLUB_DEBUG))
> >  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
> >  {
> > -     /*
> > -      * Deprecated.
> > -      * Please, take a look at tools/cgroup/memcg_slabinfo.py .
> > -      */
> > +     seq_puts(m, "This file is deprecated.\n"
> > +             "Please use tools/cgroup/memcg_slabinfo.py, which is in k=
ernel source.\n");
>
> It'll break the ABI.
> The only possible option here is to use WARN_ON_ONCE(), which will print =
once to dmesg.
> But honestly I'm not sure we need it.

Ok, thanks for the comments.

>
> Thanks!
>
