Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE691B6A74
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDXAsK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgDXAsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:48:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E9C09B042;
        Thu, 23 Apr 2020 17:48:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so3253843pje.5;
        Thu, 23 Apr 2020 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMf6cL1D7YLD6iKlsLUtZolXbcpW+JOh8oh3DueIiGs=;
        b=PXqYHe3fZr6F5VO5PPWJRdaX2re6I1g9UbEo9QM37Hn0kGaTttdie8rMhVReN9olrZ
         mj3+Ef0v8a3XQSPAy053pkkFrikfZjRCT2Jv5Sh4f4gU/d+iyAZ66puFzr5nLojFlZ2I
         tXzQ8xlKFsayg+zOrwrUhyDcRUZKYVhrqsXPGihrVqSvC474hoNk2qnfuw3XHtfvdAZO
         jxi3NYcXf4yLR9KZv3pTHXVb84HwVxx+cqXSiMO8ZbF/5bRl4R14tiIfYA556cGqakEU
         CJa4TitRC2rE5XkA6TiJ4A7/w4t7SOGDdgYqtFWx/pounou3MUkeeKOCD77arEOVqZUu
         yiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMf6cL1D7YLD6iKlsLUtZolXbcpW+JOh8oh3DueIiGs=;
        b=ifG9SLErN3ADgHCQSCuS6KXmoBexuWDkYkkd7aKwNxoKktLoux3k1Ag3QVBRH7hT5L
         ARUT5LF/4XHVMDh4+fI7QyCA0hVD6u83gTgz+oW0XgLc+VXk7He3GdA5n+CYZCo3RMvL
         oXkoex9BmYcwh9sAr3cP81+j19+PxwOCBO0KfAbwLJkIcuBfQ4WNeQx3JLcy7f4YNiR1
         OQ+Ep0SBDMt5Pp5ufCP6frDDi0hpg8iUrZ/X9X/DffZ3tO3hyZZJHioD6j22MvLEcciz
         5BzbHWAPFNOKjzYhlSfaepVvOkJ1Uw/9i2mgOc3Qcq6ogJSEve2cRPlh7ZE35mysHiTN
         Kbsg==
X-Gm-Message-State: AGi0PuY1GKX/PF9vAwOrvgczJ6AxwlPWwWd2OmTeArUIe9Ae+kXC+M7l
        +GGINdqgi3W/dZXhtWSTgnA=
X-Google-Smtp-Source: APiQypKbOg3KAT4Ssc1MQkxI6CFpf+IT4UfYnZbKaQnyupR/T4H8IFnxTyHkoUiEsCIGT+z/RifhHg==
X-Received: by 2002:a17:902:b405:: with SMTP id x5mr6468629plr.312.1587689289659;
        Thu, 23 Apr 2020 17:48:09 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l1sm3445484pjr.17.2020.04.23.17.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:48:09 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:48:03 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 18/18] mm: memcontrol: update page->mem_cgroup stability
 rules
Message-ID: <20200424004802.GH13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-19-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-19-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:26PM -0400, Johannes Weiner wrote:
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

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
