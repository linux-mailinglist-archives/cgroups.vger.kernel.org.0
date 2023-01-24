Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71980679C14
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjAXOh0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjAXOhU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 09:37:20 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F744995D;
        Tue, 24 Jan 2023 06:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVaV9w+RdlPWko2w5pGzwouj3ODwEzqBedzTqML8Ee1lEm6iAvR8clDpZw1wxGmlL4toOTfqjXEGH4s3aOUCyFTQ4f420ImFaH0vS4in34W9bADkpdLFiX0owZYMCmeEYZNNDhjaTdvClEKPKu44r+N2YhspR+HARM2wjrS2JRissc464y1lTtJORWd+DZLKisOSgFGHGVs4DL5UgRqbqKT6WbVXdC+TvyvORxwzYJ2ggqlyYNeOvyk2sBLRNaUfL/6p8xil7+w0NYUWRkxZC83+q0LcNQoJsL7Sr0SiZsK/2HVeEkZ02FXgTMxluoBrWe0qXBGELXRPuWqSgFewoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwC0Xt8mAoKubuWYL73vUFZNMWCWco00MGWx6+xqe7w=;
 b=fi0r4Wo2QhcOLo31Pkn+2f1wFyUS5eyn6fRtZz1w2LO9f64K4nKDUcmxU4uv1X2zGDNHzps+rcQZOkG8MOaN7Ap7hjSUZ8g19ds9PzFxe06yeVJJPR/xi4ILbDnmJMvGGXcwIuDz9cxuD+KsiQP+ZwW+O7InUw9FVcYaT10ZRKZzIu6NMFDMnJsf/j/b/gGsIIvFYUqvcI0rgZyh5A0T/oBZwSBbGByGxlmQ4NeZ6OTBtUFiAO/7l/SBhsOxcrDDIdVnpRBfQkIPbD6Cx9JVRWP4TYtEZYwoZbzgarX9KRsn8t+g4ECkDUHM4B+3Cm01ArFaWF0jHbuchwD8l0SkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwC0Xt8mAoKubuWYL73vUFZNMWCWco00MGWx6+xqe7w=;
 b=F6aRMKcrtYzmchAcCMBpQgCwE4OR+0DTdfFqi5dNV+Tc20lEFcyupldB1sdp9m1scJ8wiSkpvGiWloI/yUoRG6ZwlIYcwd3eo38PC74MxjvGDizEpc93Slro/7TpOc4PkPgdyMEyJ7TTslEvIoGIZVwEff9Pg8iFQgo0E+agijDB2bVsQBEtzLE0mwBna+FCzu0MGE7RlBCdnm7Yq+0wMMLz/NQQm0D/E6vZch5T0NgBBqOR3QfXRBjfCfQXi5wPDRxz+3CQbqPT/mghzWhh3qk3Mg2zrdeEV85mn6TcI4p2Sr/OYtaSe5mpgwfmB78SUGEjGtFkn1KE1LriVDIpqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:37:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:37:13 +0000
