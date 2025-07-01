Return-Path: <cgroups+bounces-8666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D5AF0661
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 00:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD217B2AB2
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F051CA81;
	Tue,  1 Jul 2025 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IRLJZGbu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VAK9o1rr"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027B242D79;
	Tue,  1 Jul 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408004; cv=fail; b=cV0m/3VEqbQ5PnxREPhSOyIiVxP3GwLfZtfhGIMGHyP5FWTY8MeKg0PVxfcTxlld5MInoKOKHu6up/3e3gTWMfjIJeREuj2SkL49lCDWoL7mDZJYQh44bqmD9YBVVURBASovFfqhQn+sI6SwLomKSvrA4ajNJjoduIIT/Eb/Hls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408004; c=relaxed/simple;
	bh=0uwd0++eDHqXlyB+TiQCX8pIGeqJyxZeAv4wCugInTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPsWfC4YdRMODkdrOn/kA6hy3jBoVEqwT8X1ORKI7HMbDbTbzZsxWGpPkOQgjkmrO1RynQ8NjH1WgaB2TCzIQSxKfj5tvuqKSwmHsN5gEtfPthoA2vw8CZWPjLHg9IfQIhGhh4g2WLkmbUBSZ7qfBpqgYY6dwvm2JRZoDhYtqB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IRLJZGbu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VAK9o1rr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561LcvWj016657;
	Tue, 1 Jul 2025 22:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Erwk3lfxsVV0EdF/31
	LPNGNPXJaNdT8fL1nKI15I/tg=; b=IRLJZGbuw9EZcc2jgmb4iV6Oe5aqaZJK8V
	5pqsKir7H1Y8d1mZKJpw5xiNbBeWxVyKgReQQliMXtH0iR7/alSq2nHstZrgsFgE
	Rh8RcQ9GlI76mduJjmtqMCoadRqcmlBVKIsxufyvaNbab6hBpGIuwML1JCmUM/SN
	pGDuBTv5FOMCGjk168dFaTNLOM26CKBXs9ZV2xq0njgY1dk+eQFVBK4iZeLvOvR0
	0e6nkDSKx95whcDui5toGYTxvWlgH4EPNzU7IjgnbQNLztHDeaAHFB0supDUdzRl
	fV9/WLjRjpSCx6hufrAxaBBJpKQ5AMYQ6xL4FA0kZ9SHepUgiiMQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7w1p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 22:12:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561LisZv025146;
	Tue, 1 Jul 2025 22:12:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uhnb0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 22:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeO5MAGmjeLRY8CKOXeFQYK/1fyWn2r4cHHFBjSGueX7J8h8OX3wvbUdBD90n3pwSR5uHv5aQpGDP2U+0hmpO/6g+f4PNIKLKLMqmh/PSdvDMQ1cqGkMTQYuOXBEsUJ5DkftpnhidQ0u/YqDlx8aCt6yqs0rCs4a+tr3w1mkbyrz0ccFqC6eGSNyQ2ULjqUXR7fNEslT9jalWHXv/v9DS1JUfR9w+PWASKwglFxsXth+vpxc/WU5beo7NXvFN+WkXPqYIM+cx0eQk2N+tyjCv9a7dqJSDvx57kp8JieMaUkx0cxu99dMe295wkpcoyuG0SPK9WPPM3rDNhaxc7gAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erwk3lfxsVV0EdF/31LPNGNPXJaNdT8fL1nKI15I/tg=;
 b=mWmzPWIvms+iiK8XQBykX4BYEn8PedH2wK1i9iAqMMm9M3acdz3lG243L3kbPqIAvaM05bSEEiZAr2yQ4z+a2gW5SanSfuG3A5HVYfeDmGH/T6kv2FfRKedzzwiYq2NYZbz2OqKoh9lQTCz2WvOVXgDJLmdbgEjntyRLfSpmDYGwDGxgESV1VmYfs5O7robHM+RXNdAvotRejgG5EnVd89tIyJFfas5Wi4Uxj+rmZ1IeKOAFwYKYIXMMKT4YoODvJvlSlJ8Ih6bX+sUoUNKX8cUMjkLw1xn/9bSRamSHFWswittTNRw8FndswcnqzKC3RvSIPjBYJ8lrCGrZSHpq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Erwk3lfxsVV0EdF/31LPNGNPXJaNdT8fL1nKI15I/tg=;
 b=VAK9o1rrUraFqRJOdqyRh3g+X6H62kTWEzpik5SMee+0JqrOolLyJrP2SB5mdDFdMCMcOxtNJVmWzkTHsvRaXUj4Q0dFDKvaEPHHLk1gQQ3AT9esFVZcDpgDnZrjqcvdXkFAFq4vtNkcU+jnIVNR9deElEIlm54JbXzEiPU832w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA3PR10MB8757.namprd10.prod.outlook.com (2603:10b6:208:57a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 22:12:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 22:12:50 +0000
Date: Wed, 2 Jul 2025 07:12:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH RFC 26/28] mm: memcontrol: introduce memcg_reparent_ops
Message-ID: <aGRdVzB5Ao1KkEu1@hyeyoo>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-27-songmuchun@bytedance.com>
 <aGKHXWJl0ECKN1Zh@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKHXWJl0ECKN1Zh@hyeyoo>
