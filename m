Return-Path: <cgroups+bounces-10912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C9BF583B
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF09734B7FC
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183A2561AE;
	Tue, 21 Oct 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rxLJyDvc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tRz1Bl7/"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980D2EC0BD;
	Tue, 21 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039011; cv=fail; b=GZrrJwLAfZSss1LI9vnv5FdO0JizKGhRBADFmLQP7osdhj1ngmlbn7gKQnDnrqc+d57DDGAVvNzEzSMcqEfsPURJJ0MvlPGZbq1aD7CbXrpe1F8lchj+CoEFbnJ1AQXxQNjH/dAF6Yz01WbqfwH1o/ZAwuq+HlvgVCtPlPbeHYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039011; c=relaxed/simple;
	bh=ANGkD4jBOdyTW/udDZzQFcFPg6a5L0csic1LaPTP208=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUT0ZIvkGm4CWKAy1d5Bq3vjjMUvBm62NqZb7qHqkkpKn8rxmiYX9ntFDiXTI8MHdFTUBeuZTpRDT+C0KDTYuf0Nd1T4wkfi7hZIj2Qn5SVwzSDSec9aRWVGCAlrvsvEPZT9bGe8TagEsYpUvXHxwkkp5n0dJ4Uk3Pctk2Miwr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rxLJyDvc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tRz1Bl7/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7uOaF020678;
	Tue, 21 Oct 2025 09:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vFd2GNCNEA7kHUnSyr
	cOlAyFOk1C6KlUHQHcZ/nW2Ow=; b=rxLJyDvcETiodEH/1hjBFX+IACjUm726Hf
	mfThXJVARlsKTY193gC+VjVape+EKwCYGvTck78xak3VWioUmVqt0xxEL4TvxY2k
	ciMQoF3KNBkVa0xTX2DyRzpHrWo7dpGfZHz9CtABMekbcLqx/tLvllp2MKG0ca4V
	F0+WCLxlzJ5lkxnzGfKPyLZLHSDsVR/ki7XraxlrOOvI/Rf3oIZtVEoHg5NVsilO
	ypw0sxz5Zq1esW3fuNuNvzaY4GlldK+3BzUTNDUuljekXf2kAUMKto5z82vtsYjv
	Mggspr6u5i1dw7iX8Lin/AQEI+WG7tYSwSecj/BBzB2AHx391FKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3074gd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 09:29:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59L6pWYe007184;
	Tue, 21 Oct 2025 09:29:33 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbw6rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 09:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfl9lwmvljKJEHWn/c2tSkBlh0DSWXIKE2XhaJ1uWGCCtMG/ohZ0eLF5IgfVgn/22/VQdBRiKFoN370SI2a3OcoSymZtnMhXHQdc/h9Ak1pWfwq7JZBcR9OumeaN1S7gFmKBJD1WmUf/o9jbFhELgE5ttVKyWIQhrGbEStZfUQNANQVAyStcpXRRBJLevYPz3xXDpV5MyCmQCRoCNxip6D+b9nZPn5FSJJnW29qUD5Imqpeia2MLK/Yb+xviJfGV+psw/6eMob1MM34W9r7uuqEjKSUpIGHqe8h+aV7gUFndhPNC/lwVlzzqZinzvLnKUUVxOjSt2ScXO39dr959Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFd2GNCNEA7kHUnSyrcOlAyFOk1C6KlUHQHcZ/nW2Ow=;
 b=CMAkxPVqQUWGMnFrTOrF+ytE+C7q6gk2MaQ5KiOZ9uwFx/OwftWpsbYemPT2dLrRigHBYylyzzUJXEPUQHdRwhqOOtvqlhH6WNYOOQJyhJgS5t7srPLvcEYKyMUnl/THCGMx+TCBE6+/cfO6v8kzF9et78TY7a+fNs+/A3FuLa8Jc7/RsvS4SQbtjqd98OsSveMqV+GwduzlFiDaEKxxXYZujWC4ewWobdR86byzlwxJzhd6PEQPwetaHdGN1dEHK6BFwfKGZnqNAJqTcH5jdxNoU3BjWDyCOHMpdHUQsUCZnLj7UlbwK2uTFixG62uITpySrJpCLE4jV5adpTMs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFd2GNCNEA7kHUnSyrcOlAyFOk1C6KlUHQHcZ/nW2Ow=;
 b=tRz1Bl7/MeIhvJ0tjcA52P8eDMkhVbSa8gvto8xCy/74ACsSLT+WLM3dvWpY1M6oCGPvqSM4gDQm2/kggzEYxhUNMEStzWdBbDXxhlyQxLLVg/7+8a+4dPpJFGYxoM3vxZan9HD6rVqN0/sDnCm25iq72zXj1L0PHGyq60cs4ls=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 09:29:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 09:29:27 +0000
