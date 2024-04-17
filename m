Return-Path: <cgroups+bounces-2562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C808A82FB
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B97C282532
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D213D265;
	Wed, 17 Apr 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="qH/4kJZ7"
X-Original-To: cgroups@vger.kernel.org
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11010001.outbound.protection.outlook.com [52.101.133.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE1AD48;
	Wed, 17 Apr 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356226; cv=fail; b=c7X7DCX4JIceEEj2QQF8l8hYXknoBW2iCdltXwUpqHs+NvYkrkgV1qxS3Qsyz1Fy7t2Bx3vvNPICu2BfTSGRvffO0GAQJSK4mzJXuRHSOvhZVFFTsxdYyLA4QvgFQ8ku2hzX9Bn44ek26vigq5MUZPAx/jtrtkTMCAj9dAc/B2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356226; c=relaxed/simple;
	bh=5vZaJnzNKRNuSVCtk/9K8Xc80wWAA5+dNHRXNRgRIsg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tOKJY5QLYCvmnI2i1y8ihXNPbFGqdW7GOUpKwKc7hAYwrmzNlAPBXJPoDPsRI8ULHOqZIgnnqgyni9qcWrCkhcmo3u6Y6I8YmEpc+8EXPat6yV5fpJGEHwbAinTw8NmPaWVn3IaG/QXfr9c/3/HuYsO+FUF7KWi6+ySvY95H8Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=qH/4kJZ7; arc=fail smtp.client-ip=52.101.133.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IarjhAa6+ZqLzk8JQa0lJajSrOVzq4U419NcJG0Uh4+DJh1wYE8odxuBQps0A/x03C4e6Rcb05WqBLaxrxayaOKExtafWkxqyJQAz7m9dNwlsA/qtLNzm7v1MJGoDrZSXHDaln77pAlMO68OFvmkPOP0+6xjtptLrlsZSP7t7vPX4zH0QulduO88Qb45PwOgEwKvVyeqjP3FJF4C3ToRZteYuxkfKECn1NzGk3lhJ0A+h6iJ1QlNOSRJfQ/ByjWJPacWdGHt536XJ/CotMFK6bstQS5HfkMUdRxe3dJuJhoG6AEKFq5/Vo7AqLVfzv7ktYNZ/l5LCkj7cKsqvE2BWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN/TLqWiURU6FvAdsFHOMsM2Avn0GS+z9GOWIhhfiIg=;
 b=FumKtw9c755YkjYO+8bmRL7Swzef2mJrbvqgMlYZ6dJvTQmnl0SfIUTpOgwJTERT5isLa3g8KqmJ5+bX/lYVtyme50FM62DmXSwEhnHXUoFjLl2AcT1sPX6yrXWEBVAk9FnITbnM72jZKYRwLQdsHksMpCr1WAUnLajcg/vkK4Mqiocn4psNFzL1BWwv7Q4Mh6GH0WshmEz9o3VD3SRtXR5I1rANHAtCP1yJvLbbq9O2rz9tZpnkzjTxdvaVewiFHza6U1a5UX34izzMIh4VGkj67Vc+ZOezTmkPFPtoq3bsevnlqpSZgZWbQI9xZPycWFZ+LMPvxNn+JpWiLVuTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN/TLqWiURU6FvAdsFHOMsM2Avn0GS+z9GOWIhhfiIg=;
 b=qH/4kJZ7Sug9rM6boBupRI6R2afKiKKc9IIe6HuQPr3RTBHmvu/jyOoCm8oAjmFYpn137MieHhM7TIyhnQVxsBT0Dw5Pa6Xo/DYHVtRSRgMITUC5gKiqM0mUdlm1Q6oZ3/FiQCRbBZZbkKKzd8prJ0g9zlUrlwM0rBLqMx2MxKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by TYZPR02MB7842.apcprd02.prod.outlook.com (2603:1096:405:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:17:00 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::b075:bc43:3d06:c6eb]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::b075:bc43:3d06:c6eb%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 12:17:00 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix the comment error of memcontrol.h
Date: Wed, 17 Apr 2024 20:16:45 +0800
Message-Id: <20240417121645.25355-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|TYZPR02MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8eb1ee-ef1f-448e-8c83-08dc5ed8482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r0QpfVy9vg3VWSLUEY8vO+dc66274yVjUQUPRAtWgqtQs/VIiklVkSWte+lBm3AotL6/WsaaIrxIBo6XKFMBJiFbD1jpvYkhDKGm5gilDSF/hkHhqp10yGFLo3vAlCrGfSMpgODEuKUVkyq5ln3wkb0O+wPgLpg+O1GUBnFJcWnWvOZIl4cQ2GtyvBpjZWRqMz9Gkdm58koFxPqxzbh3xhACWuDGdox3+Te/xWz90vmY6vZgtr33O+nFFIP/ce4VMXpd6QLEsmymkH5PxLWWq91IBIqP27hfr1E+Ft9uYyPsVv0iEm6OK6DHwmVhPxiyc1wzc43ofu2g7z/02rY/NFUf01mTJn5/Ni2qzN8InmVsNQglkWq40+yyT8qDdQAOlEEk3FI9wsfySpfWdp5gs7fZR6FIC4PVY1SaD2pqnpfQUOIqUBzMGHp3jrhw5ymeR6Z9oc+QqL/2CPKQGKqdZpffEjpFTsYLhaelQWjbpSIzPo6gQ65i7FdqTdydzmApgoxKCx9i0eO1Wx7qEPNEaGTWJIYmLcX++1+RO0TWSlaV86cIvVAmd0vddVC4gKoeB9OqZ4AqkOf39YtNzZcj/l3vMKWSUkNJRe+IQkjR3NB4Z/mwnkj1BHlKWDei7AZLItr4+vkliUIZUaroHv0vP9F6a0BONPcL3G4MP32ZPIO+OndqddZ9s5Lw8qmmReAdzdZQVU/Rf0bPSFbSGJhEkpZ+dkc22x5xpqnoyJU3xAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCdB/YCr1yEeEjeEjHxYXFjHYK6+w3yzzwSzq7vcDd9LEJLLqCz+OUHei2Ql?=
 =?us-ascii?Q?gOkLruOtNVsuXCkEueFcSrfnXt7eYXmxWURQLFyvwNFLPQNHz47tBlAhI8o1?=
 =?us-ascii?Q?lnFd/mRfO/nUFDUr5nSGEJk6csdIKi8C4gbhPJcHe+abCg4YWZWoUri5Ip3F?=
 =?us-ascii?Q?z3QLOMsEZLvpgPe22Pybv1tbpbGJd1r8LuCEVlfWwaprDFqSYuyPXan0LfGw?=
 =?us-ascii?Q?ePWefot0p0jVihroJ+/VgBNxaUTGynWNbqEypz5hhytyYHfR0Gssi3shNANs?=
 =?us-ascii?Q?MrVUZYczyuGRI91669zY9BC0FkXj4+6UKpYrSzr/6r3oXidy3FifDydqq6DG?=
 =?us-ascii?Q?mSXKsjz5BIOQIvbCY+WcV0G2EKrDHcGNgp+f9Zafr0aBufUx02UFGsnk4JLQ?=
 =?us-ascii?Q?nSUFL00vP5j2HO+jyj5nf9FLzfvR3ngtZWO3q1iGbixgj+gdQAhX5iLTOCs/?=
 =?us-ascii?Q?aKhXA1YpIxeubXvd3wBPcVSgHgQ5yZ9YgPZ+RrAJQVS8thyy/h5p6scSFljX?=
 =?us-ascii?Q?qbOi0paY35DgmyxkEkDFL0Ht+48B1XWdEN49oengA/SjvxWmnRFv02Np+rAG?=
 =?us-ascii?Q?/tBx+dBj1s6BiETMeTCD2HWA+rUZL7gHW/WTtvhpeuvSUq0/zG+6rvrpGHPt?=
 =?us-ascii?Q?mwK4d3JBhQyYkSJXC1VoSUARQ6F4HnlJJ416HcxwOXQq9wK3qikofq0/HuBW?=
 =?us-ascii?Q?FM8MaOn5bRx4i5xq44bvdMa7xWtRktGPDjl5oJtjjRRVHOBX+X/u2CEMGksi?=
 =?us-ascii?Q?2c3x9SY7TFa42oEri0Nla+F5Io/IXfhvG5MOvG2bN8BaGZ+Vz0X5NskLUYtd?=
 =?us-ascii?Q?HppykwcnE/SiqHuh/RXxKrpu5dy9Q03nNp5D7e5Sd4uIbBDNXrUS8MvyW2Yf?=
 =?us-ascii?Q?DN2Q4gW8aMH4uI+93NLY0hHQsyee0Wq/iVes5XZsg4LTmvcFguQ9hT/8PR5q?=
 =?us-ascii?Q?EcRgMK8tTUhw8hwkqSnSd2wNeSk0T91pShI/fIlZzoIhSN0sYMH1jBvk6Lpj?=
 =?us-ascii?Q?MvxOiNLA3+D5ijUFUzh2QpqW7rmh5QEiOujTUVPKRQzzW/S6cnyPEBQdBQuB?=
 =?us-ascii?Q?uXhkjPM6+uk7guN6bYJUL2CvuXYscykbkjauDjyKCz6/l5RGwTqU4pGOAop+?=
 =?us-ascii?Q?NADq9UL97m+JocTAeEQx1ECqfy3uguQuMwLhPAuYROvIGeXPsMJb2yzT7/Fb?=
 =?us-ascii?Q?IdL2YR4Hx+KFKTZQEyRaaj7FDQcZgrmJBtcCo1TmEAnNX/dBH/Zc8EVtpV+0?=
 =?us-ascii?Q?+Zqv4OPrltbbY4iywGi5FcMmGJyZhRfbhn6bqfhKI13knjRbF+mJIciortqh?=
 =?us-ascii?Q?KdayqeuviJhUigJ03cz3SlRSX0YT/qneicDbOIxlsCeYQZKiXAK3/RW11H4O?=
 =?us-ascii?Q?A3kZ3DeNTmPvPFt2symo/A7/Wo5HnAI749T/P0gJH4rZL6kjS705Wcli1bV1?=
 =?us-ascii?Q?5PqmPiJ4PCQGdKJ3K9xv6pHtOiip1W27Pd3XK5+FUkMoUgoF63YupYULvTFn?=
 =?us-ascii?Q?/Uhbp/Hw+Lds2X+jNWCPibxU55K1jkW/GI6QKo5l27ykPkvmYIAHciZou8GV?=
 =?us-ascii?Q?JaPCOYUMbeVPl0o2Jf/NI152LJoghv2joMDsnd0w?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8eb1ee-ef1f-448e-8c83-08dc5ed8482a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:17:00.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3J759h0DFFqgPwLlsXrZr0mAXRz8qC77pScSZ2hwiJT6EjlBXpb11/pop2y2VpH/RVRN4hESvmaHGQV7vexVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7842

From: Peifeng Li <lipeifeng@oppo.com>

Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
---
 include/linux/memcontrol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 394fd0a887ae..07d08be706bf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1679,7 +1679,7 @@ static inline bool folio_matches_lruvec(struct folio *folio,
 	       lruvec_memcg(lruvec) == folio_memcg(folio);
 }
 
-/* Don't lock again iff page's lruvec locked */
+/* Don't lock again if page's lruvec locked */
 static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		struct lruvec *locked_lruvec)
 {
@@ -1693,7 +1693,7 @@ static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 	return folio_lruvec_lock_irq(folio);
 }
 
-/* Don't lock again iff folio's lruvec locked */
+/* Don't lock again if folio's lruvec locked */
 static inline void folio_lruvec_relock_irqsave(struct folio *folio,
 		struct lruvec **lruvecp, unsigned long *flags)
 {
-- 
2.34.1


