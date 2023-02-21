Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE669E839
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 20:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBUT0p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 14:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBUT0n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 14:26:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866E302B3;
        Tue, 21 Feb 2023 11:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBZPn5OjTfGO8eKjVUOdemhc0tCg5k6EREvyruDv0gL2mI4E1Mrgz4Q8zY3WL3iKMAHKUWH5xJYontvJpzYJomaH6/Sr3Pagcqn+qNyCLBnm6SXZGBEVdZKSIIXWMHmvKjl461v+WQNNkYlzsJHGFEWjVLnJfdqm6Bz5pUjskPvxSpeSoeQRltgaDbD+c3FaIpn6byKK4u+N+i2dT9Zlkx1qR/Caq8+5jObAJYgMal6zedqJElD0jlxGaQkIkVzIVxqfYgN/jc2LUSPcy88ju3YKDxJLY8lkbviqzUXOKqzgkwwFu68lgKh3Pv+WhNky9q9LrMHBRTt+A3WR4e1lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJoetxTueRdwFyG7muRq2iwGc/+2jwQdIe1eeQ2yk2w=;
 b=Hvt6t6K0Cl/vQ8/hlQEIJy14i2p8EoFVgsc0Q4OewX0n3RbDk2RwyXQg4TAB6wuNApAzUSV2sgSZkFTDZBEjm+93/iXNi9MxwxC+4K0hA49L5yWKFqFqkoovpE3aDvI2+oCTd6viKOGlefUhfiziq697xUNPSQ9tyDehhnhXduHWaSxWB6g6tRgo1q4/7c6tCot4AKzG/uGpMrtuT4HKkQr96dpErzaaoJjMI63CqcPWlj3A1kzSVQs1a8iMNL/zogaDWBu7j7LEjbHvBRQN4QO6zwzoZ5SlrLqK3dMxSRsP4Cgt48ZBc1UTVC8dPgYfjnU+XNXxUw+1MAzc2oOsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJoetxTueRdwFyG7muRq2iwGc/+2jwQdIe1eeQ2yk2w=;
 b=pCO+Q6umjo/+QS+sxMVcUAonGFKpTnHbjq5/jueZF1XWNYdx/k4T62YUpNARyMyjZy5KAQyGHlIsYpnZHAMD4sJZ8m9fwzu3OLUexUcsN4ua3zRAzzHdiCG/UXjfSz+r5Sb8pYt057W2S1uH63WknLc2yjE+drxFV1x9ZyT/qPlzIZb90Cbw8cYEFInLYGLzbady1RgW+woipbPzCracqGCaNJUElag8o2u2rF+XqljScpdXbQ7lvDkyLBJ0ifJiGm9v9xdnpWGZUejmREFEdGXcOpekVlQGeCwAiLby/coavhLN1tCfFoSL3CxLtrtoSQ0Qb35l+a/Q5ojDr/CvmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 19:26:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 19:26:39 +0000
