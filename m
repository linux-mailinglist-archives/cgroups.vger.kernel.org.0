Return-Path: <cgroups+bounces-11725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD512C46640
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A44544E64F4
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11530B514;
	Mon, 10 Nov 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUga48GJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wL8JIIpG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6C3074A7;
	Mon, 10 Nov 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775584; cv=fail; b=OtE1fO6pjo01mJA9Vjm28Idg2jy8qhiqeAXUFUR5xJEWN2fzNfh8wgG/eqHe5XhOjMn1DaHdbX9yIuw8FkFCY0lg6HiD07Gkkl+t8KN3h4hA3RnUBmxU57yWJqFebyXbA9b4sec2uy8oTIhJArxXicdfKM0uGLjtE6JI3sj9ImU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775584; c=relaxed/simple;
	bh=KGd5Yh6P5KIIO/OkzzJyDEJ4Ahhbe+8RB8npJXDmrZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCsOoNbnKLD+peb/ziLq8NS4s0xAZdOyUpJfZHnKKYa1PekPYna0v2NP9RmKNagOD3peXDFc67/GRcPbPd5BP2neYFMPj2wBVfWCHUqaQCmyNQ8BKglAm5ImcVr5iSVNirNNXItOsyrILeV/DVUu+npzLO4mAbIAMggziTP2YFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WUga48GJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wL8JIIpG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AABoh3d005307;
	Mon, 10 Nov 2025 11:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J+BbbIpl+u7EQXiu1V
	inz6LHwKqMGNgqMKTdTMPuDZw=; b=WUga48GJ9bNf5+jGGoTtWqzdQw6QPj2cQg
	Pepu1B3Ai+/4ToMlsGOrdCgIW+EYibNBAa9DqDRamy8Plvk+y84y+P0B0U0TrL7i
	4GP0bY3LEzIFTZp53tjIaK2i786Mq0l02IaiOcOxIJjoo8hOMYzC8Abzsu/LfI75
	Sf6YtFMKCR9Lwb0GPbeDZFzKO41vATkiN/99BUp7G9L7GIhL42aSvLNldDpuaCBP
	FXhAMRN3CtAiXXQVvQsfCJlC6juLMEMgZUFyRxPs2iT/3jWx2Du+oxlhqbLtxzfK
	ozNGx8n+u4LX8UAOGwpmIgVJjU6yNswgdJPmH2BNGBDicObbsxMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abfhar054-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:52:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA9awei000888;
	Mon, 10 Nov 2025 11:52:44 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vac2bma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsV9d7lYQnUkc8vEycZef/mKbI8wZn0HADG69wFo3n+ErWMDvd/sTcT7BnxnpiZhA6kJTaBIniDzJGK17mioSoGsUnRJAfOd9ZTJ2H1WYBwDGPPhLyMl0yQO4/38K/08kdVw0tWBhLrqAeaJOVzCC7Mwsy/HFcZ+RjlP/zJ/SLQcbSgrawS9Puhto8XFE1OO52drZLCO1uvq16H/oNPYVfhmL5GxW9nLftobnYrY+QldkZPdqS3yY0+BPYuh+eOCslc5t7xEK/QR8iz1h/70H1zEhPOvkWDyEp//7BK0EWW8zwsxKDiHt5ql3U8wND2ZOq72r9dID0oKuebm57IrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+BbbIpl+u7EQXiu1Vinz6LHwKqMGNgqMKTdTMPuDZw=;
 b=oU0fMQbL7pe4V86p5nzxX8tATUm5jE703ul+a2VBVQkNGvjPYm4mTgubPzNwbs0LCzR/AxHo6WsB8L4XbbCBD8EUthMhPm98HAFGSsI2Mk/0alE6d62hDZw2cH9LYsPdp5PxFHIECYZXvQSHqGyPFBuvUzM/4v6MRq4GkYyeFGlxIxbceL+UMWPxZjNPveuuYNwdYowDGJt93f8ttS4Fgdl4/ZJr5psmUn0SnGDeNqABWcM4BQ8nDd60JQD1G6Xd2Jp2tAsBNWCl+xOOsWNmEVZInz/wymE4ySo8QIo4w8FD53xU8aRMGDBgH7oDRe6TgYDzLQwTL2kxL1s/Ki3atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+BbbIpl+u7EQXiu1Vinz6LHwKqMGNgqMKTdTMPuDZw=;
 b=wL8JIIpG7JRR6pWcM+pVmobrbbwePwXi1WQUTo34ec0d8hHgOstKzs6W/xFY3z54ahiGJZGfJMVydYBX7RLoOa19irrb7gUYnVxA97OYktkx3FkZ3JNk6pXovLsDxP/T/5Wjv7tGDqWcoCBrCMUVlZMX8z7J1JAxOgfgrRR3J04=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:52:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:52:41 +0000
