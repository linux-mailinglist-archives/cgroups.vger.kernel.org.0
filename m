Return-Path: <cgroups+bounces-11781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A24C4B49F
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8253A1BDF
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D133B6C3;
	Tue, 11 Nov 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qifZPqPs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QkS6xccm"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF23370E0;
	Tue, 11 Nov 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830718; cv=fail; b=YY34QUZg834ItFNf4g9F8Wd15YprsUxOOoe33h5HG24HqiOCy+xlWvqH3DJNvQI1kM50YpYv5bsm6Omu7JwXJt67qjXsUzLwxi9Gam/EWjZzpflx8hOZwjvPM+cd+PV5tUtKqKX4hnv/a6qCoVNvyh4pNt+ut7lBSGTZrgmPC+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830718; c=relaxed/simple;
	bh=mK8JPGzveIM/Yf2TB/JQTAch5JwskXPydY845mIDKno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LLN5pMbbMKfyRukVsCfG8kpFOyl76dwCdPIuNzWciOP2PpFyXEx7PI+iw7yAioeRhzCgxwV2W36p3CCuvbSCaYk6pUi8sahinislUCJQuCMoeyW5EhAUBqIVw/sQMwreU4gHaXyX18ZOs1oS3ObZ4ZL+GIcPzBglzulO+zEEP78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qifZPqPs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QkS6xccm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB1VXjg023178;
	Tue, 11 Nov 2025 03:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1XunEFwDYbOjKyuwQf8ScBHeXvYszqnIax1JAazfv0k=; b=
	qifZPqPsrIO12EnMOZs3WW4K1OWXAgfa1yr74LjD0Cdu/tdYB7W1C/xZdWYsQX3H
	gc2B0oWWzoxeVa0zEoFbqdUfnTve+wKyMISeGxYz0hCTE9SIxgFSAVyTHfYCY0iw
	OerZSwJi/M64mMGRSbBIYL6OTjl/aHYxad8ZlLiFvdYTNMcyoohWiOlSJQu8xqDX
	3UsDEHrFwi4Ycmb31UnkMnxZ3qkzf/WyutuSFPmGnKJHK0sIfgHtHkbom1rXnGoi
	WA+ACftKEXI3KDyBnY7UWtONpO7ZLNsbb5uPfFjmDHuIzouoBllXGg+rOL/HaDL7
	8YHXAPBHkfTitE8JBvj3Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpugjd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 03:10:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB0B9p2012576;
	Tue, 11 Nov 2025 03:05:17 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacfsbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 03:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjAOoKvhWZAmeiXgjYkxOP9UmkJXSSkgFNGtogjeYNKLNVHarDEAXJoydjvVjaNGHkN96MCkPFwgHpqE7x5WtKbphCWFipv65Sd8BbTmryDENmdBvpiSSis7KUjuc88JCYjxnhNlM46nG65qiDJYrdHv5Hw4yOhEKLrifXnhMmb+8G6Wt94hDd65mtZAx75J8dy4Bc7vOjjCEhyWftZZDZjVkYPpZoCs1ViuNIheO9j9ZnNTDjvA70PMgL08adLnD5R1nCht0xaDSk6bC6ZkJ0KFLeLCgWWI2EvUNFRa7XQYGb/i/0PsFTvLOdQ8jy6qoJO+4DmGqUIy1e/3JJTmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XunEFwDYbOjKyuwQf8ScBHeXvYszqnIax1JAazfv0k=;
 b=Rks76WEcUun2akmlksrYSJaHdgKg5b9kJKOIZEBBxWju4TebfBguXtS3cosJWcE3Xt/uH9wnR0JIAG78FFQZgOcVnR4+jkaHy8Mg0xBwr6M0CeOfbh/zlDOJCWfLA+OtboQG5pG3bQDr6l97+8PTMA+8UtdnhOYLHnVLKSiW/NdOCqEkkuLlhWXnzH9xdyj871qvW0b1u4I0MW08OLs4L1CUbY+i8ujbjVOIC/54oymrmJbmiopYQ25e7oAJaPOdIj79VW624JAOSoXmI1WNGUWrqjZ3z/wmom1wf2HSQJ8gv0ARB813N0Ljxn4WlE1nYzhTQPIr3bPc12thp4y5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XunEFwDYbOjKyuwQf8ScBHeXvYszqnIax1JAazfv0k=;
 b=QkS6xccmAmOy8W4XHxFsVjZ5NwrxXBqNxdTkEauArDbKnctsiQ3sw8S2NYujxadBmlT8pbtoi4c7xfi/Gu8e2XU/4UU+yoVgv+FxFCnzgv+uU60onK6iEGZVsxC/utYTndQtV66XzcBx9xmeueg62LbHIhFj4k4xLWkinGQwaBA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPF1A1B8C819.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:05:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:05:13 +0000
