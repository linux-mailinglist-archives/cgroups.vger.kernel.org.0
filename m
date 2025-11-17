Return-Path: <cgroups+bounces-12040-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3AC6357A
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF7F7366E6F
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE026E719;
	Mon, 17 Nov 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqdf0P1O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5abrBej"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099C31B80C;
	Mon, 17 Nov 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372524; cv=fail; b=iXUfU311Q6Q0bBIzxtVwEkUYx1/21zFFa4CeWvMxUd2dwVk9emtw8zEstCA9aWUfpJZ7Gj2SnEqNr3cGLecDBmV9WanAWs126zqZQuk9I1WsbaSdxPDs7WXsgtHh8NRhWTUEPjPufNkARlZf6W/dqlZe4qbi5AV7LZZJwHupQ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372524; c=relaxed/simple;
	bh=XYy4ixg1AxvePE7IlvLcbJj8QnmBjFJbWJT3PfehfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ff5IoinkRsaQCn2CkDUCpezH7NHt4jKFtV/R3H4LZTXjCvlFOaLaCsnZx85apHVXzNfoVGv79H+WkvThq0PP24AFZzBOSr2qtDaWdDh+Uxz4TRW68+bCgE0wwXpaNQr/btt47o+joOxzh7adExbFWKXun/MEypqqjKuvVQU0s8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dqdf0P1O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5abrBej; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1w4Hu017435;
	Mon, 17 Nov 2025 09:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HZ0TshM2+DW3YlBNQ/
	Y0MmPx4/ida2FFsiNEHWeXx60=; b=dqdf0P1OgLTsVg2/xo1aMpXajjYWtcigP8
	qrQVO5mdho0AeTpukTBpangNY1bwlivSPBab4VFkoUCGY/aTsRi0OZc797NusOQD
	fsJHNo4TEv1OHv7rl4Hlcw3pH/n3IScVbbSjHPCpJ2rNP221VXaoGp7E1wRm0QOc
	2lOFVL+crAADunUxWl07q82Ih+7QMFCceC9kf2E+z2ATF8GehP/qM3LGj/RWrXFR
	o7QUwkjx/BixOabjuS02nf720lQFd/RHbcOaueYRcXvfeM0uCFOjuWjL904Eh41t
	fYoTJ1DRZCOb3OVHh8msdqo2DvueU4TKjnvbc3+7rnm9GSQjHKYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpt3af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:41:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH9SZCn007201;
	Mon, 17 Nov 2025 09:41:24 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7ep4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn0/1Mn8wDYqhyXzc5gGMrqoVLCvq3JE3OsEFU8N0/MINophE+mhCy4ea8WD52CNm7E+6KYjTbOehRlTH2uViSDcHwZ8RG7dixeAk5NdDgRagEhAXrMOrrJVPY4ZUNOwNbvn4C+WppCeaxtTP0huWWYRNUCNoBqhbh2O2mxe94Sr4aDjV9ikeVGpN5Rz8kboDq8Isfi4lRSvjU/2UYBimjg8b2+xso63FQjQU+PhWZwA6yzSVPM/fFcketI5l5jcXe/8AcDCZja6N8DcJwBcDF8B7Gr97xM4yaQutHmmhzG0LvXA63fJpzVNXy9ykDBQXtXC3gqJPhr+UwTRpz0DFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ0TshM2+DW3YlBNQ/Y0MmPx4/ida2FFsiNEHWeXx60=;
 b=C1xGcfM7q3WCmc8CtlfPUJ6tneF9YYEMKEFXZtQ6VnKgCbwswsb9XUH1DQFt+rB8sl0XN+pCYIiUdcejjFNohRH6AeEiKrWUJHp17EZlmVb7ywdXQRwrWqSib+0gVU7TTqSV5idYcCQobwqaSshNNCF95JvwCkj2bOb131v3sBl6RCAP5j60pxCdRVdlbNR2Iczxh87gsDT/9Jx0l71trI5oTvrxQ+gNvvwXO6mnnJp4aYscTgu2BtzR9pwlUWznL2IxNLKQl8kBbiRMbfD45RGCx+KdbhI6wYZKGyoexc5ZslntpdiHolx5go0VNU2/On7Fs2452h97j/vtvAd5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ0TshM2+DW3YlBNQ/Y0MmPx4/ida2FFsiNEHWeXx60=;
 b=q5abrBejSqQ6B+6aRJQmzn27TkItMUcxtKWt+3wtgoNpii2Ms4iAKzVrK2A1E26Rc1JVDz7qPNrN0rCq1k8xIKEdcgnKJCc3+0/Wu7zvBggvGI8SMc3fa67qNtlrcWzkkaMCUrZETt1XywwH1TvOg8jdRz01b1bCl3eT0CuEiBc=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:41:21 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 09:41:21 +0000
