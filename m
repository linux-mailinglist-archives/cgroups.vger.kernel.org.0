Return-Path: <cgroups+bounces-12915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90FCF2512
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76E33027DB8
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D72DCC1F;
	Mon,  5 Jan 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkGYVwPl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A23zzN6f"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE01465B4;
	Mon,  5 Jan 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600224; cv=fail; b=JQCn7cuFcAb+jruTEpAHODiUADN093vSof84a1FpVicUq6WzWmgB0vtqGsuqy9CcOAOF9puhKWQZnaeUfLzDqcqKIFkoklMHAdPaqjCs7i7FN3aI5saXmoSRoBZBvZ/9KmQr4RZjFabhBZyJEX9K2iNpWL0/W3gDxJH8XFvXPiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600224; c=relaxed/simple;
	bh=WUe+5RXwbV9Q9S52JSNUQXs8cEw/FQjE3LjBJLV4kp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSCb3H8U4xxnutZjWU+X5aGAmxLugu+rtyFZTDZzH9ednXCeg2vryeEdzhYCAB4gf30oNPORJUpj3fBIJnAq8fURR1a1hCR/7xqG0DFJN5SB7QDJJiiCDubp+7NS65rGUYRlORNDbmPbNwbghJ4uVlgo2fTZBtnxuCyVlkCYiEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkGYVwPl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A23zzN6f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052j28h231416;
	Mon, 5 Jan 2026 08:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fADH2+yDCrfVqkw/9rmY1K/U9ajMl42F7tk7FVuRukI=; b=
	dkGYVwPlZTSnRF/9NJNtRgG1A3PshA5OBkSc7KkAiotzwO1HLPZRPLsLoeMzudJM
	qAXik/cSlsnVrS/tHI5o9fH2KN5luShbG13cXHG2MTSxj//+o9CKhkcKOS9B7US+
	bMhBC3OnN+kjhFiFCI5G/ZsKcFnKIy9dysKja+hgLOgzLoiCGA2q8HuW74yWDfvk
	y94Z5Ocdk7bsEzTZ8odibiBN55WqdA9tAFRq11brQow6KQruQlTizFa9FpVKWlnW
	a4ipoTTQaFD+1rnm+yMn6rPvW5man6U7dwImcsBUTT2IJtIKMeEixlBYNEWXsTkY
	uFNAtr33AfwJeJynBXp3wg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1t9af7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057J2Rl020365;
	Mon, 5 Jan 2026 08:03:13 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjh42db-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqQ2V4m3pSapjj5crpyh3uLr6MJAWa/54mnx4RPSJmYCQR8vWq/5cXn//i4hIuFAMrD/1oLtim23VY0lPpoNDXRz48zIcHzJTziRLTZV9CAKYqgr8pECmgKOcJUGfG5dnRxJq1STA+TSPwMHXyevvOiZaT8tGYoPBgvB8OrwCgH5ui+r06uIEHvZGqLCKy0XB4QMSxwuh/lyp3Dvz7RUheajAkh32Z2X+xhvX3PJchttzN7htQcoCbmtYlB5U/pwCXF4oijCADSUohjz7JTkNR9M++KBimB6hoyNfB78EXL6+Sodch7T6zFOY6stpwMYFckaKulSpmh/DgEU9syMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fADH2+yDCrfVqkw/9rmY1K/U9ajMl42F7tk7FVuRukI=;
 b=SOf2fOpG+za32XgLzqmcPQWLOdgjvz+rgzmabQSqURJQFGdiZuijvGqkZ+nGWzieHzGt7N4xWxTx1omxIJ8zdkuazTVrDjFNg9LpLyTwcaGXuvRdY9PldZvECE/sx7UZHeUf2HWZrdL59bZuDvs4WpmH9+yn9nO+bViG/sYwqbnnJm3txqSKJ1JyvC1ApAQPxu82Xm41jaA4G9SblIVPPozopchlwm46gcT2SIFXt95ciDRCy68p/jRlefgJro/QrjTBY1VPE6f8C7+E79/lOwKp2ISp9Bj89Xp4SMjfFNABFbtBHPv9FIfixcg4KB0FIoLIAUUC9UTuH/riGgxGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fADH2+yDCrfVqkw/9rmY1K/U9ajMl42F7tk7FVuRukI=;
 b=A23zzN6fJI90G6NHhlVYhuc6SqJuT3MVck+nJLI1bnXm7TknBHHLVjUirwDJzNSzCiEMUS3eJK/+/G9FDnXUGY7rFAr/nwRFjFwn9S9wB5YKSljEfz8TOUTszh7bLK17JFF3M2MtrZs6Bt/k3sJQ37OrdmP7K8oe+og7QxLS39U=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:03:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:03:10 +0000
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
Subject: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused space within s->size
Date: Mon,  5 Jan 2026 17:02:30 +0900
Message-ID: <20260105080230.13171-9-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:100:55::27) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 8212f0b2-82c2-462e-5114-08de4c30ddf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i09q9vmmaKpCKrvo/2l6g6DA2JcTSiNwEM3+mcLfOnx8Wl5ane/crQVSK9qR?=
 =?us-ascii?Q?lXgwohbhpVqIdeGnFp52oKu3fopM4KN7BEYdyn0a+dT7ey3U2o4Wz6b+LwRd?=
 =?us-ascii?Q?EoKd/VtWqVwpKZybitITtwhpNfSSoHWPfoEJOueAbnSBDc6UqZpToYKFn2dV?=
 =?us-ascii?Q?VKise5gTe07ek4tZf07acK1uLoJVycHsKlcIR9wb0zLtS93VAVu6vx71U8yL?=
 =?us-ascii?Q?vonMgTliWoXeJdiczZnovHkQ7Yk3UvK2cPm1+cIPOTlO/hL7i9ZpN1SNkATF?=
 =?us-ascii?Q?YpjbbxvlZGteEA2ywUAKz542PVcnqRy2w4RkixA0X0CJfS2tg7cBk59+mi2F?=
 =?us-ascii?Q?GRyHKIrImJodEv5UXCcUyFPSH37weD9h7BTuDMrgYt9JuGWQhRRUzFitK3vk?=
 =?us-ascii?Q?2SednNCNPmCYvAa6ZlNvP+M4viuBLyIWF8U1GjvxmeQyqpKHlcIJ7JLReV/3?=
 =?us-ascii?Q?UimJL9l66zpNO+PeS6HnRsCRwi51YwkSLEpqDSpA6xzeN1g4CQLKMMTOkjG0?=
 =?us-ascii?Q?JRlRj/JotZiUv89BdfpShCVzypR0dwBeXM31zjcHqYUE8rREUoE6YFMEUKrq?=
 =?us-ascii?Q?yQgPTvvz+XQvWuQ74occLZ4sr85kP5PnmQCVoOyHUrC9/DNJAP3DYXTNNA/P?=
 =?us-ascii?Q?eXuf0dkD4Zfr7wCMXMkuYJHRmoAXziC8mBbpas7gJy+i2HbVfqj0hpZL+sXh?=
 =?us-ascii?Q?HCCwC0zo+uAorlvPSGMEKeCNML6usr7QGcLAjxm7wD5Cob+V04y7RHuJ1Vp2?=
 =?us-ascii?Q?FErpjmYAoNoSk9I0Q1OzKSJuHRx2xEkLGFQL8GM0yOp/a8+AH1n5zhAqAHwn?=
 =?us-ascii?Q?i9T1SDfwXbojCUNk7U506ZliyruWShr1Oq5s6DjjWn94HSssHDx/0BsC8tch?=
 =?us-ascii?Q?hYeukBvCNvJABAWwyS1awjA+tStkqU6BapbckV8vw05t9KucA7yp4Zxl17Jp?=
 =?us-ascii?Q?g0lp55+EAcIlKWb0DBdBWSLUxVkYntY3TKgpMq2xyeWf4IdRkR9+ynTiJD0L?=
 =?us-ascii?Q?wwIXzm0h7jiRhm05tcfwOCzvTK1z+/C1LB8MuP3qtBkdfRd3tV9zeGzm/oJR?=
 =?us-ascii?Q?Pes8Jv1nfrHgc2qN+PYpjN7Q0CSgPkxBuftstYADj6AyeAlTpy/cNnBb8N9W?=
 =?us-ascii?Q?sgPl1DdIlluzHif2O7mCFpPmgZi5ykvEqfkIS1pYfzSqhWSbuW1ixcxw7J3w?=
 =?us-ascii?Q?shY3wJgeXlYx/63BlbultJ4CvONhXIoJTrYVYhfSJ1H+nPdXnjQM3jFL2atE?=
 =?us-ascii?Q?d8H2oGvYOXINGDIyIrlPzEfIPWk0hhEVT8j/DH7MpJ4amYbo5Zpt2K9Gbe0P?=
 =?us-ascii?Q?PzGtPvUvM0Mbi4sVvdzyS9R6OL1iP4HIRVXuQnm02IU2kvnTqvMEvmwcymPQ?=
 =?us-ascii?Q?TCkfRKHckCV6wsRUXLww+CmnMCyV6PL7/4Fk/sxTA02/qXzZaNhqYw3wknY0?=
 =?us-ascii?Q?f0YY3XXuXbbeseiG4dlDzRBDhm0dYae7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UY2mG6v8gaU/h4wtsHVwBkkV0cWDBU72bQe6tvpe8h5cupne+e39QmWHsfG?=
 =?us-ascii?Q?nc3yf/+jazYF3OjMDWeXLMN1ParED23vraPY2B82Mp5REqzbgRBlpgqUI77G?=
 =?us-ascii?Q?L+Clq/TFXCM5aaxESwNP289jhpGcbAYrAxmKpZPhQO3hy2BI9lRy1fvkEMmw?=
 =?us-ascii?Q?wUEk4csIdY/6q8G0SFmtEM9b0wfPac3RbWOP+hbFTe/qCMnBuKFt+FHY2p3J?=
 =?us-ascii?Q?HupMS/It2Ctj1faoEuNE+5yUKPKBkmBT/B8rCtENs5u0Jtvkjr7l+SUVq0x6?=
 =?us-ascii?Q?A6XqBGLI+6qixWuDBEu2sxr927PkSDBClYolYw0xf2lEgbZV2wohTHjQfOZg?=
 =?us-ascii?Q?fxp0h8Jo33QFND8zmKMwwhIEOibr8ZdpDHzG7RgXBnB3t2u9eUsVLpb9tGJ+?=
 =?us-ascii?Q?FMCBJQZQqxIlnB4CFUVGCUsYk2LOeN+DkF2TA4BYg4vMNjvVPuE9KhfArLoV?=
 =?us-ascii?Q?soC02atpRZCpkY0/k5kYvUllsET0s4OrhmbkRizzejUUICOA8BMtCbuL/xrt?=
 =?us-ascii?Q?cio0ScEOqkQwcHlPpWHxstVHYoIQ9hEJtcpbbNpYajXLBL61PX8yh/friiLP?=
 =?us-ascii?Q?jHhRAmOFDgbMzJQiHPNejm22FuVdmSpeMNvaj/Kds5ZzKKONqKPicCEwpZQi?=
 =?us-ascii?Q?JH4+UvlwRvpspvsGvOFq9EIkL726Mn22XULeifa9FLlp4/ZCciLRPiGwf4RS?=
 =?us-ascii?Q?tyNp38FHC5ELILbTH88OR9P1BnKsrKcP08nYT4rOHsXCvmmDbRl8Q/8yC9YN?=
 =?us-ascii?Q?7HfMc5L2nnqlp69W46bFQ+25xEjQkBONw0xXXYFxwkWlhGLJYP24B5VOD5JT?=
 =?us-ascii?Q?Du9ZCr6p8+U1EkqRVtRHiitu/j3IdyDwvvVCfGRO2x79traWrafx/HtmMF42?=
 =?us-ascii?Q?XkmmXbTdmrDQ369LLFA5BW/G5DmLtcN2PtpZtYU/VJqezz2UqvyhV9gz/QQA?=
 =?us-ascii?Q?7r51TSYOJIS9ZdexlmzqEUq4tbvpLdTu3R8AL0mRlYbOEPMk5kLy8WMQs9QL?=
 =?us-ascii?Q?qBvZQEE9VMqajm0XpaPZppG6RhKl74VdIEZB/c2lpSrcFhU0MHJp31RIEMqW?=
 =?us-ascii?Q?2N0SeKVtA2NSt0khkLirsV2quZ2KgxdIYmYvIuiPZKONSxaDii+V4eDhAnbD?=
 =?us-ascii?Q?PeIBPQof5ghoBT/CM0zUfzj3UAs6+LMQ/ASJByLOWJ3tNxythkj7FzioU0HV?=
 =?us-ascii?Q?gCq8GytexxndvbJ1xYiXgzp0+X2aebiom+RZLsnatZZWGHyRCXSMDHfF8e4t?=
 =?us-ascii?Q?2rilIh5VBeRjKV19X7mQ/TwSDQxyKxpaG0rODva9rSKxuzeOdWewMEyDx0ct?=
 =?us-ascii?Q?wm1OUsJ8YQuKN1ScoIjdYoyLyJDN/snQKigGE+jLyrV+Vdz6U1u+EHQ1Hugz?=
 =?us-ascii?Q?3uea5b+lblwAfGCV/9pRaEAo0j+4p+G5X6Cou7K7C2YKuNJttE4rgqiibQ45?=
 =?us-ascii?Q?H8A9rh5goFSi9s6IUvN0Xxu3UlMBiJRdlB15/CPJTuN06QFeVq5HXlyVdjI9?=
 =?us-ascii?Q?Sb+g/JLl/zzoXmKkkfZ75qvezXwRp0wb29z70Ghhs1p+dw9yt1yWx4OTBpmc?=
 =?us-ascii?Q?FKxud+VHx+RHpFXPD5VElzK0QXLHPhxLqHyXDMkcpq4P4wR8lAxvDYH5vtus?=
 =?us-ascii?Q?sIDR+8VHN4z2/EJkoHTiZsqfz7RtBj3soJ0ESSQ3xNABgACaRfEGXJfMl7b3?=
 =?us-ascii?Q?6akz7tFTrQdyVRais/3zTEvROBJsaae4zyo6U7fz16swFBlMmS0eExK1BHro?=
 =?us-ascii?Q?t06TDvt24w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FyElSBwyZTfie6Ga6sPURatJe6beTlgBUK1WQJ2IbL15GH20rNndkEzRNNz17oszHdd+xHUaIY7sSnMxi7OkQcxixBxtsrnDUhfsYoYLggGAYo83W+DCtRa3OaP20NWAJCvcIhCHM23JG+R45FCCrMQ1MnLnYxkrS6+PZmYvda1OPj/dz+f07vu4dLvzhYktTzKhbxiYLnEFwI0xb6zcruPg1I6gpbJ7oH8KzByxWYvaPvXS69nvQESJC5MPJzZuJCtmPj9N/6g2jHNyrojUpqTFfZzbiNLHo5Hlg+p8jf+D4nG91pCymLYjZQldH2NF8sz5nfmfNwiCbeV4HSfcYFYWbe7gEpcRvLxG/xxpN73+Mu8ad65G62QdyUIEW4LgypmqRUTKT7va4WIgp89zmPCQehD2JIk5mvBL+GrU1e8kaIhGQFUZ3/Avbg7SwA4CC1CgcL8bXJV+GFswrU1oQMrujshDhXw2Br9q3h7RAINvDmFCZ19pq9rR6XkXNVWBvH6I1iyC+cQAJi+Pm5yeJAuNhEapX98z8E61b00V5zm5qJ6YOfpO07m+i/vSbCh2khuv2EYDRQAVfofZGDZnaSd+8FTKqGlw72c16RBFXWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8212f0b2-82c2-462e-5114-08de4c30ddf8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:03:10.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqY3zKyJHNjEqh7p3qEoxOgtpJ9J/HQILgMi3O9oB0d5ici+l9q8MyXkRF1AlRFJjHrE6VurgFtoxhd+8hoSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050071
