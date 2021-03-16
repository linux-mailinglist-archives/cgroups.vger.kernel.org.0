Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CF33D890
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhCPQDB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhCPQCv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 12:02:51 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0547C06174A;
        Tue, 16 Mar 2021 09:02:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s2so12004737qtx.10;
        Tue, 16 Mar 2021 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWxtuf+bX9R9Cu8TrjqwnDkf028NcAMlaQLndtH+i54=;
        b=LYzEzss7CpK+82hRa1OyJ5aKdBxvMSCKamF0GMBN3uRD3MjSqMnlr4wAbcnVkeWmqO
         xMTtoGkM+2XtUWunjz/GozmOPWH81mpg0mMYthGk6NU3chxb1OT/zTWHxoOJjW+y7ntB
         FJVIMyD12Ki7bro2nKguFU5F2O98AsnxXJEy9BU/MUIDCgEKPjCkvKYOv7OcnEWKLr+Z
         tHmR/A8LIQypTA4XLaqM6qXCgMmhMrfhcMy7oejDQr/gpqQeDou3C+fazTlvvUvsY7VN
         C1wvmeXLITdnLCvnOkmS5rBkMbCOPGQtHiEJAyAk3aDaGwIt008WGNfYLgi//LIDoM8n
         dKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OWxtuf+bX9R9Cu8TrjqwnDkf028NcAMlaQLndtH+i54=;
        b=Bpv1rK8igVDcuV9cJcR4nkLkMrj1rVEN96w+0Zmip8hH+aWBNMLJAmRMmAgAGZL/V0
         J27z32IkvyawS7VUS75Gt8nbgifpBtlsdaFfw7VKsQJtHuhjkTqOpaAs/K4M+TUMZXBV
         nfhbO00amjsccedGjfVpzO5Jh8PzxQZEF2iweBh4Bbvayn9mJNT2jum0vkqUzNRSgZsF
         kT7ltUO7Yr9Z9ejeqTwigi/f+Am1cUgj8gcsMrH1DL+K1q7oEFU6lgni06qYGPSJlZbm
         MAPlG0DjIS25QEtNgqTqN6ce/28EXiy6il88UnDAAZSoeHbldBRLNaE+HMSk9hf3AFlh
         ENAw==
X-Gm-Message-State: AOAM5317MjVHnND1xKejDePUWRUsdIV/V3G0wn0C0NCqW0XqAGYnhjmC
        xfQiTzlIh80800dhRkz4ZZ0=
X-Google-Smtp-Source: ABdhPJyLOt91wgsyuYYtOoPYt6hJjRlaQzjKxbU6Lc7KGvvik/N6MkUlXmK/47uis/lnalgwC9gnEA==
X-Received: by 2002:ac8:5043:: with SMTP id h3mr349243qtm.97.1615910570063;
        Tue, 16 Mar 2021 09:02:50 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id g2sm13740190qtu.0.2021.03.16.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:02:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:02:46 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/3] mm: Charge active memcg when no mm is set
Message-ID: <YFDWps+whDDhoan5@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
 <20210316153655.500806-3-schatzberg.dan@gmail.com>
 <CALvZod7sk52OYwxP=VRhS0q4xZ57UuSdL6Mi4Y956xDq3pTatQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7sk52OYwxP=VRhS0q4xZ57UuSdL6Mi4Y956xDq3pTatQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 16, 2021 at 08:50:16AM -0700, Shakeel Butt wrote:
> You will need to rebase to the latest mm tree. This code has changed.

Thanks for the feedback, I will address these comments in another
rebase. I'll wait and see if there's any comments concerning the
loop-related patches but it sounds like this will need to go through
the mm-tree
