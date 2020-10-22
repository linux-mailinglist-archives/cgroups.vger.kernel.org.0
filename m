Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959FC296320
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898087AbgJVQvP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902062AbgJVQvP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 12:51:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC7C0613CF
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 09:51:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z2so3125633lfr.1
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xd+wFurjGt8mIia5D9RdI7kEY/qSyqqqpi8eDO7fd4U=;
        b=LrjBvKpulM/XMhJARW83BKyF12g1Mqfl10AXRgIMcG9LM7S6kcl4R6MlFwlFkEA/1a
         d/KzVeD+H36kd9k/4RiTQHrYtLgqMyf+qBYv/N8Ex//ESFw0YXOyN4StOv1ukEWWqeQr
         hyGdvREaI2zbnlt9ny7p45Sad/Gd/FFkejzXvXodXkc/tufjFz7F4cjPQcROrIrimbjt
         LDcWSPR2XQzbiqwiz3VAllqfZ39xfPGZTzfanQ2bJ2679ENBpGehMgtEagxaUfdusjuu
         Lz0bsQ5wNKlvGwK2a5JbDUGAVjzXcEQHfzg7+ZdDyW2WOdOAoN5ovZXyr1aABAUXxX9U
         T/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xd+wFurjGt8mIia5D9RdI7kEY/qSyqqqpi8eDO7fd4U=;
        b=AnWFRVwwp27RBsmkTku+1bjav6zopt5jC6ILtOKfrmkAho27jWjlwYCRGCdnrrsfRw
         ixvIvwp3AKKk2Abu2H8bEB7qSLMZ6aTFJLTq++wVA9My4I8NgJU4a2B2dXctO2We7BtF
         XL9ykbgflyChsxNJCOVCVWME7KtZ0L5s2k3SX4HuepJJSbWhoDN0xTw59hObBfxJkj5Y
         RQEkJCWjLUEeOONouBTPu6NlVo0BkFnPmc0gD9xZBIwIlhHU2dZUhyL7UtwTCSOyVLi8
         4OFOKbvcPY4M5bjdL+B+4X2mRC4KY7sHe+EJD74dXAa2Xt9mRHD7NwJA1gdnwIzb/8qM
         JDxQ==
X-Gm-Message-State: AOAM532Veg/Fgpd9jYDniKTILCOO4ckUPlapyA+gMol5bC7PaKFL1tSs
        pDJq/Nus72CsiE6J07FR9Bs8AgDJpLR+bdQLSuWbEA==
X-Google-Smtp-Source: ABdhPJzgbjVJ6Q48WyyWENn3/RiEAe7m2DvqcU64UZBUNM7R05PvMjOPYcsfbg596U8Of0MqHkurd7hguMBbdaqIN80=
X-Received: by 2002:a19:84d3:: with SMTP id g202mr1289904lfd.346.1603385472165;
 Thu, 22 Oct 2020 09:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201022151844.489337-1-hannes@cmpxchg.org>
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Oct 2020 09:51:01 -0700
Message-ID: <CALvZod7SOpaVcmVZDTw-UeVo3Jx=VfojBzO5f7k5ATPXeN7K+A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 22, 2020 at 8:20 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> As huge page usage in the page cache and for shmem files proliferates
> in our production environment, the performance monitoring team has
> asked for per-cgroup stats on those pages.
>
> We already track and export anon_thp per cgroup. We already track file
> THP and shmem THP per node, so making them per-cgroup is only a matter
> of switching from node to lruvec counters. All callsites are in places
> where the pages are charged and locked, so page->memcg is stable.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
