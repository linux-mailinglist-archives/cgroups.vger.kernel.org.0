Return-Path: <cgroups+bounces-13855-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO+QOvhXjGm9lQAAu9opvQ
	(envelope-from <cgroups+bounces-13855-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 11:20:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F812343C
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 11:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A27F300EC8A
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B795366DD9;
	Wed, 11 Feb 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M7TFJewa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rEWy9pmU"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08219EED3;
	Wed, 11 Feb 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805236; cv=fail; b=FCW6L4O4CI7/d/F55H45zX2/3gI+GFqgvjGxco0nWV5hkXUgXvD0WLJyGNSyWCXjJlRQa9WSIaoVRWRT86kVczlkZ10Y74avkufhpTXMh2PR1y++DDnzzEDnNFhWwPM07xH2DCGLSS+3xgpNQEP4Lerc1Y4oNA1J6zUKxEIUQCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805236; c=relaxed/simple;
	bh=IPkjMPdyB6txM8Q1nYxRCdUmqTKzKHZqTo26HJbjPnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPYFZxTu0yA1uzz0Kt9WIfg8FBAj6MhGcxMutUxWwrJHTXsbfqVwwHMQlWSKN+QtqYs9Ey0Ik5S2jx8Dz7xY6NBfynWMlgIxiUcWPPOSLqDFdb53Xd+7EQqBxoBGwFoNSBEbAExssd6slY8ysAxXa85XsZewhqp0VtUe/JlX8U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M7TFJewa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rEWy9pmU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B6g90V064746;
	Wed, 11 Feb 2026 08:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KorXeNvNh/2bF2nV4i
	2MzMaxcrAO4N9h0IwiNlgknj0=; b=M7TFJewa/mGc0qrMD9HOa60St9hzMX1o84
	UW2S3In0/vP0lzrTx6m8+Uq5zsh8zLLUkc4qzW79lCWvfx7906XtV0mO/OhXOgh/
	WwwP+MGbUihXabHo6Hqh5hPR0KHebYWL7gqVuLZ/p08KuUV9d/FbKxzmNc9LNkmx
	k+SVMavAhATupmY88GCBlG6kzYarNEQXLQTa7qkllWMJc/vfuvM/WzHjB8VjPcHS
	USuaIuGtJjYuyyO3zX1c8gWvWSqDf5/hSjr7puRvBAlD9GsmicLvRmnY+hFu4gi4
	TD6yRo9hXQDwTx5ba5fX+m70tDEWuHmRBdMdX6uazXIeIo+6i7iQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88n7h31m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 08:53:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61B8QEFE030032;
	Wed, 11 Feb 2026 08:53:51 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c82299yy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 08:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5RnTnIYTfhZtqxPflCDt9cNqyoR8jA/YFf9nlIOusPUY+oVgtFYJoMS1XskeZYCoyj5NXMXYu7xTZNiwpynWEg9v4yGqbepzwcahnhfgO07a+GwHpZ4I+XZRGBQLYYN6LPPeH4m1/Yn1mvJa1cF+rT5Wd8P5QHoVDptYObV4kEj3z+F25GY/TMJ3a3Tg5RC4MqSQ1reOB0Bbn2RVkQQixMSVKhdllLDTvBV1RGWBUWF9YoR5qlSTL04uSyYB5zhcAbm0JYggPgwzksQJbsuikJqGu5Rx89n4HFjJh/z/VIZgQ9Ci5dTnTvzMz6riiKM8eGygA+gceMbrMOWMBu25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KorXeNvNh/2bF2nV4i2MzMaxcrAO4N9h0IwiNlgknj0=;
 b=FBZIJ/Cl/k8HAV/oDk0sIHXvqbDCPmA2aUIC2YlIia24WXWxdGClPIN/6EetcBy4LzXLslb7d9dKZrHr8gsUd5k/Fe2ogJFL+PBwLCb34Kr5Z/yZV3cqVuoine+gduZKsNfxSAIEiCLV1gFSB92FjQNwNdgzXbaxdxMGzu+WK577GStkJw8mYVi2+GpXHcJRogSK3pvjR9eWfrZaMJnmL64uLB5gMTHDYUrpBkkRg7No847sT3Z+yEgUg5jDqWMV+QKHvyI8KUcWyMO1IuC+cg22UdtgW9dndzyCQJwhgY6DFuwdavej34P4h0lnWVc3h6ktyCj7deE785UP1d3ZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KorXeNvNh/2bF2nV4i2MzMaxcrAO4N9h0IwiNlgknj0=;
 b=rEWy9pmU4SIuh4VyAivZBW7/nK3YMSiIhEb7yczBfwdpDJop7BKjkyPp3VVotl+wBRtx90avU1i2uKe8TfVWBV4yEhNxhZpfIw4EkO2pq/onXLDr9tokfbcyMPFGf71QCJQ/Z1DsHUOsRrvpw7v+r4b9IDqYL7Fvv1mvgDbtdQw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPF6998A7572.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:53:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 08:53:47 +0000
Date: Wed, 11 Feb 2026 17:53:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYxDkkDI4mk3r011@hyeyoo>
References: <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
 <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
 <aYQuj6Ot-JS4tXvY@hyeyoo>
 <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
 <b77dc11e-fe09-4f0c-a912-d05faa01ff1c@arm.com>
 <aYtbevHEwx_3fn0Q@linux.dev>
 <5a6782f3-d758-4d9c-975b-5ae4b5d80d4e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6782f3-d758-4d9c-975b-5ae4b5d80d4e@arm.com>
X-ClientProxiedBy: SE2P216CA0124.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPF6998A7572:EE_
X-MS-Office365-Filtering-Correlation-Id: dec19e74-d170-41c0-796e-08de694b1164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mKvH1P+GmfrqU6h3CJ9H2diCX6LXQwScJaDeURcrD8p6reGXMNNblZz16DW?=
 =?us-ascii?Q?EJKFmNuNo/teT7kR22OHxC044K35Rq8h5BAFhxGprUmyYyazrfFvOTVemB9U?=
 =?us-ascii?Q?mjUHT27r6TSptQHmJbRdQgghlWy/MEyQmcOca2AzpMIppYUcW1gq2Xfa3MSO?=
 =?us-ascii?Q?WJ2qmi9eUPZ53rHozj7JSgUU++9T+p08u6OKTRZEHeR3BlSmh55J+rECnehZ?=
 =?us-ascii?Q?8iLV5KUBApvgr1H7oXxUN4hsFIUx+ulF/Vd73L5+wIHwpuvtoAun0QqveZZN?=
 =?us-ascii?Q?XubKDvIVb3lGUSrDm+mdSRPp9I/hSlxCERj+auWAJFJwKq3LyZdTHC5UVhig?=
 =?us-ascii?Q?NpnOta1RcMceESUas867GISJNJLQHEDegxfbveaslVpUpQ8MgW2F3gajtXoE?=
 =?us-ascii?Q?b2kx4yhXh0jj3DoeDnbySIORJ7St7AmDNWeZUR4zpHmVmm7lnIMeWWI4ALFG?=
 =?us-ascii?Q?Hk5r9NxO5SyEx+K4hA7zF74zkXn3S0x7Fah7YHZZqcINSixyhKdrDiMvSlrt?=
 =?us-ascii?Q?MbPy70aDadFDNbuwFPHYlywUUrPBhxsuZgPah6N71ibu/t2F4vB3/9qoa/fl?=
 =?us-ascii?Q?IICCUgpUBlyIKd96rvGcJqEtIWmONyR1tMarqJ5GTyliSbI1pbGYrjFnEKng?=
 =?us-ascii?Q?0TvxvRpbUxNjO4aJX/D1N2gnZkG9oecItPqgrs5i3+ODzuhfKIWTjbJEyXIt?=
 =?us-ascii?Q?V6eRtNuEHpy4tBut+Z2aHIMrPPJ1GdlCrxyRQpvVZBdl70MoT6uSSyhF28Qc?=
 =?us-ascii?Q?qttjGMPDWaIviwKzK6Os/+1P25Iacch7gjPCrXJwZNFjAwmRNRVLGYPNA++j?=
 =?us-ascii?Q?svZLxjmogEqPyXUiLdyqf61fClH7MKYxyMtntgVw5rNtcfKjAP3Wusymx2Is?=
 =?us-ascii?Q?TmhuSE4ymIb/HJukQ0Q3/WuzHPv7Ia3fpdW4fyk6POPxgNBDd9HhExp2qaMK?=
 =?us-ascii?Q?EVJIoTAB+1wJ5BHnOFa3NSmBzzTiBL2xeJoWiPEUz8Enj3ewXr319yu49oLx?=
 =?us-ascii?Q?yqWs9teNWcsYrfWdfMzuly4qesHvqOv64YRC0pq8L0KbALX6p93d6Xfr1PQp?=
 =?us-ascii?Q?r3KXh89z0RdV4nHiQ/oQpG+ntfcnpX+USw/rJDdvyIA9OxwDvTbfzyTfnbSI?=
 =?us-ascii?Q?n/i+Ee9v6LWRBN8WNktTaE/PXfUr/dRlqqKKEqm5k3Btzo9my/yFSVFTMK1k?=
 =?us-ascii?Q?po9efuMSDVRrcjg6HbocNkx2om1ugDZYqO0rzPE8e98kXFv8ucEml9o9i8E3?=
 =?us-ascii?Q?cBxvjpAJUjZgQxaowdp8QHfjim1DGtFxMp3lt2Uagj3CMo/6UAGluxCm9YQS?=
 =?us-ascii?Q?un7m6L+VmP6d3/M3wBIEMzIlvZdWD+Rf0trTcdRAJVB5B1qGMV61dQn05h/4?=
 =?us-ascii?Q?EdUrZLND84OwBsetBhP25ZAJQuj4Rl31HgqQuvq0SLfKcxUretSXGhDctY07?=
 =?us-ascii?Q?D6eW0duYOhbY7WAjCHkPKo/+hzVSM2/wShJICUSZZeFa/l57VCTbioJNMtMA?=
 =?us-ascii?Q?VAPgWjYbEXwoZ534di8eCXTp/RSYpHEkadUkCkIt4MWKv7D8jDW+s75SNpGA?=
 =?us-ascii?Q?g/UdGWOjEKj+pbaJY7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3AUvqQgHB/jw+++P/uSOc+WHaXCg6QMIKtqbvJMBUeJRKcxoeC1Y5+nduyL?=
 =?us-ascii?Q?ocop/tshQnh+vmW42ahiglUtq8GulxCT3WGHfdODukQdRhMcR9RC+qdUxUJ8?=
 =?us-ascii?Q?HqndSVoorqE1qXkVl03e9Z4o6XzUHVulGVZsldHlMtvAOAFCrbwFJTUVdGAg?=
 =?us-ascii?Q?zS0apQPgE4xXkvdTtzl8EYDdOifojfcCQ95s2kVptggG9lsNlRPKfIBP0xN/?=
 =?us-ascii?Q?Zx7Ue1pyhvun1zT5yC7JHTcz+reM3R7akefdbDYvHwAsFlho6s7BUdY3jod8?=
 =?us-ascii?Q?qWJxaDtzpn27zr0ns/EJuXELvgsh8kgsgXSixWOFuRxFF11beH9FzcEjtPeJ?=
 =?us-ascii?Q?Umgjx/S72/tq4RLbGXvF7OSaIeKeWvdT0XZIWUvuwJJnh10ssBK3jXiiKSTT?=
 =?us-ascii?Q?cayqO2lVsVGHRPRdWKvA0bT4cGLxF/gwoHeZfQRatgLzvYPWWsktC0cNeQTl?=
 =?us-ascii?Q?+Y92Eoh3TkU9qpUCEz2x5KUew9PZAffPe6QJTekbOo+8JHXJBUNKUF9whasd?=
 =?us-ascii?Q?g2nDFrXBDjtqRo29ctu6uTskHxkL2F2TX/8qHSnxGQl8rwJjA4TCTDiGrSZM?=
 =?us-ascii?Q?VReTavvz2J+V4x/7XpXaXIekd6qc9oSIXfC7DruzoFPRx9Ar9pTZ7m/IxHXr?=
 =?us-ascii?Q?vOuH2ElDkXGsUAr1eJIfcw7ERK0KO5GXGOQms4dR0pep2txLP3WQjhH7dSsq?=
 =?us-ascii?Q?xHwM5cbJd1lo+H2Gn5MYwXT6SfdWuGunAPzOSDJ2LwrFAPvTWHa+8ofWbAOt?=
 =?us-ascii?Q?QkMDcEce6iZqMeBV54FhY1IRoZGRe6hE+yPBhCyzj3uZobqhkdV3YBNZ92Jm?=
 =?us-ascii?Q?gKTZiOXTzjdBc6cTnFGVZSFm/jXy73NvPaZCMFAiDa/YzSvD/qiXZ+bTk/mk?=
 =?us-ascii?Q?l1u2PMw/A3xiiN1a80vU8LUieP+0mSj/ey8+fD3ewSSMrKc79JfOgD6xgIOt?=
 =?us-ascii?Q?YMHsrXfDgqpVapaQ0GE327dF+gEN+Qw5nIZVePvHeVwwQU0xAPekzss9Lo0K?=
 =?us-ascii?Q?KTbeLhA7TPVGJFEAHcLLP0kZmaoKMSwxgbItJ8/v62TA/I73R5N+ErJF73hy?=
 =?us-ascii?Q?cXIf6LV6J7LKa3lgIUUZfIwho9inTa0gtvDZPHcjaAmjV9n50OV6HoCewtNz?=
 =?us-ascii?Q?Q24iT0uSmV++XGpi1Z4LUkVn1IGusRD46km6fIMW0VYRkSBBTj84EyraYfLz?=
 =?us-ascii?Q?AnnjLc596s1r5ITUplWPSBU82NdzKT/ilPtqepR+JAHkGoxEsQPfS17l7w9L?=
 =?us-ascii?Q?e0kNP6nKy1ePyLiwvhiI/yft9Cz5xCOH0L3M5l+EEw5Q5/MR9FdNW+IZJq8s?=
 =?us-ascii?Q?NrUA8RhSlMYBXxdJcOTqr7QyGyfgko0QJn+gUdgrSiiI8u3CBfU6ZQK+Lt5z?=
 =?us-ascii?Q?nc2yf3MJBsnHSsthUFgu6yyDrBq9ByqFcAYb+tYWGpyIwHBMsIvuFr+jd1lP?=
 =?us-ascii?Q?g2Rfr48PE992BnB+Y5BDiu81czoxhF8513B0oFAbf8gG5TVR2oJKZ8ENWw7x?=
 =?us-ascii?Q?uXKxHfdFS8t00BnAOiJkX/9L8q1Yl9rb6GtxNogTrBqRI+JFCm8x8/+FKh8c?=
 =?us-ascii?Q?nxQiKGlcftonjYeuQbonjjALG0uTwJiVip24g4UspRVPvWDPPfM8uQ22YIp1?=
 =?us-ascii?Q?6jSSXWHGIkXQqZl8YkaEzpEhR9GlIZZMx3QLO7Xnmtc7MqCC6CA15MD9HVax?=
 =?us-ascii?Q?TOwzAs4gcPf+7r7HeiQIoEXol99EoG3zXpbku8EXXpAUvf111jSM0qkVhpFf?=
 =?us-ascii?Q?zGPc1ZVvNw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/ZcW2Gc9pPReAm9saJwGDldLkuQlpvPeOge9ljfOKjq8r50ZUl1NEOJW6MwZDoGIcxAEu8f2rawM282aCgK5hffzHhtL/E1BRfprZ9kMOmZPP1raUCypadTEsEvUvd4iIDagKHdziMbVV6Q7AXmYduNoLIFxPSx3HRGxkU2QbZkjTApEkg1ET1ia3/C59zu/tEZwBfqtRRxcht4kl2qBm7pjpm7dlp4efENhipwhNWVIQDC375/WTyabkrlOcR0+oLtioizgfcUk3tCs5RVMIkMJMTrFE0luvaf+GPou+tasB4KpY+WfJPTjQldFSEnvczBtnXmBR6ErBxyGa3KSgbgX73+JSYWgXCdnAHfe2uBMapVIlC9WMBcKblab4PPbwr+t+RipE32VIbpgasV5TDzMQJ/Sag6wmKoqOEyDfN3TfUTOOmpf+OEPTkpSMNToAypGhqPgIRsE/mEf66zrJ/Ymr8pe2tePOjZ/YvU2jbd4JdhdlgZOnA9uOmI2NuTH4hWbYQxA/eu4pndcZeX9M8A0hs0Jyxn44GR6uBB5ayfdSpG6jmAenZpoXUOLHT8oyyZT5drFcq92keO2fFD4gFkoj0riGR2L9UBrHgg3sN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec19e74-d170-41c0-796e-08de694b1164
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:53:47.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty7FAozu9YFbT1CJV9PIX+J7MsxRZGrVzbBTZBW9aPtfvp8vaQHy2dEAUxpmwGEHfpLlDGuEn7u1yaH0gR9nUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6998A7572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602110072
X-Proofpoint-ORIG-GUID: MnryAtHr-6ZRf7Dtx_TTUoOFWrGED301
X-Proofpoint-GUID: MnryAtHr-6ZRf7Dtx_TTUoOFWrGED301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA3MSBTYWx0ZWRfX3lvWaPH7D9bh
 BpYMYTGhh2W4Dst7bqrgVjoQc4MAwobbc4kySz+cWvcbHEAFNpzs80NIbEa1AR+cM3vCrpVRglQ
 s0vonZbQKeR5oaJNUFhagJFcEDYEFXwy9YaxvIrm7HHSkhAS0DMv/nw+FyoJz75GkRiFMPVLBPx
 i1r1rOKRnTXJ3rNIN+wXEQkac6dJ2Ccifg3V+oXt+ym3hVsvowy0et9yIn3l4czPxJ6rU4qLhdP
 MA3WEeezrC9gh/HzBQtMX13RMV6WxVJv48vi97eOvOSr+QMamsFUYnvnstkAm2NaCTFvc3S10IN
 FQumkfnzaCxzdtG06pXiAE1CMHnYLI37JLNIKSHSH3wn5RhEGDXIOpWfGJ+BhrN7G5VLGX8QMAI
 8ycn1eQssfcxDjmaMpumt9tJqp/AoGqiOBffuLvKhEDB5o/b/DtyMJ5cEBBgSonz/2CzlzjaI5m
 tlYybtDypTTE539gh6g==
X-Authority-Analysis: v=2.4 cv=O5c0fR9W c=1 sm=1 tr=0 ts=698c43a0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=Cy7045DbtAwES53Bu6YA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13855-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 637F812343C
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 01:07:40PM +0530, Dev Jain wrote:
> 
> On 10/02/26 9:59 pm, Shakeel Butt wrote:
> > On Tue, Feb 10, 2026 at 01:08:49PM +0530, Dev Jain wrote:
> > [...]
> >>> Oh so it is arm64 specific issue. I tested on x86-64 machine and it solves
> >>> the little regression it had before. So, on arm64 all this_cpu_ops i.e. without
> >>> double underscore, uses LL/SC instructions. 
> >>>
> >>> Need more thought on this. 
> >>>
> >>>>> Also can you confirm whether my analysis of the regression was correct?
> >>>>>  Because if it was, then this diff looks wrong - AFAIU preempt_disable()
> >>>>>  won't stop an irq handler from interrupting the execution, so this
> >>>>>  will introduce a bug for code paths running in irq context.
> >>>>>
> >>>> I was worried about the correctness too, but this_cpu_add() is safe
> >>>> against IRQs and so the stat will be _eventually_ consistent?
> >>>>
> >>>> Ofc it's so confusing! Maybe I'm the one confused.
> >>> Yeah there is no issue with proposed patch as it is making the function
> >>> re-entrant safe.
> >> Ah yes, this_cpu_add() does the addition in one shot without read-modify-write.
> >>
> >> I am still puzzled whether the original patch was a bug fix or an optimization.
> > The original patch was a cleanup patch. The memcg stats update functions
> > were already irq/nmi safe without disabling irqs and that patch did the
> > same for the numa stats. Though it seems like that is causing regression
> > for arm64 as this_cpu* ops are expensive on arm64. 
> >
> >> The patch description says that node stat updation uses irq unsafe interface.
> >> Therefore, we had foo() calling __foo() nested with local_irq_save/restore. But
> >> there were code paths which directly called __foo() - so, your patch fixes a bug right
> > No, those places were already disabling irqs and should be fine.
> 
> Please correct me if I am missing something here. Simply putting an
> if (!irqs_disabled()) -> dump_stack() in __lruvec_stat_mod_folio, before
> calling __mod_node_page_state, reveals:
> 
> [ 6.486375] Call trace:
> [ 6.486376] show_stack+0x20/0x38 (C)
> [ 6.486379] dump_stack_lvl+0x74/0x90
> [ 6.486382] dump_stack+0x18/0x28
> [ 6.486383] __lruvec_stat_mod_folio+0x160/0x180
> [ 6.486385] folio_add_file_rmap_ptes+0x128/0x480
> [ 6.486388] set_pte_range+0xe8/0x320
> [ 6.486389] finish_fault+0x260/0x508
> [ 6.486390] do_fault+0x2d0/0x598
> [ 6.486391] __handle_mm_fault+0x398/0xb60
> [ 6.486393] handle_mm_fault+0x15c/0x298
> [ 6.486394] __get_user_pages+0x204/0xb88
> [ 6.486395] populate_vma_page_range+0xbc/0x1b8
> [ 6.486396] __mm_populate+0xcc/0x1e0
> [ 6.486397] __arm64_sys_mlockall+0x1d4/0x1f8
> [ 6.486398] invoke_syscall+0x50/0x120
> [ 6.486399] el0_svc_common.constprop.0+0x48/0xf0
> [ 6.486400] do_el0_svc+0x24/0x38
> [ 6.486400] el0_svc+0x34/0xf0
> [ 6.486402] el0t_64_sync_handler+0xa0/0xe8
> [ 6.486404] el0t_64_sync+0x198/0x1a0
> 
> Indeed finish_fault() takes a PTL spin lock without irq disablement.

That indeed looks incorrect to me.
I was assuming __foo() is always called with IRQs disabled!

> > I am working on adding batched stats update functionality in the hope
> > that will fix the regression.
> 
> Thanks! FYI, I have zeroed in the issue on to preempt_disable(). Dropping this
> from _pcpu_protect_return solves the regression.

That's interesting, why is the cost of preempt disable/enable so high?

> Unlike x86, arm64 does a preempt_disable
> when doing this_cpu_*. On a cursory look it seems like this is unnecessary - since we
> are doing preempt_enable() immediately after reading the pointer, CPU migration is
> possible anyways, so there is nothing to be gained by reading pcpu pointer with
> preemption disabled. I am investigating whether we can simply drop this in general.

Let me quote an old email from Mark Rutland [1]:
> We also thought that initially, but there's a sbutle race that can
> occur, and so we added code to disable preemption in commit:
> 
>   f3eab7184ddcd486 ("arm64: percpu: Make this_cpu accessors pre-empt safe")
> 
> The problem on arm64 is that our atomics take a single base register,
> and we have to generate the percpu address with separate instructions
> from the atomic itself. That means we can get preempted between address
> generation and the atomic, which is problematic for sequences like:
> 
> 	// Thread-A			// Thread-B
> 
> 	this_cpu_add(var)
> 					local_irq_disable(flags)
> 					...
> 					v = __this_cpu_read(var);
> 					v = some_function(v);
> 					__this_cpu_write(var, v);
> 					...
> 					local_irq_restore(flags)
> 
> ... which can unexpectedly race as:
> 
> 
> 	// Thread-A			// Thread-B
> 
> 	< generate CPU X addr >
> 	< preempted >
> 
> 					< scheduled on CPU X >
> 					local_irq_disable(flags);
> 					v = __this_cpu_read(var);
> 
> 	< scheduled on CPU Y >
> 	< add to CPU X's var >
> 					v = some_function(v);
> 					__this_cpu_write(var, v);
> 					local_irq_restore(flags);
> 
> ... and hence we lose an update to a percpu variable.

... so, removing preempt disable _in general_ is probably not a good idea.

[1] https://lore.kernel.org/all/20190311164837.GD24275@lakrids.cambridge.arm.com

-- 
Cheers,
Harry / Hyeonggon

