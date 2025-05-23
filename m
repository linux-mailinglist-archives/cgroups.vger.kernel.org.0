Return-Path: <cgroups+bounces-8320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE8AC19A9
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945161C02C1A
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782392DCBEC;
	Fri, 23 May 2025 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SI9Msv0L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kh75hddF"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792C2DCBE0;
	Fri, 23 May 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963460; cv=fail; b=uNvpSZOb1o07KG0vResta+9tkvVnu6qcpAwl91AfKUPuzKMtxEo0u1+UIJOMhfSCppspjKIDuteG8H+R0vV5EIrpQbVkzIN1+CLY6/Hbz0sqL30EM8ASLIh6Symp0WniY5xzFmptOnNg4m/hJ46p0qvGPqlnxkToptwMT4MyHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963460; c=relaxed/simple;
	bh=UEi9Pa1UD80J02A4vb3hHKThzRXbmWCPmFECZHYt8x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ot1DZ/2Dof8KU3C9i9Ow9jACjlyF20rtrZsdBwB3sLKWSt13C6u52O/BqciRFrke7iK1NKBjkgXLQqFdyJ2BqH4/e3TsmyZ3mlpHcGKnffQ+KS+dfEH7vt9VuYEsE/arSX1cRV4OWDDFOTJL9OfzUCrcEKhLSDYzSLamIMcw5XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SI9Msv0L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kh75hddF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1IDjD008225;
	Fri, 23 May 2025 01:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FS/dO8B/lu682keOYC
	JgbbmmO5ocH0v1QdNbMtaCWnA=; b=SI9Msv0Lh3liApLgpgrloqWsNofx894a1c
	vh2NjdzJzBJ5asTVJixqK5CjOjEPhezCFSFma2hJSR1y+cJ8IeDlvyOC3ExGePzz
	g7Nu61k9syt595NHyc1LxdwflnV5IaANsqf3QJ36RL5waMUd/RmKWLXwLyUsbHsW
	5AsO6M6lB5i6nXvC1VEhmmWQwut1fizdTAuXXXGSnwjoIIHsFs+dFn9ozpet4jBA
	lWXNVShyvxyVMjaszH74JTLKt5C3yaO5/kJKwxZEMC3ZMSWUXFvTS9UvG7NScUSC
	W+YQvMUXzoVnvT+DIqUzmC+WcPGxQmC7rccUvjdPunbIbOd8W8VA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tdse03h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 01:23:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNIvpa011350;
	Fri, 23 May 2025 01:23:51 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweq4s3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 01:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Medv64iLTVB2x084PUPmkIAItwPDknIFOByVXreyXI5+stcDMtGClms78XQHjG19DFAZds5jbUogo94+HNAgHmv0jquv3xtEzihV/eYPPEzaZvhI9ycTS1xivwUuLaVFy7QCksOldPh7JyYPdmriPUv9iwxztxWls00/hPGf/MYZ47RuvgOJ4ZgR5J20AumTtHA1RyluCFkMhCGGc77/4uYXrYfM4N5q85dI5Xvkp3TL3+Sni62e8CCTsF8aEd7nUsjO1pgaLLc11iSqoUxnx8K7+GFBTXOd+xvHyGcYTOrBnYA97wb6N7nuozHGCgVDAqRcQgNEzOjv3znig6o5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/dO8B/lu682keOYCJgbbmmO5ocH0v1QdNbMtaCWnA=;
 b=Pbo9EXG8ntjhsScnUyG9WHE38sWQRAdLPwM7cQUU5Qwux/D427ozjv6/73EkTuj4x9hYZ2qeaZ9qk7Ux5V1277K0MLopkVO6DBLL+u9TzDgpJyQ/INVEhcvlg705qJiZtfbbPxqfav3HVjE2Da6mGDX3HNkYcwoE4DPKvjOLz+wLW8RB83AHz8W2fYZbo8elWhJ3tC/5StAgqowa6t3hKSjioi6HKaFujcpixmfyhSAcXr2VBpw0Y37T9trzeCLsDOn0Jmqj/x13mBPIgw29phEWmmQC0YrYJsBwAxrpsg23BS6Ix8Uq4o7bvcx8Hx/FLsSQ5H49sXnEWtnY1HNc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS/dO8B/lu682keOYCJgbbmmO5ocH0v1QdNbMtaCWnA=;
 b=Kh75hddFR7x/yJ8hw6WHXvW67gGaosEUT4cW3mddQ4H4DBQ8SQu4XqxSR5Bi2RvxZLOJ8K+G+Du7TcqtqyuJmmDnmJCIxK/1C05p/j1t5nCKWcWR+Y9dwX2HxCaKcT6uHIn1DVUdSfVqiXSasEfWetesY0vdAGGtrJ7GNkRWYYs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 01:23:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 01:23:43 +0000
