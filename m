Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD84F7B0DCA
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjI0U57 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0U57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 16:57:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82644122
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:57:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1596415266b.2
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695848276; x=1696453076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdc/ydgmgNMsNbxoUCD1oiRqxp/qtZNwRhbMfUlTHN4=;
        b=fqq3HNnwuzMATEopc63sstUn0Qc5YGE0qSuQB825KGT7fWnOaEicczs7piYF2mANvd
         KHtooO1Pqt8kMpjy4PN1us6/RWBqhy1rqYCItsdycaMfnTKMQdyfRddFQcSOr5U2EvVD
         VT8oALeMTUGVGdiuIPR/uM3heC30t+I/LyxiNgfFwbzxUqQT6ogXeKxd4qOOZoJ7wQA2
         nobh3wZl70JsdUurdMeYmx1ox4AzaQlO4NmjB0b9rNYI++BAexoLBQowaCiIqsmjiaYu
         qUHqTUWNM0uufc2o+rFmHYE32445/kd7dh+DQdskibjweRrnSHrAr2Cy3N/l9sNzsFLh
         baWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848276; x=1696453076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdc/ydgmgNMsNbxoUCD1oiRqxp/qtZNwRhbMfUlTHN4=;
        b=i6IW9aIrSjPsDamF6LEgvvMrUkHIc3SpcTC7/RmiVhHDnRg4z1kTO8TA8US7OPnjos
         cORLj9coi5Mr/tYLFNFJGcVWUJLwJIVoz8UfHzRl1r4qekX9hBVRVwjn8dvdJK1ArwmB
         cHaINqhCUSGSL+XRvAZpUSoIf0OEZvErKO+r0vW+2oQH/T5Qx6DAYCDGc1OEbEYE6/75
         C/dKZPJjJKTyS2pZnYkOcAL5js126Mg5TOL4Zx8M7T6OR8agCik9kly2Dc3zDmyBFfMO
         CbdPNvJM8mmndHHBLLbOzrIOoFINvA2qQU6mYqzmcJJ5KhTF/UENasg9B81fmD6s1cav
         BWBw==
X-Gm-Message-State: AOJu0YyouJFTnCZ1jg9EEAXWoiuT0cRUEA81s1926uWFEtte4FhnfbrP
        4FlZQ9sA72/IPpgGCuGfKBzcmVyrbVh5gEClV1zFhA==
X-Google-Smtp-Source: AGHT+IE6ya4aiuqCKeFX4eCkv0dpQdxRXXuKr7lp4BmNdbwAhjzQ6khsMOEbO2k9fxgBuTyCFU8e4AIwnh7la5ovSiw=
X-Received: by 2002:a17:906:cc57:b0:99c:6825:ca06 with SMTP id
 mm23-20020a170906cc5700b0099c6825ca06mr2473711ejb.12.1695848275848; Wed, 27
 Sep 2023 13:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com> <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com> <20230927205153.GB399644@cmpxchg.org>
In-Reply-To: <20230927205153.GB399644@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 27 Sep 2023 13:57:17 -0700
Message-ID: <CAJD7tkbHsmM9tVTwv2Ve7Ekj_bgcZxVgpXKG8upNtZjAkimeZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 1:51=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Sep 25, 2023 at 01:17:04PM -0700, Yosry Ahmed wrote:
> > On Tue, Sep 19, 2023 at 10:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > +                       is_empty =3D false;
> > > +       }
> > > +       zswap_pool_put(pool);
> > > +
> > > +       if (is_empty)
> > > +               return -EINVAL;
> > > +       if (shrunk)
> > > +               return 0;
> > > +       return -EAGAIN;
> > >  }
> > >
> > >  static void shrink_worker(struct work_struct *w)
> > >  {
> > >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> > >                                                 shrink_work);
> > > -       int ret, failures =3D 0;
> > > +       int ret, failures =3D 0, memcg_selection_failures =3D 0;
> > >
> > > +       /* global reclaim will select cgroup in a round-robin fashion=
. */
> > >         do {
> > > -               ret =3D zswap_reclaim_entry(pool);
> > > +               /* previous next_shrink has become a zombie - restart=
 from the top */
> >
> > Do we skip zombies because all zswap entries are reparented with the ob=
jcg?
> >
> > If yes, why do we restart from the top instead of just skipping them?
> > memcgs after a zombie will not be reachable now IIUC.
> >
> > Also, why explicitly check for zombies instead of having
> > shrink_memcg() just skip memcgs with no zswap entries? The logic is
> > slightly complicated.
>
> I think this might actually be a leftover from the initial plan to do
> partial walks without holding on to a reference to the last scanned
> css. Similar to mem_cgroup_iter() does with the reclaim cookie - if a
> dead cgroup is encountered and we lose the tree position, restart.
>
> But now the code actually holds a reference, so I agree the zombie
> thing should just be removed.

It might be nice to keep in shrink_memcg() as an optimization and for
fairness. IIUC, if a memcg is zombified the list_lrus will be
reparented, so we will scan the parent's list_lrus again, which can be
unfair to that parent. It can also slow things down if we have a large
number of zombies, as their number is virtually unbounded.
