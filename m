Return-Path: <cgroups+bounces-11656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D88C3E32C
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 03:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F18188596B
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95732D0600;
	Fri,  7 Nov 2025 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ItF3qdkz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRlrIisw"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A761F03D2;
	Fri,  7 Nov 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481109; cv=fail; b=HIiWfJTIc+NBArdnQi+rtRTW0mDxujpFGKNHxEUaZJSDPy3mMCfv/FmKo9wemkIvzi9//Hl+1SFqWAYUPkU/TUFS2wY9nra5JAKEeTQ0w+M5p2gQ7DZzCTy9WXeg+DfKwXNxl+vjHVlVoFfnp6V0V8RJZpOtAPdFDiXm4L0qyKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481109; c=relaxed/simple;
	bh=8sbM5Jobt9gdDLjGFYwcTjwpubW1yrbMDfBlFVyMaGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DZ7WS1DRreEIlnBphyp6YSDmKiVrQL42HuFNuIvbP4gT3sUlT9oqdOswu4vixUvVCqZ8gZdxQYYvz4MC79waAsqFN6ZsasaUq1Lnbi9ELb3gg2fVz4Km4g5hMRrQLLyTYpK1PMRv+O3R1B+KcVh/7mI9FARrZ2RP6SFON8K3I1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ItF3qdkz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRlrIisw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6LNOZZ023378;
	Fri, 7 Nov 2025 02:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bBNCYgGQAr40hS1/fF
	f7Oy2DNO9KQrXENCtKPSlGdHs=; b=ItF3qdkz2lJihF6FZq7vPTiYoZaxBwbB1h
	V1ARDr0PuIFT5BWnX+ID6nAAOY1UWMXD0e20AYj/5H/zrmy9W5bdjK7+bPOhL9K7
	pd4YQw0zBuPTbPPx2Se4RTeDBVx5CJMVcDHMC8Y4yuJPEIabbGMi1U0p4EXlxKqv
	IlutkvNJZWgSXUz/zBb7rQSdwBwY8C8NlyPJ2n0q+C0Lbiz1ykNoA8TrXsv8w0s2
	gr2xtp82wH7FXVATOGpr0cwm39+sAvCPHOVoIAIgvKEeTJGO/ALKTzzNSIDs4gxh
	DLO4EYPu9/Qc8hdfhnHIo4S3EDjijDXIgBBylpnmkbNCM8j+t4lQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yw9rv25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 02:04:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6NbDex023206;
	Fri, 7 Nov 2025 02:04:09 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngr07n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 02:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsgkx9xnfWrTbCVbol4Xg3UtoE9SXUKzfyaRADH+lLbHV7yLU9CG2WQVjGEnly/3RAlR+Pcjqo4owPj4v8uGBcvwq0okPVfXMqB3IIEMMhm7NXeC9B0rlmH2i2vskTbF2i3UoJvxkLHwo2eI/A4tTrL6elpD6YscfyHhXtVFdYkBUkk7aWDoWThu5wORO1H1W6prSHTFscKh6Nl69auFhy3cDoGqMno4RLYOug9nMyYz99Ze7XDtQFBVnX4QF3ie8pjCPj53B5JC9RQggQV/6/txu94L0JGEtLLb+oQmK0akE7PPm7HgUEz3kG9anLvtqbO4l4SJNm+2D4rMOcQoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBNCYgGQAr40hS1/fFf7Oy2DNO9KQrXENCtKPSlGdHs=;
 b=SXhewUpvG7tCvczB4a/0VCusCRhj8PgXlfW5hn1eFSfj4souqGL5BxZqx3T7mkS9QCY77aemuOoGK7b2f0s7Vcx7oZc2/ZChFa6lm7eKEtiiK6ep2IlwaVt/FP4qLwQ0+a/GRncmytJ+T36dw/Wmofra2/NvzGB90hmIyBGtHLKAr6i+K9eTtLj3JJZssHvYg4Kx8q7dpaif2XXaHQTNPskaYvEsmguXTyWK16M5bZPL1tFKDCflB+BouuMoOrSfh0dK3YqVBVzs/gCnh3LqwYO+ddFkLi9w93FiuwDSR9Q38Zm3LmwWYZmpEwxiCyn3dMwP2DXqSMuXMc/Q9w0o+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBNCYgGQAr40hS1/fFf7Oy2DNO9KQrXENCtKPSlGdHs=;
 b=XRlrIiswony0OmofLhkD7vozIOHEC96V7twP6VF0AFZ1mfnDZsHyUkCLcMjdnmUHhYGrwQq4Fopz9fZjUBFpJhrtmh2jIsJ0d/0JcreVAxAbdhhKNgJd252W2IOeJvf2NEUWDkp1g6SKXKslQHxB3sBm7Qwn6j60RPgLEMLGrds=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8352.namprd10.prod.outlook.com (2603:10b6:208:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:04:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 02:04:06 +0000
Date: Fri, 7 Nov 2025 11:03:54 +0900
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
Subject: Re: [PATCH v1 03/26] mm: rename unlock_page_lruvec_irq and its
 variants
Message-ID: <aQ1TiuTL5ZQ_4JIX@harry>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <f68f1ae435edbbc6cfe15448c2df5c4112a4a61c.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68f1ae435edbbc6cfe15448c2df5c4112a4a61c.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0013.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: da9902e1-020d-4809-832b-08de1da1ee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1RDoS1HvSW7R3zrt8IOw0mtlt1g1TWCazB2EuM/be9/PzNioO0qpgW/tHUP?=
 =?us-ascii?Q?Iv5TcLLuzchVMXfLnlGwBFUa4zBS1zUEoIaMzxAx23DrNRuLx5Kzu2nOBV0c?=
 =?us-ascii?Q?D8afLh/EW3V2KBZGBdbxusOZtvMggjTjm9wycatNO6uihnbhRUulmZfGOCOF?=
 =?us-ascii?Q?Z5Vgkg8Dacw2DGyfpgZlZb3nkWdqm8y2DNofSBijPRk4XJZUtfOK0qaVGQ6X?=
 =?us-ascii?Q?FUvnIHSiPwuk9SWtrWnW1t2pH2mym5DBR5ilS5A42oUHWvRxCBH4XefCe61g?=
 =?us-ascii?Q?uYuqQey4NXxDAjwPhMa6WhHgBWQP+xdOu1ev6CGIUaSjbobLcmBZvpoA1qAz?=
 =?us-ascii?Q?F/0Qu56wWrKkp9SV+3wT15usYEPkR+s0tpK3NUqhRxIY8OENs78bKk4KFGEE?=
 =?us-ascii?Q?TAS1MKahcclByxKp0Q0Jfna+MWf4rRQpiuMR3+mXQPB07wuMFuJY3XlGE+PI?=
 =?us-ascii?Q?5obxDgv/YlSSKboxBCn+00eK1InXYdnpx4UxjhktS4cFEwLqIoxITz42Bc4l?=
 =?us-ascii?Q?vEETXDNT/Bivs1x9a34nFuHLQJfedKhayi6riCfles7Qg3W7mzzk2Z0NNsOD?=
 =?us-ascii?Q?gYIWHRIMqq/wCx9/jZ0fx/zmwyXGcguhYCSLOwgr035vVv9EAF8fL9KgqiEy?=
 =?us-ascii?Q?aeioKpOQHFrBtqPWTqXRBEmJi8HHnQLgY46wCWln3URgY4pm8SPkhSv2j64o?=
 =?us-ascii?Q?2vKiqcJEHHmVhQKsqURrGC4CaPzefo5NPuPMRrxyRtNHQLwgCrnKK5OCz76r?=
 =?us-ascii?Q?roB8ns3JgRmU6Q8ZbEFVla7UFPAnYvkBxxxHCxyzdb73jbB92JGTQ8l+v54l?=
 =?us-ascii?Q?J/PVhEHModKUxJ2rULtV4XsIa+4UKBSGTYNjEcbroxzVl4Zv4MI/6tvbXM06?=
 =?us-ascii?Q?VZdakT+61W2yJYnec44KL8uXvY5su2LEoOMhjUs9UTrbB5r4Wn7vfkn+Gk0p?=
 =?us-ascii?Q?G3Fbbd7kWAj8U/DEo50mJ7vLLsN8b5mAeIRxU9i4frT0jgvB8p5wR3MeONza?=
 =?us-ascii?Q?I3b+Wm77Biyb0MeptGdC/0spAmvY2qk1FDi57uawlxx1Tz01H06VCPv/t2Jf?=
 =?us-ascii?Q?G+STU8FByHiaj2KZjtDUeTF3gztKQgfaFYm90Hxkzq2kTwvS0YwFlQLC7WFt?=
 =?us-ascii?Q?mRZREVgL7AsXzQq7eY6mDbz0Y0nmO8BnwYbIVtwsaVn425TtLO5Kb9y1m3Ru?=
 =?us-ascii?Q?z2O3NHXTFquI+pPf3KFq8fC9KkMPAYuk34kHm00AK91khhgQf/DjxExy6YjT?=
 =?us-ascii?Q?82v4//s8LtuwDO6xSSIQqhysp3LcjgL1nFR3wnbcx8YuUk5Ov1GYEIQn6d6K?=
 =?us-ascii?Q?dWZexao271EaOlM6gHCPR4jxi2ItzTuqaq1z0s5+EFSIfMRUAvBkicEMvWQb?=
 =?us-ascii?Q?9c9gclOrna+T+0oA7f/pre+APkCNEvKnt65q3YlFq7B/NSE+PDM71nmUPBDE?=
 =?us-ascii?Q?R3DN8gsO8fvl1b/6qjFPLHsI9wVS6/oq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Ssp1aJzIoxLMVDa823ME3ZR5NIqXL69E/uv7hksMTnDjN3j0ScsEn7+lixj?=
 =?us-ascii?Q?j2rjCAHKmcpnFvjJeh6ZI67S/SD3lZzZxUlyvzfqHksp3h7o1rq8rV8qx6uK?=
 =?us-ascii?Q?m0KEQkUJdd2ELmXhKlbpaBMVEnWYg4XZhs/qXR2T4q1+9lAy8earPPQ58HD4?=
 =?us-ascii?Q?QGD/mjpnapAaFayuAvhUc2L5WhTU27buN2CR9N/s8M90rPvpkpcMh8OMS8vN?=
 =?us-ascii?Q?0Xd2tdk6cZ9wso9+Ya2t0seSncrhrMKkfFHglQApnXXcSJ98prgdujFyPrHg?=
 =?us-ascii?Q?r9hufDgn6QjMMXD+sjjLH8oA7I5naprn/yUZWRClNWUFZqjNxXObQ0lGx2OG?=
 =?us-ascii?Q?GbfLKZobkY91V9sgByqK4V4voA9npAg0MWKFJuz01UE2QEAsV2fSkIi0Iqbc?=
 =?us-ascii?Q?nMVdL+TU0K3Li5dIZZG/DNoJRIkqvmoKuylqw2YCW1ABJPFzqexiiSaViIOr?=
 =?us-ascii?Q?ATXveNxMQyPqJmvuOT8JGk81PKRogLWkVPRJDqbWV3G0MEEQB4ohJbrh9sE1?=
 =?us-ascii?Q?nZU5HEMlHfGk7kkYPXkg2+1p+NZeH882n/3liq7ZDpuwiz8WNZbjeX/R/FJ5?=
 =?us-ascii?Q?1xF7H3dLhzA1WSmbsREH/oZh1QJsDJ0EoXBo8BgGEzRUoxGxY8gv/3xb3d/S?=
 =?us-ascii?Q?M8R69OjsrYcWY5jLMtNbb/A6W15VGbXFje4lTV0uy2aSl646DUmzofwQwE4o?=
 =?us-ascii?Q?Sl0edsdXmf/VU4mtldKwkn7fWzELU8wJx39/Thc+lZhtik1jOSaLE238AEmq?=
 =?us-ascii?Q?U0Zqrv28Vwye72/DyakMCLVfWK67y/q+5cE7cgaVMSrpuwYfUD3zJ9qXx8Ba?=
 =?us-ascii?Q?JpQT5ZuATGTeOf5fMktbiRWR1fthqhP05Rcodo8W0AiyMhXm/H9hF0mnLu/N?=
 =?us-ascii?Q?ZnJiFG2cHhPaMVcGLVoEOWjagSmtYnsCR/7jBGxGMM4a6t2oMqQghZFSweEI?=
 =?us-ascii?Q?ISHU7w1sGxsxbeIXZJ0wIsvvHhkz3hP7C7N2XZg80QT9XOQreIvMoz92/Yfv?=
 =?us-ascii?Q?Q2Qir0tiMwSqM+nQfSs2GQysVfymyabbHmnhUIkEE9fSPA/ZTUCNUxrMajXW?=
 =?us-ascii?Q?syYOCyKHjiFkmQjpnbUvaUMPeFHuCdONNfmBLsSQXjnHIAsgHKMynx6voFM9?=
 =?us-ascii?Q?CN9KPhZnypMJZpBTN4O2VpAoSjdzcfRmB+zSUktemE29gs+MygnGSjp27pum?=
 =?us-ascii?Q?ayzQHnMiQH/V98oEP6prwDuklL43iYwrfBp2NlV5JqAIwkjKsc37crAKH2a3?=
 =?us-ascii?Q?iy+IHrCN0vayWHfXwq4lW+TJCiajJI4sJUHhZQKe4qah/PYUcASpIBrFqkOl?=
 =?us-ascii?Q?QonkdcRZit28SXrGkFus81B/9HpxsJQFEJWi0+ZzaRTNCr808M6VHhJehXpk?=
 =?us-ascii?Q?MOdVqgzqvIdiw1FCbKNV36EG72VOvH4GqHj1QLizCEE4+IOtiq+aSKHbwXFU?=
 =?us-ascii?Q?nbGY+yx/A5UJT3NyLL7qqP34V41/Lu5iYKwHRURk2yLcuwJwYoDS4RFz4cnD?=
 =?us-ascii?Q?Scn3BseNN4LVUzQiDcJmleM4zIj5XkHXNGia/WBsEjKE0XREiTAzMfp4pjBC?=
 =?us-ascii?Q?I5WhmwwxHKdnfzbylei52r7NtW3O8b9aUyXXILFJzNJXMoHfKLeEhXk/2P15?=
 =?us-ascii?Q?PAvubCWuOSqGtDOlxdqw/wvb1i7kSuyq/GQFN8LcJkot?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aLJec0kmxDKyWBczBuMHZlkDbcRZAuhwYz+5qWF9WRlqU9PgBQjHfrLcDnbmr8FEpGcZq9+XhGrWJf2V3CoAwMauOr+cYYHIpJThHe3/XpAN2ziGEx0msTr/LCZcQqOcUSCYvyi7hdDbWu1c11IaiRZSyI5NisemTnrfZBoIxYRCz0O49qR2Gl8SDsjyG04TlczCoAN6kySRafrFPhuHCav8Htyu0u4A1nNvNl+8giaAT+N8RfVHI7/bcac595x7pFD/3HXjPsb7ABcKvaJz5a71BNxSZDT+Oa9ZIUlbtYa+k7LlcRyrJKm2eVDwets2LT3W7OKX7VOw+HlR1cbt5udD2t3mCJZt52h3Ss8YHn63MS1z9ryx7LF4LglmRXDQCGb1F6fthJvkqLFDGW64mIE+2vw5gZ2tSjY4HPbuNt5NCAfMwjiLavQxJas2ZRUanhaC/qVRQnyOp2kqgzfDU+nOW/Z615iq6Pbb5J+fOneitjrrKCGOM1AJ2jKHKcFdzRziog2P8X8VFBlXG7uivNPN90G1L7YMOR3mHZsyT/GQDmRQc7DcMgIatpr72sXxUM6QQ08ND2dOgt+iwB+1+lel0REY/U1cO84h5Vo/iwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9902e1-020d-4809-832b-08de1da1ee84
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:04:06.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIM6pzdWM1zj8SqTn2JPeD9mzYvSGtRRJ0DThygLF06bkn12AI4IQ8kPqqO92UB9LYLxJmpddcvYaPwO1tv6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=964 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511070014
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=690d539a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=T_itOBEgcG11qK_9x1gA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX6GAj1duHDxRn
 88iZ9JgW2rDZcJEuVSunnzCYaTUFs4LPNXL76PgNsIahOvYq4CBihRl1QDLTHmNeLOFNoVftAGG
 KsmHjWdlklQfKicDzLtrr+1zo7Yr5veAbh0Is3LfGQQ/gXW2zl2snwcgTgYzvadXCY55LxguwzI
 IdONBLps0symwtbgh8mZiSeMpthAe1Kb8m9nQe0uxkaUfrpyTyEnu7uL1l0cHB8f4YABRg60JR5
 cyTYcrdSVOD7YV+Io+MtR1flz0+4ysQpwqxZiziBxg9bRgBLAJrmmz6W11xIsTTlv3GoCO00PI9
 V+4KUBYuFsRakr7gSOPJS6xYNXf0n3DXGV6Hvn0/Y4+TmpKch0+stkdBe613JTTqhZeX3YpYow9
 lTXPNGNZTmuFl9dDqM7IezYLaLAAohp8XsOUaRAF9SjxU1qnLb8=
X-Proofpoint-ORIG-GUID: ScWmDnMTWMHT61apM5ccHnihR3uonbbM
X-Proofpoint-GUID: ScWmDnMTWMHT61apM5ccHnihR3uonbbM

On Tue, Oct 28, 2025 at 09:58:16PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> It is inappropriate to use folio_lruvec_lock() variants in conjunction
> with unlock_page_lruvec() variants, as this involves the inconsistent
> operation of locking a folio while unlocking a page. To rectify this, the
> functions unlock_page_lruvec{_irq, _irqrestore} are renamed to
> lruvec_unlock{_irq,_irqrestore}.
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

