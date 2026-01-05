Return-Path: <cgroups+bounces-12918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC6CF2536
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6423046F51
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893F2E03E4;
	Mon,  5 Jan 2026 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctgwU0mW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YcADVkYz"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F12D63F6;
	Mon,  5 Jan 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600271; cv=fail; b=Ud7nV/2HLOPSZpaLM7Bfg7bz5B6wc4tFa5exu/y404nQLA9jRNsMypl80oSu49G/SjbtSiY1009M8ljPRYjq/jgKmXSug4uXaoqEDNf5FlW4Hlk1giCnHQg9eNhXwGVFt4epTtRWQGyu1PyxCteiEtWBNoPbZvhow9VEdkiXups=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600271; c=relaxed/simple;
	bh=WNFLKPcPvh4YrXB8J/pg7MEQr6BB4vkKmMobNiuKiCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqpL1RpY2ML0DJx40JtESxUxGTJ3WL+wetbm8c/svUB5pKNXUJhgAPD/Y+8l47HAMrVKD/kfSNVo46WW36INnqvSCAPUxskwNojuite8iL1x/0WDDyFlrLvggU1GKSzQYyl7pdDeDu6EHzcmO1iNNd9sHYYMOblUJR067ZlewPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctgwU0mW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YcADVkYz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6051BecN303509;
	Mon, 5 Jan 2026 08:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5175iRdb2mOfqKCIXVMMdSqeQl3S9QkYySAuY2vdPTs=; b=
	ctgwU0mWV5j6XLP17TqE+AHHlrX8P7tdCFC70ttoRnmPCMASx8wRlnHnjnzakP11
	GDFLSHL6rPKmDQJzUTuWHLsP91Ar0ky4uBn/wNL/MaR3yDTEyx+HiERJ01hrJ5FT
	atBYIfBXSB1OwG7n40Anpr9jkUpu8TUQ+cpV/A2qwhzvsuls/4gm760QV9VeckOn
	B5gyr6PPgIK8XfUBQNsf3+QykDQE+lVAIWhbT6Kk865/1wTGz2it4g0iWnrM4Qm9
	wzVTUCRa0P2ZNatxq7yN1ufPt6n/XIkiMS4ykc/TW0qpc8fnpVLXMMWCQ25i0Udc
	+SYv3rPqrp1wmiqc25vhZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev5qhaxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60570BOW026309;
	Mon, 5 Jan 2026 08:03:01 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhc0dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blH5AlrcMYm1a8JRdkl+PfwBL7lyETUqFucnGj0URrLhbVl5lmgYOrxgQh8us7TbqCiKlM43gH0rewYyloQnEmbfV5Uw6H/7hII/2ifHbXJPrQXTZXtPj96YNPEe3EGqHAS6/NZwMqGM89DolRDEkWkrzrK1U/wmHaJN2mL9+YxYUkh4eK3Itf0G7gq7lFdrkzD+t2Cyhx8uK+dr584ydMrD8JFmCcqk40XncBb9CpL6OvDoft3o010o607fYPymSvFe5JMzvqiSHsT7BBnnmFP4X+s8CSnI21JGOMLPLyBayjN9a2aw29dUJ+yiS5HITIgQtNR5Je3cScBopA78ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5175iRdb2mOfqKCIXVMMdSqeQl3S9QkYySAuY2vdPTs=;
 b=e6SNi/fJSrgXz7UklwG5soPCuRVoi9E5Wz6nZfNgNttC34HjZIcfSY5crfPhxNIJh7cwiHbCDUqyYX0yzfQB6uHKDQUSS+mvjDxSrWTt2bb5U1r2Qd6nb49MunwCAabziQD0IkWK2lR3kgD55x8FtzregDVQWuyakUGeOgaG+mRJZXJrXA5Gb/4THZUqqofZ/fC5JwLOqZi3gSpZxf0FBFomXRIoNizxjHC0v/sgOg/1x2ecuLtOUmUJWTKRqCdNSGp71IcY21+Hz7XEV2hfe/1WuzJdo88YVL7gKPFvTiTf8eb+1aCnjsTe7Jopx52nk8yc7K296L3HcFzVpj0BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5175iRdb2mOfqKCIXVMMdSqeQl3S9QkYySAuY2vdPTs=;
 b=YcADVkYzi96MsZUFLUXszDRTBYQZU/KyLanJVYzG37crUvKXGg05N4w4LvqN6rjYHWKpLVuy39nTysxVK0IAmlRSPMlbY2LVpUFzwHtngGPdtPJa6ZyLIgGZG7pt050ya80QxSXlKSEz9nmP4TOWbTVO4j07go/bKUwAR1EQQN4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:55 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V5 4/8] mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
