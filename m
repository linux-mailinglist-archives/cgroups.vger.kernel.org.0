Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A791E424F02
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbhJGITB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 04:19:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbhJGISy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 04:18:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 24DE01FF3F;
        Thu,  7 Oct 2021 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633594620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2zBp/TdnLxt9MSyGVA9a0A07iA1c9p9pwwD3gNr6Ak=;
        b=UAPCqpUZyGb+mMq4PDUBdSUecHqde5B1fJqE33t3Y2RwGHnB94nVT8KQW3TtCJvduavGch
        KcDyMaWAlTNXXtXEV17ELqBT731RB94H9WQNvqUFuWBaI+9CQwo3qLWvMiKX6fwstGyls6
        cJmkqKqUTZxWV0K1owln3VT/xce6WNQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3C3BA3B85;
        Thu,  7 Oct 2021 08:16:59 +0000 (UTC)
Date:   Thu, 7 Oct 2021 10:16:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: memcg memory accounting in vmalloc is broken
Message-ID: <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV6sIz5UjfbhRyHN@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cc Mel and Uladzislau

On Thu 07-10-21 10:13:23, Michal Hocko wrote:
> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
> > vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
> > 
> > Is it known issue perhaps?
> 
> No, I think this was just overlooked. Definitely doesn't look
> intentional to me.
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
