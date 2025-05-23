Return-Path: <cgroups+bounces-8321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2BAC19AB
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D0D3B5FD9
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E642DCBF1;
	Fri, 23 May 2025 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndOe3MpL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHL0fxwL"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F12DCBE0;
	Fri, 23 May 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963553; cv=fail; b=QBr1zlzCQLv+Su0kL5rfwKv3FvN759VPDnJUkKO+GKWgpeXVo6JciJEz4bqaU9RvqrkiFH6E41PTF/JTYhwhYnSikXyAlKdyiMM7BLcDZ5yN6dv3eB2W9jeP1So8miQKHNa8npUPubRPx9ODzryUp5TmudzbdCWydxlfOY/nmOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963553; c=relaxed/simple;
	bh=2wg8jGqeQGCd2DchFDOtH0xwR09A9PkMiTNdzUOf2Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9j64AUrFor3Q7lLZZOG6Gl+G5QDlu3ZCyGtAekSyACcBy5kgfrlsHcvdXCr+q9E2thL+caByfEiAt5SU7qVguwFFG+oKVj4wMQIfsLSSs3F5PyKlwTCZvGkIlTF0pxY4OQA0iyO2Ah3yx14BeY1J+cHsiZdSNoEbGLKjTCUjic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndOe3MpL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHL0fxwL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1I7AE012878;
	Fri, 23 May 2025 01:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TA7qa2fDTU5Xjgmh4b
	50FcUiQKn8FJGMVsGnd3gz4rI=; b=ndOe3MpL5Npzh5NJs3FBtCzP7z/MRhHWmQ
	P7fHK+i5dc6fzKXkqZAD8ekq2rGhdlWkcg/regFhrz1fsyU8nwzqicIVUBV4tGYp
	eird/tE74lwNApvhI3s+I5m3TE5W3gIAF4xAiZGn55iBoxxpzmb3ffDgxwFs25EU
	a+FFsF8epKfuZCKxhpVdpJoQjm6sqhvrJezIUoqtV1r3FaMBuU74Z8OA+4a/jXOb
	0DrzZFCBgcMPOgACpHLwVPl4hJAvxGuoUzUW2zdckHMTYWi/oehS2UXrrKq+5niI
	/K9v8w4tiDsVXe4A/9vg7LhS2FTXHvV5DX/hAbO4kVhBwPdmkpbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tf12r0fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 01:24:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54N0WRVO020354;
	Fri, 23 May 2025 01:24:41 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwevv9p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 01:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJX4O4igqUF6tbCByi1+tvxRplUzU9TFrJf7ov3wXabejbYngsXIVdigNWR+lNwcuct+2HTdcI3WWe9LStc9GiskTtzxxEq8HDsO8KJyVG0FlkQvKOJeyII63W8bXXwRhC9R6lxBVH1JSIhDJ76AQ2Stg7bL2F50VSs/9sHICqcrrNiD1Eqg8+xVK6vSIVSN0SforwR7j4EmXJgDnnQj0BsGFSlAp3osc2AIQAw17AhH9t3RZgbahVcntXxYxFjBs7tNccluPAS4psSLlQCGMtuLKbkK75Yz5+iX7NxZJNGwF3ZYv8nokQ7miwghPG++uVwdKONuStvsJDtFtRuJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA7qa2fDTU5Xjgmh4b50FcUiQKn8FJGMVsGnd3gz4rI=;
 b=hEOW2lib6A5SWnGPfAznjiJbh8eCHV68lWW0d5KIYAZGUoRy6jEAIe0Q5dMxG8DA4cnhH53z5qtCCMXqpbDWtAmsmjlgPMvlUBMIjIw59dDrMxNCRYf/ocfXUaZZpqx09HeQjwA6/jpSveJi+qssY0zd9Mdoth5BovlEA171kF+aXW4E9/3wFROb7Uz3utrRRccivJkX5+4aC7cUK4pyf/NaEwHii4QCNtrEdfXRGUWT5C5/G3FL4WanpMCsQcBhbIQlOWd0TGtT1A/CV4pW4DTaBOVUmfuqJHEJTkmKz5449En3QIU5LhdJaKbwE30OLMjT4hZebzaMcNPbIWvGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA7qa2fDTU5Xjgmh4b50FcUiQKn8FJGMVsGnd3gz4rI=;
 b=nHL0fxwLfGpjLX4s4ZUkgoQiqicpeYHGP5jcGO1KDvZ5l8BMK+0O6mZSOdwg87QZaEM1Fh9Bo6ZOg2UkHeZkkrIBX9H2d/e8EykRI2xM8ZHJ6DuhOFDRAIgHSjpPt70cKaC9RZIPmUxq6jfpnjy9/53WS8tU+VOPXat2Wh35h0o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 01:24:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 01:24:38 +0000
