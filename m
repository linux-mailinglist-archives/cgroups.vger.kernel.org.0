Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF342E090
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhJNRz5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhJNRz4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 13:55:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE78C061753
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 10:53:51 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k19so4194552qvm.13
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJB8zVukIQ+/02Rc0y98q23z81gJRt8QzQtT1HzSbCg=;
        b=ELuQkXd9ubC+OOcBV7fXc70bOKtTagxKSxoApRUZ/4BsKndSk0l6tVMuHdx9fGF8zH
         GORoT66pFq9wl8kI1VG/IbM0ZkQtbmbFy28q5ZyHmlwRLBj6NWqSXekY1Otqk933Qbv7
         ZzzvXg8ECuwL+T68M4ziC52MUIzd1A/c3vjxaTKvNjOdZKbK5kJbRJOctsmBzxNUL/YD
         1THlLPXxUs/+yF6XR1swIr/l3cprEL6aLrnPAQw8H4lRzMDB8F20ARkbeGD9svke4yjt
         Whnosw86G4eJkcVRzBte5sAgcWStb1FwWIYYSpxBMgiIP2ZHEgXw9eYXD0AKGy59C/HR
         pa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJB8zVukIQ+/02Rc0y98q23z81gJRt8QzQtT1HzSbCg=;
        b=iWzFjsYHJG3dYvajanewNTrTijdQyMBWxo0cXSrERdtbx2/ap0gq1309zoixKyPX3N
         guoafqLPw88IQ77suqwnZzA54Axwapo8OFhbVGnlDsa7Q9EJKM//z7+N/QOSZjKJ6ku6
         Am9LQpOJUkYWn8Ez7Sh/cygUrntLLgaXX3CjDRhkBH45Z4ByBGRKlkukpIZTKNtXrU0J
         hrXpgC0INAqpRwmpbwxMprqrHknOinWfKRjKAZC3GHpkUx+RU93c7Nehl0Xaqctl+r+s
         3fcKOkHhzysA/3kRF87VUMKRYlM54a5WboPAiTpJ8hgHXpuqDskyP/yWP4+yxTSxpHny
         rrPg==
X-Gm-Message-State: AOAM533aHBaYpkMysMJkUPdOJnD9PiwwJdFXP62o+TOgmLjaPBEFlyQ1
        fgUnMrUy8Ij2HS6bPbM45vZWdw==
X-Google-Smtp-Source: ABdhPJxs6J1YFfPVOY54XBg+m6W3BkcHF+q5DixWAchSuTpZvRCuu3J2EDc22HFiu2RbpWn8URKa0w==
X-Received: by 2002:a0c:e885:: with SMTP id b5mr6594010qvo.18.1634234031011;
        Thu, 14 Oct 2021 10:53:51 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id l3sm896707qkj.18.2021.10.14.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:53:50 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:53:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
Message-ID: <YWhurV5tLsMZQaA9@cmpxchg.org>
References: <20211014151607.2171970-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 14, 2021 at 08:16:07AM -0700, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
