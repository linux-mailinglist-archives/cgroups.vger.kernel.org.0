Return-Path: <cgroups+bounces-12919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67964CF2548
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0173016992
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609B30E82E;
	Mon,  5 Jan 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwHFkToL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wEolG4QC"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD730DEBE;
	Mon,  5 Jan 2026 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600355; cv=fail; b=b9yWvKb0vfftA2ownaBbpa1al23Wgc9vokfC6uCD7er8I9h1IZHnVsVZHls5tYn7ILuOhx8t2cdkxknMcq5axwKmBqUTaj/lP1fzmdXsDBY/Xsm22dQlspkWeWIUWRcDMPuLzELU0bx53dsrbGfO5y1qSOnfaqdVKC66PRczmx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600355; c=relaxed/simple;
	bh=OS15ZZK/w6GktrUp4xZ/nuRElhBGYihb15Wn0FO2H/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUPqHQleGbdQyqgseP6On8DkWKTutQPyT4KaP3LnbGtVFJJzoGVOmYRvvEk+Ox4kBawnY9kZvaaYQmACg+b0XoilZ99vI7/ao0KA7nJWPk+TvWVbDri3AnK/pEQEsaMv0CUg6+iWJnjuXO5Pwkc4TjEQke+LE+cpAW+sZCfIh7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MwHFkToL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wEolG4QC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604MuYxQ124437;
	Mon, 5 Jan 2026 08:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7XpgH4yoTxymamPFX/
	k93duRv0x8BtUsm+fOhfZxyhY=; b=MwHFkToLA45vOhtkbx/I9JvJhEihVmWNaj
	lgKcpU8GnmH4wwY3u8qWg12k1yptJN+3RDXI4m/yf35VWWPKH2NazgviwDAx4752
	NnBIT9cuAfS8ZQAM9t9yoDYTOZJ9Y1c6BfDocFUrlJFXpae7aYD/DSWrjcWbvRmW
	EXZvx5Atj6fNdbM2FVrJhKbAn2ZL1mGCqgLkooudmrQG+1GUU+5zhAx9xXcB/Eqd
	cXtaGKWDaDo9cBciXW6tkZGLXhpR/u5FUnmKpT61cx8ax2mvCp1sVfB4q8zXv7r3
	mYLzys1/AvN7B6B2rLDGIvv0Eg5Kvyebt8UhwRxb5i9y8BKXhzvQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev6nhbf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:05:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6056uIMU030712;
	Mon, 5 Jan 2026 08:05:35 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjb45u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSeMKU+ZZfDKaK4EjoajEBfKFq6O1V3C6A3lXgE+IGAOd1uvIZgCmfJAUD6R0b99mk6hDSB95zPt2i4RgFqncMXF7BH/0ahFQ5MbDEkviaDhvpdRZhx/46QDBADgDe+fkNv12hKq4U95zgJBOSQxp7S0GFJ22yO+7lblyYYaQAFnwd5lStFXuF7LjEUhgolFn6j239wyWuGsQ+SAPiHIaSmtnpDMDIpvCjSOyj1azl4Ec22H9bAPp/zGRZiKjD1s+U8hvnWWj2JzZQ+aK8AUlcmP5IOlXHiYFPL6aqPPTdWLhmPOOBKo5NyeqvB3o3VNeBCqryD/jHzPd7pztqCCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XpgH4yoTxymamPFX/k93duRv0x8BtUsm+fOhfZxyhY=;
 b=W4xF0At8Uj7HK8l6S/dKQDVdkFY6lP2Ky/UF9L+jD/3YlN/BW2588ut/w6STu+6+WkoBmqoJMKRtB85al4H9MkV+Rd5DWjrscEKjy1HobWNqEeO5nElEwABDhiynHVoQyRlegFVuWWj87qBsTvgpJVw78oG6cermRFHuuA/MHUv6dBmDEnP5zKiGaylRo3LzKBCX6ohZaIW5AJ01D4Y6DBGXhlGdK0cRWTOajqYtg6bLA+thToLQWqy1MvjmyMOIENFBsrwB3RE7xqxopK5zRma25jeoPB3Do9EzGfbW+2PHYQ6Rb7gmcguUiSsyid6CouBuiv7E4JE5c5/fjKPj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XpgH4yoTxymamPFX/k93duRv0x8BtUsm+fOhfZxyhY=;
 b=wEolG4QCQokux+wZPNvjd6u6UZBVSaG2VuVZSqnHLnuvygx5OcubJj7ROSUZlSnxzrXPZGLjCe5yXfzqDtUMD03mS75YEhP0qyzKLy6CKXFPiNXLWK42KVjpRdMnyTBQhgznmbe2p5uqHaHOPfbeIYQrQzmAgMM/euUx8Ldt4nI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:05:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:05:32 +0000
