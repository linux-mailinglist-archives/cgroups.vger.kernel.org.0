Return-Path: <cgroups+bounces-6965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10954A5C163
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6B63A5F1A
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93599258CD0;
	Tue, 11 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bfWcoulj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2B25742D
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696622; cv=none; b=b14XnqtmFMDJI0jy4GwCjs0P28VoiKeJ6gs8BnEPlnOWDyLsdr5cEsBYU2oniqmqyMZCZI+onM2CRgHetNrdFr3ByDTDKAnNGSCrw6LxnZyFSZNWVdBtmQrkChxEPM/mgW3iSCmPeNPllZF9ua9WIFqfjWtdRYegw9yHToAJ+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696622; c=relaxed/simple;
	bh=xyEpGRHmfNTyRjNmwaA53DxBYx2J1p00Psf5Ko0aRxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoEDEuPHJC2qXGpINduSVtl7DmBwRGjUFRQmUMupePO/2FQGZekPyAwEi+/gWRPf88i7kty9oP/xaGc2LqyYA55jfPaCyGBjl8eXks1pVgPu0dgYOyEzEqAQlxr8Fi/uVwh9ZYAEd8ORqSoHVh2FLpHCI+X1pup4BXK8j/u77X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bfWcoulj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so15480405e9.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696619; x=1742301419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xuoo2PtJFZeE4IeXKmwssCpt9oQyYMklcL+gMOuRoQ=;
        b=bfWcouljdKQCxEXmcxoru9LHjh01i1KlUhSmUBYnYcDhreokBmz9Qp77KFcABE/IDM
         TBcNno+Mtrfyiu3EidddcJ/89PMziiJfzkHUI/KiVhQPPPx9YQ8a4UBhgvfMkucqj04d
         vYC/PRb+QmSLXDzHuTmlwizekshw0Cj7GjImm7jJs4QhiAP3FaNhoy+xNpkv4FxKI0D+
         rkS4sGGUglssRlVd5vSlqqHVxW7b/ketR3w+a7xEjNC8aiXKSPamSPRBlEayJ1thWM1A
         fF/GtYA5MujYYVQxsoEqqQiwiF+Bx4amM3TcIKFXZ1dHxYlmwGFBfklnFptB9JoUlnqR
         8Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696619; x=1742301419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xuoo2PtJFZeE4IeXKmwssCpt9oQyYMklcL+gMOuRoQ=;
        b=UgGgVExheorfOHJHY+gCtIb4HhCRYiVqtn++oYeUfx2VFG17pKnq1B2KjqDvCZjEfS
         jh5YvTjis1YCbdHJsN2n4H/OThesn0lP2NKNaQ+kux0vwtQQLWwi9eca2B4DSLQc33sB
         5Djhr+3jO14uxPImjQnohaEEK/RWtQ0jVthZFbOaC9ZHO8iJXtknBb5a/ujn5pZwP24p
         prsUym6yJIZe7w7JmZfJnLtAgfdhxVAGYiY8nznzN9G3x1oG6dk1czn0dCT6Ae+j0tMm
         Hr0/cvHyYHaj6mcMtUtL2A0d1Pl3k9U2R2DfoSdS1aA57zZk8+6xN5kMtggehsmD/bHS
         YAag==
X-Gm-Message-State: AOJu0Yz7c+aLoVBDLavoBI9oOjaIoFOlhRgZCNTmDDDDdcxe53g7dWNW
	7erT2c+VRKwGBWLVNeHXTXYo7wCQZlq3j3rJ8qc25zAKlnjs1p1u67UwglEztNXke8znAaszJPB
	TvMI=
X-Gm-Gg: ASbGncsQiw4eoLtKmXJztmInHQ5w4OiKlgkLGDEPuvWCcq/Ui6ocKf4UoxedxlTvQoC
	cAY61+KZaHHiCkQVm6CrniFZR3iCrVg2fH8SezvGyQ/z7j6vSq313QgyfjE2YcYZtjkm+RSkxYA
	pWE6xLG+FhkplCHIwsstBxv22IJ3E5ueUi5A59LBVWCx+O4HUJirm88oDeiDpffEJvOKrEXstbk
	h5KnJ0rVPPe0gJ/LdPewgrjpqz2yx6NGmve5nhnSgHX2YaSuukxzFgOWHErqlsGrV8Bs8oxlfVR
	sIdL8mldjvWwKlMlV+AgNy8otGmgjU+1dr9Uho6d6ngVj+8=
X-Google-Smtp-Source: AGHT+IG705tglikfT9xX/hSnvCuldCmyH71qaPUhRYW4tTIkJUwakPUVz4hapz+mna0wElISmvRMlQ==
X-Received: by 2002:a05:600c:4f10:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-43cf64c4722mr76736445e9.29.1741696618579;
        Tue, 11 Mar 2025 05:36:58 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:58 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 04/11] cgroup: Print message when /proc/cgroups is read on v2-only system
Date: Tue, 11 Mar 2025 13:36:21 +0100
Message-ID: <20250311123640.530377-5-mkoutny@suse.com>
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

As a followup to commits 6c2920926b10e ("cgroup: replace
unified-hierarchy.txt with a proper cgroup v2 documentation") and
ab03125268679 ("cgroup: Show # of subsystem CSSes in cgroup.stat"),
add a runtime message to users who read status of controllers in
/proc/cgroups on v2-only system. The detection is based on a)
no controllers are attached to v1, b) default hierarchy is mounted (the
latter is for setups that never mount v2 but read /proc/cgroups upon
boot when controllers default to v2, so that this code may be backported
to older kernels).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup-v1.c       | 7 +++++++
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967a..95ab39e1ec8f0 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -168,6 +168,7 @@ struct cgroup_mgctx {
 
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
+extern bool cgrp_dfl_visible;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e28d5f0d20ed0..11ea8d24ac727 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -673,6 +673,7 @@ struct cftype cgroup1_base_files[] = {
 int proc_cgroupstats_show(struct seq_file *m, void *v)
 {
 	struct cgroup_subsys *ss;
+	bool cgrp_v1_visible = false;
 	int i;
 
 	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
@@ -684,12 +685,18 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	for_each_subsys(ss, i) {
 		if (cgroup1_subsys_absent(ss))
 			continue;
+		cgrp_v1_visible |= ss->root != &cgrp_dfl_root;
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 	}
 
+	if (cgrp_dfl_visible && !cgrp_v1_visible)
+		pr_info_once("/proc/cgroups lists only v1 controllers, use cgroup.controllers of root cgroup for v2 info\n");
+
+
 	return 0;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe5..3a5af0fc544a6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL_GPL(cgrp_dfl_root);
  * The default hierarchy always exists but is hidden until mounted for the
  * first time.  This is for backward compatibility.
  */
-static bool cgrp_dfl_visible;
+bool cgrp_dfl_visible;
 
 /* some controllers are not supported in the default hierarchy */
 static u16 cgrp_dfl_inhibit_ss_mask;
-- 
2.48.1


