Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5469FF3F
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBVXK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBVXK6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 18:10:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D7322793;
        Wed, 22 Feb 2023 15:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob+wSQelyppV/Dro35f+4B0AO+1cjHc67KApPoHbcMZhc4AXWtYbo91ZZ8mvb3hVwOib9ug2F4m7u5ML323Hz3qQCAo2NFPCTh98LaXfc0Y1iPvYhgn4pxBVTT7k2uG9Tq/obJg/okZWPBIvVjl9a3GTQO0T3uVkjk9IV1cckloipQeGKSNZHlWuDq+UfGNH/yVbSfOc5zgugGoSRxC3KQO+bqqz1OxWFoo/wzgh65nPwygHiZL67dbLwhZyD451j8m7yUODxRkOScSZ0Wv1vONcgOEee1ZYRqaMeQCXGEp76iof2G1QDoNc2KF47MzhugYQT//OHu6Ngbqt4T7BAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEkgqc8O5bXpNrc9NPq8zjyGAtxzYq4xZ0g7ZP0VIYU=;
 b=nqcL3zgh01D2I+WHKYHgWG59XoahvxsebrmbF40FPDAiIz48eQTjca4TwfHQvuVJK1i/cdF0qHp87qtyJsnL5Nr8jrg6Nat3qcZ1QOC8Te6AwTIRi0mLwnMEr6VUFcRwSttlR5b1IyRl4NAc4xWXCdg2hUJ4HnB9td3iYRfO+KDxP6heTU8bkJ7Xu+u5zKEh/AUkY0+Rqy4oC9tr+U0WPrXsmv4a3buWhaCgblrGH45AC0OuAXUwCbwp/qkAC6NMnqevlntg3wLZcfL6RRKCZSCkbscuppkky8Wd2ROxBkNbdGIYG4dwJKr9wGEJAmWxhI80ul3gVSOmJL6l/dXglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEkgqc8O5bXpNrc9NPq8zjyGAtxzYq4xZ0g7ZP0VIYU=;
 b=K4ce+te2PjmL/TZR19WKv6RqyhnPZ2vtQhFLo6Mc2cPp6KGmH7/jxwRJRrMXVqbP1jKPYBMtOZKLiPlrebaXEQdg7X/bnRXTiSDZPswLcUXXbWi0dJDOFyTUzmn/qhXCtylnsmya3c+YDwIikyLyR0U+UOt6evaN2ZDU2C9YXlJBd0RpSs7bTpvPdJm9QSS5Wyl2TVU4tLzJ7d7i9zkW+awl6ut7ou+rjs/92oWMsZRTo5xILzhrLtBiv7lwhItkontTl+zbZp/wsAHcIMEVOrl9Ma7/MHRl3qJDixKKMqSVq9TVV8QT+ziZPpKP+euX1Lsour1OvBEaX1x//lGFjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 23:10:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 23:10:55 +0000
