Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5ED69E658
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjBURv3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjBURv2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:51:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A632ED78;
        Tue, 21 Feb 2023 09:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McMNpgzGNJdocKCpDAOLho/m9/k4biVjAh/0BHttlDfA78wi8N69XlfV7AExFZlFBU5nBXttlyQVKu+6Bit9KAuPKqU3fAwnB2H3VNrEaF69jfQ6sliHCBo74bjuidJjNoKQWohgU+fmJxpwKlxc6mPgHCQJV6bmLDZQKw2lHistdsoaKfQ0WV4SueSrp3zNun9wSFcrD5e4mwbkQOg8ukQddbjFqsL2ei7FAYaxX8oG1fVtGkDz4vAvZBsa8WRJju8KH0m5HAF7NpEMQeH1IVev1jraS16W525fm6uYvC5eGUMyNWLpU+LFXC/r0ttK1JgSS3bYxtnHUMLO51hcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfsPA5ydF9JSAYHxDEO2XlmhJB5FFetsi9LZA1Lbr0A=;
 b=BWJxoUSZ6xCt74dr3klqsOb6waeDih1OeH8a7II/dyOcEVD2gtaQ5Sf8Pm3z8+Qey3LglloxCemyb6b1RHtVydinJMKmp/NRkxbnQQcEoRft+v5oaI5i4RoShf/lROcBaD6R42dCY+EqyOFSqWEBL2YHJ+goHxw+t3oWudxf39WLEUAPrdj3w4Jc7Tk48GmwQ2ICBqEcZUAH/pqXr9lHg9guqHQJYolD7DqMcx8StqgT6WFBUeiOH1TZ4K4BT5/bJ0Uwp69PE+vu9Lhmr8OKjLp9+4XIWzgNBbXHnO63HBAO8OwrSpKXAtZZsFAt9PIO23kFR/Q4ioKQSa/mKg1Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfsPA5ydF9JSAYHxDEO2XlmhJB5FFetsi9LZA1Lbr0A=;
 b=gLKYzJNG53oPf6n9IcMdkdK58kNvECq+/1LpO9BTcXcB8r939w50XFMzMSshDC7dwiPGqbtvskfWAErXvW7JQhux3x21jH3D72Gp1Y3/wz36UQmQZfw5LD9/aOGAY5+Q3OKb93K2vS42gBS8SPlM2lDgi6Au2mfIRwgZKxdpNLN7mVtie6NnhkGgISfWvZmdWlo7l3YpyfqzJYx/v52oEvx1AEqITBNJw6Wz65DLnvkdqVTPRsosmINqCB+kKcSnZV/uHO7c4MFjGQHzxZ0/MdiqvB+d8Vid26ppJqpcrUEZacOFjDxoSTbB8354e+hQyoYbXDw8GtbJLK+e5iUY+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 17:51:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 17:51:14 +0000
