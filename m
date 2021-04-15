Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987CA36104B
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhDOQkf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQkf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 12:40:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98AC061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 09:40:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id m16so18001607qtx.9
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+MTg13jTruCvQFaQ2SQHWrJMRTHVexZhbO2LJXAAyHU=;
        b=f2azcLNZKFWVZUi+8XlEbk6xsbqrFPaLUskuzNkt4yE1HRpTTrcLRwV2kQt0HrgDFE
         rVwpA9q0JEuyse5ePGHghwY1t+A+GPkgJb2OnZjCHD/VJyH3ZKGS46D6pgCtC7Z95JtM
         33KKM18EU0EJI9eOZQhPb2U8b3GuVPqpmGv8JwgbzjxbOB/v2c64Uq6WeExA1QmpQZt+
         92/nDRBZIHZ1AUlVayRBlQ7+vA8kHBZynbnsZ/kVg2GY43428DBGz9LPK06fYEh6wZBX
         /I7JO6qcEZx2/Ltz/urm+ZH7FxV3/MALWzsvBgzcEo9pgtbfhLRKOZVHur6XLWVGIzaQ
         hAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MTg13jTruCvQFaQ2SQHWrJMRTHVexZhbO2LJXAAyHU=;
        b=B4uvimfEjOusAWt2EyRGegCKNG5Sa+s9r/uWFtzMtZHTrMksSc2sp7eXXef0JKgkiV
         Ob3Zp1bCkwYlUxFc9fsaADx51BBIssJ5zUw/kci3O5hANUun1STtgSPpPe74UmvTivZs
         yiX96T0yDYqYIT5R8eTe6IKoBpvpAIoW6zAVFNeIXcrrVl/DkqBxzjKfjUvI7+BmSX4p
         fqb7GpixKBNWy1lfLEsJCcb6Q7W9jucV2D4UTHDXDoILbLs2nyM0sCjr3fHKs0B28xoR
         EiZ82mc82YzOKBtpjaaMGjjyVn+jzkCstkfg7hAn61RWeiyoOkZ/uk9EpqHvfhl3L+Xt
         w9mw==
X-Gm-Message-State: AOAM530fIMsPhgoaUAayrGZpZUCH7TpeY3zGfut7nBPDah+HQTHTamPf
        hRyZZIbsR3qKlkUmlkDVQeoSaQ==
X-Google-Smtp-Source: ABdhPJwgP97m4gr1qBim6TXwSwKDUDq+Zh2ouDoYZ48bt1WH2coO+z6v2uNO5ihB0rSLUrEGT4KJFg==
X-Received: by 2002:ac8:57cf:: with SMTP id w15mr3899983qta.336.1618504811194;
        Thu, 15 Apr 2021 09:40:11 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id m11sm2173946qtg.67.2021.04.15.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:40:10 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:40:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
Message-ID: <YHhsapGx3vTlyZvF@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-2-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:23PM -0400, Waiman Long wrote:
> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> available. So both of them are now passed to mod_memcg_lruvec_state()
> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> updated to allow either of the two parameters to be set to null. This
> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> is null.
> 
> The new __mod_memcg_lruvec_state() function will be used in the next
> patch as a replacement of mod_memcg_state() in mm/percpu.c for the
> consolidation of the memory uncharge and vmstat update functions in
> the kmem_cache_free() path.

This requires users who want both to pass a pgdat that can be derived
from the lruvec. This is error prone, and we just acked a patch that
removes this very thing from mem_cgroup_page_lruvec().

With the suggestion for patch 2, this shouldn't be necessary anymore,
though. And sort of underlines my point around that combined function
creating akwward code above and below it.
