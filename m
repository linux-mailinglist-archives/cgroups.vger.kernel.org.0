Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21416CCC07
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjC1VTA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC1VS7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 17:18:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863411BC8;
        Tue, 28 Mar 2023 14:18:58 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SJRJP4024705;
        Tue, 28 Mar 2023 14:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=EhPMp2qp9jjI1AQyh9X+OKpkYZAtozxBNWxVoOqwgbc=;
 b=PBolmj2cXkQHAty+kcK87WJQCfcWhmW4CZwtw9t0qS5TBF2uI/7UgBWQ22Ulocp5ONl/
 rRHHXgurzyS0ypvs9evEzcO05Pa4nGY5iCdz08936Q6EK9nrub+HgAEzi9NLoY3kbUzr
 I2qhbSH3heZoduVb70hGQqzuHYOlyoVN0TTmRcdeP7ekfy41zPO3/ChoQ++HNhnY3wdt
 g1raueq9nP9wBjJNeXn1k/LJPSR/ohwwLDw3g2wwLs3r/83k6WePHM0BgSzPkQbyfFXR
 75e6c8jmvyGPOjDQN3eaOdEKVpp/bA1TInnKovEqOnfw7ZrOQ6oHHTiExAhoTFjHudtG aQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pkdm524rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 14:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu3Xso0F5aXgjVsR9tSWhTsz7U7LW4ODx9zTSb7wRluqajQttgp8r6naXQG8zNcfbQGLZMRI8cYsasMndvQpqVrjoCq3+Kp4R+NWofZX7C02jICvIBjxkeax01z5a/Nh6kU7/bMqd0KBBkCkDgH9B+G6nLN3KXS3jeW9U2SEIEDLqsLSVGSZX+EvTsht5RyaBXR/Tj8mUDicRrGVL8BvxIVStxkG9Bbh33WNqiskpVwLidm8kOIYFH627qwwoMErXUR3i/sMFDUDHvmgXEDsHAsj44/bFkbj6+f9Q+MKVmSqPTG2R0OOQPmGjmKxShKChFXoWE+UtWfM3n5WFHZXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhPMp2qp9jjI1AQyh9X+OKpkYZAtozxBNWxVoOqwgbc=;
 b=hzUqQeDzXIZll4YxtEPps9SdfKlxZ66ywZibuyG148W+riknwoph+XjEk8LswsNbXINHBnYvG9DDpK6N5l/Zvww5O5BBMo37UMvy3zVZtuGM3LsKOP4PcFMM3c4rZMLGlfm0YnUbcm9S1VoEde+XSKrcsm4KaEEm0JwJMS1XL7o7ks8rBd9tFqAfdnFw78olYGGr/vJIyvR4b+/fTS8npD0eoCUlK4Zv2omxJWVyTMHY+6r7j8DZIlf2nDUyEnWtl2Pk4/AiSeMd/R3D3jHJHoGlr02v6Pe05hsyLBjbF9Qc2E02+8nIMn+mZCE9UJ8h0eNL0YGizF+n2AJdRKcHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DS7PR15MB5787.namprd15.prod.outlook.com (2603:10b6:8:e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 21:18:46 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 21:18:46 +0000
Message-ID: <512eaacf-3ff6-f4f9-c856-a0e03c027501@meta.com>
Date:   Tue, 28 Mar 2023 17:18:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: move bio cgroup punting into btrfs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230327004954.728797-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DS7PR15MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a106bd-e2bb-4232-87aa-08db2fd20450
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzOgz/9oloqPq7DhvFE2Zqe8vyDeurVhBuljLjPDei7VkWYe+2SaBB96CQtUqoS2pNkfPEbnbjMQJ6xIgoMjYjU8smzK5aZFSAGL2mjo0LCLjuDBIH8/Z7mK6gPjsLPAAGoV6rECUTQfr3Gz18/RxgLhUXFEn3IYwicq0y6q9rSRmBfcO4EikIViBY7hIVNMph2ZceVzKF7GO5Fm5vCvkbv/pjHBty/KY9JSPlPUme1KhOqXcUPnSkm4K2KmDPIduAbs/I/VCciwSBDBTwNgoOih5o4Qlfc++f3TZCjz3RJEt3zMS+ulGv6/Fw0/oCnDiFJe6axcwpUbq7wCyQTQpTNFjnIHjMy+JtWk1O0c/Cs1MvRAaSRuhvXH2YJSOcLwecr9cSR3bDXKKhy4OxRMjOxKuxk8a8jXm6qAnjwbWuvGkWy1+7q7PEl6sk9GOYHJUIS4ikGchIDgFkejGZqKV3YLqp0CMCihg/pCxFX1w9Dpd6JvidCJp8PZsFN+aX/qYleDwA6vuq7kEYpxGsbgEGuRl7jAWrOS6f0jE+Jdi5kaCoVkC2yUKi12dKG1ERV6YpoC0nSKJVDElWedSOi0NDfHZahFUkweK4iXqzYHG6PSAB53K1DY4mYoE5kclaJ9VO6bi3iF7qGAh0eopaCm5JeKM/KI9x3fsEz3OehkOpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(2616005)(36756003)(31686004)(186003)(6486002)(6506007)(53546011)(6512007)(6666004)(31696002)(478600001)(86362001)(110136005)(54906003)(316002)(41300700001)(4326008)(66556008)(66476007)(8676002)(66946007)(38100700002)(4744005)(8936002)(2906002)(5660300002)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3R2blVHN0pwbEx3RXRmcndGa3IxY29FRnhlR1BubWh2ZjlXR1pCMUV2U3Fk?=
 =?utf-8?B?WlQrdzNacFEwSk1yUHVoblAwbDBwUU8zT3A4VU9GMisyQTQxaElIdTVRRXFQ?=
 =?utf-8?B?U2VFWHBxNTdJeXR3RW54Z3gxckpXNnpGbTlPZmE5VnNnQzVncG1nTXd2S3JE?=
 =?utf-8?B?bnA1Yi9LeHdhRjZPc3FqdTU0RHdIUmFQZU5TQWgrbTR4aGlHVVg5T1pmT1JK?=
 =?utf-8?B?dzFFSjlIVmN2OGZvci9wbGM5V1FtYkxSUkt1aWxhVXVONTZUY1JZZkk4UjZ4?=
 =?utf-8?B?djZxRDJtUDdWNEIyaDY5MmpxazBLcGJkZ0o2VFQ2WUlEa2pCMXMxVjVjNEZW?=
 =?utf-8?B?YlArRDJoTUhpM3NOVVhjWHdmbHgvM1pYcnBtbFZITHFVT1JXdFZPNmlyVFFo?=
 =?utf-8?B?R1cwcDNTTWxDY1Y5RTF2My9SWFdCbmgxRUI5RkxEVUNjbVZVa0ZZOExnRGVC?=
 =?utf-8?B?Zm4yTFkxWTlCZERDekIvMDJZbkRpQW9paHM1Zm92azdVK0VEZEg0c2N3UEpW?=
 =?utf-8?B?TUl2R3NzR0JuZ1ZkYlRXN3ZKbHpXbFN6YnY5RHdBL0JNVWxtV0k1bDFCdUNq?=
 =?utf-8?B?ZE5DVXNEcDJ1aDhDeFh3Y3ZwT1VEZ0pZSFJISzdFM2g0YzRaSnhCeHpTM1FH?=
 =?utf-8?B?MDk1UXpLMW1YaHFVWkdqL05BR2M0MUh4ZUNneTNHVFloeUhZQWp3bHB5clk4?=
 =?utf-8?B?SzA5TGN1RFV6Y3VGSTgyNkJBZk8zWFRvb2NrenlmTFlvQTNkSlhudytvM3V4?=
 =?utf-8?B?N2loWFVKa21zMDBLRGNmWmVEYzJHNXlDby9Jbi9sRTE5cFU5K2Jxc1VMdmVG?=
 =?utf-8?B?eGhpb0xiNmFNcmdjZERMVVhmQVlhemxNVlZRa0JndmpPQ1M0RUJEN0RNdUFV?=
 =?utf-8?B?T3IzZXlCYmtUd1JiR3VSeHhycFp4MjVwbWMzVUdCdXk0SkY2UUxEMHF5djlW?=
 =?utf-8?B?WXRJaXhRdUlqNFNyVThlTWlMeGFnTHU0M0JLOVQxK29zRFk4Q3JXdUg5RE5Q?=
 =?utf-8?B?bVZKNk03cXJCbHpnbnBWbHJ3dGkrL09GZy9zS1A3TDl0L09nWGRiT3pUbVAx?=
 =?utf-8?B?VzJnUEhBTjNrUFNTTmgrdUVTVUdLNW9LL0U3bk50VEZHYzBmbkIxRDZQS2cx?=
 =?utf-8?B?MEZxdTBQZytkTVBxNnRaZFhZZjg5QTE0UmNhSS9MU2lGUUUrZkJKSnE2VVQ1?=
 =?utf-8?B?NjgweE11ajREdmdFMEgxaXU2UHB6NGtPL0haT2E1OUlSTFprMTZPYUFGVlFD?=
 =?utf-8?B?MlR0K3QzWmx4ZEMyS2pXKzVJRjE3aGRiZ2drckt6NW1KSThBN3BvaDBHWGVG?=
 =?utf-8?B?SHhSMitIZDBIUWhLRDliUkhBWEFiNDJpTnlOZ0s1SmRkaitBVFRZaWZCbUxV?=
 =?utf-8?B?NmJrZUFmWXJkMS9ORlRwZXJQZ1E3cWlxcEtQdWxPRnpRS2RYNENWY0t1eDF2?=
 =?utf-8?B?RUQ2Q29oL0cwNnVvdWR3OExxSXNnaXBnaDdzUXNwaWdDdkh3VlpJbzEzTW5S?=
 =?utf-8?B?Tkgwb2wvclhoWlZoU216bGVPZmFJeUw4cHBCdzFWVGd0YktYdVNzS2pOS0Y2?=
 =?utf-8?B?V0RJQlVpWEREOXBlczdGdW0xeGRncTczai9hRVREdllkQjIxMFoxT0Roa1Yx?=
 =?utf-8?B?SVpYR3puZk9RMUpQS3o1WmIyNUIzaVNXMFdTTExScFJBM3BrUmplVCt3QzJW?=
 =?utf-8?B?Y1poaCsxcTNoVGFjRXpuYXk1b1E4YmFqN1dsOVhNWGJEVDJSZkh1ZmlqdTJa?=
 =?utf-8?B?NTFCRi9xNm4yL1A5cnAwQzhmL25ldEE0RlExSDNRdkhxSTVWZUJWd0Y0by9w?=
 =?utf-8?B?VnozVlZxelJ5enJQSHhRWk5uS0dxZUNINVp6QVk2YXdMSEhOUS9jeGQ3VGE2?=
 =?utf-8?B?a05nQUJYU0VwNHcwVEhPT0xpeTNXTkYwK09iMnhzQ2l0VzlVZzhMalZneFMy?=
 =?utf-8?B?MDlERGEzUHNKTGkxMTVGamtlMk5GK0FjWXZWc2FydUZIL0w1cml0MlloNmlq?=
 =?utf-8?B?SnNadjBnTUNpRnlYQW1jVlhubkhCTlg0SVovUHBId1hGWWlPVSswT1RlTXFu?=
 =?utf-8?B?TkxOMjVjZFhDdGt5N3ZPSXZQOCtaTzZoSEZkc2xRQ05WQ2dQdkh3ZDBDOERQ?=
 =?utf-8?B?a0JFbGY2emlCTVFTS0FXOGI0T3RPeEJqSmptam1rcnB5b1BYWEZuQmIzTXV6?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a106bd-e2bb-4232-87aa-08db2fd20450
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 21:18:46.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjD0MKJ9JPKdEMnHEsps5T6GIlovPPBqYSdegM9UUK1VwmZTxGdw6kX3aGOqigjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5787
X-Proofpoint-GUID: CxiBt1D2tBoO09d9iL4kPWwQ-H22NGS3
X-Proofpoint-ORIG-GUID: CxiBt1D2tBoO09d9iL4kPWwQ-H22NGS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/26/23 8:49 PM, Christoph Hellwig wrote:
> Hi all,
> 
> the current code to offload bio submission into a cgroup-specific helper
> thread when sent from the btrfs internal helper threads is a bit ugly.
> 
> This series moves it into btrfs with minimal interference in the core
> code.
> 
> I also wonder if the better way to handle this in the long would be to
> to allow multiple writeback threads per device and cgroup, which should
> remove the need for both the btrfs submission helper workqueue and the
> per-cgroup threads.

We tried a few different ways to solve this internally, and I'm not
against folding it back into btrfs but I'm kinda surprised that nobody
else needs it?

Is btrfs really the only place using worker threads to submit IO, or are
we just the only ones looking for the priority inversions w/resource
control in place?

-chris

