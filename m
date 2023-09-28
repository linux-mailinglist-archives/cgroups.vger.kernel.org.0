Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E827B1034
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 03:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjI1BAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 21:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjI1BAp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 21:00:45 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB6BF;
        Wed, 27 Sep 2023 18:00:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso130877339f.3;
        Wed, 27 Sep 2023 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695862843; x=1696467643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbmQXiIb/6ha3RbpQiPYuun60PQSJ8nGNO0HCRh4zk8=;
        b=HWAriZ+5MDXJAtj8hgfCKsjlPcGz5oeqLoykvHA/LOIBF+1osXCCtRUhVpe11QxPqz
         eOFwMulLf1+KxceCZoTdiV0aM58hqvpGsxymlKhWslFvYvro07UuQDl9RR5G2iz+z+Aa
         RVvZrDMGh1p4QyDtPWaXPNWuCSTpWVtcjCfHoLGR2GZTU8eRmxCaiTaftYorSzf5j/z4
         9SNSWbeKV6lRfpZ51E/6zWaV8A14yoKMJW0AzXilZuAdNBqRBVeuFZj/UQTN2SxP/Xs2
         hdCheLdg8Vh0BnAJHsoouUaCXl2naFSNufIPVLqmuoPc53mwqF+8Zt+fHB+QDgosU2A5
         38yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695862843; x=1696467643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbmQXiIb/6ha3RbpQiPYuun60PQSJ8nGNO0HCRh4zk8=;
        b=UN6hrjamlUtJh6lhfe4rksz/22fv6qtTWjSZptgAWiES5+KbX2mEICfDibJjqSfrOM
         Ibz6whti0U9+zNsJibgLOMeZKILJ40id1+ZOqFRV4kFHqZBnLf3OwXdWbRe1YTfkYtIb
         /O+JMSvOO8J1pzfQUAvDNtCvqz7oYyr9nMapeADOEmlyeFoV8/KWglvElZ2h6m3FexSH
         /kM4QO/zSEHmgc5Drsp9skK8IXh7p7/zNiVU92tXyFTzMlkWMejzY1W20yFp1A0eNk7B
         g8IafxFLKtPoO4202vOX8acuJ3mGAijb0l0ObIvkfIG47tCNUTb9JcvTMpQiJiz3mFh7
         aIOQ==
X-Gm-Message-State: AOJu0YxBR37FG9EqDg+QHXXsZLp7dprtNP4UIcUk81Gql2CwVtM65aLE
        4Y42oznlkA/2Vto/bF8L2IVZT6g2CYo30vrJT4U=
X-Google-Smtp-Source: AGHT+IGraQVaz++c0TuIHxnjgvrQNR+F7cLgT1kxcj79/8QWJdAqqUOQh0mJXoYanAp5mx/cjWaneXaDjvBz6BRx8go=
X-Received: by 2002:a5e:8706:0:b0:798:134a:44b with SMTP id
 y6-20020a5e8706000000b00798134a044bmr3574638ioj.21.1695862843166; Wed, 27 Sep
 2023 18:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194949.2637078-1-nphamcs@gmail.com>
In-Reply-To: <20230926194949.2637078-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 27 Sep 2023 18:00:32 -0700
Message-ID: <CAKEwX=MieJze0Gro5-ubgeQaTYn2+8pQZ2C+vbppwqh8s8XT3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
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

Thanks for all the comments and suggestions everyone!
FYI, I have sent out a second version of the patch series with the new
mount flag:

https://lore.kernel.org/lkml/20230928005723.1709119-1-nphamcs@gmail.com/T/#=
t

Feel free to check it out and discuss it over there too!
