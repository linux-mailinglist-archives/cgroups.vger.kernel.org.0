Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9536F0E3
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhD2UFW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 16:05:22 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:9024
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229960AbhD2UFV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Apr 2021 16:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knyBiq1DbNPQY/clRZTIDwEcEqns5lCgAU7HC9tyc1EULHeC9OPjBrIRYPccEeKSAbsw9YvXWFGlOSpGLy3skaqBO6Be82m8tUjR8WtlsAgOxhnphjaULzF0iLhyS9wS6JcKag010IjJMUm3bJoupQNs25/nQZxxapvi3P/1as/YGVk54weXwnWxvMSTfTbcZ2492POr/M/wpp7OlSN87axeDvhzgH12z+nXvXFbzGUb/y61ygXnwWTraaa7IvwuVHGSIyTVxAkDgskQv90Z+dRnXzV1RZUsoAw+VMGd8Mkqn7NGMBItdzYAbZlU60/JF88/uj6glGmK+ReSqzYMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkpaYP+cv8dFl3WE35NrNGEXUKYkXY9KrkKcooFcmuw=;
 b=cW7LzmAo2ccrct/fPh2BMr7VEa9nGi/WVXe5yoWvWeiEOwxXfVnJmCJkzFGdj4MR5l4huWwCTGFkVg+DOct/dz9tgTvZH7hY+m6JL5x+h/9ufxZNv5RCvO0AK1yVzmDfKLdv1zv86Q/qAkvg/Dvrs6xirdIep6Ah7xyUGcthHcpxZP2UwnV9y88VDgOUNtyPmifbR5/2g7KRwVPbnA7Yhhvx9fNAfbzThxQ4PSNz1NNmvGVG1ZBRFNfybUUICGkdkip7A8Va3bKuEW0Dnfu1otUAGJPOf6kFxtNsrCfDaV7guDmi5tTuOkJ13XCrTBcb7gwOA0kYJDqP2cxoc3KeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkpaYP+cv8dFl3WE35NrNGEXUKYkXY9KrkKcooFcmuw=;
 b=nj8960sLdZFZGF/WBWTEOSKbbmdMUc4/CSoTPhJkq38wCvool8bZj2Wq5M7E27g3fJdJBtqbXsM/i0yaU8C8ES/4fT9YbLRY5HNQNxg3UOx4F2SahPAffnvhIxc2WsdqQeCs1WvIs43vPcSAv6qLeR/gf6sjqrGZofsc029wHqNczkMIsYKKZDgo2wf/T/tMzLuXSPLF1Tjl2KKB6MLeUEQf1W8cUbdv/sePqiYpqfFPB6UjKkWWUklVIHuljcoFino/sc4W7cDPWhdCp6sM8LhL8lQW28tOYvJc96b2cgbSFxTl9Whj1+nMrZ/dKsBunJP3HnT3pwzXlkYTIuYSmg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Thu, 29 Apr
 2021 20:04:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 20:04:33 +0000
