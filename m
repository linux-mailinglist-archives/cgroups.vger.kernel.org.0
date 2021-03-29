Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89B634D52C
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhC2QcA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 12:32:00 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:7264
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhC2Qbv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Mar 2021 12:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlqRkA2VDRyehwpMIgDMjI4IVEcoC5RBsKLjqTPfiZT4e1vHNtSCUSeCEgQJhsR9VwBU/kl5lfyNMEWQ24ktMaFSqsOhEVhWUkbr4v9ZTgIudtRKsAJ5T7Dw7JNLTOR8i+Ckwcl8EKUQvolnfHzWaO5ILzuL3HiFP97u5Tajriox9n+rt/7pBkiueN4JFQv0n7o4R4OV0ZMUQ79QuJ54Oz1XfDnf2EV+ub06A2j2AbG3nMR03lpC7zo+Wfnyk4gqglYSW7aXpDEUzczD3So+yltEDfv7yK72zDTlTpawoIrIz08VoQcnw4EZ+khFae71zlxllH+OVNn8xxVYCop08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9aEK6B+3YyO5OqaUbIleKWQnFZ2YkAV6AxJ0q5vvnY=;
 b=buf1uJ8clkf2uGvt9ooa1yg1/TxAZ4t/8lqZB+qY/PDTCoJkA61BuTWjiCK4RsS90W1W85GLjVkLS3+ir56jx4TCz0cL12gIlb/KB0UMY03HQEWjJsLiQ9rTKENQ+0CGqPPmYvShTr7SBwTMN11YHZJEojnG9q2xjEgDLywOrdgaGT1jz5tjSYJgjgzuqdBO0kvY8epDPmdMn4dbpDnQIOqy/g8Le/79etmGit8bDyClVrQH43bePXIEWePAvEzo74q2LJZCxVgtvIzH5GcjZ/OuzRkAw6qalb+6/4TXMxCiK8OEIOLw1EK+VuZ80R6TbzuLL7O7ZbJ+mlO/E4+6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9aEK6B+3YyO5OqaUbIleKWQnFZ2YkAV6AxJ0q5vvnY=;
 b=ig2oCuU0YoeT8AMc4uQ3O8ZJsVtUGMboBU7t+iCo8mleLVT/mMEVGKU7UWwJg4UqUEOo5td/f7o+vQRgbQEzibO39txsYeYwDAWUwJSfJLtFESYZqtNONznjsTDuvt1pVCoP/8bcy1IMMkuYw2dbKtD9ZDlVVLtktSEDMT5rsXXQYSA4GslGqjXtE/DcgzkYQrVoXRFr8UGbUOP9Mur0qxRCrw9EJSyhA2DQuG15tql1sMwsagY3YGNKxyl2bH2sTA2/WkFYJ93IfazQExIKAvLi7YaH6kqXW98R4aaDKHE/8XBh3ZOZS7VPd6q5GAeetlwn2gWy0JMUj3eMjGUhdQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 16:31:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 16:31:49 +0000
