Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC1351E46
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhDAShx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:37:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:38667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236265AbhDAS1W (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 14:27:22 -0400
IronPort-SDR: LY3OBXoheAGxMb0szz7VjYB1QDN0NfbftQOcvs84j3LzlSk++FBlOeNelq3+L5ZXPI+wG4Y4d7
 Zo/W3q1MMPFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179784450"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179784450"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:08:25 -0700
IronPort-SDR: UjMwzev5mUBqbD+7jOmFM8b/vOw9+mCSm5BBsTius43CTADjYiUUJ5Sh1HfASu067N8ShnCVaa
 ce7o6tYDQDgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394536457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2021 07:08:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 07:08:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 07:08:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 07:08:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 07:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg1D6O9Vqxff7khHQBIm6RY7bRDjsIsmpq7sFtPHqjLim3fpLw/HGMrfQzKmuSytPStTg8Fn0KXjTiqwknYEDjatPsQNbQasI/fmsjqX2uzbFedvejpTFy6lADA29AFxJPrzRx9gFWGoM4Z8roULcH0+5vhJ7jeUUNGIqXymM0hcCuGQ3G376avZ7E9L3Mp2F+/bOgdbu9Dw1400kWuJXo71lGwVrf48R8aUTbmaRfCRvFeJPgM2uVaSkkAliVKLzIfeWpamvtGB3CqKL40NVjSbhlXx/WcuSsPuZ+KdVeS3ezAr8VdAw+g8CV+wPGPfowPCKG1OYhrwHcYLu3Sx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFuA5/QeuJCFioCyUFaV/Plim1BRp3FYkUDyZm2u+XM=;
 b=YocmRkg4OrG6QsioQjhYpc+Zw8wKiGCpnH/ykAVUlhxWh4K3b5kgbvRE+ukXlKBk/hjm6wpB0Q5Vdk/kVOin9enZDlgmazFDQwhIM7Zm+J7CfS4ttq07ydT+VRlTesH8CuM8YciHTtQQ/ObiKSiiMvy6+CzPoYFreee4JRRtfvCFMPTbeoQ9nDyjTOZ8cwLUTbVq+nOXGBFh3+Hw1ClumppumFw5sK4zc53aicWsZcUqKZH5JYlynV1w0P146fgYzqsMfsFXRUPvMblIhib2XNyTGPM9zn5CVYMzM4T9L82JkbMU6pfx8uIHJeg1gwLRKacPT/GbSNn2R4zihi51qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFuA5/QeuJCFioCyUFaV/Plim1BRp3FYkUDyZm2u+XM=;
 b=JC5p7wl5hhnHL7WfZBquMNLPHbMEJA0EEeoxBkQxPvdK8WOSsBWPzTulH20ipJPFBe40IYXORmSRpEM4of8RySWeuSQ5YLE/h1T1igw8mUOOPLW8jN4AxHRXYx9FbCYRO6T1g6RMUD9FpPMRCZfNzaAPsnRPxXiRH6d4Dn2f00w=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR11MB1796.namprd11.prod.outlook.com (2603:10b6:404:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 1 Apr
 2021 14:08:18 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 14:08:18 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0IAAWUMAgAASa2CAAAjaAIAAAHQw
Date:   Thu, 1 Apr 2021 14:08:17 +0000
Message-ID: <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
In-Reply-To: <20210401134236.GF1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac2ab35-ec20-4861-695e-08d8f517997e
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17969400EA3F768005F66673C37B9@BN6PR11MB1796.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nDiygaKdNAeX+QLTmqoVYvcHPGj6V1naBefUbLboD1vLFsBay2SaMA+XcjNT8PjjbRjpLNCeF+6kVgAvV1VWso9UCImnEevYpFuXmpmJJFCZ5KLUrQIUCG7kdQVgtLMYhUF1awfMb1yao8+HogOoIXi3DzPoYy9tkMFaJRVEGluF5wiMz80Mx5kbWUXqmh1CEtPLIo3GT0VK1BmZVKmdKniuaj9h6mu1BCwhNxy+k6dN8cKGxWJCxZxqlfHPR8o2l+R6fDJ6Z98T3WlDqNjKcenyFd8ekaMQ4nloWeBemdRCI7k6OEUdy9JIXsAAgvpOwZybLx/A2ZpzyuOItPLMvgqi8D7FqJZYMkkC0ul/e3YQPWJ9Z/a7dO7yPRLbjLHqORYtvl50elZs9eFHTu1AQ33sftFquD+IAqTca+EX5qqKIkvq9b0jHryP5OU0qkrnQ22rS9OOlTM6ISTOn+n7EpM3eGg9bG8Db1oQOmnnJ/J0sI1PHuVoMsYvzPYyHOLTFKyaga5iGYHRxAHBvaYUWBnbDbTz1I5sc4khMFvMb1h3mXXonPDTsYORlvm6LHMyXEJFw4w6XiciD23Sy2YHXpci9EUm7K71lMsYA/MrsZiWlSivAqF1e8Wo0jX+XBvaxxkfWlf3SUzA0UbwwowQchWu7YS1BsLiqTLriOU694XN2LVFi/xPTwp9Oum8HyYkWoKQSr6u6ZTTXbOH1NAZwpsjEiQVB+xviv4rYy6l7XEP5WauoMfYnGzdSzQDfKq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(9686003)(83380400001)(5660300002)(38100700001)(7416002)(26005)(186003)(52536014)(4326008)(86362001)(71200400001)(478600001)(8936002)(316002)(966005)(8676002)(2906002)(6506007)(6916009)(7696005)(54906003)(66476007)(64756008)(66446008)(55016002)(33656002)(66556008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RYSin7oavo1ZfSY8dUNdPYzPVxAjG2rZa0EjZfR1kIRublytw77XnbAJePn4?=
 =?us-ascii?Q?NFL4N87OF82dZe6ZpMZAopjlmP+a+tJb6QKgNpUxqE3e/c9P6r0SxHtZRhhd?=
 =?us-ascii?Q?v/zOHpn4xkimrsUR/DWl1IwNT2ktR5T9RyhjG6x6gAucMDg7pdfQCkMLsARq?=
 =?us-ascii?Q?Dry/HMGz5Ufgjh0UJvBuMmxiYN0Jb33grjpLCVbRa1MeWx/qDA4yrs+1nkFJ?=
 =?us-ascii?Q?Z4gg+u9/MBu9uVCsec6tvJAwf9Zpc6WqlIrlOasEMqSoS/lQoz2WiFI86csd?=
 =?us-ascii?Q?WVJACukxtU/Y1J3RmkCRazQO3ZYsQajFKu953DIrai42XMv1ouQGlJOtM4Ty?=
 =?us-ascii?Q?Ij4uHnHVPhmkewwsDei9xlFsraMQkzu/lrW7QJA0JYACvH5lUgFQtR4q4BQZ?=
 =?us-ascii?Q?WRxea5BEqkE5jcEzTtGUnHI/EGmv25r/buo2ZFQyM7RhcWXGe7tCNBgipT09?=
 =?us-ascii?Q?X7FvYFuje1QjphfMvlVMhkmb//45okK6Dmq6JqEf4lX/ofz5qjpG/ySSSXPW?=
 =?us-ascii?Q?V81famsYXqz4fdIcRcaiwHi//How4bESVSLJrnyAq/fENOPyY6DxtKL8K0tI?=
 =?us-ascii?Q?tBUa/Lo46b53DlTV4kQK1/WmRk8kS9/E728ADLhWzaF+J9/K2xUi2ovPqfQu?=
 =?us-ascii?Q?+CL0uCP0kKixHxYFHKJhRMI8WxTDgRSN2/Pd7BsPHYc2ZbsspsOti4YoKqvJ?=
 =?us-ascii?Q?/jNGfCaVZ6RNmUH9qwaHmhD3KxXD1wsPrBejdBCnfB4xP9hjgzfyjN0bT4QW?=
 =?us-ascii?Q?4bOoH3JARUJs89g1ZghT2EYyVwgV0urdTY2N9PSFxq5NmX00HFvXdlcrKX4m?=
 =?us-ascii?Q?5i0bCx1AqJLKKH5GDz6nXXqlQQf5omY+L9L+2SO5/zCrVPiqtEFNQZInEyV3?=
 =?us-ascii?Q?xLXYQVfemRrSD/jq+TizxFeQhCh9BSpmWhH+jZjhyHHUMuMJnMCF1rAC6rLo?=
 =?us-ascii?Q?6X/vqPsms3edcreSyDio0fx7zf0fQj/3Fc4fc6aN6YGZ1BeB00kbGaPrbFNC?=
 =?us-ascii?Q?Sg5Mm2NItME2mj7t89Y6xs9AsS76zJ1XPU8dvpKip6gmV8a35FA5D3Hnzl/S?=
 =?us-ascii?Q?bbyvoKiu2HrMdTWav1cdAqhfSnO9CRql0bOp76mpX3MxK2n5iYd9PgzXv11x?=
 =?us-ascii?Q?mvWjIjrbWyCOy5u8OLakaonZcVVUdhl3yLOv38Jz52FiofxFmG0fHv/HMg47?=
 =?us-ascii?Q?6hClKppppuxQuvwc1d3eUuuTJCNvEFjKnQkT2ohcpbeN9tTisaXVjRnpZGgz?=
 =?us-ascii?Q?P1ok8w5Li7zNfNPFgSHJgAY20qymmwqnxhhTUNCFdNCK/NbDWgoGku4KbpHZ?=
 =?us-ascii?Q?i7UiOj1HHwLerj9P+ovHaEpf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2ab35-ec20-4861-695e-08d8f517997e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 14:08:17.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkDhNI7HUiyj7HDLt/trE6W+PEa7bRniamW4BbylmhjBQHvj87YNiF1UgObrDf3RZYSuIBSzRjOeobZW/opOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 1, 2021 9:43 PM
>=20
> On Thu, Apr 01, 2021 at 01:38:46PM +0000, Liu, Yi L wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Thursday, April 1, 2021 8:05 PM
> > [...]
> > >
> > > Also wondering about:
> > >
> > > * Querying IOMMU nesting capabilities before binding page tables
> (which
> > >   page table formats are supported?). We were planning to have a VFIO
> cap,
> > >   but I'm guessing we need to go back to the sysfs solution?
> >
> > I think it can also be with /dev/ioasid.
>=20
> Sure, anything to do with page table formats and setting page tables
> should go through ioasid.
>=20
> > > * Invalidation, probably an ioasid_fd ioctl?
> >
> > yeah, if we are doing bind/unbind_pagtable via ioasid_fd, then yes,
> > invalidation should go this way as well. This is why I worried it may
> > fail to meet the requirement from you and Eric.
>=20
> Yes, all manipulation of page tables, including removing memory ranges, o=
r
> setting memory ranges to trigger a page fault behavior should go
> through here.
>=20
> > > * Page faults, page response. From and to devices, and don't necessar=
ily
> > >   have a PASID. But needed by vdpa as well, so that's also going thro=
ugh
> > >   /dev/ioasid?
> >
> > page faults should still be per-device, but the fault event fd may be s=
tored
> > in /dev/ioasid. page response would be in /dev/ioasid just like invalid=
ation.
>=20
> Here you mean non-SVA page faults that are delegated to userspace to
> handle?

no, just SVA page faults. otherwise, no need to let userspace handle.

>=20
> Why would that be per-device?
>
> Can you show the flow you imagine?

DMA page faults are delivered to root-complex via page request message and
it is per-device according to PCIe spec. Page request handling flow is:

1) iommu driver receives a page request from device
2) iommu driver parses the page request message. Get the RID,PASID, faulted
   page and requested permissions etc.
3) iommu driver triggers fault handler registered by device driver with
   iommu_report_device_fault()
4) device driver's fault handler signals an event FD to notify userspace to
   fetch the information about the page fault. If it's VM case, inject the
   page fault to VM and let guest to solve it.

Eric has sent below series for the page fault reporting for VM with passthr=
u
device.
https://lore.kernel.org/kvm/20210223210625.604517-5-eric.auger@redhat.com/

Regards,
Yi Liu

> Jason
