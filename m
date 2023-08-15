Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43477C474
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjHOAcH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHOAcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:32:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B611986
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:31:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so651420966b.2
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692059509; x=1692664309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7/jDiS7/IrE21nefdgl6ERSoRxxFYoQh4qkRl/Z/u0=;
        b=CMp325nAJZYOQWN8OUYs8iYOETxzcLv+d/AwJkN8om25cEMN45r3ssYVm/eQWcpS0K
         DJOj3Q08o/3Vky7kzXvwPFx15c1frFa7rA51u14GOuK9Z9eFqMbeoAM7U/K+ycAXW+Sb
         o/IPm8INg68M9Ej2pA/g6ALCp54lEjRvYZeUlr83lgnft8PxDjP7Wj1P9wG9e000RpxY
         l2fjWFfiSB+velwcNNsi5JNsz2H1nF+PAJ1YOTZ2t8w2WtR2afvJItUy5V/uG/cW6vlc
         eEY9JHGmhrqohqpsYsXPAn5ge/T2HJ8d8lPaTGSof8HwiTOCZ2L82uDN4Qb2XxRHEytC
         Od4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059509; x=1692664309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7/jDiS7/IrE21nefdgl6ERSoRxxFYoQh4qkRl/Z/u0=;
        b=Af/jFl5kO5l0Ey3EmO2flSgeUiv3/54g//n9DxLHk6mbGzx96ZiTnVTX6Btc29vuKK
         T+srb1PpPdC7oNlrsvSpDU5rt0QGaac0zjMGYHcJFj2RAj7cOED1f/7COSBjyz1fkoaR
         2f89T01n1nqJX48w4Am7BN4AXXpkHytzfTqTDESCSN4DlIRRJ3Vsr92vmrqoYo6OPnxZ
         JqKnVvXGM7Rbc94SLPMzpEHZ8MRB7UhybJAKDXtG3NdxrhILmouIcMr6K7wLE+CDXebl
         GCOZYPd8oE3C3EoVO/UInZL5U7yTbslaZCJ/GhRPi97ykpdxrBOBUuJ/zja7AdFqNOSZ
         aoLQ==
X-Gm-Message-State: AOJu0YypH9tIP30fSHYunyXGPtuiwmBnU+RkRKuhBvYI+cYOMuS6a2Dn
        lycKqFNWSqRJwjEWJAq/jTvaKAo675/M3B50LdSc1Q==
X-Google-Smtp-Source: AGHT+IE/htfV4QNfoMMgC4atM5dWO8PfNSLcA84uWrMsDsn26y0vrBvecK1ytIGI8+UORN6DcvBb2wfWraEQy6TTz84=
X-Received: by 2002:a17:906:11:b0:993:dd1d:8251 with SMTP id
 17-20020a170906001100b00993dd1d8251mr8858048eja.28.1692059508584; Mon, 14 Aug
 2023 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <CAJD7tkaf5GNbyhCbWyyLtxpqmZ4+iByQgmS1QEFf+bnEMCdmFA@mail.gmail.com>
 <CAJD7tkb=dUfc=L+61noQYHymHPUHswm_XUyFvRdaZemo80qUdQ@mail.gmail.com>
 <ZNrEV1qEcQMUgztn@slm.duckdns.org> <CABWYdi3z7Y4qdjPv4wiHyM6Wvwy_VwSLGA92=_PdYyVZgQDSYQ@mail.gmail.com>
In-Reply-To: <CABWYdi3z7Y4qdjPv4wiHyM6Wvwy_VwSLGA92=_PdYyVZgQDSYQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 14 Aug 2023 17:31:12 -0700
Message-ID: <CAJD7tkbzznhwkYacA75Se2Wi2pfXSkH77B_wgGC9r90ua7N76Q@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
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

On Mon, Aug 14, 2023 at 5:30=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> On Mon, Aug 14, 2023 at 5:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Aug 11, 2023 at 05:01:08PM -0700, Yosry Ahmed wrote:
> > > There have been a lot of problems coming from this global rstat lock:
> > > hard lockups (when we used to flush atomically), unified flushing
> > > being expensive, skipping flushing being inaccurate, etc.
> > >
> > > I wonder if it's time to rethink this lock and break it down into
> > > granular locks. Perhaps a per-cgroup lock, and develop a locking
> > > scheme where you always lock a parent then a child, then flush the
> > > child and unlock it and move to the next child, etc. This will allow
> > > concurrent flushing of non-root cgroups. Even when flushing the root,
> > > if we flush all its children first without locking the root, then onl=
y
> > > lock the root when flushing the top-level children, then some level o=
f
> > > concurrency can be achieved.
> > >
> > > Maybe this is too complicated, I never tried to implement it, but I
> > > have been bouncing around this idea in my head for a while now.
> > >
> > > We can also split the update tree per controller. As far as I can tel=
l
> > > there is no reason to flush cpu stats for example when someone wants
> > > to read memory stats.
> >
> > There's another thread. Let's continue there but I'm a bit skeptical wh=
ether
> > splitting the lock is a good solution here. Regardless of locking, we d=
on't
> > want to run in an atomic context for that long anwyay.
>
> Could you link to the other thread?

I supposedly CC'd you there, but I realized it didn't work for some reason:
https://lore.kernel.org/lkml/CAJD7tkYBFz-gZ2QsHxUMT=3Dt0KNXs66S-zzMPebadHx9=
zaG0Q3w@mail.gmail.com/
