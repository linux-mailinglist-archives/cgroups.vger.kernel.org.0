Return-Path: <cgroups+bounces-9874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4FB518FE
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB81C25E64
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2E321F28;
	Wed, 10 Sep 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mMK2XaBZ"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012053.outbound.protection.outlook.com [40.107.75.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687B31B13F;
	Wed, 10 Sep 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513277; cv=fail; b=WaFn6aeErnYvKLU8GC7aAkl+0PjNcTwwjswJ9ExlUZArBGLGYeowOY6FU8our3UYQ9a+X0nUMCiQwqdtgvSJbFjmoH8cE9AaKBd0jcF5a0JQu3PQWt9NNBhuPsOeJQH+XIeqHB6qMpx/m8uzB2ObweaBF6NqWZ1L9uJ3jqLJkMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513277; c=relaxed/simple;
	bh=zvJi14wSVwdMUwqA1ZeyxGXkLBcuS83MjL6ZjkIlQeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVXnvK5/RycZ8URbl3HppnmkMSkGMNswxsfp7PH4TfqN19CXF3mR8ef0LRVDIsOTw5eR0qkNDOs+4Qot6Sm68O5CLUHu/l2QaJ604sygAzSHg41gNNcPbDZqBxyyuZ+Q0O7Q6cL7W32ho0ELqQe2LtZvCE0tbZ+jeepa9q7BEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mMK2XaBZ; arc=fail smtp.client-ip=40.107.75.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsSK0GAEZ9aEhqzy5g7QIANxd/Pd6Mo2CLvmcO9ZniZgmAn1ca3qIA8gnZdNBL5NtARqFSy24yM62MeyhVLeUAj9pB6ngsNaPU2hdG7+cXh9oFqy5qAFkqjez3SiDQVsVXWn38jwe+ypFr7YmOoV2pidMYXGMoX7qaVKvLW5zSHxAnwYMii0x1Y2grHZvKg+Tp0a8gQ5qdtLz5fCv+uraAhKw7vdzp4Qnwc3nOpwvGUVjGAu+v38uGwBnFQ2mNQ6mJ94KNp/IPtCDzjlavyFtvjf+ZGoCr8dFm8mVo2fzWbKLW6tTVLDk5m6KZuMjDNLSw3D1ZeWdgEf1bFSkWR96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJbg4ZI3pPHs6Nk/nl26gYGNF3T+i8Fsyu/ZTJ56dq8=;
 b=a7c+cIHlr7LWLTRdqJqF+rNNB+3vXW3xoHLtf1kVtBChqlJi3NmBSozTN0RrpFRQmtYic8E+WowqZZnD5Ayhz1v8xNpuKTxeqsBV5v8xzOSnoXUEzT0vtVEdHR5U9xLejJR/q/+U2u/aKN2UoMxtOCW0xW+j4JHHdN5nJm72q0OMkPtYAx1I+7WNrbNGihDL5fnrjcWQRoprlksKo4bcYNOfYkESW4hNtMzJta+0+x3lJS6s2qzfm6MYM0qtUgovlF0OGeT0JLoDTVxfrqIjsaR+IdPQCW1/D/yfHb+MI2qrdxhKcAUjNi79/6bd3VymOF6KUhB4TwCTExZSNjA5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJbg4ZI3pPHs6Nk/nl26gYGNF3T+i8Fsyu/ZTJ56dq8=;
 b=mMK2XaBZTfKvDqNIRQv3+nJUgs3IOz2uwsQAWRB6m6OOSPKEHzNxNMVumnfBH5D9hwgKy8jJEWjPhOp/px2hjpFSiMiUXQsrVQXhFI38dRl0SK1Yv5a0OFu9y1UZ/xyHLt+j4zfwN6YJOtEfnb2Jz2yn+tp2dWOs81KMXriDyuejAFOqMvHbm1sA6kYCFumYY7jXVayDa54Mw+rQf/kqnAt7PyNo4gNPhKDW7x7UbkS2hbHuBPbHboyhUk4QbmyJ9S3YN59hsEHs9VeymfKGjaPxvni1Ulva1RnciGQqj4/TNR4+Pm6Up2evzAXiTwbecVGZVlVEiXH407H/ELTIjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB5931.apcprd06.prod.outlook.com (2603:1096:400:340::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:07:52 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:07:52 +0000
Message-ID: <fe38e328-5e64-44b2-9e62-f764c4b307bd@vivo.com>
Date: Wed, 10 Sep 2025 22:07:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
To: Barry Song <21cnbao@gmail.com>, Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Brendan Jackman
 <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Fushuai Wang <wangfushuai@baidu.com>,
 "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: af2a9725-8167-420e-aa1b-08ddf0736e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|42112799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0ZjeEdtdlBjSFJ0aW5qU0dVYWlydVFvanJ6MDRzSml3elR5RDRJNmpZa1RX?=
 =?utf-8?B?akVEVmlQNmNsdHZjamlFNWh0MzFiTEN4Ni9sWXJENlc2a2RQSkhjaEdQaG1s?=
 =?utf-8?B?b0dxeitab3RrREdWdk9PSWFIaDFUTUJNNjJxRkFwZGQ1UWhieVlOUjZXTk51?=
 =?utf-8?B?R1N0aCswVG51TFhwUlYvZUFPTlhpcWhuckFZa1lPOUcyM09KVEFiUDh2bU5n?=
 =?utf-8?B?VUZQTTkyRUxwa3FoVll2a2NxaGo2WFB2RjV5TW1JQkJPR2xzZ2dOU040NUp6?=
 =?utf-8?B?aW9JTnQxSWhFV2hiOG9lcjMxU2lmM3IycnB1WFpUWWdVZis0dDM3V21HUkdL?=
 =?utf-8?B?MGtPK2NJYkxEbFkxdW1uM3gwZitadTdPZDQxeVBZSmJpem9MR1RqQXFpTXdh?=
 =?utf-8?B?VytNcXJlMEE0c0RpOW5ZTGIySDhBV0xTWW4wcWZVdW1WQjZuWmtPY0FQZ0pZ?=
 =?utf-8?B?NnhsWUppSWNSdC9yZDMxZks5ZEFvNlhSL2Z4KzhBVTdxM2JXQi9uZGtJT2ZL?=
 =?utf-8?B?NC9RSGdaYzhnek9HREExR2diclN3WkIybFRvVVJ1eUUvVVJ1MVFNNFRGYXll?=
 =?utf-8?B?a3BMQ3R0M0JUdkxjZHVOWVZUZlVDMFlrVGlZZ0l3bjA3U08yUWhReXMrSUJw?=
 =?utf-8?B?VkFoUnhQaU82cFkveitWa0N2Z2svRjFUQm1OV0lYSkIwdkVCR2RvWWpLN1Jm?=
 =?utf-8?B?Q3M0V3NIZ05ybjJZOHZkblBUZzB1aWRhS2JDUytnWWdwWGZEdnZyU3N3amNT?=
 =?utf-8?B?bldmNGlPVzFreEpQcVQ5bnhNaGwrVm1OZ1RvWFN0VGwyUFE2Y0l3SVBMSHpV?=
 =?utf-8?B?alUrZGtIOFBBNUtkK0dJT1FvT2xiL0c0NVVaT00vZHJpVXBXMmJDOTNYUnB5?=
 =?utf-8?B?NUxnSHRYRFJ4RnVIb0d6Z0swdi9ML1ZOVW1uaFV2Qjh4MjU2ZTBCbXZIckM0?=
 =?utf-8?B?QzhDWng1RnM2R04yY2lxbFpMU09OZm0wNzc5OGpZa3VrcTNEcUExdlA4Z1VD?=
 =?utf-8?B?Wlh2a1lmOHV5d2VXOC9KUTFoN05NRmd1b3FJdmdxdWg2TWRicmZkZTcyZGM0?=
 =?utf-8?B?eVJhcE1iNmpiNVgzL3BPM052YmNBNVFNVzdHREdrVmNGQnVZQ3kyd1VRZFhq?=
 =?utf-8?B?ZEJocTF6ZnVwUk93Sm1qbWZqOTMyKzRnaUkwbzIxclNPbzhTZjZEeUlZajVn?=
 =?utf-8?B?NVFKOTlMTXM4SWYvSmx5TWF6QjRSa1psWFRuOGVBd053b3NuS05QcHBsT0t4?=
 =?utf-8?B?Sis1b00zYjRjWDJoOHl2S09QelJzWERkYS9NNU0xc0E3aVEzZGRHb3lqVTBK?=
 =?utf-8?B?TDd2bFVsY3lYdEZkQVhXRmVjN1Z2MlRsMDlIWU5Kb3RMbjZJTmpBREhHdlU1?=
 =?utf-8?B?N1NIdlp3ajVGNUZaQWxDdi9vNlhWRTR0ZXVxSFVsSnB6c0ZGQjZsclRGNVpy?=
 =?utf-8?B?b2thaG9oOFFtVXFpWXE5N0xFbVc2Y0QzVU5zTzVZMlQrVDlCdzQvZWZNRXU2?=
 =?utf-8?B?WkxTZTRxYXl6SW5WNy9yOE9SM3hTODM4azVyWk5oQzFsRVk5RmpzeGQzcEdD?=
 =?utf-8?B?dDRON3grK0Q2anVobjlrNC95a0NicXAyZFJ4OVRHSG9qUWcwQkNLVzM0OGVH?=
 =?utf-8?B?RVdKd3FJVGFJUkZ0Nk8vWjVWWnlRZFhPRFlZYjVMQ2g4a1A1WHpWMDA0dUZt?=
 =?utf-8?B?NE52VmdTdjBsL0sxTEJsZ2d6OUpGeFZsblByU1lhMStpbTc4NlBCZFNRWGNF?=
 =?utf-8?B?YjRzbHliSk40S2VPNHRWWEJtMzJwV2JhZ0Yvb1JLRmRsZkFWYTNvWFhuNlMy?=
 =?utf-8?B?UGJ1YkQzTVRDZ21DL1pUOHJXZ3RTbWFsSWJ6VkVwcXNLOHpjMjZoMkQzQVFj?=
 =?utf-8?B?SWo0ZHB5QmNPaFdMZHV6S1VwMW5iZGVSazR0MnhPeGtOQkV3cVFPT29BSk93?=
 =?utf-8?Q?QJh0JKkGF4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(42112799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmcxVDFWZlVzZDY2QklCQ2lRRFRRd0ZDSXplUk13R1E0TmE1MTNEZWhaTXRD?=
 =?utf-8?B?M09qZDUvM0tqU0MyL0l6Nyt3d3FGUzFmSURpTDhDcmlCdktKdkx5R1lDYzhp?=
 =?utf-8?B?UkxxaCt5bzJreFhUSkVmbzdQWEVWbHhaWGIvZCt1WkxxRjVMQU01d3diUFQ0?=
 =?utf-8?B?ZFFGSkxnOSs3VlJmUGJLd0N1ZEl0enRSQXdYbnRPUW9td08vcHJacXZYVXUv?=
 =?utf-8?B?aGQ1SGhNd2xOYlFldytYb3lGN2xreEVFaWNMRzNpcDJtMWRNTzhNdThRckl5?=
 =?utf-8?B?eDNJL1FVdGt1YlBqdm12NlpaNWliaUdkSHFRcDRyYlU1b3d1WG4vVnJFNGt0?=
 =?utf-8?B?NnpEbGlIQWc2YVJWTEplNk8wM0ZpaFNWSG1SWmFQQ3hhSWJnNnJQNG16R3VF?=
 =?utf-8?B?ODNBU05vTU50blRSQUF1ZCtjUWlENWxxRmJsSzEzT0FmNU1aVi8rM0RjaHE2?=
 =?utf-8?B?OGlQbitPRlAzVVVEcjdGYVM4M1FkRjY0NDZtbVovQUl6TE9oOHloSUY3Mm5v?=
 =?utf-8?B?Tk1lczg4bnNGQlRnc0k3dFlyTUhWZ1pIN3hBYSt2SEpibW9qRG1wbmFIZ1RF?=
 =?utf-8?B?QlBYOHJ0Z2hXa29icWNCcVRBeFhkZDIxRG42dkdvOXFvRDVnS3ZjVjAyNWtM?=
 =?utf-8?B?M3p5WFRNempzeUxNNGk3QTlEa1pCSkQwMjhwcWRUTTVoT2lML3dQSkg1SlV2?=
 =?utf-8?B?YlJZRnphQnRuZ3J3RG5IalhDeEtlRmJMbXRIZ1Q0WWxVRFAxN21hSTVhZlRK?=
 =?utf-8?B?Mlp1bnEzS3VIMlpVbW16L3o2aTN1clNhWFlpR3Z2V2gzbGdYUWhNS05RTUNj?=
 =?utf-8?B?S1VOaHZnQ1hsZE80RTFkWE9xRnZEemZFVlNMYTBOTjUybGhoMng4UkdJMitH?=
 =?utf-8?B?MG9KTjhoUUk4ZDBPY1JZNDdySUt6TUo4TExibkdFcVN2Q0wxbDVGQ3pxV0la?=
 =?utf-8?B?VkdHZkt1SkJUR3pHZjVkS0FYeiszOXVxRTZaaVhQazB0VzBpeVA0a1ZHUjNY?=
 =?utf-8?B?V1BLVi9IUitBNXI3RUljV3IwVWJMd1NqK25WdTBKQWplSHI5bVhNcDBFTlhv?=
 =?utf-8?B?OUhIK2ZiWmx2TENPMHkvM2Fzc1B3VWpYL2tUWlNSb0RycEFrYWNrQlNQd0Q1?=
 =?utf-8?B?Nk9Kd08xeU1jcVBqVFhUYmhLeVdMSnd2NE50b1l6K1lYNk92MG1HR1hoZWUr?=
 =?utf-8?B?YmtMSGFyeGtyc1pkUytUY25XdzJoMEhPUmZJSlBydXliNythSGdVVEpBNXBY?=
 =?utf-8?B?ODREc3ozV3FUV2JWcVdTMEVnWlhCM2paalNYUDR3VlJ0aVVVQ3dVckdxbXNX?=
 =?utf-8?B?blVyeDdCamwvY1dqVzVKc3BrVnBhTzRIYXFpWkhYK1FCMS9PT28zVi8xdUdQ?=
 =?utf-8?B?TjhqaXNHZk14SnlhL1lhRldsTW9sejRZdHd1NXhNYTNCOC9IN2M0cUduUFhD?=
 =?utf-8?B?dFFqN3ROQmR3eC90TzZjR2R1ZlZRMERWZW5wVUJMTEdER3lLRjdEcVhaWjU4?=
 =?utf-8?B?Z0g0eEpiUk1tOS9HcGN1dG9jbFdjVGpKUzdOWkIwdHdZY2lzN2JpR0VZOXdP?=
 =?utf-8?B?d3VuZlgvZko0UEsyNTJmNHh2N0hYcWo4U0V5UzdRZWtvTGhRQUFJY21iMU82?=
 =?utf-8?B?OGRDVFBLV01LN3hkOHpVTEZEY21sNzFzSWVrQ21OT3ZCeThXYlVjektEckpO?=
 =?utf-8?B?a091N3hKOEhHYVBxd1hoeHNsbTllM3pOdE5QQzRwS3Nybm9LV1hrN0hjREpL?=
 =?utf-8?B?WG9URExqNzloMlZlUmRMcDFlaXpyam5yV1pKMUd5anhDZXd5eHNkYm9lRUt3?=
 =?utf-8?B?amtNT05NZlBqVE5RaU1hTVAxQVYvSDAyZVRTY0o5THpadXYyamF3VVZnY1RY?=
 =?utf-8?B?RlZwb09hNE5HbTBjckduV0tGRURFOWVFNFRobzFpZUc1bTlKSWx3cHZFZFpZ?=
 =?utf-8?B?azloL0pJR0QvUlNqTElTSHYzNERzSkNLTk5EQ1E4SkdIeEZaaE94bFI1N3Fy?=
 =?utf-8?B?Yjdoemw1Szl2MXpLd1E0YlhPeE9DeWFzM2JlTko1VDdjaTBaR2lhZDFWTllT?=
 =?utf-8?B?ZnhjSEJVYXZmc2g0Ui9lVEk0WmdHODlJN3p2TytvNGNyZ3pmNmJIek5OK2dU?=
 =?utf-8?Q?3DuDZDdo2ejIBgZNN0XdXHacv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2a9725-8167-420e-aa1b-08ddf0736e3f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:07:51.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0oM7n09VMzvUjFkBlvWxMwW/wxQTyQnP2VTxJ3sZIrR0K+XMyD5Bll8lIROAXW+Dxg75DWf9TKe6Ko+Buu1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5931


On 2025/9/9 17:24, Barry Song wrote:
> [You don't often get email from 21cnbao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Sep 9, 2025 at 3:30 PM Kairui Song <ryncsn@gmail.com> wrote:
>> On Tue, Sep 9, 2025 at 3:04 PM Lei Liu <liulei.rjpt@vivo.com> wrote:
>> Hi Lei,
>>
>>> 1. Problem Scenario
>>> On systems with ZRAM and swap enabled, simultaneous process exits create
>>> contention. The primary bottleneck occurs during swap entry release
>>> operations, causing exiting processes to monopolize CPU resources. This
>>> leads to scheduling delays for high-priority processes.
>>>
>>> 2. Android Use Case
>>> During camera launch, LMKD terminates background processes to free memory.
>>> Exiting processes compete for CPU cycles, delaying the camera preview
>>> thread and causing visible stuttering - directly impacting user
>>> experience.
>>>
>>> 3. Root Cause Analysis
>>> When background applications heavily utilize swap space, process exit
>>> profiling reveals 55% of time spent in free_swap_and_cache_nr():
>>>
>>> Function              Duration (ms)   Percentage
>>> do_signal               791.813     **********100%
>>> do_group_exit           791.813     **********100%
>>> do_exit                 791.813     **********100%
>>> exit_mm                 577.859        *******73%
>>> exit_mmap               577.497        *******73%
>>> zap_pte_range           558.645        *******71%
>>> free_swap_and_cache_nr  433.381          *****55%
>>> free_swap_slot          403.568          *****51%
>> Thanks for sharing this case.
>>
>> One problem is that now the free_swap_slot function no longer exists
>> after 0ff67f990bd4. Have you tested the latest kernel? Or what is the
>> actual overhead here?
>>
>> Some batch freeing optimizations are introduced. And we have reworked
>> the whole locking mechanism for swap, so even on a system with 96t the
>> contention seems barely observable with common workloads.
>>
>> And another series is further reducing the contention and the overall
>> overhead (24% faster freeing for phase 1):
>> https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/
>>
>> Will these be helpful for you? I think optimizing the root problem is
>> better than just deferring the overhead with async workers, which may
>> increase the overall overhead and complexity.
>>
> I feel the cover letter does not clearly describe where the bottleneck
> occurs or where the performance gains originate. To be honest, even
> the versions submitted last year did not present the bottleneck clearly.
>
> For example, is this due to lock contention (in which case we would
> need performance data to see how much CPU time is spent waiting for
> locks), or simply because we can simultaneously zap present and
> non-present PTEs?
>
> Thanks
> Barry

Hi Barry

Thank you for your question. Here is the issue we are encountering:

Flame graph of time distribution for douyin process exit (~400MB swapped):
do_notify_resume         3.89%
get_signal               3.89%
do_signal_exit           3.88%
do_exit                  3.88%
mmput                    3.22%
exit_mmap                3.22%
unmap_vmas               3.08%
unmap_page_range         3.07%
free_swap_and_cache_nr   1.31%****
swap_entry_range_free    1.17%****
zram_slot_free_notify    1.11%****
zram_free_hw_entry_dc    0.43%
free_zspage[zsmalloc]    0.09%

CPU: 8-core ARM64 (14.21GHz+33.5GHz+4*2.7GHz), 12GB RAM

Process with ~400MB swap exit situation:
Exit takes 200-300ms, ~4% CPU load
With more zram compression/swap, exit time increases to 400-500ms
free_swap_and_cache_nr avg: 0.5ms, max: ~1.5ms (running time)
free_swap_and_cache_nr dominates exit time (33%, up to 50% in worst cases
). Main time is zram resource freeing (0.25ms per operation). With dozens
of simultaneous exits, cumulative time becomes significant.

Optimization approach:
Focus isn't on optimizing hot functions (limited improvement potential).
High load comes from too many simultaneous exits. We'll make time-consumin
g interfaces in do_exit asynchronous to accelerate exit completion while
allowing non-swap page (file/anonymous) freeing by other processes.

Camera startup scenario:
20-30 background apps, anonymous pages compressed to zram (200-500MB).
Camera launch triggers lmkd to kill 10+ apps - their exits consume 25%+
CPU. System services/third-party processes use 60%+ CPU, leaving camera
startup process CPU-starved and delayed.

Sincere wishes,
Lei



