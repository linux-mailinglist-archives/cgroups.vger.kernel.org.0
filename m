Return-Path: <cgroups+bounces-12917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF942CF252A
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA443036409
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67F2DBF4B;
	Mon,  5 Jan 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8G8L1+k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TGeT1TOS"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECE2DC798;
	Mon,  5 Jan 2026 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600240; cv=fail; b=f3caJm1z4rXpiD76OD2FfaOz6iDTc930TkEMNosQH3roG+g0xkE2KIQaEr2vVPH14h9wfbGmB43KyHDnlo6PHKZ2HMk16LSzHcU6z1FtIbjzxA/jYr6AcSoDqMMe3tsEPmTOxs8HFqBT/YBho2DkKHkEfyrFM3bcNzfxO74yavs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600240; c=relaxed/simple;
	bh=JwypxlZDXlyTUHKaVZNBx+O389sUKW1PFVJsfkG2bLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2voRcvkPP1sftcK43SfXb89lAkvIqfqMVggG2j4xICTaeMiFoWJbwMMPQwtsYOYb8li31E/zvQ5G6EgldzcuiqabDljpyZVnKL8wSY4LWZR1Xadj6Se46bw/6t8zy5FD6NxrOHzCQGglBI3IczoQ23RujOtoiJ1Z1Yp9yz2Tgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8G8L1+k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TGeT1TOS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NtCDJ180217;
	Mon, 5 Jan 2026 08:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SFvGk5mqhvnwbD0V51R1DiMVZG10OgmKQTBbJd2WpR0=; b=
	i8G8L1+kIZjhNaO6GzkvIl5Z9LELqsQmuEwWr0zyfwJouKjLHRFtdXEpz9lMYIF2
	AhFlgqHgydtTrQTlWDPn/99BFStHDUu2I6gK1qwTCYGy/ADhD+/Y5PgHD3eASe5Y
	MQPHdxh07rAVUWkD6Y0coC18gVdfbdSKY9Wv8ST08EOG1s8Bu4ztnVhxQs5xKZg0
	vo+WDmw4NQeaXACSP1ZTw+EtHoHJusxfpuFxxXWjEKwQnqEACAc1lJ1b+pkqgwoD
	TQVXt3pFN8+JH+StL8pZ9SGqEvutKDA3alnC1UIsOz184g+w42LWgbGCPIYas6QH
	4mN56wKI02xB1x46+03UyQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev5qhaxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057J2Rk020365;
	Mon, 5 Jan 2026 08:03:12 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjh42db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm/5h9LJle4tEoHOlSbsMq3ZE14a5D38ZxOuQdZWyWKe56s7kvPRR/2potQbFM11yOyWcebFdHRo5B/Lnd/J45k6yXwRMj321M7uEvo39MJuNAuBf4hig/YqhO71teeCBfBR711T6wB2vqfWqVYQfRX0DUxjIjmDRWri4rnZLEbo4mAmRGjXQV2uwfduXLwsqnoYdXk6okbqXFdiT1QolRo1Al0hX24jjXZrE2yeIO2l8yzGMKhYxcMVQeJEbEKsdt1LoCciuDklFN5y26GrS5E3MevzX3JUr3yeiuwVnIXjS9u0arz5W2WR86W6gQzDVxp4TyEcJQZGSw10iGZWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFvGk5mqhvnwbD0V51R1DiMVZG10OgmKQTBbJd2WpR0=;
 b=UOKyE4zspRivNu1Uaq1UQLXX/WR2LXl7SS9qygQjeSadoESWxHcsPS9kicHjp8KdcoLpVFNZmydDWTHn8NC7NutqKXljj1F+OQ47hM4gSzNsBjb/c4SV3XZ0SARRSIIGZs38blfL9RBxi9Aeg2h3niMIe7dgWvP2B4MqYtONgsr6PmfbkAEjVc9lrt20DbHXFGW0hYpigEegb+koXZLxOYTJTv8BCq3Ymr/lbXWAmgtHJiz030bZmy5hiK1rVUNYRY+FUiTeDxEtp6U0NhbwGVgEvVxD09vwFr4jX2XYdcpY56kMYDcHlFZf7VvTymq4JX5QN7VYK9MFNwBhPOSKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFvGk5mqhvnwbD0V51R1DiMVZG10OgmKQTBbJd2WpR0=;
 b=TGeT1TOS1IIXs2a7CfWk/uHnDoAHKTFFyF6LU35Irz+RBiRBIGCewFdIq1xFX/iVsvUPXP8OXYVsmiroDlo8t4av+wG1XoiKhRqiSCAa7qjOyrVPD1C9I3b+ydscL21ZrspmRWjdRP4JE61/jQTUEcEg6R179VBRgsei7vVQmyk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:03:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:03:06 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V5 7/8] mm/slab: save memory by allocating slabobj_ext array from leftover
