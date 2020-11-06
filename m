Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC82A99BC
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFQol (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgKFQol (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Nov 2020 11:44:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD33C0613D2
        for <cgroups@vger.kernel.org>; Fri,  6 Nov 2020 08:44:40 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so1517269lfe.12
        for <cgroups@vger.kernel.org>; Fri, 06 Nov 2020 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFLzWInf7oW7bjGKiJqYb2/P1LPe/HLqYvjRIRLjv10=;
        b=RQjhXcPHc5TehIv2m28NXMCfMB8WOK9adl90A+M0wwX8PK6WMj5fVagX1y4Z5YeMsM
         /1FU5uFqyQmCBuHK0ikHPWvQrVgo1mHtafkOOO5k5CY7cpfLKoxGtKeLHpLb3lY/jJ9C
         RVOaNkFwUQJ/bhi8vvvNok/I/RDEDELO9MiyB2iPiBqfmvEnqBk71I2SRpv+Ban9L2fR
         bEjBtwl9BqqVM/kjUvFv7pNt0oKoD9siqOKBcd2O2cqn16cAH4ZoN6taKDYEzbOWoX10
         VtwXLYKrJU5/wPL353TmCD01vVcEl8/usm8BwvYiDbimiB+SodnlttN7tGoOfFR0PgPv
         XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFLzWInf7oW7bjGKiJqYb2/P1LPe/HLqYvjRIRLjv10=;
        b=cNU2QTjAd6zhLS2uBYKhS9m8riBbNBA/vGG38IW6JLWRlItJoWwv8lG0RPU5WfKMxq
         OFyRVRgafQNWtb856AXxNrR9yu+3YZ4hhn3NVpa7KDV1LV8YboWGtgnnQacdTWDv6pkw
         3ZwMIT/TOwwTibXSZPnMyT+M4vT4N4pcTEmVbKadjHhfoI0/fSQq9qV48yU313Rru4qh
         UapOTAlvpxc0NKhkZ2Z/5JXghEKLUdW8wYY7aeQ2NAB1PBqz840+pF7iicMFBAN8gaef
         OMSh6C4q1GS9pNHKQvKaSfkamzpqVUVoIhKqMD5wlqkhv4v7bU6zqOlG8teLKOgSRaje
         edlg==
X-Gm-Message-State: AOAM532K79IZOZUX3K2lFv+Sdg0bV752X1T7KHCobWbqXtF8Z2YS0uyh
        JlaYE39Z+K1QzC6MniCnko3dnYK/0vINAUHP54AfOA==
X-Google-Smtp-Source: ABdhPJzvx9kTQoQU7TzDmsNIEOUAUb40PiYa+6L+oqi+65en5PqDp5J1/BrC6Jd5BAxdLnXTv9yV3MQUHbUbnOhOGX8=
X-Received: by 2002:a05:6512:2154:: with SMTP id s20mr1146709lfr.54.1604681078897;
 Fri, 06 Nov 2020 08:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20201104142516.GA106571@rlk>
In-Reply-To: <20201104142516.GA106571@rlk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Nov 2020 08:44:26 -0800
Message-ID: <CALvZod7-FnQNqH-REJtrSuo+xfVMyv0os83-MvXS=ciGKZGA4g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
To:     Hui Su <sh_def@163.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 4, 2020 at 6:26 AM Hui Su <sh_def@163.com> wrote:
>
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
>
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
>
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
