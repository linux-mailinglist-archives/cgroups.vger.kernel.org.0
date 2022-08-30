Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1555A5D34
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiH3HpR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiH3HpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 03:45:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292D13D6D;
        Tue, 30 Aug 2022 00:45:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f24so7568623plr.1;
        Tue, 30 Aug 2022 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=96IRGBfcr5J9/GRtulzalfsCYmkGXye7ZPp+1XPMemc=;
        b=ZaLX9vwlsNnUkPUmS7uMrUQJ7sNnSHEUaPBpt/On8HRnJbnSVy/lt90ZvWaMRgor2i
         Ph/rqPOrHM7aPfcaIlY/XJfjku5scFdKAyvPfDJa9ks7ySKCKEO0BxxGEFjnF39umarH
         AMMDGE9E6m0WhJbo6qgTLl1DORwnZX2YcomKG8ffyLrZT/NEXUpoVxGH5gUhiyEZGnqO
         PgRJvnA6bxgbbt2Rwl8MTOpxXAjj8XWtjK+XDpKSlB2qMxtkiIgo/MCR82RisAtQBsxF
         s+vPiZvoPHE8IFRDP2KxneJsozXta4d922Ya/hudxh32NBklMno0ZG7SB1NjCvkqQjAk
         2w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=96IRGBfcr5J9/GRtulzalfsCYmkGXye7ZPp+1XPMemc=;
        b=p7xE4Z9UP8e85Z5S8mGugeXdXmliOKzs2J1mGaCCwz4ftmoxOEmdlQb+ow5uGJnoYK
         bbwurXDFK82bajfdtTcew6YIbQw6Zp5sKjJt3fI+pxj75u8ofqLaxCpGKBM0fb40twTm
         R9eeNQuqd60lPgnPiTtcRcYw6cWQ0KadK8qLQ68YkQ40bTC61k4YxOroSzj9z7og3Q7q
         Ec6E7dIg0TKI+xDbVhCn/aWxzyWCZcUPztn5cES6H72UmFcVpRUQfZFQpOMtWRnCB76h
         D+dw+dGNX3jgxaO0cZlgS15uN4AikCs6Yn8b+TDFX4/2jNpKzfUU8cUiRlqOZohI/bQ1
         G1gw==
X-Gm-Message-State: ACgBeo1fibtVSDGU5ZocMc+kc1SXRMXz7kxtpdH/LDeyLvfwqXq5SFoJ
        O2XFD9w9Q1S5EmTvggVRhv314VZ1C6rjbfaLWTY=
X-Google-Smtp-Source: AA6agR6noNl1l+P36FlTPSu4x5AwF9nDFdZyAMdtD38bTvz9UvkqSMQFtOpGPG8IPIYgs/iv1tdLpMimqKS9+S0bU3I=
X-Received: by 2002:a17:902:a982:b0:170:d646:5851 with SMTP id
 bh2-20020a170902a98200b00170d6465851mr20500615plb.134.1661845514795; Tue, 30
 Aug 2022 00:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220830055949.12640-1-ryncsn@gmail.com> <20220830055949.12640-2-ryncsn@gmail.com>
 <Yw2x6T3xchjpzX7j@dhcp22.suse.cz> <CAMgjq7A+Ju247rC7+fo9jcZpK8rkd0Ou6e=7qzgL4rV3JWBX5w@mail.gmail.com>
 <Yw24cFGTtOZF7Cgw@dhcp22.suse.cz>
In-Reply-To: <Yw24cFGTtOZF7Cgw@dhcp22.suse.cz>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 30 Aug 2022 15:45:01 +0800
Message-ID: <CAMgjq7DTSXavytZUraNy0uGu9D+WngBKXMTjoA4Xha1NEUminA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memcontrol: remove mem_cgroup_kmem_disabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 30-08-22 15:06:57, Kairui Song wrote:
> > Michal Hocko <mhocko@suse.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:45=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue 30-08-22 13:59:48, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > There are currently two helpers for checking if cgroup kmem
> > > > accounting is enabled:
> > > >
> > > > - mem_cgroup_kmem_disabled
> > > > - memcg_kmem_enabled
> > >
> > > Yes, this is a bit confusing indeed!
> > >
> > > > mem_cgroup_kmem_disabled is a simple helper that returns true if
> > > > cgroup.memory=3Dnokmem is specified, otherwise returns false.
> > > >
> > > > memcg_kmem_enabled is a bit different, it returns true if
> > > > cgroup.memory=3Dnokmem is not specified and there is at least one
> > > > non-root cgroup ever created. And once there is any non-root memcg
> > > > created, it won't go back to return false again.
> > > >
> > > > This may help improve performance for some corner use cases where
> > > > the user enables memory cgroup and kmem accounting globally but nev=
er
> > > > create any cgroup.
> > > >
> > > > Considering that corner case is rare, especially nowadays cgroup is
> > > > widely used as a standard way to organize services.
> > >
> > > Is it really that rare? Most configurations would use a default setup=
, so
> > > both MEMCG enabled and without nokmem on cmd line yet the memory
> > > controller is not enabled in their setups.
> >
> > Actually I don't have too much confidence saying that as well... but
> > AFAIK, almost all distros will create a few sub cgroup on boot by the
> > init (eg. openrc, finit, systemd).
>
> Yeah, but do they enable the memory controller as well? Unless I am
> missing something this will require at least one memcg enabled cgroup to
> be created.

Systemd enable memory controller by default since ver 238 from 2018,
but I'm not sure about the others.
Now I think I was wrong about the assumption, will be sure to do more
homework next time.

And thanks for the review!
