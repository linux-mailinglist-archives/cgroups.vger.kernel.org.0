Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17074E48EC
	for <lists+cgroups@lfdr.de>; Tue, 22 Mar 2022 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiCVWIp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Mar 2022 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiCVWIe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Mar 2022 18:08:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179B6F4B8;
        Tue, 22 Mar 2022 15:07:06 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MIITn1023181;
        Tue, 22 Mar 2022 15:06:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wllJnS0XqXipMf6tAFjOz4iAppyqxI4/ObmWs7r6k40=;
 b=QzJ/X+N9DsgP11dUOewwzvwIclky3bIi0rKZruL3wu3c6fuxtjGyvfQQEivvmf/u/UGY
 u7J4IfSFKH6qUNYJJfo+mTUpDdPtVuhpAtRNtkE3iUbhSlO08ZPirfwOCZ9ZlLv6E4yy
 +USmXRlT5yFtKbnvwzEV6b3/vWtbOYUbvIs= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ey802q1jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 15:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YajQxkLfwYY/KExOo02xKD7LN1dKzfwXa4Fk3XFp7077yU8QoWkY43ksxbyhpjXvRu4Am1Y3fKWspr/iSTzElL859pFclbWb1QCoXjRSBaq6sS67zQO91w8OvVUpeQjIvB1r7rQ7R8Wo4CLgJ0YvvSEaRppUyXFv72xnsL3q5glvv/8MzPoKigWGdl63/xRD1E4YzAixtFmdNc6oVRdd7b9rIZ4oQEc1BlsDUdbFt+rAylYKTcC5Ui9Mmn0W61uqpmZWjnFLDD2HPIojW90L0RCT/GWscS/l+wck9Bs4N+/tpExhs14RPBjXYOtWQiPx2GHRfdYfpSvAt5IJTncUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wllJnS0XqXipMf6tAFjOz4iAppyqxI4/ObmWs7r6k40=;
 b=XUHMjH+2x6LoMHV3YesJG87j+Bo4RPwVGqyUxcF8m7Y1uCll//W9fcGb4U6/5Gh4SdAkzZAZ3B4y1dnAyFLjbyC5Q68mhThjJf5FyL4RLIcQeLhlkTKqoQMEk3G2bEuKJJlwYWAFBuHhO8ZjHQmHa2z+/XN29vuOq725DChDVAmYYkpVS/uAA9p40xZyF4BdJbWEFkDWs8BO1hIM35/Fgac1RBzlY0dwyAfNnPUpYs3pZA/b31671XQ282e7giNnX5DMhjM81aU2jmN08sT/YhH9qbTWULrvGFOgdACme902QXtuJ3QnQCiNVrcIrvGPAR3w3O7cA8kqElaj0e7JYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3054.namprd15.prod.outlook.com (2603:10b6:208:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 22:06:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 22:06:45 +0000
Message-ID: <2453e8f6-29fe-c11a-75a4-18644a68d525@fb.com>
Date:   Tue, 22 Mar 2022 15:06:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <Yi7ULpR70HatVP/8@slm.duckdns.org>
 <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
 <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
 <CA+khW7jFSmm5sTyAVfEZhYnKDhVZKRRGLgAmCqgZzgON8NJOGg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CA+khW7jFSmm5sTyAVfEZhYnKDhVZKRRGLgAmCqgZzgON8NJOGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:300:116::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01dbcfc3-acad-451c-cfcd-08da0c5040e0
