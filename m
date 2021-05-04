Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC44372E21
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhEDQcp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 12:32:45 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:33633
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231744AbhEDQco (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 12:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXFwdCe+oZl9UCO3DQtKpk3alHpbc4qEVSjkCvK9A7T2Vx/sSIDHJI5cDOJS1YIkGm6a9HAO1nmVCATFDQ0fPLxcjW/rmCvDzJMm49Jrc1fDi5XSThBgz3be07CdfwJ5Dq/EjWBnsQOTM5Qq/i6eYlGJPMyYOXqTQ4EgJYeksL9Mt8HBUxQDR/xzq10WFZwaAqxy2ONwhT1BkrE9SkTzevBsx/jP7j2fdcf4RT4fUi8PjBAypQNsIwU6xbo+N2h96nLH20SlYCgrErdo/Ckh/b9dggfDRtbCouzo7k0QJqm/uKrEOw9AK4nUvt85TgUThoC+n91JPqJeDJ0nEs9C/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O2DkU3YtUqQE86orQx8Gn+mwJw0fU3SGUHkiEbFIds=;
 b=kjf0RV/vt8KqP0fwALG2mwHl3/IA291j+itRJlIBCDASP847eM9JBro0mMEQeysgvPtqSieDLhUecIMZNLUiKF1tOOYguGARGumWBU13MtqguwvDp3dd/LziOpP0opiCVzTtSy2NKr2Woojleu55zFUvqewzdJEInKpH7tDSl0rOrDKTNZd9Z0WvPQwy23cDYqjlrkZ5f+HeASWLPPr175aMwBNAhVcVAjgExSVTqJTjToC7o0CeokTiPRHXktwOjo4b/HY+82dBi8w06SwbySuiDvnbV3GtCciiObgsgD5UFbdtFdnolhOKRo2WDB8UWniWIMICpe1sit9ixqwo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O2DkU3YtUqQE86orQx8Gn+mwJw0fU3SGUHkiEbFIds=;
 b=BElQBjp74MZc8ReP9t3/VyPRTjx0c7lu7tcmAcu5Dr8iSRDQP1WoF4/b/dcDx4E/Qtin+UO7ft604INf6XvlyKIPd6t0tQYsKyfTnG8UjsLJZ1N28Mom6sITyxZ844oWLMumd6X/Y+DFfYA3uRO36HG/nJ1h8x88rXydedr9TvbNxhgRLAL/XYjgvFp4b5SNRmvN+14Z31l0c9PKdiyHn9101rGZtDk8KYQsPw8vcoxDM63+QpvkSAxmBYqxv03yEf3H0LE1FH7/d8utX8Sa1C1HM510HVkAI9KdLiGPDfsmmd62fbZjHfeM5b+Fy11MwHN7IWO15d8taIthryteWA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 4 May
 2021 16:31:47 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 16:31:47 +0000
Date:   Tue, 4 May 2021 13:31:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504163145.GU1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428204606.GX1370958@nvidia.com>
 <20210504092255.76c387f8@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504092255.76c387f8@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:256::23) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 16:31:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldxxZ-000RAF-Hw; Tue, 04 May 2021 13:31:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1aae10c-c672-4dde-f67d-08d90f1a1c9a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:
