Return-Path: <cgroups+bounces-8700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68408AFDC40
	for <lists+cgroups@lfdr.de>; Wed,  9 Jul 2025 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665213A5497
	for <lists+cgroups@lfdr.de>; Wed,  9 Jul 2025 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E82C8CE;
	Wed,  9 Jul 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ghHMkZ36";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yqlbetaY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1F944E;
	Wed,  9 Jul 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020137; cv=fail; b=f/ZneoW0yRt7Qx0Ne4e++CanrelGW5Uz494c6NU8R2b9lTNC1+mArmazFVSD3X9uQKh9PFTYHdPjjYAuX0jxRIjbDPxeszHdIIOkavoPQL8Dqi1hNk6awjmYa+bSkz3vQV7hOTMHhdM7zC9mYkJFJKwLBSsF+faHxPV57+LHBzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020137; c=relaxed/simple;
	bh=PP28W5yK/MXRQMeonsCxW4f6QrjhUY609Psaj9ISG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WBqqi1lY8Czd9PDLn38y1bLMXEiZ5Cy4s6IdOKuL5NBiiREaPUw83CNPqHEzwZtJDuHJo85m0bSEi5+JS0q+tekBhnJWqYfIZBm+7tWHBvG52+9QIahQ2tgRsi51L+OFuRAS35Ne6JfZpSebCxZep9PiiJKO8ga4N8r2UJ9yZPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ghHMkZ36; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yqlbetaY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568NN9wf021977;
	Wed, 9 Jul 2025 00:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZBJPSLqIu0wLKE8JgdeyExPx4KsYTnqXErcuCmehZPE=; b=
	ghHMkZ36hflwhbF+35/Xn4Xc0Bm/ov33YOyPORYWpEck7veAbZpqFbGkY8S3fEjP
	1+s93/A97MEzo0dqUI7rQhYkDis9S0GPzsPGHy/5IzwS8t7nS7jz4fg7zYJquhos
	QyGu3m9Jt7Pda4VX8NY3i63RLjunCrDC1v5MmBB/xaOLACt7CoJ+DpDCQftxNcbr
	SZObViyGv3Cp2Ncx20sSv/WG/Hy2e1Qy1Z50ZVyimcuEFC53mZt3FAPgX9JT75Gh
	Hs1YublcN0iWyA6D3gcNuhjC6udxGv17Xyjr3SE68CSE6D/0R+X99LntsPtToRIu
	nsdjqclFH1INnz3xz+qCWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47scxbr173-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 00:15:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568MpZQn014128;
	Wed, 9 Jul 2025 00:15:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga9x0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 00:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy3X9x5C7fYEU5BKvVmqiKfD8EVPPOq7FMuSEJ1praKy+SuuOFoNKUUuUEOu5HXOfcSHcyxs1boUMJmJj91tMhXaX+zPQzykOTnPRE8w/THS4H2NdREMuk9tQS2BtChJ8ZAHmtWreakMAFT0FFue/Y/7cgY0dj1bwETTqanw1tX0qJy4A3d0vk41urD1Oa6XJGDmDDlT8KcQZiafeuW2N0BIWpcL2FSnEIKCERQQruVRKXSJUiIGBiC0cY0z+1m2wROsjM/IsVtQSkZzw2yBpsplM3ZIthIj8twIY4fzYJsu23O3Jwkie6lBoRth9Em7upKVAtD579l1+ZH3UXuKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBJPSLqIu0wLKE8JgdeyExPx4KsYTnqXErcuCmehZPE=;
 b=NEV6NcfBNpq8alvba/VCdpNVAziTUi26PVHfHdd30+YrvtNV1uF1lPyAmKpZaFANKf6rmd54ZZAPXDcA42qjff1CtPL3HMvZnmwLQ5UiMuh9ybLAba4TQBu98aOH28V3VkioIq9VCoSUCl6wm0kEy4Jxs/nfl4IWEnEksT+UMjvqot3q8Gmuis02CmSPgFbMsGlCgVMqlcv6+WIkCmsTxCqpKbE5acTiSWKOV4rkQVvMdPy4eRwXa7TosR3+pwx9+mNwFIkkg9IfmPq/CXPyqve4BrIDehhuj6PTNn9qSxfCW6xu5mg8/OHssjoOit7v7lWV+wf/sI9IaFf+50mjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBJPSLqIu0wLKE8JgdeyExPx4KsYTnqXErcuCmehZPE=;
 b=yqlbetaYGxA+unGYYEHiHhR5o1E010hBZRS3jHnCh1pu5dm5rXp+1pf0y/kxtKnHUIqnYA/w3zLbbAWYsvH9EjDtRpAufJl1SijHB+k+D97XsSGwRplFJCxIQRngTwUdv3Eh+U6hEIOD0MuxeY2qoUFHuXsdmB5K5qc20RvItTI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 00:15:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 00:15:08 +0000
