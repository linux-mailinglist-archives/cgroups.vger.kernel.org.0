Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6817BD240
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbjJIC6V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 22:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbjJIC6U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 22:58:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD62AC;
        Sun,  8 Oct 2023 19:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrMhyXzJgSQKTfbEHQN0GGqkAE24OLUPGzhVtE00ciguUOLO5b7g48KV50ERw55Vr8e6C6EUsM2Z8XK6Ncs11yxAVHYCRG9h61WwtKvmEbWYYxU09ykMqpHQ3I4cb0trIncHXKxYSn1C/VrGIIEshXkQ5nUhdtuWw/fitxjIR67hent9/Q+qGKwdIWyaWwzKsWLBlrry4j1uNGeOqI0oG9gynd8E1z28GY5dI42078X2ogUI1HTJ+w0fUFdP64jmCRkrj1xFURCCJ8RZQuw6LTLA6WlJ2o5bSeT4BkBs8pV301LycNOEEA3PG48zIluaLH/6PSbH6Vf0FIW6rXbPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HZcHFkOqT7M+sC0RLKzaw1ViPr/hgsujAmsPaB8Jnk=;
 b=VuTSwXSKwACY0NdAxJP1iE1fwVMvMjRXquXHCt49LFVbD5O1MQh77ANhROWOofJArfvGy81iAlrLKCLNt5O6MwJjU0jdONwmpSJ1Ha7ZFLIyVAA720h6578hMohFD84qtw3LIxfzTzv1klpwRUoh+c94c8RcKShaK4QZJZC68AW6TkNDTri7/jaPue0JYdfI5P+cjh1FLuxBQ3DOeKiBz+3/KpTNdRUqfKaAHN9csMF8VCQqM3z94QoggojZrW72L+neDqP8jLo2ihjSZiQmK9ceIuqa2G0FiyKpF/b+pc0gKfNC7zBODBCEl/29a0W43OZnlITe4yYE6//izpm3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HZcHFkOqT7M+sC0RLKzaw1ViPr/hgsujAmsPaB8Jnk=;
 b=cXFO9bf+HM7seEASd+FbR0+cmv5kCcRwlHXS5PcaHH+MK+gzgz3WQOc4jQornUTGYvBccoy2cGrQqIXJEp9g7KdgVLQ+sfiluilTzD6f2uoJUm+87iZ5Fn5+GXyN3hYVaLruB7L4rZ+5qA1Z9o6CT+mBYQ7rqanoVCFjZOxpKX/Bfd2njLwJQHBx00Ik+MaxV2rJzjquRX2n1MRmtmF4z+CCuGYGo75hhLQJWVcv4WmE5yo32R2R777KS5595YaomVowtpsuKLRBDNe9L1f6HouFTOWHDFFFs4OEBjYAVw5ZO827vX8iWx6CydV4lrGNDIl5xtcF70GX0H/IlIV69A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 02:58:15 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 02:58:15 +0000
