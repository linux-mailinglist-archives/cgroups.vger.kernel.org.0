Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D173C85A6
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGNN52 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 09:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239428AbhGNN52 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F19261396;
        Wed, 14 Jul 2021 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270876;
        bh=5fwdrjx3luOJz+IOnCdMGj33tiidc13aDeeeCloWIWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlAnA95h33OKgMm2eTmKOChZbGNcVOgy3VE4J7GPWG5S5fLY7B7smBjtqalkpOyRj
         gO42j0Sej5Wm5advrRU4dgr6qfdKDsijIzo9vvZe/8Il4C7qJPiKjjnYKYlAmrnbs7
         VCZRmrlgcWY+HNUVTFplL6DwfIe1mdXwVEZM832yGllCZ2p00MfXgat4Htfxh/oBCb
         kWaSw89f2dX767AlGowLBLRe+7VnqWVqjfn/cPJUjXFPofgjh20NArI0BjserrpZBi
         DDLbp5AIuSIFCxPFDwTqRow+xdSElsb0aAHtgf9Gr03aN8aCbXOilQv2w6EF8uIbFw
         vZWvC5Dvj/e3Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: [RFC PATCH 3/6] net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Wed, 14 Jul 2021 15:54:17 +0200
Message-Id: <20210714135420.69624-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
References: <20210714135420.69624-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare for HK_FLAG_DOMAIN to move to its own cpumask.
This will allow to modify the set passed through "isolcpus=" kernel boot
parameter on runtime.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f6197774048b..78ea904e9206 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -782,7 +782,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i, hk_flags;
+	int err, cpu, i;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -798,8 +798,8 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 	}
 
 	if (!cpumask_empty(mask)) {
-		hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
-		cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_WQ));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
 			return -EINVAL;
-- 
2.25.1

