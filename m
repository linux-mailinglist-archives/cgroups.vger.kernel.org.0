Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0681E3920AB
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhEZTO6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 15:14:58 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:62689
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232133AbhEZTO5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 May 2021 15:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5EaASX5k0eg+8+S/XOzt17c6M790r/ecjjFcGeYGwESDn1XRsnk8R+bCRvYsmwT+a3IjP3DYyNn24UtFZKv8dgtvu92a7AuThkQHb1ht7o+gHzI17M85FWXEDzrVEfHksUMtpjoUk6gPqQTpUk+Hy9WezaG/8I/IgxfMafICCZ7dqSwVcq0PoCGmGMBeQilDlAmlIFNwNxluoLfin5wra2E+nZUmcsg5sKNK9KtP1pCagwGx/EVwGo4KjIg03N5v6w/np/oRL3NvEtygxWh+38V+B+zaSYK9cH/qnVKAOTvdL1suWixHqBcTQWWjKoR7qZLlLP9dZqtZDUfluDuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWuO9e9xT6uCDc51InbjAXoSqaQdVWoQ3GqsT4SVE+I=;
 b=UWW9Oz7c0gw6uVJAZH1XDqGo+OU/64PLNXSshyhvXhUgIn01SfKqk5YvPBOV7HI2FNOMCmJZ+Z8EfE0eSyAmWBgczI6swzvMxrws0BgSCn9P5vo8Ga8d197Do439cH3qL4ZkQ4n/svdribJAtWcBR7hdetzNxoFvwloZg3knmCgxoGlL3nG+LpNTSRaGS8/xO1fSyv7Zvx/pjsYhcsPaKmel4qM6CrBk6l7hCDOf695X88+NzKZPqNnEEbdHyQ9fZxXX1W+kvDuI01agLgGkBCay3DqE2yE8CRM+a3ImbYW6MGhIj6mF8B0w7/ADTI3HDfQLfY5i3qHiaWY41dKYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWuO9e9xT6uCDc51InbjAXoSqaQdVWoQ3GqsT4SVE+I=;
 b=mC8Vk/BZMuGQ9+dcKC5CDBQPUR3rAIEcSdoIlDqhxH3QcefGTHvP2JwdDyk1Vr0LR/8yhPCaj8c1EyH8mD8k9YsowGQRXQhYSUd4RrDoTtpIIB3LT4/sXNUJpOc5T0nDtDA/wIPZ2suXtpzJ27edmulW7B24RLIBI/gQZsVJnmo+C11BnFZiGZIQo5ILYspY7j4/whNet1uRlWvwojzy2iSgUaD4OdRg283oeiaKz5o1ZOE5VaV1ct6cspZq/nAhgS1oKM/Ut4kerzrQsdSIo75+IdV0so16xphObhkQdJxo3W2FtEUHi9ips9nnYNO8xGoFQEGSceDUTkZYwDNItQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 26 May
 2021 19:13:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 19:13:23 +0000