From:   Huan Yang <link@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [PATCH 3/3] mm: multi-gen LRU: add per memcg "lru_gen" document
Date:   Mon,  9 Oct 2023 10:57:22 +0800
Message-Id: <20231009025726.5982-4-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009025726.5982-1-link@vivo.com>
References: <20231009025726.5982-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7df4b4-6a1c-477c-61f0-08dbc8739524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxnATBr2HZjW6XD4NZD2xnRfct1Z4NI+HuINWDvcpWjOR9QP7l2YwusAJsXR1a3RcaQatlO0aUEg3UlYua89IKnCyNPQK1BlWF4UEPt79P+lEVh8JujBfaV4Tnaj/fqx+u+yHMb/zrOPG7nczB/8Gl8alArTKkUcA0nfnCqUawnYXJKeJuU4Clan0u4/Bg9b8ttfLyXybgRVuBTJt4ub8UATR5sC0rIQy2BlBK3Q331u2GZRDXX6tfmcEZPMVbhjChp97i4SJF+ieIp7Lq/vX9gdkrLnd3vqJ9FJ6LatJsIRAfHmOuUQVsEKFlJcp3BM656oUN8mWwrvVFkjgxvH6o1zMYhTrU6nPMI0gZ1p//bcDntRcY6ifc1VdKbX8iuDML/j7Qv6hXY4+IccQRvltCAOlZU2wZt+qtXb/CPm3PO3iKHiUXJm49NE1POflrwULGwvFy1T2l3SX+8w9iKBTw5qhwABLqVSe2MjEJoJfz8AueBfd5jYjzu639+rEg0DylTKfSGkALdb2vaeyqzCMaNudr7iI/54B+t1/BkkKhQvuE6cm5bwvTTOhwIgzCQ12e6GIUKezWvFkTBmPti2A2XoXtmmgaKZsfQZrshARlyR/WHnD4B0uGGxwC48AMyqorwgLNlmF1CxVr7gdZ7RLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(52116002)(1076003)(2616005)(26005)(478600001)(6506007)(6666004)(6512007)(107886003)(83380400001)(8676002)(7416002)(2906002)(8936002)(4326008)(66556008)(110136005)(66476007)(66946007)(6486002)(5660300002)(41300700001)(316002)(38350700002)(921005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFWR8ssilKDiPIhwUoaaZuV7gwfB+048IPFq+wvEa9D0w+zHuF16m7HzSk4R?=
 =?us-ascii?Q?5cMk/AGw2Rz4zLYOeZNI6PSHF5X7faNrrk9iCOkUmHMUN1gXRfbHL2I/zlOd?=
 =?us-ascii?Q?5gAzUzDWETVNiG5oEqKaH8bZTfZW0eyZCtRyGmr72wWwsO30RuQ91zVRCgt6?=
 =?us-ascii?Q?YAJCdNW2Bq7U55eiBrBHm0e/3vLcw7JaSuu0U2aAR6teGAZKjnqy2mWP1OKn?=
 =?us-ascii?Q?IkyHizZo1OycYVCh7WcrX+qEYJvrXGTYneriikzD69Uht+Up+O1wdR+ZE06i?=
 =?us-ascii?Q?26W+qt4CbsMfvAjnVV/51wwnsf58Jy9nrmbQNQSm9rWqbyIaz3UMxlg79lC9?=
 =?us-ascii?Q?tHHGQ8wYZRGPikNnARehpOJsviP9bg9C4i1j1PBi0EwJ7jKEBBkciTvbBpXY?=
 =?us-ascii?Q?XxtTlJ0B4iyCs+EqVT7o0WqbpeCOMELG8ArTOMevxnBbIRf5qgIbO5oAQy2a?=
 =?us-ascii?Q?dkoUGz/fBpXXbz4wZkn9lZvVWHYCHgj2aS2myUk/D5OECTLGRu/PtnddLp1l?=
 =?us-ascii?Q?O1cjUiDqyI0OmpW9i7UGo7QzCdC/EwAF5xezQG5Tw2YEmCBmVXiJ+93sDqWe?=
 =?us-ascii?Q?Tpw1DDtTVBoZtdm3O2ToXtOSxRmIhgLCvCZCKcW2+b5X2su04Ic0A9wfSoLv?=
 =?us-ascii?Q?mJw83sbbgCjzedOGLGhl3s/XyXdb3dsCzsj1cYNUNl+vWFyIhWkrZv/dZXC9?=
 =?us-ascii?Q?PFYB3q2JiocUIb3eOF2vy5X+pjiKYxWHddXDEbNlrmVI32TjGyuflMc9uno4?=
 =?us-ascii?Q?I6MnM+BPfaFRAlcAGyFyJe10cf+4KjIeW+yVmvarNkwQgmaSfhe7J4RTdPDy?=
 =?us-ascii?Q?+mJKw7wIA++j5YJ9gWWTvyjRtO7XUarnmMjjh1HC7fLI7gRvlIl1Jbv0elpn?=
 =?us-ascii?Q?W/7TG1tufc8EgO6R7IiaEYO1Uv1qCtLhyJ3fvLm2dC6O0ZkZL1WE1FF22HZd?=
 =?us-ascii?Q?XUqBOiIyzLD2KRhUaNs74idSGTLX6p/l3V7ab1zwqXRds+vZta3EV3pXfA7b?=
 =?us-ascii?Q?x2L2p2at5I0yyGKgFxph2J8J39o/WEelcRZ66p4H+cZDIkvxpfmfkFfYwsQK?=
 =?us-ascii?Q?+LDHkNORjUo43izSLF3qZL1NQnSt6CmuxowWQFUSazTAOCjiUX6EKmB2YDxr?=
 =?us-ascii?Q?s3slL9mS5qAXA2Wr3lA60hLDRXquAxAG5WZv3mDUfelz5it12Qy92sPeaRsh?=
 =?us-ascii?Q?VipkNXspwv2sBANBws6zmtqLoIWIgJLvrvduA+O14PEEc2EQsd7FThsfXr/J?=
 =?us-ascii?Q?4BBMXnCvvwfzzrmeBYZAgZj/z+sM1e14dBhhvaaFRHyDUTBUJ72F5v5iXwvQ?=
 =?us-ascii?Q?NWFOUwy7z2gIiDhTLi1e9suIRxcWSZa40I2yLDULW4LQ5yny0tL5y0rf5Ul9?=
 =?us-ascii?Q?GSwXIdesVIrP9G8bxToefGBRrBOVv7NPGZ4uXdXhr1AvsiCPHAZXOi9mnjNC?=
 =?us-ascii?Q?vpKRuLjfrZjLX10MC9hIu9QU6q2704iPPFInvuLN14eARtfECNT/Pxg6jDQL?=
 =?us-ascii?Q?Kp9U8BoWtVV6pIVjLtuBwAVO0JREYJL8eTUTxPsHzEw5KCunRpAY3BeW3DPM?=
 =?us-ascii?Q?vzIQThs/SfgwTmyOppGS1AZ/L0TCWxQSc/K2n6gy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7df4b4-6a1c-477c-61f0-08dbc8739524
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:58:15.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5UhB9ghhcnWggGZyodKQuqW6SwKHQJCxTrk0I0ZPRdvTu2yFyzwDpR93Ba/uaG0nhPv3zKxg3GlZe6k+BAdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: HuanYang <link@vivo.com>

change multi-gen LRU document.

Signed-off-by: Huan Yang <link@vivo.com>
---
 Documentation/admin-guide/mm/multigen_lru.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
index 33e068830497..078056b8cc7c 100644
--- a/Documentation/admin-guide/mm/multigen_lru.rst
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -160,3 +160,13 @@ cold pages because of the overestimation, it retries on the next
 server according to the ranking result obtained from the working set
 estimation step. This less forceful approach limits the impacts on the
 existing jobs.
+
+Per memcg lru gen node
+-----------------
+In each memcg's dir, it contains ``lru_gen`` node. you can type upon cmd
+without input memcg_id to do the same thing.
+
+    ``+ node_id max_gen_nr [can_swap [force_scan]]``
+    ``- node_id min_gen_nr [swappiness [nr_to_reclaim]]``
+
+For show info, memcg's node always show the full info.
-- 
2.34.1

