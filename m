Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5722470F
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 01:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGQXiB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXiB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 19:38:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761AC0619D2;
        Fri, 17 Jul 2020 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M3QiKi1JcWwj8bC7tSmSd1af0WRuIi4gwW+Grh7mYOg=; b=YAzqSdhPO520UAiR5iyt9Jr0ff
        eaFZLgVzYfQJUu/UsvHx9xpd18nuVH/Htw358n2nFCznpIQNq5IwMjvcoxIsmXQpMGqbAKn65MIl/
        bN0+ZqVDpso/8UNVDihqGg+iPukyMf4YRuyCu3j1kZJi5D6YAxqUGyjMyL/ODNfQMBuqmvPuXToSm
        N5J8MfeeY8lec3FFZoRwMDfYCl3WVyrw9AqnGwm8HSTsdHnV4v7y8B++QRLLl0Y7WSvblrCY9p4f4
        98fiWHYk3O8w1Lh7CM9JOgrB8UZlBmu8EdTNY91158J0d/CQMFnaZ3eqD27OYI/+gLrTkLLLSVUPh
        ORmnoNkw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZvS-0006df-Jr; Fri, 17 Jul 2020 23:37:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] memcontrol: drop duplicate word and fix spello in
 <linux/memcontrol.h>
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Message-ID: <b04aa2e4-7c95-12f0-599d-43d07fb28134@infradead.org>
Date:   Fri, 17 Jul 2020 16:37:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "for" in a comment.
Fix spello of "incremented".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/memcontrol.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/memcontrol.h
+++ linux-next-20200714/include/linux/memcontrol.h
@@ -72,8 +72,8 @@ struct mem_cgroup_id {
 
 /*
  * Per memcg event counter is incremented at every pagein/pageout. With THP,
- * it will be incremated by the number of pages. This counter is used for
- * for trigger some periodic events. This is straightforward and better
+ * it will be incremented by the number of pages. This counter is used
+ * to trigger some periodic events. This is straightforward and better
  * than using jiffies etc. to handle periodic memcg event.
  */
 enum mem_cgroup_events_target {

