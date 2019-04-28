Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749D8D9FE
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfD1X4e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Apr 2019 19:56:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51377 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfD1X4e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Apr 2019 19:56:34 -0400
Received: by mail-qk1-f202.google.com with SMTP id q79so7786932qke.18
        for <cgroups@vger.kernel.org>; Sun, 28 Apr 2019 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yu6NcO6qkqCy2IZdfcCLb2i4aKMiT552Q3oiWALCBq0=;
        b=t0IuUsXn9gaq3SQut1xYfgcWiEy8RtkERl2pBXCiH9XceacJW0QWyY0WBZHCewi6u6
         YRjtmVCPM0+qoQv1Z87j/N+3XJ6aoclitm6grIraYu8Y9Bqhjs/dhYKOjl3kFgZZJthp
         pG7y7jAYeykyDXhBxasCXYScBOh8nNzAxjTMW89k/5W00JPfrgSZ9b5ObblARtA3d0rr
         KacNMeGFpwmM7JL572xU2Rag7vO9sZNeLdQO7gbiSSqb9VOrg7HXmC04PDokV2Tk6AJU
         C6mcwZUohipajKu8TC+IP/nEKyhgdFNNkhV+kO/BxejCC4n5s/0FpqjJ2o1Bvmw+R4+U
         Husw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yu6NcO6qkqCy2IZdfcCLb2i4aKMiT552Q3oiWALCBq0=;
        b=Y/lLS5tSKiRdbeE6HYCUrWZtQefWmwTzPfS/PWg98hRucx//zyIzTKvDqBvE+RQvx4
         0Iq5nCLgwOpW9xRAqL+mOEYN8ralyoY0Oq+x4jmaj4vU8RP/ASb43F2NN+MidA/vqkNF
         d1zejyRjq505WfUmAytImZGqIWX4wj+pRBDjsnCTnm3kI8N7vsW1I2OYcX3pjmwSoMVh
         8iBL9uy79T1StFscsxvxi1yq/BXm6OL24sal28s1YNqikj3S4IfKi6JD+53TeMQe3sDN
         oYzw/Mh0vh/xgnIWQKkCN+mt/l0Q+5ZaEvihmQXujgiv17xhEZeGEb4MKLi7mKtcdz+F
         FvnQ==
X-Gm-Message-State: APjAAAX9q3Mc4QiBuE+ILEe8dVanLtEu2Kr5VEBDseS3YoF9ZbT7S2p0
        BgK7SqATIpPXVY2OLXgEuyeUlzMOUP95qQ==
X-Google-Smtp-Source: APXvYqwscTyupsIoajguC2ll5HejrseWPsuQsoX13E2On/kwywEZi3TbpJQWePki5zziDZiwfyJTkIrJKlFGbA==
X-Received: by 2002:ac8:33eb:: with SMTP id d40mr25801482qtb.263.1556495793414;
 Sun, 28 Apr 2019 16:56:33 -0700 (PDT)
Date:   Sun, 28 Apr 2019 16:56:13 -0700
Message-Id: <20190428235613.166330-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
OOM killer will not be triggered and indeed the page alloc does not
invoke OOM killer for such allocations. However we do trigger memcg
OOM killer for __GFP_RETRY_MAYFAIL. Fix that.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2713b45ec3f0..99eca724ed3b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
-	bool oomed = false;
 	enum oom_status oom_status;
 
 	if (mem_cgroup_is_root(memcg))
@@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_retries--)
 		goto retry;
 
-	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
+	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
 	if (gfp_mask & __GFP_NOFAIL)
@@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	switch (oom_status) {
 	case OOM_SUCCESS:
 		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
-		oomed = true;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
-- 
2.21.0.593.g511ec345e18-goog

