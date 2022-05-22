Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA871530160
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbiEVGsV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 May 2022 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiEVGsU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 May 2022 02:48:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1B36699
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:48:19 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i11so20382132ybq.9
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+86wYP36U311zaok342X50l9ECadNdMvxTZhZZ14tg=;
        b=2UtmFRcCttqhVCYCxkvMGj1oc42Q+TyiCf7Rh2JlB+DFl9as9uUEP04r2Tx9KZzwMw
         YWV/0SVPIrdAzgtlxIJrFaVbtgMWlklBLxambHEJKDPlReq8UdjzGw9drwD6TMoVRO+V
         G54/gUVExox3CmE1K3kCF1KpEpk5ioGFI0a7ASDRM35NvxidOzMd4230U4oSfpZ0yP+T
         9tbyFvrynWSP5oVmMaPsVvyuiRX5LsOgS1R53xUZvsa7JZo/GbuTq8yT44YuCxf0I8LU
         nX0KSUO+R0vfTSTblwBGQDCKkvV6ljOTr/wf/pLoT6nYKV5jR0DXNCg9O+TZ7a4MlAQ8
         4XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+86wYP36U311zaok342X50l9ECadNdMvxTZhZZ14tg=;
        b=672cx1K9QQ+flhrUhgpxgcBfKYrAxBmaTcWbEqQfW7unW4XakEl/t2Hqhwm1m4s6eu
         Anwhpo62ZAvQ57khDKVkaPfutZqCtV7iuT75I777VDHxNVSuiarEyk7mGGDd5dvVVODo
         SN82X2MrRr+AqO+pl/QwWSCBmy3JyU5DCMBm/+/C908UeUUsOtfl6/2UILGIJTiPswUV
         jcGRdamhZdcrdSlv4dxsafUgUNIZM7fitTMsTXMrV7rQqJtb866aEp6FKbaJYAUYwLEZ
         K+V9Q5Fu+e8wVDMmYB3kAmx060gVa722jKLrz4B5kNUAj41J/Bxhxn7o+cBUXxNWjOD7
         mDgQ==
X-Gm-Message-State: AOAM530tPxeo4B1+Aj9KY7JlqW4uYA6TTpTDq0gcHdVNcX3OWaccqJC8
        gmqqOXrbjNSMrHqEy+G5Bn1X2bOhlThh8BtcBBdMGw==
X-Google-Smtp-Source: ABdhPJy/hxbB+HcmNHUq9GLnjBjRRMwDZCFUNbBD4QiZdQ2+dSMuHi6jgHmZszNcElwj/QiJCEFPP6kTaS1hMBJDU9I=
X-Received: by 2002:a25:6fd4:0:b0:649:a5f5:c6b2 with SMTP id
 k203-20020a256fd4000000b00649a5f5c6b2mr16641652ybc.132.1653202098638; Sat, 21
 May 2022 23:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <9925d0ba-40d7-e3a8-1fef-054968b26ce6@openvz.org>
In-Reply-To: <9925d0ba-40d7-e3a8-1fef-054968b26ce6@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 22 May 2022 14:47:42 +0800
Message-ID: <CAMZfGtX1pste5vY_RE3N5LQ1_+BUjyRbSUa1yf0v7vboJj_iOg@mail.gmail.com>
Subject: Re: [PATCH mm v2 7/9] memcg: enable accounting for large allocations
 in mem_cgroup_css_alloc
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 22, 2022 at 12:38 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Creation of each memory cgroup allocates few huge objects in
> mem_cgroup_css_alloc(). Its size exceeds the size of memory
> accounted in common part of cgroup creation:
>
> common part:    ~11Kb   +  318 bytes percpu
> memcg:          ~17Kb   + 4692 bytes percpu
>
> memory:
> ------
> Allocs  Alloc   $1*$2   Sum     Allocation
> number  size
> --------------------------------------------
> 1   +   8192    8192    8192    (mem_cgroup_css_alloc+0x4a) <NB
> 14  ~   352     4928    13120   KERNFS
> 1   +   2048    2048    15168   (mem_cgroup_css_alloc+0xdd) <NB
> 1       1024    1024    16192   (alloc_shrinker_info+0x79)
> 1       584     584     16776   (radix_tree_node_alloc.constprop.0+0x89)
> 2       64      128     16904   (percpu_ref_init+0x6a)
> 1       64      64      16968   (mem_cgroup_css_online+0x32)
>
> 1   =   3684    3684    3684    call_site=mem_cgroup_css_alloc+0x9e
> 1   =   984     984     4668    call_site=mem_cgroup_css_alloc+0xfd
> 2       12      24      4692    call_site=percpu_ref_init+0x23
>
>      '=' -- already accounted,
>      '+' -- to be accounted,
>      '~' -- partially accounted
>
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
