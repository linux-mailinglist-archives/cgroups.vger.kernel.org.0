Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF48375830
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhEFQIi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhEFQIh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 May 2021 12:08:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E44C061761
        for <cgroups@vger.kernel.org>; Thu,  6 May 2021 09:07:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a36so7732247ljq.8
        for <cgroups@vger.kernel.org>; Thu, 06 May 2021 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hHJ2if4WJkg2du4T57AGBZ6P/jf0214NaTU4kr7th0=;
        b=d+zf6gym8dKCyDd+UW2gOZhjv9TbxL+FJK8ovpix4foAPy8PgxTh8HkOnZDMQ/cd26
         WGRoTUYFIYN69v5oodnGIbj20EyykcmxDgIZWoyp/1w0l9muEsYf9Uk/tfZiHoYJCBfi
         BCjZKZ5gq0Lxjohp3E8Pr6WYBt4oIh+6lw6uTaWaQZ2aBWi1SzUaRWklhTvAAPD58Zvj
         V5yJrXUENoSbELQPDjZoCE1TVtfzCVleSru6ZHEl5Txc5G5XcRPl/Lha+BpLumBgd911
         uZnYv10zevCWk1djhUDzkakEUnhG6oLg7C6aFXvvUQ38kSYeZxkWHaU6gaPF22aPGCmt
         KSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hHJ2if4WJkg2du4T57AGBZ6P/jf0214NaTU4kr7th0=;
        b=Sxh9BRR9pg6aINJY6wr9lfSZhJJyx/Gv64Uzl+hfbo/GdOgrEnPruEtzPDtvVIDQHf
         i+oKhV2m02ikB/Z2gHSNlxiCpxljMYxItUcnGnSEQXq4qrmDO5adHUDkAg7M9IBFVbWK
         x1rTZVg0ZTJOZdn44xYPTizSH979lEo3+PksNy1K3xX6XpGTLG4PFF1+YXK/PdvYq+1U
         cvpZgTUzCzLMZbURf3LA0CTbm5lCKiHXZAP+0+7eLYV2MfdI8BFH1zHkhG0Lc9TkT3fa
         SsUGpY2t2J576C5/kZsFwJFSG0+4McWCLBihuCSBDSKQiz5XDtNLaYX6QpWid3sqFlAX
         6RvQ==
X-Gm-Message-State: AOAM532+F+LaFRplNeaWQbqoT3MvhK/XqQXHs2SHiuWoKx3ih8hXXrVU
        ZAdh+Bu8uslTCipEO42n9Sk4kKxxGJ0DN/a2oRaFpw==
X-Google-Smtp-Source: ABdhPJzn2EhM7XMXkXkyTxRS57EaFcBBQXV19tsKpHBUxqufilM9fckZn6puZV9zDw22uUMMC4ZL5urO+Urx9IobDGo=
X-Received: by 2002:a2e:a491:: with SMTP id h17mr4203019lji.34.1620317255566;
 Thu, 06 May 2021 09:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210505200610.13943-1-longman@redhat.com> <20210505200610.13943-3-longman@redhat.com>
 <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
In-Reply-To: <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 6 May 2021 09:07:24 -0700
Message-ID: <CALvZod69Ge5QzQsbNbf6gwHvSY92TGo0Cc5pxyyu55CHfNhfZg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n> caches
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 6, 2021 at 9:00 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
>
> On 5/5/21 10:06 PM, Waiman Long wrote:
> > There are currently two problems in the way the objcg pointer array
> > (memcg_data) in the page structure is being allocated and freed.
> >
> > On its allocation, it is possible that the allocated objcg pointer
> > array comes from the same slab that requires memory accounting. If this
> > happens, the slab will never become empty again as there is at least
> > one object left (the obj_cgroup array) in the slab.
> >
> > When it is freed, the objcg pointer array object may be the last one
> > in its slab and hence causes kfree() to be called again. With the
> > right workload, the slab cache may be set up in a way that allows the
> > recursive kfree() calling loop to nest deep enough to cause a kernel
> > stack overflow and panic the system.
> >
> > One way to solve this problem is to split the kmalloc-<n> caches
> > (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> > (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
> > kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> > the other caches can still allow a mix of accounted and unaccounted
> > objects.
> >
> > With this change, all the objcg pointer array objects will come from
> > KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> > both the recursive kfree() problem and non-freeable slab problem are
> > gone.
> >
> > Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
> > mixed accounted and unaccounted objects, this will slightly reduce the
> > number of objcg pointer arrays that need to be allocated and save a bit
> > of memory. On the other hand, creating a new set of kmalloc caches does
> > have the effect of reducing cache utilization. So it is properly a wash.
> >
> > The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> > KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> > will include the newly added caches without change.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> I still believe the cgroup.memory=nokmem parameter should be respected,
> otherwise the caches are not only created, but also used. I offer this followup
> for squashing into your patch if you and Andrew agree:
>
> ----8<----
> From c87378d437d9a59b8757033485431b4721c74173 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 6 May 2021 17:53:21 +0200
> Subject: [PATCH] mm: memcg/slab: don't create kmalloc-cg caches with
>  cgroup.memory=nokmem
>
> The caches should not be created when kmemcg is disabled on boot, otherwise
> they are also filled by kmalloc(__GFP_ACCOUNT) allocations. When booted with
> cgroup.memory=nokmem, link the kmalloc_caches[KMALLOC_CGROUP] entries to
> KMALLOC_NORMAL entries instead.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yes this makes sense:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
