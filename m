Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A57CF036
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjJSGjb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjJSGja (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 02:39:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F879116;
        Wed, 18 Oct 2023 23:39:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7741b18a06aso551387085a.1;
        Wed, 18 Oct 2023 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697697568; x=1698302368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9ZsHqJLwA+8C0bKpNAFMlm9CdR6RyXfCZFn1e/5/2w=;
        b=JbJM/W4+rljHwMTvsjKCmcMpYvUW6Nuh37aq/uOB7Nx0Hq4f4QC3fb2hW8mTYh7ivn
         trZi0Hec1HF1OSzeIjFFxPlp8xWEXznfUytde3KMf/hj6qjxI2dZyIRQgrlylMNdB7eF
         wSBreeikFVeFUbOx/cOWf7dCaF4MiksmgO/8clq2T5iKmueWLYTSVOURp9oU7j8bSClY
         sMCCXqsergGUqH08BSEmvKkdvzNdtOLgkX6A56Ftvu1qnKyIW6h7QTgmuFZck5WHBLDp
         xPqb5kWMPZKGOjv8JNvmTQ3c3W/bOew819/5cuf/jRQPnY+y4paM4g+rH2+1Eft+zkny
         780g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697568; x=1698302368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9ZsHqJLwA+8C0bKpNAFMlm9CdR6RyXfCZFn1e/5/2w=;
        b=saxmMc1yOLpnYy8jGyul7vVMti6DolP64qxtVwxHhBqtbJK4I1Fe1op4nfJvIf7tgJ
         65a8rx5ZtC5e33XtX5ZePl/EZHEtv+Iid9fBNPyeTvh1HMiaA7xG+I49XPF7JZS/QVZA
         G3WhdkPrsxfXQpqHQRDeuyDKvYl9Id+ahU0E39QI03f5theMTMkyZFwMEVHJnyHzwseh
         RKNBaeM6Da8RV1y1VPyCludimkZ/fym3myL+bSTt5U4yGefd15MWInPJEZZchJpBlRMx
         3QL9KDyq9lcWt3ksaGOBC56x68DpMhKQfA25zAtK6DA9gFGmvBO2lTe/1GWvx+C2L+jB
         8rUg==
X-Gm-Message-State: AOJu0YyY3vIsKTTNpdvfHm8pF215gv+Aceh7yxw9TUMX1Djr3qaROKJC
        1n1wO9inJ51uBMm4ff7S0qAFV+dsd917Bp5ddFE=
X-Google-Smtp-Source: AGHT+IGX0Wi333UrDCooJ04O3JfucX0UUD1XQ01jNvgTTbFoISHizTrWjj695jy+J0auhREZGZw1955Sua80J6Bnffg=
X-Received: by 2002:ad4:5de4:0:b0:66d:25cb:43ba with SMTP id
 jn4-20020ad45de4000000b0066d25cb43bamr1595817qvb.20.1697697567992; Wed, 18
 Oct 2023 23:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org>
In-Reply-To: <ZS-m3t-_daPzEsJL@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 19 Oct 2023 14:38:52 +0800
Message-ID: <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup
 root_list RCU safe
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

On Wed, Oct 18, 2023 at 5:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Oct 17, 2023 at 12:45:38PM +0000, Yafang Shao wrote:
> >  #define for_each_root(root)                                          \
> > -     list_for_each_entry((root), &cgroup_roots, root_list)
> > +     list_for_each_entry_rcu((root), &cgroup_roots, root_list,       \
> > +                             !lockdep_is_held(&cgroup_mutex))
>
> Shouldn't that be lockdep_is_held() without the leading negation?

right. will fix it.

>
> > @@ -1386,13 +1386,15 @@ static inline struct cgroup *__cset_cgroup_from=
_root(struct css_set *cset,
> >               }
> >       }
> >
> > -     BUG_ON(!res_cgroup);
> > +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
>
> This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.

will use mutex_is_locked() instead.

>
> >       return res_cgroup;
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
> >   */
>
> Yeah, as Michal said, let's not do it this way.

sure, will do it.

--=20
Regards
Yafang
