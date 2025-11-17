Return-Path: <cgroups+bounces-12037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7020C62D8C
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 09:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4223AD618
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A0248F5A;
	Mon, 17 Nov 2025 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VJEN1ZJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UGmCU8WG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920B22E004;
	Mon, 17 Nov 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366583; cv=fail; b=IUmo2BV+zQ+c16GASqqQgIVCmpGp5bXYfaye6/CGeBmjYsRcE/LDQzOHjDxyhwp1zak0H3w+vIvzImiRcIb7ETwXa0qo+/yjLi/hUqbXm2wGKkI5pcweKZcAwnCcO7eIsT0EfYMzfRCy/wc0vobFO9n4f5EXI1upiNV2gaGCr5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366583; c=relaxed/simple;
	bh=o9DtHHUNgUwmJ0IUE/MH1ckD//gxe44e4cuq0GBRmEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHlzrRxMKNzuidQIlJKxdfmdSOSQwH/vnUKJfLYsoSeUZXsFzGKzMdpeAa2KhTtHdTYO38j3zmSSR5DkqkD1+Bn+49lSTkUTClzmwDPg3SSZ6mjCwCmIvdNGeQyOOofSBbG/p6+T69kf7jQ1OsLWnF1IPtSGcH2BKovlC57jr8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VJEN1ZJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UGmCU8WG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1wQKH011737;
	Mon, 17 Nov 2025 08:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ffMo2/uYgyEoVvfP1D
	DMz/7Kwj2+IAqOPazA+zVwrCc=; b=VJEN1ZJiXPHY1a78hiHsr2EYyNvab3qd8z
	oxbCsMViX47nHgcNRdJhYP2IYMfreOgF8H8H0vZLiotmw2KX5yu6+oKaDhQnPY2r
	Sl6//KqQQTPu+xhr1yaxwdyWC7gg0vSwZmapNd8fIcYsAio/2BrTCkkaIUZZuPqw
	3S1tQ38K3Jw1imtwDQccOAS1eMSOZgvEhnD+HDzEBxI3ZmUYJlsWoCKK/pcVZJMI
	DhQ7/f58ylf2+KQ4u/H3pUdZmmvJoc0g7G5KfqhusCOqvc0+TTc3XLUQhGw8yh3A
	t6KwCSnYCghyfXW+NJaaIFZb3R+mJpjyRLv71CuhhxuwA76S3elA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbb9yvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:02:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH666cu007200;
	Mon, 17 Nov 2025 08:02:24 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7bqg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrBhPYUBD9IPN/RozgRevBgGYsLm7+RtLhCUOEJ0fZABfLNQBNbYfBLv2AGPxKuxvxlesjA6/XwRyohZNdpyJiRRkCGfTuQrkqHslHd7PvosrIg0SKQ6lZTUkWdD68X8TD719l5odlx1u1Z51ny6ZTB2qDcJGsWZbk2wZEGko2iNTJzm3vEAz5bCExFio8j/aa3rTcjh/XeRS6Z0CtD1v5MEJkGxlOZujnnyTB7aI4kkXVvOmNhzciFdOV7wPceDkj5iBuiukaDKOuXhq80eQYwz0n+ACx2gag+mO86KPrQYN95hSK+USaCaN1QKsTFC7hEbghawVj195FjVa7AolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffMo2/uYgyEoVvfP1DDMz/7Kwj2+IAqOPazA+zVwrCc=;
 b=cHl3qjoPM3NWCpliJBWfk54EQh98lbUDnE0LSElKGdQ9GRwz5YB3qVZdTCDkiLizbwMO+YJRlqY0qZ0CgoXHYxliMACzXOFMH/2Tuq0l8OcsRIZ5AiKBTZ/otXEjP25Z4zhmWJ44TIgNMhbrAj4OKrvuYFw7S+h2JdikK4jUWtc1/ZBmtMneuFTLj5rIHrDsNCSxU2y2+w43ud73Tc9lSu+Rxm238uGsdmNmj+sR3AFqTTHDzkgMsJxnRquomNQtVQSnVAtJOAnMShiMLR9+MUd2Mp36codRsaQiVYLxcFngUpCtIYBCssfVuh6UI8exs3NtSP/KKq8LwIQ+2z+E7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffMo2/uYgyEoVvfP1DDMz/7Kwj2+IAqOPazA+zVwrCc=;
 b=UGmCU8WGrKg5jXbME3Am6osTv0v+mSl0vQceveyJMVsZiNoRg6FV188zLeWcXXXOfQ5ewVHLN0Ycashbq3PBY/WGZPhNcXl6l/YOzWl6Voh4WcT+DJ6ihgPPU+Ms8B1LGj/OElMjT0NybqXDl53asoohAZty0sjfV+wgKZ1Zg5U=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PR10MB997550.namprd10.prod.outlook.com (2603:10b6:8:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 08:02:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.019; Mon, 17 Nov 2025
 08:02:22 +0000
Date: Mon, 17 Nov 2025 17:02:11 +0900
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
Subject: Re: [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for
 non-kmem case
Message-ID: <aRrWgxZ0kxtcBcJ6@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <05ef300193bbe5bb7d2d97723efe928dab60429b.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ef300193bbe5bb7d2d97723efe928dab60429b.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0074.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PR10MB997550:EE_
X-MS-Office365-Filtering-Correlation-Id: 035dd37d-a5fc-468f-b21a-08de25afa2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sd3+217cNkrvzd+sT2TmZr4SZ87HOqJRkDT5PZ4pxLv7VKa87FGLZtilarr?=
 =?us-ascii?Q?/dJl1cWIlHdD5QEGm8ey2fLi7ZybDia5aFFf6Va4SGxZAjS6cFf4scVcrmrD?=
 =?us-ascii?Q?ptD2BqqBVYm5LQgkrcKfO2IAmom31EjSbps8gcA5q6UfDlDYLjO1Hhgv1hcE?=
 =?us-ascii?Q?ggp15f8V5Z5XJiFs5+IZr1W/Wm/DF1BAWT3xtPPxSguR0qbW/yzQUtqnW+xY?=
 =?us-ascii?Q?dJafo/C+liq1Vsvz79OUsy1tffmy5MAkAVm7Pyj+INdlAOcPPIfHEGlhpqbJ?=
 =?us-ascii?Q?FCIkJNxNiqaHFNgLArGsqp9a6AtzF6nc+5Bg71q3w9eDFFc+u6UeVG+xnV+C?=
 =?us-ascii?Q?+Te4CAys9ecMLz8FlIkGwMFcujAjEVp0ZeVeaoWxFUq8c4zYc9GR1+tU6xBN?=
 =?us-ascii?Q?kmn6oy4+t+g9hYRM5RXmp7jccHqZA3TtD01UcrTsOPSyZWQs7VpFFs07c7TJ?=
 =?us-ascii?Q?hQdKpsV0KL1djz7M0lt/nzrXo7OxPA5egWhsFaBe9jlOsvcPnyHBRLYqgWIe?=
 =?us-ascii?Q?zgqM4jTMsqPvGRj7aE3VB//cKrm9IkG5i70VZP4nNUrVEYqUX5jxj3+vcWjD?=
 =?us-ascii?Q?bGY+P4BC17Zv889ITCjmo7rA707rcWJL8tOcn6q+UpM2Vw6GR9jOrumJ09Mj?=
 =?us-ascii?Q?Pm/k04cEb3+ABot9zXD4OMhg/qnOOyZQ83lVmJTdT6BV0m21E3OFxSmJWNyu?=
 =?us-ascii?Q?+k1MmI/4aKyH9T6l6Vp0Wx3ICV2irBcOiBtI1VJtYpZHQY8x1DAItYexy6zu?=
 =?us-ascii?Q?Y416cEoFjzdsj8+I7Oqc8Z7EgkfSMBFdrFzE9hQ6lsUugmzPoSJqGe0DamTQ?=
 =?us-ascii?Q?6h9y1QBqMBQDl6NkVYpqISl9KQBRRY+L40NMAS7VqMNdsfxYkQdH5MA54s09?=
 =?us-ascii?Q?mNqiAE/3WE84hLC1TXM5WvYwu+T/g2EOLcpZKBq4+0M70Z6vVBIV02/6Wcgm?=
 =?us-ascii?Q?jG5U9M9buBVtea8pF5ktBDD0jXoybCQWyYkJSMafMR6TW1dsg4S/vn052k0F?=
 =?us-ascii?Q?h7U3bRsi5hyLxUMjZcJEQ1OFVSEz6ifeEgflncR17jjErN9YLe/xEkZiLW/3?=
 =?us-ascii?Q?FHZKlHpgOXGp/Bww4IMWZxIlGMfvYfMgtNz8Hs76x673+DmU8tYxdM7gfzzE?=
 =?us-ascii?Q?pcFqmjUzoEJffyaWoZgT8PgmFOvfWVnfW+5JNYM1Ddor6iEdOS4lR9Y/GnG2?=
 =?us-ascii?Q?d0wWA9e2yb7bmqCCHsReRLL+vGAvZIHpbleXndo8MyTNx3mNrqdYltAN6H8b?=
 =?us-ascii?Q?/C2RokJMD+jji8SiXytXpcD/Hxdkz1i/GEzNMW5+vO2hE8J1+fuMYI4QLUaZ?=
 =?us-ascii?Q?NDH+Xlt1Ps9OboiQeNpzqkmg/X/iJGIIPg/d51IRirp6ihFNS2fM7lqROC6l?=
 =?us-ascii?Q?clAiwe8Yt883R5dgb4C02C62cmpM1n61p/Wx0t0Rs0UJHYYpNbFJesb0hS8k?=
 =?us-ascii?Q?ZrzkWXR1zbaCLPV87Bf7nNct+gGkud59?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvBBqdpdle0nWAubQ8Nv20R1Rnl+130vr8kcezFA8ibSUGlUszUwVDq3HwY0?=
 =?us-ascii?Q?CSpc5/VlRK+C75H2RHQSd6pkqFONkdb12+JyiXztYAv3ctzHwmaXo80cQHVH?=
 =?us-ascii?Q?l7RG8To+7gpVemIHABpoU+sgvTkGParjkqD6CLwdFjkdcvvEQWPj3YF0ezac?=
 =?us-ascii?Q?nerA+yUGjwaDfkj3bt3ICnZQ+EK421Gokx3jGqGrYvv3yCrPhTevq8sszte0?=
 =?us-ascii?Q?4IjVY+w2D9egacijbqS5/d0S3PrV/VxAHL9Q5Qnrsx8lWLPeokOV2hDX7NPd?=
 =?us-ascii?Q?pUO4p16nfEzwBHULeqa/7Ul1XTt9INURF003U6ZGOLxDEldOJPXA3YUzLXon?=
 =?us-ascii?Q?MtI/J2zPa8jKv3achG/JQZKUJl7laJNZibj0FYDc47zRHS2ptV3HYnZMov+B?=
 =?us-ascii?Q?c4WeGW687DmuFYisdkpvPtaYZipU/9QaDiZjxrXp8ywz8pv6Cccw8MCx/tb7?=
 =?us-ascii?Q?3kOiOWeXHahigo6GlgaIZYWf6HleQqZY9Ra/FO8t9OTcZ/amCtSGeePa4ko3?=
 =?us-ascii?Q?IWPQGYtnVoTe9FaT1qJXBu7xFmGHEWEIu4ZSNmY24wvF1KZoE3JdIT00/eco?=
 =?us-ascii?Q?O2XLB+T/j+hV5IRrjPDqU2xJVQl6ptAlPvHD15HKI0SW6vIpKx3kIWiYJPDD?=
 =?us-ascii?Q?+gjPzqUzpc/4jIowZdx7+3ICZ6W8AvI81wVX/UepVCsKvlRTj9hCJQYI01sT?=
 =?us-ascii?Q?hfB3vJSIIP/IWrhlvdVNSV3VuNA4MdmTal+7Ym+p+4Sw+CPJtGOqI11isdjH?=
 =?us-ascii?Q?h9U69Bc2kGASVQCIJL+i+mwBEOX5koNHospyXDO5DdkqNSpQQVPOYlTHh4J7?=
 =?us-ascii?Q?4JiymqpuuGZWZoWBhHoJlNzfI8NZusHCuvasQCONF8pBjaPmZ/hAx97xGx3V?=
 =?us-ascii?Q?Wm84TIX6N6jgmnn2imG8fPtjVR7Ls7GynY3tSqwvTtYE48hhy+F5nCwDx2m1?=
 =?us-ascii?Q?sjT4HUzxFFfgsmSWz2qprtGPVlyyb5lsm53KV9iNPgIdjqT4HPthB48ec4Mn?=
 =?us-ascii?Q?NAB6mGYFyUupbl8np+zglUrV3RbY6JGaUfnjX+0o/isOtG+qdKwkfuM/ws0E?=
 =?us-ascii?Q?Mu80j/7aYxkO1ozeXe6dQdzXNHxuAbMnAUQzCzCrUpezFcn0UXEjitWdM1DH?=
 =?us-ascii?Q?tKSu6ezc4maU5/666lB+/0ujV9K+4B1219TmRykN+GjQ0HGrUr7dDiq6boav?=
 =?us-ascii?Q?K4tX0ImVloqXcpCcrhGbsVtwmW6gOg4DJWAOV2AraBJ0UV/8Uj2S9BClCHkC?=
 =?us-ascii?Q?zbx/jrmLek8/R7JaR5DGdCtfYknbRNCqzhKIz+UOFSETYebb7GO9kiEM/fwO?=
 =?us-ascii?Q?bWayczK5Jc+4UF4rty3AZ5T4R2KbIgtNRxTHwkDL7/+RTpkTlrAeBDj8ZE3S?=
 =?us-ascii?Q?OiRLB1HomsajYwO42Jv+bvTxxIcA/sjGvG5w20JdEnhLzAz60s3Y110UgrDE?=
 =?us-ascii?Q?KF1A9eUfCzxOaLdqx7vQ6hobF4D/FQfnRH0rvoP+oFE8YXLlxW4QjW3DKhEM?=
 =?us-ascii?Q?S3VWjyijRUMquHluyOr7B41x4o4HfYyyTf14/+XCEEHtLr3gxHJoaJo1UqBY?=
 =?us-ascii?Q?EejJ93kZf7oNtppEmX2XD8BihbVvZ6watRG3GE76?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1e5vi0+obINeozRgXVt2l/wc2w7sljTH06C0BP+TW7WZpIkL1mNd/8+ej0seJaDAxfs9OfyOuvKX3SvlF8LlU8ImdZSURdQrKMIrTHZBVzBHzg4GD7n4HEsmOw3OjkfXIRJSkdn741fSYIcxADAcRLUek2MVFu4vvn3jVDf1vDcjHRlyxQq1mEuOvl0KvuZmWL6qTQzY7m571kxR8OufzSsT2FoAYFOblnkqDb2pvVS58pmDfcWvaq/RQSfa3bIQfUSr5kujz6RSbbSX5WRDYFNrCwjRUS7W6+jJgrAi+1WLmwvLFSnJyVrAOIkzyGjhoz0FEyxq2I3GdVJMG4uoNq3lz2rSZW3AxWI5iocITbOoejZmcRnUhFy/M+2UONAHx0c4izdsziFOsntnnm2eChwURGmR8sr3s4gnW0pdGNUL3H2IKmD9U5kbVdEZpAn+89AQaRLZwLpA182ARY4dtIWq6jQq0HBi9wnXwS6iO9Sfgx2TZf4XDyAsKyYE39N5NReo4IS8myFMaSBGOIpED4EkWh5SWdE+q8vF4sgpSqQmKOHJAzCycl6A/W9aTgQtS8o05Z0qRZIeJEdqI39AfwYYIabY26fosAvcC5q+Rrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035dd37d-a5fc-468f-b21a-08de25afa2fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:02:22.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+bit6JlhMBpfB8e0RjJyLDVbca05Ctzkg+ObH/2Zcrqd6L2N7xNH2fI1f57pT4d6F98gvLMkK9JkA3mOPqw2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170066
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691ad691 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=qa0PhOK97wjBr8YahkUA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: RofoOr3r6cG-ZUHaxLOnFIn7XoaDQ_40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzwhK7w54USxY
 NWhzADKzITKCFrX6mKEm17MSHHHzcopCXEuYgKtYicWKp7DDdCrQQ08bhyYBqVRkgVdb0TauqCQ
 Yr7fGzKYOmUyKme83HcfkbGEIceeh8Q7E3E43QUsvudDQxX0exNhvUt0QOuR58VLoYTpwVqS2CZ
 429zA3b7zT0K0de4mJ0bPNzaiV9f8JfFgERW3invyy6yXZyXbDGsGtoqCS5WwBBhGJLIt7DJ5Vw
 zSVqLIvSCBYhz2pxh7PZoDe73fEh/TLo9xdG84dcP4LmP/wGGjx36DtobbmxiDUYSlpNaXkTNW4
 +Q2qs145Z2aJUZABiWQT/3FF1jikGqGetYeXSLIR8VMp9xToh4mCzAe3UgH2up5XBLX6w3DXPDT
 vt7u5BCCc3LuwWOMRCtio6J0TQUipA==
X-Proofpoint-GUID: RofoOr3r6cG-ZUHaxLOnFIn7XoaDQ_40

On Tue, Oct 28, 2025 at 09:58:18PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.
> 
> As a result, the objcg infrastructure is no longer solely applicable
> to the kmem case. In this patch, we extend the scope of the objcg
> infrastructure beyond the kmem case, enabling LRU folios to reuse
> it for folio charging purposes.
> 
> It should be noted that LRU folios are not accounted for at the root
> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
> the folio->memcg_data of LRU folios always points to a valid pointer.
> However, the root_mem_cgroup does not possess an object cgroup.
> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

