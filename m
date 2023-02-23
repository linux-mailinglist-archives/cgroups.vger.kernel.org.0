Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9A6A0F3F
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 19:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBWSL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 13:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjBWSLL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 13:11:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E19522A24;
        Thu, 23 Feb 2023 10:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8tswUcRcFsfK6jH1WRB0H2wCG7d/fUHXOnj1dneJkGuWF+gqAjr08d+nKB1OwB/w3BwFq55idfojIYZOySLBr+ZUjwfbXHaSuaIFOhdfzDFbR8jd7VeeZiCVwGMCqrUjwxkvp+A49BhPh+TQ6W2y1w3lkQSDn0qrXOP7FHFkdQM1GRobelthfg7tuDe2gJx45bhTjEyObQWvzF3jM6IiDM4Uic4wfArpSSIO/9KeXKcNnq/jPIh5bSbREY+2tFgAlD4VtkOKq5PWQUIAFrlueB3rrgH5X1njLaXnl33e/+eeHnPIUByx2KDqBljg4a6bxW4/mjXrGmKq7Zn1zykZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAXBMEHjkUp+0vj7OPO2O5OssGr66dDJpPIUENBFNto=;
 b=TbijRjsJXdssdKYqphBLZV8wq9vPZYcVYEIqlA1teAtki2aB6+1bd5PXw7bHjCZDbVTdM5ehsSJDy3g27h1GcEWoxLFN9UlGBbt3WypVp38KRyK2Eiazm964C85+TzZd91flt9ATfkrGQTzzmVBrmlVvkB6V7HSipyeNQYVC+uE3V2etAzQkEN97vL+7CPxKGP2hElwMbpcnAbpiJIs87zJ0T5dRbQCk9iP38alLUA0coPZFWutQdZ1MiAKdKEcFN4F/FjmIm/tx1o2TSIMN7w5ZzhWmufb0WbRnyEC2HTiFrPGOIBXYzpuZb7PAdRS9Zk9uTI9+dsByxDMHR+GutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAXBMEHjkUp+0vj7OPO2O5OssGr66dDJpPIUENBFNto=;
 b=UrxhiQNhhKH+ARXM51IYi1pNkKVfnnT1IppB4U4Mr68nBbhNJbMs0xIZE0nu7g2VTYk7ZyU3Te0q3o7XiwFal3UvSBmcXSFSI6MOCBM2X1j22PpExMQozyDnRXZRFqpXZfOYk7sGnU5sMwCL1wlxOqSGSe8mzYmvQ5PP2ELRSkWof82teI4o2No2DLazb36a8tvl1Qr6MTflCN/uIMlG0e8FusM7zfoOplQWy7vwAuWEMb0mZxrYp9JJAKB/no+YWpOBHjkcB4uxA05e9X2KJgHJosdF++IDwJg/giCJamjg6nvYybXZsxEa+E745aBWApAyTTdF+/cUopglqk2rUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 18:10:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 18:10:57 +0000
