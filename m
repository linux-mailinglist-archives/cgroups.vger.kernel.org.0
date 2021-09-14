Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625BC40A437
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 05:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhINDPH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 23:15:07 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:43490 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237213AbhINDPG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 23:15:06 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E1uq6R026172;
        Mon, 13 Sep 2021 20:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=U0iyVEQEwqLW8iHKurcltX6RA9m7vH+xk+bWf6qhOf0=;
 b=PIRF0+iuE4u0VI64Z1U/xDP+CI8AOHnU9ZC6YP7X9mvDJZPoE1lUjGxf8mbWeUGSGaER
 MQrcgBtEzvLkDoBdVstP+sTAqgcBggwbZBchgE6P3TUvWFsczgML30w80XZ/XK3gKg3R
 p5VVtDrsB5QJNYwuFSMH8njSU3yTqlPFJKKOqYAmlGwHd89SD8YpIMp980oECg9/pgZn
 iqlNNK5SNRYQ0AJ4F6Kzo3ve9MkY86CIiwcU6IG6ee/inOFUnshS03DmH3/UpZK10rZm
 MJ2C5YUi4SB3T6o308UGzKHvWWw99RCzfk0zx8RiQeFsK9iiolYXuRZnXZ7CFUOGImm3 Lg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3b2d2jg73f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 20:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA0rLf6u7xmY1/4rzESPr6npQ3kdbczdyeDoJH2+7eaFHg4vaUeJ44ufUulLYfWLIvJggnYdcGt1JZLDHIkYO5nqMgYdYhCxxwteFrKgDZRUoi4hk2u2+DPDkhYTQ212cJzyusXIKh2PM3BvKeWtH3115EOpX+4OPxmtrD8M7ogXNlaEeOYJScyR6ssHfCXnGF5WBrCzrfqbJuUx4CbTwV0uwog8Rnf/QpqSkoRmeTYYWxng2WPKdwQ60ik9AhmK8kGPCy1Sugd7DpPl7qgXgXWq29DxxTDwKVGCx9qQ+hVnxikBrh1x9nYSaHsO1Yl/YB7vXYg6stv/ndYulGpJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U0iyVEQEwqLW8iHKurcltX6RA9m7vH+xk+bWf6qhOf0=;
 b=XyxyP0v/jJvFOJLKLkc3gwepc0kuvhlOsJTAoF3Xs/kLukYrgiCt9KyK1MZfc0xN0YUV2/5maDk+QHcclMwVNoIHDNb/3VhMy64YrXMbFYEqZY3lKxgxCXDJ5u8o8nIyoX63lSwbboCE5BcWdmYvPOWmro0aMTrULrDUB0rORuoZ3Zz+PkYEmT4t6Yhvm5YVOtixruZzhp9zr4Hssz42kFE9L6e6xxD5b+mLSd1xYf7/eR/F8bRTPSHEqnx4wpH7ZGWBtyyfqJioymNy9UCmYcMbT/UlohfvHiYE6z6o62KKteSqUBNzg28wSRP3n/80DLqoXKdoQ1GKpXVHlgyxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2716.namprd11.prod.outlook.com (2603:10b6:5:c7::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.17; Tue, 14 Sep 2021 03:13:41 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 03:13:41 +0000
Subject: Re: [syzbot] memory leak in blk_iolatency_init
To:     syzbot <syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com>,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <0000000000004ee28405cbe8d287@google.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <5feaeb5d-a0c7-ac9a-7511-19c993a5a78e@windriver.com>
Date:   Tue, 14 Sep 2021 11:13:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0000000000004ee28405cbe8d287@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:c9::13) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.162.160] (60.247.85.82) by HKAPR03CA0026.apcprd03.prod.outlook.com (2603:1096:203:c9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Tue, 14 Sep 2021 03:13:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2489f942-353d-437b-9721-08d9772da732
X-MS-TrafficTypeDiagnostic: DM6PR11MB2716:
X-Microsoft-Antispam-PRVS: <DM6PR11MB271606B75A428B4B1867CC25E4DA9@DM6PR11MB2716.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXhGL3JZOTROejRLY1NkcmcrdWZvWWxEeFl4SjFqRFRpUGMxOXMyRFVOTGN4?=
 =?utf-8?B?ZXNjS01OTm44TERYYk14YWNBeDduWUs4R2lvb0FRekZ2UkJFcXl5WDR2NnFQ?=
 =?utf-8?B?MjBNbUcwZGx4cEkxTkZHbUdPczA0cUNnbnB2QjdzbCs5MHlHOHcrSXhwSGZz?=
 =?utf-8?B?UGRDKytIay8rZDRsQW1JVDd6UmRCUXVUbmZtengwQ1pSR25WTnR2anZJUlRE?=
 =?utf-8?B?L0QzS1lua2cwY2o0blQ0VnBjeFk0SlNLSVdqLzdnRHRFNHFNQk96aGZpRW5V?=
 =?utf-8?B?elgxcmd1YUswRDRCeTRzOXBiaFE4eEhFOXBLRGdadVZzN0w1QlhlZE00Mk4r?=
 =?utf-8?B?R0dMWml6NDRkb3F0Q2N6UXZ0N2Y5dVRvb0Y0T09wRlRSNENEREIxdzdZcmVY?=
 =?utf-8?B?MUloTkNjb094eXhwUmhoeXIyaVB4MkRkZStQdUQwZXJxWWhXNk1XVTBrdjFJ?=
 =?utf-8?B?Vm9JNXdwZXVNYitHWjVrS3lnclNwMlZCcEJVUUQ4RGxGWGQwNHBHczN5VjZx?=
 =?utf-8?B?L0IzZEdmZXpRSjVKcnNieEVZemhiUDBKOG1FeGtLWUlyVjZQTWFzMFdTeCtF?=
 =?utf-8?B?TTNRV3lKVm5FOHBqYTF3aTk5RVVRN28vTjVTSndHamlrdkh1enllandwclBY?=
 =?utf-8?B?SVZROXJOdzk3TjMxYjFpU2tVek9aSXY3UFRTSmVtVG5aUXlLWFRNZC9FYTI1?=
 =?utf-8?B?dTBqUzViVkMyY1BGR2dMbzB4TGdCNmg2ZEdNQ3FuRkFYQnJoWFdpSTljSWw4?=
 =?utf-8?B?eENkZjF1SmQrTlNQMjRjZGd2ZWMwS1pmayt0MmY5U1ViVjZnbUNuVnBrSHk1?=
 =?utf-8?B?ZmJkL0dtK1JINXhSOUpYV25kbGc4Zml0WGxuZlJtSmtqRTcxNDhwbTF2cTM4?=
 =?utf-8?B?cmtwVGowbkxpbzJ4T3EvcDB1TzFvZzhHSFBEbE4ybVg3eGNRVmY4WFBQdlZV?=
 =?utf-8?B?NllRYzZtQXRtVzdETTFpYlBJZ1QxdHdOT2FMcHEwRFZwVjNIN09YVkpSYTF6?=
 =?utf-8?B?dzVBTEhHU2dKMlB5WXNDVzIvdlNHYTNSY2RYbUt5NkxoY0R5UjB6OFJBaUd2?=
 =?utf-8?B?YVJyZE50NFRheEdFNTEweDRXam5zbVZER0QrekFBUGRSRStoRDlrbnpVWXR4?=
 =?utf-8?B?MmVuVWpxMDkwYmxLU0JSSnJReGFoTEtvZmVIb0NDOHRFcVp2a1ZTT0FleXh6?=
 =?utf-8?B?OTNZMjJlQjJEaTJoWjUwN1dLUGgzRnZ4WU9LVmJ6SXNkZjlMa29MSUtmaTBM?=
 =?utf-8?B?NkZjb3o0anY3WDcxOGxsVytTT0dsT29tR0VVZlYrZ3hlYTd2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39850400004)(366004)(376002)(966005)(5660300002)(478600001)(8936002)(38100700002)(6666004)(8676002)(53546011)(36756003)(2616005)(31696002)(2906002)(66476007)(66556008)(66946007)(316002)(52116002)(16576012)(186003)(6486002)(6706004)(86362001)(956004)(38350700002)(83380400001)(26005)(31686004)(99710200001)(78286007)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTUyTVkybVo5MmZmK2FIQUJjOU5LS2FYeFZxMEFMRWtpR0haREQ0TGtHZU1r?=
 =?utf-8?B?SUhneHllYnJvK0thc09xSmFudXdwNXhzblIzbnpJczkxUHdSN3ljZk9TbldX?=
 =?utf-8?B?RnVHMUtwd0hZN0xxUTR1US9aamVmMUZPV2t6Tm5GaDNHU2ZUZVNNeVFCRER5?=
 =?utf-8?B?Y0ZDUG92dzRSYnRkcS9IVkVobEN5SnZOb3VIZklpQVdDUS8wSFZBRmJpM1I1?=
 =?utf-8?B?a0tyT21uUk9GS0dXYk1FMW1wWlZRbFdSR011WTlLWVFhWFQ2VDZOSFV5N0FI?=
 =?utf-8?B?a3pzZ2NqcDRtdWZCeTdsV2JmdW4zZkZLK2RvOERDUHlUNkZYSUlNSUREbDVh?=
 =?utf-8?B?S0V4NUtha2NIWWlPdDlRUmdTR21qU0QvKytIRzRRa2h6Z1FxcW1lTXIxdzFn?=
 =?utf-8?B?UzZSTFpodEhWNFlyMFovNkY0UWVZM3R4eVAvQlFHVjhseWVLNk1VQ004dzVS?=
 =?utf-8?B?WmRIVU5wNm5wbExHSkNkV0dmQW1yakVhZjlBbXlobEhwVlQ0QVhCVCtFeG96?=
 =?utf-8?B?WEhxT0ZTRjhHVTY5aGFiS0x3cS9oR3J5Q0VkVXZ4bjRqc21XQ1RYcm1veVpE?=
 =?utf-8?B?ajVjSmp5eXo3S3RqUUhwaVhEczhKaGJTWHJvdk9JOENjUzNMeS9ya0hsb0JD?=
 =?utf-8?B?VGpXUE1hdDN3VE4yS0hSOVM5RWExVWJOR2VrTUdFd0E3dGRMRzJxdjA4eCtS?=
 =?utf-8?B?Njh0Qkh1RVFsSTlWR2ZuSlF0V3paQ1JRQUdEcUxxZVJURlZmOHFtOFNMNm1N?=
 =?utf-8?B?WGtsbE9kZ3BvWDdKTjRPdERoYjFrcGlwVG1HZ0VoTnkzL3VObXdNRFJ1UUp0?=
 =?utf-8?B?K1B1dXNRNUFZMS9lWlJJMnRpQnZwekVTS3Jjb2VZNW03TmtnaG9ObDZnekoy?=
 =?utf-8?B?Mmg1d1BMNDNCU0d5aXNoOHY3Q0JRL2Y3dFdVNStuOWdZMHpoazNFcVN1THA5?=
 =?utf-8?B?cmE0UGtDNSt2WmRrSFF5eW4rczdXNitCWTNXK1M1Zlo1UlFyc3hSdVF2Z0Ru?=
 =?utf-8?B?M0Z4RDNJSFZzemt4c093cXNBZzlrejVzekhFWGlxQ0FWQTA5Y3RTQ0tmSlBJ?=
 =?utf-8?B?azB6ajZWejlXUytlSGxaa21Vd0hRSnBJUlRrZk1XVEREcnR0QXd5S3RySkhJ?=
 =?utf-8?B?SzNYRnJsUFc3QlRDdzlrRlRNbFBCRWZwQ2Faa1FsV1REVVdUWGdJbVhjUEhw?=
 =?utf-8?B?S01WTXJZdHBtOXVERWZ5WVhPVGsyV1ZhTGpjeGI1TlNzQU1Md0RMSzg2d0dR?=
 =?utf-8?B?OEV1V1JQNmxGdnk0SWFwNzBNUVVXaUswcXpxVHNWLzcxYVV3RXdyeEI3V0xF?=
 =?utf-8?B?OGQvUXhpRGpZWGtSYnhFZnB4dSt2TDRjTEtlZFZudk42Y0FzaW1udEZrRGZa?=
 =?utf-8?B?bktIbnZvbVIwT0w1THpJT0sxN1NkNEk1Z0I1TGVXQmVMWmY2WGMxZmJXODUw?=
 =?utf-8?B?c3JrSXB3bUhjTWhmVDZHMCtzTGpQc0NnV2NKc3g0MHhYYmtTR1RoOHllODZo?=
 =?utf-8?B?Nm5WTG5EMzRTUzltSEhZU3RrdlluRklGSUtVNXpQL1JnRVN2ME1hbzV6b29J?=
 =?utf-8?B?WVJzcFB5V1c2SVNCSFZYbHViT01OcXFibXBBRmlyYm5zOFdodWFHa0p6d0M5?=
 =?utf-8?B?djJXempNc2hUai9pK3MwQ3ZUQW1jdDlxaTFGOGMvd1VlbnZKMHM4bFhvejFH?=
 =?utf-8?B?YUZzS1dlWi9lbFhQRHZmR2dLdlZxbDVNSjJFTWZhc1NKUmNlTGh2TXdOTS9m?=
 =?utf-8?Q?ceu81iIQqekpE0+sQecsvj8LbVK6htNTA/M7aY2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2489f942-353d-437b-9721-08d9772da732
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 03:13:41.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3dSCpCttyLXdznA8l/bGz2iqDC8KZxww/985IHR6uUdz8Q1j1Y/gxQWqnBW5x/SQXCWQBu6dqL6IWaG0COpeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2716
X-Proofpoint-GUID: y8wcOycSIAIA_k4RVhNU92f6SPe_ACLB
X-Proofpoint-ORIG-GUID: y8wcOycSIAIA_k4RVhNU92f6SPe_ACLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140017
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 9/14/21 7:28 AM, syzbot wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a3fa7a101dcf Merge branches 'akpm' and 'akpm-hotfixes' (pa..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b4a5b3300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee3a4c022ccbbca
> dashboard link: https://syzkaller.appspot.com/bug?extid=01321b15cc98e6bf96d6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c170b300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com
> 
> 2021/09/09 22:14:31 executed programs: 444
> BUG: memory leak
> unreferenced object 0xffff888129acdb80 (size 96):
>    comm "syz-executor.1", pid 12661, jiffies 4294962682 (age 15.220s)
>    hex dump (first 32 bytes):
>      20 47 c9 85 ff ff ff ff 20 d4 8e 29 81 88 ff ff   G...... ..)....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff82264ec8>] kmalloc include/linux/slab.h:591 [inline]
>      [<ffffffff82264ec8>] kzalloc include/linux/slab.h:721 [inline]
>      [<ffffffff82264ec8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
>      [<ffffffff8225b8c4>] blkcg_init_queue+0xb4/0x1c0 block/blk-cgroup.c:1185
>      [<ffffffff822253da>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:566
>      [<ffffffff8223b175>] blk_mq_init_queue_data block/blk-mq.c:3100 [inline]
>      [<ffffffff8223b175>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3124
>      [<ffffffff826a9303>] loop_add+0x1c3/0x360 drivers/block/loop.c:2344
>      [<ffffffff826a966e>] loop_control_get_free drivers/block/loop.c:2501 [inline]
>      [<ffffffff826a966e>] loop_control_ioctl+0x17e/0x2e0 drivers/block/loop.c:2516
>      [<ffffffff81597eec>] vfs_ioctl fs/ioctl.c:51 [inline]
>      [<ffffffff81597eec>] __do_sys_ioctl fs/ioctl.c:874 [inline]
>      [<ffffffff81597eec>] __se_sys_ioctl fs/ioctl.c:860 [inline]
>      [<ffffffff81597eec>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
>      [<ffffffff843fa745>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<ffffffff843fa745>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>      [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 

Hi Jens,

How about this fix?

    Once blk_throtl_init() queue init failed, blkcg_iolatency_exit() will
     not be invoked for cleanup. That leads a memory leak. Swap the
     blk_throtl_init() and blk_iolatency_init() calls can solve this.

     Reported-by: syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com
     Fixes: 19688d7f9592 (block/blk-cgroup: Swap the blk_throtl_init() 
and blk_iolatency_init() calls)
     Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3c88a79a319b..1ded4181a6de 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1182,10 +1182,6 @@ int blkcg_init_queue(struct request_queue *q)
         if (preloaded)
                 radix_tree_preload_end();

-       ret = blk_iolatency_init(q);
-       if (ret)
-               goto err_destroy_all;
-
         ret = blk_ioprio_init(q);
         if (ret)
                 goto err_destroy_all;
@@ -1194,6 +1190,12 @@ int blkcg_init_queue(struct request_queue *q)
         if (ret)
                 goto err_destroy_all;

+       ret = blk_iolatency_init(q);
+       if (ret) {
+               blk_throtl_exit(q);
+               goto err_destroy_all;
+       }
+
         return 0;



> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
