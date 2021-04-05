Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16576354946
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 01:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhDEXfh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 19:35:37 -0400
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:3298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241759AbhDEXfh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 19:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz8UR53+OIF5kp/llIY9dumCYImxazPVAvegUnz8xYgJmgGzF3VZkbIC/QRJlsLSWhCv3b9NCPlH/iApgiVX/PWHHGEtrphJ1uJsAngpdhJIpkI8A72B+lrVRI4/Cqb52tIIkp3vmTCfxQetJP0kgK969/sQAl1LBusByHgt+AKCorM/4AaVe7TXkO/cbkot5sgf+n1BAD29sUFZbO7oH12vQW3uCdFDxIMJAsnOsVuV5QreYMPNZZ6RC5A+UUDguLEjktukDuUHa8R4ZjA7gt2eNIDyAa1VgOCJLE6sujZy/BIaTiGVVQQf3+rWMBYZXVE1G7QI6UL+Pt8Qn/isGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHeH0sFWkExFTh6x2tdl6HPZ4o0wuEQBFYJ59BhepT0=;
 b=V5z8Rw2sRuVunAcupVKCc25u9d9Ez3rIjBqpPXq+Gw9lYD2LwU68+p7Ig7uW/cn8TX0tNtixKCFtBQgrZtkxyc+mzPHvATWe5OmPeyzbRWm47EtwTAX+5LF1Qn5waxCwmuv5RARqyp3zE8ZD2oDCoTK3v6UdI8sr2yt/WKSmSD+cPO9fpIGRKCeLHq5xn/D0JKshgkTaImuh3ccfiGOuMcIDs7iYw/+mTu6q7VfQZ4d2PzgkOqppCqFkMXXK/GEud1E/+EwfFv3/3SW9yNZVA6m3b1cq6jgd5RO6QPH33r9CyR4Wiv4On2KkCorMkTARa7+c0j5qNEKgtjMNFcuuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHeH0sFWkExFTh6x2tdl6HPZ4o0wuEQBFYJ59BhepT0=;
 b=tHcqvui6u2rmDn4N3rXpq+IZR/Ch0OYuPZJgu9sS5svISsngOPZNzIdybLwgdChA2m35RX+ImFRcKWWHrzWaN4ybCOYCna+hCkskug5Xn0O2zLvf4wFYkBD7nMhkFUi6HJQCO0hXSH4Z3ojLCH3VhCV+i4inMXJq6460uuT25PDpnRq4yzpcMlvK/tAFMcLCwttFkXEnJVQ8jGRGm45AGYGe592Yn92TRpJU/57Zot63sWr5Lc7rk8Qa3oEfjPhJvN73WlqxMevKL4TukNHtV9spIrxVE66l81zxyJ4JKjwJBVfFPmwuBgNEJ+PNwjeDj7Iay5OJOeDUafvgmVfE4g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 23:35:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:35:28 +0000
