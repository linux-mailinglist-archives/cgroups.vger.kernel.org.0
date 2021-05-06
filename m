Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B13753C1
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEFMXZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 08:23:25 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:58592
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229733AbhEFMXY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 6 May 2021 08:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp6Xj8bcKPRpsQqKl2XwO6DI3JsUCPalF4ev/wVUeaQ193MLX5rcDGOqYdH0tYhSq3uF6yjtcRKVP+lPsk7yrrt+OubVCIQZO8Lp7ig27ytszRktWQa8xpDHUPYPhzSEJVywZpaGmK5Q2L3eEKtM969Nrqi/p4kbAdhniAJd+o9l9gFosjx37OxUz1x3tnhbXRkmyCYmqNMhhSys/bv9N1VGTjjelGWLy8Brzt1sqUg1FjD01iTHYezQ/altX4isRYIl/x8jWUn8orI0far1v9xksshyy095YCPdF3h37ERvMZ7kmLmkXHGUk8ukDc5u+XPlHNBGsbJ0D4WFDHQ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyhDd1vrMGxrArRcbqrysudGQz5qpeVhUNpvpg2w6FM=;
 b=SuaZeqQGV4iBwdr6HzJMHnPJK1UlYEP56EN9OUiHm62O6BK6NQ4xl06I9PIs/8QNMRr7BiVtoYCAk/83nQO2l3yKE1nxLVtaZODTidy/bnEPYwrbStxajOBumQENfCdryAnDglYw+V7eBINDLFnH7xv7g5tY4mcJ7mDmI/DHxdvtztb85+IMTTG5Ky1TkSaA7r2obWlQuY2Kmdd6uPV0Dle2uEUf4xV0BLBhUoePasYBIas13r39hTZy48uJoihtXo+Tvh0TP1oxen6HPrOvsbb9Ip5K011evEe41WA67ZRNMDBNO2O4J0+GykwuHje0Nu2nw8srO3StQj1ptDJzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyhDd1vrMGxrArRcbqrysudGQz5qpeVhUNpvpg2w6FM=;
 b=JbHEwSe4DaJvYUG05GX7gANS52d+VrOMOIrl1SEDGbLfwsVUs79GijkU9ExMtAO8hi8Kh483i9W5NuM9KfLV6rQTWbr2pzYr+EXorQ8YkmoKpTzm2ROO55U/cmJRfJJU1Z27EzgUGv1TOPONnhkakGZael3IqGzXx+9VBhkI2pc5wzY3UVMIKxlI8n0gcPwI1PQKygz0XvfTNVLqVVyPLimBWSX1Ree6wxGrKzqk+UKfJgrIsqmfPSySVhg5kIj3hpc0+mRy29DZiONj7H+ZQVwIkB83m4S7T9U27s6kw1ZWUtAkYflH5LXzEu7tZA0kfzk5ATVPj7FzGI+hnSbgOA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 12:22:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 12:22:24 +0000
