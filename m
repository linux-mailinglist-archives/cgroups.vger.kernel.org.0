Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B030CA116E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfH2GGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:06:05 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:7918
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbfH2GGF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coyR3PhhGdQ289VT1xTyJr1eM4Q7ipslx1vH1JDbXnRw6UPnNEGiIMTdx0/Uzc8NJUHPmi4h77tl79hoBTUOJO6O0Yrae8cigKDkxAdEhu8JMhhOmILGGeRrg+l81rStPFNNQkcaOr+aDZL4WJHki+F2CLFV1Pmij6DUCc/amv/41VHJCFmgZhlSoGH2hdGO8dj3ZUCoqId9eRkh+pUmOWutkzbnxhLkXqyKpDgdnsGRct9/6XnDBuKUcFttol/2qYWgRfCiF2w+OpZuhWDs3irPr8S+V0pceQj95vae8TyVys1r9LEc1JOzJyDka3W/pbr3XgBej44lOTAmPQP99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHCdRB4lz61FKBEyUmCsgxLGy00PpWlSb12BZmjdJis=;
 b=NY0n9LhvvIMRtwDd1XAbI3uiAEQ0kWhyBWYHDWnc5yPm7VzqtotUWE1/LKU2urUliibhLfUI/WB5T465fLaG1pntLRXVtKEWuCNpEfzG7LXwdOE3oW8MKcVqaIKxiwHV3+H5BoZcIr+KooHOGdLAwF5VI2e/q0zgGBqqT87JgPh1JpxTv+f8Nu+Qy4Q/upe+FW8R6u/yUVSwy3w6tdf+o5AWCwOsrbc4AMuNlLxMREQmLy3evoFEpuohGzrO0hxku6SGnEFFH9iOZ4RUP6hmCct8jtprD99mqrdi3AunJJvU6eT7VNtxVMl2kUiYHxn8760xZ4yjHtHkuTIbRmQxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHCdRB4lz61FKBEyUmCsgxLGy00PpWlSb12BZmjdJis=;
 b=FJ9CEsUTHTD/c5M5pZrVBNiKuLyw9sbcWxOEpBEirse0l0Cr25+3m1lhDDVGAQgWlLxXYAk+7s/cYuFKwPn8F2u+HEe57hYsX+dcWtRjvAI1NIHCsYGeXwX/cY560Y/KalEekkK7L4cnggGJGgY0dh1hIkASoCSEGVtNeox7F7M=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19; Thu, 29 Aug
 2019 06:06:03 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:06:02 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:06:02 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:52 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 15/16] drm, cgroup: add update trigger after limit change
Date:   Thu, 29 Aug 2019 02:05:32 -0400
Message-ID: <20190829060533.32315-16-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(428003)(189003)(199004)(486006)(476003)(2616005)(126002)(426003)(478600001)(11346002)(356004)(6666004)(8936002)(50226002)(110136005)(305945005)(336012)(26005)(53936002)(186003)(50466002)(446003)(5660300002)(15650500001)(51416003)(2870700001)(7696005)(2906002)(76176011)(81166006)(81156014)(8676002)(36756003)(1076003)(4326008)(70586007)(5024004)(70206006)(14444005)(48376002)(86362001)(2201001)(53416004)(316002)(47776003)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2719;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b87b45-2a42-4107-bde9-08d72c46f8a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:SN6PR12MB2719;
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27192B32E746774F37DB2A2783A20@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1ND1aj3G7PS92B3emWO4t1VvMpq3pbGoTv7Du9foPdf8l39vpF6WH0EOLRWPR2Vg65v3H6Mqbfi7u+DQKWJBpuUC1IW8+rJ5G5d650vN+BlN0fRC1xyanHtFzAjPCuxnOfDvcovTXXMVUerMf2U7LFtXqRIxKQXVCZxxsl2xugwNIn0BZctQyqLla8iPN1yyI3qtwJiwi6vME7tEHGAccfnEs3MjkCu6yz2VjkjCiiLgt57GxL0p1BpdRoVI1bENQUhgteMcpE301gBny8w7rGBPgoSVVZz/JZaRRtL2QWBK3xlY+hLnAQ7fPYOjgN++rS9PNTLcMAim2+z/7pyLgFbC7T4E8rN7/22WBu6tN74qWJYqQaZ0Q+75E2vnPX4EbbQP5lCoF7ijrcXOpWfeBpRv8d7fJesg8KD3HuV/JWM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:06:02.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b87b45-2a42-4107-bde9-08d72c46f8a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Before this commit, drmcg limits are updated but enforcement is delayed
until the next time the driver check against the new limit.  While this
is sufficient for certain resources, a more proactive enforcement may be
needed for other resources.

