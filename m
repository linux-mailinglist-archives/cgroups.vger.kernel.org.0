Return-Path: <cgroups+bounces-13134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A950D16D04
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA62B303D343
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACED369214;
	Tue, 13 Jan 2026 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q9bOaNeT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FP3U3ozE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5206369218;
	Tue, 13 Jan 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285233; cv=fail; b=U+1v15MbL2CU/2gYtTeLhsWLr8vroeMdIL88OHrmDAmuMWamlmRAVtg5ilgf+Xr5em7M8Y92xARZbT6I5TvEOu0sHtW2Te2MenBSJSw3VLP7wU0N0rO/OZ6eIFvXDLZqPG4Ta9aeQyClll706kwfz4Mx6tG5A+0KcreTD1XUBkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285233; c=relaxed/simple;
	bh=J0nQJM6mlR7W9WqtJfyTtYRQO3UqBh41pR7CIEfXO8M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h6/zUJaNfmfb2aC/lEMH5hrf0GQ/eUwFWjMbrt2kiWAXDsHnY3B1DlslY+S7mnPFAs2IKv2gdeqWmHh2Ql1KolwyjFPv1gTx5kq09sBfGPJS8u9vwyoTO2Ue4svsBodK1CdOjhdkWcuBL94nP7OOcftUYI7odTkUHBE5HTqxO+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q9bOaNeT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FP3U3ozE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1iYE92686260;
	Tue, 13 Jan 2026 06:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=P+Ip1YfyyFcaYNzF
	lUNuswMYnRJgu97QFo5jcV5uz2s=; b=q9bOaNeT6yEluUgLQpJ1OPqjHud/UusU
	7Y/z1eQFa/Yw38nn6J2y61weq04lnJWJZtggyhcRP9WrXemleytYmTUnlRwKKG4n
	9sEJHhM4Mw/I3pFKqZSI0F+GoOLXuOBT8JkrWkiL8e8EIYe+tmnlVfqVUPYIAw3+
	ksEAgLfaXg5fyi5+c2whXlAsU+9L51q9ZeErjuJ7IRoB6LUkHj+vXYmP/b6FIYQo
	OAqHzs133TREdR32MqtW8TNjv0k3e1bYIDO/NBX6BZAJEVh0W2RqWZEhf8liCu6Q
	V50Ejrj5ljJZJY54j72oJe2A2t9croNIKOe/z6PuPswJSNofcVbiNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb2xus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:18:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5O5Gi004123;
	Tue, 13 Jan 2026 06:18:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j4d5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI98jd5spPn7MvGs2y+exZeCXhxZCYV3No6Zs1d5MtE68qMoPzeNPgfkkjRcqYLteNPNmcSGHibWWHhs8OGqu467yoZ/dsTeDh4GFpfdIyKNlvBryKZ3kuQ1fIf18+q9q+q0lfJ35ZxeRrMrUPszyHe6QJSRXlkDIfnwYX3HXc7PBJQYdD9kbUs0HuG5N0bFalWjOICW39ONjfSRC1skzExVQWf52YIq5Pht+uhNC0mMl89Mx0vfBXCjNGdiGcOzVTcSQQo/px49plGlHn5w8QvpM/Bpf7g022eK7n0kkpqGDciE7D967e9urehujzesOCEsgnfrXpv145Zc9ke7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Ip1YfyyFcaYNzFlUNuswMYnRJgu97QFo5jcV5uz2s=;
 b=NfzZB3X1K2d7Ho9Rb9VIBV9wu3FjfsXIOiB8h/Zb85t0niBnb5Lu/wEuI/nvwJT3Mj8+eO8avh6QFQlMX0zM6SdC2IWHmgXIqh/YXSVoIi8UIHTuh3unTI+DYh+sZD307ZHV8KV0oVZCtiNQTZcBlukeeviBDJ5Wcas1aDNSq1SwaJudPnASoenqMJyqSjdN6Psuc3qNfstXDDZSWvTxeAzj9lhxeOB0pGbjCvYoel5UxFKPrk5dFaqwGYngMv0ssHtvpC2eN+jYiTwUDDL4FG6KqMoNR17gTuzrPeh649ZFugCO1rXta7j6GgX/ul7K96OgX5AwrvujFcf9Iop7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+Ip1YfyyFcaYNzFlUNuswMYnRJgu97QFo5jcV5uz2s=;
 b=FP3U3ozENK35uEYPG2UVsEPMRfDp8HNLJiEPZwPko3TN8bB4fDoFZ1E42d3tCHAyXSdPzOkKsAJKFwaayRRz0ZYNkhWlgC/v7A9RZlj0/YzW3Yww2I138h17j6LOOyBNZEuHfnnZokTlpqX3OFA5DYOKVjS7yOmZokIwTckvXi0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:18:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:18:52 +0000
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
Subject: [PATCH V6 0/9] mm/slab: reduce slab accounting memory overhead by allocating slabobj_ext metadata within unsed slab space 
Date: Tue, 13 Jan 2026 15:18:36 +0900
Message-ID: <20260113061845.159790-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9af1be-c732-4d4b-46d0-08de526b9f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7s9Uub6t+33q/YHrRkATBY27R9/0pHLbVxSGoj92VBR99xkjNJemb4dLlBGY?=
 =?us-ascii?Q?Lv3DKeb/AdiT5F+MPJKDGZM5jgFEQfbPnsNsZdEZSwmZHdl7+AWpcLVfQNCM?=
 =?us-ascii?Q?9RA2RJNrCFyiIjUEfhoa9M7I8LMHatfg/hINzXhebfOGKC8Or19Y4/3KXeR7?=
 =?us-ascii?Q?kkkZiF5anJ7x2w9DrzCUmvQNmjf5MB+5o6nnm2PoXP/6OUIQdAY5EwUnt3l6?=
 =?us-ascii?Q?BPB295gv19pnSWHXBjet9khkmHDo2BRp98yvtUa27wtff5NZUb6jjxpYLk3z?=
 =?us-ascii?Q?tEQlSuJZAkqub2dGxS7xTaPC+D2e5J64sm1L/3WvnP1zl/XF2Mk3unSQViyW?=
 =?us-ascii?Q?OliPZxfMTDrGWzIZEEqUZWo5AklWxgr0qEVPpIP8XEFkabC2BF/Bq7kEFiN8?=
 =?us-ascii?Q?X/foVF2S4FxNzuz/sEcgVH0YF8AlQodcE3Dkp3MLFw9GY3pTiH4RGzEoZ4n8?=
 =?us-ascii?Q?kvJi+jiQAOrZzvh8T3N7F0defC7vcEK/qTWOCHIkKlbJMKxhn0PhVoNSSNuQ?=
 =?us-ascii?Q?bAUaCk7Y1H6GyxnnI7QwyhzGOgNmu7fSxu/BKykpu4PeHlZPy1VPxCZRF/W1?=
 =?us-ascii?Q?YkOBhSuPlwDv/hz3SDLtzXsmFZnwK62T51mwVzylsA5J8rAAypiloAaRt09n?=
 =?us-ascii?Q?ocAipXeE8D9t04+Rs53td47NltmHhjiRgn1U48j84PijN2JRSTedsd84k4i6?=
 =?us-ascii?Q?kOSpTY7bexCG7gBhVk3i9PlNAmXrg24PEjtWYkn6MeZ0c+to7j+UBmbw0uHf?=
 =?us-ascii?Q?GQqrWuVCOrWRly3SZRle91AX5Us2KVDU5FV5OMJXO9HCLFn9uh+B8KNvA9DD?=
 =?us-ascii?Q?7KF8a4qU5V0d6xbDxGFt6rA6MBCZp0jWFurOcJxsOuRNGeezPBGGPXynHOGe?=
 =?us-ascii?Q?2fe3kgL+YAcIh4gsJN1HZ7/ceDq4Ff6zd1szhHt8uWuPj2S9h9LLog3Ri7Nu?=
 =?us-ascii?Q?ZvMCpizfh705V5SCZp+hp5tZYFIbZyOalAOEpiXgJ+FW/uMexMvUYTlBJi+v?=
 =?us-ascii?Q?boaVRhvxHgtnhR9uio8J+tSNg/i9n4x53vzVWBsYk3rnPn5lR6LrmOlyQHVF?=
 =?us-ascii?Q?+W9aRWl1GKmi5HHkJlnr9K0cv9S6ko/n91S1crA0p7rjuMJiohKG+P/eVeDp?=
 =?us-ascii?Q?EZjiaBIfBheFHmJo7Db03Zc6us9LfWNHr2lxooZdCoPTKszr8YYa2usGZ6Gy?=
 =?us-ascii?Q?6uYOKV6UdnxcEMs6zcGn19BYGa4EMNtynprtFkQH4ki5edTpIsccl6iZ6hSE?=
 =?us-ascii?Q?w0BF8uMxA5RkivrOytNhArNcwFrYnm20nk3jMGiHLaZQ8x0Gorn/TJvjhJ2H?=
 =?us-ascii?Q?iSTo/gmc35gwes/I28FYYNclqvjIa6VsJr9RqbEHF2y56UlIHWVfaC1qEJSU?=
 =?us-ascii?Q?M6RkKXnqLjkDTDJt2OvUSTIsJAb04zliA+9lPzYpBqMENZCEpm9NK3JT7Jzy?=
 =?us-ascii?Q?3JHpgNiInBLWQvSUmkW8DXzdcmen/LMhEQCqEyDvrfL7J1ymF5Sa7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mporZ3tlS+4GsBzFVNiY5L2Y25bcmimX5+ZNxfkJEVVYHAxFsf/jc5L596bw?=
 =?us-ascii?Q?rW41z1e+mYwMpvu1TQdeMLTvmtsPJeQwwWfE2EuRTNA+1azZM0zKR5BwfJDo?=
 =?us-ascii?Q?KWcg/CbajBFnUUlafN0m/7ddznZySTJhWx6/QFa4pG4lLJ6+1kAjGzGWTJrR?=
 =?us-ascii?Q?byvG2dYa/nKnEeXAyhm+XPQbfON283a4PnMfomF+lJu9JsXLIPJP2ZBYpvDw?=
 =?us-ascii?Q?JBP5nC/S5AUQbmMqf5TyoVzlClgAqikARrNrfvoa24jJ3yJIXcXyCia4nmbK?=
 =?us-ascii?Q?KiZks7gD1wRAzFIYVupNNV0zk65iDOwRjSCH0EiSze6HCAKbziSpf+eQBw4J?=
 =?us-ascii?Q?4K8Y//uaeLP942wLxUk/aTJskLCV0Ge43YDHxuSL17XmtLz1JPluTVscN4DV?=
 =?us-ascii?Q?8N1bNTin5FSf6U2C6CxCYzZik9oVI6sTmU+p3o/X8hL1LnmCmPn0YFlqIkUl?=
 =?us-ascii?Q?9SQB2/+kbUDxVpqq68NWToPGdSMyPjEoExWX2yCdhZtClQwYbVhNp7sUthZw?=
 =?us-ascii?Q?9s45IZXTORkVKkDMsHK+BGVx3oZSeTiVbiJrcVxXOPWgBrXR80oAAWzLCFNy?=
 =?us-ascii?Q?32PnLAkFBUowY07jAIPNk5doFeY/lt9LuLr6ial1L5uohvdSf+oHapC+EEkT?=
 =?us-ascii?Q?uaSBWBlZT+MPFdV77ailjOwOt69ec3OdY371r9Ik9Rte70asYZq1Txu1DX3T?=
 =?us-ascii?Q?rMVzSBwJv+ynR1o+Xhtk+773F8l6vHR32I56vRcXufhLV7yvGfKj92EloieJ?=
 =?us-ascii?Q?RtHShzMYKclyuQnpQxdFAibm+/RWSDODpUoN2Apx1hW28oHzvEfQj9LEg23r?=
 =?us-ascii?Q?tDovYkc7XvcpB0544mcr7XdJTlmy58+Bl+C8LqN1uh1uIX7szZU1L3WyMaS+?=
 =?us-ascii?Q?lc4Hx0Dpf3rxGb/X+xiZYYdR8GPL3P6gAF4B5StcZBRh9Dgmv3Gwl6JPqeE5?=
 =?us-ascii?Q?ObT0mcyZtMGB5x9CEBTxyC1j8NxsXX9WJtXgQ/DbtrDBMvdwPUqE5tIF2mEg?=
 =?us-ascii?Q?K+Xwo8E4p6VUdemDNjrCYKad7BL8dOPEDDVC8P1E9dVHvjGrwFSzHbW78YQo?=
 =?us-ascii?Q?h1mquz7Y7uOmrfoJ2sGhd1KBsXuYltv6dko5o9EsfQnWDXeB9tyYJ8ujVCwz?=
 =?us-ascii?Q?yD8KNBVjsZ2C0ZwlXbKnfO1ejpUtZjG44fQ0bw3zEBgwAnRs81D849AKprCX?=
 =?us-ascii?Q?3Yc3OfVcFP1YWTCR0hskIvj8KxwxV2YFs8H7Cf4sMixqK5gGSiyHLzsoxRYM?=
 =?us-ascii?Q?1GzL/9B+0EOvGL2R9muGtF991v7XaKFZk+AGgIeg9WHJiWnuuhKEuzT1eRF1?=
 =?us-ascii?Q?IFL9taC9z/JJgtf9Qgf0Pe73qu2qlQN2SWa81hFni8Vqc69ac3x1GKHaCUnM?=
 =?us-ascii?Q?RYsxojgVVhV+fEOieV9N79hqxmBY+MeooXLDIUeuRgK1dfeZ/3p7TAAT6Yty?=
 =?us-ascii?Q?/Lq9/Y8Tir7ef0iddnzxxQhSKOIUpBV9W2EjkMDCWKuZTvdOQqxrRZNF7h6I?=
 =?us-ascii?Q?aJASSWzHg81NTWGHUqj5LtmlnUJ0crbPblKk/9dHN2qmvxYIm31qPfEGU0OR?=
 =?us-ascii?Q?MV7F1hYO/Oj7jEMWDBLyNprGERH7UaaPzvzOAu4BP0LnB+7kzBtN20gaQmSl?=
 =?us-ascii?Q?lcCfDilVbBG5QC3HWozdw/sbbOD3DqEboNQaZUJnXnKTzLMS89MJNEi0QPv0?=
 =?us-ascii?Q?JzmGcC6JsQ6IgCw0DtvSdieANCYwlEEBHGWkSqySSMhG6MJ174dDgJdbWBtb?=
 =?us-ascii?Q?8XztuQ+b5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6PDxpUdGIwMFdK+i6ezUGm4F+0p1WKTV1YJWnCaH22yhZoBcS8MkWqUNROFhcK8SSI/rcuH3MRKk0wykUc0m/O1v9i/EtERksrL3WDrrW+mnY+fQ5XW+fjntBMszsyCCx50MMWBZSV1objLn9HhQp8JBLmR+3rzi8rkaf3IvVlmIukyV3OB2aZmCAvy6dBZqh44PCXjJY/AZ9QVxJwIBL1odaGPcFYcMFa2BpvYneKo0N5wzbckp6RAURk8Nd1yGOQQ1ozj9v7pDV/+tg53W5aSCwEcqTxyPROdD+ifVdRmdsch+MXxGLjT3ec4JAuFdMM9FLpMfL22+fVZItLX5eO3Kmh4NEyqDTscwJT7eZzYgP0yJ0PHPMrZZgf5ttiXE3wdKT7XpW3OX5QXhsqsA9ofUq9zJjWGH2P3zJQOQKKCcAASLx93frMiT552QGkrI9jMYtIjs61zSlrR2NmDlLjWSlXvuX+GJO1pDfnAyJCyp9+5ZWCcAVink7DcFSqLLtTNxosTVBiO1PqV6qtLXvYMCuJro7xnqcIZSbCH+sbQD/OYVJsA/LPGL3tasdiEZqBNG2wJgzPxNGyVcdmX6nv2wvGveEDfsvO4PGOgF3CI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9af1be-c732-4d4b-46d0-08de526b9f7b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:18:52.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxQJMgeoARIH3zDR7a8mAcnU//iyYhteaGlVTGpfTICXEkTSyiqu1bapj2wa2xRTdgDmYZ5Acc9ko6rulH6x1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130050
