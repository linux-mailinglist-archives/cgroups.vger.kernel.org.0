Return-Path: <cgroups+bounces-15705-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO+JK0Sq/2ng8wAAu9opvQ
	(envelope-from <cgroups+bounces-15705-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:42:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C52C5018D1
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15FE4303FF23
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180E39A7E5;
	Sat,  9 May 2026 21:38:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C939A06E;
	Sat,  9 May 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362715; cv=fail; b=AKbK2u2k+tjW2ZbS6dEyh+LD3iXkLewCdnFoJVEKn1xwRDRhqfW4VYOL0g0ucJ5l+nyxC6h8v3HC78/qcaCYrAD1Kex5SwJicfZy77Jdh05sAheXYxu+d4p9EqYpGUJTg+IF4axPGbKfDibdFdjCBL4LiRMiRqlXmiHLuhEq79s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362715; c=relaxed/simple;
	bh=gXW2tVK2rJvKbLAJlvlVKysbS7f/ATAI7+8OxIqKdw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r01/ro0ayVDSFDtOoeW5SSFiodhDsJqBXjdhxa1mX71bF23gzoabOIcaJyoEM2+5e9LYmiX40DtsOOf+ST8cyuoyFC7SnOuiVcBzTXwZ3SybSn028VL4bKHbCgm2HeMAndLOSPPakQxcBRDtYOg0cBpOMSu5kkUhe97a31jpENQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEz7NqhLAP0eWCRzLaMgfKZCOVSp1dNiY01FQiYaCgxg9JFan94Bh0x5bVO49IotLgONUmhiZSQ32HaM8US+nnUdInmtC5o5/TTqk8AZCRp8n8gDLlUZbCgxwpELwc/O2aE7/5nQ7sfSfg6wNYE+awMHITVzyRXef48cezHsFQax57yCIOjESFI2bSRqNpCOL4DgdMoX+l8c44M9qjCOVER6UDrcTALMnSvP/Gkp9YuZ3je4kBqjApWEwAa6amDyd5uqzYCTtCsU8xXuHf0LHcMVkBj+/At3OeJChceg7Pzik3iHnNP0MzYBo9iE+WN9c85UNI8uA/AmHEweut/XXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTfz3Hj7ujVDdcvZYOI+m/9GV8/fXk4bGlAUsh9uTKc=;
 b=WImePblvfYwKwhR2eX4vZWM4tDzGZPUbMgAvHOUFKOEY646gT3l/Ys7Ty69LZWRQwsRibk10JGaF3OFmYOpFG2kNScK3B02pUEcRx1Llr0jonXdPD0z8t0qVlw5TP5p6hiB/IeqGPwWc8zoORzucj5lsR4FW4o6bADdLcbdiQNQ1DFVowq6kAqWcHh23k9BYMTaytnz2JnOIUz4NJDZ4GbU+b8jqNzCMRQWImk3+BbZS7ijd+96TO94RfQB7xdhF+AocOElvS/ALS9PEkdF7TwKQkowx83Yz2sDF3YyR3oXZUd+TCEOO64ym8GeWVKPkdJSllgElxm84SBys2h3IEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 21:38:22 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 21:38:22 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tsbogend@alpha.franken.de,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: chenridong@huaweicloud.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	omosnace@redhat.com,
	kees@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	chjohnst@gmail.com,
	steve@abita.co,
	mproche@gmail.com,
	nick.lange@gmail.com,
	cgroups@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Sat,  9 May 2026 17:38:03 -0400
Message-ID: <20260509213803.968464-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509213803.968464-1-atomlin@atomlin.com>
References: <20260509213803.968464-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:408:f6::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: a204499a-417c-4622-ee2b-08deae134b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GpD4ssci5kzb4xPkoDw5ISube3AFq2KFTAEIlg2Sz1xss9+8iXVDTDlRdNQLuQEh/Lwk3GWpSeo+oVqYQOmnnifBgDLa9AO8Fdm3oUZnG77gs2OJ2s4Oq8ma/cACIaDxKdmVJuYqUh2TB27yxBBMvo7Gu1RYOyYiZnt8OEP/O5Worg6YhfldfcHAcHe2oBd1EwT8oxIp4pcDbpDHdyYidI8pnlK2ty2pmDqmUbhh8qyXjqfucbyKTOJKCsNgBZf4IAHBySjQqQWr0mkg/bBV6DZqDH9dsPmhw+8IFZUPWRi4qGobaXP25PioEjncv4rKgOiwZP9ZOSbL8M/jyCp2ggHO2ZY3hDOPb3kS0eay4y2x6Nzskl75evB+bxMfWiN7R7BY4n7y0wQRdPfYCtkaidT6Hh6NrdWpoc2sHJ38+aM9sokg0O3gqKFNcmpT7S3DmAaEUOAHYyLcEbo3IQ9OvfYKixddP4Gu92ZcD0FVLC6xSFbdgAX9oUNycNvnOx+RdlZ/d8oRiLOl2MrRiQuUS/cNSd5sd3nIxbCHK5iko9khS5lcntrO0UzhmVckzOXRxrS96Lsl2A5ZObOU4QrNab1u87lqNp7kjVYZcdgOzRsrL9wqgQbYJ6vZJyqwbbXJsugWTkfgl3j5+dsmOpQPoRdzzjxSGIeCC0wcMAM4ZaUX9kpgdGgivIrx9nCsJ2h85UR5q6F3uXFnoO8Xt6QC3/cUUiIkhJnfZOXjH6s/r08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ARD8GmRRRpPSXJ0CFYzT7AjfrCJkkIUpZFGbx3LHvEk3YYz/iiZbJG2OLRLx?=
 =?us-ascii?Q?PRA22bFob0+sufcfHXBQs7gGEKILp+DlG1lRrV8Qqre3nLCuDB/xa0z0L65R?=
 =?us-ascii?Q?QkaabB3pG3l0dWkeuwTStPuL8nAudVvRPA3sGzGPTFylx9sunDf5eH/nl5Nd?=
 =?us-ascii?Q?rf5qxW2ahLpS5zKHp0mwSedqM3FMZvD1qSMyYZKZOAf0fDVw0UgtkpYrCkva?=
 =?us-ascii?Q?OJ0Uw1sEXiG3aAVT3Mo9tSjwd/fJKFYy+XlmpwHFrHAjiFRdHmjik/KSQC40?=
 =?us-ascii?Q?J6A4Kp+lY4wWe7ZufX18z//ejETze4uv+FnclJuyhJqtpFWk9J2pRDZfzcEJ?=
 =?us-ascii?Q?OMZksXIBIsTm5YNYipymm0hGmc8Hs57WtQErYATVs3aZo5lqUDMwdO5H/R9L?=
 =?us-ascii?Q?q4/TdMRq+priM0h16i3CORYUYjbh1rI5PI8uLYZ8p1FTu0FW02RObn6WRVUY?=
 =?us-ascii?Q?RgMhzyjmUIF7CCpyEfHaxeUFQM5d3TJNpj2YS3qtG66ZHP2vUzHLL2yGVXwv?=
 =?us-ascii?Q?B9sbpyhPDylZqFd6VPppXkHiiS2RmQYy4p05ZDASWm1PyYTUFYtOGbfOoPjN?=
 =?us-ascii?Q?uxYgxHOtpNyUFQKPIaAHG8879OxP4jE0xBSVRN64Q0LrYk8qhXSgF7gM4MPV?=
 =?us-ascii?Q?c8A4GIdo+IvVyX95vxJ9Lv/OYbfsMjwUVCqvVAp2+BY9VS7CQW2yzqo15FJj?=
 =?us-ascii?Q?M8lFG00QOlfonjDCMPK/hEQVIAv0BpNJEUJj4iWxRW0YA4G2lkHucwqgab05?=
 =?us-ascii?Q?H0dN0TDeyFfKfhrX+GO3BsCHdTw/VIX7t1qJU84qRPs6cIMg9OXC4R5ixltq?=
 =?us-ascii?Q?eMt7p/yuZgfzcONJRR+2z+pG/J0O3EMlJoDbuHdrmhdGLf1G/xS49VWPX98Z?=
 =?us-ascii?Q?fkRLrKM6UJyCQZluTcO0j+fV8k/TnSJyVKhB+A1qTAiAKtcruYB/Khc2vcBW?=
 =?us-ascii?Q?SQ3qGiNNSYruQSMCAbShpVPMgvgOmeXII/UlMtTVA4H8+Nh9ht1kiG50MdGD?=
 =?us-ascii?Q?KyZSywTT4JRMQWkrNLuoPtggkhsB2yt/eTaefbP6lVfMRth7kdl3Dy7jFns0?=
 =?us-ascii?Q?YjOcCQyVqhHzrkC6yhMb3utCLnKKusER7ILaiyv5F04uNf5xR3bdiIjPHXkU?=
 =?us-ascii?Q?7Po9tMS5A6Te5+fxNFF0kNgMDlKJUHG+xbuopx2fWhKAJ3misrBePqYdEVMW?=
 =?us-ascii?Q?SDme7tTCDJu3eEj0zhg7YJkuD79Flwbuy3YVaDb7TitLCgMISE/chGPieVev?=
 =?us-ascii?Q?NJTXef1u6Hth0c9vT9IvT0RkNHaAZEhZvTE+ZyeJLNjSMatCBAy8vCCLr9yr?=
 =?us-ascii?Q?jIsCk/yVwDAlJC4wUfmlIGS2rvGt5PoYqRyjAq63TYbz5x+J3wp3XNmA9RRo?=
 =?us-ascii?Q?RdCSfAq15uAVlHkhNK8q662MaLg2lTYnrFEDhB8wjbdK4OsOZWUKBoligJ0Y?=
 =?us-ascii?Q?53VgtXUwxTtyeFsy2cWJPPn7T7hO9yLa05U2ZTETyHRIk0iBmt0ziIk0QJE8?=
 =?us-ascii?Q?GOlnUSLoToEw/NIzo+XvsrZ4ssuBURcntzvcpLOl2BicFv433MujF5Abrxlr?=
 =?us-ascii?Q?2Cjqi+zfH8Rpk1V/BamNkZ7hUt/B7L5Sp8V56RHVUjSTeWCIUWPP+lUlr78T?=
 =?us-ascii?Q?LYjBB5GJqiUUystUztNnwcJy1YMKM4e5LhfLRhsoRLYanPRQKGEWtIdNf2BZ?=
 =?us-ascii?Q?1/t2JeDuPD/YZnYrCBb29kol2P0lQ4pF55bVe0io+ToLxwr7SvxHj7Hsxka6?=
 =?us-ascii?Q?pJkboHTMlw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a204499a-417c-4622-ee2b-08deae134b41
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:38:22.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVYC+Ee+mMtkrdwocnsqDqEmIhdLFgA0M+SWtjZ/rLJt4rDBt7x1RfoNyi6LnVxi6Vcnqy80387WkDbbDOEoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5888
X-Rspamd-Queue-Id: 1C52C5018D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15705-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.137];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atomlin.com:email,atomlin.com:mid]
X-Rspamd-Action: no action