Date:   Mon, 29 Mar 2021 13:31:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210329163147.GG2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324120528.24d82dbd@jacob-builder>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32 via Frontend Transport; Mon, 29 Mar 2021 16:31:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQunr-0057WO-9I; Mon, 29 Mar 2021 13:31:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234e0896-d67d-4de8-725a-08d8f2d026ec
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB183371E5236147F2ADA1E760C27E9@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7IsoifYqCkqBaE7fyq0WxvZSEVw+Pben6kZZJ8UKi+/+cZX2PcaNK3VmhroBhOX/Sv3j4+M7uVSZCWivtrXxFGTv/fMQ7fjkqM6a6tsMUjdEGKySfVqElpb0u2DkOeAoVT2d7hU9Vax7j7w48XlhlEG1JI18KVrkV6sG1dqftMUA+GIu7gNDtBews89/lY6VkRx1mO2n3djxWzavUUc3JKznlEWqq7JDNivnL/K+mA5NOqONz7D6gyYkCW8Lewq5ocs5HLv15+r2uAaAWwdxxNYjPzQnHRW+HhOGps53e7WXA3kSzqDM+OGgIwpW6eLRh90Ga9LNvyRFc1blkXsA4WGKWL+YXkmdaWuRekeZvvYyVzjeeiB8NMOp39E9+UtdHuzRo4DVNNdaZrkhXZSv20yIciHRtaNnfnjMdQEzWvqwnRMmgpJLFWBy+qVOZt0vjZUsgUEdkGNyFHCtsSO1daCxfDbT+5ErhHeJEWj+oCAQ0SDNS9VKY/doKtKF+he1R9E6rLlDKe+rcTZJY0a+XBhcn9c7vJBVgT8wdGr0EYwS3+gsFpvk1xHE3f5zPJenkXyqwIbq++9xDR8xaYpOisNLwLvjlyND48ZoYg4Cn46tUF06Xy3vl2F5a2RzVGb/f9cYOOrpYrzlxWe0U7eiAAjOpZ5L5B8MHEknqVzHLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66556008)(33656002)(38100700001)(498600001)(186003)(9746002)(86362001)(9786002)(4326008)(83380400001)(54906003)(8936002)(7416002)(8676002)(426003)(1076003)(26005)(5660300002)(36756003)(2616005)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WUO8FGu/ypfvo95wM87wqe64aTxd16QjlK6S7prHk9AhfSJmV6Gsd6aFp1wh?=
 =?us-ascii?Q?mWlUudeHNw8Hn6YnxTAbfuxHNbqKnV+T9CjBgkQeM+/Ony4UXN6nDJDaw5Gj?=
 =?us-ascii?Q?7s25znd8iTwN/Dxvm4SrJ7zDgGcOVxa1FPywm+PmEQG16ZiWvpgxQwPQ/fQO?=
 =?us-ascii?Q?3NbcV1+f/3kk3pErSWTp0ekH1MV/+j+BRVQhq59d2HRHRG8gXj2SwZ+Vyrx3?=
 =?us-ascii?Q?MPEmmijrHy8Wf83N6NT1llYYwq45xj902Tunw1bQOq4ZzPatGUhfnNXxOHAe?=
 =?us-ascii?Q?OA7HffF+1xKwVFrVRojAcI4+CSE8FpOmQYpRUP+Z2bKMsyfPX15Fm6T1w7jw?=
 =?us-ascii?Q?w0R7UwRAgDrF/40+3Jr1HduCTYNQdh2WZd/ZdUnwzZn+nsmTSynlBtyPhXdf?=
 =?us-ascii?Q?/V0B4LuQ0/8hEKVEtJRL8sGJcXjP0t5hA5y01NFYr91HRkh1Rm0UOogI8ZWz?=
 =?us-ascii?Q?GHWe30YqRoylYaegckq8KNED+QWMa1mUQwAJznW5eCe2Biyfkvl8t6H/ZYd3?=
 =?us-ascii?Q?yB8KHapYu1KUGHE/X6IIAq9eSWV1l3oybjRKzmHXysRZh4caDhHP4koKhB+v?=
 =?us-ascii?Q?Myg4TcbjXP+Jz2mbj+lserlHDKorkOlGvY1ACjzAmA+etYCTQY97Z6YKrJ9H?=
 =?us-ascii?Q?6+/VfYFQP1CQXtt90HOPVw85DPsmHGMCtJejHO6ToZYmEIjEoNPbdY2Nr1Rs?=
 =?us-ascii?Q?asHxWx+xoChVxTMYV0yQI/g1etG7IO6j603BNL28AiyJGyCViVMokoZ0C2VG?=
 =?us-ascii?Q?2JchczrnsejuGP3i5bcnxmxERDuVUavcIvb4BkfO1l70mVOY9SytuquZKXA2?=
 =?us-ascii?Q?KH8kuJERZNGSQSCt/a+k2hLmR4pXQPVmYRv8UvL3ztVOwSID/MG+ZP0ncNyn?=
 =?us-ascii?Q?hire32Ktk7fK1txDGQ0HJUrq3ZNbF3NJVd50bR6Iv7lm37gl1O/QzI9562Hf?=
 =?us-ascii?Q?GL4+xl2vkpJjwK4GnOiEr9fyZR1mL+c39ZfLRKfEeWr45yABcTxWL+JvkW4L?=
 =?us-ascii?Q?oj3swOvgd3rOHZfMcADLlhs7LEacQFyS+BG01HXGm5pqiwzF980YYtTKVnJZ?=
 =?us-ascii?Q?2s4qeqHUGpYfW5+FTJGgqmXZTIPO8rHJSJ3pkLBTwZLU5JHd1Q5ov+0+T2SL?=
 =?us-ascii?Q?pVvhHe6QuzuNxcT7TrLIfdkKEF+O6380APp3Vl8xzgIprApsTcON66B2kD3m?=
 =?us-ascii?Q?FKo4C+tCRGQEwCMGP5M81jtW5vHHsNbxS39NnL4I8G6+oDKfKpiISpfyqn3z?=
 =?us-ascii?Q?tvpJ7pK4nuOflnZsI71wGO38oU7k8gl9x/o3511HUelXyIJLqvXtwPlEH5BZ?=
 =?us-ascii?Q?habVBGdV35QLKA+P/N/iLVfk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e0896-d67d-4de8-725a-08d8f2d026ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 16:31:49.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfZHRldxabI7n2IlqOvuTFhdMbsXBmkKDThRCMpGWUOESv+nJGsBQ8+SfDb79q5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 24, 2021 at 12:05:28PM -0700, Jacob Pan wrote:

> > IMHO a use created PASID is either bound to a mm (current) at creation
> > time, or it will never be bound to a mm and its page table is under
> > user control via /dev/ioasid.
> > 
> True for PASID used in native SVA bind. But for binding with a guest mm,
> PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
> bind with the host IOMMU when vIOMMU PASID cache is invalidated.
> 
> Our intention is to have two separate interfaces:
> 1. /dev/ioasid (allocation/free only)
> 2. /dev/sva (handles all SVA related activities including page tables)

I'm not sure I understand why you'd want to have two things. Doesn't
that just complicate everything?

Manipulating the ioasid, including filling it with page tables, seems
an integral inseperable part of the whole interface. Why have two ?

> > I thought the whole point of something like a /dev/ioasid was to get
> > away from each and every device creating its own PASID interface?
> > 
> yes, but only for the use cases that need to expose PASID to the
> userspace.

Why "but only"? This thing should reach for a higher generality, not
just be contained to solve some problem within qemu.

> > It maybe somewhat reasonable that some devices could have some easy
> > 'make a SVA PASID on current' interface built in,
> I agree, this is the case PASID is hidden from the userspace, right? e.g.
> uacce.

"hidden", I guess, but does it matter so much?

The PASID would still consume a cgroup credit

> > but anything more
> > complicated should use /dev/ioasid, and anything consuming PASID
> > should also have an API to import and attach a PASID from /dev/ioasid.
> > 
> Would the above two use cases constitute the "complicated" criteria? Or we
> should say anything that need the explicit PASID value has to through
> /dev/ioasid?

Anything that needs more that creating a hidden PASID link'd to
current should use the full interface.

> In terms of usage for guest SVA, an ioasid_set is mostly tied to a host mm,
> the use case is as the following:

From that doc:

  It is imperative to enforce
  VM-IOASID ownership such that a malicious guest cannot target DMA
  traffic outside its own IOASIDs, or free an active IOASID that belongs
  to another VM.

Huh?

Security in a PASID world comes from the IOMMU blocking access to the
PASID except from approved PCI-ID's. If a VF/PF is assigned to a guest
then that guest can cause the device to issue any PASID by having
complete control and the vIOMMU is supposed to tell the real IOMMU
what PASID's the device is alowed to access.

If a device is sharing a single PCI function with different security
contexts (eg vfio mdev) then the device itself is responsible to
ensure that only the secure interface can program a PASID and a less
secure context can never self-enroll. 

Here the mdev driver would have to consule with the vIOMMU to ensure
the mdev device is allowed to access the PASID - is that what this
set stuff is about? 

If yes, it is backwards. The MDEV is the thing doing the security, the
MDEV should have the list of allowed PASID's and a single PASID
created under /dev/ioasid should be loaded into MDEV with some 'Ok you
can use PASID xyz from FD abc' command.

Because you absolutely don't want to have a generic 'set' that all the
mdevs are sharing as that violates the basic security principle at the
start - each and every device must have a unique list of what PASID's
it can talk to.

> 1. Identify a pool of PASIDs for permission checking (below to the same VM),
> e.g. only allow SVA binding for PASIDs allocated from the same set.
> 
> 2. Allow different PASID-aware kernel subsystems to associate, e.g. KVM,
> device drivers, and IOMMU driver. i.e. each KVM instance only cares about
> the ioasid_set associated with the VM. Events notifications are also within
> the ioasid_set to synchronize PASID states.
> 
> 3. Guest-Host PASID look up (each set has its own XArray to store the
> mapping)
> 
> 4. Quota control (going away once we have cgroup)

It sounds worrysome things have gone this way.

I'd say you shoul have a single /dev/ioasid per VM and KVM should
attach to that - it should get all the global events/etc that are not
device specific.

permission checking *must* be done on a per-device level, either inside the
mdev driver, or inside the IOMMU at a per-PCI device level.

Not sure what guest-host PASID means, these have to be 1:1 for device
assignment to work - why would use something else for mdev?

Jason
