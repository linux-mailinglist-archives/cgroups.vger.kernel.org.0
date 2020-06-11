Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487821F64DD
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgFKJkh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 05:40:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54587 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgFKJkh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 05:40:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id g10so4340760wmh.4;
        Thu, 11 Jun 2020 02:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7As6uSYKJIDVnQAAEPQVgwwIZgTE5NFEu/RzVDwggs=;
        b=r7ZgFvp3TqjrXoLq1p3GWPiM3VkYyMHZrNkIzmEVet4E1t6Z28ncrE3p6jq5AxHV+t
         J8h4amQEeTR8ShIkvATCV9FXvGhLdh1jo6irm10kbEoUp+EbAJASWGS52Gw1wrwLrrV2
         ZX0tIVCFInfJyuPivfGJQ62k2if6L1UWzDwtCriIDvVLNm/AuYqJZ3/hcJGMKoHqGFbl
         IR6voeAvr7hZxhsXa0oLB+cbAaAP/YVK5+KKkkvet8IgBzHj2YTWCa/XFcwBpJBATfl+
         pbEj2rB39AdjYrX9kkbxIfkeyINYNSepK0Oud6EgDH2Ahp3SEj7QXyFzvnuWeE6Hsk7H
         YicQ==
X-Gm-Message-State: AOAM533FhlPsx2U/sLZhTZV300TdMffKDDIzlTO/SFHDs0gYLGoOga/Y
        KP4G8NlTWKnG+OCmLRPWSwA=
X-Google-Smtp-Source: ABdhPJwKYxLynBYWf8bE86R5FOu50icX4WssBi61qH6gatM5hr/CP871z4VLtTkF+IP90VD5efX2fg==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr7262406wmi.119.1591868435507;
        Thu, 11 Jun 2020 02:40:35 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id l2sm4040320wru.58.2020.06.11.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:40:34 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:40:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 19/19] mm: memcontrol: update page->mem_cgroup stability
 rules
Message-ID: <20200611094033.GC20450@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-20-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-20-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 08-05-20 14:31:06, Johannes Weiner wrote:
> The previous patches have simplified the access rules around
> page->mem_cgroup somewhat:
> 
> 1. We never change page->mem_cgroup while the page is isolated by
>    somebody else. This was by far the biggest exception to our rules
>    and it didn't stop at lock_page() or lock_page_memcg().
> 
> 2. We charge pages before they get put into page tables now, so the
>    somewhat fishy rule about "can be in page table as long as it's
>    still locked" is now gone and boiled down to having an exclusive
>    reference to the page.
> 
> Document the new rules. Any of the following will stabilize the
> page->mem_cgroup association:
> 
> - the page lock
> - LRU isolation
> - lock_page_memcg()
> - exclusive access to the page
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks a lot this is a big improvement and simplification.

I have gone through the whole series finally. I have followed up where
necessary but overall this is really nice!

Sorry I couldn't jump in to review in time.
-- 
Michal Hocko
SUSE Labs
