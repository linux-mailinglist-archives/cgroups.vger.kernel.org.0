Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C76457C63
	for <lists+cgroups@lfdr.de>; Sat, 20 Nov 2021 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhKTIBi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 Nov 2021 03:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhKTIBi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 20 Nov 2021 03:01:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6AC06173E
        for <cgroups@vger.kernel.org>; Fri, 19 Nov 2021 23:58:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b1so53909809lfs.13
        for <cgroups@vger.kernel.org>; Fri, 19 Nov 2021 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDPBsHcfNzrPZpXm7j+tJ6FtAT1aH1QKACsXUwu2lsU=;
        b=PDIEkVRE4lRmmix6/kxfmiSW4LoI0BO2oI5eeIooXPPBVyf65uczSyS7/ryrSS30TB
         yxTiLtqZPEhw/QJsG03QilaLw0yxveHy4FdQKSADKfOQeZ+PzgAjKkAAMZ9fTG2X7PHy
         q3PcsDO1p59bhbLyWub0/L3p8OfhhttrwOAZUm4+ltQQgUTSY9rOrbMNacNSIAxYb07s
         Pt9fk8i0hGIcYGImn6ufTyobVPEffh3xY4MdR7gl7Eu8nyqzLZKq+TnidX1MqXLynmwH
         iiRf2LJpIO+G67HLqgqO+zKYKIscIpBouV5K55umtQPZenddR0fPFdAUpe1yoLJuk4WU
         nAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDPBsHcfNzrPZpXm7j+tJ6FtAT1aH1QKACsXUwu2lsU=;
        b=ULN5t9xj42l3Gw6akUzotR0MjZfI5LbOm4Y/EKIkLaTzePRI7lGFVDNt+IUp5OfpFn
         wxb7sbqbpSbPF4XZ6ckb2FBC/8ptpvf1l5AzRsYqyAIK2x/hnbl1SV1ZIMDHog7FB/lb
         LE4nguPsuZVmZrsLiMb09HCwJ331cifOnh0+8BFkirlT85Mp3LN6AaLa/cu6ACxdPO6z
         fIVQ+oPGJleRvhCS+Ly2u+gq5b3hXORjITivZd72DoTNSq+uNqtToBDZIE44NLpfA+bs
         ZMxI3q3UNl+RPL8DObZYKG/WWRhc4t13S4pBl9QJLJpEc4HaNyYWNGIQUmA0g0eSaE/W
         b16g==
X-Gm-Message-State: AOAM531htreeNFW77zpAHW7jtiZuIYcEZUQcRsejC0cawEek/2WJoXfU
        EQsX7+HvMexqvmgomNd8KfPxLGYY8na5Zr/tcVTXEw==
X-Google-Smtp-Source: ABdhPJw+OYVb4seahyrAiDFYKQkciHblBbjBsl9XGIXlNspD805fH4RQ2gSTe1cRC2JQc8l1JxWEgxNl8G9bQKbPpYo=
X-Received: by 2002:a2e:a314:: with SMTP id l20mr34005249lje.86.1637395113126;
 Fri, 19 Nov 2021 23:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com> <20211120045011.3074840-3-almasrymina@google.com>
In-Reply-To: <20211120045011.3074840-3-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Nov 2021 23:58:21 -0800
Message-ID: <CALvZod680y1o3WKFKEXmXf3Cd4j-POpc-zrAQ1+ykLoWK9-21A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] mm/oom: handle remote ooms
To:     Mina Almasry <almasrymina@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 19, 2021 at 8:50 PM Mina Almasry <almasrymina@google.com> wrote:
>
[...]
> +/*
> + * Returns true if current's mm is a descendant of the memcg_under_oom (or
> + * equal to it). False otherwise. This is used by the oom-killer to detect
> + * ooms due to remote charging.
> + */
> +bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
> +{
> +       struct mem_cgroup *current_memcg;
> +       bool is_remote_oom;
> +
> +       if (!memcg_under_oom)
> +               return false;
> +
> +       rcu_read_lock();
> +       current_memcg = mem_cgroup_from_task(current);
> +       if (current_memcg && !css_tryget_online(&current_memcg->css))

No need to grab a reference. You can call mem_cgroup_is_descendant() within rcu.

> +               current_memcg = NULL;
> +       rcu_read_unlock();
> +
> +       if (!current_memcg)
> +               return false;
> +
> +       is_remote_oom =
> +               !mem_cgroup_is_descendant(current_memcg, memcg_under_oom);
> +       css_put(&current_memcg->css);
> +
> +       return is_remote_oom;
> +}
> +
