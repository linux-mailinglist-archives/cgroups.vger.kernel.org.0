Return-Path: <cgroups+bounces-13149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A139FD18FD8
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CC1430039C8
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B07348898;
	Tue, 13 Jan 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJtx9Miu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0OCAWvk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E38281370;
	Tue, 13 Jan 2026 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309328; cv=fail; b=C+e6KUHsrCHJJ3zF9udbduG2u/dyj7P51gATQLjsaREGbJcmO5kg22SdYF0CQJUi9wUH84SqtTNIHt/tOOvnixi/4nHLyoednpmB3pfI4DIeVHk2HB7+NL71BJDieUbwbjaHtADK2kM1oz9feD44feII4PHIvbKy0QiOCnOAT9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309328; c=relaxed/simple;
	bh=NksENjaK+YCo0feISkbPza+rNMaR1MnfMouV97T3wO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lC2PMlABRwtNcYBwl+f92rrBgCeCDCIDgV+gaF/tRhH71wcrH9VMhAyjxJx0KLQKXaPVHjyTS4VEJEjHtRpdxLqvDQRdGUzR5Rw6a20p+mSbTbmvC10NTL9yn95fVAHGhhlill27QjRkLtEQIFWKXqR7lrLsb+46UwAD1ZOPd0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJtx9Miu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0OCAWvk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1iFpE2685997;
	Tue, 13 Jan 2026 13:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6z1lsRiEv+BN91aunl
	lEmXAqJjXxFrrIQsx4GLnVtqM=; b=YJtx9MiunWSErvj7olySrjOvDatfI4BlJ3
	LPsvapS7Ic1Kf6TPrD4ekI4kac5nIgZykztcMCJ78sRX0hR/vBHSQCzctZ/0SRk2
	TJ8nyPJCuHQ8t3XqkIHCtbvsEdoByBWsaOhQq3Dovzqx+PuJ0kXzYDoP5xAy4nD5
	eudg2AsQuQEERPp+gxnfNzuHMyY4kq7bZ/6uMKGZH64iqHOWlyeGRGeWsHJK5ymp
	SsXEodtspEimOUOfb1Lc+yT27glvjjJzoisPV8Bk9AJwoLGT/fvDFgiNLWg1sEQD
	TWAne3H3OGEJ77UKTQK3o7P65JZysEGxu7VcKUcF7KRDkkPnCqsA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb3dd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:01:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DBWGxU008377;
	Tue, 13 Jan 2026 13:01:33 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78eyt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN9vTDwtVAB5mrMPficXsQ4j8ZLQze27tW0QSUjLrn6pwbW/fHBSt5vM4Qu+4S2iXpQsitecMSAAy02nRsZgIkbJzJUElK1Xk2uhpaCdT4h68ORrvNOIhzOnpriYK+vevUfZhbu9m9aiuL9YYLwvCidrOCQW9Olpuvy2/PczV+zo63Tw56wkiITF+FPDxXdRbkXy4hgTMlR1nXDaVPMeUlPeIL3vpdKUd3QfR9j9JaenlaSj+scsZRcI6cNg/yNoiJcxOowZBeb2AskTXTAILFSHgdYzcnwCwtzztrTGYWWeFWCv4w612XCeVrA1ZmBHbZgergvKq9jVLyC2rrYcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z1lsRiEv+BN91aunllEmXAqJjXxFrrIQsx4GLnVtqM=;
 b=nT5fM3UnyrzWFQwrD0T3tKDzM49RGsFDdWS62o7BfNLXr5VvGDYJc0uP+eg8m9L3umtheuBIyyi98ATDRkz4vgcCxs0YX780TZTzMrqa57R5a9zspEQVaS3jHUU93VIdND6Y0JJ0NbuwvgGKfStv8F2Asqs6FTR4TFx/IJc5kvRFw8GM0mwfpVIAYrdZm6gDxbEEHYoxtrQL5zYNPo/16BfvjdftY1G0R5eH2X9rFWgDNfvYZi2GYaaZRQtQM94OblKflh2m2rLLB1gM+ePQHJWTrmo4A/qAJt0u+XurQG/D4qLiHylLMzeGs4Bks5Ot92uPhBwVTsNy+t3pwEdL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z1lsRiEv+BN91aunllEmXAqJjXxFrrIQsx4GLnVtqM=;
 b=t0OCAWvkCg4spZaPJ6P+pswI0876HIsm5KK0ivWuPF3+tcZW4zT91H3KvKSXvhI2G5rsAJhS8nbR6RRZ0ODgfKYCApo3h+ZSWTmx7u+ryCJNoAtBLSfZQNXi3XJ8FZ7X5Fe5btTxAihfxONVt+rakVRGAdoj8rl31jCBqVQfu2w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:01:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:01:24 +0000