Date: Tue, 21 Oct 2025 18:29:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <aPdSbO-6xTmr4IsX@hyeyoo>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <645f537dee489faa45e611d303bf482a06f0ece7.1760509767.git.zhengqi.arch@bytedance.com>
 <aPcjnKAapap5jrK-@hyeyoo>
 <3acbf7df-b890-4679-bbbe-959bd45fdef3@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3acbf7df-b890-4679-bbbe-959bd45fdef3@linux.dev>
X-ClientProxiedBy: SEWP216CA0104.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 17386911-f6cf-4626-b1c2-08de1084547d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfUSd/E6thoVvpp3MbKThjkXu4L2leeolnygnVbhlxT0/EcPAwVLXHT1NOKm?=
 =?us-ascii?Q?seYaUuiGWalZxUPZFYhJ+m3al0TmSDlTN9DS1VHL2ZsGeJqPBWMPOBYXW18i?=
 =?us-ascii?Q?ZLA5uk90l+Ik7L4OehFn7CqV7vvudOncgtizObtRr7wNVm5kYIw+0vJOpaoo?=
 =?us-ascii?Q?Er2BUlNETTjNzKZ60zMz/nz1b2GE9UoB3RF1dl6yQuljZYZ07ZbPKqjYT0GR?=
 =?us-ascii?Q?TeVwKLudnioAAHPUnZ2HUsJAXD1H21JsCS67lBVNjKGQHz5Idwps++cnctv5?=
 =?us-ascii?Q?/z652+iS5DkEaXzbH77aiSaGUrwQDbnYfq0+na+UJE6Dy7W0kXV16uzvREtg?=
 =?us-ascii?Q?MY+5WoIdxIFsq2ADeWl4AalIwPM2PCk8KeaN7ygabpv6rsJwMW2jbbG8sbW0?=
 =?us-ascii?Q?lXBAKmTHKqOtFscTbl2wn80r+5Xyf4YZ5HDCgmfUz7E/p1I9/UaobJUpHUHi?=
 =?us-ascii?Q?+YucyuGnR1RMAIbf0xAJV1JJy5A2B/RXnNahlrtLjCZxUce7x3zrrvjuJ30f?=
 =?us-ascii?Q?NyoeUxpJyb1noPjtgN13dSNtJ5OkaJkd9+5XH6VQvrZnUUXRQLDs7h3dQLXT?=
 =?us-ascii?Q?gTKzthxjkNM0e0HEOjeB4hGXBOHDUTq1dDq99+/CuRdGFuAIYABOI118kLuU?=
 =?us-ascii?Q?QC5rdRKP7uWm55oWaaT0l/NwJgJeuGAT8yg3WAk9jcSkdqcguknFGBXBoPI1?=
 =?us-ascii?Q?0ES7jRcBFcv+j5EJPXg14UuwcOFw+8qpAaMfiaDR23Ei+ZAbks8gKTS8nE+c?=
 =?us-ascii?Q?V8LOPUYLPuFJZ6V5eEigICjPf/4NNUvVaPEO8d0e6cIbsnM7gdgm+i07FGl7?=
 =?us-ascii?Q?0wtSar2GKWjgQL7AU5JldGN3XGZnqu4Y/tLEcTyAHi8yPeLujsD2buUr5mdt?=
 =?us-ascii?Q?9I53UzHL91WF7LOiHBRwltX/0tz0KqM89TA4GtIhqrBbzs06mu1bcrLm6S0r?=
 =?us-ascii?Q?gDJgIadsh8bZOdJhDIjgsKm8FSPssbi29Toz074lMi/cA7ejtXf81zZcrYnW?=
 =?us-ascii?Q?8BY/2mwJglj64r3sTHXZ8f2h/Ov6xxHub21x9KnaAFfihEPXWB3qnVQZ1QQ8?=
 =?us-ascii?Q?+igJUVaueyLBQLAvzCPqs+kou4G9AArRAklKBecODoa+K+O2+B6LrEXykt3g?=
 =?us-ascii?Q?v+03F98Ry9SggRs2ObKCGW3oJ8mIgl6H7n4Xr1kB82DULM8BuLZEKb6+jW6k?=
 =?us-ascii?Q?moJoG16i1g9h8+JOY7U50luH0UoiW1Oiu2bTkHVYF+0xEwKznJilLAXOkJw/?=
 =?us-ascii?Q?/yADHmP7svJg7baPQl6TaBE5zaH56e8viUxQP+HFuLw/2bG5NhxsiYixyKrC?=
 =?us-ascii?Q?z7t7s8FRTqqWPcmOcvQnjyL99es/0H8yO6WHfegazZjEyn+5Mg/nYUG4jtTD?=
 =?us-ascii?Q?o1bo8hr7aBVdiO7yJNaBfLax9ioCDxDdoDUXYfzDZjOpO8imeJ2IQvFNT9Qk?=
 =?us-ascii?Q?/KQFdufu+eas//0EvEb6j0Ln2/Vf00V2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkEh8hqY4CywzrY2bd4egDvilOdIGZ45whQ5cykIDlM9KmZ87Mb/5SKRhUy9?=
 =?us-ascii?Q?lYjydtO2P3FFSnvvxayAmKJSRqUOhpuRXJrWeQ3QmsQHE+5gHgqt46WS09fB?=
 =?us-ascii?Q?3wr6jdNPIhtURWaanFiPa79kCRQScI8uq2FUudY6o6zQ18PGKV7GoGpEJJqV?=
 =?us-ascii?Q?nhyVTb5ZLGmvxRZWniuqx6g+bj2RCjTpsfZt6lnWfUkokoGzCSK0tCsoWq0F?=
 =?us-ascii?Q?0CZb6hz6mSmWrJp+/Gn5QlIi/4lzqNR5ToQTULpr/I77TLLf9x8S+NDwPGD0?=
 =?us-ascii?Q?LvAM3/zE56UO95e+Tgs3xdjvyPAc/m6Yo83/PMSzizuT531xL8SPOIDvY/XL?=
 =?us-ascii?Q?UAMbWnhcLm+KR3KXowumpVRKlt6VgxxsTyZD/trOQ4SiTs8q7wAv71qa5SQ6?=
 =?us-ascii?Q?NMzuZaXmw/l4OSRtKh8ZQdFdXXNcV6bghsCloQfeDbBw9Zm/2OdIpbM0GZ/d?=
 =?us-ascii?Q?VJrp78q2vm/zMPN1mB5u9BlfAbNaOKjIEYM5va9vv58DFZFR58mE1Fqxtueg?=
 =?us-ascii?Q?fmSBp4wM/3jIN6iUjjH5TiFRy3NDSEgQjCMjEtl0HrqKEPm6jcJU8ntnSpOL?=
 =?us-ascii?Q?6/nE5YIzQ+y8nBEGYkHXsQ8ZobzBe/v8AW2olz8fXFb3ik8oEU9S8N65Qzb4?=
 =?us-ascii?Q?TedQKRNkDviWS8mLckW4uWAtINnNvwjv9ic31l0ch3UCyITkUE3RMxqWZkKu?=
 =?us-ascii?Q?dDBAK8mkgf3WbfAtedHab51B4jmPlXg7BOwvIWlB3Ds9H3q4Lo0z+Hs0lgrm?=
 =?us-ascii?Q?IausdOlLgvVHothDeHfXnf9qPbKreTyt7stTP2DRKx6ZiG13MWeizfvZScoN?=
 =?us-ascii?Q?S5x/rqFWeRCN9RI1TeO2jcLhu8pPwAzwwXp8Qj6uwfrVCKdIoXmy2G2ZkseK?=
 =?us-ascii?Q?4Tb63OMKwpvJvYMHASxMXwDUE/+gm/l6eb8soM5uqsb0WDofKqRWieeZB4sO?=
 =?us-ascii?Q?Z07yx1XmR8k2AfNxcuBQjwNOG7Y9ByMGzSnw9oBipbU057h9zGfJUzXyn55h?=
 =?us-ascii?Q?jq5VBU1vOtfwUFDW4sH4G4UnAp3z9hrtMuvPbyeviW0tLiE1Pqn28OdB+A+g?=
 =?us-ascii?Q?tXii1hd8M6Ly8J0EmZFTr0lCZhV+S1Qg1SxuugiRiBk5kw16w+4vRtKbifLq?=
 =?us-ascii?Q?+vkzKbHjHPuq3Cx3yeRnr2TVrmxWFyD0ykei0W9cEHoCqXEkJCjmJXiIDW2S?=
 =?us-ascii?Q?oUXlHur3yp1VBiwehu0PRIi/nVodHxXrxKBxXEjj9akSzZMr/aT8YI3gUtOf?=
 =?us-ascii?Q?rUn1zL3ixZX+pMeFY+y/ZI6KTnGNx1YguQZRt4gKckcnL8eZRfIpcBQibVyg?=
 =?us-ascii?Q?Ik0YUbm0l35zRLvnavNLzFxF+T22GK/QvZvuB+ZKbchEndTkrTtRu6L1nOX2?=
 =?us-ascii?Q?zbjoZJpHdkkodt1D467u3tCcIWpHw0Zg/0wzVIqnnMivzlec/M9VWRqvjTlQ?=
 =?us-ascii?Q?2rGG7z+1agSK080bnKeJdawIIYmXIRqhNahUPFQdk71+Z/HXrCYxQ7JN5j5w?=
 =?us-ascii?Q?IkYNXMC8TVK4qBXTL3yUiPhc4/v4nLPDz2yL+rcJaD/wlVuLC6f980gInoDy?=
 =?us-ascii?Q?YsNNamk9VpKHeGFiMTTyzqQVG5F2pNQhVxwRfo0p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FhsMoaE5pf/AL+Yksbka9jn1qjyNFCFU8Ah3+p3DklvXeHWi6rZsgpAnfqFphseSfNzCp5d8AUHaEs7tXzDcZNVhG3cEDHfK3WMFMIu6Zx7V8HrR49PdK9IteeBu3YlxbmdosP3qgUMi0EKJCS1vqoyJbIZb5cA1A4ROyKzTSLEkByEKIOL1YjFccN4vjHCg3vrd25v3RGD8yM6cKkTQ2yHtYJZTJula5vSGZ20Ad+f9CC6aW6iBOGDDLevamxPg3KzNaOjTpjDA9f77dfnOhUFb9osA5Sy+B+n1hDorxsK8Xv2+XFPORV45+zfPQZ/z6YIHaLRvf5xq8/HHEvDx0vEaEzx7F9FLQizqRxx6zw5kSsQALVHlD6hMx8jFGIcSv2B/Stw+C4kqX8jkdjCWsJ6DGjI8477hhPFcth4DvaV7xDNbtrkwuoLpJauFuuqColgiZh6tyIpDJwZT0gyHdAwWzYois5VgTHnZUrHNmm8lch5W49jG5RtyFTln8A6efXp5oNdjroAxkeG/6v5ygLZ0+CDPa4EMn82o5SYFwR/wzUPM4NlUdri20avCmEOIr3Azl7q/n9ZCxZUvmSe4vEiayvrruFVZxpy/F5q429Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17386911-f6cf-4626-b1c2-08de1084547d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 09:29:27.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nf7GekxwOQNvf8ElBFMwVmYNQB6FBLTB0+GcSro/mbgIDIOcybx0rihAnlWxv+Fq2i3sYM6wclyILQ3L8qjvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210074
