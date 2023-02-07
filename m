Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B12A68D655
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBGMUF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 07:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBGMUE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 07:20:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070334025;
        Tue,  7 Feb 2023 04:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQYLCBkr3h7sr6oFL7F00rTYjcBgdGa7gV++Masx1o3oVdRgSyfhMiovpww5datK9wxah4+9dETlGrDmhjJlSeRii5gfLhrVHv2hLLqwWgPtb91eVlg8kCPUG81n3WKSrixouipYh9p+angSaNnUZ56V3dB7iAV5iU4wnD9b7cpPqHKGErzgZKqBQ0l2gAFETrdbJbGWxTTxfX852+cezcoLpMaTK+WToOjm1AeSRIl3OKJs5/PsJhgZyZW8DTf+ynNX9F+h1ll6UJ54ZdmTu9btqk48gdgTzZRqWYCSD9jKCugXemEYRrGtYkpQ3UK5VseNOdt/WpZBTFuh32SOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka1JLWFpn998EV2qdaWGP74rkt709l/jFMLXnA2McRI=;
 b=ZuZLsoZU2zZuB1ZGw/rau8hwtHaapmiT8VqbHDU5j4Y+k6Sg98tRgRLKf7Y8rNxSJTNytx7fEhavGZcVATMOdzgjMtyU51eFU0TQslg7Nv8I3lcyca+mWIaQ82PIFZLDp5TPlguJ8pfFpS3k1k0mUCOHzKRZyrPKvGem/Uz06tgabvRRl7W0QV5NPXBdlifImOARFvL4a4l01rVxXmWI4eH/o/dqzpeM2S/AwKrbHifuH5ZCLWx1QeB5ObV4guYegLXQtpkWHCu/GmZeA6jkTRlNUlk1mDiOybpyzGgOcaPBlrxSabDoWwjMwQRXFjvsWK0KJWMn/31vFjse5Mi2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka1JLWFpn998EV2qdaWGP74rkt709l/jFMLXnA2McRI=;
 b=m5OE0QsOAJMuO7sF515kJQhbdVYWm7PbQ1qoPDMRjU+hu8SwYLfcKuvpnj8PnK6DW92p/iV5DwOGd7UDk5WpOpHzLHOnPNcEGURdho9/zdgL93qewYm3BT7ktpSrkfvOx8pqgFqByMapwxsnhf9XEkVxZ4cicYRkWNgJUwnOn40LjQlXvwf/ysRd09mQszOrL3lfPBDKCBbtjAYaeZdEoi95TPyu27VCuB/1rK2KpHWjACa+BP6N8AOajaRa6TXIvADSH2C6auwDsxSrX20MEkNkZwJ/FMw6PuFKHWp+awPf5CQlpOuRLpw3iTPhQKv28Lsdfcw4o46f9AmxoKZ+Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 12:19:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Tue, 7 Feb 2023
 12:19:58 +0000
