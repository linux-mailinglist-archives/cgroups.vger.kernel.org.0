Return-Path: <cgroups+bounces-11661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147BC3E7CF
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 06:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EC9188B1DA
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38724DCE2;
	Fri,  7 Nov 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+/h4aUl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SV/ku+uk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A51DA60D;
	Fri,  7 Nov 2025 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492358; cv=fail; b=Ph6NZfiiFEBh/iACKxo8MbFLdJLLBqJoaklXHavqBqB+kEvEE3AgGViiqZSmm7mkuT+bJV9lSBkFt6diJdvClqcv1Qi1mcomMr6a/MkTouDmIR1XX+Mj6XyGHqH7oemXBvmVDu35wBHlXbAgT/20qPnd8WGmoXQUjitMDNZDxFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492358; c=relaxed/simple;
	bh=hXptG2lqgjSJiMrOx99S92W6IlwKCVETUU8IhJkvEmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADufV5oy2Vapp4lb34BqXBb3Fezc2O8vXZ8kcjXUmOUJ/mTGrjXKrh+/kK014tkEZYEFRhx7BX8l1gHuYgsAbJPAr1anudTEph0tHv4QuVOS04n4inbAj30JQhOWWpNY1rjDPsW0qkkiqlhA8jcloqKG3JwBdFZRaZj+YI433sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+/h4aUl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SV/ku+uk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6LNPkI022894;
	Fri, 7 Nov 2025 05:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vqfb99NW/wJM4nSeT3
	MHpdXcQySjsge9QpzrD22kWB4=; b=J+/h4aUlG8bJ3W57c5pK8ydFBxI3JJvp60
	OZOXPIlUiYYWXEY5R83uueEWg7ODhC3hOmEXKASPu4hBFqnQz5IXR/gMcqiLUvNm
	M2YIGQtlLnx9TvIYfVoy/GpylL7vmkX15qe47LT322V0hyZvtjcej3vrycDdR5qx
	YbZ6eSuRlAhHakVTgKgjWwBHw+G8a3EsogpSITxuRYsnJS/oTakm1TsMkhwcsm26
	3+9FVONx0XyPR84lmYS0Q877brYo8A4l1h5F8xURxtBvlZz2DmMvIWuh1KvFu8Mp
	1s1fUlSbs2QgCEILbdkYjXEDEjSRvM8ds5xmS/cLCmvHnwIL2nFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a904b113t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 05:11:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A73bdAC002768;
	Fri, 7 Nov 2025 05:11:44 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngwdm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 05:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NekJR1Pt7B+JVA4qCu9awgMy+0czIqlqCjSyhYBfAp/8CqdirOTWwE7fTa8bPkaJ3j6pbtgrY+0g0Z9OY98m0KwBfJvaUAgnu6RRXYw9UUP0sV6ue1pGWWz9+rtzH/mozZiuk3Ew8RRWJe1ujWbEyB4iaWBatFeCBgD+30sEWvMESr6QnvQG1BjPz99ynZukbOSp7r1F50vMcG2uySUPxNl/hXoHYjcooVxo7fpBOZxufT0QpMlanf9S0ZY4OQEaeklUuQB5Vo5/wf9yGKalXM/Nc2L3K/i4WzckjroaghwWf+tIvxbSWruq7D0xxvWE1jTb2k889y57E0sTX1LcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqfb99NW/wJM4nSeT3MHpdXcQySjsge9QpzrD22kWB4=;
 b=qxpXzJyqn+k9WwLMSDAOPPEGsniAKmz6heFbtWdrERumdlQO4Mk7wzwIhj2/ewxFZRZbtIEMbo8uA8bxpRjuaJIRfIYFFlvu2mMbjumXkZLCnqRLj76IC+rKYJSVmk5LUMkAvwnEcROs5ee4ye867lNUBzkFDjNkopRxqBjig/tu2wjcU4xeAfkSss1KZfgLM16gtnhjzG2J9yNrBH3HEvrv8yG28p20WQ8jH8M4CDoyuSKs5hLuI1gT5hRFS+dF0zXrQHODHtJAuzxnAnvi+bTDCpG4GeJt0VjasLXY3MaX1Hq+qplQeIMPWge/bgOHewcjH8QUPC5FuoWL3vDgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqfb99NW/wJM4nSeT3MHpdXcQySjsge9QpzrD22kWB4=;
 b=SV/ku+ukealVC2/NxGgvy4TzXvYs0C1ScqzHhDfAFPbLpK74M2450Y8qSnjfTrF63C8nAe3xYpsSduGxiTyQ9KX+YDr0UoIBhABDFS/7YJPd6dLGvHbRO8CnyAEHkuzdxSXU+fN+2c3El/8VyfzftgRkkcvh5awsEOwGp2sfjKE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPF9C7B9A88F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:11:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 05:11:41 +0000
