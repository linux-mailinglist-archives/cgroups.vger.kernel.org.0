Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84728680C11
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjA3LgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 06:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3LgP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 06:36:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C43AB4;
        Mon, 30 Jan 2023 03:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFYxqSY+OrbBB0qdfTxxyZ6SSw9LCqdXCgHHI/N3tzZ8papnnqckm1LyCAHqrDGmmVyGuB22UOT/xQyoqbKPgIwgfhZUnxmx9WreqDd8EPjSa8ZfqvTc/8mQJQ8DDnHLYLcJMl6YukBWSA4ubsCpNOtvSckrEEgzbFA0/8P4U9UmcA6bjpBmaXAp4jTh/c677z8ZR6VM7Gvru99sDmB25JZb1EEPfoQtaR5wrJALqiw9UGlJSbEdamkRSaznspEZzd9AClh+3sSjNhJbEb1qwMdiEPE92fC5R1Qaq4qqBHobZKcaOn5VgTjQrIzGLnr/so7v+YBlIqrfIee0XU3reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIiPdkfZ/fZE2PAtlhpufWZGeI6OlvxeJR6i/u8E6ZE=;
 b=L7nGwiU0yf+gEVaV9lOUMSZuydguua8HOQ4FjKh7dk7n5dSv+ZGU3dCclAT0uz2VWss+aBz1UwvzCGFQF9mKkJu8W15bhNrIzsU9mLhTk3KZYlkZpOIZ/klPlnjNIsp+GnSi53qm1BGCQnxzAI6CAaJFdQZB5bw353gDMCzim8KIPgZznk5w8R/zcQNSHpNv6ZSiqYHqkju10kmnoB7olrKGATlZ95L8iOAOtbCTYcQxM3AIJefQjD0C/J3XthN9BH9SgoVaK1d8821Et8PDC0dYzeoTR1s0zRHsUT5yX5LHAgW0boPCBmrQCJdOwqCMHjT4oj1HD6VS1fF8wVb/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIiPdkfZ/fZE2PAtlhpufWZGeI6OlvxeJR6i/u8E6ZE=;
 b=IKmcfYZIzTzE+FOa9C3ZcvcOQ5+xrQCUSqHncijXIwvBmirsKytj0A7M/kwsE7d/H/D19ZWtknuMw8Zcn6PeNfD4aQOeqkZVRtX/5fxpsayNRTWOq3QcRb4abf3aI7FogIC0ECl984cN6FLW06FSxKS1A53E6zVpuPRFfOV2f5TblTaswez8dsHlGu2Z8JeSVOc+pyQynxbv2BVY0xQnqq8qN9xrx2lz+SqrBor/sYenCC3RLXJXWElmoXlGiYyijpHLNKUEo33AUSsVhgLbrxtj/J6ubVFc1SdJ9lmNjlQe80TlXgDRtMZ5H6r5XFDoB4kiNV/vAI7X8/BxsOl/2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 11:36:12 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 11:36:12 +0000
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
 <Y8/tGIeg5mI9bDOa@nvidia.com>
 <SA0PR15MB3919F0CCF1D878DE8B243B0199C99@SA0PR15MB3919.namprd15.prod.outlook.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
