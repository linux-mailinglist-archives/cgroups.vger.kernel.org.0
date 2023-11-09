Return-Path: <cgroups+bounces-262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CB7E61F5
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 02:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A955F1F213FB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4553110E;
	Thu,  9 Nov 2023 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="STGcmte8"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049910FE;
	Thu,  9 Nov 2023 01:58:53 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661526A0;
	Wed,  8 Nov 2023 17:58:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb2X3ykveav27K4nABBeSVSsfusObu/VThiqbWVNpkS12/z2vlOm2ZCHSFNERatGc0PlZ4L5W+Nlw3/JmXzQB4KtsVDgXY6dwX1Na5H3y/qQb9aKg/4nup07jkvKeTE5ACgbecbLegnGszig489B/8TISqhpSFCc/hP7fT+Ke8KXmuF3KzlxbHMlgg4m+hEjAinr+8J125mrow78HcuiZobzx4TFYTpAxCIB3RybKHjN0AFAretOaVGX/pQzVXf7zZNoQz1vwhxsufk1qwsEA8aKt9xaTirQp7uW/BMHYTWCGJvJ3/jYVMzhSfP5dtgRk2YQt1qm7O3AA84C2555fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOjSbToOYvXZU//WeBNovkB79AJ/AqUB5fwkiwFisiY=;
 b=KwOCFHzHTRHx7sA434pLa2vNZNHq6RtUmEcALpADV607dsx52xift1w3iib7aPE+LYPbMg2yjdWqpqlL2npoFfJeHmA6xq6EtaOr7UQmAiVGsp18V4GzfL5Yp9wWyc7ViMbjppOPm7/H9SazIs4B45tolrQhAIpy5Xbo4PPCWds1PFF4puvWpphAYpdZKTkS3GIB+hxvQn1jbv8ASn1skqgzx9wYCERgJhBrNJz/J6kdO8VknIZSOP1VqjgQNSxiVR95YFrtgjUdaOAYXiwr2xuxloBLapdIB5fWQxRE38jr9q1KbTUsfoo5d6PSGkhegW26hJDTqWm1XVfi8UB/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOjSbToOYvXZU//WeBNovkB79AJ/AqUB5fwkiwFisiY=;
 b=STGcmte8hVa/a2aiGyiELg1bvmKOJAVQltQiSrrHYCgZAlFOUVrBVnBYXXzfK0immGnoNulxWqZ7L9WcYZLhelBnz0OIrw/gZ2t5ZAXX2NdRIj7hOXLEb+w7dOBpqVJ/aAr0nI9o9jb0aGLhxUQI4F87dMlwehmnnfcVLn/1ompx9EwLLT/j3mrEtRGhAUZGPRtAJbqaBGyh3gdROfnR+08lwY74ENdMTnMO4K5gV3V8ZlsVT5O7KCm+Utf77uat5fz2ubK1+MXSl1WeeDYl7vcotfQ+Hph0psx8uW4iL3kaBTsenh8v/38Lqueh9HHgAGdceDIh89WOvPZhIc0zFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB4397.apcprd06.prod.outlook.com (2603:1096:400:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 01:58:48 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 01:58:48 +0000
Message-ID: <b0d11a27-972a-4318-90b1-77e5eab4f0b8@vivo.com>
Date: Thu, 9 Nov 2023 09:58:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <20231108081419.1c31f74de8e7fce24f85c967@linux-foundation.org>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20231108081419.1c31f74de8e7fce24f85c967@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: b50804d5-a489-4154-e145-08dbe0c769da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vDo1x39FCkAmngeDmvb1yg2HeL6wMMXvJJpyef/gJQIvRGN69xEpVOY6f/HvNwXMICrYUiMnuzp3okbP/RCOWYZa15Yv45Ssmy60SVTcpiK9zdSfJmZZfG37n+Evu3lkLtmU+UvoYgg9e8EjTMddP22V+N9wpPnuLbqmsGVjkBnaPizZSZUy3iDVABso7zyNt2V3KwYy78i2B8BJylkL3mAjFeTfB8nAVAAfonEz5WUV1W77ADTZ5SmR8FP9gS1d/ts4p1kfqhmOrNJumJEucLJuEynHMxY68jGT13m2bnT3/iP9txxSMH7THKM5i7PkRFFH4FSPfbysqm1BSpUq3ENkfKM9IkkO8+dHNSiGxIeGB77YqAPACTtDtobAikMOgsYYwoZH/zRGOWC84in1xNrRtoZqRiXyqN/Shy430R+G9E7v7SLNNFWjnYDxfuabvjMYnHG9/FymkQKf8hYWOcYYwKZSMDZpJO1pPQzVmVowCK/j0mUth27344cj8dFKJkKTpW/FYFP7i1crn0n/R+812MsWzygKEmE3JW+Vpy1PESWOkIAyzpgz0U/Gtr2paDrA1CFhk8ux7Fu2q+i3k/+6oibjvkB9KR40TvX97Po0mmxGLWrQfj4dDwEMdUbwIEzfA+NiNkpMaRlZO3v5N8DBFjyS6j0o2els89bm/AXTqgdiJldwm/6gQFKhBYjgX+5rhml7eVJiIutk/FsQaGezJioDh/3pn6FmK+eLwAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(478600001)(6512007)(7416002)(52116002)(6506007)(6486002)(2616005)(966005)(8936002)(83380400001)(4744005)(54906003)(8676002)(5660300002)(2906002)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(38100700002)(4326008)(107886003)(31686004)(31696002)(86362001)(26005)(36756003)(38350700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE94TnRLdDRVSnJCd3hucElIZ2FIS0xGL1I3U3YrK0pRTFlaOHB1K044cHV0?=
 =?utf-8?B?VEh0TSsxT1VwMkI0OURsalNaUXpNY0VYc0pZb2N4Y1RhelFLcmQ0L21WMVVi?=
 =?utf-8?B?eGlQRlU1b0pOeW5RMHRFcm9PY1JTWUxFM3VlUUIvT3IwTCtWME9YUXYyMVBM?=
 =?utf-8?B?TVVycE9LTDJxd051WjJ2SmsvUDg5TmxuckxjbXFvQXpFS1N2SzJTOXRVLzUx?=
 =?utf-8?B?VzRrZDRMV3ozd0YrdGpDb0ZFUXVyOWJ0cFZxbm9LRVlRdU9WcU5nYkcyS2t0?=
 =?utf-8?B?V2ZXMXVHUld2WG15WnBXYWFPUFlvYnVTdHFncFhlN1o3eG5iMEprTS83d1Rs?=
 =?utf-8?B?bUZkYVdVdWg5ZE5LQkhUS3ZGSG96K25oQkZBRExOdVRvWUY0a05VeWJWRk92?=
 =?utf-8?B?eFhlSWlkRVBuT1p5MStHYUVTY2dKQTkzeXdCSWlVQ2M2SjROeER2dlNMSGJM?=
 =?utf-8?B?bFR6YXFFMlpBSDlzNUdpUEwzUWxobWd1eTltZTkxS1doRjFrcnJxQUNOcDFS?=
 =?utf-8?B?SHJ3QXZsclB3SmtwWndMTTRkOU9vUzRncUNQUmZiZzR1dFJiSGxkSlhpeEtP?=
 =?utf-8?B?TWVWS0VRcmdaeEpzWFN4S3ZVY0tKNlZMN1I3dE0zNEpHUHhWRTB5TlhiZDZi?=
 =?utf-8?B?U2lGN3oyNnpralEwSm92Skl1L0R0SzFnNXdUMjlUNWt5VFNzRHZnajUvOEhC?=
 =?utf-8?B?c0N0bGxQaWdGc0xqOGtJRzJJY1NqYUNYVk4rNGJpN0g2YVB2MHI5Q1B3T0Na?=
 =?utf-8?B?Y3dmZnA2TUtvYlNiNEpNOS84dDRJTERnWm83YktCTWdJNUhpNWxKdEk0YXpL?=
 =?utf-8?B?UnhHeFNLS0Z5TjhnMEE1Y2p0eUtvUFJ6UnZMR0xoRGRhc3FITFlLT0JPZXI5?=
 =?utf-8?B?T2g4elI4STFQd1Fpb05PSUZnRXFUT1ZhUS9pRVQyMkRqTFRHRXBHTDZIcWQx?=
 =?utf-8?B?ZTlaKzdhdjN1WHBrZDR1UVJlTXVmdnlTL0xOWjJtTG1YL0pLREtEY1h0YTJP?=
 =?utf-8?B?Mmp4dytNNEUxalNjVkFPcmVWb2o3S0ZXZWp0WFlWRzRBQzc5OWdpVnRaNWNT?=
 =?utf-8?B?NDlPdmtUUmRxMCtHR1FzQmJsSy9zZUVqay9PZGYreDdwNW5DL0p3bjB4dHJL?=
 =?utf-8?B?UWJ0ZWpmSWVQM211QTJGbW1BMWlDSFNzNGZnY3lWbjhsOHZxWUJxVlFJVmoy?=
 =?utf-8?B?dUlLeFFuUDdJTVc1MEJUQjVoTFhEd05SMWVkY1NDcnlLNytEcnRnS2pWM1lU?=
 =?utf-8?B?c1lvUHNzaHpnOWZBaEFRV3VXK29tL2hOclN2Z1lXdkVoSXFtM0V2dkhiZjRK?=
 =?utf-8?B?NFdpVEtRblBVekFIY1hzMENpLzJXZmIwa0FMdmJSQlF4eHFrYUFoUGJYd2N2?=
 =?utf-8?B?TEV3YjlDRnlDK0hyRDVHeUk2Mk8xamJmdS85NFllYkhvUlM5QWp5emZGaC92?=
 =?utf-8?B?aTkrR2dGNXBwbFZKWlZ5NFIzZWRxRDV5bzRzWjJzME85OGpYRG43aG5WUytW?=
 =?utf-8?B?dDRHRVB1ZERrU2VDQXBWdkExaEp3MTBmeTFVYWlzYVVTVG0vT2tSdmh2d0RR?=
 =?utf-8?B?VFV5THpMVlJQaFIvR3JLYkZiRFVGcWp2cjFVUE9qT25EZm5TeTE1R2NsZHJN?=
 =?utf-8?B?ZklmbTI4UW10WG5kcVRyNzNIcWNNU25CYjlVdUFwRnYrRlpyTERWcTRXZHhK?=
 =?utf-8?B?R3JOZXFsa0JrS1ZjNUorZFJ0OEk4Nkk4WUQ0Q2lWbFFxdS9ibWZIUEdJLzc1?=
 =?utf-8?B?a011R0dSR2YyUVcyb1d2SFZlMmRxc1lKUHk0OC9pTzltWms0ZkdLVk03SEZn?=
 =?utf-8?B?YUQ1b01HdUJKcjlicVpmRHJWZFNsY2N0Uk9FVnpCY3kzK3FYR0dLL21SV1lF?=
 =?utf-8?B?Vjhpa3NjamJ1U2hobmo2V1lERUs5T2R2bkc5VUxSVFV1ZG9KWTErR3hsS1pU?=
 =?utf-8?B?SjFBRm1oLzhPUjQyWTl2ZzdwNlZEUnBZL3ZKNGZDSUk3czRoTWVVYi9CVVFV?=
 =?utf-8?B?M01vOEVhazRTVkJtVzVZNXJuZThEaTB2eDFYRVd2SXVZVVNab3IvV3MrdkhJ?=
 =?utf-8?B?QTlTbnBXZzdRNVRzbHpGSm9URldJekpOUExYdkxseVFTM0VvRTNpK3JEdFNI?=
 =?utf-8?Q?w7fuhT255bcY5cVnVYVQNHBd4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50804d5-a489-4154-e145-08dbe0c769da
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 01:58:48.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJOBmu65NR14qanUNEJRl8AAtelK6dGYsB7FYAuGvsWmF2N1M+QM35ZMArdGlSNyMJbzHVgl6oXyoyW+cgsx+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4397


在 2023/11/9 0:14, Andrew Morton 写道:
> [Some people who received this message don't often get email from akpm@linux-foundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed,  8 Nov 2023 14:58:11 +0800 Huan Yang <link@vivo.com> wrote:
>
>> For example, when an application is pushed to the background and frozen,
>> it may not be opened for a long time, and we can safely reclaim the
>> application's anonymous pages, but we do not want to touch the file pages.
> This paragraph is key to the entire patchset and it would benefit from
> some expanding upon.
>
> If the application is dormant, why on earth would we want to evict its
> text but keep its data around?
In fact, we currently use this method to only reclaim application 
anonymous pages,
because we believe that the refault cost of reclaiming anonymous pages 
is relatively
small, especially when using zram and only proactively reclaiming the 
anonymous
pages of frozen applications.

