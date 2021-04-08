Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEC358233
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhDHLl2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 07:41:28 -0400
Received: from mail-eopbgr770085.outbound.protection.outlook.com ([40.107.77.85]:61248
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231375AbhDHLl1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Apr 2021 07:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dirQRXoh1J8XF+FPqZFBwaa/X88vpba1m3dikJIr9t92bWLCoj4nQAR5UGZWOQrdpm9g6NsTAw0aP26tx228R7SnY8EuFl/fkMpDb5Us9CBJ7oy//wlPfZiNZwDzsWTagWGhI3KMZw0Xwq86zkaHRKmIjktoEBRUiALu1o1T3qs3/d80hqBf8c0NEfUdMPJ02FGyG8EQhRk/mfE2TtlQjIBvTrWPnYtu6CfARWuF38X5a0WHyLq2+4poRbVRDLp0ZserlfwXmEywEJrQf21PHfzVWD5yIv67yZZ6ydJFcgVw8nPrrqsQqdzCnSPkXKFzOoTtd1h5dsumhklJHmn0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OHsp5mI3yQn9DHcjJ1PrziL5UqaHpzIRwLXkKu7z0=;
 b=PwzogAIPPemmNz20lWPnCoYecb0fWp1uQEeeD52aHsVxpDGu+8b0XXdVluuTwkbMyG867r4LCj/MusPU6RtHqR4WH3KEi1MOcECzotq+Tq0Kdb009DBeoS4LfLFf2H4b2U9YGjJumT98DByeI3asn4suxSQajR9Hb6eOnyp7S1/DGJiwg1bCP1VEdn6iDJfPSe//1gtAzdXsSC028C/MR6MS5vSCdS9cjglGN63EBhXmd5ckg1WAVZuifdH2aRP1mZWuhFSnhonOF++Yxgptk+GKb7YbeQLi2rjfazfvqImclRsnGu1cdXbuReGSzLpdGUGyrofTwjrkjcQS6vwpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OHsp5mI3yQn9DHcjJ1PrziL5UqaHpzIRwLXkKu7z0=;
 b=eHaPZOGQChk9LAHLgFwQD7YeZuLpMvNdeyclyCf7PB2H4FY7mAjGNyAp7qO0UO6KK+5AgDh1WrBY/2ZIimgmxDh1B38HLLStt1FjSV6mn4qmMB1QDKZjtlI1xwbWO5c2PeW2y2XMrUBVtdZ1oCXMNkzwZ3LDY6FybWDl9/brPgvQ2yvnEtCyocJQs1WQXF5soAHdnch8E5O+gJiwayiVFaOKsOjgbexxddaVlBxQT7yEnQTq4PjHmTYHSlMcxw0GOCCCGD76njQxYXp+8sjhAIWzuu4Z5htTQqNdjA0sbhqAzykjShPpDIztYCzULHzZVAHwlLkx+4wvNhfIxuwoag==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 11:41:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 11:41:15 +0000
Date:   Thu, 8 Apr 2021 08:41:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210408114113.GN7405@nvidia.com>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406123451.GN7405@nvidia.com>
 <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210407122042.GF7405@nvidia.com>
 <MWHPR11MB1886AEAE97A9E6972C63CACF8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR11MB1886AEAE97A9E6972C63CACF8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 11:41:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUT29-002gu0-Bb; Thu, 08 Apr 2021 08:41:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2ee5d3-ae12-43db-37d0-08d8fa833743
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311345EA793C5FA1CDA9C122C2749@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7f86JSlLT3HDyCU3AtMKPNBzH7riFib8cjWXyYC7QZ777SSYTNLMpKmT8M7TrFOyoehBeVv9yuN6ywvrknJtPXc0XMMMMVZtGjkUIw9aLI0t2hjG6eQ7cUERmpMmkV9sstw8GM6jLQ9Q8GXYdH3XMZk+ieJahv/XFLtoOlhKvcK8lZ87SCg2FQepxQJCbPLeQtCGBDdNEuK6FdSzZYQjnfV0zDNJxW8CTE6MvC3fqX7XxX/c+wsolc7reWflCvxO2yOIMD5Ygz8If+UU1j4HifdNrMrA3vLJxT3DoANhtJwQgmXXFLE2rMH8BPBg4+L+hsZI31WrIvwYLyaflimRWEEWP29RsEb3nVO+2yI6Pakge84sEpHjEpw49LTOPGzCTvbC0W7H6cIsnIK1Jq+fabmfKjDFh83KNoJf/n/hYtda3qhmLJY9Pzp18c4Hk4DzoIIxdxRh9jNGaepVwfgeiXx1S3bqwkI/WNSXJZEeoVYQKGPujifxHRdhntMPoWMCAFxWXY/r1T0aufXx/7o6qzF45a2F7m51ZM1W5TxxaD5T51o8K3RthE/RSLJu+2LhUoBfQyR1h28wWk411g6amg5PI7gjJmKhcN9TTDhZKndcchRIoKGRafIgaeteUnB6sikdBaNu7CsoiFG6UvftmE1lDfsRu+Fix0C2w9CwaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(426003)(36756003)(54906003)(9746002)(8676002)(9786002)(2616005)(8936002)(66476007)(66556008)(66946007)(316002)(83380400001)(6916009)(2906002)(478600001)(38100700001)(7416002)(186003)(86362001)(5660300002)(1076003)(4326008)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk1IcllHYkJ4MXdzOWx1a01sTU8wRG1HNnpIaGVXVEg4TGpVSFFEVGtzS2NS?=
 =?utf-8?B?R1l5cUhTODE3cHNzL2paR3FsOGc1eExOamlja1R0R1lIY1FXVzgwYmxNalRJ?=
 =?utf-8?B?Wnl3SE9STG5iNEkxbXZldHdaQ3Z0VjJwZFE1ZjZMMVIvUnEyQlRPOVRDQWZk?=
 =?utf-8?B?Z0trcW1qNGdMRHdSTEYxZG5HU1k4Q0dBRVovcTM0eFdyeHJmZnJ3bEpnYnh4?=
 =?utf-8?B?ZStuelVIT1hDaTk3V1ZLakg2WkVzc2hRWG5Cakgrb0ZQank2YmlBeUVFbEVW?=
 =?utf-8?B?cFNOWWFGU3dXV2loeFRuU3p6V0lGeG1BUHVSNmVxSXFBeExQdGhmMTJVbmEr?=
 =?utf-8?B?SlpaaHo3RnkxOGFGZ0xsNlR3Wk40b2dydlU5eUVBNVRweFVqYVFBMGh6TUZt?=
 =?utf-8?B?dEszSFpsM25RRnBRVXYyU1dlalRtYnZuRDd5V2JicWlUVU5lMGJaaHFLU3FT?=
 =?utf-8?B?TEQ3VVFNdHMyZTEveHYzZnoyUjFsQWduUmtUNmhVbDJSWWtZQmhneDh6eHJa?=
 =?utf-8?B?WVJvNnZWNGlzSmtaWThKYkpCaUdveVhGMXZXN21xZWVxdDBWd21EL01QRG5o?=
 =?utf-8?B?d3JJNnRYZnRHNk1wemkrb1NLejY3RDcwSGxWcmt1NFBMaTR2V0YzQm5YWWhH?=
 =?utf-8?B?cXgwblhHaG9JcGdBb2VhMEJiOVZneVZsdHZVbXBtTEZxWWJzRkwxQVdlc2lk?=
 =?utf-8?B?STJaR1BXSWZXdlVYMTE5RFd6MUEvZ1RjR0g2VWZPOGJxOWIrNGQ5Sm5xZENL?=
 =?utf-8?B?YWpsbXgxSHRuOUl5QXg0SlZUSnVpOThpY2NqQmZCSjZvY2FkUTBITW9zTjhN?=
 =?utf-8?B?Q1IwazRHSUNPZVFUdFZEemI2d1JBamYyOWdacFJ5TVAyQmlROHhVYzBoOVcx?=
 =?utf-8?B?ZHdBc3BWMjJodWxDWFZ5bkg4bEczTWhzTnRESWhVN3R1ZzAvZFhBS2Q3VUUy?=
 =?utf-8?B?eTJPRUhJaUlrTmFaL0MwS0FLZzVQVzZxOUh1VjZtY1dDTXhxbks0b2tQamxj?=
 =?utf-8?B?K2czMGtPMkZBSDlSNzBYZlZBaTRpMmlVRzYrL1NCNUxxOGVlMXlackd4eE1h?=
 =?utf-8?B?VU56Zk9mdHBoNzFtS1NzQ2svMytLQlg4dHRrSEpJd0tXMnRqSnROSUZOUElp?=
 =?utf-8?B?YXRrZWJOVk1TbjZmaUlEMjcvQ2RjQjdqYTEzSklwYVRpMWRoUkhXdkJoRmt1?=
 =?utf-8?B?L0Q3Q2RCYkw5aEJHcVlWNkUrdmZXeTAxWW9WMzh0bThuc25RTGEvbk9QRXpK?=
 =?utf-8?B?QXN4SW1ENVdiZDFWYWE5RGd2d1M3blFVdXdKd09YS3RxSnVLWTIxdmpTZy9T?=
 =?utf-8?B?YXB0RVJ2UHdadGZZVFhhbjA1MmFiMXJhMkJYdGh4bkF0UmMrRHVyVG5NUU9J?=
 =?utf-8?B?Y01ERzJQTTltcXJJMGRMMUpwQnk4YTJlYzdPeTZ6Qmt1cDAzdC8vVURmTG9h?=
 =?utf-8?B?ZHgyR1p6RTN1bGJhTHhaNzZkRUNzT2d4U1l3dUl4T21NT1JHS08yUEVDVHdy?=
 =?utf-8?B?cy9Ta01jZGphc2R2cGJnMmVnRVc0cGVjZWI1N2srMDlTOEJ5OVQwcTlWbm9T?=
 =?utf-8?B?dldqRFE2L0pTSitMNmRxY2d5SW9aYnVveHpIUy9yVHlBbnVTeWo5dEJIOVlq?=
 =?utf-8?B?M2xnaFk1by9vRU51aGlIM1E5QXBYZWxJSDRaMXE1alljRC94TXBWSm5XNkZY?=
 =?utf-8?B?SnVWT0ZFa3IyRUcySHFPcy9MSmxEVDljaTVieGdJSVlxeUtNbGtSNjlwenBK?=
 =?utf-8?Q?QAWFtUsbdhD0gxbrxFu/UNafD6EyR4MMjqOccyl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ee5d3-ae12-43db-37d0-08d8fa833743
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 11:41:15.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hppP1EQxIDE2JqzFbsRJneV2TEDenuRBviLxrHQiWtijBlptfVI53YJZUxNCBwwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 07, 2021 at 11:50:02PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 7, 2021 8:21 PM
> > 
> > On Wed, Apr 07, 2021 at 02:08:33AM +0000, Tian, Kevin wrote:
> > 
> > > > Because if you don't then we enter insane world where a PASID is being
> > > > created under /dev/ioasid but its translation path flows through setup
> > > > done by VFIO and the whole user API becomes an incomprehensible
> > mess.
> > > >
> > > > How will you even associate the PASID with the other translation??
> > >
> > > PASID is attached to a specific iommu domain (created by VFIO/VDPA),
> > which
> > > has GPA->HPA mappings already configured. If we view that mapping as an
> > > attribute of the iommu domain, it's reasonable to have the userspace-
> > bound
> > > pgtable through /dev/ioasid to nest on it.
> > 
> > A user controlled page table should absolutely not be an attribute of
> > a hidden kernel object, nor should two parts of the kernel silently
> > connect to each other via a hidden internal objects like this.
> > 
> > Security is important - the kind of connection must use some explicit
> > FD authorization to access shared objects, not be made implicit!
> > 
> > IMHO this direction is a dead end for this reason.
> > 
> 
> Could you elaborate what exact security problem is brought with this 
> approach? Isn't ALLOW_PASID the authorization interface for the
> connection?

If the kernel objects don't come out of FDs then no.

> Is it really the only practice in Linux that any new feature has to be
> blocked as long as a refactoring work is identified? 

The practice is to define uAPIs that make sense and have a good chance
to be supported over a long time period, as the software evolves, not
to hacky hacky a gaint uAPI mess just to get some feature out the
door. 

This proposal as it was oringial shown is exactly the kind of hacky
hacky uapi nobody wants to see. Tunneling an IOMMU uapi through a
whole bunch of other FDs is completely nutz.

Intel should basically be investing most of its time building a robust
and well designed uAPI here, and don't complain that the community is
not doing Intel's job for free.

> Don't people accept any balance between enabling new features and
> completing refactoring work through a staging approach, as long as
> we don't introduce an uAPI specifically for the staging purpose? ☹

Since this is all uapi I don't see it as applicable here.

Jason
