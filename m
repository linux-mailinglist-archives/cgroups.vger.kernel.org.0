Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500AC69841D
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBOTHM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 14:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBOTHL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 14:07:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0BEB778;
        Wed, 15 Feb 2023 11:07:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myZp/fc0W3czbaneNppWZf3LmA6hFe5yN2WJ0fATaU/SS2iqM14+VpmOuygl+RaMil+PHtctSstele5KZkGi5btQvVqjCYB4UUAL5DewM9L7Hw+jZOLkBzA1z8FWzoEsJ0ffrrhVpUl/MpDQv4lt4M0lglOTtdFEH0djk5+H0fgh96PovqyHBemFuSOBM+a7Xo/1agfTAJg8A6v04C4M586x/f9yLSgNCjcgvZwqr3bLxmMx9rrADrSRQms3GfzV4EjX6vNBZ5tluq88unGlAmrd938BZZuz+j9lP+sVENzgyUSwe5/GCju8WAeeT4K0dI/n92I5J+ReKXuoGBi3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iPKtvv9wejlbWeYQwKPPsnqj4kXcryjfYKfl+hr2pg=;
 b=RjhtDsjSF/3NlEd2QMFMHTqtEEh9Bnn86Hf2r+yFs3nMRw988U7CuFrPdf3rYB9IaovZZUk/KqzZofBSO3SXmfoO8gvOSkQN6NEyyI5NVBOvo0uJdxnWx81owIdtxg3bdZYrreUuyrU22L2+juNSuETpB+fI48NCI0yIJ3PT9nGwBAn1bL3q/OEo3WUq9Re2ej4L4L2PgaUKUSezDF7cbxOB0EnIFcrZMpyFASo2jtRkcr8LSjU2Zc2a3YJ/ORvrLCXJEDY60Gj9Kc/X1KY8kDU2bT8v+Kuvc3yBsTtAQvIAAlUH7MvLTMuIzSL4+z3tR1CNvEboORKPrjbaat1n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iPKtvv9wejlbWeYQwKPPsnqj4kXcryjfYKfl+hr2pg=;
 b=AmsVkfhLYYqH0rvpSbGV2zJ5uqU4MpYSdczJPgEHFtlhXeXwl6xHLMilcN52vZjKAB7b3xmBoRkBmYCx/UybeiBqHgc5+2WWiKKmjBA+Mh3JNDzLD2ZNjA2NA1fTTfEzuXT6G4NKqbqO0UChIQ7w0TdFa0sZng4IaWFhwTT6xltCvgZMZK069V4LB+GTg6YQvVexwfozbrwMxJJoDzUqs2cexoJUQ5aljLbkfXNW/LXqu6NDAIRziq4j2v+ddPRF2JU3BLzS8eTEGkB7kZf9hlwMeTxx6mluMwVzcAPysje3TDEgoHf02xMoQ9crJJNEDN5urvDJjwoHk0Z9Yhy1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 19:07:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 19:07:06 +0000
