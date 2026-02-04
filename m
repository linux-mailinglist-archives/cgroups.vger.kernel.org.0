Return-Path: <cgroups+bounces-13676-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBCtAN1wg2mFmwMAu9opvQ
	(envelope-from <cgroups+bounces-13676-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 17:16:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC32EA0ED
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79A9C301BA65
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0C423A8F;
	Wed,  4 Feb 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CG7LMhqC"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26648421A11;
	Wed,  4 Feb 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221733; cv=none; b=tTcQU8KQIGpM+rBHTyZda6BLnEI0bHi1pnWuMcMFqBOLxCCYL61rjLfGnqwzz9Thm0bTglm1KvyJfhPKLUpVaS/nRqC25uDsobFKS7ZzHHSUc2yp1HU/oY85DCJTvvzdYk/LnANXj3+NQ65M84nWBbvW4EyzPjlZ1lSSnaBryH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221733; c=relaxed/simple;
	bh=VUXwFN/tQFzURvWM4nP/VXY6rg+eLJPscffz1scgyOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C1kc36mdh3HoFZq1CP26WoiLTTY1x/8dA9CG25DBJhUeZn0e/UodF8CLuxtgOSn//Bo08Dfkf87FTNwk9biOBGFJs0assrid2Ba46qRsfiOs5PKup493lqVBuTR0+gHzH8f6+dehbl9aj9k6+vBUFCUrEfTGtvwx9kJgdEHwqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CG7LMhqC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=743Ax+sX0JeWi/iOSLknxfX/DnCNL6/UbMsg4xu3V5o=; b=CG7LMhqClsDn8SrGyQ4oW/9vY5
	FCt2puoFLtjIFUGnVCuDZmzBGCw8iaXsyFMAXc70nxo/hiw/1lDOB2Vf0Hv94lsjgu+OoE1c2UTRT
	VBx8gpVyVWrl4VpGwA1c94qu5XzR2aEhTDScNlx0QubDoMR+pW9QGNpmch30o5ysRLMl7/FzJcy8T
	wL3B1pdxLpfyK+BpK2CefGuEAxQlRsjfSU6yufvxdfnKwfcC7QOJq2HGT8U/vZ7FAg8ZaFZBxq2YD
	mq81wpUsbl4mgNBK2ZFls7OhPMsCSUWWkltmxqU88h97PL2VM8m7g5SdlM+nt7Cj5chlm3FQArLta
	7YB1+g7A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnfXG-005iji-2V; Wed, 04 Feb 2026 16:15:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Feb 2026 08:15:12 -0800
Subject: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>
X-B4-Tracking: v=1; b=H4sIAJBwg2kC/yXMQQrCMBAAwK8se24gjUVjviIlNOk2rkpbsokUS
 v8u6nEus6NQZhJ0sGOmNwsvMzpoG8B4H+ZEikd0gEabsza6U+H19DHlpa5+pFCTlzIUUWTbYO1
 lusaTxgZwzTTx9otv/d9Sw4Ni+W54HB9WnuAdegAAAA==
X-Change-ID: 20260204-blk_cgroup_debug_stats-e81b887f9c30
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=leitao@debian.org;
 h=from:subject:message-id; bh=VUXwFN/tQFzURvWM4nP/VXY6rg+eLJPscffz1scgyOc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpg3CV/tamWhcKJHEkH+qxX1hGY9CbIBZsRrcE/
 09p+DGfNzaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYNwlQAKCRA1o5Of/Hh3
 bYVPEACD/Wmep+MgW/Pr92FZLSZ0GUsJ+kz3UywUCV+HVyIiUqgl/SDwIQURe0wYtgrFF9G/b/N
 y7ymCLP1rjYUNvhvxXtzEWrgarnXj6Z8UMG+PHRilXYZco0TV/F7ZhqRnfp4iEHetT2q8XJPXkE
 kDiicrbZZTWSCfgrKjSPYqDf3Af3RDZF5qVTplph8ggn87LyXmJE/05aZ6PkVCPEppDc8c/sWFT
 8o8JrGvqFws8DOY81eG6wCY0ZS1zqs4Co4eYk3MfaWAn9+tx5jCyJf5q9rw/PUM1HGVXirlXdnQ
 8oTuGSDxU//M5ni3R6+EV21CPLcWd6m4wM7G0O00XAgc28FLA52Q2EJBYecvCvAKBmwjDvUK0BX
 z8P3SpyAGef6k2Q3Clq4tsKQ43RG/Pis05fydzjZpDRMvbP/YCSktOkCw6Ufjk+ZvyBj6+VMk3s
 lukkqhJj6r0CUG53YU0e4i+ZF8iHaw1jPNR0rX6jh9/r7u7JmANa+p43RO1sAfI609Vd+6U38MJ
 UA5pue1fmO1XDDqQszuCMhe7jYxYqTbdpzC/OwEeY1D3yK0ZzoilMShRToaPTqKiVpyfqWomi43
 ALZDlr0/ouPUqqc9hF3rWO2cZzVk3CSKzldU5d+no4cayrhmnbZ8SGiWIYIaGNkMJfdhTFWCYhY
 kLq3mxmaMEryhWA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13676-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACC32EA0ED
X-Rspamd-Action: no action

Add a Kconfig option to enable blkcg_debug_stats by default at compile
time. When CONFIG_BLK_CGROUP_DEBUG_STATS is enabled, additional debugging
information is shown in the cgroup io.stat file, including cost.wait,
cost.indebt, and cost.indelay for iocost, as well as latency statistics
for iolatency.

The runtime module parameter blkcg_debug_stats remains functional,
allowing the setting to be toggled regardless of the compile-time
default.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
This option is commonly enabled by some hyperscalers, either through the
command line or custom patches. Let's make it part of the kernel.
---
 block/Kconfig      | 15 +++++++++++++++
 block/blk-cgroup.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7..03fb95a24564c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -170,6 +170,21 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_CGROUP_DEBUG_STATS
+	bool "Enable blkcg debug stats by default"
+	depends on BLK_CGROUP
+	default n
+	help
+	Enable blkcg debug stats by default. This provides additional
+	debugging information in the cgroup io.stat file, including
+	cost.wait, cost.indebt, cost.indelay for iocost and latency
+	statistics for iolatency.
+
+	This can also be enabled at runtime via the blkcg_debug_stats
+	module parameter.
+
+	If unsure, say N.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d87..67687d02b3cbc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -56,7 +56,7 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
-bool blkcg_debug_stats = false;
+bool blkcg_debug_stats = IS_ENABLED(CONFIG_BLK_CGROUP_DEBUG_STATS);
 
 static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
 

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260204-blk_cgroup_debug_stats-e81b887f9c30

Best regards,
--  
Breno Leitao <leitao@debian.org>


