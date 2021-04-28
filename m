Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99636E080
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhD1UrI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 16:47:08 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:55904
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhD1UrI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 16:47:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2D9tPDKMugaIFPrRbGp25O5k1H/Kp2cavKEpCFkQ35WYjgAUze2q7UWWiYIaAYN6/3ZiYoOMRB+DiayTRCTHuoNkvR47MegnRKJsL/cLG2v08636uHjTs/OTAUYxbHIaf54gAmcbFPNqcIetnEdobgEzpqfdYZt7g9f/ZmNVGFBAuIBaVyYSmR9qNdRiDDuBQY58N/TtgcGz4qBbtU8gC/uApgWoVzQ0fTvHrnLJSVap4dv2NTKB1FvUCnzwJ/FsZfPOU7pHwNQWCWNp+/t/IVgqYgQ5tp9TS0dIkzgROL2xN0Ls7yvU6EvGGHHjbRtTj9boSwEiqjXFEDAW2N03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fKpv9xAO7yDUmDQhi8eE8dYVFyldocMXHvUmN6E/Mc=;
 b=Z2Md2itxfePyUmCyen7btdCSZzWHhxWEcupd7DyzgAlIRmak4HI24MEQLtq1zegxk3UM6km4lLVRq6z45ZqzKKYq7/fNN8ORTq1AONuKkNEkGJpdvuSa0ZFs/hqXLug5Ry3d6DyBWl9PHC7GtQaJNvYuXU0pVPYcEJp662DLWifklEDxqrMP1SxEgMHC98U75DHJLTGUG1IopIKZNIakV2R6SSGfkngfvg5GqYelHIibSxadvBmgJ/BcsBUn+stRMZkPCPufgs+S5fA8YyeRDUWa6/pkj+cgX6LLjVM1yXnUkcE7dekk+s+7JehmEctBswynvPAPGN2oSSDaduDVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fKpv9xAO7yDUmDQhi8eE8dYVFyldocMXHvUmN6E/Mc=;
 b=dWUZedCa9MtKeKcKPCiXEQkNS/LHsw1r8ZBTtkRhU33wV7yZYwpbROnaCgmdP27dVqgl5iepVrK7QmRjaB5aNz7Z53OktyBK4rkztkyhMosn5VgNBRzOfWSVg/u+j0YxDC4/1yT+3caWKAPeH+THRSp35+2511/Z3r45gAjvZqbZgi5qfAu5ei2Yz4zzZ18ueJBSkZf7zOYAtHjCD0lGBxENRpGIvTMsOPNdwXnvjAvBlc51A+KC/TbZVWPwXjNY3X/xGBXBk+BTCLOF6OZ7+qQEDvXRqY5+KQkz18P4yE6UAMILhyQlPtxc2+XT5ns0K5n/VXWPlwB/S+fR9O6BDA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Wed, 28 Apr 2021 20:46:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 20:46:09 +0000
