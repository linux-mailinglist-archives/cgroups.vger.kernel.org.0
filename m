Return-Path: <cgroups+bounces-12588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9429FCD5C46
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B10301BFAE
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA030F552;
	Mon, 22 Dec 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfRrwzW7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="slCs6zR0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4D314A7F;
	Mon, 22 Dec 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401846; cv=fail; b=pHX/tN2vFjd7rzhiIf9Arz0kxHmtxEFDJo7ijhmqZwduO+0c8QvAd8taqKHClv6IeAha2xaFAw8xV7c/MxBNNcviDS8ilg9UQSJytQoFEsDiYlDJMQpSMMubt3/XoTcJaHhV/7607yWnDWHr/g4e5lz8rtFhXSWchr7qgCFZrU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401846; c=relaxed/simple;
	bh=op4WBracsGJuEPD0pzkd1nH0iMYCIsp0rv+usq6ah2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyzvqfmY79SVmewG2tBZ5qRuGTai98z05yIpYQFkcypFRsNG8YzeVcWr8LH5cXv1q6GJWMbqJWuPhFJKIKvGhi59RcQNmjmmHj/28lqUv370RZGzF9mUKaKZoUISmMk96bwTLnv6kcX8jEvbR7RTLmZ7UtcOq7+yIBnEs9VZvoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MfRrwzW7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=slCs6zR0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMAqmiJ2099142;
	Mon, 22 Dec 2025 11:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=; b=
	MfRrwzW7LUM9hOSL5FqdaYJoI5rlNCZBoOcSDf6Z68jthhdfG1ChgpGrZbe9ggss
	4SWRKzyjBa41Lf6disfb2JnQL0c/n7H4ihgrXSis6xZGE6DwCfuf1CTmDaxp3vRs
	OH9Smp5c7SF8KJtk68syuRISfsxeKHqhoWVYWaUOo4U2/vuG/Xt61XlceSjTGiqn
	C8iG/cFgBu8VdLijw0HefMCD+/TzMf8IOhWkR79XIQBcwPloZfXIRRF6Oce7p5rW
	d605EG4hjnn3GiK+aReMVXwkvfNEGdN/nQfenrMj36fBAc73R3PjnXKE+E1Tm70x
	6oG4CR0giSXMCLpRp8gbZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b74mb00v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9dLAD040041;
	Mon, 22 Dec 2025 11:09:06 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876new-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr4HbA5NVgQ6q6Rx1i1EV+J/iSdnuycTXb3b3nud11wIYIJ0YPDwmuU57TaoOIHEMjvNB0Htmdrp+AnliAhNo0IOLkV5htezTL4xv/Hf84U89YQ7oEVpNlO6JW0njX8tjUWwPU/cywN5xIb7UWx9hvik2yVAgIDVoAY6nnfKMFNtzZpP82NiGQQPw8pyGLWIZg5tE/hONIQ/wdppx2BiJZDcdUXOU9D+4sGS/68dJ5ru3TPJfeQBWjuf5aKZ3s5MGNFuYOO4UpnQ7vm/GU5P8qw9JDXnY77/jbQ+JP0STikqbTyHashTP8KTVn/SapXhnaJAUKlUmrx1ENXUXmVdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=;
 b=Nz16oRvP+mSOAcj45Fe9Z40uG9GhJqKJQrCdAb0q+8Al0q+F4EJYT2NXPyYgZo6j1yMhbUu0KB8DKcwdtnYsM96apjjRlb5/axRYKnwbkaPufVE401TnjYbTAVm9Lu1nWjHtXUsYw9uEosbxri4QDM+dfKyHGXZ6Bs8pp0pg2I+cePnRw4tISMQhm+TKDLMQ2eW9KtqeuDSpa1GWRk2NG5gKY+Kd42cKQr2tWLHT1cx9wCuDeRExVXvXiGK4ymOhzdJGvLjQMcRxB5fo2k/HY2yVL1i4zDzVNR09jTtXCwImLdWHqaI/LT5zgcpipTc74a4lIiXzSiXNYm+H3HU34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=;
 b=slCs6zR0KX2FF3nyXwlcAJ9gliqRNgILHoCIAtc751yiaKXBe0AD+85Xvnj+ANohgSWkh+mam3jCU/1opcyvAVhliu6wUDZ2TVMUjRxexb804IJl+4PltNMTyBDCvNt4V6BfflPl2+40V2RVvCDQUrwF1gPCzf23xeIC8IU6c1I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:04 +0000
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
Subject: [PATCH V4 2/8] mm/slab: allow specifying free pointer offset when using constructor
Date: Mon, 22 Dec 2025 20:08:37 +0900
Message-ID: <20251222110843.980347-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: df774547-660e-43d5-bfb2-08de414a8487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYR063jl2mk9/c5elYFEs0SxcdLvyT3t0Ghb1VLSMT4ltGOv7QeLuagxUr7/?=
 =?us-ascii?Q?pFSiJum926s2ANc/FHTdzL6PnMdAkzuny25AETgWnO9z7DO4LGBR5HWNnSaq?=
 =?us-ascii?Q?VbT+JJ5vE5eHlQKJv7RixL3DuXhdV4yk2zmwLWRtDIKa/wSLfsGhHf/J7Iuk?=
 =?us-ascii?Q?CFb4X5duvBERLxeffnixFpcIoyKyqyAZtMDE5Gtzw/fiFN/tYeODbMJTFjV4?=
 =?us-ascii?Q?TGVNqVrrLc5q0e/x0VCLj45LVCLGGRpdGu8+53QSdnVKpj3OwdPxSmKy9EN4?=
 =?us-ascii?Q?GiwI7FiutwD6/LIJ5UEdlC9J5DMIzp4jrp6D//UuFjX56DtRVRJP4uWcGq4r?=
 =?us-ascii?Q?6yoVRfWj7sFWqTytOmIt2EFoqjvP1AEP9UVXWhAPxHaxfWdncq65EnoYOrzI?=
 =?us-ascii?Q?fDLVhJfPRp22M4BYbo0/MCRdZpXQhijvMgZXNhGg0lDpumRIMoX4cPv6AxAL?=
 =?us-ascii?Q?wSQ7ZXtGb+P9VhLgtuUVErzIczlq4gvtT3CH8Vb3yL5aC5Iew9OF46+yAaDB?=
 =?us-ascii?Q?BZ6jKah+XvL7dg8WVi73GRRGvW2iOSNHbt3+m34zxB53sk84zVeBCI42JznZ?=
 =?us-ascii?Q?kCNbtz80XqLcggNFn9PXogBUnMorlSdb0QY8k+NZ40ppzkZYsHM3xI6XxpXV?=
 =?us-ascii?Q?Qw4Fd9sWhIZE/3WE0++9ZuFDj47z0ul3KeMwDDvCPEHZxTY/O9b7DyBleD+y?=
 =?us-ascii?Q?0N6A/TpEDJr1vXGXUnJ0LTRbU10uiioV7fKZ0TWJqwhkeguzByJV0ZmLPzSj?=
 =?us-ascii?Q?1+3RkylEAQej2PXl7vdRE2mxY+c08fYzEgWKzZLQc84lY6Sccf+Zq8HgrXrg?=
 =?us-ascii?Q?Q0640ojHbyPYN/B0wA9cxjRrc+Yb8lTsIBnPRs/j/uGJP7jwjjKThlsmF4hd?=
 =?us-ascii?Q?Je/OWlvl3SNhxqaBQl6LvZB4lZ7B8sGaBhqjWcDAsmWaHhyxBcRphI7EzJcQ?=
 =?us-ascii?Q?wVzIBchfRgiUMTsSqbjyoYkU8vF5sEwoIOKqIxoVHZteK3p1OZwViuedpSau?=
 =?us-ascii?Q?MzeU5SjFzKzGd1dg8/TMJJSObI6+wjLnoz/Rqo2yqYSQGT+X6sCBmOwy3k1U?=
 =?us-ascii?Q?kVBW/Rxeq1GdLLQFPtWEWkTSwLP+zHsUFtvrIPVTyXqHrZoEjLCjN+Eyucww?=
 =?us-ascii?Q?20oS0QiK3AN/FHWD1FyhtYIOcYAYkkFoaVHAwN6Ya1UD9nsRibzJIqckBuiZ?=
 =?us-ascii?Q?JnVafqTIBFYPgQpyStKuXzQo+Oc+GnNsc5fSi9CxdZ3RYqmmHMg4uzqSmMHd?=
 =?us-ascii?Q?AXnc2tprlaMb3uBgyiBTUGOqpWhsCo3M9pzsy1MPDvsdgB3U1vwyAep8qdVx?=
 =?us-ascii?Q?VJXKd1fHqJGScIaXPk46TSJIzYBOUpW9b1WV249JZ6PCIxHwqcZuTa0n3+d7?=
 =?us-ascii?Q?60dWJIuje3zHNaM2KwYgoMrXyMiZy+hNqDrZsoeQvnwfaBt3NJuwfnlag+HK?=
 =?us-ascii?Q?H77xKUQFZfuMT84SQyhoMHo9A3D41YxA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsMg2sqLH7OTIX/wJ1hoVoUiHWD251ggaoQmhR4AHxrrPpPnujaXl9JQE16I?=
 =?us-ascii?Q?BcmxUnMlPB+woqDqxP4cEBEVaDGv6uUWk7jCw3qZALTLIgrbeFgd/HcGWIJt?=
 =?us-ascii?Q?rVaMMBZXR0/y8AzZ43csCMLTPvqR+59XVCaGImtQmtJY2IiNZWINZQTeso77?=
 =?us-ascii?Q?SISe0OKdlj8DkRYZr3MuJYuXGzIb/9OZfMV2sHfkIOFlQqe9kIRtQ9lFRso2?=
 =?us-ascii?Q?apxJEXeeNEN9XTUxwSlW93Hy/REL408Tzjj7ZBPp6pLX2QNt2ucEI7Ba1Gil?=
 =?us-ascii?Q?mpvlfNlbJPCWySg5VZOp6JgqsW2di4g16wj4kIVwiHBw696dxBlT2a7bsZsR?=
 =?us-ascii?Q?0c2o+kTlyQcA+wuwRaLw7gdSvsnrt0K6Jvy7cJ0FtwcxJXnmbeOHxa+NV0If?=
 =?us-ascii?Q?eI0W5tmDfkExzsH4tHBtmEP5dZycaupmIATeCSBIjJxZYdJQDx71NVy6usCA?=
 =?us-ascii?Q?cK/YmIv64Nf1SUbP6csmG6ivfFIapWqnjiTjVJM6r8BgG1p9bKnPT68oJ/KB?=
 =?us-ascii?Q?lnn7vrfe0Pd8vvhz1DTCP+3Gb3kAi7eQMUraoFUNONzPb3PEObwQ3ZXGUjbK?=
 =?us-ascii?Q?yNbqDgtIBnB4neVp0e38g0QzS4bwMDqDodVdcb/l7aUSMt9lVKOl+S8xPQXu?=
 =?us-ascii?Q?Gd2VKPoV1A+pXPco6XXJdRvtZzRmOaoxicyTwpPFp3xm3V2qgl5kCe5aO/+3?=
 =?us-ascii?Q?3nZhUmtgt7bJ0lVUdLnwP6UZDCh3BBSax8MSYQcENKb5qI5hHHhNf+ChDi5h?=
 =?us-ascii?Q?HRmnMhyagWS1aYv5T5RTRUGwikwI4VcLxYXKW1vl6fZkGOs0cSqKSkZJlT57?=
 =?us-ascii?Q?CWebjGV+uClCtMxRhjqY9l5Iaelz2hIQtCTbTUHJSpp5HEFT0L+Gg2FqP7Pc?=
 =?us-ascii?Q?Lmqwb3rDFc/2X7L+/0cgVeTK87SGwP3QwDl3vp0E7Q/zkoRl/+s1mBwIzl6K?=
 =?us-ascii?Q?UXDJuKap2sld8rxiNQXM923Q/xq/1t+HEDhZkuN8LuOXDlH2MVImjvv0ztf3?=
 =?us-ascii?Q?NMCVpMfWgivJVzooJOE69oqcYDeyzjiyq3izF2i+Rsd9HtCmihuRxTTHUCde?=
 =?us-ascii?Q?OOeeErD2wTXbBg/S8MA0dbuu5O1yWnCXmrNFK03MwNXC+pTTXjLdG6w5swTW?=
 =?us-ascii?Q?2qvEQmpshrvWjeKgVKdDB670Q/GuhI5sLhobV4iydfUQfTzGdwZ2hM3PTLby?=
 =?us-ascii?Q?RgzfhaKdMOM84b/A4J/1Sg0BQ5Yo8QY4hq0mgJfVTzhwgI2qD2YuIEveRsDa?=
 =?us-ascii?Q?vqAKkuAXG/e+AOor3aGOMyZ6C0awDuY9QF5f8WCZ8wOeWRfirDe+yeWRi1iC?=
 =?us-ascii?Q?C8AfikLrDOnyqsYfRUdE5/0fcX3C3pv1Vl8x+7IJvXEVYxisqqDQL2uwGeKV?=
 =?us-ascii?Q?N61b+RQfVN5PqgMMWQO3uiZOP/bzlbqB6c7/QRnu4QxDi29SpxTjluCz5Wxm?=
 =?us-ascii?Q?nsBqLa9j8kl4ZYpfpjNA/wYaIs3/HhN/1NI2CYZKI76MFZJTV1xAulLmXCt2?=
 =?us-ascii?Q?Upt7VAy4LvUCbJC4KM02khYGgCJ25kU7h/cLYEIqKdf/jVLKgiKUpk95vPS+?=
 =?us-ascii?Q?57vuQAQBwQiIp97JSaww9dN4zXcK+zN/h6uR0idlx4UPxU/PKEf7+uanx1n7?=
 =?us-ascii?Q?Qcey8mlY4m+Iq/4AjdHbkBg149JQHcPVNVPI2Qbbw+cDeAHfpRGB6ZEuhMWV?=
 =?us-ascii?Q?v/UV1vIrEhyAcKrp8wZ48mIyhP097MEk4mLb26JHHHhw3GTK9viuD8VLctoL?=
 =?us-ascii?Q?FKXE9o4fYQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dDKSYFmmx7rvvRYvZLLOnRF1Xdj7ck4EgxC4GGC/aAap6y+mMNZJ0JpcFFo22w9LulBDwtGsEDysCuYJtTObMNM6SNcDG1QZ1xe+iDzunaqdVedvPV14WKMi94z4fue0q/9GBGRuKrHb3sTQ8o/vvWJk53z/Ey1xzwiUHPCpt3CHM/YsKAj/f/a3P7AceI1pVNT6w0P5Nl7CzwFTBJ4kJD6s2qkgC3lhgrB+y5/EmMnlI3JCEcHBexCHIXkNfrntDehOd3M6joodzedBP8neqY9jmVn0uE/mpNTIf9XFRGe8srmBSIxtcN+7652JOb0G86zcZqtklD/0KX9bOvScH8rmRKx30BzGk7CA8rcV9pva4t+gKRbaiEqKvZ6iJALDYy2sun9WWLeq+tS8CWATfYVMzxFQ/5kaHGEPi8avt/sZu891kuyGCMRvcXTvr2lyXW15P8BftVX10tOl2SlAXUbV1/0DX+3TewGmA94Fzav3r9x9dcM9lABybK402WfuMCb0fN9v0JH4oQK5JcWF/iqhvaeYfUY3P8HfyrqI9V/0s/68sC96kELHZg5hSva4eRWYndit+Vriv7uSC6FR06bd83Op9E8XxcEax73kh8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df774547-660e-43d5-bfb2-08de414a8487
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:04.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbSWJF811VPKmSTUBsJN/tR0Nx+XHX9UzYZXjIW35KQrm23C5f74XuK8AaZ+fNriQUTqb08cp/TVIGR3cC2o0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Proofpoint-GUID: -N-GWutV8nV9Bdrz8b7PXOVqTeXezIkp
X-Proofpoint-ORIG-GUID: -N-GWutV8nV9Bdrz8b7PXOVqTeXezIkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX5moGdtpgsElt
 UHW5FBxeQe8WdovtV6qTjewXzyU13sZ3KN8DnLR08jL6gMm5Uh/wgOQY2yeq53I/avSPV/y903R
 J+nALKAkGg21kZG+SJbMVgCVheUlB6kZ0P5TuUAs5WIr6ouAgOJbVqBsg9Z+UWl42vZaL6FZoFF
 BvDwQqmkU1uUplQiOfJ0b5GeeqQLoJleNaRiLttGaNbII0ajE001weg58hC7+xKxyesg44ffQUu
 oJyypP7uj5XPohMxe1ZMTZOsXjBmvNeY1FcgtH9KWih/wD0QG5Y9wAUA+cNNBnz8/2VlxAPkonA
 L8KDhXtE6cjrucc9NYdjpyBQx5nbLk7XsvwECrys71hkEWK+4ehoysGSxBlFJxKtW1yobPZwhdg
 zW1omgj2sJ42I/WMHWsd0G7MMN5WIZnkCoh8Ar2F6SnAcLUBlVO+RapqwrMEZxBelszzfDqxM/u
 eDvbtzNbBxEcl9O3GdQ==
