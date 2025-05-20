Return-Path: <cgroups+bounces-8267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F78ABD6C3
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EE08A711F
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D3267B89;
	Tue, 20 May 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpmUv4L6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZpL0VGE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72F10E4;
	Tue, 20 May 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740482; cv=fail; b=nyHSSbm2Gm/pMDyNiW9LVy5CJAAdz/EQGNlC1bohQ7aoJWZQtuMd6lwhm/R28ciL97sI3WsGh5SQMuLn9sav21T+rg/c/3IAnpNzyqooTybNoywzLc0l7rUM0UESamWmWvJ3D/p9f3N1qj73XvH+rW8rlQOqvZlSi1tr0PCJb/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740482; c=relaxed/simple;
	bh=XyRwX98SjcMiVpckblUZNbyDLlfY1NqGRkZnLr16Q9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F16btcSsWWFTIcrj9uH61dyP4LKGF8uWpG7Fmmqms22wJ/JY3xE1DVPKEthvyITf27zgyo3/zBAc4DU6IsyMBqwhoLoHer8HWnfziflcN2yOAaWUXfO/mRExi9xm4DwEUSVbd/Riub+FDFwA7ES4uWGiJlDL/8RbXp8Il5YXFkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SpmUv4L6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZpL0VGE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9NFBK011913;
	Tue, 20 May 2025 11:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KBamS1mV1cuMYYjEgN
	32AZuv1OEskmKtqa5uxbgGtrQ=; b=SpmUv4L6hTV3mcU+g2j4jWugzOR2m7qpd+
	pUEv3HcgkOkkj3zDnM2k1J20tmklLnmFsd1KkVm+4wyN2nzW0Y4MlkA2WLgCBOt3
	arIylMkpLXh4ef2hqhAzg+8p4lGGGJ6C8l5ieipGAPp7GAisG4ahXoJcu7pI/5VI
	UlO9Zrha+7/LKTT6Mui0f94iFLXwshxxUAfDxN4l7P3bFfU/e+g0xUoDziSH8NnZ
	GAMype/ysb4fRUNKaTu35fq6vcz981KPdbZlXag4pExxtAPXLq+IuRtwygfFkirF
	HxsjdS5ip6ZTEVm/zYn+yhvldPlj1oD4ORetzvx++iz81prF4PmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdceh2nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:27:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA70vw017470;
	Tue, 20 May 2025 11:27:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw846fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvseUM/fHyp90GXHnfcwVBk8SBYLFFGkk7V9KHzTkfTzUP+lPd66Nf6Drv5etEa/e62nvb4INNA2ngC77CbeHh7elkCgP8n1AIMDmfkDMu8ufJDEtkupHg2mqBY/FjjBIL5wp0+dk5vytJTVhEOtrcO+QVMcB920ZnUlMpaX0+/p5YyQQ14x/liaBIlSwFPltDCRl5pr5hI6xLI7j8eHWh6ZQnbmsBqluZ/qMLiPilAT2erDHxZnHkfot6C0w+VMVXZEGJfYpnla/4X09JJ2orMIpxwDVJoF4QkY6tIxliMn0S+3siBAiSyFYyurfsWJ81xz0atRxBLL79fipJcRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBamS1mV1cuMYYjEgN32AZuv1OEskmKtqa5uxbgGtrQ=;
 b=TPxilAzuqim3j1WBgM83ucinqWDES1VEuwNrbmT5kwnUoHiDUastK4p/QYyiGiYyg0otFVk92cAWiPYve/V7lyNXySbDq/5WM3Xmy+lCBwyjQLQCs7e3+wlI6AFkbsC9yjNe6ZvKZ8kG0G8CX4GkFroexspBJVN1DbWXdtduxF6Tr99KpGtwCi/KdPBx8f3d91Vc903OMqa28m50OBCHptZAR9myJvNyrpD07BF0tnNXP3YyikV8Edw5vmbMBfyOJ9A9twHldIwkqt3B8Szl2qWuoVWdqwjcQv5Pk08Nd+PrUQPLTYb1da2A/9apZO906VDG7//8rt5YnnfZTLPzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBamS1mV1cuMYYjEgN32AZuv1OEskmKtqa5uxbgGtrQ=;
 b=bZpL0VGEawMtdvK/OXnlRiJsxb4oR84LtEhl+SLdvJepudHixE3GCeshjU11DNGWMFbkmY7ndzIyaINjD4SfrqRVK092aTA4UlIKB/DLj2Dg1Frb7b7FIrdOMaOF5bh9wUCW+qu5ji0buOORDrAQblg/P8hCWVajeSy4my0ybYE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPFC7C228AEC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 11:27:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:27:36 +0000