Date: Mon,  5 Jan 2026 17:02:26 +0900
Message-ID: <20260105080230.13171-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0197.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b822a74-4f58-4f8e-7bc5-08de4c30d506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBrTp43SB5iv08of2rDaJPAp1p7s3gel4TqzfF8EmImjIKz50PBRJGT2DYUj?=
 =?us-ascii?Q?FK+EBlRBcyhB6YvFJBYsLc/yd+Dt8Rh8HOeHjHWaZvIIjMBdeHIB0uaENhUN?=
 =?us-ascii?Q?BNjIrME+pdMCXs4c/q1tLi3GEyqFzTkjM4SS4F1i2ZUFLNFHR+NC56hO3+rI?=
 =?us-ascii?Q?veQcNap18WxBLiGEK1/ZJYfrNG9934yTm+9gVzYnkKNszSztE0Iq90Imjq1W?=
 =?us-ascii?Q?4Pt3YiAeiVMkJvtjfIv27jgRDyKF68Ksd1K1cPtibQLGW0JrwhIdMf61oMuR?=
 =?us-ascii?Q?KL+wzdvvFZ55JqcDdB1DUZBfOUerGuKmk9ZuHI+IyybBputm6mdAnR4x8pQC?=
 =?us-ascii?Q?WkcJzu5AyiRnx8ra6pNe9ns0NsEYw9Pc2RWWVx/lFPEKqu5G9i5dmluX+b0y?=
 =?us-ascii?Q?RplLo0/P9f/Tn9GTHOfLce2PxJpok9hTtVASmRJeVuvUrMI/pQ1FLSrC2Y2d?=
 =?us-ascii?Q?QocKONIr5iVnif5J1uoww+vcCyGqc6hoAySbehjqE0jSEqAjxgSLmnQeRttJ?=
 =?us-ascii?Q?SZvxtGH864VwfV2nYxTvhnLIH5Z+q35GZGbhbjtGlilE4Vid5FdYWsfJc3K/?=
 =?us-ascii?Q?+H4QjneCh+AHO0dAMZtOj9kTAauEYXMkeY4Jz0zEUZ0xQUosYXrysDJw3vZv?=
 =?us-ascii?Q?T0pxwcRAhD7Jwk2hgyL8KNW/s8F6aVX2bBHrSGUQhCp9XQ4kyqGjuYRkCQif?=
 =?us-ascii?Q?+BlbqnBRAV3owIVeeGLKUNtZa/VRo4yF2s3l3QGNsYoSCADBwVr8gmsoCCVf?=
 =?us-ascii?Q?N+Wyq2755Direw8JcVBpJGRkSszjd3epnluH+/2xBNsHMScuuih3NasxPnPR?=
 =?us-ascii?Q?LO0DvDz+8+v7WP7Gm93MInc8Rgmh3wQQnWKpRTnOz3q5NeVf+vz9IyxASqGT?=
 =?us-ascii?Q?beF/Jo1qeD4cU2Pqj6bVHATgSO38gk8HPJLhUpD3hGIGtbzHmvWx24Qt4IPB?=
 =?us-ascii?Q?b1T5fTIkHmKNBdlSJHKO10Rql9BS5hKIBCXXqU5upiARx1c6IGFrprWYUlPS?=
 =?us-ascii?Q?OOZ/z6NyvTg+GyhqYZcOFqE4miIvNNn/jvW+Whc46xdPA2lpde/2JB/zfxQq?=
 =?us-ascii?Q?kH7G7WU0KLbsZ1n8Xr1nmJsxEoS0xd4055cL/ixOps+ES2fMzPRmLDHt4JZ9?=
 =?us-ascii?Q?oiFYc8N20qKwehKrR+ocXexABx1I+/5TL+Ro4pwn6bIcDumYskCO1pNbSgYO?=
 =?us-ascii?Q?PIDK5HMIfLrVcEzEAmP/+9k7/m0KI5/6vR09hWiyKtGqOrrcIHaUz2w7aHYc?=
 =?us-ascii?Q?tLgFcc9kyNLyxyq/VmFM0lIRUUMUAOU6MXE9zQQ87WVmJJ5c61mDyy2mouv3?=
 =?us-ascii?Q?nAJVFVRZ7NE/9e5aI/UOivdTBltL4rk9e/P+bWqNISXP9jIeB5V2qQi96QY5?=
 =?us-ascii?Q?AhSVd1kcJ3RWKi7Vt+dRojwG4CXAA08LDzeuoW4+V9LaB1zAeH1/njp6hsBJ?=
 =?us-ascii?Q?0vQG42M7IVwyCXkDtlG1XHFbYYDQFefw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i88Z2HoexIY/dhO3K/6OgeVAWIv9JO5PFfg6eTOUJR4maHp/mnx/o0oGftBh?=
 =?us-ascii?Q?DbsFFhzVpYL5u4Nwrqs+nM5afBJU1RNrWVvm/Dkqg3BOup3BmRe+pRHE1HJd?=
 =?us-ascii?Q?I/PD0LKeAAe7t+YbOgcwcXwDjVhYiSFUhfhUrVQwkxCfejd+4l3NymPaPEIO?=
 =?us-ascii?Q?P4AH2RRaU0s3h3RSiorrp0kAZrZfwYbM1Xwt3AIhVVaWZEAobsRq+vdXaKOL?=
 =?us-ascii?Q?7CoOMtU9b3ooWUgNdcsFGzp/E5AR7TnSNH3AXMuy9Q+2D5JuEMf/CIULrkmf?=
 =?us-ascii?Q?5DJbXq3YIWJyJVtlgg6rWwB1q3/QX60HsO9230RLxkJXUm5y+id5Wna9HOoJ?=
 =?us-ascii?Q?HoX2rJ6TpeNl00lyv5X85+La2UNC+pCWVrypfd9XJmQdJ2soKnF5iHElet5Y?=
 =?us-ascii?Q?zzm4y5qOoTbV84xPobzycqEJUSx9ykJjU6uS6F/99jsFqqkL28c7h0zSKjRv?=
 =?us-ascii?Q?rzi5FRvON0bFmAp73tr+AKZJvgCT4d7lzDiVkC3XMhFsw/KHtNVJ9JB6Gwsh?=
 =?us-ascii?Q?8pl/1rDRK8FbqRrEYfBoWerZQwkuIyZ5laNrwf2ldFOMccjHs90x9TDRVEI4?=
 =?us-ascii?Q?H9GzHbsnPEN0qe0XOIG3x+U+kLBbQ03rptiyDEpfsmx42dZQligcPhKuL51d?=
 =?us-ascii?Q?jxAmaaJBBl2Jk+TyrYfYIanyWh4XOpXr/QYP15v69dJYefx+H8kZBl+3KA6g?=
 =?us-ascii?Q?TK1yg2zmJNElKKvULl57UJJ8kFXd/IgI1wo5vAmHgxy4Cdt6hknM/DVOXJGI?=
 =?us-ascii?Q?t4cUqz0IMifl9sldxhhKkSuCgiK6Krxc5M6ldwSBQmwIST/LgrVhJR77D+tr?=
 =?us-ascii?Q?rMf4XeAIDPtOkMJ0AW7kQoZYvnrFuMS2w+mUM1c5LzCdY0sy3q4KvUpGA8LP?=
 =?us-ascii?Q?9aMApLQpq7C9lVk3z5rnAP33hovRUm6xiy9LjnYnSu0m86/0l6oKETW5Lcy8?=
 =?us-ascii?Q?LhQChTjs1LSVpx5mvWwXflZBepp+noFzTJR/NRs6u4n18n/2LYz4R0QAWabM?=
 =?us-ascii?Q?3sj0nza6fI7vZTwltvAhCo7hMyDCmDWqKEbZojHWbcXDVL+DLX0tWHmttLyD?=
 =?us-ascii?Q?NcZII1wNF6AIEFLCZn+iccc3LOqVeG61V0iOx2RkHL4uEa6RcJ3gn5Q4Zm3m?=
 =?us-ascii?Q?6cCkebIRD/QD5H1WQnuK/ruAw46kXrMmE+BG2E01fnoIdx5JOXj4yMsjPaEi?=
 =?us-ascii?Q?bRTlJMJNAsqhk2FDHG6KC0cLZLSn0/ikJvgJD4W5mmCHoaP9asn6t/QNuY/b?=
 =?us-ascii?Q?u0BXJKmm94ZzxbLaDH4Az8FUdbOS9eYjzlZ7oA4kn8PFksbqA9h0aU1jjewg?=
 =?us-ascii?Q?3RWmQGYEb+ZcVpzoJaW2O+wkhZd4AaYAbxOq3s0/v5OqnH/rxsMa3+nXU98A?=
 =?us-ascii?Q?LEaD7ETtg6cX6UafrzJ1F2BAVyPIyBbGmQgwkRWEKsJBfWBWnXdhLAVWPEAJ?=
 =?us-ascii?Q?y6mMp1L9bLQk7YNkse/q28lIacXhjTLxODr2DK7vdqt/4XuTdrMde2ZuGlJm?=
 =?us-ascii?Q?S/usTtYsaocykjdyPAF95D/MVN2z9H5/1Qge+lGpGVbin1AAm0OwPidb5k8q?=
 =?us-ascii?Q?OSxYowhp3ilbYGArnfRKBIlu+ZAXJubyj7krelTy7/npO0mGn+JOAlGbvzRl?=
 =?us-ascii?Q?0X4VyiUfq3K3iebrRq/+5ptf3vIQRnmhDJlC/04GxgOxFnxlxEwMUebud8Jf?=
 =?us-ascii?Q?2cX3s3JCIH77Pz0IZ45YxCRSrrHCBQYozP26zZuG3R7KsUoMwD+4STjJEoKH?=
 =?us-ascii?Q?P4rIIrA58w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XK4Ft0iIAsgyDdyzBjoh9CZoC84qqdS8G+POpH88l/fYLz2jPGzbOnOjcL1gOc0wA7OLvaAbzPkrUJLOAnwbhvtIsT+6kd1Hsp9zdPO6NFjGH8mdof+NjQbOJ7EwOKGPKG/ayeGkLn/PWtjMpTuOK+AwJ5RIPeS7E/nQUDF/vHRo04TEKx/xL63g6AH8Db0S8tWH0nnZ+4gP4Q9usWCBHxrl9JhnHLAOFR83k10X7SvL24rR/Lp3b0yCpmxWLvfyVcEKnxT8mvwPzngDo78ouqrUZDIRE/B3JpDVvVkD2I6x3jGSSjtM7KiqIcaFTdMDUqzaBArWFewQfQLxRarK9qziZTbgrgMdRZAuj/iP4jAb38yRKR5scMOukYlN0KOSkDzaeZptOaS3xarNZxh0O3dW79QKeoplTYrTnDeHfj9n6tvXIiTfcAKU/IjrJBdnQUryE1tEQnZovrEmc8V5wJzWR/PK5M7To9BJzQ14QehZ/OQ7FyzbGY81NuhHvOvXCj4r8DusWVh5Cx8AdMApoSOug/k8A+maT5zWcN5Sko9px/7Vx8shK7Hq4oG4yaDa+xXKIGFapd7SwmHG5Sdgi7GWELkmaMVzDFcsVPdueK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b822a74-4f58-4f8e-7bc5-08de4c30d506
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:55.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzoLTfyW/md+QtzQqQABr9E22h4h7mzi4LQvUXqqStE6xXrUeGYos291rxT4b62LhszqQs//a0xDZFdlFifnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-GUID: -oLfygrJmDXfoGL8VrUVwzmO8Xfp4Emi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX/yHkirE+ypt8
 XR3tJgt1YsUfsCCVxU+zKTpFEWQne5HzAqnBmORtoP89tFVtM6RAqFxMnsJfC22bzsZnAgz9/Ex
 iwcZCul9eKichRwaV29vf8vxaTKWcXflsopp7MLyLVRHYWJtjlwdPuCUusATvlHmg68wYMibXIP
 BmI9/uPIJg3PzUwa4wiIMYXzvOkQfFq1pywVeAc6heAUPyW4kvkz+VhBt5CF8ps8WP94zPWAfDj
 vTnZ13Nw2veCIElh1uN/thJRHTbHqb73XQmMJl9y5CkUnUKSgJOR76T5sWMZHtbseXPJy9kP3id
 yGsFDpQW7/nOxJ9GMiHI5doG3Gylcx/BvfEWTfL/bRc4a/ypkN3KC8VkJAnXo1oxuvOfCCQyn9r
 IFBHuR8RmzfHNggd17Rptq3/MtNMLGCWdGAPYqK/zTW85y+hQJHXvvebPli7sxuh8Bts3o63Fr+
 TIOCWY7V7KNiB6ITLC/of6cLPVQ1w3UzODcAzCe0=
