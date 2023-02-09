Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363E690798
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBILmc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBILmM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 06:42:12 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388955E61;
        Thu,  9 Feb 2023 03:30:37 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id z5so1455035qtn.8;
        Thu, 09 Feb 2023 03:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDkWXAEEhy2VoXh+Bc3398ODh0oG5X691Xoq6e7LZmg=;
        b=K055cZuD84EE4vZQSZTVkgvlYu6HEsqiYoe0wUMw1gXWvVpibA8mZVBwCnGtHYDZjj
         vCeA0nXg0VBUFLVkpn8DaNNZiR0uFOc8MzsnALrn3of8Zfpjvr20WerxDWbyWAqvjnT4
         wJYREah2Bzt1cZu2v+KGxKGL7jRm8Uj4xcpHb38gq5rJic3U/2+lXLsWwast+ErQUBRi
         PMno/k5THMgxcHw39OD4fW6z15xJnDVP6An9Ajhpr5emlZS5RYonCETfxXryUGlVu1B3
         rg4rERM/ld+83BXTfwnH29Bhjcc1cO6vyDUpBrBgkwryqLwyHiKxZ4fZ1DNHLYi04l4c
         3GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDkWXAEEhy2VoXh+Bc3398ODh0oG5X691Xoq6e7LZmg=;
        b=cP/VraLC0R1Ahu1lQ8zpC70pjHQMDOp5f5Xi8Q4RQp6lLfrBwnRzOY9tM3hgj3//qq
         IT3l21ZAsAj6dTADmU7CR5nabKVQX67vvo/YoVB9ULROhPbFkTqO1KbUk1DdRVYQbNpe
         yBlDfM8THwfd1wL4w7RPAlXRWvqMhEYeuejvIsDaqBNc9+FXLPzIe58seBEFycFkzqEk
         biiN5QsgTotGWJsAZFJ8iPx4F/wwtGiMkud+WKSj/12GzPlIuFTaHt3lDFynntrppTfr
         EzIwVkl83najRv+aDgrTWI3irNUaGjP03U9hTDsADf0Yc+EHNiLezh8quhRmE0lttgiB
         HNqA==
X-Gm-Message-State: AO0yUKUjN0W6OjUT5RlTmoZxk84kRjxKJ1kpLX+rV/CH9QkQl/vmvqL2
        NxWaxmwMdzZG3f4RyOhN1H0WnEZlspEEkwIfRNk=
X-Google-Smtp-Source: AK7set9UnhO3e0ZCvAf4BBcgOgkkPqdkdK7wmZPj6GUROOzAcJSKfG0kRz3snJW7n6FP3me6fhAqzM31MvVZQSdnKlM=
X-Received: by 2002:a05:622a:1c8:b0:3b9:b1a5:b52c with SMTP id
 t8-20020a05622a01c800b003b9b1a5b52cmr1634714qtw.166.1675942117789; Thu, 09
 Feb 2023 03:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20230205065805.19598-1-laoar.shao@gmail.com> <Y+QL8s1VEHlolXM3@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y+QL8s1VEHlolXM3@P9FQF9L96D.corp.robot.car>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Feb 2023 19:28:01 +0800
Message-ID: <CALOAHbBzev_Bi5kzD0O2Sppv3SO2_Qbxe4McXy2i-08dPqVwRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf, mm: introduce cgroup.memory=nobpf
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 9, 2023 at 4:54 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Sun, Feb 05, 2023 at 06:58:00AM +0000, Yafang Shao wrote:
> > The bpf memory accouting has some known problems in contianer
> > environment,
> >
> > - The container memory usage is not consistent if there's pinned bpf
> >   program
> >   After the container restart, the leftover bpf programs won't account
> >   to the new generation, so the memory usage of the container is not
> >   consistent. This issue can be resolved by introducing selectable
> >   memcg, but we don't have an agreement on the solution yet. See also
> >   the discussions at https://lwn.net/Articles/905150/ .
> >
> > - The leftover non-preallocated bpf map can't be limited
> >   The leftover bpf map will be reparented, and thus it will be limited by
> >   the parent, rather than the container itself. Furthermore, if the
> >   parent is destroyed, it be will limited by its parent's parent, and so
> >   on. It can also be resolved by introducing selectable memcg.
> >
> > - The memory dynamically allocated in bpf prog is charged into root memcg
> >   only
> >   Nowdays the bpf prog can dynamically allocate memory, for example via
> >   bpf_obj_new(), but it only allocate from the global bpf_mem_alloc
> >   pool, so it will charge into root memcg only. That needs to be
> >   addressed by a new proposal.
> >
> > So let's give the user an option to disable bpf memory accouting.
> >
> > The idea of "cgroup.memory=nobpf" is originally by Tejun[1].
> >
> > [1]. https://lwn.net/ml/linux-mm/YxjOawzlgE458ezL@slm.duckdns.org/
> >
> > Yafang Shao (5):
> >   mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
> >   bpf: use bpf_map_kvcalloc in bpf_local_storage
> >   bpf: introduce bpf_memcg_flags()
> >   bpf: allow to disable bpf map memory accounting
> >   bpf: allow to disable bpf prog memory accounting
>
> Hello Yafang!
>
> Overall the patch looks good to me, please, feel free to add
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> I'd squash patch (3) into (4), but up to you.
>

Sure. Will do it.

-- 
Regards
Yafang