X-Proofpoint-ORIG-GUID: YZFKHtMLeJl-3G0eqIKvySv-UpzXiqPA
X-Authority-Analysis: v=2.4 cv=CKknnBrD c=1 sm=1 tr=0 ts=695b7042 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lMPLp5VHBhqu3uUK-QgA:9 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX+FJYlY3Vn2NI
 VJm8O9GXK3V3d00T44sNRUMLzYuX2Xyzg2pPTSrDc9HIE+RghlDRd6PLY/7+ym9sVS4cudGpQi9
 J4omCbEqdR+owInIsIJoEzXeK0KrmPgdyG090KsX/J3C488CkDyu3kr2dgyV7LDiKmlgJOyp803
 M8r/1v9xcImrjtw6Rngn6BtjTZ7n8TQonNOyukzo6EnGoDs16g6Kw4awMjPaGHhaeBr18h7gpT8
 0PlzoN+s93UCmeseQhoAaegOeHA2lKe3hrxHyhmIopvvzAYUHgdYJzhJt6/L9EWL2oA6FKHgnjH
 Sr22h4lHK+CGxFkHPE48quLV5cTTWTOngRFqMV+ingD7gMl40ro0S1rfT/tSIgO8/9DNY744SYy
 0imiWXjujg8uJfWTU5vzeEN32G5aKf9H0NOIvhFG7roVG1BPSmXRZBGs3fVYzt0Ll7LyW09OMVT
 gXMR+3jCTuzS2MqNdjsyF87Be1krQZ9Bpm9BYOig=
