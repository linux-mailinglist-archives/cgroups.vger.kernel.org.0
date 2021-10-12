Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB26742A81E
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhJLPWt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 11:22:49 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:39517 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232952AbhJLPWs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 11:22:48 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 06856FACBD
        for <cgroups@vger.kernel.org>; Tue, 12 Oct 2021 16:20:45 +0100 (IST)
Received: (qmail 1342 invoked from network); 12 Oct 2021 15:20:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2021 15:20:44 -0000
Date:   Tue, 12 Oct 2021 16:20:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in
 __alloc_pages_bulk
Message-ID: <20211012152043.GW3959@techsingularity.net>
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 12, 2021 at 05:58:21PM +0300, Vasily Averin wrote:
> Enable memory accounting for bulk page allocator.
> 
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
