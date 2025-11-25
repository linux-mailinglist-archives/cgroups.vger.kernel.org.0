Return-Path: <cgroups+bounces-12189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86EC84530
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 373CA4E7DB2
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC832ED15D;
	Tue, 25 Nov 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q+F+Gamx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ssCJ/Mq0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D22ED141;
	Tue, 25 Nov 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064638; cv=fail; b=nFv2LchDnGJeXDJbzGov9iTRj/o7TzBwySOm87AWI3MiMqkxTqf2mYAuewXGaO8TTZYnl5SXearK58QYQ7hu6wWBK0LhqIXA9KBIdQSskOhDz5aM+X8CLmYns/EnjWP5l1CTGKOxHWNoI8BtoCbUfP67buoRay+i5533HoUcYWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064638; c=relaxed/simple;
	bh=CWT12X1wSWWO7s2Uglp+lkSM/DEqFRaC5BRU3QEm3/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izHA2TiKTtXlUL2VL9M6u0QEHlzMxoZzVtivZzv/zvd9kNs52zay+FFNl7cjwTpsHR/+/WL3LpTLFtYa9blNsbKghxu6Xnl55kspxxmlL0sSArSrgvhpBSrjauGvsX3LIWI3SAvlipiF+b/5RzzkRDcL9ABWwzmo9VbarUlMD0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q+F+Gamx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ssCJ/Mq0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9SNNW2394974;
	Tue, 25 Nov 2025 09:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=waI/9Se7A6tGbJT4+/
	fNIjhJlNL6Y5E/aNl/eKdsey0=; b=Q+F+GamxBGU6DcM3uO9Sqb5qZ3xVppVDjk
	iIp7R4VIWw3cBzGk8+VbLf1+w8d44fWxEuRM38RINgokAXPl5qtPIefAJAKH+EXC
	oSJKm8HSdOD1ANANLfkPNLcJ8s0c9gvNr/8zmkU0BCsi+InBYbSwq3ygOJNvdCWy
	Z8a7Kn1FYOQtJ6wIwTkLnkon/WWygDQVDKEgdEUrwyHxMWJWUoJD8Hw5yW63pIbM
	MnkX8jfMcPe5GjECZvrAC7kwocY5BRW37PJsFmrjhQuXl4PGE8j4vaBCo2APHizI
	E3BYOA1PVbqWjBlEjNsJXEAN258FVKN6N07uDbBTO+YlYSNa1DLw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak811m9ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:55:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP8SSVM032705;
	Tue, 25 Nov 2025 09:55:31 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m98hx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPmcvG3h4Mprb2Jtm9IBHLW528q5VHFGt0ISRaonBpj6X5rbzlLsLjkhBTJ0GGd+th42SCUlU1cL5LpGBM3u/4SyQDF0e6iX6wgvFKJ9dXEYuu0Jl+1cnHVZsZFpMqlm+YoBglGOoiprXsRUDIT8ngJYo6XK1qVCwT22VnpEaFl/Ky4SlC4c0SGPgkapDUuImGewkpxelB3U0cZ5V824lN4wKCl2Tn5Vu241cBuvqbXQUCP75s5YRqVQJ523+qGWD60C9SJM8DGDZOQUx5kNNAm/sJdhVl32ed0p19Yu20j7XTp50/1kSKINBrutTh5jf7uS/0dGcjoKVd8EHCic+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waI/9Se7A6tGbJT4+/fNIjhJlNL6Y5E/aNl/eKdsey0=;
 b=PAJL7MOD5cIotcEJRfWEN2vdct0B7HTL0QGhO9rcrPE9ntEcIjT1eVCV1Lqfj8twVFjLBMXChG/3gJqMqu+UAVNK9lutQYxpsXtcAblV4lw5WLFatIDNkKrbtomwuOH4i0R+fX8K28HNlug91wnMoauPyJy3itSKY4OrhdKaaGrDe8GL2jI50cjVG1Wo4lQuCoxo98ALyTbWOC0vnaahQ6Ylot3Y1lq22qpyXMR1ZgDKiWcKHRROnYa8V5jk0QH/AjYF/XjBBssM9NPPhXGDBCZH6SndGfykqAMeUuE/n0TeKnw5BkBwlLegDMLm5/X8XHGljTiRAQk2uimspf2LTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waI/9Se7A6tGbJT4+/fNIjhJlNL6Y5E/aNl/eKdsey0=;
 b=ssCJ/Mq0tNuGunHXDSZ0lIN4RiVKIBozLStUMIK8JrS0apVyU0ABgfe4F+eb5s4TI4y22mzG06XK6BxRH1lmRWqrc+SUYC7kZ6C6AXj+baQLGXRITkl+BNF1HYjg0MOTT3+N2GK9BMoxquJObRyhzSWWjkQ40700wFA5EigsNOo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:55:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 09:55:28 +0000
