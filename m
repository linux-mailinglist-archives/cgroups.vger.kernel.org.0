Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ABA759FDC
	for <lists+cgroups@lfdr.de>; Wed, 19 Jul 2023 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGSUda (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jul 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGSUd2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jul 2023 16:33:28 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87A2103
        for <cgroups@vger.kernel.org>; Wed, 19 Jul 2023 13:33:06 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-564e4656fecso100752eaf.0
        for <cgroups@vger.kernel.org>; Wed, 19 Jul 2023 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689798726; x=1692390726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVa5fBSVAdHHhZFj/pRkL4ALpTE995mDIMsnkkRTm0Q=;
        b=Lde5n1cKOA1T4bKffkRp7OCLFw3kIzNszFORWjdILVZqUjkjtj/r9hJnWetWPtfHma
         ljuFtQpXVY4jecYQAp9auj6671m4eJtWAWASvcxJ0vh6TBOL3L3JPhny0qmlkfIO9s+W
         8B9dU1kPuZnzPVLrgJf4wHRzdb2yDbMwGZLSaAOSX8ifu+zNVAZ4k00aAjhvtL71UYFE
         zBzIW5qzWajLb4R1YlKHx0jzIA1FhXb9NOCMhsidexUSwl+9zzaHMeWSsIwt4d/UKdn3
         ou8P9mOiEJewUTZVMKvwVKWKgZcn3ZknSYuePQSkjSIgj6WoH4BvzHG+o4ET6ZkJEN1+
         idEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798726; x=1692390726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVa5fBSVAdHHhZFj/pRkL4ALpTE995mDIMsnkkRTm0Q=;
        b=UtwcEvXVRPt6/azGG/OczIYZbhkM7+M9safcylAuMs0dxWTLeTTEphx+rrbLiY+DOf
         sjTJLNoJcXhKj/fxh9LGDFBTMpUMvC40R9wzZdMEMPukHFOTAmtzKfFdsVrvxGOo30a0
         W/h6Se7VDtrt6u7mWOVYatWY85FUNgaCl/I10A5y8wa4f/7GrAoKEBMa77mCnSTW0Nzs
         fW3+Q/hRZH2/mawxR/5t/NRNne0Y0JaWrXSco2t/NA5QAC/URPlX7DOVr0PDEtPwLDy3
         6atVPjMjFkHm7zGMp+PkTBbR0DeBRDU7uX5LQzPiTILTccFtgF5bYJdEMBZe9hp/JJb1
         ZBow==
X-Gm-Message-State: ABy/qLYUFS2mZc+adYPhR8Pq8+AVtINh2huihd2E+2VmPl+d1F4BZXua
        jAQMgJpcsl20V4G7qiApn0E9cAWZvnBBL/c80yRZzw==
X-Google-Smtp-Source: APBJJlG0LOmFWJJYoiI2DoFv8CdP9UbzzCs8Y7kDwJRTGKPR2LDaC31eQP8L8zN0JJDBJcCQwWuezCzERqGP128mCXI=
X-Received: by 2002:a05:6808:138c:b0:3a3:eab8:8710 with SMTP id
 c12-20020a056808138c00b003a3eab88710mr4242718oiw.43.1689798726160; Wed, 19
 Jul 2023 13:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 19 Jul 2023 13:31:54 -0700
Message-ID: <CABdmKX1PUF+X897ZMOr0RNiYdoiL_2NkcSt+Eh55BfW-05LopQ@mail.gmail.com>
Subject: Re: [RFC v5 00/17] DRM cgroup controller with scheduling control and
 memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 12, 2023 at 4:47=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>   drm.memory.stat
>         A nested file containing cumulative memory statistics for the who=
le
>         sub-hierarchy, broken down into separate GPUs and separate memory
>         regions supported by the latter.
>
>         For example::
>
>           $ cat drm.memory.stat
>           card0 region=3Dsystem total=3D12898304 shared=3D0 active=3D0 re=
sident=3D12111872 purgeable=3D167936
>           card0 region=3Dstolen-system total=3D0 shared=3D0 active=3D0 re=
sident=3D0 purgeable=3D0
>
>         Card designation corresponds to the DRM device names and multiple=
 line
>         entries can be present per card.
>
>         Memory region names should be expected to be driver specific with=
 the
>         exception of 'system' which is standardised and applicable for GP=
Us
>         which can operate on system memory buffers.
>
>         Sub-keys 'resident' and 'purgeable' are optional.
>
>         Per category region usage is reported in bytes.
>
>  * Feedback from people interested in drm.active_us and drm.memory.stat i=
s
>    required to understand the use cases and their usefulness (of the fiel=
ds).
>
>    Memory stats are something which was easy to add to my series, since I=
 was
>    already working on the fdinfo memory stats patches, but the question i=
s how
>    useful it is.
>
Hi Tvrtko,

I think this style of driver-defined categories for reporting of
memory could potentially allow us to eliminate the GPU memory tracking
tracepoint used on Android (gpu_mem_total). This would involve reading
drm.memory.stat at the root cgroup (I see it's currently disabled on
the root), which means traversing the whole cgroup tree under the
cgroup lock to generate the values on-demand. This would be done
rarely, but I still wonder what the cost of that would turn out to be.
The drm_memory_stats categories in the output don't seem like a big
value-add for this use-case, but no real objection to them being
there. I know it's called the DRM cgroup controller, but it'd be nice
if there were a way to make the mem tracking part work for any driver
that wishes to participate as many of our devices don't use a DRM
driver. But making that work doesn't look like it would fit very
cleanly into this controller, so I'll just shut up now.

Thanks!
-T.J.
