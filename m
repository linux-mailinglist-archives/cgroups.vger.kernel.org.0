Return-Path: <cgroups+bounces-2176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15988DA62
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05FD29576E
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4B381C7;
	Wed, 27 Mar 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P3T+XEQl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MfogU/tT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF250F8;
	Wed, 27 Mar 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532451; cv=fail; b=MOoLAcghblWfkeAsnex8M5NvEzXum1Zn58LmgP0jv5fPexoQi8i7BR4BpXycuwjMvQCRghzXyJuIU4cOBsq0FzkS3Db61gUQ09LyMvfg4It2e/CThFIxxjMNrJed9kUtdUO8gUFFtVqOlvSF5SotospGjMplQUMD3qV86J+dXIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532451; c=relaxed/simple;
	bh=M6/uElKeFj991kp4oUJLEtdRDxwbHun0G2QX3xIRl2g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iedTFDYF3HsfkpfQClqDP4rOfaevgUnrEkU0FZ7zhgaOPTv3i09GtWe+TrMQE/tcBDFpw2vkEy8lk9cZEYhwmWPKrH6f30vNI24qHBKFybPHhsHUWfjk0gdeBO+ut6xFVJx3s0or4E7elm2N7krVNbvbbQinu+B2y2JWvmRO2rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P3T+XEQl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MfogU/tT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R87poc020072;
	Wed, 27 Mar 2024 09:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=t13SVpey1+758vD9d+TsN2cwv6lVOfVT0b5QuIFkSRM=;
 b=P3T+XEQleB/LGldp1zAtsC7OJF30bRYUSiV9+fy5YzpHqPz+HdYQpTfRTW+ZBfUMWvvx
 Y0eeta8Z9H3+JIjLJQnSbvWyIh+bHkrHsDcJL73sYUjrxIqQ8jh1ZsHWoogijeTFHlfb
 VjHLf938iaE1P1I4OvKNt17dtxSXLF73Lo/eVM7NWVfbLTjNn4zcL8SaIz50ORW+ryqf
 4RMzzjndORWJ6LW5f0DrmFZ0P3pQPrE46WKwsbYfZ2U4cvdgQwPEn4hTB4pMm1GXmau5
 i/cH2ps94rl4RQz03WaRAi4kIJa1QERJwao409mOLTAoF2ikFinfVGzygG0nfo+1HzEH 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybpx4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:40:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42R81EB2011583;
	Wed, 27 Mar 2024 09:40:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh89h34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gof9EwsfhRrXhpWH4T2EtTJj4Lx89hBWQnFkwMj6Y1SxelBA863mXzOWHXQGOTLE0NCIP7X2m8EpYd9HafTRzTpfJZ6xAUGzAdtqrWtivB9kHuTwsjvIHxD+qM8G6wE+O1GwPO8SNISn0XlCgvTHCv6pmlj4bb/4CsxNCtiFe5BjaX725vVUlxIXGvPcS2f0fcLwfZwGM6aasMzG5d2hjDAiilpWYyQLzJPib983GAEBv8nVEzoFoZuQxk5VpMaRCaN3RCuGElWhwac6zj30juma2kcKf2UZcD4A2NNQbw91UiYWjks+mKcNGAIvzcdQwmP1cKd3EE1ZPLbAJzhPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t13SVpey1+758vD9d+TsN2cwv6lVOfVT0b5QuIFkSRM=;
 b=Xb11U2lLY0P41J27E4gUkhHJo6GC9V1jFj9wIFR3BFrcdgU7dyYv1X/99RAfKsBwsG60loRCo1h0+1X5rejiLijrK5u/jfLWhbjydJ/0xhLOe+akiBULNq2IysgG4YzSHbhVqj1h/tVEO1r6suzm6EJBrp9evg3V6GKgytqLweaUGgIls6gXl5SdyABh+DX5rTy44zzgueWlmWxYLsLPusk8etYw2szIwmuZ35ZdS36HP7mj6CRU7VFAJeMeW3YAqR0nBue7C1fYqO3Stv1Ccr9Pm5q3p+pnfH6ZyJzPY3YDvh7clXJbDTpQO6WNlid8SpT7iFwKA6Kx2cOz8SIzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t13SVpey1+758vD9d+TsN2cwv6lVOfVT0b5QuIFkSRM=;
 b=MfogU/tTi1Sb8G/TyDKggjnEP0b+HprajdNEo8tg+TqbobnXU/1PvXG4z3y/P2a0vrD5+FMmMTXr6Wt6/IjeLiOP+OZHDVtKJ9omRS3cWo8bMElwk3DtXWNrsKNzRLFeBTHDIpr1i+n2wbOoJsUH/Bjrjw31gIdRPwA/VrhdNK0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 09:40:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:40:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com,
        hch@lst.de
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] blk-throttle: Only use seq_printf() in tg_prfill_limit()
Date: Wed, 27 Mar 2024 09:40:20 +0000
Message-Id: <20240327094020.3505514-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faddb41-548c-451d-4769-08dc4e41f408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vHQu8KUMtUtcRxvkF+t71TB8UKCkPi2+GhXMy99D/5LvhL3dfwKwVPPfdHYtWdpaaPcU25azF28ly9iMWJfs2g7J4IzM0ULkAVcj2WtEog/kbeaoQ1hIgKlR8imDT9d8eiMLU3V6grUhIXLqfRWlDDkZ5k/dWJTIXdJLyYOOBeSCVEgUYjlgEZZVNlScUEUgRQReEow5ZjEktpJfDmWfiV070wBh9D5oNbR3o3DfxBDrYpnP93/NYBKcF2Sj4rVKhKhpMYGyG92Em7bvBqR0FBNg/DFjeFkDttAz4yruqrMDFmuolyoxbQEN1U7MJ5phVmRZ/Eap9bF89vFuAFwgRVZjId5+LaL3C/XK5s5gi3cuV6Y9dnEoO/RTVsQpGWTdBx5cO5bF3L9sy+/pJDoPVt97h6rihWQbmw6HNGo3ZV/TYTiLR0kDcJjIwW4oStY27ueNM8Qu5uvHDJvlM9u7zxDOnZKyPIpEiv8FH6MzvbvknPyhiSn68oxKyqfCx00ptoe6psToJYNScX5CI/wHOFXmCjL/+GOIrN4nxIc//KbtaLTVOce5juss1ywZTOgkLPoFGOZ8zBgXb3og1My6F8lS6ZKaFx6giF2dRCO2AIkIHfNngprCirenZoMsVmUcc9ZD1kXj3uPpGRVMrgm2i5FWXtQVELoBbnPlieVGvo0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hyuu82Xam1gqitWRBP/uvPu4CrnIK0KAPc5zAiXzkbdUeHZF+qiMwxtoAFzb?=
 =?us-ascii?Q?jHi0xoaexYGnItF6nSweW31nT294uJRTy9BKtQzI2WJKfhTIZEinCRULIMeS?=
 =?us-ascii?Q?znIokqFx8TIZR1O+BGjjKk6vbIjKZCIAaGPHdCqGhrENDwObGm0OYSbDlsi+?=
 =?us-ascii?Q?zvnsangsjRurQsevGAbCLgyvj+i/FlfMcqO/1rJO7GrQNC2AH+VDrdE7PeKV?=
 =?us-ascii?Q?TFhOVFWMCv/eBX6aqUxCJZ5JwZILVKSNtK7XmZv6h4lyDuLnO4aL/v2N2jAt?=
 =?us-ascii?Q?aXxTUX2bJgzEU8Lb+pbMeu4i0ddakZoQX1oamMRFpRNQTZn1KqCFeCNHqDbf?=
 =?us-ascii?Q?Ft3qKRWlag0Ysm7XLkDZJb4qMaTVOamwK7vYDeYGZR/W8fomoarqLnZhDPqe?=
 =?us-ascii?Q?QlKQJ2RmuUvFEihBp1WqTOXDcfnDD/yCnvCy8ZewX0NrxJTcX4CM7GXt+III?=
 =?us-ascii?Q?Z9A+Ons39NiW+SwbZiqQPZeVyMPq6I5XK1oz4JH/sheJ+rWA9s9r9974KJEM?=
 =?us-ascii?Q?PBhClouFPYNYOdShwea7gTtu4eahk/KBHq8YBKx/CLSL/CsNBtqgTRkXAEHQ?=
 =?us-ascii?Q?v/zvQmK2BQfxTwYYNCcLt602XCiceG9bB8KGEDfe0QkIqtAJyuhRkjrz4EKE?=
 =?us-ascii?Q?YQGFsxDL7LJl/MqhqsL15BSbezTNW7hr/E8zWFPYdYw0XaxvEXPIbEzCYFGr?=
 =?us-ascii?Q?eVtKJaE2CbkznMqtudL7rIN+Ec8yMReS6XSO3w1moQRP+SfDeuwgBT3Y/1rI?=
 =?us-ascii?Q?Q2pjPt58r0WacO9Evo/F1CoSGsjY3DGty5+EestuCOTizO6U5TYMWnDV4yhs?=
 =?us-ascii?Q?bvPsJFeWEJfciUOo5TGKL55N0UsanJYsoNHUSssAOfENgOL2FPdBfisxioch?=
 =?us-ascii?Q?gC8jqlJYpn1LAJ8x31Wt0pIXpmYCUuvERhO/uj1pG3AhWLhM7N9pfoDYrYaD?=
 =?us-ascii?Q?EmbrOEDMdqHETZwk7vmaeT7f58qaQySKbJA4xs6tzGbKloUfiCJym64CNhZt?=
 =?us-ascii?Q?PWrxXZKKlM9HAmPEvIAp2Uq6lfYcKDJGhX2xgLz4h6T4+mBhFxrGHWUmKSMD?=
 =?us-ascii?Q?7TT9QChx6b9iat8tTMCVlnlbke82TB5UDOCWpE6MEh+0sDKPtIi1ZvSAzILl?=
 =?us-ascii?Q?7OkNKQ2oMKGPFEJ8er7bGOJiUkJVs2uaTHs0PQ56c8VdTSry19pqhpy8VUX6?=
 =?us-ascii?Q?IxxJheP1v5cifUpLw14KS9+hl3cU/uOcGzaTf2xkxCNRJEttPP3el46nREvy?=
 =?us-ascii?Q?/xJ8+4LGV4h3dQaa7gp52KcJpt2CncH3gr2Yw+evX99W5GD74VlnDtP8NIPF?=
 =?us-ascii?Q?BXDSWT2/p9EMGRMYJDkUNZt5MP3DmWyVuj1/CRXqijYZfQR5BDSgVzGT0kib?=
 =?us-ascii?Q?xtjRuDE9UDVlVYp6Y7Tjr6SPSDSriN5m8EAFB2fxiIO29tUbLsiyI3nepdaF?=
 =?us-ascii?Q?HDuo7QPLuDfx+A0lxQ7vegVkgOUzhnriOmjYhoTXere3KJdcUqQI6ZnbbnoX?=
 =?us-ascii?Q?OxiYf4wqwdGOVslZ0WBHCUQy6EMj67QRoIvaxhDZbNMLnyxz/ZH8Vdih9FFA?=
 =?us-ascii?Q?aWUkH3kHyrjv0p3l25a8lNBsD6Q+byYN77zKg1jBGFDexzQ/ikSB4gLT9Yoq?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0WYdovSZLc0qCz9qM0QSsCQj+hbirXARZKweXFB/0InTyhgfuWJRYLkkCjPx3uRd9eabVUb4c2wGL2HIGFEBDixLCrZmdf3nR2xVtStwdmxn6RIMh5v/2GeF20NI7PUJAQDMGUl+geKX5R38CekZcU6S08MyynOQToKBMt0mYQH5HiTHtTsjHM9k5Shuupa8JKOLAjanFUs0AKL/P1dYeeFbHNy36ZicUJsvayFFYs5mAW/KhVOA0XwDcGkO1g4vse1wHKX6uB2KpVmUz5vDyAFPk2vWqKTorqd3cFx030TVTTbk8Jf/StQEW0rMdUYeWDNwZUJ8Pln117DTf0kWFowwz95n6S1mzEba22M0lpL6UUJQqGENQVeQ34EeRx54ptN7DzCUbLuGr0pDNirjKMY7CUtrhn4Xa2lSBvZfDV4Mf6t1YyGZYJZTUbIhWjcTIo3XIso+E2XClqpZSrQoQ30dH7aABBdGFIirCENZEfGAbytMnNZn11gIXIU7jw6BzyjyEmLS9a5CKwBP3gdMrjYjglAg3OaCzJ1axO7TQXk4RA/u5YIE+/KtPE88l6ltfHUOIfrPhSuapErSLuDVEFPGrIH9EiTO9tLcXkJ9d7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faddb41-548c-451d-4769-08dc4e41f408
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 09:40:35.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Gm4B4+8f8mZ2+MoG8hPQPCNkw3bdExNdndO4wgIbdU1EHxE2JAPDNkdQVvPXzIpJVH2cBHULTIIsGJidKn5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270065
X-Proofpoint-GUID: 1cye4obpclOcxakD_1zENCx7ebGx27Zg
X-Proofpoint-ORIG-GUID: 1cye4obpclOcxakD_1zENCx7ebGx27Zg

