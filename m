Return-Path: <cgroups+bounces-11705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4491C44C30
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 03:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4820A3ACE74
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092221DE8BF;
	Mon, 10 Nov 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZougBn1Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fr7R7Eaw"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126A2BB13;
	Mon, 10 Nov 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740940; cv=fail; b=VG3YjKbZ8KNg4/Q7S/nRXZM2WtSsYTjuz37bmQ5RmVnD07c5JLoyqz0Mn7cex83dgZCgUVG9esiT/OmMOU6PDnAFeF+bEF2C8dOYNrZwmCGob0i9Qnd7iMdw4JAvuwtiIxgKdfb2ANal5SCPfBQPq3ab3DnOU8dnLJoRou2gS1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740940; c=relaxed/simple;
	bh=lh+QBi+NS3nNFnjsQhe1o+H6i+lLrfoyo2AZlGWq6/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhvz+rtPT7JWn/2Xx3D18KdF7gDqf2S40D1QNbD2sRgE79nsPgAOX2OD47FCsiwJ9541hYAKTEWqeMHcVrWTonehLssnGeiEI43Zp4MdxlggJD2hAlmRbj4Q3n2D1Is5oL/CY9o6Hd4HT48TrIz+hHNjO9zOo60GHfXcHrJffLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZougBn1Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fr7R7Eaw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA1sTMO017224;
	Mon, 10 Nov 2025 02:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p92qH5pDIVaIGyVpyr
	Sk90i0jnREKB12e/WncjoZCBI=; b=ZougBn1Q80cNODD8MhaZNUzCdmu0aelkVB
	RwJQW2xbU+Wxerqkbfh1ie3RoQavWXW1ArtqDbLiPkTTxFz6JYAG77lUUTK/gpHL
	vr6lLQxLr+wdjY5dYnplKbSm0aMtg3fvwkvMVWo/VGkDCUlZH33304WhGaWM1K6n
	lTv26SX2VMJKc/mVeiT1JpmP2Ce7zTb5bmpVmcVKsUOr0eDKTCZe31RC8qlXlUnm
	cJEXeK8eDDnrQ/gxQW+3yGjcIaFP1sJB2kE0DsgEOuKKfnQe4C+wnON6rneyX5qu
	Mt80dg9bqUA9uyDTfF7pfl6+2fkaCRMJ9ADZUcGSHYhlrfvGmUjQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab1u1r9yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 02:14:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA01aXa012715;
	Mon, 10 Nov 2025 02:14:07 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vab2a02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 02:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAT+FNl1cnK/IdNNtCpH650uH/bj8lxwxBzGjxu/kKgCieK9EpM4IpmSe+LK+HjRkEc56s7EcqhCQoO4ABLWadO+gcS7fasWv4jEEWMLOTRt2pgNkyeTlQmTob+rC7T/ds3tBcUNE7ah7R5KNPdA8aj6rI1cyoCvjGpYCfX5lNwo1JueBnVyALiO0TyFeVk/UfzaLcROPTrXU/+FN2CghYMQaI4RWIzMkqWoyZC+G1zJZPrif1HeezQKRLtMvMJDimAdTRkovFBt0694GZaPmjO7sl0g/JmH4W+NGAYVJOEqcSao44EOJ0HkN3Khelljtc2Etq9y/4nvo7FchgWdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p92qH5pDIVaIGyVpyrSk90i0jnREKB12e/WncjoZCBI=;
 b=Wk8JS5766Wh2oMdOfvqM2RelUiwSBtaSRqEwtK+iKrZQEnabUZTLRwaZFceg+y+6Tp8ylw0J01YKNXdgZILBOfRt/ZvwtLXgt/vrOy0NYVY7LV4bdoAaq6EHodlmJZlQAUooqugez709rF7cg00U4QK8W9nwi+U75FZ2gQpuIRZlbPSQloioKfsbMrE5LVf2twPGjcYFpi+S+MdDQHnv9bI1HlzicrSAyZYZllzLCPkJefaFMhQWOakqFSSUj0OXXnpCS5qD9siMibU4AjWHfxGGezDZEGG73WZC9wcGQkA0zfWQGLizsf6v8BCNXHPddvtrz0FOon/Ae01lJ3KEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p92qH5pDIVaIGyVpyrSk90i0jnREKB12e/WncjoZCBI=;
 b=Fr7R7EawIrlDhk8iOnFtQV5vm6pEUb4WgqDVrIf+fdh5IovPzoruq5hjBTCUs597KI5z5zfoqmuSwJS5bwID+mksfQpM8az6v13+CjYLh5uJuUAsDFbZFbAGGJ05oO3bPj2zjekx2ln3ooX+i+Ag3nFjdpR/fVh935dJeYuPJSw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 02:14:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 02:14:04 +0000
