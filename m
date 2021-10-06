Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09582424677
	for <lists+cgroups@lfdr.de>; Wed,  6 Oct 2021 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhJFTKK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Oct 2021 15:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239194AbhJFTKJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Oct 2021 15:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633547297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1dm0Jsv2mUc+jhdc8qHClKIoNz3UWNx693+PgEldu0=;
        b=eOsj/GGlAuVEw7NzJKCex2K5Qjrq9ukJfe9lPaktnWREHMMcU0MLczKGZpWEWDpmaHgMD9
        nw2UGRNoRaDqO5hdkmlOMKlOA8lAiOHNSgZjWlxOPty8MUdY1gX9C5C5y0Ke2SR6OS4TZL
        HinQjL2pPV/ECcuTRLsPHY35O7HaT7Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-xw6Aw7h4P0CMSrH8oiePgg-1; Wed, 06 Oct 2021 15:08:12 -0400
X-MC-Unique: xw6Aw7h4P0CMSrH8oiePgg-1
Received: by mail-wr1-f71.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso2834923wrg.7
        for <cgroups@vger.kernel.org>; Wed, 06 Oct 2021 12:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1dm0Jsv2mUc+jhdc8qHClKIoNz3UWNx693+PgEldu0=;
        b=3UHjv2ZyzfvhWIHlOHkpoZdqUtT5FdNwSdxuZJwf0NCjyeA5BZnv4hXcCd8Z4FuLRs
         ii1RGxl33YoE/LaIGivTrEmhWdGvJdUAKKl8xp+RLx8MObMlMOL2pbmweYO4elBROvHW
         Q1HY3KfI/iFsDegGcQp06Ak+TYvaZ9Yjr/u4iluftS72fHMsHU7RPP+Srk7ETz1DNNFY
         2gW5y+Tff1b5jEfnPG+I3YDmaaxnXbcIE5TqgliZBHo9IPf+Y9vr6alz9au7udk4LfTC
         kayvzGVtHDKWlBcp92Uqmo3eBHdm49sUISKkZ9I6ox3ySk5ZYAUbj8wKRmnOi8+jcW4s
         qBvw==
X-Gm-Message-State: AOAM530hXfBzsrigelboAJlKZJBqig+8amr76ex4iV2jeIYGJVIV+V+/
        umgS3nIIBivnLIbzRMHfJfas6zBMFxLqgzHiYod0D7AUEb01j3loY0Q06BQVRmJ+q17VPy7c+4z
        liMAXBsj9iQ29pT6r
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr26843wmk.143.1633547291532;
        Wed, 06 Oct 2021 12:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW3Vplh1TB3mapUwuNjmaCci2ywucaNaPkBXKlNFfA0xxJLgQjy0Of/3AUsfgwnuRUSg9LQQ==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr26813wmk.143.1633547291261;
        Wed, 06 Oct 2021 12:08:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id s186sm7171134wme.14.2021.10.06.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:08:10 -0700 (PDT)
Date:   Wed, 6 Oct 2021 20:08:10 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
Message-ID: <20211006190810.ume55n4lugekcm63@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211005202450.11775-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005202450.11775-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 2021-10-05 16:24 -0400, Waiman Long wrote:
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online which can happen when
> online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
> is confusing and it is more clear and straight forward to call
> memcg_offline_kmem() directly from mem_cgroup_css_free().
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

