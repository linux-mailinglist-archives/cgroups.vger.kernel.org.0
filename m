Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4806F3741EA
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhEEQmG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:42:06 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:63200
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234524AbhEEQkC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 12:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbRhmrQdJMMQAGE1MulLCl0XX9TPKhhhvXyvrwQ82H4b+XB9F4JZqf9g07EZzcCeG7sODmN02sQmdsCRB3lS699yxTv2arDGLpJVehJKmFNmmUgRoNexF1Y20SILVjuFb3iQ0BA+pLYVWQcAJaX7TKEJ1EFtn/xN+Pd/nX/Ytoo6/+6VMhF1SlVsCH51Zx1XmCf5krhgTJ5fUqOYIloBtyUfUh28K+7pXHV/NVccbJ+P/RQAw7PseLNFQZYe67BLjKw6C4qOIRzQKd7AChBiE984XQdbjl+fl0/T44iUevLaAgNG0pl48wOxJsR/MpaA/fjSMCXu2eH2Q2wHFgl4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH70+oRTAyzUKrrZXAhjmmptE/7Hb7K1efCmOivi7Ws=;
 b=S6sfBaZOpDno0qIflVDmD+YU5h2NgGD4H+02o3e5USAp91r2GZtRCnMhUSZ4xHSeiSmR/79XtKL1gLTpAe54GCTlkKu4ovNc7ahIDURIGOolWaVGIkXkbmicYQS3SyFPDtJJbC4dvFJgkF4FdIhGbdzl0xGK1zQFnkmZuzB4FlQifzh5DtOvSAuuWwVIFg82Rfj1l9uz2uhspHRpeJ64zZ8GKM+a2xQrfk25jWAynOcf++Haw9bLgvV/UG8Kl6EmqZHGg/i4MeXWQQVYASFvi8QJfbDNesU2EMBWJO+WYnpJEpofd6m8FN/7NTc0Jn3fZ5IJoj0MqgynjM4f08E03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH70+oRTAyzUKrrZXAhjmmptE/7Hb7K1efCmOivi7Ws=;
 b=ScuNMw/M7/LLfEZP0gsU6ggeJlwc4P960HhbR9TXzIjZXVi5M4YzxOlYwIX7NxE+cb+NWvvfzk4r1H7dmQVVUWYK0cK6gvwVNobFPhkNCwq7qW6Gb4z4pff6wDQBnnk1zJmZ0PziFsn5TW7eomXyNDCatxhsB3ZORC/Ow1/TkS+bnOFOyPWY/GjBlZO8aTysd8/vAq+Q1oXPh67RqXCwuWZfwMoJAnzAA/C9CdjNHX+/8H+8DuXGMcN97m1+k8H8CLFnPkN+VCYEI4ovjnKfxqvDtjODHgPbbURzl4kqUsm29xKiT5LfHcLdlutAeSzewEiYI4yns9A3thQY6FypDA==
Authentication-Results: ozlabs.ru; dkim=none (message not signed)
 header.d=none;ozlabs.ru; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 16:39:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 16:39:04 +0000
