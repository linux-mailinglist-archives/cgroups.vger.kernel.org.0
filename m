Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A74C39BE
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 18:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbfJAQBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 12:01:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38323 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAQBJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 12:01:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so22268498qta.5;
        Tue, 01 Oct 2019 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x01awrD5TSlsk6NlvH+kQSXg+iJmGObI88cW5UgsE3c=;
        b=QWvTtiz/VZYw1m0emYZEvdX3jIvdDqxwcdnllghimSJMK3C5Ai00cL9TOAPOHwpnne
         YE15m+iiuMUNVC+K9dzxXBFNg9iGTX+VK09xl+5cwlMlABm5otzMli3Y6EdlIVZqSvav
         84cqfGop0SmbgwugT+NhoZuvW1JJCo3kW4e3RuBDjlx06YoUBhdEX0cNs0+2QotM5Wnm
         x0spmgprZ1miAdsdHHmHtAs84Un7joJuFc+fdWgb5GPLEZEgJ5WdtQ6w0iqUtrxSlBpn
         dvz/ln4tCoK+o3Dor2376kxekznS1rs+ob7tirDpEUZKjFIKlBcnxQa4w28N7qp1VEC2
         8oCQ==
X-Gm-Message-State: APjAAAWIRZfTW65nmSxNeVi8tjBPv1kSJWlXhkze0tTY4LvtO14Wr0lA
        TvhxrP3CvxQB1fFA0RfKBEtHatXtNZO5UUjPCRk=
X-Google-Smtp-Source: APXvYqwXNQ85AMQ82y5yVifrvbRIc55eAUjhwij0+sTOJVCU6PWFQrAXLde5ogB+7LJPke763XickWNjc6/9cst2GW4=
X-Received: by 2002:a05:6214:2b0:: with SMTP id m16mr25953761qvv.45.1569945667079;
 Tue, 01 Oct 2019 09:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142227.1227176-1-arnd@arndb.de> <1569940805.5576.257.camel@lca.pw>
In-Reply-To: <1569940805.5576.257.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 18:00:50 +0200
Message-ID: <CAK8P3a04nMwy3VpdtD6x_tdPC14LPPbt3JKrGN48qRo_sDVk-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
To:     Qian Cai <cai@lca.pw>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 1, 2019 at 4:40 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > of the same kind when CONFIG_MMU is disabled:
>
> Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?

Maybe. Generally we allow building a lot of stuff without CONFIG_MMU that
may not make sense, so I just followed the same idea here.

      Arnd
