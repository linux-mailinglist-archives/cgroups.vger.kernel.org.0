Return-Path: <cgroups+bounces-343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A17E944F
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E98280C00
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 01:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE14F46A6;
	Mon, 13 Nov 2023 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fz6URQgD"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA5522B;
	Mon, 13 Nov 2023 01:55:10 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049A1729;
	Sun, 12 Nov 2023 17:55:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn7eB+ar78y1xBGo0gdQ77zoiaxjk7AxBKRpI0eRlMQKMWDkiwim72ozMX6Iwod6xAkpbxJqaQTBL8KkiWoGc2t9b66XWUvQE+JE90caW8dCig/1Vw3y3P0apbGaKE+wH4Cd6xXFLCkcl+J5DaPWi6w14HUCTKA5K7hacv+wKxveO72t5+IW6qWM+UuuPHTRpdW5fM/eKFkMqXu6gCKxh6RUfyo2Y7IAUhMO4nD1t0g0ofZlaOc4m3uVNcLVmeR0tLBTzMYDJsJ/VIBUXU61M/z6/i7WhuL1fA2IBEhIYA/L9WCRMuVyPnNDpYmhYn/sNw/Dl44PjXTNbwcuN2zqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLmFBl6yGgF/I8rnX5q3yJ5aPzhbTwL3y5OGC40REa4=;
 b=eFpHwmIlsK3y1iC8zwf4CA+L/HWOW9SGCvmxYt8YyyZkc8gUfmqxUa8YB7cMh8b7lBCnni0T3Wg6Btsid28TJe3NWFEKr1DAkebsl/4OFBq3mB/4WSfZtd8jVXpFT1FWjOMxiIW2RLcta6gqmGlTQTUp17KV5Mm4DI5eFhEIQwzDW7GtK0PBIMDOwmObJbkM95J3hSKy+BsCxKyf2/yhVPSkBjmnY54yFerPDGX3jJCx6CGT2ZFnPXhS/feIe19u65ltDhl/tgkLHOKrDOMc1ylRaoVIWbK6z5i2DlM97gDSh2cVherAwI1AtBCuwcEUJDCeygzgBmF5v/jtPEoAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLmFBl6yGgF/I8rnX5q3yJ5aPzhbTwL3y5OGC40REa4=;
 b=fz6URQgDbZE4e9d6Cq6Pwt6V9ZkEdb/HMXAmbkVW6CTytrs7BkiDdxPTrajjcxiklPBZ7uqMtRq+ph+jp1ypiAxQkkiaRTsWua+HQ8S6q9ObSrUOpfaEFlmPcfoTzdMBYPlr26zKVU0DkceEAVVBDMM+YKbe56xXR+nSBMbM1ISb8XkWaFTRI00HCjNp8B5UzAAVG3CIdj63HCCvIZeIGtfJMbQSDVXi8lva69bDAHWDDGpHX9+AsHOAIcNZyK3DZc997Ra2YUjTcb7+sahysI/hSO17HynFoknmQZpyS+SlPJhzY+g1D+o9/jiOxcqOPnwK/FrqxFOB/cCOGk0luw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PUZPR06MB5953.apcprd06.prod.outlook.com (2603:1096:301:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 13 Nov
 2023 01:55:03 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 01:55:02 +0000
Message-ID: <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com>
Date: Mon, 13 Nov 2023 09:54:55 +0800
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
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com> <ZU4i36tKnyXZ8lZD@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZU4i36tKnyXZ8lZD@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PUZPR06MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: cb07e866-d9a0-40f8-02a6-08dbe3eb8ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FY2ZdI0W9OPD6Y0e3VXs9LHZYHca2IFDP9eEI9lHIXULtVrq7hfub7HkUJGZK631VRXgxkoT+bAtzaxpbdzHTcPCFhad4oHHdqSyUn0ZBxGCPi3x+ZaoIemwBQInYNR0UUOZaUtjuEI6ZNASgIAgCXrAJjZtcDqDVCxj51SUMlOvUIWIqLGZeqLWu5XmGTVOKimD0yj70R5xrJAAHKvdVqBeDMTWZdM7/ChGWWWEUe+ZT7vECYgicVg8iSOS/2UgnAKwbz864pWbSaMvc01UpL8BqGSe+RPgCspFVLwJdQGrzuS2Kmf36TEh3ka3HowkgPCVRgVOI7sXt9xxegEMzjZ19U9GUqY+w44qrvpBdIWOZ/AJt0fDU1x+ZIEiC/mAdkcrdyzJ/kTEwLbwvNzY+VXjBnuH9IN9fGyRTQO/9StuQfybrQ8HxqMzjOMWo0cXbtiuqDc7SmVUJRQRUWvBfVRw2QXGDfVW8d6m52pjTrND1zP/ZeszjShoFDXl9kMFU0D20G9hZISw9c1KFmhbap+ThZb5t/2Rv5AAeoGjc1GoFMwnSCWZRmujnI03JFoz5EYuvi/cjt4GPUOT2V4XOMCPj1IVbfOMe69q1Axx/Z09v5i7Pps+EW3L0/5WmvUav+qvyGs4aW6PD8WvJktzAd6YXox8paVcEhoOK07B5CFHJiEWLUUVCAOaU9CyntpN3VK0K1evrqY+/R6g81IZyUF3/auLbHXfPukUV7UuEfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(2906002)(5660300002)(8676002)(31686004)(7416002)(86362001)(83380400001)(38100700002)(41300700001)(316002)(6512007)(8936002)(4326008)(107886003)(2616005)(66899024)(66946007)(38350700005)(66556008)(66476007)(31696002)(6916009)(52116002)(6666004)(54906003)(6506007)(26005)(6486002)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHpRNm1YNWdRY3g1RDdPQVp3OHQ1Y0NIc2tLZFJzUHRGTzR0UmlpM1ZmYUJH?=
 =?utf-8?B?VndUZmcvWTB4V2lranJzQitHOXhOU3lGaCs4MFJObTZyMFFHZVB2SlEyc1pp?=
 =?utf-8?B?eGVIYTltOUdrWDV1UXAxYUJKRDRUa2l1KzNxZDBQUW5hMnhHODk4dTIyMnY2?=
 =?utf-8?B?S1c3Wk5qRG5zQW5QOU1rRVN3U21naGVxWGVnRUpTdVRLT29JMWFzdmFOZXQw?=
 =?utf-8?B?WkZMRWZxeUlYN1YxUTRIYmFneGNSM0NWVDNtRWZVdFkvV2l5SlFGUnVJbFNj?=
 =?utf-8?B?SXk1aW5aTzdPL0FUamFtRCtXL3dwci9PUXRoOGFUaGE5Y2xLMkF2VkJTN0Fx?=
 =?utf-8?B?cVorOVA5QkFPc2tBNm1ncXZnSWdycXg2VGZRTkw2RHJiajB2a082YnBzNk1L?=
 =?utf-8?B?TjFFemQreDdWNldhMlFBVVp1bUNFZDZWSjIxVDZIc2IvMktTeEt3VkNGdThD?=
 =?utf-8?B?QlA5clZlNHQ2ZjJVazBhVTBBeU1XdlEvMlJqSENtOXdOc0VrRk50Rmg3NHRE?=
 =?utf-8?B?aHpWcUk4RTdqS29VN1VKcWRzS1VDUzNTTUlraFdFYkVCTG05THA4YksveDBB?=
 =?utf-8?B?alRqcVZTa0RDYUpGdkhCRFpUUTgyR3pOV2hGZFUxcDNBbW92MFduSVUvWDdG?=
 =?utf-8?B?NVJRK3FtTkNtMmVQd1pVdUhwTFlhS2JIUVpYZVh4c2ZDVUk3SWxKMldjVVU3?=
 =?utf-8?B?UmJxNm5taGtlaTY5MS9CWkRjb3p4b2JqNTBYUTkyTjMyVEg0TUdOTDd2Wkpw?=
 =?utf-8?B?aXYxUW9EMXU0SlBPY2lhczdmazFZUnhCMmVUdlFXOTk4S3ljelNaUTJHVHRY?=
 =?utf-8?B?NUtQWXJtWnFyYVpmWWhTZ2xLN05MVndMU1I1L21iYUFpRkxKdzVweDFSLzNG?=
 =?utf-8?B?dUtPZDJoLzdRb1k0VnpPYTExZEpUUzRWUTJ4VkVZYmg0ZUIwZERTTjE4Z09Q?=
 =?utf-8?B?bTc5bC93OTdJVVVxakptdWRqc2cwUXRKYW9veUJLV1Q5V2R4ZjNqUGVkb3Ru?=
 =?utf-8?B?RytkMmFRZkRvRTlkQ2dwNmQ5TklGVnV5SGhpRGdGSHJxYmEwQXNCOTRmL1g2?=
 =?utf-8?B?ckRmSms4Z0xsa1dDWXhwTU5HZTViQ0M5V016bWRRZ0xUK2xsWW1Rc1NnelZI?=
 =?utf-8?B?WGZrbExxOU5OWjBKSnpKS1F6TU9qU095QWtYaHZPMURKcDNrK1B0Y1g0dHhY?=
 =?utf-8?B?V0habjYzMHZCRHFwOGJRNURDSlV1UWx5T2tqcU1oWGdZWE5tK3cyZGtOcitm?=
 =?utf-8?B?ZkxNb3QzNk8rVUNIWjBTRHcxSGI2TEZ3aW5UdnF2S3dMY1pQeTl5R2Q0b2My?=
 =?utf-8?B?aWNjdG82cEJhRm4xMTZsQ0E1UmhpQUNMZk84UzJhVldxSjVxeWtnRmZLN0xU?=
 =?utf-8?B?TU9qUlhnVXNWWkpKLzVqNnA2aG1RTkh4aEJMdDBOdDNOQzVJS0hIZVRRaDg0?=
 =?utf-8?B?b1pzcVo1SFRBVFg0YXVDZVR1R3FrQnBQK05LWlVIaHZsUUxQR09vNG8rckRn?=
 =?utf-8?B?dUtkVDRZZm9icUFkaVdEdDdXcU1obk9CeklKc2h3dkE5WFR0ZnlwTmROWWZj?=
 =?utf-8?B?M3h3QkpZS0cvZmpzbUNOTzB4d1pxYWlkbzZmSURsZk5sc1E0b3hRdmZtY2Zx?=
 =?utf-8?B?ZnNVOURacFAvRm1XdEtIYk9hS25lUzFLN2EvWFRua01PVEV6K2tjYStDNEFC?=
 =?utf-8?B?ZXF4ejJIZkxtbWFXNlkzRmEwTUhVcHJqUlZrcGVMNXc2V0pHUEMzNXpjdWdn?=
 =?utf-8?B?RXMyUzdDVHRoSDlBM1pGTGh0ODhGS08wcnlPQktjeDVHOUc5VjZtWXRmMllG?=
 =?utf-8?B?S1cydHp1bXBweVU0QVlobFlKU0NtYllMdUxBWWVCdEZxajJQd3ZlLzB2S3hr?=
 =?utf-8?B?b1BjUUlrNWFNcmNUU3NJcDQwR3A4eFY4WUNXNnR6QjRhcEFsS2pRN1Vvb29S?=
 =?utf-8?B?c1FRSXdLUk9Xbk5jeVVWUXJMUFlFOXZ4dU9zZ1AxUjJ2bFQ5azdsWTNhdVJp?=
 =?utf-8?B?b0hhWHphWkxQWW5FbUROK3NSMm9iblRjUGRHK3VtVFR0dnpyZUEvWjd4ZlRa?=
 =?utf-8?B?ZDI5WDlUZWZMMmVCd0NkdGZEbUt1U21tSGFEVzFpa1VvT2o4bDNkbi9hZVBs?=
 =?utf-8?Q?GxT2teRGCaGBD+bhd7dkLH0Zj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb07e866-d9a0-40f8-02a6-08dbe3eb8ca6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 01:55:02.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6ZjzdApFdJCyNFwym6bCLYEcnyig5g+8wCPFhF07dGB3c1nEUO7KL1+zu1rlmju673FuryjyJlu62mS4/OoKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5953


在 2023/11/10 20:32, Michal Hocko 写道:
> On Fri 10-11-23 14:21:17, Huan Yang wrote:
> [...]
>>> BTW: how do you know the number of pages to be reclaimed proactively in
>>> memcg proactive reclaiming based solution?
>> One point here is that we are not sure how long the frozen application
>> will be opened, it could be 10 minutes, an hour, or even days.  So we
>> need to predict and try, gradually reclaim anonymous pages in
>> proportion, preferably based on the LRU algorithm.  For example, if
>> the application has been frozen for 10 minutes, reclaim 5% of
>> anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
>> complicated as it requires adding a mechanism for predicting failure
>> penalties.
> Why would make your reclaiming decisions based on time rather than the
> actual memory demand? I can see how a pro-active reclaim could make a
> head room for an unexpected memory pressure but applying more pressure
> just because of inactivity sound rather dubious to me TBH. Why cannot
> you simply wait for the external memory pressure (e.g. from kswapd) to
> deal with that based on the demand?
Because the current kswapd and direct memory reclamation are a passive
memory reclamation based on the watermark, and in the event of triggering
these reclamation scenarios, the smoothness of the phone application cannot
be guaranteed. (We often observe that when the above reclamation is 
triggered,
there is a delay in the application startup, usually accompanied by 
block I/O, and
some concurrency issues caused by lock design.)

To ensure the smoothness of application startup, we have a module in 
Android called
LMKD (formerly known as lowmemorykiller). Based on a certain algorithm, LMKD
detects if application startup may be delayed and proactively kills 
inactive applications.
(For example, based on factors such as refault IO and swap usage.)

However, this behavior may cause the applications we want to protect to 
be killed,
which will result in users having to wait for them to restart when they 
are reopened,
which may affect the user experience.(For example, if the user wants to 
reopen the
application interface they are working on, or re-enter the order 
interface they were viewing.)

Therefore, the above proactive reclamation interface is designed to 
compress memory
types with minimal cost for upper-layer applications based on reasonable 
strategies,
in order to avoid triggering LMKD or memory reclamation as much as possible,
even if it is not balanced.

-- 
Thanks,
Huan Yang


