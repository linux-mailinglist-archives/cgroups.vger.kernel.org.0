Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935053BF643
	for <lists+cgroups@lfdr.de>; Thu,  8 Jul 2021 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGHHbE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jul 2021 03:31:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhGHHbE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jul 2021 03:31:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4E0CD220D2;
        Thu,  8 Jul 2021 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625729302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17LWgY1lhwnG10GPb9Rqj76fsBzvfjmM5lbcUo6gvVI=;
        b=Uw4AoXNSjnjAxhH0BbMXmIpo5cwyH7inw0BupZ8ZrmMINW5o3MMukZRtAyUTtg0uLnFh/x
        TFUwG0oFkek/lO57V9WITuUkWQfTIi4XJ4g9+sBzLLpC8JTMf31+0sAiWr1ik/nXg4i8g5
        ZlDm3yNFJw+mbnmEXIbO3Z1LSUhdqIk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1E28EA3B84;
        Thu,  8 Jul 2021 07:28:22 +0000 (UTC)
Date:   Thu, 8 Jul 2021 09:28:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YOapFVzNhSgnN/tM@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-14-willy@infradead.org>
 <YNwsAh5u2h34tGDb@dhcp22.suse.cz>
 <YOXD+TVkAeWmjLxX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXD+TVkAeWmjLxX@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 07-07-21 16:10:49, Matthew Wilcox wrote:
[...]
> > I do not really want to be annoying here but I have to say that I like
> > the conversion by previous patches much better than this wrapper
> > approach as mentioned during the previous review already. If you have
> > some reasons to stick with this approach for this particular case then
> > make it explicit in the changelog.
> 
> OK, I can point to the number of callers as a reason to keep the
> wrappers in place.  I intended to just do the conversion here, but
> seeing the number of callers made me reconsider.

OK, fair enough. My worry is that we will have this lingering for way
too long. People simply tend to copy code... Anyway, please add a
comment warning that the wrapper shouldn't be used in any new code at
least.

Thanks!
-- 
Michal Hocko
SUSE Labs
