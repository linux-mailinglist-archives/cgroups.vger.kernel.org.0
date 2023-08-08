Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99210774351
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHHSBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjHHSBC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 14:01:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463C12597;
        Tue,  8 Aug 2023 09:28:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686bea20652so5799122b3a.1;
        Tue, 08 Aug 2023 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512029; x=1692116829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n17U5qh0OrK3kvBv9V9L+D0ClJ7otAlPJK+8puyUKR0=;
        b=R9MM9qtcdWK6ALzoyjStuJ1cKn4gHm0nKPRoq9v6WU//494PvRCVoizlwxpSB7Drq5
         PkpAsBRdO6kebLLBV1eO3x8N1gVnQMrZ96KIGwypJXK3mt5n4XqxY2L9ouNEbcmUSMdQ
         VW6eL2ZF8SgJCGeyLRpuzQIWeHbFUXs8EnlA3vW4A9XSXKo2pNMZ8gz327rsBfsHFAAM
         vy3gZkSk82+C9oXJjCcdjYS+j3qB0TT4CyfrGWM5SOKmsI+XTdIinG4Cm8a3W5yOZHD1
         +zq6pbc2BaRGIMvcMyxTwne37QIixGwvDkGfIsuWzccKIJzntyBs3XRQlXk3yCjSGQYq
         BIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512029; x=1692116829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n17U5qh0OrK3kvBv9V9L+D0ClJ7otAlPJK+8puyUKR0=;
        b=AjJA/KR4JA2aYQJ7eC7x60Zld7rQsO0OlNDtiFIZ3/h89uFbHWUOlCJ3xiWHthU0CF
         xtY0tyIFz/ftFI7iU2/9JJuSCUi1Dg5wmMS16eQYjenh/tYfTR3Tuu8jKxFs6bbaNdN1
         Wh9YQSOddc35l26rug8a9UtJePhUf7Sub/LEwN4HcKUPFIh3k9C3zXlNVYwJ7U0wGtyH
         QnCYpQvSVUbEFs1+U8ekL0k+VFqYBvVbNgAMjpD92LqyJ8YNbMYcgtivssOFkaJfXkn3
         KwobxuEocJyhH/C3F3NryvFJI7AJoy/+mhSvIBETifZgcsQKKzxnLLXc4jzS7ECbGHWb
         vXHw==
X-Gm-Message-State: AOJu0YwApKHDFPbiqf5krx9/b6DpHqzh0bRFESLX90bFwcufBtKO27ad
        bnvuRmGWuScXu6ibDzOy4IMyd6voPm3L0B46HodYjvPpfUs=
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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
