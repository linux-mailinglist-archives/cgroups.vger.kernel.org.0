Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB334E86F
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhC3NI1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 09:08:27 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:6240
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231848AbhC3NH6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 09:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDcnhkdBAn3K/W4u1ghnXkknCC0rbO4UAd8NIAavDc3A36d0dR2LRrRrpLF69Y2UiTkccvoUPpOeRS38C1t6j61V8dxP0p92K/D+RCOyViASzolcWy34vAeASsEOUjupWkOxo9MOgEnC/9Yg5uTHMeV2va+6vqWqEij2ZGicmsYgHPgTgVbpYW0IEiJOM3MUnqPuvehErshNoMUo2BMwFUVTSd8B2hKHw3fYpzbShC06ERYaMDQmp82ikkOPq+6BR0F7U6yRcVeGEDaRutFe3RKlGEaQenAejb7KbSfgjGtg7niPec4hK2Qnyjpt23rldEERMuTZL7zwP0GWqRms6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s5RX/kaTQLG4ZYwIXZPhAg6lwL5YhEUVyeYSZvZ0hM=;
 b=T3qucr7Um/mV/pybGypfvvSGTDOI1zI/jrfwJcgnGp7QK6BSooQP3Kye2bfdVqyLj81g1v/Jq4xMPWsKr8S68Tz7Fb8ABgtbQ28fW/upI89uZ7sMKqrWCSk9L9Xp3uIo1VmcoZ8htKYMMVH86bdg/IBSRwLlOp2AS/6nHd0x1YHjh9IKTQ9J/7M4rr5MU2aucXzBA2jfHh8Lbu0TRj2sMvbezP2B9NAXtmLBJXQwA5vT4xaJ5r8JZterS7aZR0HPscvkFQerGIu3BhVU7J3bBZeUh1jO8qKs7/bxNYGoCrStSSBZLjd8MoM5wPYmMIA6m2IS+sI5hrkuSGnDJvEgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s5RX/kaTQLG4ZYwIXZPhAg6lwL5YhEUVyeYSZvZ0hM=;
 b=HEFVEbCBsqhoaugV0hOZDcCMEYzYsRClOEuU/Rpagb62BUzX+Z1C5W2D9stEcqeiaZuunva6VuWN0WvxJlMlgyUsfJMucHjrM4k/In2/yl8gbwy5KdAqQB32wYRJ9Bz/MdYHgc7BhJx/RHWIEqk29/83sZs4MTz0Yf/1MaF3YeBiypM4UvsrXPHvIUzdIrNgvdkkPLleBfLKdR4GCpqTZFJWw4nT/bysHv+3f8O3MfnBJ99Ut48FemWA5xdrPpKAs3Hle8kFhL9Hh7QxBg07pT8drwZkIPVBdPDY492qx+GkjlbNr3Hm8nrQSVY+2eZJA8g5a1CwIveiXVBne78F4g==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 13:07:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:07:57 +0000