Date:   Wed, 28 Apr 2021 17:46:06 -0300
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
Message-ID: <20210428204606.GX1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR05CA0144.namprd05.prod.outlook.com (2603:10b6:a03:33d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 20:46:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbr4Q-00E89B-Jn; Wed, 28 Apr 2021 17:46:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2fc2089-2c69-4f03-c2e4-08d90a86a6b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB154718E83A3B72560BDB85F2C2409@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXV2ttneIwH8M95RwucNI+B5U/wNThfioCLm5Qcrkh29Xv1xjbEvAMX87ryhw5FUNAMJlPqSzf0eSmBcRe6CKudel3USs4cKHMEtaie9qvk2V7u1gdt5C4PZIReCiDaIMtD6HnypXNyS+qAkUUTu90B0xD/b5lWHg2/JNQg2WVteblNILj3OjTnk1C/yZan14At5kBq+k1f+j5nlI0z42bn1KvIa9csEtQ4XVuScL1gZcrV3Icj1aJuzSX6EfWrEeHrRZBUuX7Lnbhlze3Hs8RkZR23wTQkCYrTTbs6I832znhQBY53PTMJm27aFL80iMIcQyZTKqqvnydolnqVwx6GZnjPPiQKKMg/JwrXvpmW1mU5Y4wsW5sV5X81wNZ01hgdgZpghCcnN0t7xSkQUhNZV13siO7564frXLBfEozA320WMcM4lPz89MyMnfz3qtXiUgr7Fy/Ys3iY9TqqAwzLHRxtEF6TSqAa4zv8PhOwlOaOKcJRStRrKWm7pB+mRSO2xgBA90zH7FJNIx0LjeDr/WYQTxvL9q6G8nwOZ0AVv9u4uv+b2YRxPM1inWWfBJEjLSUMx/wamKF0gAUVLjU8VOL/6xBSGjRJJ4PFmRrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(6916009)(426003)(1076003)(7416002)(83380400001)(66556008)(26005)(316002)(66476007)(186003)(54906003)(66946007)(2906002)(478600001)(38100700002)(33656002)(36756003)(8676002)(9786002)(5660300002)(8936002)(86362001)(9746002)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmFTSWw1UFo1cFhFZ0Q5UkhJbXRYUmhZSjlJWkJINXo4aXVGbloyTzZ0Q3cr?=
 =?utf-8?B?bHJ4VVlGYkh0MEsxa3ZCZlpKcXFMWkxXRjE0TjZZUEJ6bWM0ZzJpQ2dCVDh1?=
 =?utf-8?B?S1NNaGhpMGU2RHV5OVp2ek45NnJwemp0UEVBWVovVW5mS1NjK1hMWStXK3RP?=
 =?utf-8?B?UFFkMUZGTm5CRm5JU20va0pmSjFWWDFUbWhneHVqSkkvSVREYjB5YmhCZmE1?=
 =?utf-8?B?MkRuQktCRjRtaGxyT2FBSFpGdFhnTXJiU0FRSWNObklSLy9iZ2xDZVkvT3pm?=
 =?utf-8?B?ZEpvaHhNL2tTY3dWczZFQWVaYllYOUNZeG9LczZCdDVZRjNYUGYzcXp3UXNw?=
 =?utf-8?B?QWVXc0gxOUZkOGpkbDgyK0VWd1lxYmlubm1vaERmc2h1QjdsbHlCaHlVQUhU?=
 =?utf-8?B?RXZDaEo2bnpCMzh6RHZMUDNGVHZaRGFqQUthYkRDaitpTUdTU2lWVEpsTGI3?=
 =?utf-8?B?RlhsbmdNV3ErTHdyU1hYMnptY1M1N0RiUGNSZ0dpRkhXNVoxTU1UcElDSHEx?=
 =?utf-8?B?ajBEa1Z6d1RycXRleUtjUlh5dHNnOFJPdkladVpIb0VadzFod1h5Rmo2c1h1?=
 =?utf-8?B?T1JLcGNDWXg5STNMdEdBTmJYUXJaQ0hDU1dhbFcraEtIR0djVUJBcTFtU1dW?=
 =?utf-8?B?dTVYZ3I2STlHcTJ4cnBuajdENXlwN2ZVNEMzM3R0RE8vY29Va0wxNHpuVmpT?=
 =?utf-8?B?c2RNMGhoVlpySU1zaVZtZ2NxMHZNT211YWhOMzdIYXR0QTlxdkpCbXd3RTI1?=
 =?utf-8?B?T1F4SGJScjhZNXZxb2ozOGkxS3BTSXQ3Sk51VEtvcDhSNTdZLzdaSnd4Y0dU?=
 =?utf-8?B?RmVDODZlYisvbXY5MjZza1p5a1NMUzZtUXExMlQ4Q2RmcmJ6NHBtUnJHRlVM?=
 =?utf-8?B?NmFFWTRDbDZPMFgxR3g1bXJwWDV2YnBwZVhRelI3Sk9ZNlRFSFFrRnpkVXY5?=
 =?utf-8?B?SzVMcm9GVGJkbE1iaUJweXQyY0l3RkNQVmxBdXhIbGo4VWRoU3ZVZGpoRzI4?=
 =?utf-8?B?NXFaOGtiMG4vWWNsUnBTdlZ5TklUZHZVSkRQTVo5Q3BmWnJrSDJzSWh6YXZJ?=
 =?utf-8?B?UEpFWjR6VGdaRkEzQjM5S3hmeGtPcXQ4N1o1WFVNUE5UTlJRUjZhRjBaK0Zj?=
 =?utf-8?B?RzZocXZsbUJNTkQ4TmthbnY2aVNYanAwSDNMcXE2eHYvcGlWTWhaSmpmMVJa?=
 =?utf-8?B?Rng1c3RldUpBWm5veS9iQ2JVV0R6TWtrbEw3QWNMeFg3ZHoxTzhERUsxWlQz?=
 =?utf-8?B?MUM0QTNla09MbmcvbWpyWG81MWFTRG5Zc2ZkRis3c3BuMURkcit5d2JVKzRW?=
 =?utf-8?B?b0ZadjQzSVd2alRDR3FSZTdJK1BFY1dqOVJPbzR4SFBzTWxXM3pRNmwwaTJE?=
 =?utf-8?B?UC9EZnhpZ3pIUTIxMW9mVk81bzB2OGphSzBUS2UxOU0xOU05Vi9iMElHa2Zu?=
 =?utf-8?B?akxIMU1kd0xSUHloMHAxVy8xTzhTdmdobjVQZGE3WVI3Wm1vT0lUeGFLSmRR?=
 =?utf-8?B?aGdNSnUrWUxnUE1Sek90WU1kak9wRWxldUJkZmlMVnRXZExLZHd6MXZvUW84?=
 =?utf-8?B?SzFnM1lHUlE1eWxmN0VEeDduNTM3akVvWEV1VFJnRDNWNDMrem5uNlpCMCta?=
 =?utf-8?B?QTRZSTArZ2hsYWZwaTJNRU50SmN5bWRoRjQ4Vnl4cXU0ZWtBOEpFNXBlaTdm?=
 =?utf-8?B?VEEydmtGTEhKTldaSkhzWVRPc3Y3NktRNHVERXFLT0hRM2xVaThHUnhrcXpP?=
 =?utf-8?Q?2e1iBr31dWte5XoX2ySV9XpyIfhfUPynGRCg0bL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fc2089-2c69-4f03-c2e4-08d90a86a6b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 20:46:09.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdjcX7ybbIeXgsZjrWSqG1AeDQxG6ujYTHHbdq+8ZmOYA17KPLiymF8f0X696yjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 06:34:11AM +0000, Tian, Kevin wrote:

> > If /dev/ioasid is single HW page table only then I would focus on that
> > implementation and leave it to userspace to span different
> > /dev/ioasids if needed.
> > 
> > > OK, now I see where the disconnection comes from. In my context ioasid
> > > is the identifier that is actually used in the wire, but seems you treat it as
> > > a sw-defined namespace purely for representing page tables. We should
> > > clear this concept first before further discussing other details. 😊
> > 
> > There is no general HW requirement that every IO page table be
> > referred to by the same PASID and this API would have to support
> 
> Yes, but what is the value of allowing multiple PASIDs referring to the
> the same I/O page table (except the nesting pgtable case)? Doesn't it 
> lead to poor iotlb efficiency issue similar to multiple iommu domains 
> referring to the same page table?

I think iotlb efficiency is up to the platform.

The general use case is to make an IOASID for something like the GPA
and use it concurrently with three say three devices:
 - VFIO (not PASID)
 - VDPA (PASID capable HW)
 - 'Future VDPA storage' (PASID capable HW)

The uAPI for this should be very general and the kernel should decide
the optimal way to configure the HW. Maybe it is one page table and
one PASID, or maybe it is something else.

Allowing the kernel to choose the PASID once it knows the RID is the
highest generality.

> > non-PASID IO page tables as well. So I'd keep the two things
> > separated in the uAPI - even though the kernel today has a global
> > PASID pool.
> 
> for non-PASID usages the allocated PASID will be wasted if we don't
> separate ioasid from pasid. But it may be worthwhile given 1m available 
> pasids and the simplification in the uAPI which only needs to care about 
> one id space then.

I'd prefer this be a platform choice and not forced in the uAPI,
because we can never go back on it if we see that yes we need to
optimize here. I understand many platforms have different available
PASID spaces already.

> > Simple things like DPDK can use #2 and potentially have better PASID
> > limits. hypervisors will most likely have to use #1, but it depends on
> > how their vIOMMU interface works.
> 
> Can you elaborate why DPDK wants to use #2 i.e. not using a global
> PASID?

It gives the kernel an option to make the decision about the PASID
when it has the full information, including the RID.

> > I think the name IOASID is fine for the uAPI, the kernel version can
> > be called ioasid_id or something.
> 
> ioasid is already an id and then ioasid_id just adds confusion. Another
> point is that ioasid is currently used to represent both PCI PASID and
> ARM substream ID in the kernel. It implies that if we want to separate
> ioasid and pasid in the uAPI the 'pasid' also needs to be replaced with
> another general term usable for substream ID. Are we making the
> terms too confusing here?

This is why I also am not so sure about exposing the PASID in the API
because it is ultimately a HW specific item.

As I said to David, one avenue is to have some generic uAPI that is
very general and keep all this deeply detailed stuff, that really only
matters for qemu, as part of a more HW specific vIOMMU driver
interface.

Jason
