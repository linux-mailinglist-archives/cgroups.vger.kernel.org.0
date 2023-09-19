Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A07A5978
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 07:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjISFnn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 01:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISFnm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 01:43:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E5FC;
        Mon, 18 Sep 2023 22:43:34 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65642ade0easo17995936d6.1;
        Mon, 18 Sep 2023 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695102214; x=1695707014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjesQVNT+DryUaqUKb0b5eBDwkWp5Kc/txf22mT/W50=;
        b=ByU+hHD2ibDMiavw4fx/O70zZc6sLQPLvAG/Y8jMEeH/YjzVmYjqHLCv6/dPI5bEoT
         V6ujSVCHrP89biolx2TDZ963j60/GP3unO1c4k9MNb52z1eL+DTdXMKlFzrfcnMKUV5w
         i9Vf5QKXrmGF5/WqBOPl0BkaImpcPB+Q+/dKsh83BybcAj4crOPFlSizsxkVPCOmmL+R
         ncKE5QIyIhuc1irLwu+ugyOtv1SJYJvc0TAgkFSOqwMDQGNfPw+g/bWtpROsbc9nklNb
         OLnh5McSaqdYeMK/AxYW4LHQ+culH7ZZXPMngxc6J9doZ7aqqQkxVmop2yk7r4vli0We
         Krxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102214; x=1695707014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjesQVNT+DryUaqUKb0b5eBDwkWp5Kc/txf22mT/W50=;
        b=I/WYwfTP0ffzMXkEzRIJJfDWh0EW2I7UmjQtLWfqui3F6rMVHdMu9vt+e24E0P9KDD
         +l7ybAGOVsTEeX9LiGHV49qo7oN/Hwyle7bA9JMBvoZD/AepmEeApiTfo2n1E+gckRGr
         bo73zBRHzS1sJH16L9hUPzjCEilG4RP5JzAl97Bi1ltlg9GspwMfVju/KVbcQ5xRZPks
         aFZhl5dD8j1fsDeOnDI1gU6XPFQfnfrJWZISFCH9ZEXykjJYJQv07O5g+QZHJKUl2SST
         0t9KRQ7VDj4b3sCZG2B4KCb7qW/anLND8X4RsG8XTFjKW7pLV8fpDy/WUSAOaCPspR1L
         zlCQ==
X-Gm-Message-State: AOJu0Yw1UDG4lY80IrBLJTJTl4U3qvAfLn5+G6G/yOCPzDxbIxvEhD7n
        y7MMzyHWvPvJ0gKz560mdk+nHcE4zJgXy58bVRM=
X-Google-Smtp-Source: AGHT+IEocmxoe+7svG20ot8HPLzzr0JwTBXheGFmsXDiCTynxBaGuwi5Y8zP2wb87ZbZvKzhYGKW63sjG81U0RaZDbE=
X-Received: by 2002:a0c:f3d3:0:b0:656:28b1:16c6 with SMTP id
 f19-20020a0cf3d3000000b0065628b116c6mr12006704qvm.2.1695102213947; Mon, 18
 Sep 2023 22:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <20230903142800.3870-2-laoar.shao@gmail.com>
 <ysajseo5a5dashpz4dtkdpthtdww4m6wpgtgpakbtlbqoy7cvg@53fx3pou6hrl>
In-Reply-To: <ysajseo5a5dashpz4dtkdpthtdww4m6wpgtgpakbtlbqoy7cvg@53fx3pou6hrl>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 19 Sep 2023 13:42:57 +0800
Message-ID: <CALOAHbBD32gk5ztVBfXoM+mVWXeXre2Pma6Lvk0BZuvQQtAQ0Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable task_under_cgroup_hierarchy()
 on cgroup1
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
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

On Mon, Sep 18, 2023 at 10:45=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Sun, Sep 03, 2023 at 02:27:56PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >  static inline bool task_under_cgroup_hierarchy(struct task_struct *tas=
k,
> >                                              struct cgroup *ancestor)
> >  {
> >       struct css_set *cset =3D task_css_set(task);
> > +     struct cgroup *cgrp;
> > +     bool ret =3D false;
> > +     int ssid;
> > +
> > +     if (ancestor->root =3D=3D &cgrp_dfl_root)
> > +             return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> > +
> > +     for (ssid =3D 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
>
> This loop were better an iteration over cset->cgrp_links to handle any
> v1 hierarchy (under css_set_lock :-/).

Agree. That is better.

>
> > +             if (!ancestor->subsys[ssid])
> > +                     continue;
> >
> > -     return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> > +             cgrp =3D task_css(task, ssid)->cgroup;
>
> Does this pass on a lockdep-enabled kernel?

Yes, the lockdep is enabled.

>
> See conditions in task_css_set_check(), it seems at least RCU read lock
> would be needed (if not going through cgrp_links mentioned above).

All the call sites of it are already under RCU protection, so we don't
need to explicitly set RCU read lock here.

--=20
Regards
Yafang
