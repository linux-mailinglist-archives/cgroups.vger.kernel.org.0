Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADFC6D5B26
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjDDIpP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjDDIpO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 04:45:14 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FE10DD;
        Tue,  4 Apr 2023 01:45:13 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3346uujA022123;
        Tue, 4 Apr 2023 01:44:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=CwBd8VIVqig1KSETexcoP8hRMLyRRDRlZpfgmLHt3x4=;
 b=XNhEVMGk+X/Fum0Lijq/qlsAtJjnsWZpIzLlKiAsvKUNJNqkBgQCFOWXeW6ourXDbzyq
 /5jco6EojlE/FPntsEH0aqBZ22VtcOSIQE/38cyUZlBgAX2pK9an44RExlwX4dTKN2hd
 V4FP+1Ps8jjqLRoLtZsvGRdmbZt12PtD0lgjhC8Hr2haSK31fmlUELrMshdHdvNRQENX
 k/ZlpZElSoyCCivnqAal9slBW1IE9i3NPC9j425LsGKqaxS3M53J3T1BIYhHVGL3eL8/
 3+jTX23EXaxiFq5cs/ln1Pi+v74/FLgPwBx4NDPmXOUVcrfeATUdEhvCfsOHePEHvqFa ug== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ppjqme5tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 01:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqhwp4msGlBIH5Fzg/sOU+MiD2Vx0UO4qIid0WvGZjwtTVdtR0IA5ic7r4NTxz7PAuHrC8nLlnNYJmC73X9Q05ZtgvRGPhHhAn3573DiKKjfPrx4wQsQRZwh/s2Z2jBf+9RHtdaEt3z/tEDhLBw0Rlnbw4WpBZpeB/I5NTixA0zBezSf3QB1wW6urd4rab4Wef5GROMnX+nJ7FepoP0ilrwXtyvC1uln+LyTYfnCZTxCzBLv++zc5FoyRb/++rWbQvb1p7ENkSKUac3DkHpjzW2z0YZRcZ02XXpPgZymQZ2JaICBUWPryY5YdBOLCLGgf+L9BqIqzYM9Y6fe83E+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwBd8VIVqig1KSETexcoP8hRMLyRRDRlZpfgmLHt3x4=;
 b=Xf0Vjs//L1BGs1U/8UBd9CXsD53APetjLOAcSoJ/N3xs/83SaWDDjmI/vg6x537kDmsaW72QPgnnZ0+bMXSjrGtvjLBt+6gSjtPF9m9XCaeIV0DEtGhhAZyMk90AiBVCEUr6dJLB57wfa50+UODmcoewYRiT5XASfjIatualt9Ch5Vrg+mSICrZJCkYU0WaV/m+sX/qb6eJO1b2HFvqn3GCDK3V8NwUgV39JPx+DpKaN4N/n6tQ4+6o/uqQn+EVhc1Tjfo6CjSh8Tp/XuJ0b3ghuCbvlRTP0Y7y1DPC2MIb0/OKxODQ/BWWIPu9vCd5rUPdyc6832hZl6OupiWEMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwBd8VIVqig1KSETexcoP8hRMLyRRDRlZpfgmLHt3x4=;
 b=oOBqJBgQsai65YnlwhuU4zUOD1/QRBxTrf03XXBlaS3potkcs7t8f2cp/YOrXJZYVyT6k3ztW4L2RxRiOjQSoEvO+Co3ArxtVOXKkI9Pj4zkgPNdvSPaz3t0U/Ev2DVbgaloKVlqrq6hiAiu8uuqN8KZ1FT+A7wDT5k20KkMkQbvmErfR1DWhZE1iDSHp0oQLlHVNlfr6G+sTRq52CHHbsOx7BlJ/T1IiPNKnzwLWWEaUIcyMYFfNGFvqzNCDdF9dz3k7h4L5WOTBxdWOk0S4PKpzdcxeGNPnkN/sZgCVwH/8k1Q1TWhnqg+vhR4+tlnUKCfq2pVpNg8col72i1AWA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by SJ2PR02MB9653.namprd02.prod.outlook.com (2603:10b6:a03:53c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 08:44:54 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 08:44:53 +0000
Message-ID: <63942948-a41f-c4c0-dac3-b71adb38496f@nutanix.com>
Date:   Tue, 4 Apr 2023 09:44:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230322142525.162469-1-flosch@nutanix.com>
 <20230324150350.fu7itbqqvtjmyf3s@blackpad>
 <6f4420d0-2f86-7294-01e1-6806ef7e4686@nutanix.com>
 <ZCH/RVlh1M6DRXaU@dhcp22.suse.cz>
From:   Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <ZCH/RVlh1M6DRXaU@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|SJ2PR02MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: d36c570c-0bf5-43e7-3404-08db34e8dc17
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ap0X9b6fITdRXSA2KNQ+169YqCKP4pLrAEbiW1fv7wq1n7GbAhT8B/WPxASO9IUzXLVwQysrLozPrMXMpfKCdqiagEuo34SH+BJfjChNL5rQE3BCtGZZZh43g8fxU4pkBuwofpRNXov3JF43OtcilDviiCZGQfyD1lYDYoydKtoqfIoogzOV8/2XYugsglX4Cnkt0FGt5AWcm2PExRQavaPuW+fK4452WxreLMCthaCFA0wz/mt4W4JU0d/b2wZUldhXtvod0vgixsu46N8uK2DEvJVXDzjlXIh9yaR1p/NGO3LODuhpN8t3jU15XUtgbSAKVPLMfSJ0z0mFlKWsSl6pQwXsU3cfqVNc5Wzr3loYnmO1W/sPG4+7yOY5AkerwPCWNzG7t2S7Gi6gzh6QRfQVnEato3tf66G5oDcgtVWgEu3huZ4jdnqeKgy8LDt8p24uGzOyBuP3f01FwfdEog2XMtY8XMsLGvbwfwZ8MdvWT7KYH3iDsgnBRKn9b1tUoXW/2ipBWYgG2ZElJO1GwYvAveBdNqEtOlmI+mc5TARSz50FLPuOTYBgdcQ921a7P0xFm8Ae/gWEk8bvftlo/YdXMQ0y27Y3Q14tdiKzg58g2heAjVCt/j4MeyF/MWOd7tedDqj8ivbIobVCxSw0tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(2616005)(6666004)(478600001)(6486002)(316002)(186003)(4744005)(6506007)(26005)(54906003)(6512007)(2906002)(5660300002)(7416002)(36756003)(8676002)(66946007)(38100700002)(41300700001)(4326008)(66476007)(8936002)(66556008)(31696002)(6916009)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S283cG8rZEp3RmpJMGJ3bmlRMWc4YjJCRXU2Z2F0VnpBZU1YUk1RYzA1ZDV5?=
 =?utf-8?B?ODVkdExpWVprRHB6V0ZWTjNLcVJFeWJkUFFDNmE3ZFRZd2lKMit3U3hWRGJv?=
 =?utf-8?B?cTlnVmRwRXpZOTdubWRyMnU4VTdoOC9vRGZpOElta3hORnZwWjlGeGJKai9X?=
 =?utf-8?B?TVBFRzg1K1lFODRVTDEvZ1M3YjY3MVNPOEdmdDB6Mml5THJYNHJKTDdjSExn?=
 =?utf-8?B?SnJIZGtwdnVnNHh6Y2ZnS25JRmppMXhndjFYM3RPZjRjSEtRYmdJSnRsWnVy?=
 =?utf-8?B?WUNnSFJsSTF3V3YweHloVFlWaEIrYVNTQkl0a3oxb0xNWEYyc05nM2lReSts?=
 =?utf-8?B?ZHpYd1lHdEpXQnN2Ums5SjkxUUJxMHJXc1lQM1c1S2VFNmViRUFObUliT0FJ?=
 =?utf-8?B?UGtZeVNESmM2ZFROQjJsNm1PTkwxV29Dc3dYRXUvcE8wRmJmbHptNEd2OEds?=
 =?utf-8?B?eGp2QStTMlp3MFkvSGNHN04zckdXb1dHcU1yQU9oSURQK1ZpckRVZWExR05K?=
 =?utf-8?B?dGpaZUwzeTFUZ09tMGtLZ2xHOWIrRDQ5b1dXMzA4c2VxK3JpN3N5MFIvT29L?=
 =?utf-8?B?a1l2QmhqSUg1Rkt4L2s4bmkwTkxiMUtUckxmUDZoR09naVZTcGgyWEp3VG44?=
 =?utf-8?B?TkpoTXlXc3J3REE3dWRWK1RuN1oyMUY5MVNLNk1YcnluZHhmeTlFK0ppVnRS?=
 =?utf-8?B?bUtEc2hDalBJYzRpV2kzbUdRQzFHYVpZN2RhNGtUS1l2Y0lBMHlwb2VGYm1v?=
 =?utf-8?B?RHNaTnVUT2EvQTBaSEJERjBxVmd1RGRRRjdJd3RvcCtZUHMxTWFwWHRKZVZB?=
 =?utf-8?B?K0laeS9GQ3ltdERvbVhSNlZiOUozZDAzRjNHeERDT1hVZGVtb1VvUXhoMVli?=
 =?utf-8?B?elorejNxZjE0cGdpbzEwTmJ5UkVOQjhOanFFNWZCYUk1NDRQN2RxYk9XZkRq?=
 =?utf-8?B?RkpoQVd5QkVoOUY3RE5jZmt6MTNXUUhVZ2p5R2xFMS9xMW83TFBPWXA3NVlO?=
 =?utf-8?B?Ty9xZVUxOE9uRE1iOCt2THBYaENobmFjTXNjaFUrT0JTOXV4VnZoQVlJb1Q4?=
 =?utf-8?B?YWJoRFFEUzEzTHMwdzFTUWFLdUJSTGRLQ0toQWpDbWkzTHpUMFI3VkJZc0I5?=
 =?utf-8?B?b0hBVHd6Zkhvbi93SUtiRFRUZGRtempxVHY2T3JWTXFXcHVETytYZ2VpanVw?=
 =?utf-8?B?WC9aSnFpTWw4dTFiOEFxcmRPalVkU0xSNHoxRysveGhjbWJwZ1pnMUNYZ0tx?=
 =?utf-8?B?dldsdXNQaVVDQ1NTb2R3cGQ5ejBuNlpTUnRUWnhJUDZkOWExK0dZODFPNkYx?=
 =?utf-8?B?ZXVoYkE2dGJNbkRZQjRIdUIyQUxVNVhYV3NtUUgwaFNXamZ0c0RrYlFVeFd1?=
 =?utf-8?B?eVJmS1RVTVB0QmlQT2p0WW9YdzUxVE5mL240bkQ2cXREKzU4VUVHL3g5VStx?=
 =?utf-8?B?Tk5Ra0dVdmViTEZXbUYxb05td001dVVXVCs5NGdjR0doUkgxNTVzeGZlMTJW?=
 =?utf-8?B?YmNPeUQybFhMZ2NkRVV1MnN1UFEwNGRQL1J3OUc3QW0wRzN6aGJpcUJsOXRQ?=
 =?utf-8?B?eWRMbE9iQWRqQjJ6b3F0SmhTZitrK3hQZTAzM0lPVUhkOU9pNFVjYUdrdnFt?=
 =?utf-8?B?WmVPSU0rODg4QjQvY016Wnh5UGNKYzBsKzZpTGM0ZG5kUGRwR3dCZTNXSmE5?=
 =?utf-8?B?MlBJbCtqaDRuWXB1bmk4YkFtVmxDT09yTjJiTVlxbEVIeVg4blBKc21ZV0N6?=
 =?utf-8?B?V3dkSzJaclVqSndFUG1jaC9RN1pOU2FRQlp2UndZOUIwVUlZY2N6M1duKzJB?=
 =?utf-8?B?bERDcVlpeWVETzM5czVlTDNyZHNqU0tCaXAwL0l2WUNFVlprZEp2Z2prSGM3?=
 =?utf-8?B?ZnIwdWJaK1RvbjFmU0ltOCthbmk2MTNpZGVHYUVPd0pjblNPSFNGSUh3VXRH?=
 =?utf-8?B?a05ja1h4MzFtb21GTXFNRlJoS2NUR2VSaGwvM3RidXpQZk1WQjFVcWd2bTdp?=
 =?utf-8?B?V1VJenNBNWhvQldVWkhvQmRrWmdSdFFYRk04ZGFmdzJLVC9YRTB0OTZaeUQz?=
 =?utf-8?B?aUdjQVZRYnc0dHhzRUNtc0N3UlgvY1kvL0c1OUs0K3FwSVN6Z3lqRXUrZ2Jv?=
 =?utf-8?B?SUdQakFMcG1zSWVPQTlYUlZOMHU2QXAzbHJHWWRNUTZZdUN4WkZLYzJTWFAx?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c570c-0bf5-43e7-3404-08db34e8dc17
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 08:44:53.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmqTuJdomlhv6RJ9fhizwc7UnizF1oDVjubcoX6tZUNO0St7lq7FFUi9etd2oFqb3DzlA52ACHiuJjT2U1Rvf9cXEr41OFlGSPeZOQfE67k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9653
X-Proofpoint-ORIG-GUID: al_-d1Qml2luVfRmd6jsln_bWVJ4b9wb
X-Proofpoint-GUID: al_-d1Qml2luVfRmd6jsln_bWVJ4b9wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_02,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

to summarise, I've heard generally positive feedback from Michal H and 
some more reserved, but not fundamentally opposed feedback from Michal 
K. Thanks to both of you.

Since there's been no other feedback for the last few days, I'll raise a 
proper patch, and any potential further discussion can then be done on that.

Cheers,
Florian
