Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22034405F
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCVMD0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 08:03:26 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:31105
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229905AbhCVMDE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Mar 2021 08:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwYPGpkj44TYv+dg3xJbDWHMrNAgK7Ld3qNgEMUifygEIzlBcTbTN7v6xMp6NPXmYBd5tfKLoeEty6QOQwliVr7PA3R+th673EV1wImMGlCJKevlvTcYrz2lDOl71yloALG4TpjsHrC/pzGkA0T00KADeahSfXv0sLAkNzuuB09co0WexeYlzJWH2mmADKr2WfjuGISnAAoIg/xd1fnUN5612gFm7nOMzCxB4k+1ySc2vPizYXdt611+jS8kv3AXjTC6TuOG4HevWrwN308FdiQNA1TJb+okkMUd9R2G2RJryLwaElVjA1Qo/cWJd8Kxk3+izM1pnDtnFnkFjhLI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzn01HrZRrwKwV0UIRm7mXB+Hx5h/+0Svn2iOOF3wM=;
 b=kE8K9sB1tnmz6/UGryrcpMPjWrklJF8LnXoZgoB7lUElGEZIdoSeAI/72BNy/oQ5pzaG2HGs3itHSrVqhPr2ko0vaQXKlTB2ulFN2WVej9KgVrVuGUR5At9cqG/eORjoAoUk9JGbss8+k18c5IDz8NcnworKKjKN8Ra0VdEdf6mNfLxU3E+kFWyByH4Gf1rwxSgs6Owxs6DVUCWJO8Yrr6BeOzvbo0Y+yvtE+Cu6LVJdl7H3Iry1VxMQMpKWLBMhulSs5V7V2Eqerr+Qlu+b7b432lYuP2MzIGkL6eYXqohMPAYnv1oQW01FfXwf6HXMN2dYMM0ogfqwRSGHk3IHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzn01HrZRrwKwV0UIRm7mXB+Hx5h/+0Svn2iOOF3wM=;
 b=Awv7I16VB9PBbqCllrddC1HBoNjg/I7JnRN5KKKk6C12wdfMr0NBkl1ylMJhyMHZnAvKMVJ9QooxDmQ0GF7jhFauFPB2Ao5Uft+VpXHxkKFf5TRbYWBtaFGa0K9PmhhjzeyFtc+ODR3AG9Fw3TTtmXJDk6eRNnTHToupP/divexZknR9ATV5WN4HoZDxlKAXTCAzwVXe9BX07M8GLDXX2SRqsFI1HULxIWOXlnkMKUj5+qbETvkZdu7JTn6O55zd9DCTBv38ZX8YDoQkQw6tqHEBGgkPVYdtO6P6qwVZ+aeBfyLFcIci16R6DCra7+ARXB5fFQzL6ruf5I/SLiSwnw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:03:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:03:03 +0000
