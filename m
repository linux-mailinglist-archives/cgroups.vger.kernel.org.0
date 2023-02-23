Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9376A001E
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 01:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjBWAf6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 19:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjBWAfx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 19:35:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3D38E88;
        Wed, 22 Feb 2023 16:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0Wcgg2T78J6pQP8cM8MH4B/QKXcavmDQpP3b91NSIYBHeV6r2FStHcW2DYSchXEkxWaw1EQ2VBRUgizUxVummLvgD6NVMbECbvAiCpQqrrtxqt8mkNwum9Mnn01v3ce+idh4ePlgj1a+P0ByX0f/TJbOgB88Om4x8YqJPJmlInJh1GHAwcWWHPrjmoZci3nIv+AUuELIS4Kh0kRZKy7pNzKlG6yWIKKCmD4eYV9UVVH8wlQli+c2oZhomz/Y8WWjEETfF9AQWBCcoKeSzJG9/cAEFEECONCziTuOgc/tsJ98Qdo+z87v6Imsa2bvPC7PsV/3q8CnYu6QtBMpFNMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmNiOyhFz9DXx43kKHbLedhcqXbiD2keDGvvn4lrLkQ=;
 b=IjI/XYBeNkuSqCimnRUE/s7PPJYq5ujmFERFV4ikn/TQkL37s9QSz/z4uMA0syHXqxpbr4W3kcNB47qPaQJxsjQJEudR9qARl80F7TXFOjAeh9YVwmLO4tMknCJurRikVynUvVLYoEVSFRZ2nNedG+LXbhayXMoRsJPg+Zqpn61AJuaaIUlxNxBcdqWAt2fpErGlX8QWaelO7eP9uv0eAw/MJEBYxNe0DxKOF+dzpiE8nAL/Y3MEryHT3Q4mSaIUddNMbV0mEzua5vFwDCD3Nf/x5tz7iHFbAcvK4a+5KwfFZrpCvrk+FwyxcxfMViHPaPYvHTT3aw1ke3oRdD1djQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNiOyhFz9DXx43kKHbLedhcqXbiD2keDGvvn4lrLkQ=;
 b=ccCeo35i/KGpkyBRMJz2hbnyIED9fU4v7FHELHC54QHHM1VXL7Z1vZYdoR7VU/8Nfy+ANGbWyrI0SVpjN8bV7agWTYjeSt+1VuRlUjAU8+PuxxkmBVsmaKE6eKunrmjpkcEjcRf4vlkZrNWXjyrlPrSFrZH+N8XQzrTKKsqRHzjGYe1QLus6svQlq+7i/7v4WdcXe3eAI0CA1bcv5KbK2TwtZYQeXNXbXOkWb60sJRQ8SAV5RkBa0azDhe+vt9SDhc0bgZtF3lHQDW/XDSxDn1srr0LKy2zXASd/4yaGVWACBePQow/gx6fn/k6H9tOfp/bkngiGD8ubw2j8VclYRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 00:35:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 00:35:49 +0000
References: <Y/T+pw25oGmKqz1k@nvidia.com> <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com> <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com> <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com> <87k009nvnr.fsf@nvidia.com>
 <Y/at3iYz/xBSPPM+@infradead.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Thu, 23 Feb 2023 11:35:54 +1100
