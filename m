Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B969E8AC
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBUT6D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 14:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBUT6B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 14:58:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE983EF;
        Tue, 21 Feb 2023 11:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7HPGmmI8YbsoU/ceoEnZFbmezScaIwJalJTrkRoVqZOgU0YA71DYpoOhagzUhyLZ1NN+JVnCEU2HR7lhl81He43e/KSFhkg5BKXtEt4MGHPdHybl/KP5VLqV20zYWlz/HMjNTD0jM8j8AV7LdZlbzBskSJh1y8YXgpvE2Ujs6MsUpr+2YgWo1xljjKUvUWXqlB0UUBJ1kVIs0/iWwpjXvyXKbZTt497sBe/tk0+ed8EjdMeIKfsuCI7brHGSDrtCKAo8ZP02x/I6y1F4kAkCNfyWYrxTq7i+YmcHCvhKhnD2QiPwiwz9S2ioY81DnaaBu4NWCzqSpGkr1FLbE+W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSDreqvyRDCkzqkSyVdaBlUtbcDZ0NNpwoeKOF8yZhU=;
 b=hXIbhd+hHFvtGMC9UM2bNO21r/+Hb1/ZcNRrYNJQ8taDC1e20M4VzcsBGhRC0CtM5P8XjrsCLrklf2bXLesfOfCLi8BMlOhvmV6hEhqhluW3a/a191NGgQ29DXTbybYe4Blp02nNDioTLiPFhVw+XyEMMQgDqO1AbXb/zeUJ0OolgwE6/50xhWezBms0zAvVIhrrHYSsUBGEOuGtxy0W7vnPhhexXHEmA1DXYUtuW3dMjnkxek6WwqKeQmfEZ2BKWKCT/FoYcjNIi9vFWV9KGWoaiwHZfVC6HvyK5Dagk3y9YQv6bAArQOm5S7At5ZutGCMX3pntVRDxKJK2yPRFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSDreqvyRDCkzqkSyVdaBlUtbcDZ0NNpwoeKOF8yZhU=;
 b=TPECyFzz8YMTKfWSvm800qazbZpvdzhf2S4mOL4dyL6TNK+Yh0dprt0CbNvEzAGnWqC1g8gI24CNorlyE/hDpOdsh+kbCuvbYjZbE49AiWZjUjL9buzLbL3ItZYyQfifom4qtILvDK4UO6kb4gVad1Y+IWLdjGtqxAZwUijTw/H7CYC+1F8qdtiggmgVCmcobHLKY1vggxmztZlceKlgLvF0wUrJdGrphSJTw/YYQmHSfeAbNIy6H5bJJokcZIbsd+nGeI39HWXSeG3vFn+VMmrJjAfguc6ObKmw4mKboAd6QZEVUjnTTyf1ZePQ6zdiR+TR87gy3rRXSy8Jetpm8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 19:57:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 19:57:55 +0000