References: <Y+4lcq4Fge27TQIn@nvidia.com> <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com> <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com> <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com> <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Thu, 23 Feb 2023 09:59:35 +1100
In-reply-to: <Y/YRJNwwvqp7nKKt@nvidia.com>
Message-ID: <87k009nvnr.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0044.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::13) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH0PR12MB5465:EE_
X-MS-Office365-Filtering-Correlation-Id: 86650f56-c5ba-4a19-5841-08db152a0cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiFZvzySp7B8+Ygy1nOQav/W8CAPRV742jER+K5IHocXpvz4UQJy7NJoy5F+R6WZeai4r2RLLOoD4mbXcnYEtfGb8rtJ9DpdoHKWeYv8Quu2WOfErRGThKQyC5Lw56E8GQLb6Ec74pFDh+Q3AqBCFMCyYatJ7B8CZx3s5Aib/6+wLm1RdtdKOrQHECegUvfPOGC6ekZZEv+8KXedk7Kadar/JetVcDAxp4hGicqfELmGHayjsfXSaDZuhk9fobtyMQuRGT/9txX6PvXtp61W4y5DPrUDAZ6dZ6Y/eMPiLmhfL3qn87sThw5+PXTas7daED5w7vODu/cvLtS0qmDmKpGeq7VRs0RQyImGL5ewK6u+15ORaReBLTzn4j9POC+AivwULgXMDGvvF1270hCKBjfr3V+WUYBEv+mNvJ+Hm2LTD/es8iEkmLtskZadVoOzfd725w2MjQzgzVg33We8rjsIn7NVH4Qy7AfSsC2xzbR/FUR+ZnkLD2OO1w68P3mVgv6fXFHKxMoNLIMvJfGxpkqNVwapdQqagle2UUpH2sR/wRgqD2IRNmGIlFp5rdVS/ghHORRwg78nzaBT9i2ilmI6VG93urrXaHrh7RXebcMEYBBCYLgWxhgebWxeBX6LH9OYtsMqf6qMMWSQjr8frw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(2906002)(7416002)(6862004)(5660300002)(36756003)(83380400001)(6506007)(6666004)(6512007)(2616005)(8936002)(186003)(26005)(6486002)(37006003)(86362001)(66946007)(38100700002)(54906003)(41300700001)(66476007)(66556008)(316002)(478600001)(4326008)(6636002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3r/eDftl9wv29+Uxj90QSrqNG+qh7Ry4ZA2SF5Sqt0yOzdzOlNJYiDx8nPU?=
 =?us-ascii?Q?qxEy9zuR4D1n6+6z5GtFN7PUaLMFwIAQz1A1T/jIapKvKeeXhqgnCP8HdOwj?=
 =?us-ascii?Q?7wfX+XSf2uurUc92pZxVEv88CEfbD9qEGX6+G+iJKjwiFgj2Ta/dmDtPL6Pz?=
 =?us-ascii?Q?4sjiAtAAt23kshFTxOMeob+fktY+SgHn/ypWhZXUsAgGpF03W93IvjeEadsL?=
 =?us-ascii?Q?GRCFpj7CYwxyEKJOD39yTGZSD5FnXfSk8PZ6Cu41cb0r8PkJ5pMPGEzRRHh0?=
 =?us-ascii?Q?aXjmE4R9a+9OTHNXLbYjohGTiL6AR3aCJD0mz1c73sbOfRaGOM2TU89dRFOn?=
 =?us-ascii?Q?F0yJxcyHMogwf2GFKJSDWoU0biVi4zhCiq96fBXUp9eg14QJnLZm+W87de+E?=
 =?us-ascii?Q?Ps3ttJOwNj/ON1gtDEU2HT8pOiCQYXQ3PUbxh5nLE/pNCyKF7hjzQC3bdfvX?=
 =?us-ascii?Q?lS/uRs+vLUM234Tqh1pS6NuM6zyg+jeSl8JMqmiLuewKxVERFQmfXCcUHFn6?=
 =?us-ascii?Q?V7eiv4a9lq5APZtADpPTIlPk7EJWJCnMWJ78+f3dCDqxCKkPSx6oWG/NtcDS?=
 =?us-ascii?Q?L0KmCjdoLmZytxK9KS2JAzhqzoXFPZuAAkyce7ln4RDLZ75KZJmLYgPyoRIU?=
 =?us-ascii?Q?ALEgdBNpkuI+0fnGGoNlBDx8syUs1t9TluOZGYr++v3Pi6T/fbaIUb7hvcQO?=
 =?us-ascii?Q?CjIrHtMFFMr6kv5QmnRDme5xwF3sSDtpEfmmcudWOK/qk2Csg53QVxNxi1BU?=
 =?us-ascii?Q?tLQ6mlPoHUp+SWenHkdByUnsLRrdN0yt732DWAiPDwqMtuJxo0BMPJFaoKeb?=
 =?us-ascii?Q?Hlxhx/IyBLJVVXS2WlXI4cPgBCoGwBxYvWwvLVJPur3zE4Y3WxTycOHrfa37?=
 =?us-ascii?Q?zgbCLecIJKN1FRZ65LLCVzY11sWKRMr6QjqUzFKTBmrdOGpkXhrpUvrxtoW5?=
 =?us-ascii?Q?jjt0MOlvk8KR5a3V6hd4/FHKV0wt+oLXHDM3R7VPVct+POv0Zevom+AqB3JE?=
 =?us-ascii?Q?jItFVCCMzjVhwo2WLWJYZnoItzy7JrJN8E6f9oXZOUuzxnyl16jmabx1qlnO?=
 =?us-ascii?Q?LQStPCeUMtdbFY6QS8KIuwfDN2YZ7sZ/Ndg6m+TB02VYd8xujQz0FJLhOPOT?=
 =?us-ascii?Q?ja/YH+kTF4uLkpkKiPfOMVEIs50lsS/DXwoKIAoRGO0J7HA8KBetTXRJ9JEc?=
 =?us-ascii?Q?7kwFopHaPrs4yVjJwCS1wZl6/qe47zlLGuPIfYrYq2VOEwPu/DqtH1SbmbIc?=
 =?us-ascii?Q?UFUd/V164egvWky/fNkWlv6s7JFuvYPaAKlnBvjjZ/9+e6/0N+xVxkzdSxNR?=
 =?us-ascii?Q?BJJXZIFjs99z2bFoSBevd05+F8HWIoAG67wizHg3m6OstWkBLJEkH0RtOxZk?=
 =?us-ascii?Q?z2TxcE3JQQXS+AdWmbExWzKLJIeRItZiZ5XgJdH8EsTd5y4VJQfWPzPNQ1KD?=
 =?us-ascii?Q?pR64siy56wjMN07MN4QEG0Clr1UIcPyWGday+5ePa5IthGlv1xWA4knjqTDn?=
 =?us-ascii?Q?F29BiMxIAaWQtfDghUWltlu4pP39ubCDAXkX7TUBwCOf6xtYwaVNjpbYsdoj?=
 =?us-ascii?Q?Ez28TG6EZlVeRRSzr4h7C/esYTHgbx2uGjP27Cgu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86650f56-c5ba-4a19-5841-08db152a0cd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 23:10:55.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj3cAbMvyRjUg6Zl04BDzj+cUT+3uOIM51grHxnpQM8We8AexG74gPJHXsGLgbaO09aGQO8ppFx0zxpEUMxDkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Wed, Feb 22, 2023 at 10:38:25PM +1100, Alistair Popple wrote:
>> When a driver unpins a page we scan the pinners list and assign
>> ownership to the next driver pinning the page by updating memcg_data and
>> removing the vm_account from the list.
>
> I don't see how this works with just the data structure you outlined??
> Every unique page needs its own list_head in the vm_account, it is
> doable just incredibly costly.

The idea was every driver already needs to allocate a pages array to
pass to pin_user_pages(), and by necessity drivers have to keep a
reference to the contents of that in one form or another. So
conceptually the equivalent of:

struct vm_account {
       struct list_head possible_pinners;
       struct mem_cgroup *memcg;
       struct pages **pages;
       [...]
};

Unpinnig involves finding a new owner by traversing the list of
page->memcg_data->possible_pinners and iterating over *pages[] to figure
out if that vm_account actually has this page pinned or not and could
own it.

Agree this is costly though. And I don't think all drivers keep the
array around so "iterating over *pages[]" may need to be a callback.

> Jason

