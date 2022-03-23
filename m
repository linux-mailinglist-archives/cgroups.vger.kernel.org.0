Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1A4E5BEC
	for <lists+cgroups@lfdr.de>; Thu, 24 Mar 2022 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiCWXjX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Mar 2022 19:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbiCWXiw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Mar 2022 19:38:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACE7D037
        for <cgroups@vger.kernel.org>; Wed, 23 Mar 2022 16:37:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k10so3711006edj.2
        for <cgroups@vger.kernel.org>; Wed, 23 Mar 2022 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lYs3d+G/MqnkVL5mPK5nuhjYbBx01naVFSe4Xk42kfM=;
        b=lKb4AaK6N9O62KVZSBFpoXMFMKi2DX++d0hcldo7VKltrYvP1ZV+I9dYXZlx13MpxC
         U6xbiC42KS2p1EnoJU/ZpUu2VFNzNn/B5ByWL9Zt/vr5XdA+yDneUYBZIcau3mhQ0muv
         V4ah+EZCicq3OsyPu2g/e6akuJDlkHFQFQdx2jnBGU1XDVC3q67LkJ1lTpu2QD3b10Gm
         //++HMvqfQRnNJ7DQNGYM/1Pf8y6AjoqHMxScOBz3cW/cZXBbkCYsHBTNfYHMC39INi5
         cHWn+JRXaDWTnRSK6VSSXCSqWAo9ASLt+74RRIvM/eLnYs1Iz3CUqvYDSdMrTd/CQ+rq
         7Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lYs3d+G/MqnkVL5mPK5nuhjYbBx01naVFSe4Xk42kfM=;
        b=gjz9otCuk1YAqCc5WUhdNz71F/b5AqcSOwovz+SsWevNcCiEeU5pTDnyuZfnZbFX/N
         SB11H3aiLdQo5fQAPuBhAbyvnQQKveYv7VVahGZfRZb2+0c4DHfS2M9xUb9yJJ30EFXH
         rPSsmHk4W42TWVAeCqJYhI2xq9vW9GdysWJaGOVNsLA6aozsCvKZmkvIse5hrgS3d4Kv
         g/LmMSEUm/QvYWxNqzJZuhbh9H7cys++xjD2ZvDbtJ0EXNNGcrRhZvcUU49ZdFQENxVb
         teM2hJpKcwoqIsVYKptenFkbRB7zkJxf6FQ8xgLAd0BKJwV6985en4bSfK1IE9wyQNw+
         wXsg==
X-Gm-Message-State: AOAM532wF4IGROiVedMOughKoa6pgzCN+YBI6YvkObRDQx/SlDMPytKl
        hvxmdbb5kOADzzoym7g1EJiYryRiwQIZoJEPoAZyHw==
X-Google-Smtp-Source: ABdhPJwADoSTh9axrzXODWW9/zmv/BOuIsIRoK4uginvkl+fxm/Pmh4atOmF02EcDNdhjJn90v29djoFR8TlCQGU8F0=
X-Received: by 2002:a50:9b4f:0:b0:419:49af:429c with SMTP id
 a15-20020a509b4f000000b0041949af429cmr3390112edj.276.1648078639171; Wed, 23
 Mar 2022 16:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220322095223.GG8477@blackbody.suse.cz> <CABdmKX2hZChBO09xfhqB7EbH6RY9JdmDp7zh23DaGuwidn=v4w@mail.gmail.com>
In-Reply-To: <CABdmKX2hZChBO09xfhqB7EbH6RY9JdmDp7zh23DaGuwidn=v4w@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 23 Mar 2022 16:37:08 -0700
Message-ID: <CABdmKX3Un=k3yU1BuCnEEoZkOqMovVrjcg=GiqDEtLZD_awX3g@mail.gmail.com>
Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer function
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        "Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer
        function Reply-To: In-Reply-To:" 
        <CABdmKX3+mTjxWzgrv44SKWT7mdGnQKMrv6c26d=iWdNPG7f1VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 22, 2022 at 9:47 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> On Tue, Mar 22, 2022 at 2:52 AM Michal Koutn=C3=BD <mkoutny@suse.com> wro=
te:
> >
> > On Mon, Mar 21, 2022 at 04:54:26PM -0700, "T.J. Mercier"
> > <tjmercier@google.com> wrote:
> > > Since the charge is duplicated in two cgroups for a short period
> > > before it is uncharged from the source cgroup I guess the situation
> > > you're thinking about is a global (or common ancestor) limit?
> >
> > The common ancestor was on my mind (after the self-shortcut).
> >
> > > I can see how that would be a problem for transfers done this way and
> > > an alternative would be to swap the order of the charge operations:
> > > first uncharge, then try_charge. To be certain the uncharge is
> > > reversible if the try_charge fails, I think I'd need either a mutex
> > > used at all gpucg_*charge call sites or access to the gpucg_mutex,
> >
> > Yes, that'd provide safe conditions for such operations, although I'm
> > not sure these special types of memory can afford global lock on their
> > fast paths.
>
> I have a benchmark I think is suitable, so let me try this change to
> the transfer implementation and see how it compares.

I added a mutex to struct gpucg which is locked when charging the
cgroup initially during allocation, and also only for the source
cgroup during dma_buf_charge_transfer. Then I used a multithreaded
benchmark where each thread allocates 4, 8, 16, or 32 DMA buffers and
then sends them through Binder to another process with charge transfer
enabled. This was intended to generate contention for the mutex in
dma_buf_charge_transfer. The results of this benchmark show that the
difference between a mutex protected charge transfer and an
unprotected charge transfer is within measurement noise. The worst
data point shows about 3% overheard for the mutex.

So I'll prep this change for the next revision. Thanks for pointing it out.
>
> >
> > > which implies adding transfer support to gpu.c as part of the gpucg_*
> > > API itself and calling it here. Am I following correctly here?
> >
> > My idea was to provide a special API (apart from
> > gpucp_{try_charge,uncharge}) to facilitate transfers...
> >
> > > This series doesn't actually add limit support just accounting, but
> > > I'd like to get it right here.
> >
> > ...which could be implemented (or changed) depending on how the chargin=
g
> > is realized internally.
> >
> >
> > Michal
