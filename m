Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7027B8DB0
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjJDTxS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjJDTxR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:53:17 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF0A6;
        Wed,  4 Oct 2023 12:53:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79faba5fe12so9543339f.3;
        Wed, 04 Oct 2023 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449193; x=1697053993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miM9Rii6r7WYSuGpAV4z/io68HUwHuAXAnsLamrRpmw=;
        b=cgP+U1NMOp+xBRSQ6pPNS81Oj1VumE05K202Q8rW57F7NtsY9XiNUm7QulMYgbhyeQ
         PB7AQIzXnvd+blaAZhTAezIUwovwqJof8N71VedIIXKB50bhVnlCzIYSDCG6nbhsWGk7
         F729pgGeT8QinwCrGwZVUXFNXHOYNa22iyvlONy32ncyA9cfWljP1IlGlmc0VTwYUjFy
         CAihzSeVtqS1eW+n9x0iM7iNCecowD/z6p6fQS22HyXiiATqvYnUeo0AbLL834vhxKS5
         TO7ZHbcHQx9RBr0LRjFstFOPXdAo7ElVYp6ZF+HewwBDJyxVXBZnR/v6AAaU8xuGkfAc
         rt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449193; x=1697053993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miM9Rii6r7WYSuGpAV4z/io68HUwHuAXAnsLamrRpmw=;
        b=Ggd+gmD8hbl+IwvGSwU6+cA22rbY1iTENOKO5xFutl2wDgLBAQLArwR6d55Zkt6yty
         Euf8iIB0EEwhEPuvoyA65IBjXxOZxP0uIjv6eyyF8cHveg7TStN6hsMdNSNIA7JSx7DI
         0syIs+vyNmQHwGmtLEqcwtqzXo7dz+mCN+sTFg6VgEBKZz/CR0awAw7egcHRZEyrIay3
         kSdfc1gCazUSKdpvgTDGU9cwjgobTeZMJyhXXXGTFF6N06jfLbv7BDx3RAjmdu43GXSl
         TH8y0uiiyL76sB/qTQgDoiEAACMZRtXZM1PK3RBmr0UHg1Bm61yqtGlxDIY2XWITpu/A
         hR7A==
X-Gm-Message-State: AOJu0Yz+BJxERnMdhKIPaOBGp10Ufr94t3mz5ehe+j68C2yxJuGjm6CW
        9uSHRjT6tWkYoAUTSQ3qeuTYkO5++erRIhqo3sY=
X-Google-Smtp-Source: AGHT+IFKg00R5moLNg6dEnKgS3rIAz2WiRfEfg5bKT/ca2Wy/+DA5vO4GbgFWE3mxG0yLDaSHARh6d8ackVGNstxcck=
X-Received: by 2002:a5d:9943:0:b0:79f:d194:d6e2 with SMTP id
 v3-20020a5d9943000000b0079fd194d6e2mr3780651ios.10.1696449193517; Wed, 04 Oct
 2023 12:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231004193622.900383-1-nphamcs@gmail.com> <20231004194630.GC39112@cmpxchg.org>
In-Reply-To: <20231004194630.GC39112@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 4 Oct 2023 12:53:02 -0700
Message-ID: <CAKEwX=Pa1ADcfQJWskjwtGBVGB7BH1MCauSoZYJR54QGrfqd6A@mail.gmail.com>
Subject: Re: [PATCH v2] memcontrol: only transfer the memcg data for migration
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, riel@surriel.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
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

On Wed, Oct 4, 2023 at 12:46=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Oct 04, 2023 at 12:36:22PM -0700, Nhat Pham wrote:
> > For most migration use cases, only transfer the memcg data from the old
> > folio to the new folio, and clear the old folio's memcg data. No
> > charging and uncharging will be done.
> >
> > This shaves off some work on the migration path, and avoids the
> > temporary double charging of a folio during its migration.
> >
> > The only exception is replace_page_cache_folio(), which will use the ol=
d
> > mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
> > context, the isolation of the old page isn't quite as thorough as with
> > migration, so we cannot use our new implementation directly.
> >
> > This patch is the result of the following discussion on the new hugetlb
> > memcg accounting behavior:
> >
> > https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> >
> > This should be added as the second prep patch in the following series:
> > https://lore.kernel.org/all/20231003001828.2554080-1-nphamcs@gmail.com/
> > (hugetlb memcg accounting)
> >
> > and should go right before the following patch:
> > hugetlb: memcg: account hugetlb-backed memory in memory controller
> >
> > Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
>
> These two tags shouldn't be here, but in the fixlet instead. This is
> the dependency patch. Otherwise looks good to me:
>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for the review, Johannes!