Date: Fri, 7 Nov 2025 14:11:27 +0900
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aQ1_f_6KPRZknUGS@harry>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0137.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPF9C7B9A88F:EE_
X-MS-Office365-Filtering-Correlation-Id: 48818fe9-6906-4f33-9f09-08de1dbc22d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jzUumjnw36gEYxVUmpLWSccnufrCmWkoJ+T091aSySmveuPu3jVJlkrQublH?=
 =?us-ascii?Q?9kPzIrLBo02pnyBQdpdh9Cv7jbW/7hN8L0+s37lUUodLX8xojt1UwG9e3kT7?=
 =?us-ascii?Q?T+ZCdjPhPIXjT/QKuCn7ckpJjVYcSaaQdANv2YnXmh0Fu23NplyTGXK6/gN6?=
 =?us-ascii?Q?ky4zSa2f3hpb0yujz1zAeg+absNH+f99uQQnHiJjyEYcV5gCVYDaCL1CDOQY?=
 =?us-ascii?Q?OBQhKmZsRSmjBQErQo0cwHFJeIPImjH4SOrvDPmfPYCbWAjdHRA1n8JV8Mxq?=
 =?us-ascii?Q?7z+xr894f9+QJBGCx4y+f8Dx5biNqDPkSyqwkSTlcebhTiLtQgGn0ufAOyXD?=
 =?us-ascii?Q?cb+ijFJMyBS6nqbwJygfSBk9MIwmL8KAL879r0Yth3jAWEHTa/Ec5XY1vQPn?=
 =?us-ascii?Q?NRET27LPjuAp5coPxsRJ1sUPBE95bZsxBy7km2iz2q4zUUz2bE478XhootF/?=
 =?us-ascii?Q?pzAu9L9Z9JQiQfTDRuWNQE3vxHLaAb9r9rNJ3NP/Dr90cK0XkTRrwGzTFs76?=
 =?us-ascii?Q?46YLQobSBsimBYVlZt7PaPIFg2iiPa6F8yahIx/NmzY3kTtTGR9uW4PTNeVu?=
 =?us-ascii?Q?sCVT9vrzSiumRCtQA+sxdz/xnXqRJKlNzeSafaAYiMUew0I7jcy24JshEMRJ?=
 =?us-ascii?Q?f9MNvTX6oRrrmCjEBunMkEEmF2Th4EYG7WJg2tmqCuaPwH8vJLEFVgxVEN2q?=
 =?us-ascii?Q?VM/VLjPAqLknInqCoDZWhEZTZdjTLiKb6pbr+/PDpHOOWDEMh1t7ytedzC1v?=
 =?us-ascii?Q?ouNNObBrKUWk6FbfITvwUlIsT5IwzwlBLXN5UGmsQfsShD1bvWyI9WXN3116?=
 =?us-ascii?Q?r0rmQf4it1YTO9YOrtWA1JPYg3b7FFR0DQExcVDzQm9D3hDkmuZ8+zDKpRKB?=
 =?us-ascii?Q?k8OVzCqsVWqaHsNWwzImcQmogxrlmxWS2QUHLFHrWC7G6RrE4n/ZgpFfCDEU?=
 =?us-ascii?Q?c1hLSVxzZOmdYWY8JLxn8YxQZVQDZaVGUVSwvmoBTbkpcf2rDU1QGG/jSmz9?=
 =?us-ascii?Q?yRraSYmOF9wb2lEf+sA7TpUX3UIjDXrdzxFOZgsJUb6iqlEcz3o97ciGR/mm?=
 =?us-ascii?Q?MEKzJn+4sq8rwIspSVC347LAmGtlcy3IOdWzJsP4qizxPO7uTovqllEt4+Yz?=
 =?us-ascii?Q?zQFrUDZYiHT2jOP/M54jvPcGlrUvVz9Nv2ogknFt6YPA3zNdD+PxjTpp0oHx?=
 =?us-ascii?Q?1aRiDHnXES7wa+pjQ071gzjCA2i3n2fcDdZlP25WpvZ8rXn8QsC82lVWw+9d?=
 =?us-ascii?Q?zYC7GeFaTNOUsaryhjSF9Jnm7xxKUyFslrEtrL5FUDd06J9aulTtW20qebq7?=
 =?us-ascii?Q?jkLBgk/Rtc/AnNU155I/B54nC8Os/6EYHUZb/aoGpM7yyhX3bQ9sfs2U9LMk?=
 =?us-ascii?Q?m/SrggDExwBWx2tlXcJVMAfjBXhdkVBQ75/TJZKk+7828sHBiXsYvJwcyb1Z?=
 =?us-ascii?Q?PPZY8S1JwzFm5VVCjw/XwsakhXfZYhWO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2kClJ7K7eWpzG96RkamfAFc091+tzTmbdxZVeNnROQptdDH40WWdSbjpI04?=
 =?us-ascii?Q?wkilbphBRBiJbrFfgLv8BVBoTUtW4vf3VZntacM4NGP3d5fg9vKbtRbEa6pg?=
 =?us-ascii?Q?eA9Sm9TZxSwkDxkWNri5GAEMivWKHcDOXVQU7g95ZjI4A+SaA9LBVRxOkM5Q?=
 =?us-ascii?Q?mu6kaD5/7MxyHkgF2o5opL/5soJZyLNNgP6CojpL9mmT8uVXH1VKR6GpODmr?=
 =?us-ascii?Q?yWfTNUHeIUCoMnM/H9SEYabeqLzdiG9UEM0QBuXdZ3z1qsAdwt7kjvf+XhCP?=
 =?us-ascii?Q?gsqAd6UEmWtUXTjDP/ZwQqGHscJTTZKWLdkVshysc/6h5j+Ml0KZdrjKtgkU?=
 =?us-ascii?Q?9kWUnxCB61zO9Avj/N8AfO8L7Q3GJot411q45bG7/mBdg2u5iQyRLA4MtGXZ?=
 =?us-ascii?Q?kAZayxcSGvdAsq2XUPVYO5Z6gyHS0+la0XeEVPndzAogrf5+bKoQ4BzYplOk?=
 =?us-ascii?Q?BSbbbbEFAsCjih1QCwTO1UWTtfSRm4VwzqytMwcCLrLPRXETy5NcYjTj65qJ?=
 =?us-ascii?Q?zNyxHWSxu9mg5nXSav/9KqmLcfe+OuIG+m1u+LbWFmjq8fDoo4EkfU/bKE85?=
 =?us-ascii?Q?ooa3lvnARX95iNsu2rKN9+AhxRuh1309yRLQgHrh35wSUlV7zXT88I2p9uXQ?=
 =?us-ascii?Q?vPCzpRuBy2tWmgS7cp0xONv9XhYiQbMMNRMd2VYdxGV51d8JmynmEeMouY6i?=
 =?us-ascii?Q?Q/QA2FZ1HU1V9edF318HF/tzYE8em5fprwLvK/lr4mNSEtV1u4tJvEiVPZ0/?=
 =?us-ascii?Q?ekORz5RBLKREBrjMvYQHKnVxV6yJZHn4W6CCU/kHmG/ADpnKkkLUdhQmuqLe?=
 =?us-ascii?Q?dTUz2us/yZPDCYGJQGn/tMaMsV6abjPU+LXUhhKzQlZj5T8GVxgf3Mra2NJJ?=
 =?us-ascii?Q?54Zaynvw463Pktt94IofFlqV+VEQ5mP/w+61TeU9TJZVZPaL5Ku62A4BDY32?=
 =?us-ascii?Q?2Ry85DNziB48xksOSiK2F+5UVA+2U3YA2EtNKJgEOsYLR1kDj5jBEjFB8PFf?=
 =?us-ascii?Q?1Sw4NM3+l3WELyeiskysd7qVx4l+4yTw29VF5JFaIS/b6Wl9t3H5y0iglJtM?=
 =?us-ascii?Q?s+wFA6CS9aYeggC94MGo106f91/QIemEAJpX6uuX9KXjnaX6QGVpKhNjsFXi?=
 =?us-ascii?Q?VLYv7EJxgGIPP3GseCkOh8drCaY4WiRB4loKYVB/SkgcHQ+1258lrQ9NeWql?=
 =?us-ascii?Q?l4GVKzeYWW7T5ELeyHj2yXfnprHZr93gTYmKsCC+i53HAwwTZvbpmL7Uv6F3?=
 =?us-ascii?Q?Tn+eJ6PojKrWOB/scuG/bJmpX76C7DSnVo1bcYV7m+9XhmbiNBnUsvlL2utq?=
 =?us-ascii?Q?YbsIAWemrEzm5Lvh6SPrXGUWHEFkhGOMHnJHaweXDXK0a19mYQgMciJBLsAa?=
 =?us-ascii?Q?/gR3FuBSm3I+1fnz4Az4HMr+YYUeA8Mq95GNhtDrcldOwB5dbQIZezGf7tSg?=
 =?us-ascii?Q?V5bhut5CXuWJSDeEDt7x+dHDJWZrCwkgRj67TopG73iZrqqI+tMBo/8It3iO?=
 =?us-ascii?Q?XXe73ZjHgfU0LsFrlmi3UbcwH7lW0lxi700+bdIVF5L3XE2f9z7V8PgwkOyb?=
 =?us-ascii?Q?8P4mIqWhXH7+mi/ce8O8IkV2lJUc7SYL5VNgNYoJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2+dZsYhxneRMQ3sQ6kgVyoITqY755WF74rT3Zuo5HLGMUHrEA5DjrkzD4cRsnjyRSgSqiYqX8GBUh4wpbRVYAkv2guxf3NCOM3xcngqopAn10XV5OHoeEKhAoSjMaLgNJ7Bm9scPnHYglgPc7umKzFvTq8Z94T58xC+8At+0gnalXP3tlrEZ1GlyYUwo/Cd0TcKO4Q6bfXaVwe8NdKlGrz6wiSBwBnDqLv+UbAZ/dVU/FfEJmszC2xwQGO/5oHSsksKDoiOfXYSxC6Eg9v1Jg9zeK57LJfxDpTHmYz2GFzq6gEb+ktFD38jDZjF8EsiwcWddNl5GB4Xj2PBdS/l4xABBsEbRKdVAjMM9XCth89IXXyFnHa8n49rEz3FYY5ePs4g+O+Y+CIB/8R/TVhiM2ts2/iZYfUAtu+A4SghzVlooMT7oZRjuFvJaDviZAk7fXNksRyCuncEkOkHdi+e591W8PzuanRbvAK9ksCTpK0ZAusAecIuGtXW6ksK/pJwCeLJmT8Nu6kGXOxWeO9468QVYNlJR8BZl35E790maZuNTm6JwuDiwV5rsqmWKmR/+s9J0Yu08kS0ZXpjkdhbcTnroE2ddQSB4tFRC9BS5aaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48818fe9-6906-4f33-9f09-08de1dbc22d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:11:41.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntfLv0/abphDDMZvk3Ziz+vkN7fjpn1dFtNvbutUr9ZdqoPMRtZFCj526GHmFcKIQidi6i8q+zjvw4JScf7Grg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9C7B9A88F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070038