Date: Fri, 23 May 2025 10:23:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aC_OF2hYWawIdb-_@harry>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
X-ClientProxiedBy: SEWP216CA0012.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ea97a1-e154-4248-1808-08dd9998747e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/eqQqUTxeerN/Z1frK3vvuuQPl6bgr9EzlYyiv8qxhKqJjHUYQyKH1ZDovh?=
 =?us-ascii?Q?f83k+dIBEgyVSMoicCt17f1YB92QwewyL5vncijlz0/o5oHB2QrJqSt99hvQ?=
 =?us-ascii?Q?hgaiX914vCB10CJxZ10E/BiHAtZVK8Pr3G82aDcfmheoNlDIhxsp2D1aS1MN?=
 =?us-ascii?Q?gpBZiEc6lF7EAsk+0pA4ykBedGQ5zshcHnRX21xivrHwP2EN6qkZ19gU0/L4?=
 =?us-ascii?Q?dsRV0/MEdOtTyi+3pE+Y58oJ9E6FiTbBqXyK5t3JjFd0G89fF5rHuvPTNYVa?=
 =?us-ascii?Q?KBoHapzoUpHhPMsULqXbprGd0CdQXTjK3UJUMnKna1ZRaSgo46AKzjnyeJll?=
 =?us-ascii?Q?uWLieKJqUudRH1Kcf8/odILleHDy6pMsZrNu9p+r+6TwDgOjp8OiYxOn8D37?=
 =?us-ascii?Q?REMm3FLNKdgsmL0h1Fkfk4yfbq+Ru1OtUXCJqT7V0ljA4hZxCoq9sBX2E4iN?=
 =?us-ascii?Q?aMERpJEkmNVym8tcl/Odc05pyyNQZskkXfmHfx23GUSiM0p+mL4drdjoKHW2?=
 =?us-ascii?Q?LeS67TrpoaD7Fd/9aGbSQj3rAqo6ZhI3qTBkxd+ilv6bkNbZHe+Dfw65zSAM?=
 =?us-ascii?Q?AxluMjFbnvW/O01oc/5dCs02RW5uPlYvRsCn4lYDTafxhNKoKuvuA4mBSfhI?=
 =?us-ascii?Q?DNDzBwqa1QyyW2B77h4byVARb0tdy/AOzEwSxQ02qJzShK6Ww95iYKyWG1bH?=
 =?us-ascii?Q?6yCU3qWrTMxwWr2WLb9ki6Lada6oLWhZ+58edaqUy6oTrXrGAkK4Kt+8rHJO?=
 =?us-ascii?Q?m/klogOBLgaiZfRDcl7dnEnEElco4lvPOPWCmBn18zB3m0u5rz2Ipyy0lFZl?=
 =?us-ascii?Q?X6pKRcB3GQA43xHr1qKn1xgtlkgH8VdCFcXMX68h468XVUHO9QYi6aqV997L?=
 =?us-ascii?Q?nB3Ak2bE6blTNGhfpmcUOFxTCQVVpHSqlet4/ReWXjQSTq22nI3j6mG3C5FO?=
 =?us-ascii?Q?67oI757ORAFeCtNwZnpKZNz7CTFdcQRX0tNnV+4rR+2jTOVYRn++41wiuUg+?=
 =?us-ascii?Q?i9rlDws1q1ouWCkhy8IRTS1tX9Tw8yBffQkKjc11zMv56HytBCwN19FadX8M?=
 =?us-ascii?Q?VJ5elhNSVztoJHvqTezbHy6T2jAiLdieSKgDnUdyxxCwhJK7RzIkUy1LM3nY?=
 =?us-ascii?Q?/VJ45CqffpHSgr0rurJcHzr9Hl9D3yBYRxfSP304MPyZNNlVzIqODPd1gTks?=
 =?us-ascii?Q?42bDRWuBW/C0TWr4QnVopLjOm4kENPyYvKG16iGzc/f1QdU863NLkdRnbkbS?=
 =?us-ascii?Q?lay7oTfMJ3t4/KrpTYKwq3eA5a2iSC9oEPBm4aFehjjid3HEvDQogDRuVJXb?=
 =?us-ascii?Q?SiQNBew5Z0Nsn0zY0uvFL+Q28cZKBksLJReGvBlHYI8+BnLHg7mFvoZ69oTx?=
 =?us-ascii?Q?EXy2KmX4CpX8tBR6tMJIKS6asqTx8AN+Dru29Jx+syjGl3IEcAASJ2EvoxKq?=
 =?us-ascii?Q?LLjjnjOyRuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQMzWhqbvTz2ces3mD99QGj49mPR2x2tykUXt2m+qn8NcvNyCWXybMPSyWCO?=
 =?us-ascii?Q?SOy8q7ah3lzE9H4x0QB5sZ6Dlx49l5QOUflO7ka7ABIYzv1zchJfX38stNkx?=
 =?us-ascii?Q?ScDEd7N3hrntSMmIdQL0Y0GjzHTovY+LdYqJQKKD/q8x3XhMtrXGiwk+db4X?=
 =?us-ascii?Q?3ueYn5XflCGSMHEi7y49rNGsDZVNg2ZSIOiCaY0lJ8TxW1X8EHyH9aq4FJEt?=
 =?us-ascii?Q?Hr+2+1sD8WbuC5jCuDgJnBusmWvQAjNOlvnKiLzgjscSYkt15NADGXMinyFE?=
 =?us-ascii?Q?SvTl0XlY4O1Y5uoK7t7UWQc7JUv1KsccDczUMFi8zS6yBEuATYAx/1hnAFkc?=
 =?us-ascii?Q?NfdmXaBAsOtnhfoXQHaJGZ1pS9wgzMFDeDvSlm7eHvOcGpTlmXVVtfoiIAtk?=
 =?us-ascii?Q?kwg6abtfuqo5Jxj21/K2XNosARJzT9I4hFXD1OuEzXfdCS7sFJIJXUxjCQxf?=
 =?us-ascii?Q?Bs/O9JLIl/u8fQh01hD8/iWeHbrh0+d/2MWriYjgbMPH1h5C77xHKohV0Dtf?=
 =?us-ascii?Q?lLjIuAC0o6BgazU9x/vNkXEjHTsScYT1tpsKzp+3UczFiAPZog7cy9VxJJL4?=
 =?us-ascii?Q?a9Z0bzy4hMNUKDNowUZMpxE+9DyWFC1wdgGUJ6SL24T2wkT0p4N6in8fuKQ5?=
 =?us-ascii?Q?134foarWoo30elEYgSC4nCRlHbDFeMngF+yTRpR7glTOIVYQG2IWYZx/5exf?=
 =?us-ascii?Q?Q2Yfid0xIfRQQVokJ9F3JwYTSuQcNGGZaNUK81M4Uqo+x/VpsW/R3RaWiLum?=
 =?us-ascii?Q?JIEk1VZAkkGPNIB2o/r1Tz8ku1Z+UhyVrBGutiO8+/4Wz/yA6UTPvz/Fo0hg?=
 =?us-ascii?Q?5xb4Q51PIuKOFSji8m8M8hu8SiDVUlikP7RR3R3stCAL2QJKOUdnehG7B+wc?=
 =?us-ascii?Q?k6WUYhvR/wMs2BftMWgTUM5YJB9VAdFZxBitAd3OyecLaZlZ8DfCf8SBabqW?=
 =?us-ascii?Q?XqPDhqTXWguaal6hzLK5MqQrmrRnVbJGRILu/hY2dJfcfOXzdfgY6EGUkcWJ?=
 =?us-ascii?Q?sGQ/75+AtK9bfQCnVy4Q0Du41GEQcEVxnyFeDeNdeYU8q80o0HtYBb+uleef?=
 =?us-ascii?Q?TAbUFxijt9cfc+J/prcbT+b+4GTDATWohW/v6jec4ykoC/qaTkkoeW9/ta9j?=
 =?us-ascii?Q?pNyywR9yPzg6B3DMKBVxXohJWfyD/Q6DO+9+hgAuR0h/bM7Qqn/d5vVDSeHe?=
 =?us-ascii?Q?47UipDFQZAzTWyrttVOvPLQCrILnDalpLUVelhvYyADBm5nAyqBIZ0SZllWM?=
 =?us-ascii?Q?byh08nXNs666tzZdVoBBPrDIUpbcUvpWlFZ3OyfcAcOc+66VQEOa4ZlJvGqF?=
 =?us-ascii?Q?4VLG01oLclAAgOoGyOQmb1L8AwV7QvFrxYIcKALaGXtSUxp9JZPKlUvD1OyV?=
 =?us-ascii?Q?Bmljs45w3Kc1/+K8hOAdVTlLFyYECY6Ug6T/XyoN+FQI/yE0uksV1UmSZztR?=
 =?us-ascii?Q?Qcg/O9hZWUPSnIw3wl3FcAIVoxFIzwGgbVrENgz85RWhV1D57EzAQgmOs8Ab?=
 =?us-ascii?Q?QnhJp20TgRW9eN2QMPW30q942WyJVoI9BUpbSmTxwA6GV37dhEMFRDNo4qqL?=
 =?us-ascii?Q?Q278Oy8y3g92blLqgjUA6hDPGGTUV3Ubz+kDlosy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TZ9PNVnErc8X/iinHtx2RNmrvYqbLihCiiQctM9WsTCEc1G9F92TgmqxJTwI6sPadE8RCU7g91Cf2MN/JZg+HeSsg72psibzk5HAhsr/cf/4Lxa72OLgGkOhqeGzZfSPiqf7k2CEruPR9zs1vbcJqEW+zMyhV78yY1MrZGp72NFL5BSzJevmhgPssoWBL2McoQJR/7dh5nLxpi6UvD4Fm8pPh6qYyEf8FL5a5JcL4OJuOKOOXAct5Fc1SzPqWqU0MA5TdBN1ZrhOEYSUcxQ74fFucKYNITUIo9ovO5ASCau5Ou2MGNP5VCsbvcVaEjYQ37TKbjKaZAsmDIbAQTORUjr/eINAyY/tRc8105PhnYuLAdhB70upf7QnJG+fTOASxqzwZgXcvP5+qnUSco/f5F3l8I/ZeqtI3RYSqA1V83Ypdn0r1JWb4SR55m0I7QJqXr2u+Xo+NvtVLEW/MaPNZ+JHn6FsTVAaXcPS1xVstPzG2uVunz8r1bKEY/38x4EsVhHv0eqUzKp6LA1uZ+Oujq6T8MpW60kHMI8IIUU+xVpqhtZsCxofa5k7Fq3lj5h3itmzDZGHVHrVNf8anwmuVf0k42hOpbCAWvX0EbzbFoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ea97a1-e154-4248-1808-08dd9998747e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 01:23:43.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oJmaXx3zn6cOnZPEpTyBOwGLxLxYy4hg2LJxvc3DVPWRMFD2gb0rOwTLV1NLy/X2gcRc3WsAmDbwisZmz7vmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_01,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=839 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230011
