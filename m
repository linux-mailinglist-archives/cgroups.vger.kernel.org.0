Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B87AF72A
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 02:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjI0APD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 20:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjI0ANC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 20:13:02 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388031F9D0;
        Tue, 26 Sep 2023 16:31:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae5efefb89so696065b6e.1;
        Tue, 26 Sep 2023 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695771077; x=1696375877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAVAV1GBJCwxDDAyuqk5FEpmqUfp3B71TeVssBtQ3XY=;
        b=In1w+jj8NlzUJNM5Bh3qtanmRjZLwlJfTLNKTOOM0CZZSz+RfAacHEMDbder3p7cmM
         CxpDM3sqJL7sCxrR7wA3Swxf7ChD8mSXWc15sVzwfHlaOE6DikK3OkzN9ECBz0TmiVXB
         TERZ/asHa6Mm5h3XHzjS7ad09AyFwkgXbOoZF/jJUdXEhZcO+6mtjMdOr3T3fkbiazW9
         c6dGgVanZX1mINlAfgqo+Z3jrNbHu95BuMR0K7IGD7EbVFZvYyxaTbfdwuFDHUGSMPVM
         PHHA2jwz74ZfSbaeE/e2TStt9UUvQBPQ5J2cYflb1sScYYWb4zVg5lXWpcS5Fn8C0vhh
         23mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695771077; x=1696375877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAVAV1GBJCwxDDAyuqk5FEpmqUfp3B71TeVssBtQ3XY=;
        b=laZ53eIV9Qz31MkAwGa0mEvXmGNvwzVvbJ8QF9bIyZv8vMCsQtbYpKXnholCdU3JMK
         Z1iMwSCvFDXt5GADKTpNfWzuKzXGQXx4ermJ9gH/Ggm2imPNQnK5nPlUBf9Uopef2Nj1
         iYQcSfYPwqNgK0zX8O88GwLtfXomULaq27wyU65qcXJ5ZRMeE+GARwOnHTIrSAts9RbJ
         7BUP19ST1MOB0X3f5FC6qp6edh8LvQ/Tgeomyz9rrj4ftrpNLQESS532OkyGN7BXvmBP
         Nnmb4ISk0f2rHXIcSzPpEi0MoD9bPPRYQcv5PoH/+4tc3r6J6ACHu9eF96doeQ2mV5Vl
         CRbQ==
X-Gm-Message-State: AOJu0YxtmWq9BODqkCnE1sHHO0QiqNe1fH2451oSiVRIdFcY56+CZ+X3
        dWaXhnWKdlbgm/Fi9ELAORKai4WP2SwIEJ7yiKzxAW0OJ4ZVU7DK
X-Google-Smtp-Source: AGHT+IH1yQriWlZtGSXP4SNOcv9TqmZsi0jotr3syJyfbtTczeTQe9fBhqh5dFav+DCAFYTaiG+0pms8xgPC3IbLQZk=
X-Received: by 2002:a05:6870:5baa:b0:1d5:a3b5:d89c with SMTP id
 em42-20020a0568705baa00b001d5a3b5d89cmr453138oab.3.1695771077390; Tue, 26 Sep
 2023 16:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194949.2637078-1-nphamcs@gmail.com> <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
In-Reply-To: <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 26 Sep 2023 16:31:06 -0700
Message-ID: <CAKEwX=PjTH8RpRbKRqyHr5-W1LFUZQu_PJKsYU5Mry70-8Td-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
To:     Frank van der Linden <fvdl@google.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 1:50=E2=80=AFPM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> On Tue, Sep 26, 2023 at 12:49=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> >
> > This patch series rectifies this issue by charging the memcg when the
> > hugetlb folio is allocated, and uncharging when the folio is freed. In
> > addition, a new selftest is added to demonstrate and verify this new
> > behavior.
> >
> > Nhat Pham (2):
> >   hugetlb: memcg: account hugetlb-backed memory in memory controller
> >   selftests: add a selftest to verify hugetlb usage in memcg
> >
> >  MAINTAINERS                                   |   2 +
> >  fs/hugetlbfs/inode.c                          |   2 +-
> >  include/linux/hugetlb.h                       |   6 +-
> >  include/linux/memcontrol.h                    |   8 +
> >  mm/hugetlb.c                                  |  23 +-
> >  mm/memcontrol.c                               |  40 ++++
> >  tools/testing/selftests/cgroup/.gitignore     |   1 +
> >  tools/testing/selftests/cgroup/Makefile       |   2 +
> >  .../selftests/cgroup/test_hugetlb_memcg.c     | 222 ++++++++++++++++++
> >  9 files changed, 297 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> >
> > --
> > 2.34.1
> >
>
> We've had this behavior at Google for a long time, and we're actually
> getting rid of it. hugetlb pages are a precious resource that should
> be accounted for separately. They are not just any memory, they are
> physically contiguous memory, charging them the same as any other
> region of the same size ended up not making sense, especially not for
> larger hugetlb page sizes.

I agree hugetlb is a special kind of resource. But as Johannes
pointed out, it is still a form of memory. Semantically, its usage
should be modulated by the memory controller.

We do have the HugeTLB controller for hugetlb-specific
restriction, and where appropriate we definitely should take
advantage of it. But it does not fix the hole we have in memory
usage reporting, as well as (over)protection and reclaim dynamics.
Hence the need for the userspace hack (as Johannes described):
manually adding/subtracting HugeTLB usage where applicable.
This is not only inelegant, but also cumbersome and buggy.

>
> Additionally, if this behavior is changed just like that, there will
> be quite a few workloads that will break badly because they'll hit
> their limits immediately - imagine a container that uses 1G hugetlb
> pages to back something large (a database, a VM), and 'plain' memory
> for control processes.
>
> What do your workloads do? Is it not possible for you to account for
> hugetlb pages separately? Sure, it can be annoying to have to deal
> with 2 separate totals that you need to take into account, but again,
> hugetlb pages are a resource that is best dealt with separately.
>

Johannes beat me to it - he described our use case, and what we
have hacked together to temporarily get around the issue.

A knob/flag to turn on/off this behavior sounds good to me.

> - Frank
Thanks for the comments, Frank!
