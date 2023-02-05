Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0468B0C9
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBEP4V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 10:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEP4U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 10:56:20 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2090.outbound.protection.outlook.com [40.107.104.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1655BB;
        Sun,  5 Feb 2023 07:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTHU11GX4gl3NESFKGAU5Zurava4AyLOgtCrq3aVqWPRf7tTX2ePiZjmD0N5B6ha0IuPrdjJHKftfW7CBCH7mray3Rn+YfhFQfGCzb5uXRUh1q7Ddb3YQnTByngwXavBCByRMlYtZgAlL8j/OEdPwCJI7GSJtLOw0+VkMD8Zgl4xJ9/HrxLk5EpLUYvIhpZ5/xSmUnUGywXTPxFKH+NSDr/sX9LQsBA6+o7vjciejmUU015zp5SWzd37iEPpbUmcsYkvuUEMZn7KbtlQOZnIE7rQfE/7p49A1RyJr/ymGH429gIMEj0vW0u71zIQ9Fz/vAlxg5TNHVXujY33tPtvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqAgyTAjJKFseuP7AppMe5BCjztupRQBL+3m6KQShX4=;
 b=CvNLVt5fA1Ed2CzzayeQqrvKpOZad+m2vUeB5myzS3c4fU+6ya67cyb0hlrhqNWjIvs8/C4XlU2RGTSrXX3Vb93rPcUQO+i+c2R+KhlMyeVW/oI3sswq8Ea0RLbIYu3kh1LR/Z10lNyTWYMvUKumTJ1kSwBnWLN0c58fPOAPg1MrHJlLp1oFdr0JiAECb2uDpElNF2X73aEQOiVk8SSPgvdcflTZPJqYt5FHrKKYM4cLu2RYZRqkBWithMlTymWL0Bqp7i0Wza3VO1UzEObWbXJAH8MczUVcMdGEXl6WFoPL1hppIe5VExV35GRsQhAQlJVmgKlymmzo9+U+jdGj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqAgyTAjJKFseuP7AppMe5BCjztupRQBL+3m6KQShX4=;
 b=ScPN8ADuuKU6w1CM1Z3skUwZB3K+wS5oHfCR273L0Lokuf73HgomoPFp20ziFSiLG87HF9h/0JKM2GlvdvkzCyGVwEcuKoyWvVOEzQZMxELBWi6ksBIXNsqN8Ku9a3yg8DM1TPcTsO9zMHUiFogcYPmKPq4JAwTB9tJk92dRfaHYtQnpTrzur3qM05EGiq34NElfZ4s0nQZB7Pdhmuu26SBiVcrK6mXRTotiRTy87EhbstXmX67+SPeFswVy9HCHj9GRTXtx71kun4ov6wROiRjHzKN68nfo9gc5/Qw81Bs9wi4i8dlJzm08GGnss2wN58oQtQ/ZiDkceWn3ZL2dPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Sun, 5 Feb
 2023 15:56:16 +0000
Received: from AS1PR04MB9335.eurprd04.prod.outlook.com
 ([fe80::92d3:1531:5c9:9921]) by AS1PR04MB9335.eurprd04.prod.outlook.com
 ([fe80::92d3:1531:5c9:9921%8]) with mapi id 15.20.6064.034; Sun, 5 Feb 2023
 15:56:16 +0000
From:   Ofir Gal <ofir.gal@volumez.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, yi.zhang@huawei.com, yukuai3@huawei.com,
        Ofir Gal <ofir@gal.software>
Subject: [PATCH -next] blk-throttle: enable io throttle for root in cgroup v2
Date:   Sun,  5 Feb 2023 17:55:41 +0200
Message-Id: <20230205155541.1320485-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <YgMxjyVjMjmkMQU5@T590>
References: <YgMxjyVjMjmkMQU5@T590>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To AS1PR04MB9335.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9335:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cf0c36-a75e-4a73-5de6-08db07918366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjNzSuJB7uOrZt22Mo8L5j78TvTLIfcBW1PwRtwalvd9K7I2B4j4J7UYzprQiYcuyDXTKTKLkmOpF0LprB6qG4+I6KFShAicO011j+DGzZR4D6tBL0pG2+VmNsoQDlsxY0OK2SJ1ySKHUCAW/uSumvMsMMDcsK65oiLjO9+P1m8QJeHS2PCucclcSBG5p5FtKsoSKlHSJsuHy0Eiy6cDyAOBUMRuGL7+rCkBXYM62JlpVY/G3THulY+WQ4/yopt8WrRwVlsPcrJnB678jt+q4UWFTidH5m0BLffNwEx2/g56Xhg+7wJWfJ4OlkEmFWyljzSzuodAqjPQbrhx4JjX/kzeIxLYqprO6/hEG/SNZ61AVCktCGjbAxZB8cpYw0cSUCRFogaq9ZVeL93LTJZXpkMfy6uG3brVrgzgOV6Dg7fS/IrkOONuO+Oc+lsPRxvL27UbSdLC+vdXnksJDe6FwJW6TVbVkuxI+yZYMI2emYgXNSAW0j05rC1c51ZM7y1iEzkPGtI2LJw5TzB3vkwvwk1jVv55xJuvvcaD8Xl+gI4qHbVcX6jhS9I5O7kBOXvh2ZAVTXGa2Js3KZdrWmGC54RN/4YGl25q3VyHSl66WW6m95y6SbxnVChdN0i/zac7sPp08z/I34xq7lxQ0CZxUy9zDVysr6vO08Y+a4kzkpmEB+K15WPHw4CUx6hvB9J8mflAYxhw83muUU20dJ59cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9335.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39830400003)(366004)(136003)(396003)(346002)(451199018)(86362001)(186003)(55236004)(6506007)(38350700002)(1076003)(38100700002)(26005)(6512007)(6666004)(478600001)(2616005)(83380400001)(36756003)(6486002)(66556008)(52116002)(8676002)(316002)(4326008)(66946007)(6916009)(41300700001)(8936002)(44832011)(2906002)(5660300002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GkVbIK4SbV6AGf/V2qWVJ28qDvh/dCk1UbU1gzbG20rzqfJpTaLWKlAWcbAX?=
 =?us-ascii?Q?j7fZ+3xpIRrsIgaMPJE/ftDumtYZdaC2V/to4I8u80DbIOErsO5EqStENMfz?=
 =?us-ascii?Q?15VC7U4rBxWKPlQ7KB/MnwuaV53O1y54PX9JU1jW2rFE3DnRe1T/w/oK9sLt?=
 =?us-ascii?Q?JzEfk9mIikePwaCcWu8WnZfpPmc3vv0MVGmoAmciHiamn9g3o0cAwDWZolW1?=
 =?us-ascii?Q?7hL6sY217aiCL8mKbZz9HBp03oeGGFkvnrse5hAOK3vNpOzhj2Y0l/SmmuXO?=
 =?us-ascii?Q?H5SXJ+rnRuFaDB+wmZDoaI2Dek6nFwi0D7DAH2re6iO0cMyU4lal+N2mufZi?=
 =?us-ascii?Q?Z/RT0Kv8VVO5kpUds9eJT+tdGHHMYeswqM78UThPPqup0GS6nbHjEn4Mbov3?=
 =?us-ascii?Q?SXCSDfyXCrge5RSHVs7Y/iJPTYnjPqHGbI/OXPi8+w/M0JMeGeMwonSt82nv?=
 =?us-ascii?Q?uMCR+w0d1A9VJVjxPK+FvwlCSXPxkcpfJwhb8mPPJZG0mFUMq+JM7SeBE68e?=
 =?us-ascii?Q?+FPCSh6eG0vJhbw8OBRCFeaS8lGwSLQkJNm4kGT2oDc86IB6sCzccfUiSGf3?=
 =?us-ascii?Q?tn2kD54reJFsM0g65C6A22viqd3TRpTuIaC8o79cGI3G7PGcn5HhZ/cXpAeN?=
 =?us-ascii?Q?yMPIS7oC/vmVfjc0Vbq/wA4kADOmjIfPC3ziFGwETL0jGVhsKeUYThWPbZXy?=
 =?us-ascii?Q?LkRNKn7z5PcgsBm02LoVlu/b8jV9ioUnLtj4UmyzsgIXvoVdcW7LrQg+qbrK?=
 =?us-ascii?Q?L02UsBYKo37atw/4n1yweA/OSBU46Oodv5DDM2qhLpPteFjkFoHD9UpX5Kc0?=
 =?us-ascii?Q?SUQWNNpdp+Y59sZb4CM2wSh62Bfm8gJpj2AoWCIERUNqczDiWe8tYPrY8CBX?=
 =?us-ascii?Q?5I2umzsbWw2aynshMGrkJXO3ZPRCTsM++9fXbPOUa/HSY67OibV20gXMCTlR?=
 =?us-ascii?Q?PRp2L3lKZLNaZjPZHVV5DPqJFVDEAktj0lbr4k6dtaZ8/p1q82ABCwnHnqwm?=
 =?us-ascii?Q?RGwTM73wmO3ObkHLVg4kbQcbWw5+yF7hBazeDYRogX2mBzbA215oMjCSdhME?=
 =?us-ascii?Q?Wy+T2JtKiSL9myHa94ZIQyWDcI5H74wOvule92uAe65JRx74f90+Yi+XWq6M?=
 =?us-ascii?Q?chqGNWj+gOsuACF5vdeke7FmkblxARPbh/lB1sVWUuChk/oJEOvuTxia5xEF?=
 =?us-ascii?Q?dQNEMWVisbHVnlnz0WwgnfmWE0IMOJp4/9eRbTyixr3eBuDqIdwF5XR+PHk9?=
 =?us-ascii?Q?fkp866xriyZk/hGG1h+cOQBDspbHbENVF3Ubveh55pY0xsFFbfngwGEsjLsj?=
 =?us-ascii?Q?hBw4copsgGLdkg7Bsh9ZbRT9sTivkEbp8EuqcCQqzP6Ruwo18XMHQuppejlk?=
 =?us-ascii?Q?9GptM9+gw/hIggENXBLtN8TOVUbrEQWyPVL8kLJcbcdH7ud9dmIY1+C6rgCY?=
 =?us-ascii?Q?AFs89JDE5163z7I0HrSahq2Tv9yG3JSqDKCd8VuS6NBMFViNyQ5961frOl+N?=
 =?us-ascii?Q?1dQKz553pvZ3OXleZGHwGX1TYb5IJehUIt9sW1ypX86+VVnTmTlkFrYzlsYt?=
 =?us-ascii?Q?yT8QB2Pjyk08HnDqTP8KyJXXCmdBBapAA3VwlfYI?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cf0c36-a75e-4a73-5de6-08db07918366
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9335.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 15:56:16.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPK4M5ALwEXfWP9JcH2I1NQdSpcpPyi8SvOa6aHkHcXOKgqRhwMU9r5x2l+2QgCkF1ZhDqOMCzGOk3WPDBCHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Ofir Gal <ofir@gal.software>

Hello Ming Lei,

I am trying to use cgroups v2 to throttle a media disk that is controlled by an NVME target.
Unfortunately, it cannot be done without setting the limit in the root cgroup.
It can be done via cgroups v1. Yu Kuai's patch allows this to be accomplished.

My setup consist from 3 servers.
Server #1:
    a. SSD media disk (needs to be throttled to 100K IOPs)
    b. NVME target controlling the SSD (1.a)

Server #2:
    a. NVME initiator is connected to Server #1 NVME target (1.b)

Server #3:
    a. NVME initiator is connected to Server #1 NVME target (1.b)

My setup accesses this media from multiple servers using NVMe over TCP,
but the initiator servers' workloads are unknown and can be changed dynamically. I need to limit the media disk to 100K IOPS on the target side.

I have tried to limit the SSD on Server #1, but it seems that the NVME target kworkers are not affected unless I use Yu Kuai's patch.

Can you elaborate on the issues with this patch or how the scenario described above can be done with cgroups v2?

Best regards, Ofir Gal.
