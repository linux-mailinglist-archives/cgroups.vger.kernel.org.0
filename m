Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AF253304
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHZPKo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgHZPKm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 11:10:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3CC061756
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 08:10:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so1608075qth.5
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vg8N6XsbIE7lvZX/pCZOFe+OtpGR0YWlM+DD8uHDUGQ=;
        b=VAOKpGG4Zi1L0nHk3pQChVy6LRCqLG0qD/7fwLdWBi9XbsPa+O7Uq2p7C7i1gtvxuF
         yUiWcAjIIr7W3J71zlqtWD7t2XecOSMv4Z8Vo9D22AEnwSYBdhp9bLlcsTyqyVT0PkOm
         6lQsFFPn4vjC5shx4wLOdylw9FIQcFWlFd3ZTCqMXpqDORJ6S0UXlw3Q0fAoeya9nGcK
         3KyT/337ybzoMJsqTLWcEEqoUj/7b0O+aIgq4feNby+j5A3AAgkMjCFhu93HxCQ+qRgQ
         M0iItYBDqEZWD0cxnCQ3JfuMG9LqTb1O1DvejdQunzJkmhaRRPNY6924yuSU0CZRbhW2
         Mkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vg8N6XsbIE7lvZX/pCZOFe+OtpGR0YWlM+DD8uHDUGQ=;
        b=PNIyHZumaMGHVO6hEfY+nj0IjpGKZW4bjF5lWyxeP5Iyvo80UJC3j0/EVJY7noS+e7
         kFfnhY/t3dPnz0hGQ8oBZN2J+ieZjppaWmQd5hhnd1tOi9Lhy3N8R5/6fZ/ForMZeAzo
         K/qpLKNYZupENOQtZhn1OIebXPqq1txKWCL+gN0yLUxt/V5l+3Lm1rTZcgLKsbIvbWZD
         1nRXDGDO8a155MpczM112zT29GrGsLLqDcCdge2a+yRNdh+ZIu4Xk15FjJuu56s2zaD3
         3JN/4voYeGtXndNi9kmAKMrj7D2LLK6Q6JHh8pmqDScyRd5RmhLfWnVfrGAZxQjmtZFB
         jZFg==
X-Gm-Message-State: AOAM533DhFyZ8x+QdWHfNUFufUAHjlqYIFQts/BtkIyfNlPM5RjJGeyQ
        DMzWdZDmMr/up5uM42VOnSSDxA==
X-Google-Smtp-Source: ABdhPJyt5sPyNEvrEG8BF3rvteWdGY+/4wN0nkQCox0ECjk0O8GV0igfnvyvxHfWRXyOyeHkjwh8dw==
X-Received: by 2002:ac8:1ab3:: with SMTP id x48mr3056695qtj.153.1598454640731;
        Wed, 26 Aug 2020 08:10:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f52c])
        by smtp.gmail.com with ESMTPSA id e21sm1802330qkl.88.2020.08.26.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:10:40 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:09:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm: Convert find_get_entry to return the head page
Message-ID: <20200826150925.GE988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-7-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:48PM +0100, Matthew Wilcox (Oracle) wrote:
> There are only three callers remaining of find_get_entry().
> find_get_swap_page() is happy to get the head page instead of the subpage.
> Add find_subpage() calls to find_lock_entry() and pagecache_get_page()
> to avoid auditing all their callers.

I believe this would cause a subtle bug in memcg charge moving for pte
mapped huge pages. We currently skip over tail pages in the range
(they don't have page->mem_cgroup set) and account for the huge page
once from the headpage. After this change, we would see the headpage
and account for it 512 times (or whatever the number is on non-x86).

But that aside, I don't quite understand the intent.

Before, all these functions simply return the base page at @index,
whether it's a regular page or a tail page.

Afterwards, find_lock_entry(), find_get_page() et al still do, but
find_get_entry() returns headpage at @index & HPAGE_CACHE_INDEX_MASK.

Shouldn't we be consistent about how we handle huge pages when
somebody queries the tree for a given base page index?

[ Wouldn't that mean that e.g. find_get_swap_page() would return tail
  pages for regular files and head pages for shmem files? ]
