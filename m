Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21D416D31
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhIXH4q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 03:56:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbhIXH4o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 03:56:44 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41DDE22416;
        Fri, 24 Sep 2021 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632470111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+5dT0e/LVnNHHcl0ABQyeUOLyC28rt8o7MtGQJ16Wk=;
        b=KWiNL3UHQbuoAkuBsiy3YSQftN/E2jhVDCGJVJ4SuDi14ga6EYTPLdskYk6XwXRICZFsXG
        bEWK+3mJ2tb2wipT9UFRw4dJv04b+FFJK7rjY3eOiFx60uVYVav5B3hKKV06bppDfRyf6C
        q8TEmpzdS0lmOTDDH+ryD1WOMtFlK0k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id C507B25CCD;
        Fri, 24 Sep 2021 07:55:10 +0000 (UTC)
Date:   Fri, 24 Sep 2021 09:55:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
Message-ID: <YU2EXP5wrSKv+b/8@dhcp22.suse.cz>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
 <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
 <fa29c6f9-a53c-83bd-adcb-1e09d4387024@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa29c6f9-a53c-83bd-adcb-1e09d4387024@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-09-21 09:49:57, Vasily Averin wrote:
[...]
> I'm agree that vmalloc callers should expect and handle single vnalloc failures.
> I think it is acceptable to enable fatal_signal_pending check to quickly
> detect such kind of iussues.
> However fatal_signal_pending check can cause serial vmalloc failures
> and I doubt it is acceptable. 
> 
> Rollback after failed vmalloc can call new vmalloc calls that will be failed too, 
> even properly handled such serial failures can cause troubles.

Could you be more specific? Also how would this be any different from
similar failures for an oom victim? Except that the later is less likely
so (as already mentioend) any potential bugs would be just lurking there
for a longer time.

> Hypothetically, cancelled vmalloc called inside some filesystem's transaction
> forces its rollback, that in own turn it can call own vmalloc.

Do you have any specific example?

> Any failures on this path can break the filesystem.
> I doubt it is acceptable, especially for non-OOM fatal signals.
> On the other hand I cannot say that it is a 100% bug.
> 
> Another scenario:
> as you know failed vmalloc calls pr_warn. According message should be sent
> to remote terminal or netconsole. I'm not sure about execution context,
> however if this is done in task context it may call vmalloc either in terminal
> or in network subsystems. Even handled, such failures are not fatal,
> but this behaviour is at least unexpected.

I do not think we want to shape the vmalloc bahavior based on
printk/console behavior.

> Should we perhaps interrupt the first vmalloc only?

This doesn't make much sense to me TBH. It doesn't address the very
problem you are describing in the changelog.
-- 
Michal Hocko
SUSE Labs
