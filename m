Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505787A01ED
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjINKsi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINKsh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 06:48:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30E1BF0;
        Thu, 14 Sep 2023 03:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfMBXq8rBBX3j4mqaKi7c7c7k3Vk9KZA08Qeoddsgto2IWA06S1XqwRfq/M14KOI0S4iazwvd5+7OieSHYc1osgEkbTZofDXSuts3hIz1uaSvBgBGt3LvY9poB6pxq3aH34Tx0qNjiObqX/t7peyQrEYaRimsgqYNvAXbnzWDn+wR5PruOKMl2yVry2kU9qxdLq52TwVZDK9A8SZdwkZtHxk+NSzq5WnpOMwfvJ/Qbhd2G+USYG8c3izAvC5fllxT8FZUW9qrXRj52q1xaX45ffaYDc0YJzL+JNsBHwsTZWIMBcpKRm+0XQoZEPG3zcPAvO1skjOitUyoi1oS2rDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+m0VxUwTyDGYqfeRvoQz6OFTcCzoA6YG47/myLxRHI=;
 b=YlMuPWf+4FIR5XASUvFMhbM+7cLOEnCZjM+eyugOcWCoioeAnoNJCKnNuCC6jY4OkFi8cNE0NC6Noul25W53ATOWfAxzR0ais/DPflywvkFw19krhHH0mOqyme7XXnl6wypzBT56NTDPvM3GxyaNE8tzm4zR8rNAkEsu+qJO4Dw+hVWqhG/23t1iAxslPzDTwm21a+/bJ95VsuALpYZk0R5b7+Ud3CjHkvOLgH1nR+9veBsQ2+MFgrE3F9vfPYP+D0UmPmWDsm4flbVhkDutBo0mZMLghf5IPKZJerTJ7PB0oYc3t8EabBLMgM2ng6dvTMgqc5sUnrgYpkhoa+cR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+m0VxUwTyDGYqfeRvoQz6OFTcCzoA6YG47/myLxRHI=;
 b=LjNXJZapGwODgKeLHl9A1+6K6HXFAAS6JA1w/YeV1/SAb5oCQ5EgNy2LHg7i/FH6fBqsBQJBWPlDg9H/ejvXEFkj67t65olRRgJiJnpQvcbMGaWH0eV+pevCrUd06CtFGcQUY1AQwE9P14NJcoEe8ss+tBlBZZtwkbJQMJTwn9b1zqwOacWCgAdW0RfbhXMY80rNJXiHhYgXK2v23vOOlQn+rPOGeV0wXRzl4wjOpClbOVUSN9wK/GZUMtrWyikSYuLgkBjfL07b2uBsRmnm/L0wiV5JVcqZIeSuY8wda5IUT9u6NFj8uXjyFGkRejHjWGNXsts5q7CeuxJ1gndFwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4267.apcprd06.prod.outlook.com (2603:1096:4:15e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:48:28 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:48:28 +0000
From:   Huan Yang <link@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suleiman Souhlal <suleiman@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Yu Zhao <yuzhao@google.com>, Huan Yang <link@vivo.com>,
        Brian Geffon <bgeffon@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH 0/3] Per memcg lru_gen node stat