Currently tg_prfill_limit() uses a combination of snprintf() and strcpy()
to generate the values parts of the limits string, before passing them as
arguments to seq_printf().

Convert to use only a sequence of seq_printf() calls per argument, which is
simpler.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f4850a6f860b..c515e1a96fad 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1494,11 +1494,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	const char *dname = blkg_dev_name(pd->blkg);
-	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
-	char idle_time[26] = "";
-	char latency_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1520,35 +1517,39 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
 		return 0;
 
-	if (tg->bps_conf[READ][off] != U64_MAX)
-		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps_conf[READ][off]);
-	if (tg->bps_conf[WRITE][off] != U64_MAX)
-		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps_conf[WRITE][off]);
-	if (tg->iops_conf[READ][off] != UINT_MAX)
-		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops_conf[READ][off]);
-	if (tg->iops_conf[WRITE][off] != UINT_MAX)
-		snprintf(bufs[3], sizeof(bufs[3]), "%u",
-			tg->iops_conf[WRITE][off]);
+	seq_printf(sf, "%s", dname);
+	if (tg->bps_conf[READ][off] == U64_MAX)
+		seq_printf(sf, " rbps=max");
+	else
+		seq_printf(sf, " rbps=%llu", tg->bps_conf[READ][off]);
+
+	if (tg->bps_conf[WRITE][off] == U64_MAX)
+		seq_printf(sf, " wbps=max");
+	else
+		seq_printf(sf, " wbps=%llu", tg->bps_conf[WRITE][off]);
+
+	if (tg->iops_conf[READ][off] == UINT_MAX)
+		seq_printf(sf, " riops=max");
+	else
+		seq_printf(sf, " riops=%u", tg->iops_conf[READ][off]);
+
+	if (tg->iops_conf[WRITE][off] == UINT_MAX)
+		seq_printf(sf, " wiops=max");
+	else
+		seq_printf(sf, " wiops=%u", tg->iops_conf[WRITE][off]);
+
 	if (off == LIMIT_LOW) {
 		if (tg->idletime_threshold_conf == ULONG_MAX)
-			strcpy(idle_time, " idle=max");
+			seq_printf(sf, " idle=max");
 		else
-			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
-				tg->idletime_threshold_conf);
+			seq_printf(sf, " idle=%lu", tg->idletime_threshold_conf);
 
 		if (tg->latency_target_conf == ULONG_MAX)
-			strcpy(latency_time, " latency=max");
+			seq_printf(sf, " latency=max");
 		else
-			snprintf(latency_time, sizeof(latency_time),
-				" latency=%lu", tg->latency_target_conf);
+			seq_printf(sf, " latency=%lu", tg->latency_target_conf);
 	}
-
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
-		   latency_time);
+	seq_printf(sf, "\n");
 	return 0;
 }
 
-- 
2.31.1