X-Authority-Analysis: v=2.4 cv=DPSCIiNb c=1 sm=1 tr=0 ts=690d7f92 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=GR1G222VVbtVZ3J6RgwA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:13634
X-Proofpoint-GUID: 9IrsW11cO0R0KG9XcrT7kC-Sne0yUrwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE0MSBTYWx0ZWRfXwjZ8y1YQwPnR
 s87gpL1uF1YwycQ9KeC+pJn+y49T4BNBE/Fp0gRSTc485kjrcn2zaYbhRFWoK4MOYebZsTfuCeB
 kG0Tri30ipkTubGNg3DuBqeBhxA88DgMKcgCqp92G7SiZ7I9Sqd8yPjQyZCJ3d9tft8DFCnzK24
 KZ4dNgGB9alJcDW8mIllXOIhaG74vxzkwFWQOLJk41FWJVRkB8wrohBu8pTUDMv0UOmTWNVGtT1
 sPA3TwrkQ8iGYX95KHGGCBUPY8tTsINvToVKaZQxR2Du6WRAMDTdJr55qNmX3K0JtpCXPSafxrZ
 DSHLiuMqBlrMHrJezvBsV9QuqpOqeXvVANXrSYGlZ+EQ++rOfMsHzdDgXdYGoRiMy68+IAN6sas
 AWQUEX1itbFEn9J+rkLykEZrHpOiRy7KbcWdQ/uLA+hPHkPiqZw=
