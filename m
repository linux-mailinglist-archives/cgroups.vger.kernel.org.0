Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2C709B89
	for <lists+cgroups@lfdr.de>; Fri, 19 May 2023 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjESPrw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 May 2023 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjESPrv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 May 2023 11:47:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC31B0
        for <cgroups@vger.kernel.org>; Fri, 19 May 2023 08:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M69v5e5yvH0Deod2gBV4ORnD4rEi/6oa4wMvqKjnc8XL6YN3KR91xSI4FEZUxJf7A/Sz486I6V/9P7jXCFe21cwKCziWZ7UEJ3x7Mj9YP3FA1txkaBP4qHnx+8EvSS8dnG4PLGXyHNzd7ZuUEZvXhYVwIkHTXNvyC5+LhzH0CGU5lknPAGPEjVGTwxgWuuJ7jWmOy7spuUlwH+vbA5DP7xUIl1ll4/ZFkVNPe4mpZKBdeLl+8vIMVK/ALQqQ3OLEwe9KEUySBZ3dKaF91uarzg6Ar8ex1SzRPtwVg1YY2QBEZwkfTqdNGz6COmNwGCWbPv+sUFcrUkQDdkMh41961A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B3ZJNti/BIrnUQZgRjatFOd4YicJhlwK4Ri0TYZxeU=;
 b=HIVdMJMBFecha+segg7erWrccWppYdDNZb4AMgEqtfUCGjTftakwX4cgptwpm+GCEQkEbZAMqYe8BnNPpT6ygqFHo4cuFct1hU+AbE734uFOIMO4xBZjtEI4vxpVtx9FMRMqMF5MdrOXqh0tdMFIXEvd3MhVkvCoyjgI0TsNRQ7NZvzWrhM5bdV+EcGHjT9cZk8aSgCl3Z39ZjN3q4P513VdNdFjHZKcQL4nQoKG9PQZSWMj/U5jeOPp8HOQK6ZO13zc1HR60ZLNt7Pvyzto7vDzQfwfYyNY3vBm4owDi2GtpcsgXIjYdBmZVeW4n+UVQjCaENSSsNQJoMWkuomb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B3ZJNti/BIrnUQZgRjatFOd4YicJhlwK4Ri0TYZxeU=;
 b=bi4N+LhS5bzsDssw6Dr3JIhQkC9/b1ntzWuMOoTDBkuWGU+JEQpq6OLY88ujMwvQivJj9Ucst7GKAbRuaSgcntWCFipcm7jtOETE+OzMu3dAKHvV4F6slNTku7CWGwy1edoaR21227D5aX3T1mUtI7Ne/5w9nX6JyZGf8cwpfaZ5R0Qr7VRTF14CFNRBIE58l/UZ7n0B634QB6GlNxHpXlXNKdgl9u9eFDJ+9z0B4ISYCwq6KSHI400q1ZPotTgkLtfOYdSxC6SSHhUVtYfb/JPvot1vj1CZtM0Dx7zY1uoqgK4bY6IO/oERDLP9riT2CEgHf0hvFd+RMgk544JKmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 15:47:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:47:48 +0000
