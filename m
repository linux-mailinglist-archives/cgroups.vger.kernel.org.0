Return-Path: <cgroups+bounces-12115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94360C73436
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16FEE3581B0
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC20315D22;
	Thu, 20 Nov 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="je7I4kZ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I4gQ0mRR"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8026ED25;
	Thu, 20 Nov 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631694; cv=fail; b=TZpVz9m7Fnzug2zbCpm4w8CrkWhgqYrnGSAE9U/WcVgKs16zGYTzFJ8CGaD1iKnGsAsefFamP9fFOZZmHphfb3imtLJDB7AG82C8Y9vg/8QlQCPltdXdRNXMCQyILVGFC1SWk1d0p8coiK3aJiIb/phoj6eY6cjHyzUXaLdFD/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631694; c=relaxed/simple;
	bh=AvX9BrsbFaIOgI9fR4mADYER+s1UNiSyUOK1cbT5yNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrWvXlvrTlph2HVsF6MNwO3AOzgZO73IvfGmEY6GxCfMuofR1Huyfady3rzL6VA1cp4ifi4CI9Sj046/m4kkMiU4f4uIMc50u9e/iODaSvc3YkBQ7PsES7cRrANF3wNvsVrBPQzvfNdqlif1N3Pv8XEEoDDR5mzSBCnyVPGLDok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=je7I4kZ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I4gQ0mRR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9MQhe024131;
	Thu, 20 Nov 2025 09:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JKCbQPWhNRu3YsTvlI
	ClzjluYm1zzE9fasFhf8ghCMw=; b=je7I4kZ3RPN+aGpRvONsjtONf3/2lu53Ud
	YD5IpYRNptU8JqEDRm/uEUOOr/1nXTVOrz4peRg1jF7VC2uu9Q9JtW9I9em2FuGz
	1gJQXL5GvV4fyIMChoEXWWK5l2DT24PBpRwGXpvvhC/qDTBy+ofuG2o3GIxqtd+I
	cKsqjMA2wm6K7U6GhG2vfvcb9RXrwPwlCJj7wSng2yBhcZ2zJRzRq3aVKdZmOU3n
	VNInk55EbXYY1o0kzlY0sC4M93gQh+ThItSSBQ/UKgCo7E2RBCwlZqUt0LIGPO+o
	tjlhO5kv/TtGlGnP9iiX/gCksJsXeS8AC9oWp/q2a3DaDmXOl8Zg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbc0m6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK98f1w039959;
	Thu, 20 Nov 2025 09:40:59 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyp4bay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRerDEshFAf/SIwv8aOGDDKy5/n0PPFNMiVSDpTuaDNj2CHgKEwZn4WBEb3YI4ly4wFJ+vfEBL7gdSfygGP6DOk1TZKE5AiOESit9PDHSvxF3zXVTm1NrMpxLO8NFV3VmpmWhRN7UpSBjfdI3w2U3zyUFd9J4IzoO5KFcYsrW6SufGCeb/14KKdy2P6KrPqixhxbsnrpBc97j3o2WSyVbCiuYTHgZMT6jnVhMkTNKzGnqLcr5ivLuETU4hfyQeb55gveK/ky0E5ZUK1P61JmUF+qpDsF5IoiPR116TkjE0Laic4hWibbb5k+0xIoHxbS0HNRYF1NB6alMqAFEZa3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKCbQPWhNRu3YsTvlIClzjluYm1zzE9fasFhf8ghCMw=;
 b=iLlmuWcmvY8S3X46zX3Yifb93/3gkAApU8mOKa4lhzjDIyqJ386tNDuQTxiZ60JUKZcBc/mK3EbgvIHBFRhp3jF2XIu8NjwBmxluqjg7V5CKQFB8BLo24bhqivYFb+7pZtl5sjiUhOIXAIg8V+IbhySH1ol6scXsAHbFxOOr5MoUx6mr8EUh+1HNO5ZwFhaD/Jv5NnG7DrW1dHu31RI1/ukRWMeRgeAalB/BMWO7CaJSSN2L1Lyov95PPJycjkVeD9Hx/qEj/4E23Kre5wRDW/3/VPQ8u+jRBd8bp7khmSUINAX0fgDbMw0Qg26U4+LbBermX5bu7SgcTw3pR9vR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKCbQPWhNRu3YsTvlIClzjluYm1zzE9fasFhf8ghCMw=;
 b=I4gQ0mRRju7etndDjQsuZz6VsVE36c/Ovu5NS9KbWt/GpGnHNHkoWVlXgNqSIr6iQtW5TVUE+oilqqZ26vvqrHrObSc2YJZoDJfswVHnHJfzzg09O+CBRvHyrMn3ePGYK+UPRS6xZqkk4uv9IMxZxaJ1KEvfhruSsQw8gwY6yzk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 09:40:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 09:40:56 +0000