Date: Mon, 10 Nov 2025 20:52:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
        mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
        lance.yang@linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aRHR_zAx1HgyQJqR@hyeyoo>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110101948.19277-1-leon.huangfu@shopee.com>
X-ClientProxiedBy: SE2P216CA0050.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c38f2c-f59b-436b-58ad-08de204fa735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PmZgLcXhNlIZIHrD/SMrQFiE3IyE7GXoQC+zvFF/y/6pSv6dOdStG3w5+QX?=
 =?us-ascii?Q?0JutmvOWfR+67s91dUQdQxyXAUSIGFclooNCd1imvFIZNVCywH5A3kPHAPAc?=
 =?us-ascii?Q?X0JZKvmPmV839gmM18NQ5tvBd/l45vEPaMpdlkMwb0QCZKi8MuZychD46v5k?=
 =?us-ascii?Q?6uJzQlkr+cjYuFBJk668I3oUK7/vkwcce9wPixRBm7W6F64wB5EnVvquMp1u?=
 =?us-ascii?Q?+fQIMG3jC00ar0EPhtevMO6BcptBb+/2zwxfT90uZve0CwKrB/JKPSFFBK7y?=
 =?us-ascii?Q?d1gnqJI8ikd7wvtydBxnLhOpteWinysJjtqi5FFq+wU5Nr3vNylZ7GqqqE2s?=
 =?us-ascii?Q?IssUI6YZpBxiLM5GPkLyMJ9kAPGAHLN44W3MOwbMq3/GF3fMz3xR2pbpbfrK?=
 =?us-ascii?Q?yKUt8cJBuiQqUl4WqHx1fPjcqEULLn7GcUeJJEttbWuPl9uD1TBo5aysNtyI?=
 =?us-ascii?Q?mDHuDradRCPG1Cmz1G9qP5dIokwz8YTQ0rMpnfAxVAy8ict9B6X9bM5tt7WF?=
 =?us-ascii?Q?HrrPVrfD/f/BJHEY2UmBwvi8n5AzVXoGUdg1LFDm8VLTD+5TxeDGYm8wkE5a?=
 =?us-ascii?Q?UcKIBET7heylOHgX3TPz8uxgPJXClxFHhqVSB0D2S7ZwIKFWsEns7VyeJYwC?=
 =?us-ascii?Q?Nm+OnAHCKzKfZFbeEUoly54/YQEvrH485vWkAeKkeBmBVNmvDxP9UJWb1ced?=
 =?us-ascii?Q?YsVo/O3wAX1RkQfUGSGok6WLBL8PibCMTbJWkm3URtCOT32gOCGb18agcjfG?=
 =?us-ascii?Q?ET1ltTha85xwbvOt6Kc5UmjolPgm/TQuLh3TyvpvNRIS2S8tT3qgcCx1li9P?=
 =?us-ascii?Q?Q7K1r684nK+/2ktAl55+fIxcIP7JLsmMhHqHqoIFH741uDUg5bLu5VNTEYSZ?=
 =?us-ascii?Q?tNojMqWZrE/6cUBaazGW+kgkIiI+lUcVCRBOHJMTnyAf7sLp/BkMaBnK0oJp?=
 =?us-ascii?Q?7i/IdKeccS1S6KN+JrDjs+3AxmbKnHDOSG9aHGjXZC+7Yx1w0baHEV3gjaKH?=
 =?us-ascii?Q?ZFZruSGrkQKYor4LEF/Jiwhta+je2EkOZuq+YBqDg/4lfiKHD5yN7bB1ZQHo?=
 =?us-ascii?Q?3ZBVtMKLWzF/c7uusq3sTOaD1BxY8jT8Vap/6wfGXjc5B0hRRZQ1j29Ef9yt?=
 =?us-ascii?Q?W/TbteMOg7R71VSvwq0pNQ6bOx+QN10lYze7ZKwfj+dhiU2YTmI8huw3e0+G?=
 =?us-ascii?Q?vP1I7tpti7ZVu7PsfLmofi+UNPaoQ7TLSuxwij8ee4MnaazTVlPQQ83YzkkB?=
 =?us-ascii?Q?3la5eaP73A3Pj5K668N62Z33c1CdG0FKd/Kk9KjHEGF3DbUzyTRZzanvno5J?=
 =?us-ascii?Q?Ms9GWIgFqAKiKu0S2XeE6e3gObLXjBq7jno8ly1ay76KyejYSOLskNbvHPAh?=
 =?us-ascii?Q?2APS96goa46OJjeBTYoQYDsca1vq/9Qdrb35pT+FFLqqxOONObvOLThpj8D6?=
 =?us-ascii?Q?TGOk3h4RgT+boug+Np+us9sfRzJOwHPLnQiVnIu2xVc50O33bS7ZRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnjV53yMX0s61WWplLYxJ4X9byW5/YpIxtoNhwSBiL1qOhJWq1UixLqCqU1d?=
 =?us-ascii?Q?/0C8MuCm61NnfeAqeUPW2XNDBUA8NSI7gaI3LnfaPDXGsfC7rmD4ZarUZKEo?=
 =?us-ascii?Q?3WAPrXRsWtsEGxAsoWC7oqWwwGRB2O8wVuHZUMIZ8mzIiJB+TCDl/5QmzYZR?=
 =?us-ascii?Q?P4+IEaDivHTFLbx1rOJJ/LzYt4Zt3r11w9AbQGhPwdpBscp9P8o09n8F4o6s?=
 =?us-ascii?Q?+Z42V4BvlbldJ433akzPP/5yCzms+GMdDhmZUj7eZ8Qlo+H+bvgLL/feuRv0?=
 =?us-ascii?Q?mq5Ewed/zIBkQQue7CMv+urcw/aWmOOdUH51lOW6LqH9GPPPvrtY0KD/xToI?=
 =?us-ascii?Q?oOOsgIm+Gf9I1LAn+LGAdmyNln0hvy3xrg+N5b0nhsB9yzTIOl5HcsUwPsx7?=
 =?us-ascii?Q?m0e5UIkjBSqB7KJfVeDclLHlegITH+emc2+PPquI+mt17ByuLN6F08lphp9Q?=
 =?us-ascii?Q?S0FOcke6xsG6l3eRifwmgyL+IrdawnNzfglePFzSyr15vQpsEMSjNk45rMiA?=
 =?us-ascii?Q?0btqIGG6LWBH7crOmOE79QBlDTEUhakbK4/qC6zwVD6MBd0yRV0EaP6S7SpA?=
 =?us-ascii?Q?/nL2hTobCqnTccaMc8mh9TDuC3R9Aq3WQyoOIiiupUAydSNjcWd9k45UlLiE?=
 =?us-ascii?Q?EMfVvxyYmXHGauXE0vTIieiIIRFvNXGDkZW7z9bbXXl3IEROspE4IjDaSmVK?=
 =?us-ascii?Q?Y3pWuqx3h/ty1Hy9B6vnaj8sxjGTRxqin4CAFeI/vLt/2mmhwJhAaZudQ9Oz?=
 =?us-ascii?Q?IK1aZ5DZ1/lHlurfKOLiE+Z9zxmolc6Q40KjjI8gsc2vaVucbMB+gs89tRYE?=
 =?us-ascii?Q?BTLbiFSywiW5gPdw6rY2Suq/bV6Xl0rJaqOr/2dMYIA673wSPpb+e6HUjrfU?=
 =?us-ascii?Q?G1DpC01Va5lDxVqZQnFzsev53MfOFLC0V4xN+DZ8y1nRmhgw9PQMxm27oUNl?=
 =?us-ascii?Q?JV6iU9/OJqsFePC71qGNsCxfN1ULnBMBAoEOhOZ2dQZ+LZYZnYK2f3z1+bgX?=
 =?us-ascii?Q?0zLzDc9A8W8sqS1BcnQDtIemOLjIKIRNT7gAqDx8W1BQGMMQtJfccUry9aCr?=
 =?us-ascii?Q?zSaopXeVW/9aFUbjoGelZ+KLWizCHsrzwuv9RyMrGUWm3hdw5dWVb4hMgCdz?=
 =?us-ascii?Q?rqH/ZgkTp03GT91UoO21optZeB5OtTyG0k6egQmsiVv7R6VfrWFxlbefNdKR?=
 =?us-ascii?Q?wJtqnNsPkDMP8BfGwnBSyVwlq1VIFOfClRVh0/FgcIilmp+qOPE6Y/xUamgU?=
 =?us-ascii?Q?JkMtxRyFX3DSlPxjH3kKo35TOZjAhRzXQ+kbRb5a4HD214h9DtugxB61fzv5?=
 =?us-ascii?Q?bHedLbdiKNMj5xS/Lc8JgCFq7ZHXktP5pbK5YLo0f0HpakYXxX5UC+zhWdsO?=
 =?us-ascii?Q?GxtldlEZkgKuTY7vmoy2o71zDiL2G6lzSngOp73BHkHJzKSyMQUO4A3eaRpj?=
 =?us-ascii?Q?4eTpOcxWnqd8zffoZKE4C42+Pxi02lhQAU6JaZKGtnELn5bpiuxv7mZTXmTr?=
 =?us-ascii?Q?kNwSsPh3W1op6LWXm2g8/wLaY++SqC2TOfFqbgV1wMTG28EYcoAA5gglmESa?=
 =?us-ascii?Q?kNMhagDV6NRxTUZ4jRlL5DMhiFxJOq61MRBgm9qa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WHDuMriX55hQkBc5MVxbnQ1R/wHMgULDhf5yjn3nym2HrcXm4qvapEy5NLU5DhGGCVkXohO5Iq/fHK2Nw8yzyrvzUdTOlbhEBTEysvKoudJyHHQKSovpq3sRseRWkJjvWIQCeMxoQA87KMhjZjezUS5p1RKk0q4dMQu0e+pI/Uo1TBpfZVFFk4KolZ7vMO7YKC4wylg2fa7Bp9nVp+u7czuFOOuN0JVfcTxRh5VlK2cRcBaG640h/CaDb5yfab6FbKPi3nNjEAP3YyhOrc1wbWi5j97DRb5zgA2IJCu3a9b7iAlOyl7aCmT1Z/8svl5KR29tUYYfxg47lqWu86Y8GZmR5Y0oxSPj0fDZLwFozlhsiORqRxXp7g/1bDkjXxZPLpSYCsf9m4rWqvLdD0DK0FomODxXd1gG3BbZR2EF9lpScjNZHxVc7k469Sw8HMjDcFdvGm0aO8iTSywHWq+mKl9HvqLfkjro3neX2y+7gcr7OwiamyXHUMAkvEZHjQjtai6TdMfprGNN5H6Jd3ectiU61dnacs3sCH2RKCYtq8Cpd29QE3Y4EPA9mQs40H5/mH3qKtIucDeEGSO0gucZOFydOfFqQ/Wh3kb9cvqxMic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c38f2c-f59b-436b-58ad-08de204fa735
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:52:41.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe7UmGqBqMCOhaiSpF3yy1JelsS5WEn6Tycbh0G3TA3nywdnORjEWpwhCPHb0PHPXC/uMdrsd9P/DPtF274hpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100103
X-Authority-Analysis: v=2.4 cv=D7NK6/Rj c=1 sm=1 tr=0 ts=6911d20d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=J2gJbEVsAAAA:8 a=MOSCPsoLFJyRNCULsHwA:9 a=CjuIK1q_8ugA:10
 a=Bt_igOxda4ASFyQEjNxY:22 cc=ntf awl=host:13634
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMyBTYWx0ZWRfX9Nmts/IyH+Ha
 T+WVFYh6N/zc7FfgMKhoDaph6x0nanKqSBi4IJLOJXAhIuAmTbN6Wyi66wwXwS4AYXjhDbDJAel
 Fux1LoFZ80boi3ZC0VSee3rDGHZLhr22a36LiQ9ACo7aRRufDC0aVibLlOSAj+XBoPzU8EAEKAO
 tYoTHsbO//PcwZTac5zUNQRoGWxRtpuHPrR0+yqzdCn6/EeJJ6hU678lJojvVE1Sv12LcppQME8
 o/b9O/CRWO7+C2SPSv8ll+wTDQ7u0xf/wSzKb7DNqGnMiYEkaZmSdAp7foEzjoCkbUK7MBoD/ku
 TdV4WG6TnFzGfheuGqvmgCAzSYB99yX+43L15BR0PfTp6D9bhgc+GVKwsAByTHxsvGn+0BtRj/e
 uLon7VtwSWal3KMISRoiA+8KJrxF5vTqm558sghCVBhleCZzw0w=
