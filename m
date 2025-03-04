Return-Path: <cgroups+bounces-6823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7291A4E510
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A769519C4B88
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24E2BE7CB;
	Tue,  4 Mar 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ReG+dyPC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A942BE7A3
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102749; cv=none; b=JztMNdO0ClSvxUkMMd0vXfHWwf8mG5hJifpZ8ss1uPsNTaB+THoXzqtz/boZwJONcJ55yCMQjpm93pDw5lkRSOP18/XFzaIQ3HgL9S7GzA7MojxPCIv1RZv8h2VdMheYpKM6wHUZTmNtWuPPXKWVZ+9kyuJBjQH6GYZ8BwFWd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102749; c=relaxed/simple;
	bh=LvkOijoEyLqDMsqQX+Kl7wQP+Lfreox2ddu/WO8YtBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2moHYFBr3xlMwX0YgYBNY/7zNWNAt9fIXuQSTOtrhMvgNZKHDRem25PdZhazYlVwZW50YK10wypMXjmN2NZ9kuok3ddXwxT2AQvEi69NZf+AjktNvcG9Q7SzhTpOk6xaIMRk27wTV1oK5H2JxSULcKs66UZZKI6p2HXGlAHm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ReG+dyPC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcc02ca41so7993985e9.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102745; x=1741707545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkXOSC9ROskp3x3ku4mQvAAKFjUVG2MCmIDW0NJqpNc=;
        b=ReG+dyPCRDFzyYsj4zAYWz+OKEE+rGOqNz3/dsxcIS6XEcShSVkTOBrrbwHt7layU1
         q17uB35yxIqgEEh4Uaa/dDkymiADB3WLoC0pnAt6Iwr+pmCS/Bkcl7yiDnuPs9E1yjb5
         SXZdxDMirB3pe52gx2v8nfSuWl2Yq1T4XtaBXmHBZ2+TjCkwGbPn3wQe3nQYG6NrFT9I
         WdmTKAY058SuNpiA3IMy/wg3MYne/Pll5dQ2t4RclcRQHwHLhMI5NUnJOBtziqWaq2Nn
         2kdHJzoN/WidBmWxXxgReZFzcvWtWXErsTqmFYkdvUtxtyJ/Zkydf1TZ9KGLRlk7N35I
         omBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102745; x=1741707545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkXOSC9ROskp3x3ku4mQvAAKFjUVG2MCmIDW0NJqpNc=;
        b=k3rXLKxFcdgW/VLbwk9Kbs1rpx4gPkoPzUzJmnGQokmbomjI+fCS4slBJa3h95iEND
         eo38cnz+4itlcFtF4oMbCbhd+7acKHSbdX6MN2L/Ysw5JMcibmVDpD9g9oI0TN4XRt1I
         8MVGa7q43No4sjO+Ez8hX9p/hF3/mjxnfIQZaGalOO9Tbc6geKjLvpP6kMW2nkLdSyGU
         NntJC2TlQJ8o3e0pzXb1XjewRIEkTnAeLaSfaJKXqKrCGy8LOqr2FxuX6UZO7nsRS2Oy
         UYghGFQPhMjPH5MUfdpkCKo4PpMRBxHNlK9ybmdb3FpdH/xId0/C8gzAlm8BFg05NRvi
         tifA==
X-Gm-Message-State: AOJu0Yw4N0nBLPdaRd8YW+9wkYTi35S5J7l6bM4BtW98m507tOHrdBJC
	tp8QXvQ2ZNrU5S84U2a2wNksnjoYlWKxzv30AYmjW+5Qi6ZCgsQNx5GuzEgOUl1uqfk3PupCNS5
	bUwE=
