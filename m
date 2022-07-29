Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACF585621
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiG2Uao (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbiG2Uam (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 16:30:42 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AC18E12;
        Fri, 29 Jul 2022 13:30:41 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4067233otb.6;
        Fri, 29 Jul 2022 13:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nzD++3Hnq8Jl3miMPq7Dm32aO2I1KwSGCsVt2On+yvI=;
        b=Ot0MAiej63uI8gKPoHYenJArAvN2RS28MYqFqsC1TZN873kO3qSCV4Xc9TMCBHOeyd
         pGhi/+fwV+LSdhyttJ5E+OQckbsfQR9N/X9scikQ4rt9H5gqiFQdjXdTGcCshe6Gbx3c
         PMScNDHyTp6zcilyCw45vvADHD8chLkhL6xzq8e0+WkubtQ4ulB/1MYpOoy+ZEJWVyFZ
         VNNdX8Vt0sMqVNtfp8REm1AYxdHuChWUjKKARMNP2AzlP5R3GUuKGSVYts9+fvP839EA
         9F3ptqaZV5OtN2YYaQjxWhMkSEyS8TMLqe1jbSB6fp5Kn2kmPBdV0oBIvZELMOXCsra4
         yR0w==
X-Gm-Message-State: AJIora/tWkcnomsT+AV8QiSvUZIab1fTpmcaMg6F81mudM1RE2dyENev
        Gk3bdax9+0fRvvsoLke2n7OclvOyqd0qaP1jxnI=
X-Google-Smtp-Source: AGRyM1u6XMfZ2dp41165Y6KJg+tj3el3CgTSSr/ajLq9RE4Pk7T+bunFV24+9DB2zeoboKw/3lVEbMi9pB9nIMPKojc=
X-Received: by 2002:a9d:3cc:0:b0:61c:7d1d:2056 with SMTP id
 f70-20020a9d03cc000000b0061c7d1d2056mr2171008otf.247.1659126640499; Fri, 29
 Jul 2022 13:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
In-Reply-To: <YuQvcCrcgNWbtndU@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 29 Jul 2022 13:30:29 -0700
Message-ID: <CAM9d7cgrpORPW_jYAa-Xopw3+im1SPiR3O0omh-v0Odd7YGxGA@mail.gmail.com>
Subject: Re: [PATCH cgroup/for-5.20] cgroup: Replace cgroup->ancestor_ids[]
 with ->ancestors[]
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups <cgroups@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Fri, Jul 29, 2022 at 12:06 PM Tejun Heo <tj@kernel.org> wrote:
>
> Every cgroup knows all its ancestors through its ->ancestor_ids[]. While all
> the existing users only need the IDs, there's no advantage to remembering
> the IDs instead of the pointers directly. Let's replace
> cgroup->ancestor_ids[] with ->ancestors[] so that it's easy to access non-ID
> ancestor fields.
>
> This patch shouldn't cause any behavior differences.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Namhyung, I think the change in bperf_cgroup is correct but couldn't figure
> out how to test it (normal perf build wouldn't compile it). Can you please
> see whether it's correct?

Looks ok to me.  For the perf part,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Note that you need to pass BUILD_BPF_SKEL=1 when you build perf
to enable BPF stuff.  IIRC Arnaldo will make it default at some point.

Thanks,
Namhyung

>
> Thanks.
>
>  include/linux/cgroup-defs.h                 |   10 +++++-----
>  include/linux/cgroup.h                      |    2 +-
>  kernel/cgroup/cgroup.c                      |    7 +++----
>  net/netfilter/nft_socket.c                  |    5 +++--
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |    2 +-
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 63bf43c7ca3b..51fa744c2e9d 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -379,7 +379,7 @@ struct cgroup {
>         /*
>          * The depth this cgroup is at.  The root is at depth zero and each
>          * step down the hierarchy increments the level.  This along with
> -        * ancestor_ids[] can determine whether a given cgroup is a
> +        * ancestors[] can determine whether a given cgroup is a
>          * descendant of another without traversing the hierarchy.
>          */
>         int level;
> @@ -499,8 +499,8 @@ struct cgroup {
>         /* Used to store internal freezer state */
>         struct cgroup_freezer_state freezer;
>
> -       /* ids of the ancestors at each level including self */
> -       u64 ancestor_ids[];
> +       /* All ancestors including self */
> +       struct cgroup *ancestors[];
>  };
>
>  /*
> @@ -520,8 +520,8 @@ struct cgroup_root {
>         /* The root cgroup.  Root is destroyed on its release. */
>         struct cgroup cgrp;
>
> -       /* for cgrp->ancestor_ids[0] */
> -       u64 cgrp_ancestor_id_storage;
> +       /* for cgrp->ancestors[0] */
> +       u64 cgrp_ancestor_storage;
>
>         /* Number of cgroups in the hierarchy, used only for /proc/cgroups */
>         atomic_t nr_cgrps;
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index ed53bfe7c46c..5334b6134399 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -574,7 +574,7 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
>  {
>         if (cgrp->root != ancestor->root || cgrp->level < ancestor->level)
>                 return false;
> -       return cgrp->ancestor_ids[ancestor->level] == cgroup_id(ancestor);
> +       return cgrp->ancestors[ancestor->level] == ancestor;
>  }
>
>  /**
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 85fa4c8587a8..ce587fe43dab 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2047,7 +2047,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
>         }
>         root_cgrp->kn = kernfs_root_to_node(root->kf_root);
>         WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
> -       root_cgrp->ancestor_ids[0] = cgroup_id(root_cgrp);
> +       root_cgrp->ancestors[0] = root_cgrp;
>
>         ret = css_populate_dir(&root_cgrp->self);
>         if (ret)
> @@ -5391,8 +5391,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>         int ret;
>
>         /* allocate the cgroup and its ID, 0 is reserved for the root */
> -       cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
> -                      GFP_KERNEL);
> +       cgrp = kzalloc(struct_size(cgrp, ancestors, (level + 1)), GFP_KERNEL);
>         if (!cgrp)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -5444,7 +5443,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>
>         spin_lock_irq(&css_set_lock);
>         for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
> -               cgrp->ancestor_ids[tcgrp->level] = cgroup_id(tcgrp);
> +               cgrp->ancestors[tcgrp->level] = tcgrp;
>
>                 if (tcgrp != cgrp) {
>                         tcgrp->nr_descendants++;
> diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
> index 05ae5a338b6f..d64784d4bd02 100644
> --- a/net/netfilter/nft_socket.c
> +++ b/net/netfilter/nft_socket.c
> @@ -40,6 +40,7 @@ static noinline bool
>  nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo *pkt, u32 level)
>  {
>         struct cgroup *cgrp;
> +       u64 cgid;
>
>         if (!sk_fullsock(sk))
>                 return false;
> @@ -48,8 +49,8 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
>         if (level > cgrp->level)
>                 return false;
>
> -       memcpy(dest, &cgrp->ancestor_ids[level], sizeof(u64));
> -
> +       cgid = cgroup_id(cgrp->ancestors[level]);
> +       memcpy(dest, &cgid, sizeof(u64));
>         return true;
>  }
>  #endif
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 292c430768b5..bd6a420acc8f 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -68,7 +68,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>                         break;
>
>                 // convert cgroup-id to a map index
> -               cgrp_id = BPF_CORE_READ(cgrp, ancestor_ids[i]);
> +               cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
>                 elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
>                 if (!elem)
>                         continue;
