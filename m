Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949687A3413
	for <lists+cgroups@lfdr.de>; Sun, 17 Sep 2023 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjIQHa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Sep 2023 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjIQHap (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Sep 2023 03:30:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2A186;
        Sun, 17 Sep 2023 00:30:40 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6563409d7c2so12324356d6.1;
        Sun, 17 Sep 2023 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694935839; x=1695540639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHboe8nA34+TWlqz42IVoMs0G+Rp7/msDkEqBjUm0qo=;
        b=bnrM6vELY9l2Q8Hxvlc7bvaVyeJI4bcW2g54ddAJF/B2UkLjz7FmorHubjqieJBaDu
         nsy/S1x9vZj+l5PLakfU55A3nWfDT+9LRJ1s/eiURB9qJt2KgrChdGWd17EL2QyA2Imn
         9Z4zuZMzcDYJQrRf3GPYIF3xlxXtgoP0mcUeK1k+ElV5Clrv1LvpPqq7jzkib7HrJ/nD
         wWfQUTH0sb36FSaqTAFYlvZlCnDYwuzgPJm4TKw658OxSWVywbIfYOmO7YWb05v2LM5W
         lhbtNstGFY0GAvBduZJgZ4DJzIG9SFEFf0H6IuTnkCg11GA3t85r1cxJnWvJ7OH73lUW
         siIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694935839; x=1695540639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHboe8nA34+TWlqz42IVoMs0G+Rp7/msDkEqBjUm0qo=;
        b=IXvLotbajtrGr1zG9eHScvBw2OYADEKWtjG6+xXd/C6icn7wZkcNtUCP3+EreixZFx
         aBIvZJKORjmS+yxDf2hnoy9dUrSfXg4DeMcnQpte2tDSFb5hyvNuiPNP8xvO0p78iW/3
         AxIzU+xtYal+ODXJzqZv5UkZ+0fbuCYqPlm8LV/krqg6HZV1sz2I0dUx3GShgcit7QPA
         kygd90nFk2+FeFZjXe/v6WxIluzso8b4ddOk6OK6smk0YNVEkPwCnidfRF0LMjWWEKV/
         gljq74iDPuN8koqP0EWT5UnNjw91aPPMsjdb3fqTXT2Sx35syH/qarDWfbnqdRT6qbuU
         TrQQ==
X-Gm-Message-State: AOJu0YyPB757mvCnTtEWKaL2po3a9ynfJHu/PZWUi8qAJi+KZDRac3od
        Kd3/TYpoUTqjfj1d3KqdoNISKGojq0uWGHzidPA=
X-Google-Smtp-Source: AGHT+IEdtZPbxcCu1aE5YY4gCTN5TPLXm2UZndKbvCU3l3gT+owKRWVE8u4yi6benAyozDXj/C/8JD5XjdbaSwZMJvg=
X-Received: by 2002:a0c:de07:0:b0:656:3c43:6bc5 with SMTP id
 t7-20020a0cde07000000b006563c436bc5mr5430699qvk.7.1694935839502; Sun, 17 Sep
 2023 00:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org> <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
 <CA+khW7hah317_beZ7QDA1R=sWi5q7TanRC+efMhivPKtWzbA4w@mail.gmail.com>
In-Reply-To: <CA+khW7hah317_beZ7QDA1R=sWi5q7TanRC+efMhivPKtWzbA4w@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 17 Sep 2023 15:30:01 +0800
Message-ID: <CALOAHbAYTYasEHgd9C2Oc8yznR9bR9Q2M-QS9vzBpOYvmG7F+w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     Hao Luo <haoluo@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 16, 2023 at 2:57=E2=80=AFAM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Sep 11, 2023 at 8:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Sep 12, 2023 at 4:24=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > On Sun, Sep 10, 2023 at 11:17:48AM +0800, Yafang Shao wrote:
> > > > To acquire the cgroup_id, we can resort to open coding, as exemplif=
ied below:
> > > >
> > > >     task =3D bpf_get_current_task_btf();
> > > >     cgroups =3D task->cgroups;
> > > >     cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
> > > >     key =3D cgroup->kn->id;
> > >
> > > You can't hardcode it to a specific controller tree like that. You ei=
ther
> > > stick with fd based interface or need also add something to identify =
the
> > > specifc cgroup1 tree.
> >
> > As pointed out by Alexei, I think we can introduce some
> > cgroup_id-based kfuncs which can work for both cgroup1 and cgroup2.
> >
> > Something as follows (untested),
> >
> > __bpf_kfunc u64 bpf_current_cgroup_id_from_subsys(int subsys)
> > {
> >         struct cgroup *cgroup;
> >
> >         cgroup =3D task_cgroup(current, subsys);
> >         if (!cgroup)
> >             return 0;
> >         return cgroup_id(cgroup);
> > }
> >
>
> Can we also support checking arbitrary tasks, instead of just current?
> I find myself often needing to find the cgroup only given a
> task_struct. For example, when attaching to context switch, I want to
> know whether the next task is under a cgroup. Having such a kfunc
> would be very useful. It can also be used in task_iter programs.

Agree. Will do it.

--=20
Regards
Yafang