Date:   Mon, 5 Apr 2021 20:35:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210405233526.GD7405@nvidia.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <MWHPR11MB18866AB35A13A139262347FD8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18866AB35A13A139262347FD8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:208:23e::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:208:23e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:35:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTYkg-000wx8-DI; Mon, 05 Apr 2021 20:35:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1026ab-34ed-42e2-138d-08d8f88b7e5a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29371E3CBD9D93E0C989E335C2779@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZribJxxj6M06NiJC9MWCKNhr+Nwl5ZS1fKHMMjvfMlSGJJTCA6bChih/cJG68YIrShk+Ta84Jlu9i7HAvM3VXrl5K6KH2N28DZ+RFrpFhF3n1wqLh7y/hgI/7azwixkFePscznnjdn/ifvMYZFQeNY8qD1ebl8tULBbhNeFqDryTBO4oTRMDGU5WxNUVZgiptXgGj/hr97MSRocMzmrQNCGqhSThzYHGSGujwi5tTV+ai9QoWGk3P1KKv4/oU+1nDh8rkahvpoDQs+Prv/1TmPr0YngIAn0hbLx7wxl6O+FDBPGF8mEd4H7XYYhtS7muqM2+VxuNSYMwWiUMiS2BwUZnkH3pHmpOJAWfMlpIZjApc5xY1CN/99t3stUIpg1F59Kwa7iMbaGgBcoqL9nR9vK4daHEbx2mqXBDSYalr6mi+MQ4C7VeYc3AzNrba8iuTeJWeCl+knMO7q3KdtjaYmqzMbXAKD3Xr14MnrMHlw8Ckg8ln+iXHarJEpOv5JgunCUcHKFBJuyK3dkyIUsRjMNs3MsOz0L5IKvwOF0/VwX60obWcF8CXwG5QjU6wuruiw9Q4uijMbsh/StAmcQRSvniYOXb4GwRYgAQ4VNqnBkS1cVwWnckADmmQh1KZak5j7Jk8WlQTD4+QSYNL7zAaa2Myy6tfTY5UoNmI/TEPJhLHJ5g5RdEHeJLYt40vyc2ST2tB+dbs4DJwuULtz10/eGhYw+HpAWiou5afCS39WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(9746002)(33656002)(426003)(4326008)(9786002)(2616005)(316002)(83380400001)(1076003)(38100700001)(8676002)(36756003)(7416002)(2906002)(966005)(26005)(66476007)(66556008)(478600001)(66946007)(186003)(86362001)(6916009)(54906003)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OOE62aX39TZRVoK+Glmv+mUvIS2Z99X51PoKawQpVg1clZa8Rbq5GlDS4yiN?=
 =?us-ascii?Q?Rg9pD1OvHjiKcy0r6yB2GbHPi44i9sPblTT9wpG2XaXoVGj+NjBy+4UGSfbD?=
 =?us-ascii?Q?lx4ImbIEXalOlixzxHIQXUb6f0FRCL267kNJhsyAJNfqPtHT6D6L7dgX7AmR?=
 =?us-ascii?Q?XSo0g6v52RVdDwFwkxNfM1t4bKtiR8Gu3K8hqfo7uV0+qlXyMhcQkA1ISoSh?=
 =?us-ascii?Q?msENrBvBZVuyS2D39F9Tudesuqqijk5KsgeyLfwxKXT0bTmOWS4TeBOXo2Tw?=
 =?us-ascii?Q?XcKLUuwY71STmkVg1kqqPCAYpTjTIVe5xFfASnE6dbNkd077NHgNzFbZHd4E?=
 =?us-ascii?Q?gPobhOrWAiJQcoG9gl/ZGu+H26GwmumZaMTMctah/WgT9Tw+O/0XCs4nju2N?=
 =?us-ascii?Q?KEFmd3GxvaiA3PSzdnxNsVC4X+EThFrTZXwj8kK0uu5IVnUOkUOweRk6gg+R?=
 =?us-ascii?Q?DYm4JhdNfKD4CMoHirfzkMeP4e8KRI+i6Icsjm2Ej/2zE7z62szarCNhUCjB?=
 =?us-ascii?Q?yBi7xTDEhKd7ioXpCYGrqd7SNcdRHtR28kovVPATL4hT7PoPmOSFCNKb0mtI?=
 =?us-ascii?Q?2xLwxvzE9kaC/JtIAL+G26F+gEMzWspmodG8rGfSxN+PDFvQGp/xEBiP8MSR?=
 =?us-ascii?Q?1Z1c1flt317fQq8kxbKd7FYTjruLUi6rNvxp3zlg4wqrDYzCP9GVLwoax4ZO?=
 =?us-ascii?Q?ujUAtyafRbg90XjgPQoBWJbLhEomTxg7dRIO1KPANIhgYRRhZiwWFnhQJ75M?=
 =?us-ascii?Q?AT3YY1BGbVL3tL2qqMsABZByjQm+a/D/5TNibxuxaEKYAIv+JvpFCN6OIvV2?=
 =?us-ascii?Q?pMHdv1+IJC48KGPTHXGt02T0r4bdicI3Vlwhcf1ql1kDfToTpvW3zypxKDE3?=
 =?us-ascii?Q?AO33kOPRR5yZbZFp8dp4cDGvhrEY8p9qSykGgTH10GTyxPKYqZPpV6yUz34N?=
 =?us-ascii?Q?LfCKoThdbNKXq2Gyxtlsoj33hv8fKgCHXSmUwi/L+xOm0PeL5IFmRZgAb9v4?=
 =?us-ascii?Q?pout0m35jFVIkpTgXnCm6N3FXAupmnfhVFcrrmKsF1wcIB60ioSZiT6zH4Bg?=
 =?us-ascii?Q?k6UDP/qC0AX6D3Ykf37dIxCHcNkBsx1QZJe1h8lHkpcPg4o4jMM2AK0jF15o?=
 =?us-ascii?Q?/CtagJ0ViYRZi1kkcXN1p5mUHHKi5JjaOcqv9Bm/67UBXUxIMrGtGAngFn4k?=
 =?us-ascii?Q?6P1ptRwzvBRYWyAtJHLpt0RSbBLQ4xRFgEMrdMBrLoDjigBxQnB/oVrzUj8i?=
 =?us-ascii?Q?AsLHZ8b91HHE2wNqh2XeGiykghQSV7cK9eVKBQLnEARqEzGx5ni+hcehrcbT?=
 =?us-ascii?Q?A1LIYBEuMfxTF3dp28HD8e6s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1026ab-34ed-42e2-138d-08d8f88b7e5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:35:28.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbJ3X5euoT8bCXfxnLCYVjgOzphKPTELhfl8wNw83h7uBeJvXG0vYAItqHF8SB3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 02, 2021 at 07:30:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, April 2, 2021 12:04 AM
