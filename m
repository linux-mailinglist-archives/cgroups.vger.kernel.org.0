Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262406A0EAF
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 18:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBWR2V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 12:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBWR2U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 12:28:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8822D52DF8;
        Thu, 23 Feb 2023 09:28:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBauQl56IGvTonZ250MW77qyln6ZcOk7ghIh3MxgfZJrRDRdAVRx+Qt8SUSTP+oF6lKpFs/MZz4LTM3Zi/j2qDPU0uTkHBDflUXhfmKcBqTpO2mfJu50JmjwOiBvoCTnBiXs1ZDLAazJ7iVlj1ujl53qarxCy1IheqRlJu3XTR+RDARfgfSpAbjbfQrTBO315omzgQcaD9S/7/GysRhjRZjcVWzCHUZCyX8r3Qx68wMcB+ggXWpRCnGWQW18el87IbVZ/i/NtqU1ALL/pXzmBbLpcwBMgOd9qrZNza76JthWYOnzJUgSgWIAMAe5fLjNjAdxkV0fj7gyo3nHSfyuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKAwc/LgahAvTgYhXdUvHgORsVMsXkpCftdguy998aI=;
 b=E1povPAPd0ZXkXskz4rLiGjXE5l7gKeN0Acew/4HCMeTaSfRYouANrKM4/dBN0DcrH2Dzyv3eubyaz9b7xAVyDiH9th/vxRt61AXaUcH5XmjuxrO4Atk8LGVYUjaheoZfT+8gu40XxkXP0xdIYKy2wZq5t1QMT1Xbg2ZLTYImhU1Br5nZ6frUTViznnArm5q99yatoqszebHnb0FfMp+304kQDwmFgyE+a3qQ466hTCiamsqRGwYfTXl/9KryZW+nYrtYpgxsd3BN+pnMWkhZjpoiw1eH8ihydfhmWACDQI8+aClzNO4TRzU0I54Cg+e6YLuI6vQ6UN4PmXRDjLQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKAwc/LgahAvTgYhXdUvHgORsVMsXkpCftdguy998aI=;
 b=ppKcvQhMyE+wTM8JZCjY9g/3iU21+KFmkyth0kNxOctyRwQoqg6epC3+FYpbG9cRH0MHYlesqB6oyMyvzyu45FQ3bZkjSgbMJaVYthTId+Xolp7s1ff3UJtpWvrQGHrgfa9CcoeBpOrwVADqxD8m1KWXecaum4T8b/UsFwmIMgEcfAHRyhIBzw9bDw+qg97CCjDYolBcm3Jzxtz8Jc20aG3DONNR65ZvAR5+D4BAfwXGfLHbumXRght1LTX/IvurZhdEB0/92kUTUC+n+LgZ34kmpEZuRxWyYigTrTw/2675DKm7uHvmFrUKC62aAl/1SENLCNhMxtEYA8WLQue5uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 17:28:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 17:28:13 +0000
