Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD03519BD
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhDAR4G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhDARxK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 13:53:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A7C0319D8;
        Thu,  1 Apr 2021 10:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7n3eZXagTwg3F6QTliwUyA0m2UTWOWHfZ07O6l+f2n+GlQRjj4F67Oq1qjA400PydCY14GBzFdx5AuO4orBQjqkyCHcepGTLFlVLSXNwxNp3YQcdRu0Tb1KgnIAxCjvdYyyTIz+b6GXINLu/MhcuEumsoyIVdDU5HLQKbPZSUGI7U5rvRa42xjOGVB69vMTJN9pIwCt7LIlQfnJm+aNSSDjpwHQKfKyV+6aSFZ2HVpuQBZckS1BE6nM7VD0kgPGiufbE1blF4zQwEJnsL0QPf1KUHC0BsrDnHAMUL6DOV74VIH1WoQnONOSjLMILT+hykYNiP/ymxYdsRq42nFuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziwf1w5DA8l+3uM9hK6DzOugzV5jzyrNOz7y/RdgICY=;
 b=DwVj2p0U9QoaiQcSP/dxOEdcOQZGVNtcOraaBM6Iw6iawcOuh4jWVjy5s/ZKHHd0svIgvSl6cvFC7dptRXMW4ynvuyLlMc4/7m5EG+qNJvezsnoQsIA3FfUsYOORb7gRE9bu/pLASpqr8/7QunZwUJj9fSxHmNjQds1VNpJ1ipbDxY3pOyaGD09Gcr1QiAdCApdzRNAcN9DMbR1jtk8+9k/oN5NR5OD4VrbdN8XqcsRmbIKYrf9dO8v6/khbybBVVNZ8qOjno/uNi4qEIaYPfc3Sbqk4pb/DZumNS6Mek1pDQkiHziyl/vCKgqLwJKxmypGrgU+D2BHKQbVOJiEiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziwf1w5DA8l+3uM9hK6DzOugzV5jzyrNOz7y/RdgICY=;
 b=ODGfMh1+QBZDYa/FGBFHjgz5L8qh0H3bOxSDR5QUAA3YbCV9H+bfGlCK4+wr6CiNpEHzvF3y0LqDy0FgACGthypU2LGcNB/wFqHKT4VSE60R8Lr63OYmrlh435wMpJwCi+47ShEqutwZGISH297ecxN59g1yL3JrJ39XAJAbfVnQqe3WsJBjk0RzDP1pelWLr/nkPhZUnDrmJ0hYM6Si1K0XutEYjvhuWDhLbAHNXFR9itvetNrPpQoyg214XK3P5O7xL8pN+hV7z8mRj/IEFb/OMaj2sF2Nia0oq4sClV8BZ7wwEcjUNqNqg6R7VOkhKgcinqBPJ7mv0o76e+499A==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 17:26:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 17:26:06 +0000