Date:   Tue, 24 Jan 2023 10:37:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
Message-ID: <Y8/tGIeg5mI9bDOa@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cb990b-3038-47f7-4cf6-08dafe187bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OU5A1zgUkVgwnKydNMBYtEcB5L3TZDsxt23XkHmeGms5FTVBzEFjdVsst9Ev8MaLmq6E2GqC2vUvdsfItduxmMJmu2qnaNpycphm24+b1vTRX1BYr03Rw0C2Yiub8S6O4J1Y1TO5h3teUuAUi2cc0sp5Deb0Q1J3Z12uQ+0ipjN7A8DIbIXDojHeQ1xLvTzHGQq5VV1aOtO7tMw7/lIF+l0aRfnG6cgale6zyMm/cfLgErdRE5+aFwiXE/SnpfK79PIj52e7ipxI4fbl4Ef9i8FsalNFJbJ7+fd9QHvHiJzunoAI/xoTjajy6lDD+svsWkSktGNKyS8NokNM6xIMlcufTCh33oske+7oWTPfr4eX2IpXrG7u2GKZW+r19ig0OSRQL1nn+uZGFRCWcZPcpHiuKCRYry1h2/6AjLCmu5/ZGCbEtDX0uO974hSPtJuKcHSHvQChaPd0ffQ05eLWgyOukgap+oMSXRDPPUvzOH+0mgvOVG2Qyuu/yacHaNuwkjTevsMgQ+JlDO0qVRNNyF1bw0aZcRzAdH2ix73CULIKYM+wDVlGLA5PGCit2fsQT5F9sU173ZBHhmqPJOCUrZxImm+Y2x0PYUbCp4Lhy2G1hNdzJ3iRXbD17BEvhEw2ZTL8K6rmvlqi9wrx7GIaSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(2906002)(2616005)(41300700001)(38100700002)(7416002)(4744005)(8936002)(6862004)(5660300002)(8676002)(4326008)(66946007)(66476007)(86362001)(66556008)(6512007)(26005)(186003)(54906003)(6636002)(37006003)(316002)(36756003)(6486002)(478600001)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWTA0YAsamXm4rPmWNLYQebO6O0qeHX0C01yfd8nsH7Mz9ydZIHKIJMRDbPE?=
 =?us-ascii?Q?fFeRHTGNwwYvyYm28EQTY6KEpK298eZjweNeDFJVksm0jEZksNwfGNzeoZst?=
 =?us-ascii?Q?vY3uOnOH8ROcxGnnGHlWTvfVAk4sHtRt0kbyE1O0JiNHQ6bPIO2hEMc5V0Ly?=
 =?us-ascii?Q?KL2v6Iif2V0wYWx0sXNj9jNlzWU8yDHRKKHEc4LmkSWYchvx4DDWLyWoWvgW?=
 =?us-ascii?Q?w8kkrEOdMb97A0qrEoHWKNrtXXC8A5Pgxbv7WQyuKACgzQd/CiYAf0krGqSb?=
 =?us-ascii?Q?e9G0AdsEiY+y7zjrShD2cO09VG1dJqzWrcKAKuCqlVCa3Ry8C7M1jJW0xx3/?=
 =?us-ascii?Q?x7Eqx0F0WH7vMMxUvCdPSOe+ypUeUCFbEY1NNl1C9K5ytLYZnpTSWfO/g549?=
 =?us-ascii?Q?aOnCMoWan7nKmJiYMn5UMWr6gnqS37RURsBEdVLD249jtDTIZWjYxjRlOLgh?=
 =?us-ascii?Q?wNENKY9vVk7/WHfZkC8MZBxtytPo1ZYdRFqZL2p3dLXzLfuANyfLG4ZoYVQf?=
 =?us-ascii?Q?Wrf2bgEwFOrIBNEhOzBSf1Ya+U6ZKJhz6pLA+9WB7BE7QPPoD9vwEBdKbyN+?=
 =?us-ascii?Q?SXbZyKpRtifcozGvHT9sxd9f/i916sTMz+mzxr2+RGtOK9iuzgeQlIZK/SCZ?=
 =?us-ascii?Q?v2JOyX5LuW+qFqAGrlUj3sSSTtkPlgQt0+QeWHChywrAQYtMquGVgttIUaUC?=
 =?us-ascii?Q?4WD80YcW7L/tUI3zxE2cuqdH/g+KHjBUEsBMUugVW9YE+gGurj5O3asMEWcP?=
 =?us-ascii?Q?1y7AgInvypmh1fgfMWu2TsJtgu/NcyFKPzu10VEZcK+hW24FtLgPHk9Avb7+?=
 =?us-ascii?Q?VoozhAWTs3qEd216k8j8Ci57wE8GC9aIu+QaXi+hTLpqhrGPuW/56v6m8VRB?=
 =?us-ascii?Q?+J9IYSSYgH3Kr+PioPZx9H9cBherTt5cDSnecPnuXMADiLO0X83PXdS75MYi?=
 =?us-ascii?Q?s5FiPpR0Grabsk8pdDB3JLQQTLLrrE5zriSGOZ50TvJv80J2NYaggXUAsW8k?=
 =?us-ascii?Q?0rYznqMhRztDqgefiPQr9GcOaW/Zg5e7ghmqbpAZGNfab9wGP3QEJhLTNqpk?=
 =?us-ascii?Q?9Qm4Ucc+xlAl4K/Yq5zPBoHX7vFdeWwD21aqMQRshjIj1YnU1794w4rlqQVy?=
 =?us-ascii?Q?T31JisSTMVyUHZp2wYawpexe/ntDI2SquF9L7AWAn+ZOnn+NRhB7ZdQJsg3P?=
 =?us-ascii?Q?rxcsv1gm8WPPuORvZ+d+rLUk7ZuWiL5cl/0xEamB5YaPVQSipzTpAYcK78es?=
 =?us-ascii?Q?+1T0WZSV/tWpdz5UP4bJy/gI4q5qmrSvcxZXiExqsdZe/qO1oxj5mnVHbkQV?=
 =?us-ascii?Q?R/2trcPjy+5yq1XEVBW7yEaO7eDvWo6aK3v0MVXWP4UzSHWfPLbK3Nqh40Pj?=
 =?us-ascii?Q?rrG+AUHLf4S3RqKKKezuBffhpG8RoS2dBtJjSYRE0yJsHVKaJdjkB8BNag+W?=
 =?us-ascii?Q?GnTDomoepIMizyfeuDh4ZBmCixiS7Bsa0mPLMgrlzJaJwofqWCgL0s3wYxNb?=
 =?us-ascii?Q?IGTRVc0NmJyrAMJQX6InyOXx6Hy1NaH7rEnnTz0e1sLlXUQahuzrW8GOXEUZ?=
 =?us-ascii?Q?YMZEMw11Kt8Az7HyBnI36L4dSzogtDoZuEluvvzS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cb990b-3038-47f7-4cf6-08dafe187bbb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:37:13.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjLAMrynaYWKSowMDNK7l89KzBA0yEJeV/nt3qJ1xBuH/6OUsccOKiSvvlXFBzZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:34PM +1100, Alistair Popple wrote:

> @@ -385,20 +382,16 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  	if (!umem)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mm_s = current->mm;
> -	umem->owning_mm = mm_s;
>  	umem->writable = writable;
>  
> -	mmgrab(mm_s);
> +	vm_account_init_current(&umem->vm_account);
>  
>  	if (writable)
>  		foll_flags |= FOLL_WRITE;
>  
> -	mmap_read_lock(mm_s);
> +	mmap_read_lock(current->mm);
>  
> -	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
> -	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
> +	if (vm_account_pinned(&umem->vm_account, num_pages)) {
>  		rv = -ENOMEM;
>  		goto out_sem_up;
>  	}
> @@ -429,7 +422,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  				goto out_sem_up;
>  
>  			umem->num_pages += rv;
> -			atomic64_add(rv, &mm_s->pinned_vm);

Also fixes the race bug

Jason