Date:   Tue, 21 Feb 2023 13:51:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/UEkNn0O65Pfi4e@nvidia.com>
References: <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a87e99-ebce-427d-cf13-08db14343993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/sOPIqDSERu1SM0e/bOPA138NGTMv9AC7ZN/xtLZCkm8H0BsVJ3TLUUHcDodMo1JATZGPUr3MOHxdN8Q8pN5gDwY7pYlVnT189Vwdcorf5z61hRdx6gnJjh14YU0rt2vgGrD6hMra0R+bkIpwaxzbkabgfTw7fl5WZz/6uDCUCx1vMq2KiBo+E+e4FRU9gIoC0JNR1NMUO2o9BGY20jyNLt9HNwe8RHJe7EhFFxrLWVym+1GcZdLrInUVb1OC5axBfuizvaLUbpopjU7S2HfrMpxmrCnEF+UtHUaobx4mN0IshC1+fbsHucWnuSpVVoYsGCtESAoQHwHEIQJbgC/5rC2M9ZkjNuoAYQHDwhSzTHP6iDYrV33R1JJz3QZXrCS2z8RTPXygjxEFnz0ycbl7e/OKNMMhts6L+yEZhFX4uyuMp4RgEZoX1OyBNKHdhcrkdaI707Fl6REqINfrfR1pduwnNwTqzlBCfLqhkwfJhYkuQ7XUExTOFY7Eg8ntbCJN89BFvjO8cD3+TM3wz7Lc9a03uSVv0ooW9HkvUBDQGn0hsItandgSmJlJl46CWN4tH+yFvWrYdugQqoy48NusRDiUfvZ5uMcp530Vl6xm+qWOl7bGMP31co1dq9JKUoQFd0RBke8xrnTNb1D5omTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(83380400001)(66556008)(26005)(478600001)(316002)(4326008)(6916009)(66946007)(66476007)(6506007)(8676002)(186003)(6512007)(36756003)(86362001)(38100700002)(7416002)(6486002)(2906002)(41300700001)(8936002)(5660300002)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lf4EcomXGO5nzT5kRqJS1/g3RIvOTcpsIzQrVvVqZ9iRE5fuLo+ITv0zhFGe?=
 =?us-ascii?Q?CKTb1ITjQxey/oxawmAdbBYejbA4c9YVuH9hD+nx5bA5Hk55v1XHPdnI+sJK?=
 =?us-ascii?Q?0hoNTnD/HAH3iuJs7vDnAxACJgLFYRlI2+98yanX9blZm/u2r8Eltrs1fMjc?=
 =?us-ascii?Q?JDhJVI9N9UZnDeGOCdwx8dOf8c2suErbGzw1YyxniBhqUtLRhF6hWOiuMsDS?=
 =?us-ascii?Q?NaUOKfTOnwbNaQwM/+GUlzaXUpgSezcmmx6zdEcX/Gfsyaa/SWI+0tE+HH07?=
 =?us-ascii?Q?byu7FldYiQdvMnJCwBMWQV0U3Mo0gPWofYXoBSWQp7f6uIvqf1kWjdvPCVD/?=
 =?us-ascii?Q?+qJ571hn0oMrFGgKlIdKuI+SGM2K62RdQAY3StuF/RfoVDqFUmN5vzEgIo3F?=
 =?us-ascii?Q?fgTAv2f5nijDJUEJY6kdRRCNmfvM0q8ATRx/4WPfyB5LalDga4pboJzsOF+D?=
 =?us-ascii?Q?Azt31uKDdkr6tG3JJErSQPymaD6xbLSJPtobXJ8pnoNcidDEZ2/RM4GWWnSR?=
 =?us-ascii?Q?v7EAnzQK5vBtu9/6EogB5d84+Z75m3YUhMpqjAAGW/f2L27kZvDIruUGyvTp?=
 =?us-ascii?Q?Q5h5tLXcBOUt1kpnRNVBOwgH9x5teZ9cr6p80wQIy8uPF//vXw5cy6TWIyTs?=
 =?us-ascii?Q?/Uy+pzI+XoKo8PwWgJYm221YnNl1DHGt2IV1K7K1ZRimO29apCw7Fi7Jq1T/?=
 =?us-ascii?Q?dzfmhkYAr331ZQYH3TvcHwxL/zGgUcpPYJOBNaGmTpqUIh9nt9kSaxcrTI74?=
 =?us-ascii?Q?Qv7Lox5inOz9/44Z7m4uQtnw8F7lqtzLAfH09YiklxVQFip51A6YnuEhnyOQ?=
 =?us-ascii?Q?lgWSCtPyNNKqx8i9M9IjSiaT8Vq4dgTyIcmmCWGWnYYRfrOr5AsyRw8yJMPr?=
 =?us-ascii?Q?+G79XDRDkB/GKh7GTlvl1ZfShBaUBa5tqXC8R5yCzqwBFRjclPcId7+fNYfE?=
 =?us-ascii?Q?Q4MkKTKzN/OXI4bfxTUdl7s0+Ra91th0yAXLpXlV+H/73RL0uob7ScJV3uoW?=
 =?us-ascii?Q?Oy6BAUPotMrZnFCDtEuyo3cNkEkpZ3qqZhTKdAXYR41uWn+vyZzBJLVkhb71?=
 =?us-ascii?Q?Eb/LydiX+fLMjvhtlY/3ZB7yxgvCetSB6c88fR25KFU+LK0Xmg/vGUzQ2c9J?=
 =?us-ascii?Q?85VkfbQ6xjwco2nKNng9SP9j2wDuwZmtt3ILG/EJyf60aOeHa05cNi8Uqutf?=
 =?us-ascii?Q?65Lp3x5dQCDitMDfGhTmRWQX25aasVTjaVp8+U2A4pm/AGqoTJvmgPX+UC7A?=
 =?us-ascii?Q?hWDXrQOwEmGNU6I08hrtiFFn4X6ypand9yuPTabdx8722oRB+Z+eijhNVQAg?=
 =?us-ascii?Q?WrUOZYho4Wj4/nUCcWfAl8XnxmfSdU0s0WxWCldO4TnKj0v9AkSU1uTd7oZg?=
 =?us-ascii?Q?PYYXBSXMDbDQCC3lpYPqVfk/pZknVabp2SP2K65ytgJ/MMaSGAHi5nu50yNc?=
 =?us-ascii?Q?DbEk9oBqLm61b5xsG0Htf16FKkvs272dlQd/IgKrz0hvRRlAIGENab+OP4Gs?=
 =?us-ascii?Q?tlfYRKha9Ueq/vtRbqMnNnGlT7VI5P8WG98u1XIy8UEz8L20QcwBMmuUmKma?=
 =?us-ascii?Q?t6rA06XF5mblAo2j5wmVTsX65ghVECucz4Z3C0R0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a87e99-ebce-427d-cf13-08db14343993
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 17:51:14.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ68VzYnEnQBD9EPJBqsYYC6Wy2UvKvSUi0y6+6fxRl+68c9+nMigxUKu5T1TPKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 07:29:18AM -1000, Tejun Heo wrote:
> On Tue, Feb 21, 2023 at 01:25:59PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 21, 2023 at 06:51:48AM -1000, Tejun Heo wrote:
> > > cgroup, right? It makes little sense to me to separate the owner of the
> > > memory page and the pinner of it. They should be one and the same.
> > 
> > The owner and pinner are not always the same entity or we could just
> > use the page's cgroup.
> 
> Yeah, so, what I'm trying to say is that that might be the source of the
> problem. Is the current page ownership attribution correct 

