Return-Path: <cgroups+bounces-5730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58929DFE73
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944C82815CB
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20ED1FCFDC;
	Mon,  2 Dec 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XzLGS8Z8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ahjt2KUt"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5E1FC11A;
	Mon,  2 Dec 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134303; cv=fail; b=QGmvI8cUeEYGoXr58rtsf1e6Y2G16srVUGhhxW/3cngVJh1QqEJdU0Rbfoq80Sdw5+zbrcOQBfgp4ixjtcPdJlYgYoM+KCdwrhzgBf/sHx4d5kVSuK34JZOFT2UTSH0LkQsEP3ZNRSi+ZULnH/s4zquWvpEQWdXrF6wUv/hM8n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134303; c=relaxed/simple;
	bh=PA7d1NxmY62UiyZ1ZDLD6OXFXXh/Vy6agWkgwIqAdLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWCMEth+ZeBIBYGgh0chiAUeTKs+gaF/Klpv8qWRAjQiBg54GnAq28o2bT57sjmw9mw6QUKCd4zIyJEINN1z1T37io7u6pKLMBcx7zuufF1uwuRjeh1N07qV3E0H0AyfTr38NWukfpHdAHZZzGkBb39Ok6GbvTPwyhNloVXrk2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XzLGS8Z8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ahjt2KUt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26Wxr8015034;
	Mon, 2 Dec 2024 10:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0pMTks4L7/gqgTnMrQ7azVmrvTmICSeCDtWmjaHLbrU=; b=
	XzLGS8Z8sFt88fcHN6awrVnug6hjOyzV5KP8mirXw3Al3QuTUxVTVCMiYz8utAe+
	vbGq754emiwLhGeGESwiBtVhjHOeQXauyWNpWgEQmEyOWhjTvod0DAZttB9YBc+H
	xwPWkwr+JAVBpI+LTUwI/BTGdZpamOzAOX+3VebkA3oW9Eejwpz07d0I80LkJwEj
	H5g/NDlBScoSL+bW8F+wbVlgms2e0oWyPqoAqFLSwK8TK+fLUYNUH3TqyG8Ax3DB
	RnI46CRNtMrGzeJJpSWLYFoOJbVDXKLkjsBc4Ji8qG5o8mL0GVg63JOh6G5EZEwX
	d5lPchCCIq/Yc4i9iNsKzg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smaah84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:11:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28IIvH031298;
	Mon, 2 Dec 2024 10:11:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sabr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w62Gt2sS/z7V/7WuO+g4b4mNnFsFHbMynwL/nAc8iWe7ViBfOdCzO4xbOJ9WPRKHwOCRYawzG0hiW51dHY9ZF1aeYweV7wxhtiuOJMlzWm/DYnaDv91UTA0r4KpucHLv3Tzaq3bhheRqmGvwgn5RxzIB3DRTBXUQdKGFd88fQW8FVioZ2saqMkmKDN9mLMjIsBv0rKji+N1F39gTv3OmknAHfT/5MkIA0+E96rJEsn6TNgBjDCA1+sUC1Lql5GS1tW4ivgkYwr1fUViET8U6d3nHBU1gXktEPCvCq7k29gAxwilawDCV/LoPp/JsrDvbkp3XTkXaWo/GxJBz/4pByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pMTks4L7/gqgTnMrQ7azVmrvTmICSeCDtWmjaHLbrU=;
 b=QivM0+XW/zS4b9O8/IfKs3ZVRISZaSFBzdlWYHyPSPkJLEhXbgMEfDCq/iuB/8IF4A5ER63V0d4NQ6FZtGitWzbW6lrYWcvkLmLS/5mDcMWsOYH/G8pDQ9XH3GkYM5SDMu6iOj0HGy8VtCgohtomnGmO/RrfwUx7pgD7BHEk3St3fdWEvxqbTywIgdY19B27ST5IzNBebFMbjNmkgoRNp24/csisksKCahI8/ZFLDZ7Bk6AeYRg51jq5S8wPwE9vnDsNXXascVXsR8kyBuVukw62aZEr0mnqNLVlmuZbxMNSASoXk4/A9rlzthRETXNX9Qn34IksDOXPbIhggekWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pMTks4L7/gqgTnMrQ7azVmrvTmICSeCDtWmjaHLbrU=;
 b=ahjt2KUtxzndscwmWqmXqzfRf18s2im6p7ecbwcmHIPyfCBABN2EhLp3yG6M0QJuT0DoyMb8rWoJMYJQFZSkMmMbB1dHj3BfzY6X2gn6TwBio9e7j6cGqGEqwEdGMvK27YMt7EAqcBM5s/ObD9KtX8SkbKa7SBMGQmpCQaD50PQ=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 10:11:33 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:11:33 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU safe
