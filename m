Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0055A592970
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 08:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiHOGMo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 02:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiHOGM2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 02:12:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1918E32;
        Sun, 14 Aug 2022 23:12:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so5969692pjk.1;
        Sun, 14 Aug 2022 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LhcqDlXGfJ5WZ4pq+69nFl1/2lUamAyvk5tX89/bbLw=;
        b=josV6bMQDWFEsYVQ1ffi3TcLPOFdBK8SdUPeL+Mzpqlr0xOsCTcflSe+QLaSP8mng6
         iD1HHHxy8U6X5F4Z2LTEPDVNESg9hF/49w3fjQyV+I/CkMU3w4Ry77cG4LYOz4+CkWW6
         Y/R6z/fWx+cPV6AJ/wHyT7MvGyEBoEBDUuSihr9+apX0A+EYUN8m9sDoRnoiEV/dNTbn
         rr73ULJMhxR/cXPDfwg9swGYD2aMr1kZrtbNwk91Z532o/n1tBu549Ja/tIZsgNMC42b
         Pw+F8OY4F85MwvDW1iMF3jfwDCGbzn/iZ83FzK3zEZelye6ugWfcWjh4fcMGvmrLDrzG
         SdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LhcqDlXGfJ5WZ4pq+69nFl1/2lUamAyvk5tX89/bbLw=;
        b=BPH1/QLqh2q+iXdH7Szyd9eO/ui4g6frBnL59W0f8OzsKt4sskJV7bmMDUGu+EnW6o
         SDNueI24Kn43zVgjKteoYGxzcfwJH/DOP7T8z8JP0jyvJPiuuIvmXMs4l+XjLWL9R3Lf
         ew89SCal7lKTJu3UqOGdMIYoXQAkdfZOBbPgOX8KbwGTBUK4dSM0bKuDjPQ5UkYtaSi/
         ySjKTjc49Rdsubo6WEVt6jj0E4FTQGMO9WGBjYKnkliWp+7ccgqtz+ssoc0zNOZREXK0
         YhGzmLNtGTg1lmlnvufsHHEqiwiN+xhpKHLClGCBVdkPWe9RrSzCOkgku/5Y9XxskB5D
         X6ow==
X-Gm-Message-State: ACgBeo3SdGxpXxt+HjYWP8SIyN0SbMQerJHHr/BB4FsaH+ybw2q8qMuf
        FC9tJUJKhE3iSDUDV1b17qA=
X-Google-Smtp-Source: AA6agR7T6weGBYhmhqBDQeVt0qeaU5aeKHWCsYgehEewIzNjCzlMEyhbZfCuD3o/QG2/9Gfli6P4DA==
X-Received: by 2002:a17:902:f082:b0:16f:18b6:71d7 with SMTP id p2-20020a170902f08200b0016f18b671d7mr15973415pla.94.1660543947638;
        Sun, 14 Aug 2022 23:12:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001714c36a6e7sm6281140plq.284.2022.08.14.23.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:12:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xupanda <xu.panda@zte.com.cn>,
        Zeal Robot <zealic@zte.com.cn>
Subject: [PATCH linux-next] mm: memcontrol: Fix typos in comment Fix a spelling mistake in comment.
Date:   Mon, 15 Aug 2022 06:12:08 +0000
Message-Id: <20220815061208.65945-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: xupanda <xu.panda@zte.com.cn>

Reported-by: Zeal Robot <zealic@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>
Thanks-to: Yang Yang <yang.yang29@zte.com.cn>

---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..4dddd8be320a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1143,7 +1143,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	/*
-	 * When cgruop1 non-hierarchy mode is used,
+	 * When cgroup1 non-hierarchy mode is used,
 	 * parent_mem_cgroup() does not walk all the way up to the
 	 * cgroup root (root_mem_cgroup). So we have to handle
 	 * dead_memcg from cgroup root separately.
-- 
2.25.1