X-MS-TrafficTypeDiagnostic: MN2PR15MB3054:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3054AEB8A255722A20BB7332D3179@MN2PR15MB3054.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bPrQnmWT2ClM4U875sXkZlLvsqpXZUnxu/xwryRIisEOk81fvdzkEraSpmYkydMYx8+pj5AqXHmxIxrqeYoiOr5Vhh15pp2H6HrIQW97ctcEVaGyAUPBa3SQRqnJGkuGGMMcPt2RaEy2X/Vh809oldnrW7ewusfKF0PsH4o65HU4nntEvQziLyyXL94PkHKHdbkoe8jvW8RWS3iPA2OooFovaKbIEN7PIXONCOP9TB8j3FXyrWVkfkBqED9QkqEv7iqbvUTeE/BdV6ujTgTWqF5RIhZRagtjL2yx19gm1IbaoOG4cLTqLKwwAcBrOFI3HHsKCbwE9xKoHGzxwOsDtvwHRZrdZK3IN7mu/QO7q4/+/YqJQVSUqJxlVgv6uuSG1KBvbinZRj81A8IANT6d8ol3Pn3zuqiuCo2fNXoI3UP+V2pKlBp/OkjPc0sXhiDsPkKbq/Vi4GvV3ivxpydNu1lsiANAiROkc25pSd69jb9jKvL8RRPps5BiYLBuCjjgb9mYli/j6mxx7zwLXIYUKpkihsRqpSs9VL4DKk8af19lCtRi7xLPBE2tl2UqGLdgsJmwRq4W8iBRt/tjaEImpZFRr5uL9N5OHPBalrC+hgyQTC4+HOTEahPnG1XSzfnp/dcgIRtMSRBN7ulb92dVVMwygt89SBq1KiA9Im8a1dWDnTD9AaXEV/l3Xuf5C8iKCDdpgYYTCJIshHM62d3JTZQbn/r+gP66rxiAvDYz7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(52116002)(6666004)(36756003)(508600001)(38100700002)(6512007)(6506007)(53546011)(316002)(31696002)(86362001)(6916009)(31686004)(54906003)(6486002)(66946007)(186003)(66476007)(2906002)(8676002)(4326008)(2616005)(5660300002)(7416002)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1SNndjN2VmeTRCSTJrd0h2L2c5cHFYSU5sS0YxVm16c0pDTkd2cEE3VzlG?=
 =?utf-8?B?bUt1eGxQMjlIVTh0T3l5cC8zd0VPandrUDkxZVltMDZheS8ySE11SExHZmdJ?=
 =?utf-8?B?V01qSHo3RFArK2lXMmdMVVNRaWVvYVZoeElleVNwYTdmQ1lMcm93aElDdWJJ?=
 =?utf-8?B?cm1leloyaTluS1J4akgzOStpSS9wRUd5dmMrL2g2VW00MkEreldLeEZ1akxm?=
 =?utf-8?B?dmVITFJUdytEUGE5TmJtcmlRWGk2amFtTkRTazgrQzRqeHd0dmR1M2ZPQXpM?=
 =?utf-8?B?d3MxNWZMSzFCRkgrTVJGZVFMRXU4K2gzWEdOelFlWjMySmRrN0dYNnp5eklF?=
 =?utf-8?B?UlBmODdiKzNlMTNiWkFuMjByMGNxNDlGd3dWNWM0dVJLT0xwWkdoTVdJMnR2?=
 =?utf-8?B?RW5qUWxFbVN4S2lTYWQ2S0RiZ3djZmdNMklVL0llZTNqNmpncjNVRVFSdFlZ?=
 =?utf-8?B?OVlpUU1wMzV5czVCbWoyWnRLRnB4U2c0aEs5SHJSVndaYjhYcFpSVURZY0hE?=
 =?utf-8?B?ZSswZndOY241THZZbDRrQk5MNnR5QVl3eS9JcFBxeHlxaFUxZk1Ob05JTjQ3?=
 =?utf-8?B?Qk45S0lmTlhzVTdSTzFRZHNyc3hVbW9vdllhZW9SYlZmVS9hRnNXd3NLRTY2?=
 =?utf-8?B?b0U2emtCOGI3bzhncC9Fakk3SzJVejhBTENDZnZhenNtc1JSRFFEeVJRb2g1?=
 =?utf-8?B?VjFqN3BTV1gxRkxabkU3MGR5L0pWM3ZGMVVDeDlKMGc0c0pPSE1zSkFVQUlR?=
 =?utf-8?B?ZE5kTThKbkZGMFNlWUtMOWpYRGs3THRwYVI2QndHdFphM0FTc2hGeGF6Zktt?=
 =?utf-8?B?RUs2RnZKaVNWRElYQWVKaWpRejcwdy9VSXN0QytsaytvelViTkRDdWcreUIz?=
 =?utf-8?B?WXlpL0dUZGFncDhWTEIwM09NVW93MHJxbVlrOHkzNW5jcklvekt2OVMydk9N?=
 =?utf-8?B?Zk9jUlR5OUxhSVVKVm1wY05rWDVoU2t2bDlmMVQvWVRkTGxEMFd4aU1rYkVK?=
 =?utf-8?B?NlMxeUdJN2hiUXFiNHNkREJFWVhFY0tEdG5UKzZ3U2RaMFA5RGcvVFlYMkhS?=
 =?utf-8?B?OWlZc2h3TGVmd1RmVGFyaXlTeDBNMDdEZGkxV0hsR1p6eDRFOXkwMk9KZXpP?=
 =?utf-8?B?bzZ5OEUxRDlVWXl5MGIyMjlvMlN6d0dkTDl3NnZodWVKQUY0QU9teU41Kzg5?=
 =?utf-8?B?YXlqSmgxVWNFWXZxdE5TNkdKL0c2V05wdlFyQU1tWTR1SS9RK1JTU0FOYTVr?=
 =?utf-8?B?VEFWSVBTRUJsTnRiZ3ltQWw3eHY1SFZUNnhnbUJidXlyTUZaZXpGNENTejlG?=
 =?utf-8?B?STJZTEF5Q1dSb3pzckNhM09JejQ0bmJRczZ4UkVwZ3J3emg1UzdsMElQOUxi?=
 =?utf-8?B?clBPejh0WU9OVFJnWjVaMTZUaW11TnBFcUJ1UFRscFhuQk5YT0RnbWJST24v?=
 =?utf-8?B?aXdSTVUxQXJJVWtpZW52bGk2RG1QQUtOaEtxODd4MDhiL3pWSm5URlFkV0NY?=
 =?utf-8?B?Qy85dkdueXBQc0xqK2JwcGo3dFg5UTlyOUM2M0tUMFZOVGZ3Q0Y1ZDFkYnFY?=
 =?utf-8?B?Uy9HNldoTlNyMlNxVTc2RzJNYkIvcko3WkgvNHdRU0w5Vm41aHN4ZjdmVFRo?=
 =?utf-8?B?YkRIUGJuRFRVWU5OVFd3S2NtQ1M0a0pOU25WeHh3OTF0amQ1dFFpUEtTekVk?=
 =?utf-8?B?V3VROXloUjRXL3JXc0h0T3l6czduK21JQlk5TDFXUDJ1RmVQdjh4bmFPRVJ4?=
 =?utf-8?B?WVZpajlqN1Nsa3UyUGFrcXhiNGsvOG85ajY1bk1PQms2TlpqZ3ova21tUFdS?=
 =?utf-8?B?ckQzRVI4WUNtM3Z3YjJkQjljY1dkN0ZzV25RN3ZZeTF0SmpBRVZmMFhqVGM5?=
 =?utf-8?B?ODhtclg3UDBmekhXRmpvZlp0V0Z2R0FVdXlMcEtQVVN2SmxVOU1OTmhTa3B4?=
 =?utf-8?B?WVEwTkVJeDYwVzZCaWR0QVNEQXQ5dWlpYnNLc0l3MksvdGlEN09pRXhkcWJO?=
 =?utf-8?B?emdXOUgrSTZBPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dbcfc3-acad-451c-cfcd-08da0c5040e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 22:06:45.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXMWDRDJAnxPn/UF2e0BbOxWGmbLnZEYVfjQqhDw4PWsxhQSBnZuCDbozIn1XM8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3054
