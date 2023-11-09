Return-Path: <cgroups+bounces-275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DECF7E68C4
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB4BB20EF2
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869ECD29A;
	Thu,  9 Nov 2023 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T5Xw6BED"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE4111AC;
	Thu,  9 Nov 2023 10:50:49 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBB2696;
	Thu,  9 Nov 2023 02:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKlwad/z3ReKArjKsKniVfxgwQQQm7Nlx36qYx5OQFdvriIcXbAObgccfEwCo7VhTub6EA+wKBdz+xTzGuSXOTSYVBO1CFMxDJQcqnrhjf1fCB9py11dVrX2oBAI4SifDMZ3sYz4V8AAlHU76MmlxXrHImRzAx/AZL+ezwodlMbVtg3EF0dVttRFbfy0EgJbVeoGNmiY49M7KAgGKK4+urDtQQIsVdWwtDN8+ozKkTpDXUoc3SuSLOYaaot40MInvaJlP6+QkP26fkF0dUhDWmtJD2YDgiplgeZupyLGCle/gFNzNsTOPpXd0cS0acMcRvu2HBfkoqrJjXcqGGd9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggcKLMvdLHqgY//Q45yfEjPpnHKeuiUH7SStWfpBvRE=;
 b=j2fJTNBrDMsZS02EtvRUrZMgruXdTpOMyiAj5p6/F2halVMx9mcupuZ+m0iB+hYkTfRDRKAySUC5uHYggMGvPn6UC+S7kDkpTRBKuw1iRUAleGZiQThVdW5c7WzVCcXoC578wwcCl2WGHy9yL5jEunwkelLb6pAZvKL1RBTUcroywpQeLGk4JRJqPb/iHyTZIMk9aW0lEIT8yy0ezKiA6V0VrghoP0pUFambV62HnLFTri4BqAm7PbxUJeI75gdf2aF7z86dXcB2pka31QCR2y06JdD1OazU+N6XlSZ3bMBVX07MzLCMve4hxpHDFcSJtfdVm9nbIlZed8wAHNQqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggcKLMvdLHqgY//Q45yfEjPpnHKeuiUH7SStWfpBvRE=;
 b=T5Xw6BEDNuPYSpG9U7Mm7yZfMMzrNDCcfvde2BGomCCs+ChbHlrhFq5kGXSQ3ipmNdDVhWbw8H0Sat84ClgNtmjKLntXrGZDu7r5ZYeaEkGvkQFHtUaKBRRa9q5S26jRCdR4S1bH5Hi6fW0CczL7jV0naBA/WOtAnsODzEU+u2SIUPeJEGxL42Q9Fy6u5dEy3bRr8lApRu2+dShWVE2BKZttkw37UMIOt2LoH9sPMBt8lKHTUqNjsKyoH8E3cg+nk8ErAJPilqlNB3metG7T1PR5SVo3HNThUIz1eonb2iFthBETLPzRsh8hpjkvdtrk/VC7DF+Q/fbndDr2/n0Vvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB5894.apcprd06.prod.outlook.com (2603:1096:820:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 10:50:42 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 10:50:42 +0000
Message-ID: <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
Date: Thu, 9 Nov 2023 18:50:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Liu Shixin <liushixin2@huawei.com>,
 Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka> <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUy2-vrqDq7URzb6@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e0bc11-1041-4f6a-4aed-08dbe111b804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AB/5KpG7otTa9J9u3n7Y51rRwHd06bM5X7WRYPILic7TepoPQ4POtAmpvSdnhsAIWa6WA3R56vomWirQtzHPHGsrXJ7zDy3v1VUUpADmEPkkbPXtTRhuk5zm33H9TzqeD7p+PjBdE2hzBpa5mH/xyVD4nOOV6/vToedQKl1rbp+4EwGXlfjrHRfckplna/ngQx55SsWTpFLitGR4HBu9ZMUgUwEAbWdb5sjLmfsghd69ql3mV2jliNY4wE1r++TiG+uRicX6rpra7OU14oIkZFuHW6wwJ0Rv3yQnU8mrZrw4lg2Mz6EpqoxAzjgBv8AC5unDZd37SoKVlXSIjwYU64nlwMDLjiVM/gfdF0QlTWibXDxL35gCNgkUal7txD+VBPSmI/S3kjU4iffWvcNXWQn3ndeCrDCVzk44P4hHsrUGnGbGQUROsPNS1u9lDWtT+Rm9Yndb3uKTM4cakmL9ZWLqTCjWvH12OHz4GoooguUm1ppuCBHWXQFYh5IaG+O7FC4ZyM9vRD1kk4k4+BUMB6pmjHPpFYbjkEAnhe/5+XhIU8DROEvAlOTpLYCmtC+DlDxf0Ccu6IaX+RuApBAyJLwjWTQl/Gmsrfeivsp8EwIMeBy7EMFbGHV5PP3XnqQJEmOd/fod/SgKi/eq/+6l9wfLfdfJdcercK9Nt85Vy3KGXxf/iTXeFg7iAj7bqcW6jbrfgl5SgoM16hS/Ba7mEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(316002)(107886003)(38350700005)(2616005)(83380400001)(66946007)(26005)(6506007)(6666004)(478600001)(52116002)(966005)(6486002)(6512007)(66556008)(66476007)(2906002)(8676002)(36756003)(8936002)(31696002)(5660300002)(4326008)(41300700001)(38100700002)(7416002)(86362001)(6916009)(31686004)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhoTkorZ0lEbTVhelBmRitZRUNVUDlKVitFOXF6b05hUnppMHZIMDFPSjFJ?=
 =?utf-8?B?VEVvUWI0eGRqckpON0dHMlB5aENpcUUzRnpZMnhwUkp1NTVwaGhuOWl5T0JG?=
 =?utf-8?B?L1p1bzhieTJMUDZRdDNobUc5N1N4MU83OVVRdGVWajBmVjFqUGhKWllvejVs?=
 =?utf-8?B?UDliaGlHRFhzSnhxRFVpc1pBek9VWkRwNmdXYkxHVWE2WkdpaWU1aFd6Szll?=
 =?utf-8?B?SHVCUkRYWDZ6TDRXTlVmUGx4T1FFaStuckNMTFVFcnU3Y0lWRWRJaFpGdzlI?=
 =?utf-8?B?QnZVTjFQczBIN0lMS29EckpkeGZHd2NWUEx1ZFUvOS9UeDZMalVhRU4yVERB?=
 =?utf-8?B?Slc4dlFYK0pxWkhESUtOWHdqZGIrOHFManFzMW5kNEw3RWVSRUJrUkpFZ1Iy?=
 =?utf-8?B?ZzJjZXhOK2syc2NySUVEckRwWG10RUpwcTQzU2JpZmpkMU1HVTlxamlOekM2?=
 =?utf-8?B?djZ6eTdzZ0hPMjdtbVNUN0xqb08zRm1PSUFSZ3FMY2d4N1ExKzFXblFGMUN1?=
 =?utf-8?B?M1V6QVB2YTJYWjN4dW1yeitydkRiZmpWNXZjTFlOaUEwVFpSZFFVaFRhbjRM?=
 =?utf-8?B?WUFPdFdZUy9qbTRrTDNkSmw5Z3l4a3ptSStOb0V3R3ZmSk1wREdvTGpsanZU?=
 =?utf-8?B?a215d2IyK1FkYU1JTUxDRWhIUWE0SlhkTWpvTlcxU1NkNTZDU1FSWG9GbzFL?=
 =?utf-8?B?aUxXbDJpd005azlyU1NqVGVNQm9HQnBtOE5iRm52c0dxbFF6OURDYnJneTVG?=
 =?utf-8?B?ZzZwVTBqRU04cC9FaXVkQlFEMVZqbXlYNGVXZjJpR3FhaVJKUlIrR2UzaWZO?=
 =?utf-8?B?MGlxaFc2TmUzaU13YlpUMkJyZko3THlVNVkraEJUOXZES2U0U3ZPWG9nb0FB?=
 =?utf-8?B?SlBOUk9qd0l1S210cEhkZFd3c0lWcVV4L1FSVkJTeFA5VnBsb1NjSDE1bDVV?=
 =?utf-8?B?ZzBqdUlaalJPclhBL3lJb0R2K3J3bFdicE5qcWhmNkFDcTJ3UzVLUWRFeFA4?=
 =?utf-8?B?VzBqUWhIOWVNS1E1RWxNN1JyejFnOVVic0NUOEpqdjlPRktVRkwrS1d0dHFh?=
 =?utf-8?B?ckhPTk9PVGVrSFZpbEJRb0xBOXd4a3JNeTBXOVJQQjhDcDBRazBQVlV2VjhD?=
 =?utf-8?B?Q0UvaVJkcFUyOXBkRy9jWjdWNFluMDVPRUsyR1ZKQ1ZZV1RmMk1oNnF0WUlN?=
 =?utf-8?B?UnNOaU92am0yTndpNlZyZkpmUVB6ZklnUjk0cnp6N1ZpdGpzbFRWK2hLYUdy?=
 =?utf-8?B?VGN6TGNOTmRTT2F5dkRBalZHWGFuS2lRU3Q1TXVtaDFsek5Xd1JvcGM0d3Ew?=
 =?utf-8?B?TFVVVVZBVnFqcFJ3NHJYVkdqYjVHOWNDZTFITzg4TU9XbnNESXc4a1lKdlVR?=
 =?utf-8?B?QmVBUjRhYllRbEJSMU1GRXR2K0pFRmxYenVmcEV6eDFtdDd4U3U4YnMycWdO?=
 =?utf-8?B?a2hqN0lRVGhiRkN4WXZSU2tGMUNFS2h6RWtIcm5SMGMrUDhjMk5NM2lGeEVx?=
 =?utf-8?B?S3NFblBWWlJWc0JLNHFSR2l4WGRWSnFGUW01NnNVSXE1dDhRcWdRQkR5c0ZR?=
 =?utf-8?B?TFV6K3pWcUxWT0tXRG5qL1VVTXhJbk9jekZyNFFMOTc0SXN1MVM3RXcwNmlh?=
 =?utf-8?B?WnUxSEYzcnVNK3lsZUNCYWpqUFU4dmhTYjdEMkhYM2ZKNHE2Q1RrZFRMMExE?=
 =?utf-8?B?QXRMY2FKL2lGZ1BjUk9OT3I4ekxRUjFwVUdOMVEvMGwyOE5vYVJuR3RpVDZi?=
 =?utf-8?B?MlB2QTNoc09mSUMxSFpVdFNCTXl3QXhEcGZqYVhWWkJlSERNL0IrdG9DOUpr?=
 =?utf-8?B?eXdYRnplRFNhQ0pOUTJaTHFHQmZSazIzaExRdWhQUHpldVhRVlhsQzlFWHJu?=
 =?utf-8?B?cVJpM0VaWktsN0lsUlArWWJNNDlpL1hGT2l4MzBaRnFuR1BmUUp0RWNLNHZY?=
 =?utf-8?B?cnJINmwzWk1YRzZBcXJjcitHTUx5eFZUL3VDNHBuRjNGKzRXWnlzbDN1d094?=
 =?utf-8?B?dlhZcVo2UGYrUDBKVUVMN0NoWFJ0UERqWnhMOFBMMGRiS1pYdzRQajFjV3dw?=
 =?utf-8?B?T2RjNXhGSXN1Vk9UeEVvKzVpVlhod00wY2tYUjE5NHBDZmlvTC9TZ0toL3Ix?=
 =?utf-8?Q?arNBALqbbHRz2+6odcuqr5ZDO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e0bc11-1041-4f6a-4aed-08dbe111b804
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 10:50:42.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDnQLJzRgCc8Uw6RPMWq6svplb54MFeEaCNum0BoZtyp568v9aINVKpcS7HqKVla1kFCcwkimX8E+dfl1HyebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5894


在 2023/11/9 18:39, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu 09-11-23 18:29:03, Huan Yang wrote:
>> HI Michal Hocko,
>>
>> Thanks for your suggestion.
>>
>> 在 2023/11/9 17:57, Michal Hocko 写道:
>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Thu 09-11-23 11:38:56, Huan Yang wrote:
>>> [...]
>>>>> If so, is it better only to reclaim private anonymous pages explicitly?
>>>> Yes, in practice, we only proactively compress anonymous pages and do not
>>>> want to touch file pages.
>>> If that is the case and this is mostly application centric (which you
>>> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
>>> instead.
>> Madvise  may not be applicable in this scenario.(IMO)
>>
>> This feature is aimed at a core goal, which is to compress the anonymous
>> pages
>> of frozen applications.
>>
>> How to detect that an application is frozen and determine which pages can be
>> safely reclaimed is the responsibility of the policy part.
>>
>> Setting madvise for an application is an active behavior, while the above
>> policy
>> is a passive approach.(If I misunderstood, please let me know if there is a
>> better
>> way to set madvise.)
> You are proposing an extension to the pro-active reclaim interface so
> this is an active behavior pretty much by definition. So I am really not
> following you here. Your agent can simply scan the address space of the
> application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
> on the private memory is that is really what you want/need.
There is a key point here. We want to use the grouping policy of memcg 
to perform
proactive reclamation with certain tendencies. Your suggestion is to 
reclaim memory
by scanning the task process space. However, in the mobile field, memory 
is usually
viewed at the granularity of an APP.

Therefore, after an APP is frozen, we hope to reclaim memory uniformly 
according
to the pre-grouped APP processes.

Of course, as you suggested, madvise can also achieve this, but 
implementing it in
the agent may be more complex.(In terms of achieving the same goal, 
using memcg
to group all the processes of an APP and perform proactive reclamation 
is simpler
than using madvise and scanning multiple processes of an application 
using an agent?)

>
> --
> Michal Hocko
> SUSE Labs

-- 
Thanks,
Huan Yang