Date:   Tue, 21 Feb 2023 15:26:33 -0400
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
Message-ID: <Y/Ua6VcNe/DFh7X4@nvidia.com>
References: <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UIURDjR9pv+gzx@slm.duckdns.org>
X-ClientProxiedBy: BL1PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 30550aa4-da80-4f47-bc16-08db14418e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLLr87YI+SBC1hzkcZdat6+s0q0VTyiEOC5BT8OjQiJuNKC8OS2Y0A9Gaki0cuTfk2J0SlANU3vvmT10tJSo3vEm1sFD/eAtXjv90JUHkVG8jifeCUeIhUsK0HeTep54K7JoedjlvkEWxPuBoA/N2C1t/9oFx9bOmcEh2JvB043PRdeRjhXeyDzmWpjdKelI8kUquOv/Bc7salXG2tEbtcRgFlCnlEs9QNbiW20z1Xzb+YZwWVPaQ1hC9gw11piaMb0mHB7rAFIrI93g7uOAIp0V3txbM7vFLuq9TmOyPu5Of9wq/2P4OEDev0LyH82Wv6vj9Y5scrhLHjBx/xS7AtXch4mA4ypVS+an38bKIJoMK7MyVKKnLfgda1uGZObiw+zKq2RqD3Ls1uO9HrWVG/Oc92a+7s1HeBej1XxjOecPVsgd39MPzwVyNzawLY+Gw2njbmRsoGH7Rne1tErRrSq8x1pf8hh8RTltKwR5OpZbJlQVzuQWCXYhnh5ruQOqg2FLFXsVqi2QNePxuP/BPSWo1uxNtKz3Ahf+bzrYSrFw3VttU2iQ5WbTLVT8AFgbb/lJ6b18nHMshEPlvymA3xEDzgB0QtvXJAirHxD3djub4dz2sK/8rrv3VWh/e0cO1q3I1H03OEtEFzUA9+F7hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(8936002)(7416002)(5660300002)(83380400001)(41300700001)(2906002)(38100700002)(54906003)(6666004)(2616005)(66476007)(66556008)(66946007)(8676002)(6916009)(4326008)(6486002)(478600001)(186003)(86362001)(6512007)(36756003)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V1wM8VrubHxKqHUQYvjXFfvTUnnmpjgBy35HRhaVru0yNqT1g8j6IH0ghOl/?=
 =?us-ascii?Q?oM937/JnMPdBYCnSBeRRpXO8Hsq4rXhy7Z0D2J4rtlFe9ynNdwztLb3wGRnw?=
 =?us-ascii?Q?Ad+GBlT8k35RQhAmNKLVzkjILeQG1nx3dY4f1zLGivfWUibPYOq4/gBRDXue?=
 =?us-ascii?Q?iXnY3TdMwwqZhQkMW2Myre+btpOo0yKQ7JEgZtmz7HUU9bKTtjohJ8weNzxg?=
 =?us-ascii?Q?FhoVdVmxtNoH4dDKCuropBZrGbyYiXOnLx40RNKO1t8RpuvEz27Ee4mBSz5+?=
 =?us-ascii?Q?hyjoNuLqAb1Xeh0JAiffKEG+R1f5HZa1szLGVSZb1xzJT3X6qkkzW8DWvj9i?=
 =?us-ascii?Q?xejdgqAIcFOhdb0LPr4VnuoG2xiduTJvvhbw2WIIec/wUqMApC0DeuTaTe1N?=
 =?us-ascii?Q?NDyWe9s07Sp3O4XMG2etoAv0h/s8eYDngBhIqQT9CYAM29JhmVLzjszfFvEX?=
 =?us-ascii?Q?KURLzBYY8MfFt6CTIFmADRj+vZ4dPbWdxKIRNpDSTnU5zQWNht2Dt8yDeqe7?=
 =?us-ascii?Q?Z2If+8qVlv9Mn93tgSzrnkyCOaD1NsJWzLD73j7d5TItom5PY0qcjcOgR3qU?=
 =?us-ascii?Q?cw4PZ/22jJNOIMFKucu2rBXOrZ8NKBP2qNarLtIvWFDfNnXkLh8ZUzc9hdMP?=
 =?us-ascii?Q?OaQ2Aw+SiUYOlE1tq1T2Y31B9iWP1mH1gbo2z6PDFkvZYEu0tscgbzkM2qAf?=
 =?us-ascii?Q?bAXZIY5IETiqJoxHpO3b6/Gvi/5yD0l+uD5V+kPj/2Cd6vuH8OV2ee1LLFE7?=
 =?us-ascii?Q?mgo77fBpFkiUxdKTQfOnYBZ+w9PZNnuEgJP5XsHdFqB1VkDIQrd18pJRAypN?=
 =?us-ascii?Q?eLUTQ3LnKfqFLeGG9GVqnFXy+2uuI/lOpPRiiexA7jkOgSb8COTbdMRsi5/y?=
 =?us-ascii?Q?HZku1P6LKcui9FMTx6ApMWa0uZhpCzgMALoBK+8SAZddMsbbKlMTB7NFIcQZ?=
 =?us-ascii?Q?0LiVtZm+Fv3Y6/+rb5kwshRu8fW6r9mHu74P8GiNEPUpjZYpmVE/QRb9C3xx?=
 =?us-ascii?Q?AaBsuF2jnJLtGD538RlPJMApZnBXqb9b6ITXsDDIOoMHjJkWup0C33bUfSdL?=
 =?us-ascii?Q?2NQuewddcegnv4vfF7MyZdWwXzZA88KWhlQC6zSXM05zdbePqODfIIiG0Mvf?=
 =?us-ascii?Q?woALinUsmNVhpbP5b0oxOEMT/zDsKgJiu1vgEEVu9vaRUs2W1UQz/R7WQySx?=
 =?us-ascii?Q?GooIt9lUg7FOPUNskpFpJHF0fNfSsSa14DmwUBIq/irlWEHsiFJLS3eTHxFP?=
 =?us-ascii?Q?IZzy+3kqkFkMK4ZfD6F2mjvo48/d2Yn7kyrSw99n1KP9zhRrBLndtMVW82GM?=
 =?us-ascii?Q?AvfDdxFWFkAArNF1r2e/IStq+Y9MsoeoYiqg3ZPG2J9sb1natCH/4hCxVA85?=
 =?us-ascii?Q?nG5S9APS5zEv+uF0YySWa9HwLhulSdzWE3pbtysfXsILboS0WiuEzw1H1ELG?=
 =?us-ascii?Q?jqgEI9kvNKh2omri6N9dpuXQTZFC9bgIRpWp0ptDnI3Y1Vo3VUEBGiFRxTIv?=
 =?us-ascii?Q?70Y8Jgz5D0zgry9+iOqSaRmVBHMhjDYGMSkjYoZ75DJuhVB2INKS6F+OcrED?=
 =?us-ascii?Q?xUVrerEzD9smz4uhMOSxSdh7dXk2fcI5+4Z718lE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30550aa4-da80-4f47-bc16-08db14418e3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 19:26:39.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH3uxQ3UR/Gi1fj071+f/4LMBRbGcmGKqji0EB3mhXvfJLj7FxcZc52OU51qbluT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 08:07:13AM -1000, Tejun Heo wrote:
> > AFAIK there are few real use cases to establish a pin on MAP_SHARED
> > mappings outside your cgroup. However, it is possible, the APIs allow
> > it, and for security sandbox purposes we can't allow a process inside
> > a cgroup to triger a charge on a different cgroup. That breaks the
> > sandbox goal.
> 
> It seems broken anyway. Please consider the following scenario:

Yes, this is broken like this already today - memcg doesn't work
entirely perfectly for MAP_SHARED scenarios, IMHO.

> > > for whatever reason is determining the pinning ownership or should the page
> > > ownership be attributed the same way too? If they indeed need to differ,
> > > that probably would need pretty strong justifications.
> > 
> > It is inherent to how pin_user_pages() works. It is an API that
> > establishs pins on existing pages. There is nothing about it that says
> > who the page's memcg owner is.
> > 
> > I don't think we can do anything about this without breaking things.
> 
> That's a discrepancy in an internal interface and we don't wanna codify
> something like that into userspace interface. Semantially, it seems like if
> pin_user_pages() wanna charge pinning to the cgroup associated with an fd
> (or whatever), it should also claim the ownership of the pages
> themselves.

Multiple cgroup can pin the same page, so it is not as simple as just
transfering ownership, we need multi-ownership and to really fix the
memcg limitations with MAP_SHARED without an API impact.

You are right that pinning is really just a special case of
allocation, but there is a reason the memcg was left with weak support
for MAP_SHARED and changing that may be more than just hard but an
infeasible trade off..

At least I don't have a good idea how to even approach building a
reasonable datstructure that can track the number of
charges per-cgroup per page. :\

Jason