X-Proofpoint-GUID: KJ3da-uYVcCPgkF8NDrJiqh5_lc7mrwW
X-Proofpoint-ORIG-GUID: KJ3da-uYVcCPgkF8NDrJiqh5_lc7mrwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/22/22 2:37 PM, Hao Luo wrote:
> On Tue, Mar 22, 2022 at 11:09 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Hi, Yosry, I heard this was discussed in bpf office hour which I
>> didn't attend. Could you summarize the conclusion and what is the
>> step forward? We also have an internal tool which collects cgroup
>> stats and this might help us as well. Thanks!
>>
> 
> Hi Yonghong,
> 
> Yosry is out of office this entire week. I don't know whether he has
> access to corp email account, so please allow me to reply on his
> behalf.
> 
> So instead of using rstat in bpf (by providing a map interface), it's
> better to leverage the flexibility provided by bpf to extend rstat.
> "We can achieve a similar outcome with a less intrusive design." Yosry
> "will look at programs providing their own aggregators and maintaining
> their own stats, and only making callbacks to/from rstat." As the next
> step, Yosry is going to work on an RFC patchset to drive the
> discussion, when he is back.
> 
> It's great to see that this is helpful to you as well! I am looking
> forward to collaboration if there is a need.

Thanks, Hao, for explanation. I am looking forward to the RFC patch!

> 
> Hao