X-Proofpoint-GUID: YZFKHtMLeJl-3G0eqIKvySv-UpzXiqPA

When a cache has high s->align value and s->object_size is not aligned
to it, each object ends up with some unused space because of alignment.
If this wasted space is big enough, we can use it to store the
slabobj_ext metadata instead of wasting it.

On my system, this happens with caches like kmem_cache, mm_struct, pid,
task_struct, sighand_cache, xfs_inode, and others.

To place the slabobj_ext metadata within each object, the existing
slab_obj_ext() logic can still be used by setting:

  - slab->obj_exts = slab_address(slab) + s->red_left_zone +
                     (slabobj_ext offset)
  - stride = s->size

slab_obj_ext() doesn't need know where the metadata is stored,
so this method works without adding extra overhead to slab_obj_ext().

A good example benefiting from this optimization is xfs_inode
(object_size: 992, align: 64). To measure memory savings, 2 millions of
files were created on XFS.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on xfs):
  Slab:            5175976 kB
  SReclaimable:    3837524 kB
  SUnreclaim:      1338452 kB

After patch (creating ~2.64M directories on xfs):
  Slab:            5152912 kB
  SReclaimable:    3838568 kB
  SUnreclaim:      1314344 kB (-23.54 MiB)

Enjoy the memory savings!

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h |  9 ++++++
 mm/slab_common.c     |  6 ++--
 mm/slub.c            | 73 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4554c04a9bd7..da512d9ab1a0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -59,6 +59,9 @@ enum _slab_flag_bits {
 	_SLAB_CMPXCHG_DOUBLE,
 #ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
+#endif
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
 	_SLAB_FLAGS_LAST_BIT
 };