Date:   Mon, 30 Jan 2023 22:34:50 +1100
In-reply-to: <SA0PR15MB3919F0CCF1D878DE8B243B0199C99@SA0PR15MB3919.namprd15.prod.outlook.com>
Message-ID: <87lelkz23e.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0096.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c58427c-5a16-4fed-e146-08db02b6306c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXgfrjh0f9stgD0aR78zVAg3Y4wQW2zDICgg4FHoK4MVjIKs71nXxUy3npUte3LmzkDDGRIOwEjdyHL5iKmpX3l2emZl41d4lKyHHfMXrCL6nhdJnA6rV7i90JWqejLSsngWxmfMbzOet6yaybz2mnIQsUIDLZS2eQmtXSYY/7GTXKrwjhoebNLZW0fodwMOKKHLzDQUCl2Wa9DqP0spFKrR/rwR9Ji0t5a4s3dhoJGOwVeF9SQMZnbDsIcsBLcJ5ZY17DkuNw3P5Q/OGyFH+ysBiuX6u7JoMrR6Kqet5glmtkiMEMNB+eWv0Kn2M5P6imQeSNEaD31woYtt9/KoAvYJq+4rn9nPyb0eHjV5dWbYkyW5vGwvHmVdslEN3zEb+JztRZeEbdVV3D2uPeu/GCfdcRmN7yWLWe/YQYhniw3H1KYfjy1JBQxCCiOH9XhLiDQF2PR2WneeKkjLG7MB4eu2Nm4Dj2p+O3vFSxskD0veTvNFFa0zOiqgcqYcBH3CBpsZ4vkYhcaMMLyxwWuoRL5vkuoK+I2IhnZGwWYWW8vpfTAoQagFSJulwUIIzAak6z01q0mR6jeUUWwchPziPBEcgcHip7nEeBDfcoGYgSQs0+eVZdJKHNgFxAt3gc57p7eSs0cmCl3LGjkj/8E0LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(41300700001)(38100700002)(86362001)(54906003)(8936002)(7416002)(5660300002)(316002)(2616005)(36756003)(2906002)(83380400001)(53546011)(6506007)(6486002)(6512007)(6916009)(4326008)(26005)(478600001)(186003)(6666004)(66476007)(66556008)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ny/smdHJMuFK+nvuNNyX5LrDyB8sHIgTNntb0rrU9xQS1kCPAsCf609Nh8vU?=
 =?us-ascii?Q?x8rrgs2YHRo+Tw5zq0WmsFHlZ8k+2agxsZWDJdSQhULRjwNgI+YCojuuR9Ci?=
 =?us-ascii?Q?Vmg/qOSrCa/yZA8lt5rzu0iOB2NNQISGrWuUHsihPktZ91P4/m55VeG8MYzW?=
 =?us-ascii?Q?9TWyD3GEyxLgrgM2NuhO6lQTkicaGEtMj8a4P41Brzuom55M+AMF82udc8PG?=
 =?us-ascii?Q?hRfG2Z90kdmI63Z9K8/OLF2XG6jqUi2oc9LNrqgGZYVhYzxiwOj7KA7YT8ay?=
 =?us-ascii?Q?uYWlbEY2SDRccX7IjOWmjxDuWhq4tgUxtjeD0hfvQA5nPY5Wus8ZidqAmDjB?=
 =?us-ascii?Q?/K5cMn8wCT84ZNGFHv2HSi6H4s/okDH1vY/AlBCm+hJFYwZaL4d15fhd3XLW?=
 =?us-ascii?Q?E8ItGmRWYYPO/ecRfkL2eVzVzwWwFhinoiTuYXXo+u819yfuBPkS/YWl8OJ4?=
 =?us-ascii?Q?OMQlej4jL6KvNF9UzDBqin+me4af6oa3IAO6Sy5PUdD6S9FRn3nDdXlr6/58?=
 =?us-ascii?Q?vFEy9UzAFEyA9IGncMPX3nAa4upZiV3NNxvdUCZj1Fgk5o+voqm/ozWf7ijy?=
 =?us-ascii?Q?atV4R6bumuY1H1AnQbG63/H+vP+VORCd0H1KlyWaHQRKHrz95H4HsUFM4XgJ?=
 =?us-ascii?Q?jsmkYUZrutbl5sjWSu0bNnjPqyGQwRwY9bZtD7nP3wEjFRZzdTmC1FNt4fl1?=
 =?us-ascii?Q?QR/0IOHZ38D4AJDbN3KroJbNV7jeUGb74sEKYbx239PBI1rd7KopA1HalRmI?=
 =?us-ascii?Q?WsUlj/wG76SvsqoomivkOOtow4MSfdfjuvAKxg8lohrHls07Fb3EWwb9OA/7?=
 =?us-ascii?Q?2EW26cbCQmxnwxhweFZ9B7/Yxm2DYLmzePV+dA6PAs8/79ZMGpVSS+6AuzBy?=
 =?us-ascii?Q?4qJq47TEcTKCjSxEoscLl2Zhu4iXBq8k2gU8n6Hbn+5ZgOT1K7woglZY+Vib?=
 =?us-ascii?Q?qjPjvgSjCagUUwFgCWrhBD4AwM59WwZAELe1llNesWonIsfO8TrRWreewjJ1?=
 =?us-ascii?Q?TSv+C/ZhWdQU7mcgxdQHByjgqdLqYCVZ4O4B3fKlaI1CX/hGZp1mDZJseg14?=
 =?us-ascii?Q?lJqp1m/QGkD0PN/pM5RyuELCVZgHiObPXF8YM6D1Q1jclwREB1TXqlB4qYDp?=
 =?us-ascii?Q?+iiSNZRt+nDM7MNayL0pEeaJGErBAkZcU4LFkx3oa6vjKGJ2uSTqxcGmpamK?=
 =?us-ascii?Q?ZCgGJ0qLKFzWBOlqzzQlp2JBMPkDNaiMx90LgTKf63PlyN8PVkNf963mauqS?=
 =?us-ascii?Q?txaDs3RttzxoMgbD9pSBBcwUExVAncmV/jQckD+bIvHr8zJpfQGUh1B2IM4Z?=
 =?us-ascii?Q?gqoWia9boUwk1VFJpoaItIepnVpAyK3ml8afiijp0+xcKfc42VRNfVg/xfzK?=
 =?us-ascii?Q?cApVYbP681+0PgTeHnbx2rLwyl88oAJBErcZTfiUEBtih6Z4/i6VodilqW3D?=
 =?us-ascii?Q?YDX9wTOPKXd6LBLOay0aDILuPFF7K98mbBv7BcN0NCpTcsiKJzo79qHh+5Lt?=
 =?us-ascii?Q?siSpkBx0vPwiYdlsE0/LUBuF1MfBpz/uJFSOYi4M18N2yRcCNK4K+L7CcPlT?=
 =?us-ascii?Q?lYO5McCSzxaQimdA46DQsx7adldnmvCPo2JQEBR5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c58427c-5a16-4fed-e146-08db02b6306c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 11:36:12.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQjdkUOlO9LmFpQKEhaNwWuyd2zyZsG/8qA6pNnjwTAnnY4uCtNcmjB0dFZRHiAzgumUo2M5ZWGRworOeUJDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Bernard Metzler <BMT@zurich.ibm.com> writes:

