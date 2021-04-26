Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8036B33D
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 14:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhDZMjD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 08:39:03 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:8673
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233575AbhDZMjC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 08:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPkljl33hgZRobT2CtqZDNuLbaZKUwsqY3unyeEChco4eHgKQ4lbHnOvQ6ktZkuklnlZ06WcRbVChZjKGX0xC0eFLIs6G5UMzVRFdIoPL9LgoQmC6/BB3W8EZup3/eS2GeetYRfxyMAh9DpPtyXn264qKGoMVp3L619K03yGctdT+B6LIcDjFdUUFj2LVcyy869cjf012oz2VI1pOPDBsM4+ijSkfiiztBo/VxzI0jzpF68Q1yEvpeeO9WIlnUSugM/ZwgGoWcShlr1zAsszc8RNhMwPUp3jFVmIvIvi7V7ybhNMugyOGJfmfqXlWqBaF7YyJcN+Cr2rzAh7vqSlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOlurQmXmbDShxP4zI/UwwA0xTTiZnMgbw91KKw+w9Y=;
 b=gQsFEecWa147XIrvj4n4HgbRqtdeKz982OnUapT2YV4jQb1rkY05KpxhWKg5viaw0L+mJR4uHVPp02DUkA7HWrP0d5I8+FpAMc8d+BKLuiu6XtjzI6YuTduJjxj5qI0aws/+W63k6m+smCQZw5jWMdtLwVZKPqktTsHiuWs+PGxwE1rChx8M5Actr63keciPg08qA19wIgBdR7g8Nddsioc1e6elCynp3TI8UwwtTk1bgDYcl/oRtjMzKt2xvzRRu3c/rSjR8YKaeSchInETMTzCecpr79XTGtaX5lv7xX46lhXrEYdnHcPb3CY8sBKM3iSlyLCs3pcEFUT1sqzBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOlurQmXmbDShxP4zI/UwwA0xTTiZnMgbw91KKw+w9Y=;
 b=pK7tjSDVxjWxR6OBPJP8VKdsxlAQbnRrbjt+npzKtVjTr5cMRt9EXhftMNvnApUZOHK1NMyzYfw3XzylK5w/DAImAF1yLXN7WLHpUMnobk1maWeRazoJS4U1N658hSj+Tcc1Sgrny4vF2NT9WuUKwdUtAd68pWTguRe877ab13+vUo4p9yPEtnC+M82n6ic4c7YfMRG3H82+xvfgWss2rskXWixT4j0A+taeGe1vky3dXb/hVA1W+QncsGpqRJj0e2rVS58Duwgmd6yWy22e29c/tLhTiYFdi/+psJdfOWisbEiZr5dfYqX44OBU23qzDQr8eheNAhmeGcSkima0jQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 12:38:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 12:38:19 +0000