Date: Tue, 11 Nov 2025 12:05:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <aRKn4kqHx9m9lWfu@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
X-ClientProxiedBy: SE2P216CA0166.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPF1A1B8C819:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5ee569-fd25-489c-77ad-08de20cf2212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckRndnQxT1dxWEw5YUpXeEVMMVZRK3htK3gwdnZhOVJGdElCUHBSUXM5SGRi?=
 =?utf-8?B?RXV0dG50VlJyVkZJLzVUN1Y2YXVpK1ArWk1hNUFIQVFQNFYxcW0ybUdpMHFj?=
 =?utf-8?B?WHRWSDB3VFBrb0Q3amtDQmprYkhwNVQzU1dMNDR4R3BBVkV6N3dSeU5Ddy84?=
 =?utf-8?B?WHhPamZLUWVBZ05BWldKTU1JUmVFZEI0U0hCd3B5a0swZzZEQjhDSUZEN2RJ?=
 =?utf-8?B?OWdyb1hxWXN0YngwdWFISmlGOUV6dVora2UzNHI3UXBqUFJkK1lBc0w4c1dp?=
 =?utf-8?B?dEgrL0JaYmhqSE9JaDBnYWt5anlFRGNpT1ZnWmxDVTdIU0o5aVhSTnR4MHZt?=
 =?utf-8?B?bCtTak1iSURGWVhGYmliWCtwVkdHTEVVSUNqbXkxUU55ck8zMkpBM1lGaHhx?=
 =?utf-8?B?ZUZXSVdNbGQzOEI0SkdQTGFUOVh4QkFqYmhjUktZaThDbXN3ajU5K0thVkZi?=
 =?utf-8?B?YS9PdlZsOHg5cmp6ejNRc2dFZXdaZkRpL1RLTk84ZEJZbUV4bVI3cFVzelhJ?=
 =?utf-8?B?ZVNKZEJROTJmUklMUVkrdmFVWmJvenZSNFlyT1ZJUlYrZlQ5RVR5S3NFQ2xo?=
 =?utf-8?B?cE5tRS8vV0ZkcTFlK1ZOMGpiMktYd2IwdEhRaU5wVGFsb0x0d2szbGRGK2Ns?=
 =?utf-8?B?eERvQjdHV3FVS1RwOEpvYkpkeklwbVNxYURXamx3dmpHMHorKzJ0NHBzWTli?=
 =?utf-8?B?blBRYWFHYkQzQWI4cXQvRzN6UUE2SnN6MkgwRWhIZlcxdUhkekhaMW03alRn?=
 =?utf-8?B?QUFUei9zNXhNREh3eFg5a3dEOWJMOFYySkNFMlRUM2hEbC8wcCttUGtwUnBW?=
 =?utf-8?B?Wnd2MlRYR0RkZUEzUllBNnRwMnp1RS91T2M5dmJDZW5KOEpHUkJwYmo2aFo5?=
 =?utf-8?B?VU5BYjdQdkt0aVArdHJ4eUdONitPUUgwNXRBRmdiNzZabGZwVThvd3ZYeTRY?=
 =?utf-8?B?anQ1Zm9pcVljVDgrV1drQTB4VkdkemowWEZuZDVZTGxWWUYrNnB0RDJTOXZk?=
 =?utf-8?B?bkhUVzlDdU9QYzYvTjhjNXdETngwL1AyYjMrQ3J6aGVPUGx2S0FHSE1QT3hC?=
 =?utf-8?B?bU9JTG85aWtWWUo1RDhabXV1SmJRZytqVUY4R1RKZU1mTm5RNmJwWERwN2hQ?=
 =?utf-8?B?cDdJazBmdVRHRDNVc2FyRjl4eTNjU3IrZDhMMkdLQitJK3d2RGRONU9PS3JD?=
 =?utf-8?B?QTIzNDlNUVJGYlFmNm1DanRJSjZ3TTNUSjE5OUwvM295UVdGRmFmelR0VVBv?=
 =?utf-8?B?TzJjbjlpZ1RDdFlnTm9lNWNoMGVYR0thT2dvWmJZbVVRQkxnVlYzUWR0TWlh?=
 =?utf-8?B?TnVmU2tGdTlQWU5QUDV1Rk5iL0hnbk9sNHM0L2Y1N1E2azl2N0RNWU0rNGJC?=
 =?utf-8?B?SDFTZk1sTXdXT0RjWW52TDdMZ1g2S056ZWdmNHhaQXZKc0kwd2xoYVlOMndW?=
 =?utf-8?B?dVExUGNNYnhaUURXR08rS3hNK2VrUXpjN1pnaXBUQlF0WUlXMU4vekxUbG1k?=
 =?utf-8?B?WUIzQjBwNURhV1RzL3FVVmdYYTZOODR1T1BjZjRFWnkwOGhvRzgrOTdJY2Vl?=
 =?utf-8?B?WE1pdDF5M2w1b0hzYXFUN1dZbmpydzVlRnBuUVN0ekE1STFZRE9TMDl2UXdL?=
 =?utf-8?B?dDRVcHBFYldUYmxMR3BXaE81V2oveEp4WkZYK2ZiYThBNmdhZkVwcHRydmMr?=
 =?utf-8?B?RVBNeWhFaWlFOUdQK21JRWFzUWZzUUdES1FHcFZxT0doZXA0SUE5Nk84TkNh?=
 =?utf-8?B?aS9ubjh6Rk16ZlNPZWd0WmJ2ZzNLZXltanowdVBueEtXamRqQzJDTDRCSEkx?=
 =?utf-8?B?ZFBsL081NCtxSU5VWlZZQXJCLzRjd2IrSTFYVmRWSCtlZDJwakRkU09vV3BK?=
 =?utf-8?B?NmNoVSsycmQ2enVnaUVJYTBRTHhqR0lIQWtzTXM2MFo3LytKeEx5TXVFclhX?=
 =?utf-8?Q?5tVT653Ich6R1gboTi1mePM4L4Hp8WVX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1BmeWh2TklrUDdzYXRRY2h2QmdGOW9Ia1FHNjBpd0orOVFmQzlsSnAzVlQz?=
 =?utf-8?B?WnZTcy9TTkU1UFc1Mjlpd0RiaFBKZEp0NEVZWUhaa3o4ekQwRS9Scjc0NEdL?=
 =?utf-8?B?SGdKTE1DZTNyemd2VWQ1amIycSsvdVkvbWdkK3NqUlBVaG9wSXFIcU12c0lk?=
 =?utf-8?B?RTN3a3BmajBEWGpaRG4vZWtBQ0R1YitoK0hrNWRrcWprWkhTTlVrcDhVcWY0?=
 =?utf-8?B?UHhTeEd1NkZQTUZ1aFVTK1kxYzhwa1Vwdy9lR3BScTFiTmdrVzZ2N3RCUU9r?=
 =?utf-8?B?L0w4c01wbk8vSS93M3lrOXgrWVJUNnJRSHpkdU50TEhiN0dCM1ZNd0FYWG5q?=
 =?utf-8?B?Mk1iaHNBK1ZwcnVYWlFKamtlM3BJTEhia2IvK3k2Q0JLRXNRaDQ1MzNpQjB0?=
 =?utf-8?B?MlgxRGFlOHN5S0ptRWZwVTNwMHUyWHJacm5rRjMxRjZueEZLcVNYSDUxeEQz?=
 =?utf-8?B?T0FmZHZCUUVvN2p0R0xFdWdrOCt3Vm1rb3BYcVVlQnY5OU5CWVVtVlpvdUdH?=
 =?utf-8?B?a0hFY2l1NVEwZTFMaG9tc0Z3eVlaVGE1Mk1YVDRVNXRGajVpcWZuZ2JUbmxU?=
 =?utf-8?B?bXUxVE84emFhbFA4ME8rZGZpY21hRFQxVVZTdGlNMEpZTWEzWHBTMzlINHp4?=
 =?utf-8?B?MU5QMmxlSGJYd0RoN3o3U0xiN3FOZmF2RHpnVVBXUW9zeGo1M2ZDZkdBYm92?=
 =?utf-8?B?bHFQdW5WZlZzNExXYWdkanhMS2FiNVZTbTVtdWhlR0Nqd0ZsU0VCNDkvRUgz?=
 =?utf-8?B?WStKZ2xWbE9kTm9TLzFjTzJaZG1SRU5tRFpTSysxa3VvZVg4cDFxMTg0ZVYy?=
 =?utf-8?B?WFE4LzNSY0hKUGdkL2ZsYjA5dXEvUGd3SFRhUU5qc255Ym5LTUFhMll5Qmts?=
 =?utf-8?B?MzI5ejh3V1dXVW9iNTVJSHh5S3N0KzBXckZzeDB1RUJHZW1aOUhydEZORWw3?=
 =?utf-8?B?WVJxRDEvZmJubXc5bExyTTRqNzhNNVFKOVprSkpocEgzMmppWkhTbUF6bEZF?=
 =?utf-8?B?QVZ6cmpqZEtGakJxaFJkcnQ0ZlRiQkRlY1VxVFc5d0lBOTB1Y0lleWFqcEd3?=
 =?utf-8?B?Wnd0TDF5V2VaVWhLQkhJYkxTY1htcFlLY1ZGZW12eFdvZmZobzhvZE1uM09j?=
 =?utf-8?B?VC8rR2xmRHVWUlBSY25MTHFML1ZzYkRBV0FNdWRHekpwaTJxMitpa2hEeUww?=
 =?utf-8?B?QTVURHNNQjdhVFNMZytHQ01IN01MelFoMnVobktEZEtka3hocW0xK0lwVFBp?=
 =?utf-8?B?SjRFbFBiVXlBY2xYKzY2SUVXempnOENZSmFobnF2YTJRV0pTNlpCcUltM2hR?=
 =?utf-8?B?bkhWeUE4bGpvR3BVUHdQcHFNc0EwRis1ZTk5ZkVYVTRlZ1VkSG9BWVlkM1Ns?=
 =?utf-8?B?MTNwU1M5QnBsY3QzVTY3ak9Nckl6TDRDUG9ZNVlReW1DbHQ1RFJJSTJEcnkr?=
 =?utf-8?B?R1dOcXhhN3dkOXlWd240V2ZNd05jZEQrSFlQalllYnFrenpvb1R4b3VFSzRq?=
 =?utf-8?B?bmpjVW16TlZGbkRWTEhHYjhjdGR2OUR0eEVMVkUrcTc0RlB5ZFF3eEtqK0JZ?=
 =?utf-8?B?am8xbGp2TFZteWlxZ2JPWm5BQlpQWUh3QWw3RGh5K0tFNjBidkRqTm5lbGpN?=
 =?utf-8?B?UUlZZ1VXbXRaOUxVcGRLSFVzMnhJa3RIZmYvVFJTWFhkamFwRGJRUjYvajJm?=
 =?utf-8?B?b3NUNi90MGlkQzR6TEJoVFNuNnVsQkJySHgvVkZEZytFOTErR093eW5HMjZJ?=
 =?utf-8?B?WVR0YjZESkRjcGNNV3R2UUZEc0pnTnJUWGVQQ0lUUHBCQS9IVUI3UzBWZTk5?=
 =?utf-8?B?MUFVS0JleXVXQ1l2cmtzSW9ZVG85MHpicEx5RFg4VmR3MmxsSmFCZ0gyVmNl?=
 =?utf-8?B?UnRuZEY0amVQTVlYU2RhRnAxMTVySldUelpjNVBwVS8reFJ4Q0Uwb1NjMkNq?=
 =?utf-8?B?VjI3L1N3S3dPc1VGUjVpenJTT0ZSeEpMTUtmVzRkclIzcmlDN1Y5MTJ2OHh2?=
 =?utf-8?B?aklVQlN0aUpCemp3Vm8wMVBBUFR4SWw5ZDdZN1JZNXdrYU9pTmRqRHlLMTZN?=
 =?utf-8?B?YXR3ZjMvWE5aeksvd0FPekxjb0pZOVBlcWRDQU1CQ1RWemZYUVNCMWpHbklv?=
 =?utf-8?Q?1p6lO1fd7A1V2LFWFV9FYfnK0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6UlnO0EeZnXnhCvnkYlmOwSfjqHYHSQ8qPY2sCzPX0LvwiQVdTH4GIpSgrrAc4RgQG7arDz4W2uk0zCnUJUce7tdDAXm0aNylhDdmXwQijnrOm+qpmp1VNbjTs+R2eTJnxFl5oSBuSHKajpNpYWXMOuXYeN33Ffy7zLe5Wo4XkddFLcsYj/OURR+7TACX1bhvrw6EcmjHCV5nw1Z17fnTOVFomGjBl5hFNvKow7kuvUfoPL7Plm1FNBG7y8nQMe9xrBUAtIU95DZ5aIs5mnThD8op4UGqkpY85soMwOPf/2z7YQu/9jFjuRHh0r9htFfPVx5WgNGrLQsIE4zga5TaJz/seTt7FImvpoHmrb94hxe68pXf3L5f2U4RcwGaFYCMP3XJlTc4zRTgr001kjuBZ8lL0dq+o+Ql/0iG5lpWcUb22G3iLvAIElsuOmEVzFF9ncQ/jY3Vr86azyI77+TcKijYMweXiHDZ4YqNJnubV6xX0I+QUIS6tDgiLOLmZk5WbmrsLIUcPncxRclPI8znFFue5ttJkwUbmCkQcpLARhPX7H292A6AenjieEVsxQHQyKtQZ3+4K2FjgsMeG92UmhyTGrRGpumXq+Hr+nqoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5ee569-fd25-489c-77ad-08de20cf2212
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 03:05:13.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5dapkORghqjGWgeZyV+J9U5XDxYd/JzvijUAMHBdNhRyM8ZSnFjBubho2ygs2vh+S2lobbIW6TJpQApIB4bBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A1B8C819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX1d0+jxI4ylZQ
 KjumPn5ruvXjaGdylYhX15xYQH2yZf/MDs0GwgOBrtdfLjeNRKD45uMXuLANBoQ5i9fSPqv8089
 U/AcS3rRE1P0wX2Rm3ocf1dbnro/Xsow/aMkhA/9oxSP2x/fkm9amhZC6JrXQyBxjlMXyU6gchX
 TNLryGGNO4MEc6rcv+dv4QBe0p4BE1LwA3AI9cMrSAorYK17xivUCiIF8mCefReFJkPWnnBdeCo
 fxwyYv2KUYGtp1im6Cv+2Ayx4QJm8trIePvsAak9n0CrcC4dU2G4CNZdxssNd1ybA12AG/ngvt9
 EhZBw2y7HGNhgNwF384jSniQ+13frJL3gA5kBs7tltDOhYglvAvM2wAtfn0cjnLCz0OLpoElr2E
 sO7nWLpaV6DXWMXUCGYaFo4h+Z/R58/RzcoIixBF7BARvPN8Fdo=
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=6912a91a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ejgEnbGrQ65qdgn0WqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: LrM6ioDNOF8ywMlED54ucrkOrOuSkQxo
X-Proofpoint-GUID: LrM6ioDNOF8ywMlED54ucrkOrOuSkQxo