@@ -244,6 +247,12 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
+#else
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c4cf9ed2ec92..f0a6db20d7ea 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
 /*
- * Set of flags that will prevent slab merging
+ * Set of flags that will prevent slab merging.
+ * Any flag that adds per-object metadata should be included,
+ * since slab merging can update s->inuse that affects the metadata layout.
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
diff --git a/mm/slub.c b/mm/slub.c
index 50b74324e550..43fdbff9d09b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 {
 	return false;
 }
+
+#endif
+
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+static bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
+}
+
+static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	unsigned int offset = get_info_end(s);
+
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		offset += sizeof(struct track) * 2;
+
+	if (slub_debug_orig_size(s))
+		offset += sizeof(unsigned long);
+
+	offset += kasan_metadata_size(s, false);
+
+	return offset;
+}
+#else
+static inline bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1277,6 +1310,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
@@ -1446,7 +1482,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
  *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
- *	D. Padding to reach required alignment boundary or at minimum
+ *	D. KASAN alloc metadata (KASAN enabled)
+ *	E. struct slabobj_ext to store accounting metadata
+ *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
+ *	F. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -1474,6 +1513,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (size_from_object(s) == off)
 		return 1;
 
@@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
-	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+	if (obj_exts_in_slab(slab->slab_cache, slab) ||
+			obj_exts_in_object(slab->slab_cache)) {
 		slab->obj_exts = 0;
 		return;
 	}
@@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 			obj_exts |= MEMCG_DATA_OBJEXTS;
 		slab->obj_exts = obj_exts;
 		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	} else if (obj_exts_in_object(s)) {
+		unsigned int offset = obj_exts_offset_in_object(s);
+
+		obj_exts = (unsigned long)slab_address(slab);
+		obj_exts += s->red_left_pad;
+		obj_exts += offset;
+
+		get_slab_obj_exts(obj_exts);
+		for_each_object(addr, s, slab_address(slab), slab->objects)
+			memset(kasan_reset_tag(addr) + offset, 0,
+			       sizeof(struct slabobj_ext));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, s->size);
 	}
 }
 
@@ -8023,6 +8083,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
+	unsigned int aligned_size;
 	unsigned int order;
 
 	/*
@@ -8132,7 +8193,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 * offset 0. In order to align the objects we have to simply size
 	 * each object to conform to the alignment.
 	 */
-	size = ALIGN(size, s->align);
+	aligned_size = ALIGN(size, s->align);
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	if (aligned_size - size >= sizeof(struct slabobj_ext))
+		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
+#endif
+	size = aligned_size;
+
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
 	order = calculate_order(size);
-- 
2.43.0