Date: Mon,  5 Jan 2026 17:02:29 +0900
Message-ID: <20260105080230.13171-8-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0156.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c36eec2-17ef-4547-3af9-08de4c30dbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/l7KzQ9pc+jcMrbWSKThdhWKqCQklfamnVD00cJLdoNBinVbMondkZb0Loh8?=
 =?us-ascii?Q?6B6tWcy5JvXJLqXcI6Xf828ain5iNHFQvi/OqNUEorHfMFkyvyMzw+uDA1ll?=
 =?us-ascii?Q?Zhig5gG+YlZ+GbS3+KoyOA4csFMvOz8qozVmP/ja3Tqds0AM7wAPeK+VohsW?=
 =?us-ascii?Q?foQeRyIKEX0JCrY/km6Ljd69qfaSOv6wg/uMHTwrlgIqdysi7SlCJKUgMxsa?=
 =?us-ascii?Q?XEdwIgSGCVf2mJoemgBbGZk8l4KHTGWW5EpfLFwmQ94IKNrOYdUkYi81AP94?=
 =?us-ascii?Q?yEtWxyYM/lZB/6bsBj1qThb8xrUc2/CmrmIxX1WjZHqNmeDHrYopNG+h/J83?=
 =?us-ascii?Q?AyY77bEe0DjDTz7s+3XXrcaOUKLEmlnjjDfDCJblF/BNPj6wwQ3tiqXWShEC?=
 =?us-ascii?Q?xt/Flc8wPFeK4nd2HUo3aAeWOl1j9V1Gk7sS82JFku2MFMrC20Btw7R8y14Y?=
 =?us-ascii?Q?VVuYc74f7RJqt0ClDOnzJ8k+4YkmWkfu8okdERGfDTFxgras1wSiJ5WsHrh1?=
 =?us-ascii?Q?DZfB8PCl+hFXsiiQN4CyhJgTS20XhIQYuevGdQtCi7zEBbDt3reUES4KfqmJ?=
 =?us-ascii?Q?CdbKN+H1dqzbLVVIXOWmc83G06TZiR1EiMkyLQN4s2YYHBIhV/ckcBYKvgCb?=
 =?us-ascii?Q?VVPNGSC29iyqIADARIes/x7IPbwj4HK8t746M+swzFvDvKwp62kjz/pXgNdL?=
 =?us-ascii?Q?oAPg12GMCMggYmaVqHQC8K7mzSBT+CXhjovH6FtJvtGjybpTub76aEAIGe3r?=
 =?us-ascii?Q?qZu/9bnD/R3UVis49jQip7m0bTsUDW73Q5k/EJUKqkKIVJeJNHY0aYYoNRCa?=
 =?us-ascii?Q?3PoH49Is6Q2m65y/jf191D3gzkKpwAX5ZDTuiZWsWuL5876NBxi2AlQrwRua?=
 =?us-ascii?Q?V9LrRt3pLcSrJVdSWPuBJF6q/djCjUTEZnHCGavDxrQH8P13T4fedhSLsi0g?=
 =?us-ascii?Q?kXdvc94iO9Ofs1rulyKkaPFV9aIestz3XWSk+5a/cEPDss8M4TvmxOXyTU4Z?=
 =?us-ascii?Q?cjfGjAXxkA8hYzmDwFXKNpHPGw9mVMmDdVXb1AGa8kYr+AZ23QuF19Zwaohj?=
 =?us-ascii?Q?4InK2QzoVe9w0NdpyP1VyZx/fPwEiVlaYQDrGjZtELRG9JqaayaaXrgLy4CF?=
 =?us-ascii?Q?FvNE8lmmEt3cJObR7kXKIql08DUnQbcu2TlV6h/s6drfmenUD1noH9Y+Wdfw?=
 =?us-ascii?Q?eTswc9qGjA0HA8Dmo75VcYC/JvCvCiK1DQK6xPOAkot3yIY+yvmGSLGKVlo3?=
 =?us-ascii?Q?lO9XXZuSsAj7okZ4ekjcNoYalHMWg4s1ol6iP83AWzBetOnJA9R5pXxK8d7F?=
 =?us-ascii?Q?x6ustpsKx0yZBl8lu+zY/E/6vvvnmV5SCB6SlqsCIzQcJPdJh6hr+avBuGTA?=
 =?us-ascii?Q?RWhppBSHoTeSCqUvlmzeHlC+e2yyRfLwVxajceVKz86FqhIKe8RvxOiwSZTM?=
 =?us-ascii?Q?xusUVs5GfATezclhgD8T/jxZAEo0UPBBGXb6f913nCypW4pljcalIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lwrVJ6rT9g5+5QoIXvZbtt+doCK0omNkL93KqMh5Nl79NCXPEpHWOphWmJk?=
 =?us-ascii?Q?Ewd2bSvx7eNurrATz1kFt8QcE0a7wFezDI4NnieBbkjS0r1K7uw362+bGnEd?=
 =?us-ascii?Q?8smXg1PzSCmko5A7BY9vcoUbgkQM6wHDC+A9yp689krWg8laXaX+kA6bTDrJ?=
 =?us-ascii?Q?ehaJDKpVmnpZGnbgef2EpWQvkbND6vieyYQuBovfxxa10M8L0MJkUKYAitc8?=
 =?us-ascii?Q?eyY+BurKXC6xCmJKYD4VLEFQZbb3fOdrA3Iji+x4Af8jTBoRgQjQD7dapHap?=
 =?us-ascii?Q?EE5ADZ7mD9fQgW0sHncvriZa0d5EMYLkhcKJFs/9oJrEiTtK+wUEXDqFtU3R?=
 =?us-ascii?Q?48wU1ahcYmZ/2awz+vVAfTAEg7rIwxxDlgWpMCb4ZyHKlYjH6lq41QM4Iw92?=
 =?us-ascii?Q?LcubaPw7nA3xF48zi6jKHcARgTps29PxEp0o6Tm+B74iA4l2cW69cn0VXhSU?=
 =?us-ascii?Q?KahN0X+JGFaorNupQECNCusokox/b0tunmdRvE9/z3+ZQ0TaZBDky9/pGGt9?=
 =?us-ascii?Q?iUfH0+/a7w/saiuoyIiiEaL6LglyJKWSePxh0CCtJx/h4T6kK/QN+UEuvieF?=
 =?us-ascii?Q?7dm+xUtDK57XnSZUNoo09mYMAPuXDj298GWKYR+Rv9GKjPQP7g/CwUDFIEnK?=
 =?us-ascii?Q?D4AQ3LfeUO3DHKPSme5GFo/WbTyyzBH6kY32b85KNovG2As9nQddoNkXq/kD?=
 =?us-ascii?Q?s+VAm+10BLblhLSqZt0pq681/7o769zptza9CbYfoxsjuzqhVcYLar6X0KlG?=
 =?us-ascii?Q?woklG+96pBs4hmYPAN4E8n70KMTPvdDwMaFkvY8MlrrFRA1dIr22ErszNjFy?=
 =?us-ascii?Q?MyDJi7SXYKubEIkjMDs9Sjd0BFVenjFTtxE1Beg9g0AMkYYYZNR+cfnV+uhx?=
 =?us-ascii?Q?8uolyHuKwYI2kydTGc/WqOgaAR9KestL9nkWJcVUZ6csEp+5D9MfA+FWhqUX?=
 =?us-ascii?Q?wdEMXPwV7SIsYG5yYfBjoBkX6+xMRV5aeTD//5/XulrS+syMsLXDWRKmNvf5?=
 =?us-ascii?Q?Izy7UdMuKC6WA4h4sFr4PsxrxtDZxQTM3ghHMnqjIQFUANF+ZQ5oX5DWOhuY?=
 =?us-ascii?Q?ScniuJwJ92mS1Xv/4G8Aa7tFR57GYXh3PKtehLXff9IfIUFdVpGyrSCHplAt?=
 =?us-ascii?Q?WFjI7a2urd04oOXL7HLRwgQN4M+PIOF8/3Sf2Ixn3Ukf7rxDl6tDVnCFUPqY?=
 =?us-ascii?Q?JRK4KSDEXBiknl/XOzjk89iPumLN2oM66uEN98EZKWBjO0KTuK5a0s7++I1u?=
 =?us-ascii?Q?whg8400ageHt0DmGqX81Scak1QFh4Qd1mvSKDlDMENwEtxyObc6yQ7/JB0Uc?=
 =?us-ascii?Q?TZbRG51XcXJjqALIoFPR6l2TUD5PxcHy6AuBD5RbSkUuVoPVYrt/tudJSZ1m?=
 =?us-ascii?Q?4SVpxnOovDRivxws3clf2lJ/Iifc3PD5V0Zn87qbInEOq3ZbMFNQkJsooA93?=
 =?us-ascii?Q?+aRebGDrILYkz+ghv/mqP7dF4u4GlHsKb8iGCV/jUnICyefTovtpW4gAyNsO?=
 =?us-ascii?Q?fKLAsym4UBquOkFcKtwHvTfJpXz5E3AYTb9M0RtMrkGnv/aWkpSKn0HPg9mM?=
 =?us-ascii?Q?4s5jgHWghD4p4/oRq6uAqrP2Dv2pdt/ttMfzD4iuPEr+yBDiOiJMBWU++eiO?=
 =?us-ascii?Q?dtgyUpPwt40lUuHIJOxKH4Nrb31FNiXS7OzBrH75OXmX4agRIHBJC7wiYhxS?=
 =?us-ascii?Q?/OoTAWydU0boe0hW25MAowzmSZ+Ae7ybIBSjobK1fzrey/Dsrmp69AjRoRnY?=
 =?us-ascii?Q?7sV76yUZFA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MB5c556IBYThdZRYV8ZEzuVcQUnJ04jKxVxJ++VSmuJziYY4gC/9ozgHhtAX0RfmC1Y7OLmW07NCf428K/pitNtUMzgmpt9qiINYhSigfaLzAB5WvhcGht90h/erPN8a7Zh7JXspzIxBeJs4qjZm3LAwyZ3fVJnd3WZU9N3U6DJbEv8zfet63CZLqFasDql0QrjuO3KgGfOsC5Oa9ChxCgmT8Rf3TuRqWiLfDQS3kM4ZpAothOJ2PtcdHXK2MIxZUrCek/fsSNZg1dwO5H4CmZoRAPJmAmx1EQUCABAT52s8Ov5ZUqvZTDSO8JxbqzMLF/vTtPp3bymj77z6SQylF54w8T5foSaEO5EW2n9zmJvdKSoKnCmny6QgWflOl3+foUdSkG/nPd3A1P9Knar/XitWccFuukNiR+HR5qqEmX6NPPTHz8KBUhXMtswwB4iY5JDaWjZ1cAMbWRfUzg/P1zWdHaCqTmNY0X1rnAypxuhZYkeMccjJAt7eP+cP4N4ajVPo6uM8fdT14GONfV+X5SZhPgHZ8VF0I95pw46z423tbuXC26B73MAXZWoiQR4nVIXdNvnrzJq+T9a0SZAw+SIgiIZ00VLKOArJsz5a7+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c36eec2-17ef-4547-3af9-08de4c30dbaf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:03:06.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b01L5XBu35fd+UnP9DTVA7blGeByI1A4EzbycPra1a7xrALvHj1lzpyE/IPOZ7aZYbVwht1/6WZgbYnxBuEMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050071