X-Proofpoint-GUID: Cspvcz9dADQwWATGxmlmo0NHy1FjXUJq
X-Proofpoint-ORIG-GUID: Cspvcz9dADQwWATGxmlmo0NHy1FjXUJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX9Aha8hNEqV9f
 SMhSWh1vhR+iYZc6q0knQRbChxGsW0QbwNnHG5tvUU9i2opVHWxXHDMxg1uhGabdnAmjie9GdTS
 KusL4vLEWft2ms70bKrEf6qLiIZhRcuhN1EFHiYyG7/bi7HZFaY6iLPKLaW3o/3ACa/kUNZeMvY
 xY+9cZEvdKR+3rG6TWA4kV26pW575ZDx293ToPRnVJ+0Bx0DM5Kj6iz3eNXB/S3GBz5zX3Kj//6
 cTbt4TGjOuJ+J7R47BwZerNvqgLKY0zlkF5JHNhdDH9KF+j5xR4U+f8b5ni+XtvSBUXvrkB1OjW
 7t7jGBqcN9IAGhc+MfLI/yFz7fVscAXlW1b4kq+gc7OWoXXtPCxPFc95TjMyo3iAm29iXTH3gQc
 A5PrX+AnWkyFP1WNhflsemP1fjk9Inj8f/2qsAacvrPLu+xTukoVodTD5NZYcFHyoZCGBRcNmto
 bSStQkhKIdCa7eV4N/ujKKvztaFX2wl3zjiYprI0=
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6965e3d1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=WS-UKqYZhYmZd4hvbKIA:9 cc=ntf awl=host:12110

