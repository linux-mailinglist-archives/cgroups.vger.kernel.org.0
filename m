Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4E36CA24
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhD0RNC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 13:13:02 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:46070
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236713AbhD0RNA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 13:13:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/+lWU79RGw7Yc/dvIa31ivK6qBquYLIFl9FJ+P4ut+BvtcQglWKzrz3eQcWkcfQ60UzaihhcE3+lKspRtIMXqbUbeA5Z3NMuBp7db8Jv9sAH28mP2GTOuSBNZhxDM4ffsH1kNjGakOKO7/KjP4uCZ0GLAUUJ6rzSjoSbLfKnS4yxyNd/nVoBv2DtkzIm+wbVUmXzAUoW8on5USWi9PZHPQDduEc2eNlaHQFABwt4swgHVxNBNsgAtofTtllsDPF6uCo1a5p8GOwBJt2poSOb/RM6lueoJV17l9H+3DihWNX3I2YcBSXu1y21PkY+tHbYO3j8OM93z5MAvasJQ8TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5ay4zJDSzBfgShQVaw/dIX2szXKUzgVWHX1srUfNus=;
 b=QQq9W5+npTBkFbx/a02ME6KjpmiyscfJ4Li+6kDqVFBvVPNUBXzi0OLRCPN3BEYIwQEHz01rA88act6HJ8m55vSNVF4P7Pn4dI1msrTbMp+OVSmxADXEYRnovZfZalmSqX4HZYCrEh7WJsUiMNtRfgJbyTNrkAZFoBcUREHMgBw5qJvQHJwDu/8xAVIzt+NeyKGtZkJvM2NulJp5tdjRTDYQoszOS89p1A+N4aYQvjr08P5MJaVofVa0wVYHNP7YcOHnv9QyqcBFWll8QRcMh86Tos2Dd5bCFtIjPUjuKMIQD06mdnlAcbzher5xosPPmYSWn2xHS/d0YcR1q9Krng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5ay4zJDSzBfgShQVaw/dIX2szXKUzgVWHX1srUfNus=;
 b=l7N3W0P1zgoY0V5sk3MZROfPlsXfodgsYR1q+Qm/FDfxN23MA9ITKH3W9aMepSTcfnRsvNYYiDrZgFaUi70KuFu2AC2ApMcfKKnWEXFqJ3nji+X/obxI5B4C3/sLFThgrq0Q00TvRZ2WEgFm3m+Cs07GfDKrUC368IJ/0DNlVwXNsr3MQDMkC07gDqan2+u6kQHpJG8qEqBwBDlKfueLp6Y/FJRociM9iC/qNTa7fjKaSvUIgXjn6cXS+t8LT92ZzGqhSv5T5krJ7nHnB5g6danC1O17g2P5FH7VkCCgQD22iPf794YC5j7cQMtKVDI0sDePWXPyYGfDQJJ5iqKoGA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 17:12:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 17:12:14 +0000
