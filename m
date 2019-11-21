Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28603105B66
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2019 21:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUU4e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Nov 2019 15:56:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKUU4e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Nov 2019 15:56:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id a137so2533550qkc.7
        for <cgroups@vger.kernel.org>; Thu, 21 Nov 2019 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jo8ATEWyaSv/vLCn6HnPEaOlsTqvflPgdCXI72jAtAM=;
        b=cwuJLrMBZhPa5DBRo45PuWX50UB2Z5+gnbtBmxVA7l/W0adG0YbnCA+7EREee4ihMc
         /RtO2VS4M4autGBGzWZTC46Jv/LvU147g9Fe9ZrChLgdMY+2MhaYCoaBjmPAKML/GefK
         VsbDCS5rx0r5a8Yr8KgX4nvZa37JnXmMlmF9QekitglonB7f4EXFQTtRmVDQb2Zbltlx
         KwQpiRpPbM2LMBteWoe4r9FvgKpzKFjVlySacY13KC2eiNkTNw4bwv7DtJGh5FIwLoM2
         eD8G2mK3gounHPRVqZB7S/qn3WcDBAFP289D4mndKgQmZUjv19S70bmW84IqqAvtTHWJ
         c2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jo8ATEWyaSv/vLCn6HnPEaOlsTqvflPgdCXI72jAtAM=;
        b=iUerXm0Quh4dQF7vF/aKyoeRRLA2g/wjakyJxDbZEbhKroQ/JtWMVGKKfugW28nOy4
         P2Z9DB1OAzlplZ5TWBFfRHQCaRZkDjKCjo06qawiILAf/65Jv1iI1nnSwFNMyW2eMUxr
         1HAFBf20PuZrRcPKBt9o8cliWym/LDkmJoQJnt+yAgD/CfXjeenl1itQHtvbZMMOyno0
         n/UPKKOZsGpHwpR3C43ikzaeIYNJcp+eYswlrvnhLEytnz4ijz+WQ8kDXhcD8UNrlSAI
         XbqZ97lRRxdboZ+t3d4a6gpT4vNoRf90ugwKZH6ya399HuLgxYIi0NoyFP7PEi5k1zHc
         +VBw==
X-Gm-Message-State: APjAAAWZEowiINa3Tykgh6evGN9ssQzJtDGc+9JHU4+BoTkZ59NXimdZ
        icTaTWrHRApWaBKAjky2k/A47A==
X-Google-Smtp-Source: APXvYqzsNvwhS/lTU40H0qPMgE9W+CAi3eGFu6U08L2WuddkClqPGbs73rv7JHDvuvP81IsNUVvndg==
X-Received: by 2002:a05:620a:1653:: with SMTP id c19mr2834381qko.482.1574369793110;
        Thu, 21 Nov 2019 12:56:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:dbed])
        by smtp.gmail.com with ESMTPSA id b4sm1934576qka.75.2019.11.21.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:56:32 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:56:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration
Message-ID: <20191121205631.GA487872@cmpxchg.org>
References: <20191120165847.423540-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 20, 2019 at 07:15:27PM -0800, Hugh Dickins wrote:
> It like the way you've rearranged isolate_lru_page() there, but I
> don't think it amounts to more than a cleanup.  Very good thinking
> about the odd "lruvec->pgdat = pgdat" case tucked away inside
> mem_cgroup_page_lruvec(), but actually, what harm does it do, if
> mem_cgroup_move_account() changes page->mem_cgroup concurrently?
> 
> You say use-after-free, but we have spin_lock_irq here, and the
> struct mem_cgroup (and its lruvecs) cannot be freed until an RCU
> grace period expires, which we rely upon in many places, and which
> cannot happen until after the spin_unlock_irq.

You are correct, I missed the rcu locking implied by the
spinlock. With this, the justification for this patch is wrong.

But all of this is way too fragile and error-prone for my taste. We're
looking up a page's lruvec in a scope that does not promise at all
that the lruvec will be the page's. Luckily we currently don't touch
the lruvec outside of the PageLRU branch, but this subtlety is
entirely non-obvious from the code.

I will put more thought into this. Let's scrap this patch for now.
