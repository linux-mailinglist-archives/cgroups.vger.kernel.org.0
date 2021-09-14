Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD540A574
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 06:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhINEeA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 00:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhINEeA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 00:34:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130FC061760
        for <cgroups@vger.kernel.org>; Mon, 13 Sep 2021 21:32:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g14so21300265ljk.5
        for <cgroups@vger.kernel.org>; Mon, 13 Sep 2021 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fu4lIl+FKgt34SvsZzswMOLfBBmVaqouMxJqzvs5GUE=;
        b=Wz8/qbTPuO2gFsebTp8dF07QwNkcGKHJMIVgEfNxylqPVZk6OBBEkaVAdxFl12egu7
         l97RUWL/RGR8c934GwssB4/036sjsHpT9g0uqhwaOqSjYuXOsqG1yftRdoOu/8BIc9cl
         6voG47yQxfvp9VzEVI9Iif5Icr86qsK7yGWbgCOsrBwFx2Jr+WK4n9+Syk4/kwti/G0V
         nM5qOvg8C/2cJB40l7jsLaIeAnGw2ZFv+dElbWu8D9BO2Gt6R30tVUrztrdx7+U1Yux6
         xFN2S8CNPAjBD2AY+FHArieeB3XWjHrOCCqrKRk/SSiCyDCnoxoBZeRQWTVCBTZLYVi8
         dT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fu4lIl+FKgt34SvsZzswMOLfBBmVaqouMxJqzvs5GUE=;
        b=EBE1Hgk+2j/09uifnYcy7oVsKMLdElkzANGqGGrfEMX7t6yelExq4dzBbY3jkVhPVc
         SrYWtQKJxX1vGd8gqL3pH6pNMKwA7hsRCLq20ceE0QUHX/iYZ2BmBr/RTYn9SdATD6GJ
         4drYvX0QrbrNreuT5KM9Su6LZqhtQuDgFZfExaD1yn9YIUiztpYcuRr9woNsXAap6PSa
         6Vg8DyXA5x2GavDKzwv5zYohuwVY24AypCxboiBDLC3dL7NtkvDvC8nj/oy9qTF8ovJK
         uQIY38oqd7CCJWZ56Ef/Pn3L433tIcBaQoJCUlig4oAt8iPmT/7TlqryeB4HOZ1WYReO
         3dSA==
X-Gm-Message-State: AOAM533bgDaZ4Ra2BD7fFw2fkrAWOAYSrvmSAU9P92ng8y9ucZ1iSRMo
        GUPbW4pIE6nh0udJ8W6Pnh3M0gQKGXopnYa+7Ud1Nw==
X-Google-Smtp-Source: ABdhPJwwcJw34ryViJqWfeTSyIDbwy7I214F0qpdX1884+9sk07rIdBTGzjoVqFpSHQdDuRtvjz6KAek0X0vVU2EMsY=
X-Received: by 2002:a05:651c:113b:: with SMTP id e27mr13609792ljo.6.1631593956911;
 Mon, 13 Sep 2021 21:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com> <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
In-Reply-To: <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 21:32:25 -0700
Message-ID: <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in do_semtimedop()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 1:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > However Shakeel Butt pointed that there are much more popular objects
> > with the same life time and similar memory consumption, the accounting
> > of which was decided to be rejected for performance reasons.
>
> Is there any measurable performance impact in this particular case?
>

I don't think there was any regression report or any performance
evaluation. Linus raised the concern on the potential performance
impact. I suggested to backoff for this allocation for now and revisit
again once we have improved the memcg accounting for kernel memory.