Date:   Tue, 27 Apr 2021 14:12:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210427171212.GD1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIecXkaEGNgICePO@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:610:60::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:610:60::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Tue, 27 Apr 2021 17:12:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbRFt-00Da1n-03; Tue, 27 Apr 2021 14:12:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bca92a5-b842-4560-d6ac-08d9099f9a59
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1146773F5B5B5F9462F5E594C2419@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EGRfaPOjEl/XxEam0ZW3uylwAwPdZrlCnXWxNdvWYhpzvRb7jzZxBVi4/0sk02hh6+qdxpk6yKZFtMoAzbJZiA39BJ50kTuU/90dV/c/qABBpherAXYK46lM8bk7r8igUKbHnkRyM8Pwngh1k2FvXn2VFD5McGeItBs4Xzp9IjIJvUnFs9qaqphK9agSwS9xIG/tIbSwML650l2USwgOPMJjSjUBjEePdgoiqKrJhkbHpgAPAseT+8UhPqIrBFGsVcrcCPgtcpbn8vLDh5TH1FyWx4Lua1knKZA1tzvD4M9mge8JwA/pSz29Q9tuqU3goReF/6h8OBJxX5VlhPucKTok+UL5yesWgeMbxMjlA1hXRcjxXsRDwnZDWO78soFVEaeHzTLJDxDGzBbsY9UaIbjeHtgu9lO7gpH46s6ls0DL79+jPFryDy2whsF6+mNvGgHQfgrauQwwlHkHwQryc0/BSgSjG60coS40SH6LV0hB2LGuF30HCysquZoIcT+/6h3cWN5zN2jNhpxpihpyKfL1ytlLQgi+dF2x0xcKN4vUYTO7esOAFie4PZrn5WvdfdzZEVO2aqcDNPPtAI11dwsIZNO4eSlSIYEUily3JKd3qnZmIK24DguQDyylHtcP9+xfPFbhxzTfmB9D8eWSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(66946007)(33656002)(1076003)(426003)(66556008)(83380400001)(5660300002)(7416002)(6916009)(66476007)(36756003)(8936002)(38100700002)(9746002)(9786002)(2906002)(8676002)(186003)(478600001)(316002)(2616005)(4326008)(86362001)(54906003)(26005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FSUlmK5Yq8/6300fuupat9QbDI6+Gdiuxn+xchbsPf46iuVE7P1gtL8ke4qj?=
 =?us-ascii?Q?ORcgtZsqLN4Wfj1lS5AiOaAgBXUJhVkKBe8CgfQWsRLeGS+68sh8YJJuSTBA?=
 =?us-ascii?Q?RgESxZ0KEac6WaOqt4FxPTLyZhwcKm+z/0hIfldpOvwuhOalUky2F6f2lBGM?=
 =?us-ascii?Q?07hUcELfp6S97zWOPoZNRmnXKcGO4/xw522Z/46lk8AidPGUmblVjphH6yxF?=
 =?us-ascii?Q?3IWf4Y/NMCHUsDr5kW5/9bHAl1bsGWJ+olt1pCAGRhToo+Jit/MHqtblILVi?=
 =?us-ascii?Q?W/rCbVPmfboUinDvJWk7apabDbPP0CSwOauFitFK+yzfEyKYHxH8HrAiJh0e?=
 =?us-ascii?Q?oNbed+0ZEE/oEiGho1Hin++LxTIhpv8w0iHKKDvPBgVPI5rd+SFztJ4ZfNSj?=
 =?us-ascii?Q?xbx8NULjyCP1KyKpACrpPuW+swJ/ofH41r6NCqSn+W9PRdHjlapX7Q7DVY8N?=
 =?us-ascii?Q?49Z+aDLPUMczTfDpqb3wmrVhmMTjw239w8EwthuWaMMPuaWyaNSp8TnTzOBe?=
 =?us-ascii?Q?b4ltO1gTkqCcMizXTXyWf3VjpCQbKs9CEFA1ReT2SA3y2TqUlFnWhgHEBybq?=
 =?us-ascii?Q?yU+ycgFCnvaNGSrCsKpFCP7RI72KvMGWIObu3PFdHtAN6kss3ygMV+Zhq+vM?=
 =?us-ascii?Q?3WFPB67i37X58pkBzWicop3HZ1FF9AT+tLP3VLE2yd608SXIdqpTf8IkLFLV?=
 =?us-ascii?Q?uryFWmId6ZlmvpgMo5YF3gsJlm8QgUuC+9Py13aBUZPlrMCnaCBRX5wWP5RC?=
 =?us-ascii?Q?SvOXwKl+sL86u0u66nU8pc7G6LniHDBZ0S4kLCEaLVFmcQswHVGvXspBl8hb?=
 =?us-ascii?Q?DoEFBcz7Wh5DU3XHnvtH49/wY4wt5iMcxFn8BTsJFn81HX9izzqhFAH/iHl4?=
 =?us-ascii?Q?r8zub2v37QQWSgmALqbfJY3eGID9tFNBRzTKTOteVNC0yWV/6DujCjtt1cAk?=
 =?us-ascii?Q?Ocd3MtPrBRhsE/cn+gla+xHEG9yEuaG31G3qMEWHFNvojJtWwPLSiXNMLzDN?=
 =?us-ascii?Q?9n2i9Tb28U04UbAoAFxUTi9I0NK07Df+M6+DzNsd7nzFVQ1Qre0jku/Tbri7?=
 =?us-ascii?Q?ByLRTst6GeyV27CTk8WG8amHBwbNGrslKnfXBf27nzTJzXmGYvOUQT2mwypf?=
 =?us-ascii?Q?yawRnGrQjK2/MAR2I+mgNxy6I28ug8tNkXnydJsdOGwdQ9OVlbAUkLCpQJSa?=
 =?us-ascii?Q?kfLJ6/DcUwo6mXvsgGOqUJunhHHEKd4Jh6DKm0Co/02ZaR+EUX7xvQ3QQDhs?=
 =?us-ascii?Q?LHQUhPiGy2CJOYd1ZquvQmX/wl18oSp0lKALrAczTsqGGBtTTWgS+g6oacIp?=
 =?us-ascii?Q?oquQCgOQUd7JnAC1Inv1TQeC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bca92a5-b842-4560-d6ac-08d9099f9a59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 17:12:14.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Fvc6rMT48aRhqFXrH4jNwpEnxAE+j+IaDvt9ljHZOR8OAO7drE1kvYzOaKOnkwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 27, 2021 at 03:08:46PM +1000, David Gibson wrote:
> > Starting from a BDF the general pseudo code is:
> >  device_name = first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
> >  device_fd = open("/dev/vfio/"+device_name)
> >  ioasidfd = open("/dev/ioasid")
> >  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> 
> This line is the problem.
> 
> [Historical aside: Alex's early drafts for the VFIO interface looked
> quite similar to this.  Ben Herrenschmidt and myself persuaded him it
> was a bad idea, and groups were developed instead.  I still think it's
> a bad idea, and not just for POWER]

Spawning the VFIO device FD from the group FD is incredibly gross from
a kernel design perspective. Since that was done the struct
vfio_device missed out on a sysfs presence and doesn't have the
typical 'struct device' member or dedicated char device you'd expect a
FD based subsystem to have.

This basically traded normal usage of the driver core for something
that doesn't serve a technical usage. Given we are now nearly 10 years
later and see that real widely deployed applications are not doing
anything special with the group FD it makes me question the wisdom of
this choice.

> As Alex says, if this line fails because of the group restrictions,
> that's not great because it's not very obvious what's gone wrong.  

Okay, that is fair, but let's solve that problem directly. For
instance netlink has been going in the direction of adding a "extack"
from the kernel which is a descriptive error string. If the failing
ioctl returned the string:

  "cannot join this device to the IOASID because device XXX in the
   same group #10 is in use"

Would you agree it is now obvious what has gone wrong? In fact would
you agree this is a lot better user experience than what applications
do today even though they have the group FD?

> But IMO, the success path on a multi-device group is kind of worse:
> you've now made made a meaningful and visible change to the setup of
> devices which are not mentioned in this line *at all*.  

I don't think spawning a single device_fd from the guoup clearly says
there are repercussions outside that immediate, single, device.

That comes from understanding what the ioctls are doing, and reading
the documentation. The same applies to some non-group FD world.

> Yes, it makes set up more of a pain, but it's necessary complexity to
> actually understand what's going on here.

There is a real technical problem here - the VFIO group is the thing
that spawns the device_fd and that is incompatible with the idea to
centralize the group security logic in drivers/iommu/ and share it
with multiple subsystems.

We also don't have an obvious clean way to incorporate a group FD into
other subsystems (nor would I want to).

One option is VFIO can keep its group FD but nothing else will have
anthing like it. However I don't much like the idea that VFIO will
have a special and unique programming model to do that same things
other subsystem will do. That will make it harder for userspace to
implement.

But again, lets see what the draft ioasid proposal looks like and
maybe someone will see a different solution.

Jason
