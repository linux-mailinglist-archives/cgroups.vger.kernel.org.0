Return-Path: <cgroups+bounces-15473-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHfdMzGD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15473-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:38:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4234457506
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98B893037166
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC3346773;
	Thu, 23 Apr 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obDih05A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F656342C98
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976490; cv=none; b=gRjAhN+jRGJ7rLsygu+ad54HAjWfJJrxiFEUnZFYru60kePivmF88xd9q5TY9ldcUxczVdDZ0wW7uTSQGzKJag10S61vEjVO5vsv7ujdON8Uh7NBuKe8fGzJSKne1SgHG2NLHrbBNBu6lCV6MTdfy9HGoJjRCPy0Z4cWp9WCIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976490; c=relaxed/simple;
	bh=39F1o581xg4twjfG9X6qcV7pU5QuDnl6qOMsk8dYRnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoHcIgTd/pQkFID4Tij23SQPcf+ILCJsBBaEiY/N7LqN/hfTA7P03OO4OFf7rlGrh1LZTqty0NVxtRxboWQ+E97UMSZvzHier7UP4DKgb12DMtd4Tz+6Nmem56EWjdOzbyS6BKzRvU+2QTXbh4zyVDK2/my0I2vcpRF9QQ76bDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obDih05A; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-42321c8b8f5so5891170fac.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976488; x=1777581288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt6QPYXRPlOeK952eds6qWokMWJg/x4011D3wXxWslY=;
        b=obDih05ASzv8dlL7WrPJ8hTrgtEWBCNzrz5GfvitkEgav1Pk6oB2BVb1Mds90vYQ9K
         uuhm/zbcjoITPJasUpR8xyvdK4wLG8o+gKdioYgFgW56PVfZyifWuAkCWRByB8nELehp
         JXeN+LUMC3dIw6pWfxo9bEylh/JfXRAVIbLQ4I9z4L369KqfpiaDvDr+0tYoYCijgNpn
         GJ3p3Ai7bnnB/vdwWxV8EdXJO4VlITKFgsPnQpOkmibA4wONSj9m85bpExsr45S5zDv4
         kC6BKuLsfvvTxGgIXRVQIL9dEkariIkxV7Lt5hCrfuoTdBpy41JpZFrREJIkLdp1LZrk
         +KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976488; x=1777581288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dt6QPYXRPlOeK952eds6qWokMWJg/x4011D3wXxWslY=;
        b=aSV/RjKjy4xx/m/lhuvV+KkpEFV/6Q6TN1ds45vX1oxWHf+4ELpA8CBD5LSwbB/GGx
         3wSfFqt4rbPc/XLlc12aoniTjxgRyTc1dMZHd/3ObUplLzzSe0FDXOwjMxdjjFgG+yGX
         G+TsXr4rNSzMjN9qx0JAAt8tsMmsQVEciUj9fhTYjucyQiWNhkfeRHmwHnGeX3lSORcL
         /5BbCwlzkGRWFG7Mv4KG4YGsBOpzpfXRYNPpnTi6doJtI1Mk0tQtvDK7iHnopNiHFuCa
         YOsUPiYAH7QsiW/wM4IrYYbCBwtDqwmmngfUVrK34eOpXaMMR4OWLV9GcF5HaMP5aMCS
         73Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZUFjCNSkgc9alZax5H2OslDqr7LuTNP0IIkToDXolSbDE3sHNL1+uQ8htddtSUCQJaXCkTbLm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1s6oqZt1k9ddMsquiF0dv22cei8xm3jXCDSgBiGVoRoh6m2k
	cU6FtzaqAf74nXujTf/uKnQjXidnV6M70FXZtmRf9QGiQv7OUJAZIy0m
