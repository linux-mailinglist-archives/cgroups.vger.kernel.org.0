Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB07BCBBD
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjJHChJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 22:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJHChI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 22:37:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EEBA;
        Sat,  7 Oct 2023 19:37:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65af7d102b3so22411346d6.1;
        Sat, 07 Oct 2023 19:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696732624; x=1697337424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A7C6iBOceRhCdcoICp64Dsf0M93ye97XtgUpFujJE4=;
        b=DKgSGxIf6fWPa4p+Va3xMb/vb3e3ymHeWr0uJ1kttIN6ierR3PhkJ0/7OTv1eUwxaW
         FORJH+2t6YITmHny4umxdAaDq8IKYiCAHbQ/Q3mqyB+byz9Wx6HvE3k73B8a/n7MkfLB
         l8nAeyNt5vqdFo+5Lu27l8gtN4IIhhewWqU95rpT23n0P3y4eOWZ9XtsVzD5/5WRa50/
         BWanwM9Zf8TkToDgKvoLvCKR7aPlG45OvRVLYMwcy4mH33AfeKHp9Wi8MDO5ALJfL7O0
         XXuQUir3MaocLkAP2Qj8V5sA+DnrK0Mtvby2kJMOmTwna3NDoiHfVlMJ0uPP1TSS51D4
         rXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696732624; x=1697337424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A7C6iBOceRhCdcoICp64Dsf0M93ye97XtgUpFujJE4=;
        b=oBApBpJxDu33Lco1H44SxO14hCEsrgd87EFlphavFJ4MvoR+38uJZbCLFgxNCffvlw
         D4jKm9WKeSlaCM/KqsIqMwQ4jJMgYSDhTypWmdt743UfafJChhmXHg/6U2/IA7OLS5Bu
         xUog4VN2Jcxm3vKG1OB0xs5K688oMFw8JwTiMc447QWIF64CtnTIkqyBgfBHlBdHXggU
         kj3/4ugPwQxPuTMZt0fT6diGpO7JVCJVhli4oYQeJYqel1d+yAmTGoO9U41wJ0qkrZGr
         +kGhdwHt7Qm9siQmVLmzdoYvbT9o+yUFL9sB94E7vBcjDw0bcZxtKzJo2uvAsdUamZtu
         VeDQ==
X-Gm-Message-State: AOJu0YxOYvvKkTgAu2b5nGkhHaF31slTmnGLa/6RY8WInvNAJIqpwkB4
        SETMwJYzY6r3kN9h8HVcexEptf1hVVTafeGWF/Q=
X-Google-Smtp-Source: AGHT+IH61GUWBmiS/PjzGywjVQovWZn2AYKhGCamjcfIrZIn59TmoowBjT8PnWs2p8NMU2h6Ai/vcq9xc7fPpX2Sx4c=
X-Received: by 2002:a0c:ab06:0:b0:65a:fedd:3c69 with SMTP id
 h6-20020a0cab06000000b0065afedd3c69mr11430436qvb.0.1696732624409; Sat, 07 Oct
 2023 19:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-3-laoar.shao@gmail.com>
 <ZSF_daEXs8xpvlo0@slm.duckdns.org>
In-Reply-To: <ZSF_daEXs8xpvlo0@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 8 Oct 2023 10:36:27 +0800
Message-ID: <CALOAHbDCm_x-WK_ia5Z2Xa+LZhvsZPx0yeC7i5HXyv-m7Q7e3w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1 hierarchy
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 7, 2023 at 11:55=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sat, Oct 07, 2023 at 02:02:58PM +0000, Yafang Shao wrote:
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index b307013b9c6c..65bde6eb41ef 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -71,6 +71,8 @@ struct css_task_iter {
> >  extern struct file_system_type cgroup_fs_type;
> >  extern struct cgroup_root cgrp_dfl_root;
> >  extern struct css_set init_css_set;
> > +extern struct list_head cgroup_roots;
> > +extern spinlock_t css_set_lock;
>
> css_set_lock was already out here but why do we need to move cgrou_roots =
to
> this header?

Ah, shouldn't export cgrou_roots. Thanks for pointing it out.

>
> > +/**
> > + * task_cgroup_id_within_hierarchy - Retrieves the associated cgroup I=
D from
> > + * a task within a specific cgroup1 hierarchy.
> > + * @task: The task to be tested
> > + * @hierarchy_id: The hierarchy ID of a cgroup1
> > + *
> > + * We limit it to cgroup1 only.
> > + */
> > +u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hier=
archy_id)
> > +{
> ...
> > +}
> > +
> > +/**
> > + * task_ancestor_cgroup_id_within_hierarchy - Retrieves the associated=
 ancestor
> > + * cgroup ID from a task within a specific cgroup1 hierarchy.
> > + * @task: The task to be tested
> > + * @hierarchy_id: The hierarchy ID of a cgroup1
> > + * @ancestor_level: level of ancestor to find starting from root
> > + *
> > + * We limit it to cgroup1 only.
> > + */
> > +u64 task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *tsk,=
 int hierarchy_id,
> > +                                           int ancestor_level)
> > +{
> ...
> > +}
>
> I'd much prefer to have `struct group *task_get_cgroup1_within_hierarchy(=
)`
> then the caller can do cgroup_ancestor() itself.

Good suggestion. will do it in the next version.

--=20
Regards
Yafang