X-ClientProxiedBy: SE2P216CA0022.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA3PR10MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb59f31-8654-49b2-fce0-08ddb8ec6b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w1fRncl8nvgRMbznOAnu7XyB7nzPq/vi4XINFqKvNRZtwRfVCrnfZbGuBVQE?=
 =?us-ascii?Q?VCbOvAcx4O5UT/nKRR3VfiTRjiirl3dHOwz22REIcQehGpR8MBc/Nust8UbA?=
 =?us-ascii?Q?22ymFomAAb96OWJKkKbAnh3OzHhPDcNgnB+6H4pEZdb8KkzN22/ITPj9HE7p?=
 =?us-ascii?Q?ehh/Mv9n2XUWT4M3syq1inrwLGYhG6TMAizFxyPSXPX8ENAuqUe7/IdLpbMI?=
 =?us-ascii?Q?lxeH01RO3sEas9oEEEKnfTtOaWa6PoiDI2gu61Qg1y0zkyBgNZXJAxoHu4iO?=
 =?us-ascii?Q?jiacd0JbYfk9g0MPPLRASZ3nJdNJeLJYoABgDwdaM0/ISVwXVWIZUvwFiGeX?=
 =?us-ascii?Q?01KsG7RSxhuX8LESztlA5Pr9Kd8RTpD9SWpyPFbwfh4tPaqjNO9G4ara2pjk?=
 =?us-ascii?Q?YbQI5NduIGt6BmbWLEJA5wDrkkiD0QQk4K3xe13QV0qCUj4NcjFjYAghSbWG?=
 =?us-ascii?Q?eroeMIXzyF6/kAUQlztJEQ7JJg0ciXeQ722HKEi+gbedukoNJJ1+rsVs6xbw?=
 =?us-ascii?Q?z6W+CDqgsyW9kRhXPqeUeQJunWE+siTYzwrvO12E5NObYSgFywD8Xm1p6sRU?=
 =?us-ascii?Q?PKaNEBTc8iF9+6UEyR7vmPqTSS0CIZsWI0VfWq6WGDbQVJQAdxRGwFTV3YDa?=
 =?us-ascii?Q?39cUnkc0AR7C7BJ8C1WGFD1JQmx9esqmoqfojp+RyP+0gUZR6TxRanV3TdHP?=
 =?us-ascii?Q?DMkThkXQa01uYvadPybkNio+OJ709MMgd+Wb3Io5fBoXYfV+bL9Ek+7Ke0kQ?=
 =?us-ascii?Q?5AwzUVQGJXq3DBgIMFjmJw0TS9INVoRJfVYS1GO4tBBrsr2wRfMu92exwshR?=
 =?us-ascii?Q?dNFBnOr20vEiSOtVMv9etBY5pe5CJdDxtVTg0STPFzahEsNVfNPr9NMw15fO?=
 =?us-ascii?Q?gBrPXVIkVr6Yk8UWIvB5MnNiQOpmPjPpa2G0df+gSP1s4wc5xcspQZeeFpgm?=
 =?us-ascii?Q?9q5zRWdUQ5KiAKg/O6+GSmxkP6VlMPTUg1/aBrppfUB24MTqaJUTihtOlviE?=
 =?us-ascii?Q?mKX5EDp6aW0agnUMwonLVHOrWjxapv1i5c82St33YztspWE2XEf/x5jVpF9l?=
 =?us-ascii?Q?kebihjrO3Ah1uFZ1yinZGAvXCWxSFmvEV8Mrviwd6mukoTibJELfxTjKgApX?=
 =?us-ascii?Q?xKkLNUKx/rIv663aF7tCng4FPeKjLZR/WlK1TcuYZg27GouhD52DUobDvjjT?=
 =?us-ascii?Q?gwcwgFnZsKpt9Y8VYA+LYyp7hvHikJcYpEYZeYjiVY6wWhUQ8gmQJfwkX3h1?=
 =?us-ascii?Q?yRWm+DbdGu6FaQZ2IB0OS5tALajsDnnXqHLXgXdzuxX8xXXUndEEBuvjRs5S?=
 =?us-ascii?Q?Nf/i4adDDlcxnHJe95/0s6xPkbjm/dBFWxGPzhsumdWK01otjY15mlM9hNVd?=
 =?us-ascii?Q?HfamKZsSiHdH1vDxZbf9UWW9AWj/SUPak7FNdvInNDPc8Kh6G2j1A9k71BS5?=
 =?us-ascii?Q?1oDCGCQ1+Mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTUvb+VSYz98LH2IAtLlWGk/KmlAzQFP5UfsWtIZxr7U5TtJmS3Hc78mujJc?=
 =?us-ascii?Q?SdnzZWwsGDs0FPg29O18lNwSlZ28Q1HPORSGs0TY6OvER9wyFe6ww2Arh+mo?=
 =?us-ascii?Q?d9QliHCwwdAsOHk+HIZG4qzDupymRUVZ4EjWE2N3p4N3TSRMRvnuFLJ6BDM8?=
 =?us-ascii?Q?ZIR+twT8obtIKfFAVXPx3qUrqUuYXrm7f4789hZtW5O9HMcEYdHie5Dbde/z?=
 =?us-ascii?Q?jDfjei2wnRm623WvzNxqQoHdO3zJV3hVgnCYcbmpPAlBM7kI/SzK9nc7jErt?=
 =?us-ascii?Q?PTkeOlanjxqktZGEiSyxKTiRJmBziq82OyVBHifjXRsvZGODOcxUP4vk52H2?=
 =?us-ascii?Q?g9c9zSAFRND8XVlTsMA2bY5WqOzJ9Jwy6uBRA9xxz7e5dVrJEZ38bHOdyfYK?=
 =?us-ascii?Q?vnrbWoD3NwzW8sH4jVR00q5Hb0BSBSLSHqory9vPA+hWy9YAq8vSRH97Gbr9?=
 =?us-ascii?Q?Llh7N/qqzNpGraHAjXDmFSh5bxHLztUmOjWmHxckhGJbfmAlILe2rPTMwygn?=
 =?us-ascii?Q?Tsy3nslRg4mOgUciDea6ibkEKvoX/wGKwZgOltRk2zJL7SUssrZb4RH2q6pI?=
 =?us-ascii?Q?9joa66DC07KHh/oSUHoDe/8GM1ZYvY1Ky7WZzd00v2yTbxsuxTYMdUAgi5QA?=
 =?us-ascii?Q?5U9RIvqsR+2IHo23Ngm1jKJw3Zhd4rfMrt76nmKlRWqNVEWhAJK5gH6zNrj+?=
 =?us-ascii?Q?zg/cxbE29UaIuIrSnWCNqwjKYZ5wtfLtMwIQztCRR+ncI4ZOIFdRgioiltJ8?=
 =?us-ascii?Q?040ho3VlWClVNJMbsp7K/8JbE8GECUMt6K2iPiK6/2MSuAThX0zYFdV0N5r0?=
 =?us-ascii?Q?oB2mAYuM0s/Hpna0Yf24i3qkXONx0ET+MmrlnYK6OVoyyw0hf0YwzeGpC7Kp?=
 =?us-ascii?Q?8x6UARaIg2uaKUZLDNis4+snkL26115ag2Jwlqr3mml5k4NAYacKTeWzGFcB?=
 =?us-ascii?Q?aWwkmm5L4OzK+CVzj/wSIFYLnwPt28rIeR+Xg1Ioc2FAZozSwa0/lR9SAKbO?=
 =?us-ascii?Q?UT4wzdCaICjfq4cz8B8GfZiJetbymIBt6DJZmgL230h9hjp+9gQ5tZA3x1Go?=
 =?us-ascii?Q?um/pMPP9gLGLwEL7ujG8r8E0OCuHGDI3lPvI+8c2F0TuYXGstEOGx9Fs6IRm?=
 =?us-ascii?Q?POX1iRV7xV8foVX9ZYxI9eHjHpf86Uf3ItuzVhJMOx2u1QvlyDGL+oj/bx+G?=
 =?us-ascii?Q?myL2i8Khc0TvRWQl97/CUgexkFl1We7NgYON05/peKWq/R5uW2dyAYWSxdoE?=
 =?us-ascii?Q?RVxoW6kuYwq+JjZ5CSYHBf6pur8lxQD+nnsrq+0rnNhU+gS1ga3Xw5H+qKFp?=
 =?us-ascii?Q?6X6uZTyxV0/jDSdv4a0Gpwl9oeMSPBfovHHCbSVhaR1t0YTcBvLFltoolwvY?=
 =?us-ascii?Q?nlYwmtipW+iYB0QBoJ9crUecTDzjzt4ACvxoL+S+HOYNX+Xcj7q4v44fl9oZ?=
 =?us-ascii?Q?5AMuKCin9hri7+5lIm8nBotqyqNE+kWe8MUw0bWnzpu/0XcEUcG5ruCXB3/h?=
 =?us-ascii?Q?fpXsRxhhpqv4FDThHS+FGdUT7fiYtOO2hh4WqshzkBrbtcI/Ib81HNhLy+k1?=
 =?us-ascii?Q?kzvRNKiDW+Cy/SGGKZzMfnBIyzfk8rHkcBK47tm7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IvQ48m2BKDViCRg4vM6yEvhMm2H/5fcJ7ySvKmoiZpx7f/JTH7L2V+Ip9za2KzExkQKOO9dobHP4BdKscah1wtiGT1AElWZzIusuvAoJ3a1ixPCmXVKg8B4htaFJJZ9VEZtygGjfsEatAdtFSYEI9HoMgpUD3AeO6m8Mju9AbDvbVVJCNLXDx0WV97r/Y8ufkjA2Rv/GMaYXCFMrEm9bHUf/+wmfblDMHMci5yrLfsHnPrMssschq/7vGZsZDO8ZOHeC/5w0zWUUrpht+lnSF5KgqCj2E5XUf+8jrCLcnAlejPu0YgJ/BXGL/LUO8vVjOIGaK3xNlOStDFmBCMpAlzRJfodR2fkd5X9VcwCZ4mzE79YHDd55AFaB4Ni5Hxkwg3S3hrJRgkI0XFp7MlzLOa8+mr9Lbv8GS9h/fpIetZfwbKsLB/Ody/vbBxOnA5ixabSNXxtreDTHqhuRUg4Zd30sIJjlJQoDjqcWsiCsJZ9JPI3w5y+djsu1dG1azzcyEqDa+j3T0QUWGe/rf0I7X0iGsS3VRE5Ppidga+FcaA6ETlfwLmJOU709OqGAo0kEqMUXueA9JNyCbTfqsaJhBUbsIvl1iMX89JtFkMW9xLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb59f31-8654-49b2-fce0-08ddb8ec6b09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 22:12:50.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN5sBGtkAexEAtZ76kg3O8tsuCsHr5pKkoxoc+r7EF59+dgLIYJpUmPAssqcs4OjdTpYc1cUp3TGUvq8a2cq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=672 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDE1OSBTYWx0ZWRfX4vtZDJgemSuG nYZIxc3xKWckZXlyGZGpH2r7b4J/M2sZQ+s/+f6822Nh79IRQ++7GSsBwYzSx5/PI74Xq/Jp0bG jXe0d5LcOQFKkD/gGz2XxDEo+mx06OwsRz/mXhVn0jmg31Ni9vEOJmhIlNdrzAxw0rcdAYdNmrx
 7TZd4aF/GY87/kLfBsmAujkfXueO8H2kwhjGW5CyBheVPDgzFZ77vBCA/vw8yXXJ1x31BEo97YU EMZnxBsZGId5b40ZJzqOZ6/NXICkOD7kI22JFD9L4K1kM6HHY9n366lbobB1XCE9mGOR/ELUcgy mg/6QU/9wKs++82yqIxTVV2suicAils/GgXIPDKTN11Ay8XODgCD1PDC70CLlyG4/vGWFN5+ilW
 88Zus25Ey5oxrRBCqczNYBlLLWjjTjlKCYtQ9y4PZ+g2z+9I+IVAYT9DUMYWd55JOOuNVidu
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68645d66 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=XvGV-ev7FahXAOAyWVEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: 40eSykQ4LqJ3XXQw8wjycYiKJ1A_lJXC
X-Proofpoint-GUID: 40eSykQ4LqJ3XXQw8wjycYiKJ1A_lJXC