Date:   Thu, 29 Apr 2021 17:04:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210429200431.GA1370958@nvidia.com>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <6e36797c-799e-074d-f66f-5686a4b37f38@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e36797c-799e-074d-f66f-5686a4b37f38@redhat.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 20:04:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lcCtj-00ERff-1Y; Thu, 29 Apr 2021 17:04:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63da23eb-0dd1-4530-5c6e-08d90b4a0175
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB286035A8DEF1B47F53DE055CC25F9@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5clwQyNUR142L1jNpKWveC5wkmTmTAWkptqjYvPTu/wZmeXaEEkGGDO14sjc3Sg0+0ecW0h+ZvUYoUjmXiXUqw8KtAFIdbqf6PqKlPUk9UxRM8BkeAiGnWXV3Z/TA2u91kzRKJVPrCWnnsQcVA+iyGPETB8N2YjMciY83+gCoMR4kSCP6w30zIXwMtOzYwBEc3/7sO+FkY7XVKaAD6cNJhEtvYc/CU/VAr7H8zZIG7G5/lpqJsti+SK0qdvXHDZXPsR+36TaRUVwT1NrWPvfFX5vIFZMunHa9e3XUXSBiK/vqI8LDTMu3icWkKExgU3Deo2f20duTHeheW6IjHcATdvd/5Jk+P9spixQvWLSVackMkwij1Vw3b072fLys9IS1zTC8+TEOUR6xsop2OP2WNVokwA2WcfqPPL+k5WV8Wq6sJrWnZ9W9ThM5I1SrBGXIoH4OS8VUJzoB5bJbymqyIPicLfTMALs32texAEC1YqUCG5VQagLFuAKyYJDJrHCokUo4gUco0TmzZNiGlyCCPFVw0UQlC+GPmWqTtk81PwEJMEC8j7zS55EeDtV7VC030wL0VYJgDR5aFbXAVnzjBw6XvHa5qnjKVCxHUNa0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(83380400001)(7416002)(186003)(426003)(66556008)(8936002)(5660300002)(38100700002)(2616005)(26005)(86362001)(8676002)(66476007)(66946007)(6916009)(36756003)(9746002)(1076003)(4326008)(9786002)(316002)(54906003)(2906002)(33656002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JLk7POIkjGuCmNaTzIjv4iA+yxy0BDRGyhFI4QONT6rBNawQB3KsSeHW1B3A?=
 =?us-ascii?Q?IqF+5nOTt2FtRgsqC9EBX+d6jXFMrKVgoLJPmJIrThlgKfX5z1f9RH+VL9lj?=
 =?us-ascii?Q?y+RIxdmkMu+PKriOmJgm9yqWVHJ6tRJLOQOpUVduFVZdby3BI6A7FIK3alSH?=
 =?us-ascii?Q?BUBVPLIkbfaxICq2BuvmG4p3iB+fD+VpZ0FdQGRKVqhB30pdTXnLqUi00zS7?=
 =?us-ascii?Q?AK5Y+yfniURK79ngU9K9JoH6Kzcb7lZn21hTYhfmPqVbsHUpPHPfvJ1Or4DO?=
 =?us-ascii?Q?SCuTYpVLeLIXfAVQFZqp7iQc3lpcUTaP52RRnQSafMqoqBneTeJA1EBo8g4Z?=
 =?us-ascii?Q?4I5G6G6XhC05Hm89MGUsKgOybr0LU7pVPspvxGlUJefLvcIkWzdje76X8ol6?=
 =?us-ascii?Q?MX/otdlymBMZB840I1oiZ4dF7UBlkCpq3KBtgCDypnJmeVnvAaF1qkXOzZyW?=
 =?us-ascii?Q?aYQ3zrhoyrTlmWt3sowOm/d+Vg6D3JBekwcT3JvTby9u1QnTNViV4u/6ACqE?=
 =?us-ascii?Q?ymh6EOHFYlxntuvOeL4IQWoFQU5s9aZNdTeIj/PVeZSHM07WTPrEIi27j9lm?=
 =?us-ascii?Q?35URCI2cnhu/CVPPugNVLDm/b/LqSxDOHPVdQ6TDrPFFyKDrTvC85BsUWvvI?=
 =?us-ascii?Q?sEQSatOtba6IsX80ki/XZULZBWiT33C3XiNJjVIl0WNCpyTanM1jMez/Wpe2?=
 =?us-ascii?Q?BWjt0towHgXzXZD8hlL6tnVLkjLqFxZJtV9Mmjs8x9izmOSvSqLKWcuPxx1E?=
 =?us-ascii?Q?z/XQDbtEt9KlOUFYVYDdwM2JjJC+uBeaTE1y4EKpXDhB3rrm/rh4QjfkR/Xh?=
 =?us-ascii?Q?LlvnwQ2os1GFbXoHjgsLDH6v/ZzMS3fOWJp+N27HME/O13utPJEr7yrUeBtj?=
 =?us-ascii?Q?P82MwQld+6dYzGX9ftdNLI9q+W2wkJm82qrQCLfvRDFceuk7UhIHaOfYN/TJ?=
 =?us-ascii?Q?ID6NDyfWByJY/pukH32shudbTiTUErv3UUGksOo2DQwJYFQc1UUdylPvKU9k?=
 =?us-ascii?Q?UW4iz3ANEtgwBtASaWFghd2QI8gJgBwGJKN9ZgdALXDdln6RYfum/TLsbw4g?=
 =?us-ascii?Q?Glqwr4mXQmvjJJjrbOD8HHXPPspnGYvqrmXTrXqInjYP1GUYonV6utYdjEOb?=
 =?us-ascii?Q?+lZXFLWOg7wiVZdj5eJIGEFbgd3fBS9cd0gcAm9dEfUHqUJPX55K1A+LC01R?=
 =?us-ascii?Q?lbgMWfJhuNahsydGVO8Z/aRdnFbBLhv30nF/3nhWYjIAsC+t3/6TKVzQ2OqH?=
 =?us-ascii?Q?K0sccj9lijNVHqYrVt3zVTVWeeeOPa90HDYNliqy3AvLUTTusRzJawnsFH2D?=
 =?us-ascii?Q?D8z9dseabh0OGlIdEoPpWYXI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63da23eb-0dd1-4530-5c6e-08d90b4a0175
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 20:04:33.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/AzkqAFPGSirglIEVPvzsPQozOUE/A61V2XzHCQnoJ0RXjKQ7UE9cdlRAZTC6LP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 03:26:55PM +0200, Auger Eric wrote:
> From the pseudo code,
> 
>   gpa_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
>   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> 
> I fail to understand whether the SET_IOASID_PAGE_TABLES would apply to
> the whole IOASIDs within /dev/ioasid or to a specific one.

Sorry, nearly every IOCTL would be scoped to a specific IOASID as one
of the arguments.

> Also in subsequent emails when you talk about IOASID, is it the
> ioasid_id, just to double check the terminology.

I am refering to IOASID as 'handle of the page table object inside the
/dev/ioasid fd'. If that is equal to some HW value or not I think
remains as decision point.

Basically the fd has an xarray of 'struct [something] *' and the
IOASID is index to that FD's private xarray. This is necessary to
create proper security as even if we have global PASID numbers or
something they still need to be isolated to only the FD that has
been authorized access.

> >   nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
> >   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
> is the nested_ioasid the allocated PASID id or is it a complete
> different object id.

It is the IOASID handle above.

> >
> >    // IOMMU will match on the device RID, no PASID:
> >   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
> > 
> >    // IOMMU will match on the device RID and PASID:
> >   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
> here I see you pass a different pasid, so I guess they are different, in
> which case you would need to have an allocator function for this pasid,
> right?

Yes, the underlying HW ID (PASID or substream id or whatver) is
something slightly different

Jason