Date: Tue, 13 Jan 2026 22:01:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V6 9/9] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aWZCHIYsFSaGzRYu@hyeyoo>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-10-harry.yoo@oracle.com>
 <fecd4166-618d-4d69-be02-d9b3e8f0f271@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fecd4166-618d-4d69-be02-d9b3e8f0f271@suse.cz>
X-ClientProxiedBy: SEWP216CA0144.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acbbaa0-4291-4f98-3760-08de52a3db39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDkmRSuN3U+vbgwR4uGVDFwTK8FdxfN+HLtrqoH73PxHeUcyvyI7hD3Ulh1R?=
 =?us-ascii?Q?hBMB7ps78MMT8REUg8LB9GodSCpjot0O3IdJf88e25t1FatUa9RXyifa8b3u?=
 =?us-ascii?Q?vGU7HFmA5OldQG4wJ2Ge+onvZRzqxf13TREkwCtpdCCWegSMj36oVe1UqIUj?=
 =?us-ascii?Q?dr54GCJ8sQsAkXJwkZrWfo+6GbofaagoulWHqz4EFva4aSBAGXqkiruNP5bE?=
 =?us-ascii?Q?TWcPSZENp0BufizAmtXrEn2soPt2TE5jBC0+USxV+3dpLbja8Y6DwCM14GmQ?=
 =?us-ascii?Q?V1EgsAvDE+yOT8Gv28uUEqg8NMzY04ygCFSzXTbOetqtZZ++ct+DLEi+6qQn?=
 =?us-ascii?Q?FS2FayeIeANrXTkiTDgIhN/+u4ZVtNvrwuXIkRciuFKsbkScizbkdiX/cjbD?=
 =?us-ascii?Q?FxcFCi5cEV/vQBycmpy3u/3Y9M/y0NPn+3HbW57LV+CFr7mkIv9m1D0B5I6E?=
 =?us-ascii?Q?MXQHCFuIoboE5LYYJx6Sal1oqlOtl5SLMYEXkPG7T5uurbfK07ajtuAc+A1z?=
 =?us-ascii?Q?S0axlevW1ryo8iLDcEZ2X+kogB7eHtZWj1SZM1gbgtiAh2UHVLmMm37diuD3?=
 =?us-ascii?Q?z8cSvNj5q1jmJvYjpuY++DSgLxzvH4wkSIOwmhamd0yGf8NbuQSNj6kCMu5L?=
 =?us-ascii?Q?hWvsylwkwhj3EJk/1xezuwnWMZRfIgnKpA+Wg2KL0Mgrwa8/EJ8oCL6XLB02?=
 =?us-ascii?Q?huzK6Oxjr7CgRHbXfVbXkJBUv0p0P1bvATtd1sFI6559Z9WAPSrVSqe8+Jdw?=
 =?us-ascii?Q?ryID2mtwEWJOFxnhHY65WYE36mpY9/jsZWUMA4CDC8c8TuVDKFUz+XzCTJIF?=
 =?us-ascii?Q?ZbxQit6+j4G32Se+mtJpjn359QsZJrryxjPXyrqS+i6eN66MCqFAnqyuc3NQ?=
 =?us-ascii?Q?qQtuM2v+UvYg+4u2dk1Y3xBkj8IZRGX6TCPjfYSHSbkAtpnrIrvH/+lOuNCg?=
 =?us-ascii?Q?fE+4p3wJ96K2iAMJx1fl2eoEaIx5a1isz1mPQJZgJ8QG29SmfPeCYf5DyuRH?=
 =?us-ascii?Q?FbQJa9O7P5+EHXHyhzFfPOjO0i481y1mCgniyoF6tR4mgqKzOCmJw00awfY2?=
 =?us-ascii?Q?XPEvKWZnXWq4beihCzcTZ6ajJIou5imhhLeh7jm74KRU5kVBC8r8v9Ju43Td?=
 =?us-ascii?Q?g5PymGl7bRmdaBH7o1AoE+GwcXTZ7FTv5APOS5hTY5BFqYUecnpDKE6R9Gqd?=
 =?us-ascii?Q?v8JaliokyECAA7Qd1rolyn2Mn7hspKOx9fXi8Bpf+DR9+IQ4Wt7T9r1Bmlkn?=
 =?us-ascii?Q?6ye7i1Au7MfX0z1rVY6ORC9rlPHVMAgLuohQLZaqbVnA6IFoIp8MF/NIOjfQ?=
 =?us-ascii?Q?oY1dKHtSJEr0Ed2HwmTgBfyNzxWgUYnrxg7hdwG4pvs2f3Ap2Tb9qyRht/Ld?=
 =?us-ascii?Q?nqWFkuBBDKfW9BVwX9VGHlFU5QXFZigwYe9ErxYqx/0cMhNpwcyDmSM10P9R?=
 =?us-ascii?Q?nAruP5k3KbQLwOvxxeZjjnZL7eKZ/4Mf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fznVpOMGuQqG3rgt/0CIZvJr7ROnRopn1TzZdHps4JrESrDcpFQ6ozj9tGvJ?=
 =?us-ascii?Q?T8R0d5r51yTqS+9jhtly2vKeOb9aohjsbcBY/cUHWvLLTAwVsNPXEe0sC7xZ?=
 =?us-ascii?Q?0siDyUJsshQprIfF1cK7kRUNEnBBmQhyNdPIrSOdi964mzGcg570OE5G5fqq?=
 =?us-ascii?Q?XI68WEkXrFP+lLnl1U5qju0XIdaaBTPggWsjJv2PbgL4DsUuDmeycq9w07bN?=
 =?us-ascii?Q?qQqeQH3VBUda7HVoupnc+XfRcNVvnmbNa4kCRqxP+3QZgU0TCI3TsxuqTsIb?=
 =?us-ascii?Q?3X22/Z3elF73A/pbggcO8DO37ez5zNBkhuAtEQC9rMK6k3gGRXEeGYYN0R/C?=
 =?us-ascii?Q?6Xtq316o71OOjXnnkT+AVHwD9+0Y7khYFvmEs3zshj+DWSc9ipX6MvXErrpO?=
 =?us-ascii?Q?AlGL1XInr0kirK+BN82c5ET50IclEMmVEpywg8aup+2pte5fXmB2cgiUJdya?=
 =?us-ascii?Q?Ky5fT7xIsEff49BGgMUljDyrZNm9Ayjya8OnONd3cRI8r3M8F3sMb1bLDtJ2?=
 =?us-ascii?Q?D65nlBhpxLn1ewkVMn27/96pS9rhey4Mkodk6AGVBdMFqV9UaiFrQ+X9mKYa?=
 =?us-ascii?Q?cHCs8TBfd8AJMiT0cgUdJyrNGtgzr1PAA3xkSrrdCrjil9/CXqsBTvdnknL1?=
 =?us-ascii?Q?FpgZeMNLSIATZ2OGF+VPe7ucPBJQRzFZrcT9cobsElsKcc4HpM90E5UCPMVd?=
 =?us-ascii?Q?gOjAvxD1hb7ApgT6hJ24ZECVzf0yS+W2z1Jh3ENobeZlwqOzDXZU+fEfveaH?=
 =?us-ascii?Q?ylBhp5DR2fgBegMcQ+fgeZZ6Zmf1fd0t12SxUidQHVNNzlgHgYQ48u1qb80F?=
 =?us-ascii?Q?XK7J+BdN692FBzaLp7FzOMYcM3kqJZ8ROOCUdw7RcLgx3c0SZfuWCWb5LkO/?=
 =?us-ascii?Q?q+cPYfPo5OzAQm5s070ZrSHWm/SyKjWzgK2GSPI4QhFwOwlNwiH7uYOh2nug?=
 =?us-ascii?Q?0yGMMzZBfl0LYfsxn5Cq4wSEwObH2Utf5LnFiz98mOVQjMoOsaxJGOXjPrxG?=
 =?us-ascii?Q?2OAfVBgA63RwYd/ZxTL1ztyka11tu+iipjD9ARnjUYJx90p9MUPQGM0UJ4qH?=
 =?us-ascii?Q?ow9WOPGSd0lnfeupl0uhF+w5wSHI8VwqGtJ+2Dojtz+mdcXCRsgFPLDMr6a0?=
 =?us-ascii?Q?n3Ovv2Aizalbm6BiiGqtwFdFIqojORYPTVi0QRssF7jmi8PSn8Rv6qoudgJ6?=
 =?us-ascii?Q?j/m1H5rgWcxyRg7mlFInf9205r1wJYiGMDmlo12voZCMDkRu325tvcJMiejD?=
 =?us-ascii?Q?fKSmflWLMioNjFoRn0tfzxtKq4opstN1ImEFLw5CYBgMkvCUDM5QyWSEbV6U?=
 =?us-ascii?Q?hsvoKuqs0CSaXPXNCkEbe0d3JF27643+5IRTQ1Cl4nVyu4omtxgPu0X6Uoi6?=
 =?us-ascii?Q?IZyG72d51UbQ0HZs2nbv4DqoqV/IHW3oqgeqatd3Gc2QC6hDAm1r73YMJJ8A?=
 =?us-ascii?Q?Lh//pWv+h70zTW4NWeRMOKYhWLvITu5FAm14nB8eDJL8ZHI9y9/sIERoqw40?=
 =?us-ascii?Q?aaOrH8w7BA5+VT7dUMiSGNscxAj+djNpCOwnAlMm1N3OjVfNf6mdibNlLI1v?=
 =?us-ascii?Q?DvwjFVnXiPzr/WRDl7d8ddR3kTPBSmD8SqR73qpfIEvKWXSjKy+i+7Jj0nzo?=
 =?us-ascii?Q?7B6RY6xEwGaNcCDTkYf5zOzM+E6gE1kkok8bNFTDDKISxqNNhdbRcllYuroE?=
 =?us-ascii?Q?L/9c8paaj76Tjtc3P/WqcGAVHrQ65LPqjxIT4Gca6/b825Hq+gkeaa44cIoe?=
 =?us-ascii?Q?1g43yGAo1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YKU2hSLlJMe9ooULppgZUxJnVg/JfTKzGqsDgEE4jpzHL4VevWyzqEDDW7IKxVopS+1MnB7Jo0+17AFfH9NbTUsafidq4svz+nIMKwWp6Mi1W68HpRntb1hbTvT/uwDkuoFcC9cmLVjauKKW+LccRggSp3hjKhMyPGw5kNtjMDFHVHHRP10tEZdWbZc1CcNR0PJI4E1sdqAc2OTDUqMoW3pKZV71WDwipdJ/GeIkTrGU9A8tHezN4vz0NZYMD6n2wo1LGdmCrvwC+1mLohm4HQjXGWmt3OsLush9BrUPMwisJzfCshk2tbL17WefPCahc+gtk/8EuzAxQJo4hl/P0tjD2mRj1YbC35jEd2B5KdOohqXFy/GlsNGRMpvHJdBDLijH5tRGENQVghkqHkdPrWisjjDU4uUntaLui3XCjLSQ8v9IqWm1itfQBxnycv/CHwtwMTgt3RPVXJfHLLtHLUH3sFMbGtLvsWuM89nj3kGsMrZv67U645MqKhi8xfdxd1iVTDPrEYsDpGUo+YhNNIWi4lFqWj4sKjzg7QZmEiG6IwCEkLVQDG/DT6gvgEOotf5Tmydw9h+j58T+mWRKmQTn+SQ2GRXqBBn3DhJlIs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acbbaa0-4291-4f98-3760-08de52a3db39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:01:24.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jKHtE2mHleXNUmTWOHZbjYeg8pwh0qfChFHTrWavBudRztXORaExMxcwd8ipmmtP6voHGiYxngbDiPSVkJEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130109