>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Tuesday, 24 January 2023 15:37
>> To: Alistair Popple <apopple@nvidia.com>
>> Cc: linux-mm@kvack.org; cgroups@vger.kernel.org; linux-
>> kernel@vger.kernel.org; jhubbard@nvidia.com; tjmercier@google.com;
>> hannes@cmpxchg.org; surenb@google.com; mkoutny@suse.com; daniel@ffwll.ch;
>> Bernard Metzler <BMT@zurich.ibm.com>; Leon Romanovsky <leon@kernel.org>;
>> linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] Re: [RFC PATCH 05/19] RMDA/siw: Convert to use
>> vm_account
>> 
>> On Tue, Jan 24, 2023 at 04:42:34PM +1100, Alistair Popple wrote:
>> 
>> > @@ -385,20 +382,16 @@ struct siw_umem *siw_umem_get(u64 start, u64 len,
>> bool writable)
>> >  	if (!umem)
>> >  		return ERR_PTR(-ENOMEM);
>> >
>> > -	mm_s = current->mm;
>> > -	umem->owning_mm = mm_s;
>> >  	umem->writable = writable;
>> >
>> > -	mmgrab(mm_s);
>> > +	vm_account_init_current(&umem->vm_account);
>> >
>> >  	if (writable)
>> >  		foll_flags |= FOLL_WRITE;
>> >
>> > -	mmap_read_lock(mm_s);
>> > +	mmap_read_lock(current->mm);
>> >
>> > -	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> > -
>> > -	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
>> > +	if (vm_account_pinned(&umem->vm_account, num_pages)) {
>> >  		rv = -ENOMEM;
>> >  		goto out_sem_up;
>> >  	}
>> > @@ -429,7 +422,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len,
>> bool writable)
>> >  				goto out_sem_up;
>> >
>> >  			umem->num_pages += rv;
>> > -			atomic64_add(rv, &mm_s->pinned_vm);
>> 
>> Also fixes the race bug
>
> But introduces another one. In that loop, umem->num_pages keeps the
> number of pages currently pinned, not the target number. The current
> patch uses that umem->num_pages to call vm_unaccount_pinned() in
> siw_umem_release(). Bailing out before all pages are pinned would
> mess up that accounting during release. Maybe introduce another
> parameter to siw_umem_release(), or better have another umem member
> 'umem->num_pages_accounted' for correct accounting during release.

Yes, I see the problem thanks for pointing it out. Will fix for the next
version.

> Bernard.
>> 
>> Jason

