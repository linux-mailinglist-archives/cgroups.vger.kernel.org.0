Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0A52F08A
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351647AbiETQ0M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351586AbiETQZx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 12:25:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43D15A25
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 09:25:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id wh22so16407494ejb.7
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUaa/CsIoXFhGcqQomBYha0KA+E1xpoSdaSoOErgusY=;
        b=sCdCdZqIB2fM6C3/IMxJnyMHv4TxKGmIAEibbdWMh6FRbyWFI9mTEtryWRZ/NF+hj8
         +Hx7jY6REjkdGsBVNwZIlsBAmuMkblQlokQialFoP0r3E+mVoJ7qGv/cmH27SzZH0S3E
         6LoxOjAbQe+XtYP+GErjofpGVizVrpa3tPrxVs+yqbwCv/s6FVcSIgxyZOKq/Unt6sfK
         WQdH0KeBkcXcGDUDuTf8vX6Et8/Yi9aMTfXHIESge8rquWo4PxOSekV4zJTp0tvovfMW
         u6nTEG2KKtXD08jklErYVdrtfiimeio1bUddW1+xIx6fvJXFqqsrZgzOoeJe1LhQ/lrW
         jHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUaa/CsIoXFhGcqQomBYha0KA+E1xpoSdaSoOErgusY=;
        b=ojiifPJFZxAPBlNG62LKmXzaHjQ2R1RIRAPe+1X7yviqnORcTW9E9UBCeRxx4RiKxZ
         v2R8ei8uLdLAG1dNcJ2okpBR1UIQJioMs53I9/OLnhm9ip8khKglSidaEVZbll97odi9
         tMiWaN5vg//nxmejLJWlhLVlgpxPcgHG0J6YKOe7epmCL/ucZOKZpdXG07Qf6HodPo0w
         p6U+xScuhH6jEIg++w3jHvBUna1xfhoco5JZZxfHguXY7qkfd48qFvBy521TnNyKt8RY
         et+/5vOKqMrOeGri1+jo30b8XWUKQYE7hVa3TAEJte9P2jIa+Fp6/mBwK1xwxZBdCmSq
         /3Mw==
X-Gm-Message-State: AOAM532GiqqNpGgXV4Z+8S/SMHF7CyrjRQZ4unsYIdlB8iq3GKRas8A7
        e604liKE2u1S65OCK2ixWV1FKxXBqzUMi86XOAchHQ==
X-Google-Smtp-Source: ABdhPJzp/NHzceLMjs5KyttxLo22ikbB+moAIzlm/g7LpDw857XHy/sDkHqgW7kFrYOz58Ub2ZX5aqSsTj4pK+KZ3Kc=
X-Received: by 2002:a17:907:9813:b0:6fa:78b0:9be2 with SMTP id
 ji19-20020a170907981300b006fa78b09be2mr9585859ejc.159.1653063949975; Fri, 20
 May 2022 09:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org> <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
 <YodHjYlMx1XGtM2+@slm.duckdns.org>
In-Reply-To: <YodHjYlMx1XGtM2+@slm.duckdns.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 20 May 2022 09:25:38 -0700
Message-ID: <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, May 20, 2022 at 12:47 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> > Thanks for your suggestion. This almost works. "dmabuf" as a key could
> > work, but I'd actually like to account for each heap. Since heaps can
> > be dynamically added, I can't accommodate every potential heap name by
> > hardcoding registrations in the misc controller.
>
> On its own, that's a pretty weak reason to be adding a separate gpu
> controller especially given that it doesn't really seem to be one with
> proper abstractions for gpu resources. We don't want to keep adding random
> keys to misc controller but can definitely add limited flexibility. What
> kind of keys do you need?
>
Well the dmabuf-from-heaps component of this is the initial use case.
I was envisioning we'd have additional keys as discussed here:
https://lore.kernel.org/lkml/20220328035951.1817417-1-tjmercier@google.com/T/#m82e5fe9d8674bb60160701e52dae4356fea2ddfa
So we'd end up with a well-defined core set of keys like "system", and
then drivers would be free to use their own keys for their own unique
purposes which could be complementary or orthogonal to the core set.
Yesterday I was talking with someone who is interested in limiting gpu
cores and bus IDs in addition to gpu memory. How to define core keys
is the part where it looks like there's trouble.

For my use case it would be sufficient to have current and maximum
values for an arbitrary number of keys - one per heap. So the only
part missing from the misc controller (for my use case) is the ability
to register a new key at runtime as heaps are added. Instead of
keeping track of resources with enum misc_res_type, requesting a
resource handle/ID from the misc controller at runtime is what I think
would be required instead.

> Thanks.
>
> --
> tejun