> > 
> > On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> > 
> > > DMA page faults are delivered to root-complex via page request message
> > and
> > > it is per-device according to PCIe spec. Page request handling flow is:
> > >
> > > 1) iommu driver receives a page request from device
> > > 2) iommu driver parses the page request message. Get the RID,PASID,
> > faulted
> > >    page and requested permissions etc.
> > > 3) iommu driver triggers fault handler registered by device driver with
> > >    iommu_report_device_fault()
> > 
> > This seems confused.
> > 
> > The PASID should define how to handle the page fault, not the driver.
> > 
> > I don't remember any device specific actions in ATS, so what is the
> > driver supposed to do?
> > 
> > > 4) device driver's fault handler signals an event FD to notify userspace to
> > >    fetch the information about the page fault. If it's VM case, inject the
> > >    page fault to VM and let guest to solve it.
> > 
> > If the PASID is set to 'report page fault to userspace' then some
> > event should come out of /dev/ioasid, or be reported to a linked
> > eventfd, or whatever.
> > 
> > If the PASID is set to 'SVM' then the fault should be passed to
> > handle_mm_fault
> > 
> > And so on.
> > 
> > Userspace chooses what happens based on how they configure the PASID
> > through /dev/ioasid.
> > 
> > Why would a device driver get involved here?
> > 
> > > Eric has sent below series for the page fault reporting for VM with passthru
> > > device.
> > > https://lore.kernel.org/kvm/20210223210625.604517-5-
> > eric.auger@redhat.com/
> > 
> > It certainly should not be in vfio pci. Everything using a PASID needs
> > this infrastructure, VDPA, mdev, PCI, CXL, etc.
> > 
> 
> This touches an interesting fact:
> 
> The fault may be triggered in either 1st-level or 2nd-level page table, 
> when nested translation is enabled (in vSVA case). The 1st-level is bound 
> by the user space, which therefore needs to receive the fault event. The 
> 2nd-level is managed by VFIO (or vDPA), which needs to fix the fault in 
> kernel (e.g. find HVA per faulting GPA, call handle_mm_fault and map 
> GPA->HPA to IOMMU). Yi's current proposal lets VFIO to register the 
> device fault handler, which then forward the event through /dev/ioasid 
> to userspace only if it is a 1st-level fault. Are you suggesting a pgtable-
> centric fault reporting mechanism to separate handlers in each level, 
> i.e. letting VFIO register handler only for 2nd-level fault and then /dev/
> ioasid register handler for 1st-level fault?

This I'm struggling to understand. /dev/ioasid should handle all the
faults cases, why would VFIO ever get involved in a fault? What would
it even do?

If the fault needs to be fixed in the hypervisor then it is a kernel
fault and it does handle_mm_fault. This absolutely should not be in
VFIO or VDPA

If the fault needs to be fixed in the guest, then it needs to be
delivered over /dev/ioasid in some way and injected into the
vIOMMU. VFIO and VDPA have nothing to do with vIOMMU driver in quemu.

You need to have an interface under /dev/ioasid to create both page
table levels and part of that will be to tell the kernel what VA is
mapped and how to handle faults.

VFIO/VDPA do *nothing* more than authorize the physical device to use
the given PASID.

In the VDPA case you might need to have SW access to the PASID, but
that should be provided by a generic iommu layer interface like
'copy_to/from_pasid()' not by involving VDPA in the address mapping.

Jason
