Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97777C3E3
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2019 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGaNqR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Jul 2019 09:46:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44393 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfGaNqQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 Jul 2019 09:46:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so35538299qtg.11
        for <cgroups@vger.kernel.org>; Wed, 31 Jul 2019 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8f2ucm94N3RAHWXp2XYv1ymSM73yXUEwnSMo5qDl8Gc=;
        b=FkJBduK7o2U9DkS56fiFYacXOe0s7mfPx9W0zVWXLGIoBYvxPS2C2Ogl6X1ZM5uZB4
         cNBAvSNVe+z5s06SyzfhFcV2RMEo+4pQRXPG6a+ptBnkhXvLwFhmgz0gt+BJW3wJbihR
         nQ+IC+gD8EKjLqqM8uUq0xBkQAcLq2ShOD+pLbe7omO5lVwVExK79k9jyXMHHP9ALfdG
         HN5osGJO/3roRO/n8DH2DeHGHAjojwdQ4gDaHzxo6r6GRyDbZlbArnEjESad9OoMyJV3
         prsq8zmDCb3fv9cBiBkmI//oNrGrN1yzBD8iF6WSFS37+kW8o3ZD2SB4jdrbHoccKKeQ
         LE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8f2ucm94N3RAHWXp2XYv1ymSM73yXUEwnSMo5qDl8Gc=;
        b=CCXCenNAniDd1s7ic1w34rxwrB7Dzi0EhFz1nn5tOQGiaoYKl28agSMrJNcx4iZBqw
         MuaJGLn4A/3t7dTNVj5RHpzk6n6ZgjxJu5ALEmLs0oAdnOI4cGzkEPUhjp928Zl8uOoB
         ipLSgM3Cdc8gQh0mo0hUjuUl9XlC4IeUf/lQKKyoWyYNap857StHDq51Euu1oc7kVmBW
         ESV7X8H91OTlSD4DNaDgqs4tpdDVqrdf43YFNZBANq5O/PBTOuByz7HwkYGe9SuocQ5k
         p0INmd4Pcd0wRtO5X6BbP3kntCQCLMYjaIDF0QuQd0ohOxzAWC3sSo1UOk8Uy22lRc8W
         iLeQ==
X-Gm-Message-State: APjAAAXjdsXWmoLF5f8B/N2SAFJAUN/B/T9Vjr6CzGClUQmGJQnMAbQl
        ajcwNslDGYxwjdnazDbhB1mkJglHpVEjKQ==
X-Google-Smtp-Source: APXvYqwYN2nhY1spLQvC2zasTrz/bvKwBvV9enaVBBRDKUn7AFldOujCtq9CUvaY4BxZgE1L7GHd6A==
X-Received: by 2002:ac8:2af8:: with SMTP id c53mr88215379qta.387.1564580775668;
        Wed, 31 Jul 2019 06:46:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a67sm31086281qkg.131.2019.07.31.06.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:46:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     miles.chen@mediatek.com, mhocko@suse.com, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/memcg: fix a -Wparentheses compilation warning
Date:   Wed, 31 Jul 2019 09:45:53 -0400
Message-Id: <1564580753-17531-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The linux-next commit ("mm/memcontrol.c: fix use after free in
mem_cgroup_iter()") [1] introduced a compilation warning,

mm/memcontrol.c:1160:17: warning: using the result of an assignment as a
condition without parentheses [-Wparentheses]
        } while (memcg = parent_mem_cgroup(memcg));
                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:1160:17: note: place parentheses around the assignment
to silence this warning
        } while (memcg = parent_mem_cgroup(memcg));
                       ^
                 (                               )
mm/memcontrol.c:1160:17: note: use '==' to turn this assignment into an
equality comparison
        } while (memcg = parent_mem_cgroup(memcg));
                       ^
                       ==

Fix it by adding a pair of parentheses.

[1] https://lore.kernel.org/linux-mm/20190730015729.4406-1-miles.chen@mediatek.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 694b6f8776dc..4f66a8305ae0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1157,7 +1157,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	do {
 		__invalidate_reclaim_iterators(memcg, dead_memcg);
 		last = memcg;
-	} while (memcg = parent_mem_cgroup(memcg));
+	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	/*
 	 * When cgruop1 non-hierarchy mode is used,
-- 
1.8.3.1

