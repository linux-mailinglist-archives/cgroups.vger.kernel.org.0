Return-Path: <cgroups+bounces-13282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37FD31796
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 14:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1DB309C384
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8C238171;
	Fri, 16 Jan 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APYtHLE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PhaNLEv7"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26942356C9;
	Fri, 16 Jan 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568412; cv=fail; b=LjI4fW0qxhl2oDADloYCsJ3jjiW5D7sfvWuZjdbub7Qfc1KlM/vDCvew9K0+VLvLWTqcmxQv0BTtYJiITGMJa8+VSOOrH5PZX6O6H5fd1fzGzkcROD4vhzKE5vvG9fZM3GtMBxMoxAHPlBzL+d8ZJmwsvnLKkips8DaW/oyaPTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568412; c=relaxed/simple;
	bh=I/tr1O+J8imYW7+RSCmXFKVK0GOxY2FVordIVmrxbxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFLT3Aj2gkyWfE97qpgPUhdvQXaTZ2oH8KGmzKjAX/HwBLWaeDv0LyM+lECBfCXhUbCqZLi7zSqE8W01OTvJoDKOdyxvNCnnxqv907P1ygKaQ+wxhgiT/sS0S0GEIFVj76ITGlti1bpQhWlUxqt8MGOmJZ2dYNCOl7bpMT3Xgsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APYtHLE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PhaNLEv7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNlkv1796838;
	Fri, 16 Jan 2026 12:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OEQb4uyzQ3Dj2HHvUN
	orB8EatOoFpDsfnmaWoJJN9T0=; b=APYtHLE+fk0LdXc7d2ZfsioA5/PHfW+bjz
	U49ODzsjEkO7tzaHPPvDhKEcWvTIfab4XrLB7ls6GqCeA9SOizIchw9MXHc3qn9K
	WW1BXedwLdiKfMYi2zDe+dCVhnWE7+X2WAj5ziyyqaL8LpcNGUmOZTsxcoSpJoKB
	EA9Guofcwwl8zwIY7Ets+2HAsuz110jY5wrDS51KVN6ISHRTbWUy6Fv6r/FNJz7x
	kmBfXU6lvJ/nECkPBTG1sC5wXP/FqzDtZ5RhiF0He00o/2jEt+iPKUcOBHOr3554
	iJ/3JkaEQoePwuV1yGLOL/u/of40wlgqeXK2xY0p4Cde5Dy9kCyQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgsvdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 12:53:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GB6NmE032753;
	Fri, 16 Jan 2026 12:53:39 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7cve5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 12:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiwK5aVKld5dhtk32P66vrKIzr9a2sqZwDf9mHlLKl71WBw54h9/kGd18ed7Pwuvv8UGT2QaccJbKeRoMI1usjn95sAW5muRcT8sobJET4J3lVStG/SzHzjQoS+D8pzIez01Ze9TPcctltB/68+mNucxt+robyUSQg5RQSqc361Wm5rWT/+/9cojJnbe17fYo3vlKUmxsOpJzCP52Ouzs9horf0/M8p2+ox0Ffr/H3g+7P/k+QZ8X6uIi0MZ9NGJb5I/P8rCOOZJGiLLCLLb+vXtmhyATy/DZHalzyGOcOUqDZ80WsUQvSFNRomLLyqA0skO2WY2WxnqvVK4CS2wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEQb4uyzQ3Dj2HHvUNorB8EatOoFpDsfnmaWoJJN9T0=;
 b=pc5FIl+/J5srxgmEi1kH6RhXBvtXOIc08IcDd9/VaYRHluszGJlDgmA105+hJz3FHZohNnDvziRfntekUq4kaToGikalycJcjkTedkiPrlREjXZk6VOMZIEQwIZH/YrHslqimurcqVpxUZbm58lDZXBARMKTOGqyP9GAfJkV3oT8aaASTxc7tJFnQsmQgVhI0ui+tCY1xO6saQ9jRrR/AxhSJgtySVuiMU0l8bmwH9FsDLIk65IfRuxEy29+JpPJFmx+IRhEuOIdKZUJDfyD8b9WKoNUIhnJ9jgFZS5elDbRVamt85y7WGTbzsfSQ+oOXulPsnC+X6OciUATq2PZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEQb4uyzQ3Dj2HHvUNorB8EatOoFpDsfnmaWoJJN9T0=;
 b=PhaNLEv7gxy5PI+ply+r0XBxuE6PSOVUVzKX5zn+koXpHNyyuMBjr8s+IF0/kF6LFyNSEVm9U5phVbtslJ/6qzM41oXfGfZj3FSZWKfv3dvNHod6hZG9rTjffS8tfy7wxk+dijtSRYTDM/gCzAfiJrbl32zTzhQSvVkmzPGICkk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB8126.namprd10.prod.outlook.com (2603:10b6:8:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 16 Jan
 2026 12:53:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 12:53:36 +0000
Date: Fri, 16 Jan 2026 21:53:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 07/30] mm: memcontrol: return root object cgroup for
 root memory cgroup
