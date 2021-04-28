Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9D36DF0C
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhD1SmO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 14:42:14 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:28256
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236337AbhD1SmM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 14:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvI3kjB8WvK/3b+OGAwHn1l3D0Ykp9/JUZME6qGMNeHgdTNhAvyFQ1ySFbhRTAXHIInkggivwB3Mhae1ncFqoHd++DVTzbBAFQ1yxAVkqm/RdizvT1PWDBOMcUf7vzjqlqVKs64VABl/xFAV2No9xTtZfDUa5LxXpRsaowdLSqM6wBH2AfppXEE+ChmX66f8x6UQg/ceckxlUVzqtopfG50yU+MVNfAOK5ZUGuNxs6X4F0r81qtZQGJtixIP5ohuhpnjoPHu1VEMQWFhesy9AJZrB+Be2Ds3zo0A9Z/MtHv3og+IeKgxyoEdcS8mH2hL7bkGxA08ZkNQ+pb0pCIG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMfmm1azbuIlsXCXTeGTugB3LpP6zMt1PjDKaXST7PA=;
 b=Fm3gVWL3WyMaptnbZHFPE+NPuuQae0GDmX5a0Ce0kiMvCpslSnLSzNvK9lMfu1Uq7ZM9QoLkxr170fYNxcJS0/sKbkiV3of5lzGizm9c8mC1RjT+ieU1V5WVcGu+sJwRvrCworGp7g6osvV011n6e4n0I9Fose2Pr5VO7+1c/RvO95o8rDvLaRawZl4F6DQXJGB6i9PsTUDQuZXvKyEGeKfwfp1LS2IuQ2HXuq8/B52xwkK2raUKxEaP0Z2UtwWZg0hVHRJ8Ty5jLY0TpColLM3tzoF1s0RsT0aHpfxL7JNQZ+i0NUDi9KQsqkEE772fhMxJMVTdS9NYK7yzEqDEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMfmm1azbuIlsXCXTeGTugB3LpP6zMt1PjDKaXST7PA=;
 b=fMLBMOkBCvSgDFRgfCWPqAajG2U53d/nIUY6+cMmNLyrlDufyCB/TY07W6ymzNif6+wi7IylHN3zujuMF2gpAqdI9eILAmQroCQY3mRz37R0oHhymyy4JKNN5DFkyAmkwMg+95G+SGe2bZNV6oTdidK3sbagmyNWAwSK0s91q303Evnl7SRyBbvyGvCxBQtXJlRCMgJ7Nn75npWsst5eirZhlIxzGXiNGu466W1s7s+BFueb7165gvf42/gNnrPBwN86lEHrp56Cf4IBhJWgNivxH7Jmvtys+VGhuIzz606WstV8I/IO9oSp7+wQbNjSX8IFiM6S8dQO0/WK8/vo8w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 18:41:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 18:41:26 +0000
