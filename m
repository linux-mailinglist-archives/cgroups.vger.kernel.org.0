Return-Path: <cgroups+bounces-13337-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBzhOE5UcGlvXQAAu9opvQ
	(envelope-from <cgroups+bounces-13337-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 05:21:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6750F58
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 05:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4E873E87C7
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175DC358D06;
	Wed, 21 Jan 2026 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sSuyn5PH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e2Q8ABVO"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090F2E6CAA;
	Wed, 21 Jan 2026 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969284; cv=fail; b=hi0Ybp4LbVo4fwo3HogNgF9l0VvNxbh/gkreknni8LNUcIgqbizSf0JLGD+JiU9qy4IQivSiUSKqDtGp64sQIriquav70vY9JuLOfSaTKJN6pfm8v9EYu7VU4lIIQYqNFtNCmJ9BYLTLdl44J2JUn4yZe0bghwaDooVhHE+86Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969284; c=relaxed/simple;
	bh=86v2FAP1MhuuEM5dswnX9WbqJzxjvCboWe51MDI2dFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnGcJfYVLSZa43hiQvBYxbWouUQdk2QdwVdGS3qQJRMT+nj/SKe+ipC5px2CZhJWE+HM2YKMwuJtTk76xUYuInUgmU/DA5Z941S0INPSsRGUL/Sw1RUrYK5+/+Ceq0OgwDTmB7Yf7XopQdLEnGR4y0m8qQXPnvRTJLkY2OJlIUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sSuyn5PH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e2Q8ABVO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKpbN33868549;
	Wed, 21 Jan 2026 04:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DW3KR1spFCnG36hohs
	py+VI0HhV0esVe5IGcFwkjLKU=; b=sSuyn5PHkgDEm71ESydJ/KyOqPnbw46Wkr
	uqrr2xFGNQT57e9YPwK2zykllJrgDOvdP0E4NwHzxNgV2URj8gmGnH4Sz6G7fvMf
	AecUFqTCzxlqRz2IiASl7HlBDVoMUUmMAhf3bzVpgqGcp1HRu1PwHoTs3z3WL0z9
	i0bncCOJqQw91Ifvj/t9SuU+9T9MN21y4OTXVdG2Hrcg53sRBxAaTng7DSbOwVpg
	sp05O0Wo1sxBvN1Rfn+0rW27d4rc7JjKuZMHSux3HVWpXKIfaYHEV1C/KYjj59lZ
	yIIxk+vsI7Fp76a75s04mH/d9z7E2/r9Ybx2Lg5QB8cKMzxF2pYw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd1hsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 04:19:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60L2WX0O022477;
	Wed, 21 Jan 2026 04:19:46 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0veepad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 04:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLD0Ij+pVLVKqBOU+1tMvY7Q4qtbrNp7E2ODvczEhrBGtabKOPQF5bFNwsh10ExQ+UE8JxFd63ij4/m0j5KiCBq4U/SE9oLLTC77RTOP6BtC2OGc7I5a6HQtCzLVzhyqfp9uTn3685P2a7W0J0eUCZIOLMU9UqOlkOh3ckxZX8zUnnDauSwRzPKmR8mt8iP+kA2lKNgkHJFqxhHda2zqBIWwtI0jC6M0KKMrxfMG0FnekAnbPkWfJbynFDJYcR3BpDEaAgyyUoYN+SkWaGQBG4OznoJRecL1DF4YKdUVqnaMPlV2ixnwCxfSEHj1CWxE+dmWGL0xt7NXph+tZaiH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW3KR1spFCnG36hohspy+VI0HhV0esVe5IGcFwkjLKU=;
 b=RXrolN2Bi6QjsMfRSQASIC5zdey0FCSueOZinWKJu4aQpbOJ46lxsA8BXUMLSn+Nn/CDPFsa3vRs+oe7+2qg4aXlMSv90fNpsSeRl6E59PtgZmN4HVeJaIdakh9oixdWPt7WJiJCvbbGFd1Z45bo7bsvJK/djG8awoDEEJ5NHofoMTIDl4PfszyllfDUz9E5j9mdMxG0KwWnT6kh97PotqY9CTcx40jUX4fH4phIWaMtoETi43Mpi1Bl5qB79T4nqkZwOYF0mbdcZWHzZNq8psYyQavDxRVMDWL9jK0I7+H3ad0wm1mM6sdQ2MlmCWy5DW6wcC60DXoRH8EvCvANJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW3KR1spFCnG36hohspy+VI0HhV0esVe5IGcFwkjLKU=;
 b=e2Q8ABVOFt+mGdjX16G2s4JMdpWA1EI3HgYrFwvedHWEClgC+Vo1Euap7YKjAqYeFBVqgpzeKp8RJpiUxiZWhIiApDwbVce6S2H+XG1NXqbXargVzPSUdRzlH4P/m6dQaHtRw7uymctkTQVXozjyR5dO5ikEYcdS2xlGRnGEa2M=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 04:19:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 04:19:42 +0000
Date: Wed, 21 Jan 2026 13:19:29 +0900
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
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 26/30 fix] mm: mglru: do not call update_lru_size()
 during reparenting
