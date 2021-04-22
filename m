Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEE368640
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhDVR5z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 13:57:55 -0400
Received: from mail-bn8nam08on2065.outbound.protection.outlook.com ([40.107.100.65]:44129
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236287AbhDVR5z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 13:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOGd5xiq7EyiNj+4JzNaSDVfv7UvtzKCIW5cx1fxrG8Ue02LN1HnSzrN7b55VA+5Nkyv7/daFZgwt6FQWmZgIZmSzlPZZOltjjPZPdowbI1aE8J+zgniK1kx0ZPC6c+4nMCpDRpZRo4v1SNXi5epFGypjexKLPQ4u0EJIr3lcjFpafbS6d4q+CsTDtBVNKj2pcPGY2beIOa4NFd3+D8XDgVKPmgWRZfVTpmquJVPdmKmUnUc+g6LWM4kDbK9fgzH0Kpkfv4FcI/hUTqLmu+v4M3DKgYqmLqZciWpRIwV7XAVIqbpsfBlzmvAxG0U5f/5gsPYOCeh4CZrAd6lCoDBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb1aRpNEsh8C/J64KYqsXeSiReMbtJNViHW3mYjyygQ=;
 b=JC1+P6XICiDrXGENsPcVgPJgby9wTv8+u357ogLsTkWMMJO0yOMYYOTppsggsNCuGPV/LBKwq/BlrEYYelVMcLW219uYkO0i0WH7QdRJ2yO0iEotDHremN7wN6UoEfGeiNNTTWtunjugVoIo91sK9VvXPRZsvY02u74bnDWaCxLjwfUtQ4CftMtwid5LFcQQY7OMUnp53gPZoQEdEuq63hrgfZnYMSzOkNOlm2Jth50Ci3Z+9e7GDsZz4yb2F/zcmK2yMzBclO72fz6BD5Jd5kNggTTayttykYSOw2OABNMdz1fGBffdZldtVkYHb291aPwQubWp2QEfsynQeWp50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb1aRpNEsh8C/J64KYqsXeSiReMbtJNViHW3mYjyygQ=;
 b=Hf8tfLudgLcsinkKlb2RmSryevjB4O07IP8SYh3GGlHqI+u9sUSVyTRX5MvhLD4LbWggSyyBu1gWU4UY8EaClbJqbwbLbAsC1ibhsnpGE28n0AgLNhTWePJ6FLZx4WCjmTnRmBjCfWvRr7VwpWOKUIZ0OHrQyI2FT8sr6eoaOfmpdcB3ClvTWziSmqRsPiYz3tdK3jfOuv1oPb1O+uE/N8HNkd9hAuW3c0GOOD7m8QwO0ZRzu0Za5MfyHw7uc3re3FB2qqU2izQGn0BUxj8EkoVkKzd8bSkR3hhqYy/0K5ueh39SiSYm4Qv+X5clh5bvWI/V8hiTNfRpla2DdrLy1g==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Thu, 22 Apr 2021 17:57:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 17:57:18 +0000
Date:   Thu, 22 Apr 2021 14:57:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422175715.GA1370958@nvidia.com>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422111337.6ac3624d@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:256::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:256::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Thu, 22 Apr 2021 17:57:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZdZj-00AD6N-TW; Thu, 22 Apr 2021 14:57:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b90aa9-7ecb-4827-1325-08d905b81171
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548D71CE5162E4354922101C2469@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWvpu0UjaDCadJLvvHeFoNR8jy1zkrgHDpCOg2mhfNKUWyMI1EoOE4n/+LnVZEIskCRk4q/p884EJKwm6udRFrRDCp9wH3ouwxk6OAkzgZxOpqLP73GLfX8OKZeqyFGkAGfix9lIE+zhPbhfUFMO3hIY9WxXPbEM5svVV/ek9oGHFINUsxw+q7GhbD11dKaZQsXmRwg1y5ptx6dQ7iNh+LJrL6pz5a3lWcG7ooA5O6CbeUcaDSus42hQ775WzQ5FSA6VGakzTF6aZ86p6HGfPBIM2XnhYjBmYdXqo/+SV5kaFfWoXw81bG/IKpKC59h6D0t9MfslJbPyQxe4M8mZl7VYy6zpno/vrgOGxCxtZsgZz5pnM8mIp/NNmPPVV45EifoLWIeNTXK/XQ494bK2pjT5msPE80XVYpWxw/bbozW+KJAFwq7RNCQT8WJ6JyeiBKao4hDlwNdmnXMe3E91+gBxbbWusoGaVSHGVrAqKRjvwO5WSJ7qatXqsCH/MgHOo7L3piWP/Y9WzHsWFDfVyvvHBPs+m+MzLYSPvmMhcfo8A4fCzTGtsAbMU0C0mgu1T5gd4LpAO1yXNxoRAilosjjJGORRXUX8ImzormK+A7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(83380400001)(38100700002)(426003)(478600001)(66476007)(8936002)(66556008)(66946007)(8676002)(36756003)(7416002)(26005)(4326008)(186003)(5660300002)(33656002)(54906003)(86362001)(9746002)(6916009)(9786002)(316002)(2906002)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8DnE9E0ZF9Gf8zKZvcifTsnVhG6LdKWFdBV+5cO4TyzPkbrw1Ogklutq4MYI?=
 =?us-ascii?Q?OA2qiDpgBCjVImcHI7YvpfRMxbaZXk0mumkiRt/uh7mJNFlMzC5o8vIxG1PE?=
 =?us-ascii?Q?DNkF+KYQypQVaelHYm1NNFRRFrTN6ttUeeenY2VLbTmzm55tpyhN2W9bT7AC?=
 =?us-ascii?Q?+tf7q22F4FYWTmYQYmStdCLpJ9r8kDccw0D/bjL9toMyVFxX6yrCO2RQ74II?=
 =?us-ascii?Q?i+GkN8UO9UCQzwJ1REqIafrihkQQsf9bcsaA0BBkcv5b0X4Kb2pxdWDFQ7mH?=
 =?us-ascii?Q?V+gXGr1JvP13Dx2CFPBdw/20aQ4uOoBUENKoT7/zru/IAQkF6gt2bSuB7NgJ?=
 =?us-ascii?Q?Arbh/DlhDwqhQcWwaAj2p7BP5TRzFwYV+ykOuYyCAsf1MIPRA3KiSNU8qnRZ?=
 =?us-ascii?Q?KJUkyeuhJK+qo0WNouZTjNxaZSnMepeABH3xi7+/bS49TWTMISc/d0vIfLXb?=
 =?us-ascii?Q?xBH88X2skCNDrQLEUas+5JZVfV1a/u1KN9efV2d2B0QUnNNvekHdacZg9HsT?=
 =?us-ascii?Q?AdceR6ClDxX7ihzljbO6sn+Ol4HdzTtWyynzPbTYnqjVuyJUNBHzVc58lmye?=
 =?us-ascii?Q?1wRHZqRFUEwv7cq+Ylkf457nmxDpYK+46Ie+/P5c+vG95ll1paGR49wAc65n?=
 =?us-ascii?Q?yPG5xMY5ADerQb4KfwCwJn5KaytN+CXnyfm+NLr+eF9TrHZBaK+M5Chgn25E?=
 =?us-ascii?Q?PjzsVJkho05c5zbZwL+9EKFxsKu2UPRE/7gfHULupQ0YG+Bq3QFA8S7qZMzv?=
 =?us-ascii?Q?uG5xkcOyh7O7Ey/oWqu8U2tHTtUbbhLdvAnKlQ2hNSPYeS/VwEMnbYKaX3Uc?=
 =?us-ascii?Q?46RtaPv55gkA8YmtSVXgXm9dge/CdCozy4UAOe976GgTN4jbsthJTm9MHpsA?=
 =?us-ascii?Q?eShtaKr545nC0oG7uGfSuxJwUpDmbuZce/QN7NiVneVac5kZqBiDMaV/oC1n?=
 =?us-ascii?Q?cvE9bZOvJimIpclYZ4BAbMFKJuZhkirELTsKnba7/y4X4tAEkFLGMv7mhVGF?=
 =?us-ascii?Q?qc/Pp22h1Y5Qb2zsyVHlwx5YWMi7HagRb098iPpUggx6fpeRs1k/r6gPO1oJ?=
 =?us-ascii?Q?mYep6KkbRDbsNlt3vAqUuaeDOyyxUj10sAtV0xNa0GJxZIXfiiYnBhgMc/e2?=
 =?us-ascii?Q?JQLy+W1xnec37wyW3Ng/QGTgq1UVkytZN79p4qfY52OS/sZx7XjtatqbKB8o?=
 =?us-ascii?Q?naOigklp5YB/lZkdtI5neVT+NrXFzW6kZCLb3rz64cYIaqacup3g5YckKazs?=
 =?us-ascii?Q?du8T+yenyC5d/kBQKwxze+9mNa6Ze/o6+K45Pvn+DSj2mc7155gajRauzL4K?=
 =?us-ascii?Q?JahICJ/+KRd8cVEmAQ2IGm/u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b90aa9-7ecb-4827-1325-08d905b81171
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 17:57:17.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x33IdwgCSskY2/1U4Aj7V0FGxOYfRuYBp7MXsCZ2XfcoRewyd0D7hltNN205WFhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 11:13:37AM -0600, Alex Williamson wrote:
> I'm suggesting that if we're replacing the container/group model with
> an ioasid then we're effectively creating a new thing that really only
> retains the vfio device uapi.

Yes, I think that is a fair assessment, but not necessarily bad.

The VFIO device uAPI is really the thing that is unique to VFIO and
cannot be re-used anyplace else, in my assesment this is what vfio
*is*, and the series I've been working on make it more obvious how
broad that statement really is.

> > In any event, it does look like today we'd expect the SPAPR stuff
> > would be done through the normal iommu APIs, perhaps enhanced a bit,
> > which makes me suspect an enhanced type1 can implement SPAPR.
> 
> David Gibson has argued for some time that SPAPR could be handled via a
> converged type1 model.  We has mapped that out at one point,
> essentially a "type2", but neither of us had any bandwidth to pursue it.

Cool! Well, let's put a pin in it, I don't think revising SPAPR should
be a pre-condition for anything here - but we can all agree than an
ideal world would be able to access SPAPR functionality from
devices/iommu and /dev/ioasid

And it would be nice to map this out enough to provide enough
preperation in the new /dev/ioasid uAPI. For instance I saw the only
SPAPR specific stuff in DPDK was to preset the IOVA range that the
IOASID would support. This would be trivial to add and may have
benifits to other IOMMUS by reducing the number of translation levels
or somethign.
 
> Right, but I don't see that implies it cannot work within the vfio
> IOMMU model.  Currently when an IOMMU is set, the /dev/vfio/vfio
> container becomes a conduit for file ops from the container to be
> forwarded to the IOMMU.  But that's in part because the user doesn't
> have another object to interact with the IOMMU.  It's entirely possible
> that with an ioasid shim, the user would continue to interact directly
> with the /dev/ioasid fd for IOMMU manipulation and only use
> VFIO_SET_IOMMU to associate a vfio container to that ioasid.

I am looking at this in two directions, the first is if we have
/dev/ioasid how do we connect it to VFIO? And here I aruge we need new
device IOCTLs and ideally a VFIO world that does not have a vestigial
container FD at all.

This is because /dev/ioasid will have to be multi-IOASID and it just
does not fit well into the VFIO IOMMU pluggable model at all - or at
least trying to make it fit will defeat the point of having it in the
first place.

This does not seem to be a big deal - the required device IOCTLs
should be small and having two code paths isn't going to be an
exploding complexity.

The second direction is how do we keep /dev/vfio/vfio entire uAPI
without duplicating a lot of code. There is where building a ioasid
back end or making ioasid == vfio are areas to look at.

> vfio really just wants to be able to attach groups to an address space
> to consider them isolated, everything else about the IOMMU API could
> happen via a new ioasid file descriptor representing that context, ie.
> vfio handles the group ownership and device access, ioasid handles the
> actual mappings.

Right, exactly.
 
> > Do we have container because the /dev/vfio/vfio can hold only a single
> > page table so we need to swap containers sometimes?
> 
> The container represents an IOMMU address space, which can be shared by
> multiple groups, where each group may contain one or more devices.
> Swapping a container would require releasing all the devices (the user
> cannot have access to a non-isolated device), then a group could be
> moved from one container to another.

So, basically, the answer is yes.

Having the container FD hold a single IOASID forced the group FD to
exist because we can't maintain the security object of a group in the
container FD if the work flow is to swap the container FD.

Here what I suggest is to merge the group security and the multiple
"IOMMU address space" concept into one FD. The /dev/ioasid would have
multiple page tables objects within it called IOASID'd and each IOASID
effectively represents what /dev/vfio/vfio does today.

We can assign any device joined to a /dev/ioasid FD to any IOASID inside
that FD, dynamically.

> > The security rule for isolation is that once a device is attached to a
> > /dev/ioasid fd then all other devices in that security group must be
> > attached to the same ioasid FD or left unused.
> 
> Sounds like a group...  Note also that if those other devices are not
> isolated from the user's device, the user could manipulate "unused"
> devices via DMA.  So even unused devices should be within the same
> IOMMU context... thus attaching groups to IOMMU domains.

That is a very interesting point. So, say, in the classic PCI bus
world if I have a NIC and HD on my PCI bus and both are in the group,
I assign the NIC to a /dev/ioasid & VFIO then it is possible to use
the NIC to access the HD via DMA

And here you want a more explicit statement that the HD is at risk by
using the NIC?

Honestly, I'm not sure the current group FD is actually showing that
very strongly - though I get the point it is modeled in the sysfs and
kind of implicit in the API - we evolved things in a way where most
actual applications are taking in a PCI BDF from the user, not a group
reference. So the actual security impact seems lost on the user.

Along my sketch if we have:

   ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
   [..]
   ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id) == ENOPERM