On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 11/11/25 10:39 AM, Shakeel Butt wrote:
> > On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
> > > Hi,
> > > 
> > [...]
> > > > 
> > > > Are you or Qi planning a follow-up that converts spin_lock_irq() to
> > > > spin_lock() in places where they disabled IRQs was just to update vmstat?
> > > 
> > > Perhaps this change could be implemented together in [PATCH 1/4]?
> > > 
> > > Of course, it's also reasonable to make it a separate patch. If we
> > > choose this method, I’m fine with either me or Shakeel doing it.
> > > 
> > 
> > Let's do it separately as I wanted to keep the memcg related changes
> > self-contained.
> 
> OK.

Agreed.

> > Qi, can you please take a stab at that?
> 
> Sure, I will do it.

I'll be more than happy to review that ;)

> > > > Qi's zombie memcg series will depends on that work I guess..
> > > 
> > > Yes, and there are other places that also need to be converted, such as
> > > __folio_migrate_mapping().
> > 
> > I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
> > using the same reasoning we can convert it to use mod_zone_page_state().
> > Where else do you need to do these conversions (other than
> > __folio_migrate_mapping)?
> 
> I mean converting these places to use spin_lock() instead of
> spin_lock_irq().

Just one thing I noticed while looking at __folio_migrate_mapping()...

- xas_lock_irq() -> xas_unlock() -> local_irq_enable()
- swap_cluster_get_and_lock_irq() -> swap_cluster_unlock() -> local_irq_enable()

is wrong because spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.

Not 100% sure if it would be benign or lead to actual bugs that need
to be fixed in -stable kernels.

Cc'ing RT folks again :)

-- 
Cheers,
Harry / Hyeonggon