Introducing an optional drmcg_limit_updated callback for the DRM
drivers.  When defined, it will be called in two scenarios:
1) When limits are updated for a particular cgroup, the callback will be
triggered for each task in the updated cgroup.
2) When a task is migrated from one cgroup to another, the callback will
be triggered for each resource type for the migrated task.

Change-Id: I68187a72818b855b5f295aefcb241cda8ab63b00
Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
---
 include/drm/drm_drv.h | 10 ++++++++
 kernel/cgroup/drm.c   | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index c8a37a08d98d..7e588b874a27 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -669,6 +669,16 @@ struct drm_driver {
 	void (*drmcg_custom_init)(struct drm_device *dev,
 			struct drmcg_props *props);
 
+	/**
+	 * @drmcg_limit_updated
+	 *
+	 * Optional callback
+	 */
+	void (*drmcg_limit_updated)(struct drm_device *dev,
+			struct task_struct *task,\
+			struct drmcg_device_resource *ddr,
+			enum drmcg_res_type res_type);
+
 	/**
 	 * @gem_vm_ops: Driver private ops for this object
 	 */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 18c4368e2c29..99772e5d9ccc 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -621,6 +621,23 @@ static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
 	}
 }
 
+static void drmcg_limit_updated(struct drm_device *dev, struct drmcg *drmcg,
+		enum drmcg_res_type res_type)
+{
+	struct drmcg_device_resource *ddr =
+		drmcg->dev_resources[dev->primary->index];
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&drmcg->css.cgroup->self,
+			CSS_TASK_ITER_PROCS, &it);
+	while ((task = css_task_iter_next(&it))) {
+		dev->driver->drmcg_limit_updated(dev, task,
+				ddr, res_type);
+	}
+	css_task_iter_end(&it);
+}
+
 static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 		size_t nbytes, loff_t off)
 {
@@ -726,6 +743,10 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
 		default:
 			break;
 		}
+
+		if (dm->dev->driver->drmcg_limit_updated)
+			drmcg_limit_updated(dm->dev, drmcg, type);
+
 		drm_dev_put(dm->dev); /* release from drm_minor_acquire */
 	}
 
@@ -863,9 +884,45 @@ struct cftype files[] = {
 	{ }	/* terminate */
 };
 
+static int drmcg_attach_fn(int id, void *ptr, void *data)
+{
+	struct drm_minor *minor = ptr;
+	struct task_struct *task = data;
+	struct drm_device *dev;
+
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
+	dev = minor->dev;
+
+	if (dev->driver->drmcg_limit_updated) {
+		struct drmcg *drmcg = drmcg_get(task);
+		struct drmcg_device_resource *ddr =
+			drmcg->dev_resources[minor->index];
+		enum drmcg_res_type type;
+
+		for (type = 0; type < __DRMCG_TYPE_LAST; type++)
+			dev->driver->drmcg_limit_updated(dev, task, ddr, type);
+
+		drmcg_put(drmcg);
+	}
+
+	return 0;
+}
+
+static void drmcg_attach(struct cgroup_taskset *tset)
+{
+	struct task_struct *task;
+	struct cgroup_subsys_state *css;
+
+	cgroup_taskset_for_each(task, css, tset)
+		drm_minor_for_each(&drmcg_attach_fn, task);
+}
+
 struct cgroup_subsys drm_cgrp_subsys = {
 	.css_alloc	= drmcg_css_alloc,
 	.css_free	= drmcg_css_free,
+	.attach		= drmcg_attach,
 	.early_init	= false,
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
-- 
2.22.0

