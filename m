Return-Path: <cgroups+bounces-8480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F3AD468A
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 01:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1245217A887
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540A26E70B;
	Tue, 10 Jun 2025 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EDVnP+Ag";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F+gxSwB0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4474C14;
	Tue, 10 Jun 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597367; cv=fail; b=EqPurnZ+sk7NyLH8b7lT1JYakElLSofxAGECmlw1BbW8hDSgap/lIIg8drtpTlQqAupVIKEhdHQQrWRGbB70GHNJhgtTBYuhAj+HCCqdfR5XQ9xdEXBFIH64KByeRrmy0kOi6scikRDMkQB5aenKtLzmwGTdHLH/EKVCv6Q33Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597367; c=relaxed/simple;
	bh=jzNq2epb/T7cDklTGnzpw7yO3n7Tc+xsGTkfPbwxE3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pt/2DolNdsorRxQJNo056Y5XC1nfN3YUHQuY2ZjlPyBKSTWQOSnWIW8jJo4qp9XU+v3jCQYxiY38kaVLMuxFjOGKInQmrpQcY3ezXujdlCdKhYEXgyqAkxsjcXc5yBRDvzwPlWB7meFOnvqCEd/8SOZhH46Iq3imx4NAP9YzF+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EDVnP+Ag; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F+gxSwB0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALtZKY012292;
	Tue, 10 Jun 2025 23:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2GDiGYIhn7/Ur/HbPH
	5Fs1nuXzJqU5mJymqci8QRnVQ=; b=EDVnP+Agg0en0/8lrkwAHoT5vJ2LzdYFi8
	e1EfM/AlS61a19N20O29P5t2YQ6H806s23sdJTtBw5bauYtg/uhAlikZu8LpmXNI
	lpx2vHrSL4BGlJLl34DZSz+cAC/QhWtioGhZK2/h0YbU+XBTUraqS1EKugFtTV3S
	8cLX+WBKjMIF9poN4GR5tJ1pT3sLiWeLEKTJ6QBBVbA48tMkcOEcVZ8wChFAMhoC
	oQGXp6Ri0CzOrBz/eCgWiFnkGMd8EQs4h+Vrpo26IXX4D2p5H9GSVcaCXKMaEro2
	hKzYWhg53OqhAJyLI4RNNMe5p3+Fb74p4OZo1yNtXHrIyydWd38g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v5945-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 23:15:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AM9m0w003984;
	Tue, 10 Jun 2025 23:15:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9d2b7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 23:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO0AxWutcMscRmKA3OGpJU3spjNQTYkRCUw1OvmcHq1jRKGgbG1h0pRrFUmtQmU60Y8W3QTZPUotqmObvsatJz/pxlJbI0n+EyNiYKcqJXV+Cs/HNG7HMfXl3rTudbYAPGwAvoAmvPXeaKP4MSuE86f8ScmWETrDqhhssHxM7LLi3b6rhgEsQVgfF39kIL090UGnKm1M184ayvhNnCMutaBT1tvWwnwkITb50ZEpsKUu5lbt8xKirl4u7lHzEnmJBxjAIFk41/HSuh3VZR5sYEzq5A47AbIT3Kx+d6D2hOE+HtLvezWP1IEveDnfV+ldNTDwTiaVYlWbRqaNTbPpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GDiGYIhn7/Ur/HbPH5Fs1nuXzJqU5mJymqci8QRnVQ=;
 b=SunV1L/aKMAHo7xQJimJRF7cjEkbWY5oiQcZDBBYCCFiuznL4MOWULd5npFLHuhvrCnfhr/EeCa5uzjvix35Mttp0EsYkwSDltZsfRN4TwpQzfaQ/ruYVbGL5uGS5iAtKgWSwdZ0Qhjvrun3UB/b5TgtnBGeqAVkmoRhwQaKi5/iNIPwWl5Gk343D1E16gjoTKhP+bAInELk7AniLeiS/qbyYcJ9RmRmvY90bqP4kuefQIYlOeKCUSDO208+Nl3w3m3At9QdAS61m3sNzR9JOAWIj/8bN4mJIY/DFdKTGhbEj0aDuuG0EpGcr51eIrix3cOs0FIxL6T+ru7sdbEtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GDiGYIhn7/Ur/HbPH5Fs1nuXzJqU5mJymqci8QRnVQ=;
 b=F+gxSwB0vIMmTkdCe5I6St/kdO91yqL654xBFyn5XoemoB8MRm0RAmFfMbn0zmAQ19WgM23Xoy2385/2XyMUDstK1YL9W5rlr6HJ01/GBTeRMAEA1G8QFirgk6oul2mtBjbsUd+ATUZ5NL0XH9POVhgDzPPJE2KJk13XLKp6LTY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 23:15:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 23:15:47 +0000
