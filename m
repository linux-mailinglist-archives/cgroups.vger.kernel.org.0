Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B277339C55
	for <lists+cgroups@lfdr.de>; Sat, 13 Mar 2021 07:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCMGNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Mar 2021 01:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCMGM4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 13 Mar 2021 01:12:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23AAC061574;
        Fri, 12 Mar 2021 22:12:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id l4so26731043qkl.0;
        Fri, 12 Mar 2021 22:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhJjvom66vWXKl1dRRY7urBL+2AkflR90bJnAsiNVs0=;
        b=F1PhW6/1e0GK1MFV1fErIjvorj1XvA8fYbgQ+EBS2xpTPDvLQE3OfN8UuruqsI26/R
         ZyDKY85MRnrK8iSjHxVFbhnMmLbO1dk2/2Ddu+y8lgkkEIPMK9rOpLq/TyNxCJavBGm+
         XMQ7N1Gw5xxGsTAaJ5VLJVwKRrmywjrZen1GHlnxUvXBt8CLz+GsRNnUygUOxM8m6hEW
         agapUrIR9+qmpif5lwqWNI4UmZSeczjjbvND3FYs7PBfQFDx+mAFTtuFpP29FHIEUcqe
         d/KVUyrLxQTJfozyesGmOoAkwdelT/lcQE4PtvqenL6/ileoCUL66HRiOB2BaozcAFpC
         BFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhJjvom66vWXKl1dRRY7urBL+2AkflR90bJnAsiNVs0=;
        b=PBq/mfe3irdBydyPdY9VMhZNRr/m/wieqOiyOEJSaml8+Em106CkfHlZeijDz5voxe
         AYylkfyXvu7JzzOb/Yw42zGOYx0LNE3V1jDvMLWmRFJZ/SmCWwJCTBVH8EITxqgPxloE
         E2yyE2EFCwA6kU5jZtUnD0ErTgLXSBMBLcMu/gRlX3GAQdnFggWR6HXqyjR5OvrGzyzF
         ORFzEASSTHj1Co/y84ZtYCETcEt1u3XgD8ZtVQbVpC7KVheyQ+IV8auZAJVC6YVz1O36
         C4iuKVD9FOOOhNV4guPSFpH0gLDbqmcYmmO1RSkOiwgwj9twTbut/N2zl8V+zlQ2MVSJ
         y4rg==
X-Gm-Message-State: AOAM532kOrnCLWWoGqyQPaObKBtfCY0UAA6MD2kAvNPxGBXzOeajGxUO
        unLtn+MbZX2JmXy0kskuuE4=
X-Google-Smtp-Source: ABdhPJxHk7SQYw4g3fU9EIXzhIR6bw/q4vNwxpQqxtENzWc7l7tKYcTg8H613hJijEiD74idVoGpwQ==
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr14883173qke.126.1615615974796;
        Fri, 12 Mar 2021 22:12:54 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id n3sm5490020qtd.93.2021.03.12.22.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 22:12:54 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: admin-guide: cgroup-v1: Fix typos in the file memory.rst
Date:   Sat, 13 Mar 2021 11:40:29 +0530
Message-Id: <20210313061029.28024-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


s/overcommited/overcommitted/
s/Overcommiting/Overcommitting/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 52688ae34461..0d574fd3f8e3 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -360,8 +360,8 @@ U != 0, K = unlimited:

 U != 0, K < U:
     Kernel memory is a subset of the user memory. This setup is useful in
-    deployments where the total amount of memory per-cgroup is overcommited.
-    Overcommiting kernel memory limits is definitely not recommended, since the
+    deployments where the total amount of memory per-cgroup is overcommitted.
+    Overcommitting kernel memory limits is definitely not recommended, since the
     box can still run out of non-reclaimable memory.
     In this case, the admin could set up K so that the sum of all groups is
     never greater than the total memory, and freely set U at the cost of his
--
2.26.2

