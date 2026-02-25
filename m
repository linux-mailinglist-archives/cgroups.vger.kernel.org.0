Return-Path: <cgroups+bounces-14351-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JuJNgXMnmm0XQQAu9opvQ
	(envelope-from <cgroups+bounces-14351-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 11:16:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC4195A08
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 880D030046A4
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13193392834;
	Wed, 25 Feb 2026 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jPte+dRV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mqQ1iStj"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD061E376C
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014590; cv=fail; b=gr66ywbxT/suX1xMRPInHlFqFLmBWsMNnEJJk06VrUQ3QrDgH7baJhukhEdSgAAuqUsXMn94v1TX0Qyfpc+Y17L7hqQoPXCUH0KgV3kPwxrwoBJm3gCQiV7YaJ6nCjOS9LMecDbKEIRKIwCbWwhFfMV6/2WBLDzanzz4c1VKtDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014590; c=relaxed/simple;
	bh=o5mB6QkU76oCN5IPNdhiuUNGjfSR/HiBbRpSOikATxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s9hlNmI0B3hlRP4b/7MipFmPh6DTXQuyIz7ybDDPzuOjYtmDIpFokbClv5tZctDmxfgIh+THF8ikfBjjwr5k9FM06YAcBOegTV0LYt+LoQrbLrqZz4Oh8NQYeD8yoeD7w/wI8iA7hGNkmrcO+ZQOxFun7UliapT80Rgnvk8ryRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jPte+dRV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mqQ1iStj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PA3jbG3928862;
	Wed, 25 Feb 2026 10:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JE2ZrMmFImNpu1AUa2
	FsMgZ2da5rAmxz2FWbcVlH0jY=; b=jPte+dRVPEsaYvDe2YBWIrbLj8GQ5I7KjV
	rU6Kqz2YVKMjilPLNG+oNkGb73+JtBYu1aFSt0cKEu3xVgto6+njIDx6rNEiiONF
	uqAHogNxTfFTmXeDzgU8JNhrC1WfWzKfY86c3Y7tLkcHx6ivLY4leuLw4IQdV74T
	qrxJNWMPkcCnWEkhZuFZx7a8KQyeorZ4odfGY9APAAqk+nI3dLHSjt7lsoSuMGaY
	k9ZH6sv7uIEdBPZQ076PHOEo2UDygEm4kM4QnITpm4mQEUCAE9l/uvTdMdBoyYk6
	Pb+xQLB65PnouHAFgiMCX43QV2Up7DUnVdFJiFEuLp1sAbnIAfvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf58qdtf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 10:15:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P9BP3C038677;
	Wed, 25 Feb 2026 10:15:31 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35n5hax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 10:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVLZG6ytN0bTSjrVkLl+WbwSB/klgL5/VMSvH7V7x4KtiTv8eOHkO9k7wd4rc2MHxikoS8/tn2Y5lzbVfyFpNtsoIlOswDiYo6yWwFaFaYTxA7GBxNFdaKTwek3nUDBLvRhXK0sngws234ldxzNGQl4npnV1n6f0pJEWWQEZt+Smf8WLOLghs4Mc4u1mmr0taOKQRAsgOq+25KyQsO9ZeMgsMtqbSaMRTiZokqHdILYfI+4+QnqD4irnjtqHxgI6cmDqBGpHWEd4bl2rJj4fg6r3dOBx8v0ioLK6z7WsywzVB825RNArhULFQenANmU3jut3N7JPoPpysrKmgjyd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE2ZrMmFImNpu1AUa2FsMgZ2da5rAmxz2FWbcVlH0jY=;
 b=ycWmRqjx0zwBzC5ffgUJiUwSnHNI0w7XCPdWCItuoUMUQv2QRFKIbmRwRMRnk8CSSQ91c/ehkk7altKs5wp75fVo7qlPLtGF6M8HSUMGOmjO9Aw9i0C/fJMpuWb20HlJNQdcZI9vHnbqPP8CJtUpI7z/ikfWWEwX08ytDsZ5LjQn9y1pkWDRnlRlhL0fDfbKvRGvd4FuaNjneYuZjti8rW6XxWeOZ1pEBdQUzrIY8cqgi0/2Bg9lxOxR1WkOaueUFdV5+ir5rEFX5jtFrtK5VeXdKofzMtmG+k8O2VDiW7o7+IKcytXCHRICxQiSrzUC2WMkgVf/MnAkRkjYU6Dh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE2ZrMmFImNpu1AUa2FsMgZ2da5rAmxz2FWbcVlH0jY=;
 b=mqQ1iStjQUygN4FmRM0T9JHJsI6igWkwfbgEAL0DFBDxrTJ9Wl8a/qNiVYKC6WjYE8wueF3PlOuKvocMlzFbdLbj9pE31vCl9c6RQrjItM8U8DNmZu/HdbAjCXvwZcp+yKwPl9TD2kr6hMdP29dSjkr5N+Zq4YopY7gaAfaPlWA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:15:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:15:28 +0000
Date: Wed, 25 Feb 2026 19:15:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
Message-ID: <aZ7LtxAlPbSffF02@hyeyoo>
References: <20260223075809.19265-1-harry.yoo@oracle.com>
 <2d106583-4ec6-4da0-87ea-4ecad893b24f@linux.ibm.com>
 <aZ2Gwie5dpXotxWc@hyeyoo>
 <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
X-ClientProxiedBy: SE2P216CA0023.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: f00d9e33-6704-4e20-6f4f-08de7456cc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	aLqzfhdIzNsKJTpyjd40uXVGCTQHTikLZsA9Ik+3wGxxip4m39jhxDb++bZGsH2KJS17k2DswN72ve5x5+a7ZBs9vN0cAgi/gQynO9+a1tNM+neEKA5Wcx6SvHGVQNMVqP8WzJvajYqWHybmg1LMnfPqaOPxS4Nsi0kMIEcAMbXFcoxSXysJgZypdVnpNGuF4HcO3kWx2yS68IAp64oYkyLYOvwifxvTxdQncctszjiVAvaqwpIzEmGe3x9KH2y6DsEE4uBrWKFYdjFN+wq7YyuUkBvO+MYNcSc1cMd+sVyO9g8naTDbhSZPLamPgmIlw99WiO7cCwb/s1gQQru2WKpFxs5VcNmxVyexCoIbDvcU2YgrZb1Jf7kh9g8hDaji4zqOgVa7wPxqcvycENt3y2j974/B77Ko6ZkPPQwFVoDnsrRsvxh4h2Fu3Q95msqgtQdhVTNI+Fi2pKiqU/zrkmWIw1e19U+tEXqeEcKnnU8QgjzufAyJZGLx9i6WZoVymn9/H9q+/vaSFSxPHyp+/1BOnfUBdKmEoxsnj1KMpXeX7YwZGGTJgS1sRvB4YdzI1yjq/J92vf6PIhtbuOb7lQoksXPyhY3RTNZuRcvPAImohob07yxdd0SkZTsyv9Yg4Wie82RhpzOOxuRTtv9X52h2zVvkVQBonDcKj8aoMjjAivFA6YKIbooYaK5twq8EMJp56ZJM96Bn7EVhkj4sPA0K7OYaJswqhTA0jd0eABM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vWoqKSrNqWycaDBBq4xWaTVFkQkUwKJLQiRrnwt/wY9dGTuHvTmQtXfQQG8?=
 =?us-ascii?Q?TLNxfI9v7mQh2xDHqnZUcJsrwzSKzQhnX9kIwLIoqczpRsDiHzo8HuJY4P4E?=
 =?us-ascii?Q?3FyPFlbMTTjBXVMWFum4xjT58310tZpSR7+MXFWUJFayeicZWPIr0Qcdl+D9?=
 =?us-ascii?Q?xpgIkQtN+gyBLpZaot9jSxgSYIdzSrCDyQWu3RMtDyVO6wYAAoQIPiJ5LJXp?=
 =?us-ascii?Q?48etJOLajLnt9/6zaf8T/X1p4mZ5rf2PlXctEofNt1XAAExdJj98P7fLGVQV?=
 =?us-ascii?Q?PPv3cPmFv0GopCaIj157IYiUFN6F1Vl+1O2BbJafqcjmnfcbVh++Htf1j0Oo?=
 =?us-ascii?Q?xEJ0ebCS2tYJtFnupl1eIYYMPu6KZd0SkqWZ7hDIIC0qhnF4e0Y65Lpummid?=
 =?us-ascii?Q?tNOR8GvcVKGHSAZBHnaRWaWdRa3QxOJGq5gOCPNPMluaj1DKmYqnO2GbyMu0?=
 =?us-ascii?Q?z4BcKDLB+lPnJViKR1hVZ0EeTiwWUAnPB4OzpbNbl4tzmBfhH8yIrDO64X0E?=
 =?us-ascii?Q?mZCZTwtsJL/jMe20emF3RQNUJMuYflrVtGYArodvT9UIk32S3CepMJUO6zdH?=
 =?us-ascii?Q?EvJf1wXIrJIn9ASpqja62wiicZVxqFKB9415SXCrft2k/rduMJdKzP59oh9R?=
 =?us-ascii?Q?yzG3dloqwlSGONn7hOJgoRimlCxvJgWv3srldXOQ1e4xr+FJV6Ex4vc4eDS3?=
 =?us-ascii?Q?NRadUUsv6bK/Llvl7czCeJWJSGSqoMxv/mKly+z4wEZj+g5IxNfderfm2eNX?=
 =?us-ascii?Q?aJAmZUeG34L0vwkIrp4Mp3N+Jw8EVARj81HMCmN0u521th5rQCArk5skDn75?=
 =?us-ascii?Q?PwrK4eLRcyAQPE4AfUUmgcPI57iZSn1pEs7ueIJ/bnu3jbB4/Wnl9hgV5Qxq?=
 =?us-ascii?Q?q/tDpNfT4GCZsliddxZx6THUoWVmFmjeOHgu65G43liXuC2jkPBdXVmmIv5Y?=
 =?us-ascii?Q?Rq4HQ7qWbmtYieC4GQPFNfqHiposZ9wEPq9ABFw45iQGcvOy++g0MpotWliH?=
 =?us-ascii?Q?i5ZAV+YlRY1aMbNDiima7TA5+R77szkBkhz/4GOzHoFN9yio7ovTmYCXtRGT?=
 =?us-ascii?Q?oFE/+M1FudoRMGmheDvwMrIbf2U9JsrI17k3zuZ6ZViA/9V79KitsDtowCyc?=
 =?us-ascii?Q?z7JtPa7NEZPG3pof7rPteqQLPhX2AO088uOsQLZ+B2bGBAJeVMo1HKLS25X3?=
 =?us-ascii?Q?+7KlW2ztC+ubfqaya7xGXLB3r8r4tiIZEUgj1MKLy1O4hlB6qi8VBOy2p/xU?=
 =?us-ascii?Q?fEyluhHMZ89ul3lgXbKznkKgMxFEdcQ4eopkmLaJVvvjqm5I1zphrUsyiufv?=
 =?us-ascii?Q?oYEiaGjfmsoW/g5BISeLx7S7Gx5iFGPD4V2LJAENZh5knrjQzdY+kOQkoaOA?=
 =?us-ascii?Q?wYJRNi5x9QtJnbhCGNR5xzwfFooo7VZq+qNk5bgps2GmKFPYUMRi40jVVJ3v?=
 =?us-ascii?Q?Lcw0kU/cSWgwVR7l2h25BngcrzqrmXz2daQfWjFGxYXwLM8zliJDxISuZH0s?=
 =?us-ascii?Q?vPZRbBHn4+DhoSZga2Kys/r5GbJufYiqYjM7JUE+oEPSwkqaEN5TEP7CZmnB?=
 =?us-ascii?Q?fBwzVI5ZobhjfeNq8T9ctWVPg+p9buCD3humZwYxEZA4ZTxYxK5C5jqBSj5q?=
 =?us-ascii?Q?9L/PgQg3ztB21R0gl9aRg+eR+vJyU/oDZ/HD5u747OtdcEWNpNE9VOPTcvy5?=
 =?us-ascii?Q?SI8spFFWEQBb5XU2G7+nF9XHkYdkrC930VtsokNuNmt3KVE/YbdP7tikwxd/?=
 =?us-ascii?Q?XDZb+lO65w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	inWBp5gk54pwBePWypPITZIej6FAloAtzeiat9XP3LJ8YfkJOaB4vXtsHLdCN/8gbwY5gOqAxwPF/RQSY3tzL0DOMNgZxtQ0Ek8v8yf8EPwKuK9GNUBvP8R0xa2eNo4PlvA5m6TdjoCfGsUjeNtDM64BuwTFM5brAhg0G+RGCFUB5Ka2G9Ya7PfTrRhX2ng/Sm+RvE8/Ol7fwpaew5Ioz+IXy54CLPiL0Xb2yCdFFMVNIIIrlEf4ReSSRwBtmWeCw+HrGK8MtiaD5tA3Fui6FhbDtApGNFIbOciTnaGtWMyPWV0i0c/Nj0JT9iAq9Hm4EOeqHOnWjM+dsP9ufLTZkaIMqBSIeddsMi0EAM1I0KcinsldicGePNKnTIxbkqFY8T0H5pE/mDfoNQN/G1lHBv6DPcA/yrf6JJP/uQGlDLv3GxQEKy/rTuGOiPKYByt8QeDLjOBdnoJxRFsoZEaE7fWik//4KC8rD1vRo5tv9U9pE9tys+jHeolw3ZQMIErBWIIoscsNoEBNmhxoAHH2oIeU4E7pLMLjfpeBoAcqX4KdRutbFjK4fPlham6rpZ1oOR6t1g6I1lJV9UT6jQyAN6LknlVhvLZRb/mPpjYmpDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d9e33-6704-4e20-6f4f-08de7456cc8d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:15:28.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVcWwYPqOFWXx8V61SuusSopAGbl5lgABKBK7N/Y/STIxkM1KuD3te5TTKJXqyWwPVr+hqcQut0u6XmTLhtqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwMCBTYWx0ZWRfX6z4FVa4VxmJx
 mf/lsA+++ItvroBo4uMsvzu+AJXwDAHLe77UXnOQnLt4XYL4NxOXxieaoU8ty8rxe9/MYJNqvnj
 FFptJaxQfB8X4VfaUMXMGfFQKu95DLaAfq/G+hb2XgzAxVA5jJOmDcSNQEqyM2Q4pyFmFCepJYO
 qeB9B1IZhkUAMGGIc9MTdyVpTyk8cyznjWNG5uY5iG8VEHBB1ZQ++cm2rQi/EXMaS8pbNgeh9G2
 BQYgJNuxL5kEJs4r2MNE4+jq/zW81lh+4aXhhtAEPa/DjCtKbUEoX3jA3dOVIBwrn9ky5v5eIAH
 Y32Dw/kgn6ZRpJxDMHz/tfFD8y8ME/fCQIaNMtPmNwqJ9DFqFFGUFaR3VVPCnrFmzBIVEwEcqQT
 skoVcqahDNiD32PzdBmxLvNs0Uc3fwwMy5+Z9h9r9GAAbHtUpKwilJPQ9B1mamKwVLMZ6YqTn08
 Ak2urj5ZkWMEAj7ZELI0NN4jzOftD6tuTSl1Y/Kg=
X-Authority-Analysis: v=2.4 cv=XNc9iAhE c=1 sm=1 tr=0 ts=699ecbc4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=wNQek9p9X8fHaaAc_nAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: Nnw3X8xHz4ICKnfgTFJIWqFFXZ9NrH05
X-Proofpoint-GUID: Nnw3X8xHz4ICKnfgTFJIWqFFXZ9NrH05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14351-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 19EC4195A08
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 02:44:24PM +0530, Venkat Rao Bagalkote wrote:
> > > Thanks for the patch. I did ran the complete test suite, and unfortunately
> > > issue is reproducing.
>
> > Oops, thanks for confirming that it's still reproduced!
> > That's really helpful.
> > 
> > Perhaps I should start considering cases where it's not a memory
> > ordering issue, but let's check one more thing before moving on.
> > could you please test if it still reproduces with the following patch?
> > 
> > If it's still reproducible, it should not be due to the memory ordering
> > issue between obj_exts and stride.
> > 
> > ---8<---
> > From: Harry Yoo <harry.yoo@oracle.com>
> > Date: Mon, 23 Feb 2026 16:58:09 +0900
> > Subject: mm/slab: enforce slab->stride -> slab->obj_exts ordering
> > 
> > I tried to avoid unnecessary memory barriers for efficiency,
> > but the original bug is still reproducible.
> > 
> > Probably I missed a case where an object is allocated on a CPU
> > and then freed on a different CPU without involving spinlock.
> > 
> > I'm not sure if I did not cover edge cases or if it's caused by
> > something other than memory ordering issue.
> > 
> > Anyway, let's find out by introducing heavy memory barriers!
> > 
> > Always ensure that updates to stride is visible before obj_exts.
> > 
> > ---

[...]

> With this patch, issue is not reproduced. So looks good.

Thanks a lot, Venkat! That's really helpful.

I think that's enough signal to assume that memory ordering is playing
a role here, unless it happens to be masking another issue.
Even so, it's important to enforce the ordering anyway.

But having smp_load_acquire() on every alloc/free fastpath doesn't
sound great to me. Let me think a bit about it and come up with
a reasonable solution (this time, hopefully no hole in the ordering).

Since it's a bug I'm working on it with high priority.

Again, thanks a lot for testing!

-- 
Cheers,
Harry / Hyeonggon

