Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE257CD271
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJRCw0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCw0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 22:52:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D233A4;
        Tue, 17 Oct 2023 19:52:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cb76f3cf0so4918991cf.2;
        Tue, 17 Oct 2023 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697597543; x=1698202343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qElkA+zxQIebaUG8W2et9dcIHXvx+tdSh2/GiEiI4w=;
        b=O+lUo8adxat3y2peweYGQQoRwxoYChy0viJIOc91zUBfvulI6dLY9aZJ/dke/WCXwE
         hYEANcADM8/XrPGaSmQCPtTB1OCpOJDlB8SxK7OzIdtZpENQawAr5e5u3B6NgUviYU3z
         yOWUvfytpqyOqW7hTK7vZbecG/G44vr5klUIEFSgl1ieTlQusbAOK5I3/rAdUG37mkzl
         KiObu/Xa8NNrgOT9k+ckwJIw1/BH3b2XhEckNw7NkQxKRyLbAOqVie6kMNMzBSvPAmRS
         lSrnBgvbL4UeTuQAFTDjiA/5/rwpFFObqI6AT2ZWJB0SlbL8UjwzFtQuhXVCHL5beS7L
         jqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697597543; x=1698202343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qElkA+zxQIebaUG8W2et9dcIHXvx+tdSh2/GiEiI4w=;
        b=K6GbGtL4Iqdz/7dh3xZLXYOk3/cZIr3AsQMdBy+Z68ECPmnTwdNS0tIDiYOMbzK1vn
         L5lvR7xlh04TSl4y29ITOGZuGIvxWU6bG9ZGw0zsxf6zfRT9yLAojviGEf/Z1ktiDZy7
         y/ywJUr+MSU6EDtD+cMeX0dNv8J01SfyEFN4KeCPcpbxguY9jZhSyhxX4JyW42G3g7+l
         348NcmXKLRCMqvYHsUqpGUaENi5JJH7BMbbjGlXV01A3a1BjoBml1ztAZzPnbItseBjF
         X/F9RKYQSRi6fz1FClZoG/4rSxFwErfiEdZniAfwnZh68JrFtd/9ywHe3FLbQ4jbmZVs
         78Eg==
X-Gm-Message-State: AOJu0YxSjc2WpNTCakEWk0HmHl2ZWAR24rCmHkNhi56Bk+5/kYOFB5zq
        VJ2FzFNpLCyX16pqZCUWBT4bhrPNwANYa/1DaI0=
X-Google-Smtp-Source: AGHT+IEzKA+3F6z+XjvrFPyFYNwGNXlr2HVJYIEpXI446/Lwu18lyLzlmFYnb+mr9ky5p/kEfIaSZbIg0h0cFjXf4v4=
X-Received: by 2002:ac8:598f:0:b0:415:1683:9cf1 with SMTP id
 e15-20020ac8598f000000b0041516839cf1mr4618462qte.21.1697597543320; Tue, 17
 Oct 2023 19:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-2-laoar.shao@gmail.com>
 <q7yaokzrcg5effyr2j7n6f6ljlez755uunlzfzpjgktfmrvhnb@t44uxkbj7k5k>
In-Reply-To: <q7yaokzrcg5effyr2j7n6f6ljlez755uunlzfzpjgktfmrvhnb@t44uxkbj7k5k>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Oct 2023 10:51:47 +0800
Message-ID: <CALOAHbCP8HVs2UjuegLHvZSRHbfJ2ONMNC58AQxwVaNGSDYzOg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup
 root_list RCU safe
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

On Tue, Oct 17, 2023 at 9:20=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Oct 17, 2023 at 12:45:38PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > Therefore, making it RCU-safe would be beneficial.
>
> Notice that whole cgroup_destroy_root() is actually an RCU callback (via
> css_free_rwork_fn()). So the list traversal under RCU should alreay be
> OK wrt its stability. Do you see a loophole in this argument?

css_free_rwork_fn() is designed for handling the cgroup's CSS. When
the RCU callback is executed, this specific CSS is not accessible to
other tasks. However, the cgroup root remains accessible to other
tasks. For instance, other tasks can still traverse the cgroup
root_list and access the cgroup root that is currently being
destroyed. Hence, we must take explicit measures to make access to the
cgroup root RCU-safe.

>
>
> >  /* iterate across the hierarchies */
> >  #define for_each_root(root)                                          \
> > -     list_for_each_entry((root), &cgroup_roots, root_list)
> > +     list_for_each_entry_rcu((root), &cgroup_roots, root_list,       \
> > +                             !lockdep_is_held(&cgroup_mutex))
>
> The extra condition should be constant false (regardless of
> cgroup_mutex). IOW, RCU read lock is always required.

IIUC, the RCU read lock is not required, while the cgroup_mutex is
required when we want to traverse the cgroup root_list, such as in the
case of cgroup_attach_task_all.

>
> > @@ -1386,13 +1386,15 @@ static inline struct cgroup *__cset_cgroup_from=
_root(struct css_set *cset,
> >               }
> >       }
> >
> > -     BUG_ON(!res_cgroup);
> > +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
> >       return res_cgroup;
>
> Hm, this would benefit from a comment why !res_cgroup is conditionally
> acceptable.

The cgrp_cset_link is freed before we remove the cgroup root from the
root_list. Consequently, when accessing a cgroup root, the cset_link
may have already been freed, resulting in a NULL res_cgroup. However,
by holding the cgroup_mutex, we ensure that res_cgroup cannot be NULL.

Will add the comments in the next version.

>
> >  }
> >
> >  /*
> >   * look up cgroup associated with current task's cgroup namespace on t=
he
> > - * specified hierarchy
> > + * specified hierarchy. Umount synchronization is ensured via VFS laye=
r,
> > + * so we don't have to hold cgroup_mutex to prevent the root from bein=
g
> > + * destroyed.
>
> I tried the similar via explicit lockdep invocation (in a thread I
> linked to you previously) and VFS folks weren't ethusiastic about it.

Thanks for your information. will take a look at it.

>
> You cannot hide this synchronization assumption in a mere comment.

will think about how to address it.

--
Regards
Yafang