Date:   Wed, 15 Feb 2023 15:07:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+0tWZxMUx/NZ3Ne@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ce055b-65fe-43c0-852b-08db0f87d458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DquL1+61zYLxymPu2o6jDuh/YAw1TKbZ8k2YyJ4SunPudhY0ZAMf1lEquGFhBAhm5yf/f00tCEwRj3wKLgAEW/mp+47NTKTxFzrzTDacFDyVtozlyL5OArQh4ok1sg7V08uuI6ENYJszxqxA9EJipvimejY9xsh6hHod3ANkVfd9ugU1KmSjY6zFkVSBbWp45VAeXkxW0WaAa0MfsUS9aLTXhhO5Wlf9lFPE67v3/VELlP/ZVzGPUXZrkn5TgYqihyZIDMoYCzdKd+cXUPGmGC5HgZhu/6JQpEBNWdmf9S6dz8LCg9mhFwSerU1P3qwaqqrQc60FEGZf3+XytkbfUJBTiE770W/Xr0u5dt5FMW44ycmpyMqef/dN61jBRE4mEHD0X/HSKGUTFkPypmEsALXqtv+Ko2hUpPDoOBoLkbvqNLIzA/PHSyJaIlhus9aLer+n6chXiRr8U8dNnhlAW/bf1LLWNjbg3IdSPJ2opRpdduAGRivIkUjMvK8T3CVXP6W+YIa4DZDTGYqc9kNWpZspmWPssRF0l6eXnjUu+hwkddApqftlwPQ2g5yduRaIed6zJIVKDuzGaBCtTxHJYHky99AZziJkz/7vNlNqHGLJCFmdWNCbwULl1Z/sLlqWqROw1/XxXlTJa7LrbIQq1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199018)(66899018)(36756003)(54906003)(41300700001)(316002)(8676002)(6916009)(4326008)(66556008)(66946007)(66476007)(86362001)(38100700002)(6506007)(26005)(6512007)(186003)(8936002)(2906002)(5660300002)(7416002)(478600001)(6486002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1Sv0wdmN2PHhO1XRwxXaVgM1yoTde48pI+OQ+HBOPfzfJGpCoga4/zmW1Ru?=
 =?us-ascii?Q?h6QGgjFPxVx1nb/AXBxbbAdKLMSLTWd4TRD5niNg+kioUW9JNN6CbMp6PgIU?=
 =?us-ascii?Q?aMrUs1UEtAwges0ssXFyfXKGjj60dtsthZiGa6zEg2rR9g4X3n30Z7XssMN4?=
 =?us-ascii?Q?rk4S+DZnlMMLRjx4OaZZTi1baHfJyxhvgnEy4bdXI0ypJF8ru0LiQUELBmDY?=
 =?us-ascii?Q?U0AMfJ6ibvWBe/IymfUeGD2GX9XkVqHPSzMWtzKU3N/ezdl4E5RIuwXbAEM2?=
 =?us-ascii?Q?LxKlfHC9KzBOJY7oeHKhnCTUacQN64Y9p2eInfegtxe3CkOahEn7E1iIg9gm?=
 =?us-ascii?Q?fGid09o44ohcUvoJRcb0VP1KSseN0YgvkdbDlTCb+owFLe20aKjQNo1dzoM3?=
 =?us-ascii?Q?5B/By2lB2wJrE1lrk9521/lkivt9X3HDi5EtBYqtUuZvmZ2LGfXyff2SPn9m?=
 =?us-ascii?Q?0IVx9okDJH3XuuNoGocPwkiktwyLCvNfsJJy3QaYb7g/+e0IKarRkLAMBjlM?=
 =?us-ascii?Q?AhBD7Hqc2ApZsTVsfgqTdgpj2oeE9JN9WLLI4ggfLJEAX+gpKr7TJ7glOlBw?=
 =?us-ascii?Q?TYdQSDyi9dRe0YKAjgYT3PxYW8/LphpT4nP5ttJ1DYkk5q0xqG4dUvukKiq9?=
 =?us-ascii?Q?wzgL4baqdT6qJ9pEdUFR2x3Mrw/0UCkGKdYbxYaSwgRujGvfg3pbQdWSMirE?=
 =?us-ascii?Q?8A3uEg5lj2eD+do2zErzejcXpQxdZvbcv/hc8v4b6+yDGkiLeS1apcpUgw5e?=
 =?us-ascii?Q?qDNZalOIXlMMnVwp4/TZUo2PJGtmvzFbc14T28j8FUPM/csq5XObROeAakQ8?=
 =?us-ascii?Q?NtP2uQIVokvwBkH6OLLsnrhEJSHipVR6BKki/3ln5dEuPQzBnNm++3To9V7j?=
 =?us-ascii?Q?GN86sZ9EK15tBBcTdlUkjb3GhDDhxWPY7MZIC3aeKgpVfAeXD8rm+5x1nGBK?=
 =?us-ascii?Q?YE5Pkg6KBScid6b0LLKRte1BmHNCwCz8xXNuxrS2fRlcwpuIJoLRME1sbAWz?=
 =?us-ascii?Q?sXkwFIdYbNvqa8nhRkx53C7GbDqr93D3nYRvFx7c641vnTg9bKfXyNc2zbty?=
 =?us-ascii?Q?gAcCeCrBinUSJNueIpgSTCjKSHU/LDtCyOEvS2iIXRtimaFin0oQSELXnEbN?=
 =?us-ascii?Q?ypcUtFxEeV24tPStuBzXmJS6U8Wg8jpfiKiwvvmREEW9mHFcs/1U618kR/B9?=
 =?us-ascii?Q?2o1xTnc/9NjvHy0xm5fs3IrCsMLc3pSBXWtwbjgFY6EMClCiiN5Ag3K/X4e2?=
 =?us-ascii?Q?7v0pHOtuL+Z9MVHUPH4EmOhcHs3rdTYU7+nJSC7WTsBQuMLaNmq1UG+kLkMp?=
 =?us-ascii?Q?f4vN2Ebu//F1rOE0pxN5iy+lOT5QVISDU9G5oU/Y/3jC0OHRUaid3TrqxAfr?=
 =?us-ascii?Q?ESFnUrRBjWCGry2yoONncyr/4cSUOKGRAFrJ0c9AVuBA5Wf8nfEyYMbtmqXV?=
 =?us-ascii?Q?J1l7RXZRHXKq34rGsjTk9XZb0I4KXM+4DgLMzKOzSxz/3lsZpXpf6zm4+anI?=
 =?us-ascii?Q?Sx4JlWiI5mRKkfLuv7BO2BZ3IqBgFt0kJ6a06LmCQCUYdlVewVzEJy65uO4p?=
 =?us-ascii?Q?Kh4EC7nnfqAW0gscOsmBmjgVKj1ccp6XqPbZ9A5m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ce055b-65fe-43c0-852b-08db0f87d458
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:07:06.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kzK3Di3RBKpnSGBtZgA4XBEqmDvauEdQ0vH0nc+jiZ8g2frdC8MySPOL6Hagc+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 15, 2023 at 08:00:22PM +0100, Michal Hocko wrote:
> On Mon 06-02-23 14:32:37, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Feb 06, 2023 at 07:40:55PM -0400, Jason Gunthorpe wrote:
> > > (a) kind of destroys the point of this as a sandboxing tool
> > > 
> > > It is not so harmful to use memory that someone else has been charged
> > > with allocating.
> > > 
> > > But it is harmful to pin memory if someone else is charged for the
> > > pin. It means it is unpredictable how much memory a sandbox can
> > > actually lock down.
> > > 
> > > Plus we have the double accounting problem, if 1000 processes in
> > > different cgroups open the tmpfs and all pin the memory then cgroup A
> > > will be charged 1000x for the memory and hit its limit, possibly
> > > creating a DOS from less priv to more priv
> > 
> > Let's hear what memcg people think about it. I'm not a fan of disassociating
> > the ownership and locker of the same page but it is true that actively
> > increasing locked consumption on a remote cgroup is awkward too.
> 
> One thing that is not really clear to me is whether those pins do
> actually have any "ownership".

In most cases the ownship traces back to a file descriptor. When the
file is closed the pin goes away.

> The interface itself doesn't talk about
> anything like that and so it seems perfectly fine to unpin from a
> completely different context then pinning. 

Yes, concievably the close of the FD can be in a totally different
process with a different cgroup.

> If there is no enforcement then Tejun is right and relying on memcg
> ownership is likely the only reliable way to use for tracking. The
> downside is sharing obviously but this is the same problem we
> already do deal with with shared pages.

I think this does not work well because the owner in a memcg sense is
unrelated to the file descriptor which is the true owner.

So we can get cases where the pin is charged to the wrong cgroup which
is effectively fatal for sandboxing, IMHO.

> Another thing that is not really clear to me is how the limit is
> actually going to be used in practice. As there is no concept of a
> reclaim for pins then I can imagine that it would be quite easy to
> reach the hard limit and essentially DoS any further use of pins. 

Yes, that is the purpose. It is to sandbox pin users to put some limit
on the effect they have on the full machine.

It replaces the rlimit mess that was doing the same thing.

> Cross cgroup pinning would make it even worse because it could
> become a DoS vector very easily. Practically speaking what tends to
> be a corner case in the memcg limit world would be norm for pin
> based limit.

This is why the cgroup charged for the pin must be tightly linked to
some cgroup that is obviously connected to the creator of the FD
owning the pin.

Jason
