Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601097A3411
	for <lists+cgroups@lfdr.de>; Sun, 17 Sep 2023 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIQH3w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Sep 2023 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIQH3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Sep 2023 03:29:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EBD139;
        Sun, 17 Sep 2023 00:29:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-656351b6d74so11208556d6.0;
        Sun, 17 Sep 2023 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694935764; x=1695540564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UztY6Cngw+1MjErY3AcXouGizLW2/eHL4pwNAma3V7k=;
        b=fmrtSWwijJmREUyPRnXKjTTnahY7T0PsBPd4pN2QQ7zfztk43zzkYHMbo+/TGdUvUx
         7RE8LUa2hbSISx8NexCDvZg5K3Z+mXfBlf/rchw42OlrzMk81Q8scIhU9AEKSCUXVKZb
         MDAPQEgWviK2oBlb/vQlYLLcccKm7AtTU+8HEXgKrBHxM6mDw8o5gzTsCgg+x0uUZvCa
         UEmGwJMykEYyBXQMjzKu3mJEW3xtP/pT0R4aPJLTAmszV9fRHtGFG8x+tslqFDrZVfLM
         Ca0kviDiSRWo8Rjo7f1X9L00/U+gWKfiq5FW4CDHIfB4lPobts5D7OoK6dVR5Gb7lt6u
         Yd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694935764; x=1695540564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UztY6Cngw+1MjErY3AcXouGizLW2/eHL4pwNAma3V7k=;
        b=LWVjWnPW359X1luo/Y4qOAfLpbBZSI0AiIPgtZMe/mrkJKncgWeTjLB/6uFN+mK7sk
         Yw8gII5NxCSBFkucEJffXS9yyct+1aDWW8xM8adGUqfHCvh7gY+uv2s2LAh9OTJU/5Lo
         xxwr8GHcra7xXBEpTY5e7eIxTgpbyPRqwFsBtKxVVlYGdVgaFO1kDuepeE7p7kwt7+GC
         GpUuxFnvE0kHbG/CY/sGPUa+mfkispMNMLAumuaS5OFTKyUZZsJXA+qemr4WxniRnGJR
         hFpAn2T6zf7AceZIr30rnyvx04sN4BOjKjqQkS8tXryPVkR5NpzZjaLo0yoqMTudktY1
         cztQ==
X-Gm-Message-State: AOJu0Yx8QDtnHyPBqEaz5bNcZLF9I5oSZJYdYjKrMSxNqVQL/UGhT4MK
        CPl78LdIPjLnAvdAsZXJTyL4PYCtz5MAE67Absgi0Xcf0VpaPSmI
X-Google-Smtp-Source: AGHT+IFXKFyvj1t7E4o+uOtIcoul8vTE1Mo4G5L80Pv+NHAVqHAJu/1eYJ9+xMA+ROnGORjrAq9Tpe56MZXEBDVFKBE=
X-Received: by 2002:a0c:f14b:0:b0:647:35b7:4955 with SMTP id
 y11-20020a0cf14b000000b0064735b74955mr6623914qvl.52.1694935764655; Sun, 17
 Sep 2023 00:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org> <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
 <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez> <ZQSU_0RhpVw-Y0v2@mtj.duckdns.org>
In-Reply-To: <ZQSU_0RhpVw-Y0v2@mtj.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 17 Sep 2023 15:28:46 +0800
Message-ID: <CALOAHbDspQnOCFiYPjy34narygyApRQVnM1nZ+Qt2Cyq1VGx9Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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

On Sat, Sep 16, 2023 at 1:31=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Sep 15, 2023 at 07:01:28PM +0200, Michal Koutn=C3=BD wrote:
> > Hello.
> >
> > On Tue, Sep 12, 2023 at 11:30:32AM +0800, Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > With the above changes, I think it can meet most use cases with BPF o=
n cgroup1.
> > > What do you think ?
> >
> > I think the presented use case of LSM hooks is better served by the
> > default hierarchy (see also [1]).
> > Relying on a chosen subsys v1 hierarchy is not systematic. And extendin=
g
> > ancestry checking on named v1 hierarchies seems backwards given
> > the existence of the default hierarchy.
>
> Yeah, identifying cgroup1 hierarchies by subsys leave out pretty good chu=
nk
> of usecases - e.g. systemd used to use a named hierarchy for primary proc=
ess
> organization on cgroup1.

Systemd-managed tasks invariably have one or more cgroup controllers
enabled, as exemplified by entries like
"/sys/fs/cgroup/cpu/{system.slice, user.slice, XXX.service}".
Consequently, the presence of a cgroup controller can be employed as
an indicator to identify a systemd-managed task.

>
> Also, you don't have to switch to cgroup2 wholesale. You can just build t=
he
> same hierarchy in cgroup2 for process organization and combine that with =
any
> cgroup1 hierarchies.

The challenge lies in the need to adapt a multitude of applications to
this system, and furthermore, not all of these applications are under
our direct management. This poses a formidable task.

--=20
Regards
Yafang