Date: Tue, 25 Nov 2025 18:55:12 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
Message-ID: <aSV9ANXym0UDhE2j@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0201.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc7a48b-ae28-4193-a3da-08de2c08c38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VUjamwHl3ptxS6SAY+FpucWqjQJ8EVaLPGt4YP2QZL676tdK8PWMgBjoJemV?=
 =?us-ascii?Q?m+GW6NjEUwpXm2HWQLYND5pHZJDczQOmqhU0X3dcg7pNxL/BKdF5q+brHZCZ?=
 =?us-ascii?Q?jKkiGMtTZwnUpUMHcYyXn0m6TPkkutI20FZ869HU/fIS2FGSDC3dVweo6F+k?=
 =?us-ascii?Q?qULrmptED7SjwU+X+Q2tzNJ/NnDcmy1bP0/Q9/ET9ukj/pEEL+cSTEDeNpdX?=
 =?us-ascii?Q?2EpvjsFAQBXEYk/XcbHILThx45DK49A0eDHx3RzRPs4M12ptJiovrBYeSWnO?=
 =?us-ascii?Q?ZGz/ooIyJkau6KoqHx6x8TUYKMgpOBII2nlw2YIGYcA9qTN5F5JflJirtTN+?=
 =?us-ascii?Q?WOv2pAVwUZJdfKntJbbAQPPgN1avT+caW4Pl9VYr8vwqEpFjezI/OSUtyaW6?=
 =?us-ascii?Q?PplfaYEuIOw7CLTY58txdA+lSQ7S6+thnIH1OZoAWWGADUBdBi/YmKcLYqRc?=
 =?us-ascii?Q?ewofrfbifhA9Ckq51/gldK6PE01GpxdGJaE6d9gdrUoGOLqBe2gaAuXMyrRb?=
 =?us-ascii?Q?sPyuAoaMyGjEEWuI6GUnSZAXkdJpEpdx9NW5M0TA9jW/k0+118CxZVz2Tliw?=
 =?us-ascii?Q?C9Gsbbf/9SxgCZkrHjy6WEP4vgA7A+8q70TRAEddandVQZaBEa2luhb0FZXk?=
 =?us-ascii?Q?Z9XYqkT/AH11FpPXgfrcTIcxIwqqNzfD/r+CrlaAV8M/WRtsmSlOFPZW2Nu9?=
 =?us-ascii?Q?Qs8tfgCZ7n8GQ3R8O0WuDfckfjTSgMaqR2kxJMvJrramZNEDpAt42LF8jIi8?=
 =?us-ascii?Q?pEgv6UFg/LGC1NFCINZXAmrARX9xBQPBtSAx9H+FDOwaTNxBBM9/VVUCgGxs?=
 =?us-ascii?Q?A/9QviypJtYwfPKFpR6wf6JhAsuVXHpesBJ3zPLp+LiWBTOqoocedFUOodaB?=
 =?us-ascii?Q?2RaSDmp10n2QiYyrQ0fjuWYX6lXZsfE0GCrvC5uZPMO5Xdbtv0wN4o43e1xS?=
 =?us-ascii?Q?Y7TCtOO7UOWbSG/LXxROkVzorry0UjE7Xwbbq13c0x6aajQrM4DhjHSkambJ?=
 =?us-ascii?Q?Ct9XhSO24QNJtirrk/iWnd6TsYCgFZ2K4dt9uKJW3ejBdVh2po47LnuPs46K?=
 =?us-ascii?Q?lO5f/hONCiQBTJUf5XiDjW6fjIXITjI2DQQ2D75FZ8hAAQSR/FSh91To0ERJ?=
 =?us-ascii?Q?oi1bamIOlsIfS0+lypERQiXZChZSmEuziQjDVuD9x9a0HATMaYiRD+arHNzU?=
 =?us-ascii?Q?IyBfY68sGEZJv2P4YkrMxEQKXmc2LCAWci8XtJIU9LIRHX10KFblzQXiT4oY?=
 =?us-ascii?Q?arGnYNwcVmDinOKshLAAv0bGqLQW1SJpYTDRXhB2Q8cD+n5C8UpxLpRnYHT+?=
 =?us-ascii?Q?9lOqyjo9KhHzr4Ns4/3V1vc0ABOujQ5g2TQx/mi7bhWPEi52P3CgAULrojmI?=
 =?us-ascii?Q?fS9b9QhFT5D3hltvpByuWYEcByMmqK0Ch1m2Y2nev9+Hr8KcwGVt+7Sg1URM?=
 =?us-ascii?Q?wd3O2y+Y24KYDT2kjtjQvguwRuF9NeKY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90nHyYJfzloTLcSI24I7W6svGkCTyboIpvo3GOBMK3pKrILQJvy0xJzUuZFn?=
 =?us-ascii?Q?h85pTvRNsjGlwXH5d+KPAYNSk2Qs5BF9cdNIMIM2ouzL+9ZuQAc6adhzRPFM?=
 =?us-ascii?Q?yWa9reHFqQ/5b8FXj1AIFfAuvmyKtmPqJ4Yeh2+HG7x+q4C8Zlqbvwmy8Ent?=
 =?us-ascii?Q?77bsszFyxH6Tfb3zCoMmrFxlmDQWzng3j8khEgqb+owmBt1LbDX82XTKKevd?=
 =?us-ascii?Q?YvoPVPZRxdUPJu2oq6hYxEksfqMM7t2xx+6SOcwqFWsy4TJIdELHcBrq9ma2?=
 =?us-ascii?Q?n4TVmHbjNqRMq5m6Laa/i7Sf+cVK+ve2fvwKiQLp/w7qlhcX2N0Q4uLcM2Mw?=
 =?us-ascii?Q?NZ/OMhxUvPs4w00rz1XsjJBbuYHyS4tBTDoLIs20l7HMF6z1xx4tXL9IAg6Z?=
 =?us-ascii?Q?yBrG0/o/sGhgFzZhLXcQ7RPsXT6RSUa6B9vvVc7Zp01O4kKREdEqGCItaMr8?=
 =?us-ascii?Q?xkRLEklVanssjWDV4bOU5xGATaLwC2sw/zCMK+c5xokeobd0em4kkjM7Nxsj?=
 =?us-ascii?Q?ERo+TgDb4Hxip1rtan6gRVfUy8x0QGG9SCrj/rYQVWpOrIr9kobrIC5ppFvh?=
 =?us-ascii?Q?AIGg1JLP+Txdtc607wTszgacXhPCgAZwLNLY3uQr2VF374kISaah0X/4sMPR?=
 =?us-ascii?Q?xl8SVWW/63dxwyXDekrD5TGP7F5Agr0XfyvXgaSyDMkx+j7lKxuqLK8LlERs?=
 =?us-ascii?Q?7epDEuuOQ/WMbEt97YjDI31wIJFKEQ/jt0s4zK1VwEKI0FqQueD/avQzlixm?=
 =?us-ascii?Q?gZ2f80rb+qxQXqEBqSeDJk9NiQHUcCNuNSYP1TCFRc3WfGMMo/zcgL4RK7pL?=
 =?us-ascii?Q?9K5sG7yApdphfq7TEL58Fydl3eizy4neQwCL3TnnxcbhC8GEZSo+E5yKHaJ6?=
 =?us-ascii?Q?pP0SEcyyzb58zqDZWH0yTYCJs2p8YeJ6TYs1AF9wwNQkiBNNgzSjph+XnILj?=
 =?us-ascii?Q?r6E3Fqv10RKjmYoMesoUnQdn6EAsGePc5xFQFmGzvjI8DuAxyDP1GoMl9h8t?=
 =?us-ascii?Q?pZmtmuVbk3TE7pjjZuNrm46LIg/Mzz9BXoljA8B4K3r3+fweGXT26USnGnYc?=
 =?us-ascii?Q?gTtZ7mgKH1gp3cHAcODUksQJkGZyPwt2/EVFflLF7szElPHCq9uqvRDu6Tcm?=
 =?us-ascii?Q?hUD/IjhgNQvO+vvqn4J0i6eKBLcEf4D1OPUaTJ9gclkEC7Tbl65jYaG0CC8b?=
 =?us-ascii?Q?cPTXLIJ8fF3luovf5OpU1HMT+sXvBj2EZBVsuNIfV8iJPlEqCPkji9LcGSYY?=
 =?us-ascii?Q?NZlWNzgZXNLij+s2dhHWn/d8OriEGeTjNtN/1zKl8D8I7sLODzakbrq8YlGd?=
 =?us-ascii?Q?n7cGIwPeSqxXwlxyOP0L7PLXbp4dD3QrYiPvmhZu4cMnh2PQck1diSjkU1uD?=
 =?us-ascii?Q?bfxGfpGj63B8Ood3nXLLNXVPuesWAtFnQHE/fW5Uqtw9c5R6OLa/QWKik9Bt?=
 =?us-ascii?Q?64yvUrLywckKmZ61eYkOIlVI0KxUQogHY+HrGHDdySZ3TDuBRXvsCuRdPKa2?=
 =?us-ascii?Q?ZKpEmVnJpyZ44xivxTG9i75evCZaYhkAtmeCDJgDkgowOZk6+G3yK44anf2a?=
 =?us-ascii?Q?RMthph7Zg2aLCPCg7XD34qrdwjd3COR084Xqc3h2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SVx3HmSIHBEX/PMDdU9QSBQ25+Cs8Px/DMQhYqBxqkzjkRBxnJsyhfhHUrgsFoam5fS31VoVtq/sHMrhZ3VJBLr0iafbAACu3swVGseAgBLkFVhyO+SM/0TJQe9YJXZ8wL1kBB3B5qh/PIKGZMKfPaK+2c/trGpCTAjf5gIZPxvsmANzv4DAtMfPOFjCoxQqE2UnxhQAW9AygnWMJYYzU4uwAkHOPLVYWgNbWsGOScAneDuglHfON6XkqdJrlZG9ZlplDuZ3Y9YXbrrcxyKWZotGjSmUmE44rAsbfO5A7CZX3aNidUgJbJmrcvpODaz1ArhwAVWgT1fQhh8fWnG26nBfFSIXYS+av8khL494Y6KePy9KRtJG2qLgzAtB0Ixj93aoPc3phxRk/CFBnI/+/SuscYJDdCpIwJSUTUhAHjVoLQrasbA/G5k0/dCzmTSNocnnP1kbHjU2REUwISX6ZnGwcOFj8TRRDmwWDTDIjp5htuvcDqb4aE+319i+AjOnnHIHgrtILP3s4zrLaC+uPLRkMNewlJU/6BsTEi5DGiCn/1JOT9+Get8u4RTkzHDaperYZAoWkOVi1hbyt2b9N4+1+6FwqdPpifbrTTDhkNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc7a48b-ae28-4193-a3da-08de2c08c38b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:55:28.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7lD4mKL8e2uyOpsqHWKqhzcC0WM/DA6SDdi+l/Z4Gr31lCzcIgFPK2D8KnckSXb+X5ZAPaBg7sA1vz3iDwSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4MSBTYWx0ZWRfX1kXZ69nZphPv
 W9hYyf90IRHml6t+y8OLEq0CGMlwTf8ZdjPeAlZYBwfJyGtGfjY26KUCMxKBtJz3OanQYkjVqEq
 Mqyh+rwNj8gildIqqg/C/cQwaEMYaCSMdU56BM+OKPfuJkVuTddOJ4IyTQ79hWq7+bl68IYAf+a
 0LrWpuPlZDEknYsMecqts9BDJLBWD4765bGLsgtk3ZQvOVJdai/p/uv7iTTlyC2DyW5kfbS8eqW
 HnmD8ur/FHfSe0xRdFNURb2XfupukhTNSi36eC+h50Kon4QRDyfVb3hLywlhCqsgFtw9CrTvHAJ
 a87nDbGdOR+Ki9DWJd3ZnPTAQNJJm5dwNJFHv/95UY+/AAXyRdQXz3J2cCCXYohWtb3LyMfJE1Y
 WPWmME47YnWRYTazg7XIlfbsj3w0+g==
