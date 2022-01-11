Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331DE48A4A5
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbiAKBDI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 20:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiAKBDH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 20:03:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA1C06173F;
        Mon, 10 Jan 2022 17:03:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i5so7166872edf.9;
        Mon, 10 Jan 2022 17:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jn9HpCa6G4upWAzqy9L2iSMpMRASsTNp9iLWrRF7M4U=;
        b=KnHpqKaf4bNL9UoWb2i9eRaXV2Ftcl/MbpDJtelOe1wEeOH/D/nh89jJcbfwg4oH+0
         g2jPXX1T8MpZTmQ+tmWaj4HEEwm7x/rHOWOaM0l6jzdQtSYxHnlmJB+jPT3xio5EKIYk
         Y8YjJ54LxCRf/YrbmV5yZCMFyTWDsgKF4NYUg80ytXHbjc0jcmwcHVL5ozQbucW9qL0e
         qLXgAMlMTlo5mVmPryAwe5Nfw1KcbnY0mJrlJZbjm7z1KrdVcxVMIIrqwh0WbS9A5ZPm
         NFyEUea7SjrAU4JkCZ750sDihBugarUnqrZ7t4MPy4XyWTzkw6sARu7MPD/1eaziPnfI
         7bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jn9HpCa6G4upWAzqy9L2iSMpMRASsTNp9iLWrRF7M4U=;
        b=sbDwmtmqtQ8y2m+uvCkZb50veuGKLzhuL9fw1ByBpcYMDSZLp/93dsg6kjrF3lFWU0
         e/2G18Y9y7tO9kD/jgJeTDgjJl4ySw3IdETglEI3jlfQAHvzRyy+O1D/GidArIrNlZcH
         NcGQ6o5iX5QsdtRNdVoHkUwmkWmBCGXor+wMhdZhrWka0au7ZiPyBqn2zVlc8PITdCto
         V4gtjOTYTy+9xEGJXHP58yAcAUBmNkZY/1sVTHPU0tRHncqsC3XlUTOASeEecdPqp1Qu
         u+gc8A3IfC5Rux5o2bpRnjpi4N3hbziJsn8AikEt9Kk7CvqIKSQ4nvN1rqOPjww75pcO
         FN4w==
X-Gm-Message-State: AOAM533Hxy9TcV3tXGIlsrYBW3M4PjzaaySFUnHjjungIK8wHOZA6viX
        5jWl8cchvbcsRaBpsWn1Sf4=
X-Google-Smtp-Source: ABdhPJw9UFs+56GbYPq0rQ7c7c2tDNpm9aeaKw9djhH1aOOiy2Z5/mzl5j0wKXy1MJnVh9k7Huienw==
X-Received: by 2002:a17:906:2dc3:: with SMTP id h3mr1665725eji.713.1641862986144;
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e16sm4286362edu.15.2022.01.10.17.03.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jan 2022 17:03:05 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
Date:   Tue, 11 Jan 2022 01:03:01 +0000
Message-Id: <20220111010302.8864-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The parent we get from page_counter is correct, while this is two
different hierarchy.

Let's retrieve the parent memcg from css.parent just like parent_cs(),
blkcg_parent(), etc.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/memcontrol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..12bf443f7b14 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -886,9 +886,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
  */
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
-	if (!memcg->memory.parent)
-		return NULL;
-	return mem_cgroup_from_counter(memcg->memory.parent, memory);
+	return mem_cgroup_from_css(memcg->css.parent);
 }
 
 static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
-- 
2.33.1