X-Gm-Gg: AeBDiet6KcC+lnpDWd+vkk+MWbyuctWDAhiKRXmWNyf7pR5SPhFqQ5IA7YAIECt8DHU
	Oe2MRWMP/RjpfPp878iEJ6eAatzXq6427Gu33RNsirCMvPjMavN+SK4GZHlwARYrDZSLJfeYfLX
	N0DHyNSawufv3GvGNmeoqxu653BzpyxoEmIgraethADfR01WUFzHEHiSLMNHJlh2SN4wvJeCBfM
	KrF7dH0RvVehlDDItnx3MfFbvp6k/qMe2fhJ7PcY2E1byDLwF1rP91By6W3g7OUVf0oE3XrYwif
	kflzNGv2Qn0JqTt5qIxWs2sepFe6yRG6hfQoT+3HTzpX0FXLNaSbq6TzwD/VVdqO+0caBEO1bFv
	5AbKTLeA01L7lyclYZfaYqoPuOQhPPBSEXBsYXXxvnWR86neUAyz42woxTs3mM0kJrjSKYuhYuP
	/9eV/+ibXvLwdBrKxPLjlrvnTR6BzM
X-Received: by 2002:a05:6870:88a3:b0:3e8:926e:bf9f with SMTP id 586e51a60fabf-42a99ab5f12mr15325305fac.13.1776976488180;
        Thu, 23 Apr 2026 13:34:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fe61449bcsm2793964fac.11.2026.04.23.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:47 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 1/9 v2] cgroup: Introduce memory_tiered_limits cgroup mount option
Date: Thu, 23 Apr 2026 13:34:35 -0700
Message-ID: <20260423203445.2914963-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15473-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pids.events:url]
X-Rspamd-Queue-Id: E4234457506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a cgroup mount option memory_tiered_limits to enable
tier-proportional scaling of the memory cgroup controller limits
memory.{min, low, high, max}.

The mount option currently does not have any effect.
Later commits will scale memcg limits proportional to the system's
toptier:total capacity ratio.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/cgroup-defs.h |  5 +++++
 include/linux/memcontrol.h  | 14 ++++++++++++++
 kernel/cgroup/cgroup.c      | 12 ++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index bb92f5c169ca2..0b6861f4faece 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -128,6 +128,11 @@ enum {
 	 * Enable legacy local pids.events.
 	 */
 	CGRP_ROOT_PIDS_LOCAL_EVENTS = (1 << 20),
+
+	/*
+	 * Enable tier-proportional scaling of limits for the memory controller.
+	 */
+	CGRP_ROOT_MEMORY_TIERED_LIMITS = (1 << 21),
 };
 
 /* cftype->flags */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b4..be45641e890e4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -533,6 +533,15 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
+static inline bool mem_cgroup_tiered_limits(void)
+{
+#ifdef CONFIG_NUMA
+	return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_TIERED_LIMITS;
+#else
+	return false;
+#endif
+}
+
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
@@ -1084,6 +1093,11 @@ static inline bool mem_cgroup_disabled(void)
 	return true;
 }
 
+static inline bool mem_cgroup_tiered_limits(void)
+{
+	return false;
+}
+
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index babf7b4560488..6a34d0e179dc5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1989,6 +1989,7 @@ enum cgroup2_param {
 	Opt_memory_recursiveprot,
 	Opt_memory_hugetlb_accounting,
 	Opt_pids_localevents,
+	Opt_memory_tiered_limits,
 	nr__cgroup2_params
 };
 
@@ -1999,6 +2000,7 @@ static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
 	fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_accounting),
 	fsparam_flag("pids_localevents",	Opt_pids_localevents),
+	fsparam_flag("memory_tiered_limits",	Opt_memory_tiered_limits),
 	{}
 };
 
@@ -2031,6 +2033,9 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_pids_localevents:
 		ctx->flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
 		return 0;
+	case Opt_memory_tiered_limits:
+		ctx->flags |= CGRP_ROOT_MEMORY_TIERED_LIMITS;
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -2072,6 +2077,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 			cgrp_dfl_root.flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_PIDS_LOCAL_EVENTS;
+
+		if (root_flags & CGRP_ROOT_MEMORY_TIERED_LIMITS)
+			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_TIERED_LIMITS;
+		else
+			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_TIERED_LIMITS;
 	}
 }
 
@@ -2089,6 +2099,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 		seq_puts(seq, ",memory_hugetlb_accounting");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
 		seq_puts(seq, ",pids_localevents");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_TIERED_LIMITS)
+		seq_puts(seq, ",memory_tiered_limits");
 	return 0;
 }
 
-- 
2.52.0


