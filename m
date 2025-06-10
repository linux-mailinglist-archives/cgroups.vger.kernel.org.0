Return-Path: <cgroups+bounces-8475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BA9AD4422
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 22:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF97A4079
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B4266EF9;
	Tue, 10 Jun 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdoZwCjT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IKuPCdoS"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E39265CAF;
	Tue, 10 Jun 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588753; cv=fail; b=BQnf+pnwLstqVBLBJQ5rwODYaBcMPtmgNvK6ASD7AXsgbdyIWfya5JMfgriOv96SC7odDkhmwDr1N66LXw8C4ETGwTdf3xdO4J/kB7z7njLLGezeekyVH7EcEHUBxdgRDKRxILJapA4+MKRL0G9faT/A1H76tbXiJq8Z4hX1AL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588753; c=relaxed/simple;
	bh=1Rl+arInDEI78IWRAGCKhvrg9QLQrE4L53L6kbN1okY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G+nO5eIHsLR62jC7xO6tmCmhusMk6lLoYzsQ1LFOe7eAO80U9kLgYnP1JT4bZYxS+wsFsTJtIxeEtEx/UENhu1415ccjZcNTqkre5ALlDev/dXBYCZk6/6X7iCmIjty4hgiJPJmwMxt6UuXBmw+EiAgrAa0Co1fCvOXCSONs7qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hdoZwCjT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IKuPCdoS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK6klO020157;
	Tue, 10 Jun 2025 20:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ncwWyqhPw/gpkYcNoe
	4uHfcH5zj0b5Ow1zSqJJUc65M=; b=hdoZwCjT3XcLNZMKvXV088YYylwI36Q1af
	l10zOdlRdWF+tsEY7VhWNc1y0/5AfJy0tcb+Z2pI7kLPYTFt6RPCU6OcKBCgDuOa
	HMUGA9ROx4qCe36si3AyYqIXmU2eNIF6PikW6+3SNYoQ3R8w9jVmuu8HieKFcYsn
	80CVmGWQ0aR15P9Plkx1AKJkcthO9BbaYhpaMdQoy3wgX6I5JcXUGGstNRwANy58
	xQDF+Tr+aLNQ1yluKXsJactLlxvN3HIg9wlYml2d0OKDUtOtA2iXTt0UTrYBEHfv
	X166ZVOWyMsGX5YD0Qgl2aNVRroZWvwYICKrHIacr1IkFZBLc72g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyww2gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:52:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AJpRmo003281;
	Tue, 10 Jun 2025 20:52:06 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv98yr6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:52:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZdo0EonduxrkmaTrJ9Tlx3gr6a8gVnF4tViocj2Jes/EauG023b5MJsCLAkuCwxw8OUY0xit5TnqLXKTvBoeRabLeRO+PCJPWg+n2p0FI8N+ghs7e/wuyhWualSv0O2oGfmJU2yNvS00SZlwSPf5KNeSQ2KFg/El9Tob4eyQ/o60vHMUK51dAyqOLZ/IBtbnG59jbOZhv28DH8wZq39dtBkwCwg/FpEaY84q3emzyhxAex5kHvF7sGByv70fz91+HvOxSETcpmg7cehDmERlCuonovr2S9ovWnPp7SXVaglJzS0M4udHerFIypZc4+HPpBADWW1ZYwYdF0oLetmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncwWyqhPw/gpkYcNoe4uHfcH5zj0b5Ow1zSqJJUc65M=;
 b=x05A+oDvkoNyNdzDKlI5LIcn9t3/QL0IEJmUgM01biPJ8rN6i8uPxYczl+Q56On5VWT6e27qsh2d0CBfGanbSScMraIIIMpxfqlq6yinM4A9FnXwPtZCJ2z1suc2nEjOjQtJsLKRY3fGDt/T06FxHI6FZ+3kd2duvA2BRRGJmKJkuDcuZqz0WBDpTei00fD+5IHut2DLceSRCwWlIm7GScD3DNY0O+3vKAO40DD5o0S442JapVrlEbaPu7pTyg1Y7iWTlVleMdM+ZeGjPiM4mG/X0nhxje8R8o0MWq8SuXJqgUu4oQkgeMXHYPHYRV4rczftPfB7Qndu6B/JnxZo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncwWyqhPw/gpkYcNoe4uHfcH5zj0b5Ow1zSqJJUc65M=;
 b=IKuPCdoSrecP7EdC6J2KM9aOLwAdGHU73d6B3TtpdFGnF9xwwTGeO+PUGWgjGe48A+WdLaDf2PkJkJSOs1xImKRHgog+hJYvyjshpdDAqCyuqgkWvuoh2Ya+vEfZh8NVIc5HtF1xsproL+a1YTpcW0tI5Fm2ZpMypvSdrlF0uo8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 10 Jun
 2025 20:52:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:52:03 +0000
