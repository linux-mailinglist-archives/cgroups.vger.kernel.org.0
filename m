Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF793CA4C0
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhGORxh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhGORxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 13:53:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE9C06175F
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INGSnpl1UpF6CdwmxMLPgOIu/v7mSG58jf2OlaWN2WI=; b=I3elTLEKAqHwyiShzj/pAC4cdj
        loGG8gASgYQuRt8tigUzu7jKCXIIchfjOEQKJ4zotfEnlnm02Nm4Q4gMMVPhFM6fqwOWDaLxEDVri
        pIXgQ7ogB8LVZ2ivfcStsBpCktqX8DthN8Rd9SUTdszdJJ9j22PwQX2k9jWTdkIhsLt4sJUODpIus
        2Cj4shRfDtqsNCfRjET45e9wvbkRvq2p4IJfLB0pelAedzrQoF4OUHiYlnmS3iVB5RCemKQwbm6HN
        HCdGV7Z343mVYcaWLc0ZfkBezLidn5096fEal0EuIS5v7XxHP/vahh0f86qSzBbpKO9oYHwexdYuZ
        fm4d4pNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m45Ts-003ahC-4d; Thu, 15 Jul 2021 17:49:17 +0000
Date:   Thu, 15 Jul 2021 18:49:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yutian Yang <nglaive@gmail.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn
Subject: Re: [PATCH] memcg: charge semaphores and sem_undo objects
Message-ID: <YPB1EPaunr5587h5@casper.infradead.org>
References: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 15, 2021 at 03:14:44AM -0400, Yutian Yang wrote:
> This patch adds accounting flags to semaphores and sem_undo allocation
> sites so that kernel could correctly charge these objects. 
> 
> A malicious user could take up more than 63GB unaccounted memory under 
> default sysctl settings by exploiting the unaccounted objects. She could 
> allocate up to 32,000 unaccounted semaphore sets with up to 32,000 
> unaccounted semaphore objects in each set. She could further allocate one 
> sem_undo unaccounted object for each semaphore set.

Do we really have to account every object that's allocated on behalf of
userspace?  ie how seriously do we take this kind of thing?  Are memcgs
supposed to be a hard limit, or are they just a rough accounting thing?

There could be a very large stream of patches turning GFP_KERNEL into
GFP_KERNEL_ACCOUNT.  For example, file locks (fs/locks.c) are only
allocated with GFP_KERNEL and you can allocate one lock per byte of a
file.  I'm sure there are hundreds more places where we do similar things.