Date: Wed, 9 Jul 2025 09:14:50 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [External] Re: [PATCH RFC 26/28] mm: memcontrol: introduce
 memcg_reparent_ops
Message-ID: <aG20emoRBvezUXTx@hyeyoo>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-27-songmuchun@bytedance.com>
 <aGKHXWJl0ECKN1Zh@hyeyoo>
 <aGRdVzB5Ao1KkEu1@hyeyoo>
 <CAMZfGtVh0bYd5E=kK0ZMqECJraif+t0HrqVR046Q29aSJVZNvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZfGtVh0bYd5E=kK0ZMqECJraif+t0HrqVR046Q29aSJVZNvQ@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0047.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 982351c8-cd08-4151-a976-08ddbe7da9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGMwRGszZVA5ZUpDdm9kbGpORExLQldzMGVhbXA5c2FNRTUrOXlQM1JyT1JJ?=
 =?utf-8?B?blFreU50dDZsZlhISXVyMTRTL2FxNXZiR1Jnb29zczMvTXcvRGk3NWxEK0p4?=
 =?utf-8?B?Z1NjQ3hyTU5XTmVXbWxyNHAySVVVMVloOTFXNDMweDdYTkFuSEx4eWFOYjNU?=
 =?utf-8?B?bkRnNy8vZGc1SXAvaERVNFdWdWxXTTFna1hOWDFIYWpVN3F0czB0cDQ4OEln?=
 =?utf-8?B?djI3Q2VydXhydmloREsyTkcrTzJUR2VUUkNWWGhRQkN1OFl2Rm54RXpVWGl5?=
 =?utf-8?B?QjNkV2I2Q012cHdqWTlwWWtURW1idXRVejR0Vy9pSHFUK1NUaXVjQXN1S0h6?=
 =?utf-8?B?N1BsVUpDWW4ydy9qYTVLREJWVTlOMS80Vkc3SlZFTHRwMVZvTk1ObVhvN3Rv?=
 =?utf-8?B?amVUQ0ZtREordTNWZ1VtZjZxcUticWNLT2swWndMdGV5T1JnWTNFUlBiNXAy?=
 =?utf-8?B?YjZ0Q0RGVWRucnhkOXFGdkVYOGxVREI0K3BnM1RyV21mN0s2MUtTNFYvdU4w?=
 =?utf-8?B?YVJKWEFsaHdBZ0hBSGEwVzJHZmRaaFNHT09zZUpQUERIeWJWeTQ3cS9zUVBu?=
 =?utf-8?B?ZzZXZk9RdVJwVTFDMDFCRERvSDBNWFgzTkRmdjE5RUZubVUvSnVNb3NIclNx?=
 =?utf-8?B?T1lYdzY3UkE5QjhOdlNmelM2ZnZVWXdTUnllK3BId3lRTmFaK0ViZWlOK0wx?=
 =?utf-8?B?WFFMak5tbFh6TG1RYVVGeE95ZXBVQWZTWXc2Ris4cGN0bUp3L1BjQW5DV1hs?=
 =?utf-8?B?T2NNWFE1amIyQnd1Y2RFS3VWUERibWp3dGNER3B5U2JzM0RCNFVlZFowMVBU?=
 =?utf-8?B?SksrdjV5QVVIbzF6Z1BlZWtraXdPekdWZS9hV2dmbUFUWXBUNUlwS2RINnQ5?=
 =?utf-8?B?TmdNOWZwTkNwTjZVS0NxWG9HeThhREhRc3ZkeENlUDBReExaVkV3TzhYQU9o?=
 =?utf-8?B?Vk1LQ2NOQi9TVm93NkpvRHlSdGpsYis1N3lqZjFzUytqcEJXdktNclBveTM2?=
 =?utf-8?B?L0ZuZGp0QW1ZV2tIazZ6UXBsdTJHMHl1ZFB6ZnRYNVZOUDFVeEZ6T3NTYmNH?=
 =?utf-8?B?TzZtTmFrUWN4SGdhVlZ4ZjdGd0grQ0luT283VW8zcGpDaGlIRHlwQjArN3Vo?=
 =?utf-8?B?bGVsQkdldXhVMlhsdmJ6OGtIbEY5dThYSjdJQUNuVyt2aG9hOUlwb3BOdndr?=
 =?utf-8?B?cVJmeWw5UjV4aTJHMUZBT0ZLK215QVBDcEhTZGJESDFkSEhFdGpNMkxwRnJU?=
 =?utf-8?B?dTlFbHNDOVFFd0hJUGZBV1I4VWtocjJleC91cWdWYXN4VHZaM2V6dllzOUQv?=
 =?utf-8?B?TURhdHJSejJxUm8xbEU0KzZyQnNPNUdaa1VLVExTN2NTYzRIMVhDN25EZXBS?=
 =?utf-8?B?OGxxYVc1eDRaK1dwMTRXZ2FrN0M5alllSFAybEk3Y3JmZW1zSE5wTDVUUHVU?=
 =?utf-8?B?NVBjSjlrYmthR0hBREUvalRDdTBoQWdPMmlPb0R1R0hvK0wwV0RSTkR2WUNl?=
 =?utf-8?B?TU9BSllLUU1PNnlBYjhocUQ3cVRqazVYczJOSUdEemtpVEdsc04wWVFZN1Vm?=
 =?utf-8?B?d0t0QWJkbjArYUJTcHFFYmFHbE5lMUlEaTA5VkRsVWZWZGJLUE5wUDJ6ZDYx?=
 =?utf-8?B?Zk9vT2RDOWpXc0l1TkdNNmpPcWJyOFp2RHdKMHRvZXh6MDlKSUQveC9rWlRT?=
 =?utf-8?B?K3REZjdHL2RMeWNLSFJFU3piUmxzSUJwWkZCQmw1SXJ1WWNNME05Y2lhZmor?=
 =?utf-8?B?ZDhRY2RuOXVDUXhabURZQmNoZmp6R2d6ZTRtVkprK3hTYTBTaGhjSFhGTnNO?=
 =?utf-8?B?R0E5SFpWRWY3TThhQVpqdlRvOThiK05JeXl1MmNwN3Q3V3BHdkk4czRnS3Y0?=
 =?utf-8?B?QjFNRGhoK0JhWEk5Q1lSSWd3YVJLNFUvWnI2TS9JL1VoaFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2hoWm5mRnVPRmoxMGl4d1dQcWdqTnBiQ3VqS21SdHVvdHh3ZVRoRzdEZS9P?=
 =?utf-8?B?NXQrS00zOUtWbWxNeGx2R2c3UGZmaWN2SUNPSlFkWURhSXJ3WVFZSHJYRmxZ?=
 =?utf-8?B?R1lOWWVyNmtqSHhrUTlFajlOdENtV2ZZVjlUZEJuT1FBUFZGS2hsNW5aYkVq?=
 =?utf-8?B?S204aWRGSnNXcTlXWnpIazJlUDljQVh0S05ubUtHTFRndS9WbFBFQTFHa0dx?=
 =?utf-8?B?S2pxVEdWcWcxQ05KSzBQQm56aGM1K3B1Qm5SZFdxYWZ0Mk4xUHdoNmZVTnQy?=
 =?utf-8?B?bG5ZNTRHbFNrRDBJMXBzNTBNYld5dkhqamdjNU9UYi8rb2dVVXkzRTdYWGNQ?=
 =?utf-8?B?SGZvd2RsZ2hPL3ZMOXhaMkJPdmFtQlc4SnVZSnBuTWxCZWpkNXFLM3Z6WmJO?=
 =?utf-8?B?YW1Gc0poeDVpbFpzcVphbWJENEt5YjI5aWFKSDkwSi9ndnZQTWpHd2ttcUNk?=
 =?utf-8?B?ZW5ZMVNpekZKblYza1RRREZGcFVVSjV6bU9Wb3R4bm5QOXVqZE4yb1lrS3BI?=
 =?utf-8?B?bEZ0TGxhZE9rdUpSNVRTbXZXQ0xQU1ZCWUNoMlZJcWMyLzZMZnJZTzBtVS9N?=
 =?utf-8?B?Mk53YjhBYnp4MVZvTjhGRE5hY2VDd2h5czk2NU5KZnlBTmVTeVNRWnRJS2Nw?=
 =?utf-8?B?bWc1aVJhTDRMMHpTT2EvQXhxR0drS0RXMExHUTF2WWJxVUYydEdTczMrSTBT?=
 =?utf-8?B?eTJCdmwvaVY1V2IrTHkwU3o2SHpUV0JtV2FRY0JSTGxiRVVzTzE2TDQ4RE9q?=
 =?utf-8?B?SklRcXMySE1pQVliZUlLb3lGVnZqVTZxZW9tVkxxWlp6MlBMUFB1RHY3cnZC?=
 =?utf-8?B?Yk1seHVSaGJ1T3NydzBvQUFKTW5qeSt3SHY4MDc1L09OM2RuR0xRSCtMYjVz?=
 =?utf-8?B?czYwcFlCOTBGdXhHOWZlbzJzUHFCOEtZZHo3UG9xMHBmcmVIYWFhMCtHWmlm?=
 =?utf-8?B?NGhVM1g5ZEJiQnAzTis5VWRjSmFOQ2trNjY5UldSb0lNd2w3YUppOEp6QWhx?=
 =?utf-8?B?NnNWVm5rdjh1Mm9ReFppYjBkcGVPeFduZ0NGUmUwR004Q25iUzA3Z0NZcC9R?=
 =?utf-8?B?RHIxMWdrTTJwQnd2K3h1L2dsSmhKdHNYWk1RRWgvUFdrNnhnZ0t6eXkvbVV0?=
 =?utf-8?B?dXI2Mjgvc3NVWnh4RnltK1VrTVI1aENScXluallhd0hEbmNuSzhFUTlnWEYz?=
 =?utf-8?B?YnNyYVN4TTZhUjduQlUwRWdsT2RHTjVYZ0s4YnJ5eFhiTFdaNlRHVUszQXlX?=
 =?utf-8?B?NGxoczNJL09oNWowbzVUWXJDbUE0UFZXYnpFd0tsdFZ2OVBCd1E3Uy85RUZS?=
 =?utf-8?B?S3FxaUVZUDJHVHhMWExvSENieVhJbGdsdmhKU0NhcHBRMStZcjJmRXIrdHM3?=
 =?utf-8?B?TzZHRjI2a0pROHlsblNWUHZSZkh2VTd0a2F6T3NZemFlSUJySGM0aE0zQy92?=
 =?utf-8?B?NnBhZjhiN0Y5cDh6bFY5ZVpRVkp2WkxFak8wZ1ZmSlRUVVhOTVZNaktLSHA3?=
 =?utf-8?B?YUdiY3NRQkZTZXc4YzY2VEJqbDE0L2cwWUxxalJqZ3lMaVNjeUZpcWRSelNy?=
 =?utf-8?B?b1UwK3MzamRNT3Z1bW9kVkpnWFA3cW1DZW9KN3V6T0xHK1d1VkJCWWZQek5Q?=
 =?utf-8?B?UHZ1SExDejZKZlRMdUNNVDBBdVRGMFhycllYMVRxWHhCSFdxTHNqQ0lORkV5?=
 =?utf-8?B?KytlaSthS2FEY0VMY3ExUkdvOXpDY0lrUnY1OHIzU1ZJdHU4UkJ4cmYvVTlX?=
 =?utf-8?B?bnNTcWMzemNWZkZDTHRqL0F5bnhqVzFGb3pWTXdyaU1DeWQwcDFsV2RyR3gv?=
 =?utf-8?B?a0E4QlJZU1JKRWRocDFLR2xpdWN3UnZDcm5tUnBIRFNPb2hYVlBNSjFTTGpw?=
 =?utf-8?B?ZGorR05nTVhRMnlsNGlQTlU4N1E0TmxTVnFpaThZQ282KzNpL01PcHBYQVNH?=
 =?utf-8?B?L09MSWVpeE5VbUpScTk0Nys4OEtmYXBpMU1BRUF2M1NhTEg1NGVkcnV3S3Ir?=
 =?utf-8?B?VUtjRUJ4K2N2SnNsVlI4UkloanBHOHp3dFJ0SHhWenE2R3hiS08yZWo2Vm0z?=
 =?utf-8?B?WWFyUVd6S2hnUU0rczY1akJRcTRWcmwvRnUzTGV6dHNNRGlwNlR3QWg5bjAy?=
 =?utf-8?Q?rKNfXMaEU0a2FugqWZWkyrFob?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U+26+brJv6V2QK8eftYwpNMSy6lFUJ92NTOGAH6b74XK59T/+y8zrG8Exz59ocw9LKVYfm4wubL1wIFVds7TcKFs6clhZcg5Ztw4UKPJPFs2CvZ2LoMJrxZp8y37FUtGFunDG/essZ7juG1XGEpmXujxClYxIlD2rRERw7x+f28mN65mbT3hX0YLKU+1F1Mg4O5ejdVnZVD9Vv21ld82DoZUhqQfFI8xKcow+QOIsBavUXLjoi4nLYnuKqqNATT/004E2PagbnefOrapJB0sebRf5NWn372l6sbikuKmYqPGilWVoScOmK3e2W/gbYoJL+LQfAgd6lmlGdm5Nu6H8meZ5At0Z7bu1sKkE3+ktM+zSvwP/0Uxorj6v04C0jwyII+y3YmnJE2DTE4VlLTEsJttYutemI0WHwo9ii9QSey26Y4krpen+0AzcHGxHJZpfDzwLQcjqx2nBssIjs2eKDMb2qXdw1HXpWLWYHSDSYepct7JruEG3+oaJVrhqFB36sHistQehfWd4kVYY+rACmSjTD2DETAieB0tvHN6f/oqynVSp7m/tRk7sP5Q8iqkLm6G+qQzfi2dgHyAnYLIsSOBTxQaLVBnKrBT0lVc/qU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982351c8-cd08-4151-a976-08ddbe7da9aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 00:15:08.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSD+CZXJUz5NxIA+pUofvcpCRPJItjlW4TgQkgocMlRBOtLiyTH4MPIIlLCP8+CnQrBwIvHPbBSdVPL0agUJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_07,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=732 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507090000
