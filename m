Return-Path: <cgroups+bounces-15703-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPmRIlep/2ng8wAAu9opvQ
	(envelope-from <cgroups+bounces-15703-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:38:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640D501828
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 177AA3004D1E
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB1D39937C;
	Sat,  9 May 2026 21:38:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021124.outbound.protection.outlook.com [52.101.100.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026439A81B;
	Sat,  9 May 2026 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362699; cv=fail; b=Ff/CbG7B9NlBqzy9ZKR01J/OCNLZ1NPtKdUb50Jw1GrsHJqZ7fUavvgS4+uagoqT/ixPIZus0Yz0gRnCxrRcwfIC+hKc5JvcUK2YksnCacl/VfH81Q+6j+rtEfZts8h7uuW7VaNUagsolzhu125PvBE8bAn4v93vlCpctn9J7aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362699; c=relaxed/simple;
	bh=uh20slUfdhqE7y2m33b6UYY+EklMaylyVK4dbkRwzes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rda6OlfN9ePjS7ja4gxdn9WIdV2LNcWEnar7m5rpIaqApzu4Rk7GSCSy/LIANRmEuI88d5xUL5pg24NIOyMMH6k/g3cg7JNEGE7zGT+LlaTm2lAM4YsImipaFERB8bPEkL2/8LJ9pjr9Q7w9bTCr4ZnwSJe2y2CFwOW+YtGp6Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hibN6Olq/Hhsk/v5OT9n4qPWp1dAHULbhuHVvzLgSALppXEPldYvAZ0rUxgjYFgs4epxPnfuJKRbe1uTTyPDfCeJpCUqzJA14P4eSJhUFvl+hu15Eaqn3MhIQxviGO+l7nAUHlXAQrLThpj7gD/ikZtp3A8/dijvFcdkrPquhVxwISjyJNvAAYESuJBDxDMXGtovCbipY3FejEt7XyLl5BCAQaB8a0zbTAWmr6gcsmBMuVBGLoaSdLH2pKfP52l5zyMF4vQmEZs/BGunMw3QLIp9KetwzZUnWFZ6t1jniQnS0bei/cNXYzxLH90+MjTX+8fXN+Cl01ZbyFk3tWPe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeAlbHKemalWGtQv9Osq6NfZmAxT8OeU7qJBbKaVQp0=;
 b=yKlJvTDl7KvBuOgEdcFrv9LlF8gyx7bPJqTyUlP8PjYeohd/IIfsETxJZyFvbjuqH7wORtg+Mm8bkSRE8rx8bm7FznnvP63MQafiKKOGs7vGvtARy5gkLEPz3+Is1mSETJlcp9FewAjm/LpBcaBNuuU4ljrR7p+JFR/okYlnPAgG5JSObYTpv/748dSF09GErLibDNUx2icNoRUWlOtSx6xihEcg6bKa5VvuV4n7TI//Yqmw6dXVPxFnJ2qMSFQPmvcyJ9e70DDEqPkcZN2FZoAfQUqjbiPvMSpEtoyJZUE3LO0B7WLH5Hji2PaDfkHmeUrkKEVRkyW1v6MZL+5OIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 21:38:15 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 21:38:14 +0000
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
Subject: [PATCH v2 1/3] cgroup/cpuset: Fix deadline bandwidth leak in cpuset_can_attach()
Date: Sat,  9 May 2026 17:38:01 -0400
Message-ID: <20260509213803.968464-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509213803.968464-1-atomlin@atomlin.com>
References: <20260509213803.968464-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0706.namprd03.prod.outlook.com
 (2603:10b6:408:ef::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: ec86fbe4-ce49-4a4f-9152-08deae1346b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AIRCb1UXOgIL2IBleO25gYgM4/AsTySNkTJWWDktuwFHMxWHQD6tq2tbr/jLIoyc0kBh6D60or3k7MPBeRfZk7vT5U+rzH+Y4/DGugJ1nSyh2eV+t7W0otmL4zNCYOkQqp5hDwTNoA8Fe+RARy+DbERS6ByzksI9P8dt5S38T7CC5zMKQPd8cLqEiSHCHZDFi2IoBN+q9QJpuQ9GJv/Wt6TLm5h74N6SjvXSRc4eQd/+TJxS8MT8T2OgJ5SIDfGqQ8hkxeRW1yAjxrjfFOEI8lvT4h/AaobZMFuDTQOY2btn1q83UpPE6MjZJhxp5jWGq9eR6gGHS6xGfq0mmcWF7snAeocXU0HdQd7TyrIH/1CRnDNpbJU8RoYfd/3RkJpwke9SJZPdNJs9jAohwWCz4LT3x8FOgMNyIP4MFgur9V36pCgZ52OK0L8L34zTfZsk7lqGI9bwZ6C8gemZ4DoznE8JyraH/TP3Wndi+J/gBnOWLFALbnnLryccQ+fTOAV7YhJ5oazSEqY/wVBr5DJTcsB3WAwyUEX/KUtFdZvMPwEKl1PJWlV4hW6bBEyrY7rgO+w5F8zjdTWw9nxCWahlhygtqxv5go5ctesNjW4L2kdg7/g1KUyM59yqRYIFCIHl9VAsHQXU7u40C8Na+rMMgqL3jjZYleABarPfySIwBqVZfGtYm1vX+PxK2d4efrIy7uObreLvi0OJRIdTF/1qPezjW2CdF50c33Cq8Z5QBnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjkwERA+q3N4wrvu9ocvDY41TiUDCMEyQ78zBVbxZJW1LRDpnPxPvFviVF9j?=
 =?us-ascii?Q?AbaylNm769NPdO1giqsfIbaY+Ftajf+VZxWUNqely3Bg7056/J1bnkDc8vnE?=
 =?us-ascii?Q?TarAXp7HIiMhzY7cI4QWiLVeQa9BCimvvKZCighjmambOxQ52x6ZCLZoLsjr?=
 =?us-ascii?Q?mSdRvtU6sG7UKIl06Zk5L4e4q445OcZpHwkytoOBXqBMOOdH7+lSoVIVVB7+?=
 =?us-ascii?Q?KPyDxl/s7NAl1ElMVDxM8sK64zLxMESqgSI2+/AmEw8VXRbGrpOexbgF9JCw?=
 =?us-ascii?Q?jOJNagGBRyU9Jde9PmOFixJyDtzNDNfIcFJSQ7gfvmj90tygTX1tZ2ULuPP1?=
 =?us-ascii?Q?mXUQbp/6+/oYUJSoJ408lerMUvXYiKZYkKDWFwD/Or7Ymo48IyNK0sh0j4F4?=
 =?us-ascii?Q?IiiAducVJbzeuRBXPgrnlFImU/V2+u6/lKMQ46D9AA3LQzOso2RnJ+iaF8EO?=
 =?us-ascii?Q?24hJ5snYd1iLS7bTe6uSzYPORfznHjVw6LMRmXvSte5BwKUKA+Hf7VzDvC09?=
 =?us-ascii?Q?+mj6RHHyNZMfZBwzOHyz8nW2i9Pkpfd3hXAeRu7jHu7wj+1AErmnzc8IGaf+?=
 =?us-ascii?Q?gzImSG/wdV8kxJKlF5ZfO+7oVNcaEMkOlCTxGAMIDCzoVQU2fHK1N2AU05TZ?=
 =?us-ascii?Q?W4k5S9TxIOi8oc3KMUboV4CgIe6tqzuJ0z/L0XDaVe3OuVzv3f0VdZ7rzEfO?=
 =?us-ascii?Q?jOqZl3roMdCn0q6ILhRwvCIN+H1Es66ZHbsXKciKc3gK1fFfHW3A6FIxYyNq?=
 =?us-ascii?Q?hQDZiKbecpYrOd95qaMJ6/16aFDsEUcAWf7YZTVevcQO6B315Y7mtq01cXDg?=
 =?us-ascii?Q?I8fxX0S6rUbB2VtmJqL3m4O/oJnOIjnNcZ5DiAsNIVkjt+nqgeBIg+qT928S?=
 =?us-ascii?Q?z8oMQJIt2W8SQ4V9xHFaIr6OnJMBjBJ1QqdvpWBSK9XGjxdLtzNeg1sTNboJ?=
 =?us-ascii?Q?FGlGQ1L9om1mzKLPp3H4wk5ho+qUIPil//rUFzxN/0RQqpnty4fkWFHwPH4I?=
 =?us-ascii?Q?K2vRBdaUFsoSWfRFja1IevKLbORLga6Nd8h5O9ZH6Sf/cONYvmE7dWN8kufy?=
 =?us-ascii?Q?+FlElvgHiSf3LH/SbpiBhq6eAdUp9petHN2Bp7BrGP9tZ+eEf2Z1hVqs/z6z?=
 =?us-ascii?Q?HphXeDUNJN9VDV0MbeffUb8JA6oKLQReBSY5jww//mibViMwIneBpGS00F0x?=
 =?us-ascii?Q?/NoQGyZhpdaPZ23qTa6q02zOJzvkAeLJ7vkI3M5sAQIpEoBnfZoAlY88PqGq?=
 =?us-ascii?Q?0f79Z+RA1cspwD4zeBjJzp5kZeuqmLt2K9uWiap0myQejpbty+dvFgapAuu6?=
 =?us-ascii?Q?lWmtYPP2vvBavmTRE/Wyc0l+cTq9Uf5dgodaJWn11IE0lOV85WZRBwL09QH8?=
 =?us-ascii?Q?Q9VtuhzXhgZr0hakSAmrQc1v4JCAjGGz6zyc22jV2END4//TZJ9C/q5pYbng?=
 =?us-ascii?Q?myr4d8aAq2ze25NUw5j1Am2+5N2QZyViyjsM1sjRLmmRYjt17lcAB1/cJTIb?=
 =?us-ascii?Q?V9ucWJA+Yyppnn8dJ4hwmCw3YosqBbY+KVKZOov+X6eKu6b3Izua8WiVaEuH?=
 =?us-ascii?Q?asd1+shKbJED32T58EzrqwqO9NBTpdNpkPukXu2qjCbJwyBH3n9F3A8MNAo9?=
 =?us-ascii?Q?2syIpAyViEzcfrNTiFOP2WS99rqiNghDmnWCAIbLKnrbhIVnXy+xOm24kuUj?=
 =?us-ascii?Q?HDoIMybfl9CiOixoF4Dy+DQ4BKvlrXs46XnpQ7fJ86luP7lZBcN0cACP0jgp?=
 =?us-ascii?Q?ZV2Gjww4Qg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec86fbe4-ce49-4a4f-9152-08deae1346b3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:38:14.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT9sk50yyFOwYtmGp7z26YGZQqktQ33VAXGBcqwSoECN0p+AQi6i/NkyJ2G92xUTfYd5np1uP0S6ymmdLJE/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5888
X-Rspamd-Queue-Id: 7640D501828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15703-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.208];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,atomlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

During a cgroup migration, cpuset_can_attach() iterates over the
provided taskset. If a task within the batch is a deadline (DL) task,
the destination cpuset's DL metrics (i.e., nr_migrate_dl_tasks and
sum_migrate_dl_bw) are appropriately incremented.

However, if a subsequent task in the same migration batch fails the
task_can_attach() check, the loop aborts and jumps directly to
out_unlock. Consequently, any DL metrics accumulated from previously
processed tasks in the batch remain permanently inflated in the
destination cpuset. Because the migration is subsequently aborted by the
cgroup core, cpuset_cancel_attach() is never invoked to unwind these
specific increments.

This behaviour results in a permanent leak of deadline bandwidth, which
incorrectly restricts the admission control capacity of the destination
cpuset.

To resolve this, introduce an out_unlock_reset failure path that
conditionally invokes reset_migrate_dl_data(). This guarantees that if a
batch migration is aborted for any reason, the pending DL metrics are
safely reset before returning the error.

Fixes: 0a67b847e1f06 ("cpuset: Allow setscheduler regardless of manipulated task")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/cgroup/cpuset.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..b8022f6e2a35 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
-			goto out_unlock;
+			goto out_unlock_reset;
 
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-				goto out_unlock;
+				goto out_unlock_reset;
 		}
 
 		if (dl_task(task)) {
@@ -3070,6 +3070,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+	goto out_unlock;
+
+out_unlock_reset:
+	if (cs->nr_migrate_dl_tasks)
+		reset_migrate_dl_data(cs);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return ret;
-- 
2.51.0


