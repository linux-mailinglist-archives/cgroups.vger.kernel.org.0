Return-Path: <cgroups+bounces-3490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CD9238B2
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2491F237CE
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01854155335;
	Tue,  2 Jul 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jbDyxQC+"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF21552E7;
	Tue,  2 Jul 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909984; cv=fail; b=frpM+RepfRX7fly2iDgaiWrwF/FIlGLzbfwUrc1zXf7aT9zsxnfOO/l/h4Cp8e+z4OK/bkHqfUmZkxatkWggzcqqqF6O6xHv6H8g+QZ6cCJ3M6y3BlwojmE/1kVNpBk0BpNqnRJ6UtkONqNstrSeOnR6Cu8Dcv4DA0+rHkC+QhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909984; c=relaxed/simple;
	bh=Tx3p0Zwb2La6K0c1322gFWoGWJDZIThUbTNXsuKF4ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoisjWWDpbkF6TRE9f96eXc/4cVJCrt15hIS9DXZudICP9T7XUSpfw7FwfD/+5yhONoRDSxmua1rtPSYSBqW2W5MAS57H1Dfomeqdc69BMgzIt/T8jzIvm/wS3QAgE5bAXgJJOmDD/daAqjvwx8zFMUjR00/0h5RcVbQYqbWKJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jbDyxQC+; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J89eKsVjJVafsKba0ue95qSrgWkHY/NfjpKu5FkaidCshw4qSUuviuh7NGddXzA6s3pqsFFohWrmDaz97YYjOPF7hai/RVyTD7r+VRsKximo/GksF5p/ZZaFaTtp7Fkj1tzJfRTckefZOcELfRGVSg5upPtbr/YQBPgUJlDpgoSt/VqqJj4FWqQFJAJpYpJlQQXSQtgaY0a9JZ2oOZbVH2LIgwL1DWeqNtkaBA5dun2j88+SIqcgV3MVI1rn7bhWGo+/h3/q4mxmIzwZDd6FRLOo7vhxLAs5jCEOG+iw+R3oIrxuNTQjQCBbt3dAd7pPk5g1b+H1/Z3IoPZtftuHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wayXX6if5q49kSH+e7BH2GqjBW2PQyGEKDlKzSgTM/M=;
 b=GzE6U8GDjkpeKwdzvJMgMAelLrT+IiKm9e5HzN4LAzseTAM9Z1BJ5oZ+Y7h7dyzk3+zz9569X++cOtMj1OD7G/M/1YwqeeivUj9NL2oYnyHMBgtBGrLH6loniuFZiSMMz/q9A33QRo3GJ8Md6MAxS3cUlXdsEaA8o29WRtS50g321bzgjrSDC3fbehKJ5HqVJubl2fx151BqcRcyfsxJF3Nmk4Q3zKzxgho4fAEVyM8oz0zJrDUcLJVAfeFQakV2HykxiFgFNOqQvNQ65y1pguPOD9/NbgYMF5mpK64dDBwi+dM7Eon2uFMiy3gl/4ZMSDN5H5ZEwWv/nn6lUg2PTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wayXX6if5q49kSH+e7BH2GqjBW2PQyGEKDlKzSgTM/M=;
 b=jbDyxQC+prZBsQ+Bb1fY+q59ALKp3VoiOI12VUaQGpE75r52B/+htLdIVeCnQNUgKqaacaF/6HhWB1I2TuHd2l5XoxiozliXXp/A643ztyUPlbhEYVs5wJRIpx9Kplx1/PM7dwQjdD/Gvpqe3DCVbY9RFCk49t1URN6/QJl0qXys7jG2CGOLXwyX9zzykd5bHbYCgNcANGWVTg/MIFONn9UHKcYASqBpfgOn+D8iYiYb5hKfNS73H42QaQIycvEF7iuGXlV/Ce4s9bkCLbXLKkZAmaP2fzOL2895x1tBmUMhC7uVG46COfWqf887BvTvv4beX6mcl5+x3WRsuoYbwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 08:46:20 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:46:20 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Huan Yang <link@vivo.com>,
	Kairui Song <kasong@tencent.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 4/4] mm: memcg: pmc: support oom release