Date:   Thu, 6 May 2021 09:22:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
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
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210506122222.GP1370958@nvidia.com>
References: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <20210505222120.GM1370958@nvidia.com>
 <20210505232319.GA5087@otc-nc-03>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505232319.GA5087@otc-nc-03>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Thu, 6 May 2021 12:22:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1led1K-001oLv-Ir; Thu, 06 May 2021 09:22:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95dc6c01-190a-440f-180c-08d910899a6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2857CC27DE3571636ABAC1F9C2589@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA38efaUBQlc2OGpZPbteV1sL6Es8tekoM942AVSFVsmCtgDPOqDZS0mcvNX2+96VzkCR9SfOvdN17LVLAScQ0yU+D+LE0V3h/pwloi/MWpuXmU6j6+3EvY86F69I3wZ2WmBxaY5QERECpiNOHTwHO/dwJJ6nJAdAjT7YyVNxt5Y7xzqSNkeusQJCb5Vkw7+shkRCctxWwAokccg+/xzGKXV6lKXkYsVLfBVPPvV/7mbr9qMqOOkVWaM2mQeR+j3oMlNs3xy/h90CZHkhdze+95zXhhkYfqUZQG2U3SGPvlikHwoAFdfXEfbywNg/crDHWPNRUHwvd2XlC9lYDZqmyGH4XAztosfax8JZJwUGpgQt/d7dZ2OPJ5OAZmBo9NWjKntgITvI3K9U3MWLAo+l7d/37APOxHv55qmeIAcF9YRF+5/OkqAzkjq5i3aXnzmnMQvM7mp+CQKbdUemGZ5j9lbeaIldajCIhfGLK9ww4zJyzKe+Kj2ijNAMWoI3GcZw3WEiviWk2keIDHBQn6fNbdMEiHerd2Cc2HpPcflexSUU1AG9qMnOg42s/fY7F8bo2tNI5THuS8qQk8p0FcuRvxZ86F6XXP5w4PyIw5AIlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(9786002)(54906003)(26005)(33656002)(6916009)(9746002)(5660300002)(8676002)(66946007)(186003)(86362001)(1076003)(2906002)(4326008)(2616005)(66476007)(36756003)(66556008)(4744005)(7416002)(38100700002)(478600001)(316002)(426003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l6FPjCSAnKBbmiVQPanJUKUOcsS79QSg440Bsy00Ply8KZu7fvNnXWnUPaJg?=
 =?us-ascii?Q?scArcUqc19nSRhiK1RXrIaeHxfBpXnndqkbkK+b5Mau0OcRjwENogNo1fdqS?=
 =?us-ascii?Q?cs/jApY1WcZOX6F8BMPt8u9+dOp4CHT+w3mWGWwDAKkfs8Lc7Y21TIfXpkqT?=
 =?us-ascii?Q?kyCc+AjCvpE4QqhL5zIXqPxONHAUbx1XvNYN1jrkqYPZGhzLk4hno6pfTTMJ?=
 =?us-ascii?Q?IxjEMmgAM752J1f3SXCiaIts2WTIwKhgz8HGB42S7gpqvO+l/a6qji1J1t0M?=
 =?us-ascii?Q?F/dvb/wthydR2C8uHdzK0OLu4HtV8q8bn3YSTGrb0X9tqt3aRMlDn4lwGz28?=
 =?us-ascii?Q?r/hvsXCVVaOsvyLGzYR0/S1WNlDL2EJmINazcxackwjhSRp82GffzHS3uXKh?=
 =?us-ascii?Q?mavABQ9yr6CXqOiVoMBoLZ2ZfudUXWSdA79AZ1tq/+VwZAazOWhBQ2Gs6qrk?=
 =?us-ascii?Q?JGplb2VcEdbP2w8M0AspZ8G1iEALiI0YNLsbrSurPyNP0+pw8VIusZ6fjdTm?=
 =?us-ascii?Q?tElImU26eVUFSUuD0QEMZIpUIk9O/vJoPufq8u3lzXnihsDNNnS3NHKx8+iG?=
 =?us-ascii?Q?hHvG8oIEVgjax9QOdkZg8PtRHg9mv5xxvwC7diMokHCbg5liUHxP2elQTuHW?=
 =?us-ascii?Q?IODGCwijSRs5JqZ3uftW+3Sy/UKir2ZIXobed4KtEwLpjio55E3ro8HnFklc?=
 =?us-ascii?Q?QkUhB4z/EjFCGZHGeY9xurMpLVmcCRLC+NIkOg/fArO73Pbl2ijMFi6dQMKH?=
 =?us-ascii?Q?+/AoSjhzrNWzWd42+qalqc/nFQ3TSBG3KN27DmN1xws4rpMMEZqDu/RiBxVX?=
 =?us-ascii?Q?1xKJGW3sXGrbNjkls5HCin48ZX4yCXzrHFuWUWGYarrp8IYrOCJ0ZNswNWir?=
 =?us-ascii?Q?eFQY/zriEzWoUUAWS5leqUikwTvGYdUF0j5gX8s1dlVEhj3gWo9BJxpALtVd?=
 =?us-ascii?Q?/4opWyML88r/eB8Jnj7IhVOQcwwSuROtnaKLv9ijuZ09aJe4rH07UFB8r64f?=
 =?us-ascii?Q?zlHx0ezTbeFWzawsS2HUhmzEGWgt85gbRI0qwwHjA+k3D/6B4uae1Qj2KwG5?=
 =?us-ascii?Q?XszzUc+T7f+YDrqnJ5KqEEETS8uHPnx6++8u7Wjamb5Ba0l1e7/poJbBWxC2?=
 =?us-ascii?Q?mSZrWnb/4Jvmmn4MHzLJHwmEShA1MO+2J1FTPH/m6sc7l2rYtbQkv3T9BHd+?=
 =?us-ascii?Q?EjtJY9ehW//TI2efTPfROwTGpNqmhA7ow3iDQhcC3SETsMyowQprmZZPRdtA?=
 =?us-ascii?Q?0kS7XzUXuFy3gLAP209313vhwAYm0DQw7RotvN5EvVgFdxcPovD/yRq+nq+S?=
 =?us-ascii?Q?Ng5xj3nEDkUwgwjC0gqzK9yO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dc6c01-190a-440f-180c-08d910899a6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 12:22:23.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SVoQ5lHIJpuatHtD3ENapbWhumCdJ+hGK9RTsL8JMF5jmPTGCqiHLNeoJvQiQzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 04:23:19PM -0700, Raj, Ashok wrote:
> > Which implies the API to the iommu driver should be more like:
> > 
> >   'assign an IOASID to this RID and return the PASID'
> >   'reserve a PASID from every RID'
> 
> I don't think this has any decent change of success. Its rather round about
> way to get a global PASID namespace.
> 
> >   'assign an IOASID to this RID and use this specific PASID'
> 
> This seems a bit complicated. Another way to specify this.

Maybe, but I don't like that the driver-based iommu API has been
corrupted by injecting a global 'first driver to claim it'
resource. It is not properly layered anymore.

Jason