X-Proofpoint-ORIG-GUID: -oLfygrJmDXfoGL8VrUVwzmO8Xfp4Emi
X-Authority-Analysis: v=2.4 cv=cePfb3DM c=1 sm=1 tr=0 ts=695b7037 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=hqUfzwhSJLVLa33He1QA:9 cc=ntf awl=host:12110

Currently, the slab allocator assumes that slab->obj_exts is a pointer
to an array of struct slabobj_ext objects. However, to support storage
methods where struct slabobj_ext is embedded within objects, the slab
allocator should not make this assumption. Instead of directly
dereferencing the slabobj_exts array, abstract access to
struct slabobj_ext via helper functions.

Introduce a new API slabobj_ext metadata access:

  slab_obj_ext(slab, obj_exts, index) - returns the pointer to
  struct slabobj_ext element at the given index.

Directly dereferencing the return value of slab_obj_exts() is no longer
allowed. Instead, slab_obj_ext() must always be used to access
individual struct slabobj_ext objects.

Convert all users to use these APIs.
No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 23 +++++++++++++++-------
 mm/slab.h       | 43 +++++++++++++++++++++++++++++++++++------
 mm/slub.c       | 51 ++++++++++++++++++++++++++++---------------------
 3 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..fd9105a953b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2596,7 +2596,8 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * slab->obj_exts.
 	 */
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	unsigned int off;
 
 	obj_exts = slab_obj_exts(slab);