Date:   Tue, 21 Feb 2023 15:57:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/UiQmuVwh2eqrfA@nvidia.com>
References: <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
X-ClientProxiedBy: MN2PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:fc::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: a99a5cb6-d5bd-4d06-cd74-08db1445ec12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dZlK/oU4wJZ88fyw4jeb9wD33UAtY6TgQdPFqfu6xVSDUKWthv9Y+Crg1p/njU+o3FbPZps3BVX9fDqM1yEtloPySt4ZOR/snOqwJnTJjjgbgwNq/ETl+IYHj2sdWfyByeMv29jgXHQKEjHC2H3pe5tPBGVRMWBw8+X1XUiEcR9V9e4P22tuS+U4Vo2vg0UOdGDANxsD1vGg6Y1fI6Ue1LxodhhcjdFxKaWoeAcPVjrRleMkLptW8pVIhtGq+FURCtKFFSWNEbxaiRsD2WgSc+zt7UJCwcsSx9vPjjBAuozqtMeVjKhr+MePZsO7xraljNrMWW+psGRE4PAGR5QB1S2vKme+JXqkXrw5BO3yOVW+gjrguN18ANGcJrOzpXJ1N81VJNUezG3NRLr05xUYp6arEtx+IP/TPuiPyu832fc7KbSOq3kcNzA5crWaKp22Cto6ROReZLWts4m7XjbqfTX51P9qZ0/54cJka/HoWZUcK6cUgQQ4gRW3lJyt2cfw/GfpWyN/UYdu2ri4bcXLLb1CFQi7eJjHgazSus+8CBZRK26T7rSxenr9zcYwpnDsIftSJTcvy2Y9FNy+1mIZKYX53V2dF5s1fbN2tQBolAS54XnP0KfxVnAALmf6c33KwlloC+fhWlN3znBTvWdsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(2906002)(6512007)(6506007)(6486002)(186003)(26005)(38100700002)(7416002)(5660300002)(8936002)(2616005)(83380400001)(41300700001)(86362001)(66476007)(66556008)(4326008)(6916009)(8676002)(66946007)(54906003)(36756003)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rfIjzFnt6d9aZf0h/BHYVlewEQFRNu/u8TS3yKDa/Hr9M6XRtPzHvbGlxMF?=
 =?us-ascii?Q?qvJ03gQpiRzUHM6jED8cN5C0KvzfOnsFv7Z4bWy+9sdn75Tlp0zlWSuhpEz/?=
 =?us-ascii?Q?iHhPigQ/1iJW0JBHs7xsWu8bKb35Lx7O2c/wOGbJt3zWKZ/yszZS8lr+7NN5?=
 =?us-ascii?Q?6685+fMcBfbIQ+z77KBdrbPU7Tmez1wkO9QHjnP9axgC1rAG4tiaocZ+K9CH?=
 =?us-ascii?Q?pTl9FxEvCsS4v36Akh/nCzIur/7ktn3InQQhUBXTdLHMcSNiYe66/ZPKktwa?=
 =?us-ascii?Q?3pixSF1rr1h1AjKzIIun2yKQFJLzMmlJyuz0f9UocpurXjrKh82evU4ZQySI?=
 =?us-ascii?Q?uTWnC9cBDAH28LkmKZAWSuBf8N0IYJt1H9KRiABHZN41Si69d0EHpmoJrgar?=
 =?us-ascii?Q?NyK+BhOud3R2Hr/a+QcKrS7/mV8lh7CgY5JJ/+u09jIz2ZuXZJTnIgWsU9jt?=
 =?us-ascii?Q?Y7unV8+PvTGYnvron8Dxmh8/3dATCBddAqIROjfXv+CmQoZzV8Pc/frykd3I?=
 =?us-ascii?Q?j7cyGzM8HdVdt/rTrqHkEfFU0C/bGqEtVO8fvfNGzVP0D1KpbGb/rFibmVjG?=
 =?us-ascii?Q?0bQiTv+ZL+flLIL4wPG3doFTDC5gI7590NePZc4pWIJ0MG1p8buqe9dOCIqv?=
 =?us-ascii?Q?fVRFGsPIr443AO+x8O1eTmytMLhM1tNqG110fg5pwY2NvU02sb4C7VBYaJW7?=
 =?us-ascii?Q?BmPR6L12MhVqgPrSWeqcFDZ+o7eaZIMJgNXCEy4ZYKI2oNEI8zgnXaMHBsjc?=
 =?us-ascii?Q?vn0qIyOAGK9XXtocyOAdSCMADik6r0vYN53tK4t6NcCPGEfLH8v39SuFDTP9?=
 =?us-ascii?Q?eKsEleMoOmlzGa4rHjNLNccL/i0rNpLFD6hSDdqod+fEVZx+ejNlHylMFul3?=
 =?us-ascii?Q?8Omedq9+ug54xH280MdbQ1e6nD+XRnOkLc7PfmBzspJUhrajvh9cYJ/4ABXc?=
 =?us-ascii?Q?ks1HnrEzbcaniyY0cmW0uBt5FUe3Fe+pT5YEpggRKjzMEmKdrGEkFiAMTovq?=
 =?us-ascii?Q?xCIHu653OOsFVcfKHFbyyd+NvOVUlN1GrY2iIVM9gTqwKN4UrqbZDAbNUrJ9?=
 =?us-ascii?Q?ow8iZtMfPQBICpPmSNv17YCjCW/LosEa1IbrCDJKzfyN+MeGmdTsEeObjpEQ?=
 =?us-ascii?Q?5n9ae506ijXVl4PrKq5RR4wZYj9r3EduyuvHwQbxno/4Pz+SiztG29dH16Dq?=
 =?us-ascii?Q?fTadDqhypmxF7BwaTDj2H0Sx7igyF3VuMxC0LTjvbDA3f78OU1kivVl04n/1?=
 =?us-ascii?Q?iJgXmXmxMEhyAwiTrUpWhDHzc8BfMmCWQCXRRTSrM+j3hDzw7vd2u5WA8Btb?=
 =?us-ascii?Q?SMCg+Is+0uKAOn4tB8lCZSNs7TbwkHdA9T+HMygmWJEVo2KilHWEuQUwJzP6?=
 =?us-ascii?Q?Ru2znYmoIPemcUx82Wtk4dSL9Dl5iOIt9oXF2ZkqOuKnA3sGK+gXu3vzcXLJ?=
 =?us-ascii?Q?asdThnd8WDfWGeNYL+0DeY+v4hUULlTv4phnwYRyB6cZhJzxKtm4JVrVJQje?=
 =?us-ascii?Q?ig0GeY11KwPilBnTtz5XmWVHcTK5H0ralsbjDwqonEs96vulskMY/q6nvlf6?=
 =?us-ascii?Q?9FLZKd45+XIx8ma+VVbA6Jqbo5RguxdI4vFlfCpk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99a5cb6-d5bd-4d06-cd74-08db1445ec12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 19:57:55.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLOTq5ghyvKO3EuFJSw031P+mix3Tv0CUWLaFHGvsEwphxk3AeqcDmlz31+V6M/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 09:45:15AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Feb 21, 2023 at 03:26:33PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 21, 2023 at 08:07:13AM -1000, Tejun Heo wrote:
> > > > AFAIK there are few real use cases to establish a pin on MAP_SHARED
> > > > mappings outside your cgroup. However, it is possible, the APIs allow
> > > > it, and for security sandbox purposes we can't allow a process inside
> > > > a cgroup to triger a charge on a different cgroup. That breaks the
> > > > sandbox goal.
> > > 
> > > It seems broken anyway. Please consider the following scenario:
> > 
> > Yes, this is broken like this already today - memcg doesn't work
> > entirely perfectly for MAP_SHARED scenarios, IMHO.
> 
> It is far from perfect but the existing behavior isn't that broken. e.g. in
> the same scenario, without pinning, even if the larger cgroup keeps using
> the same page, the smaller cgroup should be able to evict the pages as they
> are not pinned and the cgroup is under heavy reclaim pressure. The larger
> cgroup will refault them back in and end up owning those pages.
> 
> memcg can't capture the case of the same pages being actively shared by
> multiple cgroups concurrently (I think those cases should be handled by
> pushing them to the common parent as discussed elswhere but that's a
> separate topic) but it can converge when page usage transfers across cgroups
> if needed. Disassociating ownership and pinning will break that in an
> irreversible way.

It is already disassociated - memcg is broken as you describe today
with pin_user_pages().

If you want to fix that, then we need to redefine how memcg works with
pin_user_pages() and I'm open to ideas..

> the owner and pinner disagreeing with each other. At least
> conceptually, the solution is rather straight-forward - whoever pins
> a page should also claim the ownership of it.

If the answer is pinner is owner, then multi-pinners must mean
multi-owner too. We probably can't block multi-pinner without causing
uAPI problems.

You are not wrong on any of these remarks, but this looses sight of
the point - it is take the existing broken RLIMIT scheme and make it
incrementally better by being the same broken scheme just with
cgroups.

If we eventually fix everything so memcg can do multi-pinners/owners
then would it be reasonable to phase out the new pincg at that time?

Jason
