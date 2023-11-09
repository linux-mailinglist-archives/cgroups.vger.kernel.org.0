Return-Path: <cgroups+bounces-261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CD7E61F2
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 02:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86C6280EA2
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977F110E;
	Thu,  9 Nov 2023 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VbKmnDmN"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E9110D;
	Thu,  9 Nov 2023 01:56:59 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8A26A0;
	Wed,  8 Nov 2023 17:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx/JQf5KQsV4rb8Ayv3ak4CNpW2bAHgcP9fPtjxN9kOysOXQcmnurEeHBbSrSe3kGj0jTVfOg/v6vufJ4v55QNUupYRs8ydvikq8IrSTTeccmAZS3VPst6Nk8J+/Ra39e4j86QoghlMzVXVLi/iSruPJnxCQNi+0v4Z8gRAyEwQRcOSaQ3p/6h6oxxo87V21SFPmR37jrzddmeFqXTvLz9kYG4b2JO2JHlI6DEjAbE8t6FYYoSNzpSwGHZGED0SkWeqYcFD8fKX9CV+Efyf/Wzn9yFqHOiD/owwqNnicPcfrPr37dzR3owU55BqwIAUWwTlWcD4INDRWT9uQfPv0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx3Aa6DzTj3YNGl86X0zVEea0XMkHp4V9VRMPEeSFBo=;
 b=nCS8JLg72B6J8VIMlBK+ffB9D7JT1yOc99KR+yWhbtlJ5VKihK5BmmQpsNy6tFNNCs/xsbGQwNU/XBsxlQlfrPRPJHU0sJj/sF6xhfRV/BOrVQkma7vZSjaTV0cwO85wFoDLJvsH63XU+dMxhzC2u4l+ImYX2BRpmLkaG8SzdBBlMpMORb127fdZo4r004CyXr7vREDLqmsOnHULP1bz3K0r4YPSqpW2s3YX3gj32AzdzmHWUSZ06hFPT11cM8LiZ1K340TLSmPAc2FsugXAM21X0GeLR5hb7GlqMUdypB5LzVOj39eM/y7nK0c+p3JoQHbSH5MzrRVcT/hWOdypgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx3Aa6DzTj3YNGl86X0zVEea0XMkHp4V9VRMPEeSFBo=;
 b=VbKmnDmNb+sX8v+fHUga6AYF938MFccvexhoMvojs0q/bPUXHlr4q5/LMkk5YP5m3LLu4pxz93g8a2lR6kr0sVH3GXlJTs23reBWKAOcZ/k5os6vr2cOa4RpyjgxUAsJyDj9S2IT3r+sr0WVgr8xFNFmT2+Qt9crQOWi/lEcHhb1g94/m7UTTlWpKzatOoudhxjw0n5dwMLLEH8ovULZE/rqcFX84kL1vNXQe0FyQcr5hEzDgINc1cqls6EaeTjMf2MriprMGzH2HJXSzqwjL1W2lAL6qHJZYcTLHP8M6l2gp2pI5lKhIYEhP5poI+ocrO/AO3WnDkq5RS9nz5pd1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB4397.apcprd06.prod.outlook.com (2603:1096:400:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 01:56:55 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 01:56:54 +0000
Message-ID: <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
Date: Thu, 9 Nov 2023 09:56:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUuV9xOZ5k7Ia_V2@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 2389812e-2a02-4aa9-fdca-08dbe0c7258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vCAH1YZK5D4e2+HQNlxxjeN9ZbBGlvcI0UdyyGeBUolbwZY+xVWPsmPDIL70xsu/AbU+O+itW5DKaHsORFZv1Ql9FksW1/QUmjgYtRv7Oj8aza1XJ5W3ImRDMFp3eK/zG2n2YdAWOyigYc9IOzl09WoympNxP1oWSlEkvqYwxJqS3xIIOSjfVqLKDlFIBaMWB4SQ6Lfpj6ZqcG/Dsq2j27mytYFc6fh1sz1m7cUW2Hzxmm/OX8l0MS942YO3lwvcTf8nvQ4U6dI/lpdBj8LtxuVj9eSfsQEEnHWXHv5OL8wSwHICricKvW7b7DXSoQ5m6Y8CkLiH+BlW5CGhZYI70uLr+rKbi8RV/VglfSC67sbTXg5n763XHsczPOpFppI8nJ5tqvul1J9R4IlLrVd5c6PDRHy8mkgcQVounFCJFwme0Kcu0bKcYBgzDbXzhoSQ4w+6u16jTKMp+ifLkTf6I7WGoIsP9tbGkIRwOQ40du4nWuA3NmbwYPM4tJJVZJc9BuNu8gRXlsaw2uQs+S0KR0qbrbn/Dx8/f8oG5Vhg0nvQr2MxYJqdJrt2s98m7afS/deCfllEE3B3+iD6kFS3cs5qPn0XP2RxiZ+Qn49/1mUqwMsWR/GZ4bS+MvkHEBvD/KGkoQNNx2s+NWfM+AiczpXNqfzW256S3Gf0Jej+oLwgLv4R+Y8P41Qnn2AMXVMwmkFoRdhCjKFVScZU8y6t+gxxWa1UTyeHByPModSMu+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(478600001)(6512007)(7416002)(52116002)(6506007)(6486002)(2616005)(966005)(8936002)(83380400001)(54906003)(8676002)(5660300002)(2906002)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(38100700002)(4326008)(107886003)(31686004)(31696002)(86362001)(26005)(36756003)(38350700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVJGSzN1eURkbW5XRzRiN3RqazVHSmorMUh2TVJqdTNpalhGUzhXeGJSTG9v?=
 =?utf-8?B?RmM0R3pZTmdTVVFvVVpCYjh3MEQ0eXJHM0tKTkMzNUw3VXJBanI4T2hnVUtX?=
 =?utf-8?B?RnVZdzNoNjFhSnZWVCtaVU03eFVVOXA1N0ovZ2tIaUI4dmV2K2NLbDNWS3BQ?=
 =?utf-8?B?TmQ1UnFpckxKSDhVOUVUQVJKV216aHVNVHZhS0J5NXUzekF0STd1VTlxUzF5?=
 =?utf-8?B?UTdEVTBkM014UFoxOXFFcDBmaXJIK3N3UHJJZDhJZytqa1VqTkR5TUtLNDhv?=
 =?utf-8?B?alhYSkxQWnl0RitNWlI3aGN6YWR4SHkzSHNQYkFnZi9jdXdsUmg1U25WcG00?=
 =?utf-8?B?cGJacU9mK1VBdkt5R291Q0pIZVRUYkU1Q3N3SlJTRWRQTC9jbFBQMDd3akVa?=
 =?utf-8?B?bHVzVHBJVW4wUkRRd1h4OGJoNUpFZXZwSVVmdmovWTVRWFhwQklJNGdWbzIx?=
 =?utf-8?B?WnVYZkQycFRzSHdpTmJLR090ei9UbGJjamljSkV3ZnA3SDhXeTJUa09xUWZv?=
 =?utf-8?B?OHpTdEJub3JQUlZMdTdBY0UweEJkOU1nRFBITnh3MXN2cUYrZDBwRFQ2OFQ2?=
 =?utf-8?B?NEdkMmhxOHRway82UkszZDA5RUhOd1RLcXY0c25PZTJ5NTAxN05hOHBYT003?=
 =?utf-8?B?QW5tRUYwbWpMZ295THl2WW5VTTNYbUxpVHVRZlJJLzhpYmdGek5pbVRKZkVY?=
 =?utf-8?B?S3owY0tSa0dBNEM2cGg4V1k5STk0WGFWUWZ0OWZaWVJUeGV4WC9mbnovc0JG?=
 =?utf-8?B?bHd0WFc3MVhKVWE3clB5aE9YN0lZWDhCak13b1ZEV29ZNFlzZDhiMGVjT1lS?=
 =?utf-8?B?emwrYkJMekRsWVAyTTlnc04xQU9YbHVpdFRsV3p2M1J4UjBPNEpmLzVaa2lI?=
 =?utf-8?B?cG9OdHRCYjZRSjFCaEZaNVNSdVFUelZURmJuaGVxMWJNWTNneFpzekt1QURk?=
 =?utf-8?B?RzVuT0pZY2J1M2ZrdHpyVlZKYmo0VnJ3dlhZV21DM2svelFQVFJLZ2p0V0Nr?=
 =?utf-8?B?N3VqRjlMZHZwbW5aUllZZ201US9XM3IxU0JuSDJUZDZObG9JNUlTdDhSMmRs?=
 =?utf-8?B?Mk1FY0t1YVQ0bGVQVTU2bnEvY0hCT2x6VGg1bHF4YVJoMEVhRzBlUFkxTDht?=
 =?utf-8?B?WnExV0ZqWjBBNFBMV0hNOTlFZ3R2VlllOUgzMU5PeEhocGhuc3dRZ0pTSnpx?=
 =?utf-8?B?ZGpRTElLYjdoUzlVYWQ4SEp3Tng0blRUUVBpbG1hZ1A1c2d5a1VjZW5tNm4v?=
 =?utf-8?B?akFtUVhhdEVZOGxsZW43U0VUTHRpVWhIZW1uK0g2eHhSZmhyRk1TR1VUeTBw?=
 =?utf-8?B?NzNuWndyM2pwTGRSYndpU3hoNUl0UlR6U1hnbTcvYTFGSVpBM1lpN1hQbjV4?=
 =?utf-8?B?dlpmOFA1Sld6NCs0dzZWbUw0amJjNlVZWXBUQ3hGQ0RqWXZUUmsxNXF6NWky?=
 =?utf-8?B?ZUo3bDI1WVIyaStVMlpIRlZlOTlva0RHV01kbGZjRUxhNW1IV2VWSjlZOTRU?=
 =?utf-8?B?ZTYxOEYrZklIcURpK3lrM2UxQklJd3hSbVRYUjZ3UlZSK0sxMUs5ajY1dkVz?=
 =?utf-8?B?d0FleHM1bXZvZkI5VWhTNHdYUlFoWWFqZ2JXTUVEUVpMMmJyRFRCM2laY2pk?=
 =?utf-8?B?K3ZSUkNTYndHY3dhQ01sN0NiWWcwTWNQRWJ5NURsMldXV1I1WWN4dFhEUHBR?=
 =?utf-8?B?WDcxakU1Zm9zNkZSUFJYRDcrQURmOXNFdWRqdDdrRGpGaXZ2MERUb1V6Ky80?=
 =?utf-8?B?RHF5VnpLTTdFbkdzTFJvZlRDOS8yMzNCeEpxZmExZE13WSs0ZE8ybTdmTzQy?=
 =?utf-8?B?NEE3NUJQK3p3YzRrdElkcEFMRXk1NkV3QnJubHU1K2dhWk01NDMyUDNhbXFs?=
 =?utf-8?B?K0hWTmdiVWtKNldnTlNSUVdCTUY1c24xajdHUnNQMGM0OFBMaWtkai9XUzJ2?=
 =?utf-8?B?WWJUV2pCaDVaQ2VYOG41WjRVNURPcjdhWGpCNFNWS2ZuOUdqYUlWSUxBTWo0?=
 =?utf-8?B?dHRYZ01CeFNwTVl5OTdybDZCQVVmUSt1Qm9VL1ZGV2loTEJ0d01EMThmVTQ2?=
 =?utf-8?B?dXRrNk5MTDFCN2FZL1lYNWNxSnMzc1hZWG9hMm5lVEFxeDZCLzU1TFhQMWNY?=
 =?utf-8?Q?kodGeJR0whSFLNFLZMN8TahLB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2389812e-2a02-4aa9-fdca-08dbe0c7258c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 01:56:53.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fihWbXPwgihx0Qx2jul7t/lYAG9DkXrVDPZ+n+gbzIsubv+z1Jsoxl5U+1faM2I9JHQCg7MXB1Yohu+WEeUyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4397


在 2023/11/8 22:06, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed 08-11-23 14:58:11, Huan Yang wrote:
>> In some cases, we need to selectively reclaim file pages or anonymous
>> pages in an unbalanced manner.
>>
>> For example, when an application is pushed to the background and frozen,
>> it may not be opened for a long time, and we can safely reclaim the
>> application's anonymous pages, but we do not want to touch the file pages.
> Could you explain why? And also why do you need to swap out in that
> case?
When an application is frozen, it usually means that we predict that it 
will not be
used for a long time. In order to proactively save some memory, our 
strategy will
choose to compress the application's private data into zram. And we will 
also
select some of the cold application data that we think is in zram and 
swap it out.

The above operations assume that anonymous pages are private to the 
application.
After the application is frozen, compressing these pages into zram can 
save memory
to some extent without worrying about frequent refaults.

And the cost of refaults on zram is lower than that of IO.


>
>> This patchset extends the proactive reclaim interface to achieve
>> unbalanced reclamation. Users can control the reclamation tendency by
>> inputting swappiness under the original interface. Specifically, users
>> can input special values to extremely reclaim specific pages.
> Other have already touched on this in other replies but v2 doesn't have
> a per-memcg swappiness
>
>> Example:
>>        echo "1G" 200 > memory.reclaim (only reclaim anon)
>>          echo "1G" 0  > memory.reclaim (only reclaim file)
>>          echo "1G" 1  > memory.reclaim (only reclaim file)
>>
>> Note that when performing unbalanced reclamation, the cgroup swappiness
>> will be temporarily adjusted dynamically to the input value. Therefore,
>> if the cgroup swappiness is further modified during runtime, there may
>> be some errors.
> In general this is a bad semantic. The operation shouldn't have side
> effect that are potentially visible for another operation.
So, maybe pass swappiness into sc and keep a single reclamation ensure that
swappiness is not changed?
Or, it's a bad idea that use swappiness to control unbalance reclaim.
> --
> Michal Hocko
> SUSE Labs

