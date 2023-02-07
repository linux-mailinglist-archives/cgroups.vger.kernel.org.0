Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A768CC58
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 02:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBGBxY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 20:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBGBxX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 20:53:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FF1B326;
        Mon,  6 Feb 2023 17:53:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi3sWo+0/xV26+WtQ9LGRAUy6rJassWZOY2S3qX1UJoIp1k/dZ8Z0hF4un66BOf0Yv24zAsHuRpEM/XhbUFU1pa6orCHOdCWfl5lyJpT/ljgIL3K55aporFJArYZVT4qjDDQOKyLtG+6X0xkTxjCypffTEyczNsIRyQ3iSM2/cLV2WEpRYWENKI4dsR57eAf45vicUhNWfdZm6P++BTEwnNDloTdOi7XQcysF8GIwvW4dkmaVdRVCHbd9kv0AUhD0Suv5T1YWQQG7B01Bftzf5FZ1Vype8elGGhUzz1+qM8pQm5F+iADW8y1kTaR6RL/H7qjwp4cqDn72y0gFQlhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gACIV1J6Aakw4ZT8mMl+C83X57q5sM9bE/vQSWr9rN8=;
 b=PHHv7eSfbdqVjvkrvF/noI06zjekwIi9IxIDQepQv2iBiNwopuPhcqP4cLKBlBIygpdY7wvxzdcCuXohnHvNnb3K0Z7ysYNrTX7cm7G+OWR1fDvFEvKwxFyqncOrxxLyhmHv9227QmdnU4Pn3JLU8wY0WdxUCKU7JtBx369mb6+qHUMUr3oCehz88qOtKHE/+ZhC9JFcQ9cdJKMDYZ5jXYngU+SbGgdR4RBOk3lGAXxHpcGkMzNK0+IxFt8oWhCxsuMX1XbWafMWb++4vIHIy4yMErgklGPWReb3dGyLBpjxxt40mnDXCnlWKJBXfqr/HyukbkZGwI4Xcf1m3PZBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gACIV1J6Aakw4ZT8mMl+C83X57q5sM9bE/vQSWr9rN8=;
 b=G05K9hYCVW+QPPlvLzVjLnGVv2s8nJOYfjESSkZ0yoz9EL/wAlg60MyZqY3QXW1MkZUNikI7PXH5+6gcujwPktN/NUa3PWti+iGui6JEXUxOWZbzqLcB4PdV1yYdbv0RvsoyyNKeR8EUPgyFFroJvWSJA4CqyiXEa7MY18GD2Q/vLuedowfESRJYkCtqNNhLaK0Yo5qa9HFOHkZvETaxBIVWdsGgCf88YLlLeyYXnkznVdfZfCkXz2xVP/WRPq1lSGWtWFdAbf+l3r9NPqlml8gxAF2TsOpfD0zObonF0hPH03LM5C3CLLGxN+fNaSwZbNrnphnRd9btzraHQAod4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 01:53:17 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 01:53:17 +0000
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <24668a43-fb00-5240-6072-230c5f5d0943@redhat.com>
 <Y+GjSTu9vE/A/EKG@mtj.duckdns.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Tue, 07 Feb 2023 12:50:24 +1100