X-Authority-Analysis: v=2.4 cv=Zr3tK87G c=1 sm=1 tr=0 ts=686db490 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CqMesUGD6HYyBvFlfWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058
X-Proofpoint-GUID: 53yp5IhszAOMeI6tUbyUK_oyCbaMOrpz
X-Proofpoint-ORIG-GUID: 53yp5IhszAOMeI6tUbyUK_oyCbaMOrpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAwMCBTYWx0ZWRfX7YYsNAiMGVy6 EJdJbtzdjnZoGBz8W3rZUDX2BhY9Mlr7SrSgAN/wVm/O1+v8tbTFfpZKEiCofZyrFPXGHsVoUWu UDcRRipOihFZvUwhssSRa9HcxOWYQFxYddTmzNS0y0TC/2m/GKoVvE1VG/O9HLNYjOtHbJFdW4w
 bEH2eMFAXVqFzEfFPjKi+KbFgxEq5+snziGa2YinK3WaEfK0eITxjv0p0IunJBkfM9Ys9dCQKGh NYlmjVT6IxhZPUrY43eFpLOMMMVzfmSYOpUc2F346hJk4tFhVEi54H7xeVW5XekUudvbxGBsUR/ pTZ7mntAUh5RwaEhDhk5X4hVygiU2uNVqg7JH+xApCOIfn8Uy0GeqaWpNG64pp8P8j7OtyAQvno
 fyAn/B41RnsP0BEEv5zKAY50pKNy3LiQeX2LHZue++LeYvE6WAo8q5j7s2SNhuMbSU2BeC/u

