Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085A73BEA71
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGGPNo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhGGPNn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 11:13:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC6C061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YBvoj0p+cw7rNWFJS293btY7G2SyLG5QlTGqGbKgJpE=; b=VfkYhMTWxTWXcvH47VoE0W62zb
        vxX7UJxvehXclaKrJGBbR/w9f8g0PtOMhxuJeQFCAKaGe+Ve/syaYom0T/RPHaB9yz4YtKlUYgo8c
        MnQycktnLj7xzcRGfdRVc4S7VVudEY0N6hyZUZqrAHokbRLZUEreEIBCKHhzcLqth8PKj/Jfhvf+V
        bPByt0Gw0Qq6bYg1AMSxnHoN+WJWgxKdr9zbV8KDyTu2sb5fHi4RdX+NeiIOfCZPr1LQRCsxE4zo2
        0GWaFiIKBBZ70y/UcpkgXIUYJzWLACYoBMpWuhXMetEzaVaKsGsZ6kbuWi1aUgMdrgLnj2a72Qphv
        0TB944Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m19CL-00CW1H-1Y; Wed, 07 Jul 2021 15:10:50 +0000
Date:   Wed, 7 Jul 2021 16:10:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YOXD+TVkAeWmjLxX@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-14-willy@infradead.org>
 <YNwsAh5u2h34tGDb@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwsAh5u2h34tGDb@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 10:32:02AM +0200, Michal Hocko wrote:
> On Wed 30-06-21 05:00:29, Matthew Wilcox wrote:
> > These are the folio equivalents of lock_page_memcg() and
> > unlock_page_memcg().  Reimplement them as wrappers.
> 
> Is there any reason why you haven't followed the same approach as for
> the previous patches. I mean callers can call page_folio and then
> lock_page_memcg wrapper shouldn't be really needed.

At this point in the patch series there are ~20 places which call
lock_page_memcg().  I think it makes more sense to leave the wrapper
in place, and then we can remove the wrapper once all/most of these
places are converted to use folios.  There are another 5 conversions
already in the patch series, eg here:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/a41c942c8e4b41df30be128ef6998ff1849fa36a

> I do not really want to be annoying here but I have to say that I like
> the conversion by previous patches much better than this wrapper
> approach as mentioned during the previous review already. If you have
> some reasons to stick with this approach for this particular case then
> make it explicit in the changelog.

OK, I can point to the number of callers as a reason to keep the
wrappers in place.  I intended to just do the conversion here, but
seeing the number of callers made me reconsider.
