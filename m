Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA4A69F4F6
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 13:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBVM5O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBVM5N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 07:57:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181C36093;
        Wed, 22 Feb 2023 04:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMBPJsQpnyoHlZYHjWY9058c6WWqBoIBE9B2sCOhGls+noSTWj5PqGw/jThQK41ncUn/lhkj3MjSLlrhL9UW5OGjTc/mhRi0K0s2sj++Aw/z1zbN1+b8r8wI+TVYt0LJXT9GdMBSQgu8lf20VGI9krUyPzDqT6y8dNt9TEVUcOatzrw7LF+xPY+8wmfrL7sGKNRfz8+NAL6hD9jBAqdCV3wkihQnzodGaSQTM7NfcxrhqgyEbn7cWdlDmkTM47kjNxrOOzqQYcny3yh01vaBjYWV88NXKQwitfx1CdgHjW8cvM7lCFD8Gj2Sl9si6PN0DHBxB315IDEhXSKwMwlTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RIZyLsJETVGJGmuhJEPdBBNsg/5QmP04eJhuH91Hk0=;
 b=ZPqpb0Y2E0XKyFOG1uxRW0AWAx3mTE6W43449jvPttIykO6aRRCFwxjk0neHBWZU2Zw3r4QwuASfM1Hc2IT6XQP4lbMt9ga3RNe7IfFN3YBEO3XMzWnp31W5Txbg0MZO5QGi+T/psRXx3/gzxVUcPTXLOw0FMx/plseWDwnKSkS+7iax3iHcs2J8e4Z3BsHqYgmlZ7oIooEUOJmIhdCUx2urHaefzfvKuL1Cg6oWRXBHOrMNzgiJ8Elq/BLrABMJ4LLNSyAhCzYc5vVhlpsMltPw7T5OxTHdvteeoXx7VBpioduQeuDjVpdxUIecLHdXHreqBlwNxqCoR9o1wbsvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RIZyLsJETVGJGmuhJEPdBBNsg/5QmP04eJhuH91Hk0=;
 b=TntXxiLzAo+Kamy6sH0IlJzfsvDL+LHTJlcaP+B3dP0AFGrcME0nXipcCynUyCXYRGJh4Y43dCasn+qINtYu6HzXGHUgA+7OVUnv7LGUiZjaNLLRQEB+FLEj5ztLxfXBv5j0mCwSwlFljuSSqx4ba40WI3S6GoP93hD0iDGllbGUGyxhCLw0A5VU12o9njw3dDkpXmbFHxMyq1S8TuNJ9MhYin1/h7KAIgRtZ5+rf0bxpX8D5x76Mm6xXji9nP5GN2wikXoeJl9I9zW1Dwbu5ZU2PYqo9D3WzB/JNeC5tXawEh/yOe3WVCS89cLgYVKQnuadOG0jNdI+Ici2SDhXYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 12:57:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 12:57:09 +0000
