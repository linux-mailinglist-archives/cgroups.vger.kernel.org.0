Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4B650708
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLSEW3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLSEWW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2F64D2;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so11728184pjr.3;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm3StokzlT7Szh+BiWvCYI/X474BbeHVmllPMqNHQFs=;
        b=CivmBZcjEkCkLhyVLzlphxvDMwl6nheUGKlegj1hnyWxPXopZtrKelMJg4NLztp6Ei
         19ap32V2lPltBGqPJjF1yBiq+0421am0efG9yS/XctjfSJMUHJPg2KbY+drosobdJh7n
         gghu6w/mHGHBlxzAbFf/3ky8O7nGUoI16/HmaFoXCTM60F0g6N/aa3HWSmyxvZZBroOs
         0IUlMvIpvPq9EUVRd08Us5p8bQ/ETvUMY7+aK58/0yKxoewBuKFZb0FIc8vWRY1rerdg
         ofnz3i0Kc4V+CwnzTxo9fb0DS9JoKTh94ENhKF8b6RzRqJ5RcsZp2hXo25O5OqXf7Mgo
         1soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm3StokzlT7Szh+BiWvCYI/X474BbeHVmllPMqNHQFs=;
        b=IYltYxCf6RqE6TyvEPzge33MQDbzlbm+9qNJqSv1DI45HRZGxSjNOmY2MdvuHbqEQp
         Ekw0kvCwn1NMcl+eFhZgucT7FzlhG/zIZKQCahM02bUsGZMX99bgbAj5IqiwGo01kad/
         4YZj/4EuamRA4u0C3QTHxy7ANZgbu3nK/+428zgGJFFen07mgKHgGxm0K2qxhSGpx51b
         JpRRiIHM1id2qlaT1kdOOMBtOZ/y/cW1QQuaGkB+M8SegdwoO/DHDKYON9lW/Ju80+3T
         +HlujrQwVlD7+km2ahq/BsMiq6pUkOvFW4zxBmo0Ep4kSHCipfG4gWI+x3WS9viiQvdp
         CMjg==
X-Gm-Message-State: ANoB5pnJc2vK1BLYN8yuNphBBwt+y3j4r42P3eGg6np1eII34GMF/Dzw
        BbukgfAEj5Bs5fnjnV8sbbM=
X-Google-Smtp-Source: AA0mqf5CnUHwvfX7+1EJIa5A6jcN2atInVT92XNpPGAKNN1DfPXiodIusuJr6g42L8vNFv6OI7Tt7w==
X-Received: by 2002:a17:902:7e86:b0:189:eaae:a19c with SMTP id z6-20020a1709027e8600b00189eaaea19cmr39764943pla.30.1671423741073;
        Sun, 18 Dec 2022 20:22:21 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00189e1522982sm5876404plf.168.2022.12.18.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id C45D310403B; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 03/10] docs: cgroup-v1: wrap remaining admonitions in admonition blocks
Date:   Mon, 19 Dec 2022 11:22:02 +0700
Message-Id: <20221219042209.22898-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=bagasdotme@gmail.com; h=from:subject; bh=lpUMV2xz23OWCWVLnriwcRj5xPuoIGRu0Ewl15SLIFA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn71z7D2sLB/nI+epfmjX8TWbYy0vZXxnNyt0vbLVJ3OP 3IINHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjInU0M/2PY0lqe7C6p53qqp9STtv jzwfmNq/u1OK6wh/Gr3U9V1WD4w7ObbfXhP2dvCXbryN/+9eeUl0qKzZdN71um3rpuJn59MhsA
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

Wrap two other admonitions in appropriate blocks in order for readers to
pay more attention to block contents:

  * hint:: for editor's note
  * warning:: for move charges deprecation

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index ec99bcbd55c2e7..f828db2a671be4 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -13,11 +13,11 @@ Memory Resource Controller
       memory controller in this document. Do not confuse memory controller
       used here with the memory controller that is used in hardware.
 
-(For editors) In this document:
-      When we mention a cgroup (cgroupfs's directory) with memory controller,
-      we call it "memory cgroup". When you see git-log and source code, you'll
-      see patch's title and function names tend to use "memcg".
-      In this document, we avoid using it.
+.. hint::
+      (For editors) In this document, when we mention a cgroup (cgroupfs's
+      directory) with memory controller, we call it "memory cgroup". When you
+      see git-log and source code, you'll see patch's title and function names
+      tend to use "memcg". In this document, we avoid using it.
 
 Benefits and Purpose of the memory controller
 =============================================
@@ -723,12 +723,14 @@ If we want to change this to 1G, we can at any time use::
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
-- 
An old man doll... just what I always wanted! - Clara

