Return-Path: <cgroups+bounces-15596-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BKqDhs/+WkZ7QIAu9opvQ
	(envelope-from <cgroups+bounces-15596-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CD4C58EA
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438D03024C81
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3121314A9E;
	Tue,  5 May 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgVePif4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76267311942;
	Tue,  5 May 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942283; cv=none; b=FwDdTQqTiOZVovxPH6NwpDgdW/367BU1rzgwlGrCx58T9IluPfpMRMHL59WbZWfS5EKEwWpFRohHZnIALuZjyiapIakkzgO236kPvdMPHFJExQDhNbyzDelJDxnPA8ScKEst91oSTrAKhhCAHcbs8ccpvVIJGKDS8InRoaEN2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942283; c=relaxed/simple;
	bh=Ne7XQJ1miNBnKG52Sp2NW/Y6cdFrExNmZwu2qrVSo9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSyVJ2UUTO4inuZSvSPU5h9knhz+elxmqGfqFVTucdeqjMzhngh4G6E+BHZq5u5GiikoywmUsMo53LEhilY/VVq6ZJtuJI9SEbJKuh84Z8uVZMg0RSvQEfJ86hNMepJmc7hquRnSh0sclmHzgicLjDGWj5r1XaloIpkgmnZC0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgVePif4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E4C2BCB9;
	Tue,  5 May 2026 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942283;
	bh=Ne7XQJ1miNBnKG52Sp2NW/Y6cdFrExNmZwu2qrVSo9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgVePif4K+znOmGBXU4xnDR+mXW1UJXrAntINTfp2JhkF3GYBX4347Dwh5poSeyur
	 7bdo9570a82Kq4zGaMWbzYlddUzj6YuUZwnVvy7e+OgJ8uuvdYIsNI977s3QKIRNNv
	 Evmy6VshRbq8vt1DoIQl7+EIX9axM09OETEoEGcnJMPyPmpSH2gFRSinstCulzcx1C
	 FLrfJwlJb9Kop1qZaN0xdsDvvYlRLb9f/boItJNqnjbG8jPWmwxesJ575Z4NwhZ8Sj
	 vCEb3wcLKk3qVAVIp2DHpnEejgGxw0MAaaYq4s9LjSMdtW3GAzh9aa1EuJQn4qfFxK
	 UX87leRm5+ObA==
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] cgroup: Inline cgroup_has_tasks() in cgroup.h
Date: Mon,  4 May 2026 14:51:17 -1000
Message-ID: <20260505005121.1230198-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505005121.1230198-1-tj@kernel.org>
References: <20260505005121.1230198-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E2CD4C58EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-15596-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

cpuset reads cs->css.cgroup->nr_populated_csets directly in two places to
test whether a cgroup has tasks. cgroup.c already has a matching helper,
cgroup_has_tasks(). Move it to cgroup.h as static inline and use that
instead. This is to prepare for relocation of cgroup->nr_populated_csets. No
semantic change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h    | 5 +++++
 kernel/cgroup/cgroup.c    | 5 -----
 kernel/cgroup/cpuset-v1.c | 2 +-
 kernel/cgroup/cpuset.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index e52160e85af4..ceb87507667e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -639,6 +639,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
 }
 
+static inline bool cgroup_has_tasks(struct cgroup *cgrp)
+{
+	return cgrp->nr_populated_csets;
+}
+
 /* no synchronization, the result can only be used as a hint */
 static inline bool cgroup_is_populated(struct cgroup *cgrp)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bd10a7e2f9c5..7a94c2ea1036 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -376,11 +376,6 @@ static void cgroup_idr_remove(struct idr *idr, int id)
 	spin_unlock_bh(&cgroup_idr_lock);
 }
 
-static bool cgroup_has_tasks(struct cgroup *cgrp)
-{
-	return cgrp->nr_populated_csets;
-}
-
 static bool cgroup_is_threaded(struct cgroup *cgrp)
 {
 	return cgrp->dom_cgrp != cgrp;
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 7308e9b02495..3e9968dd91e9 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -312,7 +312,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 	 * This is full cgroup operation which will also call back into
 	 * cpuset. Execute it asynchronously using workqueue.
 	 */
-	if (is_empty && cs->css.cgroup->nr_populated_csets &&
+	if (is_empty && cgroup_has_tasks(cs->css.cgroup) &&
 	    css_tryget_online(&cs->css)) {
 		struct cpuset_remove_tasks_struct *s;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..a76006b62b9c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -432,7 +432,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
 	 * nr_populated_domain_children may include populated
 	 * csets from descendants that are partitions.
 	 */
-	if (cs->css.cgroup->nr_populated_csets ||
+	if (cgroup_has_tasks(cs->css.cgroup) ||
 	    cs->attach_in_progress)
 		return true;
 
-- 
2.54.0


