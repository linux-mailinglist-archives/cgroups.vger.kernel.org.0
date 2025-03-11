Return-Path: <cgroups+bounces-6972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C7A5C175
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D292C3AA411
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D725BAD4;
	Tue, 11 Mar 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gj6+wHTo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B425B674
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696631; cv=none; b=WV8mOM9bCQp4xzZUQXE5ZsnZZtmjDtEeua1xdrXd6qZcOJ1J6UJS1wa6iMS+KJ7mc/TLOD+57FO6aXOSeyd9H/On+gd+FD9s93OY8NBhjqafLUQKH1Nh3XpYPszk7kuk0brAkiTVj5COfe5TN7U4+5ozgdUYJvdkcW/IrpUCyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696631; c=relaxed/simple;
	bh=eOYfV3hkQJ4COrJVGB6V6NB92ZYbl7TFTpc5f+sHq+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFvAaBQ1rrFVrUwxPqjvFYSDgWK2VL0mxuSWPk6pDTRGbRCmlLk7mY8VjycNVFZbt9j7j+Gf9imQtdF9qhkv7lFOT1/QJateB1yaB03V2ZGl+2ptxq6FQhS10UMKVphOWeZGaTqEyiMeHawi2IDl1Qw3maZnI11wlUrSHNnSZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gj6+wHTo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso14792305e9.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696627; x=1742301427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXKXrFA2VlkBneAZZTTJT0fgxthnXkiDyglv3h81Of0=;
        b=Gj6+wHTolGFeAgq22JiafPqm8VHBHP0h/rnlt1cfsS+rrHR0pO6waVKh7/+5iZh3Qx
         qphA3U9dDmz+ZLsJc7gR46WS4WOoqTCuJu5nYw6OVlbHxZWMkVIAcD1OEVhdQZnaKYmf
         HGVOUqLmmM34MGVI0ziF4AZOZwLshw0t3B2SJLyWrFx/d75zL3HRtNx0ZA0xDzn9UvPa
         gcUEl2MDR6Tccapij03aYYIktHjH2hA+TNV7LR0HTDaQtb5WuPiwveoOXxQT4ySGBW6R
         fgM7u7kVfMzSWo6QPHImJxQ3UnzZ/AqQHhp3eepAYj0dNJTy1lwgpidVvOpCBLF3hYgn
         +MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696627; x=1742301427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXKXrFA2VlkBneAZZTTJT0fgxthnXkiDyglv3h81Of0=;
        b=wT1Y8pZ68CD7vq1lNFxI4oVDwJAMebQtKE/Re94kB2H2fYQeV613YqyM4hz5ranc08
         BSc1jMmxIoYz2oE9JcdON31jSrl1AlFzKnDOb6DVWKknj4TH9o2484rXolVul7IKE2jk
         48kp+8BrJpyJ4ekm3mgPyrFn8knFvBHSqXCZpI9WHd23Xv0C2Z4AHE9b3tSdvJ64fZ11
         j+nOUIRtAozK32duAevvZWFEmfgwM695eNuzLkTd1JWpjasGT3LvJUDtdUqwZ7KisF4p
         sD7XzeslmcR7u8y6eAjIpziFrBpMn0BVSjwGvEn6iuiGwwqUtOnc1+0ucHnmXbS6oDsN
         7BEw==
X-Gm-Message-State: AOJu0YzDjSzMhi1SggdzJR1OsPjTMu9N+LdjwkL8t9MQO4xpLDIPXghG
	W8b39TgnINmnQlkfh6VM4AF0apKtszWfBjoeYHK9XOIFVazHrIJ0StdgXnRQTgEICCZ7bb8kXUk
	OQUg=
X-Gm-Gg: ASbGncu8sUF5OQm/SJJAWO5hyv5n5y4p+BE+KqyzGH9qkbDCoV+O9KQ5ld2DTOnMlmg
	LuetyzXg1mJhvErh1QSRAexBdIula0m6Vp+E6kl1DueYw9MiOWWpgJF1ZGb3JDq0SoBeVVntH0J
	+uqGH2550Pd7lnNhknOV7krDyRBys1wWrTC62VU9L7Jx1wGXtrUeONdBvZm6LM/ndadhf5hGVTx
	TM/rFymnn4r+pxrP14aEym18tl9yG/3wBblask1VrbEnYJ1maO4xql3MtGasVXR1pqogvBZZRy2
	SLjtRXNq2+mjMhWatELF7HFPY+UjxK3akaAU+yLMg1+HBq0=
X-Google-Smtp-Source: AGHT+IGxtVT4Mv/MwWFfw1GFVyifXbknAcM7hLfQYB/ggvVos7rNOTA6kXKjciYRQIAM+TQeTmsWVw==
X-Received: by 2002:a05:600c:46cf:b0:43c:e8ca:5140 with SMTP id 5b1f17b1804b1-43ce8ca528dmr93497435e9.23.1741696627217;
        Tue, 11 Mar 2025 05:37:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:07 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 11/11] blk-cgroup: Simplify policy files registration
Date: Tue, 11 Mar 2025 13:36:28 +0100
Message-ID: <20250311123640.530377-12-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
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
index 1464c968eeb0c..1994a11ff9034 100644
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