Date:   Thu, 23 Feb 2023 13:28:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/eiLBo88pgr2IUm@nvidia.com>
References: <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff558a8-cc31-47f8-136a-08db15c3572c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Az0dYJVPJq3Jtm+F2AnXoLkDSqmICQTeuY0+dOawKPMTcj8SO1MSHkLHOqb9LTyFSD40/DIGa5gQDBVlLxyL8uJpxG8BpJ2L4Of3Q9Frwnv2scYaX9sFLAj+4Wn85QIEg3G5vJOCKxbucGvuLaFXz+aQJaXaZ9vGCy3vW4G1cJab9SBD6k2JNHjGqk8v2ExijFAw9RK4mtcHhk/E4+0MKEAv3tQjlJ0rc5NdZTXTQrutnQ9m2hllyZamYGBJvlQpd5u7SRZBYkqeoun9neYuQolzF6fmu9g0xw/2V+SuDxtPT9UVq0zY8eADh38IDlVnn78PL9Q46CTV7aSVex3bw/35Nf62iPPbXz8QJkZkFUGSqy1qGUEOQTfLMz1RnbJOsbPLyvqnCoRhANt4riqCF+FGKc0UWpp3iLvo0zsKaBwDGA3Ypls5vEx64JTF48/58slvNoyJ3rEcZxfl15MbKtT8qLnCyhThwSy9BTLQvwm9vzHKHWhh1AJUGPjeRTY85Ndp+3PNHaXe90zMGq9Bqf4mZ6Inw1M36tJLplugerpnegLUAA9P9ZdKzPbnu5/calVTfjQPQapIYLM1aFGtzdI9NNrxvBcr+j5G6wo87ELAz8J78zubwR4Gb17hB8wd1f3jW4DzCSCPGzjMBO0nDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199018)(26005)(6512007)(316002)(186003)(41300700001)(8936002)(7416002)(2616005)(5660300002)(6486002)(66946007)(478600001)(66476007)(6506007)(54906003)(4326008)(66556008)(8676002)(6916009)(86362001)(38100700002)(36756003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XX7XTAnRB8btRUXa8swq4gC22zXcvVkutgnxLp6sAClIHAIwp9cTXwLEsVOX?=
 =?us-ascii?Q?LlfccTGSs8aa+nBVGZpO30TjUL9j7XYCaIMkviuxfalCN/sq6/yuK5WpMTVx?=
 =?us-ascii?Q?GcHRk13PTUKorlUKpM9ixdwc0eCD/cUqQagY3gaN0RIT2KcMJGByfDIvF4op?=
 =?us-ascii?Q?9vPO643VX0yYidfcJkeJVQoOmHqWFqB5lvRJrazTyodGWJwAaaerhxtuhFwc?=
 =?us-ascii?Q?DF0bR3I7w7UyxdwSFLVmj5DIzFNwfzP7fpKelh/w4Yt5Nh/1xqhe9UNjD/uH?=
 =?us-ascii?Q?IE0Gm3V5+KCRyg6M4McWcn8rc2ASg6vXFVhKWyk1vok6F915tkolw/R1H+Vq?=
 =?us-ascii?Q?BCi63Yh1yV9U0lvTvld2rENimQFI4AJmyulGPsFjVnjwaX4CuIBSKh4Z4VGC?=
 =?us-ascii?Q?GANkjkd0xJ3AR1m8zQMiJr72eGPQU2ln7pmMXzWkKCVkGXVcq30hX72p46OA?=
 =?us-ascii?Q?WS9y9ubnwajGZJ9OpSiuuta1t/wFX6311OgSthyTFweVxoiXbDhPxDpMgFBC?=
 =?us-ascii?Q?edVuGCqBnFBuNJML3OcuM+Vlq6AvxRsi+1+qnoSsqDbxBQR1qAoh/F8Tgf0Z?=
 =?us-ascii?Q?ZIqtRh9fFD3ATVSja1rXUGhVn58kXLV22c7LMoSjAj8OLTk3oM0An8bKvW3F?=
 =?us-ascii?Q?ZXcHsymO/1coYpAjE7QxpZiJ1QvUfk5BiENKAFhJItaC8m3wNfBOT2YU+leU?=
 =?us-ascii?Q?//lgj96F5StGngkPeDdGC8Pi74Z+975EM5wrWzbKUyY+Q8F7aLVBdhTB0yiU?=
 =?us-ascii?Q?xFiEtA5UOIv5JgDsiMNJb24hrKX2vDaJeXoLYJxYeUQtsu99AN/PFyFOUbCw?=
 =?us-ascii?Q?+5RuLCLkT6lWrlBcX3My9PC0bax5kKgIGV7PtAWK6LmWHoMWTrvT/BGUScW6?=
 =?us-ascii?Q?Vd0zMUPSBQfnOb8ZeNOMnUnsz+I/m2cLbog3hevud+oe5UqIWgL4L8OgvCBd?=
 =?us-ascii?Q?YpdyuUjZxhhyeA2MmLmWN6l0XoQR3HrLcVN6CBTbhFhadYUwH2rjGfFk/eJj?=
 =?us-ascii?Q?PWfh7udg7NDBt7pqbrJJs9ydzSHiqNTJOWuaHE1ttZBKcD0/G788oTV4FIBT?=
 =?us-ascii?Q?OaC+EHZ+4stNymqsSleyirvaOLoukqWNWBuamc0GLIlatjLVHbGuzstCZnjN?=
 =?us-ascii?Q?lBOAqbTsHaP9awYXbF6ruKQUmJLus7YHskXCywAJdVyUJcqAnLi3Kc5VTBB1?=
 =?us-ascii?Q?IHHr31g4538aLdf+nL0VbQ5DQN/XwZ1XNRRm5HOYRB95xxhjcwCXZOZWtNYd?=
 =?us-ascii?Q?DTepplqFRrGqp74rbIoqgIw0vafdJK8eLxofEldxlZU32JAsF5XEV02EvkAQ?=
 =?us-ascii?Q?L6QVt3ykPQfBwItS2rhcX3E9932I3JwAE86vgHpvsfY+mg8UjzLLM9SHOhqs?=
 =?us-ascii?Q?BGn3fsmRSHEhJk9+1jxH8l9bJmY7gIZjBuZ66uiSlXQPTYSGvKkAQyv+5bm3?=
 =?us-ascii?Q?nBxHIK/2wOA3dcYd15bg8l4Bl0aJWSXp1UA1RDvA5aM3n+cVh1uK9V4MMAWr?=
 =?us-ascii?Q?tpyMNZOEvU8dvimd+s3lxoLKpLfmV/agVGNkp+xBjYMtHezNQmb+EUAHQmQo?=
 =?us-ascii?Q?BfSprdcqER27eG+nW3Vvgy025Vmyk/cYJsy4wZJj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff558a8-cc31-47f8-136a-08db15c3572c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:28:13.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/jsrIhFTKkzsK+Gihfjn8UpfxRDCvhmJHQxppw8HV7yXHmIk6t50KTCS6r0GQxM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 09:18:23AM -0800, T.J. Mercier wrote:

> > Solving that problem means figuring out when every cgroup stops using
> > the memory - pinning or not. That seems to be very costly.
> >
> This is the current behavior of accounting for memfds, and I suspect
> any kind of shared memory.
> 
> If cgroup A creates a memfd, maps and faults in pages, shares the
> memfd with cgroup B and then A unmaps and closes the memfd, then
> cgroup A is still charged for the pages it faulted in.

As we discussed, as long as the memory is swappable then eventually
memory pressure on cgroup A will evict the memfd pages and then cgroup
B will swap it in and be charged for it.
 
> FWIW this is also the behavior I was trying to use to attribute
> dma-buffers to their original allocators. Whoever touches it first
> gets charged as long as the memory is alive somewhere.
>
> Can't we do the same thing for pins?

If pins are tracked independently from memcg then definately not,
a process in cgroup A should never be able to make a charge on cgroup
B as a matter of security.

If pins are part of the memcg then we can't always turn the pin
request in to a NOP - the current cgroup always has to be charged for
the memory. Otherwise what is the point from a security perspective?

Jason