Date: Thu, 20 Nov 2025 18:40:48 +0900
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
Subject: Re: [PATCH v1 17/26] mm: workingset: prevent lruvec release in
 workingset_refault()
Message-ID: <aR7iIKqhg-B1vgfR@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <7d58f7f924961bc9ce386b3101448a49d7aa1daa.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d58f7f924961bc9ce386b3101448a49d7aa1daa.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0182.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN2PR10MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b68780d-a40c-4876-dca8-08de2818e798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtlBAZzuKwZ4XZifZMbwPMz5mV+jMzY1J4UYotrvoqBq6bcq/xqg9RQFgCI5?=
 =?us-ascii?Q?+dn+naOtl+/SG6x5tX+8x5MqjRmuLAtAJ7hT+tyCboSCtFspIr0vbCzmHfEs?=
 =?us-ascii?Q?atuoT2nJqWJgFm4zwLfY31rTw1OSJKKZu+vUzA6GiXysiu/3Wn/Zc5h4jEpp?=
 =?us-ascii?Q?e2B12wG6EB5h965cHFcV7gG9stHzdqvadgQYWeEtuc+d64qMRGVWwUR6C4/B?=
 =?us-ascii?Q?d4V3h0gA4UIwh8ruaACvSK3ddr6d7mSd5zGezmdgbwQoDd6f8A60inhN5ZO4?=
 =?us-ascii?Q?CW6UB6os8MsyWwyare+14sBnqy3C0+IxKaY+ctnAzG/CGJJVgIHF8jQdIsho?=
 =?us-ascii?Q?XmDY0UOG2DQGRP+jrctX7L6vDViXujutU+XUO7ESXpkThReRRZhhgDtUeLPb?=
 =?us-ascii?Q?UYpUf7GddPK5cNKLONbjXBVSjbup+fUFGLT8b4hP+SjApYujEmqzOUbCoLo6?=
 =?us-ascii?Q?QdyMcijzDyqhiD6CNjR2x5cNUQLsqOpxRVXC7fWvHqHdGTXAKt+2+RK7nI+R?=
 =?us-ascii?Q?eL6rhfEJItrl/D5G/xvDMCzrVlSxABPhIIJwVOWsY74MOfFZhiLi35onJOT1?=
 =?us-ascii?Q?EWnGkAC2j4T0FXBdwF9QPy3yGhJL1wYjEtDT4blMIOmtLb2fz6ophMcdagb+?=
 =?us-ascii?Q?wz/wuNMZpchxsdg2dY9U3/hlKrLA/QcPFhEww8RRTVXUOHxCWedSCq4kcO5z?=
 =?us-ascii?Q?BY00t/Vmdb6XDbpQ3ugkbsvyZEQUyi+3YJYUp8toyyvgc9Mq1w4AW+SO9NUK?=
 =?us-ascii?Q?84zPtFQJ5CNWTJIqL0U7PXXYxE0bUdATWB6f/WAdNH+47GJX0kkUoMAJ4U5C?=
 =?us-ascii?Q?hkG9AmPcQo9SUvfXi/L8oc96lo4Lrk/tFaur66EooInl6UHyd3A0lS2Z6YRi?=
 =?us-ascii?Q?ujvglyYceKOUTU3ck+zJzzCCpQr1yEq/vBqDDSPnPxpCqFFvo4/S2nueq8ho?=
 =?us-ascii?Q?TWDVwZQ6y6y5q7CyzLKEWyS3uGAfldq9zU6QSag1/1jtQO5FyTcNcolOQxH+?=
 =?us-ascii?Q?sqIL+l9V8QrYKLA1sJFd5444N7EgKzlIZ0JXJ0dQ1nY5RwJzZYcT4McqmNg1?=
 =?us-ascii?Q?XjUJWV5W6nC9va+Tcbww7nuk6JIvPV5+tVG5PRyRqbcNGdxZPMO49N5jI1K3?=
 =?us-ascii?Q?uuGcWusEQlKvNm7fo+pNkDCTqxKsc9D3LwP5FXcqOekqCpaZ+AlFUBywuoFU?=
 =?us-ascii?Q?PDTwbdjpXCady3LNAA7uLZ/gykdyvIib91yfVr1Cd88RY0hW+3Q/fmE/EhuI?=
 =?us-ascii?Q?BBAbRP4w7hbwR6dA7ak1B0l4iPqKUGCVCtzJrId9+XPNtfOySBkPFzDa0ai0?=
 =?us-ascii?Q?N1J3wtGKC+PcbyDMq3J7I9rmV3ojz0mhUcyuJ6hBE09MDgPIkTt/MsGrwfpA?=
 =?us-ascii?Q?f4zzIWqg0N9ZyB7In2p/1F4yqnEPexo3JMxwFGKnVtdVt/4mjU9Ie+luCigY?=
 =?us-ascii?Q?sns3a8QPlGTk9ZS+dixyvo1ZW/yMD3bX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSQMtVUapWYJKiBk9C47azGULwzsqS53CEwF1bhpiQwVxeI0G+t/rSoM6wer?=
 =?us-ascii?Q?j+jJSShFxacXq5w+/1wlPGv3wvwZ6V9WYLYdbINysOU46ILG9WGDQhLCER59?=
 =?us-ascii?Q?DAqu4FZc5xH90NYdAZhb1UgrlyY4e0Gwq2yfhqtKUqxeHNzalQukosZWQFJd?=
 =?us-ascii?Q?wkc8k3wNdPC4uF6UChDaLoH52EKWRn4smeKZE9oTD3jYBdhIs+nJpGa483Ny?=
 =?us-ascii?Q?WvNv4NiOBnFON9oWxOwAIylJhCGeUt7wl6nZHRHP2pVn6O65bnVhvk5zNEU9?=
 =?us-ascii?Q?CyGdATTJMuf/qC+/4gdc7RDW1eUC2i01/P0Xdvhhp/pTqIRVQLQ6/BcNKJVn?=
 =?us-ascii?Q?qNS6ylGSBzeQcXyMEU6GsTicbMv1PxbBaMMp1D3/nrMxw1WIP5jCxrsyUdEq?=
 =?us-ascii?Q?KKQue4TXJzO9eX6XbrmgCQcn2oZ9Jib3mvolTVkzyaapF9RArNiY4dVnVbQE?=
 =?us-ascii?Q?4Vg0mTA0jX6QjLYv8MRBZzdOCeGjDEm/t5ZaQ/JWcUCcObrPuDPiMHLR8oYk?=
 =?us-ascii?Q?fK6txYALD9CbgAERvaT/qrzgQZ7PLcAs1fKRs5m7NmqBFB4nPQns8yyXa5yR?=
 =?us-ascii?Q?ZUuzV6jWioDaGGXQdfmwGgcAB+S/PNHbhWx+J0lk3zdiV/62b0ipa8DZIIXy?=
 =?us-ascii?Q?bu9r8uaZ5yZWVBbZ6tUx9RuGBv9PGOhdPem0xYPxr2HrZV4MgC0nx14GRBOn?=
 =?us-ascii?Q?dyNDdASy3YhwQwLaz4fnpTXXKzhNbXPv8KOSvbXHVP8z2ndGNpvyKX9rXs62?=
 =?us-ascii?Q?2nJQQ9l4luIhqPJuMJ7P5eT7P9ble7LrQZZgUf21LagSWLE+mMY7EZTJM117?=
 =?us-ascii?Q?Ddx+P0nW7benQEJxq4IJjOPCjDsk6FaMKlpVPR79ccF+0kzTdZcZsx9z0emI?=
 =?us-ascii?Q?aGubGKrrZwXVJvBTozd2fDWHn6yeuQwsGQs9CEc0u/3e7pEeifXjkGsp3l9l?=
 =?us-ascii?Q?6Qqyy5gWY4hymKcwlPKCrCp41Y2YtUc5jET55tfT0i1HzUG+uBOrAGCDRR5Y?=
 =?us-ascii?Q?LyPWa868z4zWACo4AUWIhq+ykmleayUAmekPtXBB+yRwOrD/Syeshnyux5wR?=
 =?us-ascii?Q?qOuU+nQRshBd2kBNI74j3NHnX3dzuu1W/Be6h0QZDeH5Z4phXtvWl/0nm1gd?=
 =?us-ascii?Q?BxnYjYd+AJdP4xoBHXlb/HuHRURc624o7z1d/CuopDNuF3V3FYnG+RtyUmD9?=
 =?us-ascii?Q?5bFIZbjE3a7YMzJU2SJ6RmYSp2w94AlhNn+TRkxY4tGXxF5585bBXhQygb3b?=
 =?us-ascii?Q?nqQh+rjvN4NsesmPaRqpt6ijVPnaOOXdUn8/ZyPkQ8pEOSuJwpsSx2LWPnsH?=
 =?us-ascii?Q?bom/kDBAn0mRqS19hT8xdqlfUeL8YBzFFG4FcBiYHGESFMxLm9HXIb2E2VUj?=
 =?us-ascii?Q?PO2aBd+J9WOf0rSMflYMw6lPgCWnSgsMI0TTfJ6NTLzxkoylOHcF5/tbmNNg?=
 =?us-ascii?Q?XsE9B/I+XGNoKYPK0jjJ32NYd1KO3oD5Cw9lWo4LzL09hUMPYq0oUeuEMGhn?=
 =?us-ascii?Q?SqE2+xiD1K52PWAxBg1+5TVz8VxqwZ58N/HCDD01ThSfSpQENMLfg7Qxxgo/?=
 =?us-ascii?Q?07dyR3Vb5L0S2CCyvwGqP6OTBhbIVu/SCJX7o4RZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JcSl1WgTkCrt+7huCmbqegRq21+OExCleXotCoz+3Y+u7brGU+ABKLxP9+4Z3d9yoF4PGX9b2Pq82+CvsGlZH+v7a7V1MXAgbx18HUECqMrSLDsDblaEz/pEgJCtj8D51RW+YR58JhAJBNjhld80uZ6CKgEgDZmYEwizrE4ItmXap0mnJddkrazEH3WmT/vJNWsVIFg/c7M5Zuloi9dprtVRnDIfc398VXTfuRbXY9lVPi5VWf85Dlo3VvCvejphvWdRBwR+E49sTK0D5j1opczgRq+59+bZuTYO84JfctimKbVH1/am5nWh5x5fHg+KxBjo+OXEQ43UAtW92iOz6RbzivdNpSQfARcKo4a79xIF+7ZWXlDKo7q6Lyqf6nkJmOhOzrFMci9DoKfUBENGZqtKBRq82fU6vf0NOSCU1i+MqD4BwDVpAbyME3RVQyaAjXvHinfeL1D35v0mNUWagt7d/kfF0UcALz9+rCjmwoHqf9RpzmNN+KHSK6WIoRTLCC/lh+B0qIjPlwt88l6Ab+tS5BzC0544tcMpgB0YN/xPrO37KZ958iBSzSeurJ7S4lhI9I5kQ/RxggyYhgo2gqu4nFx+pYAhIlm99XyVwEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68780d-a40c-4876-dca8-08de2818e798
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 09:40:56.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtD1naYR8H3IbS6jwvbrRKGvSTkTnJkXMbKQzsRS4hC63HFoQlXMmMDZeoRYERCN0O3Ix+kl6QuWQZUZCNj7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=951 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200058
X-Proofpoint-GUID: SyubcZRkb-Nu73mXIV96q0tyGB60mN_h
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ee22b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=W9BqLgzXg1EqYeH4nf4A:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: SyubcZRkb-Nu73mXIV96q0tyGB60mN_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8YqNTHJeLKvB
 HmkTvUjEzR+XNm0ZPOWbGTEYYJU1Tl+6ETABFWg4K2io5ZtmTYJsg4WX843E1aEze5unk7DKkMZ
 Xt3co2UAagA4Nlb609HrNZVhidoZOHQ+hW1CV75E/Dbkde2BiZR18S9eIkLLo2tj9h5RNEFr55y
 zxsrRIpnymo+iU+nK2MPU75PsphPq9/VWeQAnJajDxDOzuM54TJF1J0nLYZgFrtm9/LPpI5icQr
 qxR0czMHulCBp4oP7Uzofd6QjT4BrY6GmoxxGqdJ5eIQsJ43HqbBmxmLEWDb4dx7wibsZMx7rqA
 IO5YAPVlLyOU05YWD9U9wPSRGI0Ezloo0iaPMSloorIuj35n3NlE/Vn3AzN0cAYY8Pt+wvbzjR/
 GW82L+G7Xd5TjSawWJieuylfrtaAVOf3Zqjbj2QuPjI8fUcxfPU=

On Tue, Oct 28, 2025 at 09:58:30PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in workingset_refault().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