It should be correct.

This mechanism is driven by pin_user_page(), (as it is the only API
that can actually create a pin) so the cgroup owner of the page is
broadly related to the "owner" of the VMA's inode.

The owner of the pin is the caller of pin_user_page(), which is
initated by some FD/proces that is not necessarily related to the
VMA's inode.

Eg concretely, something like io_uring will do something like:
  buffer = mmap()     <- Charge memcg for the pages
  fd = io_uring_setup(..)
  io_uring_register(fd,xx,buffer,..);   <- Charge the pincg for the pin

If mmap is a private anonymous VMA created by the same process then it
is likely the pages will have the same cgroup as io_uring_register and
the FD.

Otherwise the page cgroup is unconstrained. MAP_SHARED mappings will
have the page cgroup point at whatever cgroup was first to allocate
the page for the VMA's inode.

AFAIK there are few real use cases to establish a pin on MAP_SHARED
mappings outside your cgroup. However, it is possible, the APIs allow
it, and for security sandbox purposes we can't allow a process inside
a cgroup to triger a charge on a different cgroup. That breaks the
sandbox goal.

If memcg could support multiple owners then it would be logical that
the pinner would be one of the memcg owners.

> for whatever reason is determining the pinning ownership or should the page
> ownership be attributed the same way too? If they indeed need to differ,
> that probably would need pretty strong justifications.

It is inherent to how pin_user_pages() works. It is an API that
establishs pins on existing pages. There is nothing about it that says
who the page's memcg owner is.

I don't think we can do anything about this without breaking things.

Jason