X-Gm-Gg: ASbGncu0DQ1ia78XW79hWTH0B5WyFpl5r7rHdFd9bQtbXd+DDi3NdQJzxDYqKgHnQOc
	e8BZo1OObGfOLT31ffO/ktqwJeTikdAnH6UCmByfvKg4dF4di1sFxE+bdtfK6IRrYHBxtmL+Xie
	aqG6rzPd7qCW8xn92fi2EHaQXe7h8Amdjmn6czdci6YemZIvol7upQ8JzBELWFiRqPLxQchR0kX
	4ITMJLvsvZHnHdbIHtSPrwvSv7Qmh+1r5YdoW3hCDzCT/RXkDDrX8r/EgKF7Z106B9hONPLHZ0+
	Lp6z30VBdY+jOizd0CsDqPLF6SBOVffMHUS+ozx0aGUCGI8=
X-Google-Smtp-Source: AGHT+IFd0Y1kfVUDwA+rIlXltUNEpd+BRYNRN/rGxGNdGzkzrMQ0wTVhTLyq8Q5ZNmhBP5e9sRDWeQ==
X-Received: by 2002:a05:600c:44d6:b0:43b:c0fa:f9c9 with SMTP id 5b1f17b1804b1-43bc0fb002cmr75491345e9.7.1741102745403;
        Tue, 04 Mar 2025 07:39:05 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:05 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 9/9] blk-cgroup: Simplify policy files registration
Date: Tue,  4 Mar 2025 16:38:01 +0100
Message-ID: <20250304153801.597907-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use one set of files when there is no difference between default and
legacy files, similar to regular subsys files registration. No
functional change.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c     |  7 +++++--
 block/blk-ioprio.c     | 23 +++++++----------------
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c |  2 +-
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b77219dd8b061..db6adc8a7ff41 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1771,12 +1771,15 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	mutex_unlock(&blkcg_pol_mutex);
 
 	/* everything is in place, add intf files for the new policy */
-	if (pol->dfl_cftypes)
+	if (pol->dfl_cftypes == pol->legacy_cftypes) {
+		WARN_ON(cgroup_add_cftypes(&io_cgrp_subsys,
+					   pol->dfl_cftypes));
+	} else {
 		WARN_ON(cgroup_add_dfl_cftypes(&io_cgrp_subsys,
 					       pol->dfl_cftypes));
-	if (pol->legacy_cftypes)
 		WARN_ON(cgroup_add_legacy_cftypes(&io_cgrp_subsys,
 						  pol->legacy_cftypes));
+	}
 	mutex_unlock(&blkcg_pol_register_mutex);
 	return 0;
 
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fff7ccc0ac73..13659dc15c3ff 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -113,27 +113,18 @@ static void ioprio_free_cpd(struct blkcg_policy_data *cpd)
 	kfree(blkcg);
 }
 
-#define IOPRIO_ATTRS						\
-	{							\
-		.name		= "prio.class",			\
-		.seq_show	= ioprio_show_prio_policy,	\
-		.write		= ioprio_set_prio_policy,	\
-	},							\
-	{ } /* sentinel */
-
-/* cgroup v2 attributes */
 static struct cftype ioprio_files[] = {
-	IOPRIO_ATTRS
-};
-
-/* cgroup v1 attributes */
-static struct cftype ioprio_legacy_files[] = {
-	IOPRIO_ATTRS
+	{
+		.name		= "prio.class",
+		.seq_show	= ioprio_show_prio_policy,
+		.write		= ioprio_set_prio_policy,
+	},
+	{ } /* sentinel */
 };
 
 static struct blkcg_policy ioprio_policy = {
 	.dfl_cftypes	= ioprio_files,
-	.legacy_cftypes = ioprio_legacy_files,
+	.legacy_cftypes = ioprio_files,
 
 	.cpd_alloc_fn	= ioprio_alloc_cpd,
 	.cpd_free_fn	= ioprio_free_cpd,
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634d..8e7415c64ed1d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -113,6 +113,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
+int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3a5af0fc544a6..e93b0563a8964 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4447,7 +4447,7 @@ int cgroup_rm_cftypes(struct cftype *cfts)
  * function currently returns 0 as long as @cfts registration is successful
  * even if some file creation attempts on existing cgroups fail.
  */
-static int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
+int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 {
 	int ret;
 
-- 
2.48.1


