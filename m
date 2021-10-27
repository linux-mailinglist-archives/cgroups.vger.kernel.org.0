Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCD43D6BF
	for <lists+cgroups@lfdr.de>; Thu, 28 Oct 2021 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJ0Wig (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Oct 2021 18:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhJ0Wig (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 27 Oct 2021 18:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F29610CB;
        Wed, 27 Oct 2021 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1635374170;
        bh=zeRXlf3fAzntvGnBMpDwMgonqEP9pBriRbcBLNzhnE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=voGDb2zXrSVNrVTxvYv+5pMhCPRA3F8fwGVSJ7e4sGicSa89iz8fbmPQ5IDUj6bbB
         /7BX5p6IZvMH1BZP+4LX56HqXYw5bE76pXVRLoi98OHqHA5a8vD16kOneRNlBRbsGG
         uykElR9RFUVO+G11QXqJr8RFcQrPCNZlTWAsud4Q=
Date:   Wed, 27 Oct 2021 15:36:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH memcg v3 3/3] memcg: prohibit unconditional exceeding
 the limit of dying tasks
Message-Id: <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
In-Reply-To: <YXZ6qaMJBomVfV8O@dhcp22.suse.cz>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
        <cover.1634994605.git.vvs@virtuozzo.com>
        <8f5cebbb-06da-4902-91f0-6566fc4b4203@virtuozzo.com>
        <YXZ6qaMJBomVfV8O@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 25 Oct 2021 11:36:41 +0200 Michal Hocko <mhocko@suse.com> wrote:

> My view on stable backport is similar to the previous patch. If we want
> to have it there then let's wait for some time to see whether there are
> any fallouts as this patch depends on the PF_OOM change.

It's strange that [1/3] doesn't have cc:stable, but [2/3] and [3/3] do
not.  What is the thinking here?

I expect we'd be OK with merging these into 5.16-rc1.  This still gives
another couple of months in -rc to shake out any problems.  But I
suspect the -stable maintainers will merge and release the patches
before they are released in 5.16.

In which case an alternative would be not to mark these patches
cc:stable and to somehow remember to ask the -stable maintainers to
merge them after 5.16 has been on the streets for a suitable period.

Greg, thoughts?
