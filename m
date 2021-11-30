Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06694462A95
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 03:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhK3CkD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 21:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbhK3CkC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 21:40:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F478C061746
        for <cgroups@vger.kernel.org>; Mon, 29 Nov 2021 18:36:44 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e136so47978718ybc.4
        for <cgroups@vger.kernel.org>; Mon, 29 Nov 2021 18:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgI/AaQZFO092ur38zyTNNcK9cTmIjNH5zoKttaDw+s=;
        b=kYkEpq6LFfs3NoxTELSmxCDx47pYFaIovpRQGk2quPgVmdWUClF+vOD/rZsiomySAK
         X/zimWA0oKUSpvxdallx8oTsNjVTID4LekkUuE/tLkqT+GQ1HYUie6ZhKNFbOtfVyLrg
         Ol6Ov926pxHkMA3keHjhtZeyKd40GR/QHKJXOriNYWJvDwZi+y5GANYYSFLL7EwFqLls
         SWOM6of0sDfztlYzipJoSoyG0n7huKNlRqpRkgc+Flg82cBAIaqmbxv4poSaIfXHcBVP
         68vLxzZrlSTYmwhvu7R6HepJZm6xQ31Nn9db81qJeAbnEl09V7n0zPl1oE840Yz/jQlU
         SWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgI/AaQZFO092ur38zyTNNcK9cTmIjNH5zoKttaDw+s=;
        b=k0UJq4tksovEVWZ/VX+qDeGa5oXveYRFlDTH+K/422JNq5jRMpaJi0ZYeOadRs3NTN
         P1RP+DUGAuNOFIPBq0UES7usfweNVpwyGoqbn50W9sx7hgQaPR9ff+K/8R4300OJ/sYQ
         suGICvLlxZcYYCKZzF163SCYADkXT7Itpk/XVO9T09e/zF02nBakf4PaqkrkFTSHuwsN
         gGwP5Wq13a9yFhu/N+kM5jXHSB4VS5cYqG0U5lkm16PqOHeXaMoCB3FFhDCKyauQzlqm
         o6cJCfxQEwmNd7SeALxK7vwAY3AMBJcx+78Fq4h/rP1/YcfdW9z/wNroRUx6rH/0rA3i
         QSqg==
X-Gm-Message-State: AOAM533c75aSP61rAukbvdO2dCfPn0y5ueUAFzsx4IJsNqTdgtSHtrSF
        k2YQERwpPpy7sE89cUW04Eg/5h3UYqJTRoY3Nl5HpdGVJzt+KliX
X-Google-Smtp-Source: ABdhPJyFf6WTkt1uX5KpYxUT5GJwtE8x2E0e3vEVMXMsXaGqkI+umr2ym/BiLOmJvqyb8y9kR3sw1Ymo4ANuwF0vanc=
X-Received: by 2002:a25:ba0e:: with SMTP id t14mr9675193ybg.49.1638239803470;
 Mon, 29 Nov 2021 18:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20211129161140.306488-1-longman@redhat.com>
In-Reply-To: <20211129161140.306488-1-longman@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Nov 2021 10:36:07 +0800
Message-ID: <CAMZfGtXvHB-PRe11VmmFqsLg9EQ3LUPqYA2zNi-1A81p-pzH5Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Relocate mod_objcg_mlstate(), get_obj_stock()
 and put_obj_stock()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 30, 2021 at 12:14 AM Waiman Long <longman@redhat.com> wrote:
>
> All the calls to mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()
> are done by functions defined within the same "#ifdef CONFIG_MEMCG_KMEM"
> compilation block. When CONFIG_MEMCG_KMEM isn't defined, the following
> compilation warnings will be issued [1] and [2].
>
>   mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
>   mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'
>
> Fix these warning by moving those functions to under the same
> CONFIG_MEMCG_KMEM compilation block. There is no functional change.
>
> [1] https://lore.kernel.org/lkml/202111272014.WOYNLUV6-lkp@intel.com/
> [2] https://lore.kernel.org/lkml/202111280551.LXsWYt1T-lkp@intel.com/
>
> Fixes: 559271146efc ("mm/memcg: optimize user context object stock access")
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
