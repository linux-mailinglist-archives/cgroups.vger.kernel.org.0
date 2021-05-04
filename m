Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484A53732A7
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhEDXQa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 19:16:30 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:47729
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229960AbhEDXQ3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 19:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTQ5huxp3RslomJF2vwxlX0isdo5+QebggGZH3NzdpI1tbqX++WcrRlxwTpT/9j71F1NIYRsdVNaZFfPYUWsipmYA4r/n0UQhYvy8ueNG/CIWtYH1ST3d/EMny1+SowK4c1S6RdXJb0tq9w4dm79vv7unYtYHvlHjQLLH48rgBQMUAJQeF3Q6DvdmsliEDDuoIE9y98a2IUl3pUXXS+3IUh0xNHQfW10uXgHjCTkykDXgW623Z3gGHhWLMFc2EHy9baWEC+ekjXpX+Xjgw2U6VuHXRQESepVOhohxTI8TS4OMTBgZknDT3pGnss4AUkSgYatd/ykPkqvZK9Xum7Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLArOltAOURLFEyuzKk6PJmJ0pfXnOd1SuIahF/sRjY=;
 b=nUeI0tknk7LkUAmXGrnMqd8uNkKwLgzS2fsS+eVFOJ7EB/on8W1v0ANAHmkcuTT9saRar0LXjAg4N/S55PuBwhhNKJlC+ss7ENXn8osseAxyQh+MP+JDKjY1/xmlhheYJk3eMeObXhPDmL2eEPJFbwGZjUZFxm2tRdXuL2ZzoLYK329vz2qXaijg3kDpkgsw7TTMH/wJL5zlixj+ISQNepfHDXyDV5paZOZTDRYeEwTS9iRkqs53jQGe0fSNj9a19tKOW7UaMooLq9WyEK2g05NSfmjre1JSf2BGZDmBJNAf30vc/Npe0Y0MNnAQBlROzCRPiUTYA9qyTGBpLW59JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLArOltAOURLFEyuzKk6PJmJ0pfXnOd1SuIahF/sRjY=;
 b=GxRbyVPgdwFtFgyoa4wQA4EGmiWBYPbCwRFPeyYyDyHnYYs/0SoQNe05NHcqaTQdCwt0MNwkNwSz+3DA00sgo2LL0XQRYLm/IMfzyp47L8kdCzbr9GOr5uncuADU3gd8QRy8ms1qHi0OWFPw9L/QyLZL1FGNJykfnzUnHjgjHQR5Crsi/G2a1pH7Qm+I3XhlTdJHHbwuqNQyDSlxmlqSzVk4h7gSXu+1gADhLaXgcFLtO74je+YNnHdnvsZGARjWvCxdxwJFW4gVkIAg36d6rqPXkokwhyZJdKHWkerXxPDDPsDszRX8hkW3qJeR5JvnOa3L1vc0r4xk/RL4YNAmCw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.44; Tue, 4 May 2021 23:15:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.025; Tue, 4 May 2021
 23:15:32 +0000
