Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051247BCBBF
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjJHCiP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 22:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJHCiO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 22:38:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C74BA;
        Sat,  7 Oct 2023 19:38:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b02e42399so20806446d6.3;
        Sat, 07 Oct 2023 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696732692; x=1697337492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86WyTUgqN5Dtt65DGNX3FHZX1R93hWr/AkDXdY/Ehyw=;
        b=dboDLNGJSP1ZG30AFPl9G/nqC5/eBAYutz/Xq0mZRm/RD/qxLOihwWTUUAJdZ4FGgF
         oUXb3cjdrabn6BhQ8jRZukF21i9ISjAYVUlz8gTJiSOwAGKOoa/vSzAbodoQeJn6Zdny
         +eALTHP7zRh7DHOS9Y0RZVTzkgkCLiX2SnaN/AldJqExdW7Ve4AC3wmH6teGGo3HG9BB
         SN8JaUG4tvtssRYGDoDtuUTSOuxBYnh/uXX5IztzvMISZO4xH+ktcwffIS6PcbT/TWLX
         6W8EyYWdY3+RzUSphrBOz3LRALflSwO02dPv5Ian0b8F/tuWH1LYzqPYDL9TvURCll1m
         8i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696732692; x=1697337492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86WyTUgqN5Dtt65DGNX3FHZX1R93hWr/AkDXdY/Ehyw=;
        b=rMinfTXNNb/wI74BAm3DIZ3r2TVIyf6ujssuvtIjt6sfL2oi7oyqiB4CBi0shcEJ3f
         wspI8RdmdRcHRrpZJvx1bQ590hWWAwSWb3Aj38kaE3WiMKAjLZ8zoFaq3nh2zrDxHu4u
         pGvubFLrRd6fe/x8lpGiZGi0vd/XySKq4pXZBvEYv0yCyR/1LHT5zD8+Hun9Xx6DI/l2
         w0wEqidRlAlAQT9VMM1wErxbDH9iXP5jN5Z2ejnFfEpAhZrTn691zpyxJ96h2CUpbAvy
         tlzeHaSu81I3GjuDXVoEOvObQj7MExjmmeRb8XSs72sxp0s+eHkEierFAVkPz8Idqy6u
         2ruQ==
X-Gm-Message-State: AOJu0Yz2oSSzaRiYj8yNT8PLK5cltiJ809aoMlWmy+6EUi5GZZTJyImE
        f3YS4WhJb+FbsFMbTyI+8VCK9zbOb+B3SrzAbYI=
X-Google-Smtp-Source: AGHT+IGfVgcmJtRnnO44XdFCEgPpsKv4E4c7Pt/RgyhWSK10IrLPZslHUhm5O6hixiVrFdQ5CJaULcGAowZNF1Kc3rA=
X-Received: by 2002:a05:6214:5709:b0:668:d7e3:8460 with SMTP id
 qn9-20020a056214570900b00668d7e38460mr14234698qvb.26.1696732692629; Sat, 07
 Oct 2023 19:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-4-laoar.shao@gmail.com>
 <ZSGAACHHNAYbk34i@slm.duckdns.org>
In-Reply-To: <ZSGAACHHNAYbk34i@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 8 Oct 2023 10:37:36 +0800
Message-ID: <CALOAHbBDAT2QdKeWDCNLkc7Q8L9R57PF=nnTM6nzbpAyGx_8MQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/8] bpf: Add kfuncs for cgroup1 hierarchy
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
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

On Sat, Oct 7, 2023 at 11:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, Oct 07, 2023 at 02:02:59PM +0000, Yafang Shao wrote:
> > +
> > +/**
> > + * bpf_task_cgroup_id_within_hierarchy - Retrieves the associated cgro=
up ID of a
> > + * task within a specific cgroup1 hierarchy.
> > + * @task: The target task
> > + * @hierarchy_id: The ID of a cgroup1 hierarchy
> > + */
> > +__bpf_kfunc u64 bpf_task_cgroup1_id_within_hierarchy(struct task_struc=
t *task, int hierarchy_id)
> > +{
> > +     return task_cgroup1_id_within_hierarchy(task, hierarchy_id);
> > +}
> > +
> > +/**
> > + * bpf_task_ancestor_cgroup_id_within_hierarchy - Retrieves the associ=
ated
> > + * ancestor cgroup ID of a task within a specific cgroup1 hierarchy.
> > + * @task: The target task
> > + * @hierarchy_id: The ID of a cgroup1 hierarchy
> > + * @ancestor_level: The cgroup level of the ancestor in the cgroup1 hi=
erarchy
> > + */
> > +__bpf_kfunc u64 bpf_task_ancestor_cgroup1_id_within_hierarchy(struct t=
ask_struct *task,
> > +                                                           int hierarc=
hy_id, int ancestor_level)
> > +{
> > +     return task_ancestor_cgroup1_id_within_hierarchy(task, hierarchy_=
id, ancestor_level);
> > +}
>
> The same here. Please make one helper that returns a kptr and then let th=
e
> user call bpf_cgroup_ancestor() if desired.

Sure, will do it.

--=20
Regards
Yafang
