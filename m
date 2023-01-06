Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FC65FA7C
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 04:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAFDtT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 22:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAFDtS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 22:49:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A979B4A8;
        Thu,  5 Jan 2023 19:49:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so470043pls.6;
        Thu, 05 Jan 2023 19:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fekH72sui9GdebDgVNk2XaNYCf3hMj26CpPd65HWWNo=;
        b=UiHZc4xPgz9riLMU7jZRFdpYBA/tSzUNwC2BWiIfW76JQV7qvDnZ5YFgaBwl9muFhb
         nAkOig3bzP5SUcRFGALvqIyPdhKwyNXxWrdL9D84b0uOtZaZPFbVrf5kQzVd/o7OBkXu
         z6f2FNtKYhJqWr/Xndmg2e/SuFt9Fy/yogCm8unBMDoDabAFe+n8z4lp47ALzRkkQCSZ
         oxmtpgTEH7TmsJjYV1pYx4dJ90trVyNrmkZGKcXoBVSNzk42OHhEXYxdFGiQEkojlIfy
         SzRBhKd/owMzJFmNo5AZZdxNmsCZtH2WIhpIGtVELwEteObfco0sQVwvAoyw3CcOcJba
         2t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fekH72sui9GdebDgVNk2XaNYCf3hMj26CpPd65HWWNo=;
        b=NMLSNz75dYFn0jr6RFwnhrRRGoKyxbcQAKJhHaP1Au3F6FcxqaH8huM9JIu8mepkku
         ZgKBs/VEPxCDsBN/6PocjLv/9EEqHyOOQ2xO5ryvPmc30fXrJOZ3uZlRK/fEpcEzXq7D
         oR49+XxCIiquQchygm6wawuVzSyreyvcZOaYTzdEeX1muLcA4OgigAC3PMS056ruuYec
         pirMV1nBgsVNHxiqnhr/wMKLil511p65Y625f4y1ax7Su3MyLivYVik1ZbDj8Ll4aL5O
         0mpwuZKw1zIhAno5Pu64FVKtnzgGRCbTnDSMBct/LYaG0Ee7IiRmvOz4eF5AiREzh37Q
         x1Ag==
X-Gm-Message-State: AFqh2kpbtCt7QCi3H20JhbFq7SXtLsCyNF7YlGY9FGHMUwnumx3IBz8L
        A/3Tf/yaq6xwOxj3+Kt0pBo=
X-Google-Smtp-Source: AMrXdXvyVCK1lhieVWDdWnx9fCexwUkj+hwmFDv22Gy18g2mIEKegCTvNB6j6O9x6ZyNW6FTQLfyhg==
X-Received: by 2002:a17:902:edc3:b0:189:5ef4:6ae9 with SMTP id q3-20020a170902edc300b001895ef46ae9mr52366814plk.45.1672976955660;
        Thu, 05 Jan 2023 19:49:15 -0800 (PST)
Received: from debian.me (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b00189c93ce5easm26648752plr.166.2023.01.05.19.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:49:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5D52F104FE7; Fri,  6 Jan 2023 10:49:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] docs: cgroup-v1: wrap charge moving deprecation in warning block
Date:   Fri,  6 Jan 2023 10:48:37 +0700
Message-Id: <20230106034836.23708-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=bagasdotme@gmail.com; h=from:subject; bh=KgCM3g5FsiytA4vmbQIOX+Rd86PUGBjozHPoOarnvsU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbZwnsfhJW03XnxmSRtsDcZWFZB88eW7hWrdvL9bXnM5+Z d5av7ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBENJ4y/He4lXBqP09p/boMlhvr/y 585c/It8Tzxvk+4yxNVfa3K8MZGb5oOmfr2SyO3zdhwoR9+hn7BQ8yvnZceueQmbWi7I2NxXwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 4ddb1a2aa1a3c4 ("docs: cgroup-v1: wrap remaining admonitions in
admonition blocks") in cgroups tree states that it also wraps charge
moving deprecation notice in admonition block (specifically warning).
However, the notice isn't in cgroups tree when the v2 of formatting
improv series [1] is submitted (and then applied), but rather in mm tree
instead.

Wrap the notice to fulfill the intention of referred commit.

Link: https://lore.kernel.org/linux-doc/20230105131633.553574-1-bagasdotme@gmail.com/ # [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 258e45cc3b2db1..b73eb174735556 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -722,12 +722,14 @@ NOTE2:
 8. Move charges at task migration (DEPRECATED!)
 ===============================================
 
-THIS IS DEPRECATED!
+.. warning::
 
-It's expensive and unreliable! It's better practice to launch workload
-tasks directly from inside their target cgroup. Use dedicated workload
-cgroups to allow fine-grained policy adjustments without having to
-move physical pages between control domains.
+   THIS IS DEPRECATED!
+
+   It's expensive and unreliable! It's better practice to launch workload
+   tasks directly from inside their target cgroup. Use dedicated workload
+   cgroups to allow fine-grained policy adjustments without having to
+   move physical pages between control domains.
 
 Users can move charges associated with a task along with task migration, that
 is, uncharge task's pages from the old cgroup and charge them to the new cgroup.

base-commit: dd5c3ba990ae67409bc058051efcd40c3689d01d
-- 
An old man doll... just what I always wanted! - Clara

