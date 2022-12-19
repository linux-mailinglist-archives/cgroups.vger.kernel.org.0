Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C36650719
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiLSEWq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSEW0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024965BA;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d15so7857630pls.6;
        Sun, 18 Dec 2022 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agWt8CECL43NEhVRFwvhtAXySMNGigcHHGw9DmNksyg=;
        b=Rw+DM6QWhhdQXktWp+em/fBiFTj3BUilx3MP8RgeQvvsMgLuECpixEMst4FxDtn7zH
         rAtjr2VM4z0g7bvXq3KMTUQq427rHE6DpnzawpIYLHC4ZJe5B2U5vgtq/CW3nPXjtUXL
         EOTbYjZFPwUdqOlRePgXbAKfKz3l/dBEmZ/BsZAW7kFA+JnMNfrmriDf/smpetfVAs8V
         zlEYA+1aASqKs5fLj9Ca+PsuWMPAqfGTOCRjtX4FPTomYaN9JIrxcQ83tuhIlGF3dTo6
         tPX6UhACp5qTOwk+LxN3dvDkAeg+v22HECunwHxAfPX9gvjE+loAvHbiB0LNKPyfzp2b
         PG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agWt8CECL43NEhVRFwvhtAXySMNGigcHHGw9DmNksyg=;
        b=ZUsoY/D51Yvu1FG8IcBtlP6jdRo3nfPdVvyKxNqe6bTOxBX8/0G6ITdRp7s1BxUXQQ
         aMiXK1L7SBj4+wiB+2jbx6bfTD6P6jByji7BIBc2R/AKFmXcTiuKioCnxXIqL7r+MB9f
         U7yVYySA1bdU4uHoOKIUHnYIX030MKqj9nhMo+Uj91LJKUSy+CddzucSWhu2/8yXk1dY
         FjUKfnXFN6P+l7QMGLSSmUi0tMGZ0z7jQAnUqL2w5zPCrv9L2Udoj5CAPrHBXdwH/c4u
         hUe/YTMorZc3dQiFEVoUPtZM7q+Hea/OIMjwLO4JOkOzLnto1PQjcJzV4m/T30ZDSEma
         Up8A==
X-Gm-Message-State: ANoB5pmqaZFzUvqeYZkDhNLGhYFyJEYhCIGPL2HEMw4NIXGldDQS9sEc
        5oAy0NDNmFytk3NRY1K0HPU=
X-Google-Smtp-Source: AA0mqf6BCBYy+YpcHUop3GwiAxAif950akyz01hjK7kttTKC1Ch/bGKyJy+8RAzPOIHGCelhPQJrwQ==
X-Received: by 2002:a17:902:c183:b0:189:854e:93a3 with SMTP id d3-20020a170902c18300b00189854e93a3mr40668144pld.69.1671423744594;
        Sun, 18 Dec 2022 20:22:24 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b00174c0dd29f0sm5897250plg.144.2022.12.18.20.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 669B810405A; Mon, 19 Dec 2022 11:22:14 +0700 (WIB)
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
Subject: [PATCH 08/10] docs: cgroup-v1: use make swap extension subsections subsections
Date:   Mon, 19 Dec 2022 11:22:07 +0700
Message-Id: <20221219042209.22898-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=bagasdotme@gmail.com; h=from:subject; bh=YB2axwGgINIOaNnBOhZC/NJ3W2+BU7qyWgI/kX2Gj+s=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnzn33I21Y795n3xfn/orzeP5p9r4RP8LZ3u0nrvSUhWSsM Gs4s7ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEHv5jZNj57tBtd/9bL4qZdyzn+b l3XeqJ8pQY9pMtkqu/q8zcUvyfkeF0rtX/9u2rLSbq3bjgea+r+adr3/YLwY3svLk39z+RXsQNAA==
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

Subsections text of swap extension section is marked up as bold text,
whereas making them proper subsection is more appropriate.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 01104b459b4cbd..863e0f17ca0067 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -246,7 +246,8 @@ In this case, setting memsw.limit_in_bytes=3G will prevent bad use of swap.
 By using the memsw limit, you can avoid system OOM which can be caused by swap
 shortage.
 
-**why 'memory+swap' rather than swap**
+2.4.1 why 'memory+swap' rather than swap
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The global LRU(kswapd) can swap out arbitrary pages. Swap-out means
 to move account from memory to swap...there is no change in usage of
@@ -254,7 +255,8 @@ memory+swap. In other words, when we want to limit the usage of swap without
 affecting global LRU, memory+swap limit is better than just limiting swap from
 an OS point of view.
 
-**What happens when a cgroup hits memory.memsw.limit_in_bytes**
+2.4.2. What happens when a cgroup hits memory.memsw.limit_in_bytes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When a cgroup hits memory.memsw.limit_in_bytes, it's useless to do swap-out
 in this cgroup. Then, swap-out will not be done by cgroup routine and file
-- 
An old man doll... just what I always wanted! - Clara