Date: Tue, 20 May 2025 20:27:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH RFC 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <aCxnFg0VSpd7g_Ju@hyeyoo>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-28-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-28-songmuchun@bytedance.com>
X-ClientProxiedBy: SE2P216CA0071.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPFC7C228AEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 568da745-d2ca-4a71-1035-08dd97915204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ogAl2qsizflOm7dmm0OoLzhz3g8UoDQAu3iGTOytZWU9qVPkGV8rS3mJgZY?=
 =?us-ascii?Q?M3sMRHRztYW7qEmQFP6ymPRH51Zep6HPZnAvDw/kqivGJuByrycknFLbTs7R?=
 =?us-ascii?Q?B+IVc1XfouyzDpE9WlI44C9aY6NcgjVFMvLyj1ZQeniQgQj2z2D0LRNbYGUn?=
 =?us-ascii?Q?ZDoeRVDo39wvh+VXOyCw0QP6kwQ2fXdJBgmE0MnFMB4NtA6hFNmM6tpiRBo2?=
 =?us-ascii?Q?NJIhbMpj920qSinCBS7O8Xqpm9FZUqKd5JuMfjCev1BP48qRjo8D2v4W0iiI?=
 =?us-ascii?Q?pngYoA14bUePha+nSfgEcDfYssJs+oczQoKs8OsCmP3ZY78LXiFnHmPj/1nK?=
 =?us-ascii?Q?ATSWOMVrx/PPw2+X7ZaRUu4FvTNFr6HEHA/ZcyVA12GbY8LRh+qEYYWi75x7?=
 =?us-ascii?Q?46JgNjl0LlZe/Hd5Qz0sUH17tHCG6pTxwJf8bweUuvgnjZ7yN7dZUiczUhO0?=
 =?us-ascii?Q?CXUJ0XtBH+WCOl70mvvk/Sa9/OFZnaWqrl0UtFEvfYpVSwTolLsK1k10DUsL?=
 =?us-ascii?Q?gHvNu3G66/W1BJm0AKF2LbiCL5Y8bhd3tcmYQWU/RKvHxHjexMXAB2RPnu7P?=
 =?us-ascii?Q?6IWZmroYbpM27KhR03v2TOkdV4noZyJRVR4qISlyqp7YVilWWxCFlT3Fof6n?=
 =?us-ascii?Q?pv/XRUH1RPSuNFQLaEXec5O8ae1oSyQDFFi20Bl4SL/TgO+CVLHJ+SPlx8wA?=
 =?us-ascii?Q?k+/LQyQjEkA35uLUZF5U3U4WvwZbJwCT05WNi7HasgCkOOhSGTu07CF6hvvp?=
 =?us-ascii?Q?wzgqusjRiJYcuq5J0seaN1tMFUCLe5a05jNp5gXRNdzkTXd4lmjh+kXvZ1a9?=
 =?us-ascii?Q?Z8kZArGaEIdr3XbDENZ0UX+PB6H/xzGk5CzVUrUvQjgEkhUwL3uWsCDx/jSs?=
 =?us-ascii?Q?WobeUuCvZ4SOPXT3YIAnm5lmkJFs6nXr9EoaKvSBZwmOt3MqaI13QeaZrsGG?=
 =?us-ascii?Q?2OJtbe/WxOawAt6oDYoEbMMrmgMfckQrEMX71e4lMTEDQSsLD1/iCiyszwcn?=
 =?us-ascii?Q?g90Ddsi02goyOSDArtB31MDA5yJe0aaaeQHyPGh3WdSC/1qH7tWgp6Cjh313?=
 =?us-ascii?Q?X/B/YG8jEzYvNrkhBiso/zgnL0DKQs6UOZF0EQSTGsqAIt1b4wdwR38kqDRf?=
 =?us-ascii?Q?g57zli36BtFBzEWsHLuNPx0GMYyW7u84+fC3o3yBv+ZJc/JbBFimJEUFmzww?=
 =?us-ascii?Q?quklhdWs2hwXFNAC/6zSQN1v+QSUXCFKyAZVwOf0FHWCq5i0HoukR7z8lrx8?=
 =?us-ascii?Q?/mvDMevCGIFmWocdY1nEsMIxW8rCq8+lOKJYm1s7sGfFTx7dDY+oRUOTKFOy?=
 =?us-ascii?Q?DzuBG4VI8RLBc2t2QjQNCX6yZnkX5yuCPD0vdCnC86Lnw6FXcuQiwQb0rN75?=
 =?us-ascii?Q?EOomwLUsglzZWs+dXql98Z0ovEsZHMfXSitIwRx8GiV9yktRz1sfK5HSHVs6?=
 =?us-ascii?Q?xyTG7eIGu8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4ZYC2FqRRKI7uRUvybJwgTkLHk/Tu/ceE/kqFlP+2GYFknQ9rPqB3HBNSbM?=
 =?us-ascii?Q?T/cGNtg51eWkWuHUaHI63E4XUyJ8SKVdxgqFNjDYsmOV43yl1vLQtsK/D++m?=
 =?us-ascii?Q?NYyMeut6zwOo1QWCb//aym44CfEF/8oBmWZRZ7E6Tm0AVkVrPi0FRGC0SDq+?=
 =?us-ascii?Q?om0QOQHX11Ypo5gV62dpW8nSfD1xynKYhCVWQWUU7QGl6TzP9OimFSAR1ImE?=
 =?us-ascii?Q?ZuH7+Z0r9XDkgXyz/pr6uGU5VXOxo95Pyn1xKAJ6VILUYDlXSyG0tO3SP7Ip?=
 =?us-ascii?Q?luY5M/0YBIDfo07SXoBHRH3JQp4zFs7hXUr7ZqDehO8HCvOhNuNgn+zsTsh/?=
 =?us-ascii?Q?na9JF98+/s8wN05kUNhN9xrByP/HKLUKorKl7klcwSm+4AxLd5iCwBGais8I?=
 =?us-ascii?Q?9yzUtge6uBU9GGU1bTbeXZlf+WKqvr7J/2LrcrQnXNwt0ZyXLVMvJs8tc7VR?=
 =?us-ascii?Q?rCqQ8jKEV4Z+suDJHLdaYpNudn+xeg2TGT9l7zuO9bD2P4JBuR3TztE3+VY3?=
 =?us-ascii?Q?cFayr9H+an/RcdZDh4nbLAAOGltW9ly2wgOjBOOsj2h9bFVl2ZvvZG1Mkmkt?=
 =?us-ascii?Q?V74KEM7dEKIQs6UIZ8LMNU7XgFO9I7x9G7U+eMk8I0EFGHArXB/dA6NKmlK5?=
 =?us-ascii?Q?prs5eYtzxnaVzGgBVQFtIH0QLGDbtNP5WDdrrFNq/rcrIOiNJh4mp15tWcTs?=
 =?us-ascii?Q?HfVnoIcBETS3qMWYHijMWjvnLx3QfSq1VDMi4qX0uBFV3ro6ZEC+kkvrFLYj?=
 =?us-ascii?Q?BidQKYKvRZggJvdg0HLTj0Rvi2KhOEbrAgtBLSxmWns8OOCEpRK/sKW8AyyZ?=
 =?us-ascii?Q?cDFIIShMkHiGxaLEaG2dNAYwZbbBr7uoMtg65HukHoC8TqkT8QyCw2p5Q18T?=
 =?us-ascii?Q?dkn0mp1bI9/KD2kNuUPgaI3aGcNeaEj3mIf9eYZbUZfI6O0sxrxn2d87wbaK?=
 =?us-ascii?Q?Fi/swlbImM5lOXhNC3LImK2URW2RLitXrHg79k4CHe/otvmkkF3VB9NfUTfP?=
 =?us-ascii?Q?FEQS6t6/iDX2P/AwWvjmv1p7eRn+/1eCdhOkRrpwni/HaHmnKX82L/PRdNkn?=
 =?us-ascii?Q?43iW46FSFAispjgotn4wAG1ZE+DRtBBToGThK+pgzPm7jzqSAWvA2gYFgI1S?=
 =?us-ascii?Q?1bbmqqxZ9U1aRudFjgAU4/e7q+kuw1tPAk0IJAcsh6gKLVdqQ3QMP4QyG39+?=
 =?us-ascii?Q?9uwt2je/RNW7RDrQjzr5H3JMcN8/4/G0bIQ6q7qnWF13+9CrC/KWoCkMolKY?=
 =?us-ascii?Q?VDfqbBXeGBvt9lln3UDkBZz3cQHuXO7ni4FLrP8eSABlguQzupmCjGEY8L78?=
 =?us-ascii?Q?32UpUEEvO1mDPACA96N2tog+eQ8gT+HwVPKdSw4nBuSstI8EnM5+jbbl9UhH?=
 =?us-ascii?Q?blgO5EYGaBTi23prgOqcuKhKdUS3fstQ/Loavk9nmXRj8UUcX82ZgECnpQUr?=
 =?us-ascii?Q?QuMUOwX3J1crd9sYrdvk4ShsjcP9RHrEfhu9dOKaMD+DyLsYm1nVXe3WCsQA?=
 =?us-ascii?Q?ttrQDi7UI1z45T6BiJfSThTzEKratec1is1GXHdPaOC+9P/MPCOMaZIiIWsm?=
 =?us-ascii?Q?0MArDOAnyBXRGr1Hed29X7C3H2W4OllLk41ZHZD/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zoN0d5eXl9I+RQFUAvYFTkevkq8cljw7Vv+PDm8eGF6XyPUNOEdjIC/BGQhI9iW8dsHpmzg0YCEqOnuKG+Jp38ylDrvYz/STMXYETIOq763w/dunjno9cR02P5iHsRW9GhMvwGEqvM0VCmZJ9CfTTjLSxM+ifQTanZJ0i2TrmkF3/TQ+RaFDQ8tj2RDN9hzX9qgkjTL/c4Sc/NMWv1z4syOjfo9RzKGytE5pttwp609QCXRz5nYwNFp9gK4270D71tqveIEzN5V1f2j1XLglQ4ShIiOcMcW9bXHrjD5QGyL1adeC4y2iJZ2D8AfIGWJf01/lmbcFKnudz2duaFFxJ5M3xoiEbow5XcK0moXK4haOTq1INh3GK42WyIP/1a4EPH3WicN6c169Ey7FzVAyFWujyC/GzEo2gfYUlgGUJvperxxjoblB52qSDY0gMSA3TsPSXsSa7hkAcdhxYjyDxUsosrUMjiJwUHhhy0Ccq2PSRFT0x9YTsfZfTjZ7ubGXHjepEemWbs3EUWlrIrDXi5NXnLvsCqe64Zrzj7uDxJ2RddS9qvmJFd2YWeeJ4YbgDne2OTiNoWC3gaAKyTQRK1uPHnYAu45mkh8ryAR28aQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568da745-d2ca-4a71-1035-08dd97915204
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:27:36.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPwGXji/Jl9gkqot+cYaSZO3vgminpAxaPVTQnbqIAOvNdD1P7HZjcBPKJQhO3Ia0ckvWCIU+rfMTa8nuuQetg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC7C228AEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=947
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5NCBTYWx0ZWRfXy8yT/PuHxxmX 2Scw60JxHJ8QibD6zBzbConTwIILHOQPwgcuhc+VPRCAY3gOcPHEnndckRWhhgtvPsGODTcvluO mrfLSo6QVWsC0aFxIrdZBOLywxYLtg1+oYDhWnlsfN9sKeX4flasReIJJga5BlSsG3/lmgp9X29
 3rjFK0cQp8p6XtDRRD4xh7/WJJXB2MMQNlJ0gGhJOjjFx8bs7KCXu8BzUYDZa104Sfp5WN7ZnUZ vbCo5vbB9cN7YiuWxi8jkEJ71uobN+lSCt9KxEt3OP6VdeHdwZvAHT7Zuqg+gXx3AcJEJz0M/F7 wDMnfxAmgVpV1R2BPygfBCj68qtkYSLJpcCIT+xXc5kI8QGdYbOfAfVLyev9wFVMb/tGYF+PIrs
 OjRCEEGof3ZZmPkEt541Z0bVOJOwJhduRo3qsaleW/OKxi1s+EpDndj6+IzYKroMqO1iAug3
