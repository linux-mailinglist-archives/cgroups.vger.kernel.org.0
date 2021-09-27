Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8846A4192C7
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhI0LKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 07:10:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhI0LKN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Sep 2021 07:10:13 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7EB52220A1;
        Mon, 27 Sep 2021 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632740914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0gN5P8Lx7ZyiqATEPAc473z/z83jxXVuqiEZE6U3VQ=;
        b=kre7iUxOWUIgYgzzKUhzw0x2WCHgHzMCUOqVIBpZ+x/aVr1dRjiWLufEXpDi/CmGC1TYI1
        px71aSp6Y8Zv4RfWxdoH2HFaiQnu6Shv0Ar9v2hzsX4tQvCY2YXDp53YHRpvaMi3o5GqQV
        TZ9vAVbHiIdSUzPF8ML3FYKqjacgdVY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id EC5EB25D3C;
        Mon, 27 Sep 2021 11:08:33 +0000 (UTC)
Date:   Mon, 27 Sep 2021 13:08:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
Message-ID: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
 <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
 <fa29c6f9-a53c-83bd-adcb-1e09d4387024@virtuozzo.com>
 <YU2EXP5wrSKv+b/8@dhcp22.suse.cz>
 <508abe37-a044-7180-ac67-b4ce5e4cc149@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508abe37-a044-7180-ac67-b4ce5e4cc149@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-09-21 12:36:15, Vasily Averin wrote:
> On 9/24/21 10:55 AM, Michal Hocko wrote:
> > On Thu 23-09-21 09:49:57, Vasily Averin wrote:
[...]
> >> Hypothetically, cancelled vmalloc called inside some filesystem's transaction
> >> forces its rollback, that in own turn it can call own vmalloc.
> > 
> > Do you have any specific example?
> 
> No, it was pure hypothetical assumption.
> I was thinking about it over the weekend, and decided that:
> a) such kind of issue (i.e. vmalloc call in rollback after failed vmalloc)
>    is very unlikely
> b) if it still exists -- it must have own failback with kmalloc(NOFAIL) 
>    or just accept/ignore such failure and should not lead to critical failures.
>    If this still happen -- ihis is a bug, we should detect and fix it ASAP.

I would even argue that nobody should rely on vmalloc suceeding. The
purpose of the allocator is to allow larger allocations and we do not
guarantee anything even for small reqests.

> >> Should we perhaps interrupt the first vmalloc only?
> > 
> > This doesn't make much sense to me TBH. It doesn't address the very
> > problem you are describing in the changelog.
> 
> Last question:
> how do you think, should we perhaps, instead, detect such vmallocs 
> (called in rollback after failed vmalloc) and generate a warnings,
> to prevent such kind of problems in future?

We do provide an allocation failure splat unless the request is
explicitly __GFP_NOWARN IIRC.
-- 
Michal Hocko
SUSE Labs
