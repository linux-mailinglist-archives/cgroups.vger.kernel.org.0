Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DE37A99F
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhEKOju (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 10:39:50 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:29921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231652AbhEKOju (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 10:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2Bbb6pJqzIjWO/9zvdiEB85cxP9qVBTkgowCwDLdeTg5VDXCYjT9RE2mk9XYPim1HvI5avGgozC9JDGAISk5T9gUMb8Bs11p+0PdFi3saHIXDP0z00n4JMzzvu+42FZPuVFWfqUFhelA4FJ2OC6635msSuaGHy6ugQU06ZfoP23brTpbIPtuYUsIoxsHOqjfcPO9MFjqJMcsGa8kgW50Fa68V4Lkuqps/FhlAUTvNcDt6O5M/zMWEKPOEnSTnpz76RPlnnQD40tKQUuTnL2J3/3zQnRK1ODp2QrCQARGdINOr902wd3nwiaQvm7R2baXi5LWkZYq4mS9C3nxKmhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OMfWZvNL8XVN0Eq8qQEaCJm25NFuVDltqXLJAjUpac=;
 b=KePGNgFM/t6sYoiyG2z2ElZuy/GJfLCU473FClh/nQa02B9JnnHY7SIJXJbuXTIWP/UYt8KDnGw2uuxDJpP9nc5YMgIfnuDd0uwwZJM8fxDMIwV73G/jbDURLEME6K3UZNeDhN93kXb8M7V8HhnySYQ2KWmyEGvz5uFmXotqGq5dr0LCEXwYGX490DEZjmNCEmVwSr/8/6Tk45aJOIdZdecDcALHs5ZoO72NBXii+VMsRsTcmGc592xzCtUnd6hxh7qaChCLIY0ooYbQFvWZ4HnXS7KrqORvYhi/YbhfBfCy3wytiKmgi1VQtCwq18LMbMMV4G0v4wGD08Kgy7oDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OMfWZvNL8XVN0Eq8qQEaCJm25NFuVDltqXLJAjUpac=;
 b=dqzdeesY1x+1S0AGDzq8F043OdtnVXKnYP13vLzlFfeRlbi2131bKz8yz43m3we4AIcXowxauy9JFy8NVJOdNTBo8fUkzZcwnn8K++uew6S+FBtcqwAPzObxUB2ZYj8ptlu0zztzH6NQYPYUTleh2YJW7zMWwylLAh2mFaGHIcDmnQkQkqsXuo8LS9thNUOWcIPNiHZIaHsJe5IkQq1ZArTBUqguhhvsI3ayPG7fk3f+tRt014luP7dCcczAc1jXCKRK1hWMopXSPyOl5pgP8i0f1gms3d0fkCTng0KKLIcCSaByh0UEHdYJWywgiOxZraEYdFIBjSg4dkms8rZeBw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 14:38:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 14:38:42 +0000
Date:   Tue, 11 May 2021 11:38:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210511143840.GL1002214@nvidia.com>
References: <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Tue, 11 May 2021 14:38:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgTWy-005JN9-PB; Tue, 11 May 2021 11:38:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb71bcb3-b358-407a-d372-08d9148a7956
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739D43F378152B9BCF65278C2539@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvL7JkTEMko8SNNuTblXwhaIRiR8T+dF5pl09mzAtaVO0uzC9dVkWdf7yWJHw26cvCjkVnG3BbcjstmSleh657JlGdxDNnFCt9nAVULQWvVCVPv1vezySCwmES5EQIgO4E51VSXhZt297H3AcgmwKmyPqD23quhpvnarvnrDnRsSKAtEfs9cnkHiRU+v/HAhyFGzp0ZBtrkhPmOaynDUoLU9AVFNe4zMs7fhzkI+ZIDGf+CF69RK29IX+Q5OZMgOnV/GTpMg1kcH4rtTIvFAbMZ4DOO9Mevbt/YC8TweETm0rbCV4hGa5NzP4MS4H3Jwoy9q+Haw3pmJIDmIXxLAzPKGVVyNkMgh0GZ49sBYPa4Govf7e49MGCA8gZ4JvH9ptJfJR+QShKZEPIB/rXuKRJQKjADbsvfDEkCQfNqTE3fDiuZiXRfaR05/vfRPYY+ONW30T+79i7+msAL1Yn6AEMjSC34CsPAtVZyG0m/tt1tfy0pVuxsniRJIdd3YFVz3XfJ/rYfrhtcWHVqkqstHJWuOgZ6AYM26hczUvQ8b9p3FOHCt4550nssU60CDI0xOKYUMLUthErMpHQ3GoEiJmuQG6opjCSbImy2Kn5Ws6gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(6916009)(86362001)(66556008)(66476007)(7416002)(66946007)(2906002)(4326008)(1076003)(5660300002)(9746002)(54906003)(478600001)(33656002)(36756003)(9786002)(186003)(26005)(426003)(316002)(8676002)(8936002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ItoyRa2M5frlc+uXbOmG6SXgpRkHEAR8tes7LDoa0eRAHbBOmVd8zL/h4U6j?=
 =?us-ascii?Q?hT9CiyipVwa21qrGC/29TTqdKFoxYNuXEFC5dHrggMlyXDR6gRlPPXq0Fpyi?=
 =?us-ascii?Q?PymTM00YPze1kJaLlOs/SkZbYVRqeUnNs0appn7kPTWV8cTuMf7AGmmHwxAl?=
 =?us-ascii?Q?XUEtF8Rq2/SLwhOo95hH1hr79nzUr5uPfz4Kawgm6szC3RBCVLSpxXM0wDRr?=
 =?us-ascii?Q?8zNmnAd4jZtL9crw+BMySNBy2+jI3Ehr06F5GUd3jhDq9qe64/xPHIS6WYxZ?=
 =?us-ascii?Q?56QC3dA/ky6xxotwR/B8qMy+RETtsbdIE1+jprCcBUJ1u2BP/+Y3Tzi+JtEW?=
 =?us-ascii?Q?YvM+AMMCbeJfb5cpeAegPagWkIKOdVlpZtnCSUK7DWL5mstZS+uhJfzJlB2T?=
 =?us-ascii?Q?/97bo0l6M2DOJ1yYQl+kWK6LGfxGZ7LIuRospiGAhylihas0EtttuASudu8J?=
 =?us-ascii?Q?1/rkYRMJ5IxgK/wesdnZk9B+s6gajxVoRPf1Ghq5L+LGlPtnU6Qmoyg3TnQk?=
 =?us-ascii?Q?6x/qxFWz5H6+4U8F81l1ws2rYucFd8rLKQ0gdDBTrhFXVc/ASMUTP8EsunpW?=
 =?us-ascii?Q?WJMJd7vQFd0g1q9YlN2jOKtX00744s0Rohzcu2h3IJtsmOd8l5LNPUCdukk+?=
 =?us-ascii?Q?MSmlls3neB0IJBMjClobAT1+fhT9HT6MYnipcVdr3xJrW3Pe1bdwOXFRa2gf?=
 =?us-ascii?Q?FbQBvPoeBfF/NgP7MqIxYYonwTGnMmvIdatJTVrhgYCgtKdh/oUAiGBbI/bf?=
 =?us-ascii?Q?EnTJOrbnoPyneiE4El11OXE41H1k5A7iDKdK1xq8dFbXXNsUahCfK51LxLdW?=
 =?us-ascii?Q?NrP4cNkKpB7259r8eEeAmuUnF7ehPRpx0iRWXqjGDvgiCJvM4wSils/W69um?=
 =?us-ascii?Q?1AfhXUKHFB4aFHaUq1xYeHobnMozmKlTjjAn+Hz8jzEEOjoRCXBU/DufYoA+?=
 =?us-ascii?Q?yHCdA0A7K3wP4pEjI24Gs9O/iVOcij5l8FjnDBijgGh10pFCiAHn2kFY1sQ9?=
 =?us-ascii?Q?becS3ub5d/fHAJxbA6Qx2zTfu7VJBoTN+mcVbF/sdXgeF9Eb3+wxWmQ4jX50?=
 =?us-ascii?Q?AQOaI6ZMopCFV/90eh5RpvuJNdabNHepDFxNan0gZxU+c9myxSa1zrAoqgIo?=
 =?us-ascii?Q?zLtxcdteCgpGbEda1sTL//QzSuAMPCLcXurSe/2xzHcIeXv0wMqe4zA4p2YV?=
 =?us-ascii?Q?2TDKssoHXVGcNUVqb9RCL9RqycKiolFL1d69l4HsT6teyaX9+8dLK7D69h3b?=
 =?us-ascii?Q?eY7PayykJ5CijhJBdlTJe3nRXk/vc79Mq3DczTC1IRp7NWpudBY3jRRIZUQU?=
 =?us-ascii?Q?IuStR6pSNgF8EDx62yxJWMKR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb71bcb3-b358-407a-d372-08d9148a7956
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 14:38:42.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA5AijSzVOgFIPKsxWiEkQIPJ5HN1ee1yqjvCWlmAe8Mpo3BD6aqs1VKk5lUCWQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 11, 2021 at 09:10:03AM +0000, Tian, Kevin wrote:

> 3) SRIOV, ENQCMD (Intel):
> 	- "PASID global" with host-allocated PASIDs;
> 	- PASID table managed by host (in HPA space);
> 	- all RIDs bound to this ioasid_fd use the global pool;
> 	- however, exposing global PASID into guest breaks migration;
> 	- hybrid scheme: split local PASID range and global PASID range;
> 	- force guest to use only local PASID range (through vIOMMU);
> 	- for ENQCMD, configure CPU to translate local->global;
> 	- for non-ENQCMD, setup both local/global pasid entries;
> 	- uAPI for range split and CPU pasid mapping:
> 
>     // set to "PASID global"
>     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> 
>     // split local/global range, applying to all RIDs in this fd
>     // Example: local [0, 1024), global [1024, max)
>     // local PASID range is managed by guest and migrated as VM state
>     // global PASIDs are re-allocated and mapped to local PASIDs post migration
>     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);

I'm still not sold that ranges are the best idea here, it just adds
more state that has to match during migration. Keeping the
global/local split per RID seems much cleaner to me

This is also why I don't really like having the global/local be global
to the ioasid either. It would be better to specify global/local as
part of each VFIO_ATTACH_IOASID so each device is moved to the correct
allocator.

> When considering SIOV/mdev there is no change to above uAPI sequence. 
> It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
> cause any change to 3) regarding to the split range scheme. The only
>  conceptual change is in 2), where although it's still "PASID per RID" the 
> PASIDs must be managed by host because the parent driver also allocates 
> PASIDs from per-RID space to mark mdev (RID+PASID). But this difference 
> doesn't change the uAPI flow - just treat user-provisioned PASID as 'virtual' 
> and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use the 
> real one when programming PASID entry (IOASID_BIND_PGTABLE) or device 
> PASID register (converted in the mediation path).

It does need some user visible difference because SIOV/mdev is not
migratable. Only the kernel can select a PASID, userspace (and hence
the guest) shouldn't have the option to force a specific PASID as the
PASID space is shared across the entire RID to all VMs using the mdev.

I don't see any alternative to telling every part if the PASID is
going to be used by ENQCMD or not, too many important decisions rest
on this detail.

Jason
