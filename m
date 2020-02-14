Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3F15F7FB
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgBNUse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 15:48:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50548 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUsd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 15:48:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so11324864wmb.0;
        Fri, 14 Feb 2020 12:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxFia235IPfyDDQlAzkqDLsg9ubjwppF/aCVODUQpIw=;
        b=LQmAqdXsML9wsGoHcSXgEQKuW22UvhWB3+YmPOoYpcyRKxaOGFw0sRsTP9S1LqiUJs
         bdsMK4EoopXxGlZUwb5tH6yhMXvxDXEvIQq0P3OJ7pJ+VUOCLL6h8qqNmWZkkHV8jd2B
         1PhOxvOSceedwzfZhc1p6KFkG61AKHWLd7YlXmPxB3eui8YNbKH7ZKysXnA3grvN2DPr
         5xiZKGTjCF8BDVemAY801rVDRcQYRMPd0VTq94+/OgqF6v/MMx6sDmijersbj2IOL24G
         jX75Cehb1X7k4z/9fQm2tRVySdwmPUX3i1ViH0YaL7oGqVOinBrh+hxbU8SAhgKB/BSK
         EQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxFia235IPfyDDQlAzkqDLsg9ubjwppF/aCVODUQpIw=;
        b=NToLleBhhldrHhPl31r4FD3MvmRTvE+l+OWe6efldQsOFBxgQCu4QRLhTcyy9HCj0v
         F5Rc+bGGKPVGWJmZ6PUYi6iM36D9Jj2Kiwj95E9cgbXpqfvOamwu7z6S8HJ4vSV8MgYw
         z2YeUCTjmy29p5FuvI0F/HOOoXOc9VroEPCTTvHQkRkjlhoPdwrjU6wi5/FmP/+oVch+
         JV3zED8ZarbWoqVeKQyaNm76K3Eh6uKQrIcxuPq+UhUktvuuYxedBufGdo2ArCLmUgIa
         zk9KrMe1kD4VSWFS5vbodNdGwJSjDW2A8P+E/oN5lCWaIDb2XhO8F5aUdLljR7ENJskv
         E7ag==
X-Gm-Message-State: APjAAAVqyYRRWJp7FD84bbUqlzCL8k3bMBB3/uxvSHapWDwZ1Zkqiy2k
        SfPhl8QnqozzjIjVhU0peML1iRqkrGyM
X-Google-Smtp-Source: APXvYqxF8g88uOOKmgJxcxdDJrerXQURWrjGk+r+5cHlvZaRVE7gv8/riqrZWRwVhUht96zKhugSAw==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr6474084wmi.35.1581713311936;
        Fri, 14 Feb 2020 12:48:31 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:31 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 03/30] mm/memcontrol: Add missing annotation for unlock_page_lru()
Date:   Fri, 14 Feb 2020 20:47:14 +0000
Message-Id: <20200214204741.94112-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sparse reports warning at unlock_page_lry()

warning: context imbalance in unlock_page_lru() - unexpected unlock

The root cause is the missing annotation at unlock_page_lru()
Add the missing __releases(&pgdat->lru_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..22ddd557a69b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2587,6 +2587,7 @@ static void lock_page_lru(struct page *page, int *isolated)
 }
 
 static void unlock_page_lru(struct page *page, int isolated)
+	__releases(&pgdat->lru_lock)
 {
 	pg_data_t *pgdat = page_pgdat(page);
 
-- 
2.24.1