X-Proofpoint-ORIG-GUID: ILuLhKAg8Ucm6WSDbdxABkdpdj0YDBJx
X-Proofpoint-GUID: ILuLhKAg8Ucm6WSDbdxABkdpdj0YDBJx

On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu wrote:
> Memory cgroup statistics are updated asynchronously with periodic
> flushing to reduce overhead. The current implementation uses a flush
> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> determining when to aggregate per-CPU memory cgroup statistics. On
> systems with high core counts, this threshold can become very large
> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> statistics when userspace reads memory.stat files.
> 
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data
> that is thousands of updates out of date.
> 
> Introduce a new write-only file, memory.stat_refresh, that allows
> userspace to explicitly trigger an immediate flush of memory statistics.
>
> Writing any value to this file forces a synchronous flush via
> __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> descendants, ensuring that subsequent reads of memory.stat and
> memory.numa_stat reflect current data.
> 
> This approach follows the pattern established by /proc/sys/vm/stat_refresh
> and memory.peak, where the written value is ignored, keeping the
> interface simple and consistent with existing kernel APIs.
> 
> Usage example:
>   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
>   cat /sys/fs/cgroup/mygroup/memory.stat
> 
> The feature is available in both cgroup v1 and v2 for consistency.
> 
> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
> ---
> v2 -> v3:
>   - Flush stats by memory.stat_refresh (per Michal)
>   - https://lore.kernel.org/linux-mm/20251105074917.94531-1-leon.huangfu@shopee.com/
> 
> v1 -> v2:
>   - Flush stats when write the file (per Michal).
>   - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/
> 
>  Documentation/admin-guide/cgroup-v2.rst | 21 +++++++++++++++++--
>  mm/memcontrol-v1.c                      |  4 ++++
>  mm/memcontrol-v1.h                      |  2 ++
>  mm/memcontrol.c                         | 27 ++++++++++++++++++-------
>  4 files changed, 45 insertions(+), 9 deletions(-)