Date: Tue, 10 Jun 2025 16:51:45 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, andrew@lunn.ch,
        guro@fb.com, tj@kernel.org, kernel-team@fb.com, surenb@google.com,
        peterz@infradead.org, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <aEia4cEFb0n9S_jj@char.us.oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610191144.422161-2-konrad.wilk@oracle.com>
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad21c5a-a3bb-4246-bf9b-08dda860a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOy0KBInNuVIWBO3IsWjzqrTP3wwZb2qpuQsavZIIemOdr/CzFVNQdmVm8uf?=
 =?us-ascii?Q?1JM5GFDPyj66qEUFQpIT1doQ6jHkRBvJwFtp8S7pj/ULYS9B2rEHstIDbIC6?=
 =?us-ascii?Q?Tty5/yMLIoUl8k3DcYv5VFb17Ph6p/iJEzTWmh4wz67K1oUpmEG749sJtp32?=
 =?us-ascii?Q?ubYVxBooh48R3CIZE1gqQMcS5Q+w4X4f0kcXkRxIqn1siyRhPN6vUZH8w6sI?=
 =?us-ascii?Q?tWNBUlqCx7aPCYv7RAia4tLfvO1k6AW7PBXx+vpXPVPzxKbdokWIoVm5TTw5?=
 =?us-ascii?Q?rxP/8Dqu+Q/95xdzg5HdoVcoPo/u/acryVpeinFO37pn1AdPcais4QtR1Fv+?=
 =?us-ascii?Q?G3qPYQ7Dnow8ScmMMr66uw3/2i5pB6xZ+b7aL04LODgNmb9K+3rTHf4WNdKh?=
 =?us-ascii?Q?RAiTkAQ18H8c3IMrFj9VX3XA2GAeDKg7iadq/5KUfUztRNDNiqF+firCTDhD?=
 =?us-ascii?Q?MQ8kWbIH7JntqhONlQWq/E/yKOKT8pTwPnAdlpRCGo4ODrRa9knnm2/+vbw+?=
 =?us-ascii?Q?bIfPLJYTUiW80XGiavu95Goz7zH36GQkhU8mv/mzWKowzFJkvM/+piA9imXl?=
 =?us-ascii?Q?Q/b5AqwlDB01RL7wc2NMGi6MSu3HA8uOQeiShsX64XBvjIebg2nWfzr03T3F?=
 =?us-ascii?Q?mlurP4VKmlgUQAxqKE1VuwWSQG1+oWA0LWXMGmZQYnV7B89SJatGBuW6v4Qr?=
 =?us-ascii?Q?JZF91LdX0uoNjVtxTYdIDWUpHAfM6VlIvRrD/vzGdnMUVNdSqhiVyMG2XnqV?=
 =?us-ascii?Q?sKdg1vzSCz1TDCaECcCE9TA5ZTw0g79qnZfLaXw1fe9GPms0FtQa+gpoogdI?=
 =?us-ascii?Q?iPRXpLSP/1SEEh5rOyFPpEg73xlSVm5CdrHU4UWtkk8Aao1upbM3wVnxkoJt?=
 =?us-ascii?Q?zKbz9jEynO42Zm/oU15q2ENT+qvw2Sijl2w4CyzrfuP1shDBhGrzhLhYqFez?=
 =?us-ascii?Q?msML9L05MD/Q0lnlXtdEZJfPuN1Fxz8C3w7sNys+2qUL2Q4g73epMVY6AcmA?=
 =?us-ascii?Q?U2o9ghLodCON31BHfEylH/4u1lVSsP7aQrLSuNG1A3vHuFjaBap0mbtX3IBq?=
 =?us-ascii?Q?GGDCs8Z+6KFoiFMlgy+1kocL8Veq5owpzUhtxIY6IYlW8sxTZMgRn8GriaY6?=
 =?us-ascii?Q?wwZRhJ3nrIAEU+XqArIutfQOEzyl+YQJt/aXGd5gOEiVzJtmv8L66BZhKDcx?=
 =?us-ascii?Q?zEdqVnbcm0Tom/mqjiWFJUa6zEa81jWVwFBfSrRZk76ZmgkeRTNYPKoZYM9B?=
 =?us-ascii?Q?ViqPb3mPpb9qzRlFrDFZLZuYLlIhgvR5aLqXfKdd64fBLMvd6AMIkz94JIpm?=
 =?us-ascii?Q?lWTQf3hSrHEL5BL9TdHhy54c3oTNbTa2T5B2jHgHBJBiL4lyJ9pMALLh8hyg?=
 =?us-ascii?Q?vZAynnPz8FdUjJBLWB1wxQUJrH2T97UxCV7Jrm0zb1KFHXOz1R2OMKJGw8Hl?=
 =?us-ascii?Q?yZOWLJt3AFUI2OSGFgTkc+k4Z6fRqS+wegx99SbBTcObIusMb5mzBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BVS9zLTMrY00IpKNnknDsVys+KbYmKIlEAt3Zn/wxoqUKLNwGBn8K/XgzniP?=
 =?us-ascii?Q?BbX4abHF4ZWDiE3reE6WyuC/STCx6Kw40x3qJtLqPpdbXRZTVu0W0j+/I6qD?=
 =?us-ascii?Q?lJ+McyvTwGJjuL5pm9rXwvVyflNIsWOQ0Axd2utPrqqui8esguLlNxMyQfcz?=
 =?us-ascii?Q?eXucvregSSPlVMtta35YTvi49HvxfPf1qX7dAiHy9FIBdM0FJdFjiByTw2a7?=
 =?us-ascii?Q?w3S2N46p7DNXyPXlS89yjx4djmKf7xt0rrK0wqdJgmz/5PSgcklClqR5rySz?=
 =?us-ascii?Q?pD5VVYWK8KJcBJ5+YKBywwDM8PgJ4q30b1JUYZBbuOF6aa3cFZu1tDInfh3A?=
 =?us-ascii?Q?i6HonRN1bbp4zdrdm1zLPHbkXAYWU5OLIrPouqhv+QkgiS8S6UEeNUSIjhqR?=
 =?us-ascii?Q?5L+7N/rlhdcW+WdPY10Db/9EUYFDT7gn0oFTF9Srv5iGCJw4tdGXG0VcUKcv?=
 =?us-ascii?Q?tlqUXUsHkuEFirzSQvFnmlsMjHr3JQCPGT9fjjJ1r5DHGARekBfCKcxYriAW?=
 =?us-ascii?Q?sFKM7Gu2xrt60szfJMsA3La2byT+9DwpP8qZ9qVZDxbYz6G9o9VwzBbxCHb+?=
 =?us-ascii?Q?SMyQ0YUnPbsqgMgAXN03gJ4lxs6SXwPNGIYHrKBvgi5arDMcg5gem7/YwEbd?=
 =?us-ascii?Q?v7K6xpmEPV3f/Z43g9aMmcvV7tSX2Hl/xwotT7/Q3OL8x40YM+3lDge89Pfy?=
 =?us-ascii?Q?0/bIQR0E1OvcvWldhNM2Kvi1tYfXwgUc3+9T8qMOg+6oecFv0hIthtgPqUYr?=
 =?us-ascii?Q?O8Yxt4ut8r6KwPw6xvNmyK55vQF7wTbKVtk7Anc6fUs7Ka0GCUbrxw2ZzhdW?=
 =?us-ascii?Q?u3H1WtTXOLBkrXbsHTfzJVAIqWfvwQI02oJVq+1OxaEYaFDf9DtUHCuS/j6l?=
 =?us-ascii?Q?zRi/mN+iJ8fsryZU9Iip9NX7cZS2iWh5DPB1Gdy+XKfYKsYtLYduCesVkA1G?=
 =?us-ascii?Q?HThLB3M8Wwkb1WGgQ1urBr1/ptw4TvD3mKgHz2MP1oTKWwCCgECrwLbHY5o/?=
 =?us-ascii?Q?gwGxualRlOCG+3Bjr417oGjT6zPRroqsubQbRJs64nl/9OguLHIBDAjquMNt?=
 =?us-ascii?Q?R0MmGf3RoJXQyTF/LnY2x12WeAwx/ajvAFl9L09VJYqor8GTgf676PGANMBy?=
 =?us-ascii?Q?6EfoIeGhBDnb8qvITNPITjdbyM/AwDWRLn8qtpFt29R/tkqNZTvZIiJoYBBn?=
 =?us-ascii?Q?KMBcPguQeRn5pW52HLRSrsqSrZNwtsnzhG+iw2zQlqWru8lepyTACYNtYgAo?=
 =?us-ascii?Q?bUOsTI9zMemfMxFXhjXv8LYZyuvQ5ks+t7S+/taUwZBA2xiUwDNdiBCDMyPI?=
 =?us-ascii?Q?knQoMMaTmzLa0D2cNoOQsP+QSxqoZfG8Mte4mt6ok4y82jfyYsuzbaP1RDDh?=
 =?us-ascii?Q?jGzudwAzyrh5qGuMd9jS0Fftthql3PQu3rYKs1QYPBZZGuzwRKXbOC0IEgVr?=
 =?us-ascii?Q?a47hR1aCw+E9OXAf4QLm9ZjloFTGqXpPdfzUT55M9PNM09oyWkeQtdzezaYP?=
 =?us-ascii?Q?Z093Adm5iK67YtDXG3gtVD6XUvNei26dOGdoUvsl/WZ1GvUoUM+S/EEsz3IU?=
 =?us-ascii?Q?wxHeBSlEaHXeTnuBZ/UT6wWcLkG5MmYLBlUdYCSeNqhVH8vd0/yxSoV8rsnr?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F7vZRLB/PpNj/yv147k1Qn8JG+xYkSMp1qqt5OLrNQ5gW12QcS0Co0LWXjhfplovth0aOxMSjlScDMpmXYPEiIlmw3FJHItRvkE5Xun5IjyuQB33jZ7H74ojyG+H9H4M+m9Mwek2/VqAx66DzkOXGXP/lyFh3Bh2vW97w+pr0LYq5QIbvV5J8x0fiIYgtRBl1HmlqowPrZybp9i74F98X6URJc5HC6PIer+68oPd1dlrXNlBsakj1wDGSjW2Lws1IgZ5FZEaC+qFJbfF62wyY3U50oCTwn5qQ6UCXGb8KjBPbfsBFQMXzfnviwsQ3pyQt2j4QzRjHXyKFc+m6S9/M0qGV60SJjn+eMDwsgB6/wEIAc9POZJxcWrEV7ew7ACVk5939P2dIJBkRjmL4Pg41hixKyVbCLOfqBCbkU5V6IQLaa0ksvQ6D8XPR36AO7p5Ro1Lf1l/xn1CHlYY4G6n3X4227w/rlT/kmC98rZpvZsOO84xrNaF/JRjLMOXFiqWTUsLRgqOYjg4zSBPwY/xYjhJ3jRmXyOmv93LYlyDg6Elws+8PzmwJYW2ePX3E3L3YEkRv/5ezoDUBF+hWqn4ZTDXvj4VnMY/BjxSZXh903w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad21c5a-a3bb-4246-bf9b-08dda860a6f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:52:03.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2+uK0HIGtnQ33HiOePpMl48Gq/tlS4BtEQmYuHNyWomwGuSn+xLaUhvWRSCnw2TnnJstl/h8K1ipuJ0N8D64g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100170
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=68489af7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lUBi2n9ZklZlEZZudfAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: JNZG-98D1jMUs_rnnnu602WUfAnW62MJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3MCBTYWx0ZWRfX1OlLco/Wd+2c oMrkfx21BxU9OqOGBvie+b2jHDB2xz2z+JSrSuP1fs9+bdvM32YC+BcHJnRZ/ZKtzNac/uEkJiQ Qtpp6FHtb/Kx5V4xFvkIk26UOSYDtG6CUOmtDk09/JSeCJrd6Kb4jQ/QeazNqPVCHPYY7vWNDoV
 EdRq3vTIHG7er7qcFfPPChLrJiKhfxsyZYJ21cETB6otb+6/8RHxf+5y6NL5O/GirjKNjgZXGaV j8hU21zHg7TXh1vRVSvLzDaQe7PVkF8qI9ho3YW9i+0f9e4Wemz6fkoLWdBvV1ehwhhYyUgh6A/ /dMvnP8EpoRkfkxRrneCommIAR5/KumA7zPon+Nsrl5IDNoOJmR+Bzc+/k0BMovS8kTXImVTa1Z
 lDjftKi2MVMtPgAsM+gXfKaDC+G2E7iDu7coblanBNPjORTo0mbGb1XXyi8VvZK8fd+Egpwn
