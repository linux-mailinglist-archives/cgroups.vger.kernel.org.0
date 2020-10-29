Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0744129ED5A
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgJ2Npc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgJ2Npb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 09:45:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03788C0613D3
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:45:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so3402832iod.13
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lMVsDoZ2rvYhRouYTnsQqKObuVh6EX/L2Iet4zmcg+0=;
        b=BqZ2R2ieXOiIyfj4R06JqpmwkZDKmSom+oB6s4vJ3gT+gZ0OND8K/gSscTX2Ax4YSL
         th+NpS/aAW9WU9gUbnUk6J2t8Tp6ot3gvUb+/Wqxbmh9oVvb4neSwLThNjXM4j2yFQUg
         Zt/qaKVHiCUkE6S2dy0ZLkpZ7hAoJZTPQ9hb2rwV67DMknJ8A1iSh8jHBADKov09dNWG
         wUL46gT3QRe9y0P/5t0OhMkwqxX8F/m+Py4topxcn5Ws8DywxAPZ/2FzlE6cx4EpvU/8
         XPEiPhhjlKLee4syFyTA3ZhySwdIZlKRhkhJCAVIDBlBVvgErA68e84xR75aHFHvDqiv
         lo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lMVsDoZ2rvYhRouYTnsQqKObuVh6EX/L2Iet4zmcg+0=;
        b=fVe78/UILhtE5EVcWtD3+T5HbADEXqpdFMWZNbm8GYegzgf9ITIJKPEg7bqKYMgZVx
         61dVR/xu9D88leh3R1x/emlL3ESutN8FL+Xed8fMJnqhYgnl5Fc4XXWY1EpnhDoMxI+T
         RNEyRZTT/Qt73g/EjdaiF2cJ19Df84D9eh8VGLNN8hJ7kPa+s0ec5koOKNv8FCSokZ+Q
         Ouy0qn5Ku9Nf1M/+4xQSLAZWGmSrnQ1xdpjNxGr8haapSSr+e2WGX0dozGtA3rPd4XWa
         cVfU3+HO9cWp7GRCwFzSAXZe5ZAS6lBodDHZBBCpbuhhcwv5pQ0RVOBy7dd1Vtm4QHIw
         d/LQ==
X-Gm-Message-State: AOAM531YkgRUpEgb0sCLqLkRqlR7l1pjxxDLNB2lg9FZp4A7hkJGbpPa
        sZCW894OP0Tmw9h3RS1iXn3oMw==
X-Google-Smtp-Source: ABdhPJw/UxKZenF/5zce1bBQYI8Jab+fyaFmZKutTSonAjsrtKq4WJ82S4BHxXpvNmFvbfxO1fy6zA==
X-Received: by 2002:a5d:8987:: with SMTP id m7mr3494563iol.20.1603979130469;
        Thu, 29 Oct 2020 06:45:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id c13sm2352228ild.68.2020.10.29.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:45:29 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:43:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v20 01/20] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20201029134346.GB599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-2-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:46PM +0800, Alex Shi wrote:
> Add VM_WARN_ON_ONCE_PAGE() macro.
> 
> Since readahead page is charged on memcg too, in theory we don't have to
> check this exception now. Before safely remove them all, add a warning
> for the unexpected !memcg.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