Date: Mon, 10 Nov 2025 11:13:55 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
        imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aRFKY5VGEujVOqBc@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
X-ClientProxiedBy: SL2P216CA0171.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 8525da8b-bc57-4f11-9d6f-08de1ffed226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZ9YfXAjr5bIlXvaFi92VltH6jCtBrCbi4E2xxBXJzyJRlV+9WPgt/Xtrm5P?=
 =?us-ascii?Q?drJMVgY/JdEeZ5HKVdMDDbQuRjyKta+/hHy9FvhXiHcbyd1gc3vgsPXJ6esN?=
 =?us-ascii?Q?MF9Xpy+S4gD/N/JkIlFGNzK0iAbeRjLruRDuciN2r72Qux3QBPvYzKwK/Exy?=
 =?us-ascii?Q?YubTjT98Aqv+No9LQyQhMk1xXGl5DWBS40UHAGoWjDBNOrLPcogjB9NAJGKq?=
 =?us-ascii?Q?Eq7VE//qDxHRGmK2dUUNA1+Jjj3MzPnwVQGV0BHqEOh6LRMEyARheNdL2edo?=
 =?us-ascii?Q?1hGVwEBFatKg9l5RToQb1jbf3yXbtCWPrXsEeaE2+ogP/VIi0ikpPvSGL7R6?=
 =?us-ascii?Q?QDzDvhCP1+OPCXiNd+LaTqKuqQF5HXMKkOjzpjra306ueXE3ggwXtIefq82X?=
 =?us-ascii?Q?YbNGCCfTBM+eTpM0agAbKLSYhZJAq3ELpQ4/uR22uoetd+dknOd7NCNQqsfV?=
 =?us-ascii?Q?RIn7D5G+GNdrAPtkNECXEA7memiGihi4w3IkXtoSo3sIsVbBWMn97E0D3Ufl?=
 =?us-ascii?Q?cclrsbiYUwCGu+43/zdqrZcpqqe+O/sVQQduzzvEG8XRom5jRex3cQOek/2y?=
 =?us-ascii?Q?6sKsHBYH26I77YIxzMpb3EECL4PwVhStubiouVYszBvK09q94cI5e75f+3r4?=
 =?us-ascii?Q?kyEjdQBjIge4uVM/VDA71JEI8hWthl7mXmMAUoWYFkY6qQUlcnlNreojtTCx?=
 =?us-ascii?Q?krrgEScRxAiOr6y4F3QOrZ4kpO75Jqj2Cu+rirkg1xqbWefeed8VZEc5jFRu?=
 =?us-ascii?Q?H5qVfZisHkNUYpYLa3kg0/7FDSztB/Uq/lPsilYv8T4Ao8Tu0Abp9RZjPIT4?=
 =?us-ascii?Q?7MSAE5e6etzADtBV+8Y3Q8E4mOLHbuaqCO775uckwYg9C1RrH/0Hro+MXwAF?=
 =?us-ascii?Q?3ZtrtE0x9l8B9AoLMzubKQ771wqt3Linp6uC/Rw0qrEgKegxOEEUIvxpi6P2?=
 =?us-ascii?Q?2bfkY52IAI/S5KzRR0MCyyAllfk3e5m0WecL3y3D9HiZ7SGzDX7aCNVhA5JO?=
 =?us-ascii?Q?hIJKeGhNrZ+8zPW+UV06/Cgta7YIYs13vmOCvCERS0rze+Qibr0nFEGABSbS?=
 =?us-ascii?Q?8MC+aYzAz2vw1g5cDwPENxnBAlyn6cBCaUWr7LwIrqCjUHGfI8bk7dp/kw6M?=
 =?us-ascii?Q?7cndOLfS38NYcasV1CCpP07D74LaXRxkT/jqalD+LIvGgyBiOmQyRH0CjtlZ?=
 =?us-ascii?Q?ZvYeZpw7RHnRzgVJL5OrA/MX9M2LpMOvsFycdwtyKjfanHOpAXRpBChBcCpQ?=
 =?us-ascii?Q?dv/5oqcrVN/0IyFci9bvwLa7WBFU8LXhTBNaGJLxzVVCFg87NO4AnnyNum9K?=
 =?us-ascii?Q?/bUUobt804h7DNL2mqWZoXabXTJuKGwUyA8a4It5is+Vk521QiCO/4Of53Aj?=
 =?us-ascii?Q?iAfl89uMrKO60adHNCfKOWIpSpTzCJKV+wSiKIxT5kUw9Dcd7w0jB3lL94Vr?=
 =?us-ascii?Q?8P9yVw21MfW3u+XanFWyl5h9UAIPYW/R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TuqIZWBBK9iD+pGz2lA1Cu5euZ4vvdfDJ2k7yCaCbMuE9qhcA0ELNP2F3PnZ?=
 =?us-ascii?Q?UsCBJmECOeZXfNVt9E3iCcrHwQwrLfbYHjWfmeuKGzgqw5zRkyxtziGppCl/?=
 =?us-ascii?Q?v2qwPArUXaQdAOK4oTkZFsJ/NmIbZe3Wr/3hn3/VZ6Vxmyb7p4nzK4dSYZsI?=
 =?us-ascii?Q?jvW/ualqCV6PzsV1RNoXHub9JTBpopXY9p8wjtO4MtL0jkvX8TcukwtPxlwx?=
 =?us-ascii?Q?pHJM3KLTdbU4s5LynjUjE1hvFkXilvTL0vflg5lDllLaQQnFYO0gnLHjaFs2?=
 =?us-ascii?Q?XaaBUpUtwpLfhYrw5OJE6yilntUqLhGZxAZYBhJS+8lxqBXCyfi4E1e/GuFS?=
 =?us-ascii?Q?S4NKgQiPVk1HGZ6b598Oixbukcsd60sApx7hd16cbijMm1MicX3M+miRXey3?=
 =?us-ascii?Q?14El9FKLVPLH2WgMxPWGNmV5j/m9xW3RP5ERQoAiM06Y/AkPU4Je2OGR5IQe?=
 =?us-ascii?Q?JglSA3fWSO+glIkR/ppveseeNuzudZ0rHEg1ZnPR3QIe/j/sxdLP1bTRr/eJ?=
 =?us-ascii?Q?SNIpSw1uFH7Erw1YqMG/NxyuaiK5gWmwecVydWXIdMjZ2LjjWCMWQ1CtdaZy?=
 =?us-ascii?Q?jinzx6y5LIkPdXiEx064nHm9oYA1qIBTYY+2eVHQxurgchvKEPgaf3zTEdD+?=
 =?us-ascii?Q?7CK+6pSmVysoiubzmSoITR+S9AdSALxkZ7GuIcJye2LACzHNXo7GQ5u3fi7g?=
 =?us-ascii?Q?l6pihAv1/hfMbM3ETl4GA+zskUeZ8JA900nILiOjaItTsjIKH5vF1trwbpgr?=
 =?us-ascii?Q?EGHsuuJe/f20mbTTkwIp1q7IaKXNevu65uGThny2cQ3zajuKmcVh6vRaHFGp?=
 =?us-ascii?Q?smHyj10cxuryu16F6yJlRA+WSbz+LFw9h88lQS1FQIPMI3n1VdAMLs8Vl++4?=
 =?us-ascii?Q?5zcfksYxHzhOT28W1s9nS2j79ki9nC6rv9vyfZfX7GSWq06HjBcKLzB2243U?=
 =?us-ascii?Q?S+C/ZtkT2GjtvrCDaYrDtXoF9c6x9PhIfCmo1yU1K9UvbpQk/X7cTeiJgmpP?=
 =?us-ascii?Q?ezUJTTpnuoG61OfEqJXKwoMLWM3t3w3wVsP3xR7bR0cKXKtX7d0erFDuWCNw?=
 =?us-ascii?Q?9yg4LPJTMA6/59PJekk62RcLYBnpAosd1h6+kRG/Nc82t8S64bAeLSLZTKnt?=
 =?us-ascii?Q?mElg+AIvPZoZ0lPR+XiKPI/FaGbdKKXOO8+cfrJpVQlsV4g3iBfJSpEr0AMn?=
 =?us-ascii?Q?dS+wxPEfDM6Uv38DzAfYpa9G3x/uK21v3idy0mmEAOaxmN7oO/x8q2B9unv5?=
 =?us-ascii?Q?Nx772ze3VsFtoTq9/7xs/ycuuUS4IYf6P7meX4+ummvKND0ItwHbTWQgxxQ+?=
 =?us-ascii?Q?w2lOftXQ15/ZmL+MVNy3qspXUqz+qOKAsuJlFJ+V/gKxZVaLqAyd1EBqQc5E?=
 =?us-ascii?Q?y7wk/6P8U5gR8wF656keHjf621TiTC2EpMIVh6Mu6pUncrBKaEghw/5DokQo?=
 =?us-ascii?Q?GP5SvkkAa1zhNynG4T7FFGFeVR9c69n0RSekYhjLrkiokbuQVx4cAgBz8w8t?=
 =?us-ascii?Q?KOIVjJLpt18zxVK/WG4I4sFtqgN8zv278BAszMrmzXl49Ok7h4S4eEaw+fv7?=
 =?us-ascii?Q?0UDcedVJOc1613lTPpxpaIT828NlyFdn4E6smzdg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rPnX6/1LylJ2I1gHlPZ4LU8Nb48RHYAeudGyfU0juNZpRK1Yb8ChqljZrZ7F3ShR4v9Sn8hT1KAopmqnCHDMRvhKo6UwsGGZ4zGLzIwqUCNw7irLnET/kxiu8vP6tmf3G9+yDDjFd7eluLZ8LrrAp1eyBAX8rOFvR7ltYQ3SzE4tMoKhvSaKLmLe5oALOQ7+Sqw6bccn6xwTdp5Hm7R+z2iSmAC4HM9wzSRuFvyvN3kmWfM2JWomjWmR3QzEEkI3HIVMg1IOBSNKNHQHOgY+ZhI/tqqk+9qnVboWFYdwssYhx59A9flzPb/nKrONXx70ljer+OneiHL5fN9EhQ+OoQejR852fuT2gQXbf8ceMpfkgh8I93CVuw7F9MM8OIGhqnO6mZGWjePxdNFgfryMC8/4N5LT3wmTnIRkatd5DNkAZ3EoaX7S9+XrQtKqywLp8ELDvW4tsmgr/gTvrL0HcsdisIAPtemdYqzOAeEoLZ3OQb+Vq8Q8Qd0NJxiIPCmCZ5YLOIoEztdhdJJ4MdvJGo5xRcs5O9QodovO+Ey+Y+OsEtCPYa4ZTQWxGEnLTWnjpsRUvN8nPO24OETupHkov4ubJ3PelDFjcf7l4VkzVAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8525da8b-bc57-4f11-9d6f-08de1ffed226
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 02:14:04.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIYXhvsUtZ/5DTlTbpFu6qXRYQf7qNtFYebC5uQHs5tYg3ARvT8B0YDw2bYctdzUIsT9/WmjitXZAoVnOXnPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=584 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100016
X-Proofpoint-GUID: aa60BRYcKSRQzGLeypkgt4M0MKtkq9xm
X-Proofpoint-ORIG-GUID: aa60BRYcKSRQzGLeypkgt4M0MKtkq9xm
X-Authority-Analysis: v=2.4 cv=AKlJAtVy c=1 sm=1 tr=0 ts=69114a71 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HfqzDRm77vvMm0GhDc0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE4MCBTYWx0ZWRfX3tmEXbPtFX6s
 YNo4DCp1QqALZmFGRyMQRQ2HoMDwS4mBfxiNfspCG1xX5MzylZ6RfNJPH+xmLv/hhK1MwWT/Kb0
 9Zvlp+/8t9U2zc5Gh2fBQAt+CiL8AzkGbyfctUSqbX0DY2iiOZ7TQ1kbTHjQ/4qGQF3FPhJFstj
 U2Cy8PQhTlf9Wi0n9G2e9ZBUTQldFLVuYz1Tv3VVcL6Yikz8krRqkb6Py2nff+RiDGeShzULinO
 ZDyMy7kfx6/ypbf9TL4u4uwJZ+teKFD3k9K6U9o6Y9VhWrDs0A4f4XGnnNdV86e19mtvHQ0Pkrw
 QthLeVfzMdvjn136E3Jz1NCO+t3gsbC8WheqbpwX3sA2I35JsrbhY7wTXeB9NJgxIcARUG8Fj12
 qNz33pM/iFP83AiJcaIzb5SSTYyqOFhjqLSrptKfdKpbdBJDY+4=