Message-ID: <aXBT0R42Xuzwr3Ns@hyeyoo>
References: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
 <20260115104444.85986-1-qi.zheng@linux.dev>
 <aXBNuLDtUmDVyXTv@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXBNuLDtUmDVyXTv@hyeyoo>
X-ClientProxiedBy: SEWP216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fd665c-de4d-468b-bd99-08de58a44d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/bDN1fZr+JRfWQiDQbvzFaUuSJNp6rQhydjwOOH93GLPu9S5a7OwX07MOSNf?=
 =?us-ascii?Q?ktAoMX5mO7gIhGfsbApxrNPJo/b0KysmYoSr0CGSun1JixbLDNkALejigjxd?=
 =?us-ascii?Q?vs4/qO95wunAtwEQVKyro1N/+Y3JXY0NcJUBmiD2WQHhsOY0hv6ulm0/B5h2?=
 =?us-ascii?Q?7bp/8bQ0zqOKU7bP9U+KF8lpsmZr2WosZYlEz3MZ+5lj5aFS7+xLBSCNT4+J?=
 =?us-ascii?Q?pGwtAdRsy+Xl2MpellH9nVsWLCgupc0jjxZDybb+obB8zWqteVkas+na7VQc?=
 =?us-ascii?Q?9ryWG/3OuWxNypA9h76pLCT2qnZl4JuNNr/AFrrjlhv8S1OUBLv7PWg8+xtl?=
 =?us-ascii?Q?1avD2afJd9zsWFlshl9FbqDcUWyTZZlkSumbPxtwnQM+fzGpQTUA2Zqtqd3Q?=
 =?us-ascii?Q?ktg/66QU5ZpCPQWMgP7Y05DSRbQslD7FMDJuJYkZ8uKuVbHbcURTF9/qTnqN?=
 =?us-ascii?Q?P3cpn7R+GJhlNnNC72XWuLnc4P2p5yCNOs3/iyEBbH4qtbKRKyGJ1zIxhvVG?=
 =?us-ascii?Q?I5UZNU4SVKO9jDJuB7QTMsd2RwEbeFbLoX8UlRyItbSmT5uVbAwZrXAJdN/F?=
 =?us-ascii?Q?iQGpgSu/YFge4mDqx0UX6hiWs3JG0bZxdjDycA9UwIGG81FBMoSz7tzK8Z7j?=
 =?us-ascii?Q?u1bDD3TdJTwp79ubaa/iYVEz1ARtOMLAvpE5tMSZoMZLIm3qA0SC85Uz1umh?=
 =?us-ascii?Q?QbUHBX6ObJTyItAVScJxRiyDQW9G0qNGO3+jbG+f3NvUAp6WVjTvitKPQisO?=
 =?us-ascii?Q?zoBXoO9InjI+45XwHz3nX/cvmDq12Q5peJO6HyQAi1aT6zrUpMDe0VtgooTb?=
 =?us-ascii?Q?+qdyaFjagaROUJCbfhhALCc64KMUQdXGUeh0bR7jvEnGQLUet5PZmsgiO43Y?=
 =?us-ascii?Q?cGCRbeZWE63USg8+WN7fJ5dr9h8sZKT6rVpQupPnv6Y/wv79b1+f+Sbkewd0?=
 =?us-ascii?Q?lIIGO5w8AqocanhIgwAqcrZKNFeiA9Yh3TrCcOASjEIWr1JT8mGoxL/Zljl7?=
 =?us-ascii?Q?miCJni11iEWh0s5a6xoqo5J0Xxaa9Ciko6blZyaZV/Hcw7/w/sCjJ/LjOtzx?=
 =?us-ascii?Q?FxwIrLkscYpKAdzF3/dSV6VYeMmg7h9xzcg0HwdQwBSHtIvqEQpNIu9qsafG?=
 =?us-ascii?Q?v78+mUx136DDd064fdmCnSyTvkWUrre9sQFmdSHU0rLLFH1SP4BWXp9VUm0J?=
 =?us-ascii?Q?OhkHJDzONCp/yZxdp2TiygoHhLgd2Q4efDENutjGFCSVB3xfKcQThI1zjxsK?=
 =?us-ascii?Q?ZN6m2lH+8SMZwUxTT00ox/57io64VCLSzP/QXXz7DjMyEdjowKETpwgQ6sLe?=
 =?us-ascii?Q?AlvwX5NZVVydOZ/VjyGcLvdguvFzWOnPcKnr83FQ4xgaM3arhTLbyLAQReEe?=
 =?us-ascii?Q?pAtgY7jcLiN2KXO7zyXt7mjHqoRIISjoaZ1+/uvdzF5nEPHDOGxdtbdz4Sxv?=
 =?us-ascii?Q?JV0yOeeKNCUqRiSSrnRQk55l8TUpNmdlPtr94sebcXoxdVFg6CWyxF1rGTHN?=
 =?us-ascii?Q?Tw471mNeYEJLgK+z7y5O3HqyUxnVATacbjwMnQi8v+mxP9iKz07kskEfsmjf?=
 =?us-ascii?Q?6VGECF3K9fdJvLqVRLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HG60NHTFbEGgFiJBJf0R740yUvJL9dwMp5ai3keZ/b1V88W9WydQSJ7pYksh?=
 =?us-ascii?Q?zfSGYw3+McrpZgksxjf7kDUMUo9bZSOxLN5glkfCv0P79Elpta8sGwaAGYHi?=
 =?us-ascii?Q?MGRiFY+iypoF4cUu5lxKLYhiFNLfJTeIvurko2pcYcIFcybDRKfBE6cu2p3O?=
 =?us-ascii?Q?RRVY5GGwPq0OQVquq2UVGZEOALrsFAza3pj9lHe2YlfjS/ZGqmYViWqZk5oj?=
 =?us-ascii?Q?Fw4x9KJAQiWf/LWoDyn13CDiT4slrPqvjKEcopD5Cagn9u6QfxZUMnlygSB+?=
 =?us-ascii?Q?Q7MxUZUCVeRWRW1RcRpfoCcTSgbCFMQny6EYqMOMUCQnpYdNOlkIikwgcBr0?=
 =?us-ascii?Q?LOzepGpSnAFUB5umL8pShHO8ZEO0OahQUZW8JwhEW3akfp9TEV7SaXbOkX4F?=
 =?us-ascii?Q?XTukBytO/IK0GsMgWTLFN1R1RoEhTDRTJYkeATzoIBQ0Hxg9X/s1m7lkla/t?=
 =?us-ascii?Q?ZXj/n+emh8Mpne3tRkrPQutAe0HtOelCdSK3XCC8pDMft5uXiBLdUegs9n/Q?=
 =?us-ascii?Q?dPWUcN4SQCMM6I40nesQfUOoiW4If2JVwRMPbaPyNCjzvSxPsXwEMKKahJyA?=
 =?us-ascii?Q?NJH3WzRyMZWxgJ4Zb0V6j/yGy8uLRGNz3qSIwiovtLooAj9p3pwH3epynMbc?=
 =?us-ascii?Q?JPJap9XICkl770AB6ublgwl3h73lLi2VDt/xiPg2GGnMhIEOfSKYqWn8VX5H?=
 =?us-ascii?Q?IaFnyHt1EhMERnHXDWYLEuJLNqUzJ2c/eGm2FmE/mNFs6veiIPo1lFD1fFTt?=
 =?us-ascii?Q?S3MEDd3BM7U4yAR50NsLSNBJwcHrmjdr8CzEB9jYclCuLSUXja8np5DcXoWQ?=
 =?us-ascii?Q?HJ6rEsKGeq71yS7876C+Nd9jKoL2Yt3H7FN4wggtdf6e1aWD17hWOc246imv?=
 =?us-ascii?Q?ZovkbQcFyUneGEm7W2mP6TTq9oPE/4fR6399NK9MNMOVsOYbrnGPFL2nJztG?=
 =?us-ascii?Q?gaGPiW50vSrlGmdhs2q4QTrnoawYMTABxaJfKs6VEbygr8+DMpAv8+e7SlMJ?=
 =?us-ascii?Q?Ilq+v/R1PHkx38iNVByofz7FeGGcXst5FiRCeUGOZZQDHah+b0+Opga/Cj9J?=
 =?us-ascii?Q?aX+HGqYPzJIHQ2FPVNJofwu6OwbIg/jl9YprY6OI9z/ZIHj7twsDnrQkVAFO?=
 =?us-ascii?Q?Ok7VsK0UROhtLKPkKdDjaQormFifQpYqJL4p1h7r/yZWDqzbEtdYAGVhmL5n?=
 =?us-ascii?Q?2+xdItUgHc1mVbPyoEvmyikZxQYE8belWKz5viGPao0qXfr86NHfUww2gSjw?=
 =?us-ascii?Q?O4Gxajz45CjMCxzUfoPaJliDyrRi6MAua9YTqhZjx8WdmvqdBsbWVRaWfIar?=
 =?us-ascii?Q?7pGWuBQrUYokQ9hM83TS2mV5enhxThWSZ231vFzeRfBkxHdULgH8d4d/QaO2?=
 =?us-ascii?Q?jiXBtXKeRHFmRTtKWbuYO/+j4ekaBqWq2h8vnm1g//jtf6/+fiKhSgvOhLZm?=
 =?us-ascii?Q?YYq2PXNoG7yn7YDGkIVPhovJyR+wjpxoL9N5xVlhL6wZt5AacSYdOgB3OEEf?=
 =?us-ascii?Q?tMS4oIvd5xdLuY5Yyo7FG7zgoM/b5N3iSIxASrvT3nFCLy9d5c/ZSt1ku+50?=
 =?us-ascii?Q?7TH2QraCa//uKKS1v4DJJebCnEj2ucVLgaDZxsvD0wZC4/nMivGKCMaym2MQ?=
 =?us-ascii?Q?GyoTZwz+Nu62GEydJqNWjRkl55xp66kYJJpOztrbFBJrrztq32lQrwdU7Pn4?=
 =?us-ascii?Q?cf8rslJUORnuH83f+8YD3LYYU3ZUa79zT7k/ebhI84uTBfX2N045YXaGmQEk?=
 =?us-ascii?Q?WsyupzJAGA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MhQSfQFsAnoZBqV8hy6yVdoHWXnVE5xNPov0YZboT+9uXm1Ye/e/SBYv2/iXct8PpacXF01h2raYQAb+9JQL0OHZewbv/MJIdcny/cO8wXkuzqHhseG8hIE6zfSTje62+CgRwJRj5zouOgpv3/VNrvWPyBSGDj0dRTg4CKIvY0YBThrzFg0E61kWu73TLwgma+sWe2mZaikb5bQmoLfRnL0ergn7FF0wmV81CN7urFtQW97CbNnt9DBWH2NV029CMv97YxK0iVftQ81xeKW+y829WpK0nUgLMidiHo4s7kEgxdQb4xhFbPpPBCYv/RUuNxkr5XW4yHZaOWceK6EOmSglnIrhthhGTp1heHNMsInN5M68zxoArlDrCeIjvjsnWbL7onfQdKTwpoobwqb6CPzQx1SS7EshICJ9BA9TPrOuSSsTjO+yTaqHHzrplsZ9Sh8Gr1Yr88fWEPWskoQkJgSreU5KT92KC9vHlXBqE3j+kPrTyy9vpysDYhQI+ExmTHeId/l/Njg6dApcKKTYjxVkDArwyNEwM7Mtcn//m28KXAjH359f8BKvJc1Ynij/2IRS9GScTiCWrMvhu6+rUUouTLBBWRrf0lRE184IXLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd665c-de4d-468b-bd99-08de58a44d09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 04:19:42.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQsLx2YNak3FEUwhAHmrcw4BWHuvZv2IaE2Co//WqBlkIMDi5HKZ8qspRA/NhOD4fhrsFEu4J1WrvQo+yXefdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=970 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210032
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=697053e3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=PLwUsP1UlCXpjlXo0DUA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12103
X-Proofpoint-ORIG-GUID: KBzrnkatgp0CpQeNVdHKV9Hr4QyhKoNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAzMiBTYWx0ZWRfXz9mmUfwZS3/A
 GJhTEzUIhO9uULHj9gSt249tHNWAh9nSjl2Tp6Escv6hXZL6fxn9OufW0w7bX8R/JNjlI8f+Hz2
 NkJ5mcoqBGJz/uGnSKBAgpdH9171yRiLd9MsI/cYJQGHatuycmfVaALzMaNCqRdlNFABD2CploE
 4oxRCfgxRx9VuogLiq1VlIIvyNUmarF3SwDRNmV5g+6yhUsR9TZvrOEgakwp+0tL29Z/ITqj7UJ
 s67aRe5tcG+WBn7GoKxNLIdti1L1krJC+dqEKVvse/vTYrkr7iHY0TianyTYFsKG0K2m1LGgUl/
 Ty/dnQaMQAJzeNMiUGc1/wHi1VoWj9sWWSXiMiLBd2V4LZhaytZzBmzC4uHxQHw11aJ7ofq7u45
 apWU+idl6iRJAO1EnJCmuQunXNEW/RBeZGy/sFbGinqI+ygXCUeo8IjIva+V+5OoYHppJdXOE8X
 zUJpIpYzt3E7f/bwJa1qCipD0HERVk6v1c9qEtRY=
X-Proofpoint-GUID: KBzrnkatgp0CpQeNVdHKV9Hr4QyhKoNJ
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13337-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bytedance.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8FC6750F58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:53:28PM +0900, Harry Yoo wrote:
> On Thu, Jan 15, 2026 at 06:44:44PM +0800, Qi Zheng wrote:
> > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Only non-hierarchical lruvec_stats->state_local needs to be reparented,
> > so handle it in reparent_state_local(), and remove the unreasonable
> > update_lru_size() call in __lru_gen_reparent_memcg().
> 
> Hmm well, how are the hierarchical statistics consistent when pages are
> reparented from an "active" gen to an "inactive" gen, or the other way around?
> 
> They'll become inconsistent when those pages are reclaimed or
> moved between generations?

FYI we've observed this while testing downstream implementation
as it led to MemAvailable being unreasonably high due to inconsistent
statistics.

The solution was, if lru_gen_is_active(child, gen) and
lru_gen_is_active(parent, gen) do not match, # of pages being
reparented must be subtracted from the child's statistics
(and up to the root, as it's hierarchical), and added to the parent's
statistics for the generation.

-- 
Cheers,
Harry / Hyeonggon