X-Authority-Analysis: v=2.4 cv=WO5/XmsR c=1 sm=1 tr=0 ts=682c672b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=37dOG756UMMSJ0ROjGYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: 9Ym0uYzBnML_77WpvXU2SNbQQOa067k4
X-Proofpoint-ORIG-GUID: 9Ym0uYzBnML_77WpvXU2SNbQQOa067k4

On Tue, Apr 15, 2025 at 10:45:31AM +0800, Muchun Song wrote:
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.
> 
> Finally, folio->memcg_data of LRU folios and kmem folios will always
> point to an object cgroup pointer. The folio->memcg_data of slab
> folios will point to an vector of object cgroups.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h |  78 +++++--------
>  mm/huge_memory.c           |  33 ++++++
>  mm/memcontrol-v1.c         |  15 ++-
>  mm/memcontrol.c            | 228 +++++++++++++++++++++++++------------
>  4 files changed, 222 insertions(+), 132 deletions(-)

[...]

> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
> +				enum lru_list lru)
> +{
> +	int zid;
> +	struct mem_cgroup_per_node *mz_src, *mz_dst;
> +
> +	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
> +	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
> +
> +	if (lru != LRU_UNEVICTABLE)
> +		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
> +
> +	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> +		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
> +		mz_src->lru_zone_size[zid][lru] = 0;
> +	}
> +}

I think this function should also update memcg and lruvec stats of
parent memcg? Or is it intentional?

-- 
Cheers,
Harry / Hyeonggon