X-Proofpoint-GUID: 8yBVaEO4u5OvJnRMWOXmpIJlJIqS3bcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX7nxg+mW9D08E
 3SEMmzhFncQe+XZyoGhoJERUZDHLECfVSF4bxRVB/gGPl1EfmTrLSy70M5Fkj4CxQjaDoa7BH6t
 lsqqdXcfiuAd4fxlWsAWkfY8kWwJJqpBk2+CsnqbRTht1YALffU7J407IA+zJ7XVsuo7exXtuTQ
 GjQBv9r++R2zMNKmSdFLrsxoePiZDkpc4RGnGEgE3tY0UIeK3lMhsKsQRJ5/D90xZLu4OR5SiTj
 NoKH1+ufdsjeEwrFIsldHCiQjwYez0owtbKeBm2e1t972evjj4RmI4afXsjuLyk/GSZtWs8hV1Z
 43S6e4oqw2qLygHbQRyqyDd4EppOQtrZIBGeeE1d0qJqSD3mgpKRcYUrU7Ql0T9xjPc8R0g3oG6
 kMQgHCuZh81Sp7AJaG4+0O322uguiuAYuefeO6ntnSjUv3Z58oLV0T0yIKWqnkN3V/08kZ0Uvnk
 bugcgcMVkApdo11q0T5NmZvdpWRVkHrKJUimwEmo=
