Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799532F448F
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAMGax convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 13 Jan 2021 01:30:53 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25692 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbhAMGax (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 01:30:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1610519378; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=AzY0una2dr5icUhDu4lNzz1sgrc+V2ouDrf899s1Eyof7X10qnOw9Z7U499Bz5Lg3W5PyGnwg88pDKHUasBCLs0P6wUW5WSl1jud1Qxu6lN+bAtLNDhK8FkqicnI7EowTnRrLNQmOIFtGvAMxSqEMACkqHEqVLBAf69D/7bamiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1610519378; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=EunE2JE8gNgn5uPLjhfmYDZKnwinSngHILvntoS58Vw=; 
        b=aNzoM/mwp5LeNaHJC4PpzMl740Ug0RW+w/aCX1aWN5t+TwU/kBUDX0Q0kObSU12WAxQuo9tsHm4LM61u6p1XEJw9Uwh1kuK6GyyC238A0CYm4O9d1x5pzypWZ8FlpuHg6v/FEwlccmkZsMediNNzA+ZOaqLuPy4Rb8+dYnKgpWM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        spf=pass  smtp.mailfrom=lifeng2221dd1@zoho.com.cn;
        dmarc=pass header.from=<lifeng2221dd1@zoho.com.cn> header.from=<lifeng2221dd1@zoho.com.cn>
Received: from localhost.localdomain (119.3.119.20 [119.3.119.20]) by mx.zoho.com.cn
        with SMTPS id 1610519377806976.0436234871487; Wed, 13 Jan 2021 14:29:37 +0800 (CST)
From:   Li Feng <lifeng2221dd1@zoho.com.cn>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Feng <lifeng2221dd1@zoho.com.cn>
Message-ID: <20210113062929.303858-1-lifeng2221dd1@zoho.com.cn>
Subject: [PATCH] cgroup: Remove stale comments
Date:   Wed, 13 Jan 2021 14:29:29 +0800
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The function "cgroup_mount" had beed removed, remove related comments
to prevent confusion.

Related commit:90129625d9203a917f(cgroup: start switching to fs_context)

Signed-off-by: Li Feng <lifeng2221dd1@zoho.com.cn>
---
 kernel/cgroup/cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 613845769103..493547b4941c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2139,7 +2139,6 @@ static void cgroup_kill_sb(struct super_block *sb)
 	/*
 	 * If @root doesn't have any children, start killing it.
 	 * This prevents new mounts by disabling percpu_ref_tryget_live().
-	 * cgroup_mount() may wait for @root's release.
 	 *
 	 * And don't kill the default root.
 	 */
-- 
2.25.1


