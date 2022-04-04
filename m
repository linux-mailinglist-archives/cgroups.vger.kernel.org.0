Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC844F1D1F
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382492AbiDDVaH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 17:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379501AbiDDRQo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 13:16:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F513F77
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 10:14:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so4219988pfa.10
        for <cgroups@vger.kernel.org>; Mon, 04 Apr 2022 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9G0a90Ep/Bz5OOoDZhbBO26Y5kHqZZt4pCiJoHTyyw4=;
        b=dbsKFhi7Qrtq/Rq9OZDWGOfaDFXlehFA5Dvy8IhvRrLeU0T4wP85YNiBqYaU9XUcaR
         eUVN69DjjMnifijLW25m+YKzc/I0odbx2wV1tPCdU+KBxslLKSqFwvkD4pVvTF50IUQa
         +QaIH7XLXTeNMaw7eguYI4S17J2ihOJkhUqbubb0twU+NF44WOBEs4KEZwuyI2cQ1OWg
         DjvmsdfzKYHIffEOCxLZBCluUxcZ7//A9FO1lCcnt+AcAMATqSVWgw8Xu0BUE/Jl7VQw
         rtUspdPnkhbICsCmzGy+IMML4dl30xRIEscdXvevjnn2tvTt7h6mqDEkiKuyZ7Z/UY9Z
         FpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9G0a90Ep/Bz5OOoDZhbBO26Y5kHqZZt4pCiJoHTyyw4=;
        b=m9eW4YVBv04M0lwEQ4RTBLd+zozsP5X8BxPpzwr/pBSqXt6ZOPScJaLKU/4DIsuaiH
         yIS63M4xMWh74Jd6dQhdCsLwmhiSOitGv98jiyInq240+rfdZrW0TNqvgW3qE3+++n69
         ZfypRAdFB+gHCSVSilXhqDNBZbNxftXnw6e1kuizC6sgoEf+bE2kmeaD+dtLBHThuR25
         h0mPbkHbEXzvyNKEc7kEJsKmDWERoFtQgsWelSdGVO9hHS52qrfymiLe+ov0erHISyWl
         a54Uvuxji/zBr7/ASYmVRqewSg7ATjPs4GGoBqHQvEXpmyCwGIGwD54RlFiZlG1lZAX/
         iFqw==
X-Gm-Message-State: AOAM533SQlQzWFO6wy443Z/kd9oHJOe40awg3V3j7HDo8+kwl7Ty57tx
        NGzbarggATIorCWYzikyAPa/IxyIZ6YpLuL9JtOUrw==
X-Google-Smtp-Source: ABdhPJwExpdEGnyWDK69sFVEHi5zDLcGulVNorqTNcKNzqhC2Qfdem89xzMoC4eHonTJ3Nemx/2dgOoEjbxz5HBpdFw=
X-Received: by 2002:a05:6a00:bd1:b0:4fa:a5d7:c082 with SMTP id
 x17-20020a056a000bd100b004faa5d7c082mr520472pfu.85.1649092487680; Mon, 04 Apr
 2022 10:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <YkdrEG5FlL7Gq2Vi@cmpxchg.org> <243A0156-D26A-47C9-982A-C8B0CDD69DA2@linux.dev>
 <Ykdz7fiMFZeFltYy@cmpxchg.org>
In-Reply-To: <Ykdz7fiMFZeFltYy@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Apr 2022 10:14:36 -0700
Message-ID: <CALvZod466jLN8Bb67X9=iF5TvjOo-oEsHA-mGhpHnywGCP+WvA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 1, 2022 at 2:51 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 01, 2022 at 02:21:52PM -0700, Roman Gushchin wrote:
> > > On Apr 1, 2022, at 2:13 PM, Johannes Weiner <hannes@cmpxchg.org> wrot=
e:
> > >
> > > =EF=BB=BFOn Fri, Apr 01, 2022 at 11:39:30AM -0700, Roman Gushchin wro=
te:
> > >> The interface you're proposing is not really extensible, so we'll li=
kely need to
> > >> introduce a new interface like memory.reclaim_ext very soon. Why not=
 create
> > >> an extensible API from scratch?
> > >>
> > >> I'm looking at cgroup v2 documentation which describes various inter=
face files
> > >> formats and it seems like given the number of potential optional arg=
uments
> > >> the best option is nested keyed (please, refer to the Interface File=
s section).
> > >>
> > >> E.g. the format can be:
> > >> echo "1G type=3Dfile nodemask=3D1-2 timeout=3D30s" > memory.reclaim
> > >
> > > Yeah, that syntax looks perfect.
> > >
> > > But why do you think it's not extensible from the current patch? We
> > > can add those arguments one by one as we agree on them, and return
> > > -EINVAL if somebody passes an unknown parameter.
> > >
> > > It seems to me the current proposal is forward-compatible that way
> > > (with the current set of keyword pararms being the empty set :-))
> >
> > It wasn=E2=80=99t obvious to me. We spoke about positional arguments an=
d then it wasn=E2=80=99t clear how to add them in a backward-compatible way=
. The last thing we want is a bunch of memory.reclaim* interfaces :)
> >
> > So yeah, let=E2=80=99s just describe it properly in the documentation, =
no code changes are needed.
>
> Sounds good to me!

To summarize for next version:

1) Add selftests.
2) Add documentation for potential future extension, so whoever adds
those features in future should follow the key-value format Roman is
suggesting.

Yosry, once we have agreement on the return value, please send the
next version resolving these three points.
