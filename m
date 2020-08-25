Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB02517D0
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgHYLjk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Aug 2020 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgHYLji (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Aug 2020 07:39:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8DC061574;
        Tue, 25 Aug 2020 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8tGP1JPc7jordcLr9GYgEH1sQIAUBACeH7562OxDjxY=; b=jh69tqh9e33dVk1UNLhHRmhHiL
        7OpafBoQ9WlgiW0XNhW64zL1/ETCzp6H4vvEfMB0rWyBOhhR6m6y1f2K8Rm1ANxQ7MfYlSy9BRKBJ
        0w+5LDlcoKVpEjuSnMGW4tmb3C2UlWZQBKcZs8cryVhqimrR+Bo1XNrvqh8dWMIinKhxaW3hvf/9Y
        CwqVStNBSBzAiL1dc7uTBWj97LHP8X1bdfHGsABFRj2uE+jdoEwWe8k2GC7wQXV5LKDDEEPlA1adh
        /aBCHjF34Wg1fJhQNag+xJ6RKYboemMzFYE4Rot8gJswaDDR7LSF6lLLlUCrLc7JS3IZYlIeULqSn
        LhCnHHdw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAXIF-0000Sk-1w; Tue, 25 Aug 2020 11:39:11 +0000
Date:   Tue, 25 Aug 2020 12:39:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200825113910.GM17456@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 25, 2020 at 11:26:58AM +0800, Alex Shi wrote:
> I tried reusing page->prviate to store lruvec pointer, that could remove some 
> regression on this, since private is generally unused on a lru page. But the patch
> is too buggy now. 

page->private is for the use of the filesystem.  You can grep for
attach_page_private() to see how most filesystems use it.
Some still use set_page_private() for various reasons.
