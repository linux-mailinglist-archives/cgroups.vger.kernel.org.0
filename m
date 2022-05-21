Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099C52FF9E
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbiEUVhY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346018AbiEUVhW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 17:37:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87EB52B02
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 14:37:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i1so10025589plg.7
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUHlY6J9Sffp4UlBWr1Ple6zvDOi7bfuxN73Sst2ROw=;
        b=ra8coKkYaI+nTpa/3tURJsZMGvzuQdyoQqh8jFxXJS7g0+8e01V8X9PBbCiPrE1FE6
         Yzcm7D4kVznWFOyoJbAXwA0JksMwuxSeRKJHaepGZUl8lYbYFZgIG8Oi3E1d+6xIR/Sc
         O9wApVFLDj/uVKWe5ig9oA3BYUdXFeSE8Y1ocXJS1c7EiMbev7w5BL/bErmsf7p9aJl/
         Ga9Uv5M/1wjbL+MLI3hBN5tyLtXCO3jyPshHGXAdVzvkrmR2TN14mpXOD3I1H4Ng8ii1
         CyhknimccTj5ODRjBe/dfaGnat48A0Qkf0U68Lcxtde6yS4vHqKa0+SDw738gp0RWhGo
         pSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUHlY6J9Sffp4UlBWr1Ple6zvDOi7bfuxN73Sst2ROw=;
        b=6AGxjr8P1YYy+tQy8s39pTsYRqZTgdBRJm3C7enNmsb9LusUc2kZuxNwKORZQ7/18d
         gNNzvrgEATzcm/Roqq1y02jy8+JRxDLF4acGAm8hTR+zC9FsEBXfe/Bus9DbZ3BMdJBD
         3p0Oc8AgBvrUEu09cSfwWZGUKQjrpNBNwhXS4tFQYqfOFJKcwm2tcIXzzad/1+0y2Zpw
         TMch1Mu+2CQEUdJPIDQCX/2L3Kxtn+XJURSNjal2a7YOpYwdt0HAWovl57es1+LVBJJX
         8X2SLv02iMEOBP0gkgNamfX8NCFMCT4ZnViAvJ2aUI40lQgB3yWgUjK5y8uioGbJy60x
         RCIg==
X-Gm-Message-State: AOAM531oej6h1uO5YKHls0EAKNohLPp7pWNv5YHZy6hMkJ9wlPVHnC3d
        nJXw7dQukBc2fOpIfLlB93B+prNlzqixGaQovWU9Lw==
X-Google-Smtp-Source: ABdhPJzvooQ2soSHTUGtc62LLq2ToAadW6HIRcDfEM09iWRyYpsDh7FklUk1Jsb/BiB188e8xe8KvqWYHnAhdyytBrA=
X-Received: by 2002:a17:90b:4a51:b0:1df:7617:bcfb with SMTP id
 lb17-20020a17090b4a5100b001df7617bcfbmr18604605pjb.207.1653169039194; Sat, 21
 May 2022 14:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
In-Reply-To: <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 21 May 2022 14:37:08 -0700
Message-ID: <CALvZod6+R9XpAz7_2QSc=fNO4w_revhr9MvCrByHCWWjnQwOhA@mail.gmail.com>
Subject: Re: [PATCH mm v2 9/9] memcg: enable accounting for percpu allocation
 of struct rt_rq
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 21, 2022 at 9:39 AM Vasily Averin <vvs@openvz.org> wrote:
>
> If enabled in config, alloc_rt_sched_group() is called for each new
> cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
> This significantly exceeds the size of the percpu allocation in the
> common part of cgroup creation.
>
> Memory allocated during new cpu cgroup creation
> (with enabled RT_GROUP_SCHED):
> common part:    ~11Kb   +   318 bytes percpu
> cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu
>
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.

*containers

>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
