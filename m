Return-Path: <cgroups+bounces-12085-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B9C6DB1A
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DDEEF2E2C8
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04FB33C194;
	Wed, 19 Nov 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FAIDJ1+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A1/DyAUx"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8930101A;
	Wed, 19 Nov 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544223; cv=fail; b=M2buRyELfdgN1Pm6eYNIr1m1knBb1tetzraPilcNmtdBlxThQ3aWeoDn0Ux4X2kUoRNaOYglEB7EHo1eGS8ebOHiS68wYamdoLfbTgYkSDljKLYZxDSY61WMLuyY8CfqYFJp0RlgW5n3/EargS07ATX1aYIwlaz+otPtcTGbK/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544223; c=relaxed/simple;
	bh=hkv1QnmlkD1agZedDFTT+0vrfme9rgYGdQR8wifl6ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laSIqjv+2Ge3MnbfxaryO07tfufmwCuZQFLIgZ3gKy+WOIl4o/xji0PLYsvjGa+SGP9o6/4IrUewfRtVJyUsjmg2CL+VWRyKbxyraE3XtIg8bF7Mw5JrkGzJ6kXP2lRGIK1dnsKi2f18qIzk1/DK9SJYSm5V5GHNuzSegjBhHoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FAIDJ1+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A1/DyAUx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ9BfQH023358;
	Wed, 19 Nov 2025 09:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J2OI+6894m31Al2d6w
	DsX7g1YhEV0tRzVqY7yLG4OEs=; b=FAIDJ1+T29DGq6ZWMSJEczCHQGTipqlrOC
	308k7mbs20s4N2xRgPlSDG6KS+N83+EK8kNv4XQI/gVEdw2XfvnT2SNL8D1ebsyK
	xkeRDZLzVpDi4PbzykQs9sOGYABisRqiKSbpB5GOo0aa292c2WUTY1zZYKRmcPXG
	P4KBjRvuSepsjiN39R2MUp5uzBEWzI739r7w9t9uwXYX9ALyFJB7yiV+8BzrCxnB
	7ZKrhY0Si4EgqnB0TRVL3amkbGutBY3AYsXO9s7yPFQ/8RbJ1z7Y0DyMeoPTrPAO
	JjnEzeoo7TC4zrOV3j8I68U4G9N9/ocVGPKTPRrT9JS6kdF4pnNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuphu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:22:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8PrDG009444;
	Wed, 19 Nov 2025 09:22:09 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyech8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQWnH8Pgs0bBoNI12hq0eaAjgWLARUTGRr7lbjYunTsQ+WMeiz+aJ5yc+E8WsrlT8BQ8USt4YiFP7mvoQhYY4DzkA8Z5N6FWtlKODafXEHbtrZU/Me44du8tJwK35uTBilk5Vxf54w9wyk9HYWHSJ+aBFWEqiZNSaxKfs7kyDrzn7u+yWpT1EifURLgMeSkGpinGeFTi538rtlq48WJTOpp6Z7DxSzJTDO6wO4aXn1gq7aUU7hR/STmp1UegWI89owD2ppBuGAt6RPprg0cd2Gq8FgiActp7xr/Glf/VbayieD1sTy9RWN/WMQ8BNi55eUUx8mtdpKO8v8/JoOPqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2OI+6894m31Al2d6wDsX7g1YhEV0tRzVqY7yLG4OEs=;
 b=ZxYFTReKLlaq0p2WCKgrh+bnGmtdKNGS1Au/QezNlxti1cph4OdJJIJZVTE4G6c21eOY1Re5WbELu8Ibo4038LrIdW+W4pA1yumOxSVVf4M3WdHMTU9ZpAIzMaklNIr0n/iE5+HzpCk0Vjwu9xGkNGycJPI6mHaRLS7/2rKuSKsGiskMNbHcR57byIw6rxanFkRVDMU409bxqqluuwaj3RiAsa1/D2EKgddPps4c/pZ59fH0eLh0x7m1GlUfW0oj4kZ22sxPecgYlXTmn3jFN+jft5rEZbZkawIjN8yz51Ke7b1b5mSDqHCo0TDFRgLALl/6gFJP8QEVaphOCvRaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2OI+6894m31Al2d6wDsX7g1YhEV0tRzVqY7yLG4OEs=;
 b=A1/DyAUx8Iv1mnnKfSve1jWVp4bFq5zU5eDIYJW80zVhdBZsMqi9T/GSW8jG+9rU9GPSuXVhnGc02OTqLADoLz8R3057VjXVXtc5nzvmx/EB8xCjUaIfivqTJLiPbAjKGaphaLyOWAOZdxogwxGtY8pzrIfu/otLa9cbwtC4qpY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:22:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 09:22:06 +0000
