Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942287010C9
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjELVQ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjELVQN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 17:16:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DCC8A5E
        for <cgroups@vger.kernel.org>; Fri, 12 May 2023 14:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnU0GXu+re1J82O7A3j7edMqJyvhy+f7HkOVUOYm2iGllR2iSkxazTecZuncgf5/ZSxw64SBxk3SkQQOVSAAdHF1qEMucEd56htwvnESoCxF5t/Be9t10rHNHCKY/sMNkqwSAo7NYz+ckHdCDM40FBBYukT0qFp9uoQs5+T7maKGhIyqz/3wPF1NDOaOW1obiwWNnhc8BrE2/zydEJLtiJdOG7LH21a8PktprthaAlnWbi3CrQcth4jbMkhMK77IuY+ruM/1Vn4NTlmlZq0oMPKKTCwK62o+aQ4Q4D0ETvX/vNOMTBPQtRDsiTupKcByAyt88wKbVGec/u4zWWaS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x55qt4WozEzcvVLV3w9xOL/S4v7cSAQ9J++ugA59PIU=;
 b=SYWLF79egfwZn6xI+I1mFJ7hHmoaSN103dBmili1RF9kbjZRcBlYvCN1YEU1wKUnUL2w/N1EXPg795w6Fm/Y9ysI5oHMboNCF5fhHURJmvTKc3DEebs5N0CgWwIeaapewLfMIqJfSg+3laMKCe9q3VygD+Nxsbthiz8W0G0I4RwxkZuYE+cJl3DLzTZxeUUGu1vVEcuG0jMQSdtlizq7xMm6ug9wTSEcNLsaQANk0/erBuU7l2YHgYo+C2PzZBTRjhKNG02zNdaRBKoAfBmWBVi62DGb2onsG12UJnnZXyjo/bteUJj8JBFemdp5e9aDjK4BaSne0Egld8y1ntfjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x55qt4WozEzcvVLV3w9xOL/S4v7cSAQ9J++ugA59PIU=;
 b=JBC+OGjC14bwo3BIV2VZvGdajWc8KoK7lcPuZS7YeNCSIYm9O3FJq0Ri47/Tw69v8V30loe5NY8Sqlynqs9bsy60M9/Jp0h1N82XgrkVa28gurGiYFNVcvogHKZvsx6WMM0MKnQJyLsXdxtuaPSXsu0Y42CAeopzqOMOs9STCxzg4f7fbBw9vkUjA5s03HrXUxj5ZCJQNHJ/jeu+60WN4u8fJ3xcaxdEyh/ZEVZ0b2APFO907hONzl6OW9+AYOrdQs50GtwrZEMd4KAirDAjc3FTdOJ89muyX6baEVVmXVS/tqMRHu+DoaLOcM10cr4KOrun9xfKLuRPpi/jf2Udow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 21:09:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 21:09:23 +0000
