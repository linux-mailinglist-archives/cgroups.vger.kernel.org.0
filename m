Return-Path: <cgroups+bounces-10510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A1FBB2435
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 03:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C119C8264
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD57262F;
	Thu,  2 Oct 2025 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XrwhfqM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wb8B3y2L"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF553BE5E;
	Thu,  2 Oct 2025 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368281; cv=fail; b=HLqImjmZO8sXYU5jva7HzeqS5FTdvRSTWHjfJk7X/CqQDbEqNE73c5hCEYskkm9CTMG04PGyU2nA2+IFvSHeCFjGaaHxCqorF+TRsCtJdTgtIao2xeb4UBP60W7f4d0utaYDrut+My1ZUaIKKYk8Set9J9q+i1zX9k7G/VwuKuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368281; c=relaxed/simple;
	bh=pn/r8C10J9ngfCTMPArO4AHGOiX5U+yvVXjmiHYFPK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YumNXKWqHNJHXOTJkqzs1LthILT/H+x0VVd3Jfb7sxSxCn+U4a9xYW/i+BNc5TVefS7Z7B9a0R2cUFrKHA4F8zRjVmuLlkilQH+UNn4OXnIooL+RT2h/gJ9kFj3Iz+s7XXS3qopHi90F3Ii43MqUF9xja83iEncT8qdk1lQJKhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XrwhfqM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wb8B3y2L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591LgRAE010029;
	Thu, 2 Oct 2025 01:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A4CQfqoiJKCrsUmd9e
	AEPOEPvJzov0MwzZDA3F1RLhs=; b=XrwhfqM4Gq7276H41n1RtNPeWzdSovc5WF
	dSFV+gUDV33pc1/Oxe/5M/h9+p5RxRcAfnweHm+z+avoLOKtfE4nfpias8Z+lYk3
	P5dFXqJDVg72S3dU7IaPbtWvynMNtmgyir062rZROy+xB3bk7vUzjVzGS5XNLQl1
	zaZ/5G/YyaktNNjWzg5yMDuU1hcCN/N3KneHdAt4RcDHcTx3fZ3/zsb5UIlTH6MO
	wN5u9Nes08gSIg+P8YHz3cy/3ft6Xq/CNgfjFjdBQkIuMW85kGqeUQi9J2AA9Nxi
	LTxBFzU9LINjvsS+UFdZ8Ejb7WPkcO7fHPuIQiaMAU4ag7097sUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmactjmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 01:24:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5920B3xO003040;
	Thu, 2 Oct 2025 01:23:58 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6cada3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 01:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYMK2/XHRpZUG6AqouWxy5ER4FEk4Xd77HGS+EQhq2tjig/jWZah2Pghx5/4prNOQBRpEwW+wZCKbVtNkX3j0jDhZJvGJ67S/QvPl+WjMJY4foqhdNhZo30/CbJXrhrmccY3o0KoLOOspewbbMIOw/Gr4VoP5cnrCcj6SScs1hZH0IHj6wedil4zoRGYEq3+IKYvLt1cabs7ZnLSThQq51FsfBQ0+5zEBQkhtWNK9Kta6ZdpLj0F9bGg9UDlloBtsJ9/ri7hYe4DErcHymWXMToHk7jTRXOryQ25srjkUTPero16QREUMbVt9a5Hs6A04X38fY2ahGeEHwF1xHp2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4CQfqoiJKCrsUmd9eAEPOEPvJzov0MwzZDA3F1RLhs=;
 b=seqKw+n33tzmTPurQzTFwPd8Ze0gF2J9jRsGColyDYwgObz68csyksYdqghz0L9F5uoh70N5Q817WsUWiQq9ZMt4BJWznZAIPzm1elsDlCt77ncGsbVkU56a+SWbIyhLkbtjppTNk4AsMDScqI1/4+WPrxwNBL7rlbNDMJDEyOg4sLXGtjqVs+l6xydRSn7dKnL1+5dYfO7hKhgtcUJOlYqfjbfPBpG4oH3UDidhNtsoFOabRoN2+PnOWluf0K7msKUNfbQD+cPNiFIMD9T2zXkEutod2eaTWRWGKVJ2v70kqEe/2KQL4A9wzX19cb4IZVML+EFBJOWMzHcCjczXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4CQfqoiJKCrsUmd9eAEPOEPvJzov0MwzZDA3F1RLhs=;
 b=wb8B3y2LmV1caflM7mCJyzn1bUYCB/hzw+4jHdcMlWIgy/lKmjnx92WfXUfpUV8pcneE5IDutrB0Vm2WCmqBXbkMEEm81jvW4PtV7cvUs65OpLSrctvp3yWx06Fy+n9VELZHn7O0vXCvTYjzofkbtervhi/Ocf+YtYIFNrg1ld4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7733.namprd10.prod.outlook.com (2603:10b6:a03:57b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 01:23:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 01:23:54 +0000
Date: Thu, 2 Oct 2025 10:23:46 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 1/4] mm: thp: replace folio_memcg() with
 folio_memcg_charged()
