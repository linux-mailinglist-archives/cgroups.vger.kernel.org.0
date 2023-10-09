Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE77BDDA5
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376995AbjJINL5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377039AbjJINLd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 09:11:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9103E10D2;
        Mon,  9 Oct 2023 06:10:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b0dad1f98so30137356d6.0;
        Mon, 09 Oct 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696857041; x=1697461841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF4Xq74YABdO/1MGMVceT5V4Cxq8Bc9WrNlmL9HlSME=;
        b=i/d530lIehi2JsIFsodGmmwJTks7xPGSNoiEZ4fPTv1qo1E8LbF1hcEOHcAmGSjBBG
         NyxBVlBDQhoFFYcjNCW/sNs6lfDzLjK2X95WXXH3cJNNbVrBWDD+HeNwVxCDeueQpeAf
         EZbiqBKtOPKd00fsOwmIbePp7rhpfO9tsct0BJ4BRuvzF9jEW6H5kfVTkadk32oG53iu
         Q55d63dGc91R1Pq3x5qUe2Oe1noaJNbpEx3U1X3YHMzAogTb58VFu2qCStKafM6iIILd
         tC4jacG2iiKOdnjwpb74M/gliQA3h7ppDaUteFcEoTCbY+NgmcAOelxMNqUqDSSPRdx2
         XYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857041; x=1697461841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF4Xq74YABdO/1MGMVceT5V4Cxq8Bc9WrNlmL9HlSME=;
        b=TA57BC88dMDru0pOOwTOVhkYkwLqU6Lo/lmbLOH/uO2x1Q+LZ5SXS9Fmid8bVqL5tt
         8Nau19ahXzgyn76RUxlNPHJOz8hq48TZfc7tNO3fgOWOcB/1EvW3jIUPJj3eHPLqe9xV
         Y2XfGkLzPvmzM1q5S9e60pYtxmrQQemmfrRFbJIjrIxxqYPN9DNPYtw4AFe35Vd7KaKO
         Y+HxIoILRv0HKKnMyS3m4QCDI4iSeOiA3i70Mf2YdFfqj5M9Kp6B6MTShf5Y1JyvPGcK
         OXiiakAqSGu7axSXHgiV5eEF6hKL2C373VlMP6t3cxXNZiq/picam8Zo3sOpwIIr0bqO
         jMlQ==
X-Gm-Message-State: AOJu0YyznU6Ty7sXdSTiIoeeADMSMBiA9RQAwwAwcF0JgLx6aWyqKHqc
        UdOx0BHCJKoQ4sZasLbGSzSdKow87RnQ27HoHbiSTupZUeyRlg==
X-Google-Smtp-Source: AGHT+IGIrhGiv/wMI769r0JRp9aiFdWk/edGN8ihq6OdGtOnRX8iJ9uvOg/1gRp1Tmq5Ok3cMR3CI/OJ4YMpLq4h9v0=
X-Received: by 2002:ad4:57a1:0:b0:65d:d:a114 with SMTP id g1-20020ad457a1000000b0065d000da114mr15483391qvx.55.1696857041093;
 Mon, 09 Oct 2023 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-3-laoar.shao@gmail.com>
 <5ne2cximagrsq7nzghbsmimrskz77drkj4ax2ktyawquvu2r77@dl4tujtwlnec>
In-Reply-To: <5ne2cximagrsq7nzghbsmimrskz77drkj4ax2ktyawquvu2r77@dl4tujtwlnec>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 9 Oct 2023 21:10:04 +0800
Message-ID: <CALOAHbDdWtM8+vePYm71xtX_w_6fAANTV6qAkqC-vaiLe0Gmog@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1 hierarchy
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
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

On Mon, Oct 9, 2023 at 7:32=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> On Sat, Oct 07, 2023 at 02:02:58PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > Two new helpers are added for cgroup1 hierarchy:
> >
> > - task_cgroup1_id_within_hierarchy
> >   Retrieves the associated cgroup ID of a task within a specific cgroup=
1
> >   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
> > - task_ancestor_cgroup1_id_within_hierarchy
> >   Retrieves the associated ancestor cgroup ID of a task whithin a
> >   specific cgroup1 hierarchy. The specific ancestor level is determined=
 by
> >   its ancestor level.
> >
> > These helper functions have been added to facilitate the tracing of tas=
ks
> > within a particular container or cgroup in BPF programs. It's important=
 to
> > note that these helpers are designed specifically for cgroup1.
>
> Are this helpers need for any 3rd party task?

Yes, for example, we can check if the *next* task in sched_switch
belongs to a specific cgroup.

Hao also pointed out the use case of a 3rd partry task[1].

[1]. https://lore.kernel.org/bpf/CA+khW7hah317_beZ7QDA1R=3DsWi5q7TanRC+efMh=
ivPKtWzbA4w@mail.gmail.com/

>
> I *think* operating on `current` would be simpler wrt assumptions needed
> for object presense.
>
>
> > +u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hier=
archy_id)
> > +{
> > +     struct cgroup_root *root;
> > +     struct cgroup *cgrp;
> > +     u64 cgid =3D 0;
> > +
> > +     spin_lock_irq(&css_set_lock);
> > +     list_for_each_entry(root, &cgroup_roots, root_list) {
>
> This should be for_each_root() macro for better uniform style.

will use it in the next version.

--=20
Regards
Yafang
