Return-Path: <cgroups+bounces-13125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10296D16CF2
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41926306F309
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB1356A2D;
	Tue, 13 Jan 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EqbG+z0P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jp8x7r9Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6C368292;
	Tue, 13 Jan 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285185; cv=fail; b=VgQ5rVCQLWqYw2qaiqrBZyxwWX/EhKcTyKrip21WRn7t7UhRwQHLiMFW8oNvYBb5fj1EKy8wyCfmej9QVL2gteK4EMDS3bGEyOEEiKEn2UuOOIPOtROyFsX+qX8qjkZ+r1Er7kujdYkxr8VrHh0U4AJlbPxhwHGRbiD/e9jIENU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285185; c=relaxed/simple;
	bh=yuZ72/wMU1h+J/kNso4mVYb3q99qzq2iSHjqQ49K0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtcUSnfG6ENYXkE625LuB5ya4WpZ24xjpfjdJ2JjmiKi2TiHG2/naFgYzpDHVVE9YV4gHSncf+K298bnzxlE+gODcIYu4J35NTWjrnExeqM8hSgSBwi4xeE9zg7FDQuBnu6UDyOD1yXPRGnxmUwXz9A1PCGYucYaiyJJKoLvDhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EqbG+z0P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jp8x7r9Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gbdm2419350;
	Tue, 13 Jan 2026 06:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0TQLgZ+xdU0Gd8si5tXHeI0rI5RRDjri3WTn3+981yo=; b=
	EqbG+z0P6+pd3BS0vuwC1o9LC03yaSfoIhglEik7BeIXgXSV/OUh4sHNa+yqTcUR
	qFOf7nMN1e/FA1rpZdZ7O5zvqQa5rDrJYXZjxaURXVYe+RmtuqCRfTaTKv/8EmVw
	cW/6m331mQ/FGYNl4YNApedtVVYMpX0ukjLtkxokbXW7z3DcZHCi4IvFcTuFOYV+
	NBpxjbeqNVrD+ZS8qWMC7ZTp+FkQV9rnOYR48HtymXnJhZHBmFR/2wILzjXkkAdl
	AaCU4VHRcmXhYUtcN3ryFi2MmitgPUYXKLTw6Es5sgOKtXpR0gLqTsvzEOGo4Kf0
	C56r8R55wJqXRdTGKTk4gA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3tw98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D4q0BW004104;
	Tue, 13 Jan 2026 06:19:14 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j4dgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA2Q0gbrvgDJLDCcWpDKOFjzThYp2yYGYrmDWI5k03mHoz5vk8VmdfkUsxj0FqGjt0+BiwlkDPhgugdrsCzwt+LcCgBFGnuNsRT4cx/AYE92ZC3zECHZGFjrMzF1TAjS9GdMJDWuDuIJnsFQhDj0RFTEVhOOVI81ZnH038Nrq0HFDoyQmPYnE1/ctQhWGZY10TBxPujL+iIfM6zX2aCaXoqO7zl5GQBIfg2BS/Me9EjFxVL2a88JNc0Ew11yK7JG6Bvcs4FT/KOQDXMl4ZwDqWNefxLCkQYUv5u4B5SGpJNfx2Mqxc7T5G7b23quj+oWuSDepshwF1tJjTKQoUOFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TQLgZ+xdU0Gd8si5tXHeI0rI5RRDjri3WTn3+981yo=;
 b=qhr1xIi7gGjibQDSV7JvucwvU6NYG8LfbWyQRNQUVBFtM5NIxpBNbB1fvEvZoTNofIkQ7Ma7vH8udDHVrPA3+cEWah2b983PRVkjs1+Cs5wsi0EVMgulOclbV3G5iVUg3q2xLV1d1+nEhlKa4IifOKfQdhT9a+4gBYuBPEhMynHySmQPiN2EA+nnxLI/LBYC5tCg44lwYN7E+t5xLTvB3VDLZ3twxV5oAcYJUMZmmKKRzyTvcmge3BvCvWmxKnCmr1OQFPZ4sWEI0bl7z2tAAamAZ8VkQR6n/ghj6AkybuZF4mLLFUmGeAETDfrO9tZgbjfhJYwdayp1wRwWsEhHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TQLgZ+xdU0Gd8si5tXHeI0rI5RRDjri3WTn3+981yo=;
 b=Jp8x7r9Q8MZU0/DtloGhNmqXLoRdhDNoixFnOXWQD+caq5e1KhM497VaMF7SkoEc2qwHNc/ZYR0vsBY39x1ZNkh8vub5SR9lZUFBGq4nmxjYG2g+WQ8Ixg9101pPj1LDDLJnD+VlOvXo8hMvFqi0VswCmUU1UA8PaUTMxz+w6qI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:11 +0000
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
Subject: [PATCH V6 5/9] mm/slab: use stride to access slabobj_ext
Date: Tue, 13 Jan 2026 15:18:41 +0900
Message-ID: <20260113061845.159790-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:100:55::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b7d43f-2831-4cdd-bce4-08de526baa8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFwSgiQ95iKp7wVfyxmJnYDuc7284hFrXahjXJC+quYs0nBnWIlFeNULw77Q?=
 =?us-ascii?Q?bINwTI5fzrgoAnG8GiCdcCwOlg4xXzWu4Uk6LBVh7qGLNA8k8MuPC+lEDS9e?=
 =?us-ascii?Q?oqz0DmHB+E42Ej+GOAV+XYu6NaI+fBHG8+7KS978/wRgJrEJCPFIkP7WOulj?=
 =?us-ascii?Q?ofgTv0qCd04tF81fesy82GmDq6aeIKjdJF6cl+Y11JnWTzrPGNJSogfa31uH?=
 =?us-ascii?Q?vuv/f874KJPimu0F9szuo/Nj5ULGdNXkDGCBZdcLzyYCq+sYRhiv0srh8CvG?=
 =?us-ascii?Q?3avS3ECT+plB93FrPe/MkjMD0HiLwnRnw6a7DrNpcNxNB8QDqI10iVxBzoCR?=
 =?us-ascii?Q?Ouw7jVLd07iD8h35C1TlamHRayS3P3vq90eCJtruxe3UcvCaifSs0RmgrmSw?=
 =?us-ascii?Q?SEOzXMAeqtkRX/9O7oVrlWXQ7wWELUp0nh04tV6CWiUKhM9DALcT2/ckl77A?=
 =?us-ascii?Q?6YOKDgfb1k2ZIDPUO3W4kjtF6sxYmVZypxekZ6bEPDvAgrBrkVMm1G8IEL/Z?=
 =?us-ascii?Q?TIoxMBdaUIQJnuBWuVkqLHYTvKAz/roUCnDEYT17ewSeHwAbW0L5Ce19ubEm?=
 =?us-ascii?Q?2YovbteGsacbDnRJ7aWdbYZmCeil3LLI4DJxAWivKjEWUq+PdAItiuH7EgKA?=
 =?us-ascii?Q?t+RCeaUU+BssP7WChYdiWTpeiAKldYdI21+4BTWCaKV7WwTbs6d2gLg2RqWU?=
 =?us-ascii?Q?FvMGxgFF1SQcrRKbFotZwLS+BO7fEJij/V+pzgaa+34wPIaGFT1rEWeLVBew?=
 =?us-ascii?Q?zVvkPxK/XH4GP+OdLapWM8JCxYhJNoK6qZ66dFUtNtfvWS1sa2zu0MEFx9yR?=
 =?us-ascii?Q?s4+V+EMTLTJs949g97HWVwKbwCrXjgYuEOZbDgoany7wNC9LpAuMvGPzaaYL?=
 =?us-ascii?Q?sqQZ4tNLOumv/US/qm4E97b2DzW4yeMgFSsU6oAQkSJVPnN5EdrRX464AZNa?=
 =?us-ascii?Q?wUuCaIYnpTsoz9M5ckhrajOGzlURnfx41jscIGDEOP9v8dbfpXtsloT7Gmt0?=
 =?us-ascii?Q?M+qndzDaCD1wj09iVFD48yXu6JJtavOp6J6sAHZPm/tAEyykqUVbSseQOFKO?=
 =?us-ascii?Q?N8bwyCOeMQhQzHZQcTDwxb8m5CAx9iFxxLZJjI/qdCmGmnk/YkigPkNYlgKJ?=
 =?us-ascii?Q?dqzLgnH+sXGtYL/HSXZBeR7w3kbDAgm9KL9JpvQU9039KOaSEM1Kcf3ft95U?=
 =?us-ascii?Q?HolJIZF1NjbK/G3rOx07XAewUUHYUxNPbeZzarMoQii0EYbqpx0gipgBwp22?=
 =?us-ascii?Q?QVneKNonPshYPeXCjjK3sFW16JJrx1q3IrOT25A9Kk8BXWOhirJFwmW0FIGV?=
 =?us-ascii?Q?rm6M+GRbCEA/eHbHQGUz/PakHTnQBYfRFknh/q3yzTeDDujFysbe8E4Ribee?=
 =?us-ascii?Q?OzWFJvYyXQo6WV9Exrwolk0CJtPlt+4OyOjJrks+xG5GbiflkBjwLQtFnlt5?=
 =?us-ascii?Q?EqbkV2YCc544rZnIEWJQKoD6xnOceOzB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56EhyyNp9oMiDcXjB7f4Q+m666gyHON/lYzmz8qCcmMxvrj6+7sOW35f/AyI?=
 =?us-ascii?Q?PdNYlhzOVBn3fDnb624TqCjL4H/55Ez8fhkbHfobg3bEOtyYFYJ0wAHiBfkD?=
 =?us-ascii?Q?n3XzkqmNLSBQ4CIXgI8vWkTPN4N3kIY2Kijqbf62VblAs7r3LW/ctvQjkw8F?=
 =?us-ascii?Q?PyivrN8U9L6r751vfJ4oN1aUHCcfYoEp7P06WEjfVUDJYwMQSbfp02Oth2vF?=
 =?us-ascii?Q?IvnCqlHCVbEuJ+dy+mb0D7rxUOdtD7NT7jvI+JlDf0ze1nhtqYUXir3vMyST?=
 =?us-ascii?Q?Ec8kEN/+WoYlvNz706lU6eRiACW8OLvK9hGeesdGU6qhIcqlZFKiqHUS7ty7?=
 =?us-ascii?Q?8yKTYzal2WuNkDMVgXFxEIAb9UsY7RL87+zFI8H4piDZLyehRhUbPGA1PeQN?=
 =?us-ascii?Q?BtmRAYnj2kw8CJAUcQb5z4rM3CAGHZzse4JGGmsqwNRHHWK+RMKfsMa+Wgti?=
 =?us-ascii?Q?+Gn02alSzncIYRXxK3XUfwpRu2GP6dYDU6SgJm4HVP2GLfBrLOTE0K6CwPfl?=
 =?us-ascii?Q?jXGu8aIcM1XeU8YX/kpbkZVw1tADKx3Nnlg6c3J+bVl8c/Rjx+lwY5Z9TYdM?=
 =?us-ascii?Q?LXKqR44sFLm6qcVCWjC8suW8NOy65ScNdkoKKQR+hnxItLVLF2iXCKjAQMQo?=
 =?us-ascii?Q?SQJuDcXpOr0Qg4NcRZX5uswD1WXPbQ1QfHO4OxItFtHj5+PtP44ELkPq3m1j?=
 =?us-ascii?Q?LjOkVkpbuYzCq2xNo6DAMT0sCPrIKjsvQjAZpm3FfqV7YnOjonWx5wAhIJQL?=
 =?us-ascii?Q?EHuT1+Czp110omfgX2+2Lssre5QgwGWD9vsbDLNiv1SnsjvKVz9WpfbBjxE1?=
 =?us-ascii?Q?npGfkVfoyxiK5JUrqOuC9oP7o5XF3XGgrmyAWlHffj2yr58OanpAQy6YNzU2?=
 =?us-ascii?Q?2YhuWn14gIZ27l9fVnDrv6hhcwfqMta9YA1WfM+HDo4eNlF8HHUn1iZXZMJE?=
 =?us-ascii?Q?BKx88oN3KB0ZpTdYWo1hV5TM+cR3Nl/gxdvYM5V2IVENg/Mzw7YbZZU/8OZs?=
 =?us-ascii?Q?ZIxlVtDlfGdXNLxgkf0xgCOXVV8KlPyqLPWpf8z5Em4wUBhhckcN9Xx/Qt8g?=
 =?us-ascii?Q?+Q/BPANFmXs2QChCCtnmQewrLtIX0NE/Pwy27oVK8EdJ0S5mrcX9j0xE8FBF?=
 =?us-ascii?Q?UD0nA03TiGhWNV26I14uckmHiowdq9nSjZwBQRchHRfTT45mC70InBF2rzpY?=
 =?us-ascii?Q?Hepi8DBGs9LuyWBItZCemPyiL/gadaB5FGvy2pPcFgVba02fqmJGxNjF8kgj?=
 =?us-ascii?Q?+rIO/vBRMAlYDTGL/Y9D3Y/+BZGWbko+sT+iVZPVZZbMV61rmkqMPSkNW2T1?=
 =?us-ascii?Q?kwifNrY5xRmKXHiEeE4wa09u9KpzUBC3Y6Iv9QaIdbQWSdZ8Xike8v3BgR2l?=
 =?us-ascii?Q?JH2XB8gSIFNNbHZ6pr/O2a2ihIzT1sVJnb6k6WvuzpsYUMFuccS1WVUOTffy?=
 =?us-ascii?Q?ttUuwwKZ0nLvVMC9y2B47UUlAIVj4+UoHmpSPQ7A5RRlJyvKvm55AVpM7WZg?=
 =?us-ascii?Q?OYy36gXGFgSsLR43jIE56Cpo1B084HqZk5Hw84dNCIx+KViIQrUW2CpXWqlT?=
 =?us-ascii?Q?DQWMHYGSI8y/SRPaywUnywWBcelU7r6cCQApcn1f9NIaL/B00kbE7h5VIk/J?=
 =?us-ascii?Q?5UXsxPxg8X0tFpaOlC2yfw1InxOhEXUfRklahfQbp5ynxJd4I+uNSulxQDzM?=
 =?us-ascii?Q?274dAZ+zHHEMJoxwLNoGdAojUr7zhxFf7b96+WJKkAp5+LZH4IKPyhcCul3Z?=
 =?us-ascii?Q?vBbOceFrsA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W/6ceEszC3O9aMDmbd3kitvtkuZ+K3WwdB9xe9v494tR5EZH9gVKO5bp8Kql6bTZgmPyPiJQTzZInLnidRFUFgFP0U+Ir2KBoR2yB4zAbEii59m1K6z5YhtTKJP4HTnGTP4Tx6k8dKCWpxlyGh64ckWWLWLYItCFGsEyxbv8HvySIxgL3lHBzSSri0AFwXeEKgVYLTfBH8SFuk88TNljtpw/YX4HWCq41gJF8oBPmMyx5RRt2WDgQANDleakIR0hcKQ8SP8j5wNHlacnCPhEAVpFD4KeoUSmUOylT+7wkILJUAR9lfCUvtw3ET0iYC2o3BqNdVgILXV6ccPZFkbNoBgJ/5vrcSV+b+G848OXovnQL7qN4a0Rox9oBQtQTkHg4jJFph/kYclcLvSX+1PicIi04d0X61+4o4yCYuLOdIxP37bbHaimuUYvU278ZQ0eLwPThfVkowE/2931MkKBEIPMLifymeoaZtp8ON9Nzamr5iIRMJ2dbYpfR0lZy7sHJdnt4Gdx0GFa9w69PEajVuN9pMb5rLg+oHxEi2NI1k2sshzd4J9bj9o8eQmxyhRRTGks7DKx4BynMam6w6GYL7soM8RYYmfRrkCR5nQ/Kvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b7d43f-2831-4cdd-bce4-08de526baa8a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:11.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DL+wcBeWr69RHYxuHeNXtX5C5VU2b2hE7Ijkj7pz6xU1yrWh2icmN6upcGLPeIZqe7XtXwdPqbkwnI0mUAteA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130050
