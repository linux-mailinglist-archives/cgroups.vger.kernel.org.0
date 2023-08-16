Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413D477D70E
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 02:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjHPAYU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 20:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbjHPAXw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 20:23:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312AA2114
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 17:23:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso81091cf.1
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692145429; x=1692750229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr6wnngjOfkRJLjnGKEITli6UcKrkyv5fLRjRdWwczo=;
        b=DmLpMxI2Z57pCltekLrtxPdsSCRhtaRsRx6F7jipwCpyI+DI4vQ9TpFFJ146R3hv/i
         bJTtazbPGlZFtbPAAPy9tgD1+OBMkDQMHftLu28qs6QKx9i6rbevc7AOrvCvVIIPNjZL
         MXAo/8+Le+4/IMGGlMO+efTHrebZsw1suOHPCaL9YhMi7djGa8RZE7ryRpmATwuzAB1e
         lK0aDMrJc9NrBe4WKp8o3E2p23tXEpqJ0XQPgwHQ7clyXTOFqs7XDb7azNiAzDIpOKEm
         ftPSgi6paVUxUPygywa60bGtqFzYdPixr0z1OE7qhQyeBABacrkxeV1Rw6WwkCdFwCFy
         FpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145429; x=1692750229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr6wnngjOfkRJLjnGKEITli6UcKrkyv5fLRjRdWwczo=;
        b=PMye64CymInlFkJWSWlrlsiXqc6o7udFIehKFlxa0eDNvbgsCKKjsjrJbh4bCc1Nrx
         FQkDaICG1H309XDYM2IOzp4uXq7zkyKCR4sl8H5gVxC5zLXFrnjJtw9hvb0Cxbxmi7fG
         d6P393iTL+AlIBnF0NPp4XYqnzji65EWnsSvvRVhLro3tCN9MOpYapVF66W3eGsW8ShE
         sFKwOGcE1ojLeNaAkzAFCpQdGQIcDmBc3Qw8YyWCDco9Q32HEEITJyL+2ODwZwQ12GBT
         RkEfZ8XgV1HJjJHoa/jGvkqA/wbjKiZtA1guTq4fOaOz5RKSM85ytkMwOuzW2+aad1hb
         0pew==
X-Gm-Message-State: AOJu0YwXblMWBam2bSnI24mXNkb8mvox3oFATn1Y6LzPNEdy72HTt/JH
        uWIG1Gg1DwKqwP1BMNNmVNPggy4kGB+KOJquVphYDg==
X-Google-Smtp-Source: AGHT+IFklfKFYofmRkEJahy5j2pWJQ3aoudpaKELWl1jMcquiqD5JY5lZA5wEnQ0wKlgn5x3ziqfDjl+dKn+UyisHeY=
X-Received: by 2002:a05:622a:1a06:b0:404:8218:83da with SMTP id
 f6-20020a05622a1a0600b00404821883damr61239qtb.1.1692145429219; Tue, 15 Aug
 2023 17:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
In-Reply-To: <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Aug 2023 17:23:36 -0700
Message-ID: <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
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

+Ivan

On Mon, Aug 14, 2023 at 5:51=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Aug 14, 2023 at 5:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Mon, Aug 14, 2023 at 05:39:15PM -0700, Yosry Ahmed wrote:
> > > I believe dropping unified flushing, if possible of course, may fix
> > > both problems.
> >
> > Yeah, flushing the whole tree for every stat read will push up the big =
O
> > complexity of the operation. It shouldn't be too bad because only what'=
s
> > updated since the last read will need flushing but if you have a really=
 big
> > machine with a lot of constantly active cgroups, you're still gonna fee=
l it.
> > So, yeah, drop that and switch the global lock to mutex and we should a=
ll be
> > good?
>
> I hope so, but I am not sure.
>
> The unified flushing was added initially to mitigate a thundering herd
> problem from concurrent in-kernel flushers (e.g. concurrent reclaims),
> but back then flushing was atomic so we had to keep the spinlock held
> for a long time. I think it should be better now, but I am hoping
> Shakeel will chime in since he added the unified flushing originally.
>
> We also need to agree on what to do about stats_flushing_threshold and
> flush_next_time since they're both global now (since all flushing is
> global).
>

I thought we already reached the decision on how to proceed here. Let
me summarize what I think we should do:

1. Completely remove the sync flush from stat files read from userspace.
2. Provide a separate way/interface to explicitly flush stats for
users who want more accurate stats and can pay the cost. This is
similar to the stat_refresh interface.
3. Keep the 2 sec periodic stats flusher.
