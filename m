Return-Path: <cgroups+bounces-12971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3AD0209E
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D9F30B6A8A
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533683A7F68;
	Thu,  8 Jan 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fU5hpL4f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v81gw6AJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72823A7F6B;
	Thu,  8 Jan 2026 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863073; cv=fail; b=MFpUrqm7DQhbq5utHjoq34QhK3l87Xw34wm+pQ2LpMaN+WK1EHwgRiNcscuo5zAmEsvvQvcotqVC6zLo0X1zbNDgkJhHOni1oApR6oqaxtfTwBCD+KmL03LL3JPyyVtzVk8XORY346r75ijTM8gZSn4+3GkEWUq2zykBCCZTwY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863073; c=relaxed/simple;
	bh=5Bpb/qg0UD9XIZvO+eqDBetEsxhse0/8pGt+Cgs7hyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NK1OSyyqcRayjpKEQJzFD168BSryWc4NaNbxXPfTqqEB7k4lviqA0MMht1W976tJY/xD8/HWRDivsw+wgAUwT5Mb3pVKCef9SijZVlW5+mu8VaOf81HFEgjzX2J4lcIRtFnmPz/mHcZYe8UWqXiV5gtv4JpOSopeN+vsXDVB8d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fU5hpL4f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v81gw6AJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6084acmW3711761;
	Thu, 8 Jan 2026 09:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tnFgBZ//FXNQIuSVX8
	95a7jwkt94u25JR97v5nYMaPk=; b=fU5hpL4feHqB4JnSiEXNcQxSOxTadBozKQ
	tM6uTEMPyiDLQIHIoaYjgdSCpd7aMD6IgxMQ9NSIH6xTdtWgLSIrAZ46C68Nxqpw
	yV2ucqJxb0kfPoS8PLUAarAZLadQpQnGSdDQOFsJHsZWTiNHWBdWV3LRdEl+fI8Q
	W4qntTj2wNAo5MX1T9GiRMsXEePPneVOrN1gyS2kmNvY+igL67BULDc2V2aVAOfa
	EwvaXcWBaKp94zBOLxsPUdBvTt5rCdf25CjCM4qkVtOTqGK5mU0Apfh87ryg6ydb
	WtHYq+7glHi0HTBJnNhfwHsXh0XgX1fGKcu7TJWgqSdl4u96M0dg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj5pnr7nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:02:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6088lQ2r026334;
	Thu, 8 Jan 2026 09:02:52 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn4c58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpXgqTKXhSCpePOTXDEXkDZY/nVVv0C3b9DYZ8lviZVcAG/h7w1QTiF2JjPWuJQ3POLuL2ibGLWWVxwjxhqEYZU0tKcqvDZrUr5/0cbPKat58YObuNo1K0cCBVrIwi2RDvgvoU+NlQHkcFyoxh6JjI/Al5NXN6e0veXbyPGyIDFcErnYDOkzdCpe8acZ/LZLv10bWCaUyZe/znxXUvBFWVX1dOsQHQBVf8uw2KVZ82S9VmXaoxlwusDN1vuuQohxyKi+smYkJOn4ERQaAJVOj3Hls4yJAbNIQfdUwAc+sIAA7gPrHn5GoKHAWc145GHhigTZc9N3Ic39OJKhDgmd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnFgBZ//FXNQIuSVX895a7jwkt94u25JR97v5nYMaPk=;
 b=eySMZ7a17QPOY6fKx5vozgijCo9YlbsvrzY9X8YQgcValhaW9CnBpQm3WxmNSiwtM9CsaJ7NylpSY8/Dtz8bI0u7nfyHD5IE7mz5AKqwgWNRZKWzYztz13pdOsJ2fIkCCZuMiQgfgiWQ4nWvduJA1deISZYxv5l9NqkhqKKDsT7p3NRGgiI/JYzpErscPOIwT0ivj93Qaemo9+moux+S8p1c/IVwYbtp7sw3DX5Sh1xLYkikKVf6/5wIJrHiLYcSndWaoXlhzi7DEVyGBw7WXxNwd1wgu4mm930KQyPX1PvoqPyckj/ZJY0nhe1RXW7PuNBXG9qOyJEX9Ci2yOpbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnFgBZ//FXNQIuSVX895a7jwkt94u25JR97v5nYMaPk=;
 b=v81gw6AJeb3BWzbe3U9p7o/UiaBK++CO0fRZpDsKxxp/24hS/SsuehFFBis3/oO7ybAcKiG0Nt9T56D4g0y7bFbABhNd6E/XmFv+ULaDUNp1V9PTXWcZeOiKvjQYN6NC5+r8YE9/Rjt7+DCx7pONgpGJF6owHnWgWgsh6UHdyNs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7388.namprd10.prod.outlook.com (2603:10b6:208:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:02:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 09:02:48 +0000
Date: Thu, 8 Jan 2026 18:02:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aV9yrnpk1sEDIJEY@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <8c67dcbe-f393-4da6-8d24-f9da79c246c4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c67dcbe-f393-4da6-8d24-f9da79c246c4@suse.cz>
X-ClientProxiedBy: SL2P216CA0116.KORP216.PROD.OUTLOOK.COM (2603:1096:101::13)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5248b206-a86f-4bc4-8236-08de4e94b1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CKvnobftYhxdsOaZTzFJepPEeHqOraOMuTSI+mneeuUt4+pXkKDbFkD5n29n?=
 =?us-ascii?Q?PifUYJas3tIMd/yz4P8TACWsrWuKMJeKKpT3MUQdW+LKCHfhfUp/GrblRPY9?=
 =?us-ascii?Q?kyq4HTy3Fc/PngErQOip48FVr/C+6uwzWrqp9nbNhuZtB0z6Aj621LxKq5mT?=
 =?us-ascii?Q?Fl0EVdSqV6Iv72Ix21q+fq6icKOVr2trZp5s5k9VUp3PujbF1Sen40+VfD2p?=
 =?us-ascii?Q?CE7cPjX68NI52NxhAHb2gra8QtN/kzNTBX7dPYMI4kpKSvEl6WZBiZo5yjQx?=
 =?us-ascii?Q?zCrtqmLFMNJTakEuMNzSmlXPtSNUZeLkHNFQqDYNbe1isR7DnCw0OKSmjxoZ?=
 =?us-ascii?Q?RH6l8PNzRW4sdOn5Xdl6VJ8XbRCR8gN9mBS80kgJ6qLohA0WCOvm4+dY3lB3?=
 =?us-ascii?Q?4ss/tCz9LVfEqA+FWH/cWWmF+oets1mVXHg4kU4mHkIKsEqgjJi9ANEpO/Uw?=
 =?us-ascii?Q?S9R0UZH9AZtFbVTf7YieCzWy/ZRVTLSiUOE+Xb6zPGvZSAGA8puI2kv50KrT?=
 =?us-ascii?Q?k0v4mTf6qdPQDhOVaTpqmQqm0cDHD4O2LStvLfBmd2tU9JsRtytZdJYNrswy?=
 =?us-ascii?Q?nPS/kkIL0r0OY3nJP8Zyl4qX7ggiZyyD8jV5kqb2Gblr/KuRLy4SFxbY35uj?=
 =?us-ascii?Q?UHmWkV/NVMxKERrUqS5TRpvqXQsW6MV+DpinD01kAuJywtfYmLiDXX56SP/y?=
 =?us-ascii?Q?xjuVfpCEb1pakHvfMh91965+GeC0N0FBVjumE9IeA9/bm2OpWgVsactX6JSp?=
 =?us-ascii?Q?1KtAgfy1wT5pf8qwkseX3r3pBuwXeFVSdrle55P5WnzGV7WFExW1fUYtj4tE?=
 =?us-ascii?Q?am3+b0czz8OAxl9YD/FXtZkUzQC56SdfD3ffIEu4ui94HNpqEWJB9aNINMCR?=
 =?us-ascii?Q?TUXH8kbQejNDnRDiPugFgkSmzMZjTiJRSpPtvUlk4bQ1zosqglGE/ljYrn4Y?=
 =?us-ascii?Q?6BXL24ZMJByrlCW2rOdo6Iby6FFOkE/juHdIlGmG5qbtYmBBmU6P4oukr/NL?=
 =?us-ascii?Q?yby4ZKZEvh3Ur9Hy/RbKlBhXlSQ9YmfxPZL90YX2zY8ZJydLNNN1oDFsgIqZ?=
 =?us-ascii?Q?/A6XZBPriOQH3zCRKUN5Zxz9BSMZ6AmCWvlaxNS9k8MJKhk9Bd4ISrnV9zrS?=
 =?us-ascii?Q?bZlRhwnI9dXXMpHyjT/eXMOCUzzJHIjhscQOPgNMWiclQrsI1mxIkVR3Y5QV?=
 =?us-ascii?Q?i5wemET7vlJtj4cNjAi1UvX8GSavsUm31mTWkSSRxpvfY2QMPxms0PV5nLFx?=
 =?us-ascii?Q?fyGIbDgPjjOjGZxSdHxRMBJmEiX5geL+KKtwY+KEj87vrtj1HMyGtpCSNJCT?=
 =?us-ascii?Q?WhwLXZjsY2R6bvTphRYldmM92+fml9fvb8djfQMA92nMDIeQ6rMEgf9iZvGE?=
 =?us-ascii?Q?T/MXCmGxvUcnah3ANIeLGVc7rZCDl8Ebz6YrupD9rme5W7QdDpiOyFWrAWgl?=
 =?us-ascii?Q?T6mYi/JqVpNJytbG2PuZHpgR5ARGTndc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phqKG1Ss8dc23Ezmn5ZiCdKGf0fpWAkP+4W5Gad9xPLCRLMRJ5bOrjq1xAlr?=
 =?us-ascii?Q?6r3EPXhciNjg2/fybg6p2V02xprl2tpYIwu6aRUdux3c2BbSIdnTWfXzqVPS?=
 =?us-ascii?Q?kF+bt7l43K8R3jXXONloNVKul7v9aXmMuKwchjBlq/vlVZiIjarCMAnXQbWm?=
 =?us-ascii?Q?DmWQ90czw1//a53KFtvHurGBBVN7X3EhZax51nMHXM9drhf71xMzzrINmpVA?=
 =?us-ascii?Q?nCofWYzKDn7dbG+dn37qQT9MTQQWWleYZqqY1zvQIRPKLNYqmfFNMzcgDloX?=
 =?us-ascii?Q?sM6YLixr8XOsyVDWnSJE/soNOQmQxOaQ3NSAKIyUFgNXpIiv5QeINtSXv6Oq?=
 =?us-ascii?Q?zCPNlNE2p6o8OtOVnOG/pQg1mg/wLMoHfyqYQl0nYlLkkSeeJ9r1JlxUrwOq?=
 =?us-ascii?Q?TfSX/PzKyaeSirFe+/TRNLrORmOKINJ7/uFNxaja2epXyTtqJy2tsNZKEOJt?=
 =?us-ascii?Q?th24HUJ4tEQ21jNV6E5YylAgwHVc7MvFzUhbyUVJMOhGgJ6MxpShTLft/hn8?=
 =?us-ascii?Q?cv6B5h36bKKOl13l4Lmkfj3esB2bmmoZX1yudobx0aJ4DHizuexr6PqnPgDZ?=
 =?us-ascii?Q?jGQL/7aYIo6LPqZu2vEgQEVSvS46E17IMWXjzqKDO5j9Goj8hGMiK7G7eYld?=
 =?us-ascii?Q?hZtQTv7gkWGUYQZ7iWFrpsDluCQc6UftBjKbV4Y9v/5YZj9PdSX+f2rnHRbN?=
 =?us-ascii?Q?+rU7ghNFSKhnbRID0+cWteZ89dyCqKV7iZJTltw+SysWkJaTtbOViDsAgjQB?=
 =?us-ascii?Q?nL2IU7gqlrgAed/uFid1BvCp/6jOtOmkLwcoFzWPNKbIFyaoaiNngMtSMBXl?=
 =?us-ascii?Q?ttwoVtL5T33NYBX+oL2QIluAEnp6CUhejKOPj7CgK5Zj6jxrhIKanbHILk8e?=
 =?us-ascii?Q?dDEJ7mq8ez76r+8UQBcJvYCXnSrPORs7h2ZYYyGCPcycP35Xyxr6J2kMcy/b?=
 =?us-ascii?Q?gsXj9KOBSO2Q/xWpBsWMFFu5D+MbUTLqJh+m3+x4LpH262pNkwx2BQ/g+JYT?=
 =?us-ascii?Q?bEFE7C4pBo/dTtGPqwFnwzKAHDOq7FgydAnXwnNqv2RYjOO1HUSFILzruFil?=
 =?us-ascii?Q?Wi6JHVaDvgKSu+YgzHDlx8OPm6oAlzM9AW5YbPR0j9/DaAl5sEuXDLm9zcVz?=
 =?us-ascii?Q?JoXd4Of61Z7muQRScZdGcWAVdQVOTM9/SpwrIZU2zQjSlXHH80+f34hyzonv?=
 =?us-ascii?Q?nIuLKR0JQiy64n2m0f2MU0HNlckOMjuVatxKHhlh7MMdPmrKqf+nt8ySQlGo?=
 =?us-ascii?Q?/TTh+qBnC0FRzTZb8WbpqPyXWn06zE/6izb5nWbENI4YKaSFZHsN9D5C4gye?=
 =?us-ascii?Q?dQlsdJt/plJjUbhnuWOvpzPMyImkVGFtEPxtJDt1bwkN0QJ3jwQj/yEAYJ7L?=
 =?us-ascii?Q?aMP++CKQuXK8tteVWsW907XMyIafcU4rI/zD8mjCX1boE1qfir7NaLBxHBZ0?=
 =?us-ascii?Q?zQWzQcDKbxNEFkX23KlUlsMZ/4QJAq2PHRZQbOzZziUF3iJ9Y6walWytb5eV?=
 =?us-ascii?Q?beHhKy1vffNHLME6UdfDjxw7gGwCzxFTwblhh4V94b7GIUkdwMbk3mbIUCOr?=
 =?us-ascii?Q?XtLJKbo8ZF8FA1xLSHxGl/cxAbieUoRKrlx5FYWq4JWn18FDUsXCYA0SYc9y?=
 =?us-ascii?Q?09k/Yd1AFHn4GgborEZpEJ7YjFtwYOi3oCbYiE1CXAgz+rxz0x/Zn8aXq3N8?=
 =?us-ascii?Q?gx/cNL5FrEPTYT6tSVjfATm0713hUZs7K7JXtPPoOnLXniSSXUmwzCeWwTw5?=
 =?us-ascii?Q?fSZS/nF7LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ntn1CwnazwbSB4TanxD6m/LX3QucahDxHHEJa3bmikT5vblpL6LwxmD6ujWJs9eo0gcMyuR9l132EsDaAPuQhfxiHmwnCA2nFD0stJgaKb3EUBKbyciiZR1+TKgNM3B5m4XGaCHqH8oytprM9Cb5VSaVC8Itc2c1O5tEGQuIaJzgvmM7GH4H7bpCt3OVWSQ5Gd1/DKl+VzlUcCv2nA/oWMZz519BHIZPJU5kelgGR/NRAp0eQKWmPUdp276U71zP+4gbCQW8CwQs7APQePieMfsS3E75aUzAExdbb7ioUFZRPSyXwRAyHdpd+lPppYKO+BQYQv1AxG6CjdFd8WHArvRxkd9guOxDr+YMazZjAG1jIcS63BVuE2/byZpJv/ZdkboRFCxAEoyPpOrZ6BGX5corC6FL4fhzRVnaaFKM+cRqqf5OdPtkfmGIS4bmSxiqr5po7CLW6APuR8GznldkzNboTwOV+0xvTX/76MnGD63H7c3mVNx/m2FnWiPRa2o4RtzsjrjwEOP3cU2Yt5lQnpEUZQWfRVZvBZd42vaylhRL7SIYYh01YYjH52nDZiPpjppnrgp0Sj1NUEahMFgiF/qW6lCM5RiFMa+xxGMUGvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5248b206-a86f-4bc4-8236-08de4e94b1da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:02:48.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beIR/4tAUJL7p1pgzLeZX4xMrm3dehp5cqdyRj0h51ZhoMJDIXPlaXcOwd+bmimlHyc5efTUKv+3xAwh+VlI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MCBTYWx0ZWRfXzI2Ffmdo2CKr
 hlBlMvl4pe8clfkHORQsWi0UYpZu2GYKPCyLFC/jUxsH+KSJAP3o3TmPzh49NB33nLnz1GePfT+
 SIQ2cNjmAA+u8AnfsHYJODMrg9rdj4KLtAPQku3I3itvG4WqKInOOnqjNjD9KvwN+aklTRKgMKF
 U3MslpzkQDRGl3rGwcOOB+CiVYDWoPqBQmi5dka2zPUT6DeL3ByQMEyqq3H1ZrEFAV9j5Xmb2t2
 vwCTsg0LdLfNbDO8GO28NDhA/9P7R5/eCUjwJTfav/PW5CBXwyO3uLwWg22lJU7FgZ9rHB0YB3p
 K8IK8L+UIB4jD0RHfLcJMReNos1G9ueAwQRYRol3X2aeLva0RMQM9gygx3fwiozKyfA8TNL179T
 n4GebUDnYBMQUuiQK3RsTELBxKZH6NGUEBjEmX17nstyDrsYi0olSbfdQs9P6XWT/bMrSG0TuJ+
 JJfLZ51zwBz+pxoSORzg+0bTbAuN3VzSW5W7qEWQ=
X-Proofpoint-GUID: rr5PSOV_s08tNo15-XnH_N_5umSx7_y2
X-Proofpoint-ORIG-GUID: rr5PSOV_s08tNo15-XnH_N_5umSx7_y2
X-Authority-Analysis: v=2.4 cv=dOerWeZb c=1 sm=1 tr=0 ts=695f72bd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LsrSTTMk-Wra0dZZUtAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110

On Wed, Jan 07, 2026 at 06:33:52PM +0100, Vlastimil Babka wrote:
> On 1/5/26 09:02, Harry Yoo wrote:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 50b74324e550..43fdbff9d09b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> >  {
> >  	return false;
> >  }
> > +
> > +#endif
> > +
> > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > +static bool obj_exts_in_object(struct kmem_cache *s)
> > +{
> > +	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
> 
> So this is a property of the cache.

Right.

> > @@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >  		return;
> >  	}
> >  
> > -	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> > +	if (obj_exts_in_slab(slab->slab_cache, slab) ||
> > +			obj_exts_in_object(slab->slab_cache)) {
> 
> Here we check that property to determine if we can return early and not do
> kfree().

Right.

> > @@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
> >  			obj_exts |= MEMCG_DATA_OBJEXTS;
> >  		slab->obj_exts = obj_exts;
> >  		slab_set_stride(slab, sizeof(struct slabobj_ext));
> > +	} else if (obj_exts_in_object(s)) {
> > +		unsigned int offset = obj_exts_offset_in_object(s);
> 
> But we reach this only when need_slab_obj_exts() is true above. So there
> might be slabs from caches where obj_exts_in_object() is true, but still
> have obj_exts allocated by kmalloc, and we leak them in
> free_slab_obj_exts().

Oh god, right!

> (and we perform some incorrect action wherever else
> obj_exts_in_object() is checked) AFAIU?

Yes.

It must check if slabs actually have allocated obj_exts from wasted space...

> So I think we need to check obj_exts_in_slab() (in the simplified way I
> suggested for patch 7/8) first, and only look at obj_exts_in_object()
> afterwards to distinguish the exact layout where needed?
> (i.e. free_slab_obj_exts() is fine to just check obj_exts_in_slab()).

That'll work, will do.

-- 
Cheers,
Harry / Hyeonggon

