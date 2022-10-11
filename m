Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6196A5FB6CC
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiJKPTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJKPSd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 11:18:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2038.outbound.protection.outlook.com [40.92.98.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D59B0B11;
        Tue, 11 Oct 2022 08:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fywr/bBjOIURZM7Y8fUN20X8H+Iy5LCkeIHsqyi6nv2zjIK52aGrBq/oOAGSmPYP7Gq4S+tp/leMbgIRgNYdWtLVprYEpvlEKhxvYSHp2yUTTjM0i5NkedBT25ljjv6BbYNMVNAP4HNxdscy9DRD2hmPwVisD14QnNsiVVuVH98TkjoGevV2uLGu/5wXOA9PfbUTw6WKYqs1k7YhhTFU6M9pml9RHQN7mXLHGWo0JFirycYQIpIV0i0hpyQTrLUD64JGKy4Nnl4lcN2pNpT9APivI/8cBPq/ycPcSkHMWq5/EPotEOJDnLOSKcYK80EHVHeiNQ9AujxSZ7G7E+9FGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bBy9sw36qcFhorM+iNFTH7B/8r5UMCmWvqfteMHnNY=;
 b=cbNNBmRuWoYPKcpiimnXH2TzioaVnW2dMQI2xF3x3XuduilbzkUe8S+zHnrXyaDjsx/xVf/HLAxMf+TwGZ8+Ywnh5ii/xh87ulx3RJD6hDEg9mcJeUwncD0CKiRODhSll8dpfosnEwmlcYIAs/YUOGCcV3On6Pho6B9CeDsaW9FdNyiKUTxSkyQwKSTVVz/q7+SaazDwEr1Fb3RH36E5dfGWHlkBwbpbxLhXMbYqTEPLsmEvW7ADJjxA/Y2OwqnViI1N9TFOYosDx/BYN+FQpQO+Y/9Z1a3d1ASxuNYPCbDmd8VcwLbaEYaytmj0sQCjdpF+BycuI7v/JQ96mtr55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bBy9sw36qcFhorM+iNFTH7B/8r5UMCmWvqfteMHnNY=;
 b=VprE1niqM/yyyFASg7FZ5LpQ/EtljQ5ETMBGywkfftCclL4q/c1fTwqtJljtN7xTEpG2kDonDxP3cJ/ot6oP+tHfhlMPmuTHgbi/27TpZOgExCMGCcXBmlCJInGwJpx/A7/sfrPS6BA1h5rbgFxD+y/I41yA7Dy5imVjHOklK3uFGWRY6h1EczDnaXxwpg95Osbxiv6Ihl1WWq0s/FcfxWFkUTQLZ8Uv7m6qQaS9nur8kfA3HCkuy47D8JciDORcGtjFQsKni/BhFIKu5AzozOOefe+XLYgOabBOueHvNq57Q3qCvqF2cH7ii+XAIDKIS7tgRiLRu+ukDAO8LXhvIA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB1855.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:53:16 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:53:16 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk, tj@kernel.org, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH 0/2] block: queue flag helpers and atomic refcnt impl 
