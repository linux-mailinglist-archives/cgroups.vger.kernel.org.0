Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3D4F8E06
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiDHE75 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Apr 2022 00:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiDHE7x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Apr 2022 00:59:53 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A047AEE
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 21:57:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id o11-20020a62cd0b000000b0050564575a89so2664545pfg.14
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RpFXlKvwb4pUJyIrx0BwPq/Sz7TwgzSMaU3KXpjsnFg=;
        b=PZfwTndHaHFeiId6kJJWIk58eh5ykRjdyumVYKw/V0Oluj34d7Lv6G9QfbAO6MG68X
         5Cp8uWVnKwShcF0BFnxZHLWp6ZB5aWPOXG/Oix4YaoRQJT/TamzL0Z+Q0C1feePcwpoK
         FENgXFWEzQHHDlbUa6+OWFMfZy/Zs5THpeXzBDDUoSOpdHazwli+xVssStSpQX6dXP87
         +gEZWfq2i6qSv+b+zRxuTxamA08CMwUpQtHbpqJp/ibE+JIapaGcj0/Y8FuPUv9ANtvB
         K64P3pZuES8BJSknRtTorjKzVC0kiVkym17TcMpzn9ih6gm1W5AFO0y+l2ijh3LMEALt
         vIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RpFXlKvwb4pUJyIrx0BwPq/Sz7TwgzSMaU3KXpjsnFg=;
        b=eeOToL8P5MukAG5DQRUD/jPLV+sIkFPkdP7GqHzxOPvAWM63fWwqgdTqb8Oq65m/x0
         1PllVm5x5Qac84oZTj00rjzcnS9voRFSMPVxzY+aLM71NdY0CG0wx2MMwdCkKfp9xCqZ
         Wu43m/5BBUr6Jts5tDSIoajVkvLRrUF4xhbk6x7x1O4FMEICPFj0aqud6xjZETbEN+Eu
         73ufMianalBCWc5tcZDS2gxmFAYFQ1AtknNivvkCEtYMz2wqBj/UU+KyLU1Kz7+DdEfT
         SOMAkr3jY0seBh3y5Gqbbhh5cI2pYqFHcjGO20l0x03uOZvY5HGzSZ3vSD8JFdsHsTJD
         lO2g==
X-Gm-Message-State: AOAM532tHi3esVebss7GVHW0qEFwx5hiyz4tnT0SbBtf3JZF/FnQxsej
        WzOeM254EadjETCIWJ6OPX1PuxbkJqQy7WLS
X-Google-Smtp-Source: ABdhPJw5mVvKa75yNWq8X1toeYD179Hk+kkkpDn6jYwbzqwx+XJ9Se+9zdydnBR6hBfnjvMnIUQQ2/3DjI+R68dT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:ecd1:b0:154:5393:aa7e with SMTP
 id a17-20020a170902ecd100b001545393aa7emr17225851plh.79.1649393868836; Thu,
 07 Apr 2022 21:57:48 -0700 (PDT)
Date:   Fri,  8 Apr 2022 04:57:41 +0000
In-Reply-To: <20220408045743.1432968-1-yosryahmed@google.com>
Message-Id: <20220408045743.1432968-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220408045743.1432968-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3 2/4] selftests: cgroup: return the errno of write() in
 cg_write() on failure
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, cg_write() returns 0 on success and -1 on failure. Modify it
to return the errno of write() syscall when write() fails.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 32 +++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index dbaa7aabbb4a..3b6bb09985fa 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -38,23 +38,23 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
 	return len;
 }
 
-static ssize_t write_text(const char *path, char *buf, ssize_t len)
+/*
+ * Returns:
+ *	success -> 0
+ *	open() failure -> -1
+ *	write() failure -> errno
+ */
+static int write_text(const char *path, char *buf, ssize_t len)
 {
-	int fd;
+	int fd, ret;
 
 	fd = open(path, O_WRONLY | O_APPEND);
 	if (fd < 0)
 		return fd;
 
-	len = write(fd, buf, len);
-	if (len < 0) {
-		close(fd);
-		return len;
-	}
-
+	ret = write(fd, buf, len) < 0 ? errno : 0;
 	close(fd);
-
-	return len;
+	return ret;
 }
 
 char *cg_name(const char *root, const char *name)
@@ -177,17 +177,19 @@ long cg_read_lc(const char *cgroup, const char *control)
 	return cnt;
 }
 
+/*
+ * Returns:
+ *	success -> 0
+ *	open() failure -> -1
+ *	write() failure -> errno
+ */
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
 	ssize_t len = strlen(buf);
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
-
-	if (write_text(path, buf, len) == len)
-		return 0;
-
-	return -1;
+	return write_text(path, buf, len);
 }
 
 int cg_find_unified_root(char *root, size_t len)
-- 
2.35.1.1178.g4f1659d476-goog