Date:   Thu, 14 Sep 2023 18:47:42 +0800
Message-Id: <20230914104754.55-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6290bf-5466-4dbc-15e3-08dbb51020dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPmxDFsWf2FK4EFdv3Thz+aPEWAEw0AGMXYEFfYfBerfMeZ3pDYHftw2+HfbaAHFY7Qo10ouJiv5gMlvp9IG0FGvuBf3F0XKEeStMoD1abXFdORhp76kM7M6zqUcHY93uUIWIg4tPCXOplYck/F75D8/A1COoIV00ZlyKuXugw/BKAfVjgXrZuELDdgJjeRwmIWLA5EjqtBeqZ2n4I+Me2DtkXcLV3aaXSbkd48LfNwEjCGwRmYvGpf+z0+TGruosNrs8PQ9RU9Z1dO1ztl/kx6ktLtiajXsnVUIOVkEBC5mZZ3khhibn4eVtbB7PEd773sdmq9lVUhMxDBCB33XaLU2sPOe7DUtBSReabRrkpm5pBVbMtiNxhXgedOnuYZbd7P945BDVhopCBK1WAocLtIBAJEC74IRHBJFSNsmkH6tHFmKyQApf9UF3Zpva+BxzdPRkO5RU7utQJrYFOj31rc+FVFe4bonIAleBciMkVWdmaxyrI2F2Cy7a+6iHvqpBaal86AKbUDSD4yiDNTtS0PVztI3q+0gRrHtlVVLOb38p/Aug1F2jNEJqzBriu+QdqGJ3ghOB+wpWoCFbAfUyVzlKpbgcdWNPCBaY0cZNSfZZDvHarr38xUk9t0YTcJB3PF5ZL1AaNpZE+iFv1yO8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6506007)(6486002)(52116002)(6666004)(38100700002)(36756003)(86362001)(921005)(38350700002)(1076003)(2616005)(26005)(4744005)(83380400001)(107886003)(6512007)(478600001)(2906002)(110136005)(4326008)(316002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJ2qbKSDULzikH42TEVZJ2Y/uK0C1h3+xqZVTcmPAAPzj4wwBAxwcqqom4De?=
 =?us-ascii?Q?Rqp2E6Ac127NtO99nvShkVjMSC0tzvoReVZTzp/MhP6VNdKYdGoj2G6jRkLV?=
 =?us-ascii?Q?4D5Ay+8AxfbHtNxaDKFt+w/X9D1mZLBfRWN0fgLrFbRgQtopHoMyBHiprN2N?=
 =?us-ascii?Q?KGGxL8qzxSWwpl8noV6Ll4KOSUDB5tiZt1x0Iwom8g59tCEvd27KSxP3ig2e?=
 =?us-ascii?Q?4qqCwy6pIoptoCiEtBhsxz6XvxcylI67HahM8FCwxw6g8UjMioBVgdecgGs8?=
 =?us-ascii?Q?DLxm7whg+OuBqPXEW0pEJciBQedIlD+ldaMDRSRPlRt9vnHWbXVQm4L7lAvs?=
 =?us-ascii?Q?DVgwiZOY52+nOcaCKoZnQAWGKg6hypNyZRexAgphvehXQxmy6dYjG6CMfHAi?=
 =?us-ascii?Q?9VvIigZNXGOuNRYYolAyQ/cQQm8vZqcUXPr9WmIykP5EtEA6QuZsGjgn4Xkc?=
 =?us-ascii?Q?17VQDkSoomTslK19ebLzVyrZIqvM0vt3uRAYxkrCVmDvD2+SrKHCDWfWme5z?=
 =?us-ascii?Q?2h8vXHNqmjfR8Oe8QlMC2lOjytVYZKJxdwP5LPQS3DTBJKbjJ3ivI6a2NaHV?=
 =?us-ascii?Q?eBCiSGuiEwZzGhhJ1RMKNPk6UcKVBRXASp2fEWVtDPlvockYXnj6kK+BbJm7?=
 =?us-ascii?Q?3t2YFL4yvL50O80vqQEf9YOuXOw0dvGZrEStBQ7GbTKHgAl6YUAzG7Uwq0Ap?=
 =?us-ascii?Q?1Rj3/5lRoGWq5bmcnoVTNHP4EZ/ej+EL66XAOMtXYSCLRoeNC7DPEhl4LxBz?=
 =?us-ascii?Q?FxFRV6qSbd5bOsDTFyaH6jf/mv6pjfUyXRSh6jqGg0ctmifJN/eEgVwB4x16?=
 =?us-ascii?Q?fGKhOp7aHNzp81fpQQLK/mkJqG4u3Gwr0e57wpyrEpKcCsJ0B2E6YqxfXgbW?=
 =?us-ascii?Q?NHk+yarEjtptvKEs1of3agyM0bzTqqdJ4Gl3nKMPClJev/HOYWRJHT3P8gXU?=
 =?us-ascii?Q?k0bqM7zOa7IJusNArkoF6Oyxk02xTAAaybyfla3smhdm+pckz6ZwduUQ8ETT?=
 =?us-ascii?Q?xhosnbBNb7X6+E1mCpoWjEPPV+WrKhH2zZO2FyhyTHSO2M/eMzNlwVCJ7qQR?=
 =?us-ascii?Q?Uq4Su3oLwjDVNsRCEDoAcM+oEfKC9L8FFUij/UXBUzOvl1J+c6GEzV/d4H77?=
 =?us-ascii?Q?XpaJSA3HYs71/2S6BTSm8xFf7XPvMvwJtrFJvQVk9VGFo+NRN+D6y/s2lWEt?=
 =?us-ascii?Q?dtZC4FCYSYV0WwNzeOYP8q1uBbn6NaMSRGLjBCYc7WwICXd7WOUHHPOVOPj/?=
 =?us-ascii?Q?ga692qKKBJmEGQ1wbXBxi9/W0drlEVNV/PLAjrCDbF5IXmSjuMR+3xRZYdJV?=
 =?us-ascii?Q?MudwfmFBZpF/i+74CnjC37g2GEI3pkzkIEq2U8EIzg6XxXEzCE1PLJOFxkPA?=
 =?us-ascii?Q?UJH1ODCJ/E5xmrOtGBKeLwtV+sGYMzq/TCFkjwNKVs7NyCng3O0y9bzJ/daF?=
 =?us-ascii?Q?87ZXzhH4phHgMbzEFxukQNbnF0ZecG1PJJj7lPvmi3FVV4d+IpIXkeQzq3nb?=
 =?us-ascii?Q?/qo15Ize/8myXXDUF46818qlNt/IOYbNYQREL2Ni4z34myufdsQfd4okPUL9?=
 =?us-ascii?Q?zTVgK8EaWZMSkb3gvmRWkUMaesp+iOH3LKRDiZdK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6290bf-5466-4dbc-15e3-08dbb51020dd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:48:28.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUGaHKrhyxIJTCFBPcsYMV9W7tgw9Bvbgnj1pajRdgKuAmFhzm09bPJTYybn9W4XfEQ+DZDBp+Y7XQboUYgswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4267
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

Huan Yang (3):
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

