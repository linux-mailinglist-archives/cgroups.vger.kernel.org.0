Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7D65ECBB
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjAENRu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjAENRY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 08:17:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA075DE4B;
        Thu,  5 Jan 2023 05:17:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 6so22544318pfz.4;
        Thu, 05 Jan 2023 05:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGNG7VnZJT5NrQNN6BhNmvq0EdhUnj+GOmFvACaLTXk=;
        b=lsPMxNWnGO17JgyijK7xfpZgFbuz6KdZizssrHuAy+1vnSLEkHZ63zNwolvfA1EZEs
         Yopw5rWH6hUbO2tHXYC4UMNhlDh78F3wuO5FOS6QUvLG84FLyKpKHbp7hgUK0mrDE266
         XFK59lSLCDz2YVDChTwwU7qUKHhu1uIN5laO41h+2Xb5hv3qgLeG3wzzfnlc0bTq9PX3
         B9H6zlDTXgbwY9BgPwwxV0LscCEfKgt5D2hFe+ZZT8ELPkfmsPIC1zLGoCFfwT9ptYRJ
         OiI/zEhACIbeIQZj4gX3ZNOIZWwBHgLZd5nSmrNibY2Y9ohvzqWNBRiWXIYx71tYtErD
         dHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGNG7VnZJT5NrQNN6BhNmvq0EdhUnj+GOmFvACaLTXk=;
        b=fdYVlcberWXLOPqPinDMoejrHSHbIn2e0+2Omr+rDFqe6AackPJ52AidKo8yPkEeDV
         EP70xVzzLcAOTwDO2oBZ8+dZXyBYQ458dk1hyUfyeEXiiB0QM9f/cNbXwwrVnx9x3Ckm
         Zd8hpXSRNOPbkOhW+sx9iOQdm+OJHPrnYky0y97D25QgxpdmZwIMfMDU6/fmYVh9Dk8Y
         /zY8EJs+UdWQO7ZARCQZuhhrQiAa1VEM61T7Qca7mpdqvvwpDGZlN2leDjSwuWEYRTlr
         0jMOyIS8O4fqVdnDesNgvCopRHCzKLC97Iz9JMgbiThGohvvUzh3apxg2C1XVWKNz1oz
         /nwA==
X-Gm-Message-State: AFqh2kqlvvGhQK7kdDD0zkVl2CLDzbQ2jMYnLZx8pXnqpsweGWU5rrp4
        BXLyQgljdDW/76QSiVXwmK4=
X-Google-Smtp-Source: AMrXdXsYhU5SvLd2MIx5+aPldA/gYIlM29jQgf1iNhKcsHwH0/UyoUf4ASexAZm03c0nXR9s3Xbllw==
X-Received: by 2002:aa7:94b7:0:b0:583:a62:d840 with SMTP id a23-20020aa794b7000000b005830a62d840mr4575121pfl.29.1672924628904;
        Thu, 05 Jan 2023 05:17:08 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b005772d55df03sm13996299pfq.35.2023.01.05.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:17:07 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4464D104F98; Thu,  5 Jan 2023 20:17:00 +0700 (WIB)
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
Subject: [PATCH v2 7/9] docs: cgroup-v1: make swap extension subsections subsections
Date:   Thu,  5 Jan 2023 20:16:32 +0700
Message-Id: <20230105131633.553574-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=bagasdotme@gmail.com; h=from:subject; bh=uE+t77fun6ccoXEmhoP8hbo16qhF0xOO2tCNjGXW6A8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnbzm5YGvPgaJDfiTkV7UzLnq4MEK/bPdWvcsokjUbebY/v rmbK7ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEqp0Y/ulb/hKJai3vXfLFNSWXae H1vUlBd6u7eT2tliVyViYL5jP84arouyobqPV75r2/0RX/O3V5z9t+3Sd1Y83q6smtj7ZZcgEA
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
index 162cc26dcddb25..0e583a6f783955 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -244,7 +244,8 @@ In this case, setting memsw.limit_in_bytes=3G will prevent bad use of swap.
 By using the memsw limit, you can avoid system OOM which can be caused by swap
 shortage.
 
-**why 'memory+swap' rather than swap**
+2.4.1 why 'memory+swap' rather than swap
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The global LRU(kswapd) can swap out arbitrary pages. Swap-out means
 to move account from memory to swap...there is no change in usage of
@@ -252,7 +253,8 @@ memory+swap. In other words, when we want to limit the usage of swap without
 affecting global LRU, memory+swap limit is better than just limiting swap from
 an OS point of view.
 
-**What happens when a cgroup hits memory.memsw.limit_in_bytes**
+2.4.2. What happens when a cgroup hits memory.memsw.limit_in_bytes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 When a cgroup hits memory.memsw.limit_in_bytes, it's useless to do swap-out
 in this cgroup. Then, swap-out will not be done by cgroup routine and file
-- 
An old man doll... just what I always wanted! - Clara

