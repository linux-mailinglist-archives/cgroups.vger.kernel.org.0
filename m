Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE367AF58A
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 22:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjIZUua (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjIZUu3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 16:50:29 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBC121
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 13:50:22 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45260b91a29so4476561137.2
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761421; x=1696366221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ8eTdCcCBk/Huq43GsPZLcFxSomyGvN9/0CZ/gCf4w=;
        b=OZk9g8T/H5mFedfr/3ZMv/1zS62oeFXPwKK7+mPF2Mq0EEh+0vJM0ngV5yEeOdEpZF
         4f0R4wMOuS667vrzkQgja1rMLOfI/DzCr7/3qp8U5nQc7GP92W6KkJIzmXQ2XpLwtLHs
         gaD0xXvtdIjX3qOdp9j+4FprTeoganIsrx+WULRf2xMSkKNanejZET3I2q8Es3oUMGlA
         A41YmFUWtRAR5BUqrtFSHgQdPl90Onz2HystmfelgzpccoiNA5J/UdcvxNkZhNUc9CAJ
         kjxGTGCbRgeOxMYNLqo2NIhu/NBMCtNwK67qB5tsdn/TQCNywPul25H/A1aGPL2dNvMU
         K2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761421; x=1696366221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ8eTdCcCBk/Huq43GsPZLcFxSomyGvN9/0CZ/gCf4w=;
        b=HCLx1EFwnb/knTQG95w33MFqUYYQvw+cL3xSQo9yYBmQ2n7N0/lavoz7C4lUKfL1Z1
         TpJPlkAhZHFeBZe5/M5M+hyMiE9ljs72ClfrOkQ6fUJq//oPY56q5hxVzoVfGssJAMSV
         LSv5PpberMcsko93Af9ZSojcEKEDujJ+FT+CAJQNv9IEuSKXvNgNYmlfmffhH5hBa+Jq
         UAonH1aS6F3w7oXHpfWCk6fhVFdw+Tbo10x7MLGmtPUXKxQ+nU+nIN5FZ9OHijDEZPDV
         SNJFZnhRNttbOidSj6LZf1tLZQaAIEeh69SYfgcG9a1fOMHXmuuKwNkwv2LS/Ry/sHps
         jd2A==
X-Gm-Message-State: AOJu0Yw0w/r9WcUsHE9RdyTpkJpm8fkx0EpDMHMaTm74URQXQKOkWKGk
        lWnfX9lEgpMSjTa+Jgw2k1QqIqXxyVEan46v2pi5IQ==
X-Google-Smtp-Source: AGHT+IHiSxZQR8jJmMne+tkZHh5aFyaxecm2LkIPWS70wLORNzYm/SDGJADtfduU14OQahYm6KZWNzyI9bWKucCDjjE=
X-Received: by 2002:a05:6102:34e5:b0:452:6e60:3eba with SMTP id
 bi5-20020a05610234e500b004526e603ebamr204435vsb.1.1695761421124; Tue, 26 Sep
 2023 13:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194949.2637078-1-nphamcs@gmail.com>
In-Reply-To: <20230926194949.2637078-1-nphamcs@gmail.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Tue, 26 Sep 2023 13:50:10 -0700
Message-ID: <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 12:49=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
>
> This patch series rectifies this issue by charging the memcg when the
> hugetlb folio is allocated, and uncharging when the folio is freed. In
> addition, a new selftest is added to demonstrate and verify this new
> behavior.
>
> Nhat Pham (2):
>   hugetlb: memcg: account hugetlb-backed memory in memory controller
>   selftests: add a selftest to verify hugetlb usage in memcg
>
>  MAINTAINERS                                   |   2 +
>  fs/hugetlbfs/inode.c                          |   2 +-
>  include/linux/hugetlb.h                       |   6 +-
>  include/linux/memcontrol.h                    |   8 +
>  mm/hugetlb.c                                  |  23 +-
>  mm/memcontrol.c                               |  40 ++++
>  tools/testing/selftests/cgroup/.gitignore     |   1 +
>  tools/testing/selftests/cgroup/Makefile       |   2 +
>  .../selftests/cgroup/test_hugetlb_memcg.c     | 222 ++++++++++++++++++
>  9 files changed, 297 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c
>
> --
> 2.34.1
>

We've had this behavior at Google for a long time, and we're actually
getting rid of it. hugetlb pages are a precious resource that should
be accounted for separately. They are not just any memory, they are
physically contiguous memory, charging them the same as any other
region of the same size ended up not making sense, especially not for
larger hugetlb page sizes.

Additionally, if this behavior is changed just like that, there will
be quite a few workloads that will break badly because they'll hit
their limits immediately - imagine a container that uses 1G hugetlb
pages to back something large (a database, a VM), and 'plain' memory
for control processes.

What do your workloads do? Is it not possible for you to account for
hugetlb pages separately? Sure, it can be annoying to have to deal
with 2 separate totals that you need to take into account, but again,
hugetlb pages are a resource that is best dealt with separately.

- Frank
