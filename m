Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8B53232A
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiEXG2B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiEXG17 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 02:27:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805FD72E17
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a38so12665919pgl.9
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2mx9bPTY7AEcp+j24lhXXPGVls/yhivZ1agLRVxoLiw=;
        b=v+S3AKD3IZY1715alsr8yTzbsVUYEJKe+49LFvD+HdqE9G/w+5EjzEN0EwaEDyGrgn
         i9Ya3PVga4iPV58AJIeN1oTrMCpdjatANgHWEgSW8H8UHrlDSX4k0sGGqWcV7AXdFW13
         EAk3nLfKEjQm6om5mFrDB7o4f02o242GQEXT/WIFEL4yR/3PpF7M5gtnBfzi+dSVbTxu
         StmM8BZkmo2YtgyD2u3N/KxcgJyaZoQ5QI6XjNdjDbH/gX13NzTb6mqHMmzWnw0wjnjt
         6G2U6k80RGyCUtx5VNIlrbZZrmZIkm6UOOp3C70ojMsYgXdvqPAfokDNwMjQRVy8THGC
         Q/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mx9bPTY7AEcp+j24lhXXPGVls/yhivZ1agLRVxoLiw=;
        b=biUVUdQiWo2VFCNDHRyz3LFLR3dzTd8qS38mMdGs4eMmY1sOiH7bbnxZvcHp8fOVqq
         XJeVSmiXw4t8hNLqVexbzAxR8hWa5ZSf8jgrNGS7Xr8KYn3Q7eCGfH6sV7fT4X2PTTWP
         zERcFo1/a0Ez/F2QbhYaw63tUr5dVnrkmhrkUfqKmAa/fez/7zIHv4WUqexr7OPVPrlI
         fwsxynSrTp2ADG7BEOW389na9HDz0czC5qZMtaw2hCH/XhmQrQ8hzDKC3r7aWAmBi1Oy
         2GogKTbTRxSoD0zTYu2PyPK1cATPjnm4e80oVpO5Q9Q5i7FsiDIF75//9r7A5zSmkFOV
         q5hQ==
X-Gm-Message-State: AOAM530BvNZO/JTWutR1WY0uBSuYL3Am6fZyWLzDdVg7vlBBflsC6hi/
        T00IWj4dQhm7IHk+B61e0x76SA==
X-Google-Smtp-Source: ABdhPJx7zUzEoXA0gBdm9ca0a2T/LuHVii8K0J7cqNEy85oapg7WfQ/2eJWO3OwS2W/T0/ARUmA1jA==
X-Received: by 2002:a62:f901:0:b0:518:307a:b392 with SMTP id o1-20020a62f901000000b00518307ab392mr27007106pfh.44.1653373677075;
        Mon, 23 May 2022 23:27:57 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 06/11] mm: thp: make split queue lock safe when LRU pages are reparented
Date:   Tue, 24 May 2022 14:05:46 +0800
Message-Id: <20220524060551.80037-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Similar to the lruvec lock, we use the same approach to make the split
queue lock safe when LRU pages are reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ea152bde441e..cc596034c487 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -543,9 +543,22 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock(&queue->split_queue_lock);
 
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock(&queue->split_queue_lock);
+		goto retry;
+	}
+
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
+
 	return queue;
 }
 
@@ -554,9 +567,19 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in folio_split_queue_lock(). */
+	rcu_read_unlock();
+
 	return queue;
 }
 
-- 
2.11.0

