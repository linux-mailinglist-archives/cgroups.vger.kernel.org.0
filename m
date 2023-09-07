Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D36796F27
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 05:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjIGDFu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Sep 2023 23:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDFt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Sep 2023 23:05:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97710C8;
        Wed,  6 Sep 2023 20:05:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-770819c1db6so31077985a.2;
        Wed, 06 Sep 2023 20:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694055944; x=1694660744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5MIjMQMX2WC54VYKndKY8gzL7KZXv1MaBOxpFihvKs=;
        b=MUYRNsvkgRvNLbNezytyfB57g8aQ/7Wj3l8H3BncrFl4yqp58NciPyzd/ezHwXtfHh
         AaJ0x7ZvrDbUoAZN6edODI8ko1sksufQ5v8DzA0PU2b2j3+oIW4v+5DQBZZHrqSDv/yX
         MVpVh4zbSHcq6iAva5Zn2r1Ih+Cxqk6YD20zBJaNR1+AOqwsHkfjrotJDfoQU4caiMsr
         7yvRbkI+LnSWK8ISsm1z2DVe0icdZoCyM9phYV7Y14+AUx9Q3GtCrF6eRmlEtm9yfgHB
         tzbZlncAimHKYP1yiLwWCNZ9GKEwLmKSYz3wIeowG8Pv/Xst2FXnzDqBTQmoVkD7vqXD
         XTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694055944; x=1694660744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5MIjMQMX2WC54VYKndKY8gzL7KZXv1MaBOxpFihvKs=;
        b=QCQP8NfPplTGEbUt4WaXd6ghoK/3xoRMwHv0vpNApC3M2hDWoDGgtHyonqYyoMdFBS
         hZmRuRUn3BfCmnlKC7SlmWAQlJ5xTX3FxNPdujnFqA1aHZzFZVQpRxFjiXDYdlfp9QNB
         HUEGeR3Gf0dWCxLbVI6I7GGLI25lsBqNx0Eh5WJnxr34bQel3KRmqWamHUGRTKiBjRYn
         HILdksKEWd45hr5Lc+P9+P+qtCubg9BbpvHbUDtWY3xT36d2zkDX8Z9Rs6OMPGRz0Pa/
         9NrcDiCOiKXOyp4zpEECESidAEd8zhRRJiNOy8r/Ws39vjKfzUlKe0xTJ87pIB5dj8xC
         28xQ==
X-Gm-Message-State: AOJu0YyPHaR/rwDhFANpk3azrlas2+mZzq+1YVDKvOqRTCQIpgw+60aU
        2W/HdYjSiPI+AwI/qZrFoAWCXRR25Gq98FhiPzk=
X-Google-Smtp-Source: AGHT+IGaI1jkOsFK8idbW802EFCo6EFcy0HFLXuBQKcPdm/Y0h5o5hYJFB4Yw/1W2vleCveBcrDhJQoFofNJ5QSxvow=
X-Received: by 2002:a05:620a:248a:b0:76d:a6e3:8a78 with SMTP id
 i10-20020a05620a248a00b0076da6e38a78mr21226256qkn.56.1694055944438; Wed, 06
 Sep 2023 20:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <20230903142800.3870-2-laoar.shao@gmail.com>
 <ZPjdc3IwX9gjXk_F@slm.duckdns.org>
In-Reply-To: <ZPjdc3IwX9gjXk_F@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Sep 2023 11:05:07 +0800
Message-ID: <CALOAHbA7gDFh5Bsr_99-rBa3h9dZw6ntF_+RxTjfK3yQXpYEFA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable task_under_cgroup_hierarchy()
 on cgroup1
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
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

On Thu, Sep 7, 2023 at 4:13=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, Sep 03, 2023 at 02:27:56PM +0000, Yafang Shao wrote:
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
> > +             if (!ancestor->subsys[ssid])
> > +                     continue;
> >
> > -     return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> > +             cgrp =3D task_css(task, ssid)->cgroup;
> > +             if (!cgrp)
> > +                     continue;
> > +
> > +             if (!cgroup_is_descendant(cgrp, ancestor))
> > +                     return false;
> > +             if (!ret)
> > +                     ret =3D true;
> > +     }
> > +     return ret;
>
> I feel ambivalent about adding support for this in cgroup1 especially giv=
en
> that this can only work for fd based interface which is worse than the ID
> based ones.

The fd-based cgroup interface plays a crucial role in BPF programs,
particularly in components such as cgroup_iter, bpf_cgrp_storage, and
cgroup_array maps, as well as in the attachment and detachment of
cgroups.

However, it's important to note that as far as my knowledge goes,
bpf_cgrp_storage, cgroup_array, and the attachment/detachment of
cgroups are exclusively compatible with the cgroup fd-based interface.
Unfortunately, all these functionalities are limited to cgroup2, which
poses challenges in containerized environments.

In our pursuit of enabling seamless BPF integration within our
Kubernetes environment, we've been exploring the possibility of
transitioning from cgroup1 to cgroup2. This transition, while
desirable for its future-forward nature, presents complexities due to
the need for numerous applications to adapt.

We acknowledge that cgroup2 represents the future, but we also
understand that such transitions require time and effort.
Consequently, we are considering an alternative approach. Rather than
migrating to cgroup2, we are contemplating modifications to the BPF
kernel code to ensure compatibility with cgroup1. Moreover, it appears
that these modifications may entail only minor adjustments, making
this option more palatable.

> Even if we're doing this, the above is definitely not what we
> want to do as it won't work for controller-less hierarchies like the one
> that systemd used to use.

Right. It can't work for /sys/fs/cgroup/systemd/.

> You'd have to lock css_set_lock and walk the
> cgpr_cset_links.

That seems better. Will investigate it.  Thanks for your suggestion.

--
Regards
Yafang