Date: Tue,  2 Jul 2024 16:44:07 +0800
Message-ID: <20240702084423.1717904-5-link@vivo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084423.1717904-1-link@vivo.com>
References: <20240702084423.1717904-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1a0e68-ab3e-4099-7ed0-08dc9a7371fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsqpTpPI6N2WGgg0iSkF+In/Pxw7vcXP7rull1Detp3BnAezK6peCymBMaYE?=
 =?us-ascii?Q?4BTFC6VUgTVrFrfSdpv3j3OnmhBlaItao8IymvyMiZta04sqX5geHlLQrPei?=
 =?us-ascii?Q?CvpfB9BZxggphQxFj0B13CyQ1IcW/6n8Rr3dmscfIRVkKfxwc1Qm/uCaQ8JA?=
 =?us-ascii?Q?uPP1fmtxqkUW7kKqOM1rPGhanwlCUIVSKXEwu42ZIywJdRAh0CqACi7cnsMw?=
 =?us-ascii?Q?0J72BSgDFph+0otu3EnaBqT8IAJp1bgcGzu6XgewjGax77qA7XONpmp7r1GL?=
 =?us-ascii?Q?SQ+sc4gHSexyEMdxYmPj3fjUF6Ftjx9hBPY+YmhRnQpLIicquovcuTcMVFSw?=
 =?us-ascii?Q?M+6i6UYQj5uxuI2FqThOeuvRXOmFRcSgel6nWqrtHyRJ+k93lm4bJj+JiLfU?=
 =?us-ascii?Q?vQgJAuyaRETxJVoAyq987wSmodwxYIkUuL9VqRilkh7sPn8hfTIkvDa41pgj?=
 =?us-ascii?Q?zS7TslaCVrVgzSVBfwI+t+CskecOyWG42lcABFw4l16ai+RxNS/CI/xyePVe?=
 =?us-ascii?Q?/dByfkzw4uc0TM2CoRiGFFPMs/QYEhbxSKbR1ja+t4kbUYqWE4CXbPoAG4o+?=
 =?us-ascii?Q?n4GEmyiNfQyVjqjZV5smuauptrRJfJzW7xIi4rYrZLLKi7ddAPKbxhA1crli?=
 =?us-ascii?Q?10kkLViiKmQ5WRA68a7ANoGaJNl+Bdz487InmmjR7fWscyO3zsLdICv9+Wz3?=
 =?us-ascii?Q?rTYATn3cFobDUgXlHQ93KRVUgKcD9EhRvIKmTpoU5q1QXS8C51vlN0L8kW9L?=
 =?us-ascii?Q?O8iwVNR+b0H36stJdheAOBLr6A4g34DllIgz2LxrGLa+gCuFXXRRng3FpPIM?=
 =?us-ascii?Q?crkSsh/Z9NNgUP3B7d4zDgzBKrHNFOPDrVho8uAQR5cT7VBpmIiN+2otuTj3?=
 =?us-ascii?Q?xye7GJcty7PbxYb3eOk7GeaOsJoDc9XroVRhMixenYQt+2RPiUspsRJS0DGw?=
 =?us-ascii?Q?cc9lqCryrG/E2SfRN/DktqjhbjyPEU16mrc3HCCcZvYBnUKgYa/Rx4Z7s4Dh?=
 =?us-ascii?Q?w4kB3fBblsQvAs6p57QxcsXQYwnjKsrhQP76LH8E4OhfuCI73EidLSOTdac5?=
 =?us-ascii?Q?D37a7InU1rU+MHaHDGx1iencOn7C9QuDSlCCstDJKl5pSZJde33CrlyVi+BZ?=
 =?us-ascii?Q?swztEX2ymA2J+oNWBj7YaYpmtQQPd/AIxJZkW/ZL1mWq4LRwzv0lyYL0iKXL?=
 =?us-ascii?Q?NSk1ZrW9G1TXl9Kr/VbZzmN/UbDrJeqyxi7oLTf80kuAlKGr757JnHMvNoOg?=
 =?us-ascii?Q?dARgEh3+UJzWeTIh9IZtvYzce2SndrehSFj/QqC9rsg8ph/CnGYJ+82MRxiH?=
 =?us-ascii?Q?Jqn0czHyDVIq2Qewtukhq9+lFDhjrk+vXCo/Nhw9WmnfvrB3huyslvturCbf?=
 =?us-ascii?Q?dYC83RR+zRrio16D5qzzcY3h0rR5+zQrWDRgDEq37NgJxjmchkF/UEvDNUOQ?=
 =?us-ascii?Q?DrvMsxCbcho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G00yIZH0KEXv5OXfIs8l6NEO6NXL/A61iR75yv9JrQ4l9AbLuHyffUj7a5J3?=
 =?us-ascii?Q?d2gY4FFKiG50arGFekXXHwmcwiP1TVEfJ5+X8k8JaqIJxEpkrn+2MQnmtIKb?=
 =?us-ascii?Q?EiG26ITnRSNlhBjhggQHSl+hdj8WUR7tKjC2qAx/m7RoM1rsrs8KFH86Vb0t?=
 =?us-ascii?Q?6tdSk7W+AAowq/LfC/ktSMvcNnKQa1+L+qUsM1iqyXCII1obprL072SPiPYS?=
 =?us-ascii?Q?ARlvA6iLrLKNYhEMSbOUzT7wA5DcqCLga3rSXvefwjQeowPJQbbmdt8SnEk9?=
 =?us-ascii?Q?S6EdbcKT0AzGya17bOURMeoo7WaeYAWOA6UCBCKpDXZhY0fToSzqbwqO1hSb?=
 =?us-ascii?Q?SxF4paYKYxZ8Ys3QguAz+K2dBqqC7OrC8DujIUwT4Y0m485VLXTvVtqH3YQ8?=
 =?us-ascii?Q?f7gCa2QAN0Nk0jtHCnZw+pqUdnISEoAp2Kocpz32oDfyFPBNJvPfCZfvh5iI?=
 =?us-ascii?Q?zSO2U15w5fgcPMIndPcVppPhD1a5625W2n5hn/uaKN02jA+97hvrCttA5QoU?=
 =?us-ascii?Q?ft2OyxyAwND0cOPUwSyrf754LWRHAvGz6vswU0/eqmeFpbRpmEWcbqX/vLB4?=
 =?us-ascii?Q?xAHjOQCy7dz9OMMDD+hh4RVeMk++XHoB7pk4U+bo0ud7e0ktqiGtK0FCTYKb?=
 =?us-ascii?Q?ZYg/a3XhHMypbn8xtHyJZaE366zSpIc9t9o8o9n0nL+kjzfLxx1ILNwQ6oLo?=
 =?us-ascii?Q?BgV8WwmcppeJZmriG45r3+UL8iPsJxqcmXDDKYCVDh6MrgpnNMpvNRs9clGl?=
 =?us-ascii?Q?ZWRTuJrHlPlARJWIOYaoQAuhMZGkCAHQaaKGhinKXekj2++hFYrm3lq1ayAu?=
 =?us-ascii?Q?2iEbNgjprj9jYb1PwPEUDjWU4YOex29tH1k5T+/fyLvLBaPvyuCsbmUy3zwJ?=
 =?us-ascii?Q?Z7cy9x2f+pODrkiCD3PIntCpSMwihFOytiOuBnW2aZARey2Onmy7AfZnoRPl?=
 =?us-ascii?Q?iiFz6cuyjlg1dePCg4pvROMjZulm9WvB69IaVNruS6JhxEe179k0jrg2KJwp?=
 =?us-ascii?Q?/Jv4m+Ucu+OYTD4v4PeRJCUMb8yeqU5ZZVCxDGexGNRxry9ris3Cd2GlkRPX?=
 =?us-ascii?Q?zJKL43BgbsXOHsHj8IFLskUiCy/Xu5GkA3WX4kHKSDb4sdCnMvUEFSh6DGqI?=
 =?us-ascii?Q?74aqL8ZM4q5khl66VaGGiKE5yNzpD+kznrzOnrIOFOkGeJVpAMRFVfj6DXfD?=
 =?us-ascii?Q?/AkVvDq2oRY8DXP5jkks9u8pdmy16PSnd9KIpuNAzG7TpJrdhBt1BiVzXRrq?=
 =?us-ascii?Q?de6vaDcRgo9/M8QkXYsDXU2x9cdvzCUDUr1nJyEDj2tq7h54ffeXv7asqoP7?=
 =?us-ascii?Q?gSJz+YLRsGUFyKVSVqpw6ydEAttdptNFTxm3j86kN63QsiqTD9KKSP/X8DlD?=
 =?us-ascii?Q?H39+/lAdnGHAv7HtB8HkfFSOsiOX4Z/AU3lTUzLMKjQl18ZSuWiRGhPRgoQH?=
 =?us-ascii?Q?jkHcdVXzhyy0rTAjCzuthXBXTgkGEtKfm4gH/A+AyZpT2qAqUnCDuaNCB6ZB?=
 =?us-ascii?Q?6w8PSH2DZuhMK75cmRRK3CtpfXHVNBG3tmeP3Ns9pYY3m6vE6hKCBO8ZqBDE?=
 =?us-ascii?Q?qdwA+zWHWkPl98DkrvkqkTvMPWBgApWyp+O0YKGP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a0e68-ab3e-4099-7ed0-08dc9a7371fb
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:46:20.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzEupW0V4BOAb11XvdtEl5741crWW/za4brGf8wfDzJOF1VhuEWE95CWnRRZ0d9S8GmZWXDn1bEoyugO4NVe2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790