Date:   Mon, 26 Apr 2021 09:38:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210426123817.GQ1370958@nvidia.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 12:38:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lb0VF-00D1ep-Sl; Mon, 26 Apr 2021 09:38:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2170c46-5d03-4a24-f48b-08d908b02bdb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019E03A67CF3F21DD50B1BFC2429@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNVj1rhmTEedxXaBNBZ2fbaZYV9SIHm9MUTnYeOAVRUu3W1rIbWRSasdcHgiYJtQICxA5xdXK1PYzVhoZrlLCDTavBz3285VEnenxhqYDYAuIIcRmlBZyS9gAavg/nm3L+dGjR93/dXwKapu30lEPLt5//SOqJEs0GHB1RpyoHzsiGIpSviDHvgkbf30ttiX08nQLu0eLcyYLM2hp7gL4nF/jD1+qleivZg2dqndeBJrih90vxSPgNQZW0W1r2PAk3qvUzX1pl8ihvvyMU72zXB19fjwH3TbxsFtUUOGZoN+njNRaeCmH7+Y+yfOrd+QXhpKmLdoyIL/uv825UggyU0g2HgqUFFkoeU5r7hxPGYbJgSSSbSwfGDUHKVuoj+Pl2ObvEBcSabvv/5FPsL1mGVpa6B/rsAlK5nJQQVZLEtXm6w8Z3NksTYI6xoQW73TIn5ZewIzXFOFXlb2G/k5gzT0lGws8Pi+7IMBTIxpiRGaMXBOl2mQ/rzj9FnQjGtzuWf3OT1AX1RyMMTuECU4t+6ZUPImBt/EVP9O5frTx6WebgPhz29Sz3KqQm/aDEsVxCjp/8yIAjYUKVMB+KdUs9AUBMvPwCIBCruAn4bY/ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(1076003)(5660300002)(2616005)(38100700002)(2906002)(7416002)(33656002)(316002)(66476007)(66946007)(66556008)(26005)(54906003)(426003)(186003)(4326008)(83380400001)(36756003)(9786002)(6916009)(86362001)(9746002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjEyZUN3ellURyt6cXR4Q0RiWTJiQVgrNjR0QnhpS00rbXl2bnlzOWdUN3Zj?=
 =?utf-8?B?Q0lsSW5PaWUrTDVJS3FLSDh2T09uS2JqdFMrbEhvRURhbWthMkY0QzdlMHFB?=
 =?utf-8?B?TUpNVVEvd0RtNzhtRGZib2svL1BIU0dMRXVlamJjYy9OOFFnV2VOUkN1ODNY?=
 =?utf-8?B?Z1N4MzdWY01UYUg0b1MySVlEV1JLZnRkNEJNeHlTdkd6RS9uTHBaakF0K3NE?=
 =?utf-8?B?alEwTEk2K2tOeXh0YTJySjJWV2tQZkIvSVh2NzdSYlRHa2tta0ZnSi9LNlpB?=
 =?utf-8?B?cUtjTGtjcVBHS1Z5Z2lqYWwxejVBaW91ZHArQ0IvSFlaMlUzWjUvbzF3eWpV?=
 =?utf-8?B?SnI5djJpMDc3UlpJTnpiV3o2cnF2ZE5FVDhTTzhXdzBFM3BVT2Y4a3JFN1VD?=
 =?utf-8?B?SFNJQ0VFZzlQdGRJU00yK00vZkdXM3o2QXFyZXVMYThiRnB4b0VmMEQyWDls?=
 =?utf-8?B?MHJLT2hsTlMxS0RTeG5CNlFIQ1IydUdPSUZmM3VhVUQyUHQwTURGd2d4emFp?=
 =?utf-8?B?V29KL3lWbERKRkpsN214MElhWmFYK0l2SEVsNUZtMThQSWhadHNzZ1lvclFE?=
 =?utf-8?B?Um4vT09JSy9FZzh5WTVXbXJQMXNBUytTWURTaFVEWlNyUEhRa2VBYW5vamRN?=
 =?utf-8?B?OXJHVE11WEc3ZHpsL0VieFZKeDVscCsxbFFCOVZ3YTQ2VFNRU1V5WXJYY05o?=
 =?utf-8?B?TVFXTDNjdjhaR1NwZXBvc2RmcVpzbm5YOWRNMmZYY2NES2luaG9WZVc5NS9U?=
 =?utf-8?B?bzNLU0lyVjF1VUFRMGtHdk1kQ2Y2bVNqaHZodGp1NHhZVWpIcks4ZlFFRTU0?=
 =?utf-8?B?S0pudEp4dHR3NUtjY2hEVEtWRTY4cnFERHREdzkvbm5ZY1RKWGhIaHV6ZFl2?=
 =?utf-8?B?KzJOVVNnbTdram1CZCtoaTQ2bCsybVJMcXFkSFd4dWZva2dzaXNsU0lkVDhx?=
 =?utf-8?B?L1lteEF6aTh5NzJPUDMrT09DMDIzM1hTSjR6a3l6dTlaaFFVaWtKRXU1eGlk?=
 =?utf-8?B?U0RCNFpZc1dKRWlLYk90aDlYRVE0N09GOVh1UmZ5Nk5uTVhvSm1wYmJiaE41?=
 =?utf-8?B?TjVOMXlSVFRIazBrOWlKd2tTc3hhcmIxRXFFa2NLUWRUZlduS3dZc04wcHhx?=
 =?utf-8?B?VmJoLzhIaTNBMVFWSDErUGRoaFJ0VmRzUVhlbmUxSVFYTHZkSWRTTlQvYzFE?=
 =?utf-8?B?ZThsZVV2T0VOM0FTbVpqWTJ2dGxkUHdqdHBLSFVrTlpjZ0VMZ1U4bjFCMEo5?=
 =?utf-8?B?V09nZHlpV0RiTzRmbHJHMHBnRHJETHQ1TDY3N0pvYnFISkc4TlZ4L1BUNDdv?=
 =?utf-8?B?OGxYU2V1WllZV3BBT3lMSXgrd21WRXdxV29Vb0RGSktaTFRWcDFBMkRCWHd3?=
 =?utf-8?B?S1lpVXBodUlPTGRVNmN0R0ZkRUZiaWYwTTVhK1h2MVRxYjFFU2l0bkJUb2to?=
 =?utf-8?B?cFE3WUlFWjl1OVFiSWlHZXBPbFJucmhNdmVMMm5nbjh0OFlzTTM3Q21rQTd5?=
 =?utf-8?B?cGNaVG51clgrS2JQQTNzQ0QyWmNTTHBjazYyUklEVGxPdlc3WC9CNDFhQ0k4?=
 =?utf-8?B?RWlCOFhGOEhxcFN4SEpJZVpSc1IxQkplTEltaDhQT2VKaitiSDRQcVdaK05o?=
 =?utf-8?B?czZMbzhGMUR2WUV2QmZjRGN2SFk3V3p1MjVoby8vTFRMQU5PK1hEdTA2U2Zz?=
 =?utf-8?B?L3hDK2xUMW9pdDl2bnNPWnZOUXFlcUlSMElreEU5RVQ3N0thVVBCdS95eDhH?=
 =?utf-8?Q?7UfbYxBKPd8CCsGmHvxpmJqClC2FAYMriJCf5oF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2170c46-5d03-4a24-f48b-08d908b02bdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 12:38:19.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL5z5a0vWea9uUudvLqZ/Id4YhlxETzuOx1dK0sjaGglm9o6k1RKhhS74ilq7Af9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 25, 2021 at 09:24:46AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, April 23, 2021 7:50 PM
