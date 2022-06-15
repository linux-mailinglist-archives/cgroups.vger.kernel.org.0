Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAF54CFF2
	for <lists+cgroups@lfdr.de>; Wed, 15 Jun 2022 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbiFORcS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jun 2022 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357329AbiFORb5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jun 2022 13:31:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017A53A55
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 10:31:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eo8so8987630edb.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3YUx2QLwqjC4yt6Na4HDX+YOsTdcO8b9CpzZpDW+SU=;
        b=SumGg4ML2+ipUmc7XA+lq9lEeAMN0G+c1nkIb8xlQdeSVIXK7p8gchHLt4JMr6H2DB
         oay1lq5P2vRcbJXDcviUhEXtOuH0wnMLPDb9TSVPWMFmqsCzv/3C5/PS3UIUNxLhWLFF
         stiOnXVgBnI1zKc+m2gV4bh+ZP9jm2By0atDyoqFmq9V6owXGPdCIBexAyREiyN/lqWP
         sE0WUW66Z3ial6A4UoLjgKhJjd15EU91IEkibIDuhAx6QDoDtHXsAnahe4K9HdlDUCRk
         bV02tDWRCArcwrkIhFBPyvdeAp0V7KDoiMmXTmMmQR0oyvjc0mW2aORSBPxsiKFydKXZ
         joRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3YUx2QLwqjC4yt6Na4HDX+YOsTdcO8b9CpzZpDW+SU=;
        b=FRyNYJWSjKqNM/6J5cejimTfxnD5PObOu5lh3aEQoJBDUA9JpYDyl8UB6/kxrASCDK
         ILVv9CVv+oG/AvSzI6/3VgjSJzAPwNnt73MvHD/M0Rx5PvoCHbmvAUU9W/u921717LFx
         vyQ12vw6oJiSwBFi1q5GfRUQ8vhiwT21iw7+UPnJNUje1jXHUS/xV8nchVKjfWezSqPW
         8nNWMWZkESojsibxsLL6r7VKCcmHwD0y5yePYoFHq1v+2KcAUSmljb2JC0ursOT1Frzi
         rKaK2/ZqEKr9n6hCG2VPFzmABxiD+w3VoAuGECMvQXpkUkuQk8N0Dluu2VCi/hfTd7Vz
         OSxw==
X-Gm-Message-State: AJIora8w4SDTYX9o63OAlnPyAF2v9WRRvFuoserXWn8oWzyQ3/tk5g6H
        U/Knu3OjzbhC+dWgjxmkwEL4j/VDM3bBfnXu7iOOHQ==
X-Google-Smtp-Source: AGRyM1sS/o8uE5SIVvuRne76FHmKtTOxLuF/9qz0QiBkZZh/OtXHhO00qEM0M0U9FVkRkm0Vv+czaVupYJU60sZU7Ow=
X-Received: by 2002:a05:6402:3325:b0:42d:e1d8:99e9 with SMTP id
 e37-20020a056402332500b0042de1d899e9mr1033464eda.87.1655314293062; Wed, 15
 Jun 2022 10:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org> <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
 <YodHjYlMx1XGtM2+@slm.duckdns.org> <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
In-Reply-To: <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 15 Jun 2022 10:31:21 -0700
Message-ID: <CABdmKX0WV8VWgeafVGJ++nJ4xsJD7Wpz=3KX=BW1du=huttfvw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 20, 2022 at 9:25 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> On Fri, May 20, 2022 at 12:47 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> > > Thanks for your suggestion. This almost works. "dmabuf" as a key could
> > > work, but I'd actually like to account for each heap. Since heaps can
> > > be dynamically added, I can't accommodate every potential heap name by
> > > hardcoding registrations in the misc controller.
> >
> > On its own, that's a pretty weak reason to be adding a separate gpu
> > controller especially given that it doesn't really seem to be one with
> > proper abstractions for gpu resources. We don't want to keep adding random
> > keys to misc controller but can definitely add limited flexibility. What
> > kind of keys do you need?
> >
> Well the dmabuf-from-heaps component of this is the initial use case.
> I was envisioning we'd have additional keys as discussed here:
> https://lore.kernel.org/lkml/20220328035951.1817417-1-tjmercier@google.com/T/#m82e5fe9d8674bb60160701e52dae4356fea2ddfa
> So we'd end up with a well-defined core set of keys like "system", and
> then drivers would be free to use their own keys for their own unique
> purposes which could be complementary or orthogonal to the core set.
> Yesterday I was talking with someone who is interested in limiting gpu
> cores and bus IDs in addition to gpu memory. How to define core keys
> is the part where it looks like there's trouble.
>
> For my use case it would be sufficient to have current and maximum
> values for an arbitrary number of keys - one per heap. So the only
> part missing from the misc controller (for my use case) is the ability
> to register a new key at runtime as heaps are added. Instead of
> keeping track of resources with enum misc_res_type, requesting a
> resource handle/ID from the misc controller at runtime is what I think
> would be required instead.
>
Quick update: I'm going to make an attempt to modify the misc
controller to support a limited amount of dynamic resource
registration/tracking in place of the new controller in this series.

Thanks everyone for the feedback.
-T.J.

> > Thanks.
> >
> > --
> > tejun
