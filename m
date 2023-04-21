Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56A6EAA0D
	for <lists+cgroups@lfdr.de>; Fri, 21 Apr 2023 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDUMNV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Apr 2023 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUMNU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Apr 2023 08:13:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF715B93;
        Fri, 21 Apr 2023 05:13:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso690532276.3;
        Fri, 21 Apr 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682079198; x=1684671198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOvME7tAXZ9JphDrU67XmOOlY2Dekn7UQzOnjzIbu/w=;
        b=dOj7qsSoqusi9JzHDMCTpPvIgyQPzCzKLm+sIKYvK1CvZPROIce1ddULWduEJd7jrh
         h9EtoGJ6m1GHmYGpXJU6/6FNPLsCuLt6cW8q2qImYUU4Me5AQY5TlzdLNG24YUAq4d/b
         zlGbTzgDvqJDlOwMKaEiRsVixMQR0LYg8I9uzwd9DuXOQdacYh2RKW3yFarSSqIZm0e5
         jXgDJyaLluMrwFMsYHZLR3DOju3AwGzSKT33SyiKGKcL6YgeBrcoJbjsBjTKixLnXlG+
         W46y8eXZCiHZVJ+VEK2Y83z5BnDuzZ4ANfbtnti4CzoG2KX/btAfDEYaiJwWihMcIxck
         x68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682079198; x=1684671198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOvME7tAXZ9JphDrU67XmOOlY2Dekn7UQzOnjzIbu/w=;
        b=XUzkxuxPKbuEmyr61zqcdp1aeeyywW2oIenPEgBAjIyigyL3zNgPZcmF7nL4mITHRP
         WsFpn79wlTZhgQMeNFbra5Sbd/B8ZSQBcy+DrTSs/OV37wxylAxCp+czHMl5IhNIAw6p
         KL7kDcuUdyxHlJTFWBjlAHQt2WXrv69XDQf/e8EnRpPD2E7bIlQiqOA+gydxgLALsJM0
         K2f7ebURBB4aiWQbJjnmtHGxQGdRP7qX485nK1tkM2sNWTG1L1OttmEXOeRkg3BT+WNV
         4yplyn1sguMdnA6kcdmCyY+daEvXT0uimmxkkq16VGOTpE7Xfgwso5TtH+6hivmrfJHk
         1Jmg==
X-Gm-Message-State: AAQBX9fVLeTyPLitPSWr8Hc7HkB86Eq9irGEDW4QcFb4m42UE2yM3NvQ
        RjGHZOCoU6uUPG/0ncEJFPT3QDbFR2hN5V/fdQo=
X-Google-Smtp-Source: AKy350bjuOnxJWwW5k1ckin1yG5kiI/s5+t7bZByyWpKZYMuEEODDrY8+cV9Rp+5si3ja6aSq0oE9UHI8YlKQLjj0RM=
X-Received: by 2002:a0d:f205:0:b0:541:8810:8d7b with SMTP id
 b5-20020a0df205000000b0054188108d7bmr1918894ywf.15.1682079198356; Fri, 21 Apr
 2023 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com> <20230314141904.1210824-3-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20230314141904.1210824-3-tvrtko.ursulin@linux.intel.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 21 Apr 2023 13:13:07 +0100
Message-ID: <CACvgo52Bb3kBua8dh+eac6dhSwiJLMGAdGDAa+LQYoOwCLPLNA@mail.gmail.com>
Subject: Re: [RFC 02/10] drm: Update file owner during use
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Brian Welty <brian.welty@intel.com>, Kenny.Ho@amd.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, "T . J . Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Greetings everyone,

Above all - hell yeah. Thank you Tvrtko, this has been annoying the
hell out of me for ages.

On Tue, 14 Mar 2023 at 14:19, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> With the typical model where the display server opends the file descriptor
> and then hands it over to the client we were showing stale data in
> debugfs.

s/opends/opens/

But as a whole the sentence is fairly misleading. Story time:

The traditional model, the server was the orchestrator managing the
primary device node. From the fd, to the master status and
authentication. But looking at the fd alone, this has varied across
the years.

IIRC in the DRI1 days, Xorg (libdrm really) would have a list of open
fd(s) and reuse those whenever needed, DRI2 the client was responsible
for open() themselves and with DRI3 the fd was passed to the client.

Around the inception of DRI3 and systemd-logind, the latter became
another possible orchestrator. Whereby Xorg and Wayland compositors
could ask it for the fd. For various reasons (hysterical and genuine
ones) Xorg has a fallback path going the open(), whereas Wayland
compositors are moving to solely relying on logind... some never had
fallback even.

Over the past few years, more projects have emerged which provide
functionality similar (be that on API level, Dbus, or otherwise) to
systemd-logind.


Apart from that, the commit is spot on. I like the use of rcu and the
was_master handling is correct. With some message polish this commit
is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

I also had a brief look at 01/10, although I cannot find many
references for the pid <> tguid mappings. Be that on the kernel side
or userspace - do you have any links that I can educate myself?

Thanks
Emil