Date: Mon, 17 Nov 2025 18:41:09 +0900
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
Subject: Re: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for
 root memory cgroup
Message-ID: <aRrttY5kdbbubmGs@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
 <aRroO9ypxvHsAjug@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRroO9ypxvHsAjug@hyeyoo>
X-ClientProxiedBy: TY4PR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:378::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d6e504-f8ce-417c-bf0e-08de25bd769d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NMJwt/7ESX+QEt1LxBV9WbFxEoQR77W9OtHP7uIjKXV7zAX7k+DeihOXiAq?=
 =?us-ascii?Q?8RWLX4s2hcuNbse2O3gr8Vf7r56yjDjtIP8VLpPCoioxDqENnsGHPeC4VkFq?=
 =?us-ascii?Q?AdSKdlalqEpRNLRdNEx2CTji8nkRmqtmlnV+uO9l3gxp8CifEcrbTFclCvOW?=
 =?us-ascii?Q?xhR3jHvxFezyT7IzoeMvwAmAqJTsA11mGJNIrzYdJumnNZLLabgGeVJ7l/7v?=
 =?us-ascii?Q?1gH6jQhgpMJ29pqRpyMSjZZLbkKkCy1e3Vd61LgxHnJcjsyBFvS3McaTYLNP?=
 =?us-ascii?Q?dsBxFP9Uu2EFa6+l/3qcKUxxUcEPoUDV9/uRgs0ChUkCvVe4It9AVIcB+PZp?=
 =?us-ascii?Q?CiBvx/8o4yS6RyOg8CUQUboP0opZB0ggq9T+k4xzPRDKmz83GVR5XNi9nhxy?=
 =?us-ascii?Q?rx6fn2lxh1lNnoC6EjElNT25+7ciXIb32OG7vl6pJztiIgSjaCjV2JBR/HzO?=
 =?us-ascii?Q?lawQ5nZqJl0yOp5htpNcH/r6ofLDXs6SINNuOv2O2v9bqHrAK+cjgaIkJ6h4?=
 =?us-ascii?Q?Fz8cQTcrsS0EZruTn6SFRGoB47GZ6WpAlOhXcBt1z0U0EHw4+xn0pHGzAB/J?=
 =?us-ascii?Q?u9CKJe0vpqRkpTGk7XjMDPfa+S7No75kpj7Upv9Ay2Iyn67ifS1R7zs4JaIb?=
 =?us-ascii?Q?TacM68wUTFIPEUosU8ev8YB1PE5mFH+z770r+2shwwYIJea2ussftR23Qk7+?=
 =?us-ascii?Q?HBSLFkEWjQnyrd1XWlf3GXAUd+fSPCDt7UGtffXm6K4sVFSouZoH9s57oOUR?=
 =?us-ascii?Q?IHfzgkahX1M8H1vYIJ3L8SaSW+rVnn/YfaBTtztT4eSLzZ6TdX4tPlDUGv7G?=
 =?us-ascii?Q?SugFqUAs8P23IanX0DQHsQyVadUCOJa9biMPnwEfNhR/Mc0b0ki9EFlcvSJ4?=
 =?us-ascii?Q?CdrQNkN1MQeUjQZqx2SeE9FRaNZrEqGGeBRegtoqqnBuyjFb773yMdg/JIpg?=
 =?us-ascii?Q?rGzR8MeFGtqdYzJooKvN9V0IHBFBXtsiuvpU5kag8oyH7SnSvx2Da0QbXboA?=
 =?us-ascii?Q?0fyC2QPkEjb60/AXpEka5TQ2F2mzB/pdm1tDOIFc7RoJsChhUpHBjQsE8axS?=
 =?us-ascii?Q?HxLp3XCmQdu2SdSWXJusDcLqwilNAUkXvAsPF5WtW9LbeFHVIQrpEs/Efw+O?=
 =?us-ascii?Q?OF+NAK7Uqlv3AMN3I42nzG/o+qlj8ksOFjjNvoSx02ixCya/w28hBNNM85L1?=
 =?us-ascii?Q?2xgaI24QX3gvUfSUnO+1hw8sKvuHwYzYszm0veCGWdwhT0AxiTIe7chXMaJC?=
 =?us-ascii?Q?llvzxL1ZMmE9mEhnmf77UoeAP+uDHaoykeeZ/7sXZk+KjfE29nXr49IK8jBf?=
 =?us-ascii?Q?rz7XXuigdvUWmW8DSbGrxayqIR3ZDoxt42yKzeRi16A8jEjPOyRMa+VrDuV8?=
 =?us-ascii?Q?drBxwvgFk3ukXKMk5hlr25FOxvvx36iCVUyHEn5SLM4HsB5CYyVBD1xzVtTt?=
 =?us-ascii?Q?4ws/du+Aj5vZb1/TCJAKsmrv3UuGV/XTwJGHkFkJfF1p71n4HUnlEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GybRVenmIadsF31jEyrecMolxqRF4KNLATUNNisUHurmDqP5aCbYNnnzXQUF?=
 =?us-ascii?Q?vXYykS6amag8SfqnbzdzF5OjvrJb+oTXhtSRsCdHC9yLHVGKJybFfelfwqoE?=
 =?us-ascii?Q?wE0j3Cme4VNGDTpWRg1I3XfrNDHaRBKkW6oO/ldAyGCslqSOeJs8JWvL8UHn?=
 =?us-ascii?Q?Z+HF8V5go8EHXYvFiOI9bEcHAht1FOv6KjPRF5wbCq2ACrOarZQeUcH6OaZI?=
 =?us-ascii?Q?Tx6FSR3uZNCBjR/1ZfDxvSU/fHrAl2Vy3CG9KX7MP6UaBtKEqJ4ggcv7XT5F?=
 =?us-ascii?Q?z7BzfBbVE/nuOTZkgvDnuNQ79dWFhOteVW5t4VgBNFZEL5NS8abfdBZ4qpJS?=
 =?us-ascii?Q?b5s4X1mAcGhPz75+WJJAJqJpJ/3mFBBuRj8DiUjy8jIi7dotA/5utW9PBq7H?=
 =?us-ascii?Q?/IXvGAwpgZLB4WPlRBxvFzww1oTC8tKo3+dv8cn2XHz7qkdvTbzwwq19CBsz?=
 =?us-ascii?Q?nH+Cj7EjhD/SG1e1YnK33TCTHt6WYjQUEEs38pkqWPS0z5RaTz0ENJBcQA9n?=
 =?us-ascii?Q?4hkxIG9x9HMH5PLLiHFx6/09H/OBx3OxZzSqBDntr3xnoqSrgDWhzte8INyT?=
 =?us-ascii?Q?+U/pgF6PE/uR7vQ9/I+n5cYB48K2gB2eU+WGnaHLLlUUdUTl4yk8AqYjjMdU?=
 =?us-ascii?Q?L80IrQvB8/VsyJjU6sebgXogXmr5yn6zHSAN0NgTVx8XFMuX1bFliBfKyAOe?=
 =?us-ascii?Q?RGtXIgIhJvJg7rti0JkCK0PVVnT/PalouMEamrYn1BjlG2H41zGaI+nMFz8u?=
 =?us-ascii?Q?+diq65OcuJhs4zvnywDyseNFPsxf/WMOiEnp/7oZ9t/2mrxhMQ9SHOI9g5sg?=
 =?us-ascii?Q?hBKoW1Kq5HXElLKklgV2L6Tj4oypKHW8hWIitZ3lT0DwLbEc2hJU3IzP9oZv?=
 =?us-ascii?Q?turlDiABGNvpCD/L8cHTPKV7kf8FB5NHIxN1hkOtgh94PzWy6/R2hjwO5nsh?=
 =?us-ascii?Q?wGtsy9KmOm2tfm1nySaF9SWXe3gKn5j+YLFZRXTyFHi7K/NJoLObleh5pWyx?=
 =?us-ascii?Q?GU3cuFPGzAAn2qKF79YsBypIs+SYiRCEZ6DeCRyhAbt7LOt8Dh5DwcAm2kFV?=
 =?us-ascii?Q?avJxtkiS5diT+HegBJHgiVti2laU4WkQuxd6oG4yx6G0YQSVyWqLwxQ6HUgm?=
 =?us-ascii?Q?z/K7OURu0QEjml4MYjbcMb7Mk17XucjiIUX0yamu7H0blxRJmKf5JRi1YRRN?=
 =?us-ascii?Q?04KJBwbHRJH2TY91NF/xHpyhCX7x5i+hEYTx82sNpZg6dcXOeNcnkXg6S0bD?=
 =?us-ascii?Q?7prMThuhtkm9KzNrSmIcimph9aBA7eVgRYhHbtq0W8hDfqTjL9hIrOURsUqQ?=
 =?us-ascii?Q?9kY9jgj9xZ+krKcYSBW01rm+reFVSKDzN+zsV5b5pHbfCSZ5pAAeqA6OfkSn?=
 =?us-ascii?Q?Nj+PrhYuuiLB874GsFxO4KpDBoBFt5Zoy+4PaAvQkLNZcJf2JpN32IxBb8ao?=
 =?us-ascii?Q?tBqZORQmNfJj1/8ZNJnrGtloJt+aGkyrBT0TTDtI/JGBn73FOfoEKuPFAEHE?=
 =?us-ascii?Q?G2UgWf4AkkmHdBHXeeRiflSBjAxz1Oh2GCe6koxOixXs8MRAQuU/AHH5oPbx?=
 =?us-ascii?Q?E4SNPYXWFwhdEHZSJ4PEIWO0Llu5pge4sWd2ifAR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QHT8opxtf83XbZdP1tlAx484PLW45dhV/L8Qp+k3nG+Uzh4lgT8mGmKX+KhzWeuRHpWXPQb3Sqv1O5O5YnASSh6hmxOmE1efOXxyYN1XKFuhlQ1mAlLTCsDOr0iFmks+qrR7TXX+LJPnKxwudKs5YN7+AT18Mf2VdH6bRaivNvhoMZGn6ES2O25Ho7Zzct772nZhRhacTJGluBlm6yLF9NIdRL4gohIICrcYIzy+TJqjcgFvhqPIEqEoQIQ1iKouBpulVh3AR3d+EOSlz70zKdOWrzA7T1BrAHqSSPFS56y6sU6PeUFNMHu5VNZYQ+1PjPbpcQ0rj1TMgDHehRN2RJ+nCIIoyXImJF4+bx1UpFntOktQz/+YCOZDRtCPbRhIXmA33p6sd2AwAN4+KFmFTicIXsLJ5SwZ8dUuNdzCVZWK8zeSHGkFz3akWffE693OnIQM/Uc26WhlkjoSdhSop+CV7cbTmp50hU3yA8iAjkBQrQMe7rr96tyc1uq3iYFPhhSuydHvuJYcn2swALdb6Z0BnayMzVOcfzEllRH/G8IQeU5L4g6mSo4eHgfIF2lI34s0RMHQKlYKqPqvodGjqi7BYZtj36aHUloT69jIP/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d6e504-f8ce-417c-bf0e-08de25bd769d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:41:20.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi1DrDLcEUOGdofceIRAcD+aotBR3l1rFS/KkcFWHxcJpRd54E+9S8130hehVkPxi+GqDWaw1g2SfR5cGT3Ljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX2gALMXY1b2Oy
 BOjndhqkxDf6XDLqSzmhA7ODTUKdABsgf99qcI6DHh1WXL0EmjNS2jVlMmT+SOephROBqndZCxr
 qaIg9iNsR0K5l3oH+UK4Vt40G6tSbbtDFUrVHIXz+CJcJWm3w4GClLIDE4uQvkI9gDBAiK1Etn/
 ENWVucvgXp/+93KdHKVatoBAWUOC/zpNZfAmkIs66ayvgD4qGUyl4T+f2nPm4xsacGx5YgrXNQQ
 Tx4/L91gzlkoIYb8LDdK4aG7SG4GMp7xGpgECNDHwWGbTHKjlLDQozhW/h0ebTSN3CbbxgPJpPT
 rwF2IrzNe84vXRqU1D5pRffw3O39PuhK9zGJdI48tjNauE49r6sR491uRiaRDGL19TmqGPks9Vp
 utC929cp/rqFOxDsK77Bn59QTPq3iA==