Date:   Tue, 30 Mar 2021 10:07:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Message-ID: <20210330130755.GN2356281@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
 <YF2WEmfXsXKCkCDb@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF2WEmfXsXKCkCDb@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0014.namprd15.prod.outlook.com (2603:10b6:208:1b4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 13:07:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRE67-005t1R-CR; Tue, 30 Mar 2021 10:07:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7c2a20-b30c-43d5-0808-08d8f37cd62b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11478692BE0829E1F1A5BB45C27D9@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOBCxMia08uadq2NM2IL1kUkHwZtiy2UTRVJRoGOG3r7Mhc5lnoyFIp5xsmT+vEPStKsFVyMz5o1w4ZJjWLi8oyZ2aGmK/z5+9zGp6okaCJ9mxptNSxiO8vt8UzpqAgjWyFeLCOdkRHxvgYONZgtYwVcOOlK8ccR+XgM7YWoXxZ0Z2nxI/I7G1yT/WXrf42ME2yeDv4xRK1iQkzjC4Ql3juoKLczRg+1YuO+fwwQ30Ar3kcGdu6ssq+MwZCUITZU5rq/GHZO5l5TrP4zvrelPQt/iukpFSJ9/3OcIVcfzx+53h7NjkWLieNPqMjQSb6RdolRJBbBGjH9EiycgTI1b+EHzJZI7QGJqfjdBgOwgGn05piAlrWXrlR5q451DCx9Kvim6McU6dlWgpec+QgGAKh1/X3xG1/oV+5znAOpDHALxZjttehTTMdn5qvAtGXDDyqW4Sq13r5d9xclQpaPp/ITDaoCXwvwJLKbcg6v9Ds+wIQecPE7Zogz9vcFp870ZxUXsJ76WkSmxn+KlcqwXFKvhcsICAVZtw/0iR0ebYs3bDJ9epLZ7AGSjbkTJIMi1NXJwcop1dXlblCqKjmSfz9sThDPB6GHUvprJOij0rHvr7VRKq3WESB5RQCniYHZ+5Cj+J/8QfsRr06IRKY/4hIhZzGPj34OV+7OKB36fPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(8676002)(2906002)(66946007)(86362001)(4326008)(33656002)(2616005)(26005)(6916009)(426003)(66476007)(66556008)(38100700001)(36756003)(1076003)(9786002)(5660300002)(8936002)(9746002)(316002)(186003)(7416002)(4744005)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fFd0BZLLgivCuM2us8Q9Gtrf4aDP+yeFY8HeSb2jNmAu9SBjVgWE/GY0o1r4?=
 =?us-ascii?Q?9Ir06DBaWB1IeeVzm/8jxg5aAnvkk3RyfykKo1CZmrgGZI+TIjNb82+tKmsq?=
 =?us-ascii?Q?UktigdbuC/1vgrY0WLQ9K6dIUpMxgb3bVpBAJzeO15CZNX4CXVrF6Hj3cTbY?=
 =?us-ascii?Q?MoYEFI1lnOYITawBlOBEmtnM9yKWpnoFpdlhbeVaVh12fjpayDaarUENqjo9?=
 =?us-ascii?Q?/H4vVjaiPrPw7Ike5BsqH4BC7/WRbZ6zADG5aUjv2MHf6DYtH4OTfPPbXzgv?=
 =?us-ascii?Q?QWaPTU0ZgwFDGNb2CMdhby89ijgsIkhKgHnWIe5CW09/CKzzK5UhSe9Q7aif?=
 =?us-ascii?Q?Tso2QJgowF11PScfDJtIgBjSeHZm2MHSyeMBmwfqrQOiaH+FQckdIHmcvISC?=
 =?us-ascii?Q?xsgcBZbR+DzTuMHvd5UL2roS9apQkIgOyoWC3IScfnls3nkf51upJqVF0Nu3?=
 =?us-ascii?Q?D3k+nAJf26883dYiyK+VYdYprrH1rqMtt90FJLveuPv/Av+3UAV6Pmq8awIp?=
 =?us-ascii?Q?HioPjvs7/ioMuc3XUWsh6TPwFQ75nO7QHOXYgwbiXCDs8ub7F5XS7BUDGFRJ?=
 =?us-ascii?Q?DM74go59j2lMdSF3j2kdykE4TN4pmYfe8prP95QdmVWUzSKYok2pEGAWXUeX?=
 =?us-ascii?Q?HCeq7qn60PL02+szef8I/SlCIEJoI6o4vX/vaPhvziqzXfKY4DWm+5fgy5mp?=
 =?us-ascii?Q?44q1LGfHenWGlpmlB0nCHg0lFVcTOfkgnSx3XSE3knBX22S/X6J7lHjRuvkk?=
 =?us-ascii?Q?CueYsXm9RzQorfbl+tn8AFSYSyUZXxlyuJ+I6ox2sJnytQ087JlTh9SLXVFA?=
 =?us-ascii?Q?NKVoTISIffZbg/zIhBscxXwyXzpqAebYV5Yylj+K7Z/Rzocn6v9q6TDujfjx?=
 =?us-ascii?Q?HFSJgNycdm+kEazpF17SrKvYz+OxASEnz/3l1Ul1KNZQKiwwGSeJD7cC7lhF?=
 =?us-ascii?Q?l5sxb1U0K94HTOrMnMYxP5knuOfaEin1SJ2aQmfzLh/uLKB/iIz643B1myxX?=
 =?us-ascii?Q?TAL+agVNebS9n7aTLPwKaSfPnVkjbVIu7XaqeFy/rb87xcSOB/rAOpGbmz5l?=
 =?us-ascii?Q?5IfTQpiaxQy1FnstBR7cAqjF5MNUjsxgN4lwT8XgEeIReVjkFoSOd4+40WX3?=
 =?us-ascii?Q?s5zNbgldo95Nb95sJh4zpX9+LluGNsg/B3Ayn3ayuAxMBsYhPmKyYoPAXA7U?=
 =?us-ascii?Q?91Gd5ynNlOy1TfVz/4gSlOXepmfhtX3GiB/0HMpqBc3tXe4VgxGIDpkFz7of?=
 =?us-ascii?Q?nGqJK2Qohb5Y0SEI191Tlicc542J21iYxGc8QkayqIvqhBVmPkgyMyK553E9?=
 =?us-ascii?Q?lC5rLY0R3aYK3zKyyUyZssLz+fsJJNX52zBf+IyS4lxR4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7c2a20-b30c-43d5-0808-08d8f37cd62b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:07:56.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvEezWddZX80AoBg6BSKzponcgArJG87YiF9uZnFIrWtxH2SLTnd52i/Fsk60YxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 26, 2021 at 09:06:42AM +0100, Jean-Philippe Brucker wrote:

> It's not inconceivable to have a control queue doing DMA tagged with
> PASID. The devices I know either use untagged DMA, or have a choice to use
> a PASID.

I don't think we should encourage that. A PASID and all the related is
so expensive compared to just doing normal untagged kernel DMA.

I assume HW has these features because virtualization use cases might
use them, eg by using mdev to assign a command queue - then it would
need be be contained by a PASID.

Jason
