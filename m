Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3C35CA74
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhDLPvY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbhDLPvX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 11:51:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A55C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:51:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e14so9419277lfn.11
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXdDtDVkOliHR0wKt8o4xOp+hVyUebs5k6d6U80wmt4=;
        b=caAQ4Xqg3sQpXpGaPNU3gKD7/UtnjwdhKAtTaqk6OAPLz6XqnT2JJIRntD7Xo7/K9F
         9Uze7K7jgVp9YNlmci2T07wzH6iQWrk+KTChEXZtVUcgMPlTqiGfCtQyExMN3RCaBNlU
         r3gk9p6TrZEHgs+aBrSlqaWZjux7xtU1Ml1dFps1vFQeJDdkRHM2uZKddjni+P37e0A7
         Dd4j8BViFagxn40TtOl79/kk9ps0I/pPMz8qJ8qkA0WKCny7QuwcCqKUFGQJAY0cEaVT
         1kIY2G4ii+zqIlQgDlq513nOi6v7A0qNOa0mRYFLP5FsDXuMXFkV+1jLK8SEo/JBXW7X
         itog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXdDtDVkOliHR0wKt8o4xOp+hVyUebs5k6d6U80wmt4=;
        b=fJiTV4PRgwTF54ZajCFrC6Dh67AIv1g55bb61Bqp2VZn5y8EyhvXcoBAbuWBYxepQf
         fGJs+NFHIiYvTK258RysDMzcoLnowoSGLryqfJHUCqGyMiBBFOrDw1bxShyLkmdm6vUN
         9csrhMlsmDcz/m+hLHdCKI8PPvDXKaNX4GlWrx8r1+UgFsrLU55S53jK0J8t1rJoBcZe
         wahOKhrl5keyck8mGy4JMkAFfFHPPPn2QYzrC3nwDWtg39r0HwxWkRaGChdffgeRbWTm
         dcLFWu5sHt33yIgDQJAkXN7yOxIpNMVnL7hkc00zbDl7lcS3PyKAdLQxTTEMyr3IK+R1
         nKjQ==
X-Gm-Message-State: AOAM5312y9QJ1JgFKtbT2JmTgEMOxRS0oemi7QvbxQaId1e6/HdGjQ3Y
        iqN2SZ+YrII4r7OF5ZfZUUt4ar13Pwo2+fYcbopa8A==
X-Google-Smtp-Source: ABdhPJy/6xYW52zIk5X9L64R1+sYa7h1XRl+uzYrZVCer2D1jTMm+sFt+n0v5v9OKyJBaCPZPiLkgW53BuZLiIEZybU=
X-Received: by 2002:a05:6512:34c7:: with SMTP id w7mr18952307lfr.83.1618242663210;
 Mon, 12 Apr 2021 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409231842.8840-1-longman@redhat.com> <20210409231842.8840-3-longman@redhat.com>
In-Reply-To: <20210409231842.8840-3-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 08:50:51 -0700
Message-ID: <CALvZod5m_J4z0sZrd72yftXhYF9PmtJDfRKDK9WVSMvo7PP6uw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 9, 2021 at 4:19 PM Waiman Long <longman@redhat.com> wrote:
>
> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> function call goes through a separate irq_save/irq_restore cycle. That
> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> that combines them with a single irq_save/irq_restore cycle.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