Date: Tue, 10 Jun 2025 19:15:31 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, guro@fb.com,
        kernel-team@fb.com, surenb@google.com, peterz@infradead.org,
        hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [rds-devel] [PATCH RFC v1] Feature reporting of RDS driver.
Message-ID: <aEi8k1yKBn0egAui@char.us.oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <aEiZ212HZo3-zpMc@char.us.oracle.com>
 <aEikeOlAjvbqm_7v@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEikeOlAjvbqm_7v@slm.duckdns.org>
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd5584b-7bd7-44df-b949-08dda874bbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0S5eFojo40BN0XkNBFHqGXfMUzAl6MXJSw8UI+KNYUtOaBWXGlZYG6fV/ifb?=
 =?us-ascii?Q?UIZKIaMs3LHytmyHa28PHToMO2AG+SGD2OZIePI7ddQ6ZBECENxchQPwHB21?=
 =?us-ascii?Q?KdZslfMNfoPfn0jtY5ZdPSrbD9QAgPL1RFE6rmMplB9oW3mW4cHb5t53xIrd?=
 =?us-ascii?Q?cm515acOH8tkjkD3Qa8lWYiTDPfCJxDX7WngNealt+KeeFcvpxTV+ampXopu?=
 =?us-ascii?Q?37QEzp/12dEvJwOa4750x3QuZQJIL98R1C4fLrN9EqbP5GXrTornxWBybBOb?=
 =?us-ascii?Q?7GwCLpnS2eVmaTeJBxlq+LQEZ4U5BrZKHBBFIvvbAnt+NarNJrA053w1ciSj?=
 =?us-ascii?Q?MgokgFV9YK7dKINtJvlpX7gIyAqDeBh/D2r8jIQ0d/grXLymuD/hlrkEDBbU?=
 =?us-ascii?Q?OY+oNFtTuvriIUhUCwJX9Bx5OaoJJ4at5LH0sRus9+2HMGA4MjeL8lIb2+bN?=
 =?us-ascii?Q?6Mg5XlRqPJRH1k5jR9A8Mak0ACfLozMPsUvpw4DKUBvtEKehb7EfSrqrk6lW?=
 =?us-ascii?Q?Aj9jfr/Rn6gKq9IZmm6NgcfJstQj2HTE0f7yh0r8VU0PLNaSPLzEPaYmhy71?=
 =?us-ascii?Q?QxnIMmPMLy56+EXF9j/kpPCizCtFoJgSjGeH0sCem8nlb/F2BjQQvsUufNk6?=
 =?us-ascii?Q?nk2mAQ28S7CKQV63usp8GAt625BzI6lZ+O0lSy///fz8AECX5iKTfYfDeZH2?=
 =?us-ascii?Q?r57zGZhXgm6NYu1twgwPHzr5cTHWxxhwG01PiRFxJ2uWHwBisdgt9WBD8Ycl?=
 =?us-ascii?Q?Ah1iYd38M5KZK74MsV0h3nylxSLWxRK918w5nssatDb3xnJt+a7VGbP37uJ6?=
 =?us-ascii?Q?91kU+xZqFJrw0l+supEzWmu6sPpvVjYTcBE40lYAuXLmcPO5fiYJzK2tMRYM?=
 =?us-ascii?Q?67wnvvmVL3fmWi/b5223AWwF1/ANTcrdJdGUU+Sdsns3Qck8kX9HfXfumkt/?=
 =?us-ascii?Q?3uemBuVXtLkPSUdVjjY+lyWLxInwnapD96qc5kZfJk8WneBBTK2T00/9yG7y?=
 =?us-ascii?Q?lYA37Fc3eHjMZt6yxbYjoNJBVm7nlbyiXYTiLxvll70/H/6OJxbJ0YPh3Mdy?=
 =?us-ascii?Q?30N981LbzB0vLWsFbpYBE4gi7HfGW7379tM9cxpqetjo18G6O+VN20hkbXkd?=
 =?us-ascii?Q?5Ax8TWwuCy2yPU0TQvDxJ6fb3ov9IiQFVLHnmt1SHACJMgR955h0V1UipNyQ?=
 =?us-ascii?Q?09KMD0kjgdTUtfKHShx/eRdTVRAeVuSICDzgik1zrVlqoTEihyEK685v5DQ6?=
 =?us-ascii?Q?nLkn5gM8+60SHnfocccl76mfplQ9F3niSZSWqgt2km7faSo5vHvBBGyaueFF?=
 =?us-ascii?Q?UT/PdwRGoVBqk1bTZWh/0+YDBC4HilL9xEOKVR1diUn70YE9O9fauleeGFmA?=
 =?us-ascii?Q?3kAELBSkmEVdvgzrFlk1p8S1/0Ail3bn+wDMz/TMdR2ES/ZAhhULgyK24Ter?=
 =?us-ascii?Q?wWLz6C18IJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWBArgugvRHlEwslKFA6ak/nB4ilbyT3bmpgg0XBXPlvKdRzXQTNZeIvPiKh?=
 =?us-ascii?Q?AkqytBvFYekKEfss8/NQCgjAHFOQnm5jR+5bxMEWdwy4GpxWAtJKLXKbEzal?=
 =?us-ascii?Q?LYAW6hbJMumYoh+VWCaPrWwkIvZ1IU7sfztTQQvmqxZMPVwMECFrV+b7SSbI?=
 =?us-ascii?Q?rfRizF0ga2mpc2iRYzGm5UezrVnvQjCW1ujQC78NO2v0X9if/2d2WF9wVuNo?=
 =?us-ascii?Q?+rpaXKM9TAENCt5MSR3xG0LZgO/gteRclal7lb9a81eCoU8ThDJpf9362wTP?=
 =?us-ascii?Q?dzUL6CgFTWqbv7NHPqYJDbe4tx7iS1PP/8pYbKRY/30DBzhirIN6RpJlKmMO?=
 =?us-ascii?Q?I8c3yyPmBKJE9WNEI1D2BL2+fVRV59aMib2lVo0AD4UeWRam75l20bvQYCsT?=
 =?us-ascii?Q?Y/3tFz0WigDEo1NgpTvJ012qnAtqQ40D/b/O7xY7cGQo5XSWDOQhpIWSQ5WS?=
 =?us-ascii?Q?KDVNeVglBz5NbJ3aSm6A2QoUfYyvhdVRYLVxTSBIVGvC1VI3im5xSdcGZZhn?=
 =?us-ascii?Q?bHHyIufU8aQEYlc7t6Kpbv/aas8rkJIiE5K2YD2yST9KmBxML5zQZsVXykw9?=
 =?us-ascii?Q?jadfvQWzeu25+oLnOmJbt3wrTv0vJU3LKDGzHe4L3LFEoYkHSf3q+0YIWfLB?=
 =?us-ascii?Q?V7nnB5amLaQT77NZ2TTUL2peIMA3Qt1oSw/hCTc5HCP33T/JGqL1xKQopC1e?=
 =?us-ascii?Q?umuJaKDxjTwUmRAzQafS0j8UnhnEYln/BONBeaz1nmRYFbjehQklYtc4Jgdj?=
 =?us-ascii?Q?2FaqiHHNsYHSeuUogBx65rS+jCScfcdF2Dj4UBKE91T17gixGf8R3V/IYlz3?=
 =?us-ascii?Q?oKuWHdUBFYXNBC6texEhDJg7ZFYJvQqhjjO10t2etoJK+6ccZiKruSmnFmuf?=
 =?us-ascii?Q?ndfZPRiLFukS8AbtDvjz8dwAshBzYXsPFieORBTBsIylRW6sSHpr40n2MYpH?=
 =?us-ascii?Q?d1fcAuRvOwOalWeKdED/8qPR6IGhlERIgOmIEqp1lGIrc9y+ioNcN1doITM0?=
 =?us-ascii?Q?8QESNkoTKRKtfJVOUI8BoghKdEFLSXMJBjrCIMB/Jivm4bLaen4HEF50YF+Q?=
 =?us-ascii?Q?mKvQBMmz7TP4ZMfkPsduHQWvAQrqYLrogarrY/ftaYQ6MtAcclXfrF4Hs6qF?=
 =?us-ascii?Q?19yh54ZBaqSfELqSAbJeG5vV2F0xrcAUDFczsQnxS0yOf8xDP1YUhIClcUhK?=
 =?us-ascii?Q?xeetUdQvOHF3VDvfPHtIJcef5ADXgFwhpi5mzWnXgGT+1vu0xazWOcuqRrC5?=
 =?us-ascii?Q?JFGK/yVIDJnguBJ+4EX8eSR4Wl1YO/X0Ths4EbiwBVtHp+Tfbl2h+kAneIhS?=
 =?us-ascii?Q?/MahY/dBE7xD2yPTh0mgMCrZj88XhESh6Cyc6Pu1ICaMiByHW40wQppOmsWr?=
 =?us-ascii?Q?jS6PT4uslVXbSf6rSHMs88zw4qoveewiydU/Koq34bQkjFk10VE+dShvq+FY?=
 =?us-ascii?Q?7oW1mztTFcqQ4zHzcN/hWhvopI1gkRBalFjDNXyGsATJu/NgjiLuU7S0rSJp?=
 =?us-ascii?Q?J+fC8pHiOfyIhm8UZrdMBreqUZz0KAjEysOLyPGo5hWL3nu84JihmxWQayVb?=
 =?us-ascii?Q?8F0IXnwEMwmdhqE2Bw2foFqSMtawSFrupSinPS25Aof5NTRm9P9yyZ4Tp36Z?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qYslAQpINmIDLUAFCsM3NuN0w6PiG6jmtpP/s7BaLEM6Ph5YPCKYwtVFY9L4Vl+FbCbL9cJpnKfB6Tf4Ry8HFXcghSUBCNjLHcr0FoUgHDuOp6w2wl5K/W+o5PgEBK5Rx5VUpN2m7DCsCsLbucx344ZujzWiWPNDHvL0zM5OlRa/6Hj+xPoFo+OaniRdnTopPLmrsOb7s69bfKiRCy37KgHmf9uVDQpycely/0h5vxVFgnLRhCORtK+5cLeY2tLIBtE/guGouCy+r2pTXqk9aqDm7Ar8P28WnphMN/Z4boXM2IesnQZbh09flXGF0R3XYT6jPZcRYRsISiUutjx6k/PGICmEVVfpmpZWZ3+V5Qq7MUQFszBEPKGOiFQeANt1LWZAYzT94rxx869dpFLkQHOxqUj/mx0oLRaPCk6e9a4lr9AezPYW0FMwBLOV0lyUUjGBgqAqdWYauEhKgdq7eFbj3H1gKqpDCNoFZCCZDxokaql80A6hVtNI5RfVfaOHo7XclMB6dr2LNvzLn1HlzcIpvcwJ1Qzul1wXQ2z5pt34B0gc48+eFCWeagk12u3bXjJXxF59nFjHmN1V7K78APSu24AoU+MzPOQa/RW27Ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd5584b-7bd7-44df-b949-08dda874bbb6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:15:47.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwPKMyMMr15NQi512LBy2TPnjCydkwwm7K8hiy8ve3alIuGF+XeAbAG+VrCB8Dzs6CfLvOcF5X4Jt38We5wxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100192