This patch let each enabled pmc's memcg register a oom listener,
so if oom will trigger, release all hold pages.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/mmzone.h |  3 +++
 mm/memcontrol.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b56dd462232b..640a9cf51791 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -622,6 +622,9 @@ struct mem_cgroup_per_node_cache {
 	unsigned int reaper_wait;
 	struct delayed_work reaper_work;
 
+	/* listen oom event, release hold cache */
+	struct notifier_block oom_nb;
+
 	/* max number to hold page, unit page, default 100MB */
 #define DEFAULT_PMC_HOLD_LIMIX ((100 << 20) >> PAGE_SHIFT)
 	unsigned int hold_limit;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae6917de91cc..3dfb2a17c1fd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7101,6 +7101,33 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+/**
+ * This function listen to oom event, if oom will trigger, check and release
+ * all holded pages.
+ */
+static int pmc_oom_notify(struct notifier_block *self,
+				     unsigned long notused, void *nfreed)
+{
+	struct mem_cgroup_per_node_cache *node_cachep =
+		container_of(self, struct mem_cgroup_per_node_cache, oom_nb);
+	struct mem_cgroup *memcg = node_cachep->memcg;
+
+	unsigned long *nf = (unsigned long *)nfreed;
+
+	rcu_read_lock();
+	if (!css_tryget(&memcg->css)) {
+		rcu_read_unlock();
+		return NOTIFY_STOP;
+	}
+	rcu_read_unlock();
+
+	nf += mem_cgroup_release_cache(node_cachep);
+
+	css_put(&memcg->css);
+
+	return NOTIFY_OK;
+}
+
 /**
  * This function use to reaper all cache pages by cycling scan.
  * The scan interval time depends on @reaper_wait which can set by `keys` nest
@@ -7176,6 +7203,9 @@ static int __enable_mem_cgroup_cache(struct mem_cgroup *memcg)
 		p->allow_watermark = DEFAULT_PMC_GAP_WATERMARK;
 		p->reaper_wait = DEFAULT_PMC_REAPER_TIME;
 
+		p->oom_nb.notifier_call = pmc_oom_notify;
+		register_oom_notifier(&p->oom_nb);
+
 		atomic_inc(&pmc_nr_enabled);
 
 		INIT_DELAYED_WORK(&p->reaper_work, pmc_reaper);
@@ -7222,6 +7252,7 @@ static int __disable_mem_cgroup_cache(struct mem_cgroup *memcg)
 
 		p = nodeinfo->cachep;
 
+		unregister_oom_notifier(&p->oom_nb);
 		cancel_delayed_work_sync(&p->reaper_work);
 		mem_cgroup_release_cache(p);
 
-- 
2.45.2