In-reply-to: <Y/at3iYz/xBSPPM+@infradead.org>
Message-ID: <87fsaxnrqa.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c808221-5ac3-4f02-64d9-08db1535e902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzBNy3gmSSykF91Y2a90xhRwb6aUejeGJIdml9JnOV/dIsyoNtJEWEabP8Bwo+xUhbYff+OIV3/ty4cFCeLObMmHGnF1FLEA1ZxXTpdTR5sQlYcBAgSYM72FN3p+/a//U3KMIJPvHiL+HoCgaw7C/8IxomN7OMmJnIId4ZpVSOiRG4BfLQ2g79SIRxEfcIxhpSg9VrlfyQWpqOVDXhnKa6LK0fYULN6qiw+530vdfM9cRxdlsSosviijIkULw7X0XbZwvPJ4fpEol0rvEfGR0MGpfObyJx0EyAiRfASgALwwetqWZ/3DqooR1gQeGjoO5ZkA4QvJ+S2Ef6AaqetMwRExRUyUDZYmVbF+wnzkvLX5stcYKgGLyBTmet9inCOAg7/YO8bFlOwWY8WhxTuu7ugO4lhZTywxrkFvP8IoFjB4MeGW0RBcBguy7iYXtH4n++rTv8dH1JSQfcDgDvvowvFFDj7JIjAlUmhqWl+zmTZf1JYUXLLHFKf0kT7TGH4LeyuZoZDCN5djDfsRIHSdlzU4gQ4vpqIaEQ4oYtsMta36f/snwGa59x+i+3SOfsb0A6hY7ymKZ6+JFJxKPkCkiSoZ1qMq6pT3TGj335uW+PxSBA4mMSQZp/FlStX2Q+y4m7da1eofaAuUr8IfrBW4xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36756003)(5660300002)(7416002)(2906002)(83380400001)(26005)(186003)(2616005)(38100700002)(66556008)(4326008)(66946007)(316002)(8676002)(66476007)(6916009)(41300700001)(54906003)(6666004)(6486002)(8936002)(478600001)(6512007)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLgT7/XTqULLC/3pEsuI+WrzdM2G/7wITQ2gXngBf2UpYPdoArHSgW6xnv1U?=
 =?us-ascii?Q?Rvsf8WlZZLXcyIy/Ge/9QoV6sR3dNG0h0Fd3UGsOVeHcJ1btdEZ2WoH0/iK9?=
 =?us-ascii?Q?GrnSDs7F2TdOX1hrEvAOGbWbqpj80CAFw8jwlcvB83hKG/Zh8Q47S64ck3Pf?=
 =?us-ascii?Q?sohDYw+nQIaaxaHBHYK544GGZSbC7NsKM8gpR5cPWqRHQRP4vUS7yTZojBzy?=
 =?us-ascii?Q?XQqcgJTT3DfsHw99uyAM7+k9+hq4PISNluwPCub2/KAozcSNjWXAoDFViqd+?=
 =?us-ascii?Q?qTdZy1g6Wdzjn0dnJezw5mId/LvfTOUgw4YW3hll+1hpV9/ZOucIo/JsMgy5?=
 =?us-ascii?Q?0EDfE9HTmKxwOfc4LqyxMgsICkm4L519a8SwR+TXY2zvvkPXfeB8a3p0WwqY?=
 =?us-ascii?Q?BEJDxKW7PuyCk7yNJDaXl23G/ArtEJbl+YTfw7YTdJBxxJ7YKb+uZrg2aGFD?=
 =?us-ascii?Q?gOGvHq9phVDT1udmIz50gX7acJjGU8KE51S+ltvQGf9wy5kAFawneLUz0rYH?=
 =?us-ascii?Q?THFoeykOnOSUteWFuj+Y22QvUpG4Aqzju2zMhwnx635ITRF7c+e+m5D/QddN?=
 =?us-ascii?Q?jZNMNLwP+L2M30QbS+c204pmz66IC8Un8xB+qD3Z3RMjB/AoHbo/pVUMrS2x?=
 =?us-ascii?Q?/VnoiJYWHcDUbc86UMw1oTuev88SAeRuil1m56fda7VQfI2mFdu6t5o4B0nO?=
 =?us-ascii?Q?aQiSYTAQeKyN9sRqaU2DaPSbF2STNhzfrAtKvSTfVE7BrskkUHm/EcZlgqbV?=
 =?us-ascii?Q?uTFs7Mg8/mGro43wJJM/F6l3hnQz8iUwbBVplD3Wh8qhPxFlBKKSsE3Dmek0?=
 =?us-ascii?Q?8d+LTQ8SVF2Y4Dl9i5cb/+9+/FEnhaSZmB8Eqw37V7P50czCkG3aW6bdFvGj?=
 =?us-ascii?Q?3OHRpk/atXKATp3YvU6A7TiYVgFxEtw+qtYhxtqy9f//zXf1aUJTu/Crpy1g?=
 =?us-ascii?Q?arwNGLfBf+SALFWKAD83aYDG++lLHe8VxAg5gR+g468Nbn5Y64NO17E9wTPz?=
 =?us-ascii?Q?jXowd0f2LvSN7pIVBaDX4JWrmK/5AbDaeULHMktke1F5dBv9hpd9/xbDmXCU?=
 =?us-ascii?Q?R2LF+c6NzrR4/C6x7JGlXO/Gw9qdCfMAB7Kf9jPwf2y+rWVIhJPuThxeM4LQ?=
 =?us-ascii?Q?ulF3hOHVLWBps4bImf/Bu381EEKseZbrwjcqI1O0O/1yT/SW3xyW070SCJaY?=
 =?us-ascii?Q?JD3bKSHwZKzdt/s/ZUrZ40zcSUkCTg5o6yxrRzic3/QJpB6lRHyg2eGzqo4f?=
 =?us-ascii?Q?oFil+vh5kaIaUlgrrpWBr0744NP+JLo9jvMVe4FRcOB6m+AIeUtRQ9PrxtWk?=
 =?us-ascii?Q?ccyJXbrLMETNo32snaDL7WkW9qkN0PoXkXC0NNfQGFHwdBOgsVmPaAhaYye0?=
 =?us-ascii?Q?UP+I2kHK/3PPrCylJ6Nf9mtSOiByn+STxSG3IqAvcBNQegehM+D7nCGJSUbe?=
 =?us-ascii?Q?mJJYIfbGLbAASjFVXkcFgG26sNSkEfMYW7VJOwtat0mnS/P6BAKzpjqkvtj8?=
 =?us-ascii?Q?89VdbOUdeMRoCRC9qORae5QB9sBD2zV1KTDt4mEFyCAFsDI+JhmpOBcEMtXm?=
 =?us-ascii?Q?zWPZtYvhLK0CzlHx26/9TpnikPhaJWGOKcVU0c8I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c808221-5ac3-4f02-64d9-08db1535e902
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 00:35:49.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46JxylTl6Wkb4IWfOuMnCidEJgvbxd3muLPpwSGRcpkHzf8wKQLFKlH2F7aYqoWH+Kh52d8Slny4R4Ldefwb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Feb 23, 2023 at 09:59:35AM +1100, Alistair Popple wrote:
>> The idea was every driver already needs to allocate a pages array to
>> pass to pin_user_pages(), and by necessity drivers have to keep a
>> reference to the contents of that in one form or another. So
>> conceptually the equivalent of:
>> 
>> struct vm_account {
>>        struct list_head possible_pinners;
>>        struct mem_cgroup *memcg;
>>        struct pages **pages;
>>        [...]
>> };
>> 
>> Unpinnig involves finding a new owner by traversing the list of
>> page->memcg_data->possible_pinners and iterating over *pages[] to figure
>> out if that vm_account actually has this page pinned or not and could
>> own it.
>> 
>> Agree this is costly though. And I don't think all drivers keep the
>> array around so "iterating over *pages[]" may need to be a callback.
>
> Is pinning in this context referring to FOLL_LONGTERM pins or any
> FOLL_PIN?  In the latter case block based direct I/O does not keep
> the pages array around, and also is absolutely not willing to pay
> for the overhead.

Good point. I was primarily targeting FOLL_LONGTERM users. I'm not too
familiar with block based direct I/O but from what I can tell it
currently doesn't respect any kind of RLIMIT anyway so I guess the
requirment to limit pinned pages there isn't so revelant.
