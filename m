Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133B7ACF53
	for <lists+cgroups@lfdr.de>; Sun,  8 Sep 2019 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfIHOjK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Sep 2019 10:39:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35050 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfIHOjK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Sep 2019 10:39:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so8533048lfl.2;
        Sun, 08 Sep 2019 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmmHtAJUP2a/sLNIvsEgkXzhFS+gIz57sAKIuY6RAn8=;
        b=lBDsvcqqCALrs7Asc/HmKgFWFmwGNUKXuO1TAhKJ5Csl+ugUwRosyWCH334U7DF+ZF
         dcoLrwnMGGWEpFSOiyHsNBBRLoSjg97E2KnqWfDOV4ZIavS1O0CNzvZFJhRlUU6deFCS
         rMCFjQV/LyfaP0/59T1/0LlgAivaQpSrPCCk5LAJvkt7WHPFkVo6eS4szqHZNAQrGvxK
         LHXyEbIFlqq+lVSU6OZ6pJC8prWZ8mk0H+7gtoYydJpgt6dNrc+PdesE+N0mUu65ogSu
         vkkkXx3SIF2SWg+LALK7c/dINDV5wP70vX9NWMxYhgM9MdGv4vaJlLDWtFKjKYbWFxLp
         Q6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmmHtAJUP2a/sLNIvsEgkXzhFS+gIz57sAKIuY6RAn8=;
        b=AESS/ByH986uYrOHabsob0Pp6LJLKvj92cCCxZnhoIbspcvkSRfijR8vwcrWWcmn0K
         TJCmHPs9F+LSvLLrDlYmIXc9aO5mWSgL5qVCSS3PN3IFJO4qPd973Pnp/AVU69uKYRaY
         epFqXM48UrsLf3++SPDHDky25wSwisDXfley5XMHY5V/1zawflOd2cGYbWwboLK6YHCY
         KNU99z3zBOI2Fqc8UsSSF4tDdVDrX9tCWKZrTk5G875IOEBUUUnQQc+Y/g8rudfWVsZr
         ixgBxV+8Dj5XFEgTvhaS21GPw+Pi42jw8TXr1ebtLnXn0Jy7KF4fWx9ujhMYYg+WdQJZ
         ryxA==
X-Gm-Message-State: APjAAAX4pKP15RS8xhmtApSHWDuMaJzf07ybO4q73DxZPloHMSXQQSpt
        AhuBnZ4yDwxx4dyNBAYUSVo=
X-Google-Smtp-Source: APXvYqxcbaQS8WynGpl53n+pakgNA0lHVLZrKm5k4Gn6oLQe8fn3KHnNy1mTo5IscKem22QUoBsyRg==
X-Received: by 2002:a19:5f55:: with SMTP id a21mr13732991lfj.56.1567953547645;
        Sun, 08 Sep 2019 07:39:07 -0700 (PDT)
Received: from alpha (ppp78-37-236-177.pppoe.avangarddsl.ru. [78.37.236.177])
        by smtp.gmail.com with ESMTPSA id p12sm2007088ljn.15.2019.09.08.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 07:39:06 -0700 (PDT)
Received: (nullmailer pid 19711 invoked by uid 1000);
        Sun, 08 Sep 2019 14:40:43 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] cgroup: use kv(malloc|free) instead of pidlist_(allocate|free)
Date:   Sun,  8 Sep 2019 17:40:41 +0300
Message-Id: <20190908144041.19667-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Resolve TODO:
> The following two functions "fix" the issue where there are more pids
> than kmalloc will give memory for; in such cases, we use vmalloc/vfree.
> TODO: replace with a kernel-wide solution to this problem

kv(malloc|free) is appropriate replacement for pidlist_(allocate|free).

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 kernel/cgroup/cgroup-v1.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 88006be40ea3..1f25f35af2c4 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -193,25 +193,6 @@ struct cgroup_pidlist {
 	struct delayed_work destroy_dwork;
 };
 
-/*
- * The following two functions "fix" the issue where there are more pids
- * than kmalloc will give memory for; in such cases, we use vmalloc/vfree.
- * TODO: replace with a kernel-wide solution to this problem
- */
-#define PIDLIST_TOO_LARGE(c) ((c) * sizeof(pid_t) > (PAGE_SIZE * 2))
-static void *pidlist_allocate(int count)
-{
-	if (PIDLIST_TOO_LARGE(count))
-		return vmalloc(array_size(count, sizeof(pid_t)));
-	else
-		return kmalloc_array(count, sizeof(pid_t), GFP_KERNEL);
-}
-
-static void pidlist_free(void *p)
-{
-	kvfree(p);
-}
-
 /*
  * Used to destroy all pidlists lingering waiting for destroy timer.  None
  * should be left afterwards.
@@ -244,7 +225,7 @@ static void cgroup_pidlist_destroy_work_fn(struct work_struct *work)
 	 */
 	if (!delayed_work_pending(dwork)) {
 		list_del(&l->links);
-		pidlist_free(l->list);
+		kvfree(l->list);
 		put_pid_ns(l->key.ns);
 		tofree = l;
 	}
@@ -365,7 +346,7 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	 * show up until sometime later on.
 	 */
 	length = cgroup_task_count(cgrp);
-	array = pidlist_allocate(length);
+	array = kvmalloc(array_size(length, sizeof(pid_t)), GFP_KERNEL);
 	if (!array)
 		return -ENOMEM;
 	/* now, populate the array */
@@ -390,12 +371,12 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
-		pidlist_free(array);
+		kvfree(array);
 		return -ENOMEM;
 	}
 
 	/* store array, freeing old if necessary */
-	pidlist_free(l->list);
+	kvfree(l->list);
 	l->list = array;
 	l->length = length;
 	*lp = l;
-- 
2.21.0

