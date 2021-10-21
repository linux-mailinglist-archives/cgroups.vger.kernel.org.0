Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65832435E8E
	for <lists+cgroups@lfdr.de>; Thu, 21 Oct 2021 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUKFm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Oct 2021 06:05:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhJUKFg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Oct 2021 06:05:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCBDF21989;
        Thu, 21 Oct 2021 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634810599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lb7XXB7wqKHGBh2gL7Zyuh+FLppJxySX9xGrB8I5wEA=;
        b=MaSik9roDAoYdCgZi6qhyc/laF7U1vE39+hc/YlZ2kqzOLWCOp9dmjNxyq1n3YFWcr31HR
        hfp/RkT+NiT208Nclww+4g8e32HXhCKSORvYbq/dLlJBIuj5KXhL/Vt7R6h6isHu1TOkUv
        f6TAQnNCl2+kwVuGHquE1a7UyTfgFd0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 817F3A3B81;
        Thu, 21 Oct 2021 10:03:19 +0000 (UTC)
Date:   Thu, 21 Oct 2021 12:03:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 2/3] memcg: remove charge forcinig for dying tasks
Message-ID: <YXE65h/1qeSzKA4C@dhcp22.suse.cz>
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
 <YXAOjQO5r1g/WKmn@dhcp22.suse.cz>
 <cbda9b6b-3ee5-06ab-9a3b-debf361b55bb@virtuozzo.com>
 <YXAubuMMgNDeguNx@dhcp22.suse.cz>
 <dee26724-3ead-24d4-0c1b-23905bfcdae9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee26724-3ead-24d4-0c1b-23905bfcdae9@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-10-21 00:20:02, Tetsuo Handa wrote:
> On 2021/10/20 23:57, Michal Hocko wrote:
> > One argument for removing it from here is the maintainability. Now you
> > have a memcg specific check which is not in sync with the oom. E.g.
> > out_of_memory does task_will_free_mem as the very first thing. You are
> > also automatically excluding oom killer for cases where that might make
> > a sense.
> 
> What makes it possible to remove this check?
> This check was added because task_will_free_mem() in out_of_memory() does NOT work.
> See commit 7775face207922ea ("memcg: killed threads should not invoke memcg OOM killer").

You are right. I've forgot about this and should have checked git blame.
Thanks for bringing this up!

-- 
Michal Hocko
SUSE Labs
