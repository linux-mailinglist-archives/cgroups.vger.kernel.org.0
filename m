Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1213BF0E4
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhGGUnu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 16:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhGGUnu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 16:43:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD4C061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 13:41:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso2395948pjp.5
        for <cgroups@vger.kernel.org>; Wed, 07 Jul 2021 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4P0KNfgWIHNUMQeKArxNiZXWY4TL6SD38burZdGtmU=;
        b=jxcBI4tRdXz8lueNWijVft6b8D9Bs/Ztrx6y/abhbFp/1koc4S09E5BLEuvjihUSlV
         44gQzlL6BNXxn1NhWf9bM3ZwXXByfzIj6qfBavenyQQO3BW04/c/oW9WpaXTwr72wHDe
         XExZc+OZQbvQ3SXVOqOqpyz+Og2mAaCFUCZxpVI6siymiro/itdnoB54RINqCWRif1rO
         xVd0QlGQZIh7EwKTD2c0uw86WIX7r06KfxDLxql/OR1hpgtjsYfAtRpBiaNtAVSBC2EI
         8wJ+ynVom4czdgqpPyT7yKvBv97YH5anfQkzZ6mhgQ7k5d0MZL66cw3TcC9AvwtB7JFZ
         f0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4P0KNfgWIHNUMQeKArxNiZXWY4TL6SD38burZdGtmU=;
        b=QWnfVgWbDjIKKnvET98i9pG91dLjHz9S0EvpAsjqQqaPpyBEDZnUgEQ2RXU3oCTT63
         /w6ZlDIl1PtSDEGh5i/P6FBhHRGVHeSOKVQ+aT0/s+Z8Ry2GHibQzZl/n2KxbmvRUpM5
         EE+5Ss8+36DtLWg5fYqz/WNP//v2jNPWB98lgYz0pS/YfQGCE/MHgyTxqiACdDt8mP7t
         AFt/MATrXvlBHbq84TOx9SaGBKNH+qk073pp5K9l9IAa7TGn0VcDkg0t0rG/6jzMDIr6
         Hwa/Qdy0J2vtGLu4R320NMfiI7HkoD7T+Dfpvkjm5cuiXu51y4M1C2Kq4wLtKxTHEwI6
         FRQw==
X-Gm-Message-State: AOAM531IZ/WTiYs0kZ8Ewz4tuWEzUCdgYY2DEl57r6UM/gGHhJaHaYdj
        QNUP9qxUgJu2nrKyjV+gd50HWM7Czft2Mg==
X-Google-Smtp-Source: ABdhPJxNV60mHk9QdfMdqDZ9XuKOsJOhvCk+yXfJMgYynl0hy+ru6RNPGsji0WHlpZpAAKl4l39XBw==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr4905468pjm.97.1625690468414;
        Wed, 07 Jul 2021 13:41:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e0c7])
        by smtp.gmail.com with ESMTPSA id d25sm105765pgn.42.2021.07.07.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:41:07 -0700 (PDT)
Date:   Wed, 7 Jul 2021 16:41:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YOYRYXATm2gHoGGq@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-14-willy@infradead.org>
 <YOXfozcU8M/x2RQ4@cmpxchg.org>
 <YOYAZ5+xDFK0Slc8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOYAZ5+xDFK0Slc8@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 07, 2021 at 08:28:39PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 07, 2021 at 01:08:51PM -0400, Johannes Weiner wrote:
> > On Wed, Jun 30, 2021 at 05:00:29AM +0100, Matthew Wilcox (Oracle) wrote:
> > > -static void __unlock_page_memcg(struct mem_cgroup *memcg)
> > > +static void __memcg_unlock(struct mem_cgroup *memcg)
> > 
> > This is too generic a name. There are several locks in the memcg, and
> > this one only locks the page->memcg bindings in the group.
> 
> Fair.  __memcg_move_unlock looks like the right name to me?

Could you please elaborate what the problem with the current name is?

mem_cgroup_move_account() does this:

	lock_page_memcg(page);
	page->memcg = to;
	__unlock_page_memcg(from);

It locks and unlocks the page->memcg binding which can be done coming
from the page or the memcg. The current names are symmetrical to
reflect that it's the same lock.

We could switch them both to move_lock, but as per the other email,
lock_page_memcg() was chosen to resemble lock_page(). Because from a
memcg POV they're interchangeable - the former is just a more narrowly
scoped version for contexts that don't hold the page lock. It used to
be called something else and we had several contexts taking redundant
locks on accident because this hierarchy wasn't clear.

I don't mind fixing poorly chosen or misleading naming schemes, but I
think we need better explanations to overcome the reasoning behind the
existing names, not just the assumption that there weren't any.