X-Proofpoint-ORIG-GUID: 8yBVaEO4u5OvJnRMWOXmpIJlJIqS3bcU
X-Authority-Analysis: v=2.4 cv=cePfb3DM c=1 sm=1 tr=0 ts=695b7041 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JVGYsnW0c5-8z4_xaEwA:9 cc=ntf awl=host:12109

The leftover space in a slab is always smaller than s->size, and
kmem caches for large objects that are not power-of-two sizes tend to have
a greater amount of leftover space per slab. In some cases, the leftover
space is larger than the size of the slabobj_ext array for the slab.

An excellent example of such a cache is ext4_inode_cache. On my system,
the object size is 1136, with a preferred order of 3, 28 objects per slab,
and 960 bytes of leftover space per slab.

Since the size of the slabobj_ext array is only 224 bytes (w/o mem
profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
fits within the leftover space.

Allocate the slabobj_exts array from this unused space instead of using
kcalloc() when it is large enough. The array is allocated from unused
space only when creating new slabs, and it doesn't try to utilize unused
space if alloc_slab_obj_exts() is called after slab creation because
implementing lazy allocation involves more expensive synchronization.

The implementation and evaluation of lazy allocation from unused space
is left as future-work. As pointed by Vlastimil Babka [1], it could be
beneficial when a slab cache without SLAB_ACCOUNT can be created, and
some of the allocations from the cache use __GFP_ACCOUNT. For example,
xarray does that.

To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
array only when either of them is enabled on slab allocation.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on ext4):
  Slab:            4747880 kB
  SReclaimable:    4169652 kB
  SUnreclaim:       578228 kB