X-Proofpoint-ORIG-GUID: idzvRi1OmFVFeEjxl-BRnMD2CggSH9jB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAxMCBTYWx0ZWRfX3N9OmWy3OUT+ b2PoJc77zbpYC+26FK8e0MyKcEVafNOsHRYkJ+33nbIrbF/aBxbMs3+/QEqbmiDJ2TU/R+ihLlb A4VkWI59zCKRXx2FleFtg1m3VUrHwaWwpg5ZmxjodAaF+RfAiksJdPTUlqti+Gt+7EMtxbOtvYz
 g2y3gQnVH08qFZD4rV/TQ0/t1PBsoAmkDnPBk23yK+rGX/CoqqeaJwujR97XYERa3HiEuQLRMsk 0AF1Z93z6zMWv3QwqOqb3Y6QAot/i6OVaL0WFO56r21EHAoZbgYyzXm8l+aj1zT66zI+AaqNMef JdHZI5yt0LzjyG3RJFKpy+5ygGjoR+VBgdgKbtV5fi7TgCgIJDkzbTbD7VjSeR3worf30auySFg
 nhucUsAP5LcDtUimJZZQ8+v1+dzgFJBpXqjwHRUoSFWla60C9I2tyqFtTA0UQRghWH/w+v9G
X-Proofpoint-GUID: idzvRi1OmFVFeEjxl-BRnMD2CggSH9jB
X-Authority-Analysis: v=2.4 cv=eNQTjGp1 c=1 sm=1 tr=0 ts=682fce28 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Nz0hZ0UMEcAiIgdyCZQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714