Date:   Tue, 7 Feb 2023 08:19:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+JB7VQX+Ypof4j6@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f37ae5d-e578-4edb-205b-08db0905a0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBDH/XfDWuUq+NesiZSJgyuPE0EHBM0fqtR5OR+8u1yfr3kpUKW5cs4lBzSAS/9EC7QpxwZH549XMLaXWDNK7gvzbihZIzqqLJDNotmZRu8XfJGmzLcJ4hBxg7j3PBGsHJpAjHqV28fKDSELPo4waGUeYryBg770j0bu+XeXzMD7ISn49+x3Q20+fanSlIH5C+IeMlHtBlc1Td+/MSgq9rWXE27WFkEdhp1oDvWRH11uYBRBgVswvVD6dvZbd6TjjqAj0npNNP/tSH5eySnvIEtvB1ljErIFvEOnbnchi+Hg5NLvXWLcHN00BiFKgs0Dt2GJpSa2/BuTAgVDxwould5YrwTdp7ApacWnaAhZ2fvaY6pCzjn/0qndMxVJY3S6vSGHvtiHn3g1EH04F7u5YNRY8nUYUhGcbf5tYtjwxDkwWdePW++XFCz1GxLx9V3/tq0WsmSK0ypTQsPhbRzVkToIXrhEgX89poc2TwIc9fP+nF6KxT7bBLrNwL9bZp3tDfY7lJAW/MVIl9m36+FkJa0Y4ENKYVYkXH4QNBIvx0yWNIh22msNghYGtWx012HLc+RdbZ8Eyb7tW1rWtmYr9FiJr5srQC2O7p4FakVntlphYETZZMVYTli75AXqDcVmEDBvrtik9/heIg1+t2Lw0QGoF1ROrMTsOkMw7BG3k6oVcjXYhPbVU/6bKWYcr5lQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199018)(36756003)(6486002)(478600001)(86362001)(316002)(54906003)(5660300002)(7416002)(2906002)(8676002)(41300700001)(66556008)(66476007)(4326008)(6916009)(66946007)(8936002)(26005)(38100700002)(6506007)(2616005)(186003)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7jjaMuA9DcsLEBDIfAXe3RC1lyz+rkh8jyDusQ/Ivk5siPu5l9NPdu21CDkC?=
 =?us-ascii?Q?iPiuzCzU+weBCxAt8Ta5fXrlC2xAE0ieMCgvOHzhHJJP729ezZJLUPt8hOkA?=
 =?us-ascii?Q?SUCV6/z/B7BuD4fW050zaiy2/UhcEsaHikE9I7gkykM/62zJAn4c1cikttO9?=
 =?us-ascii?Q?Dw7X7tUb3++z4Zsaq0hZHiIdwyvM7+gIQoXWqPTaIt+p3NPUOAkZesqGQjPj?=
 =?us-ascii?Q?iaAP3+N3Z4Uvyy8p1s75YmAJMuA82uuS3oST/iaHw3itMBwTP7Ftmd+YQMdw?=
 =?us-ascii?Q?Lga9SBYoWzU0URVs0VJsp2H2itoagr4e/8jo46DXavbn9IpNf8fPlN2mXrHV?=
 =?us-ascii?Q?O0WwNKHVciMQSI4cmIwr1rWDvfaaUBkt+fv7MTEWPaiiuQaW8t6xb4RSecPn?=
 =?us-ascii?Q?myxB9YNB0hHe3cIGzVpKnhgRI+3WFQ3EfHIfUV9uQBDK5Rkg6iSxBfcLp7zW?=
 =?us-ascii?Q?DPt/t8GFeHHY78/+E9MBj5+eW2BrHdifu+pjI/kFij0X/H1Kc9xQtsRtpJtz?=
 =?us-ascii?Q?hBPCIpBavmiAbe1tV4j6+E52OiRlaRuPE7N6aUHy0ENEQIcBHIgSHoTt8aKr?=
 =?us-ascii?Q?y1XJWJXrVePaECRTpu4Cgux9PfTn/GaUOU6W8JtbPdIP/dmmSjgo6nk14jHf?=
 =?us-ascii?Q?DeALzquymRf4aKLFhRIVtCXj78nr5joXwtJGDVVIyuv4ag+nS6kYTN46Ap38?=
 =?us-ascii?Q?NaBjXU9ljmvxtkvQchl1LNGkhWflTOqflHXnQyl0Qs3h216sf1FS9UVoAeYs?=
 =?us-ascii?Q?GLq1aQYa5AZBC2VS04B1myDrJ+2detosXcALOPnjz5pg4PqaU4QDTWcJo6+0?=
 =?us-ascii?Q?2m7JeV42Yp/TxvWnNHFbDg/H3sbsVXFy0dzUPptiaE2Gao76zxC+54HlnH9b?=
 =?us-ascii?Q?/C66QINzUCKDZpVBLmqwywji20FZeJ3WyJGST2It7Hv4XWJx6/Gxqzap1HxG?=
 =?us-ascii?Q?Xnapw4qhsmkbVPGudcgrqUk7NDKgUlzLuQBbI7Sjc/qUkgekqxY5LboZ0kSY?=
 =?us-ascii?Q?CxaMgRuPq2IuDkQoNA0POsCzSyRChhtnlW3fh1ZSyQ5j9qmdnH9gZY8r8SA2?=
 =?us-ascii?Q?jdBr3dAETIwaIfyx65gCNPRzDbHeBEq9rd2c//tkr4CCNAUutd+ZpdPISJOc?=
 =?us-ascii?Q?vrvuSd+Xz4+qu4l3yob9KX95O4ww2NMW9BbijisLXJSAPsvnR0mjzd6hvUIX?=
 =?us-ascii?Q?VYeHcoW5YCJsgod3RxyNMxcaxKqz/YXGTzeAkNRJsi2il+DhSu/F0NfIm2vW?=
 =?us-ascii?Q?Y5lvX0Ekih6Rkp1n6wZVHkplnjEj9La+cBmqfQybi4npLUhjso+x3AvzhOaH?=
 =?us-ascii?Q?dAnqghA3ePAIhLoOEUc0niBtldo99L07i12ewbdRB/cUioL4SPBQhzTbm2eM?=
 =?us-ascii?Q?oDbMPtyh/Bvbpr1dnACBMbgCbTSOOQ+GF/2/p3/4/+jrwo/VJOvjB+bSq50g?=
 =?us-ascii?Q?Exf343PTBAklFR9adBLpNL2yItFlIaqiUMU7OXLCHi7CrhHuCIOQkryvwBKg?=
 =?us-ascii?Q?fX+R5LWs7WM5M9M8xNjF9o9Txf2qlbMyC8EqzlKJKZBS5OEeUo0T6WCLlCnv?=
 =?us-ascii?Q?PLB0R4Yp2RG8cu9axwZ4rU4cigHFecUWVrlxdSyc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f37ae5d-e578-4edb-205b-08db0905a0f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:19:58.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LBky+F8FtsxirGaThj2HjswjpOwL/6/TJ2PsEPMh4sJ0PGkNfnEKb5Bzygx+h7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 02:32:37PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 06, 2023 at 07:40:55PM -0400, Jason Gunthorpe wrote:
> > (a) kind of destroys the point of this as a sandboxing tool
> > 
> > It is not so harmful to use memory that someone else has been charged
> > with allocating.
> > 
> > But it is harmful to pin memory if someone else is charged for the
> > pin. It means it is unpredictable how much memory a sandbox can
> > actually lock down.
> > 
> > Plus we have the double accounting problem, if 1000 processes in
> > different cgroups open the tmpfs and all pin the memory then cgroup A
> > will be charged 1000x for the memory and hit its limit, possibly
> > creating a DOS from less priv to more priv
> 
> Let's hear what memcg people think about it. I'm not a fan of disassociating
> the ownership and locker of the same page but it is true that actively
> increasing locked consumption on a remote cgroup is awkward too.

The main purpose of all this is to support libvirt, so they need to
support (a) too.

(b) is what we have now and most closely emulates the way the RLIMIT
works.

Jason