On Mon, Jun 30, 2025 at 09:47:25PM +0900, Harry Yoo wrote:
> On Tue, Apr 15, 2025 at 10:45:30AM +0800, Muchun Song wrote:
> > In the previous patch, we established a method to ensure the safety of the
> > lruvec lock and the split queue lock during the reparenting of LRU folios.
> > The process involves the following steps:
> > 
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >         spin_lock(&lruvec->lru_lock);
> >         spin_lock(&lruvec_parent->lru_lock);
> > 
> >         2) relocate from current memcg to its parent
> >         // Move all the pages from the lruvec list to the parent lruvec list.
> > 
> >         3) unlock
> >         spin_unlock(&lruvec_parent->lru_lock);
> >         spin_unlock(&lruvec->lru_lock);
> > 
> > In addition to the folio lruvec lock, the deferred split queue lock
> > (specific to THP) also requires a similar approach. Therefore, we abstract
> > the three essential steps from the memcg_reparent_objcgs() function.
> > 
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         memcg_reparent_ops->lock(memcg, parent);
> > 
> >         2) relocate
> >         memcg_reparent_ops->relocate(memcg, reparent);
> > 
> >         3) unlock
> >         memcg_reparent_ops->unlock(memcg, reparent);
> > 
> > Currently, two distinct locks (such as the lruvec lock and the deferred
> > split queue lock) need to utilize this infrastructure. In the subsequent
> > patch, we will employ these APIs to ensure the safety of these locks
> > during the reparenting of LRU folios.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 20 ++++++++++++
> >  mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++--------
> >  2 files changed, 69 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 27b23e464229..0e450623f8fa 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -311,6 +311,26 @@ struct mem_cgroup {
> >  	struct mem_cgroup_per_node *nodeinfo[];
> >  };
> >  
> > +struct memcg_reparent_ops {
> > +	/*
> > +	 * Note that interrupt is disabled before calling those callbacks,
> > +	 * so the interrupt should remain disabled when leaving those callbacks.
> > +	 */
> > +	void (*lock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > +	void (*relocate)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > +	void (*unlock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> > +};
> > +
> > +#define DEFINE_MEMCG_REPARENT_OPS(name)					\
> > +	const struct memcg_reparent_ops memcg_##name##_reparent_ops = {	\
> > +		.lock		= name##_reparent_lock,			\
> > +		.relocate	= name##_reparent_relocate,		\
> > +		.unlock		= name##_reparent_unlock,		\
> > +	}
> > +
> > +#define DECLARE_MEMCG_REPARENT_OPS(name)				\
> > +	extern const struct memcg_reparent_ops memcg_##name##_reparent_ops
> > +
> >  /*
> >   * size of first charge trial.
> >   * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1f0c6e7b69cc..3fac51179186 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -194,24 +194,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
> >  	return objcg;
> >  }
> >  
> > -static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
> > +static void objcg_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
> > +{
> > +	spin_lock(&objcg_lock);
> > +}
> > +
> > +static void objcg_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
> >  {
> >  	struct obj_cgroup *objcg, *iter;
> > -	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> >  
> > -	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> > +	objcg = rcu_replace_pointer(src->objcg, NULL, true);
> > +	/* 1) Ready to reparent active objcg. */
> > +	list_add(&objcg->list, &src->objcg_list);
> > +	/* 2) Reparent active objcg and already reparented objcgs to dst. */
> > +	list_for_each_entry(iter, &src->objcg_list, list)
> > +		WRITE_ONCE(iter->memcg, dst);
> > +	/* 3) Move already reparented objcgs to the dst's list */
> > +	list_splice(&src->objcg_list, &dst->objcg_list);
> > +}
> >  
> > -	spin_lock_irq(&objcg_lock);
> > +static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
> > +{
> > +	spin_unlock(&objcg_lock);
> > +}
> >  
> > -	/* 1) Ready to reparent active objcg. */
> > -	list_add(&objcg->list, &memcg->objcg_list);
> > -	/* 2) Reparent active objcg and already reparented objcgs to parent. */
> > -	list_for_each_entry(iter, &memcg->objcg_list, list)
> > -		WRITE_ONCE(iter->memcg, parent);
> > -	/* 3) Move already reparented objcgs to the parent's list */
> > -	list_splice(&memcg->objcg_list, &parent->objcg_list);
> > -
> > -	spin_unlock_irq(&objcg_lock);
> > +static DEFINE_MEMCG_REPARENT_OPS(objcg);
> > +
> > +static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
> > +	&memcg_objcg_reparent_ops,
> > +};
> > +
> > +#define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
> > +	static void memcg_reparent_##phase(struct mem_cgroup *src,	\
> > +					   struct mem_cgroup *dst)	\
> > +	{								\
> > +		int i;							\
> > +									\
> > +		for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)	\
> > +			memcg_reparent_ops[i]->phase(src, dst);		\
> > +	}
> > +
> > +DEFINE_MEMCG_REPARENT_FUNC(lock)
> > +DEFINE_MEMCG_REPARENT_FUNC(relocate)
> > +DEFINE_MEMCG_REPARENT_FUNC(unlock)
> > +
> > +static void memcg_reparent_objcgs(struct mem_cgroup *src)
> > +{
> > +	struct mem_cgroup *dst = parent_mem_cgroup(src);
> > +	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
> > +
> > +	local_irq_disable();
> > +	memcg_reparent_lock(src, dst);
> > +	memcg_reparent_relocate(src, dst);
> > +	memcg_reparent_unlock(src, dst);
> > +	local_irq_enable();
> 
> Hi,
> 
> It seems unnecessarily complicated to 1) acquire objcg, lruvec and
> thp_sq locks, 2) call their ->relocate() callbacks, and
> 3) release those locks.
> 
> Why not simply do the following instead?
> 
> for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++) {
> 	local_irq_disable();
> 	memcg_reparent_ops[i]->lock(src, dst);
> 	memcg_reparent_ops[i]->relocate(src, dst);
> 	memcg_reparent_ops[i]->unlock(src, dst);
> 	local_irq_enable();
> }
> 
> As there is no actual lock dependency between the three.
> 
> Or am I missing something important about the locking requirements?

Hmm... looks like I was missing some important requirements!

It seems like:

1) objcg should be reparented under lruvec locks, otherwise
   users can observe folio_memcg(folio) != lruvec_memcg(lruvec)

2) Similarly, lruvec_reparent_relocate() should reparent all folios
   at once under lruvec locks, otherwise users can observe
   folio_memcg(folio) != lruvec_memcg(lruvec) for some folios.

   IoW, lruvec_reparent_relocate() cannot do something like this:
   while (lruvec is not empty) {
	   move some pages;
	   unlock lruvec locks;
	   cond_resched();
	   lock lruvec locks;
   }

Failing to satisfy 1) and 2) means user can't rely on a stable binding
between a folio and a memcg, which is a no-go.

Also, 2) makes it quite undesirable to iterate over folios and move each
one to the right generation in MGLRU as this will certainly introduce
soft lockups as the memcg size grows...

Is my reasoning correct?
If so, adding a brief comment about 1 and 2 wouldn't hurt ;)

-- 
Cheers,
Harry / Hyeonggon