Date: Fri, 23 May 2025 10:24:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH RFC 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <aC_OT5IQVYk2wFU_@harry>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-28-songmuchun@bytedance.com>
 <aCxnFg0VSpd7g_Ju@hyeyoo>
 <3782D28E-B0F0-4CC7-98A6-27E443A92730@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3782D28E-B0F0-4CC7-98A6-27E443A92730@linux.dev>
X-ClientProxiedBy: SEWP216CA0115.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d05de54-8ae1-4570-fe37-08dd999895eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxgOivXZh/TmgGIqx/8LT9oAtW5DBcMEmF/A/6wnVdVL7BRT1zrnDHryhowq?=
 =?us-ascii?Q?s6iMIgWPuSMbBXcViF8PHaLrYL01gN+EgsErPHsg9lXPVWYyRF3yZ9cJ6lSn?=
 =?us-ascii?Q?nrFAic4+5zPJV46AgJh5HkHkSf9yoRssO/WZfrEUk1DW8GDTxo2pyGxldqki?=
 =?us-ascii?Q?AP+kCYWv2qVJDRngpbRKCiXAe2AfXIQCb0hLaJuiYvHtRtGDt50N/tQOgzHa?=
 =?us-ascii?Q?O8uiYcUvZJ7vs5I1Qi59mYSIIetwNShZF1w2SxW7wKsq5JX2ZxHpPK3jYU6r?=
 =?us-ascii?Q?iX6qeBAfGSa1ivD4I6D4AkjcVS3ZaXjL55vgDDfHbRI0dDKgDo8Dsx7ElIAe?=
 =?us-ascii?Q?CM54hBADhUwX4/hk7gmf/eEm+sc9h+hn2KGbNlGs8FsCmfyDG1ZmmGbHfrp0?=
 =?us-ascii?Q?QqQ+GdhMKOpeU0U9TGN3akY57uryG1BEZv7JmJe5+CVZpisJQNoTAn8OzjRz?=
 =?us-ascii?Q?b1niOw84gsX9U3xxF2mhIEhmxMXXYYIH4NHEtX3JX9biVECcxEVcpGwhpx7+?=
 =?us-ascii?Q?yT28OB1/bzSMkco5TmRIU5gLpdFEZF7RUgi+10o2NE1DgfGVowHBr1SdVLxQ?=
 =?us-ascii?Q?qEqcJtt5/QXQdrDf8yzsAdWtSQSrn8tjnYZ09vUY1/QfCJni5yYt9Y2jTBin?=
 =?us-ascii?Q?QoMHuJ21Cv34Uqjd3sx8WGTUEx8bRBOhx0gwDOY45kJqQF3A6/Weo8y9CdFS?=
 =?us-ascii?Q?ag8cUJvUVPUsES21ohPiPIGyiNFQcqiKeG+1xhkOCW35UExHdYNtILf7L2f9?=
 =?us-ascii?Q?SSK0iAkjYt7uDbuwLZ7xS7eSg+j/1l/WRG9ji/+9SEiKNcwS5bNTtiqZGJ+F?=
 =?us-ascii?Q?p6oQYdlL/IgcNvxTUs5QqsZ0+TdRgQP8cgl3TqVee/BLITNJM2SN/MRxm5Rr?=
 =?us-ascii?Q?Vd3q81bTgJ8AkWJsaFecP/Gt3HKgnuAu3yHoCLbZyf5U0B3Vt1Co1/nkzfLA?=
 =?us-ascii?Q?eMzQzcX/IPLiojiymjkexS8PDr0AaRQ/LgVm++ldpI1FqNUrQue4m/jjpGBM?=
 =?us-ascii?Q?vQ65oSN8Y4kvd9AbtyOQaRG2y5SQNurMmx1KpB9mMkK1rwEypJMye/eJ34AX?=
 =?us-ascii?Q?tFjcfrPNxRqrPeLy+fxYtEcPq8p96sBEsyTzbCNW6yTI87duESrvzOCy23j0?=
 =?us-ascii?Q?pDGXFZksRQVPdT1kP4yZ3A8HHZ2C2yUoaafyv63WY5GsGK+Y87D5j+AStlBn?=
 =?us-ascii?Q?RPD1+PyFfO0/vNr4bqzTUt1XFO3d9ek13YT9LunAycskTNo+LlvToEGav4+o?=
 =?us-ascii?Q?/tP4uNMe0hmKGieDE0kLsXyD06sBJQrvzxJAI0nqKtcS0JY+vVMXGozk2nz7?=
 =?us-ascii?Q?iA3fQIbSk+oXrZsCCkGk9ceKzTWd+4Syt6BC0kDYqcOKZRoc3nxpMyJv/rCb?=
 =?us-ascii?Q?NWkvAPIN9uwBnU+xq20R2H5nsuzl7xhYtMWCYrlgwwOxVdDQorGtAUmMdfNJ?=
 =?us-ascii?Q?8Nh34clH0Xg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D43eEHzbw+97KIpGuX46VEkvuhtLIebEDviTbEVPPhZbkbygUyOBbH4MfWri?=
 =?us-ascii?Q?n/2+jRqJc5T83vGJI2me6XrbM8NtMxcrc+eI6TTLE1oovOeaZ/SAle+neRRE?=
 =?us-ascii?Q?DhLFpHKKXZZeHQLI/+2BLHCM1Xsv18DZ5s68O9nAMLJpskCjx9mNXBaDrRqQ?=
 =?us-ascii?Q?Rcj7NniuiRR0miaBpDpymBcix+Raf0B5We8NBi0+OZm09PK8oDNCDlQGP/k2?=
 =?us-ascii?Q?UOpgpXms6py3S2thUyU2h3Upsdv2UdPFJEESFZ2845vjIdsNFo7ezTs59G3Y?=
 =?us-ascii?Q?J2v1i4RMT5FJwVAuY2puwebBzkSZgMTwxnmnzgqxU/XYym0cXGpg+dELsUZB?=
 =?us-ascii?Q?++cP2Oo1M2Bv+Y40J5ZYX4HDp2YMkf5LFnpUTiZA1eo8W3UY6IiNlGw2edZw?=
 =?us-ascii?Q?48HRqyOAK5aBbdlia3STwFh9q6cicKjRIP1+ZhKoSKgbnVPJBLrqY7ORu6sF?=
 =?us-ascii?Q?n1PykMddFkcrcrh5BmFztvjxzrMMmhSgSIz0Iw7e52SftyEieZ+ZR1lOoqn9?=
 =?us-ascii?Q?YpCJHe6t9FFUiG/Fb2/nfh2I1uCFxmFiF8RXcjMFhMELBXx+5jStnWh0kEp7?=
 =?us-ascii?Q?RFeRHSLTZ/l+b5XdLKnB8PF0Hcs/xXDJ0n5gS3s9V+iu+dsixmjp5fsxrvGQ?=
 =?us-ascii?Q?B44VOeU71Z0P00V4Y+wNhekuDTbiuVF/IFQ5wGn4on6kFc1ZutEbCsD5VDKa?=
 =?us-ascii?Q?x+jCDob5q6EfxKcyjgww0xYryaymMlpdAfu0t3vEG3ta9jBghKfsKKc0gGVD?=
 =?us-ascii?Q?CfoGmbn1jpm46zFh74NlaZ+rplUL0Ax0EclZlPHJGGiQx/3exwQyGqfJbWCC?=
 =?us-ascii?Q?NW+N+i7Q0vMh4R9AGw+un3nQ3rREpmLDxnX/8N3vWOP4Pz5CbRfwDTCqcoKd?=
 =?us-ascii?Q?6EGnrwpixIk0wHQ5Yw3ZUArSx3rKV6t/W8vNWLitFSUrPlpj9zMyLc7IUBhX?=
 =?us-ascii?Q?dt0Gkzo0ImAeFaOl3DiERGWM0T1GURPWjfEP9TBpvHFgpas8hUxD3+nvOo/N?=
 =?us-ascii?Q?GY9ZrsjnEZxfehUF7kATo25oB862NgUJLtjW+95O6COY6TfK4ajv0eCJwnQI?=
 =?us-ascii?Q?ZGdPthuXlNTceqht6/GBK4rc/BmhotnqpJPLm6ElosuN6AjR/lS1uBouO+6H?=
 =?us-ascii?Q?y+8AjWU0isAgqV4LfB7fVoIS2gey2s5zJebp2EtcfeJ7aJsSPfgrd+5MfRFN?=
 =?us-ascii?Q?UPJ3Gnky1RyDATeplIWkaWesBj0UaVELzXkSBhadNDbsQVeZcACxdS77D4SE?=
 =?us-ascii?Q?79xb1qYX8S1W+Hrv2RuPjPGhhgjfMHwlHADV4dGF75QPzfZ+bFQqgQpGoFwm?=
 =?us-ascii?Q?WrO5tJIDc/5bQlRHtx7Kzyu6tr4iJggXHveYvbUFluhjZFpP8xtjlXy0cg2P?=
 =?us-ascii?Q?E8STGEee/JZ9LSjNiPn2tEK3EKvuX4YaZ1qy1a3uNPDlSGvSh5YTLzMeUKZc?=
 =?us-ascii?Q?+YfU/YiPcxt+JYpN+PFsl77B2mJNknpCHd56kjnT55wHerKTF/E1k+QPIgjM?=
 =?us-ascii?Q?xTTCauLsnVNG36QE2yWSXHNaBO2yrcGPIEsbop/MzVZWodXOfLAgkoTYq9CE?=
 =?us-ascii?Q?Ak8Cfwfsni7S8ywvaIQAeLdBZsbVPLi5MK9541Jl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IIvnj8q6ZN5yaNXr8MWRLWjYYGmJ2SAroeTVxUlUAUtKxCU0Tu4SV76z3rz4V5NLGNOyqCvceaLzymHEgrgLKE/hzQFT/cEIZKK2vy3qD0vTlnCJd7fhYLX5h2hBRrFg8i7qfkArinNqoiOFMT/hdzgBSnwjMFm1bw5JRvRmXTDP54SAYDWTv8qI/PYfKFJ8K46SkpPGE96N1FQOpqGQxf3yUB1Q7I3DHSNb1APY/qIWluvv8Hp6aFp4PQrerlCvYNc/GS78IZ2NzDRACC3CEBSWdkWkI9D0RG/I+omBJROnps3eNPBG8Pwzz4lTkcc7gJ7XReWG6HCB0lt0RvQLSviPDhKwVVg5ZS/RMYj9y5nScIEoEAV7fvDNXzgAgW4nv2hDnD4cbifm7gQXlFt8xU5QvZYi2dbb7TyCC4jB6pEnkiWFXDwP4xPlNEVP8bJKuq2AYHmRhnuDa/p7LB/gmXxAG50t+/CbmqLGEn50ii1mrnPjqkyExNDlZZce+qozitZfS+huv2GlAKq5ZNShI2PJdXFW3gnLGfYrnvWoxv4hhLSfcf0nkq8W8aHxQmljsLCg7ROmXR9LP4flw+GC3GcQlDnXbEMQ4Tkyb+zUqHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d05de54-8ae1-4570-fe37-08dd999895eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 01:24:38.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAcSbMAUf5wZrlpwsMPBBUiVnwv7M2wgeMkdf7av26qXI1EmhSbJoSWY/+6EbYsHOYzb5YQ62aH4x75JvVS7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_01,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230011
