Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4223532C2
	for <lists+cgroups@lfdr.de>; Sat,  3 Apr 2021 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhDCFrp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Apr 2021 01:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhDCFro (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Apr 2021 01:47:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B3C06178C
        for <cgroups@vger.kernel.org>; Fri,  2 Apr 2021 22:47:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l1so3342343plg.12
        for <cgroups@vger.kernel.org>; Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=pMd1FbuvZ5E2fr1ocmyqnh+uLdNieVu/k08bIWoaWboRu1GuMhWuxbxzopnRIIA9lc
         zKwlsLoFQIrvZO9+Oo5f16yHnpzmH+iue6MrfQZ68f+gsl7xZ5h4aANWgAt4AjBkOBIn
         LczolwaRoieF168IcrjESxGMivxeYdlo7Pm9SyQ/si7aRk4o9K2fQKJkVd7bDtift8BP
         irNQU99mPX+t2pMHMjigsm8Gc9ruDFKeFl/YCvdAbROCuItCoolqDlnbbTsjNsM8SmMt
         RqMuLSmnqc5b8HrGIBHt14Fxr9KQXLtRLhBl5pAV9AM5fVsGMKr2+SMyr/9c/sjy9u4c
         nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=Wu+oppnUW7hU7IADbaTbF1eMQoLwve0l23QgwPrvsZoiQonWFKJaOWOBEGmhiD9z6C
         v6cmAXsrcvi78FOBOh2+Mj2uiEEfp5hWNd9jbV4ZHBlFh2Y07dcbFmz/M813LV1nWod+
         3GY5NGriPPGjVAgL9mtdSJS9p/3AVyqSe4Bnf3FPHt9ACTd9bp1JOgalgHlOfQI4ssrh
         8sGqAtU3z4+Dwy11GzEDlbmgYo/aJw49nWSibuMlST0iKO7oVPPuzy8X30ci13bNppKE
         t3J6h84m/Nf497xhqtSoBprocOnC+IFX/dqTn7+M9kB8sPjqSmSyVIT2BiTqxfRxEZ1x
         7rqg==
X-Gm-Message-State: AOAM532Fjp+7rEnw+yRAYW9M8Ca56BA6EKS5AgH3NRRi76zFOPZvCO3D
        0YeiLVTd2h5zXP3hHicYNEJneMR1voxmTv7dtUJexw==
X-Google-Smtp-Source: ABdhPJzihZ9i7xdyKbcp25Pn/HT4uvsaH7n4VpVPtgIcyATKoF8snXQWFtthCIKS1/pr04vA/PHK/n8U/ZaD5DfL31I=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr16762991pjv.229.1617428862110;
 Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com> <20210402191638.3249835-3-schatzberg.dan@gmail.com>
In-Reply-To: <20210402191638.3249835-3-schatzberg.dan@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 3 Apr 2021 13:47:05 +0800
Message-ID: <CAMZfGtVwxo-UMq8RD_2hpLAbhhYzSkDi_J7kQOJ3yzFz=-5USQ@mail.gmail.com>
Subject: Re: [External] [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 3, 2021 at 3:17 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> set_active_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If there is an
>    active_memcg, use that. Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_charge (case 3) it
> would always charge the root cgroup. Now it looks up the active_memcg
> first (falling back to charging the root cgroup if not set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