> > 
> > On Fri, Apr 23, 2021 at 09:06:44AM +0000, Tian, Kevin wrote:
> > 
> > > Or could we still have just one /dev/ioasid but allow userspace to create
> > > multiple gpa_ioasid_id's each associated to a different iommu domain?
> > > Then the compatibility check will be done at ATTACH_IOASID instead of
> > > JOIN_IOASID_FD.
> > 
> > To my mind what makes sense that that /dev/ioasid presents a single
> > IOMMU behavior that is basically the same. This may ultimately not be
> > what we call a domain today.
> > 
> > We may end up with a middle object which is a group of domains that
> > all have the same capabilities, and we define capabilities in a way
> > that most platforms have a single group of domains.
> > 
> > The key capability of a group of domains is they can all share the HW
> > page table representation, so if an IOASID instantiates a page table
> > it can be assigned to any device on any domain in the gruop of domains.
> 
> Sorry that I didn't quite get it. If a group of domains can share the 
> same page table then why not just attaching all devices under those
> domains into a single domain?

Sure, if that works. But you shouldn't have things like IOMMU_CACHE
create different domains or trigger different /dev/ioasid's

> to describe the HW page table. Ideally a new iommu domain should
> be created only when it's impossible to share an existing page table. 
> Otherwise you'll get bad iotlb efficiency because each domain has its
> unique domain id (tagged in iotlb) then duplicated iotlb entries may
> exist even when a single page table is shared by those domains.

Right, fewer is better

> Or, can you elaborate what is the targeted usage by having a group of
> domains which all share the same page table?

You just need to have clear rule what what requires a new /dev/ioasid
FD - and if it maps to domains then great.

> Want to hear your opinion for one open here. There is no doubt that
> an ioasid represents a HW page table when the table is constructed by 
> userspace and then linked to the IOMMU through the bind/unbind
> API. But I'm not very sure about whether an ioasid should represent 
> the exact pgtable or the mapping metadata when the underlying 
> pgtable is indirectly constructed through map/unmap API. VFIO does
> the latter way, which is why it allows multiple incompatible domains
> in a single container which all share the same mapping metadata.

I think VFIO's map/unmap is way too complex and we know it has bad
performance problems. 

If /dev/ioasid is single HW page table only then I would focus on that
implementation and leave it to userspace to span different
/dev/ioasids if needed.

> OK, now I see where the disconnection comes from. In my context ioasid
> is the identifier that is actually used in the wire, but seems you treat it as 
> a sw-defined namespace purely for representing page tables. We should 
> clear this concept first before further discussing other details. 😊

There is no general HW requirement that every IO page table be
referred to by the same PASID and this API would have to support
non-PASID IO page tables as well. So I'd keep the two things
separated in the uAPI - even though the kernel today has a global
PASID pool.

> Then following your proposal, does it mean that we need another
> interface for allocating PASID? and since ioasid means different
> thing in uAPI and in-kernel API, possibly a new name is required to
> avoid confusion?

I would suggest have two ways to control the PASID

 1) Over /dev/ioasid allocate a PASID for an IOASID. All future PASID
    based usages of the IOASID will use that global PASID

 2) Over the device FD, when the IOASID is bound return the PASID that
    was selected. If the IOASID does not have a global PASID then the
    kernel is free to make something up. In this mode a single IOASID
    can have multiple PASIDs.

Simple things like DPDK can use #2 and potentially have better PASID
limits. hypervisors will most likely have to use #1, but it depends on
how their vIOMMU interface works.

I think the name IOASID is fine for the uAPI, the kernel version can
be called ioasid_id or something.

(also looking at ioasid.c, why do we need such a thin and odd wrapper
around xarray?)

Jason