I would feel comfortable if the ATTACH_IOASID fails by default if all
devices in the group have not been joined to the same ioasidfd.

So in the NIC&HD example the application would need to do:

   ioasid_fd = open("/dev/ioasid");
   nic_device_fd = open("/dev/vfio/device0")
   hd_device_fd = open("/dev/vfio/device1")
   
   ioctl(nic_device_fd, JOIN_IOASID_FD, ioasifd)
   ioctl(hd_device_fd, JOIN_IOASID_FD, ioasifd)
   [..]
   ioctl(nice_device, ATTACH_IOASID, gpa_ioasid_id) == SUCCESS

Now the security relation is forced by the kernel to be very explicit.

However to keep current semantics, I'd suggest a flag on
JOIN_IOASID_FD called "IOASID_IMPLICIT_GROUP" which has the effect of
allowing the ATTACH_IOASID to succeed without the user having to
explicitly join all the group devices. This is analogous to the world
we have today of opening the VFIO group FD but only instantiating one
device FD.

In effect the ioasid FD becomes the group and the numbered IOASID's
inside the FD become the /dev/vfio/vfio objects - we don't end up with
fewer objects in the system, they just have different uAPI
presentations.

I'd envision applications like DPDK that are BDF centric to use the
first API with some '--allow-insecure-vfio' flag to switch on the
IOASID_IMPLICIT_GROUP. Maybe good applications would also print:
  "Danger Will Robinson these PCI BDFs [...] are also at risk"
When the switch is used by parsing the sysfs

> > Thus /dev/ioasid also becomes the unit of security and the IOMMU
> > subsystem level becomes aware of and enforces the group security
> > rules. Userspace does not need to "see" the group
> 
> What tools does userspace have to understand isolation of individual
> devices without groups?

I think we can continue to show all of this group information in sysfs
files, it just doesn't require application code to open a group FD.

This becomes relavent the more I think about it - elmininating the
group and container FD uAPI by directly creating the device FD also
sidesteps questions about how to model these objects in a /dev/ioasid
only world. We simply don't have them at all so the answer is pretty
easy.

Jason
