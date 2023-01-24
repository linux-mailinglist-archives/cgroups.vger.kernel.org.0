Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71C679C2E
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjAXOlg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjAXOld (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 09:41:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBA49550;
        Tue, 24 Jan 2023 06:41:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC91cz6zV3Z9WYk7aPGNBspp8pD+ugRtmBpGnMHB93kCEBvfOCStKka26m72qraj7Py5eHbRyizBB9Zs+mr+K4eB6Rkbvx1Y9ZZTX5MGJwogYYW4R38GvFGQYreQQIpcpu8PhTHPECXhp4L+pDT6I0lI/2CQu65k+iANQuNH5NyrzlUNt3LLngOmSOsk0Fbyn+drNCHg1B2Fk2zx1/Wr+FXkuz+4UkD6XkJlpS1MPJ/Kx7dQQMaWFNEZl/oF0odtFDTqBJvaXZaeXGavmRaCFXOAdFGbQaJ3Tht572K+A6PJbcDZGpofSvXz32mVgxOk3Npzqj5t/guWWYl7LNb5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywtsCLu+RvrSzqntvW+kqIVqxdEncdFU1vtcnEF3TRQ=;
 b=OAY5Xmk4DsxJkstrb+cjY/zwhzQBVcvdelAMXUOezTm2ZgydfGYOEv+idW8MOH1vn2RXOpAZ6/wppm30F0yzw9PCy9XjxMl91+IhG9WimOfrnv+Xo9wZfILIN92v5yJ37izj8z86+WyD0P8mXAYr7vti8w6e8GJdPZoLE+bTfrtppuot6GotlnhWRcmzGLXx9LwFY2YPVoGP55sr6ZH17FDG6+PLI5DL2l608zjanCLB2S9fy+HrllT+KbY5rPld6Pl1fUYOcZ1a/qmUfotEz3s53inGKzwMApVZGqrLFlwC9b3Bszi19wUfgVxMB/Wqey+zr76r4Q7c3Jlgr2+6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywtsCLu+RvrSzqntvW+kqIVqxdEncdFU1vtcnEF3TRQ=;
 b=czhv9+m+4tZFRqqvaTO9pz+tjvg/KrN/fxDdGq/COZrao6LzGW2f6kNi3Ak17UuprxKwLj9C74ru1Chj+d2E1ee/UYYUQv2bd9svCQsM6nV+8YPyCc4hLGJ7Cu8/wVk4GU5TT7y3x4Wf+yHO6nKjbLqVRNQAkiDzqmXvT4j3qh6tcLFrBvJRAta8ejhSQ98rqBUsUSu0MAZWcxC60OcA819P0hUNuzZsFGCSUUV4/jMV6c55PNKj01/Fa7cMMuBDty8Qv7mhfYdOSyM8+B5jAJF2UjMy1e2vDUrJr4yG6/W5bmYbYuS3RFfDmvARB74U9RlsFPnXWmV7mA+vZhsRYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:41:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:41:29 +0000
Date:   Tue, 24 Jan 2023 10:41:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 06/19] RDMA/usnic: convert to use vm_account
Message-ID: <Y8/uGL+TA7ow4Zmu@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <03ed2d166826cd7055810c66a175e20fa2153c52.1674538665.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ed2d166826cd7055810c66a175e20fa2153c52.1674538665.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:208:178::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a20138-2937-44af-6be0-08dafe1913fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCFdTYdJSffP/abnNYMYlIbw+9ZVi3WT0+TFjUzL+iC3wZSkOfQuf+0GO33jjl29T6R/SjcbZ+qmXCn4GTXAnTjy+O8C5HgAst69o99Pgz7Crq3aRBtnRliPNuOvDkiGPLSUagxjn5xtjL6TC88SXYQq/MkCU6hkVnbTuK/1gelBI74dUJoPLDmv8DduAEca5FdvqdsnGEg+8DNiLW33OfX3bIVMVmym3hSN4/5NVkFcGkCJQYaopWbO9/vkKfQLYx+hDa8OqxvdAeaWrZvguhKWVE+uNVsgJtLBmWXdeedNTuDTSRM43iVw6OLe7vl5WP1GlHw7Q0pX7qaygv9LuhyqhiET5j4nLPjbpmMNCTtULLMdtOjIHTs6n56yjsQmtWVncsTN0ydx2xQss4QiJgB6TDYi/pm3Btch1zLNzm7HAUHMKrXjFblCMqBrn+SzoSkB0R3+B8ncTFF4yrGE4hSuZ+71NpK3WWnTs8+MjygFY8xumonclp/lW5SyiP76s76lwzhbajUDxfOo03dUZqXsNmiqdmwGSe9IfX+u/mETFw69R9pVvCtHvWQmRF9ouni4TBRCnQ04fthmGbo5Nx2dy0MuGUqO9KyJgOKN/RLVk4IXiQyI4DpELsmuFnXWfnDFq2p/q2TEc0DXxUWuTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(54906003)(2906002)(66476007)(6486002)(4326008)(66556008)(8676002)(2616005)(37006003)(5660300002)(6512007)(7416002)(8936002)(6862004)(26005)(41300700001)(186003)(6506007)(66946007)(83380400001)(38100700002)(316002)(478600001)(6636002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYxYE4MVFfZUfhz6HQeV/K+4L1TejtqI/CWsU/t5iW/ztdkW1uoNXFxmgFjK?=
 =?us-ascii?Q?AyYDyNkEv0ZhakGaYA4sJiye0BonykOJUjLWYbS+DBU+6l4wsckxPrdIavFH?=
 =?us-ascii?Q?2ceV4Q1b9G3X9Tw4oXLupafdMRsL9ciJeievDPEWf1EnxXXwysMX6P9HPEYB?=
 =?us-ascii?Q?nhxrnrZfSCrYyWXMyTxZKmp0gsNjQHhsSPGldqbX83XBdqtAh+ESwuJoSngJ?=
 =?us-ascii?Q?76p9XtormxRndwFF2OAaOdidJ0jfEcT1y/4tYZVnVefUhpt9q4dgfam1VJ1I?=
 =?us-ascii?Q?ZGe3958jvuiejXO2hXteR0465gVXh649YIpqZOrMh3ILc3nkCFPAghPOTOLc?=
 =?us-ascii?Q?5J3RXWU+FDnsEVzTBcTrmd/9fh+huVGmjjXJ8BuFB0Zu6x4ivESHLo5Vjkay?=
 =?us-ascii?Q?eXi4Mo01jf/g8Yxd8XeoLZExVvs/3yNMU+rf2FXYDdawMrREccDrO7WxSel8?=
 =?us-ascii?Q?nuvFrxx4z14NqGPwudvfZFws+2yBS5dnUUcYofgYddYxH4MmX3mbwfYW4Agr?=
 =?us-ascii?Q?biygpKyxlUZqag1eE8mve8JMe42IXJRjBhQoqhdGlk7No8h8aE/gH4KEwUQt?=
 =?us-ascii?Q?QmP/kZLB7zgyQQNsDWQdgyRWx1w9ML5MH1IvM7Pek8ophVh+v9c7IeZs5+XN?=
 =?us-ascii?Q?RCv3VKDR+5UqVEPNFbFzW+571JUbARqq7mRJuQMuW2aaiuJ047wFSl6IHb9I?=
 =?us-ascii?Q?0D6Dhkd/+ydFCqqMibpKcKuxWXk/k1Yldy/agDrGD5l8FdsSN3uC4TI0fnLx?=
 =?us-ascii?Q?eZRw2pjdDqsyJ4D/J0lAeonyLahm4kftqFjqIC4d53h6BkmWJ8W9kGVvjxBS?=
 =?us-ascii?Q?TR/G99LAkT0iq4L5bwnYcviNoHfhc1QMPscqMw24TMDCpbg8khjFtzgwG7ZJ?=
 =?us-ascii?Q?alp/DZYcAgTwTPbVbe+bvua4IXALFJ59tfYMJGXKzg7ElBG2k6EXGlUCxVff?=
 =?us-ascii?Q?Z9fXOuo1GMYE8ByFUeSi3sF/1N6TRQwRylZ16p/l2pZuodcdm+RZQRv4Jrvs?=
 =?us-ascii?Q?1lLQNKmUKGBf0E3nIaOIbnfrvu9NGkT/wEnLl9yaM/G3iQbgYUPd7VgLM/2b?=
 =?us-ascii?Q?AOonnWB5VdX3mWkRgjX0nM6ry7xWQH/1ZvQoARtGSvbf1X3qiF1t8ii9UtVO?=
 =?us-ascii?Q?Ppkru0jD99z6/6w6Tbhxz71QJfWEae0pSmFZR5pKKffjnsgLsPNrMZgxczW5?=
 =?us-ascii?Q?r1vVRIrzbCGGdjSVi2lWpjaPFYXrqpFzkDFIE94bymV5olDL2hJFd28PiVij?=
 =?us-ascii?Q?1Z/Ko/3ubXZlVlljVhSwZS3ut3XLYHajw7jq8WGqqAMtbW5Wucch5FooALd9?=
 =?us-ascii?Q?PvwtXBV7eRA292l18bTtGwDyRY4YOPsQwUEjexZLbhI4MYA6/kygyQz86Yqf?=
 =?us-ascii?Q?wMLyiX8XCHVwtkRIxylxCZzHVC7henlL6NqqDwEnsiYBkR/0he5OhJPjGUTl?=
 =?us-ascii?Q?ypdRIrRMUhukWqGUztBNHEjWqW0RKkRvclCtYvsIKiIdHUdccut0ZDRw08cb?=
 =?us-ascii?Q?bwGoxB7beNTYzFvQ3CodDX2B/XRrLOukhAo0mD0sRcTY4MMMUcE9dzgQGOKV?=
 =?us-ascii?Q?msePoMZ1znk3dajlrhmSyiTSxPazO8c4SArdfnxY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a20138-2937-44af-6be0-08dafe1913fc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:41:29.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptw+XL35iN6kXublrCFnBFlKf38ALQ8ITH30j7Cpz2s+PGZ20mYwNjS1MV+70tUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:35PM +1100, Alistair Popple wrote:
> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
> index c301b3b..250276e 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -89,8 +89,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  	struct page **page_list;
>  	struct scatterlist *sg;
>  	struct usnic_uiom_chunk *chunk;
> -	unsigned long locked;
> -	unsigned long lock_limit;
>  	unsigned long cur_base;
>  	unsigned long npages;
>  	int ret;
> @@ -123,10 +121,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  	uiomr->owning_mm = mm = current->mm;
>  	mmap_read_lock(mm);
>  
> -	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
> -	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
> +	vm_account_init_current(&uiomr->vm_account);
> +	if (vm_account_pinned(&uiomr->vm_account, npages)) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}

Is this error handling right? This driver tried to avoid the race by
using atomic64_add_return() but it means that the out label undoes the add:


> @@ -178,7 +174,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  out:
>  	if (ret < 0) {
>  		usnic_uiom_put_pages(chunk_list, 0);
> -		atomic64_sub(npages, &current->mm->pinned_vm);

Here

> +		vm_unaccount_pinned(&uiomr->vm_account, npages);
> +		vm_account_release(&uiomr->vm_account);

But with the new API we shouldn't call vm_unaccount_pinned() if
vm_account_pinned() doesn't succeed?

Jason
