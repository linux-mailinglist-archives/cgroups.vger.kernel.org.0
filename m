Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D44510DB
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbhKOSzp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 13:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbhKOSxc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 13:53:32 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08DC0A3BDF
        for <cgroups@vger.kernel.org>; Mon, 15 Nov 2021 09:53:13 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e11so37215639ljo.13
        for <cgroups@vger.kernel.org>; Mon, 15 Nov 2021 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NsJwQViYjBx6x1vnKWwbVuDzGBfSCVWT/rbaDdS07o=;
        b=KO3K519hv/U7eBTcKvTNDP2eKFUA2AUXYqJpuH3H7HpyMWbd/okypmhcyl68qsgEMB
         Tk6M3OgdZeFJesvlAB5Bhgl6XW/O9P8mk3dMd4fFh80iqqMofW9VhwiDp62KQ0N/YUUx
         kuKS6PM57Mxitv2Gso7uX6bsb3i2CsyEFARebzexwMlXFoA74eOMXb002OmB9tn9+Y85
         wR9hyRPYMFGUdQX09cuC8rvxOvFIKVUi7nFklVRic3dV6iooqaWcyuL5oVncWpD+oPvG
         mL1mSaV4SWgyrxi/iuT2d03XoYCARQJVASW7AGQBqLHs2tgGfUQfKdhwJr20mXiPSoOr
         4lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NsJwQViYjBx6x1vnKWwbVuDzGBfSCVWT/rbaDdS07o=;
        b=hiabKU+0qbsyKle7R78Hoo0/OukPH2prNOIphgko4EiMQALqvrGNiWqWXGiSHk9p6L
         zNfBUvMBqVpYX06So76hEiEqMK0oTMW4S1eGcuVSSTc8yqTYJyv2m0gZDQwjV/t2VtIj
         vxE6Ei0PYd2QB6e/zZ0VJ+lHlEj/qn3Fmf7yCBrT8ZwsUjyiNQqBxwr1OCUBG+rP+U6I
         S0VZcCFNws3hGnX8HqaafZtR9MvzIOMksDmN7XQ/LF1UWxe1as7viebFP4YrHEjgiM2b
         Bk/jv0KmGQg/2+lCsIxffkdBWGau5rFZhc4AHjQzm9zkVDG0CWPp6AN0evZ3xpDcPiCk
         hI2Q==
X-Gm-Message-State: AOAM5325+sK/AN62WpXxgFTnC3RTbPZBYTytg/La16dWJMDgrWYr5EXS
        q3UUh7SOqxh4Z3MgVOitjRTJ61rpxFuZFJi5Hb+fEA==
X-Google-Smtp-Source: ABdhPJwhwO7vj3l7PglblWhEu/u5R0j6w6RyAXBfY3b1tMLAwK4ATaXsbDMVLHDtN2AxslDULON1DIcW72dsbChwW+w=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr448399lji.6.1636998791657;
 Mon, 15 Nov 2021 09:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com> <20211108221047.GE418105@dread.disaster.area>
 <YYm1v25dLZL99qKK@casper.infradead.org> <20211109011837.GF418105@dread.disaster.area>
In-Reply-To: <20211109011837.GF418105@dread.disaster.area>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Nov 2021 09:53:00 -0800
Message-ID: <CALvZod72uULZ1TfJbk5q-0cVTmGfBG=a5zNb69nb4A2bv+pPWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 8, 2021 at 5:18 PM Dave Chinner <david@fromorbit.com> wrote:
>
[...]
>
> > If we are to have this for all filesystems, then let's do that properly
> > and make it generic functionality from its introduction.
>
> Fully agree.
>

Mina, I think supporting all filesystems might be a much cleaner
solution than adding fs specific code.

We need to:

1) Add memcg option handling in vfs_parse_fs_param() before fs
specific param handling.
2) Add a new page cache memcg charging interface (similar to swap).

With (1), no need to change any fs specific code.

With (2), fs codepaths will be free of memcg specific handling. This
new interface will be used in __filemap_add_folio(),
shmem_add_to_page_cache() and collapse_file().

thanks,
Shakeel