On Tue, Apr 15, 2025 at 10:45:04AM +0800, Muchun Song wrote:
> This patchset is based on v6.15-rc2. It functions correctly only when
> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were encountered
> during rebasing onto the latest code. For more details and assistance, refer
> to the "Challenges" section. This is the reason for adding the RFC tag.
> 

[...snip...]

> ## Fundamentals
> 
> A folio will no longer pin its corresponding memory cgroup. It is necessary
> to ensure that the memory cgroup or the lruvec associated with the memory
> cgroup is not released when a user obtains a pointer to the memory cgroup
> or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
> to hold the RCU read lock or acquire a reference to the memory cgroup
> associated with the folio to prevent its release if they are not concerned
> about the binding stability between the folio and its corresponding memory
> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> desire a stable binding between the folio and its corresponding memory
> cgroup. An approach is needed to ensure the stability of the binding while
> the lruvec lock is held, and to detect the situation of holding the
> incorrect lruvec lock when there is a race condition during memory cgroup
> reparenting. The following four steps are taken to achieve these goals.
> 
> 1. The first step  to be taken is to identify all users of both functions
>    (folio_memcg() and folio_lruvec()) who are not concerned about binding
>    stability and implement appropriate measures (such as holding a RCU read
>    lock or temporarily obtaining a reference to the memory cgroup for a
>    brief period) to prevent the release of the memory cgroup.
> 
> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstrates
>    how to ensure the binding stability from the user's perspective of
>    folio_lruvec().
> 
>    struct lruvec *folio_lruvec_lock(struct folio *folio)
>    {
>            struct lruvec *lruvec;
> 
>            rcu_read_lock();
>    retry:
>            lruvec = folio_lruvec(folio);
>            spin_lock(&lruvec->lru_lock);
>            if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>                    spin_unlock(&lruvec->lru_lock);
>                    goto retry;
>            }
> 
>            return lruvec;
>    }

