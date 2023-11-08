Return-Path: <cgroups+bounces-240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BE7E51ED
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8532812EA
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C24DDB7;
	Wed,  8 Nov 2023 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gdeF60aA"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBCDDA3;
	Wed,  8 Nov 2023 08:26:27 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867A10C0;
	Wed,  8 Nov 2023 00:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTdafOk0kH1pS3RZZRlXOyjHE8nWxZcVn/CmZ++qG3FW0j5ZgD1f1vD1iXPhvMKDUNiP2X8EpAhY5oaLARz8uZUJoFiimx2fum6zKydBIxmSYmgMTR0T5nO2427ERdFHm494qt8AGQcIoRFb2XkbQbQ3wUTBA0nqVxKveUM5/FdonZhqsnzwNDxa5HB22CFiAgbPrXcimYFLqKR67BuOH6vQg0wB6yEWs/c7ZOXt1SFcz63B48PgtVY81rwLg/S1yBXuJVFc/r2sD/iBzmHNmMFrOJGtGtRbpKIBlRg6w71xCq4y14lTVCg7Si4aVYj7HHR9JoqjF/RgX0Z3SY59sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0cXq8Vxqak80mxA5UzUMzilyeWNh23z6yXwE/bhGu4=;
 b=Irph7ns/GzFZcYKxhmI5qZyWaMrJBY8SUUqAPazPTnSmav8s3ZxtdYYDlCyLcNu0h9+BbZAjbLUDDbQfMCv5Xl+DiTQqm2I95fef0gSyrqnpWl+rMPvWk0ZqnPW5bBcnREr5idmbfvrAqZ7vxnJ9Kuf1t1jWSqsFcC6gdf4aF4bdqgWAAIr1w86TOaUtTEHj7V4m3YYAFdrL4mwJFCI6e11TBrX5L3HjxY6t5WiULCGKKtZkj3JCg/Cg680V6M3eSX9ttmbkyDU07mkXxpcrs1kALZ5igNtmWxRcKAPEEMMRgKCr6KMdXFyK2XxcCO62M90OeCxs9coS3R4sOJwcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0cXq8Vxqak80mxA5UzUMzilyeWNh23z6yXwE/bhGu4=;
 b=gdeF60aAk9ELlRHjoCxlZjxdkb+5ioAna7/bU4PD0d+VABjcs9mq/aRBOXmwOA1GZfXFZ3yp+vT5sWjp3g15I7ojeyb+rO1tiCcboQv+iQbyIzUTt1/QKL3nwyNm4goQhZJicgx+jM+jP8QKxq3YKB11QO8eNcsvaR7sc7NOgxQBbTk0I6mby7H/Qy/Rh7lYUWj2QmTg/HGWjrs3cUFGtMjpkHVmMaWmzACve29bMTDjVwRM5NAvS6S2dXl6n6yANI44zG7M0StwIRpaqvsOCS/0mUFIsJ5VB8CZjuEkFag2rtfRbRpOVmpOMHhwnR9zXJPSQIWBPV/1M3wk804o2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6672.apcprd06.prod.outlook.com (2603:1096:820:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 08:26:22 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 08:26:21 +0000
Message-ID: <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
Date: Wed, 8 Nov 2023 16:26:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Yosry Ahmed <yosryahmed@google.com>, Wei Xu <weixugc@google.com>,
 David Rientjes <rientjes@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Liu Shixin <liushixin2@huawei.com>,
 Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1b456e-fec5-4f17-9cbf-08dbe0346388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MJ+50OhM+EwDL5WVFck2/VBPF4S+Q7Wx3ltzpoGWmlB7DCYKJsAqHjaWdT1nhIKBJFtgArYTfqk4tahA/S6mKo8y46hKCp3PJmS671rzP7pbNpa/RKGkoWRDPNM+ALLibG2U3KpwuYhv7NnaDqaZNSBYV9WbuJhNRTU/S4Zo71WbZiM3FFA/29mjH+otxpaEy6KcS1gGVGdlZT10ciqHT4q3FKJN6CRjUTRfwCXiu/YgT3thzo9uiNK+qbbW8RvJo6o3uNTh/40CdzSg2swl7FBmCO/bHJmQLZT2UgOkbyHMkUF/Ob8NjdNEpG9WCqYpfky/iDUBqRsR/mnobjWx6M4S1rxvEvLGGQX/5+AbYmBNsveivWHbrROAqrnWeVd0RX/wwBNqeHzwBBctugezpwCmWi/sEHGKgOSVh3zVAVlqkyo38fdDWo+3YTG7ox0I5Yk6bnFrbKxV2GwxGQtzsXD12x+HcSG+LK8Y9JOif8u0au9MX0UTeue67zOhPqoxmKfQgjHJs/Cyh1CbvU19hSoyizhK5Tt6LMAiTJf6U7Xg8OaW3VQY+iOIaVzmRi2QJIWKmynYa7Pm+hF1EaoI2+Uck2EDOARCXUQwKCf+e/7j4qYtyDo2rK+aHkfXqpc6yORJbsVCQsjmWNrF6u9NKheP211IKFi5KhY4huSBYqQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8676002)(45080400002)(4326008)(7416002)(31686004)(86362001)(2906002)(38100700002)(41300700001)(5660300002)(31696002)(6512007)(2616005)(6486002)(107886003)(316002)(110136005)(66946007)(6666004)(66476007)(38350700005)(66556008)(6506007)(54906003)(52116002)(53546011)(8936002)(966005)(26005)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3p4UUJXdUJxclE2UmVjbGkyZTh2MXRkR1RKME5TeWc0THNJTGxYNUUzRlIr?=
 =?utf-8?B?Qm53N0pYVllBZXZsN2ZuMTNEV29hU1dLck10MnVPOGVvZFRWanJGQVdoN3VT?=
 =?utf-8?B?QWRGVlQ4YjdpT0JkMHliUjZBZ2drdlFBTGl0UFhBS3c2VUdWTkFSR2RFZVg5?=
 =?utf-8?B?N0dPcGN5QkNjNXNDcTl0bmorRVBPd3J3eXRza00vL0RQeS8xRGlsMzZWbGll?=
 =?utf-8?B?MkQvYkFRL1hmRUhQS094c0RYNHNKbW96T0pBd2ZCSjZtSFIxNFBITC8zaXFz?=
 =?utf-8?B?NzFlNkZGRkVldnQ2eVZMY2RGQ2piZ2ZYT2luSlNybDNiYXd5cDRIUUdteWRM?=
 =?utf-8?B?TXZWSHgxUEJsWnZzazA3K1pGYVc2WHFaVFNhcFJ4Rllxdk5TMkRtWkxvY1Fy?=
 =?utf-8?B?alV4bXlVNkxxeXQvUmVSVHBLM3VIR2xSR0w1L3BlcDkzekdmNTJxdTlvYzh3?=
 =?utf-8?B?cTdobDhLanEyU0VSYkN3SXd3UCt2U0xWWkZXeVdpbEJOS000Z21lc1U4MGgw?=
 =?utf-8?B?OVZlcXYrQTdHTDEwQzd6OUtpV0tLWmE4N2VvNlJhSzNIenE4L3VZdHdDMnVT?=
 =?utf-8?B?VmpQRHdxOThrZFpMaUNnekU5RWg4aUJEd2hyaEhVNzNDRWlLQnB6aHMvVFd6?=
 =?utf-8?B?V3NTbXRTS0tMSmVIOE9hdmRmNW9WQWE1bGZ6azlTOUpiUEM2TUpRcElKaEg4?=
 =?utf-8?B?alY2L0k1RG0zbklmZzRCRTNKcm9ZcTk5ODRTbUpPM0pUSWJaNHBHa0NjcEtC?=
 =?utf-8?B?MFFzWnI1M0xiTTFEVjF0NHRYbTRoaTVDZXoxaUR6WllpWjNycFRyTDdjM3Vp?=
 =?utf-8?B?aTBYNkFVRHBacnVYUlhidnZVMEVSU2c5SEl1R000cjZMaGN1UnVpZlJsM29O?=
 =?utf-8?B?NDNENFMvWWNwajdYZTFrQVUveWFrcWUzNjEvd2l4a2hpQzdKVUs4dEhxWVpy?=
 =?utf-8?B?dE1vQy91YnlqdXZTZmM5VXdxbnFiaUFDcitoR1R0TjdVQVVFSFpwcTFNNHp5?=
 =?utf-8?B?ci9mTTQ4Q2hYdExScnJHNFZnakk4V2NxV2RvT2dJaDdJRHVJM1g5eDJCb1Fn?=
 =?utf-8?B?TFlZSlJydnNSME5nMlVvM01DcWVSaGJjUjJpMjZyZ2xuamtVbUpRNzhOK1RP?=
 =?utf-8?B?R3ZwU2hzeWU0c1FpOUc2cHI1bCtlUUc4ZUIvc2dpZkttM2laMzlnRUdWV2Jr?=
 =?utf-8?B?Zlg0UEJYZ0VvN0x5OXBpdUpEbmRJQVJnSDRYenk5UUJPMUx3d1VnbzhTZjUz?=
 =?utf-8?B?dFhWNmRKRFAxUU5NOWg3V1AveEd1cFRRcXIwK2YwTS9rQlM2N2JwQmcyayti?=
 =?utf-8?B?LzROTll6WGlaMXFYaHhjY29JUWsyK0MxSU4va25FWWFHNG1Rb040UE5nbU9W?=
 =?utf-8?B?a0hqM29LdysreENYNTE0OWJsN2pBenNJZjNSbW1KZlEzM0RBK083T2FvVWxv?=
 =?utf-8?B?aEhYWGRFekJUYVV0VVJlOC80Ui8wd2xERlZLckhBWngwN0lDVzNlaENMRFA0?=
 =?utf-8?B?WGdXL29IRTdWd2tnRlExRWJwbEU4SEUrQThFem0ydXJHamJHZ0NyOVNsbE9F?=
 =?utf-8?B?UDU1aFdqblRxZ2RtTFZadVVYOU84TGdtR2I3Q01QUk0xNTBXK09xcHdDdSsz?=
 =?utf-8?B?V25xNTlqMzJUNXF2U1NxRksyZTlGRk83WGQwNERHb0ZMbkc1aVExZU04UW9a?=
 =?utf-8?B?MFlzSW9kc2JJeVBXK3RoMjV4ZDRwa01hcjhoakpXUzYzb0hZY1puUGxBdThE?=
 =?utf-8?B?WEVoTm9JeWVvaWIxZTNLUDVOTTV4c2h2REtOMFZVOUdhWXplTDNDcGZFZlhF?=
 =?utf-8?B?ZzNZemNnbjBJYWt5aHJjZzNnZ1Q5VFJnQjljTjRqSlhydE5yb0RMdW8vd3Qx?=
 =?utf-8?B?MWxmM3hSVEp3QnBEWkN3UDNTY0FSbGpUcDg4MEhwQjJWeEFmRm1aUmRBQndV?=
 =?utf-8?B?bXRTdmgwZS9wNituTFEvbFY2NC9kWFFwSjdYSzNPTTR4aXQ5U20zdlJ2dm11?=
 =?utf-8?B?bXlJM3MwSkE1NTZROFA2Y1dEY2k0ZDRrakttRXNiUU5LMUlMSGxIQjFhbnJT?=
 =?utf-8?B?MlkwZ1FjeHduU3lNWnRSR3pPNERwa3RKaktFUGsrM1NKSU05K2x2UVpEejcz?=
 =?utf-8?Q?+ERLaeZ0kCiGlA1AIzJ8vw3g5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b456e-fec5-4f17-9cbf-08dbe0346388
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:26:21.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvb6u8iaMTC0QRMbSnEGtTGkAl7H+jCbNYI5ZLP52tBaWvrpszLdpSrgpGLkq50QhJn4Nu174YQ4EXawoSjAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6672


