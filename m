Return-Path: <cgroups+bounces-15353-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M84YJMVW42l4FQEAu9opvQ
	(envelope-from <cgroups+bounces-15353-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 12:02:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8B4209EC
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 12:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78431302B3B7
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981B313522;
	Sat, 18 Apr 2026 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EkS+icW0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102D134CF
	for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776506561; cv=none; b=BGAouMdYLg/q0EKR8ZTNeaiPc453sZI1d4D+ZrWVFawwPrEgOtPl1ScG/3ZTwZv7scu7jt+LpRuJWhp2zi2E6O1Oy3Jx3UAfDp4mupTFHP9sp3xmBzbPNSZVAbPyrO1QTcqOOaeoFtU2iHgR5CbzS9edXBO3Fv8B0WZdknB5+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776506561; c=relaxed/simple;
	bh=ZYzUnEiKq9S+vGGS0++5U+7rfjGOkutHI7PMS8wqIpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1292LtuwX2nicO8BDAu4hhhjvbe8QhOAcDpyrZxg/J7K8RcO9xZVkkgjjM72fyJ3k6YY8C3eZAsGkDN89mPifSofSmEYNb6peM5cPfdDZWJOq5qf6H4oEArEZCshaFeWhCNxWbPXfDqP0HRmQTnmjg9zDmGR9Qs9FC/QyYeig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EkS+icW0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so1506474a91.1
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776506559; x=1777111359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZnSL+paj3Qwpah58bb/0dGs7eb4dbR7OOIO5FaRgaw=;
        b=EkS+icW0BHdCrYViYfbI/kfPpDoXNWQKofcST78lti/opuOC2RZfpJesX4fmsniMeT
         uHQo0Waj35fGJMzMvHfJnzCXBX61aOrZMUa0EXWJvNHkaKwydmrnI7RBnEaFFqNLyKIS
         t2IOUefs21WzUUR2zkQe7PRp7sBpGhqE33FDvDdU88xS6cpzrssP6RpKiKFR6sNHZFM/
         F69RroImgKDWQCP92ywkDN32Q2vVh9mgCKjpBOF7B46vsVpew6U8av9RUK6BCfX8vZLB
         Ldg72qcfL6WD9oFde4kOdlM3POV0VyukjzjUfnONqCFZzfjZZ0lHHqaHRDBbo8pNteMa
         MVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776506559; x=1777111359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZnSL+paj3Qwpah58bb/0dGs7eb4dbR7OOIO5FaRgaw=;
        b=lt8jZ4cx6Us6gVYA64BlcK95z57uzBRsil5z9e6Jdfx+HLgk1x3aDR8OxKQrzjwohB
         pqDFDTmVuNUyImZkgGryuT8JZ9mrGNp15fexxCXXb5QwkteIH4mLWKDl2RvMBHb6OfJ9
         PpQx8GUaXOoliv7WHp9U2PT7+R0pueoWrykKHB0MiOfZzhJEIufa01MPe3jFs0Eej58X
         TZxjcPGdtH1RweSblMX+QNAaOxcXo+/fBg1aLbqd9QE/7F7xZvqwGZOMa4UFAhGwoKpc
         LjFoMKP4zp/X6fMJ8P/UE7ZPTcBE4oN+vIbQtVU9eu4+8jhF9W4Y5LcKk0Dc/A/EMjTJ
         MuZg==
X-Gm-Message-State: AOJu0Ywk2oAW0pH8tvX0xaFDvqKN/3PBqeBirRneHAbghd9JOQJP21Cc
	iA0kDj51EOouCQ6jov0AJOyv8kzt/UNMpn6Ub85uhdxayUDrPhw1vCFZWxFCm9gBdPAaxplg3ME
	M1Vpd
X-Gm-Gg: AeBDieu3aNoh2Ba9dAGiHmZPiB/U2sAVVCF8sB3wXeklRVeXVmsQwQtLDx1gLguHBb4
	rgkixyw4nsTVnlXmHaVO/R7oMGQso6J/WNxD0iy6XEaTnf9MkkJujiz+NV0ic2Fs2LKtjYohm7O
	mWV31IL+7K5O0e+BcMb/vnIpQTticWE79KaTI35thVJFQ7Wirp1BCr6YqBhcvJ1FIB/dlKrkTnf
	Zw2ngQCrZVje6xmpVO64WGpE7Z6vuTjdm1Fb1CQus1KNLBRCCsXz5HnUYHEld88+jOtuScLyst2
	kBrnSlWAdIRgy60nhfWzv7UOBp7azNrmMsD4ZIinNuQCsvWK98khyIky/B4xZmGIsA7NhhOZ6u0
	Pg0gdc9IF2YzDvu7bFztFnvrgfTv5Xxz+aO1oLfUDYajq4f+X5lVJu4e57rTdD/BQy6tT7V6+SW
	6DHfX75mqaQnPn6A==
X-Received: by 2002:a17:90b:3d86:b0:35d:a90d:580e with SMTP id 98e67ed59e1d1-36140490bedmr6618135a91.23.1776506558459;
        Sat, 18 Apr 2026 03:02:38 -0700 (PDT)
Received: from localhost ([240e:b1:e401:3::95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm3319010a12.16.2026.04.18.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 03:02:38 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org
Cc: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Subject: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems writes
Date: Sat, 18 Apr 2026 18:02:20 +0800
Message-Id: <20260418100220.3717207-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15353-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sunjunchao@bytedance.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1E8B4209EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpuset_top_mutex serializes regular cpuset writes against the
housekeeping_update() path. That path has to drop cpus_read_lock() and
cpuset_mutex before calling housekeeping_update(), while keeping the
housekeeping cpumask update ordered against other cpuset writes.

cpuset_write_resmask() currently takes cpuset_top_mutex for all
resource-mask writes. This is broader than needed for cpuset.mems. The
mems path updates nodemasks, task mems_allowed and mempolicy state, and
may queue page migration work, but it does not change isolated CPUs,
scheduler domains or housekeeping cpumasks.

Add cpuset_mems_lock()/cpuset_mems_unlock() for FILE_MEMLIST. The new
lock helper still takes cpus_read_lock() and cpuset_mutex because
update_nodemask() can reach check_insane_mems_config(), which calls
static_branch_enable_cpuslocked(). CPU mask writes keep using
cpuset_full_lock().

Record update_housekeeping and force_sd_rebuild on entry and warn if
FILE_MEMLIST changes either value. If that warning ever fires, the mems
path has gained a sched-domain or housekeeping side effect and must stop
using the lighter lock path.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..5e0927ea71a9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -331,6 +331,28 @@ void cpuset_full_unlock(void)
 	mutex_unlock(&cpuset_top_mutex);
 }
 
+/*
+ * cpuset.mems writes cannot change isolated CPUs or sched domains. Skip
+ * cpuset_top_mutex, but verify that the path leaves finalizer state unchanged.
+ */
+static void cpuset_mems_lock(bool *hk_update, bool *sd_rebuild)
+{
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+
+	*hk_update = update_housekeeping;
+	*sd_rebuild = force_sd_rebuild;
+}
+
+static void cpuset_mems_unlock(bool hk_update, bool sd_rebuild)
+{
+	WARN_ON_ONCE(update_housekeeping != hk_update);
+	WARN_ON_ONCE(force_sd_rebuild != sd_rebuild);
+
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+}
+
 #ifdef CONFIG_LOCKDEP
 bool lockdep_is_cpuset_held(void)
 {
@@ -3209,6 +3231,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 {
 	struct cpuset *cs = css_cs(of_css(of));
 	struct cpuset *trialcs;
+	cpuset_filetype_t type = of_cft(of)->private;
+	bool mems = type == FILE_MEMLIST;
+	bool hk_update = false;
+	bool sd_rebuild = false;
 	int retval = -ENODEV;
 
 	/* root is read-only */
@@ -3216,7 +3242,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		return -EACCES;
 
 	buf = strstrip(buf);
-	cpuset_full_lock();
+	if (mems)
+		cpuset_mems_lock(&hk_update, &sd_rebuild);
+	else
+		cpuset_full_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -3226,7 +3255,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		goto out_unlock;
 	}
 
-	switch (of_cft(of)->private) {
+	switch (type) {
 	case FILE_CPULIST:
 		retval = update_cpumask(cs, trialcs, buf);
 		break;
@@ -3243,9 +3272,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	cpuset_update_sd_hk_unlock();
-	if (of_cft(of)->private == FILE_MEMLIST)
+	if (mems) {
+		cpuset_mems_unlock(hk_update, sd_rebuild);
 		schedule_flush_migrate_mm();
+	} else {
+		cpuset_update_sd_hk_unlock();
+	}
 	return retval ?: nbytes;
 }
 
-- 
2.39.5


