Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66E736F10
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjFTOs4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jun 2023 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjFTOs4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jun 2023 10:48:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85D95;
        Tue, 20 Jun 2023 07:48:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57059626276so54309167b3.3;
        Tue, 20 Jun 2023 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687272534; x=1689864534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/BJYkX6bywThpMtgw8TodK1xxjg+6M9424vm6AiX+Y=;
        b=lgOaNfjNi640O9ZZHKv/WLheDYiuIbH18qLmGDyCLONcthMEFX+H5LSmG9gOVzksDc
         CQLFSTiuRlk1VWwhUbieZipxET0Zc/GAVPhzolyepEoZygQotuQZVRD4nYvzGaZn3PMC
         WXvs926H2+4CKi5nARSFzigY4G/qCPjPOyomRJuWmIzfmVoL5hLT6xD++D+33HDh3YMr
         1cqM3g2fkpfHrsN2JbWw5fstY/OCkyK5XGks3hfOCC7dlfBe7YuijuzHYaingCIMGyhO
         7A7hUXQGBFqCTSLv4y8EyFKzwPGWCcONQVgOV5kPQTLtSvEcUnhORCwwAO4m6perxe7W
         w98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272534; x=1689864534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/BJYkX6bywThpMtgw8TodK1xxjg+6M9424vm6AiX+Y=;
        b=WeTSeXY9WRjxeItbrVA+Ij32CY7KUIaEpAvePLhQZb0YB2YuIBOpUSdgsaueESc/ns
         kozn0WnQka/fTErsply24EtVUXmOse9K8dbMW86k72ITADWj00u7mHBC7E0so2/gfLyI
         opiNBd0UPnYk2xqLaEMo5+kJYLzZeBg57Wka1cSK4mxW62pu0cwaQd8Blym4GCs0PsxQ
         3rWrmmU/XYwlYG8fd27Aq2noePq+z5UD+/VMgPgPacayOkvL/KW+CN4qpLOHSQHec0FK
         VeUTJ59pYeWBOcZXwUDu39q/LwTKQ2f7hlmrMLQfDAOL90uYg6eGiG/ZuTaRDgSVcuHs
         15kA==
X-Gm-Message-State: AC+VfDwH5jEwatinT1uK5KqvBXRxXX9En5VK/G94Zwd04c4uobrgUrnP
        fxcdEkijVo8l+CmNE8QrRa1wKD6fAL/iubD0RGI=
X-Google-Smtp-Source: ACHHUZ53FgFHl4GIT8XPufVJ5Bcyl9yhhVb0g6Za2zAKdfIAPBal6veXmG1rjZwhgPo+3i8UpRxR6fhd5byzeSU2tg4=
X-Received: by 2002:a25:424b:0:b0:ba8:3a86:15ca with SMTP id
 p72-20020a25424b000000b00ba83a8615camr10675163yba.60.1687272534290; Tue, 20
 Jun 2023 07:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
 <20230314141904.1210824-3-tvrtko.ursulin@linux.intel.com> <CACvgo52Bb3kBua8dh+eac6dhSwiJLMGAdGDAa+LQYoOwCLPLNA@mail.gmail.com>
 <77587046-aede-f625-6a35-55bf9c5f1179@linux.intel.com>
In-Reply-To: <77587046-aede-f625-6a35-55bf9c5f1179@linux.intel.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 20 Jun 2023 15:48:42 +0100
Message-ID: <CACvgo51DmeM7Tbboozxu3Yn-Pe-eALVTkiq4vZBJJHKfqP_HeA@mail.gmail.com>
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

Hi Tvrtko

Sorry for the delay, real life and other obligations got in the way.

On Thu, 8 Jun 2023 at 15:26, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
> On 21/04/2023 13:13, Emil Velikov wrote:

> Are you okay if I just paste your very fine explanation verbatim, with
> credits?
>

Yes, feel free to use as much of if as you see reasonable.

> > I also had a brief look at 01/10, although I cannot find many
> > references for the pid <> tguid mappings. Be that on the kernel side
> > or userspace - do you have any links that I can educate myself?
>
> TGID or thread group leader. For single threaded userspace TGID equals
> to PID, while for multi-threaded first thread TGID equals PID/TID, while
> additional threads PID/TID does not equal TGID. Clear, as mud? :) My
> POSIX book is misplaced somewhere having not consulted it years... :)
>

Ack. /me looks into actually buying one, perhaps

Thanks
Emil
