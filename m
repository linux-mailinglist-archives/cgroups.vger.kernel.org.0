Return-Path: <cgroups+bounces-11654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101EC3E266
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A253AE2E1
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF452F692C;
	Fri,  7 Nov 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDAjrOl6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MJ+zDAOG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2482E5405;
	Fri,  7 Nov 2025 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479672; cv=fail; b=VRcHrZ2aG/kJEXjXDBBAzP5Koe98UwlpjCIgptqdUx20SnBXS99ulCl+7qI8OPH3yjrqkmj3m4FMNuWBq3RHHjBhkipEfcKNhkccMO8u4KqHXWE9ksNLr1LbhfcXO8m/JanMRELoJXFlRMwAGHx+0kcpNYnY10pAchbecg+G5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479672; c=relaxed/simple;
	bh=0aF+KIn7mATGO3H3bR21kVJ1bN0oQB0eEgJ8jG6v0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVXvhkGU4uPFn3bI0+/s1V5tVE+JL0tP8wPwJcy31VEvKvbYSSC1SgvZ8QoM0OFsHcpb1rHIzMFzfMxZANv+AHWxWAuXd6cqoX4gzOBarSTtI7DiB12NAxgUAOJHJqLUeAAQbeo8kFor7GyIjSXt0pwX8JGzxopuZz2BuPWO3T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TDAjrOl6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MJ+zDAOG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6LNmb6017701;
	Fri, 7 Nov 2025 01:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=osilLwMfWEe+NPmWlb
	RWIfI+fgZacPlpdNlNTD0RSkA=; b=TDAjrOl6ktl0Dz87EtVjvxtOJISRbp4ZiH
	ZZWJ9ZU8DZ2yutzc+Rmg0b8m4NYnKVlqlPUg2WWsAO8XzyWf/5WwfIixgf3WRMkb
	KZ7AvUrAN3QIL6mMtPOUPgYgF6M28CgMX8DyPXhaNuxcg6uwz/v5p+zeGIWN0YGw
	CGBFqz8VfOWKwD3k6y8EYp1YRHI/w29IGO6egZmBZzjkKUjXwLFPvTsttUz1KFuw
	+5NLCjodzzPj0NpiWHYSZ5Ent9rCJkihEtdVje/sakWJKQzbkFgN+Fw5/bXjGbKN
	0l5hPCa5bls/lg8gdmlgMFUxxoaYK3OYNmqmNq1/RSvzlMq9jq3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8ytw8usg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 01:40:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Nh9JZ002730;
	Fri, 7 Nov 2025 01:40:44 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngrvm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 01:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt1MFV/tlRlPyttJOrBCak8bPnfKHnbtsBsOH2Gx7a6rP+D5W2KqjciBLuam7XokGSf+LFnXVOd7yRkrBY/BPQ0/4AyBb6FlcVlStaYWsNAgysamCAtvzsYv9ukh5RT1aLHjCKX6ZlTEiU6+icwyEqO3bEwxkHrDtKUDFrrGf35Hpb15u0gb9FxijsM9fITWwUJi0+Gn3fOlBcwg9J2W3SHoGG1WOa5D3G22YMm27Jjza4wygSBiWEwoojpg93aKzxKY9VuZI2ux51XCo/elWxsh5HClxJVxX7v5YKvYt9DGuIez8nyxeYDWYtqMN5zabRbQcS0EWlVt8p8lAKjpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osilLwMfWEe+NPmWlbRWIfI+fgZacPlpdNlNTD0RSkA=;
 b=uUyZypZRqagl3aB6O9S0tvbuEePNXjQ91RsR9a8I/VfAgi+QtF8TWAZ1A4dlJuomOxIlTYV4g1Z5K2Im7mPUlJTRBAM9pT7F750m3u7kkl0qJJ3IXtAo13onE2np/nGZH7hevMWUg8eC6D0M+iEvtg6qFv7ZbcO7/3kCOi0+DZ54JFatx/gjxp5bbzYZZgvKKOpY0bYJsjFhruOLvvfKohBAQpznfodCM4G90n643ADgEx7frhf8ULCUgxjXb1j9sMYZEOp7Lp9p2BJVYitmsCFOtqEU5dSP4262C5ipe0NI6Jl1ZP/dat3bkz67ujv+rznT9L6jeblU8r+UTklZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osilLwMfWEe+NPmWlbRWIfI+fgZacPlpdNlNTD0RSkA=;
 b=MJ+zDAOGdu8NuusF04g+9ruGka7yGbZ+ZPpLHEGbpVuj71WKWnMD4JD8z/7v3oKZAzgsfvMAEsZDvuVOcHxa5M3eLVL1Qtx4EJKpnimdANo5cnM4jWJ1St16e9MQNGMkaWbRZ+6+NJ+hfnUV6AXg0/Mczn060eY2MzGYgiARCEs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFF0D9ABED1.namprd10.prod.outlook.com (2603:10b6:518:1::7d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:40:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 01:40:41 +0000
Date: Fri, 7 Nov 2025 10:40:24 +0900
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
Subject: Re: [PATCH v1 01/26] mm: memcontrol: remove dead code of checking
 parent memory cgroup
Message-ID: <aQ1OCBo87ZkIJng9@harry>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <b13ff669bc3f52922e97fa0cc99e54df05585810.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13ff669bc3f52922e97fa0cc99e54df05585810.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0192.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFF0D9ABED1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1992f681-7114-49fa-5254-08de1d9ea8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GuZ6ax0A+h5E58byXHSNEW3vudjF+UAgErk9Or7cDfcebc7OYqG9GaADUH3P?=
 =?us-ascii?Q?Ydiau4Ju7lei77tP0UjjI2PGHPicqEIR9Tsk4sOaXgAlQksRSNsz9PgIQKEJ?=
 =?us-ascii?Q?dJFDErjfsmdXgXfmft24A1ZTZCHG7IJ7wxC0ruVZdaev4HfGne9P2DbpdM+a?=
 =?us-ascii?Q?6FaGHe6bq7EUlI52WogxBScvuPBcoipWrdUrkw4EBBCrmCSXCConPcLcxrUZ?=
 =?us-ascii?Q?veoDE+LO6mF+wuxWCs+2EmTd3PDD8IE+ODxVppQW4MJySADkqmQOw3r0UjCG?=
 =?us-ascii?Q?QwpQN8N/aGIGhIqMlpFU83LrPxwrYf4T2GWa7oZ0/Bzh+8Yehvl3pvGWOBrq?=
 =?us-ascii?Q?Ox0QsEfPfX8PAYa8hDc54V59C9xUUuYejBvqjlZZll3ezc9nU+WrCOGU0M/7?=
 =?us-ascii?Q?kkbyfgJLjWCHmnX5DvOVWvPtnbeV/ylFOxtSHFV3R3k8KAF1mKmsk/Ckl3Qk?=
 =?us-ascii?Q?wwAzghfIvF4rofxPPuQ93XFlpWSDiX4MSNOdofrMQiTp8vD9G+QAFlf9LcwF?=
 =?us-ascii?Q?hIkbw08Rqpe89DiaBsi+Tlb4Kqr+jWP8zzJBVSMvSMCykRTC8GbGR/TMnItD?=
 =?us-ascii?Q?nvSlmbT9Mt+4YkJs72Lf971QYJ/tlndeSelQeCqV4gaBTDPIO2lal0I78DhE?=
 =?us-ascii?Q?CkoXUef7ERLZ7l/cdzh0fgIXmzWCruK86Z9GQfGzVkk5CWu2WBBCZKQQMcEm?=
 =?us-ascii?Q?cG3lUMBEiUO6Sq5LSsBED2/EFPDdmrHkXW2dgDbJYxBTBEILH4kCcqxAIpoi?=
 =?us-ascii?Q?jQ5DtmYhYZMi2TvdKaqQFPYipottES0r7urzzg4/YJheHTCxi9BTAStoyyth?=
 =?us-ascii?Q?Vkk1OBs6S6iK3iLPuY4+4VPgcuQj2nqx16vZTTQ1u5Esy/Jrk26VQJymdgDm?=
 =?us-ascii?Q?pMj2j05KeHNNlO8Ht+HuScR2NiAvFLkeYfaWxoRa+cCoCyDS3OAOYTy97lUt?=
 =?us-ascii?Q?J1l+sxsFfIxadJ4hy2U/fw7xrG1ZJbQ+tXhaWLp548bO6IlodOVSiEZGLCM6?=
 =?us-ascii?Q?ZBC2X4bQwqwzW5/uAAknqI1aeN3YvlvjIissb6Zjt19mVg1Bi8fhcKKtueSM?=
 =?us-ascii?Q?ARKn13DRoq1RJvObsBin9LIdi+bvgCn+PGMR3uwPOfy+siXWMHzb+v6buALz?=
 =?us-ascii?Q?0vfQCfaXODixLwnzAMEwXnPVfSThzIuipC4EuDTvyc+1tw9J0O9FKZ8tDGCb?=
 =?us-ascii?Q?KnMELpFD0vJ2LD7nScsUY5gy1pqg+y8yCoPtuqjFdOtgOz6jpSohYJZ1tEs3?=
 =?us-ascii?Q?Cnf+T/Kl3Pfma5D1gxQdZiyjuWjCnxY6VTebJfkw+pKdBZ8FZWWlTAiRLchx?=
 =?us-ascii?Q?AGQKWXrjdjbrFvoKuX/TEkMce6v6ldfEbWvwFcW/1k4EM8H81bG+8lQzXJKG?=
 =?us-ascii?Q?quDdjgZFHj4DL2jxwMzDFx4mYlWgc9zopKNYFSxndVors1rw+t0BowMYdeiy?=
 =?us-ascii?Q?6VlvlRwV2VcHwlKrawT4dDCVDn0XCjBe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAqORABdYzdTzJRMcC3+vBMOFN/4lxQKKnIHFZ1UlXuPSGThHjvcEvy7sb3k?=
 =?us-ascii?Q?na9+V1elHAZHeCUhsb+PMkv2iKdQLuV7230dG/sSziU4dsFGLTHo3uuwU5mV?=
 =?us-ascii?Q?/drzZLo4D+RWTtVdKv1TykW9ffNQIePI+v+6K6KYmnuJ5LOiEFYK0FwXk9LJ?=
 =?us-ascii?Q?jEUPoso1lTOgP7ofLA6jS/05Rs9aIy6lEm4WqsmkJIwxo2XIVB9P8Cic3DQj?=
 =?us-ascii?Q?oPrAzxgzM38mdYynA1zw5T7k6CUQmiYaGB4OvjP8dkJYmDxhhe5xJ/hS9m4D?=
 =?us-ascii?Q?8hBIA5Wkc3fUCsOp/ev2lBB/cZDnmb7T2dDWVYdawt1M3bQGAYDdRVsYuIc9?=
 =?us-ascii?Q?P3dzRY+6KXtjE0s3tVFMOji9OsK11EDLwpQM/ypfzvil4OIa11mGwT6OtNuL?=
 =?us-ascii?Q?AUQkATDUl8ivQET35ZiTBjUh0HaOj9f45y1uBxM+rHuFKZH73wwG+uvCGwkx?=
 =?us-ascii?Q?QnFxtTWUMd2waTZLYDclSEWJN7iczhDLazANoiMZTkv6TMuMle1UJv2HqM7Z?=
 =?us-ascii?Q?BsTbpVCiLokV5TTNMgZ8EMJ5BZGpBsT9OHZSAx3UbVb2y10r0UXQAYuvBnTX?=
 =?us-ascii?Q?CtrLle0qlKCMdZdrDIJIl8iKwklx1+O5c5weSwadsIrseLzttBIl1i/NoKSc?=
 =?us-ascii?Q?n/PPPhlk5ChS5U0nggRb0KPShcFc3Hg4+/x/QTSEvbeeY/iUnb5QNj10MZay?=
 =?us-ascii?Q?Hyz3YDuV59t9P3JDrsZCENWRmn0q4xUKgw71oRrQCOn5Keoda7hxUf8ZeBNh?=
 =?us-ascii?Q?CRVZqUSZcl6NRSNb4aF64Bf5oUTBwkLfGk7he9CQgUu1nbRv5HYFh74S2Tyd?=
 =?us-ascii?Q?6xZfhVthtHhvs8y7liH3pAB6rRH9H5Iq72/+BUWWJI1o7M+qWMZDCEbrtjTU?=
 =?us-ascii?Q?1J5pzYdZQLheRF/bLQ8fxUZQvQHK/MSyJ44kF5Y1uTDsiPBMed/FM9z6TEJT?=
 =?us-ascii?Q?OjKS1fiMKlh6gwoFRqV0HWPrdqXskg9j6BpHTFyAluEFJeWzMR1QkXbiyL1w?=
 =?us-ascii?Q?b7dtzyJJxh0M/L4wdiObXnEwb5kai6iNypPRZxrFbYCuW1S6Z4I2Ho42XmwY?=
 =?us-ascii?Q?kTi2bbGgzQ2hVED7LWz7adCASqiJmmDSEe9S4edPKpyPZTEvE511HgI3542P?=
 =?us-ascii?Q?zpew72+yWxz/+fjpNdcY0MWRxcZOrBu7Qo+BOqFSBCldULqEJ1+0reOcXKQA?=
 =?us-ascii?Q?EvVV7WQQ2VCFzOynP0gsfUnwE0RZ87Je4tiYJbscXrlzIWtIp8XrvYqmmEkN?=
 =?us-ascii?Q?zxuGml8F/o/N9hHhzp0oV5o6qBq57T60LqgQtJG2Q8Yf9cyFWok2mFO/CYmt?=
 =?us-ascii?Q?w4OTOgZQ+0inwoJRYx5dyIPa5BrTWAaI5ghpOhJh1TugKRZ4wCE0MByEfoI2?=
 =?us-ascii?Q?mAHxQM+Qgr1mIKXPwxe8uq8CKD8D+yVnVWMcBBYTox41z8QiZ/xZJ0KTN9Ta?=
 =?us-ascii?Q?gPq0Qr+vWp6QwQiADH3RBNVNuptiqo642Lvszmtp02qxS4QC1aqXOPr5Rtly?=
 =?us-ascii?Q?zz3dor7dxyiv33E7FowbTDPuCz8Py11Kh0+pxq7FaBQR97tpVQL9uX7Iaa2o?=
 =?us-ascii?Q?hZglEcJFt/b87A65qjrZMS43OoJ63Iji7OTFXRl8DLml9wyUeXAQFy6f31SL?=
 =?us-ascii?Q?CA6KftatzhZF3AJASetXR4+6Am/FDrdUw46UsCD6UP75?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+nTrGtZLIsEj1LC4hRMEfvfbx64IserboY8nE40BsQY/XIOvFikKyI6R9gI/PrMO352ZEtyF94scDzINW5zb71Epn5svL4Z8Wr5wyYXxC/w7rh42XOhpTnE67tUAr2D+24iMxGA+eVj2rdAp/J0lr36zgD3bKemX+PCnGZCZkDtcFJL76T1ZTcymy5aoZyr+QYx3QVAUrsyKLIsdvA1Z+EYrsZVgTBtQ9HWMsRJKSiX1KsdGG2ur9yqKxvAmHz3WmPpgsABuDe8Og/NMPPQ5m+s25DvcAfy0wK13hIEJLfsiluIMAOR03wf4cksr3z8MGze+tRZ16CczeIVxHPGNZoQFQK4P92vnrJ35GOv19PdKlWJrp3kAicNevxNYSgI2N3CnRtvxm48t/iqzijzUyNOPvguBS+SCXHys9lU2S9PD+FDtLUnFolV2P+1JFdnyzNF/9/qac4LXoJRf+T1RfBgzfGzYOdUsr244Hlxmg4m1s67NBPWRxmpbPCNg9tgfe2Xwy/q7uaPrjyh0twQ0UG2WzuthD+a9WlATK/XDMCOY2H+mCPlytLpsnKUEqdsUeNG262TPND7zJT0x7z5qg6+J5Z6QNynTaHO3z2+LoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1992f681-7114-49fa-5254-08de1d9ea8bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:40:40.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4d7j5jkI06/8p/YkWQVJdMLFe1ndgA7tEO2qfSz7JCU43+G72LNt0KGJia1pl7kqM+mkJk7rvMkn3rStV2Pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF0D9ABED1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070011
X-Authority-Analysis: v=2.4 cv=L/wQguT8 c=1 sm=1 tr=0 ts=690d4e1d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=blUTA6d1koVuR4A4kw8A:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:13634
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX/ffzUnxnUWef
 ll5Iku3+R/fM8+U095AIfrkk1NmgPMOUn9nHd8kV59xLIgx/lVOMGywuTTbxlmsu58GvrHIfBbQ
 /5DTULNpUpRqNcsxvEK4p6p7E0aa0NWuttJVHfiK/jKzHM97gxA1CgCS3a+RDlW9nbajknDCTmL
 pbPYBEoNRDdk3PaO7O9rWcXEFIBs1P+fOtdixS8P5mqlytviHHHYB+Z0PeLJgV8xGNB2+74VqHW
 J+VjH2iF4ZNng6H/iYcS+GOiN8AD+hlSd9YqFpxdRbZKnDArYcYgsoJbnkasy3lgAQNvLAnKgUq
 85xIuNXDmT0cVYuXbGJkmGqw/OKg3nQUD2NFStbUv4rF6gjVLbdcIZoyYpBbstyQLdsU6lRaH7k
 qM1enZrX0YRdwk9DABoVJdAuA/apyHd/py7bNnibeSU6L3pjw78=
X-Proofpoint-ORIG-GUID: AodfAry1d6YxXb_PmtdIZ7ExN62PqzCx
X-Proofpoint-GUID: AodfAry1d6YxXb_PmtdIZ7ExN62PqzCx

On Tue, Oct 28, 2025 at 09:58:14PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Since the no-hierarchy mode has been deprecated after the commit:
> 
>   commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").
> 
> As a result, parent_mem_cgroup() will not return NULL except when passing
> the root memcg, and the root memcg cannot be offline. Hence, it's safe to
> remove the check on the returned value of parent_mem_cgroup(). Remove the
> corresponding dead code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

