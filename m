Return-Path: <cgroups+bounces-12145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55003C7723A
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 04:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C2AC829048
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6972D1308;
	Fri, 21 Nov 2025 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EqkcI645";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApXLzISY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DF2BE048;
	Fri, 21 Nov 2025 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695030; cv=fail; b=OMP55i3atWxhDiKaU/VfUHeeq4Ga0RNQPexh0t2FOrBmkFGa/b10yIq4hCJxuq8HRHBdYtbtFBL/+kPdmQXgNcfpOpyYnZ7h9TXWVjeJn7+GhuJq2cTLrEbg5aRWhpaCo2bQTpeZXytHucuWx9sAATPdh/OKMcvnhaf4kh/OjF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695030; c=relaxed/simple;
	bh=BtAum5lSBvSwTA7KJzHUq7EnYjlDh2/EE2/trl9Sc6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=otTdYd+By2f+ZQyF3CD/jOOX1ytUMeFjgEzNSX7UuAqXcEsc7lNV3i3rLdGVOy90WD3a3gqCdqOWe6PNYg9JtVrQ2/JV3KYEuBKgJXhFCgGUL3roVQjuTWAgrF/IT2ByLWnJtOn4x1MepIOY8nPJFK9mf6LOu9p55un5CpWhWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EqkcI645; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApXLzISY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL1uZDY020996;
	Fri, 21 Nov 2025 03:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IOFQmOoHl6qLSGsB0K
	2t1kr7Eq2BBlMS4X3EU5XiHiM=; b=EqkcI645olfLNpE+AU0AXOJHZyLo4Spold
	d+mXSTePyxfhjQh5rPE36YnRR+DlTHpMdHOvUK4MyH7+Dm7yIz/Uuobo3jsHLsX9
	LNtL3IPMYcF1AwGbi3ixIS3M4Evgl36xX7aC2eO/VwOwHvdFcTosMGnr7bHxP59h
	2zqWq0Q9D/5r2H1l/PRYnJ1G7OjCBW0y3lmn/Bd8KKVvTPF/p3Ha2oN0O5SFaquE
	FmKWOr9wA5S74/MBCfWwar29nxUNc73FBwMHjFeRECPdxf54mxWCdYl00XWFELW6
	/0wnM6DjLiYNO3STaPb0kRAjaf7GvxlmF1p9GZ6xM+uWcwAMB7eg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aj5dts448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 03:15:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL1uZke002532;
	Fri, 21 Nov 2025 03:15:29 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyd0rsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 03:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF2q02ajTNWWV2vhTVeqZ76ATEbMcxk26oFyn995MYJBzNzWjIHPHXGctVHFUK/8Vl4bzvoJAoFxKtn4o2c00PuZTUYU0/FVTVhZ2iPik+AbLUATyyF47TX+3zyRNdakprlyLo6KibvNzqklCRyUIfyy59DxlQnK1lCsYD/CTbA5tT3iqBKSbc1wp0q14MS0Q+F6cUhTgp2ANhRSfMAJ7PRzRBMOSzzKJ0pasYluQ1U15WK+WvijdXeB8rYUDYm7bT863rRZm0r8UnplRZDn7hKPnRkr38uBjuToTLiVjb5TccqHAvFi7zBxKxYOttdBsvSXHr5+177S8sb27v9Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOFQmOoHl6qLSGsB0K2t1kr7Eq2BBlMS4X3EU5XiHiM=;
 b=x2BsL1Qn7v2TGPKiLf6/3Ho3FjuugiO53sCqmUVmWJKRcR4PdnJdiDFcAlo5dejmRrBAV82FgYOeYXkLp6xyP0hJrCsaXjrteG2bL7+nXniubXuPWbTjxV2ZY6RNBxsQvURjHMoCLBuLmWsWKHfim8Q+SLTpdiaSHrclLV3j6x/RdKO0dqXjSEVPKH1IxqYhz09wbTDgJQrxY7Y5LmohRJrMm9azauBqgcrixKPq/wfcuIlhWSiLB3+z5vrT20bNqqHTtmFkcTWznvaDIESye6RFh2Xk+DtyTlXk5SOlbU1KO7OgWgwY/TNJkuerzJIy+YswqUXWZH2kW+oAAXQj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOFQmOoHl6qLSGsB0K2t1kr7Eq2BBlMS4X3EU5XiHiM=;
 b=ApXLzISYP69AthDIfNvoVBeVxZonJi2PFwzcMntrnb9F68B4PcuktaFWlhE23KUrlela847vUcbxDqhpTwdzMyf4h1+rGqzm4EkQtobAu13j+O+KKqsGlrZppYfjFh1valNly2/8SgzcQ4k3QZqVuf4PE+xQeTI24ELvgsFKwfY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:15:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 03:15:25 +0000