X-Proofpoint-GUID: JNZG-98D1jMUs_rnnnu602WUfAnW62MJ

On Tue, Jun 10, 2025 at 12:27:25PM -0400, Konrad Rzeszutek Wilk wrote:

Hi!
I've added some extra folks on the To: list to solicit feedback on this
idea since something similar was done via

3958e2d0c34e1 cgroup: make per-cgroup pressure stall tracking configurable
01ee6cfb1483f cgroup: export list of delegatable control files using sysfs
5f2e673405b74 cgroup: export list of cgroups v2 features using sysfs

Thank you for you time!
> We would like to have a programatic way for applications
> to query which of the features defined in include/uapi/linux/rds.h
> are actually implemented by the kernel.
> 
> The problem is that applications can be built against newer
> kernel (or older) and they may have the feature implemented or not.
> 
> The lack of a certain feature would signify that the kernel
> does not support it. The presence of it signifies the existence
> of it.
> 
> This would provide the application to query the sysfs and figure
> out what is supported (and which ones are deprecated) and also
> what ioctl number to use for the specific feature (albeit that
> is already in include/uapi/linux/rds.h but this is an extra
> check if someone messed up).
> 
> This patch would expose these extra sysfs values:
> 
> /sys/module/rds/parameters/rds_ioctl_get_tos: 35297
> /sys/module/rds/parameters/rds_ioctl_set_tos: 35296
> /sys/module/rds/parameters/rds_socket_cancel_sent_to: 1
> /sys/module/rds/parameters/rds_socket_cong_monitor: 6
> /sys/module/rds/parameters/rds_socket_free_mr: 3
> /sys/module/rds/parameters/rds_socket_get_mr: 2
> /sys/module/rds/parameters/rds_socket_get_mr_for_dest: 7
> /sys/module/rds/parameters/rds_socket_recverr: 5
> /sys/module/rds/parameters/rds_socket_so_rxpath_latency: 9
> /sys/module/rds/parameters/rds_socket_so_transport: 8
> /sys/module/rds/parameters/rds_so_transport_ib: 0
> /sys/module/rds/parameters/rds_so_transport_tcp: 2
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-driver-rds | 92 +++++++++++++++++++++++
>  net/rds/af_rds.c                          | 33 ++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-driver-rds
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-rds b/Documentation/ABI/stable/sysfs-driver-rds
> new file mode 100644
> index 000000000000..dcb1a335c5d6
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-rds
> @@ -0,0 +1,92 @@
> +What:		/sys/module/rds/parameters/rds_ioctl_set_tos
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to set on a socket
> +		the Quality of Service.
> +
> +		The returned value is the socket ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_ioctl_get_tos
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to get on a socket
> +		the Quality of Service.
> +
> +		The returned value is the socket ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_cancel_sent_to
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to cancel all pending
> +		messages to a given destination.
> +
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_get_mr
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to retrieve the memory
> +		ranges for the RDMA calls to setsockopt.
> +
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_free_mr
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to release the memory
> +		ranges for the RDMA calls to setsockopt.
> +
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_recverr
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to send RDMA notifications
> +		for any RDMA operation that fails.
> +
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_cong_monitor
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports mechanism to provide Congestion updates via
> +		RDS_CMSG_CONG_UPDATE control messages.
> +
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_get_mr_for_dest
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_so_transport
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_socket_so_rxpath_latency
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The returned value is the ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_so_transport_ib
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The returned value for the IB transport ioctl number and this is read-only.
> +
> +What:		/sys/module/rds/parameters/rds_so_transport_tcp
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The returned value is the TCP transport number and this is read-only.
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 8435a20968ef..15c8ded02dfb 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -31,6 +31,7 @@
>   *
>   */
>  #include <linux/module.h>
> +#include <linux/elfnote.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/gfp.h>
> @@ -960,3 +961,35 @@ MODULE_DESCRIPTION("RDS: Reliable Datagram Sockets"
>  MODULE_VERSION(DRV_VERSION);
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_ALIAS_NETPROTO(PF_RDS);
> +
> +#define RDS_IOCTL(feature, val) ELFNOTE64("rds.ioctl_" #feature, 0, val); \
> +				unsigned int rds_ioctl_##feature = val; \
> +				module_param(rds_ioctl_##feature, int, 0444)
> +
> +#define RDS_SOCKET(feature, val) ELFNOTE64("rds.socket_" #feature, 0, val); \
> +				unsigned int rds_socket_##feature = val; \
> +				module_param(rds_socket_##feature, int, 0444)
> +
> +#define RDS_SO_TRANSPORT(feature, val) ELFNOTE64("rds.so_transport_" #feature, 0, val); \
> +				unsigned int rds_so_transport_##feature = val; \
> +				module_param(rds_so_transport_##feature, int, 0444)
> +
> +/* The values used here correspond to include/uapi/linux/rds.h values */
> +
> +RDS_IOCTL(set_tos, SIOCRDSSETTOS);
> +RDS_IOCTL(get_tos, SIOCRDSGETTOS);
> +
> +/* Advertise setsocket/getsocket options. */
> +
> +RDS_SOCKET(cancel_sent_to, RDS_CANCEL_SENT_TO);
> +RDS_SOCKET(get_mr, RDS_GET_MR);
> +RDS_SOCKET(free_mr, RDS_FREE_MR);
> +RDS_SOCKET(recverr, RDS_RECVERR);
> +RDS_SOCKET(cong_monitor, RDS_CONG_MONITOR);
> +RDS_SOCKET(get_mr_for_dest, RDS_GET_MR_FOR_DEST);
> +RDS_SOCKET(so_transport, SO_RDS_TRANSPORT);
> +RDS_SOCKET(so_rxpath_latency, SO_RDS_MSG_RXPATH_LATENCY);
> +
> +/* The transport mechanisms. */
> +RDS_SO_TRANSPORT(ib, RDS_TRANS_IB);
> +RDS_SO_TRANSPORT(tcp, RDS_TRANS_TCP);
> -- 
> 2.43.5
> 