V5: https://lore.kernel.org/linux-mm/20260105080230.13171-1-harry.yoo@oracle.com
V5 -> V6:

- Patch 1: Added Closes: tag for related discussion (Vlastimil)
  https://lore.kernel.org/linux-mm/1372138e-5837-4634-81de-447a1ef0a5ad@suse.cz

- Patch 3: Addressed Vlastimil's comments
  https://lore.kernel.org/linux-mm/e28c08e4-5048-429b-97a0-8d51e494efcd@suse.cz

- Patch 4: Fixed incorrect function prototype of slab_obj_ext() on
  !CONFIG_SLAB_OBJ_EXT builds and kept pointer type in
  free_slab_obj_exts() (Hao, Vlastimil)
  https://lore.kernel.org/linux-mm/n6kyluk3nahdxytwek4ijzy4en6mc6ps7fjjgftww4ith7llom@cijm4who24w2
  https://lore.kernel.org/linux-mm/473d479c-4eae-4589-b8c2-e2a29e8e6bc1@suse.cz

- Patch 7, 9: Rewrote obj_exts_in_slab() to check if the pointer is within the
  slab's range, and distinguish by stride (Vlastimil)
  https://lore.kernel.org/linux-mm/644e163d-edd9-4128-9516-0f70a25526df@suse.cz

