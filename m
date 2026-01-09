Return-Path: <cgroups+bounces-13005-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600ED06DAA
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5ABA300D2AB
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFE311956;
	Fri,  9 Jan 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDDSZZYy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JTB9TBLu"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB633987;
	Fri,  9 Jan 2026 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925979; cv=fail; b=sr2Xvnp/q8/2zqJ3FyMHNigTdgGJuXWFloSaqw90IVNsnX3eQk4rVvFMauRS2tDFxU/SQOJQ19KpMFOUAyH98YYgty+ilDJ4HinjQCP7H0ixpqn+K+lJ12TcCyNIad0sgDEM29wSJ2PAeH75Kgm3JpIvV5Wtsjf5slk2Mij4w0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925979; c=relaxed/simple;
	bh=k49+2jjRK64r8mSOwlkScEZWKqJY9zJvwVG0b3Sazxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+swIr20h2OPuEtX0VxQCktot7l0gxb6Z9dzyK/ZwWXcS6OQhqOCI4NKZq/mC1E9vwkcg6H54f9d9HdKT+yHTGXSwp1ekOEn+lrr645bZ892OgU3W2sPb+BIxFEUu7qWlF/DLRlC8rtSYys1PJIHbrluzhVVd8t18RyBZw8a3b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDDSZZYy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JTB9TBLu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60920Xqm1887660;
	Fri, 9 Jan 2026 02:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W/FbAqnjn1BV35oE36
	Z09Hm4pUWzdgjQomKqrjqVzLI=; b=VDDSZZYyyW44ZwF0swam4NPnzl8o/S8oka
	ry1zkC2+7c7xpz2L1ysVcwP6NpiEEb2HAahbeCXE2+fTgqeM6ITzi4DEmbkUascK
	tJDns1MhesuE/w1LvKtkk+QF87eHChSZMyTdqy0VTTUwJxRWuX0pXaw17KTqyAUl
	cfnr0wj9NQh0Dw6z2PkX9cSmx2anb4Qros1dlKe5BrJqGJOleuZVyHnDoue7r4tC
	MTpRbFuMRyBQubkg7ehU7NV0hIzD6p/PguFm0lmQFFfM4VOQZCnQyQYxw2Vzj9T5
	feRPkuxFDVzpCbhjZeDtcWFZjjs3U3iaBtrr7YX9K5+iUFxNSwBA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjncg06bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 02:32:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609102uE040098;
	Fri, 9 Jan 2026 02:32:22 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjnv6ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 02:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzpzhfEg6aLWGD5GcmSC6C+0rGVDseOROyajCHX/2PmgSssKNAJWyl1CvRBC4QtIhQFiOgTtmyFEz/3qSHxyFQazmxAtFMCbVGTUruvHLGWKPyJIX9KRD4RFVGl/wuoWuR/SE9pbhKFS9fMj5Ny2CjfPltFfrAOCPC7AF8eQBBObm9b5SQPO3mLia1pMj0IO9tAfmvSYVTV9OaxgJIy2Ppf+Mcs3AL4D2C6yEU1cjU26BaR1I3DWPgduBhGpiNxTJk7eedPyQbG1eUt5NBNYDkVvsZDfGQcVESfRq0MWdsLs9sCTIoPa1nfZenqC4B5aHRpcKxzjwuL+kVUsa1jJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/FbAqnjn1BV35oE36Z09Hm4pUWzdgjQomKqrjqVzLI=;
 b=eIxqae4Avg2NAbQ956rYbNs6DnyH2TBry5JN327klkhKbDS2ahPBlavI1QB+3ASJRuHkA7jCWJFS5xnNG5LYYJSei+vEbRwfrDdjLNOPrHBItWMY76pziQwwEc5t10WtK10/n9mcdW3XgsT1LCR/NDyir6Za98bsAn3nrWBsn7DlIsmHtDgz6S6NjjwzGA/ExLFzWYCJ/71S7ZC5Mo4eLfRnIpLu4nmzWD2Q1wcw+EcSLjBsXWGCwqucXSNV4hD8J0LCMRIjV6fshBXsSXHvcN3zcmbD9K/81hXNPWyCDEEhgnVCytw+4GADdq+K4YAp+fzRKPZk+FuOalOyblNwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/FbAqnjn1BV35oE36Z09Hm4pUWzdgjQomKqrjqVzLI=;
 b=JTB9TBLuud5entcni9IiE8IexVNW3B1Ipcqu7WvBA7+tH0v5LxFpmyOjT/PgaefMYrM5/aeQCdr33Bl8lksMyzMWLKa5KQVm/Rd41DwfKnR6kNoK8eGr/zyiSsC6LEB5McwWA/kqLqjPqwmoJ2BvgACw8z/JeP0rbcNrrFL92Go=
