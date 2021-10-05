Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC8422B8C
	for <lists+cgroups@lfdr.de>; Tue,  5 Oct 2021 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhJEO5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 10:57:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhJEO5G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Oct 2021 10:57:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AC306223A3;
        Tue,  5 Oct 2021 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633445714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S16oNrBuFcWuNh85hYkjoulTN4cPTW6zAgP9R8WFY7g=;
        b=KRM3Clmotf21/ys7DEwncqQlncDujGhwquNy00mM6atBKUGyELdWliY5ZR0P0QUP1a58Xl
        tngzGvs0v2qeAcZ+gK67gAhzUTwx+5jpEwqM0Jy8rAQ+qtBdGUvA+8OuvJ5xj48KltS8qo
        /rrWjruydyulK56D7kfWPCJN2nJ2ATw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13AB2A3B84;
        Tue,  5 Oct 2021 14:55:13 +0000 (UTC)
Date:   Tue, 5 Oct 2021 16:55:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg v3] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YVxnUZzR+rjRrGU3@dhcp22.suse.cz>
References: <YUM+saaJEce0TJyF@dhcp22.suse.cz>
 <b89715b5-6df7-34a3-f7b9-efa8e0eefd3e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89715b5-6df7-34a3-f7b9-efa8e0eefd3e@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 05-10-21 16:52:31, Vasily Averin wrote:
> v3: no functional changes, just improved patch description

You haven't addressed my review feedback regarding the oom invocation.
Let me paste it here again:
: > @@ -1607,7 +1607,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
: >        * A few threads which were not waiting at mutex_lock_killable() can
: >        * fail to bail out. Therefore, check again after holding oom_lock.
: >        */
: > -     ret = should_force_charge() || out_of_memory(&oc);
: > +     ret = task_is_dying() || out_of_memory(&oc);
: 
: task_is_dying check will prevent the oom killer for dying tasks. There
: is an additional bail out at out_of_memory layer. These checks are now
: leading to a completely different behavior. Currently we simply use
: "unlimited" reserves and therefore we do not have to kill any task. Now
: the charge fails without using all reclaim measures. So I believe we
: should drop those checks for memcg oom paths. I have to think about this
: some more because I might be missing some other side effects.
-- 
Michal Hocko
SUSE Labs