@@ -2604,8 +2605,9 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 		return NULL;
 
 	off = obj_to_index(slab->slab_cache, slab, p);
-	if (obj_exts[off].objcg)
-		return obj_cgroup_memcg(obj_exts[off].objcg);
+	obj_ext = slab_obj_ext(slab, obj_exts, off);
+	if (obj_ext->objcg)
+		return obj_cgroup_memcg(obj_ext->objcg);
 
 	return NULL;
 }
@@ -3191,6 +3193,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	}
 
 	for (i = 0; i < size; i++) {
+		unsigned long obj_exts;
+		struct slabobj_ext *obj_ext;
+
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
@@ -3213,29 +3218,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 					slab_pgdat(slab), cache_vmstat_idx(s)))
 			return false;
 
+		obj_exts = slab_obj_exts(slab);
 		off = obj_to_index(s, slab, p[i]);
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
-		slab_obj_exts(slab)[off].objcg = objcg;
+		obj_ext->objcg = objcg;
 	}
 
 	return true;
 }
 
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts)
+			    void **p, int objects, unsigned long obj_exts)
 {
 	size_t obj_size = obj_full_size(s);
 
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
+		struct slabobj_ext *obj_ext;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = obj_exts[off].objcg;
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		objcg = obj_ext->objcg;
 		if (!objcg)
 			continue;
 
-		obj_exts[off].objcg = NULL;
+		obj_ext->objcg = NULL;
 		refill_obj_stock(objcg, obj_size, true, -obj_size,
 				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
diff --git a/mm/slab.h b/mm/slab.h
index e767aa7e91b0..6bd8e018117d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -509,10 +509,12 @@ static inline bool slab_in_kunit_test(void) { return false; }
  * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object extension vector associated with the slab,
- * or NULL if no such vector has been associated yet.
+ * Returns the address of the object extension vector associated with the slab,
+ * or zero if no such vector has been associated yet.
+ * Do not dereference the return value directly; use slab_obj_ext() to access
+ * its elements.
  */
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
 {
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
@@ -525,7 +527,30 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
-	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
+
+	return obj_exts & ~OBJEXTS_FLAGS_MASK;
+}
+
+/*
+ * slab_obj_ext - get the pointer to the slab object extension metadata
+ * associated with an object in a slab.
+ * @slab: a pointer to the slab struct
+ * @obj_exts: a pointer to the object extension vector
+ * @index: an index of the object
+ *
+ * Returns a pointer to the object extension associated with the object.
+ */
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned long obj_exts,
+					       unsigned int index)
+{
+	struct slabobj_ext *obj_ext;
+
+	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
+	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
+
+	obj_ext = (struct slabobj_ext *)obj_exts;
+	return &obj_ext[index];
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
+{
+	return 0;
+}
+
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned int index)
 {
 	return NULL;
 }
@@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts);
+			    void **p, int objects, unsigned long obj_exts);
 #endif
 
 void kvfree_rcu_cb(struct rcu_head *head);
