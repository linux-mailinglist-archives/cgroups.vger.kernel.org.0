Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4E4C4879
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 16:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiBYPPo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBYPPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 10:15:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52AA190B7B
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 07:15:10 -0800 (PST)
Date:   Fri, 25 Feb 2022 16:15:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645802108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQcCIB/BgIE3sYYr7FuCBw/IBoiYy9McFWIhbMjd23A=;
        b=TPyOgGka+Lps9k5E+/jHWNhaZZwxy03gDgZXCKFuV7nhaovdqsmi07aQaWn0w96W6tRYfF
        1ode+DMVEUaS37UAHb+4ZjmZjpTF6F/64wjprv2lczIHOEPo4pEBEKNzNUvzgU0RftB1cJ
        wMyJFfLdi4LiL+/pZNd5aGR6KeFl1eIv/aSLuXP07J2VE6/Vbp5TaJZqkWj/cC+1wgvHys
        sT3Ud7dyKaTdUEpDdCPWtL5RwudTCXuX4wvgs+TgdN/xf1+2DBUK9D0nmB2FgsbmA7z8jc
        +k12ARhogh/cJHr/eSPPYzcBdUlqOKQ3dKP85asV0d7PHzknSkUtmTxFWTtoIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645802108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQcCIB/BgIE3sYYr7FuCBw/IBoiYy9McFWIhbMjd23A=;
        b=bcZAp0a9QQrLodeqKB/SipBFgBZK9tos1qlPjD8FH6TcYEFaip5a0lOPCQqezBwlZ39WdE
        4y/SYKbqCjt0J3CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] mm/memcg: Add a comment regarding the release `obj'.
Message-ID: <Yhjye3LaBB8q55bg@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-6-bigeasy@linutronix.de>
 <YhSyXbxaMcgBJJtT@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhSyXbxaMcgBJJtT@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Please fold into
    mm/memcg: Protect memcg_stock with a local_lock_t

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7883e2f2af3e8..19d4f9297b0c6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3245,6 +3245,10 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 	}
 
 	stock->cached_objcg = NULL;
+	/*
+	 * The `old' objects needs to be released by the caller via
+	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
+	 */
 	return old;
 }
 
-- 
2.35.1

