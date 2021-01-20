Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379982FC5B1
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbhATAUs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhATAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D891CC0613ED;
        Tue, 19 Jan 2021 16:18:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so6219601pfj.12;
        Tue, 19 Jan 2021 16:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MClthhiRASKx89OyXDAWaQGxQLzHlwXXba8sXj7wtYg=;
        b=mSOIbc4Lg/dAwgp5ccUf0gm8Q8YOE4xeHySRx9KMvE3UueOXiwM1ZOnFQYjECzUZQz
         gXjmlwo9Y+lLkWSuwEaVps+e5wp30twhKpbzcX9sWh4DO1+jFGzQxhQT2Z5l1pIehvFc
         YWDGEO7MSVE0+vyHixnVh56JRzRXcf8v31WV5O+K6i1hV4vpSaO4orX/WPPk1U+2yY77
         6VBrDkN7KyK1+YhNbwQLrNl1WL2LTOv3mDCi9RZh/BoSp1dWQ8Jbc6aKDsuo/zjzmpub
         DXEgFCuFNBlsVUaSJRGGomIPtIuzgbNtCSOlC5Zfl1VxG8nBb6iHgGQYxO3QrkNFyDNQ
         fEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MClthhiRASKx89OyXDAWaQGxQLzHlwXXba8sXj7wtYg=;
        b=XnQ0Z54g881tptLv/EtAUu1mUaYlNDbvkOtcMV1Hulay0m2Oe/jl5WDK8l3MiH21OC
         l3k/DzyOWwYExtn0qoKVoZvlUF6baI4SQyXobKaw/lH7vXGnolfHP7sHASL9h5bCx2yj
         oupUalqdxA8wbkS6MTeKdevuaF+7Q3Fjasj8QeP6xt4BQe5u5VgCX/9/wAnWUvjGsoeF
         RJW0pDRPSCvzBOkr7qGnODs1NbyKSLNY3kU51STfBcS00H5yF4doaK6PrQAGaZfCN9Ec
         tOd4/aGMwWFERYMyo+Qalq+XjUS8qdBJMraFYDtY5eEDm1hRIZO4lxLk4L4yO+5kE636
         IYVQ==
X-Gm-Message-State: AOAM531q2IaP6SjLreqZNqqDmJ3yxbmO1mnzEsL7e53JCYjv0rFu0IgD
        hz0wSApLNJyBTpdHp5/PZ88=
X-Google-Smtp-Source: ABdhPJw9yDDWBEje+u8FkethTiE+pPoVs40I4042v+/1+FwwGTRw1s2aRSGsHOC7A0RU5pZ4cipozw==
X-Received: by 2002:a62:35c6:0:b029:1ba:e795:d20e with SMTP id c189-20020a6235c60000b02901bae795d20emr159890pfa.37.1611101914370;
        Tue, 19 Jan 2021 16:18:34 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:33 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 06/10] docs/admin-guide: cgroup-v2: typos and spaces
Date:   Tue, 19 Jan 2021 16:18:20 -0800
Message-Id: <20210120001824.385168-7-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

- fix a typo (mempry -> memory) in a file name;
- add space before "(" where appropriate.

Fixes: 5f9a4f4a70960
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b55362454886..073f976d44ea 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1263,9 +1263,9 @@ PAGE_SIZE multiple when read back.
 	can show up in the middle. Don't rely on items remaining in a
 	fixed position; use the keys to look up specific values!
 
-	If the entry has no per-node counter(or not show in the
-	mempry.numa_stat). We use 'npn'(non-per-node) as the tag
-	to indicate that it will not show in the mempry.numa_stat.
+	If the entry has no per-node counter (or not show in the
+	memory.numa_stat). We use 'npn' (non-per-node) as the tag
+	to indicate that it will not show in the memory.numa_stat.
 
 	  anon
 		Amount of memory used in anonymous mappings such as
@@ -1281,11 +1281,11 @@ PAGE_SIZE multiple when read back.
 	  pagetables
                 Amount of memory allocated for page tables.
 
-	  percpu(npn)
+	  percpu (npn)
 		Amount of memory used for storing per-cpu kernel
 		data structures.
 
-	  sock(npn)
+	  sock (npn)
 		Amount of memory used in network transmission buffers
 
 	  shmem
@@ -1333,7 +1333,7 @@ PAGE_SIZE multiple when read back.
 		Part of "slab" that cannot be reclaimed on memory
 		pressure.
 
-	  slab(npn)
+	  slab (npn)
 		Amount of memory used for storing in-kernel data
 		structures.
 
@@ -1361,39 +1361,39 @@ PAGE_SIZE multiple when read back.
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
 
-	  pgfault(npn)
+	  pgfault (npn)
 		Total number of page faults incurred
 
-	  pgmajfault(npn)
+	  pgmajfault (npn)
 		Number of major page faults incurred
 
-	  pgrefill(npn)
+	  pgrefill (npn)
 		Amount of scanned pages (in an active LRU list)
 
-	  pgscan(npn)
+	  pgscan (npn)
 		Amount of scanned pages (in an inactive LRU list)
 
-	  pgsteal(npn)
+	  pgsteal (npn)
 		Amount of reclaimed pages
 
-	  pgactivate(npn)
+	  pgactivate (npn)
 		Amount of pages moved to the active LRU list
 
-	  pgdeactivate(npn)
+	  pgdeactivate (npn)
 		Amount of pages moved to the inactive LRU list
 
-	  pglazyfree(npn)
+	  pglazyfree (npn)
 		Amount of pages postponed to be freed under memory pressure
 
-	  pglazyfreed(npn)
+	  pglazyfreed (npn)
 		Amount of reclaimed lazyfree pages
 
-	  thp_fault_alloc(npn)
+	  thp_fault_alloc (npn)
 		Number of transparent hugepages which were allocated to satisfy
 		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
                 is not set.
 
-	  thp_collapse_alloc(npn)
+	  thp_collapse_alloc (npn)
 		Number of transparent hugepages which were allocated to allow
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
-- 
2.29.2

