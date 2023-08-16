Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0036577E754
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjHPRLx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345204AbjHPRLl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 13:11:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08652D55
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 10:11:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso12611cf.1
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692205893; x=1692810693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mihDJW+Sury5wgYKSVJ4wMxtsiublP7tmkDuALLcHY8=;
        b=rV1Ty5Qw3EKhiG5czbzW/vE1BSLiUs9zUNJcjf+75M5FK0vpYpqr7JxcSnbPjCRksH
         JDYTQwxkpjoZNv/FpeeH5CDlqg97AYMA3Uy0Y1Ja7RVxqKn03yZKibU88sWBt2MJWhX1
         6pa36ry2L9+ntsrjBi2HhHLxzZtZYzQVmb5Ia2NQND5p/l4gd3XUH/8EpN6CMgeaEv/w
         ks+iUH9vv+yHXWBqWDjFMFYo5h+Y3BZ31ynhfIDwOs7X7VwcN3j+94Z7jxPv7TFK2OKF
         GsQGnCvb/Aq3Hd50Nn6+7VHy97QXR0nLGjHiXlAzLOMiZjLu2Sekg/DnlLL4slsuAh9f
         YoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205893; x=1692810693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mihDJW+Sury5wgYKSVJ4wMxtsiublP7tmkDuALLcHY8=;
        b=SW2aLOvCVmV0ciE9ukAKR4NxU2Uxr6uYh5304AWRYC1KvkJApkag+ulbDHSG8yzPDC
         8cDLoosOyajV4DecvMWmEH8CYzqjj/3tdi2Jm/cvXR5NdnnsythMzZP2t6qbYrmvUBGl
         +QfRTF0U8hPS1N76VwOMAA0yTG8rIb2R5aMrohYVbSyva2XXfb1FcafoZHenMJrM3G9G
         ConCafhEaTIoDV7Ck4rcQCWgTCiXiNUwc3d1kPTkrndb/9O0btSIXdw8rwCk53ZxH1aQ
         BAjz0J0oNGABRLw6AvvKfToox9fNrGNesmqOtSsERLsI+0klir8Cl80diaXct+15ZoxR
         JL9Q==
X-Gm-Message-State: AOJu0YwEjNjje1Zp1n2cuCnJJofyLPKA0E6qYv3PT7tr01H1q30vUf7p
        pp0mHIsOnRXVe2GlPM0xarUnwktlQcCiHhyFbjrAHw==
X-Google-Smtp-Source: AGHT+IFr1qh1N8TwgMlrGf/aPh/t9PgoXf520XL252U/Yi/GCnx4rLFKpCwbyWraU/2t0RtVIig7bKENz0i5Cc5nowA=
X-Received: by 2002:ac8:5b06:0:b0:40f:d3db:f328 with SMTP id
 m6-20020ac85b06000000b0040fd3dbf328mr15510qtw.2.1692205892845; Wed, 16 Aug
 2023 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
 <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
 <CALvZod6HUtYhDaXiwXSrcwfxLSrZ37sZhKY1Mg4kmpDFk13aYw@mail.gmail.com> <CAJD7tkYzr2cg-aQ899vfqB4jR7iP83t8f-Z4AH8d9iW-yw-nnQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYzr2cg-aQ899vfqB4jR7iP83t8f-Z4AH8d9iW-yw-nnQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Aug 2023 10:11:20 -0700
Message-ID: <CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 15, 2023 at 7:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
>
> The problem in (1) is that first of all it's a behavioral change, we
> start having explicit staleness in the stats, and userspace needs to
> adapt by explicitly requesting a flush. A node controller can be
> enlightened to do so, but on a system with a lot of cgroups, if you
> flush once explicitly and iterate through all cgroups, the flush will
> be stale by the time you reach the last cgroup. Keep in mind there are
> also users that read their own stats, figuring out which users need to
> flush explicitly vs. read cached stats is a problem.

I thought we covered the invalidity of the staleness argument. Similar
staleness can happen today, so not strictly a behavioral change. We
can change the time window and condition of the periodic flush to
reduce the chance of staleness. Option 2 can also face staleness as
well.

>
> Taking a step back, the total work that needs to be done does not
> change with (2). A node controller iterating cgroups and reading their
> stats will do the same amount of flushing, it will just be distributed
> across multiple read syscalls, so shorter intervals in kernel space.

You seem to be worried about the very fine grained staleness of the
stats. So, for scenarios where stats of multi-level cgroups need to be
read and the workload is continuously updating the stats, the total
work can be much more. For example if we are reading stats of root and
top level memcgs then potentially option 2 can flush the stats for the
whole tree twice.

>
> There are also in-kernel flushers (e.g. reclaim and dirty throttling)
> that will benefit from (2) by reading more accurate stats without
> having to flush the entire tree. The behavior is currently
> indeterministic, you may get fresh or stale stats, you may flush one
> cgroup or 100 cgroups.
>
> I think with (2) we make less compromises in terms of accuracy and
> determinism, and it's a less disruptive change to userspace.

These options are not white and black and there can be something in
between but let me be very clear on what I don't want and would NACK.
I don't want a global sleepable lock which can be taken by potentially
any application running on the system. We have seen similar global
locks causing isolation and priority inversion issues in production.
So, not another lock which needs to be taken under extreme condition
(reading stats under OOM) by a high priority task (node controller)
and might be held by a low priority task.