Date:   Thu, 1 Apr 2021 14:26:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401172604.GK1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331123801.GD1463678@nvidia.com>
 <20210331164621.5f0b0d63@jacob-builder>
 <20210401003705.GS1463678@nvidia.com>
 <20210401102355.38b0b7d7@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401102355.38b0b7d7@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:208:15e::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:208:15e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Thu, 1 Apr 2021 17:26:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS152-006opu-Ml; Thu, 01 Apr 2021 14:26:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94488ce4-964f-4f31-c3d1-08d8f5333b50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435239BD23BD4CD02F54FE9C27B9@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcO05XyPo2OQ2HER4YjIM20HPJtpuh5gnyAP5On4+C1x9PpleitNtkyjin6/7LYcI4ynnkOa2jztkpCMng0xvlTwXyXjJPzbZv5ayvHiSJDh/06tAzoa65bksKUKwl2WXQa1BUaFdclk+JFqWJb97V0Ek19vASOsaDLGo9EmgbU4z3QjZGxNOaCb82POkXoQUExI6omTlKttD0Sl5Ohm4JkWVyaOwBdmtJtDprTVnCdorA6wBdwY6SPB2g6D+3ypMwWQZq/aNxZj1NDxrFJl8i1H0MhONS6QBhiAlu3tT4GKfCZzFbh/YwAB8KybWX/HizhTaXjiRq9RLdFFTE7N+z6B3f8FuHSXuCz1soLa9KQonzCuTNj3fhQzBYJ5jNRDtqMm62jLqhR76v4cwXy7vItk05/bC0+CJ2vQR5irawGGqkbxQ3xnZq3FPbyxaha3ZMimWqEKeIL3EM9iSOzRfTePVpPJaitCR+BZ2XlTSFqc6kxuAHrxPpUSOmGb+8ufscDIyYhgBvtmk5rtj4ULx+nMiUnLCYAXRkGyGEwjLBfbp1pawO3hdx6lj1Zm7di1z7mGjlPEaEnoaDJHFuDwvR8oPzDe2bwndggsnL8RqodqyLfBLRw9CPIB5rtBFslmddhEzCNFfD7GMmaoeIw7KZ4+PIM9oB70UJwq433DjeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(426003)(1076003)(2616005)(186003)(316002)(2906002)(9786002)(9746002)(54906003)(66556008)(38100700001)(6916009)(66476007)(7416002)(33656002)(86362001)(36756003)(478600001)(8936002)(66946007)(4326008)(5660300002)(8676002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?swxWzRGqXiiA2mjgOB/bbW6Sk9+yw3nvZ6XVCxGdU37JYefgy2ofVtkCGdS6?=
 =?us-ascii?Q?KCFKPtBvFuxTGyDMVIbFZU3MzQYqVG4USiqUfArBLBQFjqAlEAOeG9XSmuS8?=
 =?us-ascii?Q?HqLVe3tCLD8RJBCg1Gwse7fv4hqDsH+JXs/crnchDbENIznhDDGl9fgoAXHt?=
 =?us-ascii?Q?CqNA3WWqigywQTV/L5bJps8Lvbj9muWBPrcDJjO922DHH7ncHVTiadFE4u2l?=
 =?us-ascii?Q?1aJM+UjWDkRJldGFXkphyINwEzckmlzXojhmIQ5ZDSZQSAIIm5x/1Ok6kN3D?=
 =?us-ascii?Q?+IU4rzKcJezZ9UPt7wq31JTX3ZGlUKfl7jGDYlDqOm1GkQwk/T4kPwr1+c0/?=
 =?us-ascii?Q?3+6kG+hZcDUIvuiUOCgIa8xtXd+bkJg26iimeSyIOEw9uEJB8KY153MjevwB?=
 =?us-ascii?Q?8jPvREtYyEYncUDvhS/1y8uANyVZFYMQQapKImiZQEyZEvLA6TTKdPIQZF4J?=
 =?us-ascii?Q?1g8TPXxq8Mhf6p44z3Yq7kw9Vwch7xVie92n8o4yp4xXvNV4sKjOwnkorF4N?=
 =?us-ascii?Q?YP9218O5n3xai2we/lV6hAcLOIQI1uJkxNvaP+7nEbn0K3B8raR+BAjLjJcB?=
 =?us-ascii?Q?pFybRIx65SleQbsUA58IDXyOwJV1SCKuxbtQQ0A2U5SUz8pPswiJogXq8T7q?=
 =?us-ascii?Q?gPJembTwrIyVTUPYSJMkrQNDQ2v+dAAwfC9hQKxAp7DG8H7irFSrMaE1Qz52?=
 =?us-ascii?Q?q+IDcDcIBcogTOm1cuYYIARm0/9LMG8GboZ5NRSjovsZx5f8EJAxsHXpDO+V?=
 =?us-ascii?Q?FYbTh9ufVvscEPAStJ2+1nZ50ON9Vp1UDPePptgezmSajLQD9EVqkEK4MVaH?=
 =?us-ascii?Q?dkcHf4M2ztJHh/pzTXYZKaaBmfKWqbrxK94J24+QbZcE9z1fZ+1BaNo0BYxK?=
 =?us-ascii?Q?d+5SUwDmim4EUFrSm3vDk03EJKwEAPUO8e7O7ix4BTeQt3h9K/aizFDuL4KR?=
 =?us-ascii?Q?p1k/1XjditFMTsI8SsLtCvrHKAG2voHBrSKBLULUlkZbh6ZXpmLlWbRALnE6?=
 =?us-ascii?Q?wCimucdlLefEH293YZfv61NN44+CJFRotZkvFGpkjBGDefujJug21DGkZM/9?=
 =?us-ascii?Q?ptpklwzm6m7nA5/1fWy/js/QR8FWCXhoiCCoP6NqLimuZAABu9PsU58j3QXk?=
 =?us-ascii?Q?HK0A3bQueKIZjnAnCnUG76hLFKCYqvD4lob+JQG2+DDbwT5kO6JmLJVxQDJP?=
 =?us-ascii?Q?aPRNoPcFVjOeDT1MYvOWrcJc97misJP2pCAyd5or4uFBMk7Clg8sP+RMwH8Y?=
 =?us-ascii?Q?w2ni+PqubtlNU+hD4RJv6qwDD3nlOAeyDh7pEPrOgH5UDp4czlBvMBr9DqxT?=
 =?us-ascii?Q?+zTHIenRMNc8HGrzksttWtvLh+dq/Bbd3DhbKmx/YDNEBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94488ce4-964f-4f31-c3d1-08d8f5333b50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 17:26:06.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDewsFPi6lcKPsI7BNByD/s9sAv/0YZUJXuEXHZQAfb60F6tqXs/PHVAXxMpbJnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 10:23:55AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 31 Mar 2021 21:37:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 31, 2021 at 04:46:21PM -0700, Jacob Pan wrote:
> > > Hi Jason,
> > > 
> > > On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote: 
> > > > > > Get rid of the ioasid set.
> > > > > >
> > > > > > Each driver has its own list of allowed ioasids.    
> > > >  [...]  
> > > > 
> > > > The /dev/ioasid FD replaces this security check. By becoming FD
> > > > centric you don't need additional kernel security objects.
> > > > 
> > > > Any process with access to the /dev/ioasid FD is allowed to control
> > > > those PASID. The seperation between VMs falls naturally from the
> > > > seperation of FDs without creating additional, complicated, security
> > > > infrastrucure in the kernel.
> > > > 
> > > > This is why all APIs must be FD focused, and you need to have a
> > > > logical layering of responsibility.
> > > > 
> > > >  Allocate a /dev/ioasid FD
> > > >  Allocate PASIDs inside the FD
> Just to be super clear. Do we allocate a FD for each PASID and return the
> FD to the user? Or return the plain PASID number back to the user space?

I would do multiple PASID's per /dev/ioasid FD because we expect alot
of PASIDs to be in use and we'd run into FDno limits.

> > > >  Assign memory to the PASIDS
> > > > 
> > > >  Open a device FD, eg from VFIO or VDP
> > > >  Instruct the device FD to authorize the device to access PASID A in
> > > >  an ioasid FD  
> > > How do we know user provided PASID A was allocated by the ioasid FD?  
> > 
> > You pass in the ioasid FD and use a 'get pasid from fdno' API to
> > extract the required kernel structure.
> > 
> Seems you are talking about two FDs:
> - /dev/ioasid FD

No, just this one.

> - per IOASID FD
> This API ioasid = get_pasid_from_fd(dev_ioasid_fd, ioasid_fd);
> dev_ioasid_fd will find the xarray for all the PASIDs allocated under it,
> ioasid_fd wil be the index into the xarray to retrieve the actual ioasid.
> Correct?

'ioasid_fd' is just the ioasid number in whatever numberspace the
/dev/ioasid FD's use.

> > Why only one?  Each interaction with the other FDs should include the
> > PASID/FD pair. There is no restriction to just one.

> OK, one per subsystem-VM. For example, if a VM has a VFIO and a VDPA
> device, it should only two /dev/ioasid FDs respectively. Correct?

No, only one.

For something like qemu's use case I mostly expect the vIOMMU driver
will open /dev/ioasid for each vIOMMU instance it creates (basically
only one)

> > The act of programming the page tables and the act of authorizing a
> > PCI BDF to use a PASID are distinct things with two different IOCTLs.
> > 
> Why separate? 

Because they have different owners and different layers in the
software.

It is not about use case, it is about putting the control points where
they naturally belong.

> For a complex stack like vSVA, I feel we have to reduce moving parts and do
> some divide and conquer.

uAPI should have all come together with a user and user application.

uAPI is hardest and most important part.

Jason