Date:   Thu, 23 Feb 2023 14:10:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/esMBOyTaJnv5CW@nvidia.com>
References: <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com>
 <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:208:e8::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7caabec5-fefe-4683-076a-08db15c94f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbcMAZXQuQz8lUtCXtVq8154Uz+CPUT0Ud51u5k3zjaUF+JmCVbA70H7vyOEI0Vjt5wU23wsgSwZEkB5J2wT00DG1Md9IBJNIo0S9w74cMeLxYzzADYTE0sm1CTIneCFmqx57HKdNDj9W2CsucaO94j7aNYJNTtul7Flzoqd5tUq/zcnYAGD+A2Hb6xIJ4GRF1L+muPVDRJoyxO6WEdn7xVCRVhfyY4UHWtc53x7d6EOg/mSUBkNH8w18IKszNSo5lXsXUZWSrho/gkWlJLPmM+BygJpIMnODRb9kjk+woDTH786/4a/QMMLDDLslgDy9FT1v7N2UtcnUobykTm4fszFCDIefF1RB50cAtE1/+PZBVCnniSzRF6X8YrSA+xlOerGMwt2RWsSgg6klmSw3lQGExo/I2CItVsxh/+7jEoYdM7aFQVedZidDRvgBPHqmu7rlcCvLrVSOFHTpDNbAhxNWJx+Nl3McrLXgiy2yPmvVOdza603ehqToXdNUuZmkgiVNgLTHJ1SkeFUmJeRfIu1qZCqxv86+sEhw+wWbUI1C0uk/z5Y4b94c94Bkb7qKuRSkwos/KJTZ2BmMS3bm0fj3qOtt8Bcm/m0M2j/sKmBSjKSLMBOFSX9jp2q2anS+FlIrb5NC2Xge/8AiBndow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(86362001)(36756003)(2616005)(54906003)(316002)(41300700001)(66556008)(66946007)(66476007)(6916009)(8676002)(4326008)(53546011)(6486002)(6506007)(6512007)(478600001)(186003)(26005)(38100700002)(7416002)(5660300002)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8BS+5wpS1p7jnfRKneLY7201Qn0jCflI5BRLafA7R1jyCtLP/DwgmaO+4of?=
 =?us-ascii?Q?iJVBtfXNyrNWzCASXNcEC2mz303KWS2lf/4qvWPSJPcnH7CbsD0A02IbIvej?=
 =?us-ascii?Q?eRZSLT2WouusZsO8CTEmYdGseGKMoiiZIytFPonMntwKlkmL74m061aQNei4?=
 =?us-ascii?Q?uq9uC5Fuiwa8ZwxB7kBy2YGVoN62+legFVV7t9Nw5rPBNOHNbAgEfdAOsSWf?=
 =?us-ascii?Q?wV5K0MHHtR5Y96eYsnUZRNw9vZO5gjQcvyyhxP2OdduZ7RZfVm6DDkBvWxJQ?=
 =?us-ascii?Q?PEgLjIOxyTCvKNZMlAPN5r4yg8evkmLNBunLd/qTDb+j9d3KC4MpzwgY9wx/?=
 =?us-ascii?Q?b8TwOQTY35gwk81oKnk9I6tFseatcuIwIdDvwtDUKkVKWPD4zg4/QR/j4E4J?=
 =?us-ascii?Q?6GkjFkFH9NzaZPIQR8GBSYdm/mQ6gbqdrXBnnrWkCCbgYe5Kf2NSTFtoWfuy?=
 =?us-ascii?Q?igrQLf3j7nqgDhlTUAZ678gpLLLYdNLmqHvXLMhn2YBfuNtk+bTBuR/khe3m?=
 =?us-ascii?Q?SdlDdRrCh68sZ8+J94BDINI+QhRsGXswgy0ZS1Tvip+zOwJpuS4c4GgxyhHW?=
 =?us-ascii?Q?I4v4nDaHdf9R+WPJuzsAffMhDtD+kWVSyv8PD17Gg5JYC7XEiXJCI93FKVGU?=
 =?us-ascii?Q?f0DUy67Ldmgm8+ipQ1LV6GYBNV/m2Ym5u4sTzl1wSTLhEpOQw+WI3M/Y+ZAG?=
 =?us-ascii?Q?ytUc+iisnjNMcEoIkB5LuL5CWBn0zu0TafcpjD/1vRF74J7rj3WwH6RS73gC?=
 =?us-ascii?Q?sV/NqMKfnWVh5NEi9yCiBzsIC0O3EN/6W9MqPLdc0e5Zyoqq0IH67jXYjt4d?=
 =?us-ascii?Q?5M76wKL9cQFU+FB0DT2LvCx1oBigelsbxHGy0Jy93E7gOqir3qlpSRlEdB5v?=
 =?us-ascii?Q?92R0TpdRE7Tg9J7NwihAO+uXZhAlN5Am6JCr6IhQkJtzH+HwIiH1jI101xkn?=
 =?us-ascii?Q?0mX7JyuzMhPFbLPOlKrpFJtdZek10qaUNg1n9+Sff5iZOi4ggKe6ObqGOfN5?=
 =?us-ascii?Q?liGEunca9gPMyn8n/aQ0+oe01t/LqI2c8trdHdlq9/Sx+YyljV9yVaxvJ+25?=
 =?us-ascii?Q?2jUc2iirkCVxBx4Zr1pYzzOUlAsSerjpht/1UmTYXamjNjO0eAbuSRkwaBfP?=
 =?us-ascii?Q?Gpejpw8WdF2JN9Fap4ZBasP94mH0hmcSRCTx5xaem6BGNjKFF/toVtUP9l65?=
 =?us-ascii?Q?jgIrc3rNpNOFRON6ev/6uvRkMw6zM4wZGuOWoksbPpjvSTzi1LIorDhhL3gO?=
 =?us-ascii?Q?Pd0vSZoegIten3RPVwoNkHZQntvHW0ETKTUuuAjSQmidu6S/17hxypZ+Sw/V?=
 =?us-ascii?Q?2WREv2vOnkhQNi44wVwXazKFa2XCXNuVpsCJm6fOsVcssWBCz9fi8dfYw6L8?=
 =?us-ascii?Q?zHdGfBRutnfwwf1Rong4rnCVT96/NT4SSZHupTQ97sdfk+LoacznZxhp6e8R?=
 =?us-ascii?Q?zdgnWzNiT8+KlushFbbwPy+AZaexu7Llez2YSb2fu8MUVn4iximanhZFO+KK?=
 =?us-ascii?Q?5/v58uqDf3CV1MU49VAIFMtmHNz0r1yEzsrNGC+TnJdtzrkFJZ008nNH4dWa?=
 =?us-ascii?Q?cG84/tyIA/cMpW3CvuoMhrRmCcnsUmkkcenGzql3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caabec5-fefe-4683-076a-08db15c94f7a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 18:10:57.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+2jp3Gg951800U1wXfEWiGl1DOjJwHfpQjlqbPLzwokoW2uGiLY/xP6aQ/1sbPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 10:03:50AM -0800, Yosry Ahmed wrote:
> On Thu, Feb 23, 2023 at 9:28 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Feb 23, 2023 at 09:18:23AM -0800, T.J. Mercier wrote:
> >
> > > > Solving that problem means figuring out when every cgroup stops using
> > > > the memory - pinning or not. That seems to be very costly.
> > > >
> > > This is the current behavior of accounting for memfds, and I suspect
> > > any kind of shared memory.
> > >
> > > If cgroup A creates a memfd, maps and faults in pages, shares the
> > > memfd with cgroup B and then A unmaps and closes the memfd, then
> > > cgroup A is still charged for the pages it faulted in.
> >
> > As we discussed, as long as the memory is swappable then eventually
> > memory pressure on cgroup A will evict the memfd pages and then cgroup
> > B will swap it in and be charged for it.
> 
> I am not familiar with memfd, but based on
> mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
> the pages they will remain charged to cgroup A, unless cgroup A is
> removed/offlined. Am I missing something?

Ah, I don't know, Tejun said:

"but it can converge when page usage transfers across cgroups
if needed."

Which I assumed was swap related but I don't know how convergence
works.

Jason