- Patch 9: Fixed potentioal memory leak due to incorrect impl. of
  obj_exts_in_object() (Vlastimil)
  https://lore.kernel.org/linux-mm/8c67dcbe-f393-4da6-8d24-f9da79c246c4@suse.cz/

- Patch 9: Fixed incorrect ksize() implementation (Hao)
  https://lore.kernel.org/linux-mm/fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz

When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
the kernel allocates two pointers per object: one for the memory cgroup
(actually, obj_cgroup) to which it belongs, and another for the code
location that requested the allocation.

In two special cases, this overhead can be eliminated by allocating
slabobj_ext metadata from unused space within a slab:

  Case 1. The "leftover" space after the last slab object is larger than
          the size of an array of slabobj_ext.

  Case 2. The per-object alignment padding is larger than
          sizeof(struct slabobj_ext).

For these two cases, one or two pointers can be saved per slab object.
Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
That's approximately 0.7-0.8% (memcg) or 1.5-1.6% (memcg + mem profiling)
of the total inode cache size.

Implementing case 2 is not straightforward, because the existing code
assumes that slab->obj_exts is an array of slabobj_ext, while case 2
breaks the assumption.

As suggested by Vlastimil, abstract access to individual slabobj_ext
metadata via a new helper named slab_obj_ext():

