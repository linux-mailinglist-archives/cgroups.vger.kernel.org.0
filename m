Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4335F7ADDA1
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjIYRL7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjIYRL5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 13:11:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6E11F
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 10:11:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso861448366b.2
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695661904; x=1696266704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/hhWT30YqLg2rKDYw/SVPqxcdoluiD8cyVoB8LNRKU=;
        b=BhbFLIYhbToxGSyNhmIR8RyXG8uDpP3SL/ihsVdl2fCTdoC/u3JkUu3jFcM8J9LOVR
         D0IwmB8UB5VHnsFDTQ/cmCpvDwBTgJYK0ZhOno12xXmA8s+MK6OPB5D848e5PNSElx+Y
         ptjSZDGTj7fx91tqgAz2vP1Di68wx5SYSOb/4blCBoY2M1w5lHoYqTQtvPHuolmbHfw1
         BIApqzBaC/dLNjPS4UWVoNmjwOW7XC8tZjQj3Or/ADiCk/S5wezNBFfMEPRQqDu35vL0
         mxxfPQpvZCylecGQZi+WKUyq2/9L+Tp6TVjNMwE+h50ji7lwrUuLuDKFIsetsQ90Me+e
         nADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661904; x=1696266704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/hhWT30YqLg2rKDYw/SVPqxcdoluiD8cyVoB8LNRKU=;
        b=Ecibd0NDhBP56BxHHtwDS9MTPoDvHmlS5G1kO+7eD9MJVJnZVLO4B4myNmR67Q0ilb
         dVSOAqMaBh/CCybAB6Y3Hap3i+Ja/Je7f2sxH+/PUR9zehcIq8AoJO7Yr8j2h3/0hM9S
         /LI8k8mdWcMOIu60LiOuq5jC43RMcz5KcPdlH/BZFOPjlxXDMKxRWtLMGPbbwBx+bvqV
         yNmXQip3rMRr4+w5PQY3ueNpQl4kWjEk2MT3LqWTVVNUqmzCRhqaS5U1l+8J/UruBwpU
         Iub33HMBHVkIUg+M/NyKof9MlMCbGHIwvQhUj50BK5tiGyRmYhruKerC1zCLCA6f8SgO
         daSg==
X-Gm-Message-State: AOJu0Yz/YCu7BzdV9Duftc4F+aEY8X7b0DKdxYGAhnZoi0huC/UHYFhi
        bGSV4fl4O74mP/JNfzrMpFrsWfs/0WcWdMXTFLjgLQ==
X-Google-Smtp-Source: AGHT+IHxGHsl4fbZlvFzA9O7Txe+gu98zwtJVfYdbeIxZvboXX+P0miQrKoiw4gPdaoz5mGEa0wc4CVeBercB/7xDI0=
X-Received: by 2002:a17:906:25d:b0:9ae:587a:e5ce with SMTP id
 29-20020a170906025d00b009ae587ae5cemr7423657ejl.27.1695661904205; Mon, 25 Sep
 2023 10:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com> <ZRGQIhWF02SRzN4D@dhcp22.suse.cz>
In-Reply-To: <ZRGQIhWF02SRzN4D@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 25 Sep 2023 10:11:05 -0700
Message-ID: <CAJD7tkbWz7mx6mUrvFQHP10ncqL-iVwD4ymHTm=oXW5qGgrZtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates values
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 25, 2023 at 6:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 22-09-23 17:57:38, Yosry Ahmed wrote:
> > While working on adjacent code [1], I realized that the values passed
> > into memcg_rstat_updated() to keep track of the magnitude of pending
> > updates is consistent. It is mostly in pages, but sometimes it can be i=
n
> > bytes or KBs. Fix that.
>
> What kind of practical difference does this change make? Is it worth
> additional code?

As explained in patch 2's commit message, the value passed into
memcg_rstat_updated() is used for the "flush only if not worth it"
heuristic. As we have discussed in different threads in the past few
weeks, unnecessary flushes can cause increased global lock contention
and/or latency.

Byte-sized paths (percpu, slab, zswap, ..) feed bytes into the
heuristic, but those are interpreted as pages, which means we will
flush earlier than we should. This was noticed by code inspection. How
much does this matter in practice? I would say it depends on the
workload: how many percpu/slab allocations are being made vs. how many
flushes are requested.

On a system with 100 cpus, 25M of stat updates are needed for a flush
usually, but ~6K of slab/percpu updates will also (mistakenly) cause a
flush.

>
> > Patch 1 reworks memcg_page_state_unit() so that we can reuse it in patc=
h
> > 2 to check and normalize the units of state updates.
> >
> > [1]https://lore.kernel.org/lkml/20230921081057.3440885-1-yosryahmed@goo=
gle.com/
> >
> > v1 -> v2:
> > - Rebased on top of mm-unstable.
> >
> > Yosry Ahmed (2):
> >   mm: memcg: refactor page state unit helpers
> >   mm: memcg: normalize the value passed into memcg_rstat_updated()
> >
> >  mm/memcontrol.c | 64 +++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 51 insertions(+), 13 deletions(-)
> >
> > --
> > 2.42.0.515.g380fc7ccd1-goog
>
> --
> Michal Hocko
> SUSE Labs
