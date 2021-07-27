Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4713D821C
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhG0VvE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhG0VvE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 17:51:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC42C061757
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:51:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m13so24294555lfg.13
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GJDqmdaLtkaW7Otz+OuKF+u9n9yLDONH7a1pUz+R4g=;
        b=vU99ZBKDzMVUNqf5sfsmKOTh7f/nFBljme/8vZdWEh6VMl+6pjjr+Fh1/llaa1Tmu6
         E9e293cJN6TpD5hWLPrX7NX8k8plP1ci4gLMwOoW9HRfOhn/zBJTz95wIGo8wmUwy72t
         Q8tIijJECxZZ/W7XHUlaS1CYRF5ZbobafO8eG4ZXzbODrSoQrWT+KHtcnPJ+eTgQiKCN
         PGhFkiev0aEVZ+yPmByqlCAKbem3VGZ8EI60BhFe7uveUqq3jRNUoMwJTeq236JUuDip
         Qoxh+xV/V4nysMXdXY/TVCpkHGqeXFqXWYC3SFsVAGOZZIfMsH+Nw6n2bnmPy0sihGCH
         GWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GJDqmdaLtkaW7Otz+OuKF+u9n9yLDONH7a1pUz+R4g=;
        b=HcgtF53UQmVGu2iQ268JkBa/7lzw52GMBumJevF+blWfrvyU8qpE13PcrUvJRM3a9U
         0KS6XAonym/0X+VLEOTtBgW6vMwotjnc51UwMZLlwDKCV9Q6sX5o85jViTHDw49mAakH
         ei5xoeKR+RR71qGsQZdwqpFyuvTzpJhan8v8PHyjQI6r7P93rh4E5sACkqgNKig0hmTp
         vYSSwrlfM5veJ6TynC65zn4p+y+VhCcKbAczoiMabrJu3tuVgwkVyPaEx9R9fvmycpAA
         R+z3OPIyskdJwfZwpKq9L6tYBPBL+jtGHgilePPyjdW1OMjjBhIprQ7wQF7Ve1uNqCLK
         Ja5w==
X-Gm-Message-State: AOAM533t+TED9s4LOgf2WHQyM9Zay8uBQPqvHypsudEbiDWxv4NdQJwO
        m/N7EcJV5atIGIZ44wIAWkkCbMbwmtF0q2SReaV4d8p4zU8=
X-Google-Smtp-Source: ABdhPJxiF7JZ1IzEl8lQTFbT71fuPW6s9e8dyJcfiNsanpiLLZSmPVXEg1YBkBDYHl4Ww2jWkxptQzPlLISmcGv/3S0=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr17787703lfe.549.1627422661756;
 Tue, 27 Jul 2021 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <1b408625-d71c-0b26-b0b6-9baf00f93e69@virtuozzo.com>
In-Reply-To: <1b408625-d71c-0b26-b0b6-9baf00f93e69@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:50:50 -0700
Message-ID: <CALvZod6H8atu5k3xhKf11SEMjyVjXMYFGWKBLsXStYhYs3FNCw@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] memcg: enable accounting for fasync_cache
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> fasync_struct is used by almost all character device drivers to set up
> the fasync queue, and for regular files by the file lease code.
> This structure is quite small but long-living and it can be assigned
> for any open file.
>
> It makes sense to account for its allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
