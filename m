Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F03119BA
	for <lists+cgroups@lfdr.de>; Sat,  6 Feb 2021 04:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBFDRQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 22:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBFCug (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 21:50:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8FC03326E
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 17:00:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id q12so12655506lfo.12
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 17:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fb95oN2pGx3nj+Eb9wyweMoS+j1I5Uh71GzG+Sz5oEM=;
        b=rmxoZUiSYkE8WfcgoGpH7IesJ19msP/HBOrSblBil1jDywKKNf0JAOM/ZXWZUbHylE
         ZC3ZwMo8GNEAQB5DwMZpU2qre6bGCokTjqEtWwoGcnoQbvNYKFvMNBxN7n5bth2tqddl
         jmseJ5ITj1AUUqey4rvVJJY1pFpw/ZMB+uIMqEwX1S0n2zl3xv9Z4/ve3yPhU7VwNabe
         6zD1LGmW7sV8jwByfF3vS8tVg14Cx2jqVW9wQCcQWsHcvraZsvbtriBpxYOr89geqVgw
         S5rAqh/fXXn7MLD7GG1OqbukEsSXVqs+Y9uQyfp2tZiDJ0cl9RhZ5jngWRQErTthIzRj
         q/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb95oN2pGx3nj+Eb9wyweMoS+j1I5Uh71GzG+Sz5oEM=;
        b=DWpsG3uemNQI7h4imartnodgZr8UvX4vXMHTPcIlwxPnbgUHep+2Q9XAiTV82+G0I+
         vW5qiSFyE6G8ochI6U+B1R0hyBkfrXxNmT0umtMKGygCjxDxhUqFc7glE0T1v2iyNzAK
         U7QGKJgkEn15SLxQdwOv/XrlkpKm0v4pSVE6IWTbZONqhRbZNYcZJk/DNjQkD6ONk1A1
         XnAGzd6hRajdMet9qXtTWAJU6uq3PFU1k7k59oloJ0H8kmrw68GJj9O0l6u/Xyzmg0Qp
         WuBx/lOO86B9/Ls6nL3VAv0JjfPz3ODGCXvRjLL1HKwP/xTSndWPdBBTHy+LhfRsM7qU
         dJTw==
X-Gm-Message-State: AOAM5330fo6DqrwbDrb3FL3OS1+3SAn++HqDc0OqbzWzqf9zOV9Vn5d1
        Y3k1DPmKtyv05o+sSY6asV4LXWaMFcstB25ktwTAwA==
X-Google-Smtp-Source: ABdhPJxO5T6L8jGlLaSb3hN78KcIBodI1XXIxksiCZSZKhqYtKXh+IajAf/ZWDzbObIORdgIN5KK24RJzV+6a6SkJlI=
X-Received: by 2002:a2e:8541:: with SMTP id u1mr4306946ljj.0.1612573219209;
 Fri, 05 Feb 2021 17:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20210204163055.56080-1-songmuchun@bytedance.com>
In-Reply-To: <20210204163055.56080-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Feb 2021 17:00:07 -0800
Message-ID: <CALvZod6Xv6jJbUsJ0Rh+7tS=SjOPxY5MqHLtr2JdJZov9T45wQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: replace the loop with a list_for_each_entry()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 4, 2021 at 8:39 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The rule of list walk has gone since:
>
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
>
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
>
> There is only one caller of the uncharge_list(). So just fold it into
> mem_cgroup_uncharge_list() and remove it.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