On Mon, Jul 07, 2025 at 05:29:22PM +0800, Muchun Song wrote:
> On Wed, Jul 2, 2025 at 6:13 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > Hi,
> > >
> > > It seems unnecessarily complicated to 1) acquire objcg, lruvec and
> > > thp_sq locks, 2) call their ->relocate() callbacks, and
> > > 3) release those locks.
> > >
> > > Why not simply do the following instead?
> > >
> > > for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++) {
> > >       local_irq_disable();
> > >       memcg_reparent_ops[i]->lock(src, dst);
> > >       memcg_reparent_ops[i]->relocate(src, dst);
> > >       memcg_reparent_ops[i]->unlock(src, dst);
> > >       local_irq_enable();
> > > }
> > >
> > > As there is no actual lock dependency between the three.
> > >
> > > Or am I missing something important about the locking requirements?
> >
> > Hmm... looks like I was missing some important requirements!
> >
> > It seems like:
> >
> > 1) objcg should be reparented under lruvec locks, otherwise
> >    users can observe folio_memcg(folio) != lruvec_memcg(lruvec)
> >
> > 2) Similarly, lruvec_reparent_relocate() should reparent all folios
> >    at once under lruvec locks, otherwise users can observe
> >    folio_memcg(folio) != lruvec_memcg(lruvec) for some folios.
> >
> >    IoW, lruvec_reparent_relocate() cannot do something like this:
> >    while (lruvec is not empty) {
> >            move some pages;
> >            unlock lruvec locks;
> >            cond_resched();
> >            lock lruvec locks;
> >    }
> >
> > Failing to satisfy 1) and 2) means user can't rely on a stable binding
> > between a folio and a memcg, which is a no-go.
> >
> > Also, 2) makes it quite undesirable to iterate over folios and move each
> > one to the right generation in MGLRU as this will certainly introduce
> > soft lockups as the memcg size grows...
> 
> Sorry for the late reply.

No problem, thanks for replying!

> Yes, you are right. We should iterate each folio
> without holding any spinlocks.

Wait, did you decide to iterate each folio and update the generation
anyway? I assumed you're still in move-folios-at-once-without-iteration
camp.

> So I am confirming if we could do some
> preparation work like making it suitable for reparenting without holding any
> spinlock. Then we could reparent those folios like the non-MGLRU case.

You mean something like take folios from LRU under spinlock and iterate
them without spinlock?

Anyway, I'd be more than happy to review future revisions of the series.

-- 
Cheers,
Harry / Hyeonggon