Message-ID: <aN3UIj1Ec8aDlSaj@hyeyoo>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
 <488cc8d44ba9ef1ec8ed2b32e7267d83cfd5736d.1759056506.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488cc8d44ba9ef1ec8ed2b32e7267d83cfd5736d.1759056506.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: ef30e1fb-af41-4e83-8b2f-08de01525a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?soQmBv5VqL8s/mieH/IxulAp8dOpHPGpdImYaiqBMqikWoj+O9iEZ7QOaccF?=
 =?us-ascii?Q?lIUKoY8VHsOKULqiq9PROO7/gUJv6DYWOtXmOVAp8/wd7M2xqsvGbmMnLjpn?=
 =?us-ascii?Q?RtxkSYJk79tCZY3AjG2llNLPqh+zJTk7L/0vNwx9Q+fAhydRSC5gf83dVjTT?=
 =?us-ascii?Q?jFfLDkTx90/qY4AjCZmf3gNQ71cNNrFGnHVfV9+IfPQoojIUOlmb7oO/6uAl?=
 =?us-ascii?Q?7E7MWQHfJUcWohhowBsy2tuQ3wwlzBiEzX1tkTvOukWcSBOINYL/VgdU+xjn?=
 =?us-ascii?Q?ybyWSyoUnpM/pC+P7BT8sbEiqjnhytwMeNojJsKfcxroZu7D9F9RuEGLIPYR?=
 =?us-ascii?Q?D8oeZHE3AyxZlGaH+/Pjym3PsckbwPl2MtDGe/XNca6fNMvXvHHlyyqWJfkL?=
 =?us-ascii?Q?7xUrVrn0BZzS889V3+WWknAPmCj+FeFSqGDHzrhtZHDDAvM3TEBLwmEFSmiT?=
 =?us-ascii?Q?5SPrzHspWgMtdRUQUKtnvw1iziER3psN9IeHEJkPWgs09AnN6FLhdWXEHAV1?=
 =?us-ascii?Q?kdEpJI+teVQMPoVtGBz097NTWTd6fT7rJ92OztQlQh7pfyRHtrFtQM1WQGZ8?=
 =?us-ascii?Q?AYFcYuFIqJW/YCCz5pjrQ9pECHtP41+LuvxghWburhNCgvz5fZbRehMSGO43?=
 =?us-ascii?Q?6MRh3rQLg+cNxl0Lxqcp36eaoWCmhHKWdWtVruOwFQ959RMyj+gdx97OsE1Y?=
 =?us-ascii?Q?feVtNKg5nQtUktlt6tHum+Y4idGogAOBz456C0UZ22xtr0snOhqGsFLjvrtC?=
 =?us-ascii?Q?mwiwI88CA90j3lpWpziCOdGPB+9KjQLQfIMwNSc/MjCuaAR2fuxM0HdlHwZ+?=
 =?us-ascii?Q?RgZ++ZvLODgrXrRCC1Rt6nRHV57lHmfv6K7Oiui09omrpZhLvc5u/F5QJ7wN?=
 =?us-ascii?Q?d9nj6sE1m6Lb38A77sh232KNWcQ6w2G3siA4qa52ObC2vTAfBkh4b0Laa7M2?=
 =?us-ascii?Q?zqPtFusZAhsGoZI6auz9R4oUtRjR2uyim9WIf55XDsbi9G188gvPclqQxa75?=
 =?us-ascii?Q?L2OVwnL/gPmpoh7FDDFBRByGb25gJEz1OSMEXXRMdM582yhEazK0Lvw771LA?=
 =?us-ascii?Q?Pa07n/8erWzIZC74c3FzsAsl96+yeiKL7qeTnCcRNeii7VjMKGDtdszS9xV8?=
 =?us-ascii?Q?jYQyOiNVEFEUPr0X4HSEmDQUwG0o8tzBNg71EtutfWaUd7yZ4FhMliAwCUo2?=
 =?us-ascii?Q?ROEEg9phc7+VE4BhnqAePuGCWHkFEF9EBq7bO74hIXkwsmPgO6zgBp2bYNl7?=
 =?us-ascii?Q?D+vQokBMJo61agoqlXMJjpL9BSKL6eGvkRWZjq+OB+T0gTqoWDBf+7ey5l4B?=
 =?us-ascii?Q?x5uOMjxKRcX/ALCdLOG5LNHvYMN2oB3/ljuMWMi9t+wpAN8bOv/BaEWUZ8i5?=
 =?us-ascii?Q?v1DHr8z4gWrJqyhtKKuuHdgGSfWgAIauxZagp8fHbYHIR41cDHxp15gwp9Zh?=
 =?us-ascii?Q?qKbY7Nsu8hQrO7lVbQzhffetwOGpqa/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DzoAH1yb98Offx7paYFpWuNdeCKOuTI+CIdNiEXw1Ju2Mk4Op5ucVoY0yzx?=
 =?us-ascii?Q?dMr5D0zqTGH2olBIYXfYOIPISA3IRqTGMsrx0Y1J94bHn/8HWlTvWkzIqmeM?=
 =?us-ascii?Q?SX6qeb+md6J7hY98lcbJPPCidYe4zWezxpj03O2I1Htog4gg/6DxeamveAJX?=
 =?us-ascii?Q?6KHE9FrjFtpWKyAPwVFEURZE//lI9N2xZFijcpsOKxLrCoWWgXi8jIe54jZB?=
 =?us-ascii?Q?GKS3yNkV3hyfhlrnhkhI3dDDGSOOILkRG07J42CFzZ/7oCz/xYGu4KGcEgsh?=
 =?us-ascii?Q?hPSqvC9WBuh4lWFw18P1pa+P6fjMJ+6Ac0gDTiDDHRU89E0xoTLw773SfW/H?=
 =?us-ascii?Q?7syJKU4zwp4NM2KXUfzGu5lLTxp/JmiTMmNB9y0NXBkmrnxSbJf0IGAxjCUf?=
 =?us-ascii?Q?8yoQgvl2hfLz3bCgEELb8WvDji+afiih1IzvwtFtYSlja+pWhCDrxr15BGL/?=
 =?us-ascii?Q?3L1zFUdgSH3Zxpzh0PJNlmafR9S0qoCtQjNMXrNonEph9jP+lUCs1SnDkIwm?=
 =?us-ascii?Q?XmLbUp6E3st4ovripbLroGm0fjibaHX1avDwqNHL9l13T97stY29LkSztOSo?=
 =?us-ascii?Q?NS/QB6mh7FQEmv92QKFHB4jfobhUDl41YZ5cfImmP8MJdOz5ODQRvVYBMyYe?=
 =?us-ascii?Q?D+6vw4oIsZ2h+jpczS7dnwVYAUiq2MNhWxnQpCTqt0xW+oj4py3SNHNO7jJs?=
 =?us-ascii?Q?/8NCiJM134LJD0PNyxCkokH0rp+r8zr/u1q6u55RqTF7jXArn+Hg0TfRGGxD?=
 =?us-ascii?Q?0pklAC2wdEOQr3B7N7pnezgs5e7fqg83aM6+oC2ZoneigEgf94Le40XCB3+f?=
 =?us-ascii?Q?YpmJO+YvmJr0dtxCGH8Wx2xiKnMmDUr2BFDKnPdKw9pY5rl2LiwFmLD+tbAp?=
 =?us-ascii?Q?g2eS9kOFjARDVmta85fpJdDbqQBBNNHqoS4qnSwlDe0n3l/5TNqUEUgSxhCn?=
 =?us-ascii?Q?VVXfcNLJDlXCHoPPZxqTS3U0S8eQIgq5Ydwy7dp3wMZLB35h74gEhLKC6Qdx?=
 =?us-ascii?Q?Nym0yw1htTT29IcQ3fFHPGQTO5543wYqL9KOEzcXjM+7Hwste6XPlKnUqUuI?=
 =?us-ascii?Q?LWIxlTW5NUbzKhkwJi2vqWvZ5JsocpOdJlnIf6NSSqjHkX3moW+qbTAr4R5S?=
 =?us-ascii?Q?62Jkh0vYpzm6doXrVAfpSZkkDzE29vDZkODp+PP4kt8IgP5b2oIwNB8C8qze?=
 =?us-ascii?Q?4SC5IMZlToMQ8VI0cV6T5F0+6oFsDhrR+TopQfDIQjLcUy/z2nPoqWkCF+k/?=
 =?us-ascii?Q?9BBhVAEv5XBIdDFspUB4SAISDF55jQNQYFYATS/h+G0+Xw3vHcCHDSUoliBz?=
 =?us-ascii?Q?p6X9D7GS7R1u5zu3cP0DxPAvHywRvCpffECl67rTTJV5vWSDdZ8u/31ysdzU?=
 =?us-ascii?Q?sQc7y8g44YEoVugdsWuE0Xk7DClm1DI/IhH3ieq1oDKGYipRydPgRrZ9aWPU?=
 =?us-ascii?Q?mlr4XF3reVw+FA/J+33qC+Au6XznFRSmwyMzCEImJmc7bKLkaPetC59Q2sCU?=
 =?us-ascii?Q?ncyo0PBq3FbhexUBrtK9VdP61/k2MUq9rcniaumwbL6Yp95DQwv3867BdqEp?=
 =?us-ascii?Q?+YBWkf+k3wluI8OubTQPiE2zKkmAqd54usMyAlIL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OfNAeclOmiktHX3vxtvf1cYxdpuqfOyeJpk872vyNYpHwXE7Afr+zpnp/p1RpxVCFuCg+RGggKbLRtd/XgRlcMRmbUumTjoWRYcQowVDKd7lpOSXeeVs82tQxsI7/I8tKQwEn9AvM1AJdeFgV1J7WpKom75tBPZa3mbcA2nhBhI6IX5YG34Q/L6ssbDuBbOMEYLubL5iUaH+HhdMRC5Bz/dXFtah4m024ajkWmdbeNghI+AAuEGyuPi1urrVJwy5Fu1mg5jLPvG4JZPLFTtMkqJDsGoPHgBhL559gZQ/gTYwWadg9xiI3Mv11cAJsOhC7wnAEQ1BqM0Imf/eAvUP5c+x4VvDndck6Au3yKMNZfWYzJ6+99FGiRjhXd+mO+TFXc84L2OTHsbYoJw8DKfJfgZ8J4zCx3YGQH9I5Ft1jurPh/TxOC3HjQrumjxqhBidQU7YR0wj/jZuF8TL9xjYPApVhPEycwOo/FdxisO52DBCwSMfKI86Ju2h9kBrSWTeSFJVs9igaHspgmSuBAcwT2lsZM+hDQZ2X9ZLBjqMkZN1aogTvjpSEGYjr1YgpIsnsfxaj3nPKVutc5RuFvheSdGBUdedXJnUXFPnQ1FMYrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30e1fb-af41-4e83-8b2f-08de01525a0d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 01:23:54.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1OHHZO9FdofVaFT1zxkjUs1eyu7ZOEbJS0+1JJdlce00+F7tMngKIKWDbiRpvYkY1Wd7K4ztlDoA5ikwPZmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020010
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68ddd432 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=DcoFswAzfnP7r750LCsA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:13622
X-Proofpoint-ORIG-GUID: 1IADOdiL0Tpyf0wcjeRW75kjR8VcUlNl
X-Proofpoint-GUID: 1IADOdiL0Tpyf0wcjeRW75kjR8VcUlNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX8Glr5aXfHcMV
 EJL3tVIBVgxqilhVMOxZFL14LDjly61SeFpWRW3R8g7hNmf1sOMY+/xzbhJqHbp3OmtXaGTHNgN
 fQmacIpXXk2AHNtbVdFj3OKxXcMvwoRHYTxUgfTdRkuTw6IWn5p8us5/YVu9dexEnQDMntLyZN9
 ZG6k8u4FV5rmGLrsAt4+T+W21qKAAx2PsBu4JI9RyXcLblJApBkDM1wosVBBznXgkT8oQRTa02s
 N4Qy5wKH2IxQKJqO1QkKKJ9kGZyUJi7jUkFXq80pXhB0gbtDaW2cdwI7Tg9PqZmX3NlpCMIzkGD
 OCRlTSaUwSUhEeWHareybgcpGpt57qskNLKrO3jnVRVmm5wKi0CcmaJcVb8JS+JkMoqj4BZYgRr
 qIo7kDcwxN8L1yHwb5N90DQs9LzgzxLYomo8tOEwhd+9vxCErHM=

On Sun, Sep 28, 2025 at 07:16:59PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> folio_memcg_charged() is intended for use when the user is unconcerned
> about the returned memcg pointer. It is more efficient than folio_memcg().
> Therefore, replace folio_memcg() with folio_memcg_charged().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1b81680b4225f..6db24b3a57005 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4014,7 +4014,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
>  	bool unqueued = false;
>  
>  	WARN_ON_ONCE(folio_ref_count(folio));
> -	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
> +	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
>  
>  	ds_queue = get_deferred_split_queue(folio);
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -- 
> 2.20.1