Date: Mon,  2 Dec 2024 15:41:01 +0530
Message-ID: <20241202101102.91106-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024120235-path-hangover-4717@gregkh>
References: <2024120235-path-hangover-4717@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: fcde6b55-69e3-4498-f854-08dd12b9b280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhLkrqMHyBtTxUQtVVCyWwz9eNuzSN+3IjVLqdM/Loh3KVO6uy3hY7FCcdSh?=
 =?us-ascii?Q?LeXOisZPrvs1vvFjPBqDF5X91H2eb44fHXPSX134J0N++oBuw6eSJu4a3f4N?=
 =?us-ascii?Q?oyhgFio0KFNKBcTTvn7E6Ya5QJbr5Reemg7HqVsS2inApSdI5yMWECcV72Ri?=
 =?us-ascii?Q?g1gfUc3/xmONpLvrRz3nOmCpEgpo9Ngxnh+0I8ABoDVce+jdRac9Rb6+MIYI?=
 =?us-ascii?Q?9E/wOg3BSEgXxxnPHEh75LIE2SYFdabIDzEUWkTAancg6g7dnfhIVxC7AXcc?=
 =?us-ascii?Q?uL98ZoDCP+aIgJVpmem9A5c9jRhxt6XGwuzv458LwH0PKszzyewOtBz4Lv7Q?=
 =?us-ascii?Q?VRqICu64xPkfAYjRNHPDF3EPL535LCo51EfaQWSxSYQKNXHTFhP1hq7F9bsN?=
 =?us-ascii?Q?DBJO5ESzTyRsSbhltvHxZumQJjFnhjw4IWu1z/4MglGSN7ql8f0aKcHIkEZh?=
 =?us-ascii?Q?gBijE5c16SV1K39eqsvhxMYRKx5HsQbmBQRCVvA3eAN4FTiLKKOsfPHP61ai?=
 =?us-ascii?Q?Ss1VxykezoxGXZqO7ULZLsFluhZQ56LhSWfiknxN/zVuLyuiGS5T1ZvU4Wd8?=
 =?us-ascii?Q?Ex0MiOtK6bN3/ISeqqfc8jcmlndLW/L6vXqTOHXlgR65D2fXCYihun8E7aIk?=
 =?us-ascii?Q?u9Q0J7RAyg2sXz9NcFuheLV2eL9GZQeFotttS1Sh4Qj8mTQMtXriUw+gaTvU?=
 =?us-ascii?Q?fw6wXYhsdGdlV1XmGInlxrb9Zd+VwZcAA6tl/J90o3U4kxa/bHmbXS9UUnoV?=
 =?us-ascii?Q?0jk3q+OIIfK3ItLvvQUv7HW5mfMetDyPB5nbuupQSyokHAB6JVyg1+HVGHqb?=
 =?us-ascii?Q?oUaH/294o7uY1zS1IPmyXNi8nGw7Xc6mpBOSSy3ZqUm5CyjOyaORhx+BlLlE?=
 =?us-ascii?Q?lYATC8H0f/g5hzDegzQ1niJXr0GJBMImi1Wd2z5gwwuQKeJCNJ2Caa9RAiGZ?=
 =?us-ascii?Q?vcstws9yiIOG7W86NxGyQsvALWpQAtwu7Msk58ddBr2SdZXMu4VcyctUPadZ?=
 =?us-ascii?Q?G3hrez1fqs6ZKKz1aa9dHRagz7vksyHSQAvfGq0SYwTLuDwEgnuxB0ytWSdl?=
 =?us-ascii?Q?am/neYArgYltojWJYCppwbQe4cR5zobKw3IJ7O1gJW7jAo+xirXqOPAFnaIM?=
 =?us-ascii?Q?7gdFv8H/esv90vV1dNat1H3WYs7pWnRwXazl3xq/3TIzSWeR4IttmGHQo2lD?=
 =?us-ascii?Q?Av/296kJ0NG6JhxYFBmUfr3LNshnhUGKbN5Vaa4mDrrr+UgCr9y0r+300eF0?=
 =?us-ascii?Q?AgJUbrKcDEkc3A6pf2UQG1NOJKq2BkbucTUKaBbHzQ6RrbILQ5+X+EaNWNT5?=
 =?us-ascii?Q?o5Ii8qnf0gl2RWO6grpsdFHTgdVKjeuhaI3mbMmM3FMxnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYN7OtrHRtkWMglAGhoOAF+pMymfVfp2IYxrY0jrlqkrqec4euiCyH2v0Wyi?=
 =?us-ascii?Q?KgqNgn8cjka/VZlgIzKihInf6cxMOZKaqoXEWB7BeWPmpbb4tsZgdMi04SQF?=
 =?us-ascii?Q?iPVzPO3QtN4KtNDOvFOGU/ZU9JC0TNTTiw93KPrAdx2Si5mcPYBJH2H9bEXC?=
 =?us-ascii?Q?Gr4Ipjwe6hKe96r9imxxY+KaODvtbpRdqiulkN0Cv8q4lUgadS1DF0uFJEdM?=
 =?us-ascii?Q?bLtmtAL9W6pSNZvjdcZMYV15cUG8smzqq8vC7VCue60Pul+kxxdDH6LABg30?=
 =?us-ascii?Q?pvvfq3tM9JXYoTUVcaNnUZ4nHbEu8po9NVxdzPCfm1wtdYmG1Tvb8CISpstu?=
 =?us-ascii?Q?Uqmjq2Eir2Snvrtw6nHijkWjFz5QB1a02Jn+a9ALa1a7JUfGdfrYQT1waC5Z?=
 =?us-ascii?Q?mwsednmyFMw2EXxo5hhc0kGp8XE+z25YNKr6inuOUOLhpa5hyU+OlMxzZddb?=
 =?us-ascii?Q?k0fSNe6vP8FhYtelUa6H/VZsO6jwlzBIYSVA+iXIM3ODhzmzVgWXw0iP4IZQ?=
 =?us-ascii?Q?+CwALa7BsuhZi8FGFljWo8KtaqyYS0ac4/rWcgLR1Qr1lRKZNXIqQjJjamxd?=
 =?us-ascii?Q?meT7PAWUejcrng36JDK6Y2IoDBD3Xa097oAjhSf8jG08OKR+KrV33PwSbW3b?=
 =?us-ascii?Q?LS/sHawJb4lVoWB683OWhTMs7FiCZBRiOpW5xKUNGGSB+dtxwZ1ExafcTqD+?=
 =?us-ascii?Q?M1AnZBy6GZnkJdcBVEM962A4iVo1pKmdAPYRCL6Nd2FlsyVX/hTRRTRszDCl?=
 =?us-ascii?Q?GhEqx9m8Y//ffmhzN8IUoG7ys7Uy06hk5c04rgAQNPuMAY9yPIreX4LH93nn?=
 =?us-ascii?Q?wuxaqs6zN/6tORbHo3D5QDNaCr8Jp5eaQI1rWsFea86PJU+3rNnM4pNWXMOb?=
 =?us-ascii?Q?ef9aDkcuiV8PGSOFMyUcMlI2Rbp8ASZyasmD+1Lk3aHDaa7YN0d02L3/95Z3?=
 =?us-ascii?Q?ZRSKdM0nttXLF24oRkko6LG0IzKMPyWiX1FH/WNPH+tTG4ZSqOxOx4CFb05M?=
 =?us-ascii?Q?/7RMcH6uoGMB0n5cSZmPHsFgGiUmyzEaaYsY5MDr7zL1kU5DwyhnfjuRySqB?=
 =?us-ascii?Q?i+wYh8P203taoYFl0zdrun99Nxt94/zI1fPkUaJv8reOWWuwdYVcgywDXw5X?=
 =?us-ascii?Q?gksEuL0R6/qkUVHPf8WknCn6EuWa/r8O70iHRa0eg4EgaGc9mmom0BDf+gk0?=
 =?us-ascii?Q?H2pm0ox8FtGr8eRsaKifZnqKeQIZjreMtmQ4D2DkemSa6OFyi2TyPZJLuAhb?=
 =?us-ascii?Q?rdX7N6sm759KhlkpOTmoAfA09GUImnG6eOILkYG3syUEfwsMlumlb2ains9r?=
 =?us-ascii?Q?AA2J9gKDn0mg8nvNYb0A5CZz5MbBmyyJVcV3j6N7OvNIhMi0M4+ipL24OJDW?=
 =?us-ascii?Q?iruOXbdCVorvpcN3Dx8n5/EmrpS+Q4oexfVdED/LnJiYdwHwER0wfaQDqMjj?=
 =?us-ascii?Q?30SugFsHfYazcYLE/QQzZST1S/1n/8BzRuOiRnh+8HY48owDSHkbGlXFhK5K?=
 =?us-ascii?Q?cNI9oH++cW7c2DstDcEm53TAS0L9DvpRSesscFvUQvhoZ79pQiH3AT77jv4y?=
 =?us-ascii?Q?qfzgKI1WWH6+B8OCEQ/wqe/Hlmf+i2+ZkX2TYYn8kWNeNEXOcEeBvFDFPP0D?=
 =?us-ascii?Q?yJVvF/4VgZpoL3XvjkCdji2v8oD2+crVvsiii1axOcC+bRRCj25mWijOcpdI?=
 =?us-ascii?Q?haqypQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WdsR2l549FLr7qJelK8Obe2FLcsTinFgTj510tCP80dfY9owgKWDZIkb8lfyleF4I5HS4tofWQfYhTdN03QxFvAo6XWAD/+m5nOc9MyHBWLdRj3nmVRnqcLBQgCD8i79uIpDHog/gI0JAMGfZAQG6Os2IT4OG4w0RJMDgxkJCEMJlFHP32YXnrfSRQxHBG3pQuwWr+sBAZpL/Xzm4N6xLRe/mfNbsNRyfEj+eh7ivvDWJ9+k+SZSS5o4+gwDd2KB2CBDmS97sRxoE7pRNCIdIJRk6DO1c1VuSsVRQ8wyuIV8qPXFCpDnDAjY3fMSiYf95FAuZHVjx5ZPzh18Z1HPckkGHwG/gtwI4+EvDpAk+KgWqHTN9Q+VSzrAWGezlp6xWifG554+8mlsfx6zeVdQt2NKp3VBAlp23jum1UBMOGKgx7XjeU+6Q3Ui2Vm5fPqjCE9ZDQdPcm68uygtA5AV64RINAF/kM4rzvlQOvvDV3mdW1B6ll9o66xMX7L6iWNV3scO8/BzWI2ZQ7AfuvHe24Z6wNl3ymi/9YCYqC80VRRArj3mAgFOXGQP8gbyd4DwAvVDzymcUNiqq9h7lA7Tl8Ul1uF3vfAj7ryuKtgM6XY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde6b55-69e3-4498-f854-08dd12b9b280
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:11:33.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlN9784yWolR5mwP16T6N5Wbah9fSfWT1bzXKQvPdodVcmDRaO2hdsYTMHvfBD7bQs/D30B1+EESYq13OiXKZZt5vMYBie846eF8u+gQcTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020090
X-Proofpoint-ORIG-GUID: xUM72t5u-bH0BcVXeEoKQeGOlvjPMGbZ
X-Proofpoint-GUID: xUM72t5u-bH0BcVXeEoKQeGOlvjPMGbZ

From: Yafang Shao <laoar.shao@gmail.com>

commit d23b5c577715892c87533b13923306acc6243f93 upstream.

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
 ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
 codes")]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d15884957e7f..c64f11674850 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -517,6 +517,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 803989eae99e..bb85acc1114e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -172,7 +172,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 79e57b6df731..273a8a42cb72 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1314,7 +1314,7 @@ void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
 		idr_destroy(&root->cgroup_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 
@@ -1348,7 +1348,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1401,7 +1401,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 {
 	struct cgroup *res = NULL;
 
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	if (cset == &init_css_set) {
@@ -1421,13 +1420,23 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res;
 }
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2012,7 +2021,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2094,7 +2103,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.45.2


