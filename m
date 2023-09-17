Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC77A340F
	for <lists+cgroups@lfdr.de>; Sun, 17 Sep 2023 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjIQHUQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Sep 2023 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIQHTu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Sep 2023 03:19:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FB135;
        Sun, 17 Sep 2023 00:19:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76f2843260bso235064985a.3;
        Sun, 17 Sep 2023 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694935184; x=1695539984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRzdICGYkpsfyS2a+MV5klEIYz7EG73NrctrxBdiSuU=;
        b=AWi7djdkjI7wgvSowXYB1Ndy2/XQB+dV7lE3TDa3fBoRm+KkWEo560WpA4ZqO1tWXw
         APsqw9cmQdcfEjZjmLHhqsOlw7FuuGAIhGkEZyfLiRB5UaKnFdTSbcH+yi1p4d+HZ7eJ
         NwmF0eJnSh+hdn9ax4UgLwyWWU3oFaIVFT9rlTYX5loW0F/iVQUUh6jZ3vT8DIeK/28B
         z5FUFk3EwTlWRuJOCBIiJ+hzDMKGTpKrqIF9I5rX5vWvxZQ+hzptRCnyaOnLwkCvePmx
         wzbzSu0h0adIKWP1pHzYCtFNebrT9MeB5vC7EzM6laxageM0hvmAucOdPgLSGGQykfkC
         bq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694935184; x=1695539984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRzdICGYkpsfyS2a+MV5klEIYz7EG73NrctrxBdiSuU=;
        b=OMYQJHQLlb/l4Ayzx03X0wyHgPLz6yilVjFsneQpb/zvWoX9USxmQHz7KZIHmX6vdC
         jL6cTZkhv1G0e9qGSDTVkFIs5xBn1NRdMW5N2uqvjPz5TtcwgC5EZHWU6TQiQ7boUXn2
         YML0/92aPFJhjSRnEmb+aAmTXdnxSXl4Wu+06HsCWObwL0Vz+O51E1qJrYcp6uFkF2hB
         pcQa8MSFPU4Zf6eEeyifnDnfkwJ3dpYNwYK7SPEDvJ0wggJZGMRbXiwGpSdU2VN6WU7D
         sLosAq99O8TxBoPN0wSFKsyNn0X+qsHnSoZLmXJWRkc2tlQASPGj8i+KD7hSLy/Sn7h+
         zkAw==
X-Gm-Message-State: AOJu0Yy60JP0YapkdqQaO/6EgvW/xjq+Z0o0wrE8ayi6rkL6XoMupWMe
        NCPpEzMeVMFbi7mk687J+RnC+xTY2Sp+0S+gJP4=
X-Google-Smtp-Source: AGHT+IFg4ipBwPSxHzts7K9EmcEDkhAlQcIyJyZRVBJNpp3rYTA+KrRM4TXxueQIXJ3A8n+JyeUBitkv3fX3Ah9dC2w=
X-Received: by 2002:a05:620a:31a7:b0:76f:f0b:a1ba with SMTP id
 bi39-20020a05620a31a700b0076f0f0ba1bamr6425213qkb.30.1694935184579; Sun, 17
 Sep 2023 00:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org> <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
 <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
In-Reply-To: <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 17 Sep 2023 15:19:06 +0800
Message-ID: <CALOAHbCG6W+dxpcO-f=U5=9WD-sEqRoLuhFrYAps-p944=sVgw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Sat, Sep 16, 2023 at 1:01=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Tue, Sep 12, 2023 at 11:30:32AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > With the above changes, I think it can meet most use cases with BPF on =
cgroup1.
> > What do you think ?
>
> I think the presented use case of LSM hooks is better served by the
> default hierarchy (see also [1]).

Hi Michal,

The crucial issue at hand is not whether the LSM hooks are better
suited for the cgroup default hierarchy. What truly matters is the
effort and time required to migrate all cgroup1-based applications to
cgroup2-based ones. While transitioning a single component from
cgroup1-based to cgroup2-based is a straightforward task, the
complexity arises when multiple interdependent components in a
production environment necessitate this transition. In such cases, the
work becomes significantly challenging.

> Relying on a chosen subsys v1 hierarchy is not systematic. And extending
> ancestry checking on named v1 hierarchies seems backwards given
> the existence of the default hierarchy.

The cgroup becomes active only when it has one or more of its
controllers enabled. In a production environment, a task is invariably
governed by at least one cgroup controller. Even in hybrid cgroup
mode, a task is subject to either a cgroup1 controller or a cgroup2
controller. Our objective is to enhance BPF support for
controller-based scenarios, eliminating the need to concern ourselves
with hierarchies, whether they involve cgroup1 or cgroup2. This change
seems quite reasonable, in my opinion.

>
>
> Michal
>
> [1] https://docs.kernel.org/admin-guide/cgroup-v2.html#delegation-contain=
ment

--
Regards
Yafang
