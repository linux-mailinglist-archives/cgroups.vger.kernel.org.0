Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D42DBF76
	for <lists+cgroups@lfdr.de>; Wed, 16 Dec 2020 12:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgLPLcP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 06:32:15 -0500
Received: from m12-11.163.com ([220.181.12.11]:60839 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPLcP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 16 Dec 2020 06:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BBKRI
        TNFFT+q7yGvwOTx4/tWHfQzcYeyta5d1Cb3V68=; b=fB/bHrF7W+wEz0U0iVXbW
        ATCoPSFOK67Iehdh5ukdjw4pGkuhbuE8YfAlOWVvLKt+5hznZ0U6IHJGPO1vabp0
        WbnGtiCpykUl6cS9IIOgcP7ZD6Qo9+8RUjfi9347z63Wx8y5d/vcgT0OeTN6CIWH
        xKzmE/1w/+8oGAFZC+kNDM=
Received: from localhost (unknown [101.86.213.93])
        by smtp7 (Coremail) with SMTP id C8CowACnLq+NoNlfePyaDw--.2553S2;
        Wed, 16 Dec 2020 13:52:13 +0800 (CST)
Date:   Wed, 16 Dec 2020 13:52:13 +0800
From:   Hui Su <sh_def@163.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/memcontrol: remove the unnecessary rcu_read_[un]lock
Message-ID: <20201216055213.GA63520@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowACnLq+NoNlfePyaDw--.2553S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1xXr4kJw1kKr4UAr1UJrb_yoW8GFW3pF
        sxKa47A398Xw1Ygr1Uua1Dur1xA3Wag3y7Zr1UJw48ZF13X3sag34UKF1fZr45ZFyIvrs8
        ZrW5twnrAw42q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjPfdUUUUU=
X-Originating-IP: [101.86.213.93]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIA38X10TCh3tsAAAsK
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

the rcu_read_lock and rcu_read_unlock is unnecessary in:
	lock_page_lruvec()
	lock_page_lruvec_irq()
	lock_page_lruvec_irqsave()

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/memcontrol.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e3c7ca7dc174..a19f820e8a3f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1396,10 +1396,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock(&lruvec->lru_lock);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
@@ -1411,10 +1409,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock_irq(&lruvec->lru_lock);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
@@ -1426,10 +1422,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = page_pgdat(page);
 
-	rcu_read_lock();
 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
-	rcu_read_unlock();
 
 	lruvec_memcg_debug(lruvec, page);
 
-- 
2.29.2

