Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326D66687C
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 02:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjALBiw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 20:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjALBiu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 20:38:50 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFAA40C19
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 17:38:49 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 188so17037944ybi.9
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 17:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvPtEwtZM9M8vhjcnDBhdGXaa7R7IpCHINyiVw91Tqw=;
        b=ew490uHSuUDb6IZiNj7J2omgVWofPd8fWgOYael7TpZBTXDtsHSAd1MktEsOv9faYX
         dk/AonZsRunyMpaJLLzXaM8J0rTiwnXf8VG29KNWe62a/gal2kTOWFjr0sequymp1DCY
         deryNvmfVbw3MfE8u6IwwSbV2nln5PFQpFtFcpyOWSMd9CXS/AKtS1p1YOGlfMpw79jP
         l5NkVrrTWEoDSakAg1zFF/4YwIyh4Rbq1+qoZZdl/j2jVgBkjX4nVsmfV9VLo3uChPQg
         JBL++ZZpMvU46kwYRyxClLlCAHYkOfjPCY0EBI0/s73cr3oKqru9ihboYjhKi2PyyHda
         So2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvPtEwtZM9M8vhjcnDBhdGXaa7R7IpCHINyiVw91Tqw=;
        b=cun4nqD9Krueou2unGJVI4oJWW4p5G21NeXXzejLYM4qCOxthcw9RHPmZW9Gvtjj8h
         3tpJPO9EgwG8+H8Vk6IMrXW/2vS0QDlN39I6L4oXG0DfjbFWmBpUMk0On07CC5drhuW5
         MiqeVFe7dq59hO0kGKhQA+UXl0+D03cbhQDfVNYqtornT363s3EG87Fh7wnuNnHNA05v
         IIJNqO8+9YFEDdq6xWlY5lOutA/eIYdsLNODvFjMMsOo0PwtCI4dqIwzejvGpB/MDJC7
         QJletN6e86xmGY1H1+bvwrdxbhE2XCyTRuBD/+ZsTeh7e5H0yqGZ0dW8BmY8FSOb1WTG
         xRyg==
X-Gm-Message-State: AFqh2kr4+Y4zDujU/t2PX/cQqyZ1Kf9FA5QrIJ7an5GfD1nHY2zIwHU6
        NrzHK24k7VOTppcok60NdoSHPJwBN7UxyNzJYJzNiQ==
X-Google-Smtp-Source: AMrXdXvR3AqsbCqjGKXvVsjswPX5UqCPBEwDxqz1k68HMcWKzjDj13JnbxiAoe4wa4zNk7Y/0aKbvez2mpNXiWGJ/+s=
X-Received: by 2002:a05:6902:3cb:b0:6f7:dc52:d2cc with SMTP id
 g11-20020a05690203cb00b006f7dc52d2ccmr8940765ybs.292.1673487528875; Wed, 11
 Jan 2023 17:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20221214225123.2770216-1-yuanchu@google.com> <20230111141716.GA14685@blackbody.suse.cz>
In-Reply-To: <20230111141716.GA14685@blackbody.suse.cz>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 11 Jan 2023 17:38:37 -0800
Message-ID: <CAJj2-QHxcC3u49Boh7t0Z2tZfhrg_W5uLqBcMDYmukJra8D22Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
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

On Wed, Jan 11, 2023 at 6:17 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Wed, Dec 14, 2022 at 02:51:21PM -0800, Yuanchu Xie <yuanchu@google.com=
> wrote:
> > that's frequently used. The only missing pieces between MGLRU
> > generations and working set estimation are a consistent aging cadence
> > and an interface; we introduce the two additions.
> >
> > Periodic aging
> > =3D=3D=3D=3D=3D=3D
> > MGLRU Aging is currently driven by reclaim, so the amount of time
> > between generations is non-deterministic. With memcgs being aged
> > regularly, MGLRU generations become time-based working set information.
>
> Is this periodic aging specific to memcgs? IOW, periodic aging isn't
> needed without memcgs (~with root only)
> (Perhaps similar question to Aneeh's.)
Originally, I didn't see much value in periodic aging without memcgs,
as the main goal was to provide working set information.
Periodic aging might lead to MGLRU making better reclaim decisions,
but I don't have any benchmarks to back it up right now.

>
> > Use case: proactive reclaimer
> > =3D=3D=3D=3D=3D=3D
> > The proactive reclaimer sets the aging interval, and periodically reads
> > the page idle age stats, forming a working set estimation, which it the=
n
> > calculates an amount to write to memory.reclaim.
> >
> > With the page idle age stats, a proactive reclaimer could calculate a
> > precise amount of memory to reclaim without continuously probing and
> > inducing reclaim.
>
> Could the aging be also made per-memcg? (Similar to memory.reclaim,
> possibly without the new kthread (if global reclaim's aging is enough).)
It is possible. We can have hierarchical aging, invoked by writing to
memory.aging with a time duration. For every child memcg, if its young
generation is older than (current time - specified duration), do
aging.
However, now we need a userspace tool to drive the aging, invoking
this interface every few seconds, since every memcg is aged at a
different cadence.
Having a kthread perform aging has the benefit of simplicity, gives a
source of truth for the aging interval, and makes the feature more
accessible. The application developers, if they want to take a look at
the page idle age stats, could do so without needing additional
ceremony.

Thanks,
Yuanchu