Date:   Fri, 12 May 2023 18:09:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Chris Li <chrisl@kernel.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZF6rACJzilA06oe+@nvidia.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com>
 <87jzxe9baj.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzxe9baj.fsf@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcb60f2-0c75-4345-162c-08db532d2951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmArltINAKv245SrHnc5sghUwzvwkZzbTLFxkckCFH3Lcn6dpqPGi7kINMTdHOQzTMOh+uKhqe3UyWmK6VSbFCWSaW2kzA1kx3CduZtUSyxLXBpg7SBk9VKVQMfDX0w3JFHGLlygqzlW+eDU5umu08b3Gh5tCAccKBqk5LUCLCLqQkwdU/z88YCh+9wTpfIGsualltMSV1Umwj0oweUEy+SqytzymRnQ5yC58fWWubWHZZEE3sjBUpbkcn2JrEb7KFesojmDSjIvYXLo+djREH1b7pc2uOZG6s+vILyPhg6ZWtmAs4eYUjaFGuLZx8AL+9VUnXfwfkvBGs7+QUPRISD7+3zrKkdLeEOMs5WRJyhUjuAA10Cncngm+yus7hkK1oMtGwrm4Q4WQbBzshNY5Cn1+tP3c+qbeRpDo8NXdpppER4nVtNSdUlO79DQs9EeAeJ1ehnoMnRgRlTgVRCHgUp85tUTz3Te3YR/Bp/2+xsxqnx8IIolXdNDsGFdWBj6SNCC1AfgxcRQ6uwslpvmoVlzl6G4nO3WmsO6IJ5jMSMrN5ZM3SO458XIoz7tJ3/d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(86362001)(478600001)(2616005)(83380400001)(6486002)(6506007)(6512007)(66476007)(26005)(37006003)(66556008)(316002)(6636002)(54906003)(4326008)(66946007)(186003)(66899021)(5660300002)(38100700002)(8676002)(41300700001)(8936002)(6862004)(4744005)(2906002)(7416002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enoTtHBTiCXd/1RuTBO0zwafA4W5st/FT9x0+8TiZVGraByCE8/1KWGpmfFb?=
 =?us-ascii?Q?mAd74/S3dBxPf1aXdb8Iql+WaVE32hqMNWDFsrwoiYBGhFnvEXF2mcDaSXIp?=
 =?us-ascii?Q?A3yJHaUQVF96oZaVpU2VhAicJnKC2T1e9uh7KiCPU3JmXqx13Ic6bvfKkwgs?=
 =?us-ascii?Q?Ykt8EGnohtCJ5LMDDWX7kA4dobCsUZ0HFbjkqjTmv7U5F8vUweFJrIcKuYvx?=
 =?us-ascii?Q?MfIhwh4jlHp0VZXnpBr3/8KmjLOUsbF47CtNMwhC0eiu7sq3+q68gAgh/IND?=
 =?us-ascii?Q?nYyDWZcvZNwjTXEo6USaf2eppA5Fiay/+Mz7lbpLmNer3Bo/A02NABzlMwtk?=
 =?us-ascii?Q?+VQBcv7aGO1Hk5WMUmJShAGQ4pYaYPuYxk66OwhjALWovnA04Sut/6cjToRl?=
 =?us-ascii?Q?aw4rBMpp/AsSpK8vuDrH6gMy51xxY/gNjplOL+6uSCD6ToQ+5BAuK7+fVv/e?=
 =?us-ascii?Q?NNEJFz9hVxZadLapLo7mi+gAaRl+Fjzq7qBoKo4cb246qB0EvvvUIRfvYj8p?=
 =?us-ascii?Q?WZhlQJ+u/FgyjKfOr2x98Pnb9YzSdZHdGd2z1bdXZ9d7NA2c0S7J+pzhFOE+?=
 =?us-ascii?Q?r+OxpLSkHJWESwYYgWHwWQ3J+2lu/6w/zJmxpcqzd3UuBSO6s7cQBGO79RIN?=
 =?us-ascii?Q?kjhe1KEPjUjX58hpgWGRQToKioC4JBSdbiER2Y85Njja3Gz8+njK+lJUyBZ3?=
 =?us-ascii?Q?oaCNxXNem9qQTGbRh8hJmNXZ1B1MIlOjHYoRavmxdwycpn0mRSpjK8gWF4vy?=
 =?us-ascii?Q?+h9ZXISO4MEiT7bodKwAgJysUSW/2KpeB0lpmdyjfW35CakvlJGaPehK1ejH?=
 =?us-ascii?Q?c6YV9ckOwrXzQToykFeOgSawjJ3v7KjpsGrJemCP1eNw1FlFyDU6niyQ8q3u?=
 =?us-ascii?Q?V0NXlp8XeDOSINqLa1EPFZfUESJ1bKcwCExITP56yeXMwCA7sgJ0Ox259tbG?=
 =?us-ascii?Q?WEO2b6V9hlFk5SVzhC8bKtkghtteYgkuUuT5+G6enkm5npH+wR1BWBVnuBgo?=
 =?us-ascii?Q?ZoPaxLmXTLj+RY1QtzDo1oCc9FCKomxcXUaLBsSNWXaE76mYhh0SMf6qrwOf?=
 =?us-ascii?Q?6uD3DxjNwg7iGVJgKEFLOGI9xYYIzy47ZhFHzpP8witEjG7Pbn7cwzN+o1Fq?=
 =?us-ascii?Q?UlYHBvaUNnAC+J3MM5AQBLVjsSUi/vqLr21Bozmp9LJVOplF0qy7FG03DArC?=
 =?us-ascii?Q?KlJEUaIUkFThMCC+2QgHp7PJNyCxsUBAgZ6zCC7JJ6tRpKXzal/HdXx1bpfu?=
 =?us-ascii?Q?Qv0MW/aZued7aGn70LcuAywKt7hFCAMt4rJjlxgbNIprH0u/OJz8t2d0uWw3?=
 =?us-ascii?Q?b2ABeJxDvGRMIRUacZzGe78IXaU06WTYYHOp0O3aVmEIq5QVegi0ceKHemUd?=
 =?us-ascii?Q?1JOWiNt/wHjmeMnKCGQAEuXUB3dcCv+DE7i98US6oeaJ2LNpmERzPqtUa5Al?=
 =?us-ascii?Q?by94usS7msim+4hITEUY4Auyc13mo78cRNIqadZld0osOqZ9OTfl6slXOIN9?=
 =?us-ascii?Q?Diav5e8nKTAtjV9oTeIoek8lKc+A1SnWQ7+JTkPsUsqzyfASs7W64v1BvPAH?=
 =?us-ascii?Q?3dpUl6zGi6+q5Ad0Kzk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb60f2-0c75-4345-162c-08db532d2951
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:09:23.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex4hvmdRvGQ5M5GmcRAGrNRLtUKmLM96XzFhJFchhvma12wJfJnRRu5AddI0CcBo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 12, 2023 at 06:45:13PM +1000, Alistair Popple wrote:

> However review comments suggested it needed to be added as part of
> memcg. As soon as we do that we have to address how we deal with shared
> memory. If we stick with the original RLIMIT proposal this discussion
> goes away, but based on feedback I think I need to at least investigate
> integrating it into memcg to get anything merged.

Personally I don't see how we can effectively solve the per-page
problem without also tracking all the owning memcgs for every
page. This means giving each struct page an array of memcgs

I suspect this will be too expensive to be realistically
implementable.

If it is done then we may not even need a pin controller on its own as
the main memcg should capture most of it. (althought it doesn't
distinguish between movable/swappable and non-swappable memory)

But this is all being done for the libvirt people, so it would be good
to involve them

Jason
