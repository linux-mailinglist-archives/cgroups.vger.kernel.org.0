Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0B378F4F
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhEJNlI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 09:41:08 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:2465
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344405AbhEJMim (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 08:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj1NnvKNwCYO1rI2RGD4l+uHf+6GKE7ZqoTTZtKLIRmV1sS4m4RCIjQD8GWay3cPDjetcq+yDVHHJBl3kAZ2XGHowXDlnJQumr7FLUtvE5MARKTtakUQIv6DJ0v/ErNYSGcHOS7xUSCJTDAWZpUqmkTSiR5dCavrRpJw69qJP5DecTCXQV6gdOaX+AMKaDJDCmRz0qdl6ELjPrrTJof8EGccMnjLLWjESzh7Kp1UnbafU9gkJsUM4KC7gZZN1UYs3jmok8puDox7At1ejx1BITFvTbUrtaRi0y4mJHy2xLaXkR484Fe7sY/vYpHkVtKIXvMqWVosioGj1YI9XGz8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmSBoeltOk61etEly/jceX2euJwTSIY+oVLf7nd2Jk4=;
 b=PyzftGjShTXo6ZYRwIzAfrU6ENuhRy8cU/awzYkKwsKn/cRKexcAybHNagOsusIWGi2aL+OpJqDduZzqC7SxYpl7cje9oVBu88yGM41ZurvDYxcB9hp3CYi49ErhbnfwtoERI6BVsPqz9370cEQN7OZT2GY2PVARDjI7562aIYBM2Loj3FIST+qR4Uoswa/skAjdRF1ioFqnyMVlavLCOhbz2blPSyuv9uBwEluQSqgy7yCr0zUPbACRvtWWCZzgtAMX1wcl19CM8VJhGtkjbOm8GU/Hnl5qikoAWtJevgJ7DChAnztSqZIlmzJkVtKU4f66m3SU89oyUJ9rMXOaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmSBoeltOk61etEly/jceX2euJwTSIY+oVLf7nd2Jk4=;
 b=aImgd/qtrhpLbMoyieGcNkmxq2JfYWqPbmTZiwijZ4cZfEIUrUqSMADYAvgv+dICrQ2ifIG+HDEiSfJQ5pomE6vy9WWGGJFiWNpng9Ag4MBm2i0JNqEg0a3mDjEf5pyiEQkkrZ2xWyK1CbhnobaNFeqDZjC4ULenoDnssfCt3sFOG/Q7ycPJ1yRmog3CX92k1IPxhJDk0DFXkAQ9yqow/6EdDNgv7h8c2C2FvuGppqLTquppEKrlqJ3tO3bcQfhULySkN5KJ/xsODPzg+e0wVo8XA759lKdXWL7xT9olPdrmc0751r4QVA8Y2LIGm/hSXIwIVTo+YaR+wZs5h6W18w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Mon, 10 May 2021 12:37:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 12:37:31 +0000
Date:   Mon, 10 May 2021 09:37:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
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
Message-ID: <20210510123729.GA1002214@nvidia.com>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0040.namprd20.prod.outlook.com (2603:10b6:208:235::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 12:37:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lg5A9-004Cz3-Uh; Mon, 10 May 2021 09:37:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be5bb47c-b920-46d5-ff83-08d913b060fd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15143983B2BB31D0F525B269C2549@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA500uSrsH+DWqR362oF/vrAKuZyjkCLgs0IJzhmejgNXCherVUHhHtV1EHMEqsnqkN58uJGoqpRg3JINMDeRoEiMAcvhH2VwzrY+wAJAIoAW57Rgdo3GTNHoZD281a9WZtGC6rFCg0eU6c2zwka8FuUNdgSkgOZQs1a8w8G69c6qRWCacKHU7M4ALrm7v5cNoGIjff6I/ECIxGE0hz8xeOGH4PHsyWt2ITbilOCRspm6GTcgVJEMgytOWBv9zvNoc0Jv6T6WgT//KPER6ofgZzz2Y+G38/7+qrt+mx9aoS+iXX1MNjKVayzDAH5LosF4L4jTfztB1UJ7bTylWQWD9xSFtCu4KdDY138pQJitDO41snaahSUvlSN9nSf1vrDQVbhDI1r1Nn+awzji4BpGYce2VxXTkvqhVZfYb1kNNZTkbdaTV1CTL8zxlqsuUU4iY/fA4XdEut/C1DRMPHSCXIGLIbGAK3NqiRwGiPAdea5Kf0dHPs5cs4lH3dAnup4W3Pn7/B4zonlMULLK6+03R6tubwHGyxZabZF7MxGiTvxZyFHs7Ndl9CZIqfmRwARXqFX06FQzi1f3bUtvu4n9/HAzr2LPZ5sEY4D6g33QpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(54906003)(2616005)(33656002)(8936002)(2906002)(8676002)(5660300002)(1076003)(83380400001)(7416002)(426003)(9746002)(9786002)(66946007)(36756003)(26005)(86362001)(38100700002)(316002)(6916009)(4326008)(186003)(66476007)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xw9j7fgfegdFe5VmZshgZmkZyds2JRdCC6rLCmC+SuwPYFcCVyVIT2MyLEW+?=
 =?us-ascii?Q?nH2DO7vfGa+rkpTLI6c3Ngx9z6lPwvEuaTkN3Gw46jMDT5HdctuOMO0TQlHY?=
 =?us-ascii?Q?+tQxCTxKVAKo5Pe+qxBvbvVkRLqls9ZJxhRD2BXRYJw8aVqglD8UMTSYgu9i?=
 =?us-ascii?Q?gM/WsFtAB0OZ7Q0lMoE+oJeGyim3cLWBLgCdO53p9u5O7CduCMu/8VMWTmrY?=
 =?us-ascii?Q?VbOkWACCRAoqUT2wY85Gg2pOp7MrcqsPfzIn1bwusKImFV+wRFGEBKU9tzne?=
 =?us-ascii?Q?9fnxYzONgWCTax91zL/5jYXDGAaCi/QTwMPa6MXHrY5fMEb4UB5JTYs4XJ/8?=
 =?us-ascii?Q?l/cgogp5GaNTh26N5ZgR2HGyHd2+CuUlHLvcfbWEF+O2wdCgY/5o+YKagiRy?=
 =?us-ascii?Q?v/TDfN9+ECVF4GWW4u6snkuYrcwXosq2TdJVMwHc2aNkevOA33Dxy38Av+7J?=
 =?us-ascii?Q?5YtfrCC8OYiY3ESccqH6eqt6XWI+ln1MWWtF30KyQn8AzRM2glwe6nvSGvGi?=
 =?us-ascii?Q?5NJoAemEq5gaXtcZoHFxhhaizBr75+deqHpBjf1pJZp1K/+di7kq+++FCWXn?=
 =?us-ascii?Q?uu6bG9KkoSXFCxf2PkRneLng3ht3WAwTnyWBJSTzX07MDwhfWPi/Rie+gLEm?=
 =?us-ascii?Q?kUuzUHScpMNyYxN2ttxjw0AD/o+0L67GMkn50Eponf+Ho2ima3uMxLblw1DV?=
 =?us-ascii?Q?HDdKseq6vlXAmPACQ6f7ym9Z+QVO/GzbBX3F/SLWCQRyQjdVA1LnScotoW/U?=
 =?us-ascii?Q?Y7XCm1/ZVaYuLWcZAJ7Xo/jZQJwSWLDZpfOcsWepJCtExB2pJScBj3BR2Wm5?=
 =?us-ascii?Q?He63xAXz7WjLjTQrIbktYE4pZG141YOCzHHJxYWfn5NUBiPJPu6NYXLfYviL?=
 =?us-ascii?Q?yGuKfpvupzUP6vtbQKJ9o1MB9GGSUFvfQxkY0EQ71xjZeLOy4GZEfEq7dnjF?=
 =?us-ascii?Q?BeMlqaa3wnLdgxieoL0fEJ9uNtKwDtwD/ppty5sJCj0rQtPdWOT0jyJ8SzV4?=
 =?us-ascii?Q?9YMD+qI0W+LKKYqZ6SWZmDqz6Pq227SVCtaAd/JfLavE6Oi9jnW4bpRCO4aY?=
 =?us-ascii?Q?Ypdam0s40BUMdV6vxk/BzDiSMZirZ6n+K/80BH2aB8P6gIN0d7dBtkur0QYI?=
 =?us-ascii?Q?mPjYqOB67cJS5Bv/dMA6QtJLjzzNBnQcCmoHj4tXIspffMQu7i3sg7H9JbmW?=
 =?us-ascii?Q?CNXgIbZ1ahBlpFvcJbwZLb0FZraorvAgV2881E/VIxBK9n9l8jfuonsu6vTt?=
 =?us-ascii?Q?8VBYRHmOkFAUTKxVDahPu2PH4QlOhyohej3fe5hNUR0oE9S+UtK8rp5hD4+q?=
 =?us-ascii?Q?u1CUBxrOhtJci/rNByzfUO8B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5bb47c-b920-46d5-ff83-08d913b060fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 12:37:31.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW12gPYIkLjngTCwuORhU6D55D+n15OKJ5oPEZRGKm3gEuV5PANLiWdBHeNr6xHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 08, 2021 at 09:56:59AM +0000, Tian, Kevin wrote:
> > From: Raj, Ashok <ashok.raj@intel.com>
> > Sent: Friday, May 7, 2021 12:33 AM
> > 
> > > Basically it means when the guest's top level IOASID is created for
> > > nesting that IOASID claims all PASID's on the RID and excludes any
> > > PASID IOASIDs from existing on the RID now or in future.
> > 
> > The way to look at it this is as follows:
> > 
> > For platforms that do not have a need to support shared work queue model
> > support for ENQCMD or similar, PASID space is naturally per RID. There is no
> > complication with this. Every RID has the full range of PASID's and no need
> > for host to track which PASIDs are allocated now or in future in the guest.
> > 
> > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > global across the entire system. Maybe its better to call them gPASID for
> > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > wide mapping for ENQCMD and not a per-RID based mapping. (We covered
> > that
> > in earlier responses)
> > 
> > In our current implementation we actually don't separate this space, and
> > gPASID == hPASID. The iommu driver enforces that by using the custom
> > allocator and the architected interface that allows all guest vIOMMU
> > allocations to be proxied to host. Nothing but a glorified hypercall like
> > interface. In fact some OS's do use hypercall to get a hPASID vs using
> > the vCMD style interface.
> > 
> 
> After more thinking about the new interface, I feel gPASID==hPASID 
> actually causes some confusion in uAPI design. In concept an ioasid
> is not active until it's attached to a device, because it's just an ID
> if w/o a device. So supposedly an ioasid should reject all user commands
> before attach. However an guest likely asks for a new gPASID before
> attaching it to devices and vIOMMU. if gPASID==hPASID then Qemu 
> must request /dev/ioasid to allocate a hw_id for an ioasid which hasn't 
> been attached to any device, with the assumption on kernel knowledge 
> that this hw_id is from an global allocator w/o dependency on any 
> device. This doesn't sound a clean design, not to say it also conflicts 
> with live migration.

Everything must be explicit. The situation David pointed to of
qemu emulating a vIOMMU while running on a host with a different
platform/physical IOMMU must be considered.

If the vIOMMU needs specific behavior it must use /dev/iommu to ask
for it specifically and not just make wild assumptions about how the
platform works.

> gPASID!=hPASID has a problem when assigning a physical device which 
> supports both shared work queue (ENQCMD with PASID in MSR) 
> and dedicated work queue (PASID in device register) to a guest
> process which is associated to a gPASID. Say the host kernel has setup
> the hPASID entry with nested translation though /dev/ioasid. For 
> shared work queue the CPU is configured to translate gPASID in MSR 
> into **hPASID** before the payload goes out to the wire. However 
> for dedicated work queue the device MMIO register is directly mapped 
> to and programmed by the guest, thus containing a **gPASID** value
> implying DMA requests through this interface will hit IOMMU faults
> due to invalid gPASID entry. Having gPASID==hPASID is a simple 
> workaround here. mdev doesn't have this problem because the
> PASID register is in emulated control-path thus can be translated
> to hPASID manually by mdev driver.

This all must be explicit too.

If a PASID is allocated and it is going to be used with ENQCMD then
everything needs to know it is actually quite different than a PASID
that was allocated to be used with a normal SRIOV device, for
instance.

The former case can accept that the guest PASID is virtualized, while
the lattter can not.

This is also why PASID per RID has to be an option. When I assign a
full SRIOV function to the guest then that entire RID space needs to
also be assigned to the guest. Upon migration I need to take all the
physical PASIDs and rebuild them in another hypervisor exactly as is.

If you force all RIDs into a global PASID pool then normal SRIOV
migration w/PASID becomes impossible. ie ENQCMD breaks everything else
that should work.

This is why you need to sort all this out and why it feels like some
of the specs here have been mis-designed.

I'm not sure carving out ranges is really workable for migration.

I think the real answer is to carve out entire RIDs as being in the
global pool or not. Then the ENQCMD HW can be bundled together and
everything else can live in the natural PASID per RID world.

Jason