Date:   Tue, 11 Oct 2022 22:52:44 +0800
Message-ID: <TYCP286MB2323C42B3A3E18F296A06D41CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [h4jbJW2cCnzmS36dnXJgkEkN2UQzb7Et]
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221011145246.8656-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0819f860-b6f2-4a0d-86a3-08daab985413
X-MS-Exchange-SLBlob-MailProps: LVbdfIC7uFAGjbskEBW/SERmDHTaO4T0p+LoA095vOPEm70rkD5JVnwVPm3exiyyLQZamrCHV/tiLlIxNSS2jik+MrBEt0/CnPSq6EQMKBECVuC5GFpN3fpVb9bKYj1tcezcsa3pn0Fk2PJ4vwBYXE8Abt5218ophkxdesVnNn/gg1Wx4TLjjuyWj+U/Y1vsaCXaPm2NvBsvs7UypSnY5L04c8bUqh7MNE6az7cVkAMxF92SJj1Ya05B7Zn8OhBWNbaRHnToXlaFUEch3efBc412IQjJlOqnPL1HJJEAbSZhVDGcUoBW5RgOHwGtcx/7dIG4GAGQGINRTcMca4irKH89LUf2czWXigXaFyAMrlipfwtZlvVQ9HrrpQmORawaeksynG2aHyfaIbPtQi+47fycAdN0Xy4gq/yKdCGuPkcTM5bm1FuEX54J2K9vlc181L74TdNucsV/90bs5DuEf4BaXWwiNIGADLuhx2SyLw/rPGK4915MMrtl5yKLM68TifS8dn/UCDuVKwpwuxGuXH8E8qajYzkun5GDOV4B/L7sxYdUqYEG5MMtf1+61XvMvF10UxPNKSl6ileWO2ghUr1DURQSfo4/0/Hf2qNzYw9Se1seU1b8SAdw8Xfad10JeYGHkxpAhPwtlA6gvTZY1RIM1GgNwJlW+T5dzzjW3qyStWbD1b6kTht9tq2LiGIjLtt5zsnhDqf9ioDT+Mx/ZmowKn/+rkJm5uQYgfMBEFksGjfgsS/O4g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjEhZ9XgujfF7LDmuph1ud1OCFVOjlo4EmPVkNikUX2rVngZvYiAtPlrIDPSHJ3caZ23Cq5IPCdpICPq1/nNaZ2KSN9W5oqVkI5PlmJR7kY34jQK067iSLBLgs0oQU8Bwp7ckAt7wWG2y82GAcklSat/EgF/kGs2igTrGhnvJw3EcXfHESSUvkIzkEyRbDxq5VJ2/5g3FEqcOua1qPDnWKvI8JjDEodyfSMDnUDscZSyb4juCkY6Ws5FknUe10OZkauGP3MrhHd7ABwU02Q8ZGE/iEdOMmpqhHlfWoetIlPEYvvGUk1sLkwp12UKbz0kvR1wqA2NSHylm5mPjlJYlK97ymb1kND18k3RlsnZF8KnMawwb7Zifu9QhmM7gqgcngMn4ryVTehmZcCmqa36GR9RWXRGvztkg8Q7gX4A4JOaQxTieNWIK9hlW5/bQVYXhci7hcowfWGV79LQy2/UR32lAeCUtw50kFuTBTBddg2FbU3Y+pSNG6XwxAg0iF/Suk4DwN4873cn9mQRBcFKlEwmbWU3Z537rr8kdO1RaVY7uEKQT9blqg5/wrmdyTrqmQ8+jwleFs9W64/xbIZg4Pv8Uhkc5c5vvJ2+J1aRf8I85X1Zbjyb9A4xQ1Cv9HdQoQxmvcbS1jgLJ25vCuuRW7FFMWRm1R9SQO4PXs+ftdAFrbfNT4ryUI73QbJFZP2D
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fm7t3SF90ZWJMECrB3MNab1eG5Es1nuP7OWiH8wju86dZEiSBFI4O/j1P3cv?=
 =?us-ascii?Q?eMKal8BuR9DXydHjBs4z3HWBTGdiP5fTDxviA8BennFg2sjMCtH3a62k7IdO?=
 =?us-ascii?Q?890A5WKvM1OFpPKG2g/EmxXwDiU/WpXTTwqvRqDvokYg0iHHXrR+qyOrA0t0?=
 =?us-ascii?Q?Pw9BNwvgYs4QzDirvWoVJ1DMXnv32icFqfs5p1QcbXn/iDikl1aJRq+yPYyq?=
 =?us-ascii?Q?cFjpasLlVypN2n8WTnRL2jPP9jMdywZi9cmYaNYWrd9V+Zw7bRtnWe2zoSZ3?=
 =?us-ascii?Q?drj3qQo/UnAE4J3WZ7VIIzyq5Lr1G/8zmqGeMAaGL0x0EM0PFU4GY8bxIRf5?=
 =?us-ascii?Q?gEDIF7m2m5WurWH/SV6My9PEiz7wKphnxsjVCggTJYripjRoFL0XjFqOQncZ?=
 =?us-ascii?Q?kLkmn5c4Kh++i/yenYNUpxx7SBjpzX9EKyrb5L5sFxFi7PA4FS9EF5lhSwrM?=
 =?us-ascii?Q?7YIWD+aW4FAAp43IzcN2W0A08+2bI/++1W3idsCsU9RZQYmlKlcLPyKVWyQh?=
 =?us-ascii?Q?pKt4ChEJm7VN3f6eHRZzwIY5pJBlOzMJBao1HxH6dCnnyGqBy8/RFqTtNxAV?=
 =?us-ascii?Q?FTuDTrwv+SIGLCSqviGJByi6PQnGpJgpaeHRpWbk8Dpd7kQKnENZi+fsbDXC?=
 =?us-ascii?Q?maWPj8013EHFHleSiUqr9K6t942RkADyPcN9peqaV+lbEznLPwsBXWN2hW3a?=
 =?us-ascii?Q?A1IebNIlFsNYZwjhwg/qiOaSyb2EIk26Qwj6Yb5e+X7JFRADjH9g0/uSfgWR?=
 =?us-ascii?Q?prx3DRns6rlvz5xVEL7e7pLCZM++2e0VS8GxFK1DNXNDjRQsn3i8/wRZf8q1?=
 =?us-ascii?Q?4iJSYSZJscRPdGLQkMgF+cJXSnQEArABzPmduu0wPE+5i37gDl2nLHZG2Z8u?=
 =?us-ascii?Q?l57SnS4TSW9YfkDOovUK38neI4BLw3n2YaQFieyc7pP/J4zjoHdiNYWjEsId?=
 =?us-ascii?Q?WHtDjwCl8cshfNnMtrWdIw02UuIgbkRg9wXjNclOUAwNmQuiYfSFOdGy46Gr?=
 =?us-ascii?Q?OlGOBzj/ixFQYN42ncRYhbNmOeDAfhmr09l14rWl35YXEWf2O1yEScJKjgqD?=
 =?us-ascii?Q?NiLUxZ0Z3E/AQCFZOzc7QXqqS8VWXnDdHrRFVvG43sgUuTybHOWvBi1j83+9?=
 =?us-ascii?Q?iBZBJwPEgTRb8ngzXXqXFFAzc7WNFdFhgOTKDzPnsqYKu+gBr7M2wT3kUkRa?=
 =?us-ascii?Q?kFTIVHQYd+oSJTF6x8fYA1vKZ8e13KY1rW6TkmC2xrMOAHcSVor9l78l+vwT?=
 =?us-ascii?Q?yHyRd630QEvMCuo9xDvz2HIFvLpwZYExgGJnZJozlw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0819f860-b6f2-4a0d-86a3-08daab985413
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:53:16.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset includes enhancement on block layer:
1. Complete missing blk_queue_xxx() helpers which is responsible
   for denoting whether an attribute of request queue is set.

2. Make the referene count of bfq_group/bfq_queue atomic.

Dawei Li (2):
  block: Add helper for queue_flags bit test
  block: Make refcnt of bfq_group/bfq_queue atomic

 block/bfq-cgroup.c     |  8 +++----
 block/bfq-iosched.c    | 54 ++++++++++++++++++++++--------------------
 block/bfq-iosched.h    |  6 ++---
 block/bfq-wf2q.c       |  6 ++---
 block/blk-core.c       |  7 +++---
 block/blk-mq-tag.c     |  8 +++----
 block/blk-mq.c         |  8 +++----
 block/blk-mq.h         |  2 +-
 block/blk-settings.c   |  2 +-
 block/blk-sysfs.c      | 12 +++++-----
 block/blk-timeout.c    |  2 +-
 block/blk-wbt.c        |  2 +-
 include/linux/blkdev.h | 19 +++++++++++----
 13 files changed, 71 insertions(+), 65 deletions(-)

-- 
2.25.1