Date:   Mon, 22 Mar 2021 09:03:00 -0300
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
Message-ID: <20210322120300.GU2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319112221.5123b984@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:208:134::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:208:134::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 12:03:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOJGu-000vZZ-UJ; Mon, 22 Mar 2021 09:03:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ebaba6d-589a-452d-5466-08d8ed2a718f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811A39541451A9096F68FCBC2659@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQjcTGUxPWDxE53ckoXtH6M4cjcM2pfUymA1OktBoKm3QC4KlkHZuhN07MV6eN6XNDRagGo8vW5UFzfee1NjH0JMNPUIu2exN2QbtsO5Xi2dyNT2XFMgL3lkZF5orCJkp6nYhfoEQ2mmFjym+1o66sFOp1gkPHV+9MtqqjuXROf8kg9YlY4NaG8CQUNDp6/W/CRuswqOFhwpHa6qg/9GIKAwZvg7XO6bkcr52C3bHIUgYUD/a4nnccSgODovVQljWRmpFA0x10LNz0QoujgjLBSiYgjoiDcCkx/7w/4UJP6oTZwOKwDl8gNqcm7cClRTklCkOHfC2YuI6RMUKg+NSlUakcLPxp4KLhYuPshOyXyLpPb7+4uzSVRHOKlevAhPIT2hBbj1Gpq0/ASdbFQTejaIILsW1cQ6ZEHzTIs6vZLuImoRlMcveM6SILUWY6bq/MHlwXIovtETgI8fCgJo5ty07gOTuA6fQ0T1+Jf14ef2hJhLWSDypSbms1a4kyU8z3HQpQOE7xvE5ux/E7l5G6ZZJZNls6ozpbo06yzcsHjZKL2N7AucBj3iAKMXvJYSbD9t7VWP/bIfNrz6pdUKAoqgsqaerWig0OZLLNXAetWVWd7nDxWU4vsSPItgxL3W2ITQBH2Q8rD6cNT0mzb2FsaZFuyfQ3yZoP/tPNnHPzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(478600001)(33656002)(66476007)(8936002)(86362001)(9746002)(5660300002)(26005)(186003)(9786002)(83380400001)(4326008)(1076003)(54906003)(66556008)(316002)(2906002)(2616005)(36756003)(38100700001)(66946007)(426003)(6916009)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHlYcUIvTitSUHIwZE9iU3dGZS82RzFXbUpuV0dyOXZqSEhOQlowZEdWSHVu?=
 =?utf-8?B?eWIrcjI0bVVzb3ZkVDZyWHBIZkFRa2twb2dkbTQwN2Y1VEtXeXc2NUliQ04r?=
 =?utf-8?B?Z3kwZ1A4V2pNMTNWdUl0RzJqQkNqMUdkZEo0Mkx2QVl3RCs3OHZmTDhVRXZ4?=
 =?utf-8?B?RGJxdklza0Y3Y0ZoUmJRbWc2MWs2elh3aFpPVWZaajRqdC9laWtCUWFybThh?=
 =?utf-8?B?UEhuMkluVldBK3dhUjgveDM3L0JCMEY5b1A2OUpQWWRxb2VHTXdBWmJpRktW?=
 =?utf-8?B?YTAzODRKbDV2RFpxTVREbWlkYnQvdm91NkJjWXFUYWJWTTM5L1oxdVU0QVBO?=
 =?utf-8?B?aERwVGNNNldFMXhYd0djT0dFWmlZSHlRT2JtRlh4bDE2aGJvN0ZkcHYxM1hm?=
 =?utf-8?B?TU5ZMUlyckdMa2czRWJGd21XajR4bkJsdTJhL0MxMytudDQ1d2FHdWtKR1BD?=
 =?utf-8?B?K2V6c3ZmaWlvYUhwTXFwRFN2c3pEdnd0L1pzZm42bVpicEN5TnJxZTVXbXE5?=
 =?utf-8?B?MEVtNWZCUU41cGZUY1g1bUtLNGxTSnRBdzhQbVpwWDdvYWVCMlZ2QkkvSUZk?=
 =?utf-8?B?MHRPMVdRZFB4QWYxQTFoMTR5OUJremNnck5RK2V6TXpKZjB0b1crMVZWSzBJ?=
 =?utf-8?B?amVCMm5vNjh4eWFHUEtMY1IxSHV2NlltbDVLa0RJVVpMMlo0OGtxZGxxemhP?=
 =?utf-8?B?RE9WWXNOSjBaK3dJRjJ6bWg3ZVlGeW5XWHBadDhZQmVVUlA5Y0lyOGlxQWlM?=
 =?utf-8?B?SjRzRUxEcVdFRlRybExzRlN1QU8zbU5YSXBSK3Z4dzB5ajhselJackxtTzNq?=
 =?utf-8?B?ZGF1a253RFpXTmJIM3h6eERZWXZmb1R0N1dvRjlGU0s5bjcwUFNHSnRjM3dt?=
 =?utf-8?B?SXRSa2l0VzJzaU5YeVdTcHdBVGlETklsaXc2Vm1ZdnVqa054NzhBRCtlYUYx?=
 =?utf-8?B?VE5mQzBFK2JDeW4vQnA2MG5ZbFkzVndLZU5RQ1pDMEtIMHRyUzh4c3ZjN1l5?=
 =?utf-8?B?K0dEVUNRYW5sMUxFbjhFZmFsQnY3TVM1QkwvMGxjWVNhQzg0dEZGVmtKV21F?=
 =?utf-8?B?bnp5WWJaNmN0OWsySWJ4ZHpOaGpLdEVvMk41R2kxWjV6Q0F4VllZZU5XaVph?=
 =?utf-8?B?ck4xQWY3UndCWnVjQU41UDVDVVNnVWY3dENRUVdCVC8vakNEWVdIWm5CV2xo?=
 =?utf-8?B?YzQ1MURyb2lrRWlCRndYRWZTTGZMK0daQlFtNEJNbDIxN3FoMzNyTFZaZmxi?=
 =?utf-8?B?ZDZ3STdrcHY5ZXFaWVVIWG9sU3M2WXF3RFRxbENDRCtabzJOZzE4MnNtOGVV?=
 =?utf-8?B?elVGbk9FYXRzTmNoMW85dDRHc2g3WTAxaTUvYk5UWUVhenZadGhVSUNLU3I3?=
 =?utf-8?B?RjhEUVQ0WENpZjZIeGFUNGxKZTIrQVNuaGF6N2pWOFI2Ynl3ZTRJODI4cFNJ?=
 =?utf-8?B?ZGhSaUxqem96ZmUyR3J3QTB3cVRZSm9qRlhmQmJBbm9oODZzUktkeUpLbTR4?=
 =?utf-8?B?TndJUG9nMlRFRjlxMlRQd2pJczR4VGZ3SmhCYVprK0NqNngwUlFtVlpuNU5X?=
 =?utf-8?B?cjc2ajNJdHM0aFgxTG5QVnIyeFV0ZEdxMGFaN09ZdkVkREZaUnQwYTM1ZHFV?=
 =?utf-8?B?UnE2QTJzVStUTEZodmlOckIzdEZ3SHprOW1hODdYblRod0tLQmJ3Q1NSNlE1?=
 =?utf-8?B?b2hEWE5TcFp0eFdlM0wvc0FVL1d3dFdKT1BnWStNREp4MVh3UVhhKzNncW9l?=
 =?utf-8?Q?Jlvu7oBAlUNr0dtn1aC9kT0b1VZFdd2pmV3B8bi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebaba6d-589a-452d-5466-08d8ed2a718f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:03:03.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrkWhgGN6D+mqitpSgiz5ACxHaqjL+EoUhwwYZ1Rc1oUw1bbKWfUd6dhpX5HVKUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 11:22:21AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Fri, 19 Mar 2021 10:54:32 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Mar 19, 2021 at 02:41:32PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:  