Date:   Wed, 22 Feb 2023 08:57:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/YRJNwwvqp7nKKt@nvidia.com>
References: <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7pmnd0p.fsf@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 30214c28-0ae6-43b2-15be-08db14d44f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUnffRxkAnIFgcgREVPBcEDe4BpYOzKadiljx/ezYgMLYMnEF1KgeyBwBX2Df9cdx7yNPgSbplJlqUBmyO/U8OG288QBNZG25lD+E/93UAym/Sb7MIxIpVpFjML+zwczjPurTmiARtZjifdbWbd4Ov0MimVJXINt8TEkpPM4n50xTNNwoWxN59vLFCnmfCgLN/hMA8D5T/T8wu/BImUHkBsLJuBG/Ywn2D7zxCUWV4SwkvBQFn1jAo2s1vRuhEbKw35drdQUq/qpntm99ie+SnGmwIs7wQOk+K9JKsvOit9MITIPnDi0QHTZqi3D77Fl5Lamw1wAPhlFilF2V3VgG5lLECUNuQYGpb/27zl2Z+FrHylC0SI8UGLrPS4gZthbRTm4J7zgANuCuo/VXiKtItsEk3WThJ+1H4KoYVyEPrqgulUHBxwQXz1I8UQAN9layhKLDpa+BOuS3MCfFbRExtuyeVmI/nrH700S9Rwx39wFZk9vp4VDDGNViDo+pNMxoH9at2bPSHJ3juSpZ3ZLmcLXdKD3JBnhadjtTCPtF4Rqcsn/qZel49EVCGrQn9SsH9a3KdkHmVlIIEhGYRX141KfajPJUPyA3xlR38BQEAg0dWmdruFJDGLpDgiPjQDvZ2xZtnbYGl8vm7aCqyU5YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(2906002)(66946007)(36756003)(5660300002)(41300700001)(4326008)(83380400001)(8676002)(66476007)(2616005)(66556008)(4744005)(7416002)(8936002)(38100700002)(186003)(26005)(6506007)(6512007)(6486002)(478600001)(316002)(6636002)(37006003)(6862004)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxVfF1kOMeS/g14MOy5OpOXJHRwehC+lwdB4BrqjN/vfL3A1HJAqUmVts092?=
 =?us-ascii?Q?yec6Cd8w3UkfZG2wqtQTfW91DjD5SP+wX0NYHBg4caT5WCJxPV1r4ZMYYVth?=
 =?us-ascii?Q?Cb4GQ7stK2Bzg1eg/BUZ58eao6vu/zvUVxDLZojYuIGQA0z+ttzlJeN8BKB9?=
 =?us-ascii?Q?1DX8ZJU9GCaG0AUZ/rIIhit7FhEIVhucxy+Z3dLkEZv/QKQtUNKjqByQOsN/?=
 =?us-ascii?Q?ueEHTAXRrlA11EtqbgI70eJC3tGKmDDkB4eEljUjhaZcet0+RqmlaB5lJ+Eq?=
 =?us-ascii?Q?4EpxhhwoaEkJQyj3yxxFmcbdFo2kc2Brlwb23UkKpac4tR2h0ZQTMZnKDMX1?=
 =?us-ascii?Q?knDY+YNk7gSCaOLeU6IWAqRmF7hA7mKASP3eDGF4u9sDkYYdqBx7gImqPgPn?=
 =?us-ascii?Q?7ZXGalucaoaD+q4B9k1EUTHgtMwj7TZEDRKNLImBKK+M0njIAivfhsXx6SV0?=
 =?us-ascii?Q?1F5y8LW6dP+Ft4T6MlA7zePOk8tzWS/yzzLMwr3uaGCi25UOm12DhS+BJjSU?=
 =?us-ascii?Q?Abw1X0uU35YTpvyiwg//c0Zh5mBYhTocYLXwTaUmFbK5+3DV6U07svuX9a9z?=
 =?us-ascii?Q?jwSf0c9CR3228EilO/o6khAyqGVaNkTRDLTANL/DwAJHHdtzBqtn+kMWUFsb?=
 =?us-ascii?Q?NjiCDfB8fOv85LkOTQsYr5Hy8YYWwmgz6FY20pjpKTX98w7o7jbB+ttBxMjO?=
 =?us-ascii?Q?CgJIgpiigW60MWEr6NuL+ft3aKHr+xZ5/LnQ1KVurCm9/KOUHIFJ/UY/Ka8h?=
 =?us-ascii?Q?k+6KKRTVk52w4rAxV2P76vEn4Jg4+GZIE3O0lZEedivlNhfnT+y0MGQlO2Dl?=
 =?us-ascii?Q?dJ9g2wzdai+GdE+j6833wXRVzg+bwgWznTpg9GJzzs7I30IEAekJYVtbUNU0?=
 =?us-ascii?Q?/hfNdI9nSHO7hqQwtfZX/8Pzn8BomuVQ4aCnIgT7fhUUOteSVSvqaeu303v2?=
 =?us-ascii?Q?5p1KOn5y0bhD9PaHflA+MgYuzYfP0ovAjvzh09V5ob60W+cXNJDwS0ShyNdJ?=
 =?us-ascii?Q?IPb9or2cHcaaXxK5+vFSVQ1T9+7EIwOLd6MBrqXZ6K7sRM6j28aMuFOLuaX/?=
 =?us-ascii?Q?SzjCE7JG0eSIgUQAvon5YcSk7D3q9nt/KGZ/i8krPSoNMlI6g1R5+Y78HpEu?=
 =?us-ascii?Q?RioEOU9lWzexvKF+hCqRFrDfMh2GslB4HqU7Gce1j1xYnCM5dr0j/T2N7RQU?=
 =?us-ascii?Q?bfl/Qe3m2ksUOYIoqlUFt1iTaUYJvId98fbXeXyus0zXT1xVGIhT5CXPnWem?=
 =?us-ascii?Q?sSssSFkY9CPRfpf56qJyAOYRInhSmsOIA6ch/V1nBUwrqCRMNnim5J/RaprJ?=
 =?us-ascii?Q?5QEzg57jT1vFIV21GcOyj0ahR51RmZ+yFZ//VbWPqJ6bfAmd6nLNu+Lw6qRa?=
 =?us-ascii?Q?X6yLSikMvhjv60fdF/35KS3zyTk0Cg3C6GXJVHuZYdhyVfKC4l2KG6j2OHXq?=
 =?us-ascii?Q?PawuCVkR6FWVc5S6QJ6qw45Zjb0Xm1FwhEb5E/f+7B4QBPWXP+hp89sV/sW2?=
 =?us-ascii?Q?JKSugwW90PCdPmLufhn8rv6g8xeLF/KdPDKAKX5tBp4XVL7BZSENtrPpIJV0?=
 =?us-ascii?Q?2zPLRtVvj2oiUeifP0XmNRdxHU8h/XQYhUmKi5tK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30214c28-0ae6-43b2-15be-08db14d44f14
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:57:09.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaU42E7bGTumRqyB/MpNaUoCWSgngUZJiRRmTMedmP/npvjv4Ab9rPrUWu+vsLSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 22, 2023 at 10:38:25PM +1100, Alistair Popple wrote:
> When a driver unpins a page we scan the pinners list and assign
> ownership to the next driver pinning the page by updating memcg_data and
> removing the vm_account from the list.

I don't see how this works with just the data structure you outlined??
Every unique page needs its own list_head in the vm_account, it is
doable just incredibly costly.

Jason
