Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E97AC6CE
	for <lists+cgroups@lfdr.de>; Sun, 24 Sep 2023 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIXGc7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 24 Sep 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXGc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 24 Sep 2023 02:32:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7605109;
        Sat, 23 Sep 2023 23:32:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6563c23b356so25491636d6.2;
        Sat, 23 Sep 2023 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695537172; x=1696141972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpxJPlID+SCs56C8IjY5nt1fLBEKnY3cZH9wb2ckaP8=;
        b=jL6NdW+nLX1RMVyTaV0poc9JFbgOZHEGMj8karfGXWD8NucfiM7Sd91vXaW5QyTYu2
         Zy/oNYTkIdETP2EsmWq7aQTeoLh+AqYFkx5awPhM6iTMOMcY+BAbDWSI8ZytqFPlwX6t
         gq5Sp6jjl77PlYmSzNseL+RAoVSwLEn85Iy1SPM+zUNHSOkSEBsBlPalFBlPCgDfkmsQ
         lY2lQrF17VE2GLdB0gbFbESl4MEI9boMa4TZLo7eSUwguaLVZtdkub87qb+sP7s9NnQC
         o/RufIPEXa25GPksYsFZAdOC2qoYxEiJ7YbC7ZyngHxF2maembS4KSs+C7nDsfQQaaxb
         eN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695537172; x=1696141972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpxJPlID+SCs56C8IjY5nt1fLBEKnY3cZH9wb2ckaP8=;
        b=Hrf0AdInMZrKV5LUFdtfCiJInXUUlPnV6kfsscAyokciRRDZK5qpoTDoFDQm4EOW4i
         3TSNuj6bD/iE8W9IoNp0xOUZhcyF+fRy5hRs/zuWv+134ZGtg8ls8tEoCbl4I+awRGr7
         cefeD+oken7LKaQgHTQiPeetKqXu/WCn3PCnrpOMqNNUdWM8uhCu6xdwK5xbxof4G2dV
         ZjDdfTaKWneP/DREuzVS9xLaeZHgROyoh8MjzUmr7ZaG+tG3Vyt0BTLcJgkIajTtVhMC
         xaX3CP7sI6vWdT0/e+ETXLL4La16mwUNECp0Pf2PavTQjkxoF+169+2A855ARv6LXHHc
         q/dQ==
X-Gm-Message-State: AOJu0YwIpRsZwpBnbYiznaUEE1ExqkHxRZxqOR7b6TCfofkeeMdqb01/
        iaIiOOLUBiX54mckOf/KzRBOOnX04SzFXQqigX8=
X-Google-Smtp-Source: AGHT+IG4iJb6ZapH+EJvQvCVW6z0mEXz+UEmqp29Mgj2lYIPut7HPUco4rtRh2jSapiCQ3Nq2VvfR6673ZCg3uBhRkQ=
X-Received: by 2002:a05:6214:d6b:b0:656:49a3:21ae with SMTP id
 11-20020a0562140d6b00b0065649a321aemr5845870qvs.15.1695537172064; Sat, 23 Sep
 2023 23:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230922112846.4265-1-laoar.shao@gmail.com> <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
In-Reply-To: <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 24 Sep 2023 14:32:14 +0800
Message-ID: <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
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

On Sat, Sep 23, 2023 at 12:52=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 22, 2023 at 11:28:38AM +0000, Yafang Shao wrote:
> > - bpf_cgroup_id_from_task_within_controller
> >   Retrieves the cgroup ID from a task within a specific cgroup controll=
er.
> > - bpf_cgroup_acquire_from_id_within_controller
> >   Acquires the cgroup from a cgroup ID within a specific cgroup control=
ler.
> > - bpf_cgroup_ancestor_id_from_task_within_controller
> >   Retrieves the ancestor cgroup ID from a task within a specific cgroup
> >   controller.
> >
> > The advantage of these new BPF kfuncs is their ability to abstract away=
 the
> > complexities of cgroup hierarchies, irrespective of whether they involv=
e
> > cgroup1 or cgroup2.
>
> I'm afraid this is more likely to bring the unnecessary complexities of
> cgroup1 into cgroup2.

I concur with the idea that we should avoid introducing the
complexities of cgroup1 into cgroup2. Which specific change do you
believe might introduce these complexities into cgroup2? Is it the
modification within task_under_cgroup_hierarchy() or
cgroup_get_from_id()?

In fact, we have the option to utilize
bpf_cgroup_ancestor_id_from_task_within_controller() as a substitute
for bpf_task_under_cgroup(), which allows us to sidestep the need for
changes within task_under_cgroup_hierarchy() altogether.

>
> > In the future, we may expand controller-based support to other BPF
> > functionalities, such as bpf_cgrp_storage, the attachment and detachmen=
t
> > of cgroups, skb_under_cgroup, and more.
>
> I'm okay with minor / trivial quality of life improvements to cgroup1 but
> this goes much beyond that and is starting to complications to cgroup2
> users, which I think is a pretty bad idea long term. I'm afraid I'm gonna
> have to nack this approach.
>
> Thanks.
>
> --
> tejun



--=20
Regards
Yafang
