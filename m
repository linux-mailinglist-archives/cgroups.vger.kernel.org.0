Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C9D424F78
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhJGIwv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 04:52:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:42522 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240397AbhJGIwm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Oct 2021 04:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=g/hnrPUQ5KROv8pBt4MVp2ffO2f3NvPXgJ6LS1y/yls=; b=pDkVHTpW8/rfCY93n
        iC2IazGZX+L/h/DViFNhJGCXORCEzEFSxSuX7J8mIKMM02HdDDRsykJTfDa3bvwSAGKXswwxQASwo
        WN4JfWO9/mp2l8fhkKP4FCxBP2TImgkuj3QMKji01utniqu6WBk5tJWO+cvkIjqpni146+DciNwao
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mYP6z-005JFi-W1; Thu, 07 Oct 2021 11:50:46 +0300
Subject: Re: memcg memory accounting in vmalloc is broken
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz> <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
Date:   Thu, 7 Oct 2021 11:50:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/7/21 11:16 AM, Michal Hocko wrote:
> Cc Mel and Uladzislau
> 
> On Thu 07-10-21 10:13:23, Michal Hocko wrote:
>> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
>>> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
>>>
>>> Is it known issue perhaps?
>>
>> No, I think this was just overlooked. Definitely doesn't look
>> intentional to me.

I use following patch as a quick fix,
it helps though it is far from ideal and can be optimized.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..e6abe2cac159 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5290,6 +5290,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
+
+		if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && page &&
+		    unlikely(__memcg_kmem_charge_page(page, gfp, 0) != 0)) {
+			__free_pages(page, 0);
+			page = NULL;
+		}
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
-- 
2.31.1