Date:   Fri, 19 May 2023 12:47:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Chris Li <chrisl@kernel.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZGeaI2jmItJj1twS@nvidia.com>
References: <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com>
 <87jzxe9baj.fsf@nvidia.com>
 <ZF6rACJzilA06oe+@nvidia.com>
 <87y1lo8nwp.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1lo8nwp.fsf@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: da4bb66b-8dd9-4969-6dfe-08db58806525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+W9QmaNYZkl2h8sfc9XaslzDNsi+LNo3L/Moy9DxDJOhhp2ySemwSAvuzRdTMYb21ozbCVurmZpVHo+SwVuBl2EvNP5u6zZ4ac5NH5enFSp1EtPxzse6P2sMROe6iIjrjs0ycDsFyVHE8zc9caNpjIzWFQPTnXvNPKFQMLAdK3rp25PgzKJe8zSn7ntq9XT/rRUJvEaTZa4H4G2+fUIAMT2crREXq87N4E7kNEopDIS4drdIyCt2i5enY/hqchFncZX1GR3w8F6kWOPZwqVSHfGLWdpJ0nU1bZDpTyd6LWNF1WUIJ4QZ/iNuuJ24JrroK5otafcpEmeh/lqXdqbiRZqE+Pvz6mSoLy1IFD3cKQqcaipbCUw9neA69/dSbjwWX/jvvKi6cwFo8wmZ8m+00O/5zUzKuYpwkQShgc9/qerLuwOyMKdkUUEzGnhr4X2s7RPai443IHzKT/fHpl31E/tkEgoQiBMldtNNb888KZz886QkWBWcLePgVdt6NePsYbMSoPwzubwKg2SW5KchcaPzi5grfM254QL7cCZA/dAEb2pRm3O/PEEACi3Ez8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(6486002)(6506007)(6512007)(186003)(5660300002)(26005)(8936002)(7416002)(66476007)(6862004)(8676002)(41300700001)(86362001)(4326008)(6636002)(37006003)(38100700002)(316002)(54906003)(2616005)(66946007)(66556008)(66899021)(2906002)(36756003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGQeneu7ZlHzB6uhpImjGKF1zvCdY0ceeGDLzsTnI+9yZerGwtwAxZ60xmPG?=
 =?us-ascii?Q?XDT3F7qaseZWDqP/iZuubB6GeLh1hfUvncJ3E7POuKMW7Ztwgbbil7oMZrM9?=
 =?us-ascii?Q?6uFIUQkIC4QM/sJBX0T9wFN1lszDIOQt31NE3iyNVZieSKVDRGRgz2T1pTKT?=
 =?us-ascii?Q?baY4CCGfced7vLveQhLyAeYmrDbUF47zQidvTPR8gmQ6eKXwwwSH0txb7nrK?=
 =?us-ascii?Q?RXvzUNXx6pgHpB3KDovBck2mJxXONCluD8VC+3JFDYSefu5/3gFVE59vwvJu?=
 =?us-ascii?Q?72TKIhdANgTBce5cN7e+2fP2CsyIWWv+ywbMN7u4AWXiTm9Zh/8iYS9/GnpV?=
 =?us-ascii?Q?+08WI/GqHLasAe6hz//h3/QB3K7ENw9xWv9sO6ty8gYI6hLXYKE/t58GpS/O?=
 =?us-ascii?Q?BSMFT5QAIB3A2RDhZXu2w0zQS7xrycRD5kR22hPbm7yEn0DbMZaNEUXzPpmQ?=
 =?us-ascii?Q?p+W9WRQbUbQyQmw2nyJEB/9+kNAbZJhqNAYTIN+Sr1UIoo/LZ6K2O+zFKl1g?=
 =?us-ascii?Q?xySI/wo+MKcBzzxPci0oOh1bk0VunTRaAN/pXP6QZqULY2ZcSwi4TokLEKHi?=
 =?us-ascii?Q?sTu08IMQzs3FocaniDz2iYkg48Wjifv09NitVL1f8uBzhh/KyTunS0Ut4tRT?=
 =?us-ascii?Q?UEJzg8MT/7iDxRdHGoH/3AHR6RpbIpZk6oPF+c5yU9MAywQU0e5DUv/EMQ6v?=
 =?us-ascii?Q?n9q6sY7ZAVRTObMB8Dh9ZJeIYHht1AcRJMj9iPegK6+8dirTZRBPI/XEvU2L?=
 =?us-ascii?Q?5WkBu6LvyEjjxjxZ0L4zifzBERkUcKk9Kh50boS817p2DVVjKewXZtVmt6Hh?=
 =?us-ascii?Q?n+lO5FACGC4qJX4KZO/OXbUbtZ9INpA4e+5Bkx9BEi89AE+Msb05iIDNuuLk?=
 =?us-ascii?Q?istlfzVSoystGBk8cF6gnSoWlm62i2q2Yz4abSduEbO+8q/0nAxyidT1k9ai?=
 =?us-ascii?Q?MM0IC+kMpAT5JT78yQTnvPbiXwE4G4wGNHFsCHlvJG4xRQmWCewk5wx3eidz?=
 =?us-ascii?Q?Tv4vvrLcSGFR/9wcgcgulmpykDPGVouKJRjCQiUGRq4hRLCg6Rcn5Wcolmtf?=
 =?us-ascii?Q?jrCGj7xytLZAxNmQXgiWpl3o4rTyIKLp9eZSdsvxVGfAn8E7rU19T+w24rQ4?=
 =?us-ascii?Q?OB4RWxUzZHMmlSNLPWbeOHTF2j8wwTE3hUhv6Q2jgpgrK/r178XV2Brs27z2?=
 =?us-ascii?Q?adqPa0f9Bi/P4NBoWSBV1olTE+xN4xnCz+Lm4l7lxeV1MhwmYNxkhVoq10Fi?=
 =?us-ascii?Q?O9q5KRpkUXR3CzUbZY06X86ACyZc9qgVB6BS3MxNpo/lNpphjEkeEZtwn4Zn?=
 =?us-ascii?Q?9cv1UouzQaSnSi0KB1h0vg5nhKTzD+xIf5H51zZpur+/RAvjtHQtrj2s0/Q2?=
 =?us-ascii?Q?P4k8Mglg6NzK7VIE8oJuYP4+OT7IQYOAoaE3yVE+eTKmBwbtMejUKrEoU4zN?=
 =?us-ascii?Q?xnQW+O4szNVSR7Sc37ZySO4LgcLnV7cHwTgeEag/Kso6v7cbQDu/IHPDnPIE?=
 =?us-ascii?Q?I0p6XlXt8/nXaGeV+iEG0WLUXehdNedxJyceloO4bHca2HLv4FRnXVrp4tbe?=
 =?us-ascii?Q?46e9j3IgK5Pt9Uvs812WbJ27GwbpIgWLf/ku75bj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4bb66b-8dd9-4969-6dfe-08db58806525
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:47:48.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1V7mR0KHgjgqlXNe1pqh08SNj3aAbod/hJ8M9nUIzhKWozxWkrGD0VuXaMOsAnnB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 16, 2023 at 10:21:10PM +1000, Alistair Popple wrote:
> 
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Fri, May 12, 2023 at 06:45:13PM +1000, Alistair Popple wrote:
> >
> >> However review comments suggested it needed to be added as part of
> >> memcg. As soon as we do that we have to address how we deal with shared
> >> memory. If we stick with the original RLIMIT proposal this discussion
> >> goes away, but based on feedback I think I need to at least investigate
> >> integrating it into memcg to get anything merged.
> >
> > Personally I don't see how we can effectively solve the per-page
> > problem without also tracking all the owning memcgs for every
> > page. This means giving each struct page an array of memcgs
> >
> > I suspect this will be too expensive to be realistically
> > implementable.
> 
> Yep, agree with that. Tracking the list of memcgs was the main problem
> that prevented this.
> 
> > If it is done then we may not even need a pin controller on its own as
> > the main memcg should capture most of it. (althought it doesn't
> > distinguish between movable/swappable and non-swappable memory)
> >
> > But this is all being done for the libvirt people, so it would be good
> > to involve them
> 
> Do you know of anyone specifically there that is interested in this?
> I've rebased my series on latest upstream and am about to resend it so
> would be good to get some feedback from them.

"Daniel P. Berrange" <berrange@redhat.com>
Alex Williamson <alex.williamson@redhat.com>,

Are my usual gotos

Thanks,
Jason
