Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F879BC8A
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357842AbjIKWZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbjIKTxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 15:53:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277F1A2;
        Mon, 11 Sep 2023 12:53:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-501bd164fbfso7877176e87.0;
        Mon, 11 Sep 2023 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694462011; x=1695066811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Sic40zovBW+5AtjExOsIc28jivRQhihGT7xjxZ+KU=;
        b=ShYcaZosKFez/kXBqrzHye3IStZMvcKOh7rcR+YsL15nncAJtsa3/N710pw31Zxda8
         /6u4C8lnfTxan4AHjTBRVKWHCAvK0Dnu0RvJKYW+fb/zxxaLWWC+xt3YQ+NmzBncRNOE
         bKBCmg3EJpSpHpqFzhD13DziD5KxypyAztWWPCinOvyrnjox7LBGcA884aPhdfuYBRsf
         cyRTsF4d60eQn0z0CyjN4qKE7Cy6tA4qjD486c+8UQ61g5iZwE0itwoitfOycyfZjdGT
         LOlJQu8L5D/MFTHPI+W5QqPcspHFU8+lltr5KCXV/VV7vfiD0F1XFlp44RuINSloLoB3
         vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462011; x=1695066811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4Sic40zovBW+5AtjExOsIc28jivRQhihGT7xjxZ+KU=;
        b=vp4L+v0YhxbVuWC1HTd/dsASgLQdWSQAUxAIYS3CvtOQD5GI18Hs+FZzAOmM6APfv5
         wWMWtSXPEcdPDFk6H17y6kVoZO/JdEaxDR4W+tmyaRwNHnsGnIJTEMWsHGbemirvsJtl
         3DmJ3Sbnc8FVEmOc+gOQ+oiyGfMpGsdZdB8l6KPZzMObGB6xVnmnIpWK0qr3Pm6sjFjl
         EmuHi/6Zn4wMwLxdswStpi/m/tYk0PfRPQ2XZJxKdMcKhxpRXsYEg979Qea0bwjgNhro
         ReTu4toW4rWaT/pluD3XqiDDn4s+lZP7t6F2MzT8VqC4Q46I2XfYH270frz48AvIL/Qe
         BwzA==
X-Gm-Message-State: AOJu0YwCBL+W6LeJikTMcOXlUxqLRRWf0UehXhQDKKxnGepRzI09PdWc
        JYX4dXzipaBUQBZBGFAgWRqEKDu2Oo2RswjeL9M=
X-Google-Smtp-Source: AGHT+IGVHo/69FUsCdyrL9DHMN9YgpiqkTfMYuzOx+tieFXkrLbOG85v6zMrjnotMfqeB0b9iULq6RaaqtvG0vIHKhI=
X-Received: by 2002:ac2:4ac7:0:b0:4fe:3364:6c20 with SMTP id
 m7-20020ac24ac7000000b004fe33646c20mr8226571lfp.16.1694462010932; Mon, 11 Sep
 2023 12:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com> <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
In-Reply-To: <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 11 Sep 2023 12:53:19 -0700
Message-ID: <CAADnVQJG8kGDVC6XUj40rabZK6Z78CqOMvkjnNv8zTSTkNYn7Q@mail.gmail.com>
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

On Sat, Sep 9, 2023 at 8:18=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Sat, Sep 9, 2023 at 2:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 7, 2023 at 7:54=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Thu, Sep 7, 2023 at 10:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@s=
use.com> wrote:
> > > >
> > > > Hello Yafang.
> > > >
> > > > On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > In our specific use case, we intend to use bpf_current_under_cgro=
up() to
> > > > > audit whether the current task resides within specific containers=
.
> > > >
> > > > I wonder -- how does this work in practice?
> > >
> > > In our practice, the cgroup_array map serves as a shared map utilized
> > > by both our LSM programs and the target pods. as follows,
> > >
> > >     ----------------
> > >     | target pod |
> > >     ----------------
> > >            |
> > >            |
> > >           V                                      ----------------
> > >  /sys/fs/bpf/cgoup_array     <--- | LSM progs|
> > >                                                   ----------------
> > >
> > > Within the target pods, we employ a script to update its cgroup file
> > > descriptor into the cgroup_array, for instance:
> > >
> > >     cgrp_fd =3D open("/sys/fs/cgroup/cpu");
> > >     cgrp_map_fd =3D bpf_obj_get("/sys/fs/bpf/cgroup_array");
> > >     bpf_map_update_elem(cgrp_map_fd, &app_idx, &cgrp_fd, 0);
> > >
> > > Next, we will validate the contents of the cgroup_array within our LS=
M
> > > programs, as follows:
> > >
> > >      if (!bpf_current_task_under_cgroup(&cgroup_array, app_idx))
> > >             return -1;
> > >
> > > Within our Kubernetes deployment system, we will inject this script
> > > into the target pods only if specific annotations, such as
> > > "bpf_audit," are present. Consequently, users do not need to manually
> > > modify their code; this process will be handled automatically.
> > >
> > > Within our Kubernetes environment, there is only a single instance of
> > > these target pods on each host. Consequently, we can conveniently
> > > utilize the array index as the application ID. However, in scenarios
> > > where you have multiple instances running on a single host, you will
> > > need to manage the mapping of instances to array indexes
> > > independently. For cases with multiple instances, a cgroup_hash may b=
e
> > > a more suitable approach, although that is a separate discussion
> > > altogether.
> >
> > Is there a reason you cannot use bpf_get_current_cgroup_id()
> > to associate task with cgroup in your lsm prog?
>
> Using cgroup_id as the key serves as a temporary workaround;
> nevertheless, employing bpf_get_current_cgroup_id() is impractical due
> to its exclusive support for cgroup2.
>
> To acquire the cgroup_id, we can resort to open coding, as exemplified be=
low:
>
>     task =3D bpf_get_current_task_btf();
>     cgroups =3D task->cgroups;
>     cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
>     key =3D cgroup->kn->id;
>
> Nonetheless, creating an open-coded version of
> bpf_get_current_ancestor_cgroup_id() is unfeasible since the BPF
> verifier prohibits access to "cgrp->ancestors[ancestor_level]."

Both helpers can be extended to support v1 or not?
I mean can a task be part of v1 and v2 hierarchy at the same time?
If not then bpf_get_current_cgroup_id() can fallback to what you
describing above and return cgroup_id.
Same would apply to bpf_get_current_ancestor_cgroup_id.

If not, two new kfuncs for v1 could be another option.
prog_array for cgroups is an old design. We can and should do
more flexible interface nowadays.
