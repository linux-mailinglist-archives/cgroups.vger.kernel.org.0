Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1CB3DD1
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfIPPlD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 11:41:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37383 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfIPPlC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 11:41:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so429941qkd.4
        for <cgroups@vger.kernel.org>; Mon, 16 Sep 2019 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2u752yS3oLnDaYH6yTgBbPOp6ynQQ7UEDYNUBRkEYzU=;
        b=oSAgnCbhD4qDdHEm2xKg8gd+frd0gplSiPL7p871e/IbQ3Xl+AoJriMi48+WtFfMiH
         Er7h6Ina/mwJDFGre4pqWP4axz9nWEaIsC0Mhg4jWWlTxJLjxt2PTXBMZIrdR7ueylMQ
         JjnBypKA663HUGsAUZdZa+CJSiDEk7HeQOtW8iN1K2wpYE6VphkL0B7aNMOaXbqeI4fq
         g7hWJaYnXgwqAaotMNT3gfqh6eze7k6/zlkaN/LbASqJE+8AKlLGIYlLCCa69g0youHX
         5nbYx0F2ArTT0i4inpzgu4YzObm7Q/JOwgvXXPrTcIMrcswjP8l3AOMi6LPSITs/lgVR
         ZhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2u752yS3oLnDaYH6yTgBbPOp6ynQQ7UEDYNUBRkEYzU=;
        b=gEW77zgPzcZL6CB9heFB4uc8vUFjdmYd35OtHAo2RUgggZ13U+z/JiNjGYrv0XZwwl
         mbAvspY8uv12FOQJyicG70T6bFJEML+9TKXG+okosKKTOWLzLwKuExM1wTN/mzbtP1PZ
         DKid9MLk6JT9kFMqhO3h1NZ666fGMKpVTXjUiAiTKmwox29RsMO2FzUrIDmvAKzJdYSz
         CDefyk5w2SRJ8Z0FD0WUj2tepLVX1aUklOxmVt8lA03JgvrCIfBl/gkobDn7zlyObRfE
         W1P1Y3nFbdMuHOYEGtBQ9ydG2lbmDYoQPQZ9UtLPo8rg4jotCoiUDQHk2BfWsvKWtD07
         QICg==
X-Gm-Message-State: APjAAAV/72HAsjvjgCcWkwZo9o6n1qTB7rgY3sCw1sNMzR052w1sXKnw
        Rrxgm8ku25CKgFCrIlHV+tEv+w==
X-Google-Smtp-Source: APXvYqxNJDHhdXo/lPdcN5eN3wfR3/ruQiO+FQksjwQu3q6+KQ4rkXWYO3AyeTVSdow3GMBnLY3bCg==
X-Received: by 2002:a37:aa02:: with SMTP id t2mr643049qke.154.1568648461865;
        Mon, 16 Sep 2019 08:41:01 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o28sm3162570qkk.106.2019.09.16.08.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:41:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/memcontrol: fix a -Wunused-function warning
Date:   Mon, 16 Sep 2019 11:40:53 -0400
Message-Id: <1568648453-5482-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_id_get() was introduced in the commit 73f576c04b94
("mm:memcontrol: fix cgroup creation failure after many small jobs").

Later, it no longer has any user since the commits,

1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
58fa2a5512d9 ("mm: memcontrol: add sanity checks for memcg->id.ref on get/put")

so safe to remove it.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memcontrol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ec5e12486a7..9a375b376157 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4675,11 +4675,6 @@ static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 	}
 }
 
-static inline void mem_cgroup_id_get(struct mem_cgroup *memcg)
-{
-	mem_cgroup_id_get_many(memcg, 1);
-}
-
 static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 {
 	mem_cgroup_id_put_many(memcg, 1);
-- 
1.8.3.1

