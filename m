Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1767A26B6
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjIOS6l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjIOS6O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 14:58:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0D2D6B
        for <cgroups@vger.kernel.org>; Fri, 15 Sep 2023 11:57:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ff985e292so620520f8f.1
        for <cgroups@vger.kernel.org>; Fri, 15 Sep 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694804256; x=1695409056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEGyk9aimWeGVbqBDG5yx1Ea1IhyMQsNWatyoWMLY8=;
        b=dY9jggijZ+uU4ytjXw5vqNvsdoRFFYoR4wT+b2nYenO+ihE5BpwKiJjJ5OQggRUW+0
         0efTP4vGgelj4dko9e7ygo3nK3azUMfv698qZ730JytLdCR2zs5KocemkJ82BInsVLIr
         qvBQ2cSCND7hxwY/Ft/n4LcuWtnkaaC5RHCzbfjeqWrSV6A17ZfP9iI9R0mc4S2W1Jf3
         4pPoyDwhlKS4iFhYkcNtOF/GQLVLGZSlt2D6jKN+c7j6DPkDqgNvRf9URec/6fM5ikMf
         ZU0pCWe1Pp4GxsMMhN2U+wi4pmiyzdPwoguJaUKp8UmLDgFBr3ENlPp+cbtUPcJPNILu
         c7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804256; x=1695409056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vEGyk9aimWeGVbqBDG5yx1Ea1IhyMQsNWatyoWMLY8=;
        b=BKNUMHaIP4O1HnHGNiif3kwDyEEnSpliVgyvPEvSQ/I5S0Qq6uN8n5fp4ttWfgYdcs
         ep/jhO1Sgdzu0DhUzgvrCjIqUYW1KSXYxTT1pHR55CxN/FXsom0s1setnmjuOsjHtC6b
         QQPa73iybwQi3LrlD/Vp5TQF/xVmAo3SQT6vLF7F0JnUl+15iQ/qcmEiW9qWI/NUo/tj
         lzR0oEdOyLpxklX/0pnjz9IfJuA0FFrUCk5MVrOd2sfEM9ahhgOf02oci9AxOTbtIoBs
         Zr6qysIPYcBYuR1UzOkKxfQ1KIOF0sRzcPzxEIVGprfIDc6Fw6hVXcLQDLrPU7NA2dQp
         fh3g==
X-Gm-Message-State: AOJu0YxplYUjjNf15zAuN7huXkkaZY/rRa8z0zQpj6fRnABeYEwj8yUl
        3pTjXvzM9+2g4deCZnpTFB3KMU/XoKUYk/D7EqNmqQ==
X-Google-Smtp-Source: AGHT+IFlksvjyzSEvarhPqlfaj6XF/zIYj46uIyePCmqFCxffGT4/gGEPVHY7vFw4ORaKjihuFk0NLkrAPjPwY19wR4=
X-Received: by 2002:adf:a30d:0:b0:31f:fa38:425f with SMTP id
 c13-20020adfa30d000000b0031ffa38425fmr1227612wrb.9.1694804256023; Fri, 15 Sep
 2023 11:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org> <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
In-Reply-To: <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 15 Sep 2023 11:57:23 -0700
Message-ID: <CA+khW7hah317_beZ7QDA1R=sWi5q7TanRC+efMhivPKtWzbA4w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Sep 11, 2023 at 8:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Sep 12, 2023 at 4:24=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sun, Sep 10, 2023 at 11:17:48AM +0800, Yafang Shao wrote:
> > > To acquire the cgroup_id, we can resort to open coding, as exemplifie=
d below:
> > >
> > >     task =3D bpf_get_current_task_btf();
> > >     cgroups =3D task->cgroups;
> > >     cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
> > >     key =3D cgroup->kn->id;
> >
> > You can't hardcode it to a specific controller tree like that. You eith=
er
> > stick with fd based interface or need also add something to identify th=
e
> > specifc cgroup1 tree.
>
> As pointed out by Alexei, I think we can introduce some
> cgroup_id-based kfuncs which can work for both cgroup1 and cgroup2.
>
> Something as follows (untested),
>
> __bpf_kfunc u64 bpf_current_cgroup_id_from_subsys(int subsys)
> {
>         struct cgroup *cgroup;
>
>         cgroup =3D task_cgroup(current, subsys);
>         if (!cgroup)
>             return 0;
>         return cgroup_id(cgroup);
> }
>

Can we also support checking arbitrary tasks, instead of just current?
I find myself often needing to find the cgroup only given a
task_struct. For example, when attaching to context switch, I want to
know whether the next task is under a cgroup. Having such a kfunc
would be very useful. It can also be used in task_iter programs.

Hao