Date:   Wed, 26 May 2021 16:13:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210526191322.GQ1002214@nvidia.com>
References: <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525165252.6959d9da.alex.williamson@redhat.com>
 <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
 <20210526125905.61e00a18.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526125905.61e00a18.alex.williamson@redhat.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 19:13:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llyy2-00FHoE-AU; Wed, 26 May 2021 16:13:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279d8b3b-c87a-4bdc-2edb-08d9207a5535
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB537805B3E80710629EDF0885C2249@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3uyMzckQYysMCaXhLe3SPUG95Sb7XiEVRMnHhEFrAcklWn2GXoeBmBUEpv6J1TAXCSSUPmAB0U7sMG/bZR889jCTFGptVpYvW4SMztlg7tq/P0cO/ETn7Pqzh34HrvlDI+lWtSpgd2vNTai0bfYLqZc8Xuwn5ZEizpw1W5Or3yu+6rnl8JzB/YOM0wrsI5vShYKDWaFLqaQT/hjlk7tP/67wcwNyXBcfKYACWmdWxSPmcosmBCWYGSI2VxYjAGDK8G/mOxJk9nrJl62jayyfzX0ZS5sAG2Mo9S3WpV/b4a+YTPqElkdmx1gvHpvME/WBop8FBTFYIPNuoDv7avZJo2qr3pGp0QnwOQ4xy5VHIN8fL5fHugT73/+nnWh/ZPhEScymCfZDC4hVnOw2a9/VJvMkn0Nsi/9bEqtYgjGT9oGZMPMEv5yAm5VUyDmPEd0yT8565IWdFsPaHiB7PMZJz7x//l45xMa1/ae2X9TDYlYri8Lzvwggg7A8yk0+5idVho5w7ahKGsd+XN4SFzRc4ZOSroXm2IhvsBPtOOFzmT4EPZXkanc/J2340Nsp4FoOL5xr6I40epcDY9SLkpSuOMV0lTUbKLNV5URCynAEh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(478600001)(8676002)(6916009)(54906003)(8936002)(9786002)(4326008)(66476007)(316002)(9746002)(26005)(66946007)(66556008)(186003)(2616005)(5660300002)(4744005)(2906002)(1076003)(426003)(7416002)(86362001)(38100700002)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JJrAlqwRkxgLHKBIi9a9pVMlGZ5eUJSTHZP8V+1o/wvW9C2XGbRXdLIhc4HR?=
 =?us-ascii?Q?WDuuj0QxpHMDwknLZ5K8BsmaxALE0dJUg0DjNdeRkcYL2xfFvoNk/2npmcn4?=
 =?us-ascii?Q?aWozB6ccg9N5eDYlZx1Q5+mTN4daXWGWOlmnxzTZMiqFLKVdWuyq671wXPGd?=
 =?us-ascii?Q?AT5kr1xaU30m7doZxUrFK1QNY7we+cFBXO6+aOcR+cM7sz4tOCPVGRBqiCSX?=
 =?us-ascii?Q?0zyQZUk5MsS3aW/mgFbE7iBQ4u+YlxzLP3egMg/t5C5Iz4kJoMeLlv6ljL/T?=
 =?us-ascii?Q?Qq1E35LTDdz/NEIMKHWDKllqN6pT4vyXhMWmldfzyqrV0PwkGHDRGHBL12ID?=
 =?us-ascii?Q?Ul5ImJn6Frvs3Mr+CCr2YfGPPI8t0BMMukMimKDUs0gSdXC3fdiA9w5lxbDo?=
 =?us-ascii?Q?P9o5X3sNeqZ7CL/H61/+LQx+PP7XrKwKRfyBoWaBSflscGVmLm3zN+YPaieH?=
 =?us-ascii?Q?ZYPCtDXEoebAgU1ismILXcitI+pwAl43hvyjBJ8JyttB+aOvCfMsFclvz8Wm?=
 =?us-ascii?Q?5f7an2nbIGbzyi4p34eDeUc5oHrUU7KdR1k1nbOFgh/yOKhl4a/K3Hi3TeTV?=
 =?us-ascii?Q?mpZ1l5xsgJMtWJxP6G7kitcBL6DY0hHGNTpihhM5BOrzK3uT2qCz5tkvQ+rf?=
 =?us-ascii?Q?NFXp73s4PFon/PhkRxE1buPDe1qqxxP8mKs7aw42qgCTFRKbngSV0Crx4pnG?=
 =?us-ascii?Q?hODlAfcUipu0mYInREo/rOZ/VcP9YNXBje79E9PcO1+aT+6GQU1O0pmb603r?=
 =?us-ascii?Q?7L0oAd7p6l2TyCC9QyKYiTdvXm5DHnGFGasx59pzk+sdefquxmJPNnLUkkRB?=
 =?us-ascii?Q?IE5W1aWGCl2SHjjyJZk9wMBohbMLBOHp5225Vv3prcmByonf9l4VFpdv7DcJ?=
 =?us-ascii?Q?4orfwpkPI516hfcwINzu4gqr8n8Uw8/BnyQRpAPRGoQrvnVj5+rYLI6B0LfY?=
 =?us-ascii?Q?wnhryC80tsy02ifxKMlZrlcpxpre9yI/+eYyE7x69S7BXMHIovXmSidvk9j9?=
 =?us-ascii?Q?8m+jYDaoDsZ+XlRLhgGUcVQwW4Id9bY5DUJA79v/2ajURSw+FojJFHsFHGu9?=
 =?us-ascii?Q?n+vMDvf66LHFgYeKVSLdkqt/qbYxz4RqlY+myDvD5b2kcMpLiymi5h/Kef/2?=
 =?us-ascii?Q?4QWSLJR0CN3Y0gbr3bAYkhlqUPLBfjne1VGFPEhN/x+XjOfYFyTe0suq5N/E?=
 =?us-ascii?Q?9Iyf/VI60vYu7AStWEUSXxbNX2WprfpRLjWTpuPzhWFE0jHLe4/4Tsp59UOJ?=
 =?us-ascii?Q?v5nGhwQ+8mW37GX8Zf7Jy3F4L9hoPncqc/tMV+NtVE44tDdpO2/X1tBn7Mia?=
 =?us-ascii?Q?JxCNetIUIPi4+TEDWgTG/kkk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d8b3b-c87a-4bdc-2edb-08d9207a5535
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 19:13:23.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDgfjLoMDn3USYzpsMNjZompRGH9tZ2nSsPZzIaJWN+g50A0jUqvjiZPi4sl0EEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 26, 2021 at 12:59:05PM -0600, Alex Williamson wrote:

> A driver provided sysfs attribute would obviously fill the short
> term gap, long term maybe this would be standardized via netlink.  It
> seems a bit analogous to setting the MAC address for a VF on an SR-IOV
> NIC or VF namespace configuration for an SR-IOV NVMe device.  Thanks,

We have been doing a lot of work in netlink/devlink to program the VF
settings before starting the VF driver

I've long thought it would be good to standardize a VF lifecycle in
Linux eg VFs start their life in some 'unconfigured' state and drivers
don't bind, then userspace can use the PF to perform configuration,
finally the driver can start on a configured VF

We are already doing this model for the mlx5 'sub function' interfaces
which have alot of analogs to both VFs and Intel's SIOV ADIs. It seems
to be working.

Jason