在 2023/11/8 16:00, Yosry Ahmed 写道:
> +Wei Xu +David Rientjes
>
> On Tue, Nov 7, 2023 at 10:59 PM Huan Yang <link@vivo.com> wrote:
>> In some cases, we need to selectively reclaim file pages or anonymous
>> pages in an unbalanced manner.
>>
>> For example, when an application is pushed to the background and frozen,
>> it may not be opened for a long time, and we can safely reclaim the
>> application's anonymous pages, but we do not want to touch the file pages.
>>
>> This patchset extends the proactive reclaim interface to achieve
>> unbalanced reclamation. Users can control the reclamation tendency by
>> inputting swappiness under the original interface. Specifically, users
>> can input special values to extremely reclaim specific pages.
> I proposed this a while back:
>
> https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com/
Well to know this, proactive reclaim single type is usefull in our 
production too.
>
> The takeaway from the discussion was that swappiness is not the right
> way to do this. We can add separate arguments to specify types of
> memory to reclaim, as Roman suggested in that thread. I had some
> patches lying around to do that at some point, I can dig them up if
> that's helpful, but they are probably based on a very old kernel now,
> and before MGLRU landed. IIRC it wasn't very difficult, I think I
> added anon/file/shrinkers bits to struct scan_control and then plumbed
> them through to memory.reclaim.
>
>> Example:
>>          echo "1G" 200 > memory.reclaim (only reclaim anon)
>>            echo "1G" 0  > memory.reclaim (only reclaim file)
>>            echo "1G" 1  > memory.reclaim (only reclaim file)
> The type of interface here is nested-keyed, so if we add arguments
> they need to be in key=value format. Example:
>
> echo 1G swappiness=200 > memory.reclaim
Yes, this is better.
>
> As I mentioned above though, I don't think swappiness is the right way
> of doing this. Also, without swappiness, I don't think there's a v1 vs
> v2 dilemma here. memory.reclaim can work as-is in cgroup v1, it just
> needs to be exposed there.
Cgroupv1 can't use memory.reclaim, so, how to exposed it? Reclaim this by
pass memcg's ID?