Date:   Tue, 4 May 2021 20:15:30 -0300
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
Message-ID: <20210504231530.GE1370958@nvidia.com>
References: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504151154.02908c63@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0054.prod.exchangelabs.com
 (2603:10b6:208:25::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0054.prod.exchangelabs.com (2603:10b6:208:25::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Tue, 4 May 2021 23:15:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1le4GI-000qOA-6e; Tue, 04 May 2021 20:15:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d9d8e17-2f0a-4243-25f3-08d90f5283d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658ED47CDF3FBCA857C7DEEC25A9@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CHyb4m2Q3REo1YpRVmj6fweVXDWgszW+hYPZ1sZyVC6aXSPKiMnIZkjGAotSaQ/E9awLZX5agP318Ir6KHkOkKdW3CmLpw0/1HpeVPtfcyEHLW3v6ui59gjwmxaGmc673qRPwB00ZCS6AhxHM7+6zPzZpZEQ2MGwWnX1zJPdXIKFiex7vekOBMr4hEAxja4POEHLHxsf/suZNaTkRjzVzaXs/USIj6lBWk3gHInDA7B3IUywwwG3zVWkpHlkDuCVy4iFeOU6AfWESt01+O/YkLfDx4dupsS75InWkac2qy+QxW2jO6m3ddtWGa33CgToIQUcRbnzqloEpAoicc8rpA3eYonsrtq8nmaTPsHL9pmQUBXiEw6UneWnyH/PqBcujq5RiYIUUksHMRQtaIDAiwGybeWO6z3gYJjeVZ5Va7iKJMVSXTuqxG2k9EC62lvop6ktU/eE3MG6L42J1+LOAHQvUdbUPNb4FVtpRb/IFZcHHg0ulkgbvYpSNgnH890S67bKYDbMjMOSCOARSJI4iqvHJSOl5VIkX35zOkFVjCyjPicy6lGWNpENdp2wEm18sd6jtCrce9x5C8bQiQbs2t73CnkvU+PWGz13Zjo6Is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(38100700002)(83380400001)(26005)(9786002)(36756003)(9746002)(2906002)(33656002)(7416002)(66946007)(186003)(8676002)(4326008)(86362001)(478600001)(66476007)(2616005)(5660300002)(66556008)(6916009)(426003)(8936002)(1076003)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mxm2q07Ue/iHOJ9eWwwdEFtTo32MOQjPguDAhqEIV9RA79x8P+Vp1rNGN1Y2?=
 =?us-ascii?Q?RmUen59DvqV9zRpoIn1uFzjY1xgXLYy8cvv/z2547MlKUvLlhtyz8armXGhA?=
 =?us-ascii?Q?DqRrWj0NVXQXvE9s6YeHzu8XDZHhPj0EgxEoC/Rhm4TCs8lCZLB4FNeuSJWn?=
 =?us-ascii?Q?hfGS6LegTCtFVhlyVbdLxnp8z2XtPyTxqC0ZSxsHAD5Dd32VGAy9TEpvbd1K?=
 =?us-ascii?Q?aPFk6g+nJYeLAxtH4lV2NTqbeSimeQjdKnLbNo7rgciZBzK1Sq9rL0+9gpH5?=
 =?us-ascii?Q?ZSSjM2nlwkfU1KWjCsH4Q5shFyrSwHhZcd3EqW07cLKnFlhMZj1t5MOlrP3H?=
 =?us-ascii?Q?69+Z9qzexQ4hE5XpP13GaNcfvT6fAVIp9N4T20SvggURzAlrzZziRr2GPoD1?=
 =?us-ascii?Q?/MSbamgk3PXnVVORqhG1aXSsATqzoaXUlNsi7EuyZZq4COKvo5bqW9l2EWQL?=
 =?us-ascii?Q?RSEF4b1kBLV9rtNNbMAYHSu8cAV5bk1jUgckfOa0AjJr880sgXrB6OWfuP1W?=
 =?us-ascii?Q?JZPDj1PoMkoEapTdRNNAmFzX/HS34PhktieFaz0fLXwe7wwuf74RU8hmyW0I?=
 =?us-ascii?Q?Mg0I7B8IgkIJs/Jypvb4N+r5x1t6QhAbp4LXHUGr/vS/KWHV/09r5dnpJ/rz?=
 =?us-ascii?Q?Tj7IGEHsnggoGVRSMLtKerY8Lw07Fu3bUhn3iHXnC4OwyejU5BEcCtydgqla?=
 =?us-ascii?Q?d1JUsQKNufy/ChH55jZ9MBlcz+xyUfWRlU5E2F2Ij92z6vU6hsEuSBP61+OZ?=
 =?us-ascii?Q?wnXi9/MET24lORbo5xSvLfgREEERPIsIaVOGtK4p9thm3KbI9nIEpSL3w38/?=
 =?us-ascii?Q?dZPln59KeaIRp7suUZfacEYevnq+vgfOsP2EgM+1gm+jjS14QsDxgxHPN9s/?=
 =?us-ascii?Q?oed9sDs9YI1ARRIe6PQ+SeqhBOpqkbyrr13AQUE/l8C5CQKRlRoqxOSAFwkS?=
 =?us-ascii?Q?aqlZD34resvybXX1FisVtYNtnMUC/IF1J7i37q+tjQnGhPD+XXCnbHL8lcpa?=
 =?us-ascii?Q?etUFSGVgylfjEU+MVxiq1kFetxZYzeBu/7hF2IsKszzm9MN1NTx5qXFm3XwW?=
 =?us-ascii?Q?+JyFI15UHhNzPgx03SgQUiq4GImuf64+McrLiTW8Cv3kt6ajhqB8HCkoro+o?=
 =?us-ascii?Q?8ZLU5jHTlNpsaiDHq/3ExY38qm89Q5laAQJeXjiPnGKKj/CP2e812PyP1Wdh?=
 =?us-ascii?Q?XRVtYQag4k0IqZC7Do1iBiTJf1TzMWOGP4FYIO2jw5Jx3IdlAk+I4BPcRSWk?=
 =?us-ascii?Q?RwGWiKrb5IcvuVDEftr1sKU5rYFYTNuwruTzb85RNoQxXEir3axchL9NzSuZ?=
 =?us-ascii?Q?Dk3+0Ab9x+SLjjTahshwtNaA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d8e17-2f0a-4243-25f3-08d90f5283d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 23:15:32.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnHsjKekZ+EfgtzIHRMdn+L8MgkcUU7p6blpRW7fBAVg8Xct2NqqK9q9456CGJ6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 04, 2021 at 03:11:54PM -0700, Jacob Pan wrote:

> > It is a weird way to use xarray to have a structure which
> > itself is just a wrapper around another RCU protected structure.
> > 
> > Make the caller supply the ioasid_data memory, embedded in its own
> > element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
> > allocated but not active entries.
> > 
> Let me try to paraphrase to make sure I understand. Currently
> struct ioasid_data is private to the iasid core, its memory is allocated by
> the ioasid core.
> 
> You are suggesting the following:
> 1. make struct ioasid_data public
> 2. caller allocates memory for ioasid_data, initialize it then pass it to
> ioasid_alloc to store in the xarray
> 3. caller will be responsible for setting private data inside ioasid_data
> and do call_rcu after update if needed.

Basically, but you probably won't need a "private data" once the
caller has this struct as it can just embed it in whatever larger
struct makes sense for it and use container_of/etc

I didn't look too closely at the whole thing though. Honestly I'm a
bit puzzled why we need a pluggable global allocator framework.. The
whole framework went to some trouble to isolate everything into iommu
drivers then that whole design is disturbed by this global thing.

Jason