Is it still required to hold RCU read lock after binding stability
between folio and memcg? 

In the previous version of this series, folio_lruvec_lock() is implemented:

 struct lruvec *folio_lruvec_lock(struct folio *folio)
 {
	struct lruvec *lruvec;

	rcu_read_lock();
retry:
	lruvec = folio_lruvec(folio);
 	spin_lock(&lruvec->lru_lock);

	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
		spin_unlock(&lruvec->lru_lock);
		goto retry;
	}
	rcu_read_unlock();

 	return lruvec;
 }

And then this version calls rcu_read_unlock() in lruvec_unlock(),
instead of folio_lruvec_lock().

I wonder if this is because the memcg or objcg can be released without
rcu_read_lock(), or just to silence the warning in
folio_memcg()->obj_cgroup_memcg()->lockdep_assert_once(rcu_read_lock_is_held())?

>    From the perspective of memory cgroup removal, the entire reparenting
>    process (altering the binding relationship between folio and its memory
>    cgroup and moving the LRU lists to its parental memory cgroup) should be
>    carried out under both the lruvec lock of the memory cgroup being removed
>    and the lruvec lock of its parent.
> 
> 3. Thirdly, another lock that requires the same approach is the split-queue
>    lock of THP.
> 
> 4. Finally, transfer the LRU pages to the object cgroup without holding a
>    reference to the original memory cgroup.

-- 
Cheers,
Harry / Hyeonggon

