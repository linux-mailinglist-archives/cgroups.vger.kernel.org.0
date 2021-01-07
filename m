Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD002ED17C
	for <lists+cgroups@lfdr.de>; Thu,  7 Jan 2021 15:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbhAGOMX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jan 2021 09:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbhAGOMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jan 2021 09:12:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39AFC0612F4;
        Thu,  7 Jan 2021 06:11:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so3080170pgm.5;
        Thu, 07 Jan 2021 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+/yW7D6tgLkfN73HRcn97T4dV2Qj+zmTeZIf737PxQ=;
        b=Qgbt7mCZ/t2lHcdTBmIgFYZN4t4oWy0AeqUjnjy23hkhVF+p9+Gat10t3UuhooBE5z
         h73ZrSzcfENRWBuNBlC7OjGJOVC/5EoHwlT4efFOqV3UgGokjW3iJ7UnE4XjBZ70c+A0
         yRyhNpfEKSyxLBE+3FfcCMq50v1v7xlWifXb1iuchM40Glv70zSixRf6fRT2i3xpw8y6
         0wlXYCXfFUEuSWargxi9VqLhPKp8164+CIVWaPzRcZSjUlhnI3nI+ClgJPL/tB3fu2dF
         EH6oGATMR84Yg7iXW9xR1kudfkcAivYbOm5/hOdfHHcxxoYrhx3xVafQdS3HVF54tC9p
         6jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+/yW7D6tgLkfN73HRcn97T4dV2Qj+zmTeZIf737PxQ=;
        b=lQNG4rzyExCEqaSvWM1HFJZDron5BWdIF9edXQIY92f0T3E6yjUg4WGhxKgSkBrDom
         7tedFLw6JLYTwd5HPw8G+36w9JeddZ8n+j6nl5QfUxZjqTQYtryTzTcWojtFrVI336h9
         3OE4PZZb2DCB8VTAJmUucfsUXhYyuVA+xpuJTDhBMZ+aalgkSycXAJrmirrNmSEbpzhT
         mEI1Z3vGoq31WEd1jDHLMy4iqq8m6PDyoaUuHg4IjBGnTgdfTR+EAFpQcO9+1phs0rmI
         9BRyQhmjWcHMZoP6TZgvM3Y5z9iz5Axese/uFKO9Weoryki4dtSO4WyQ7hX2lZlj2efB
         lGZQ==
X-Gm-Message-State: AOAM531zL6J5yiKNzzP1IupJcJVKx3RfHkQ04F3PMuYy/KV6sZ19m72F
        upbLix09veuu8kPt1mk9Ogc=
X-Google-Smtp-Source: ABdhPJxCLlJNDCcKBg8oPw4WOYrexH5xZzBFchkKHbH8r5c526FZG0yMXTWOtJPqk3a1aorfCpI1fQ==
X-Received: by 2002:a63:cf56:: with SMTP id b22mr2056725pgj.16.1610028699523;
        Thu, 07 Jan 2021 06:11:39 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.53])
        by smtp.gmail.com with ESMTPSA id g16sm5857947pfh.187.2021.01.07.06.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:11:39 -0800 (PST)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     tj@kernel.org, lizefan@huawei.com, corbet@lwn.net,
        hannes@cmpxchg.org
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] Documentation: Fix typos found in cgroup-v2.rst
Date:   Thu,  7 Jan 2021 22:11:18 +0800
Message-Id: <20210107141118.9530-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

Fix typos found in Documentation/admin-guide/cgroup-v2.rst.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 63521cd36ce5..e0f6ff7cfa93 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1558,7 +1558,7 @@ IO Interface Files
 	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252 dbytes=50331648 dios=3021
 
   io.cost.qos
-	A read-write nested-keyed file with exists only on the root
+	A read-write nested-keyed file which exists only on the root
 	cgroup.
 
 	This file configures the Quality of Service of the IO cost
@@ -1613,7 +1613,7 @@ IO Interface Files
 	automatic mode can be restored by setting "ctrl" to "auto".
 
   io.cost.model
-	A read-write nested-keyed file with exists only on the root
+	A read-write nested-keyed file which exists only on the root
 	cgroup.
 
 	This file configures the cost model of the IO cost model based
-- 
2.21.0