Date: Fri, 21 Nov 2025 12:15:14 +0900
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
Subject: Re: [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <aR_ZQjoAA9CFwcKG@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <d5d72d101212e9fb82727c941d581c68728c7f53.1761658311.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d72d101212e9fb82727c941d581c68728c7f53.1761658311.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b96cc0-9482-4ada-076b-08de28ac3691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwM9PBh8bmqFTjP5AQX0S7JO9IqbAkV6mkaz/p+ND+7mVo7m9+tu4TVa+tJO?=
 =?us-ascii?Q?NULsIOv3hVEJNMZIlS81zr6ZGVhY1MroLL5Q/ZeIGbQrNRG1mM6oE4UqXdlu?=
 =?us-ascii?Q?mJHSarF8GvX7u6uoYVIUfGGNoVSOCRn9333ii0ndyZ7c5zLWiioorEJ+zy9x?=
 =?us-ascii?Q?hhjoU4i/ueGLqXvfhQIBn04ujlhcg+ytpSqKnGfXpI7buen1U+VLY7MqJAm9?=
 =?us-ascii?Q?CbQ3yxJhwopJ1RfCI/wZ5LlfodK+st5hgcA60nIcN1biyLYgOoeEmFKfSV4Y?=
 =?us-ascii?Q?ac/tfzpzLeeKTtBOoZ93ZbSpyuIjISwF6ZlNEjbLFY5Rfz+OTR/7ngmsM9AG?=
 =?us-ascii?Q?0qQCM2AjA65sHTO+O+P65K6vSD9YSJOcZh76Sgu+FxqCgOTTc80bQWPPuv23?=
 =?us-ascii?Q?wQW9N/YLrxkIlrIvKQ8T3pw3gau4z+RSIVyq2wKwzQ0lNRjSNDQLzhvGpJ42?=
 =?us-ascii?Q?SgLD1pWNm5dTO5P7bs0XC/1E0YGSbjoM61LDokTdGoAy1O1ltz2WrOy1iIfs?=
 =?us-ascii?Q?XnEITUy2YuvmpLcQaX3DFIfTgvxQW16mpvfzW62nYMeKffbr9XNAR0+R49L5?=
 =?us-ascii?Q?Eb6nCD9aKK16U1zkLTzRpkGi4V8Q9VwCJSNQmwvkGK8BAUi6SghA24wzE1/r?=
 =?us-ascii?Q?qJUKOiji7wJblb/OatnF/9E1MGh9cVitFkH2eI5YW6MH0zrFa0x9cZ/EOy5k?=
 =?us-ascii?Q?6iKZL4ImTl/QGlHmACdc1M/f9Oczr04c9lb6O6xszm2gPFdTDh6DgHjQEgD7?=
 =?us-ascii?Q?B4hYKnq+4k/Ve2oAFZDztGSj7zT+To7uyQwEMxMwDx0tsXLrFCZ+8Y5gBME/?=
 =?us-ascii?Q?a64garNkDwkv2goegAcYy6kzlGEhLr82Fi86Yvqrwcb5b0fmPqnwWCeIBF10?=
 =?us-ascii?Q?vzSi4BIvmFaR7qldM37tYBTnNNz/DHuoOWwbYz/sYooBu9m4kNMHIjWCGqgL?=
 =?us-ascii?Q?/F71ZJoFBxcge4Gv6+lSlZMrGKrV55f1Gt4F1vSPZJHTx3lF3WRJKVioJ9AB?=
 =?us-ascii?Q?ezrg6+dFkQQjjBI0GnzcoLLyQq4l10s8c3YISbtlVIwREuwZHFo6Tz5cARHq?=
 =?us-ascii?Q?KmeyQdwCTNvCjEvMB1gGpko2wGKTRaRMy/GjbYaI4FwR+cFPYrXKQ75SQ8rF?=
 =?us-ascii?Q?tQl5wc95bbLEEbJ/wNtPPu8CXk38F69eJGgtWhO12MngwrHs8yxUvEHcpBaP?=
 =?us-ascii?Q?5l49nEJJU98UOM7U0/7aiz8sYwnNRdzDSVkIxRF5UDgjrer9nH8ChAjXTLF8?=
 =?us-ascii?Q?S24jdnXfMLE3aq4wbhff2eTTJtTsfi4FSSAZy4/go3OLHa8GSSCbbFthSoKr?=
 =?us-ascii?Q?pJZaUwwAWpYyS2HMfGJDSZOmei8/DEC4LZIGCIrmsN8Jm+EDroYnxZb91NbT?=
 =?us-ascii?Q?ELyWFTqCF4QJl124CItO6sqtNw6oRMzYrpOGoxArWoQf66cb/Kqn1STfSYUA?=
 =?us-ascii?Q?zksXBOYoqQ+zMl8fJlvVyD0N7Xc+EsjS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RhxFZDh5F9oVt8z8q1bZU0eXda0fSyGkddlcjXz6++bup5F95KPmei9t0xxh?=
 =?us-ascii?Q?Bxv3JMSvyTB/JPZLe5xbLkMQXjEwbV72DmNXuA5Rj8Gx5clCKvKBcTeapa3e?=
 =?us-ascii?Q?L8CTtFE6E+PFDZyy/s/978JUf6btLEFMM/LLGKG1dVHQwl819i8xra6eWXB3?=
 =?us-ascii?Q?Gg64iiSAXoQ/XrzlGfL6qRGdfcvZuxfx/UoRbCQIUcDSwPuJoWUsMnfI7G7+?=
 =?us-ascii?Q?Z3feTOaJ0sfFFQ9PnZao4lblg5rQcNIM0L88cm8mewAwU6BE3RsDBYp6JyNt?=
 =?us-ascii?Q?ULXger4CeiINxsRcRZT1buhBNrwPoIimf9h8EV4JoLZt+fEojCW6POmHA+Ay?=
 =?us-ascii?Q?vOKHhW/GDw3ThY/xdlkeTjplDJcky6N//RXgaufujhwHe9RqGU1Vymp9CRnH?=
 =?us-ascii?Q?TBm0lSBg36uBdUzlWCExshoR5f/wFnygbuBLcIeObtmHjeitH8yPEjQ7CrNc?=
 =?us-ascii?Q?0Gbe5ujCcWvoiCQxJM9+co8pL+HkJ94zX7tywWU8XoYF8rXaXDgSQkqH9NPc?=
 =?us-ascii?Q?bTn0OWh5rLXtf+hW2sLWGBYbNlos4frBtT94RP45SWHBoeaJqeR1KONSFi90?=
 =?us-ascii?Q?Ls/DCE4lLTwqKOEpLbgHFI5y8RqJ1SFngFUL1XHo5J/2dJ7LzW7t/WChOkV0?=
 =?us-ascii?Q?QITG0+nFYiAtx7LtSpcG0eQsjNHNMkzjStBPy0Yv1yCU7su27U/CVEw1advx?=
 =?us-ascii?Q?mCoJIue90kIru7Jkd8TN5S8yANsKoy26fYGc3r59FCoAsU0k7NrxlWZVLdQC?=
 =?us-ascii?Q?zcLAZ7xUNEW3JEbgCWc+gfhOyaOGTBOeytJT1q3beDOIM/SNezb0E1bM+faY?=
 =?us-ascii?Q?IYCqHcsFGfxRBlTst7CFBGEzMXEdy9NmVVJEj0kJ43ONzwEIr3f+jhruPdBf?=
 =?us-ascii?Q?Zc8GYy8/OM5pD9AozeeNk81OzPm7bWyN9JVxzfyncQfBaoulnejLV3hQ/ua7?=
 =?us-ascii?Q?JXWWS00mc9ViK7esu/LnFDFvqdDWqPfwLq14Thr4rPafTbmQQHULWDtFw78+?=
 =?us-ascii?Q?WqF6nFl5nQFGsnND+zywin/Zw52ssifGe8mEmNbe3S94Vu4CwtX2b/v3MmDk?=
 =?us-ascii?Q?ZC/uMTIKfvvKYslLmcZDeAj7i/8w2+cfnLDn4adGuqRbo30krVBTdVSs2v+0?=
 =?us-ascii?Q?Ru8BCnGGMn7ND10nSHmSg2VD253iHE+/YQedq26ByLErhk69GcV5yLaPNUlY?=
 =?us-ascii?Q?lqTe5FPm5AZEzO+HGjsKoLIuPEnHbv/qD4Dkq8KxdkbJKlJFTYiJP3V1ypIg?=
 =?us-ascii?Q?dNJ7yI3GBFj3bIxtV0Tag/m1AhZ9F9Mm9dqC1ZmOIvAzZpvnKQWY36mYujD6?=
 =?us-ascii?Q?WySesmTvRqS62cpPGVBpu+6jbeltx5ALmaAR63Iz8Kh+ZLi/+QzTXIsmaBwB?=
 =?us-ascii?Q?sNX47o/HojXip86aVK5/NugdikVMQIW933JblMtzO83JDI7118AQHw1dSUlo?=
 =?us-ascii?Q?/q2pz/NbJPGosca4+LqeaphscMAJEbWz2DXKlePWYwCnineOzqBfuPu2xcsN?=
 =?us-ascii?Q?imEfEj+s6RCkNKosUOMYLtaPO1ywSxso1pH5/A3GeNjTXNpAeakuGDQuqvhN?=
 =?us-ascii?Q?+pp8iAWG6lpXqGpPn036LdjTp+Dz3bGPDJUDBiWO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HqnshCVBRw3DSTb5Dzw+ZQu4tpJPgzHdoM6bWQkMlpgzjvsOr4YdL7jJ2Ll8SjOZxEbLoAUT1I0YN6drzKdwT8rzn9GTToHtUyN59BJIXyuPnkKABPrHtIOYaSJWL6iLq6Js6fJhTQLvav9glsoLsWY4xzy0bVAK4Qijv4z15/VHPA2xBLAIoBhX5d+FlFvt37rLSJCNpDIHTR4XNAXW/fUQ2CnC2vpUBCeK5NJXlK56Zy1NOVzjgcA48t1scvSXVy6AJSbbvYX4GYrWgM+zyfS3NF+OYCpWIS5IPrsNdjSzhf1JY9Xyd6mq7tAKH1OpNiI8rD/ko3XDRZpmWXSa72x+DENUMdj1y/DcDd0QAVZfZHylMdzHwTk0UFvBkURwhR370FiMvU9g9wnYim5kaNGtibjIgcZVGrKSUvA/FjBDrw9w7ycs+cpAb2BjHCi+KasunqOWHbYG33e6cBCNE6CBeroVuXjf/caWdl0UboSpGftkBxY7v+yQXBTKeWjzCQDqI6F0o8D2jjRT39yQE3fMRHzYxz+fIW4jr4lo+eBIpNd7/AnGPZr6PvN11n7GOgr+Vyn36UTxfzcOHt2npQZf5BMYzD7s+RXBJJDI/us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b96cc0-9482-4ada-076b-08de28ac3691
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:15:25.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYNZNxKRhX+1WpDleMN0yWAtb/ubjQM184xFuO4HoST7p9s3f17fCPkJpmw+wexu39/ZLc2Qq7jWmyakVuGHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511210023
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA5OSBTYWx0ZWRfX0ISJ1Bhgp0yl
 TH/D3H98RqxNhyN2RWM/cVdOuGjRDpWUyvlnJ/+e81CFujPNzkf3I6S+4/zvKjdtseyS8T9h6d2
 /xtWde/5m+zPJYj0lSrGmQjiEAPX2cegke3ibpvzOwgMBTLRQtBabovuJ57bI7krUZogJUVwz2I
 n9Dn0AUwHig2QhVWJgieq3YaOVEmzdPZR5ihXcy8iKW/u9illSaAykb5xlxcg9eqZD67tABZ/7g
 WRbJmOzWOZWuCf6fKYAIAhvz2VLo5daTZTvURcpOBrVGX0oVHbDOJ8M+vIlBk1fRsqNAALxlPcb
 B0Zq9FsTqfLcZn9rWjYF3YYdsxzxmYUqiQbxgDwsvUGEgSccri7v8E+r17B1WiIbb5i+xShuFcp
 tBsV1zdTKWNW7L68X0FfaWDVWr7nTg==
X-Authority-Analysis: v=2.4 cv=Dckaa/tW c=1 sm=1 tr=0 ts=691fd952 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=hpEztpKkrw6mJ6YOb6gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zKvKrM_snSka8B4iuC8_-KadSE4Cmmkn
X-Proofpoint-ORIG-GUID: zKvKrM_snSka8B4iuC8_-KadSE4Cmmkn

On Tue, Oct 28, 2025 at 09:58:34PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The following diagram illustrates how to ensure the safety of the folio
> lruvec lock when LRU folios undergo reparenting.
> 
> In the folio_lruvec_lock(folio) function:
> ```
>     rcu_read_lock();
> retry:
>     lruvec = folio_lruvec(folio);
>     /* There is a possibility of folio reparenting at this point. */
>     spin_lock(&lruvec->lru_lock);
>     if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>         /*
>          * The wrong lruvec lock was acquired, and a retry is required.
>          * This is because the folio resides on the parent memcg lruvec
>          * list.
>          */
>         spin_unlock(&lruvec->lru_lock);
>         goto retry;
>     }
> 
>     /* Reaching here indicates that folio_memcg() is stable. */

Does that mean we call rcu_read_unlock() in lruvec_unlock() instead of
in folio_lruvec_lock() only to avoid false warnings inside the critical
section, and technically calling rcu_read_unlock() right after acquiring
the spinlock is fine?

-- 
Cheers,
Harry / Hyeonggon

> ```
> 
> In the memcg_reparent_objcgs(memcg) function:
> ```
>     spin_lock(&lruvec->lru_lock);
>     spin_lock(&lruvec_parent->lru_lock);
>     /* Transfer folios from the lruvec list to the parent's. */
>     spin_unlock(&lruvec_parent->lru_lock);
>     spin_unlock(&lruvec->lru_lock);
> ```
> 
> After acquiring the lruvec lock, it is necessary to verify whether
> the folio has been reparented. If reparenting has occurred, the new
> lruvec lock must be reacquired. During the LRU folio reparenting
> process, the lruvec lock will also be acquired (this will be
> implemented in a subsequent patch). Therefore, folio_memcg() remains
> unchanged while the lruvec lock is held.
> 
> Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
> after the lruvec lock is acquired, the lruvec_memcg_debug() check is
> redundant. Hence, it is removed.
> 
> This patch serves as a preparation for the reparenting of LRU folios.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

