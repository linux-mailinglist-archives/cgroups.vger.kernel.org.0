Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF62CFDDF
	for <lists+cgroups@lfdr.de>; Sat,  5 Dec 2020 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLESpb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Dec 2020 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgLEQs0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Dec 2020 11:48:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7BC09424D
        for <cgroups@vger.kernel.org>; Sat,  5 Dec 2020 05:03:00 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l23so4780311pjg.1
        for <cgroups@vger.kernel.org>; Sat, 05 Dec 2020 05:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=iXNSJ08wIZGakHjgbIcjXIwKHGYw6UmpSfo0Eb6nim+XGWMNO6A9YVj0zeZ0dYSQFb
         VCVr64gPtj6hVu4sogDtwUSNROzxv6XvOqYT+pBJFDMLmdj3FCafR6WDEUGrUGpa/Gry
         XXAUfe11y0QLCmPB2oAJqeUXRXxHhQFQISCUJ2uu0NDV/c2iML7Jx2DS5LxoZdVrz+Dt
         JWQKZovT5QiiunDzry2OtZZ0K6Qd39WLeMyA2wk/HngpFlpKfv9fU/7JTGbFE+lpi8zb
         9xP0mmYdGoGIHA3F9+ShWXuADJv7UxVumiQ3BAl7ffDiAPAwAgcfHt+lMzY/FNoFgLKl
         JnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=Z1nTJN/0V4flqjjP39+mNneiLYqHfRo2uq9i70ypJMXBpEokqA5SlKbMf7hPKj8oJO
         B/CF9dPiKhudJmE4L4N3ek14qndjV0zeiNq0nTKFroNAzl+8jfr3A1tXm25lKV+CM8Sk
         CAAElxrUuJwN42FpKFMDYMx1I1Xexu9XPcT60G5HxnVe32nW+gJfAEk1EZb/hTorBJP1
         m+79pibXcIwvHv+XfWUoPdbd/I1ekyhHo3E1+BKotbVaHvrNtBG3P4+r+se8PymWRdnz
         eigv2IPXwRIcPYT92LNSYS3VgaqlonU/uwF0X/acUdlXG643Xz4FhOkdfqHMUibO1EQm
         ydlA==
X-Gm-Message-State: AOAM532Gd8MlGJ23WtPP3u0W5aiLxqugISzx4WoBPmJf9Sfzeg5k8gMf
        94FfsLHbU5IrauC6QKe1yBn3nA==
X-Google-Smtp-Source: ABdhPJw6o9CKoD5YBzWC7VW/NxM7IRg3JXfDBPySbZAj0r3+Q0HFX4zEhlsXQ8gE6TyP2+R2ML2Aow==
X-Received: by 2002:a17:902:b58a:b029:d7:d45c:481c with SMTP id a10-20020a170902b58ab02900d7d45c481cmr8074051pls.55.1607173380527;
        Sat, 05 Dec 2020 05:03:00 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:02:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/9] mm: memcontrol: fix NR_ANON_THPS account
Date:   Sat,  5 Dec 2020 21:02:17 +0800
Message-Id: <20201205130224.81607-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22d9bd688d6d..695dedf8687a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5634,10 +5634,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