After patch (creating ~2.64M directories on ext4):
  Slab:            4724020 kB
  SReclaimable:    4169188 kB
  SUnreclaim:       554832 kB (-22.84 MiB)

Enjoy the memory savings!

Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz [1]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39c381cc1b2c..50b74324e550 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned long *)p;
 }
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+
+/*
+ * Check if memory cgroup or memory allocation profiling is enabled.
+ * If enabled, SLUB tries to reduce memory overhead of accounting
+ * slab objects. If neither is enabled when this function is called,
+ * the optimization is simply skipped to avoid affecting caches that do not
+ * need slabobj_ext metadata.
+ *
+ * However, this may disable optimization when memory cgroup or memory
+ * allocation profiling is used, but slabs are created too early
+ * even before those subsystems are initialized.
+ */
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+		return true;
+
+	if (mem_alloc_profiling_enabled())
+		return true;
+
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext) * slab->objects;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	unsigned long objext_offset;
+
+	objext_offset = s->size * slab->objects;
+	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
+	return objext_offset;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
+	unsigned long objext_size = obj_exts_size_in_slab(slab);
+
+	return objext_offset + objext_size <= slab_size(slab);
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	unsigned long expected;
+	unsigned long obj_exts;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return false;
+
+	if (!obj_exts_fit_within_slab_leftover(s, slab))
+		return false;
+
+	expected = (unsigned long)slab_address(slab);
+	expected += obj_exts_offset_in_slab(s, slab);
+	return obj_exts == expected;
+}
+#else
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return 0;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	return 0;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	return false;
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SLUB_DEBUG
 
 /*
@@ -1405,7 +1498,15 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	start = slab_address(slab);
 	length = slab_size(slab);
 	end = start + length;
-	remainder = length % s->size;
+
+	if (obj_exts_in_slab(s, slab)) {
+		remainder = length;
+		remainder -= obj_exts_offset_in_slab(s, slab);
+		remainder -= obj_exts_size_in_slab(slab);
+	} else {
+		remainder = length % s->size;
+	}
+
 	if (!remainder)
 		return;
 
@@ -2179,6 +2280,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
+	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+		slab->obj_exts = 0;
+		return;
+	}
+
 	/*
 	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
 	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
@@ -2194,6 +2300,35 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
+/*
+ * Try to allocate slabobj_ext array from unused space.
+ * This function must be called on a freshly allocated slab to prevent
+ * concurrency problems.
+ */
+static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
+{
+	void *addr;
+	unsigned long obj_exts;
+
+	if (!need_slab_obj_exts(s))
+		return;
+
+	if (obj_exts_fit_within_slab_leftover(s, slab)) {
+		addr = slab_address(slab) + obj_exts_offset_in_slab(s, slab);
+		addr = kasan_reset_tag(addr);
+		obj_exts = (unsigned long)addr;
+
+		get_slab_obj_exts(obj_exts);
+		memset(addr, 0, obj_exts_size_in_slab(slab));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	}
+}
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline void init_slab_obj_exts(struct slab *slab)
@@ -2210,6 +2345,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
+static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
+						       struct slab *slab)
+{
+}
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -3206,7 +3346,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
-	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+	if (memcg_kmem_online() &&
+			(s->flags & SLAB_ACCOUNT) &&
+			!slab_obj_exts(slab))
 		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
@@ -3270,9 +3412,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->objects = oo_objects(oo);
 	slab->inuse = 0;
 	slab->frozen = 0;
-	init_slab_obj_exts(slab);
-
-	account_slab(slab, oo_order(oo), s, flags);
 
 	slab->slab_cache = s;
 
@@ -3281,6 +3420,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	start = slab_address(slab);
 
 	setup_slab_debug(s, slab, start);
+	init_slab_obj_exts(slab);
+	/*
+	 * Poison the slab before initializing the slabobj_ext array
+	 * to prevent the array from being overwritten.
+	 */
+	alloc_slab_obj_exts_early(s, slab);
+	account_slab(slab, oo_order(oo), s, flags);
 
 	shuffle = shuffle_freelist(s, slab);
 
-- 
2.43.0