In-reply-to: <Y+GjSTu9vE/A/EKG@mtj.duckdns.org>
Message-ID: <87fsbinsvq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: e20d426d-7e29-4bc0-a1b0-08db08ae14fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gHXwqDMpb0jB/PM8SOeVG2ELWn/M/9n5oKBeYSHD6aXXaBEQrPUC8in1n+QfaBWekuKsuGAxp8/vnujcazMKm4Wha2Z4gd9Be2txWIUdnTL7vTHjVq54P3lOoxYYQ5F7545xSgJ3b3JbaWRHyoIwGiMAdtqzf0qCUx4XMbgrxNMLSZrSK+lfA35Qx5zdMz8V/s1Blmy8u3F1UmbGznNrXDy2cJEL4B0hd+CclX+mI1hG/q3Bqpoluxh6GHiMhwyyDY0n+CX1qI8BKAQSVike1fm/GzTT6qvbLgpGwGX3w+zaBgc79cGCfTATzSdWWsAXF8+NgZKr69IbokqvjFe8fRaXMaWCUuICtjYzob81G3RjhnSWPGIfG7y6/JLX/EDKT6p7hwe3dTBpiVnesj5itNPDzz32egYd9NI2OAiIkYTsNwBZz2U4ZpTInHQ6AiGVSr0RHDAEM1n7WaaFdM9W7hnEShlOFN4se9cY7tlZTESFu3keFNCRFOQE4FnuvQEF+PoY5buL+rPt3LkCYtbwO7u6sBOt8vqdM/AhbHzUFTvIaSQqEPI5q0uZAynrugELyWIMgwFr6thqqw2a9i5smhw7gdnGAaMI+MIo2REV9OuY/dKTsqsFZ+quLBAiu+akvSWTLyQ7oNvcIjxm+Y9gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(36756003)(54906003)(8676002)(316002)(6506007)(4744005)(7416002)(478600001)(6666004)(66556008)(8936002)(66476007)(2906002)(66946007)(41300700001)(4326008)(6916009)(5660300002)(86362001)(26005)(186003)(38100700002)(83380400001)(6486002)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dh8gwN8D7lg20P4Maq6vZzi9rqJ9CGf2e5n8NrChleereHDfQSH7OEDjxdxG?=
 =?us-ascii?Q?+2W9V0QR9+Kd+lZGeG0DYgieKBA3w2BgBQ9N0nJT73aaMi3dabTwj/Gu7hur?=
 =?us-ascii?Q?mOC0F7AO5ikMmjkxpuhDWfA05mpUv+Z7T9ccAcUnmZSym9/CBoevkkg9MZtO?=
 =?us-ascii?Q?aXIggnmeq9YSXELFFzvcO5vGjBak1rhJstTcq+w4UyofBg/9OKSyln6f/RBh?=
 =?us-ascii?Q?6b7xshOaTkYflUW7lNngJD+CkK9J9jErYZxc9FJdegodRGw8CiRYUKkOX5fo?=
 =?us-ascii?Q?nY554ePE3cRaP5bcDba09goIsPUMXWW0QlYjIS/wgNb8NeAvOigA6UrKhwF5?=
 =?us-ascii?Q?F3fMJAaeJfUuYfRRukPX5JO1Ge1+2nwDvDzJI5ch3F3BjcrzrPCup5Gf+wW/?=
 =?us-ascii?Q?vEZnaSA+PXkAfIHyZ4UPGEUZf3Lrow2OiWsTjjxiWvfZL/MYF25bMC+k3B9y?=
 =?us-ascii?Q?tbRVKohA7rxVBQR6SZxIjsS7Y9VYVZt0LsQ9czjRiJik5YvpOYNZtCQta1Mv?=
 =?us-ascii?Q?n3cvnDILWRs3MbVWdXS9n4A8DPxyaFoEkr43Gb4Had6kXpSefxtxaE9fSSlo?=
 =?us-ascii?Q?6Kmai34Mm/PRu2arWTK/75tELBRMAOAFsIXliym60GRg1zT3PhvXAJemr6yq?=
 =?us-ascii?Q?yBI1BzY+5bGYXqhqlMcZ3taohjU3glJdkE2WfHPjA8Q0jbAi3umBMtTPBLA0?=
 =?us-ascii?Q?m92FjALbNA7X/jsd0eTY/b74CLGgjsvIhTr/8Vq5KnOMnwr3sKjdPO/t5a9j?=
 =?us-ascii?Q?5/dltZUAtdYHJbxeqIh/2mty3JER2cHBjzKaJm4bHNOx8AOvT/2yYNC888WH?=
 =?us-ascii?Q?WHwwTUri5Y+a10WUsjSsLadGrNlJQlGiNTqKmh3/BNm6BB3QmS24vTL3Qm4J?=
 =?us-ascii?Q?fadIoDKnShDYQhX/ler1zdqHwT91HkxWYnQnSH84SMD21GOc9MAHOhPpSgaJ?=
 =?us-ascii?Q?TixqejPPWunF0nIn0kwLKC4VP8rx8TOJnMI707PP/t4UvOHTTsVr+5XQZrq5?=
 =?us-ascii?Q?Bv3tikuc28FD1apxNj05XFsJzFhKrF3hJvweF5iDpzvAQi6KGmSIRE6aKzdg?=
 =?us-ascii?Q?JJ9f8hEYfG4qNZlgOecsD87jYT/t4G/09AItTRiVeex7eaaFYtEu9lofDx25?=
 =?us-ascii?Q?SZ4EG/wEM0n07v38s0kA2VaGmJTpuId7NFrQe8wAxd+HjqeD0GOiouj+7rkt?=
 =?us-ascii?Q?A48rbSBMnrUNYrTZrhEx0YR7e3UU9akvq7pS85fOWn6xiyWt4yU+HivUgWZJ?=
 =?us-ascii?Q?6miQL9r7Elr6Jfh6jIpUUa/XBrPR6blUvkSRT3LWuroH4NHdgKEBN0h/dKcm?=
 =?us-ascii?Q?rgrWAFYu/n/PFjdx43NMooVEJsTK4Pqym3H9KEEwx5duS5mfioPFHDnhdIUe?=
 =?us-ascii?Q?8CVnqMBXLurVWZDH3qWkYJCUNZ75/C6LPoAgqLcqS5Q0rn6wyKaXaf64Cwvs?=
 =?us-ascii?Q?8KycuIe51l4jLEEaKTuI8Pkhx/hNtKc0Tjmc55NKV1vn6qUMAgSPhR+wIA/9?=
 =?us-ascii?Q?qUctKWksh0QUtleu0kSp3DuAXiVVOGfMONLG9KrJrAsZWW8TFE4ngHdGAj8h?=
 =?us-ascii?Q?c8RUSCEqO/vsAfOHUcPhvfmMJHwEqjXh/fdAyz5x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20d426d-7e29-4bc0-a1b0-08db08ae14fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 01:53:17.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExMz1TtYeX/p+OtJ99JhnHlr5F72ypIZ/Nz2c9And8+7ve5AFUhgsN7kEmZQnbV+elAkazZMQPA3nuVLZDL2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Tejun Heo <tj@kernel.org> writes:

> On Mon, Feb 06, 2023 at 08:00:54PM -0500, Waiman Long wrote:
>> If it should not be part of the memcg, does it make sense to make it a
>> resource in the existing misc controller? I believe we don't want a
>> proliferation of new cgroup controllers.
>
> Yeah, if it's gonna be an independent knob, I suppose so, but I really think
> the locked accounting should be tied to the page, which mostly likely would
> mean that it'd be tied to the page ownership too making its natural place
> memcg.

Yes, I think it might be possible. I looked briefly at doing it when
initially developing the series but I would like to resolve the question
of independent knob vs. memcg before heading too far down either path.

> Thanks.