This patch addresses a critical memory management flaw.

When CONFIG_CPUMASK_OFFSTACK is enabled, cpumask_var_t is a pointer.
Consequently, sizeof(new_mask) evaluates to the pointer size, causing
copy_from_user() to clobber the stack pointer. The subsequent
alloc_cpumask_var() overwrites this with an uninitialised heap address,
discarding the user's mask and risking data leaks. Fix this by
allocating masks first, and using cpumask_size() to copy data directly
into the allocated buffer.

Fixes: 295cbf6d63165 ("[MIPS] Move FPU affinity code into separate file.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 6424152d9091..7c215372c5e8 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -71,17 +71,23 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
+	if (len < cpumask_size())
+		return -EINVAL;
+
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
 		return -ENOMEM;
-
-	if (len < sizeof(new_mask)) {
-		retval = -EINVAL;
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
+		retval = -ENOMEM;
 		goto out_free_new_mask;
 	}
+	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_free_cpus_allowed;
+	}
 
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask))) {
+	if (copy_from_user(new_mask, user_mask_ptr, cpumask_size())) {
 		retval = -EFAULT;
-		goto out_free_new_mask;
+		goto out_free_effective_mask;
 	}
 
 	cpus_read_lock();
@@ -92,21 +98,13 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		rcu_read_unlock();
 		cpus_read_unlock();
 		retval = -ESRCH;
-		goto out_free_new_mask;
+		goto out_free_effective_mask;
 	}
 
 	/* Prevent p going away */
 	get_task_struct(p);
 	rcu_read_unlock();
 
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_put_task;
-	}
-	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
 		goto out_unlock;
@@ -145,12 +143,12 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		}
 	}
 out_unlock:
+	put_task_struct(p);
+	cpus_read_unlock();
+out_free_effective_mask:
 	free_cpumask_var(effective_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
-out_put_task:
-	put_task_struct(p);
-	cpus_read_unlock();
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 	return retval;
-- 
2.51.0


