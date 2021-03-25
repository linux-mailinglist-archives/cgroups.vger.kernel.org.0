Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78453497B6
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCYRRJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 13:17:09 -0400
Received: from mail-mw2nam08on2051.outbound.protection.outlook.com ([40.107.101.51]:37984
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhCYRQw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Mar 2021 13:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO1nhAUlgH32lI/8vxVQ8AWCeNsVtTb1da5Aqyd7qsiwC2bIuCV/g4YG77xuZtPyX3bnb4WO7npSG6/IEnoeZKGfOpUPFS0gQ3KX3R1uOc1HLvJnLb91p3hsKY6C0/NeCjfLlctBpKJC8NjjYQjbIJbw/i/E1Uj0kabDW2QBEc1CV1NNIgBR70fmoxGmcPZZgZcXCoMNBqoCtLWeVBJQye734wva4bEDVyy/GJlBxsqs9CNdoZHWCmKNZdzdUHIBd2ipRRQfaJJwAUqKNNDhcSrONZr1BBauABQZmNX2K1eFL73n7jeNLI7xaWetJz5TquXMCetOM7VeuiW/5xiBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8497p9PafWXumWQXnOpf6+OujpPkbtt2AmI5jMKNvrE=;
 b=amzf6zrCNhrqgr+CzKuTBKChBDJmB5mUBeIlLtNnEB1gP7SDa8J2D3qzwYnfHii+fyO2YpaXBDISK/Rs4htEPOmelvIszu05QQUP25epChSyKn5055rxNfqKVH48TIJP6S0zu+7X3HTxPI00G86cxOb0TtEhrmFkVaRJ7QfElW4T05iRiIlcCGPvrZnIQOFbKkxXFGCtQlvHvNwCUOYz1InXQJ2OU7eIy5EP3DfZXX1m2UGh9n+Illa29V6BCQdLbEWMwL4yyGV1EIsCk/rdjOOOlFEvTkDBDVGIY4wkRIeITtkt8zekvXACQD5+KHj9vtVGqlRhfdgJHKzwdleUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8497p9PafWXumWQXnOpf6+OujpPkbtt2AmI5jMKNvrE=;
 b=gVoXJlLxayE3FyCpqoudz9IgiUywhEuDf2CNijaRiBcvW2xU18IghecsLD5uRVD9MoGGmmyz0L5PzPGqorDGT07/e4nggWF2iBf8DH2xcO0Nu/yAzwLKvtWI+Nr9DnhTdz5u4zj2lX877EZqotl6/GlLtal/9krr5ACapJsToQQ7yHh64/WGoqPmSJMVTNG2MZnLjts+rzg5i9x0pnWGWohGuUeCD5jWu0Xb2y5SDVDF9XGzLVrtahmgybUZvFErR95QYrkGAad1gpgEVeu0+0V0BPIH4XrZaNFnz1RKRR5LHouHAnAsFqJq0biy4ctEZGBwT8tMqkCLpA3PTxWTzA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 17:16:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 17:16:48 +0000
Date:   Thu, 25 Mar 2021 14:16:45 -0300
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
Message-ID: <20210325171645.GF2356281@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325100236.17241a1c@jacob-builder>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:33::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:610:33::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 17:16:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPTbB-002kEu-RZ; Thu, 25 Mar 2021 14:16:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ced7c9-5fdd-434b-3766-08d8efb1c55e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45787C44A24D41BB5DCC9134C2629@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBgacF4LcDGkZUS7tqwyJnECaSGeCNhnxb4tg8Pbkho5r1XmhUn4RdqnJY0e8VDPLE22QSK2oKuq/WUt3yEgaOkCcZlzX3RFAKnv56crFAKaIK19Vb00WbxKpGXQPddsbAc24yP8fHhWcICPL64AKL8ygYnr4hTiwB51xGmNAly4ugO0ivVlYjkDigTmlXN5rfAmE28wQwLe6LuAMh+GYcc3ApCldyHNLISQbsYL5qddL9ZQXhT1g4KoERRbwAPvaMwfmllpiadvx1DGAHrXBbDaL3M+8XfH2NzHdwsaDsG5AmMwx1IdQDinrJTSPCQcNOcihDuYBeGE5quLrhtM+oCZYsqCcrcn1UEp64gxebLPruj6hlCKqjOiAUOmmuju+vZ4S672eohIRrfRfwxFZlltr7HvVCzVDTSdGKwjN1VUWxakpeVJkp5fXXIY8UHH+RlJo0PZmViuri3IKZOTHp7b2t5DneRqW6qdJZpTJmIR5HTAizcN6f0CxX16q6KyLyQGivJ/KAyC+Jw+u+tDortTS2a+T8VL5BdUXrlVI1orlIqXeYvfgf5i4SQj2D034s8e9d43q6Op9GdQ0qq3IgQbCWEeKkSUcb7J2lvgMXaFdJDgZUWhH+e0qzc8eI4KZcAJ08/jnBHBXL1CORtSTKwHKQkv2bNSpXmoSESr9VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(66946007)(186003)(4326008)(8676002)(5660300002)(1076003)(2616005)(426003)(66556008)(66476007)(6916009)(33656002)(8936002)(9786002)(478600001)(36756003)(86362001)(26005)(54906003)(7416002)(2906002)(38100700001)(316002)(83380400001)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vVpbq3uLXgLkr01I90HXRbypE4HyEIHniP30mEtwI+Ur+4wLdIoAD3iE2eDR?=
 =?us-ascii?Q?tE18TP6mG5a6F/OWtkF6TQoUk8EtmgvqjNn2e7NkqOk44DmFNflevRh/ul/J?=
 =?us-ascii?Q?tq9mc3CYyFRcRG4lyPn3rjXV/fnLKhtG/q0uVVPuGcknFR9PqRV8upuQ8Vi0?=
 =?us-ascii?Q?QzRFr/ejKWzmp2PFNRDbFi9cR29Crku6WiXvvUeu5awDjbPtq2MkAn0JzOWQ?=
 =?us-ascii?Q?FMZP3xOpZ18wX1IGULsQnu4/N/3CFA95heROqEr8TzFk+/WHtgd7r96VQYrc?=
 =?us-ascii?Q?NDImoGdrsGV0C2Dxq+IzxOp9ecvK0CD1BTCgwwdIOSMQruWf6dEeT/9f8VD6?=
 =?us-ascii?Q?qKkq9ZBx4frUa/cCkY52YFzABl9ODSgDo+bsqWkVeF43jKbO+PD3ppjkcBBe?=
 =?us-ascii?Q?tbzv/BgH+KerMhrVb5B7rvdI4Ey4SSVONGmxsri0iqAVsJ0f+PsQ5K/kpckn?=
 =?us-ascii?Q?YO9pzVuh7Pn5WZd+XzA+Lf8GI80WRH57fb2ps9LIe1p1ACSvJtfHw/TwROBc?=
 =?us-ascii?Q?VGNV2CxkZAIODQxU8abzmQ5AC/GK5szO+KlNWOPEZ2Y4iQkpaknTMYnH2HWM?=
 =?us-ascii?Q?2Kbs8x1DRkhvjUEnzQm19RFf9p1bCxRbAJ/0FukrmNM/OSG3sb9NM4/b/i0r?=
 =?us-ascii?Q?oZSP0RrYKAiCXsKPQt4CJ2TpY9VQlcgYqBkQw17wcC/m9DgHbp5Kg1Y50MCy?=
 =?us-ascii?Q?MrjyJHGXywFFH5XHmF4MPkBs7IdlhEpHILyT634CLpGaeo10j2/CUq23BNE8?=
 =?us-ascii?Q?EcPjeLDHjkIsJb1r2ApIocbOjPD3DDymbmdWcg5rRvbWWhmEWj21LzKNk0TP?=
 =?us-ascii?Q?A49r3huP5Va2yLabvrkPkSAsmfv5mrAtYIaLe2cKYvOyYNJBgUjxrnz/BA18?=
 =?us-ascii?Q?Gw7FcUv6b+3ztQTpvCgMI1xYFwe0r5brE42IL8tLl/tN42nkLXOBGPqYw6po?=
 =?us-ascii?Q?3xF5WaJJ4r1nwNjnZbzrwI/WKOObQF1Q8bH1vTLboK7lUeIfhtJ6fRyTWL13?=
 =?us-ascii?Q?zsdh+DmSbZc+KehCUgkiyhqmg6HIU11uZXd/xgUKJLr9OA9B7VDZrirr/7gn?=
 =?us-ascii?Q?Ra0acAqRDFXK9CBPuXbl+UB9BQb0eh+5qZPsS+B7EzvdpeUdZmuPmS7x/rBV?=
 =?us-ascii?Q?HorIQ0iLHNViV3G/mlDVVBIu918oMwWdcNYu0aOAdw0E+9AcvCdNOk4mW23r?=
 =?us-ascii?Q?xXCDipHeqOg/gbuwZB33uAup0+06TuVWF7Kh2z0quiTWYiTktZOLChjf5Oku?=
 =?us-ascii?Q?xLPQepxP9OIsJUoNJdgod1PxZYDy50Rtvmc+uzSYnkDKBaoiDZZb5sCxlAdM?=
 =?us-ascii?Q?qwxg/bQPuD6iCph3LFIKBTbk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ced7c9-5fdd-434b-3766-08d8efb1c55e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:16:47.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKvPdCxve+uAGrivm3shTyG1fPvAM0TfDZbZ3lROxswu5USGdza5lvBmygLlUDQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 25, 2021 at 10:02:36AM -0700, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Thu, 25 Mar 2021 11:21:40 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> > > Hi Jason,
> > > 
> > > On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote: 
> > > > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:  
> > > > > > Also wondering about device driver allocating auxiliary domains
> > > > > > for their private use, to do iommu_map/unmap on private PASIDs (a
> > > > > > clean replacement to super SVA, for example). Would that go
> > > > > > through the same path as /dev/ioasid and use the cgroup of
> > > > > > current task?    
> > > > >
> > > > > For the in-kernel private use, I don't think we should restrict
> > > > > based on cgroup, since there is no affinity to user processes. I
> > > > > also think the PASID allocation should just use kernel API instead
> > > > > of /dev/ioasid. Why would user space need to know the actual PASID
> > > > > # for device private domains? Maybe I missed your idea?    
> > > > 
> > > > There is not much in the kernel that isn't triggered by a process, I
> > > > would be careful about the idea that there is a class of users that
> > > > can consume a cgroup controlled resource without being inside the
> > > > cgroup.
> > > > 
> > > > We've got into trouble before overlooking this and with something
> > > > greenfield like PASID it would be best built in to the API to prevent
> > > > a mistake. eg accepting a cgroup or process input to the allocator.
> > > >   
> > > Make sense. But I think we only allow charging the current cgroup, how
> > > about I add the following to ioasid_alloc():
> > > 
> > > 	misc_cg = get_current_misc_cg();
> > > 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> > > 	if (ret) {
> > > 		put_misc_cg(misc_cg);
> > > 		return ret;
> > > 	}  
> > 
> > Does that allow PASID allocation during driver probe, in kernel_init or
> > modprobe context?
> > 
> Good point. Yes, you can get cgroup subsystem state in kernel_init for
> charging/uncharging. I would think module_init should work also since it is
> after kernel_init. I have tried the following:
> static int __ref kernel_init(void *unused)
>  {
>         int ret;
> +       struct cgroup_subsys_state *css;
> +       css = task_get_css(current, pids_cgrp_id);
> 
> But that would imply:
> 1. IOASID has to be built-in, not as module
> 2. IOASIDs charged on PID1/init would not subject to cgroup limit since it
> will be in the root cgroup and we don't support migration nor will migrate.
> 
> Then it comes back to the question of why do we try to limit in-kernel
> users per cgroup if we can't enforce these cases.

Are these real use cases? Why would a driver binding to a device
create a single kernel pasid at bind time? Why wouldn't it use
untagged DMA?

When someone needs it they can rework it and explain why they are
doing something sane.

Jason