X-Proofpoint-GUID: qThRF4PDPx781b4yBejRZcEyW7CFqray
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE5MiBTYWx0ZWRfX1NRUJpAgu27z AtCl0tAJUqAiknkjgWhO7X24JM9dNNQHHwZ3HYnshN8XSkD0VLcbqFonpyOdTDcpJiNBCBI11p4 HwsJIKlojHcL49UleqOaeOTXYCaHrn9cDpLcKPCFwwc4xie4jP7TzrfhG+oQnYIG122L1IWvqbB
 zpuagZDSquNcYmhCyCgGLAtoK4UDLjCdOPjqPMx8ROSCSfFeUOke7rrbvCMI7X0nzbxnHVSkd8I osq6vpCDvjfva4STBMln5fS4cwKlA7Wb3cOUsWyk9gO4ZvqKbe3Q5CRBlyS8nNWahgkCX8QfOqq Nsmt4li9hXYetR37b180la/0OECVHb5dyN7wBbQ72N5O8nVf6blMxZER9L9tiYGNIPAvNvIc5Gi
 MH/VvBL5bbMIpn32xtf6S1bKf+HiriCqtrZy9aCuaIBOfg301zW9QKePvjDyjths8L3BExZ8
X-Proofpoint-ORIG-GUID: qThRF4PDPx781b4yBejRZcEyW7CFqray
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=6848bca7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Z5zCIwZRr9MpWiKH4fUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714