Date: Mon, 5 Jan 2026 17:05:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: Re: [PATCH V5 0/8] mm/slab: reduce slab accounting memory overhead
 by allocating slabobj_ext metadata within unsed slab space
Message-ID: <aVtww_FMnDX7o66r@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SL2P216CA0218.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af7f34-d09e-4955-450e-08de4c3132a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jHpgAeiSK1leIkP9xVys8Nsr6Z/Y97/k/YSZrb0KF3qx8iG94fP3A9/WXek2?=
 =?us-ascii?Q?fcL5dN1CgoX36NOpHeQ8e+d1p1t9FziOzDTcVvyTGCgAy/mEqkhllnZAWw86?=
 =?us-ascii?Q?lHsmtxa2rl50pstn5jrLx3iGYf6YiRpWFHbpr52y9U4/XzYoQh6D6OjeCqeF?=
 =?us-ascii?Q?JnU4NO9O2T6MyViZrvy4Wg4MGI2gmh6QV2XHOW6bWhMtQNS3JpbMkK+np0/8?=
 =?us-ascii?Q?kTJJJj0N0B52d0MoI0xlArex1bPKl+GlSP8t+SoAFGdYeEa+ZFxU0EgY8pHc?=
 =?us-ascii?Q?F5toRYGmgEfjpnV4uC7w/Cw+7TE/wHycBrLUZryCEwW5FXXUP/ZJY8o7DZ1T?=
 =?us-ascii?Q?VBuCsQ/OfUI4qJ3uKdxtlPPztPIeBUgAiOothmjx/o3l0hLLtH9KEP5qjgyJ?=
 =?us-ascii?Q?kGfVm/Euo51T2Nk8v2M2Rk4H1Mn5MmXsCqEr030sfDBtXyWQNqXlk0Q81XcM?=
 =?us-ascii?Q?hvdOFlYPo8Kire8FSW02JAxghBc7IM6QTOZxlgtHeZZmtsErhOTT3+972zo2?=
 =?us-ascii?Q?FRG6hOV3qAiP1K3JVtY1yj26abIx53KlEFZhUeyfIn7izQbrZrdnwPKhYT4y?=
 =?us-ascii?Q?mFs+EfzUrdAXWeIDQ2KttcRTTMxTZu7XTcrx8KcCuL/knDjgUmtoEiTcxow4?=
 =?us-ascii?Q?M+AxRl0k7KQ7ZncQKRpLZPL2yW2LWKW6yQ0N0waQKdeAZ6ss5cyHCG8Eb1eI?=
 =?us-ascii?Q?PtbjbssFttTNjZNgJZ4pkklKCRq5fiwbt68bdwzlftQYNLN7FLNKB4imwoFs?=
 =?us-ascii?Q?FvtJsMjNzXH9TwxkyTEoSaxF3mYtVmc8ZkQ4cXdWL6pxQkYS0cmrb/PpRfsq?=
 =?us-ascii?Q?j7jx+l8CQxajdklu6zh3AuPBa6aodes3KTS2dvGIGuQfuL7kxfwqkypKYBqE?=
 =?us-ascii?Q?XFiFp9oqF0y4mIeO/YQqwyUifNWDDAJiVzLseBXaU/aOcAbW9mk/w/Y5UtGd?=
 =?us-ascii?Q?y6Tv36RvQwBb7n+m1YRGJ5NKcgpFNPdhEPmULum8wvVgMjsBsQHm0jQdBBlM?=
 =?us-ascii?Q?W1elD7Rs8vbeylbfonmTtgm44PK9nHLkhX7phrHvhjtAIe2Zx0Bc5x6xMb7T?=
 =?us-ascii?Q?OWpielpl+CTjz82clqeM2osTAbrNn6ou80B42yTyhhrKX6AYnsD0yR+ZyZRl?=
 =?us-ascii?Q?5LGsxDnUuk6EUUNpWmrEVU5EcXa1is7ykNtDQLmLVMtFDNWreGgYs/e7LuwZ?=
 =?us-ascii?Q?DaT8XtwMWAtWwl5QOw4bgsJ/BeghUvNgiAkGoEHP2cKXD7tCVcpZCrRLdeY4?=
 =?us-ascii?Q?w0h1QK0niY/5vSLRR2zvIlz/ARZZ8a283JCSFGc2hSZd2RgBfvll6jM9kmOZ?=
 =?us-ascii?Q?7LY/BzeMxsLHyDure5Laj8vbT7SWYnyadwNbqkEEKc1LFsAO+5ftYtkMgh6Z?=
 =?us-ascii?Q?Os77dprQ/nlWIpZ8Ds6HLBe6kjiyYE27SQyub07600obiM/SIr+Z1sy67Jzy?=
 =?us-ascii?Q?7Q5xUtGAZQakmL0DH1GsCEG7Z6lJ0E+qRU2OupCUeF3BIESlTOfXbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRmtDZ9urvgGviSFbEBcVu9jIVRpyoaCIY6znB5/nVR2BBleLLSbIjTyuBXf?=
 =?us-ascii?Q?nzUp5/ElQw4wq8cwNdmjnDBzOk6TLP/30/qp5OUkFbidlTkTX000Z0aUr4eS?=
 =?us-ascii?Q?pEnhP7ECYLnqpo//qXmlPrzJrCybz3v+BW1rF3AZ01ajVfCLr/msnUyd5mxd?=
 =?us-ascii?Q?bBy3KYJONunBqj4BgXwEuWxJ5LeKPImKoxVtJ0bFeoj8uVLEowZHL17qDwX1?=
 =?us-ascii?Q?gSw/VAWYx4gPS11mgr0c0KA1WOVds9PKGJ1snlsQ6G+ULKygwqzLmboT44oL?=
 =?us-ascii?Q?btytg5g+ALbz0VTanZChVNPlggeKfR+45H3LgAHreRoe21sxmoMz0gSp6k0L?=
 =?us-ascii?Q?xv07zIY4gRFYkjg2a++YsAVHYOojz64jyTwpGVeEO7o9lKGdrbj19NcnxIH8?=
 =?us-ascii?Q?dFnBMNkNzbfAgV3tFaEWPlLBHZzLgQJmTLVSVSFRPG2JQn+25zaUiLPf4SDg?=
 =?us-ascii?Q?TDEBgclbBhpAEU/NlPeyzETBggRYHNPrHvSPP4nw7t1v0hBGrrPOkvSS+uZE?=
 =?us-ascii?Q?yE+eJhuXbAQRShmJMlxRrExGS4Ai01cVSlv77A6fTQ7pVenFwe3y3KDUGc9Z?=
 =?us-ascii?Q?8ayfOzOUG30XUfz4lk3+1cjU432MYS1yWO3bZwGUE8bSQWqC495OdEFCWOiZ?=
 =?us-ascii?Q?JwJSpRmnHxlhz4BVCLFELqxbRfFmlJP7UGOHQgB1HleOZJY5mJfRuPVBYyji?=
 =?us-ascii?Q?iZGXb+s4SF8wrpgEbszOmWxkaa9sqPrW4V5cvXwo0+hQPhTT3hOfdbP+ujZl?=
 =?us-ascii?Q?yK3nJywlf00N76C8tW8D9NSZe84bapzum7sF/shK4LHRwwL+KCK2MsZIoC/J?=
 =?us-ascii?Q?BuTrTsRxH3qGwZs8AThR0fGn+MMUh9cDu01cC5HWYfQfuzOmrhhR+Dc14Fqp?=
 =?us-ascii?Q?Zmac4lepy95DBTngUxxN7lIPsyeqZ5c321i81YACMpGpgOgaHwQgnvDRo9Eb?=
 =?us-ascii?Q?b/nMX4CE3qdYYsvmrow+6CvR+CpX8FlxsSkzNZGO6iCtToUMjmzr8AVzt9jP?=
 =?us-ascii?Q?n1bRoKy3OuzOzj+pTHhuvjkNI6vTkYFmXFRxaFXzIvoRLVFu8NN9YJjoTwDp?=
 =?us-ascii?Q?wKB5/oujjR7JZKEmQ409pleSfXVYS8xuWnl9CS8FoPB1kZ0c7sUEqiMegFl9?=
 =?us-ascii?Q?3+Mo3yZhECTJZuOaJ9ArRIgRFR37Sq4gY/2YXYadHnJ44zhicmY8hHmr5mYp?=
 =?us-ascii?Q?237Zl3Lzk1iuNPh3VOBHLFM1oG2njhUVXdWV9h0dyCc0nrPjfIQZByv/qjL/?=
 =?us-ascii?Q?w1sbszMBRoKHp+K1LsjpjK84H0kRTyyEXsczx+eBy2UEGB2ckkhbLqIYHLv5?=
 =?us-ascii?Q?c5opaQx7V1QpEAcCs1RJ/Y4R9R4//RndBOTEUisg3ivM3wBpDbrqn087vqKt?=
 =?us-ascii?Q?wxTSta1DDRTLCqPach7ltOSzMbaaM9lxOWFXy84l10Gx7p3azXBhlPcoJ8c2?=
 =?us-ascii?Q?y3zoUvUc3ifSEnkIegodgOhXX2NoRJtwM9L2W8TI/g60hc+BFWgbMq0Oj8yM?=
 =?us-ascii?Q?/7QemafrBqPHyF780LUKCkRdV17Aa6EFConChnfriPXtSwaE+og6fEue1SyQ?=
 =?us-ascii?Q?f34hR9ahbm2hrZjnjQjsEJjpueO2hudYac/C6JZ5bK37E3XsQYB0yU6BC6XO?=
 =?us-ascii?Q?4ZNc3mwQwiBLAgv8I2kZW5eWDLgQ7PWXF4vU/ajWEcwF8ZFjvCAJfRcPPwww?=
 =?us-ascii?Q?Y+dAnk2o61D1ifiIClw9ROWPpIQ/1X7m3KuOpGmdDenJRkWvOGwxnmeS39vk?=
 =?us-ascii?Q?UZfMHj8IUg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YWXt2oOiGEKiATajw+k1S4g87SC7XQPpvav1QOWsTXnHlBKH5MTJFUxMCGIZ/UwXQXXorRQJMQl3/1Dq/CVfQDP4/nwnSSS6SL6xQSd4PCUIWOp+ge+tLUrd9w9/QbR3i4MfMPxqsv2dXk0wxq5PV67a6ctSaqOcOi3gaOPPw0cDbNMeBBrRSVdUuxhCuBV8pfY7nfIGYTrUrDGp0t526K4Q/L1AyoOcApEpBbPsIMWbDla2PAk0raZw6H2fiYJ21hZnzM77MOwnchLKltel0L2EtVLQgswjQ7MbffKr/7TQVgEoW54F0USx+8Pi7EijqNYAZztw04tZvGB/+aG0/XKy1SYp6jTVj3Vu5HBmrd29GI2n9OYME9cIcYjI6j95L9lVNTvtX5c5/Rz6M8xo5PezxltGakjFcOHeYupoikXqmb9/ivWrIfAbwfV2Uo6hKItZtRbuUJWixko1LadRZzA3TeUYpVq60nbUGXpYVrgOfF7GiMHDO7SStEIPJSUqX23vbRlY+8lL8dZu+cQhlMll9z/SNkmfzZOTldSjfyTlAja6gNvEgFsXCt5JHI1Oj+6JnLBKaN4L/z/Rtd9B+a3KSsWnDMlUlwkBlfeqGWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af7f34-d09e-4955-450e-08de4c3132a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:05:32.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78Kbpmp3PErLnrBCFEqO1KyO5O6ogseXrMUxkLGB1x1wJJV5Syl3Z3JBzAVgrNA/0GPp/s2ZeYLIVWLYWFAm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-ORIG-GUID: Q_qHs2JWwSaGceM1bVZMTwRe5l7Ey_EI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MiBTYWx0ZWRfX7Ji9NMzHXOsF
 W2Cmag5itWJFNa9FQc/EXvenfmfGdsSFeaXJUBCASB+aJpFkav5tnwjSz+GSYI5alYyCEVIFlcl
 /UwS2ImSd8+HfOkCCQpLIU5ours+8JDw1VVlF/49ukT5U6sGASnYwkAVMQ24Hiaa+bovBeSmZlp
 RCYZYj3whCpCu82OhngVNapX3c2MgGCfxHfE9QynpP2Kp7cWt2mf6kTKGFWncftB/ccZYauUEef
 iwBfsxPTMGovcpyWxzR1mUiOPiM0LZVQrKodcBMbCUux7ch/bRjexjciAh1iBrpaQqEIbHaeEaW
 PvlbRqbSj67wQb9mRPsQgmKQDKVPXm5Ni2eeE5vZ1uaiYSLafZU8znd2z1vQrjsJ0UCmn/60lVz
 IZ8dYeV4xx4xYL6PYAtmnB0wcRqmny1cNma3ciYVl2HzzknyiHX4AZ95G+shka5rbiIgfkij2EK
 KPsi4EWvW6QjBYRwhHTHLE1/gMH1ENVVdl965T4g=