X-Proofpoint-ORIG-GUID: ckm-iz5OnUf75-65DFnqhpsdCYBgPeGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX9Zmg0lBmncBh
 2SGHipqC8N81+BQuvmgdA2UHSp6xW5Fnma8DDRO3sQVRrZ7irM3O9/56J5eZJDUzV+76PIqSRk8
 NHHRwaF/x06i5vHuaClUgzWiygziMw/bSesl23wcjNNwtCC/Qo1tpf+b9E0onNdZ89vxQXqDHz7
 gTL2KxDdZVyTlt0+8FvjHy5P81zQ/nwEFUCmGBspQBC3yISrD0WOsmcGtk+MIoBM/TjV77VMaZi
 ANhs4vZ08nxRyL8Vt4SGDGD5gjyxQkkKkFdTSCraWR28iIruU6ivP22mqwGnHm6/XrSN7E+IQZm
 OcHfmwvoYT4Ya2yn/yb4IHg89Sbmflu9sG8R75X62ax9u3xFCFkTNh8JFpDG2P5VEpOSp4h37HN
 L3gP2d/LfJQcPV25Degw234BkP/VAw==
X-Proofpoint-GUID: ckm-iz5OnUf75-65DFnqhpsdCYBgPeGd
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f7527e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=8ZetJbBXVjHQK0i-uS4A:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22

