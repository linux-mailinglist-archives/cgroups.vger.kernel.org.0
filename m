Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02E5798C46
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjIHSLD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Sep 2023 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjIHSLD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Sep 2023 14:11:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F081FE1;
        Fri,  8 Sep 2023 11:10:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5008d16cc36so3953910e87.2;
        Fri, 08 Sep 2023 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694196555; x=1694801355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyPYK0w69+g1akkDzeNAWRhnsMpPNgkPja8VOvx5ZAo=;
        b=d9JRdGQ58w6J1Evf2LP9ayMZ5BPwN+ugHJ9lnGTSwuI+upsMZbzs1H2IR4WqYXGNMA
         QGPJR47Vbi8FUwH/OLfINGOr/8T69Jh6Lou3iBsYkKKeFB7i5DH8xdHG7JXhDBu26tQ5
         GFbgqUahoRrEz+w3amIR4kPiuIZ1gHimAnycSKkTBlbIsvdmGYilyG5V7E+zao+wYmBU
         fLkJANKX1ivtnNRWXxdz0tMai6CLJw4j/vELzREzL2m96myB+Mqw0XxF3LaWQJ4qQ3Xp
         hmYqhdS2dk+eO2l8Hy81GM7rPD6MXt8ex/crEwCWeAd4PkwXEQODLmhWUsTKg5B945wp
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196555; x=1694801355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyPYK0w69+g1akkDzeNAWRhnsMpPNgkPja8VOvx5ZAo=;
        b=T/lix/Ak0kMxmz9L5MB2rewKBdU9Y90v1qnyhbnvSBkJ1pCW8mLMFlAuFtJGeRpn6g
         rwLgHnThZk0WbpWB8ObHDU2b78br1thc9+I99Vd0IJHqLEpla8JGQEwTcMWEmlzniLEL
         yt0z4fbyNSdSvqUuP1/1OAfpARmVYPd5sbaDR5rBE0W66Xk5KrDEGdPCJIhAd+I38Aig
         U3SKamUETuyQ2tO4MpRiHgMTerSaWzyfkDXfgzO5C6ldD7ekSEJ73eUXICQYmTAYyFgx
         /j2ksIOusl3InmxoVTDlexH6I0uQaqGXLzSiYQ6uFp+OrMAbD0tyBq5taTVb7w9fQQkQ
         8meQ==
X-Gm-Message-State: AOJu0YxMMmpAl5vRDClYfhYQiDdhnfn6mxH7sO98vUTLb2bwqCMAQEBD
        10c/yL0bhksvyRbV5cqSPgLnnu3lDYgumSyiH+k=
X-Google-Smtp-Source: AGHT+IHwsYTplxotX5Lf+rvziXS8asFzrR6F9PqLGYUCcrUGZWCe0+tAo56ciqkRUBe8JqyHOJftGo7/qa29BIEWT8w=
X-Received: by 2002:a05:6512:6ca:b0:4f6:3677:54e with SMTP id
 u10-20020a05651206ca00b004f63677054emr3391806lff.36.1694196554507; Fri, 08
 Sep 2023 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
In-Reply-To: <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 8 Sep 2023 11:09:03 -0700
Message-ID: <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, Sep 7, 2023 at 7:54=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, Sep 7, 2023 at 10:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > Hello Yafang.
> >
> > On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > In our specific use case, we intend to use bpf_current_under_cgroup()=
 to
> > > audit whether the current task resides within specific containers.
> >
> > I wonder -- how does this work in practice?
>
> In our practice, the cgroup_array map serves as a shared map utilized
> by both our LSM programs and the target pods. as follows,
>
>     ----------------
>     | target pod |
>     ----------------
>            |
>            |
>           V                                      ----------------
>  /sys/fs/bpf/cgoup_array     <--- | LSM progs|
>                                                   ----------------
>
> Within the target pods, we employ a script to update its cgroup file
> descriptor into the cgroup_array, for instance:
>
>     cgrp_fd =3D open("/sys/fs/cgroup/cpu");
>     cgrp_map_fd =3D bpf_obj_get("/sys/fs/bpf/cgroup_array");
>     bpf_map_update_elem(cgrp_map_fd, &app_idx, &cgrp_fd, 0);
>
> Next, we will validate the contents of the cgroup_array within our LSM
> programs, as follows:
>
>      if (!bpf_current_task_under_cgroup(&cgroup_array, app_idx))
>             return -1;
>
> Within our Kubernetes deployment system, we will inject this script
> into the target pods only if specific annotations, such as
> "bpf_audit," are present. Consequently, users do not need to manually
> modify their code; this process will be handled automatically.
>
> Within our Kubernetes environment, there is only a single instance of
> these target pods on each host. Consequently, we can conveniently
> utilize the array index as the application ID. However, in scenarios
> where you have multiple instances running on a single host, you will
> need to manage the mapping of instances to array indexes
> independently. For cases with multiple instances, a cgroup_hash may be
> a more suitable approach, although that is a separate discussion
> altogether.

Is there a reason you cannot use bpf_get_current_cgroup_id()
to associate task with cgroup in your lsm prog?