X-Proofpoint-GUID: Q_qHs2JWwSaGceM1bVZMTwRe5l7Ey_EI
X-Authority-Analysis: v=2.4 cv=QtFTHFyd c=1 sm=1 tr=0 ts=695b70d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-LFnYRDvXSHVyupbjlYA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13654

On Mon, Jan 05, 2026 at 05:02:22PM +0900, Harry Yoo wrote:
> Happy new year!
> 
> V4: https://lore.kernel.org/linux-mm/20251027122847.320924-1-harry.yoo@oracle.com

Actually, that's RFC V3.

V4: https://lore.kernel.org/linux-mm/20251222110843.980347-1-harry.yoo@oracle.com/

-- 
Cheers,
Harry / Hyeonggon

> V4 -> V5:
> - Patch 4: Fixed returning false when the return type is unsigned long
> - Patch 7: Fixed incorrect calculation of slabobj_ext offset (Thanks Hao!)
> 
> When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
> the kernel allocates two pointers per object: one for the memory cgroup
> (actually, obj_cgroup) to which it belongs, and another for the code
> location that requested the allocation.
> 
> In two special cases, this overhead can be eliminated by allocating
> slabobj_ext metadata from unused space within a slab:
> 
>   Case 1. The "leftover" space after the last slab object is larger than
>           the size of an array of slabobj_ext.
> 
>   Case 2. The per-object alignment padding is larger than
>           sizeof(struct slabobj_ext).
> 
> For these two cases, one or two pointers can be saved per slab object.
> Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
> That's approximately 0.7-0.8% (memcg) or 1.5-1.6% (memcg + mem profiling)
> of the total inode cache size.
> 
> Implementing case 2 is not straightforward, because the existing code
> assumes that slab->obj_exts is an array of slabobj_ext, while case 2
> breaks the assumption.
> 
> As suggested by Vlastimil, abstract access to individual slabobj_ext
> metadata via a new helper named slab_obj_ext():
> 
> static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
> {
>         return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
> } 
> 
> In the normal case (including case 1), slab->obj_exts points to an array
> of slabobj_ext, and the stride is sizeof(struct slabobj_ext).
> 
> In case 2, the stride is s->size and
> slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)
> 
> With this approach, the memcg charging fastpath doesn't need to care the
> storage method of slabobj_ext.
> 
> Harry Yoo (8):
>   mm/slab: use unsigned long for orig_size to ensure proper metadata
>     align
>   mm/slab: allow specifying free pointer offset when using constructor
>   ext4: specify the free pointer offset for ext4_inode_cache
>   mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
>   mm/slab: use stride to access slabobj_ext
>   mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
>   mm/slab: save memory by allocating slabobj_ext array from leftover
>   mm/slab: place slabobj_ext metadata in unused space within s->size
> 
>  fs/ext4/super.c      |  20 ++-
>  include/linux/slab.h |  39 +++--
>  mm/memcontrol.c      |  31 +++-
>  mm/slab.h            | 120 ++++++++++++++-
>  mm/slab_common.c     |   8 +-
>  mm/slub.c            | 345 +++++++++++++++++++++++++++++++++++--------
>  6 files changed, 466 insertions(+), 97 deletions(-)
> 
> -- 
> 2.43.0
> 

