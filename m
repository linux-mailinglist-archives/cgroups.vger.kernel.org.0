Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469AF1B4BD0
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVRbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbgDVRbO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 13:31:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185BEC03C1AA
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 10:31:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w145so2400747lff.3
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH/4JiFaVWzo5ZXlfDSZ+F9xWKfQK8/az3nRBT+3Ob0=;
        b=sy64pUBYeS1VuzngKnQzfqPdwoQ9xR/N3Sz+eeFgQarNRaojQFOFsGacyr3y3vkVyI
         scgMTxXkb4gRjeInhr4AoiaQ9IKFiOOktM5Ygev+YIjwJ9Mg0bxO456FvwhLwmBVMLRK
         YWJNZpAgZ0rSUjnJ5dyQB86w/4zGV4Qo5s9Jl3M0eN499tDFwZJ2boUBSkDqVLkFNwfs
         TY/yBVN42t19Bl6nsw+Q1t+McQDsP/TYTmM2DyppBmJOmkuLDEp+B3KDY1HrMTtQKpjA
         ugfESwMkPOqWW3PK4mKx4D8Z3PvoRRIq1M0yGb1+RvD/WPnPy27gy+n4+Cahdj5uU09N
         PY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH/4JiFaVWzo5ZXlfDSZ+F9xWKfQK8/az3nRBT+3Ob0=;
        b=XvTiDCV4RNeLxBIA4RgAQ32/PMWVjencTfauJrtL65Jodc/y0SKvA6ykeIxq3nV1RR
         bIQdhh68nwXROZljBOE6koxFhLRq1kaw7ZEbbTMswj44aTmXgXs9D4pzcsk4e7JC2yse
         FDWbkvJtF6RY7mfoLT5hrpZ2v6sR4ulyEdccEuIIUmJq6mWX9S5bzgeaHrXcAENZBJGF
         o5GpGM/P4Oi3m8WZ0lLTUU7/EnLxEgJdgaj3II6HsFOuGKtmFqt55HWHmFXfhYZXfZ2t
         JJOPZwRlZksEmG8/sKlTA4aFqjHrH0s9NilxDsQ9AfsnPhPquI+dMmXhtO7gRGO0KTDD
         WKDA==
X-Gm-Message-State: AGi0PuY/aQoNJRZGVc1g+iyaYwSIutoLef82j1UZYwi9WbY7bjUzK7ja
        4ga0mbJSpruipPG3w/2XSl+eHNj8HSZn7Ep/GB1hww==
X-Google-Smtp-Source: APiQypIBOdCeBOlaD4SwnrUl2Ov2dmhMv62XLptmy1XZzhZrOSgT2Am8PtZwCUE2ZTV53ujuKoxlQ4ySiX01O04rnrU=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr17530208lfr.189.1587576671205;
 Wed, 22 Apr 2020 10:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-4-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 10:30:59 -0700
Message-ID: <CALvZod6433GCgVwV7=h5zoByKj7ANoox9FyB6m1_k63KJJnyMQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] mm: memcontrol: drop @compound parameter from memcg
 charging API
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The memcg charging API carries a boolean @compound parameter that
> tells whether the page we're dealing with is a hugepage.
> mem_cgroup_commit_charge() has another boolean @lrucare that indicates
> whether the page needs LRU locking or not while charging. The majority
> of callsites know those parameters at compile time, which results in a
> lot of naked "false, false" argument lists. This makes for cryptic
> code and is a breeding ground for subtle mistakes.
>
> Thankfully, the huge page state can be inferred from the page itself
> and doesn't need to be passed along. This is safe because charging
> completes before the page is published and somebody may split it.
>
> Simplify the callsites by removing @compound, and let memcg infer the
> state by using hpage_nr_pages() unconditionally. That function does
> PageTransHuge() to identify huge pages, which also helpfully asserts
> that nobody passes in tail pages by accident.
>
> The following patches will introduce a new charging API, best not to
> carry over unnecessary weight.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