Date:   Wed, 28 Apr 2021 15:41:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210428184123.GW1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <MWHPR11MB1886C9199AA3F00FF72ACB508C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886C9199AA3F00FF72ACB508C409@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:610:51::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 18:41:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbp7k-00E5zm-07; Wed, 28 Apr 2021 15:41:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dea0b7b7-920e-4788-1a49-08d90a753a50
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2602A96402D13A2E34653919C2409@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmH32CcLjRO7nReGyhd4RyiSvA3UpDfz7sZClz7zqjDkNcOTzO5/PyZFggCEUK4WqzuMqmI+SR+65QWa+EUIgqb5tGa2gbWShL0oyYHkL14Z2aadRzfh7iNMG8U20T1dacoVDxJjd1dAZWjEeNMq3Su1Fri83NuiSu1F3aWA6aT1qEBO8t5U48Ue+8XDZJYBe5oPtbiLRXjr0062602i+2tn3sIymWGoAjacOAVFkOVpKimm8gpxNH1w7YeeH7lp68tbKy0Ju9GDmg55G9h1FHtOHa7W1Z0pGxTRafLoSO5Pe6eeKgpb5kZJHf7cED8XUOX+Z0EcWJeTH9CTv0lHxYwHWSjTpUzzpO8EnUilw+GGP5IEa1GSNDgYL8lnDXIFZKl72cFyGabbeE61MNa1I/RVFSC8ip7MbmIeZXKYFJ8DQvVlKzQw8ZBxFzOLf8HF5I5w5u/C40EaPFrpdb1hs6QeXSiv+qOXEXxb0WTmzU4KclbkXZNCGMMTLmSZUawiDBvgy24MqREnlh0D9ECACopg1IT3vie6NyKK2NnypId/vq7RGUuQ6ZhMoaCtq2+KVJ0SEGJ2qg1F3vGB9y7cLAC6WffowBAmgf94ogKNoAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(316002)(7416002)(36756003)(9746002)(54906003)(186003)(6916009)(9786002)(2616005)(1076003)(33656002)(4326008)(426003)(8936002)(8676002)(5660300002)(478600001)(66556008)(86362001)(38100700002)(66476007)(83380400001)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wYFR0UItFGTDOLMqbqqVVySTcwfGBHku3Nd82pjcCIEtl4bPHqQJcdWiYhw4?=
 =?us-ascii?Q?rv2gaPZtqmszAdzCg56Qu6rkRhvRQY0wqbXZxMFyInhfABat/tYR9+FNMDoK?=
 =?us-ascii?Q?5LhqWf9bsKQ/dPpcOKMSLi1ucR3YWNe3MgU0s9eT+C4iMmAvjVOq4WgkKnuH?=
 =?us-ascii?Q?7tyP/8dpK5x2/o2sFpbCl1IjVR42y+ybdpkZKfpNxXeg+x/tqHLK1d8mZ0SY?=
 =?us-ascii?Q?jv1zLfQ6xMbTN12P/og3mc6T0LSliqiBRMu3r8QyR+H/OnoajmuXU6QY+BZC?=
 =?us-ascii?Q?djrHo5+mjMEnAwOs9MuLzkYPTfT7ZZamjAQNU/vDUIOA4pekXpHtqC3Zx3RQ?=
 =?us-ascii?Q?wtie45qw4KtbRajD/xRrOahhdt/jBIyjEkE0BdtnxaRpC57DbU9eyuuwCYLL?=
 =?us-ascii?Q?0fc5f1MYAeT2/bkcphe3XX3jVSHeTpfW1TobDaxyrBYJAWd6G3rwRMOT74xr?=
 =?us-ascii?Q?IPqrUGBSfKeGk7VCiHAGkqc2WXr8GC+4QSi1+FUL3MYy+ML/Q93x6u1JbSK2?=
 =?us-ascii?Q?ZBTBu+FZSe9nz4Z+bcPFN4AyHQpB2BijprMoRpZ2/Xg2f7Ponm7V1EiNjFaJ?=
 =?us-ascii?Q?4cCtx+bUK/qVJzAOiesD8Sjw5Z3o7E6KXUT7QwOCZyA2jXr+JTu1XWjbjEu8?=
 =?us-ascii?Q?ahF1fuPQ6rhQf4AuECyTz+xTsoW9R/SfQOQbs2Bz2cbSDaF69BnxU+hb4AME?=
 =?us-ascii?Q?rOJvGcsqDNINEQO0X1sWYRy/pVzvlLzTNd3MKB5+HYFjnQhy6dJVv0Dqp5u9?=
 =?us-ascii?Q?oX4M169UzJwAFNGaGcoA9NjlHrHdogHsxB0RHNaPBl5I6pbpnFCVxumUbehn?=
 =?us-ascii?Q?En1oNOQjmD1EmIQ0mcEk8u0kwW5HRdRZn8t1N63/X33DtDOPRBVTv2kWh1F3?=
 =?us-ascii?Q?VWdFTrcsU1GqVrPeSCd97xs3lKM8gajEDG7e/dPwBfl+wj4eJ40lFyZEz0vH?=
 =?us-ascii?Q?sqJRXvKhJ9L+ZKispC0GBCs+V2BT4yrmPjriYMemt0nTT5QKfdSjxGPXnUmQ?=
 =?us-ascii?Q?BL0Fzbzlnmxj0Pj050IcQZuN+vO/Gcsd2p2tjx3BBSA6meUV+0vNVHKFCLqR?=
 =?us-ascii?Q?UTvQlDAN52rrLlLWPvsT9Pfjtw6jCbkrNfiNkhJbIPlVfLrHXFAM1xGcozzu?=
 =?us-ascii?Q?kxrXxGpTAvPMi+vTyyybPlHMV+bmDiJDIk87QgX/GL8Bm0riaTAHL/gCd9Ss?=
 =?us-ascii?Q?GtR7tGPw6U+zTBdeo31zQFKby3crTKQQOBdTah1/2k62ORUeQftSjim7k/Zs?=
 =?us-ascii?Q?nG92J4qYQCyi11W+RbuWE0lPUiF3FxVd7ojHbCoi0mHhRciE1He2fgspD/02?=
 =?us-ascii?Q?KRxTJYxEToH/FuLeEsZhIpqY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea0b7b7-920e-4788-1a49-08d90a753a50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 18:41:25.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f24ts17V4dFoRDA5xeY5lKYk9Z8qiHjqJb9JSIIW6nex7tcqy97V5MUpCXO8DxV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 07:47:56AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 28, 2021 1:12 AM
> > 
> [...]
> > One option is VFIO can keep its group FD but nothing else will have
> > anthing like it. However I don't much like the idea that VFIO will
> > have a special and unique programming model to do that same things
> > other subsystem will do. That will make it harder for userspace to
> > implement.
> 
> Hi, Jason,
> 
> I have a question here. Based on discussions so far, it's clearly that the
> new ioasid uAPI will differ from existing VFIO uAPI a lot, e.g. ioasid-
> centric operations, no group fd, no incompatible domains, etc. Then 
> I wonder how we plan to support legacy VFIO applications in this 
> transition phase. 

I suspect the VFIO group fd will have to be registered with
/dev/ioasid in addition to each device if we are to retain the same
model.

> Earlier you ever mentioned the desire of directly replacing
> /dev/vfio/vfio with /dev/ioasid and having ioasid to present both
> VFIO and new uAPI. Doesn't it imply that we have to copy the VFIO
> container/group semantics into /dev/ioasid although it's a special
> programming model only for VFIO?

I gave that as a something to think about, if it doesn't work out then
it is just a bad idea to discard.

> Alternatively we could keep all the container/group legacy within VFIO
> and having /dev/ioasid support only the new uAPI semantics. In this case
> VFIO will include a shim iommu backend to connect its legacy uAPI into 
> drivers/ioasid backend functions for backward compatibility. Then VFIO
> will also support a new model which only uses its device uAPI to bind
> to new ioasid fd w/o using any legacy container/group/iommu uAPI.
> Does this sound a plan? 

It may be where we end up.. Though I fear it will make it overly
complex inside VFIO to access the new stuff. It would be very nice if
we could see a path where VFIO insides could only deal with the
in-kernel ioasid handles, whatever they are.

Jason