> > > > On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> > > >   
> > > > > Although there is no use for it at the moment (only two upstream
> > > > > users and it looks like amdkfd always uses current too), I quite
> > > > > like the client-server model where the privileged process does
> > > > > bind() and programs the hardware queue on behalf of the client
> > > > > process.  
> > > > 
> > > > This creates a lot complexity, how do does process A get a secure
> > > > reference to B? How does it access the memory in B to setup the HW?  
> > > 
> > > mm_access() for example, and passing addresses via IPC  
> > 
> > I'd rather the source process establish its own PASID and then pass
> > the rights to use it to some other process via FD passing than try to
> > go the other way. There are lots of security questions with something
> > like mm_access.
> > 
> 
> Thank you all for the input, it sounds like we are OK to remove mm argument
> from iommu_sva_bind_device() and iommu_sva_alloc_pasid() for now?
> 
> Let me try to summarize PASID allocation as below:
> 
> Interfaces	| Usage	|  Limit	| bind¹ |User visible
> /dev/ioasid²	| G-SVA/IOVA	|  cgroup	| No	|Yes
> char dev³	| SVA		|  cgroup	| Yes	|No
> iommu driver	| default PASID|  no		| No	|No
> kernel		| super SVA	| no		| yes   |No
> 
> ¹ Allocated during SVA bind
> ² PASIDs allocated via /dev/ioasid are not bound to any mm. But its
>   ownership is assigned to the process that does the allocation.

What does "not bound to a mm" mean?

IMHO a use created PASID is either bound to a mm (current) at creation
time, or it will never be bound to a mm and its page table is under
user control via /dev/ioasid.

I thought the whole point of something like a /dev/ioasid was to get
away from each and every device creating its own PASID interface?

It maybe somewhat reasonable that some devices could have some easy
'make a SVA PASID on current' interface built in, but anything more
complicated should use /dev/ioasid, and anything consuming PASID
should also have an API to import and attach a PASID from /dev/ioasid.

> Currently, the proposed /dev/ioasid interface does not map individual PASID
> with an FD. The FD is at the ioasid_set granularity and bond to the current
> mm. We could extend the IOCTLs to cover individual PASID-FD passing case
> when use cases arise. Would this work?

Is it a good idea that the FD is per ioasid_set ? What is the set used
for?

Usually kernel interfaces work nicer with a one fd/one object model.

But even if it is a set, you could pass the set between co-operating
processes and the PASID can be created in the correct 'current'. But
there is all kinds of security questsions as soon as you start doing
anything like this - is there really a use case?

Jason
