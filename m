Return-Path: <cgroups+bounces-14212-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPLTJP6CnWlsQQQAu9opvQ
	(envelope-from <cgroups+bounces-14212-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 11:52:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31DA185AE6
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28060301FD57
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C6377575;
	Tue, 24 Feb 2026 10:52:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442129B233;
	Tue, 24 Feb 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930351; cv=none; b=XcNdhzRs/ngNl3t7PztwzObUDXYTt3KapKEEm7YdUd2MOw3tCUHlxI1IDlBwaPb/ZQeBrV8eZbGndHHtwKhz8VUVLGRS0mdInyFGEZuXZ5Gev4QPUd8wp/eI8bP5HGHRjk0rYm9KjMzn7YAyH7Q0XMHJ5Aoufa/WsD3MRoAp+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930351; c=relaxed/simple;
	bh=VjvpnBB4oIRmRjGTi81TP01htAF0RqRlYj4YgJe/EmM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HUj+wrQygOVOJp2LqzBjNqGXzDJduWx01sHHL9DD1RYznbwkoetUQkIM7y3jlw6O/51n4faG1X2DYZ+IakPC4sJSjMulp4VVikuXjVk3R3XwiC3ZQ2s4ZN2HIvcyZdWYy6acUbZRksSdoCJn0M2anUMtSq2ovvUszkFW47hkOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4fKvF60JVxzYl5tQ;
	Tue, 24 Feb 2026 18:32:58 +0800 (CST)
Received: from a005.hihonor.com (10.68.18.24) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Tue, 24 Feb
 2026 18:36:24 +0800
Received: from a008.hihonor.com (10.68.30.56) by a005.hihonor.com
 (10.68.18.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Tue, 24 Feb
 2026 18:36:24 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Tue, 24 Feb 2026 18:36:24 +0800
From: zhaoqingye <zhaoqingye@honor.com>
To: Tejun Heo <tj@kernel.org>
CC: Johannes Weiner <hannes@cmpxchg.org>,
	=?iso-8859-1?Q?=22Michal_Koutn=FD=22?= <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, zhaoqingye
	<zhaoqingye@honor.com>
Subject: [PATCH] cgroup: remove redundant NULL assignments in migration finish
Thread-Topic: [PATCH] cgroup: remove redundant NULL assignments in migration
 finish
Thread-Index: AdyleOaWxVLArOnARO2GXXWcyNkQHQ==
Date: Tue, 24 Feb 2026 10:36:23 +0000
Message-ID: <994c084e31414d4188c8e2973d9f6e6b@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[honor.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14212-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoqingye@honor.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C31DA185AE6
X-Rspamd-Action: no action

cgroup_migrate_finish() currently sets cset->mg_src_cgrp, cset->mg_dst_cgrp
and cset->mg_dst_cset to NULL when cleaning mgctx->preloaded_dst_csets.

These assignments are redundant for the css_sets on
mgctx->preloaded_dst_csets:

- There are only three places that modify the mg_* members of a css_set:
  - cgroup_migrate_add_src(), which sets src_cset->mg_src_cgrp
  - cgroup_migrate_prepare_dst(), which clears src_cset->mg_src_cgrp when
    src_cset and dst_cset happen to be the same
  - cgroup_migrate_finish(), which clears mg_src_cgrp for css_sets on
    mgctx->preloaded_src_csets and mgctx->preloaded_dst_csets

- All three functions are invoked through the migration sequence:
  cgroup_migrate_add_src() ->
  cgroup_migrate_prepare_dst() ->
  cgroup_migrate_add_task() ->
  cgroup_migrate_execute() ->
  cgroup_migrate_finish()

  All migration entry points (cgroup_attach_task(),
  cgroup_update_dfl_csses() and cgroup_transfer_tasks()) hold
  cgroup_mutex across the whole sequence: cgroup_mutex is acquired before
  cgroup_migrate_add_src() and only released after cgroup_migrate_finish()
  returns. This rules out concurrent updates to the mg_* members.

- During a single migration, a given css_set cannot be on both
  mgctx->preloaded_src_csets and mgctx->preloaded_dst_csets at the same
  time. For css_sets on mgctx->preloaded_dst_csets, mg_src_cgrp,
  mg_dst_cgrp and mg_dst_cset are never assigned and therefore remain NULL
  for the entire migration.

As a result, explicitly setting these fields to NULL again in
cgroup_migrate_finish() for css_sets on mgctx->preloaded_dst_csets does not
change any observable state. Removing the redundant assignments makes the
migration state handling clearer without changing behavior.

Signed-off-by: Qingye Zhao <zhaoqingye@honor.com>
---
 kernel/cgroup/cgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b04910..6c8eff438462 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2845,9 +2845,6 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx=
)
=20
 	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_dst_csets,
 				 mg_dst_preload_node) {
-		cset->mg_src_cgrp =3D NULL;
-		cset->mg_dst_cgrp =3D NULL;
-		cset->mg_dst_cset =3D NULL;
 		list_del_init(&cset->mg_dst_preload_node);
 		put_css_set_locked(cset);
 	}
--=20
2.25.1


