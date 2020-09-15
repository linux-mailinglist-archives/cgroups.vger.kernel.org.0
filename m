Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71B26A5EE
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIONJj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIONJP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 09:09:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D6C061788;
        Tue, 15 Sep 2020 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7NBf7Gx3NEoEBeWF+X5RA2TyfqQ9s1ho0GYQa3vJ+Jk=; b=ZO9myoY4N8MfiF8r9ZsvVUTGB0
        OpnTN/gQGj4PpxFg8LiE+oarC9K2KzEtQiyaBPyHtovx7UQS5tW+8bfbZDtPpgRuvDKMNJaZJbnec
        DrMTvRg1f1Te744UlXOkbnaopigPono/kBlyjwnNfR0ZoKnhZnaFfm2koAZUL1lyoGn01IeqbSwFC
        yDxXO8ABXfJxT5Vh8Kv5VpEcNU5zbsf0MhVPYtVLKyR8o2A2dpQz9WFvK8WbHRf/K1mH/HftDS0+k
        XVucUsuZ1mjpTCkcuCujL50iA09RUSUuTMire+garHju3WRwUpM7Qwp53r2bIHF2mw1nW9mACo6pG
        7bLfhU2w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIAhU-0000rc-Od; Tue, 15 Sep 2020 13:08:48 +0000
Date:   Tue, 15 Sep 2020 14:08:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ricardo.canuelo@collabora.com
Subject: Re: [PATCH v2 0/8] Return head pages from find_*_entry
Message-ID: <20200915130848.GD5449@casper.infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
 <alpine.LSU.2.11.2009150059310.1550@eggly.anvils>
 <CA+G9fYvqbKPHoYbU7w2bPkOF_vgbYgEHavLDxXQ4O5xUFHGCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvqbKPHoYbU7w2bPkOF_vgbYgEHavLDxXQ4O5xUFHGCuw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 15, 2020 at 06:23:27PM +0530, Naresh Kamboju wrote:
> While running kselftest mincore tests the following kernel BUG reported on the
> linux next-20200915 tag on x86_64, i386 and arm64.

https://lore.kernel.org/linux-mm/20200914112738.GM6583@casper.infradead.org/