Date:   Wed, 5 May 2021 13:39:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210505163902.GG1370958@nvidia.com>
References: <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
 <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:207:3d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 16:39:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1leKYA-0016Eu-Kx; Wed, 05 May 2021 13:39:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc817a0-8f1b-4820-86cf-08d90fe44b2d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44970D3D13668F35173BA526C2599@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJNqIvqOGTRt3c2KFcm6mtwGkm4lvT9WGWqnNcokrCcmvVt2DfNKduhN3RmTIjz0QIEVdNdwbtULZfNQSxEeYRopL6mDJkwwL7Qa1j3GCi1sIrFkEWZ/3UQ7rUzIfUbqjN5OmlPLLmsTPLErcgJABkgbeeVQFge9Pqu9XeRlPeREwEi8nfH2IhmiF2U5pTyMv182dscosdRCHlBGMacbIGC/FgmdJpNyL67FIsv/nPiu5xM8duOLr0bcuOCqSkW2qdlTCtCd90xJH6jjkcnJAPwMAddTOPO2A7umObw0sQDAh1lEUybFp6OClVs1/FV/3PWMZMdOXyoK0KxqQkk+FTKY0D3UThp6GxSYn67X26iSqe/EBQDabaA6ZT0II70p5MXhZDKXiWwsolbV5o5nbpAJe5R9APuZdgWFoMDhh36myfoX6yDoSMpKL7S3MaJIz9YbZGJWYyo6RvAF8O8P3CaB/bCHhTST+znXZgwpDHsHWDVLUE/dBowkeVGsyq7azAxZm+uw6W9NLBF6ZmHmtjxsSUcqoB27Cgw16SQl7cy7AymVz9tP9h/AWt75hK27f9IWmfhzLGNFN/klkqMissceAPwa2KG/yeRyKAvjXL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(36756003)(426003)(86362001)(7416002)(8676002)(54906003)(2906002)(186003)(316002)(2616005)(33656002)(4326008)(1076003)(66556008)(66946007)(66476007)(5660300002)(6916009)(4744005)(478600001)(38100700002)(9786002)(9746002)(26005)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6WKc6r5QMk5MTBzp5Kh4AZ4RZ+5ZzXTw4CZ+2ZsuxllP8MYh8yN6Cv+706id?=
 =?us-ascii?Q?PttWgu7R+x+mlnf2rGqM88DnXKhZlXc0TQbk7qwlikCZAQvrXcIO6CkOD+Oz?=
 =?us-ascii?Q?UpTZGM7EuoemCELLY692/DMTmZ+PxysaqYXF6LJD/y7O96nJnBwEeSAKvMC8?=
 =?us-ascii?Q?n9+xKUo+OWuHMCBm/GXOrGzQkRrCsQlPFKWX6q5OrG7R+AW4/t8tNYyQeEao?=
 =?us-ascii?Q?4NRDTxnhunWVDWY9YROeFMY9PFeaWwep5IPC3eTfH7KbnC4GqJAt9QS7kvcS?=
 =?us-ascii?Q?7uv6gSOREpatu+YxHN9y5PRaXqJe2e6NvnIFZvHehwGO0IyOhNDXI58yR8hj?=
 =?us-ascii?Q?5HTptFmEjRk7ZIFL76IweuVwurcMAPeWMKnrUruRqzebaLhqttk+fu7WyN97?=
 =?us-ascii?Q?SzLvI0adCDh2/4WXsivxD6GDldPbtR/PBoOwa1TAGfPrUIfBaWCuiVoWzD7V?=
 =?us-ascii?Q?ofP2OPVxB+z1vMktWCjD89J5UB6CFUxkrPkUbppoE5RX50UV2DOpOeKZx7xo?=
 =?us-ascii?Q?hwotLv0c7TljKQd0HKcYoL8rrehWuiBqi5YilgAm3arMk0WzrZsin3JJCkpz?=
 =?us-ascii?Q?2kAGCAcpbhM8ywoPjitBuX3EkR0XwCBF7EovKPiHcyzLCo2ud8PhJBhZOd0Q?=
 =?us-ascii?Q?PJVTI7ABsNhY/WgCjxP1yl0YsClgidTw2xWbWH4iFWV62DY6WrrKf4I1bBzo?=
 =?us-ascii?Q?hdIKnx4/sUDE811F0hCLv01L9nsObZ2TTDEP2piYzpF63JH2QISCnfUDbQom?=
 =?us-ascii?Q?QKaHXAWm0fcL2Xh3LWw59AdR+PvXNj/6MZxYNIGQYjhVfBZKtlGzjf3mJW36?=
 =?us-ascii?Q?Az7PPm+j4bBkAOxNjechdmGnyU2YSkzOZpOQJmWhvYf1Mhtp1dlGH7Nm/yjg?=
 =?us-ascii?Q?SR+fbiZYnkjXWF23CyIPDAcc0Evz3mhtnwVIsTS6UbU7rG8Giu1nxtjUzRFd?=
 =?us-ascii?Q?00MUTV4Bx7ODJnca3tifKxyrHV43bbXfpwvMj6w9VBd7RmWnAys2Yl948ask?=
 =?us-ascii?Q?MlWT1FlLo5/VNh7I9dcRf/pdsDVRswo8stjVMGHr1JDvhuGwhU4MbXvO1XnT?=
 =?us-ascii?Q?JCQC3R+n5a99PY9fxnG+xQYn3pPLCKt9T1wWj78EfQDjPsBlwTutPqerWOML?=
 =?us-ascii?Q?iNULL6nYEiuj30BZImtK/N9On+ZYHNGYFXIYwDOPZf2+Wpt2u3Rjxqjxrwn4?=
 =?us-ascii?Q?am14ccwoU+IqGPh4fALL6Lo7yQYYIK6T7t1xsF90KVWjTSDtQHwza6+Qg/n7?=
 =?us-ascii?Q?DJScQHI2/GcLIKvtaMwbjGrcdD50O47zWj0nHfe/Ud61wO0dPjdwDPot5I3M?=
 =?us-ascii?Q?TqnFJSUiULYo9+oD4e/Vpm2a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc817a0-8f1b-4820-86cf-08d90fe44b2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 16:39:04.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQsqC/Q8Nh8Gtd4j+TDtzl+keabd2z8JHK6V4tsy3+ft5AqtuSMTxie21Gb5YWKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:

> This is a good feature in general when let's say there is a linux supported
> device which has a proprietary device firmware update tool which only exists
> as an x86 binary and your hardware is not x86 - running qemu + vfio in full
> emulation would provide a way to run the tool to update a physical device.

That specific use case doesn't really need a vIOMMU though, does it?

Jason