X-Microsoft-Antispam-PRVS: <BY5PR12MB424163CBA3F092D86913E163C25A9@BY5PR12MB4241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIfNxc8dFBzTo1bnuV9Plt4p5YYgN5TO5ACj7KUdGUgPyq9OTkxfrhKq+xWI53ACFINTH9XuqR35MOB1ZhDoGkeM4oDV+hvBazwDIduCYAnyVncDOjs5h1Qkv0WRP+fe4UBF6OGUmuenH1OnHmoJUIhLBnwsve8/FkIuJsQ0cjQInKRSzYGqE8HUfiZR7lbs0nQMfA6NWRgBy09eFVaNRfuT8fcezm8H5AkrMSAvdn+kVFx9nLK0ZekAqTsBZCRhMViLmHnr3uQzt+CVE44nJMkG/QIJ4/+47jwgLz/0XQV6FW5bk1vwh7d1xHZzZCk6IHSoXKLOQuyOObmMNOofmRJ3AuaJIcwDrwlGDw2H+jqLJq0Ol5FCzNAiiREvzKr58ALVLNUdGpayvGepalq96rkW3HoHHgFjJiOxQ/ePwSxeVcp9H6zBzgmv+gDnn+tEhzvHMT2ec8AMKAWvXhEo7WQVX/f1qcT0pILuQr3giZDnx5WSVnPOywPzjUs25jhwS06PU6p5KpDBJVGIoU8cqkcoNAcN3ar3pVEnDj7WUoOOt1xUycYhGNtBpyxvrP2FqyRrAa2TRVoLbFfhvOemwxiQWFz6okXQqrgRYfFuCMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(38100700002)(66946007)(6916009)(2906002)(5660300002)(66476007)(66556008)(26005)(186003)(426003)(478600001)(7416002)(8936002)(316002)(2616005)(9746002)(8676002)(86362001)(4326008)(33656002)(36756003)(1076003)(54906003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mydIjh5YQxEaSIEivDI+tYfJOdWSzL3ZMmQ7UxOd7KRuzIiuNTVkVu5cEC5M?=
 =?us-ascii?Q?SJeh8o/Y58ZDvQtDyAZwVEEn+/X737qwRZjOrzgtVRrSHbJJbFS6WBGpo3dF?=
 =?us-ascii?Q?nvcbHa8aQv9pAfnkvw4SLD304VZMrRfN5u0KCQ97QGzrYlv/pUWnJVxIlT1O?=
 =?us-ascii?Q?nF9AtK6BDrsaqRumll8SSXT5tu4Qim93FkAmtZPoRDjbXaJQ7O8Geqyi/9tp?=
 =?us-ascii?Q?XukfiXIYEzzKWGHHl0IIKIQw8+hd45Yru0x0uRTTlduy/NeVp/1VFL7A9eZu?=
 =?us-ascii?Q?N9Y9UP2oKAxCCktcs6L549/QpRF9jg6MbmyYcNFUQQZOOr0OweyTYMBkZkDu?=
 =?us-ascii?Q?NO3lqntCiRbE1tBW4AQwUlWlVbxT4aI+Af4OohlzVtE/qUDmWRJtZdRu9vpC?=
 =?us-ascii?Q?133k4C6hNpKrEoI08M1BO5Eov5vNg/jpb+//Da3T0eS+CTbeQD008x4c/igt?=
 =?us-ascii?Q?DPTyn2N6esYjNx+Uc8dbX9TCbGtJlVZtJq2RBEgSTJ8uzimCZ8ygBwzr6Ywr?=
 =?us-ascii?Q?dyj2k9fy+qgJ0Z5ppOgs7mv87/lU1JLIgGqZsFOKdE066NUNPBJU70BBiA+1?=
 =?us-ascii?Q?tamb34TTMlPdzPZ4oN35TWoQ6Ba0Ny1oBii9JU0un8B6VEUjateh1fg4jIWy?=
 =?us-ascii?Q?1xra/9zctPAWIXibydbw4rWIZKSUNOeungu2uPdloIUqI9tIiFVF++l8+tl6?=
 =?us-ascii?Q?4Onxqt6OBw9o9L/RhIYTdtsKsf0nuvNEu/1xSM9GI0r0u10z+QCVCaZoGC1p?=
 =?us-ascii?Q?faVgJv//PVAvlienNVqW0s0VtastyMG0uUcx9Ut8MXTEkeovVhp8F682zzEF?=
 =?us-ascii?Q?EU7FXSZMtyM6Xuq3ihZc9I3yn9leRHdjNwE/VQBUH93be48/XWBRcDY37Oel?=
 =?us-ascii?Q?0EItLNlf+vyMiVRz8ak30qLT1B0x/IzufMzGOSrBd8TUDRwscM/ZSe9scWuR?=
 =?us-ascii?Q?JlWJyraSS5SBjOUGA6g6H9E1O4R0cBNqdMq911RMHcSgwhqZAuzLINWumh2Y?=
 =?us-ascii?Q?Nuzwb8L6j/pvUgNvvor/ye81COUwPnSbM87xWqGi2+7/t7chkuz3KBhPJlq/?=
 =?us-ascii?Q?cPMbC82g3ouJMzzfuBu5uzgnQhOfC/kQVi1TmI/6pFp6UNucPENW6mLvtCx+?=
 =?us-ascii?Q?cvbicEZ+F8Asb6RNMfSoFrVdDq2QwdE2Z7Lot2hPvSR78Lgp3cUruXK06Led?=
 =?us-ascii?Q?vRB4X3tJ8SSH3vIBldhuR3kq0RUSiS0C1srlKxR3SNzaTtIu1NTUPrETwJam?=
 =?us-ascii?Q?eUo54TLQ74kbgIeTldGvxfh3pExTm0AMX4Ozlc6Z/ewhxG46qdHRQWOxJqAl?=
 =?us-ascii?Q?a9A7FbfRQtOT0Bk+NcN1VlRw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aae10c-c672-4dde-f67d-08d90f1a1c9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 16:31:47.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZTbqUqBPVaOm0gcTie4BYe2Ke+K6ZNz288TCg+a1N4Cgg2PXJL0j2W18oVBIfNB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 04, 2021 at 09:22:55AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 28 Apr 2021 17:46:06 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > > I think the name IOASID is fine for the uAPI, the kernel version can
> > > > be called ioasid_id or something.  
> > > 
> > > ioasid is already an id and then ioasid_id just adds confusion. Another
> > > point is that ioasid is currently used to represent both PCI PASID and
> > > ARM substream ID in the kernel. It implies that if we want to separate
> > > ioasid and pasid in the uAPI the 'pasid' also needs to be replaced with
> > > another general term usable for substream ID. Are we making the
> > > terms too confusing here?  
> > 
> > This is why I also am not so sure about exposing the PASID in the API
> > because it is ultimately a HW specific item.
> > 
> > As I said to David, one avenue is to have some generic uAPI that is
> > very general and keep all this deeply detailed stuff, that really only
> > matters for qemu, as part of a more HW specific vIOMMU driver
> > interface.
> I think it is not just for QEMU. I am assuming you meant PASID is
> needed for guest driver to program assigned but not mediated devices.

Anything that directly operates the device and tries to instantiate
PASIDs for vfio-pci devices will need to understand the PASID.

> User space drivers may also need to get the real HW PASID to program it on
> to the HW. So this uAPI need to provide some lookup functionality. Perhaps
> the kernel generic version can be called ioasid_hw_id?
> 
> So we have the following per my understanding:
> - IOASID: a userspace logical number which identifies a page table, this can
> be a first level (GVA-GPA), or a second level (GPA->HPA) page table.
> - PASID: strictly defined in PCIe term
> - Substream ID: strictly defined in ARM SMMUv3 spec.
> - IOASID_HW_ID: a generic ID backed by PASID, Substream ID, or any other
> 		 HW IDs used to tag DMA
> 
> Is that right?

It is reasonable. If a IOASID_HW_ID IOCTL can back with a enum that
qualified its exact nature it might be perfectly fine.

Jason