X-Proofpoint-ORIG-GUID: 5B1Ef9Q7Z7WOPebEi62noKrXouYUWOh-
X-Authority-Analysis: v=2.4 cv=YNSfyQGx c=1 sm=1 tr=0 ts=682fce59 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=968KyxNXAAAA:8 a=uh4EI9yH-4UxwpeFpYMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: 5B1Ef9Q7Z7WOPebEi62noKrXouYUWOh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAxMSBTYWx0ZWRfX4OtIa2Nil6cj X/gnjHRWAMz6i7S3CdPy86OXNg3yY2zeZc0djXeGRCjL/t2xJIvO5lqcZ/RHHC1pSu1Min8nqq9 QS5OwakwNZWbdz8MPT1tO4xyUsNBtRqVqKzb1rDai/73ahJ20oU7eUtv6+6+49QcD6GAKXGXCa4
 +FLRRHrRP1QFsvB4BQ11N0JyEiIVeDdJdWgYU5LlY7jZwz3nkTlAcUnddmsSdtWJPppWJ6MBhOd Q1gGNtolFxfIksEMhGswemsQQWldZZ7PPSLj/Ts/r41H1SYlR1vlbWCmkOVSuMzKIEq+zfRRSIj UI6GXu3MhPtEkP8QDMSF7+XiRufcIPgAmx4YBHL1SSp8jxhC+lMxVBuJqWzavbLUr/uQDWlxyoN
 JnmSEbxYN1aqn7Slr8RMzrZdXyhkCTyxvnnF8lXAhN2uor75JtXKoitiSjYBTQe8GVAMjQuW

