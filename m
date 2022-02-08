Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114754ACD75
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 02:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbiBHBG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 20:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbiBHAGI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 19:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5786AC061355
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644278767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpG/a8UGSgxQkJKVhwJeqMQ36JzcPE9kOn8DL2mEYFQ=;
        b=eDKUE59FpC1+5QgRtpO6EV2jYS5iR5EYxSM7ImFOv12Ba4p/iuJRPvtUHQPjzjTJpkNTpx
        iWzaBlk7hDfbcF3UdsYsuGtX14bJzk4OKHIJKmxSYPRieLXnHarS/7emoVeWACXGPAtu8h
        FYaq4YLFdfMxTMe6WpHlPOgLIuJoKzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-NqDoYO8jPY-zlN6dzI7rmQ-1; Mon, 07 Feb 2022 19:06:02 -0500
X-MC-Unique: NqDoYO8jPY-zlN6dzI7rmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADEFD18397A7;
        Tue,  8 Feb 2022 00:05:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0498B5C2EF;
        Tue,  8 Feb 2022 00:05:57 +0000 (UTC)
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
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v5 1/4] lib/vsprintf: Avoid redundant work with 0 size
Date:   Mon,  7 Feb 2022 19:05:29 -0500
Message-Id: <20220208000532.1054311-2-longman@redhat.com>
In-Reply-To: <20220208000532.1054311-1-longman@redhat.com>
References: <20220208000532.1054311-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For *scnprintf(), vsnprintf() is always called even if the input size is
0. That is a waste of time, so just return 0 in this case.

Note that vsnprintf() will never return -1 to indicate an error. So
skipping the call to vsnprintf() when size is 0 will have no functional
impact at all.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 lib/vsprintf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..d419154b47bb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
 	int i;
 
+	if (unlikely(!size))
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