Message-ID: <aWo0xSYXR7qZHPkp@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <e8281b894e778472d3040b4b9027f7d25f0fd1ae.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8281b894e778472d3040b4b9027f7d25f0fd1ae.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0006.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4171f884-553d-41ad-f34f-08de54fe4358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrIZPcpYXQ+zv/GsRgyot2pESiZhJHde1joEJ70ITgUtWkp7AEHc8eZ8JV9H?=
 =?us-ascii?Q?pg7yBrFq1TYayoada8L363+/rLSNYqyDTvFLDzqNz0MPYgpqr8RTvimq2REV?=
 =?us-ascii?Q?yFcpD8YPaKCmXxAJY2AXwH8VwK76+6EDm4b04ozJ/y/QeUP1VlxXQd9RgvB8?=
 =?us-ascii?Q?rONJMWTbpWr7Gi8Snw+Ssg/5tQQ+UGBKOKW7zLp6pneYuUjAz1TiPJb6EkxM?=
 =?us-ascii?Q?e2+MpOysQmjcUHIcrNremP+EHApii59ZY4YAPK1TRIWTWLOXpyQSYcYuiTsk?=
 =?us-ascii?Q?j3tWHYTK8orAt6PWLZT5Yllb2lWLDEYkGc4PrYVqm1q6bGGlmgnG/Qi0f2cc?=
 =?us-ascii?Q?jTB5Tmgn+bm4RG4zC9213Jvai323UgZXPr2oLdK1ePevlh1/yPV4CZvQm1Qy?=
 =?us-ascii?Q?N2t/SJZZIrTmCcoK7Jl1RcRAAoNuGOh21JsCGihsB1iyQuWPaVZ5jLD58r9N?=
 =?us-ascii?Q?CPPTu8B628DjOzUQTAaL+Gr4pNQzaofgISYY3eK/Z+805473LkK9dhUGGgOG?=
 =?us-ascii?Q?riJk2NBbn4v7+tfScbWw7HO6ZMqMsyh5EBDB9Y4p+BubT5jRMCh2odGeLbcn?=
 =?us-ascii?Q?HWHTV1YjWfc3btEBGURZgCWFv9uU/FYuNQuG2CAJsscGQLV6CXDr7GyJ3Yzp?=
 =?us-ascii?Q?Gkv+7Mx7Z/rlkxOvHpz0tlqslg32ojRZ5cjfTOtNXV6Z803XXgJRN996aOgE?=
 =?us-ascii?Q?/lHhLUBy7xXWNjYWs84Ud41pVP0ZhaeG9U2u7e/GGTKeM45VC/HjL/LY2yjM?=
 =?us-ascii?Q?4spPW1ZOtNk5yA6HPOH7+Wn+jNbC3bJwHtnr3JAv7/zi11RJqq9Oh877O615?=
 =?us-ascii?Q?z6zj01v/li9ecRvBpwAQKdi9WGjo1Jg8z2fwrG2TusjHPO31/uvl6a8vrLAI?=
 =?us-ascii?Q?vRsF2FbgwNEABMdae93EbCjkKpAneGVrzcdb1PnpIMMVLD0KjIxxn95GvzwY?=
 =?us-ascii?Q?a+JHmtDa9DwgvZNXKHx9joFdppeMTc17I0ZV/4x/qNhij+RIMX8tpoBsyac5?=
 =?us-ascii?Q?WQpIbKq9hxJWbmc9M3zlz17n/dvQYtUZPviF/cjTo2iNCX2eXNTMlNXhC8Ya?=
 =?us-ascii?Q?k1r2V186hts76KY/YRagWGNXFqvh0iKtQ+1s0O5rVeLjh/70OnrWLaiWRjx2?=
 =?us-ascii?Q?Gq7gzHJZBLPJykpo7nXtF71gUjqg5gNC0IrSgGuevQPvaog/yNlAqFh4sFk2?=
 =?us-ascii?Q?q0xx/o43i4vAquFhgn+nex0g5aFDdPYGZHmW2sjRxufP3aD7JoLjvuzSWKuT?=
 =?us-ascii?Q?Qjl7c/171XSOS6OcjgdKNwXPB+HkPZetawNvrSYbWCD743Z11RprhqZ3cVO4?=
 =?us-ascii?Q?Sd2r70aLq4NWpyQBAMaZRiVsyTPbdXGgcjZ/7NGbMYU5p/+OA8QLTge1v1zc?=
 =?us-ascii?Q?tlILWWxrFlBrlOkQ+Wamco/WpzBI/Dsxbek3tUWpkCwrcVuvx3vgXraxp2g9?=
 =?us-ascii?Q?biSUnQP13aYQVB79FLJh/As5D8swmI5NSvTrRKlZl03Dyyuz6kmZdXZLFEj6?=
 =?us-ascii?Q?xHHKYat/whYrUh7+3gCV1EIzYin1virOmLM6ku1LwXgTHXI/gvXQb7fR5TMk?=
 =?us-ascii?Q?kegDzPu5WvqgMW8yt/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvEjpIx8cXc6M3H9tT6DdjxLEGFNeJebG0PVZynHw0OXDBdm/4FSWlFyY505?=
 =?us-ascii?Q?838c7JsdcHMPnLLd3ONyzcg8uG4vcorWziuOqFHdXlXDsKu12jmqA8s2F1da?=
 =?us-ascii?Q?X6Y5OV+M+RvvSZR/Hq56xnmPZh8TKiuF09o1eXewG4GhH/q7N1zCQpDQzwa9?=
 =?us-ascii?Q?lLLMaGWG78S5qIiYGKkwPwwuCpYcw9cvcHG0oAHQtqMSTvCiwFKVQw+lTd+2?=
 =?us-ascii?Q?l4KtHoGTnUWOCCVxFbsxqvMnpPvHBQS7Kjb7qc6vTncJ1sS6WbYEUa6d1pC4?=
 =?us-ascii?Q?jy8Oon6Yxncd1LtIVT2YfUTYJAoPjxIdN/i3WaEP2RewOckAKr8ge4lAzN91?=
 =?us-ascii?Q?hN68b5UVBQZH7/dozo2WznNAfPkZ5BvOo8L/1dnD8FWnX1GU19iWKfewi9mp?=
 =?us-ascii?Q?r476vBODtYu8v6wYOvGm/L9/R+I5vWjkogd3c1mTxXcJtaKPPgT44b5zE8B8?=
 =?us-ascii?Q?GsZXATQEXebrmvE215qwHXRD/yiOBPzdsXh3RZZFedN/yKiDkNYWZNzj1Was?=
 =?us-ascii?Q?DsetA+CV1uleXEdeLPkEZJQ6kMz48h15WTdzrWPjLhaKWwBhmI3WUzN8As1g?=
 =?us-ascii?Q?HTAFsJwbPHdXulXtkQRKFaj8JBPgPLbfPWzUY2rp8fOW1sVAIJdaQ3jquds3?=
 =?us-ascii?Q?klxG/tfsWpHpNu50ZGoeZstYYPLS32J0aMUamwsElxeCixfO94BoEKnc8GbX?=
 =?us-ascii?Q?eAnNgm0TRd6S+nxrDwCmhblttM4Nnkapyo+vRQfFrKCQBTAy8JBSIM9V5WKq?=
 =?us-ascii?Q?Tw+RI/PR7gJ2NtyBJgIs2Y2yRdKAsBBFXC9h67Hxofe0lzfrj6bbK87H79nu?=
 =?us-ascii?Q?+vryx0hHr5W562tZJm8dvahjOhnk07eo0pyOqWCR41vblDrEf/pX2wdcJEYI?=
 =?us-ascii?Q?nX8KJq6kW3PZNmSi3pBkD2KfToS1OEHUH8DOsci3i92UpWr+7KAS539PYLdO?=
 =?us-ascii?Q?MuNgy/hxde/oLJg8Kq0VY5xODCbHpFHEWxlYoQXBvydvq21/9CBVEj2SWJFH?=
 =?us-ascii?Q?s4UBR3GkpJ3M68+nwhVDOjmusBtgsa5eOw7A7dgc3Im0Z/4ppVHSV3Cve11y?=
 =?us-ascii?Q?rm2qhi9gMkyaUei0zXkHaxq8D7OoycHcgm90Lj9maHfKIgv8Ic4Ai/ke/4vK?=
 =?us-ascii?Q?TLLVRFfD4sVDBU6JOPOIjdGK22nwHBCBkjcnPNPjdrsGs5vP0rXquRv28WuM?=
 =?us-ascii?Q?VZ0wGJEhoW8stgYj1XlZ1G+qeoYdFj0F7Eh9QrJEsz1uon8CChQFPICYyVob?=
 =?us-ascii?Q?Pt/E2X+rP5E5uJ2CwQZWTaMhj5rR/EYhrZBnr/tE+XdMws9n30oFBFlKyw/H?=
 =?us-ascii?Q?2jjVqCwErNboiE0d9KvM2mF2awsfs5aEPml9JpMK5Y315sBlN2DJwKIWPv+3?=
 =?us-ascii?Q?DPtP9GrHC8a+VNMoEutzKblFW8G0h/vt6iOkcXTpimLVbWqQ2PhxEFRJ2lsS?=
 =?us-ascii?Q?7l6WoYBtf7uLddwVXC5tPihYAFZKmuKFipqMsWdP1Lt80so7You+UOwHOv2Q?=
 =?us-ascii?Q?PvZ6Uiyn/8T2fma9OHICTeOcLFLOH+nIQ8OJKt0RQyFpWhwqW5IEm3G45eeI?=
 =?us-ascii?Q?/ntlfNBSifAVFLe11tVGFmDDTtWEf6+DsCclW6vcqhOijRk59aQbftelACRz?=
 =?us-ascii?Q?xX2o4tqUcAlKxRLVBPEKLgS4v3ZadeDT3B/5qJ9FB9WHaElpId85a64GrStQ?=
 =?us-ascii?Q?Eo61NMyQFwqVTR9XL2UJcvFGu1Q0gftYTRvJ2AtwCeQyDx7a5eJ+FUC1vTR4?=
 =?us-ascii?Q?ho6F+PcLxA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ODsLNZxufDVsgGRRFvFVmlpF5RPtbdV82CrpmzLlb2XkbsqbtFjwgS+jzlgJqOGJQp6Rl8wwFZPFEghL3r6adAjSjVUhP3s+27u/kjCY72zFOfzOg+jns3Ji/BD0F6Hdk30/sEninq5cmiFemi/7miR7horn4SIGviZHOdVfYAKV25D8Tc4uaCpfEWYygx7sNOB0fzwiXhpZdpULXCZidMcMkJh6H521XcdyMeE1VI6vg0cxgpnnZ8oaf+8yrRQMjibaC9WcKjhg26YiRr1+w56sN2eMzTRedeOJRjgx5zy12dAlDdTmU8V7EAygGaobeTzohawO4I5XG0VDOYThDNOAejKwWVD6rzaHTGlR0WMb2ZdCl5yt0qtMAeQjBX1zz8VAWvL5NSTjghP7h/Fpb8tK23UzcZXouNqsjM3nfe2t/Y/NnrBbqMBWGlAhqoUdzZZFhr2NAnFei9KXS76XVP8hSl4GIV0dCCBSjv+I0dawjW5JHiYbYLUZCQN/XBBfnjlJhhPkmI6oYKUdThxBmmJanOijFj/MFlaW3d54AEW665ncKggOQoOEze+V28a4rg+BQD12/VYg3Vt6g2ffJ44ZkOvqoHCpaVb09aynOks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4171f884-553d-41ad-f34f-08de54fe4358
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 12:53:36.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uv81aqiJ7obxQi805oAxbaC6VHw/VGREdM57hpB6Mn3Np/cOW09+pKg112rAG60qx11hrq5tq2X2pCaaSXrc4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160090
X-Proofpoint-GUID: kc0NPCGoVVH7CNJ3n-TLREGkcKLGTglG
X-Proofpoint-ORIG-GUID: kc0NPCGoVVH7CNJ3n-TLREGkcKLGTglG
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=696a34d4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=PDVtol0NnveKQ5gCZTkA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA4OCBTYWx0ZWRfX3l19OdJWVCQa
 gWnejXves4Z/9FJMkfSK9wHaLcfF0jC/jqoDOm0OmBq57T6zjTtlR2kfaFA4vhy+lHDSYR+HEEm
 HAlUK57SkGk+xwMVf/MNs9Zhv3C5vgjZlfmk6MzQEfhM0MlxuQIE3Tm6+QT2flcHy8wIPM7j9Oz
 w81TuWpOrQUjRDkcQJBOahZ6IKABIpU2tcKbsHt2eLAfXnjP8T6fyT+BttMKp25VKV4dCb7Z7//
 PR06qkuqCiACyh6InMPcwBbtdUqWUPbgGnnbHsm7KP9bMiJB9wlJs3+Y6YxMTu3p3MUSxKuaHT8
 jRy9jSRAxJ9ybFVcM5Mc2lSinz5NUXI48HWIRtkF2IFXTfsK/liShJ4eAHUSnP7f2+sxWchsgcI
 vEUEmw92k/0mjB/SetQyunrr89bt4mIw6SqiVfzG2ZPHkwGlOO6h1xIxL1gdE304FKGHcjBn5TS
 8jKOKb7yvGe07IN0mIw==

On Wed, Jan 14, 2026 at 07:32:34PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Memory cgroup functions such as get_mem_cgroup_from_folio() and
> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> even for the root memory cgroup. In contrast, the situation for
> object cgroups has been different.
> 
> Previously, the root object cgroup couldn't be returned because
> it didn't exist. Now that a valid root object cgroup exists, for
> the sake of consistency, it's necessary to align the behavior of
> object-cgroup-related operations with that of memory cgroup APIs.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me, so:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

