Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2985C6F705E
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 19:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEDRCy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDRCx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 13:02:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE1358C
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 10:02:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef31924c64so814601cf.1
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683219770; x=1685811770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw5r5ALm4oFjWiHQAjuyJ/C3zh1wvAYI8hLaKDUg1ew=;
        b=WqN3KPJdT+xRIDnVbuxJdVPto4J2z/z1p+k2dZpdbhh36anIVnYFISHW8IAMDPjQ2c
         MXcYtl89Z5wRzZnAJJSXv0rlYW+KuwXbaTMjRQS7ytQtz707A7VfECWanLieTvzaYWFp
         62QhEtDhbQMJ2sWXZoZxg7OphoiOQy1LKpVF97k9zELX0BLlx49fbI67O3b71dP/Ph2h
         8qKkf/DqwPBg2ubww9OL/lDj+Dtagm0Lk+owMktXbBoYlXvjFbNSjRdmsKtcBchPbZ+V
         sUHEfoyzTrnuQ5nBN3UWqWtYwy/Y73U4apHcLi/q8mIWbeDQSeUZyZ3g1IfwMGomkuTh
         ldtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219770; x=1685811770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw5r5ALm4oFjWiHQAjuyJ/C3zh1wvAYI8hLaKDUg1ew=;
        b=hS8L+1PS0FhVCANsO8Wz2EG9cogd9ZaGpCdx5YpQJBTEM0jDbg+Tcj2eLhneKfHlP+
         Knvi7sy4ZMYUrrH1xWxNFGT0eubYDXLO/hhdNhN3mqNQ8kSjGI1tWrHzt2H5Z61YT1r1
         ZMuUi6qBCA2UcW8Fi6+7RxAVEzS03h3hKOjbBGkz95a1DssP/fMgUuoCjhvO1oe4pDtl
         zyz4KdBJRaZh8yO9aSBJAWkgivaUVfgatEcPfzPI1mnlQo0jS+ys7dDf5ZEGevU7K2lz
         C2o6dY5TtwzYeK1oCy9PfdNBmJFZo6jbP6oUOB/3BpkjP/9/T1TC7XJR2lJPuQIvE1bx
         5NkQ==
X-Gm-Message-State: AC+VfDxUWk7w7rno2l0wGZJky9lvKdwtexopWs0cen0PNjpAE8WEvMii
        W0ur/8fnN0jJvfzUaqsLxJd4/Vt4JhJnkHTWq+VPYA==
X-Google-Smtp-Source: ACHHUZ5sWGMeNtZ2Xbro8HaFXL+y2u45Xy7hoP5dhv1jZ+WOi1WIfwswJ4aBdA4RlXbsChq1OCPVyNEkm4W4wvY3T+Q=
X-Received: by 2002:ac8:5a0d:0:b0:3ef:404a:b291 with SMTP id
 n13-20020ac85a0d000000b003ef404ab291mr326779qta.7.1683219769869; Thu, 04 May
 2023 10:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
In-Reply-To: <ZFLdDyHoIdJSXJt+@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 May 2023 10:02:38 -0700
Message-ID: <CALvZod4=+ANT6UR5h7Cp+0hKkVx6tPAaRa5iqBF=L2VBdMKERQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
To:     Chris Li <chrisl@kernel.org>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 3, 2023 at 3:15=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
[...]
> I am also interested in this topic. T.J. and I have some offline
> discussion about this. We have some proposals to solve this
> problem.
>
> I will share the write up here for the up coming LSF/MM discussion.
>
>
> Shared Memory Cgroup Controllers
>
> =3D Introduction
>
> The current memory cgroup controller does not support shared memory objec=
ts. For the memory that is shared between different processes, it is not ob=
vious which process should get charged. Google has some internal tmpfs =E2=
=80=9Cmemcg=3D=E2=80=9D mount option to charge tmpfs data to  a specific me=
mcg that=E2=80=99s often different from where charging processes run. Howev=
er it faces some difficulties when the charged memcg exits and the charged =
memcg becomes a zombie memcg.

What is the exact problem this proposal is solving? Is it the zombie
memcgs? To me that is just a side effect of memory shared between
different memcgs.

> Other approaches include =E2=80=9Cre-parenting=E2=80=9D the memcg charge =
to the parent memcg. Which has its own problem. If the charge is huge, iter=
ation of the reparenting can be costly.

What is the iteration of the reparenting? Are you referring to
reparenting the LRUs or something else?

>
> =3D Proposed Solution
>
> The proposed solution is to add a new type of memory controller for share=
d memory usage. E.g. tmpfs, hugetlb, file system mmap and dma_buf. This sha=
red memory cgroup controller object will have the same life cycle of the un=
derlying  shared memory.

I am confused by the relationship between shared memory controller and
the underlying shared memory. What does the same life cycle mean? Are
the users expected to register the shared memory objects with the
smemcg? What about unnamed shared memory objects like MAP_SHARED or
memfds?

How does the charging work for smemcg? Is this new controller hierarchical?

>
> Processes can not be added to the shared memory cgroup. Instead the share=
d memory cgroup can be added to the memcg using a =E2=80=9Csmemcg=E2=80=9D =
API file, similar to adding a process into the =E2=80=9Ctasks=E2=80=9D API =
file.

Is the charge of the underlying shared memory live with smemcg or the
memcg where smemcg is attached? Can a smemcg detach and reattach to a
different memcg?

> When a smemcg is added to the memcg, the amount of memory that has been s=
hared in the memcg process will be accounted for as the part of the memcg =
=E2=80=9Cmemory.current=E2=80=9D.The memory.current of the memcg is make up=
 of two parts, 1) the processes anonymous memory and 2) the memory shared f=
rom smemcg.

The above is somewhat giving the impression that the charge of shared
memory lives with smemcg. This can mess up or complicate the
hierarchical property of the original memcg.

>
> When the memcg =E2=80=9Cmemory.current=E2=80=9D is raised to the limit. T=
he kernel will active try to reclaim for the memcg to make =E2=80=9Csmemcg =
memory + process anonymous memory=E2=80=9D within the limit. Further memory=
 allocation within those memcg processes will fail if the limit can not be =
followed. If many reclaim attempts fail to bring the memcg =E2=80=9Cmemory.=
current=E2=80=9D within the limit, the process in this memcg will get OOM k=
illed.

The OOM killing for remote charging needs much more thought. Please
see https://lwn.net/Articles/787626/ for previous discussion on
related topic.
