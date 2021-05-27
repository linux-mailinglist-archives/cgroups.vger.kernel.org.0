Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BB393594
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhE0SuY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 14:50:24 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:32992
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229712AbhE0SuX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 May 2021 14:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXQ3e1BKbl3juebtGya39o/NqWFaqneFQBwadeDmxgDgzxGLKuX294E8TZHS7tNIN6aGe4YOj8x11N9GFpQjrMedvINYRax1W3jF1OMF7FITjU+Uhz95BkZY9gtLH1vyQmbK0rvWAdWSENwAhuAncNLoo9f9xW5EFoYZSoDh8aDrnr8YW6pov6/SWhPGuj8/FSVxZTA43gqTYM64+UektM/EzCFV7PN2Fo5/VxuiyvzkPL0tzLWHA0+NSA8wqKkAATxFatzey/buCGJ0SBmsNR8eiSFerDGD8bl7+vFalq4zNOR+dT+NbcKyVVxi2heauGP76knZ/umwrrJfih/BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6//VIa2BaCGORurVByXULwENHNPJ5o8kKLVhL9oep4=;
 b=M4B+x43/oSNAzhThSTOEd/jGP6zAduq7wx8LyFxxHGlPpjdG9tlffF8zulqMYimzBNEUCz84t4Uam51UaT4bvpXa7szT6nYq3YfnSaK6Wz2+qx4fcutaWZV1TppYvg8pj5Qg3dNv6NkYBzB7hmYaqN1B0iDZJR8ifVZHGCHeFzT/AeTve6chTsuCMI+fnDfrzcdnIx7vRpxTgbdSLqY3p8bli61TCfHMujZ0hh8+D6ttpA67+ESIZUN8EikFEgduePlZJEWz/TL9AnxCFN/AIqBtB/1/tAwdrewT3K3DXcu7oCfWnPkyPSojzuyCeKJ47txrseDt0v1E8w///lg9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6//VIa2BaCGORurVByXULwENHNPJ5o8kKLVhL9oep4=;
 b=G6k51McGj8dCrzwErU9L0DAuzhCGK5S7HJdexv2Kn5+STdw5i0ahy7GgCjO1X8iHt3M/IItxXvAIQ358C0I4vT2VRu5LU8EGDMPjLmRuD1h6X0PTYVvmMuzHFnEoUt7IDeWT2XAr8MkI+iffBqInjIvUSpDCReC75fCtRM6jzxUsePhSLBfq/SPcnqGvbiRSCyBNAz7577YCbp8FgIZohSI9b7MTlu23MBXSTwUrG8nkC40PPXrfnXBAaHckufyeulLZ1JgottQIy6my++06S0tl/Tsym9zzlNrF2OHZv2BKaDnUpmVKbnytHxAhWOjO7CwZa9j+SrGnjb5aANMZuA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 18:48:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Thu, 27 May 2021
 18:48:48 +0000
