Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7E7BD23B
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 04:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbjJIC56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 22:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjJIC55 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 22:57:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5839E;
        Sun,  8 Oct 2023 19:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS/4wQE6VdEkAZyF5Hw4VWp8KRSVFGIlqBiMd04YWDyGWTyl9+gUJJbE7QA6gROzWiNZgTYoYznofsHhJXEvucw8OylLJcGUs6uz6NjXaJr6d9OUxLKL2Cg9ANCRe/82jTCzCepYFXV7jby3pTXhUgaLzhvmOaULWtbvWm029K4zNcgo7RVtq2+fqgDOP9WsmEUwWxCwSetbWN8bhbp170pAJibtXuBcTXRPn6dLOPFCXfbsCvybuGGIFMjYBME8X27ZAc+aC8TWVEKboJ3z2cftpsSjulEb2z4Tbm2oALAAnxiRdW+Y+Kfq9lu4z0bKJiMD/HyzAxwj//Zy+mP7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qQSxYVcIRdZYlpy4CK2cf8P/SAzI3dXY8TsE1Jz0rs=;
 b=e8Y7JAFkLoYIKp72yyWvyH3S777OW4o/jf8IHYljR4euDsMETmmIxXET9w1u/oePDp8Wu29drKxWdGvQK794qiW3JgUBJkOH4v52+tqMIQo2PwZrT2u35es29gU4Gsa1FOCNvWHQjdsDBe6BNkqB3oMawUXTp7OVWiquH6Hjgzs1zAtNS3L7sQrYoCTgqVsNBfc1jXBkPqVc/3oHCmm45Ayux63iqucYVjGeuEMUuebRAqOuEUrJu/P8Jjy1SaoeJINswvvDQ/EhSZ6GIzM0T3JMZ5oeQZ5394l55JyCNF25lQN1IZKTeRP0YCPVdJ+Yjc6IONpjalCEqcRtyfMsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qQSxYVcIRdZYlpy4CK2cf8P/SAzI3dXY8TsE1Jz0rs=;
 b=X1YKheHKevB3tvzlxdvdSkTSFP09hpl2Ta9Y3rID6npcPPsO+NRHnuKQ3bWmiokZfO0DzY7r9i+vong7GGDdL5cwzkbltUVGM5mVkpqYc2HFjljQI/+9b8Xzeek8ot0+0s69ArYnyaMGl04/tP1j7tGVHX6wsVm+qOdvUgCmJPWFKAjNWnUuW7B3EfgiOYD8CzxmDyPWwcB5uhJfvBxgXfZwobTFyQZPdUmLQF+7cuDoTbjxZLHBzhOl0oC3Bo+ulRMJIXwWlWTR8MVtPvU9oCoz0dqWhSk3lnNYK+vPwYmqHOiJ1QoNjQQZ9YPrq5hxb43X87s96341vRcXH31Gkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB5396.apcprd06.prod.outlook.com (2603:1096:400:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 9 Oct
 2023 02:57:52 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 02:57:51 +0000
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
Subject: [PATCH 0/3 RESEND] Per memcg lru_gen node stat
Date:   Mon,  9 Oct 2023 10:57:19 +0800
Message-Id: <20231009025726.5982-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cddc44-10cf-44f5-5a02-08dbc87386fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ff6B0cugS8N9cWX1L32R+mFTs201eyZL4jzvNDwKZO1cx8VRJ5pDFI4xHHkHD54O/cbPrjRew3FPRoPhAbwWeKzdxP42Berg4iDmEGLojzSgU5fQGlKckVitSwouR2Y5JOLY2tP75va1A9IVf3JDThbkn6cRex260biHB+R9XhnHOV1D3hKnumGKAFQcVPqJakcriTxsqqAP02oqIdpVMkTk8aU0AcwWfVQuHwC/BAHEZ2rS1u1zi+6vywsMd+Sker3VgNwSz34LdXzxTDZN6gl+bBiOJVyNpY80EvHutzOTKb5+06Huns08n580PN4xC5GHyCmAK6RcnHXDev3XmE8UTzDGUwLQkCn1P3l+gsxtU48qd/XmpCtsie2+p19pdkAceMNkq6DswibXB/RsUXXBprqS1ysicVT5Vcs8Q4j9D7Pqyt/Wl0UJuuN/A505a30t13XB28ikte9qtOK92EBDJM2WOglX+q0DqP6Q3EsCiYgjmFa4dqidtkpvC7QPVMGEC/GnqwV4y02EV3jpo+fgjYmkedNEt8zy1rHTMRNmlYsAxskBnvSPqrDsCYkr3DR5hmaxjnzWRqVCcWUKKg69zpyFBoyX1jyxzI28PHyUreCRQZyCskAn6snbkAPjCkQoPRYdrNGZtCluMZ3GFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(1076003)(107886003)(2616005)(66946007)(26005)(316002)(66476007)(66556008)(110136005)(7416002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(6666004)(2906002)(6512007)(4744005)(6486002)(478600001)(52116002)(36756003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/eiNj8sbQ2pv2XmDG+AQIQlTkoT7q9m9656HL+3rrqz7LHZOcAt4cyXp4GA?=
 =?us-ascii?Q?4BAgvWkmEg6ZKork3CrTjYnhREvc9n+YrtREPu3bYaNyVDNUYDnIiqSl8g2k?=
 =?us-ascii?Q?mUY6O0t/ntRZtrhFcTgnQVP2Yo6En5xhw3spIc6ZK3LGi8cjL3whiX7zuZk3?=
 =?us-ascii?Q?nqiNg1vCWp3LzXjkh9NEbIT2CD+TiV9ZgYbLaAgExI/dUcNqt2TOx8zp3LAd?=
 =?us-ascii?Q?A9j7DlixVUNQ0VwlaBuS2DnLyO+Dg+WZ84fIfAXEL1v+pVUOn5xhrQTb0KCE?=
 =?us-ascii?Q?bo8rVr8RGNVHKWkftH0IJ6TnSZYOLohpIPqEq6jC0Txk9+vsI3ieEkIaXy4b?=
 =?us-ascii?Q?h8W/BMaHHLavua7+AGUEwwoE2io3fAK/97aKGMnzGP/vqc48H9Yqd9Vo4qXl?=
 =?us-ascii?Q?ASLK5Q0MkNrYArCtQdGMXdS+S+wSeXYhdoxQLVGNsAfqnxuRstbC8jdsAWoF?=
 =?us-ascii?Q?KhaSdzqjI/y1J2mahhn7hiMyL+myTZ92mYjpfahFTuDau5i0PF+goPEco40a?=
 =?us-ascii?Q?ynIEVP/h3jXOSSsnjheE1scKNQMZ1QUgOdjIWMOPSIZDiruQDfynnmb5iQrw?=
 =?us-ascii?Q?5n5ljOAk09RYuCOBuath+QFHPPmtdAo8ckh5fLpfpa09FMkMPXqiRGKU+To0?=
 =?us-ascii?Q?FI5SvzFPtSCs3tw+TpTzjL+240/Ismaa9P6IYSuVVtDEOrQnV0kVVAtpddqJ?=
 =?us-ascii?Q?pEoQY+5aQj1mOZlTLSFRBaY9IG8uVx/7tqJTndl0JXdilMWWOozEHRO//msz?=
 =?us-ascii?Q?i7KVff1b8v1zP0E7Y/ouU82bpJYTaPfENBI5eED/eBzS4V471aUTaeiY2+j9?=
 =?us-ascii?Q?x3O563x8YrLvxDMR07Rett4X+8zdPe4bNJoQSre3OfgSI30MVtNEYtKtye2C?=
 =?us-ascii?Q?/9FGwfbv2jW1/h2y5xjdW32fZ7hlX3NvRzR3u8fPqNsLIvuEyBdo+ViLzr2t?=
 =?us-ascii?Q?5T6/CIZ44IuDZW9cTk5xrs2H9Hlx5dnTkP36moG5FM0QJSRD2Tk5j5GxlN6Y?=
 =?us-ascii?Q?WPHed4wQ2MnkpORkFksbsehcBVlnMKNK14171ldnN5uXHfEA/xBy3SDZmUTu?=
 =?us-ascii?Q?lkU1Lyo4lrmUmIeN1Lae6KHw7k/aKHRrm8TxJcE+y/C1Iy4ETh48hjFTW2oH?=
 =?us-ascii?Q?Vty40Zx2FB59gdMSb0k8PA5f5XyvOuknCtJTAQVNjqwsQpoyXMjAtzFWkcYU?=
 =?us-ascii?Q?nYo28mLbEQ0Y7uQsTjHCbKw3hMrmpZN0jhW//1+c7m21cNh6MDefjNmBTLiE?=
 =?us-ascii?Q?P89bP8DA2V6Z7030xZ25Mo76c3xorgp/ZJTOw6o9KmCLxmGNUhOgOTzY6X36?=
 =?us-ascii?Q?YzBFnS4o3bBsIJ/1ZNk+aPeldIXTbwWiYn6jGpyNYVlPENp+pb9CEfzhhzdh?=
 =?us-ascii?Q?9xPJ5eGUaPuOZa30MuSRhkaF1L/kdQpRyp3nF3Qhchp+JeTR+NZsJurBXbg7?=
 =?us-ascii?Q?EhZvRdjRg4p075CwtE9r+a/5XRqHnQIqh75N9Tgu1XyWzC+EHv7jRFOHCSLF?=
 =?us-ascii?Q?KavfIQilSqHmD/V9eDq0j1DvABiZ00zpVXmgdczF0OLIwrbKUlwpEZI/TtqY?=
 =?us-ascii?Q?eZamD9jW5bdnakZanvfYIktDZTUT2Qe8OBGEXUzG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cddc44-10cf-44f5-5a02-08dbc87386fc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:57:51.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSuR39iWb4dXKXrG/RXo8quRGjVAsXQenS7jqKWbMOjuPrZi2pwH55QgGg+uAzMkxAXE08IBX7rD/LQ1ad2Jrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On original global lru_gen node in debugfs, it can all show each memcg's
lru gen info in "lru_gen" or "lru_gen_full", and can type cmd into lru_gen.
But which show info contains all memcg's info, and cmd need to 
know memcg's id.

This patchset add lru_gen node in per memcg, with this node, we can
get lru_gen info in each memcg.
Also, we can type cmd to control each memcg's lru_gen seq, but, this node
don't support multi cmd, single memcg just process one cmd once time.

HuanYang (3):
  mm: multi-gen LRU: fold lru_gen run cmd
  mm: memcg: add per memcg "lru_gen" node
  mm: multi-gen LRU: add per memcg "lru_gen" document

 Documentation/admin-guide/mm/multigen_lru.rst |  10 ++
 include/linux/mm_inline.h                     |   9 +
 include/linux/mmzone.h                        |   4 +-
 mm/memcontrol.c                               | 163 ++++++++++++++++++
 mm/vmscan.c                                   |  82 ++++++---
 5 files changed, 246 insertions(+), 22 deletions(-)

-- 
2.34.1