Received: from IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10)
 by PH3PPFD7011BF84.namprd10.prod.outlook.com (2603:10b6:518:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 02:32:19 +0000
Received: from IA1PR10MB7333.namprd10.prod.outlook.com
 ([fe80::e8e9:f35e:8361:ec06]) by IA1PR10MB7333.namprd10.prod.outlook.com
 ([fe80::e8e9:f35e:8361:ec06%7]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 02:32:19 +0000
Date: Fri, 9 Jan 2026 11:32:07 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Li <hao.li@linux.dev>, akpm@linux-foundation.org, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aWBop9PG6s9WVp5D@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
 <aV9tnLlsecX8ukMv@hyeyoo>
 <7uiizca4ejiqw6zegjwmou5va4kw7na7wivy4kxebrju7dsdwo@5brr7vhwf5oh>
 <aV-Kn8vfyL5mnlJv@hyeyoo>
 <30ecc144-ea2c-4259-afbf-3d96849aded2@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ecc144-ea2c-4259-afbf-3d96849aded2@suse.cz>
X-ClientProxiedBy: SL2P216CA0153.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::8) To IA1PR10MB7333.namprd10.prod.outlook.com
 (2603:10b6:208:3fa::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7333:EE_|PH3PPFD7011BF84:EE_
X-MS-Office365-Filtering-Correlation-Id: c166a81c-392d-462f-cada-08de4f274f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGqv1WoTBNuz1EQ2UWwQ33+MBpyYfIDYlX4MARX2FL7d5ceyIWz/i1WWTM1q?=
 =?us-ascii?Q?MmOejGrcWgnVj+OZVjKlBFNhv4mr4DBEs+Sx1c+VuRdW9zI+UKjAwN6vPt77?=
 =?us-ascii?Q?0THYuwbOMgjhrAKfaNLjX6Ek9xwsmLyphjbht+CcnlvAmiu4m64f+Ia3q863?=
 =?us-ascii?Q?5INwCVa6/YNhhSmDQVD8qo6MrDPs2gBh4gfSKWc06pPnX4D9GNJFhqBJxE+6?=
 =?us-ascii?Q?oShD8YcmgBlTaxiMPGqyL/ejN27Pt5GNdgXCk8JgcyT74lEPpIYUOtD2aYst?=
 =?us-ascii?Q?oiX9cGevn16MfCi676Cp9eClrIYkhdCxezrguUmBwCEBr/nYFhViZLKpQHVk?=
 =?us-ascii?Q?XL94yYi2MZ+ibCf5uamBL8A2qMUxBW/RU4nsTpVmZkYtkCxAjndGz2kWcoNi?=
 =?us-ascii?Q?vdytUJQI9R4s1sdIm6JpTJRjtu4hFDDzTdQWeep7wRA4YpJcn5U0JCaO5Qcv?=
 =?us-ascii?Q?2qmAb0v8atlrijiPAHM4MrcrCZMo05EN0Bd/Fg8WNQ6Gd9wse00cBMuUGIqC?=
 =?us-ascii?Q?WhVgzpryC/PlwxlJ8FhbiwwKoeYtZrbEf1/ahC6bcfjQ3tth9ogN5i27I6JR?=
 =?us-ascii?Q?RT1quYLEwaeMYr/30l6dNPlRgPIrOhuYh6QwEx/d+qqfo68xuxxexAFbZ2Q5?=
 =?us-ascii?Q?ik5XicSp2Qcr1tHFvhT82HxLqqiXTnFa3e0S2zlRe3ruEKkqAD46Ki7onxfZ?=
 =?us-ascii?Q?MV40mj8qcb2NnSZ4dKd0rX2y6XWeERDKciAIcq1mk2fGj2Yr8GTQMtnWNHQM?=
 =?us-ascii?Q?tMdpIuAU1PgimSES56uG05zr3G3hlBz+zQptjkC5irXmEynrpp4sU2F9JNUa?=
 =?us-ascii?Q?cHH3Gs3AOqO+gLDXU9ChPDDhym5AHEYWQ94jFjiGo8XZBDf7Lx3B076Uy8o5?=
 =?us-ascii?Q?DUZLYSHHQYVkOpikBjbX0WKQpJZ4xOYK8Tva/ojjHoDoDbcNoZV1JASS4nSr?=
 =?us-ascii?Q?XEkYVZQ9gmK1MXgZ1bie1LbOsPaVrd6wWSGpjDIfnZy657EHqJSdyt/f8eM2?=
 =?us-ascii?Q?Kt3IPDD/zDJE/y0O2nOXuNAqZOwnn3BJOPsWBmKC0iuskjfHtQRJH0hvgkbt?=
 =?us-ascii?Q?gCtrwmuQH0PqEXL7EO/xx7VgLwXQmrAkmHroCh90jt8ZNp8YtH6dd0G10ovc?=
 =?us-ascii?Q?F0bl4DQQVMFYmqzL/KPmhPEelLDc4WDrSendIc3dDhCAwC2bhKQXGH31ipeQ?=
 =?us-ascii?Q?ppaefD2NCHMcJ6+f0TJ8LDaAg99pHmu/L4TtgNkLH7f33JHki+9e7XAnqUkz?=
 =?us-ascii?Q?MPQhbpfV9cEhO/bSw84Sqqz6DAi61YKgF66aMOaqjmB7igf8ep7VPNG7I/Lz?=
 =?us-ascii?Q?/NVYM+NjhNaV9abZt+2KXt8pZmuayrBzT2jzNUTFuG8S9gnWCnxCcQIIeD4Z?=
 =?us-ascii?Q?B6p5hhB/NUXyUSakVCSb761T4rhqh+bFgbTzM7rvNvzr5yRIi4bQkIh4UYVq?=
 =?us-ascii?Q?ZG8Jj8Zutr5hzbeeMuqJ31arQxfnEfS7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7333.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duALIIrD1i8Q+Ft19WxSDqC/h5Rqg303CnCRGdJOWFBcCEnRdJ3VL6OxXA+a?=
 =?us-ascii?Q?vuCpFldfzL81FRyRVTn2FGTEcyWr9r+C4OtRCi8ucK9wUwRBVxc/EpniaS34?=
 =?us-ascii?Q?BbLDH2pPydyYmtQUiXr9vSQT6zWZtKp/Hr5HujoSWNbj1pn8y9pvcyQDs8Kf?=
 =?us-ascii?Q?voPzFLcpiY8XOjsqxk7zhlszqgmqMw8l2hvXi5O99N4APE8LMAaj7Ix1jKt7?=
 =?us-ascii?Q?cGhI2gMQEk/qDqxPe7UgOU78saQApWLgxBm3JDsx1wfDJHW32TnI2tbaSf1t?=
 =?us-ascii?Q?ZZN1pvSLMjbvntj6912kRqGYp95G9j+ma+fp6S+p9Mp9XcNGATruZXLfj8Uk?=
 =?us-ascii?Q?0zmoBfAm2qKLuyqKRAXk8NKeBMsfFYGE1BtqM9qzMH60Mk2V6yqi+oIOEH92?=
 =?us-ascii?Q?osVW2CaCotcuOkeIHBhA/vuRo32jh5MuDNH7hPJtxD69UZR+25DKsYKhDH5V?=
 =?us-ascii?Q?q13Xxp3nWgyUcItoyR4AwVWsVhLhgqEiE3oqg19SLdWjE2U8Es4MreO3cGaC?=
 =?us-ascii?Q?mtH3DakDg90K/ufk1eQnN8szZIooj4elDonZoI5UHV9zvfIMgEorZKPkwX0h?=
 =?us-ascii?Q?jhmHdt6e0Y2LcAmsBrymwxrApxfNHevmMAKPyBeOIe8WNmyos9hrB7JZtsA7?=
 =?us-ascii?Q?3mvePoidlFwzd+/QrJSXCr7U4NWiLhcDjIzxER99hLPcvfs8R78JMKhBSv26?=
 =?us-ascii?Q?jya+4pEI7hKoRDCfGBqrZ8s+52iWOURUs1/Z1EVzAp8J5D4ez+I3TGR6/qzm?=
 =?us-ascii?Q?u0GqGLNA8ppQanUR4OBcIW3P4lZmEjoX3B+hZsAlQ+c33tlts1wU4R1kc5JO?=
 =?us-ascii?Q?dTDA6k615FpdghH/6N8IgyoXM9D7lZVCT81TXXsj4AYqg1i/bGrmMwUHn+mZ?=
 =?us-ascii?Q?aWzDhWzygdq/FG2rZVzuny8mfGDZ50PCl/06xsY6Oku1RUGSNT2SGxGTuCDq?=
 =?us-ascii?Q?IvoHOH6P1VUiofBbMaKOb2eQFdYZXaZATJ7OzohhvNA7rGvtpKBAewRdZmce?=
 =?us-ascii?Q?dGHF/cu1+bNjv7PXJ2i6yJ9gbkqJil6lCPlWdIEj6W4WV2qDpSMX9EKivUIM?=
 =?us-ascii?Q?GstBO1qb+4kkRwk9xUkB+sOQCxkNExzLLgZ4sCssFi3iqLP7Nv+AEJWuoNN2?=
 =?us-ascii?Q?L73VcnLvlDIKoyqmDZvUo49yvlZYkncuVNXu3LFW1U4QPwdmSGHQGKpl0C7h?=
 =?us-ascii?Q?XMa0BIUQvSHNPbRsZrp9nKeHpGKfEurnKP+PAxJVlBDUUSmjwN4pf/s9Z2V7?=
 =?us-ascii?Q?QyeiKmldyRU301u/hJktOfodV9YzXWjKSiZWfpM6Y6jUhpHe4CcI28nY1Brj?=
 =?us-ascii?Q?mJ625HtqdxbXclBdztWSwidRgALVNvwWY/iB3dbaT4VvFeBRY3yyVb3v3qro?=
 =?us-ascii?Q?aZ6GBam2GYmz4eWqcwlTpqLPYMRxOo5Y0A5KMYSNJ/fJXsFCHtgYPrB205nU?=
 =?us-ascii?Q?oAi1LyYsG+OIuSJsDfDhesUybQ+6fba+9JGM7erYHwuE5eLGsR8LKR59qDup?=
 =?us-ascii?Q?S5HWSUMJVd/wuOi292F15MfT7besVZ86RuOUojy85SWxsspfXH/dCJaUNfc2?=
 =?us-ascii?Q?P1/dgJOeLXJnt5rGDWxTg2PmGq1ekPd/zOTDI8eknp9HLVafflB/zab03XZ1?=
 =?us-ascii?Q?MVLlNI6lesTY6JkqqPSKxYUWug8iR2YCo1ltuPDG4hF7ev/woG62Lzr5EQbG?=
 =?us-ascii?Q?lR1nRIdiQ3xcX8463LTTI2W2eZtZwglVP7PgedJ9PIHzFZZ+lELte+0EbLnj?=
 =?us-ascii?Q?U49EVAuFwg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Zfo3vgvIQBGI3s/nUNQxHMuLE/Oc6Q0KbFgyzlskj8vWb6eXVVJ67ppw6jzzqp2Ej3qW+UT8rEZCUXIj5OPa5vc7uHaAVGK3nPr1YGLx3iDVDU4VHJsCEJGWpzRG6TiW6UJBMhRAxPyXSO/+XIqyi6ADCtR/JiMiQyxT2i+UYewPOVGOESiDFlcVr3Wwz57bLYGlBo/hZgsnPPItHZrX+AocGdAatHgUlO+DAu5cEWVeYrOho329LVqXjNapx8ZlJUZV+Bk+dQ+zCcFWDX25EToscQEGct20QFbK7hq8dfu58efFReJE0EHOvfoMUZE9M5pgQTN2ES4gsS8ru11za4bGZONAw3QtBk+Ev+pa7NyCjZ2iYXK6Nr+GTMHnYMsFUEUCQUifEpb1qbv+7r+zuujN7uqclXQtfyHaYPgbzKw6+kEg6LhcwbkNoipl1y4Ikf8z5tPEqVljW4XOl0jfHYkTMSc8Sy28OtZgwvCQwTtAaXA1gc7QckZpsITFGQAjSj2cKiZh4QRiMm/1qWL1KSSOh0bgZ1FW2M+2Bawvpg1+lbI45ygK6F+Yz7Xfnl8cNaBd4n4E4dsweufU7sLH2Z18jsFl4pHtwpRstXnbLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c166a81c-392d-462f-cada-08de4f274f4c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7333.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 02:32:19.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QA9bNN34HBbLdVFn+8+DMsRsd8cMZaR0xCevGaZ8/UaUZcXrmMxcDKbc+xt7RLHrjMwnBWA9qvjfF0EgJlWF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD7011BF84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601090015
X-Proofpoint-GUID: CroXX1_pLqsWnEtkLj-cqbTPhWaY4OWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxNSBTYWx0ZWRfX2eYrG1MEA7xp
 QrNRIsIUblToORamJC+73kyzaxH05V6kJBoQMjFcA3Mru3uZBIu4wleATa5TRrwdqOyQ0xUhQYX
 JAJIhab7yPK/iLFi38JZNfv8N3v2jZ+wzPK1FeRxeZn28c8GNd8JQdZMr1+p18pKLpqX2dkTxQD
 7M4n7EYLT49eHtcfDIOkGgsvCXjqLJ0tyq18KunIdbqGfq5X1+5w1/CuvLY9M3IaTbOluXUIqLS
 gLtR59ucxrUI3bGm3ghKVVt14mzQRUMhVGQY3yZGoXdivvF0idZYnA1vET63SbissVBO3k/Aalr
 jtwmfiaMjsERdS5xSDC248DsZwDfmcN53gz3gA/T+XGjOggTucSfq3f0g0aG3lmM2/PaaFgZZfp
 OejHlTJTxyh5zRPHbTkApHYr4+drpY/bZda+19FaOwG67gZGttZ11DaFJqXhWjv3wBAN6ra1+9A
 9/5t3wvh5aXQjWYoX50eiYAIoPNyNFcmwP5xq9fo=
X-Authority-Analysis: v=2.4 cv=AYq83nXG c=1 sm=1 tr=0 ts=696068b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YcNhsmij0pwKIfmHPIUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: CroXX1_pLqsWnEtkLj-cqbTPhWaY4OWZ

On Thu, Jan 08, 2026 at 11:52:36AM +0100, Vlastimil Babka wrote:
> On 1/8/26 11:44, Harry Yoo wrote:
> > On Thu, Jan 08, 2026 at 05:52:27PM +0800, Hao Li wrote:
> >> On Thu, Jan 08, 2026 at 05:41:00PM +0900, Harry Yoo wrote:
> >> > On Thu, Jan 08, 2026 at 01:52:09PM +0800, Hao Li wrote:
> >> > > On Mon, Jan 05, 2026 at 05:02:30PM +0900, Harry Yoo wrote:
> >> > > > When a cache has high s->align value and s->object_size is not aligned
> >> > > > to it, each object ends up with some unused space because of alignment.
> >> > > > If this wasted space is big enough, we can use it to store the
> >> > > > slabobj_ext metadata instead of wasting it.
> >> > > 
> >> > > Hi, Harry,
> >> > 
> >> > Hi Hao,
> >> > 
> >> > > When we save obj_ext in s->size space, it seems that slab_ksize() might
> >> > > be missing the corresponding handling.
> >> > 
> >> > Oops.
> >> > 
> >> > > It still returns s->size, which could cause callers of slab_ksize()
> >> > > to see unexpected data (i.e. obj_ext), or even overwrite the obj_ext data.
> >> > 
> >> > Yes indeed.
> >> > Great point, thanks!
> >> > 
> >> > I'll fix it by checking if the slab has obj_exts within the object
> >> > layout and returning s->object_size if so.
> >> 
> >> Makes sense - I think there's one more nuance worth capturing.
> >> slab_ksize() seems to compute the maximum safe size by applying layout
> >> constraints from most-restrictive to least-restrictive:
> >> redzones/poison/KASAN clamp it to object_size, tail metadata
> >> (SLAB_TYPESAFE_BY_RCU / SLAB_STORE_USER) clamps it to inuse, and only
> >> when nothing metadata lives does it return s->size.
> > 
> > Waaaait, SLAB_TYPESAFE_BY_RCU isn't the only case where we put freelist
> > pointer after the object.
> > 
> > What about caches with constructor?
> > We do place it after object, but slab_ksize() may return s->size? 
> 
> I think the freelist pointer is fine because it's not used by allocated objects?

Ah, right.

Nevermind. I was just confused while reading the code/comment.

> Also ksize() should no longer be used to fill more of the object than that
> was requested in the first place.

since v6.1, yeah.

-- 
Cheers,
Harry / Hyeonggon

