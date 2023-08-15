Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713F77C470
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjHOAbD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjHOAag (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:30:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60C1737
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:30:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so48302895e9.2
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692059423; x=1692664223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLuShFOThvoDFyPjtjqSrXce/+NsjfeL6FKbvb91ep0=;
        b=CxLgfRZTYE2O+lvzzG0vY5ne298WWrrJYUWkVxMZpLYYaHsHujbTYL5pjKgETSom8D
         vzAAqqBkpXkWiv0++Uxv0ACgo3g3wnwX2egyTis+N6wLSzvjoT/n1He6wzKIsNcmOJPd
         u2v+6Q1C4+SciYbUN3OI8YjqnJpbMRUzxEYaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059423; x=1692664223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLuShFOThvoDFyPjtjqSrXce/+NsjfeL6FKbvb91ep0=;
        b=AtMNfLKHMWWUONJ5a/Jmo0nJ8++sTBHg7efElT62DUofE5/rYV6orIAz/Vf+LQFxBB
         HPnUYn5Ja3AU9aVgQpevhDs7x07/4XzNUTvsDOnw1Nz+PLrAfEUM/9H8wep7znvklDwE
         9Wn6ccrntXOorvze31jCP6DCg540rNwXO69MtGkUOwS83L6X45wtoHo3Fj1HHsNbOkoU
         U+JqBU5z1/COvgTbI8emc8goAtABSW0ybtQ+npnpsCLvKyCjIL/KJx4XB8+qKWzdYVZY
         JWzj5Xin3CFvOe1wfCq6dyRkrNsR8UXzXBPgUImtXmhaaZdgwuFjHaKRzB6fpASyaPVV
         bT7g==
X-Gm-Message-State: AOJu0Yz0WFfFuC1Xu8+gezPtGYJBg7d8fW7LVnem0s4dFypisHyCjOsJ
        sUN82rRBXF3AkSQcBfPfiVJmUVXpTYD1im6TmPjIOg==
X-Google-Smtp-Source: AGHT+IGyNYUpfBkaRUehRFQ2BJSXZpWDK4rzsea/ReN61axbfTfPHR5q7HWor/xA/ao4HC/HTFvoIKofUvPoizB2tp4=
X-Received: by 2002:a05:600c:3648:b0:3fd:29cf:20c5 with SMTP id
 y8-20020a05600c364800b003fd29cf20c5mr8857963wmq.7.1692059423025; Mon, 14 Aug
 2023 17:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <CAJD7tkaf5GNbyhCbWyyLtxpqmZ4+iByQgmS1QEFf+bnEMCdmFA@mail.gmail.com>
 <CAJD7tkb=dUfc=L+61noQYHymHPUHswm_XUyFvRdaZemo80qUdQ@mail.gmail.com> <ZNrEV1qEcQMUgztn@slm.duckdns.org>
In-Reply-To: <ZNrEV1qEcQMUgztn@slm.duckdns.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 14 Aug 2023 17:30:11 -0700
Message-ID: <CABWYdi3z7Y4qdjPv4wiHyM6Wvwy_VwSLGA92=_PdYyVZgQDSYQ@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 14, 2023 at 5:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 11, 2023 at 05:01:08PM -0700, Yosry Ahmed wrote:
> > There have been a lot of problems coming from this global rstat lock:
> > hard lockups (when we used to flush atomically), unified flushing
> > being expensive, skipping flushing being inaccurate, etc.
> >
> > I wonder if it's time to rethink this lock and break it down into
> > granular locks. Perhaps a per-cgroup lock, and develop a locking
> > scheme where you always lock a parent then a child, then flush the
> > child and unlock it and move to the next child, etc. This will allow
> > concurrent flushing of non-root cgroups. Even when flushing the root,
> > if we flush all its children first without locking the root, then only
> > lock the root when flushing the top-level children, then some level of
> > concurrency can be achieved.
> >
> > Maybe this is too complicated, I never tried to implement it, but I
> > have been bouncing around this idea in my head for a while now.
> >
> > We can also split the update tree per controller. As far as I can tell
> > there is no reason to flush cpu stats for example when someone wants
> > to read memory stats.
>
> There's another thread. Let's continue there but I'm a bit skeptical whet=
her
> splitting the lock is a good solution here. Regardless of locking, we don=
't
> want to run in an atomic context for that long anwyay.

Could you link to the other thread?