X-Proofpoint-GUID: 9Qs2FHxBK5uTPqrn9EX6g6MOQb6F40CJ
X-Proofpoint-ORIG-GUID: 9Qs2FHxBK5uTPqrn9EX6g6MOQb6F40CJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwOSBTYWx0ZWRfX0vL7f6pYlmOs
 kRoYHwQl47+Ehyi+bcRU7hsg3+8xXKVkEuq8e8ifUEhJ9E9nyM8uSw9oZOacphvR2+Y+YWUhgqG
 z8pe1UmMJ5Vm3o1RC4uAMZM9e6ystDDWBp+UW0kC4vILJ1KCXgELMiLK03INv9ZartlP124KAVi
 YCeFcm/FJVIQSiFLe6/UHo2JyOqP5GbHOmcsDRKvRk9+ZImYsf0r4rU2igE0Yz5KWtOdr7MPlkq
 N9EJgwO7vfouKFIWLQmy4fBORCySzw7L9CJkF0nBrlHM0gyMRC5T4riCBBPVwvSj59wy8sVORDb
 7ck60K5EaStHLhEEyNV+EWN/pY2ZCnIDIo2vJ4u1cPSuRpd0c/neFQmKWQzwSdQ4SAXUWB0QR6b
 ALCvZO8//ShID36qJd1d72Mblc6TMhqClYXlE4cmqYxdl6U3DL1KBx/acxS0fCJbQufB1Dy6ln3
 lYnuAoYcp4BaVRNiefA==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6966422e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=C5My4TV7-s9L-27-N7wA:9 a=CjuIK1q_8ugA:10