diff --git a/mm/slub.c b/mm/slub.c
index 0e32f6420a8a..84bd4f23dc4a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2042,7 +2042,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
@@ -2050,13 +2050,15 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
+		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
+						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+		if (unlikely(is_codetag_empty(ext->ref)))
 			return;
 
 		/* codetag should be NULL here */
-		WARN_ON(slab_exts[offs].ref.ct);
-		set_codetag_empty(&slab_exts[offs].ref);
+		WARN_ON(ext->ref.ct);
+		set_codetag_empty(&ext->ref);
 	}
 }
 
@@ -2176,7 +2178,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline void free_slab_obj_exts(struct slab *slab)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts) {
@@ -2196,11 +2198,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
 	 * the extension for obj_exts is expected to be NULL.
 	 */
-	mark_objexts_empty(obj_exts);
+	mark_objexts_empty((struct slabobj_ext *)obj_exts);
 	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
-		kfree_nolock(obj_exts);
+		kfree_nolock((void *)obj_exts);
 	else
-		kfree(obj_exts);
+		kfree((void *)obj_exts);
 	slab->obj_exts = 0;
 }
 
@@ -2225,26 +2227,29 @@ static inline void free_slab_obj_exts(struct slab *slab)
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
+	unsigned long obj_exts;
 
 	slab = virt_to_slab(p);