X-Authority-Analysis: v=2.4 cv=dIarWeZb c=1 sm=1 tr=0 ts=694926d3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GMHoajJQQyXWUxyK3F0A:9

When a slab cache has a constructor, the free pointer is placed after the
object because certain fields must not be overwritten even after the
object is freed.

However, some fields that the constructor does not initialize can safely
be overwritten after free. Allow specifying the free pointer offset within
the object, reducing the overall object size when some fields can be reused
for the free pointer.

Adjust the document accordingly.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h | 30 ++++++++++++++++--------------
 mm/slab_common.c     |  2 +-
 mm/slub.c            |  6 ++++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2482992248dc..4554c04a9bd7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -299,24 +299,26 @@ struct kmem_cache_args {
 	unsigned int usersize;
 	/**
 	 * @freeptr_offset: Custom offset for the free pointer
-	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 * in caches with &SLAB_TYPESAFE_BY_RCU or @ctor
 	 *
-	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
-	 * outside of the object. This might cause the object to grow in size.
-	 * Cache creators that have a reason to avoid this can specify a custom
-	 * free pointer offset in their struct where the free pointer will be
-	 * placed.
+	 * By default, &SLAB_TYPESAFE_BY_RCU and @ctor caches place the free
+	 * pointer outside of the object. This might cause the object to grow
+	 * in size. Cache creators that have a reason to avoid this can specify
+	 * a custom free pointer offset in their data structure where the free
+	 * pointer will be placed.
 	 *
-	 * Note that placing the free pointer inside the object requires the
-	 * caller to ensure that no fields are invalidated that are required to
-	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
-	 * details).
+	 * For caches with &SLAB_TYPESAFE_BY_RCU, the caller must ensure that
+	 * the free pointer does not overlay fields required to guard against
+	 * object recycling (See &SLAB_TYPESAFE_BY_RCU for details).
 	 *
-	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
-	 * is specified, %use_freeptr_offset must be set %true.
+	 * For caches with @ctor, the caller must ensure that the free pointer
+	 * does not overlay fields initialized by the constructor.
+	 *
+	 * Currently, only caches with &SLAB_TYPESAFE_BY_RCU or @ctor
+	 * may specify @freeptr_offset.
 	 *
-	 * Note that @ctor currently isn't supported with custom free pointers
-	 * as a @ctor requires an external free pointer.
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, @use_freeptr_offset must be set %true.
 	 */
 	unsigned int freeptr_offset;
 	/**
diff --git a/mm/slab_common.c b/mm/slab_common.c
index eed7ea556cb1..c4cf9ed2ec92 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *name,
 	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
-	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
 		goto out;
 
diff --git a/mm/slub.c b/mm/slub.c
index 1c747435a6ab..0e32f6420a8a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7907,7 +7907,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	s->inuse = size;
 
 	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
-	    (flags & SLAB_POISON) || s->ctor ||
+	    (flags & SLAB_POISON) ||
+	    (s->ctor && !args->use_freeptr_offset) ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -7928,7 +7929,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
+	} else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
+			args->use_freeptr_offset) {
 		s->offset = args->freeptr_offset;
 	} else {
 		/*
-- 
2.43.0


