Return-Path: <cgroups+bounces-15068-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fh1B/M8xmm7HgUAu9opvQ
	(envelope-from <cgroups+bounces-15068-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:16:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9812340D4F
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8622E300B54B
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C923D3D18;
	Fri, 27 Mar 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY+9MLoE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EA3D3CE2;
	Fri, 27 Mar 2026 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599402; cv=none; b=u1zHaIihdCTy6+vVTXzVjiPaxawtKdbMU5ITn2BtSfCgJr6xK1WnV/qKE03mSr53BduZ5v6Yvnl5HRZCGnFVpQkCngpUvs5k9ZSroA4B2sQvWUpbTIPDTWh26GdwLIcrrHyHtsaLjjq+RP4+2IisPWD4teFXFOJMZnKEmEaYrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599402; c=relaxed/simple;
	bh=qeVWa8r7f4q+L+gXinu2pi9ngSyC1Swgdgb8weA16QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1I87N7Qe/qgcX5i6FGo2u8E7QVnf8boFInW4LvARMFjLXdyApc8Z2WKOVQoo8C/KRWBgDZsLgikKOyFWYG8UHP13F58QoUFlQ+yi47iqvGWJBQaBtch+YlC4AbNXxNKY8mNdiohClBdQ6rzgBi2jp5aSAmG6X77tQJC0nlUDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY+9MLoE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774599400; x=1806135400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qeVWa8r7f4q+L+gXinu2pi9ngSyC1Swgdgb8weA16QE=;
  b=eY+9MLoEt7lonn2S0RKrSwDKQHlrVNSfz1jSuRZ5yfkJO6jxqdGJqXIO
   hU4Mjghm0UnRJmgVTV2RJbOylg2JNOOYfKGUTjOEeYFVm2e2aT9Adt5GY
   v/+b/40BbMLmLC8INFxEMeuziwWBnd6GscIBV+aK0yBWDzRty+cwCIDCL
   oMoeL+DfqJOQeBXbaTg2cYF0TpsCpByob290y4Gvhey/oIqshcMk1b6xB
   pfcZVCOEqeC8Uk3e1+IqoMbQJKoDEG8m/71T2v6sh033MNkFpuW1timlA
   Mf7c3ZA2OdC+HpHjJRyIljoC0eKGbCwk7OaHZT6rVQLHPu07ExFLlUZee
   Q==;
X-CSE-ConnectionGUID: IgebWfR3Rn2BF5bkBMyQTg==
X-CSE-MsgGUID: aCLoj+RLQ5yqef9pbhW2BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784035"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75784035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:16:39 -0700
X-CSE-ConnectionGUID: GKBuzr8rT1imynU1RhvNpw==
X-CSE-MsgGUID: dir45kgJQ6GnreQLIax5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255747888"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:16:34 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] cgroup/dmem: Return error when setting max below current usage
Date: Fri, 27 Mar 2026 09:15:56 +0100
Message-ID: <20260327081600.4885-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15068-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B9812340D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Return -EBUSY to userspace when writing dmem.max below the cgroup's
current device memory usage, rather than silently leaving the limit
unchanged.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 kernel/cgroup/dmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa..3e6d4c0b26a1 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -144,22 +144,24 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 	dmemcg_pool_put(pool);
 }
 
-static void
+static int
 set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_min(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_low(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	return page_counter_set_max(&pool->cnt, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -726,7 +728,7 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
@@ -773,7 +775,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		err = apply(pool, new_limit);
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.53.0


