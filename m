Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5A42DE03
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNPZo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJNPZo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 11:25:44 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A0C061570
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 08:23:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i1so6066656qtr.6
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=By52BGa835IE4lyaZQwwtW5rAiE3tQH6DwCoYXbpm9E=;
        b=acZGhTzeICP5dR16o7d44zA806wjXfAFaH1u+XIyklzn3XApXetVdZA3xTVlo6FV5W
         7mhpqHdrKn7qQG7YCGWrsqMSJ/LTR/sUkidAix1OyA/T5a0UqzOy5hF3mNNla4ltmNFv
         Oay9ZIvxwsHCCOhe7oxdDn96wZcPm2/8GRVyNXK3Tsya2KnW4E7zPJ8qnAmCU+MNu/ve
         HLuf6dKzLLJhCV4MCVolKpTi/TjWPmfzTh0oahUwDKa7TbJkhez4zxc3/dtIjbEd9/lt
         Hx+Gx9w2Nxx8DFDInfXyLREY1KDQ3Irf/QLYT1oM84jVfQXe/4exZYV8UPDJWWWD9OtT
         spzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By52BGa835IE4lyaZQwwtW5rAiE3tQH6DwCoYXbpm9E=;
        b=Rd247nWXcYf9JTTI78nNWK/r9T+6l8kRyQt/u6p0LJcDAv2/jaNb2hSb+gJ7sxT42F
         om4IRvDV57DPtGWOsM7I5UYx/bcEsHKzs0pYVYK2Rsl90oqXzo4Hvygn/fJEI7wVtriC
         pHG9SbiLX2rhpBR6CfgcgbsxVGBfiGuG6boXFI0F8yJr277qEB/efcSwndoXgkh0D3yq
         pJCgUgroa1F2iB5DMiVxb4NGhcLpZd2EuBWlKf77E7yBafehO2/KrWPyLQfp1KW4L0lY
         HltewF/t3BlVJnSX9/2AYwmbYB7d99aW5E5FHelB01hhsPl+wEhvovdG5ypeQvEZp820
         4Q6A==
X-Gm-Message-State: AOAM531ObyPRcFn4zaEWkjoG+Uy1ljkGFqJ1rTSxVhPGRtwbW9Vpr4Wg
        6quPTdTvyqO/W4WJyktCviD6lA==
X-Google-Smtp-Source: ABdhPJzE7r2rfWUK2qYhXEwBeOTjEW/L3joNadlJWl12vUxkrAc2juqTsYkH1xjBMZA0vKgRe74Atw==
X-Received: by 2002:a05:622a:88:: with SMTP id o8mr7363114qtw.244.1634225018371;
        Thu, 14 Oct 2021 08:23:38 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 201sm1430966qkm.34.2021.10.14.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:23:37 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:23:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWhLeAL5RPfLjrlO@cmpxchg.org>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWfZNF7T7Fm69sik@dhcp22.suse.cz>
 <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 14, 2021 at 08:01:16AM -0700, Shakeel Butt wrote:
> Regarding xfs_buf_alloc_pages(), it is not using __GFP_ACCOUNT

It probably should, actually. Sorry, somewhat off-topic, but we've
seen this consume quite large amounts of memory. __GFP_ACCOUNT and
vmstat tracking seems overdue for this one.
