Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CC5963A4
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiHPUVB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPUVA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:21:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398B5E579;
        Tue, 16 Aug 2022 13:20:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GK1bw8016364;
        Tue, 16 Aug 2022 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+Gnw3FoslHgHWTQOPkfA4s6HrAjZORX0MGRQTTSLwx8=;
 b=U0suUQnmxWJskUAtWRliCSNEXoeo8SIdxHDbT2JaZMVtNe/W7IMYOLo/fTjTJctymDrN
 ZQkxyZ/Wvaea9ANct/Q6G1Xssm/yCLkJCwetT97uBihjgF5+K/LDvHUKRr5HC8UzufFC
 2RT5YVp3fb2rT8BD3klmLOBfXKoR02YLgOiKRr8syKvQxTVYnysPJYVEN8d8odNDJtzC
 uP7iTPxuqicySj22CkbmaM339A9G5ZwoYBLl4BrAc2VOoS62wR9r2RRG8kuo49NpcJRp
 8RJEJBcNWG75ESe1AQmt/ugVdFjqQRB0DtbvakMYUvV433+9gQDHxvE7TrpCF/R7lwad lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2ccq3be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 20:20:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GK2N8J021233;
        Tue, 16 Aug 2022 20:20:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d8v0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 20:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkHBEzhh0f7pgFC44L8Sz9I6WZ5AmQLsf5LPtfLPuY01usUc958ZFh18b0wXg9pyS4bBdX5mGME6K7pcIgBIUNuLscA1HG2ezMHAcPqWdnYUw2j5e5I3W0lGzdw6gKHYREnbOHk6oGEAElOsid3dPS8x7H8eCppPAnFiwhStpd11AtZBkIpaqwPFEi1mnHZeOWjlFuJsoAR7xlHrBFEwunS33LYhz6K2X/zLfX1Ekusmz8B8hE+lBoEeIwlYrYxIH1bxldZrJSS6NDnqV9MwIkWAKzXC/rA0i0kTcSt/+GuNB/7msC9GZiUiZbTOR9K6eDsCfp9xeAEregSVdGZf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gnw3FoslHgHWTQOPkfA4s6HrAjZORX0MGRQTTSLwx8=;
 b=mixmvAvxSV8paK1JnhMw5NlzfrvSckTP+1KCSnpmvYkOWzHosI8S7TidxYDFV0eEzTvpm0RUszThEF+Arev1xNMj78hdhbsdE83YFvMLIM4aL+LQdpd1MspCcclQgg79tKOkl9lBwiJi5LliTb9frrluoW3vrZ2Xk/NDK+syQcmlWCZxi0MCVxonvDUK9Y8SCA3al9fwc7mCTbFU2gFB4yzgMS+QkweCOVeT5K6tn8fYXrBTNyPE76SLshn0Ad7Gvz9GGT2w3JUMH4Oh31bfDTDvN0/4U1y8/tvWECce0Tv6tY55h/GyF8EW8AFhD/cw0nq2HnHQ+01bQ+BUx5b0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gnw3FoslHgHWTQOPkfA4s6HrAjZORX0MGRQTTSLwx8=;
 b=prGZ++SOKfkz6mOzQdaXeZUipZsSgM9AjqJAiBSupe2b+z383wWIytvQkepMT+d5vNplUlFtQqlUuvqvcqcWjO/10ExchlhAzxeqfuF8UdrsIypvmo8f16/Z7sLfNCq811sgWmTuy8nreHFw3xmAY34kP7JRKY2wn3QQVPjNQLc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3769.namprd10.prod.outlook.com (2603:10b6:5:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 20:20:27 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 20:20:26 +0000
Message-ID: <fa9b19c7-65db-9e94-6627-31ae205b76ee@oracle.com>
Date:   Wed, 17 Aug 2022 06:20:08 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH cgroup/for-6.0-fixes] cgroup: Fix threadgroup_rwsem <->
 cpus_read_lock() deadlock
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
References: <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org> <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
 <20220815090556.GB27407@blackbody.suse.cz>
 <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
 <20220815093934.GA29323@blackbody.suse.cz>
 <f584fecd-6ca4-4ab0-763d-2ed219009c61@quicinc.com>
 <YvrWaml3F+x9Dk+T@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YvrWaml3F+x9Dk+T@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdcd4be3-c0c1-47ba-5c64-08da7fc4c182