Date: Wed, 19 Nov 2025 18:21:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 10/26] mm: memcontrol: prevent memory cgroup release
 in count_memcg_folio_events()
Message-ID: <aR2MNSVoj8uXLZBS@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <eddcfb8a49c915dd897a91ca5560553b2bed9623.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddcfb8a49c915dd897a91ca5560553b2bed9623.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0043.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfed95f-1c7c-4ca0-1c23-08de274d1b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pLq1mlQznbjJznMqIluxPNyPIEhblgbqi517VNajKtim/mbLp0TCfqIuBa0V?=
 =?us-ascii?Q?902THAUSyz8EoNmuO/EIjqj0RPvK71+X+ztlYHgJ+R2s6umaN0OKZhYLu/Bn?=
 =?us-ascii?Q?KBtvYvuDUwF0uzyDJ50QrNZAnAw0VPLcuNAxGmBJz/QyBpfHnnzWfDJbOKqq?=
 =?us-ascii?Q?3i75QkqCb4PMK8m6wlF4LEuMeZn3g6fVt6yhCSOGQGcuVrQA/dBP7W/WUi9d?=
 =?us-ascii?Q?jERQK2CA08ZEifEV+wrCsaTSH3Q5SBGOXzQ43tL8iS4Tc957nHC4llR6sEuw?=
 =?us-ascii?Q?ywJo4YnF44WF99IHgPDMkVU/ycJ+eH5Mn1rdHXOqMV30FUekiyW5O7uIy9FE?=
 =?us-ascii?Q?UBpG+Dh7Myb5vifXg2kUqb2n+87VDkr2IAGQQ+17Xp2hOUmevXm8OMpMl4tq?=
 =?us-ascii?Q?wW+ptwi8ozPPqXMd8tJQIzijoEmxxhzJVaqPrad/dG2MPIyyfI8eV4cuF8OU?=
 =?us-ascii?Q?D1hhh6hrJdvdAe4Sd2vKxQe4y/iRvLPl/AhSkhjYl9/UYnimMV93cKpUBMZV?=
 =?us-ascii?Q?WHno278XwmdCmxY4GzhHMZ9Tz3r4wjMPIjOWMPamuhxT4tVuseZGKUBZloRG?=
 =?us-ascii?Q?omAvbdW1+mhnLMkzj1M7VSN4DMRYi2H0pB+DIHXavIxKNytoTb0pfTqY0EvW?=
 =?us-ascii?Q?dBSA5/8EowNIDCdCvnu030ZJZl9lxZAHFSuiuDaipueOcrtesM5E6tmK7T1y?=
 =?us-ascii?Q?0nN9ii+Vc5axeFaUmgMMVnV3cJs7q4qj9CelAR5VE13IALRXLbhcnnPFByuQ?=
 =?us-ascii?Q?0heDhbuVoNR4p0zwv5hIHbZUnrkkUsfE2V3TwgmN6rPkcMTjnQevbd36XEnC?=
 =?us-ascii?Q?zxt5actvW9+WCtTWXiKF+GHeYw9XoyuDUaegGe62w7sPSaXM0GDyuuTAh1ak?=
 =?us-ascii?Q?x92VXac78Sx3+IiS6qVQUD7JDtTU1cQodgv0+AAFFZs7+cv7IJaety3vomRf?=
 =?us-ascii?Q?bjpV+qkavqeWek3OTCOpT9/jng1i62tmi3fpkKPJE0sEeDX0yaYj3w4ISC9H?=
 =?us-ascii?Q?Mjc7/VKpiimGlsYDUJHflU5J7CQ2g7Dwo7A/MePyyPsb3IDhMXpXwjcfDUBZ?=
 =?us-ascii?Q?8QUqOS6tRQTF/eiKGyNZN5bMx7fPRbL8ezbj4ZOmSGrcXumTEE/EEBXblVYA?=
 =?us-ascii?Q?W+y1KzgPw4gcV+0N8S+aYps71HSuZg1dwaCCU4CvKyt5mOeugf41oo2s26LD?=
 =?us-ascii?Q?Eei9xtk8HM0UCUWatFRYAZ76H1ET7t19x4WC06XAOBVOFnmZL22iYfhfy3bs?=
 =?us-ascii?Q?l0LVFvQdL1agaClKcrJhNBJ9wHh7DJxgxCucrXLjze+CORSKq2nyGd+tTlPu?=
 =?us-ascii?Q?0uadYq02Zaar5BF8jyR3CH8K26L/5E4WGC+HuQUJWXSLsn96jYiik6JB5n18?=
 =?us-ascii?Q?JHQfku54etqjZOtcQFFnMmUCF3TwrcP4TFapksrCbU6DDEejo5rt6BSe681w?=
 =?us-ascii?Q?U9s1O4otgDXrorhtpnwzm0EDSlj2Enn5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIzlBibpF4TogEoikXjXU/2F/dfeatxUnItQkCGn4UK50T+2pJN2kcOOkzMA?=
 =?us-ascii?Q?Sr57LXWXc/7IyB01RsA9FAF8C5fR0DVTjoZ/HTcJkD+SikT8kqVydQCL7LJW?=
 =?us-ascii?Q?a/zF7PUGw2Rw9bHy0BmQLPrUg4EA0+nMUvpdLBvbx0lp0xAWkL+a8rKhIhuM?=
 =?us-ascii?Q?Sun1Qf8EDhMI6hPoITfXMb7KEAjcj6UR+3Iq/fgaPHTtnnlICH/sJmcGEBzT?=
 =?us-ascii?Q?a6ajWDQUj93UmENoBsFc/Nj6//pzZ1Ul+pTgwHeFengZjfhkwZJVGa8ab7I+?=
 =?us-ascii?Q?UBAPetL5rlVQBqy30gQeT00ypYvYYC1hvvHBfyPuCRvLfBZqoFBS+7WkYMG/?=
 =?us-ascii?Q?n0jCebhINJSYG75k46QvM+ltMNiJmv4iehiRwCxJ1EmQtHL1Qi4Z2ArGnMOB?=
 =?us-ascii?Q?ml+9Fe34Er2nYrJs1+w/+xfalasQl2Q+Lj6xmFqTlU8fscDunwF1LNsfTrE2?=
 =?us-ascii?Q?NPKkqia7kMHGO3+9LF/1IscEjmnVYcl6j6oalQZUgn+FZIh8VtGz1IXO7qwr?=
 =?us-ascii?Q?MCnc5fBE+nbzENBU43p/gpThqoVHwX/IWRSzS6f5iYP/yqvib19ZV8DMg4CI?=
 =?us-ascii?Q?ekQjLfsIBpGpqe35C8knfQM+hk692tlfoUTH1fdn0MqFSSPFah89PVYzAM5Z?=
 =?us-ascii?Q?2qpDrthij2va2BgDgZTny82YAA5MsrH23nSv3w/0QwA19Cm+Cl1xvgD7eBn6?=
 =?us-ascii?Q?slCER/n7sNb7GduywvhEYs4Kcy8Zlb3MZpmJi20BQ7mH7EEuShSF4zQZu/R2?=
 =?us-ascii?Q?0dynQKrdLS8w3RYavb8uBgKMnSnD5hN+8uj50VS4saIpYZ65TIjb7nb1LvBQ?=
 =?us-ascii?Q?wW2/F0o2Jsj14uLNWTUKK8k0sk0zwJoPXfb5iG7mZFyjf+R8SPwAYpfm6V7/?=
 =?us-ascii?Q?uE2eey0zi5hOFJfCsbBQ5ZnsNKczyPRG00vFLIrkSGnnGl165NDPqsqUN/kZ?=
 =?us-ascii?Q?C7IQW6UteReq+6wYl7HjpSb1vwKwKy1DFdDt1gMX67gdgk3KqEZxlJCwi0Fy?=
 =?us-ascii?Q?2tF6dBTt4E4ISKByq9Lc6jeYemkyqjtopqFYdMIjn/m76M51IqNTuHlRbyOC?=
 =?us-ascii?Q?Te5TGb787B5g1Or2dS6sfeKxyIp+vXrqYbC646lSPLqslEEupeWPSeJ3XasM?=
 =?us-ascii?Q?uK7jc46k8oCxUNZeSmz3aPViQ9530t3GN0m/xDSD3ow7L1P6zxfLftd45HvP?=
 =?us-ascii?Q?Cswg4QgkQno/MxtR00LllNTDQiO8KiHkWHlbwMYA780NAPYb8ah7BJCgtX/k?=
 =?us-ascii?Q?zAMrSzHj9mDnmPtD9nXhkacp3VMdISvvRmwNdNDea6rJ+2nPaV34yCdzdYki?=
 =?us-ascii?Q?AV7ZtoxJQazJC2R0P56d/CeY9pcpHLj5uV5dyzzKQaLbLT6ofSFFCvsWpbbO?=
 =?us-ascii?Q?nDCqFbY3bhGDteB7c7Ha21RvBWtt8KK0ohS2+p4m/wmx6BGr+c3IxcBT7tgX?=
 =?us-ascii?Q?Xc4pRMkGUd+vc87aUsffgv659Wuyf7cT87YbBur+WCGaDikj6/qBAN7XihGK?=
 =?us-ascii?Q?opFvFrtQudJQWbUW50AXm6n/RGSO9HlMy+3mNnI82FeKc19cWrHVdwQ5Ttci?=
 =?us-ascii?Q?Dvl4teURy0QLWV0lRx7FxViOiZCNsOhmRipFVfQt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GZo43SFhqlLQdjKsB8tz6yaYYIpAPi+6B+yowmEPSE2IaYaNmQPhu2btHR0sg/Q72hZrXNxdEitk6e1lTCIbhp9ODb4GhUvbIlnICats7ERzDbVDRvju7vBp9qko2oN1UTQ2RYsMkZsmsNF1Tzzo4VaMy2IOe4qoW6R7Ya6bsQw/tyFoJxwdpBJlX90lentelLNR4a2isXUwNyTiLATg7N5Q6a+GOKT/8Lckm/Wac5pw63yl7RDd4Jj7fAC+XvibWumOxoJY1OlACFNiklf2cuKdAn+GwK0bC7+g2vXuqBwcJPWcb73T+FviLGVnJ9l8qHPifaR/JJDKNuT24hjjyZqJV27NNZH6kW139Q9d2c8mrx4F86YVrAJjKOQMGR6bPBZna9mX2NapMKPeaOngCc059qRIdvRAR01hNLm4ZEZHujPTfCLSpLGBj8AWDONyaACfWZDiilswSKEllszg0pR8ZwXthjNpCQUm85x1hglM6WoicIQ/MbnCEwUvS5RBt3aX2DEOVh/eOvhvltrOwHhDnMStZdw4FBaBzoiFMOsFHS+FmxAKLfWhIHSxsj12idKDvKMrPdaP57Rq/PgmvlcQcHkbUp8v2xgHocQ/d30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfed95f-1c7c-4ca0-1c23-08de274d1b30
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:22:05.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P1skBCgnO/oYGK0FtTAk/B2x505A9NPMrJDhC4fNuNbqO6hwbBRzHrw28iMScyIelLGwjbrLmGvVGfDTDR1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2PbCMCa1If0O
 g+jLX4oqJ54jOxbtzmXZaqIBwcAd2O/WNMHxIMfcB+6HNqMKgt1Fq4ICZKUiGd6XAUq5fZmJdIg
 /MyxcQfzSzf97sRWpUQTMw6zq9VPdT3vL6Pf48LCu0P7e+7abzmu3J52TyXmKYQT0ggbziCVbyI
 eoU2SJ8/JDX+C1W09NIs8Pc+Y9/j/E6OshJwt/9y2XSme1ps3ezXNn6sGwEYB0gRGkPxoRKZNR6
 eYcDeAuzMHlcSHjXKmBKvy9zGIQzPN4O5scPVDT30V6B5AXXyWi4IC4wEEe7vYBbPOYzLDcGlnS
 VXaXtaoaQpbNr3O3R4SMdI7JKx7JhUXP+nGpY+NidVWl52QIsxi7Vuik6L67luHoOpmyrkWhdmW
 BE2y/sjmSwvdu3JFBpefcCqZFz8nJoxtUKqE6uyGCgjT5TC7Skw=
X-Proofpoint-GUID: mOnhD6MR4wJnweAN6XMD36zqoUUab4W_
X-Proofpoint-ORIG-GUID: mOnhD6MR4wJnweAN6XMD36zqoUUab4W_
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691d8c42 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=XoEdJELPLrNRloKZQIUA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 cc=ntf awl=host:13643

On Tue, Oct 28, 2025 at 09:58:23PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in count_memcg_folio_events().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

