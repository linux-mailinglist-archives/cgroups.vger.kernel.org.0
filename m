Return-Path: <cgroups+bounces-13358-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLcAOI7rcWl6ZAAAu9opvQ
	(envelope-from <cgroups+bounces-13358-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 10:19:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401C64699
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08F525CA8E9
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14729364021;
	Thu, 22 Jan 2026 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GwhJS18E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vW63xg8v"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCA3A63F9;
	Thu, 22 Jan 2026 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072753; cv=fail; b=cQz25v+/FUF2GY592i51mZ9qZow+WBcgIBmE/f0qmUZazY081rYYrtmzbtcB+tsZapL/FWRSP3vFUJEiMn+PpQcV380bEdKNSRuX0ZsTYN4hmaC9wBcCosjSZgXK5y8x2f4kb+DzRyjZAU9u3tqnuMh2LX6PybryhLSIRpu2aBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072753; c=relaxed/simple;
	bh=iEieUzhBBtU9CLqhQnqzcNaJaCLsphUh6/MbLknuVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I2v5Yr+s4GXICNJ5/TyQYWPryQuiV3U8xLxVWGN1zfHVsbvy+gwhLp14s8Q+gO5i8/sIO4btSuEof/TjGqC1ldj4j4UlMht/TjYvNgOVvYeLsSJOpgGWFXA77r5vIh3v0MtdzIG4d2V4VqFQjllXdbFlwmmVu+kfI63NE5PW2eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GwhJS18E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vW63xg8v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M1IqXx3264903;
	Thu, 22 Jan 2026 09:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zDUyYj8zBNPmXNs2ju
	5l+3RAcZEMIZ5fX1NaxfXIzyw=; b=GwhJS18EaImJ0vxJ/o1woDMQSG4WdL4Z12
	eZv1KeJ4GYCqHcO1WXWJwZCw4Rf9k4MaXWl4kF+kUsoyByCd19G4t66VpUmlYd9k
	nsqgHUaTZ/McpL2GygblcrAzs1LLbK0D00EUMCzok+rFfx6am5R4uuKvpLB9EUKK
	ID2uiXBizG8XPhJYLGtzwkyfto9KTTJNd54CkSrEbxj4FbsV+16v8vlUC8RW+JP6
	eQgLpxbA0QwHK3EFBOfir9gIGKwNAfc491lgncx9/wRp1ZXRy5T0PIqsHlqVr9zP
	Uov9R6PJOoT6er8evuwnsvY4RxdgCTy2s7uJtf4wpYkpPcFcxBGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8fd8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 09:05:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M80Nq6022670;
	Thu, 22 Jan 2026 09:05:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgauxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 09:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJhf0vBhmNdhQUA63+kUFEYTA+PY8qNcgvJDILg2B00TRTNG8jLsh/P1/Ut7qeotvX0Ktj1QpOpwE+egYRY3R0gAKS7ld+/0ddL0UoFokG0EvBgo/NZX3KJZ/3PhxA4uGSr0AMDEMdBypamJD8BaARa0ijeD/rVpBFNGOP4LV6r8M+bI+3RherHxt5yly4ez6jipXJGUp7iufeyCb1gH5Duw7J10McGwFzyHmFESnALrZSsD2E+G/a4Dk8IO2AMT/2Nbp4VhNsx78DS5QYGEJ6A9lOO5kCArw3/HUjjIkn6s+hQO5lI8g6P0yGLEqKgSW26AbW957jp47CCXtAl8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDUyYj8zBNPmXNs2ju5l+3RAcZEMIZ5fX1NaxfXIzyw=;
 b=OkXmC0vTRYGHbcEpHr6vpx9EfAWevXJN2ZCdPtyVM7VGAfOIQOAaHnX7knvR//Qo+1TNvFpHUkUnPpl3Y+qKaQUD8m8t2U2jn8pQIzRmUNRHxLpvJu+vGd+mfvXXUdQgTYOZ9GsVI28NGWdYunljPYk/peYmFooTJ8yWx56nLMXRattpdPKSKwI5PMONiTA8jbrCPDbwDG+XvP+zr+XRtznEs4Ebo+GD5fuSTcyuoAbocfjcqb3kdDZTMMrvy/BUF4gX/5l439/p8L5UiYo/h+PPBNlyIkbkJnps+qsxu4LmTyGFi3NU5K7J/sTZ6UJ3H6BQDrQ0RAnN3iI8xSS60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDUyYj8zBNPmXNs2ju5l+3RAcZEMIZ5fX1NaxfXIzyw=;
 b=vW63xg8va8EB5nPhKpWJm+O5eiPqVUKt5+d+EI8Q0P6Feus5XoyhvPcrAYJUIN9bxcrTgyF7Dm2q2V50HjwXVlRv5VrvX10gR0YoSmGfexy0TU/MqwPKxRzpst7ypOZF3wkwf24uKXU3boY/6FErr6udYQdU4HzmnoKow26s1f4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6635.namprd10.prod.outlook.com (2603:10b6:930:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 09:05:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 09:04:59 +0000
Date: Thu, 22 Jan 2026 18:04:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 27/30] mm: memcontrol: refactor memcg_reparent_objcgs()
Message-ID: <aXHoMB4ZM7uoAo-S@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <843e9537bf6b99cc7f19744a6f53b92338c96bfe.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843e9537bf6b99cc7f19744a6f53b92338c96bfe.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0129.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: c23078bf-44b2-4b23-1bd8-08de5995521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enoma/jFGw90U8UJ9ksrIPkRmiSxCRvagD3Ez2jLIMN+6lce94PYybJqzwUQ?=
 =?us-ascii?Q?2u5mTaycVxUJE3udrQQ1xDPlPjc1iKYZUFbj1anPspS+LMcvCMkdDzQ4KfuT?=
 =?us-ascii?Q?FDPGsr8jbIjabqXcRQvDJKWQr38D2q95cEDV3WM1lA9X6j4lWdhGRuJGITKr?=
 =?us-ascii?Q?tITkaqGtgjPjj+dFeuTDEM4zNpqsF6aC4VNTB0VVdJiLfSQRM9lGa4sv1tbD?=
 =?us-ascii?Q?3X5Zavoqt/7o5bYbD6emG2JgjW3EhQAo2cpaHiX+rk4O334FOH7wGhaik7Wf?=
 =?us-ascii?Q?2Mmd58cs8PW7BI2aWTUJE2K2Y/oO4C2uWNywB85O+8++t0NjHB5UP5xWcT5V?=
 =?us-ascii?Q?ABbFhlg6NXFqjjEjDGmvLb7PGGVZwsb8oOyO3Gyej3Q2WICY+FhbFBOvBNKi?=
 =?us-ascii?Q?wq5xIXQXjoWDp4j+gyUzsO/bxJEH+Zp4kIp7sxFCRsqWZ4GTQeNlVzETB7yv?=
 =?us-ascii?Q?Bw0aJPwgzfBvR+EDBMQ99Q7sPpe/zGbOH+CzzDF6sx+Ypn+lcs3bG6zl2D70?=
 =?us-ascii?Q?E7rmBUu9N0IaRswQuFpTMv6rhaw+fCpfO/kXDMR9pM1RbAmhusBIKP/D/zOf?=
 =?us-ascii?Q?xbs/rnGFTrzjCPE4a8/eHI1yEVWJvH1MJaALq2QkZMvtCauTp+sXKrTvxjJl?=
 =?us-ascii?Q?UdxH6Rm40DVZqpIwXFhbvey7HTBnR/4J7eRZeEHDBBwef9XkqMePdE0pwTIF?=
 =?us-ascii?Q?GQef+RDvm7jR3rlnvCXncXnzQZ09qd47fz/VAVZ50RcMjP/MomKp00RzHnDp?=
 =?us-ascii?Q?NKgk3oyw1Mahu0DU2dc/wA/68nIJWFay05tz8LyvDIp7mKwTr8QCYbz5uqQJ?=
 =?us-ascii?Q?hCPeWJ1yturykXszqOK+0UQ/O090pwcrR0kDtczS7nYCYCS/yuoVXgcMKhI8?=
 =?us-ascii?Q?xcFElA0xAFNOvpSX3VKpCowTcwZ4gbjUVyNiId9/PkiqDyphZItCnPkq1Ry8?=
 =?us-ascii?Q?363h9lmB/HJJA0gEgmVQ0V1kBTfius/LZjuERkLYZO8Vm5KSu/5O4dzaCSR4?=
 =?us-ascii?Q?KZBKXMoCXPGD9scssDJVxYxWOWXeJpMNuDBkYAxibWVeyeMuh0TqVeVU7623?=
 =?us-ascii?Q?ehdbqfkuystBEddeV+Zj1gfen7dagZcs6opXgupr2uAk4IAvaNZbQ1doW4bB?=
 =?us-ascii?Q?o70SjuD78nAhW6HonlEDFmVP/tY6HkhSeuhSiZmo7DBSXntnGnR3dvQ/gr63?=
 =?us-ascii?Q?oUiqwoPRWqq1QvyPfcVMczUPgSZFqCXxs8qeopezQ3FArEiOntV+zhyLmcc3?=
 =?us-ascii?Q?0IEr4dnptPJN8YI0CIvPwGHrxj7Rq5OceWuEWVcKjqrqENESSQouItvhsWZw?=
 =?us-ascii?Q?mFn0t6vM90eeoDioITy2ucRKNUubiRusZXZuB7XGUQ+1DmSE/ymmg19lA8oo?=
 =?us-ascii?Q?6SSKZdb/4NO1C8ivIcTFI5KLoOiUV0Z7hbVlj19ghUJo7ObMAZ4d+Ek4Mn/S?=
 =?us-ascii?Q?QPi1XDsgw+UFKIj787z0aS84sOIpcopc2tfSxOXjHczqpm0qs0Yqby6eUNSq?=
 =?us-ascii?Q?FvjiurPjp6E6vqejmGdyU18sC9ILGBZIUYYJqCUft0p38n7WA/sesESS0qDI?=
 =?us-ascii?Q?GKQY8zvgSzvJoRBru10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIF8Xez9eVNMv9DxaWEGgSVi6Ha8G2d6RrLn7M6Xpxl/LCPw67iisT4Oo+95?=
 =?us-ascii?Q?/jNqMUHYKAFNmJORiFCddnfVzyxNMupztr9EKcFGHgiEVzx/8IcFgCyv17uv?=
 =?us-ascii?Q?t+8A39QSLL0vhvlG64VfQkQpkDHoWyERYO2J51gvKaXOYCoAnU0EJlDgKYuu?=
 =?us-ascii?Q?m2D+Q51VLyRYTVBt0a3mIUychTU9aS+UoaLvEFZLnSZSYEpR+/0npKIsVgX4?=
 =?us-ascii?Q?eDsh22xJKWr45xfAXtnu6g/i874UyCXL1wdunUksbYIddGbLp6AzZ3ln0yV9?=
 =?us-ascii?Q?GiR4ZzMDDpjwSfZcl19kpdU9w7JgvFqrO6tLHsT3H0OxqB39OfFJY27K4AIx?=
 =?us-ascii?Q?WWwk2mHGskW/IBwuTdJYNyPXHDMKZj59eoV57Ud76S8Bqwg58TMt0BqTEOE7?=
 =?us-ascii?Q?XgSQ/zWr8361xwOEn9GYPmNCPN+HkHOzz+Dcn44skV7MEY/jeiRJNnbIq6yn?=
 =?us-ascii?Q?iMnOcOA+sK0p+fs85T+uRfTGPYU5ZbkYurS4f2WGs6GS5GzsLRD8e5kLwSTO?=
 =?us-ascii?Q?Abp1VdotpfjOs6T4Z/sKZ5HenGd6X6YR+Mpjcy6D12DSUX4/U7HxkW2dgPX+?=
 =?us-ascii?Q?FZ96TMvu7Yz2tLEqhhTDhqrHC7raFWYEyCwkU3/80xCWZi50dWRkaQ1iA1IT?=
 =?us-ascii?Q?8zXkiyZGL2tlA01vRwWf47RI+egS7HnCSJUVu8XtALbRWaae1OQ1m+nXzfhS?=
 =?us-ascii?Q?Wm1TmNf1dRKIGVRmWsSDXGIddNbTuFF/KaSXSJauhy46SLttWXzNEOywwRXX?=
 =?us-ascii?Q?tKqR9alOlCWBq2thsAT9hCYL4YuV23VkMUiJIz3fH2auU1DlCIAAbgWqdvaK?=
 =?us-ascii?Q?0H+DHeEOB6HHUHeDBbzvG7cidaoJiKWVQjRfbv61ytXCOKEM8YQ8K8RVbbCy?=
 =?us-ascii?Q?2dZLGd7qUsA5Eogoyf8C5oWhxugU75Xe7y4EPfiWJGG+37JiUnYSouCzuKHJ?=
 =?us-ascii?Q?XRPnIk+ou4rkNsJnOdGpE8v+k70djU1Zet2KzYVcePEqDSurD3tPkWufBZPL?=
 =?us-ascii?Q?gSSvZIYiMeRtpWDTsPsW89VGnR28kSLC5Mcrw0/ma5Cpvh6GX/OgCR/Js2b6?=
 =?us-ascii?Q?81nvqlPohlyb0+AOudthSEzwv/gd049SxBqAnn9/p+5b2YkeV+CBL8a9fmLk?=
 =?us-ascii?Q?Fga61+7P4/214Tn+6pTeZIne4baY7c6yGkULBUIJU0cQRtZs1HsksGK4LHSZ?=
 =?us-ascii?Q?PalidP5Gjrei6wi5497ahHsglFHWVSli3suE6va+ybVCeT76pvOdZyxVznsD?=
 =?us-ascii?Q?leO7bDATMw0vWGj/ZkZU3WeDh76K+FOBQXbykv/GMcoowAFv/yt5PAnsZ/tJ?=
 =?us-ascii?Q?LUlQ7RlsG0wrXFiI1tGVodmFhPBndjZn7mgvM+dFKeNoMST29CR7I1qKg6hA?=
 =?us-ascii?Q?mn4QXjfExyox4Pk5Jn045zQaZ/zorUVkdGPo4+fb6XUnMXLYDpmsmnO1ENg+?=
 =?us-ascii?Q?2GYNvwggvRRFzq9fsNJvNWZensd2jCGvG1veybqqtQGuw2zUL6Nfmvm6HcL2?=
 =?us-ascii?Q?ykA2WSANALKhgMBVzuh+DEOzCfYUrt/f+cKN7icSZERDxlyvxWAfXJU8xmHo?=
 =?us-ascii?Q?vz1CDDQiUPgZDYdLYaEyQZR3b1EvBYb8E4W0Iar/B2XzqmEo/yLizTVIv5bi?=
 =?us-ascii?Q?33QfWmKu/W6XJy8jCfnjYbwO26opluHXfWydKNrAPtBbXAGqbtsfkWBJJyfX?=
 =?us-ascii?Q?j/Em3Yu6Ie8u5SekErbh2iLq1K3HEN//rjGsD3NVhWf8iPh2CjH01EArTHev?=
 =?us-ascii?Q?epYaTZszpA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E7UZEkhUFRusJUlF7uydl36RaTp7ZFv/Ha0KSCEjbf7ZfLLH+XIr33f/1JeXthHIrJ6lGPTGcQGN47gUNlm7BnSV7pvNDsv987yBbkKFBlv7I7L4cXNuyzLykffrscTF2xQ7lc8HfMCP7b0/5dK9pDvv5s9+illxcbamsCkDab/KnPmZ84E0ay7GaxQoGBM8DZ6rHZoar/KPa1qmFSNt+g2AKnP+XlvXkTVPiL5E8U8fQF3QnsZuvoP2sINPrryAzru1JLzRsHgklu+TGMIQ6QiQ1OQ2OPbq1qk0q5iFHQJapRnx6slqrxY1WYqdm74l2ldTlds1ODT3Yn1RyCUp8S0dORVqKTYECh9ApRD8cuZmxd0jPJ3QyKMxUWz8l9zQgxbwLj6lljEDu07a9GhIWi5CEE0vPZA32ws6gJh/Cmy4l+UqoBPL1YfA4t8uIVWIMRrVbJZP+jTRoeLWDRr8D6Ujmlv+LYpkYA0AxSXC3ixBJcRFACmPyufKfl65Pe8eBWeRaW/+1pE8Fdde1rtOBkyDOqjMgZsVJxE+6HU+VYCZmCpbGp0WFKQN9073uKAUar0c1u8u9RPScMKfAYoFoQTtxFUMrwq7WuXfqTjRhpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23078bf-44b2-4b23-1bd8-08de5995521f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 09:04:59.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtsH/Y80i4yr1Le+HRGcBUj6/CUJA9oH6hKdvOhv57jmVc5rAzYV2/rUJyvglxPog/KUPZfwVoG4c6OFhD8rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=885 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220061
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=6971e841 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=M08nw2dbKvefPC-TC0kA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2MSBTYWx0ZWRfX/O8I3p5exzJe
 5sM396iz2rIRrJrTCdBwRnVXm+gNYGFzqVzSXuSxy+izdjVE64OUKdOj12bSCVC3ZaRM2hBS1PO
 7bH7pdFa+xhzZeRQwRYr2+rAXNOpWxwJliqa4LbXfYFFgrj9VdSxbpiK0BdIU6m/qv/MJSTKDyA
 e2HHVvGBNV1xkG0sucMgFrqAp0soH1Vngss2uVz0niMpN53k8l5syAwnxUqXqZUURmpkR/Heu9i
 jFmIWL031+28DO5FWXqAxqL3xoxfd1GWYaGRcLXKKuGF5s7ykN5XPgbcrFSsgTYUOmhf3nZsbXY
 iuMd1fheq64/1CmdmxM+hGy8ommkl8Yj8qndr7i2wgxcQjqNrffHWIwPO9VnfJlpEDt/dgWEdMD
 v5l+OtqhQ2xoE+U5Xrgk5tqakmPXswp/+eU95QrLh/mqesjdRecytwpamIJ+2jFYztB2kkguvvD
 84oxo/KBESDJmEPTOBH+4FPV/1SIR3uFchlu+H3Y=
X-Proofpoint-ORIG-GUID: ytmRMpUpSbKYwJB9HS0l5y8BotrqEd9N
X-Proofpoint-GUID: ytmRMpUpSbKYwJB9HS0l5y8BotrqEd9N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13358-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,bytedance.com:email,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5401C64699
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 07:32:54PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
> LRU folios here.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