On Tue, Oct 21, 2025 at 02:21:55PM +0800, Qi Zheng wrote:
> 
> 
> On 10/21/25 2:09 PM, Harry Yoo wrote:
> > On Wed, Oct 15, 2025 at 02:35:33PM +0800, Qi Zheng wrote:
> > > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > > 
> > > Similar to list_lru, the split queue is relatively independent and does
> > > not need to be reparented along with objcg and LRU folios (holding
> > > objcg lock and lru lock). So let's apply the similar mechanism as list_lru
> > > to reparent the split queue separately when memcg is offine.
> > > 
> > > This is also a preparation for reparenting LRU folios.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Acked-by: Zi Yan <ziy@nvidia.com>
> > > Reviewed-by: Muchun Song <muchun.song@linux.dev>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > 
> > Looks good to me,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Thanks.
> 
> > 
> > with a question:
> > 
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index e850bc10da3e2..9323039418201 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -1117,8 +1117,19 @@ static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg
> > >   {
> > >   	struct deferred_split *queue;
> > > +retry:
> > >   	queue = memcg_split_queue(nid, memcg);
> > >   	spin_lock(&queue->split_queue_lock);
> > > +	/*
> > > +	 * There is a period between setting memcg to dying and reparenting
> > > +	 * deferred split queue, and during this period the THPs in the deferred
> > > +	 * split queue will be hidden from the shrinker side.
> > > +	 */
> > 
> > You mean it will be hidden if the shrinker bit is not set for the node
> > in the parent memcg, right?
> 
> Look at the following situation:
> 
> CPU 0                   CPU 1
> -----                   -----
> 
> set CSS_DYING
>                         deferred_split_scan
>                             /*
>                              * See CSS_DYING, and return the parent
>                              * memcg's ds_queue. But the pages on the
>                              * child memcg's ds_queue has not yet been
>                              * reparented to the parent memcg, that is,
>                              * it is hidden.
>                              */
>                         --> ds_queue = split_queue_lock_irqsave()
> 
> reparent_deferred_split_queue

Ah, I see what you meant. Thanks.

So we may end up shrinking the parent memcg twice if it's
hidden, but I guess it's fine as it'll be rare?

> Thanks,
> Qi

-- 
Cheers,
Harry / Hyeonggon