Date:   Thu, 27 May 2021 15:48:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <20210527184847.GI1002214@nvidia.com>
References: <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <YK8m9jNuvEzlXWlu@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK8m9jNuvEzlXWlu@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 18:48:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmL3n-00FffV-61; Thu, 27 May 2021 15:48:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6488dd5-e07f-4a67-4891-08d921401028
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51428B6E2CACE4AFBC5576D9C2239@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ae8GHKroD3/u2sTbCbUX64GQ4/WFzVc0wD2KWxNqBeIBoSwxG1N6sceGU+N+i7VVnqUtU8BGQV1k42CbpOhH4EVQ63Gb2jmvcA4obIRXgae9aVUZW9smdRHJDO+QEZv499GX54iM35QoUm7H+D0uBGSqMOnqyPtqK1lTC40E7NtIzW/7YNoBcW7pL0TZdB0oBLtvPIpGbSKHNPJXCrKkJ0n3mPitqYSo46Hswu4M6FVRrN2udtz2c0erOMAgdAwHUg8j+gpXLfqz8FK63X3bMH2AnCqsWitskUsQhixss42kgoVzlXFi0yhvOu2UWs0Cv0Or17jYxcJqyqnho3q5gg8R1cvm0ynkCixuGFiJDJJSGA3qyhND6TxyYbEcDOIBOtTI7V56hD09v/EbH2buhPcj42qoF/vlSVQ4COP0lUbredSHSVNtffL9LyBSKX95oYYC3ZAUb4Z2SXDDCTC8FxBaFZvTR5+NarjrGmHO15dvQXd+VWOzEUJNbgrDTbj5sJmQShEqyyZIMDI0w8e9tEiGJNgC3BUMXFXLigXJjmtpphrxOoUaN45/+6eIELQAMwsd9XUHg5zKKB591jZQUf91WyQbv/nFImnve50CGhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(6916009)(316002)(1076003)(38100700002)(66476007)(7416002)(66556008)(36756003)(186003)(86362001)(478600001)(54906003)(8936002)(66946007)(8676002)(9786002)(9746002)(2616005)(426003)(4326008)(5660300002)(26005)(33656002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qkRmIHp3LhN+ueDhu1vvDqR5UXSWLk33FLd9/mPnisgfDV8futkMnpRBanTY?=
 =?us-ascii?Q?pvjBDFAxP8IiSNT5wovk/mE7WuA/NAfcAgkv3mwSKAjelAE5P9V7GCtbsC/Z?=
 =?us-ascii?Q?27sXg2jb0PI7mdsEfiLSCEoOU8CZjc8G6vfTKIl9dA4OCJkmyT+WypXy7j54?=
 =?us-ascii?Q?BiSyZQOGSoJKz5p6m5d7K712YGOsyxt5uV7p+3oqrkJsjpDuLdLMdH7O2LoA?=
 =?us-ascii?Q?zuA/zoICjYWOv6k5F1433lo9ankWfeBw5RRJJltA+oGqHtGHvUBvChHIGTcX?=
 =?us-ascii?Q?6qzE60pSSW9dN6qB23iDk3FB0GCmVfBuKWMGdpLb8Nfg2f3PdsjKr6Xunw86?=
 =?us-ascii?Q?+YAdhZNH0e2NxUD6eB9wCfgCEmBM/7e9eo0+EFSQICrVCchwSPoDp8NR2o10?=
 =?us-ascii?Q?r5wrGu7CtOTEb0E4iQwdBbogFVQjIkGGYLpSVa5lrFQWWHqani3bSO5sMaGK?=
 =?us-ascii?Q?6UJAt29Gdv/6zsXY2fUxaskNtPrICltSCfU5ATc6n/s2bj0AqFPgCo9JFsTA?=
 =?us-ascii?Q?kbCucXolzWweG5GeFSErMIjBnB8q5gUhjdpy01SvBKWkBooDlqRVm7VCbMEn?=
 =?us-ascii?Q?8zaJhxqzyBuB/jbGz1N54SoY23MLEbNrdJLcwNM4io1lChMx2Wc2YkD9WvCd?=
 =?us-ascii?Q?Ci/KO53vt1zF1ZM79g6vC5iQWY4oKO1ODAVn0py+Rg4IOSM/YO82ZnTeHXNw?=
 =?us-ascii?Q?HRbTy6o+I7Hg4a3B6B/0L/1MV/ND/io7R4tUBogaoLHMFBcEcEZ3Q6Wa/tGZ?=
 =?us-ascii?Q?/EtfR/SYfm35jWxmkcIGxrjN2Azd/j2ZKK8QLPGc4nGQ2nthykybhAXgwIJT?=
 =?us-ascii?Q?SDWuHfc0X58pmxhDhzRI+msdk0/2C1TN2Mqe/GpweGRngs5DvwibKQL2DtEP?=
 =?us-ascii?Q?wxZi16hjgdJGBIED7anediq84Oy9q3gESyEcWjKA7Il70un4w1gzXJi4RJ/8?=
 =?us-ascii?Q?GkRfbj/JNRAjbWwKm4cCemFMAdAlZ6nUJTXZTRDu6Cfxa/utwV5GgL5x2ysE?=
 =?us-ascii?Q?J4oc/G41wMOBNk8q78Qf9UsRFeyRLJ+UvVO+L4f5wT4sCD7CeTE/l0CaFhWZ?=
 =?us-ascii?Q?Ax9b8KfjYxXgvchcT5g5EXZ5s5XdaULQu15tSwjC9NVTuIqhbqQ789fFAgaK?=
 =?us-ascii?Q?ecPBOe1YU2XxfTpmaD1AstKzdlKM832yzOSkD6veDeG6g6bYDcuuHUOuMCtK?=
 =?us-ascii?Q?gAebTS/Or+wNjNpWdD6EmcjoltFyeB8b+dMb1mnFtR1aOtyaQ7Qi4KshlLSl?=
 =?us-ascii?Q?JabIVPyjZJgBUdaafwB+F1SBRv1Gczj65wR5lUvlWsUn83uOqno684m/QQn/?=
 =?us-ascii?Q?ifcfgCrG4zVpm2sKF7YkxC7P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6488dd5-e07f-4a67-4891-08d921401028
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 18:48:48.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bznMzZKmxwM50N7dV8aEPryYDHLhon8KH2XAtoRH+nDdQ47KZpLN+eterpLDYj3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 27, 2021 at 02:58:30PM +1000, David Gibson wrote:
> On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > 
> > > 2. iommu backed mdev devices for SRIOV where mdev device is created per
> > > VF (mdev device == VF device) then that mdev device has same iommu
> > > protection scope as VF associated to it. 
> > 
> > This doesn't require, and certainly shouldn't create, a fake group.
> 
> It's only fake if you start with a narrow view of what a group is. 

A group is connected to drivers/iommu. A group object without *any*
relation to drivers/iommu is just a complete fiction, IMHO.

> > Only the VF's real IOMMU group should be used to model an iommu domain
> > linked to a VF. Injecting fake groups that are proxies for real groups
> > only opens the possibility of security problems like David is
> > concerned with.
> 
> It's not a proxy for a real group, it's a group of its own.  If you
> discover that (due to a hardware bug, for example) the mdev is *not*

What Kirti is talking about here is the case where a mdev is wrapped
around a VF and the DMA isolation stems directly from the SRIOV VF's
inherent DMA isolation, not anything the mdev wrapper did.

The group providing the isolation is the VF's group.

The group mdev implicitly creates is just a fake proxy that comes
along with mdev API. It doesn't do anything and it doesn't mean
anything.

> properly isolated from its parent PCI device, then both the mdev
> virtual device *and* the physical PCI device are in the same group.
> Groups including devices of different types and on different buses
> were considered from the start, and are precedented, if rare.

This is far too theoretical for me. A security broken mdev is
functionally useless.

We don't need to support it, and we don't need complicated software to
model it.

Jason
