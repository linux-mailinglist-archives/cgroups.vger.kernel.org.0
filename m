Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBB4A31ED
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353163AbiA2Uxw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jan 2022 15:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353165AbiA2Uxw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jan 2022 15:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643489631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX58UmfyCZKrrdzehrq1UxMQowz9BiWVJRz/V9rRqyY=;
        b=OTyzXJq5aw/I+PxhklijLlH465QQaxedwncC5Fov+hB2t8PT3rnjo4vJD7FIeo40LUSnwa
        NxAEgr4b01WtG+6hpRIBfvYat2dvLGie2UmAMojR3WJLcVGok006bbf+jIUpuGFrVFm9sl
        i3BefYgqimNa5hVcOFNZJU+s7O3qx1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-h1czgUQNPdOvrroX67Un8A-1; Sat, 29 Jan 2022 15:53:48 -0500
X-MC-Unique: h1czgUQNPdOvrroX67Un8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0772983DD21;
        Sat, 29 Jan 2022 20:53:46 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05BDA5DF2E;
        Sat, 29 Jan 2022 20:53:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Date:   Sat, 29 Jan 2022 15:53:13 -0500
Message-Id: <20220129205315.478628-2-longman@redhat.com>
In-Reply-To: <20220129205315.478628-1-longman@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For *scnprintf(), vsnprintf() is always called even if the input size is
0. That is a waste of time, so just return 0 in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/vsprintf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..a65df546fb06 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
 	int i;
 
+	if (!size)
+		return 0;
+
 	i = vsnprintf(buf, size, fmt, args);
 
 	if (likely(i < size))
 		return i;
-	if (size != 0)
-		return size - 1;
-	return 0;
+
+	return size - 1;
 }
 EXPORT_SYMBOL(vscnprintf);
 
-- 
2.27.0