On Tue, Jan 13, 2026 at 01:50:31PM +0100, Vlastimil Babka wrote:
> On 1/13/26 7:18 AM, Harry Yoo wrote:
> > When a cache has high s->align value and s->object_size is not aligned
> > to it, each object ends up with some unused space because of alignment.
> > If this wasted space is big enough, we can use it to store the
> > slabobj_ext metadata instead of wasting it.
> > 
> > On my system, this happens with caches like kmem_cache, mm_struct, pid,
> > task_struct, sighand_cache, xfs_inode, and others.
> > 
> > To place the slabobj_ext metadata within each object, the existing
> > slab_obj_ext() logic can still be used by setting:
> > 
> >   - slab->obj_exts = slab_address(slab) + (slabobj_ext offset)
> >   - stride = s->size
> > 
> > slab_obj_ext() doesn't need know where the metadata is stored,
> > so this method works without adding extra overhead to slab_obj_ext().
> > 
> > A good example benefiting from this optimization is xfs_inode
> > (object_size: 992, align: 64). To measure memory savings, 2 millions of
> > files were created on XFS.
> > 
> > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > 
> > Before patch (creating ~2.64M directories on xfs):
> >   Slab:            5175976 kB
> >   SReclaimable:    3837524 kB
> >   SUnreclaim:      1338452 kB
> > 
> > After patch (creating ~2.64M directories on xfs):
> >   Slab:            5152912 kB
> >   SReclaimable:    3838568 kB
> >   SUnreclaim:      1314344 kB (-23.54 MiB)
> > 
> > Enjoy the memory savings!
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Does this look OK to you or was there a reason you didn't do it? :)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ba15df4ca417..deb69bd9646a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -981,8 +981,7 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
>  #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
>  static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
>  {
> -       return obj_exts_in_slab(s, slab) &&
> -              (slab_get_stride(slab) == s->size);
> +       return obj_exts_in_slab(s, slab) && (s->flags & SLAB_OBJ_EXT_IN_OBJ);

There was a reason why I didn't do it :)

In alloc_slab_obj_exts_early(), when both
obj_exts_fit_within_slab_leftover() and (s->flags & SLAB_OBJ_EXT_IN_OBJ)
returns true, it allocates the metadata from the slab's leftover space.

I noticed it as I saw a slab error in slab_pad_check() complaining that
the padding area was overwritten, but turned out the problem was
because obj_exts_in_object() returning true when it shouldn't.

>  }
>  
>  static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)

-- 
Cheers,
Harry / Hyeonggon