On Thu, May 22, 2025 at 10:31:20AM +0800, Muchun Song wrote:
> 
> 
> > On May 20, 2025, at 19:27, Harry Yoo <harry.yoo@oracle.com> wrote:
> > 
> > On Tue, Apr 15, 2025 at 10:45:31AM +0800, Muchun Song wrote:
> >> Pagecache pages are charged at allocation time and hold a reference
> >> to the original memory cgroup until reclaimed. Depending on memory
> >> pressure, page sharing patterns between different cgroups and cgroup
> >> creation/destruction rates, many dying memory cgroups can be pinned
> >> by pagecache pages, reducing page reclaim efficiency and wasting
> >> memory. Converting LRU folios and most other raw memory cgroup pins
> >> to the object cgroup direction can fix this long-living problem.
> >> 
> >> Finally, folio->memcg_data of LRU folios and kmem folios will always
> >> point to an object cgroup pointer. The folio->memcg_data of slab
> >> folios will point to an vector of object cgroups.
> >> 
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> include/linux/memcontrol.h |  78 +++++--------
> >> mm/huge_memory.c           |  33 ++++++
> >> mm/memcontrol-v1.c         |  15 ++-
> >> mm/memcontrol.c            | 228 +++++++++++++++++++++++++------------
> >> 4 files changed, 222 insertions(+), 132 deletions(-)
> > 
> > [...]
> > 
> >> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
> >> + 				enum lru_list lru)
> >> +{
> >> + 	int zid;
> >> + 	struct mem_cgroup_per_node *mz_src, *mz_dst;
> >> +
> >> + 	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
> >> + 	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
> >> +	
> >> + 	if (lru != LRU_UNEVICTABLE)
> >> + 	list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
> >> +
> >> + 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> >> + 		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
> >> + 		mz_src->lru_zone_size[zid][lru] = 0;
> >> + 	}
> >> +}
> > 
> > I think this function should also update memcg and lruvec stats of
> > parent memcg? Or is it intentional?
> 
> Hi Harry,
> 
> No. Do not need. Because the statistics are accounted hierarchically.
> 
> Thanks.

Oh, you are absolutely right. I was missing that.
Thanks!

-- 
Cheers,
Harry / Hyeonggon

