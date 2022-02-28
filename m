Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2414C6583
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiB1JOk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiB1JOj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 04:14:39 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70113.outbound.protection.outlook.com [40.107.7.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3712D43EC0;
        Mon, 28 Feb 2022 01:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnWFR0RK0+xF4+s9HfEdxLKum1IEvIfEqyXlfVK4tes2Rt5Za7Dchu5ihoNtuKekFkBGQHJGsPxitzsr3reHkaE+7NC81u6U1km76J9CmfCd//e3wPuwgM4FKnc5zil+6DkUXVI7+JjgxjLVddf/fKCz46wpgbyYmCGTnhyKF9kq+KFCfFmUzGLQry56QSaLnE9KsfgLAVSmB7W63FbXOQtcIg1M/JCqKUfIPnpd+lkOBsHdEHE1lkuX/Qlk7NhkbZ6409Y+LJklPMsqkEJfh/jsyY0E54DiHrWl6sfVy1ef8sdde90IZHOgfYGj90EzUE7Cry8GXHy8fKL8CpoKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0X0kPE7F453qZwFgdByilAR9MhxrSvmXaauHX/m9ag=;
 b=iBIMmDez0jAj/+SVhaq02+zN8V3qjbmNpcg2dxEOGSMPCa1xreMLU8urYGv1AmGR66LaC9UEOfBLIA1n7xKz4LtQtbs6FCPP9w4BcLLTNUuPDUDg6Ii4pipVJ6epEjT4ZOm/8+ke7TVKgVx0J65f8GTX6XTDFR3KeLUsG6AMdQfxquyvT+j9ln/p5GZ5f3wMIUMHgNKueygh0N0f3ycs5Pk+yx4By/3782hIBxtbigi7++C7zlJGGWfZE6mdrVkHkkilS2kamxIo/vQzi15d6X3avmiEMnPl9/LVU+HCTMaVMPB8nLoNlnItxM2BCYhWVPGb9aR0yHpFz2SA51Yb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0X0kPE7F453qZwFgdByilAR9MhxrSvmXaauHX/m9ag=;
 b=peuQb13Xo2zvilLfUddZUDT/bFA56Wy+dp3g/T+YT5FQ7Ndf7Mmlb4FHvVO49ftyGWLX/yCsj2augkX1xMAGVK6DDesGenL1d67i7VKAuxrXo0Ev1HnOMKjORob3Z0AzT0NgD6h6H+togjiKYXqOkON0AoVHeHKmHRD01os8sk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB3245.eurprd08.prod.outlook.com (2603:10a6:803:48::20)
 by AM0PR08MB3940.eurprd08.prod.outlook.com (2603:10a6:208:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 09:13:58 +0000
Received: from VI1PR08MB3245.eurprd08.prod.outlook.com
 ([fe80::4007:6de5:a0b9:1533]) by VI1PR08MB3245.eurprd08.prod.outlook.com
 ([fe80::4007:6de5:a0b9:1533%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:13:58 +0000
Message-ID: <5d4bca06-7d4f-a905-e518-12981ebca1b3@virtuozzo.com>
Date:   Mon, 28 Feb 2022 12:13:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] memcg: enable accounting for tty-related objects
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <afbaec7c-1872-d43a-1240-e077adc0d6d9@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <afbaec7c-1872-d43a-1240-e077adc0d6d9@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To VI1PR08MB3245.eurprd08.prod.outlook.com
 (2603:10a6:803:48::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f53fe1-abd3-4267-6d8a-08d9fa9aa6c1
X-MS-TrafficTypeDiagnostic: AM0PR08MB3940:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB3940E82B11966CD0A72AC12AAA019@AM0PR08MB3940.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk7obDQSkTbey6O3jiHhCTlQuU60AKRnAu4oiidogkIYOCt/SWmeQfvG6e1Th7qyqltcRuUlYOmSigAl/DYgfW0Pl7kJi/hvTCaWreYySQmw8x2M5aU6UiqlQNneRG70d29Qkh3JWeSEAIoddL5uWR1IR1x9GlZRQWuSHLYkx7JI7ri27ag3Pk3WDynTLXCRw3L3GOyDY0ibgpyv8bpZgk2nON+6LBZKmqZ/Bf6FC55i8uc10bS/EbuS04R6zwmgEq+B21PQNsdMKRg/0IX5xpIXmzRm8fE7sCjZn89aNYVh3XrhL/c9AHyo+q8txO8b1qYscSt0/l2Yrw7dGgtQEAn5n45AKkFEVul1nBDsnJEvtK13GnyLxJejupCy2Kwls5O9lakKaWnEHja/zg6z+Dht6/TMXOp/nXM/TbEAnj1s52BBMHqcBwqJwB2Q50hbJypL6dROVVPWTdHlJkBHJrMqhG8gl0nHDgQk4roJjfEvTHK4mNuqCN35EZquwVPQF+uHGlo0doRhyZBgZ03Gx5m/VOirnlMjVCXTShjV1QdqbfBJHpJWjSR9ddUR7+SHL6JCR6sy+je2ck0KUdNP+5PuV7q/GWSUMOsama/xB/7gfAOEHpb0URuAZWwDeiarbw1mm2vQXsDeKaVmELz78pmuSMAk4CmR8YkdKUMFluoxLaMkm53+NaLWuS7c5iXy9p0Ja+UqS/5+eBtrU9VAQAF2YhnseVEyKau8j0qNtw4B0AO7IuUdLV06B6f7s+8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3245.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(5660300002)(7416002)(15650500001)(2616005)(107886003)(36756003)(8936002)(26005)(186003)(86362001)(66946007)(31686004)(508600001)(31696002)(8676002)(66476007)(66556008)(4326008)(38100700002)(38350700002)(6916009)(316002)(6666004)(6506007)(6512007)(52116002)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9qYmlEa1VxbnZtWDRVYklVMjk0R0NyeEZaN3BrV3E1TlZzNlA3ZDN6eVNi?=
 =?utf-8?B?UmRobElERjhUNG5JZDFPU1ZhQ09jVE51enZhdXhOYjR1SGxKams0SlhmSmps?=
 =?utf-8?B?dC92Y3BHeXZrNkdNTUxMM012R01rWTlvZktUVXlCUk11aUk1aXdYRTcrUW1G?=
 =?utf-8?B?d2xlUVRWQTFrNTVaMnZBaGcvZlNabExWaGNvRXNMTW5PL20rNzJ4TlZ0VUUx?=
 =?utf-8?B?VkM5dzlQNU1kTStmdkUrRW84amVJVU1hVWMxZjVsWjBMZkxmQkxXeFY5dlNJ?=
 =?utf-8?B?S1cybGplSGlJbytZcHJlMXdXV2lkZEFCNHZYQ3ZuR0JYekFtWnV0Wk56YkNH?=
 =?utf-8?B?cm50RWFmdUZQU05VamtoR1BBTVpycFp4a3J1K01XUlBpWnNxSUovZ2IwMmsr?=
 =?utf-8?B?T3N0eXlWUk9BcTNRUTlmV0ZFQVd3NkpWWUMwL0ZTTUpiUEZFV093RWFYbTF3?=
 =?utf-8?B?UWpPUitsQjJvUVlhcGNYekNYK29yRkpMNGY4dmxIbkNlZVVLclg5cWxob094?=
 =?utf-8?B?aE5HdEhSaW53TGU5RnV2QUxrR1laMzhjU2hiTmlaYjZLK3RsVXd4UE1Lemkr?=
 =?utf-8?B?Q1ZDWDJ2NnlDc3hhMnU0QWRONXc0bGVhOW1weVR0MVg3NWZ3b2NKNDVpcHlp?=
 =?utf-8?B?ZzlzNmZpZ291OFo5djlNU3B1c1ZMK2lZZHJRM3V4OEhMaXl2TlJqNDg1ODk0?=
 =?utf-8?B?SmNGWFBRV2ZvcGdQT1NzOVJ0NmdnQTQ5SnovL1ZVam13Rit3VCt4M3VWSDhi?=
 =?utf-8?B?N0M2UGtVRERKYk84eDlCdkdmaVIwU0cvVnk3dkpzYW9xeXB0aUJsZUFTQXdq?=
 =?utf-8?B?LzJzWjd3UTEwLzVZOFM5SnI4V1kyZDFqdGRNdG4vamx6Zm1pWlpuZ1VIeWlQ?=
 =?utf-8?B?ajV6aEhIZGxBcjhyUUN0MWtQekQxdnhIYTBWb0owYVVDYlg3b2VvaVF5Vm9h?=
 =?utf-8?B?ZllNZzBjaFIydjhIVnJITWJOVnYwemY0MEtxdi8renNVRWgyckt3a1lOaGdK?=
 =?utf-8?B?K3pqQlBERkhzRkQzZ1BPY1hKVElGOFJzR2FGaWYraHZtMlNSK25VNVRhNGNP?=
 =?utf-8?B?V3pmdWNNTS9NWWpNbm9qRFBsdi9SSkdUTVlQTGpETHN6T0g3enI5OHN0cTli?=
 =?utf-8?B?dWVvN2ZQWGNMOXpmNU1aWG4xcEV3VFRvMzRDQlcycFpWU0pZMXI3SDdKTlN1?=
 =?utf-8?B?eWV6RzBHOHJLWkFERVIyQ2lwbUFxODhLRzFtNDU3V1k3NmJqZUMyNzJLWm53?=
 =?utf-8?B?V2ZpNnlqWitFSlhYK0U1YzVIZEppYTQyL2lFaXdMZCtwSUxmNHV0aEt6RHJ1?=
 =?utf-8?B?UFVKNElacXNXZFRkcitGU2dZZ01MdjZPZmFCeUVpbUdwN05aSHJ6M1JaWlpY?=
 =?utf-8?B?cERIN1lCRFVTcERFK0Q4dDNrUTZZVnZTSy9HZVZkZnpCM3BuSUpYQlNYcC8z?=
 =?utf-8?B?RXJqTUNQRENiaThjSzgyWGdzMVhLN2pKNnFZK1VDNEh4ZDY5ZlNIUUlKK05T?=
 =?utf-8?B?SXB0NkJoVkJvSFhaSVdSRUpEWkhXS2Fzdm5MNndzMmRjV0RTMUdLNnJmbmhp?=
 =?utf-8?B?MHJtZEtZVDZURGVGdFpMTkpHWXprUnRyMS9nMWJRbWc0NVMrU0c3ektQWDlQ?=
 =?utf-8?B?aFJLcUpDV3VLVHE0U1k3blhIT0RnSlMyQXRVeWpERmZ6eTZjT1lBb3pnM2kx?=
 =?utf-8?B?SW5LUGk2eG0zU0JjeS95dHlheGlVRmxRcERJMXdRR2RWMmI2bzFBaEFzb2ZR?=
 =?utf-8?B?d2g0YzE5a2xiRmUrS3NmaXczSVJZd01aR1I1WnNRa2xXMkRSSnVCcTBuNDdG?=
 =?utf-8?B?ODlOSklUcnF3Unl5RWFySGxNMnVrY0ZoOFl2UTcxcUdIOW54aEc2RFZJUStp?=
 =?utf-8?B?MXhqOE5Dc0VLSHFpYi9MYUowZWZLZlptb3d6U1J0TCtpZHBLUDdYOW96Z3Fy?=
 =?utf-8?B?OXZ3cUxmV1JhcjA2SjlPSmsvOFJBYkVXeHpESTFLcjY3VVBjVmM4WTkwZVBl?=
 =?utf-8?B?aHE1c1U0N21RcWdIOFc4RXV4UzZ0NW05NFRpRkY0c21TNmF6bzFUclFVbUJQ?=
 =?utf-8?B?RFhHMENvVkxXcnFmb1FKNGEwNCsyT2JQak02R2Z4dDhlSVh0azkzR2R1YWR1?=
 =?utf-8?B?ZjhDWlRuZ3FLa3VvSzNUYXh2aHgxRWZ6QUxRR0loZGtKVjVnSHhUcFo3RURX?=
 =?utf-8?Q?KpVRheHgtkNsiZUlPhKx0GA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f53fe1-abd3-4267-6d8a-08d9fa9aa6c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB3245.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:13:58.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5i+Don1hbqJ8TI5z0inqnbuYxf2hNfFpek4pc3erzkHhdL/ow3FtAIy7fgPGbX3ZJho+YhZ6FUhG1ZZ5oE8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3940
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At each login the user forces the kernel to create a new terminal and
allocate up to ~1Kb memory for the tty-related structures.

By default it's allowed to create up to 4096 ptys with 1024 reserve for
initial mount namespace only and the settings are controlled by host admin.

Though this default is not enough for hosters with thousands
of containers per node. Host admin can be forced to increase it
up to NR_UNIX98_PTY_MAX = 1<<20.

By default container is restricted by pty mount_opt.max = 1024,
but admin inside container can change it via remount. As a result,
one container can consume almost all allowed ptys
and allocate up to 1Gb of unaccounted memory.

It is not enough per-se to trigger OOM on host, however anyway, it allows
to significantly exceed the assigned memcg limit and leads to troubles
on the over-committed node.

It makes sense to account for them to restrict the host's memory
consumption from inside the memcg-limited container.

v2: removed hunk patched tty_save_termios()
Jiri Slaby pointed that termios are not saved for PTYs and for other
terminals used inside containers. Therefore accounting for saved
termios have near to zero impact in real life scenarios.
v1 patch version was dropped due to noticed issue,
however hunk patched alloc_tty_struct is still actual.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
  drivers/tty/tty_io.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7e8b3bd59c7b..8fec1d8648f5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3088,7 +3088,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
  {
  	struct tty_struct *tty;
  
-	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
+	tty = kzalloc(sizeof(*tty), GFP_KERNEL_ACCOUNT);
  	if (!tty)
  		return NULL;
  
-- 
2.25.1