X-Proofpoint-ORIG-GUID: aQ6TfCPEYSj0SUKIVOQ2G2y0dWlgdvYG
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6965e3e3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=UZPuyEf3i8-D8iXyNNYA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX8jZc++bDtx7U
 nMQM3htKe6PmvWfsCNqGbTVt3iZzKxUMrC5+EKFZwba7jgRcrJxqL2tfJtUBufNrMc2COzMoxFM
 SWR9ThvE7B1oDf9R6crxA3AKLnnQd8InaUhKiJWs1Ul+UcRqBQuPQJErVKUjf/E7Gjd9zV9L3u6
 G+0+BbjrxilekBqoA0pObCumeVirmBp0fTCtxERklkoisaYwt9GHi+m6Jb2ckRVToMo/nhj861x
 rY9zCaFQ8nxxf5ieRQC6PViiwMJOUMMNu7VPGF5EBotUoztWhP+95SYuEagkByu5k0tUBjHKcmm
 oIe9WWCbOw+GkmcHm+lU7f55CPNDEfMLbObQ1vdnt91u8sJ51zSCHk7XrV0RG4FjjWKy3rd0e1S
 0XXguRpoa4p0PoKs1fdzEYme5Ofrlz+cF9imP1gLmOwPGGBwtir7J9bN2bQhxED2QIHTIoWmu1z
 CxxycWXQOqPb6nvsotfyMoO50JE6Po56eM7/yQD0=