X-Proofpoint-GUID: zkvmNf03hKQuLPXo1MJzfQ5zjesqwXtJ
X-Proofpoint-ORIG-GUID: zkvmNf03hKQuLPXo1MJzfQ5zjesqwXtJ
X-Authority-Analysis: v=2.4 cv=KKpXzVFo c=1 sm=1 tr=0 ts=69257d15 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=5rndkMEsPp_5EL-MIF8A:9 a=CjuIK1q_8ugA:10

On Tue, Oct 28, 2025 at 09:58:36PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to traditional LRU folios, in order to solve the dying memcg
> problem, we also need to reparenting MGLRU folios to the parent memcg when
> memcg offline.
> 
> However, there are the following challenges:
> 
> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>    number of generations of the parent and child memcg may be different,
>    so we cannot simply transfer MGLRU folios in the child memcg to the
>    parent memcg as we did for traditional LRU folios.
> 2. The generation information is stored in folio->flags, but we cannot
>    traverse these folios while holding the lru lock, otherwise it may
>    cause softlockup.
> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>    may be updated, but the folio is not immediately moved to the
>    corresponding lru list. Therefore, there may be folios of different
>    generations on an LRU list.
> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>    found based on the generation information in folio->flags, and the
>    corresponding LRU size will be updated. Therefore, we need to update
>    the lru size correctly during reparenting, otherwise the lru size may
>    be updated incorrectly in lru_gen_del_folio().
> 
> Finally, this patch chose a compromise method, which is to splice the lru
> list in the child memcg to the lru list of the same generation in the
> parent memcg during reparenting. And in order to ensure that the parent
> memcg has the same generation, we need to increase the generations in the
> parent memcg to the MAX_NR_GENS before reparenting.
> 
> Of course, the same generation has different meanings in the parent and
> child memcg, this will cause confusion in the hot and cold information of
> folios. But other than that, this method is simple enough, the lru size
> is correct, and there is no need to consider some concurrency issues (such
> as lru_gen_del_folio()).
> 
> To prepare for the above work, this commit implements the specific
> functions, which will be used during reparenting.
> 
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mmzone.h | 16 ++++++++
>  mm/vmscan.c            | 86 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7aa8e1472d10d..3ee7fb96b8aeb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4468,6 +4468,92 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
>  		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
>  }
>  
> +bool recheck_lru_gen_max_memcg(struct mem_cgroup *memcg)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		struct lruvec *lruvec = get_lruvec(memcg, nid);
> +		int type;
> +
> +		for (type = 0; type < ANON_AND_FILE; type++) {
> +			if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * We need to ensure that the folios of child memcg can be reparented to the
> + * same gen of the parent memcg, so the gens of the parent memcg needed be
> + * incremented to the MAX_NR_GENS before reparenting.
> + */
> +void max_lru_gen_memcg(struct mem_cgroup *memcg)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		struct lruvec *lruvec = get_lruvec(memcg, nid);
> +		int type;
> +
> +		for (type = 0; type < ANON_AND_FILE; type++) {
> +			while (get_nr_gens(lruvec, type) < MAX_NR_GENS) {
> +				DEFINE_MAX_SEQ(lruvec);
> +
> +				inc_max_seq(lruvec, max_seq, mem_cgroup_swappiness(memcg));
> +				cond_resched();
> +			}

To best of my knowledge this looks functionally correct.

> +		}
> +	}
> +}
> +
> +static void __lru_gen_reparent_memcg(struct lruvec *src_lruvec, struct lruvec *dst_lruvec,
> +				     int zone, int type)
> +{
> +	struct lru_gen_folio *src_lrugen, *dst_lrugen;
> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
> +	int i;
> +
> +	src_lrugen = &src_lruvec->lrugen;
> +	dst_lrugen = &dst_lruvec->lrugen;
> +
> +	for (i = 0; i < get_nr_gens(src_lruvec, type); i++) {
> +		int gen = lru_gen_from_seq(src_lrugen->max_seq - i);
> +		int nr_pages = src_lrugen->nr_pages[gen][type][zone];

nr_pages should be long type since nothing prevents us from reparenting
more than 2 billions of pages :)

Otherwise looks correct to me.

-- 
Cheers,
Harry / Hyeonggon

> +		int src_lru_active = lru_gen_is_active(src_lruvec, gen) ? LRU_ACTIVE : 0;
> +		int dst_lru_active = lru_gen_is_active(dst_lruvec, gen) ? LRU_ACTIVE : 0;
> +
> +		list_splice_tail_init(&src_lrugen->folios[gen][type][zone],
> +				      &dst_lrugen->folios[gen][type][zone]);
> +
> +		WRITE_ONCE(src_lrugen->nr_pages[gen][type][zone], 0);
> +		WRITE_ONCE(dst_lrugen->nr_pages[gen][type][zone],
> +			   dst_lrugen->nr_pages[gen][type][zone] + nr_pages);
> +
> +		__update_lru_size(src_lruvec, lru + src_lru_active, zone, -nr_pages);
> +		__update_lru_size(dst_lruvec, lru + dst_lru_active, zone, nr_pages);
> +	}
> +}
> +
> +void lru_gen_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		struct lruvec *src_lruvec, *dst_lruvec;
> +		int type, zone;
> +
> +		src_lruvec = get_lruvec(src, nid);
> +		dst_lruvec = get_lruvec(dst, nid);
> +
> +		for (zone = 0; zone < MAX_NR_ZONES; zone++)
> +			for (type = 0; type < ANON_AND_FILE; type++)
> +				__lru_gen_reparent_memcg(src_lruvec, dst_lruvec, zone, type);
> +	}
> +}
> +
>  #endif /* CONFIG_MEMCG */
>  
>  /******************************************************************************
> -- 
> 2.20.1
> 

