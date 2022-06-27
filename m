Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310A55B5E0
	for <lists+cgroups@lfdr.de>; Mon, 27 Jun 2022 05:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiF0DXr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 23:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiF0DXq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 23:23:46 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81E2733
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 20:23:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-317741c86fdso73075297b3.2
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN+xoYA+ksKDeeujf53jiHGUJcOQVzh6cwSiG0r1JZ0=;
        b=VZASWp/K3Xzse8hHey4MhbH+j2n8icJllf/NFc2ri+vgIMu/2qvY/TvM0CReGMQIhk
         Q9NnMpdtXy5gdBtd8D/QZD4cNqcJNwU2DaqQBUAw10Gl3yqmRO3Oo4EEICu7bCzJOFis
         kPApaPYwsunYb2di9uQWNejNAF+g44cfP48iFaSCYQ7LopQiWLOTgTKMl2fJE5Dagibr
         vF0dfCSEVPbA1ZEOrLKDTn1JlPhyI4mw2F4rdz/MVmvFq+ZsXm3NxqUOUo4+1mUPdnBW
         D23Q9O3xlZ9IfSdolmXs7aC0lExuB//NN7EkVklnUIYUPwIVpotTJ74mu6HjXw2DKmWj
         BHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN+xoYA+ksKDeeujf53jiHGUJcOQVzh6cwSiG0r1JZ0=;
        b=0hNMg+GzG0tQBQEgFfiWftyO+qDS6Ktf5OZ6yxxxtRoUc2su1aRaYHIj1zeGFmFqQG
         wvOim0Vwg6AFxF5bRr+fJrgK6rZQsSBrf0psn2sIWNE1R6bvcvxqIM9EiumRPkIBBBcF
         CYnU1SpFaptIv7Bfquy0uHUmUg5JBIcejYaWUgZgsWxQsbuKJkA9jn1g3CpbC7fYO+/0
         6aNfr5kNx1oBjFckz0JmSzyCmoX63M63VlIHsM/Cs/5+/8MWfCD17eYLgyUOUL5phV6/
         Gdf4MCXFJEq96WFYWkuX88GPDIZLpMAaZKsDDqiiSvTzbOtX7wT/9nFOU6lt18rLwaNj
         tv7w==
X-Gm-Message-State: AJIora95A7IyN+R/Iqi7/0qyU6bea4Epvrvm1nRQSbMfmxDFMmtqxRcr
        b0hkDoBy20E2JJtbWBhv27pMMxtJ0pDiBAeiDhln4w==
X-Google-Smtp-Source: AGRyM1ttUQbhNS8g8BPtv9oRKCweJCwEVCohrYTwcAyyKKEjTRNIc1b4sVqgvWwkxo0N0u+0HR5jP3dE8s97Vii9/d0=
X-Received: by 2002:a81:5dd5:0:b0:31b:a0f1:254e with SMTP id
 r204-20020a815dd5000000b0031ba0f1254emr6333166ywb.141.1656300223877; Sun, 26
 Jun 2022 20:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yre8tNUY8vBrO0yl@castle> <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
In-Reply-To: <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 27 Jun 2022 11:23:07 +0800
Message-ID: <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
Subject: Re: [PATCH mm v2] memcg: notify about global mem_cgroup_id space depletion
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 10:11 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Currently, the host owner is not informed about the exhaustion of the
> global mem_cgroup_id space. When this happens, systemd cannot start a
> new service and receives a unique -ENOSPC error code.
> However, this can happen inside this container, persist in the log file
> of the local container, and may not be noticed by the host owner if he
> did not try to start any new services.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
> v2: Roman Gushchin pointed that idr_alloc() should return unique -ENOSPC

If the caller can know -ENOSPC is returned by mkdir(), then I
think the user (perhaps systemd) is the best place to throw out the
error message instead of in the kernel log. Right?

Thanks.

>     if no free IDs could be found, but can also return -ENOMEM.
>     Therefore error code check was added before message output and
>     patch descriprion was adopted.
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d4c606a06bcd..ffc6b5d6b95e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5317,6 +5317,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>                                  1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
>         if (memcg->id.id < 0) {
>                 error = memcg->id.id;
> +               if (error == -ENOSPC)
> +                       pr_notice_ratelimited("mem_cgroup_id space is exhausted\n");
>                 goto fail;
>         }
>
> --
> 2.36.1
>
