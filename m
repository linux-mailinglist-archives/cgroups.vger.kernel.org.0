Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF77A6B91
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjISTcD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 15:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 15:32:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4E9D;
        Tue, 19 Sep 2023 12:31:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79dc081ab8dso33951039f.1;
        Tue, 19 Sep 2023 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695151916; x=1695756716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGRB7aZVznYzmjO6PIUxYYQozTLd4WBNImNSQyAGpdk=;
        b=X62aMHOUOQ9UwPUAgc383CEhlP7+i8qvMlc9kM2GQ3nMAx0xkQTSYYBhLt2Gikm7OU
         jsMXoR3U7EKbNGBR4inSsswGuG3CQnQZTFqDWgLB8rkG7AmWJkv/YbFBav19mTez3jgb
         vny4+kksaw2FuYifLhoxZrdn7IE1Jy9NoARWevdRSd+iWUEIIyIftDDzhPXaA0fKDRLD
         KbhoBFxRbTsDvRO4BZ7vDk1QG3yhBaU8aeD//hrtKkno6c/TL9rxKHtVH1vzK4OwnK3O
         P7zMhgaQUws7iCRorPnlMNeLdiQysVxl/bixBlyxxXi8NqW2amn+Os/CukIOtBZSF5no
         okNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151916; x=1695756716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGRB7aZVznYzmjO6PIUxYYQozTLd4WBNImNSQyAGpdk=;
        b=Zb1BgtOBaJFbyaXAvjMncpmqaJQTkUHOzz9H2/KmRnUud8JvaddHBJ+w1BPbxkW0vR
         oQA59sYeFLeWwSI5NzYyQxCRtcsO6aXm/31vgjWoyPjYNO8DeSgJ/QeaW4JxegfTKhH3
         MLeTwQesJ+PewRUBdee/5BsoD8H6oscpK8vw8cY0TZeXMeHoGxCCFWSAmSrK0WcVQLHk
         embfrb9m2mU4KMkXZhM2e3NovDjfFWkVLb3XSxRM0iGbOkLZSC2+Rwja36in1TiL4mnL
         xnIA5ZUdE8CAAwfCiQmMVNgsS/Wz/7fpBceCKU7Y6+sIxbAAqKQw54P7YoNw6EPASiF+
         t9YQ==
X-Gm-Message-State: AOJu0YzJMhdqWarPdZlCyc3gtuqqbxqizTWm0uLf0U40XDaB1Aa6Rk6f
        BjC5S43TQQeNtBTadB9JIvAksP6+m4d3GAcLD7Q=
X-Google-Smtp-Source: AGHT+IETOaiwYEVB/hltNisobMmuHqMXXBC7zts8rxBGPENFVM98Hc46wT20xXd5dQuagXbUPJqvS4tvf14frSe6zfg=
X-Received: by 2002:a5e:c301:0:b0:784:314f:8d68 with SMTP id
 a1-20020a5ec301000000b00784314f8d68mr817244iok.1.1695151915869; Tue, 19 Sep
 2023 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com>
In-Reply-To: <20230919171447.2712746-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 19 Sep 2023 12:31:44 -0700
Message-ID: <CAKEwX=Mwt4aWXPpPqY_EBgzNQS0dDQaLcRF27Q3nNuMhq1BL6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] workload-specific and memory pressure-driven zswap writeback
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 19, 2023 at 10:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Changelog:
> v2:
>    * Fix loongarch compiler errors
>    * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM
      * Rebase the patch on top of the new shrinker API.
>
> There are currently several issues with zswap writeback:
>
> 1. There is only a single global LRU for zswap. This makes it impossible
>    to perform worload-specific shrinking - an memcg under memory
>    pressure cannot determine which pages in the pool it owns, and often
>    ends up writing pages from other memcgs. This issue has been
>    previously observed in practice and mitigated by simply disabling
>    memcg-initiated shrinking:
>
>    https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com=
/T/#u
>
>    But this solution leaves a lot to be desired, as we still do not have =
an
>    avenue for an memcg to free up its own memory locked up in zswap.
>
> 2. We only shrink the zswap pool when the user-defined limit is hit.
>    This means that if we set the limit too high, cold data that are
>    unlikely to be used again will reside in the pool, wasting precious
>    memory. It is hard to predict how much zswap space will be needed
>    ahead of time, as this depends on the workload (specifically, on
>    factors such as memory access patterns and compressibility of the
>    memory pages).
>
> This patch series solves these issues by separating the global zswap
> LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
> (i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
> new shrinker does not have any parameter that must be tuned by the
> user, and can be opted in or out on a per-memcg basis.
>
> On a benchmark that we have run:
>
> (without the shrinker)
> real -- mean: 153.27s, median: 153.199s
> sys -- mean: 541.652s, median: 541.903s
> user -- mean: 4384.9673999999995s, median: 4385.471s
>
> (with the shrinker)
> real -- mean: 151.4956s, median: 151.456s
> sys -- mean: 461.14639999999997s, median: 465.656s
> user -- mean: 4384.7118s, median: 4384.675s
>
> We observed a 14-15% reduction in kernel CPU time, which translated to
> over 1% reduction in real time.
>
> On another benchmark, where there was a lot more cold memory residing in
> zswap, we observed even more pronounced gains:
>
> (without the shrinker)
> real -- mean: 157.52519999999998s, median: 157.281s
> sys -- mean: 769.3082s, median: 780.545s
> user -- mean: 4378.1622s, median: 4378.286s
>
> (with the shrinker)
> real -- mean: 152.9608s, median: 152.845s
> sys -- mean: 517.4446s, median: 506.749s
> user -- mean: 4387.694s, median: 4387.935s
>
> Here, we saw around 32-35% reduction in kernel CPU time, which
> translated to 2.8% reduction in real time. These results confirm our
> hypothesis that the shrinker is more helpful the more cold memory we
> have.
>
> Domenico Cerasuolo (1):
>   zswap: make shrinking memcg-aware
>
> Nhat Pham (1):
>   zswap: shrinks zswap pool based on memory pressure
>
>  Documentation/admin-guide/mm/zswap.rst |  12 +
>  include/linux/list_lru.h               |  39 +++
>  include/linux/memcontrol.h             |   6 +
>  include/linux/mmzone.h                 |  14 +
>  include/linux/zswap.h                  |   9 +
>  mm/list_lru.c                          |  46 ++-
>  mm/memcontrol.c                        |  33 ++
>  mm/swap_state.c                        |  50 +++-
>  mm/zswap.c                             | 397 ++++++++++++++++++++++---
>  9 files changed, 548 insertions(+), 58 deletions(-)
>
> --
> 2.34.1
