Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8442D364
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJNHUR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 03:20:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJNHUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 03:20:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A3D9521A75;
        Thu, 14 Oct 2021 07:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634195887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItroEyfCjdn2jjHo+KgVNqOCeGtBLeeRzaYF2ey/Y8Q=;
        b=VfMKwkcQxdhoIzXhSYvkSm5ku7ugoTIPQVOo+JxVkpz/QxhwL/Po2BnNIQE8tm4as/wMbN
        S5oH/v78OyHEvUfHBoe4nVgfGedVIE5BtuoePId8+oLCWf/4EVJCEXyDsURoyy63WUne46
        6hmbURCIwobyelAtwxmnd6qGC94sRWw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8F5C9A3B84;
        Thu, 14 Oct 2021 07:18:07 +0000 (UTC)
Date:   Thu, 14 Oct 2021 09:18:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWfZr+lL2lrBhSc/@dhcp22.suse.cz>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <4c92e227-2abc-c3cb-93eb-f5c45bef7fc6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c92e227-2abc-c3cb-93eb-f5c45bef7fc6@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-10-21 10:05:21, Vasily Averin wrote:
[...]
> > +	/* Bulk allocator does not support memcg accounting. */
> > +	if (unlikely(gfp & __GFP_ACCOUNT))
> > +		goto out;
> > +
> 
> May be (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) check is better here?

Yes please

-- 
Michal Hocko
SUSE Labs