X-Proofpoint-ORIG-GUID: 76huLt_mYUb69-FWsJ7MOBz-kcnrSFVH
X-Proofpoint-GUID: 76huLt_mYUb69-FWsJ7MOBz-kcnrSFVH
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691aedc5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=nMxWCna17N_2zbbx6cUA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Mon, Nov 17, 2025 at 06:17:47PM +0900, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2afd7f99ca101..d484b632c790f 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >  	int ret = 0;
> >  
> >  	objcg = current_obj_cgroup();
> > -	if (objcg) {
> > +	if (!obj_cgroup_is_root(objcg)) {
> 
> Now that we support the page and slab allocators support allocating memory
> in NMI contexts (on some archs), current_obj_cgroup() can return NULL
> if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi()) returns true
> (then it leads to a NULL-pointer-deref bug).

This is a real issue, but

> But IIUC this is applied to kmem charging only (as they use this_cpu ops
> for stats update), and we don't have to apply the same restriction to
> charging LRU pages with objcg.

actually this should be fine for now since we use get_mem_cgroup_from_mm()
and obj_cgroup_from_memcg() instead of current_obj_cgroup() when charging
LRU pages.

But it is not immediately obvious that there are multiple ways to get
an objcg, each with different restrictions depending on what you are
going to charge :/

> Maybe Shakeel has more insight on this.
> 
> Link: https://lore.kernel.org/all/20250519063142.111219-1-shakeel.butt@linux.dev

-- 
Cheers,
Harry / Hyeonggon

