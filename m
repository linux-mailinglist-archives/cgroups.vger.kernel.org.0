Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3D433840
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSOVw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 10:21:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSOVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 10:21:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D5E571FD66;
        Tue, 19 Oct 2021 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634653178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17XfwS65rinqRQ1q6ipG3Hb8XhX7XNxJzO/iLYtDfK8=;
        b=QpnkvsCK9QJG2NyfNxwehgKhumEq8pDVXnpoMGN8xddkAgH7ZIiQiOX7D9WT2NjdLI/jgt
        /wzL6qvCxdyIDB6JS9svh59sSk2sZtQWMMNpmX4vXEb+OaoLLk0/hHU8TttGB5C5zksYsg
        HyUqFZ8b61DP8AYqq0iyHrqA7lj0kLk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9F6CA3B83;
        Tue, 19 Oct 2021 14:19:38 +0000 (UTC)
Date:   Tue, 19 Oct 2021 16:19:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
Message-ID: <YW7T+m8Y0wgWSnvQ@dhcp22.suse.cz>
References: <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <339ae4b5-6efd-8fc2-33f1-2eb3aee71cb2@virtuozzo.com>
 <YW6GoZhFUJc1uLYr@dhcp22.suse.cz>
 <687bf489-f7a7-5604-25c5-0c1a09e0905b@virtuozzo.com>
 <YW6yAeAO+TeS3OdB@dhcp22.suse.cz>
 <YW60Rs1mi24sJmp4@dhcp22.suse.cz>
 <6c422150-593f-f601-8f91-914c6c5e82f4@virtuozzo.com>
 <YW7SfkZR/ZsabkXV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7SfkZR/ZsabkXV@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 19-10-21 16:13:19, Michal Hocko wrote:
[...]
> That patch has to be discuss in its full length. There were other
> details I have brought up AFAIU.

And btw. thanks for walking through that maze! It is far from trivial
with side effects all over the place which far from obvious and heavily
underdocumented.

-- 
Michal Hocko
SUSE Labs
