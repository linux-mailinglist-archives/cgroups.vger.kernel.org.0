Return-Path: <cgroups+bounces-13939-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IxtOiDVjmlFFQEAu9opvQ
	(envelope-from <cgroups+bounces-13939-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:39:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23780133A5D
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0E75301B40F
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC862FF176;
	Fri, 13 Feb 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDr4/+Ey"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B72FF144
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968317; cv=none; b=Cn4Anc9CUxCylJV3/rvMiI+5ExwrtQ6DHs5TL9dGLXRXlf3Y43eIprvZy2u3WmN8b4uxdlDEQXm6EYGxICfwfqOKh8l5Qn7Uq5DamcmcKBasxFFtZJ8KRlb8f4a3YLqrP4GVApGRxvyLrF6grKMG3jy9ccDsOa64zqOobPPKmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968317; c=relaxed/simple;
	bh=HNCSRMt+uVOtWUpx9BoHkeZenvzhAbsE081cSwO+Qw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/lvR1sCnG/xnd3lBgKWwj29lHs9WyfjISVdzBRO7bzr0h2Nl2odGJ1s6GCH7snD0GOmaVSzYhvaOE6wItTZxAK8620cILxzHqhY8zq7tSvc1oyRvvk/qvd1xB/0CP696tIgkjPiUX8LKIW+vrYkUwwI8I+pWz+/Bf6f5DXGHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDr4/+Ey; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-824a6f2d816so327582b3a.3
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770968315; x=1771573115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUNbAPwCyhGMoDBC5WsOOsA+LVhyxhs3/AZuxGFmVLQ=;
        b=fDr4/+Ey4gxFhAoGsNGFV0vOB2RPktLXpGndCXHa6/RCOAdOXdzdU8onGUqxf9hr2G
         U0YNmganwdBfBPSxfAMZ27VU7ZmGkTSfdmc7B1l3Iv8Jgi8FjTtnR5KRTzuJhL6ys1Vw
         WreOEzDnFjFUetpD7qf7mqtEwF+n9w8TsI/Z2xQWHwIVivOI6O2e7L2+nTQUSxv7EZSR
         SmolaOo52hE+XMXrca0YeBT/SFdrMd9JuSNjvfHgcNxoPOAJU/ufIglT8+Z/J6M5HxE8
         CHgoibOXZ/tBog6MGU8yEobXzydNbfqMpbWJt8dQueezjW5yp/Wq4uGs9YbiMBc/m0Qx
         +n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968315; x=1771573115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUNbAPwCyhGMoDBC5WsOOsA+LVhyxhs3/AZuxGFmVLQ=;
        b=Zy0wLYwY/tKXupbhBhORJI5vRMcxtmJ+0hRJT2w2Ugt+3gwLUoRvNddtq5zAIgwhY5
         pyC/+1066WSDyzkyvdRvK+o7Jj+37AGHa7te9BhOwOPh6uqn38OhuDNaxoPC0kLa3qu8
         0jMmp/ZQXWtpDiY2IGOTQnr9pBH8VChFeNugrsAUVxTomtXt9p1MiVIPpL1MUxwtM2bv
         9ZLU+Zg9QU/SUzDjM0y+TJXQbdh7LPpEBhf1iINLKvoBYfwV0A73NvKecE+ouF4Y+NbI
         ozbIrIPIYbUeoCFvdO9TKWJqPUMcw7ltfz81udwOqQQLT1lmsV+ddVjrb00nPTjLQCmZ
         7C+w==
X-Forwarded-Encrypted: i=1; AJvYcCWS+E/DvJYl/JTERZLEaUmpg+ebH4Do9uu0v9xpmXStyucUtxawmTK++wc51P9RVwgj1A74cV8M@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDzC7wpD5FbgokodBSQ1clPfXeBKg+rB64ugkxUElqQ6SXy6N
	o57TSfB/jPdIThlqMpbSNk2GR+k1HwX0Kfv9EAzcI17zdWnKP363CvZT1SU4pASgxmtyTPmt
X-Gm-Gg: AZuq6aL32hka+ZBwbiOJsN55cCKpRT8HwzXNEFWWUneXjafnA6247Xdh4StfE1ddMmH
	G2TAzlBCwuq38QamUiRY1J7NucCdfoga+3iTUXN2TFM0KBLG7NExckEYPgQePv8kDY1i1OOzTZ1
	HBdeIxpoVQCw7nbi9pfk6OK3kCk5L5bkhMWmQJ5PlTQgLeSi2rW+Yhvl6TMutcpbEQmoxgt3hJ3
	z4BN3DOLwzMtxY+zAR5ZPQlX56JndyElezthZ5zQKP6pVcpw+D6jUO4kJW4cY+pJBn4g+aHAnUB
	dmXlcboI9WAZkm09b0594bl3mVqqiOTRZsUZinaupyqruCRh38cTv2d+C86sibMe2yiYWSMniVp
	uWhHlQKecRMOcORx723En+nMup5zs1Xllc0YeB4w3I0sUnDjPU31V0Ac46B1YSrXsxqFE/gN7va
	RBK6170/QSw8lSCW6Jc1ATp4BrudqePzc8nw==
X-Received: by 2002:a05:6a00:2e85:b0:824:ae74:5725 with SMTP id d2e1a72fcca58-824c95c3afemr1122224b3a.35.1770968314668;
        Thu, 12 Feb 2026 23:38:34 -0800 (PST)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e936sm1498959b3a.6.2026.02.12.23.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:38:34 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: lianux.mm@gmail.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jialin Wang <wjl.linux@gmail.com>
Subject: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Fri, 13 Feb 2026 15:38:29 +0800
Message-ID: <20260213073829.182168-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13939-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23780133A5D
X-Rspamd-Action: no action

In public cloud environments, block devices usually enforce performance
limits based on two independent token buckets: IOPS and BPS. The device
is throttled when either the IOPS limit or the BPS limit is reached.

To effectively manage "noisy neighbor" problems, we configure iocost
model parameters (or vrate max) to approximately 95% of the cloud
provider's provisioned limits. The goal is to strictly avoid hitting
the storage backend's hard BPS/IOPS limits. By saturating the virtual
budget before the physical limit, iocost engages throttling first.
Unlike the indiscriminate throttling applied by cloud storage backends,
iocost selectively penalizes low-weight cgroups or heavy-traffic
perpetrators. Consequently, IO-latency-sensitive critical workloads
remain entirely unaffected by the congestion. Extensive testing has
verified that this approach yields excellent isolation results.

However, the existing 'linear' cost model leads to significant
performance loss in this specific configuration due to its additive
nature.

Using tools/cgroup/iocost_coef_gen.py, we measured the following
performance data on a typical cloud disk:

8:16 rbps=173471131 rseqiops=3566 rrandiops=3566 wbps=173333269 wseqiops=3566 wrandiops=3559

Dividing BPS by IOPS (173471131 / 3566) yields approximately 48607
bytes. When running fio with bs=48607, we observed a 50% drop in
throughput compared to running without iocost enabled.

The reason is that the current 'linear' model calculates cost as:

  Cost = BaseCost + (Pages * PerPageCost)

Expanding the internal variables relative to IOPS and BPS, this is
effectively:

  Cost = VTIME_PER_SEC * ((1 / IOPS - 4096 / BPS) + size / BPS)

When the I/O size is such that the IOPS cost component roughly equals
the BPS cost component (as in the bs=48607 case above), the linear
model sums them up. Since cloud disks throttle based on *either* IOPS
*or* BPS (whichever is exhausted first), summing them effectively
doubles the calculated cost. This causes iocost to drain virtual time
twice as fast as necessary, throttling the device to 50% utilization.

To solve this, this patch introduces a new 'linear-max' cost model.
Instead of adding the components, it takes the maximum:

  Cost = VTIME_PER_SEC * max(1 / IOPS, size / BPS)

Which translates to:

  Cost = max(BaseCost + PerPageCost, Pages * PerPageCost)

This formula correctly models the dual-bucket behavior of cloud disks.
It ensures that for any block size, the calculated cost aligns with the
actual bottleneck (IOPS or BPS). This allows the system to reach close
to the provisioned BPS/IOPS limits without premature throttling, while
still maintaining the latency protection benefits of iocost.

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 block/blk-iocost.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ef543d163d46..ead478d8e5bc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -445,6 +445,7 @@ struct ioc {
 	int				autop_idx;
 	bool				user_qos_params:1;
 	bool				user_cost_model:1;
+	bool				cost_model_linear_max:1;
 };
 
 struct iocg_pcpu_stat {
@@ -2565,7 +2566,12 @@ static void calc_vtime_cost_builtin(struct bio *bio, struct ioc_gq *iocg,
 			cost += coef_seqio;
 		}
 	}
-	cost += pages * coef_page;
+
+	if (ioc->cost_model_linear_max)
+		cost = max(cost + coef_page, pages * coef_page);
+	else
+		cost += pages * coef_page;
+
 out:
 	*costp = cost;
 }
@@ -3368,10 +3374,11 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 		return 0;
 
 	spin_lock(&ioc->lock);
-	seq_printf(sf, "%s ctrl=%s model=linear "
+	seq_printf(sf, "%s ctrl=%s model=%s "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
+		   ioc->cost_model_linear_max ? "linear-max" : "linear",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
 	spin_unlock(&ioc->lock);
@@ -3412,6 +3419,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
+	bool linear_max;
 	char *body, *p;
 	int ret;
 
@@ -3442,6 +3450,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
+	linear_max = ioc->cost_model_linear_max;
 
 	while ((p = strsep(&body, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
@@ -3464,7 +3473,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 			continue;
 		case COST_MODEL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
-			if (strcmp(buf, "linear"))
+			if (!strcmp(buf, "linear"))
+				linear_max = false;
+			else if (!strcmp(buf, "linear-max"))
+				linear_max = true;
+			else
 				goto einval;
 			continue;
 		}
@@ -3481,8 +3494,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (user) {
 		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
 		ioc->user_cost_model = true;
+		ioc->cost_model_linear_max = linear_max;
 	} else {
 		ioc->user_cost_model = false;
+		ioc->cost_model_linear_max = false;
 	}
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
-- 
2.52.0