On Fri, Nov 07, 2025 at 10:32:52PM -0800, Shakeel Butt wrote:
> On Fri, Nov 07, 2025 at 10:20:57PM +0900, Harry Yoo wrote:
> > 
> > Although it's mentioned in the locking documentation, I'm afraid that
> > local_lock is not the right interface to use here. Preemption will be
> > disabled anyway (on both PREEMPT_RT and !PREEMPT_RT) when the stats are
> > updated (in __mod_node_page_state()).
> > 
> > Here we just want to disable IRQ only on !PREEMPT_RT (to update
> > the stats safely).
> 
> I don't think there is a need to disable IRQs. There are three stats
> update functions called in that hunk.
> 
> 1) __mod_lruvec_state
> 2) __count_vm_events
> 3) count_memcg_events
> 
> count_memcg_events() can be called with IRQs. __count_vm_events can be
> replaced with count_vm_events.

Right.

> For __mod_lruvec_state, the
> __mod_node_page_state() inside needs preemption disabled.

The function __mod_node_page_state() disables preemption.
And there's a comment in __mod_zone_page_state():

> /*                                                                      
>  * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,           
>  * atomicity is provided by IRQs being disabled -- either explicitly    
>  * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables   
>  * CPU migrations and preemption potentially corrupts a counter so          
>  * disable preemption.                                                  
>  */                                                                     
> preempt_disable_nested();

We're relying on IRQs being disabled on !PREEMPT_RT.

Maybe we could make it safe against re-entrant IRQ handlers by using
read-modify-write operations?

-- 
Cheers,
Harry / Hyeonggon

> Easy way would be to just disable/enable preemption instead of IRQs.
> Otherwise go a bit more fine-grained approach i.e. replace
> __count_vm_events with count_vm_events and just disable preemption
> across __mod_node_page_state().