-	if (!slab_obj_exts(slab) &&
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
 		return NULL;
 	}
 
-	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+	obj_exts = slab_obj_exts(slab);
+	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	struct slabobj_ext *obj_exts;
+	struct slabobj_ext *obj_ext;
 
 	if (!object)
 		return;
@@ -2255,14 +2260,14 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
+	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_exts))
-		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	if (likely(obj_ext))
+		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
 	else
 		alloc_tag_set_inaccurate(current->alloc_tag);
 }
@@ -2279,8 +2284,8 @@ static noinline void
 __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			       int objects)
 {
-	struct slabobj_ext *obj_exts;
 	int i;
+	unsigned long obj_exts;
 
 	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
@@ -2293,7 +2298,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
-		alloc_tag_sub(&obj_exts[off].ref, s->size);
+		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
 }
 
@@ -2352,7 +2357,7 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
@@ -2367,7 +2372,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 static __fastpath_inline
 bool memcg_slab_post_charge(void *p, gfp_t flags)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	struct kmem_cache *s;
 	struct page *page;
 	struct slab *slab;
@@ -2408,10 +2414,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 		return true;
 
 	/* Ignore already charged objects. */
-	slab_exts = slab_obj_exts(slab);
-	if (slab_exts) {
+	obj_exts = slab_obj_exts(slab);
+	if (obj_exts) {
 		off = obj_to_index(s, slab, p);
-		if (unlikely(slab_exts[off].objcg))
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		if (unlikely(obj_ext->objcg))
 			return true;
 	}
 
-- 
2.43.0