Hi Leon, I have a few questions on the patch.

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3345961c30ac..ca079932f957 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
>  	cgroup is within its effective low boundary, the cgroup's
>  	memory won't be reclaimed unless there is no reclaimable
>  	memory available in unprotected cgroups.
> -	Above the effective low	boundary (or
> +	Above the effective low	boundary (or

Is this whitespace change? it looks the same as before.

>  	effective min boundary if it is higher), pages are reclaimed
>  	proportionally to the overage, reducing reclaim pressure for
>  	smaller overages.
> @@ -1785,6 +1785,23 @@ The following nested keys are defined.
>  		up if hugetlb usage is accounted for in memory.current (i.e.
>  		cgroup is mounted with the memory_hugetlb_accounting option).
> 
> +  memory.stat_refresh
> +	A write-only file which exists on non-root cgroups.

Why don't we create the file for the root cgroup?

> +	Writing any value to this file forces an immediate flush of
> +	memory statistics for this cgroup and its descendants. This
> +	ensures subsequent reads of memory.stat and memory.numa_stat
> +	reflect the most current data.
> +
> +	This is useful on high-core count systems where per-CPU caching
> +	can lead to stale statistics, or when precise memory usage
> +	information is needed for monitoring or debugging purposes.
> +
> +	Example::
> +
> +	  echo 1 > memory.stat_refresh
> +	  cat memory.stat
> +
>    memory.numa_stat
>  	A read-only nested-keyed file which exists on non-root cgroups.
> 
> @@ -2173,7 +2190,7 @@ of the two is enforced.
> 
>  cgroup writeback requires explicit support from the underlying
>  filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
> -btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
> +btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
>  attributed to the root cgroup.

Same here, not sure what's changed...

>  There are inherent differences in memory and writeback management
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..a14d4d74c9aa 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -4666,6 +4675,10 @@ static struct cftype memory_files[] = {
>  		.name = "stat",
>  		.seq_show = memory_stat_show,
>  	},
> +	{
> +		.name = "stat_refresh",
> +		.write = memory_stat_refresh_write,

I think we should use the CFTYPE_NOT_ON_ROOT flag to avoid creating
the file for the root cgroup if that's intended?

-- 
Cheers,
Harry / Hyeonggon

> +	},
>  #ifdef CONFIG_NUMA
>  	{
>  		.name = "numa_stat",
> --
> 2.51.2
> 
> 

