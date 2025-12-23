Return-Path: <cgroups+bounces-12611-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81218CD9D1B
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E36C30041CD
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE5355805;
	Tue, 23 Dec 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFAFpEgQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hOa5h3Rj"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A03557EE;
	Tue, 23 Dec 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503931; cv=fail; b=WnH9Ib3KYKRFqoo+W6DlUNSy1OLBeX1vNkaYR1d7HjNDzyfO9+HYSRisp2wTBQ0poPbKa3vCl3bJ2/n2hMxn5cfPLcbhADjEUAX4kogAOQInkL/lHOt+miDrVaSGOFhag0QdWhnNFqmwJQ44hpSMwXBQqVXvsrDU09HAhlOUG8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503931; c=relaxed/simple;
	bh=OTy5y2SODDxXBXc+iCWMERm1OKH9PXzA4twOBp4z6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLBZMVQ54DBqX6isFHhkwzii2OvItTl4jyiTKLAWdhZeKPVrdxGOwwr9b1zYJNk8lsL0hhmVkqO0wv40PDhG+VQ+16iKwDRuSMvCWACO5PC9GERLFoJo8vHF1kkfbRAex1Gmm+kLskhJgxcNAx0xsKKyTKjWH0HTAdddQ4eBwkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZFAFpEgQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hOa5h3Rj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNFEOx7669988;
	Tue, 23 Dec 2025 15:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xwvMzVcQzNgUuzzzUM
	c1YqmaGwGXVd8t/em3XVyhXp4=; b=ZFAFpEgQxJNAUFoVaOWy+lPresIFccrqNV
	aA2krGfRtLGm9HaGlXeFyyZ7DwBCQB6bU0FtVAOKSQ9Rg8l/1IzoJ9luWGqjdaZI
	XMN7y2pWfuKCNrEslsj3Cskc7T+MpHoVgrJlO6PC5GER2XdRi4pQFUISVl7mgz/a
	H6/8eWWuJadO9vW8+NKf1V2BK51O+qOCzijC1XnasQGoqC4dYL28QyQNVJk73WAC
	ph18WImSDZilAF6RdnqfGgIAvH0p3h9VxhYbMyoYZXtu147m1WFXe5EegPxZ9eke
	ia1guKPV5YRaGK7Ki34ryxQa4WgoVsWrEQf1r8gzPkA8cDUwJvNw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7wdtg1dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 15:31:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNEI3uL032713;
	Tue, 23 Dec 2025 15:31:32 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j88j7b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 15:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bti2CAVHPAQ4/35NsEH34TQg4MMd6okcLK/g7as6uPxsnWJut+I+Gi6FmqJulCPAa26+ECjcjbnHSi7qYaHN2pkuqlWZxKmDYJG9ueY7mzRyVGw98ILs42XEOfKOvB16r55mfwdz0jADvYcNsyIdlbAetAiTQ473fjd48MVBHn3+cp6DJ+PayzD1dHHXgbUIQ6PUMqPEQ7NmW+acVjZpnAKjiyWSOs91tKNaEujxP1NoiyDPHIhcu26+y7l+e58M86r3D7YUQtscxNtk0c10IqJqRF48M4FKsjwa+LwN553zB9CLGL3TRNrwkNTIbzjap4aFe+7jrBSdvqyPN7BHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwvMzVcQzNgUuzzzUMc1YqmaGwGXVd8t/em3XVyhXp4=;
 b=DoBOFbr3Ir0LTSKD6Q1/I3phxt3XI+LEFGOWFacyaxTombLDo59pftmPG/fgg7ixDPgzLT9D+/0JKyuJUJNQz6s+TFL7PXkaIKdXrCuscLCU24nENkVlaDrstOdeus4xJXHsooMH9CQdOWCgYXhUWS9n1Shpde8DPHVUFeQvDC8V4WwWuKD2BQ5kaJCKXjLsEJhT8Jz2bo9lMqf91LKmQw/MUaNIF54rclAo3cOJPgJaelcFtdQJu0vvRbAL1Wi9qz4uHSmI4lr+XkwKg6SMJApaTt+bM9AalI0b9yHLe1t3I07kIPbUIQBcYrCBeNK+YONT0eaZ3A6mWRAGAaSSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwvMzVcQzNgUuzzzUMc1YqmaGwGXVd8t/em3XVyhXp4=;
 b=hOa5h3RjPYugsmCHTRfPlTuyWtOixjjfQUua1ATBSEOstX8l2jIQfcVPk8Ne4Xhj5Ttu9+y+Fc2WTz9O9DdYXCr1DU03j8Hm8uHoYi/yImOA3dwY0JtNDUKnjf2ADDbz6e9u3UPwo9tgMLR6VWo1b9/W+oZ86/Bgyjz8tvywJfU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB997714.namprd10.prod.outlook.com (2603:10b6:806:4be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 15:31:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 15:31:30 +0000
Date: Wed, 24 Dec 2025 00:31:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Message-ID: <aUq1x_BowqYpHZAQ@hyeyoo>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
X-ClientProxiedBy: SEWP216CA0056.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB997714:EE_
X-MS-Office365-Filtering-Correlation-Id: 417e48c1-6752-4429-57b5-08de42385884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iA/+U7dVWY+iSQI+XCDxOl4AU4fyDvzUb385ZP3hJ/y9/OFW2WCojfvLfpDJ?=
 =?us-ascii?Q?7WR2upTO221KTOaT4vqeyM9zI7p0SD0tnxm4A1vKwwWN5mpSU/doW1dHZRxP?=
 =?us-ascii?Q?r3CO842inckbCtKMxhDnM7zL28CQB5HjejRv1KJbMT3BWub7hRqaoOIHRFdq?=
 =?us-ascii?Q?Ko9SwZrKa03WtptPTCFGcyyzotRM8M35xUPLhoQN8Plu1vcB91pBpMLNJmFG?=
 =?us-ascii?Q?VoR+wu4B83ZwH9lFOh2OiZ/8bHy0Ro2Jp+rV+qQ2XlA7wlNxEcriaGZgmL5C?=
 =?us-ascii?Q?08qWorWl1PWLBiWxObyIKECCFduX6XdOO7O0MWDY1rWGBEJtPvFeGGzK7c5z?=
 =?us-ascii?Q?n2Ybds5IFOqszUilFQiZ6VVF9C/uRavfXu8nFOqBVuYMo/ggSIht6Jm15vaj?=
 =?us-ascii?Q?kT2Lu2G9ieBGOO3juQX2vX3vrl3Xd7jH/TGYZYMe//cOmYgz8/VbAC3+k1qh?=
 =?us-ascii?Q?6YCcOvigaijBwnVgRnac0Zx2CoKsLj4RlrgfmNkBVydFSlYen4vtWj6af0BA?=
 =?us-ascii?Q?dgTRTX0V+k+qT1C3J9nVZ8074WKuu0XJZr6VfIaav8Kp/XpMyNwonJPeL2F4?=
 =?us-ascii?Q?VwdrrLU/Dr52dmx++ICZWINIrmtJJjYm6hjdwcGEPzF5gqlXn223jP3p6+Px?=
 =?us-ascii?Q?MN/WYn+mq4XGlFLV49LlscqC3GprKnsGI5QoSoiNRSH+fPQfHNbMpc5UM4CB?=
 =?us-ascii?Q?rCTjCR68my/0Zn7ZAB8vTFLN9AX+JbYXx7tQ8QQ+Mp741UEKhq0ewFV+Asux?=
 =?us-ascii?Q?mIS6recdKbCDPnXL2fExEw7LOHPQP37LGZU9wHpa6OSzK4LBL9Kel8sNh6iR?=
 =?us-ascii?Q?QqgFh0PgtpcgTSKZF6ELwXSQYiel9qFjA3BxODSJUbBFPlzt/KwjJPNuRNnd?=
 =?us-ascii?Q?9W9eQRC+V5eRUwvI8J9sdbVz0EdOZr6SfSDgzzB2SS2N6Ohu6JC9ZnH8vgnU?=
 =?us-ascii?Q?GZrd35CF9NxcQ6MYH4AoWsbYIErIgXh0TNxWBolFS1yXvZ9lXX9Z3Ko+afaQ?=
 =?us-ascii?Q?i8e2pjs7QVUgc5M3TEpFRImeOT20PZ3A0CjVSmVR4sbnKLI+k7FbVqKLdWOj?=
 =?us-ascii?Q?vrBrn8w2xxQuoiNz2CY6s8xf3tkO0wmDi7M1LVp6z8CoaW60oVPhmjZJLaLk?=
 =?us-ascii?Q?oVJzQt5JNUfeRRkYjSJdXVXi2BB4rxjm2WOG0T0xaTl2A4SXsTpX+lJpOp2p?=
 =?us-ascii?Q?wzkjq10ZkqIAja1L9uVWPSlAyNIC4TXPW1G9fTQZUsBMBY5xHswjbkxKAv2T?=
 =?us-ascii?Q?1Qw8xjZQL1Rj5FhAq+1rTnZY8ZRmF6BWCSehVOb5ePaT12dJAQdOoVPTqhum?=
 =?us-ascii?Q?fMIeX2SLDF4/umgTG8MbVRkF2cbyfG1eUyeJK1kLBHcY1EjudPGPC4++aktr?=
 =?us-ascii?Q?GOVDXrcmcNnPv8x3xa/HXFaIiIuWxeW6Jew6arhLD21woI7ET4SVuFf3A/AO?=
 =?us-ascii?Q?zgBgjjosc1v54+tpvmJsqSjoU2GOKvRR2rPItwcP3tBCfpt8pFjsJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zh+MzeGj2IvUje8tm7AQmb3ieOEF+Ef3Zv++Rz48eQZJ+7de4+4uQrL5UMYc?=
 =?us-ascii?Q?uxJuScgdwf44kZPA/MzNpzYAj55XPuDLkIrgY6EQ5+2o1r9s+bI3dQLNS4R8?=
 =?us-ascii?Q?uj45fAqk8v3Ee8wpjTDFgSDUsBYGBVbjCHRN/VZXxpZq915JI8I1za/a689u?=
 =?us-ascii?Q?U7qwrrvCe2Ov0fUBl7eUAlgaMYRTdkSb63BA6nqxsZAV7oS6CeCp9y/JuULU?=
 =?us-ascii?Q?gXkRHxytiNZEXncZe05cgGcl61xGk/gG2dhD9Fx7CixkJyQExEqy1Ww5Wtol?=
 =?us-ascii?Q?we6yOmxsy3PzQWyot3cUOgk0MywAl3UZi79ZyMB4hg6d28vUuV4W1hoCh1Vv?=
 =?us-ascii?Q?n3L8/eHDEyHuSryQ6VPj8v4Yf1Vxgaomf24R6tVya3UmVSDOYXR61hSrQRlO?=
 =?us-ascii?Q?0krRsrlVfN4Isy0Yrsrn8zhjmQ+sm6li4rItCKZbIkmMFdtGPn27lzUrXtoY?=
 =?us-ascii?Q?IMc4xBRCPrFfil+u7l3QZjTtBiGm9CTGZezDBwVjAg6pkjGxbR6Wa4X/FYL6?=
 =?us-ascii?Q?FzCs3Rmc7EIrpWeAHdL5jB3CkPn8JjbCNowbbUeft3Vr5kUii11o9D8m1f2F?=
 =?us-ascii?Q?zE9ZgtCUZla1lOIG2vEmhzIFwIzPtuj/fXEV3cP5DqZY2XBd8nUoh/gDOj98?=
 =?us-ascii?Q?8irq0sZjx1ueHkkJ7mfRSA3nmr/O8f+DZXhziiQvox1sbGxGM3QtyV1YhSrc?=
 =?us-ascii?Q?uQHdgXbncE0C0dXxfcGWWf/5WKGVJ+TNOfxXQuyrjv1tnY+/ajU1ZRdm782w?=
 =?us-ascii?Q?AYT0FTpj7HDD817iZJPRrt44SMKuiKrYijLLY0Ll+Pw9uIkKCbl0VtFAlwhA?=
 =?us-ascii?Q?1pE+PQeQpgv0HKyZ4LQlx6bF5bTTgpBPeHu0FCs/O2e5/GKdAQKdzlLCIOHx?=
 =?us-ascii?Q?jjlG6bIhleQsgQcyWUBsDP8YvhQ4nwOWLXA1QFoCNG7sZcue61qeZRZFFpCs?=
 =?us-ascii?Q?qQ+qfxfak1FC99Yk26olU2XDVGREhXsnoprmAINlxUgTKf3Px7PSWmNLc+Br?=
 =?us-ascii?Q?D2HpFDbrmJR6+9jumliHNQM65Ynl8t3Zjc93u+Q3DvTozIOO1zWhOYdrJpDy?=
 =?us-ascii?Q?OdgQVCgWTT6SEHwbI8quU0l+KVwyG+enDPjnygQbL19m6T8E+lR669W2A3wK?=
 =?us-ascii?Q?bHVtidmAcPbgT+R8QCFVywsFeFv9A1MlwPjCC1VLq38rhE/tnq+APHmTLccw?=
 =?us-ascii?Q?bsF8JOfhbEI+rxzriq1nw6W/XidsuUvjCZps05xrQ08XYbDwuAxiLTcANZTj?=
 =?us-ascii?Q?4qrrsqmK0MWPmO9sGpNpx/SnoobQH3FhAHTLu7GOiCfIG6mBpNNP/LaG59Ry?=
 =?us-ascii?Q?i7qhbfmPEFfq6vzsh1pbqNOaOnfC19MtnPr8iS9uBenzWWeedxtq2drUBPbF?=
 =?us-ascii?Q?ft0Du6N0sVzx6ZcWPMMmH7O/3XTTl4DJy1kmtjHQzTtHDYYeziieR1J/uV3Q?=
 =?us-ascii?Q?Nd6DeJ4BMMzS0sQXcZLQ21260dHIGjhkNubF6QMNKu3+J5U+dSJaKWFgLH+l?=
 =?us-ascii?Q?y/b60zdDYeiS0AOTYef8jHZiKiCmHjAs9R9cNoox4kvZSQPYXKiGpeMN+4xF?=
 =?us-ascii?Q?PKMVG+dEgX5gM2lo8cyAqyXJS0Jchpsahq40xtEyg4ig9cpnn7oGe5TqV3dh?=
 =?us-ascii?Q?Nsy97Euda/9qZqtBzW7IrOAJ1YeHqdHWtP9BpGyeXE9zh3Hb/jFFuPPEiqlk?=
 =?us-ascii?Q?whv07705/KvnYQ3l/RLjCztJVl/bsPI3h/Qdp/aA8jGec5Q6vlIiwa9rRpMj?=
 =?us-ascii?Q?O0uBvqC3sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GaiJ/vk7UbDVRXu+JFWX1yjaFoyn5IDKWQarL3w6BmOwxn7m4zsebNqCDsFP9gghNj9NIwIt8Io4oZRWcXUXT+o1o2aKioPbmRo3P1RMhNZ8oDDOmGSGke18SYac9rJ9Wve63cd5f5LzEGA2dAztAPu9hnmAMfX+sKNRTMD5DDM6b+qTQ/WC1Jkmb5RhzQwIbsUxOByd76aYHhV0PLcfNpcXUUMV226bxgCHvzHn/Lhr0ohsOTIaGlgwTCKOUeV3HSMZ1SbhWsoJADtB6Lq0cBMXICFSgxnKFnCybUOeeMIRNOUN/w2UrYloMT3hPxcD5+59ZN0rz1jxekyArelh94n7Qflu3Yz4g/uZyYiI/owP60bT7wKQZ3SOKyZghsKcCu1Dve2JJxkCRDr250iNqsT43JED993BEaOQbL8FjxVE41/Vhqr81rl8/+6xsuCMzWWf1OlfkV8/jzkfOEUb7Z1KY4ITAHXOB/Tk1CgXRvPvfu0FfEceE3fh3pS0tCSCJi7MpmQGGuJ23/Eoa9b4AZoThZ1nnEwT6yDGeMiKBxIqGceWG06iDEmJ3zytBMYum2/TachM5d4rhdZujKF7rLxXcysk/C5FRwmTeJbJIzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417e48c1-6752-4429-57b5-08de42385884
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 15:31:30.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOfVESxM5CnArczEXS+nc5m9fEj72E1Vfz7p/U2kIlxNLctoMrWwOgT0h17k/gu5/sQe0bMbJJhkRiVivCRZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEyOCBTYWx0ZWRfXyy6GVnbjcwfM
 t6L32neZyuS3QhjIk75SUs7weyeomxUmeY2lhGLO9i6QFMA8fMIzFGZ771TFoQJzE4S/d7eKTa1
 pG+4SCPbnrPdSEZG9DMkEUA/v260AVSI45rp+1J7+M7SO5dvHmlgzdY5Qtev5ZXTIom7ZAOdvP7
 xiy1W3p0OXZ6WkFNJrmewwUudDqK2t8zyEbRxZB5pumwrXif32wqs/bP39db1NPTyYDwRKOtBD9
 E1qZffBuWF7SYAuJuq1UdlBtSXo6kGHd6VhYnlqQkGdcs1nnMfl7WVfgjHSQnmnWDYuOQAvUZCx
 A/NpRRLg/1KUsPg1UZJOoP+wNEGuwpELk5wefRRfHlBai7qeKiAXJBbAX24FVSn3TJUXNaR21fp
 G4lrNFEMnYH/kapmoxVVIb/lljrrTlAeTBaIzmnbYgbPATUZ2LnMDS18Xcwby5FuGbZ78iSOlil
 /AbFrOUDaNwMDwzLqOg==
X-Authority-Analysis: v=2.4 cv=B+K0EetM c=1 sm=1 tr=0 ts=694ab5d6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=mrXUw9QaqJxdP5dvzSoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 59atcIXyhvT84KbPPGwbbu63YCgI69Rm
X-Proofpoint-GUID: 59atcIXyhvT84KbPPGwbbu63YCgI69Rm

On Tue, Dec 23, 2025 at 11:08:32PM +0800, Hao Li wrote:
> On Mon, Dec 22, 2025 at 08:08:42PM +0900, Harry Yoo wrote:
> > The leftover space in a slab is always smaller than s->size, and
> > kmem caches for large objects that are not power-of-two sizes tend to have
> > a greater amount of leftover space per slab. In some cases, the leftover
> > space is larger than the size of the slabobj_ext array for the slab.
> > 
> > An excellent example of such a cache is ext4_inode_cache. On my system,
> > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > and 736 bytes of leftover space per slab.
> > 
> > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > fits within the leftover space.
> > 
> > Allocate the slabobj_exts array from this unused space instead of using
> > kcalloc() when it is large enough. The array is allocated from unused
> > space only when creating new slabs, and it doesn't try to utilize unused
> > space if alloc_slab_obj_exts() is called after slab creation because
> > implementing lazy allocation involves more expensive synchronization.
> > 
> > The implementation and evaluation of lazy allocation from unused space
> > is left as future-work. As pointed by Vlastimil Babka [1], it could be
> > beneficial when a slab cache without SLAB_ACCOUNT can be created, and
> > some of the allocations from the cache use __GFP_ACCOUNT. For example,
> > xarray does that.
> > 
> > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
> > array only when either of them is enabled.
> > 
> > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > 
> > Before patch (creating ~2.64M directories on ext4):
> >   Slab:            4747880 kB
> >   SReclaimable:    4169652 kB
> >   SUnreclaim:       578228 kB
> > 
> > After patch (creating ~2.64M directories on ext4):
> >   Slab:            4724020 kB
> >   SReclaimable:    4169188 kB
> >   SUnreclaim:       554832 kB (-22.84 MiB)
> > 
> > Enjoy the memory savings!
> > 
> > Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 151 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 39c381cc1b2c..3fc3d2ca42e7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
> >  	return *(unsigned long *)p;
> >  }
> >  
> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > +
> > +/*
> > + * Check if memory cgroup or memory allocation profiling is enabled.
> > + * If enabled, SLUB tries to reduce memory overhead of accounting
> > + * slab objects. If neither is enabled when this function is called,
> > + * the optimization is simply skipped to avoid affecting caches that do not
> > + * need slabobj_ext metadata.
> > + *
> > + * However, this may disable optimization when memory cgroup or memory
> > + * allocation profiling is used, but slabs are created too early
> > + * even before those subsystems are initialized.
> > + */
> > +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> > +{
> > +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > +		return true;
> > +
> > +	if (mem_alloc_profiling_enabled())
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> > +{
> > +	return sizeof(struct slabobj_ext) * slab->objects;
> > +}
> > +
> > +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> > +						    struct slab *slab)
> > +{
> > +	unsigned long objext_offset;
> > +
> > +	objext_offset = s->red_left_pad + s->size * slab->objects;
> 
> Hi Harry,

Hi Hao, thanks for the review!
Hope you're doing well.

> As s->size already includes s->red_left_pad

Great question. It's true that s->size includes s->red_left_pad,
but we have also a redzone right before the first object:

  [ redzone ] [ obj 1 | redzone ] [ obj 2| redzone ] [ ... ]

So we have (slab->objects + 1) red zones and so

> do we still need > s->red_left_pad here?

I think this is still needed.

-- 
Cheers,
Harry / Hyeonggon

