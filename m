Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FC39C5EB
	for <lists+cgroups@lfdr.de>; Sat,  5 Jun 2021 06:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFEErp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Jun 2021 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFEErp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Jun 2021 00:47:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2FC061766
        for <cgroups@vger.kernel.org>; Fri,  4 Jun 2021 21:45:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r198so13770713lff.11
        for <cgroups@vger.kernel.org>; Fri, 04 Jun 2021 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vow0w7T/H4Ok4yA/drin7CQKErICdzTcTT/vrNcM5Q4=;
        b=cQpKNyLMQiiglbrRjutBB1ddOTJ0H8uhnwCNG/LXy9JI6NoO9lzdOy1HZVNF2AUCgp
         +p+rCr2qv9jP3GKnpc3t1Irvf17uRHj9MpYhzTGpzCI39q9t/0ZbxDL/kzuO7O2OE07c
         QD0ofIbb5nPJaakITyoiShuR/SLGOVJC/BN/LDf4cID895GGCjl4AQqtCFK3HGIL5GOf
         lCrsT6FzE+7Rd18A1PE02wg0GVG+nqn/DWpMgA+f0ryLKukck/9GhajbiUt1BNUe9Wqe
         szncH+Or4xHWi9+JvrTkdXFEqbOrpxKFnGctU+/59p3/6PKIoRW6xmt7mxsIdmarHhOK
         c7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vow0w7T/H4Ok4yA/drin7CQKErICdzTcTT/vrNcM5Q4=;
        b=R/k0N3Tz5oAqQnHCRQhs4UnoQA0tcO44eig45/J2/P5y/XxslfsomtRnGzYzZtmaZl
         WECMMcIu4jxNiauZZ1J7QqVqRZe3gEUDX6U6nXDKvhRLqI+rOHs5Y3D1NuyUXN6wgXar
         IUfh0iJj2WxXYt+esUjpRkyfONhweBOISn0YaQDKKg4OeeFKIA+D7dfnt8Isj9pD3gfh
         gu3W87Rm+8lPjR/ff2CYm7xVoydpTssVlDoBV6PrfH+vg/Gx1oowf1fmoXrb9q/k59yU
         bJtkDakyvLSLS+LTmgxhEe1Ql5yuoba/dbT5p/YwADziuc2Avac9Az2afF9eadvyPy9W
         0yog==
X-Gm-Message-State: AOAM5309zO1KX9Ism1GQztHU/DTc24Rc18lF9Gl3dDb2PX2v/2DJLCz6
        CfOqRv9C+tAx5SHj3d202Csx0L+8m3Cwk/OKNNJMhw==
X-Google-Smtp-Source: ABdhPJwQoGzX28kw7JKRXYgL5n6FP6kpxLErtYAUQ4PvLx/uwUiZYxfr8DzUpLIwdqw3wtn0D5rmMlrCsiM0eKjbe3w=
X-Received: by 2002:a05:6512:952:: with SMTP id u18mr4785726lft.83.1622868339254;
 Fri, 04 Jun 2021 21:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210604015640.2586269-1-shakeelb@google.com> <20210604061816.3110-1-hdanton@sina.com>
 <20210605015421.5096-1-hdanton@sina.com> <YLriZxiWo+2hMI7g@slm.duckdns.org>
In-Reply-To: <YLriZxiWo+2hMI7g@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 4 Jun 2021 21:45:28 -0700
Message-ID: <CALvZod6AydanksvciHuxRPoOddFX3ov0Pp511RkzO8nLn3TJUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: periodically flush the memcg stats
To:     Tejun Heo <tj@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 4, 2021 at 7:33 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, Jun 05, 2021 at 09:54:21AM +0800, Hillf Danton wrote:
> > The cond_resched() in cgroup_rstat_flush_locked() matches its appearence in
> > your post [1]. So does unbound IMHO.
>
> Ah yeah, this either needs CPU_INTENSIVE or UNBOUND, prolly the latter is
> better.
>

I will change the next version to the system_unbound_wq.