X-MS-TrafficTypeDiagnostic: DM6PR10MB3769:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhVesfggT9XtAAbqMbHvuHB6RoKuyor5Dj//sJbIkr+y+t811P1TSfJzQIU5kUrEOIjIrCFnBSoLk4EfvCgRr3ZaokPZBrM7JJw/Irq7S6JQcd6nDxpwEi/ed+nUnqNDLkVT70TJG/Nnuta9KWcVVJ2XbVf8xVCujmKtwJcQdFK8kCAE41+vCaXJtjOnFc4CRiFRBDxAqwYoa6Sis7mNSa57wFWG9Kx2/b9H82FQy4EjeoUTrB0bvwV2qsUdc8p1xmVnWyP9lch/XdQWVuT92o81Fmisc0gHYbe8ugFAu9FRyAkLpziFTJWnbrsqMHN3JndsdOss41xV5m0yA2V/vq/thmU2MoT1AkRfFjnu5p4egKQnEau/2aqEJz8QGIbHu01YsfNTA8t/2tnxhWpCZLaUzafIyJ0xFvUJuMhH90D+5OxrtNmjYNw9UwqrR0LSVr75qxreQOJnboh0YrigCyN0xD66WY9Nhbf/RVx8a5G+vxhONzmEZq+lG8cKl7RkGNcdr5xrho0dybWZX8m3oaQhnawqsMx3NxYwW/srhVEMbirZ+kVxYMPta48RZ0SWBp+kULWQ1vAibLOxH87TfYQnR+4Oc16Q0lEdDFqXDWr8zyJYtnyrUs16wjvLoCgZIBarvE4JLsem9ev014nc25TA+CjOugieXuHR4OMEOjDDQrKHbf4j73tPWmzPE33p3pXPwb27cjA+tP2MQbmdHUdHa/yRdG/+gVUCCIZ65ooZZnb0gx+pjkCGGEqnUNvs18JqqvIpMe/YDb7NIACSOmT5Cb5jTYPUR6e9CeVVmdO+TQFLu67FJcI8P3pF7ISPQWdJ4a9uTSIqu636hbbz0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(366004)(136003)(396003)(31686004)(8936002)(36756003)(2616005)(186003)(38100700002)(6512007)(26005)(6506007)(7416002)(53546011)(6666004)(54906003)(110136005)(316002)(86362001)(66946007)(41300700001)(4326008)(31696002)(8676002)(66476007)(2906002)(83380400001)(66556008)(5660300002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtDZ2lhdUhsQlNDc0VMRTlrUmdlUXcyRjBoQXlPYWxhc0FhNUd2Y25WMTky?=
 =?utf-8?B?NTRSYVR1c1FWejFSQ245MDFMQXhnYkRzalIxMWZ1UzN5ellwUEpvSWxQbWM0?=
 =?utf-8?B?K01NcE4vMWZPV1QrT25COU01ZHRJRGRqVHlpVGJpSnB3RHVMLy94YXBUZ0ZD?=
 =?utf-8?B?OWw0dHl4dVBPV0M3RmlDZHY0TGtLT2p2UEFQbU0vcjV3VStVQUp0SkZUZUJx?=
 =?utf-8?B?OXVycTJYVGJZYzk1MW84cHVtZFVMTDljTTZTeTl0TEJMYlIzaEIxeG54MmJv?=
 =?utf-8?B?WEFYWGpLUGQ3WHU1bDI3VHFrQk1LeC8zQlI2WE5yYnZZankwam9Rcit6SXBv?=
 =?utf-8?B?blR2M2lZV3hvKzdtbTduSmhSR21YQ2Z4bGk2YzZndE85WkZaeGN1ZElSN3p6?=
 =?utf-8?B?cGVRcGpsdkxlUERZNS8xZFpUcHhqaVp4T0VNZkVGT2VoWWdSaDJxYzlmUHlv?=
 =?utf-8?B?TGdweWw2UHA5TS8yNFpTN1k1Q1Y5eEtKQnZsamJrQ3l3NFYzQ3dYc0dQTS9C?=
 =?utf-8?B?MzNBNXdMSTJ0NjB6U3Z3b09GQVU1U1I3YXBYdm9kbUxsU0tibk9aQXBmWlFI?=
 =?utf-8?B?cDZuZ3JESWpCVXpUSU5VTnhLbkV1QmNnV3ptazFhRUx1bXR6aWV0eVphVGNO?=
 =?utf-8?B?RS8ybW8vNGp3TStzbG9nMFlTNm5tdjZrWFZDMjkzY2RsaDY2cHhRWjFaenZG?=
 =?utf-8?B?RlJXak9qdUdOVW5FZFFQZnRLTzk5cGh2UXplUnkyZk9wVXc0dnNOenN4UGlU?=
 =?utf-8?B?MTlUKzNiSjFQSlcrMU9QZnJtUjJ4bGhOM1JsRXBCY1dIQUQwVGZiSkJIakRv?=
 =?utf-8?B?Umw5QXNyZFBNcGl4VGgrOTJ6eDJSTWZuNUxQR3VYUmIwWURRREozZy95WEEx?=
 =?utf-8?B?OHR2dmZUdnhpRzhmRlBYSkVFWFJJZFdMY3lvTUpwNlI3K1d3MmFhTyswL1V1?=
 =?utf-8?B?M0Nvci9jVEN0clNqbHJhdHVkWGNHa0pHemJqdkIzaGhuNjdrMFFYM2gyVEVD?=
 =?utf-8?B?eGtMa0kxeWg0RTBvb2NYNnY3ZEpDSDBjTEpsSUU5MC84VnNiYnJrYXlDNWxF?=
 =?utf-8?B?L2xCc1VXYTRzeTNoUWNFVmtaYmwwb3VBT01QMzdtNzlNK3JSWEdSU1M4aG1j?=
 =?utf-8?B?UVU2Z05oT2pSZnRoRUhqK0hBK0NGUFhnRUlxVG5TVXQ0NlB2eDBEL1JKVDFU?=
 =?utf-8?B?R21adVRNVTJ3dWJOTUJpUHA1cmxNUUZSN0M1T0czYnIwYjlXbW5tRnJhVHBW?=
 =?utf-8?B?cjhnbTB5anlDa09KSTl2MjJJNGMzdzYrYUFZb0lldHVzWFJMYXZaMDVYcHN1?=
 =?utf-8?B?ZjZ6Tm95ZVdKVjkvOC9tVGxkZENkem92eDJGdFFqTFBGci9EczRXK2tsRC80?=
 =?utf-8?B?ZVZFR1A4c3NvUVdLOTFuN3Rtek1qYWdmV1JWOU9iOWVwbG1XWU52WXBFMGFs?=
 =?utf-8?B?bGNYRmpFQmNGRWI1TkVld0pjUk5XRHN3QmY1TlJJdHZDcVpmOVlnWlFETm1R?=
 =?utf-8?B?bnBTWlI3U1NwalFmSTdxRkx1ZXdJTUUvZWVIU3d3b0lISi83TWIxSG5CKy9H?=
 =?utf-8?B?Y2dtcEh0cHdJNktTMlVlbWYva0M2djFBQ21mWFlpOTh6a21SSUUwNlovakla?=
 =?utf-8?B?ME8ya2N0aE1jUG1nVWJpb0hzd1A2OHpRQU1tT2sxaDl0SVBqRUh0RmxuNWJI?=
 =?utf-8?B?RlhVZS9SWkxxSVU0YmhSZ3VRR0FQVm1hdUJGcUR2Q3VsNCtaYjNUbmdJbnpr?=
 =?utf-8?B?R1dxQS9DNjB1SEc3N0V3b2pBUXk4ajlRc1hTNDBZc2JSVGdxd0gwK1l0bDlk?=
 =?utf-8?B?K292dUVzU01mTVh5UmNEd2NnUE9WRk83T01Kak9wRnorOXpReFdFR3g5MDFo?=
 =?utf-8?B?Z2tjWEZydi9UMHFwdDhrQjVRK3lwMzZtWTVrVFJWR1BlMFFGa0IxZ2ZLZXBu?=
 =?utf-8?B?Qk11YjVhelhjdk4wT0JEUmhYUUdwdS9iNFJjVERSUmRuYjg2eHJFMGZoOEEy?=
 =?utf-8?B?TUZROTFDOVdSTElOWWhVdnBZNUZTeEt1eWE1YzBmOVpFcHVpcXpyYnBNMEo3?=
 =?utf-8?B?UjJ0cG9FTkYvM1RhSUF1U244SCtnUjNsOEljcHlZcldMYS9GTDBKak85dnMr?=
 =?utf-8?Q?CdVIgpRnBZ/mZbdIEiRH6BRTx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXcwS2M4UElHWDREQjluRFlJUWlXVFp6RldsbGJiUVA3N0UvSmVYaVRYUjBB?=
 =?utf-8?B?MEV1NEhndXgrK3dXR3d4UUh5ZHVLY1kzbE9BTXNZV21nZ2VlSHlEbVd2cDk5?=
 =?utf-8?B?REZ2MWZ4bGlDVmkwQ09VWkJsZkVKQlFkNDFCRGU4T0plQ0tSZ2kyT09CeTFk?=
 =?utf-8?B?d3ByQ3dZY1pyYkp6YUljN3dzK0xNR1VEanZQTU1WV2p2UjBNYWlsM0RMYXkv?=
 =?utf-8?B?VlNnT1F6aE5ycjRKTnNZck5STFUvQjFUNW9rbzIvc1JxQk9JcURxNFV2a2tL?=
 =?utf-8?B?dk1QRHkxODZtUGY1blErZ3doNHRlNC9sNFZJQVI3RmZxK2JNUVdaeDdwbVZw?=
 =?utf-8?B?R0FxNDdJeUJVMGRiUmZDMjJmM0pjTnFYKzRvUzJPWGVOcDlpZVpqZ2d5Um44?=
 =?utf-8?B?M2hHYjRLYWpWQzdURzUvMlZqR0Q1OE4wYVgxS2VoWSs2YUE5R2NVYWQ3dGkz?=
 =?utf-8?B?YzBqVGl5cE5wNk5IOU51Y0hvbEppN2RuQkR3VFovSHB5M1BnVkRsZVZLME9x?=
 =?utf-8?B?TUc4Q1RDM1RWZkZDZUd4RG9XTit3aUZzaVlKWEdRY0sxc093UjExdFY1QlBM?=
 =?utf-8?B?dlRHenJ6SjI4WnBmSDZtOUNRMEJsZHlHajZNOTRmcjJwT1FxSlJ4UEVndXpm?=
 =?utf-8?B?ZkQ5MzkrTDFsN1BhUDJlUmVxMGovbFVsUTRWVEFzSFZRNU1ZbFdpWHlHNk00?=
 =?utf-8?B?ZVhjSnBQNDZ5T2dtWWsrcE9IdVp6TUFoUXBOWGJ1K29jRElWV2NnN3JQaEJB?=
 =?utf-8?B?V0VtMnhPa2l6ekYzMzcwYnZsMkR5OVRCVnNoaTlraFlxN2VTMjYzaEFBUGhH?=
 =?utf-8?B?ck56T3ZzSE1KRUJwT2U0dGUwUjA2bHFWVWlaRlVVY1hMZmhoQkZMNzRyclA4?=
 =?utf-8?B?UWowaDNxaUx0TmFSbEg5TUQ2Sm9oMUVPb3ZHVzJySDAwWkJONFVHcCtrZnJq?=
 =?utf-8?B?b3RLZ2M4Z2REVjVneUdCekdiOGZ6SVNZQWJDQ1R0Ni8wOXQvcVdzeHRLQy9i?=
 =?utf-8?B?UlV3ZGU3Rlc3ODZ0eUhaZjJzOE5xOHJRd2tJblhPUk5PclR5Tk04S1Vlam5h?=
 =?utf-8?B?cythdGx2bkRpVlFjUnh1NmZJc0lkbFpwZXhXUzFsaDlnNXZmemJnZkN2ZlpD?=
 =?utf-8?B?elRESVhDYmNnTGlNZTU4K2xUTzY5SWpMVmNBSmlOYUIxUm4zekNRZkUzeFJO?=
 =?utf-8?B?NXpndGh0MllFazYxVFlyajhOa0JpeTQwcmRQNmc1bUdzeFhLaGhoOUcxRXFX?=
 =?utf-8?B?N3Y1Mmd4OXRtQ2ZUQ2J0OGNkK3dndk5LWjNxNUNVNDdqNUtWOXhHcm5Hdlhs?=
 =?utf-8?B?MXN5SHdTVnVKVjl4U200dWs2VzloNmJHWXNEdGRzZDZxS2VkOHpXeDdjKy8y?=
 =?utf-8?B?emdPdDRVNWxVU01SNkthN3FXS1ArRi94eVNMajdjaGlJVUJVU0RWUnlpUnN3?=
 =?utf-8?B?K0tMVEwreXlCNXNUaVB5U1BibXhwSjFuTVJyYm5yL2hnelpsMnVSb2g5OEtq?=
 =?utf-8?B?aGQvVVJ1dmJwTi9LUnladkdZdE5CaFh3VDZuK25vc0NEcGFKVzhsYnBUVE5L?=
 =?utf-8?B?cGs0Y25Md3lOMjJUTlV3YVZLczhMNFQvY3RrL3ZrYUt6eEE4SmxpKzNpbjZy?=
 =?utf-8?B?YUFDS3hzTytNL0REbmVHSWRuNFdEZGs4WmtQc29kUS9MNVpDOTRSMWJGcHFP?=
 =?utf-8?B?UXIwTjZRZzkvUHB6azk4cS9zUFFBTHg5YlI4QS9RUlY4NE5oUVcrYm1JZWt5?=
 =?utf-8?B?VXg5M2czUDk3OXY1U250L1lqbG5abXIreGZmSloraGwrNUhFa3loMlc1dm54?=
 =?utf-8?B?ZytOVWE3a0twUHVVcWdLYlRUOTVXQkVWbjZNUURhWHR0WDdQZDFFRnF2dS9o?=
 =?utf-8?Q?o7/ESAxM2nHRm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcd4be3-c0c1-47ba-5c64-08da7fc4c182
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 20:20:26.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEZ0tw8H6PznTGIkYj6XrWo2buz5pHL11iDZkz39Jahtx9Us3AzLprL6hAdSkC5359dh5gzLcPD6zp01EZV9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160075
X-Proofpoint-GUID: jc1obe4RrF85EGKvVD_WUGduUkKFvtcv
X-Proofpoint-ORIG-GUID: jc1obe4RrF85EGKvVD_WUGduUkKFvtcv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Tejun,

On 16/8/22 9:27 am, Tejun Heo wrote:
> Bringing up a CPU may involve creating new tasks which requires read-locking
> threadgroup_rwsem, so threadgroup_rwsem nests inside cpus_read_lock().
> However, cpuset's ->attach(), which may be called with thredagroup_rwsem
> write-locked, also wants to disable CPU hotplug and acquires
> cpus_read_lock(), leading to a deadlock.
> 
> Fix it by guaranteeing that ->attach() is always called with CPU hotplug
> disabled and removing cpus_read_lock() call from cpuset_attach().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello, sorry about the delay.
> 
> So, the previous patch + the revert isn't quite correct because we sometimes
> elide both cpus_read_lock() and threadgroup_rwsem together and
> cpuset_attach() woudl end up running without CPU hotplug enabled. Can you
> please test whether this patch fixes the problem?
> 

This fixes the issue seen in my setup. As my setup is 5.4 based I used
cgroup_attach_lock/unlock(true) in the backport version of your patch.

Feel free to add my

Reviewed-and-tested-by: Imran Khan <imran.f.khan@oracle.com>

Thanks,
-- Imran