X-Proofpoint-ORIG-GUID: 9IrsW11cO0R0KG9XcrT7kC-Sne0yUrwA

On Tue, Oct 28, 2025 at 09:58:17PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In a subsequent patch, we'll reparent the LRU folios. The folios that are
> moved to the appropriate LRU list can undergo reparenting during the
> move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
> a lruvec lock. Instead, we should utilize the more general interface of
> folio_lruvec_relock_irq() to obtain the correct lruvec lock.
> 
> This patch involves only code refactoring and doesn't introduce any
> functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3a1044ce30f1e..660cd40cfddd4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2016,9 +2016,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false,
>  					 lruvec_memcg(lruvec));
>  
> -	spin_lock_irq(&lruvec->lru_lock);
> -	move_folios_to_lru(lruvec, &folio_list);
> +	move_folios_to_lru(&folio_list);
>  
> +	spin_lock_irq(&lruvec->lru_lock);
>  	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
>  					stat.nr_demoted);

Maybe I'm missing something or just confused for now, but let me ask...

How do we make sure the lruvec (and the mem_cgroup containing the
lruvec) did not disappear (due to offlining) after move_folios_to_lru()?

>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> @@ -2166,11 +2166,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	/*
>  	 * Move folios back to the lru list.
>  	 */
> -	spin_lock_irq(&lruvec->lru_lock);
> -
> -	nr_activate = move_folios_to_lru(lruvec, &l_active);
> -	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
> +	nr_activate = move_folios_to_lru(&l_active);
> +	nr_deactivate = move_folios_to_lru(&l_inactive);
>  
> +	spin_lock_irq(&lruvec->lru_lock);
>  	__count_vm_events(PGDEACTIVATE, nr_deactivate);
>  	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
>  
> @@ -4735,14 +4734,15 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  			set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS, BIT(PG_active));
>  	}
>  
> -	spin_lock_irq(&lruvec->lru_lock);
> -
> -	move_folios_to_lru(lruvec, &list);
> +	move_folios_to_lru(&list);
>  
> +	local_irq_disable();
>  	walk = current->reclaim_state->mm_walk;
>  	if (walk && walk->batched) {
>  		walk->lruvec = lruvec;
> +		spin_lock(&lruvec->lru_lock);
>  		reset_batch_size(walk);
> +		spin_unlock(&lruvec->lru_lock);
>  	}

Cc'ing RT folks as they may not want to disable IRQ on PREEMPT_RT.

IIRC there has been some effort in MM to reduce the scope of
IRQ-disabled section in MM when PREEMPT_RT config was added to the
mainline. spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.

Also, this will break RT according to Documentation/locking/locktypes.rst:
> The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
> have a few implications. For example, on a non-PREEMPT_RT kernel
> the following code sequence works as expected:
>
> local_irq_disable();
> spin_lock(&lock);
>
> and is fully equivalent to:
>
> spin_lock_irq(&lock);
> Same applies to rwlock_t and the _irqsave() suffix variants.
>
> On PREEMPT_RT kernel this code sequence breaks because RT-mutex requires
> a fully preemptible context. Instead, use spin_lock_irq() or
> spin_lock_irqsave() and their unlock counterparts.
>
> In cases where the interrupt disabling and locking must remain separate,
> PREEMPT_RT offers a local_lock mechanism. Acquiring the local_lock pins
> the task to a CPU, allowing things like per-CPU interrupt disabled locks
> to be acquired. However, this approach should be used only where absolutely
> necessary.

-- 
Cheers,
Harry / Hyeonggon