X-Proofpoint-GUID: aQ6TfCPEYSj0SUKIVOQ2G2y0dWlgdvYG

Use a configurable stride value when accessing slab object extension
metadata instead of assuming a fixed sizeof(struct slabobj_ext).

Store stride value in free bits of slab->counters field. This allows
for flexibility in cases where the extension is embedded within
slab objects.

Since these free bits exist only on 64-bit, any future optimizations
that need to change stride value cannot be enabled on 32-bit architectures.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab.h | 37 +++++++++++++++++++++++++++++++++----
 mm/slub.c |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index dd23d861a8d1..ab7b3e386fbb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -55,6 +55,14 @@ struct freelist_counters {
 					 * that the slab was corrupted
 					 */
 					unsigned frozen:1;
+#ifdef CONFIG_64BIT
+					/*
+					 * Some optimizations use free bits in 'counters' field
+					 * to save memory. In case ->stride field is not available,
+					 * such optimizations are disabled.
+					 */
+					unsigned short stride;
+#endif
 				};
 			};
 		};
@@ -531,6 +539,26 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+#ifdef CONFIG_64BIT
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	slab->stride = stride;
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return slab->stride;
+}
+#else
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext);
+}
+#endif
+
 /*
  * slab_obj_ext - get the pointer to the slab object extension metadata
  * associated with an object in a slab.
@@ -544,12 +572,9 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
-	struct slabobj_ext *obj_ext;
-
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	obj_ext = (struct slabobj_ext *)obj_exts;
-	return &obj_ext[index];
+	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -569,6 +594,10 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 	return NULL;
 }
 
+static inline void slab_set_stride(struct slab *slab, unsigned int stride) { }
+static inline unsigned int slab_get_stride(struct slab *slab) { return 0; }
+
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index 7c855b84e9e2..41c541381627 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2163,6 +2163,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
-- 
2.43.0