static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
                                               unsigned long obj_exts,
                                               unsigned int index)
{
        return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
} 

In the normal case (including case 1), slab->obj_exts points to an array
of slabobj_ext, and the stride is sizeof(struct slabobj_ext).

In case 2, the stride is s->size and
slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)

With this approach, the memcg charging fastpath doesn't need to care the
storage method of slabobj_ext.

Harry Yoo (9):
  mm/slab: use unsigned long for orig_size to ensure proper metadata
    align
  mm/slab: allow specifying free pointer offset when using constructor
  ext4: specify the free pointer offset for ext4_inode_cache
  mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
  mm/slab: use stride to access slabobj_ext
  mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
  mm/slab: save memory by allocating slabobj_ext array from leftover
  mm/slab: move [__]ksize and slab_ksize() to mm/slub.c
  mm/slab: place slabobj_ext metadata in unused space within s->size

 fs/ext4/super.c      |  20 +-
 include/linux/slab.h |  39 ++--
 mm/memcontrol.c      |  31 +++-
 mm/slab.h            | 145 +++++++++++----
 mm/slab_common.c     |  69 +------
 mm/slub.c            | 429 +++++++++++++++++++++++++++++++++++++------
 6 files changed, 552 insertions(+), 181 deletions(-)

-- 
2.43.0


