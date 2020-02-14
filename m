Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC60A15F7FC
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgBNUsi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 15:48:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39302 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUsh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 15:48:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so12167780wme.4;
        Fri, 14 Feb 2020 12:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQbKLQ9ukje1bT/FheNFvSXPv2JzfMKZr476ojL2Is0=;
        b=O5ir4u/aNTfUulqZgaK74Gu8mBBzIqrjfADgTPMzLTzu1KAaf5QhfiF7kasEvy5r4K
         ErG2wMyrU7UIe0OHtzQefP/ASrTS2xW6pdSXgvPTDid60F1YgIP5XLH4vSUw/PECCgGv
         Pa4cg3cKyKakJj7xVxQ0ei/Rp6Od561Ee9nLUyaY5bPJGHcMYlszGui/5WsNIo3AiOp1
         8chcGs06TgYmRm4OU+BMsaiPP3+fjTxtzTIDU6vJLXvT8YZ9sTd+TmxgjbbvPUsJaof9
         8qPho5ezQRvGRyFcOCnQK+B6YW4RPQhq9zuSANGmyzBFVnDjnlJ6D97CHQo2DeXk/VHs
         Lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQbKLQ9ukje1bT/FheNFvSXPv2JzfMKZr476ojL2Is0=;
        b=FQnrB4MbinrfrYJadZtraXZWNFWyaHoKFzzcVMUiQC3t7AnEIfnRfJMrDccbCV4ngk
         jtn96ISMli6pLbMpBtcKj5jINrCbDxP9SYaVqxf0pKRUsINKN4WzFf5BSy2jU4LmoMbP
         xymaaHXQg9+KjI85pBS+xmGBJHS8IIW1QCAcr2urtnJwJ99v7oQ5yV8yaielFhkPDS7s
         R4XTad31ppC6XFM2A0n05hO6DmkRxuqkjt70gPOlRqt+XmR0rBa9WxOd6Rr0efBWCHaY
         UCX7VQACMf0ZOzBaL93YLKoT4vPBc6oCKXvwqnWMHKzMxQln1mEzMPknMZ11P+k1T2nA
         idNQ==
X-Gm-Message-State: APjAAAX/1pJC27sDAtChonmsAQu0cMWN6gEJis6IKu3mlPJt2o76v++k
        FIfaokMR1Jq4+BwFKpIhbC53BD9bX5QS
X-Google-Smtp-Source: APXvYqzDv6V1/vR7pqSlQ0ZZe6UVzBWl6YQ5gh8Uk6kepa8dWWi2wm55mdwrZhSCm7+OaCMs66lDZA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6358657wmk.15.1581713314492;
        Fri, 14 Feb 2020 12:48:34 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:34 -0800 (PST)
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
Subject: [PATCH 04/30] mm/memcontrol: Add missing annotation for lock_page_lru()
Date:   Fri, 14 Feb 2020 20:47:15 +0000
Message-Id: <20200214204741.94112-5-jbi.octave@gmail.com>
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

Sparse reports warning at lock_page_lry()

warning: context imbalance in lock_page_lru() - wrong count at exit

The root cause is the missing annotation at lock_page_lru()
Add the missing __acquires(&pgdat->lru_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22ddd557a69b..67dc9f1af0bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2571,6 +2571,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 }
 
 static void lock_page_lru(struct page *page, int *isolated)
+	__acquires(&pgdat->lru_lock)
 {
 	pg_data_t *pgdat = page_pgdat(page);
 
-- 
2.24.1