On Tue, Jun 10, 2025 at 11:32:40AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 10, 2025 at 04:47:23PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Tue, Jun 10, 2025 at 12:27:24PM -0400, Konrad Rzeszutek Wilk via rds-devel wrote:
> > > Hi folks,
> > 
> > Hi cgroup folks,
> > 
> > Andrew suggested that I reach out to you all since you had implemented
> > something very similar via:
> > 
> > 3958e2d0c34e1
> > 01ee6cfb1483f
> > 
> > And I was wondering if you have have feedback on what worked for you,
> > best practices, etc.
> 
> I don't know RDS at all, so please take what I say with a big grain of salt.

It is just a driver. One talks to it via socket.. But it can do extra
things based on setsocket/getseocket and such.

> That said, the sysfs approach is pretty straightforward and has worked well
> for us. One thing which we didn't do (yet) but maybe useful is defining some
> conventions to tell whether a given feature or option should be enabled by
> default so that most users don't have to know which features to use and
> follow whatever the kernel release thinks is the best default combination.

I see. With that in mind, would it have helped if each feature had its
own sysfs file with a tri-state or such?

In regards to the existing 'feature' sysfs attribute:

How were you thinking to address API/ABI semantic breakage? Say older
versions implemented a "foobar" feature but never kernels implement a
much better way, but with a change the semantics (say require extra parameters,
etc).  Would you expose both of them via the 'feature' sysfs attribute: "foobar\nfoobar_v2" ?

What would be then the path for removing the old one? Would you just
drop "foobar" and only expose "foobar_v2" ?

Thank you!
> 
> Thanks.
> 
> -- 
> tejun

