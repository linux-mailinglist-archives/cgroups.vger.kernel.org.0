Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219F799C62
	for <lists+cgroups@lfdr.de>; Sun, 10 Sep 2023 05:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjIJDSt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 Sep 2023 23:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346257AbjIJDSb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 Sep 2023 23:18:31 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA9CCE;
        Sat,  9 Sep 2023 20:18:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-649edb3a3d6so15120156d6.0;
        Sat, 09 Sep 2023 20:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694315904; x=1694920704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApgFfZbO2xc5gBkfPKoQgyDazIhEPSRO3D15FUVXbcg=;
        b=dymO8/jz8Gm6xMpiLmKNgne1T1oX63DLL01ty0rhEjkxHcy6dh4pr/Ysct+TbXCUrh
         HIe0EvkO+js30kZWsSP55kycI2ex8YkuG3v1a271snWgyDkQ+U9tL9ig83FaGkKtyaeF
         14abU4X7eS4vqwsUyfSx8mAVhPljNslwY5MnnWbHIksgjEG8tkdXS2afEusExDyVZUBu
         cys4NkooP3t7KBFsK8jsjY3kMEgEPyQmQv/2dcjoYWfZmEPoCcZLg9fSjxSPOhIQ9GFX
         tB1w3AtGZJ078DXpd5rlX94UsZuthTQUpxGiDHxuUp/URH3IDOecAj+FDFAmaRNv7ydO
         HlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694315904; x=1694920704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApgFfZbO2xc5gBkfPKoQgyDazIhEPSRO3D15FUVXbcg=;
        b=R5TZnsGim/02F8shefy37CZXASXomic+wfzZe/CvcqZurNhTVboljwOQtXwweGCL//
         4VWfbAUXlutZZdd858NnEIxh91lLjOzUG1xc/AQ595AisOK0ING6gHb+QTQoqeWtW/qw
         wTOeSsyHIaJk2Iifth/9faqhSxRYuKP15bLHVKCpIvhabgFbA/ksz05loP0mULJco7bN
         JKvlWrm35fGeDFZ/mK2WaGrUaG7HIOuvc/+6YN6KvOGTOEMO+XD6sDkNZu2941VDZP+q
         lxXxmYJP7FiJDNKovFWadcJzIZ0qcx3/7qqyjjbTiB7MrDi7/sTEYnZJDncLoESjzi6L
         L+Hg==
X-Gm-Message-State: AOJu0Yyktx+IbStXdICWk9Wpia3RFtJ9lOGrycKg3af2CBJcNcpEsg2C
        JkGHU5CZeiTegmZYmMtlS8MpHo8Wrp8wWlXs5ZM=
X-Google-Smtp-Source: AGHT+IEiJ8IsW81mPFa90w6D4O+18qHOmgxJoi7ipC9aQgKERivYTSr9EmfRyFNfQTY16gVIHG0EgLJEJN/6R6n8ods=
X-Received: by 2002:a0c:f049:0:b0:64f:716e:ec0a with SMTP id
 b9-20020a0cf049000000b0064f716eec0amr9660232qvl.8.1694315904300; Sat, 09 Sep
 2023 20:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com> <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
In-Reply-To: <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 10 Sep 2023 11:17:48 +0800
Message-ID: <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Sat, Sep 9, 2023 at 2:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 7, 2023 at 7:54=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Thu, Sep 7, 2023 at 10:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
> > >
> > > Hello Yafang.
> > >
> > > On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > In our specific use case, we intend to use bpf_current_under_cgroup=
() to
> > > > audit whether the current task resides within specific containers.
> > >
> > > I wonder -- how does this work in practice?
> >
> > In our practice, the cgroup_array map serves as a shared map utilized
> > by both our LSM programs and the target pods. as follows,
> >
> >     ----------------
> >     | target pod |
> >     ----------------
> >            |
> >            |
> >           V                                      ----------------
> >  /sys/fs/bpf/cgoup_array     <--- | LSM progs|
> >                                                   ----------------
> >
> > Within the target pods, we employ a script to update its cgroup file
> > descriptor into the cgroup_array, for instance:
> >
> >     cgrp_fd =3D open("/sys/fs/cgroup/cpu");
> >     cgrp_map_fd =3D bpf_obj_get("/sys/fs/bpf/cgroup_array");
> >     bpf_map_update_elem(cgrp_map_fd, &app_idx, &cgrp_fd, 0);
> >
> > Next, we will validate the contents of the cgroup_array within our LSM
> > programs, as follows:
> >
> >      if (!bpf_current_task_under_cgroup(&cgroup_array, app_idx))
> >             return -1;
> >
> > Within our Kubernetes deployment system, we will inject this script
> > into the target pods only if specific annotations, such as
> > "bpf_audit," are present. Consequently, users do not need to manually
> > modify their code; this process will be handled automatically.
> >
> > Within our Kubernetes environment, there is only a single instance of
> > these target pods on each host. Consequently, we can conveniently
> > utilize the array index as the application ID. However, in scenarios
> > where you have multiple instances running on a single host, you will
> > need to manage the mapping of instances to array indexes
> > independently. For cases with multiple instances, a cgroup_hash may be
> > a more suitable approach, although that is a separate discussion
> > altogether.
>
> Is there a reason you cannot use bpf_get_current_cgroup_id()
> to associate task with cgroup in your lsm prog?

Using cgroup_id as the key serves as a temporary workaround;
nevertheless, employing bpf_get_current_cgroup_id() is impractical due
to its exclusive support for cgroup2.

To acquire the cgroup_id, we can resort to open coding, as exemplified belo=
w:

    task =3D bpf_get_current_task_btf();
    cgroups =3D task->cgroups;
    cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
    key =3D cgroup->kn->id;

Nonetheless, creating an open-coded version of
bpf_get_current_ancestor_cgroup_id() is unfeasible since the BPF
verifier prohibits access to "cgrp->ancestors[ancestor_level]."

--
Regards

Yafang
