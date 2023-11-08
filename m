Return-Path: <cgroups+bounces-235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF777E5166
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD80281543
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E64D30E;
	Wed,  8 Nov 2023 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CBciaoLL"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD3D50E;
	Wed,  8 Nov 2023 07:53:26 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EEC1719;
	Tue,  7 Nov 2023 23:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVudnC6qwLljrx4FkdpLe4FSSFPLkbeMoeVM7ByIh5zpDULiYS/TRuBb2yH1HzG7bYcqJ3Wmb3j4R3H+DjrcNARiorWy2J1+EiA/a+zP11P8uDBmB1V+mrvKVhp5Er69DVq/K2Rdh2mhDV1jacz2orfYjXfLPA/Fu0ILbi0fPYKMAfP7BUw+clznnPtFCeyh8Ye9Houl68VJok4MWFHJg+mnR01X/tUMQxgF7s7Owuv2OH98P2xe7UjNAzEpJq6GlRtzxdznvlqKPFUfQMrLOmEJGdJRMnzNBlhDLD36c4WVOoC+aAxCktjNbIVDCGibVeYmPt58apsxZYOp3iAYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F5x5jLLzbEm9yUc/QxhPqJTeILVMtnVfGdDfenz0kM=;
 b=W3xfBsGMETxBoi7xMIghuKLHMBsqZCcKvkJgBV5cfxELS+eyjgC1zpytIC0SxeTlW5Q0oF23wo92tqPeFYol1FmoheKWVemj5+ihO8JhWPIxYiCrvhNoxC3XPGxGv2SFtGtdYUg21ux/YFwr9ibpUAZc9nHM/09C92zoO6tgzNHQXl6i0kaL2lDvLip11UIb4AyfKKyz/IO0wMNT5T0+nca56TTVzoz37lBpRVpVqU1iLWXcdfm11lfPsqJMYyfE+jkVZQHtRefGCZMWtA5tUujE+MrhdeYhErMGtIYxQCkuSjiTAyC8wk7peQ3//sLeq1ey9z3XPSORTmr0sKE0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F5x5jLLzbEm9yUc/QxhPqJTeILVMtnVfGdDfenz0kM=;
 b=CBciaoLLhHebzk6nuKe9rv0p3/6F9L3gnLjjYdc0nEOF3QEBC05iy8qfE/CZvK3oFEzsU1TZamlpexWkPuJleoI+V+kyaeI9WHKea20F69YOdstUnDBNT30ruNNxZ7MXLpa6VPjzpBLDbJGL3nJ1ThHyePCjNFvgwmxAb6iI2Ilgi8CPX11a7i9ukDv1M54HuBlC97XnNolIyLjW2TFReVhUkVEFE1DTdsxtj5OMjamep4vXALnnrfCseigbd5MrQDnFqOZBiNQOmnTII5ihktPgd/Sf4RY6EIW0z+5GOEC56lPCksxZgDFx+j5pZIqi+TGTHMep18jXhJU/Ip4OwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB7254.apcprd06.prod.outlook.com (2603:1096:405:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 07:53:23 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 07:53:23 +0000
Message-ID: <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com>
Date: Wed, 8 Nov 2023 15:53:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
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
 <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b6f3ed-50cf-4769-302e-08dbe02fc7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s3b1hxIiUrIJdPIoYrrI2pD179TBPZQfIC3zr8TRltjlRVnB/WfsLpd0V4HmZwv/aGpVb3EMC1LpwO10dhjHHiA2AFLl+XpeQkR2K8I2+hLKbKXaFOziU7jpSDort2mfSTICiXVSw3sdoVeFfrCv/1qVccvjVfuHu6+FPP0Z7A3JRXIiwK8AXAEQBJCNtYQFsymKgTWmNCdVVxGj9fkO1yM/H0SXpuSoGd+8WOD6zDxyesZl5bUALafc11ls9NE91cOFCgwgAxlZUAukHFQY0bQnp1ly6bU27ov6768hoMxt7eeVJyHBxqMStP1tI5qUNFooSCFTqGsisx4Q0LoSIZYJU0LS+3hSduE+Rh9tJLK6PxjazxKXUWZq8L0129ZT8PyOWRf3BxFotr55ikEXU9L3WyzUsfwOTt5x3xez2iYa4x6TuuwnH0l/EOGieLltpj+qSNI5nFbylKKWn/IhKtK5p6LEpXZTLhsYyfx5mYinckFG3mwHcnUjBX+fUGVJ0aCk4neLajyiBWO2O5Bwk1GxXWSbvCI33oFDj0CnEMdsZniGu+aXynZmwkcv3osDb2YjVVGOuRTV8dvi2uPo/MaEjva9OOgHJfKVDlXUBt3Y4vNjCEe3wcSFeN7Bhh/Ayqmu1Ovs44UqnUn9b1fxdxv0qXCMurt//tsTE29GyyjQh9IJVXCI5XkrNZAJMpFM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(6512007)(107886003)(26005)(6486002)(478600001)(5660300002)(8936002)(36756003)(4326008)(31696002)(8676002)(41300700001)(86362001)(7416002)(66556008)(66476007)(66946007)(6916009)(38350700005)(54906003)(316002)(2906002)(6506007)(52116002)(6666004)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRTaCtsRkVEcDVGQTNoLytEdXN0MVdGYzJ2S3RNVVpKcWU0ZlZ4QkpFbDJ0?=
 =?utf-8?B?Rzk4M0tUczBncWdGM0xzWkQrTko1MGV4Tk5LNHNHdXo1WUs0akpKcHFES0Q4?=
 =?utf-8?B?akpaZTNlekxFNWZZZFAyb1NBVFRtUTRiTVNOSVFpRnR2MDQybFhadjhaTWFo?=
 =?utf-8?B?WkFsVlJFWFBJbFZtQXU5QkJvYzc0enRYWmZ6aEFYdFg5VW1XOFE1MXBQb0Zs?=
 =?utf-8?B?T01JZDZITDJEZFhNa21CWEwwWFNCL2J5eDNjV1FYQ1RHZHh0OHNPNkFWMDNl?=
 =?utf-8?B?VjZHT3A3RGZKeTRJNzNhbk5pVXhnWkJxbHdmald4UFJDRCs4SkVBRGRhMWlj?=
 =?utf-8?B?dmZhc2lvMEhXbi9mSzJwNk50bmwwWGlqZXNlK0t3dVBSbWRTU2o2MEYyZnJD?=
 =?utf-8?B?Ykgzb2FOUFhsVEZOS3ZJWld3MDhXenZMdFQzUi9HVVBTL3NZWXRQZTYyTjQr?=
 =?utf-8?B?YVZ2cmdrWVcrRW5jSFkyK2l2Y25QODVPazA1WmZWQ0tpcklMS2UxcHgxc3Bq?=
 =?utf-8?B?ZklDS1AwamFUbWZDSGlUMHY0WG9OdWtkNlZ5b3MwOEpkUDZzQVFzc2c0OExE?=
 =?utf-8?B?K2FXdzNsb204TitZU2QwcVYrc3l0VENZQnlvbjI1OElKY0JQeW9YUW9uc2pD?=
 =?utf-8?B?UzVXajRWZksxRmxiUXlyK2JWcVorYjU3OFhvUVRweUIyOGpoNnBoWGM5NWMw?=
 =?utf-8?B?WVYwdktLNXdGMm5TcUFwR3VDd2E0ZUxxZjZwQ05ST0pKY05GQk96aWlUVTly?=
 =?utf-8?B?b0FEZ1l3UG4zZWszaW1KNmoveFJiN1MxMHZodXdsTklJN21UdDBXYlJEY3BC?=
 =?utf-8?B?OUVXTEhQejBOSEdtaDB3WFduRDYxclJXV0Q3bjZiek9yTjN5TlAvY0dZWnI2?=
 =?utf-8?B?Q1h4MmJpclFzc0psN1ZZUTJ3MVhBdTcxUDhKSERrMFVBR2k3UXAwTU9ZclJD?=
 =?utf-8?B?YUgyMzA0b2dFcEJJeWZ6TTJyNWE3RUM2cWRxNGpXazRnK3ZhWHZlNXJ0VEFr?=
 =?utf-8?B?dVZ0QzlwdGt5TVUrcnhuRThiREJLZThMQVY3K1pWaSszSENmZTBnVHZlbXdW?=
 =?utf-8?B?aU55OTNrSDlOZC9KM1Z6RSt1UWZITzJRSkpnZDJGUlJBaVdjeTJWOXc1YWxT?=
 =?utf-8?B?ZmJJSEFrR0hhTCtKelZkNkZ6SGFBdlJSSkVveXVGUjBCQmdhVWNBV0VjWmVZ?=
 =?utf-8?B?R2V5S1RHdHpEcHRiNGxaMnF1NGYvVllORVBvVXlMU1R0S0lZYkl5b1ZlODYr?=
 =?utf-8?B?N3F4RjJxbERCQThORGk4MmZhcmxrUTFqeWFwRlRLbjFqcHRYbi9VbEdPZHR3?=
 =?utf-8?B?ekRWTmsvTkpCYmFrM21FK0xDTGN0YlBhRzBpTy8vTmF1RXVEWFB5Uy92V0ZV?=
 =?utf-8?B?dEF4UW05QkRTMzZjNWpSYitTY3NpL0RJUlJ2Y1JCakJKa0w5NkdYUkhnYlFK?=
 =?utf-8?B?ckhNOWxQVVZnVndIMkVna2V0eVlsQ3J6cTRtVXE2YnI2T2VHZWd6MGpGK2dn?=
 =?utf-8?B?UmI3dlNpMjZzZ2p1S3hnYVlsekpPL2MvVytqSG52bHFMejFkc1pYbnhWNC9q?=
 =?utf-8?B?R1ZyUXMrZ2FaUEZiVDUxaEk3S2lEK28yUXN0K01sSjRsRlRFOWRlUnhUT28w?=
 =?utf-8?B?VC9OOVV6bEZJMWFJckxxZXNkV2pqT0VtQVcveVcybGV0SnJTTHQ3TzNtOGhG?=
 =?utf-8?B?a0lNTUwzeEJubU1jTHVTTjFwUmJDVStBeTFyNFNUdG9mOVRFQTdLQjlWMGdJ?=
 =?utf-8?B?M1FPOCszNVRKSzdVRjZnSEFCUXdYUWw1TGhXT0dSTXZTYWRuUlRQRU11anJs?=
 =?utf-8?B?eU1LZ3A3cEhmZnIwci90ZmYxNDJ6VGppMk1XTWI4clNHN2JFcGUxWFMrNXRu?=
 =?utf-8?B?ZndpVTJUeFd1N3pTWElZYXJZRStPQXhUVVlmZkprbER1Tm1BQ043YktmREow?=
 =?utf-8?B?QlkvSG9BOGVoVllrOWFMQ1pNNERXLzd5MDJJd3F3anY5T1ZpZVVoYm8wNjZJ?=
 =?utf-8?B?T2pNQTlHaXZQUXdCdFhsUXIrY0FnTTJvaWUwbTFMR1loME9hdW5aNlB0c1Zt?=
 =?utf-8?B?V0JsbE9xaGhDTWdYN3ZYQzhCdk9VRXowczU1anJVTWJOR1FIQ1pDR1FlQ3pT?=
 =?utf-8?Q?XQA0suywLRYvrgpaXszCF7h3U?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b6f3ed-50cf-4769-302e-08dbe02fc7f5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:53:22.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGKmZ/NYqDeHVPvkepuc+MFxmm96tksF4zBjH3IjDdp6sFTwcBfr3x4JPWplvAAdZ8PQFXbrpeK1xj2BVgDMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7254

HI Huang, Ying

Thanks for reply.

在 2023/11/8 15:35, Huang, Ying 写道:
> Huan Yang <link@vivo.com> writes:
>
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
>  From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
> swappiness.  So you need to add that firstly?
Sorry for this mistake, we always work on cgroupv1, so, not notice
this commit 4550c4e, thank your for point that.

I see this commit comment that `that's a different discussion`, but,
to implements this, I will try add.

>
>> Example:
>>    	echo "1G" 200 > memory.reclaim (only reclaim anon)
>> 	  echo "1G" 0  > memory.reclaim (only reclaim file)
>> 	  echo "1G" 1  > memory.reclaim (only reclaim file)
>>
>> Note that when performing unbalanced reclamation, the cgroup swappiness
>> will be temporarily adjusted dynamically to the input value. Therefore,
>> if the cgroup swappiness is further modified during runtime, there may
>> be some errors.
> If cgroup swappiness will be adjusted temporarily, why not just change
> it via a script before/after proactive reclaiming?
IMO, this unbalance reclaim only takes effect for a single command,
so if it is pre-set using a script, the judgment of the reclamation tendency
may become complicated.

So, do you mean avoid use cgroup swappiness, just type anon or file to 
control
this extreme unbalanced reclamation?

>
>> However, this is acceptable because the interface is dynamically called
>> by the user and the timing should be controlled by the user.
>>
>> This patchset did not implement the type-based reclamation as expected
>> in the documentation.(anon or file) Because in addition to extreme unbalanced
>> reclamation, this patchset can also adapt to the reclamation tendency
>> allocated according to swappiness, which is more flexible.
>>
>> Self test
>> ========
>> After applying the following patches and myself debug patch, my self-test
>> results are as follows:
>>
>> 1. LRU test
>> ===========
>>    a. Anon unbalance reclaim
>>    ```
>>    cat memory.stat | grep anon
>>      inactive_anon 7634944
>>      active_anon 7741440
>>
>>    echo "200M" 200 > memory.reclaim
>>
>>    cat memory.stat | grep anon
>>      inactive_anon 0
>>      active_anon 0
>>
>>    cat memory.reclaim_stat_summary(self debug interface)
>>      [22368]sh total reclaimed 0 file, 3754 anon, covered item=0
>>    ```
>>
>>    b. File unbalance reclaim
>>    ```
>>    cat memory.stat | grep file
>>      inactive_file 82862080
>>      active_file 48664576
>>
>>    echo "100M" 0 > memory.reclaim
>>    cat memory.stat | grep file
>>      inactive_file 34164736
>>      active_file 18370560
>>
>>    cat memory.reclaim_stat_summary(self debug interface)
>>      [22368]sh total reclaimed 13732 file, 0 anon, covered item=0
>>    ```
>>
>> 2. MGLRU test
>> ============
>> a. Anon unbalance reclaim
>> ```
>> echo y > /sys/kernel/mm/lru_gen/enabled
>> cat /sys/kernel/mm/lru_gen/enabled
>>    0x0003
>>
>> cat memory.stat | grep anon
>>    inactive_anon 17653760
>>    active_anon 1740800
>>
>> echo "100M" 200 > memory.reclaim
>>
>> cat memory.reclaim_stat_summary
>>    [8251]sh total reclaimed 0 file, 5393 anon, covered item=0
>> ```
>>
>> b. File unbalance reclaim
>> ```
>> cat memory.stat | grep file
>>    inactive_file 17858560
>>    active_file 5943296
>>
>> echo "100M" 0 > memory.reclaim
>>
>> cat memory.stat | grep file
>>    inactive_file 491520
>>    active_file 2764800
>> cat memory.reclaim_stat_summary
>>    [8251]sh total reclaimed 5230 file, 0 anon, covered item=0
>> ```
>>
>> Patch 1-3 implement the functionality described above.
>> Patch 4 aims to implement proactive reclamation to the cgroupv1 interface
>> for use on Android.
>>
>> Huan Yang (4):
>>    mm: vmscan: LRU unbalance cgroup reclaim
>>    mm: multi-gen LRU: MGLRU unbalance reclaim
>>    mm: memcg: implement unbalance proactive reclaim
>>    mm: memcg: apply proactive reclaim into cgroupv1
> We will not add new features to cgroupv1 in upstream.
Thx for point that. If this feature is worth further updating, the next 
patchset
will remove this patch.
>
>>   .../admin-guide/cgroup-v1/memory.rst          |  38 +++++-
>>   Documentation/admin-guide/cgroup-v2.rst       |  16 ++-
>>   include/linux/swap.h                          |   1 +
>>   mm/memcontrol.c                               | 126 ++++++++++++------
>>   mm/vmscan.c                                   |  38 +++++-
>>   5 files changed, 169 insertions(+), 50 deletions(-)
> --
> Best Regards,
> Huang, Ying

Thanks,
Huan Yang


