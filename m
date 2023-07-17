Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488CC756643
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGQOXv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGQOXu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 10:23:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D13C0;
        Mon, 17 Jul 2023 07:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7ch/AWY5wikp1uq6SVs0mLWBPA34+9GxoS7zJW4Sn2YwPG1BUtfPXjUMalF1AGnlbcDJaAqELkBk+Whj6s5IS5YVlH0jLn/tQa3YkZWZwq2MDUqjebHY3ytNrZkemXfRrPXnZBgw5420/0ZFndCTrOAYZKR3ABPk35dvI6hanh5nBDqPsLPZ5yepqGtn0UOxWfE1PX+Q91iYortz2tFensVgPbMfESRplVJOUkXSQId6layVX0ZyiPbbj0j+SK64TUI+bxCz2mqwgONBJwR8emNgHJxaMQ93iU2BBFo6uJdfYqx2x6qKEJrDuyIXHCShRXVrg3OWS877JzAQOJHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnGRLR2tZ1S3L61lfI649dIH7f8G6DiNExIwXPMtkZQ=;
 b=iplSc8wFBY4um+fxmRC9jTyIJ+1eOpEFbMMUYMaKNjhwHaeA9X/hjzg0I4u0a4EgXrTHl1JGxHz13WMYQJvm5GfJ4p9M4klWHnsKhjfSrD3/ep+TsrNJyR1kZQzDxTrfGcudM1ECE0TSIarmjbpPkivJ9e0kX689w/BVoaidNkn+2KhyPOcAW29TOU4cISioZBLSgOQWbgjVkd0z+zLMUH7tbkxRsalbKBWs+ABLqZx3FEe6QXbG3MM9eXN3C209Z6MAWxU43IOvtJLivQaM/JZEEmrewVqXVqHWIRAnx+doM41l2j4o/jb1LW4Thn383nP1HmhqfT8/N95Fh4skfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnGRLR2tZ1S3L61lfI649dIH7f8G6DiNExIwXPMtkZQ=;
 b=Flc5v0YuYM1VO2xf5loZMVuF131YcapTU/k1Ao+PiYjWAZz3lvOfaTyTMV9zmC7oPU/tVZHd6lwLTzX+iwG8fI8Jp3huiSqb4Z21J9WapoRYi2h5hUxg7j4HvGrgn6DuIP/buhgvhag0im8o+yd0E+EGuoT7BtSZamSlhzO88G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 17 Jul
 2023 14:23:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:23:46 +0000
Message-ID: <7b79f7b5-3313-3465-be4b-47648b93e63e@amd.com>
Date:   Mon, 17 Jul 2023 09:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Content-Language: en-US
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230717141852.153965-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0100.namprd12.prod.outlook.com
 (2603:10b6:802:21::35) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8b3c72-4e86-4112-a156-08db86d16e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF+0gxpgNzbjp75AGyq0rps0YNAQ50NqMdKSyLQNuUwx9h5RVEwOeE7YQnfkS8d6XhAOrweLKKD4pzxwavV7lHkWueH1fO50NaSYxRThtSv5YzYlDUxg72jpLxcki/YE3XVcnf/dHb6UPjwD/lqEkm/pDSU3hSUoA6P0kSRJ7ND9OwSU7WHQXtfDKhEehYHEdM4IblkTIClWpOeUGvvnorGV2hprieLykhjDv6K+y/Av1TvHyBqXU67AFFfL+Wjk/9ntYzVPZBrK3fPrqhYvZ3rPA0Nnh+60jJTc6twwUu8e1dyoCqyXNpYckPFf09cAXEbsdje60UYRatIUUgiJRpFEvbNG1F3oJLfEhJ7q+q01TRRvAbibEVRa9duUbihKSoSv6XfK0TAfQSAPAY86Y6y1nA/UhjIexrgPck+iQi7G/V12skIVeNF9HN8wscJjulwZW/RL5+ldbkwXYGDCh41kuRrSq1asjvsgG0ExciQKSSAIkuBBhIEYUHJd7+wdIhCjlihvFBeLx6lFcQTZXSCiAj0hl4e5W6WpHp8xTMzUzlrLunbk9C+mzafBrqQDx97dnhaH7QP/1fSMPLNlHC5156Z3KwdZklXCR774RWQGa0A1l702jcPrTV6mZWv1rlPIHqhL0NfctjnfjY38lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(186003)(26005)(6512007)(316002)(41300700001)(6486002)(83380400001)(6506007)(66476007)(2616005)(8936002)(4326008)(5660300002)(2906002)(44832011)(8676002)(66556008)(53546011)(66946007)(478600001)(31696002)(36756003)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJtOWEwVk9JOVA0MW1PWXg0S3ArMG5jMDNpREMzZWZiRWpQSWRsZTNzSXNk?=
 =?utf-8?B?MmU5Y29zV1BxRnVPTTRZVVVvZVRUSlhnYWZiSlVTZEd3TitEWWdFUXFvc0FI?=
 =?utf-8?B?S3NMZ08wT2dYcUJwS2EzTHVNMGJrdFBBdzhNcDI5YWlaNVY5Rjc3eHkvRmJY?=
 =?utf-8?B?UnVmY3A2S3h4aU03UjUvNnNVNFZRb1ZFUktiN2xjT3ZjeDc5NnU3NFIwYWlv?=
 =?utf-8?B?K2xxaW9ibFZvY2lybmFxamZ0WU5xT05BY3RxcjNjbmdPbXNTQ0hLV2VnV2xU?=
 =?utf-8?B?VjhGdVBCa09JV0FzekFHOUUwM1VYVG5jT21SdjYxV3NxU2RvWFhWZmk0MmRw?=
 =?utf-8?B?RzBGeS8yNmtqU2pxVTUwQWFsUVZxaGx1MS9wSVh5M282NDhwM1E3b1p2dVVr?=
 =?utf-8?B?UmZZeHlJK3pSazNTTnpSVzZRbjBINkYwUXBlNGtxenZlYVZSdGljZ1Fld3Vl?=
 =?utf-8?B?ellMRCtyb0ZHazRTc1BwZnFmYlNHamZlYUJMQ1FybVpVWXBaTU9ySEhETUpZ?=
 =?utf-8?B?eEIzM2NnN1lucVVwNnhjU1pDMTZJcHlIaWhoL0xpUjRFSXRoVkdMc1dLUVFQ?=
 =?utf-8?B?ampUb01DM1FYUUxwd3B4K0cyZ09uS0RBbGlQeWVaMUUxTmtsbzMvSkFyQjJa?=
 =?utf-8?B?VkUxVXBNeG5ZNk0vUUk0REFsQ2xZbFc0MEwwNVppdlowK1ZhemU5K3BZaURx?=
 =?utf-8?B?d1RmM2hPRnB4UWtielg3TC9tTmlTUHpYRzJBZ2R1OFF0WnJkalZnS3VlYVMw?=
 =?utf-8?B?Lzh6VnRGOTZPNnMvV3pDSDR0R0dlV2RoSjB6NUhRaUhzOUptRjNtR205Ully?=
 =?utf-8?B?QVFPelM5NVBEbitBeUxHdk4zNVluZzVxS1kyOHFUbFRrQmRxb0EraWxGNTk3?=
 =?utf-8?B?YTl3OUQ4OGV0VHhCYXIwLzJFVlFYUzNUaTNxUXNBU2ZEcmhRdlRIQnBiWTJm?=
 =?utf-8?B?NWREOXhIMDlHK0p2K0h3UzhTelZpZm9QYXRZcnM0RzhFdVJOKytTbkRZMXl1?=
 =?utf-8?B?MjMxTVpuWjZ3aVFoVVNJQ1ovL0txYkRac3BJNUYvbjk3aHhLTzBkb2ZSMmdm?=
 =?utf-8?B?cXFCM3RJOUxveXNIWWFKSkdvUW1Rayt6bFpuMURJSk9MNDJUcXNqdHVkOEM5?=
 =?utf-8?B?SVlsZ2ZyT05wS3lEblR6OXFkbGVjYlJHT0wwV0RmdEtPQnNZM08zQ3hMNy9T?=
 =?utf-8?B?dWJsU0ppRGJtcmppbXA1dzhpWnRjNlFiRHh0NUg4UlcyMDVDdDRNN0hqVVg5?=
 =?utf-8?B?ZmhuNWhBYjRCdE1QdTE3SmtMMzVXTTgxR1RnakpUK0RraWJveDJSZ1RocUZi?=
 =?utf-8?B?bFBRS3FJMzJXM1FJM0FiZVBzL0Z3YzVpV1lBclV2cjZvYnJZdjB4VnRTSVdw?=
 =?utf-8?B?QVd1enUva290bVFlZUZ3YllBaXh0WWxSRFljZmc1L0VrdGFrR1B3ako1aU5E?=
 =?utf-8?B?RVQzcFpPZjJaeGxsK0tsTEdTVURzQ1kwNFUwMnpYOEVDNDBtZURWOXFYM2gr?=
 =?utf-8?B?NllucHlaZFFuK0hTUENmcXh3bVN5MVpUNlVvQk1nUHdHcjUzM2prUWpIOElE?=
 =?utf-8?B?cS84dnUzTlphL2hEdkNVZ2t4NXFtOS95d3JTQjh6Rmg5ZlJSZFVDMlpkYTQ1?=
 =?utf-8?B?amhkY0FJQ1prWGdPcEJUS2VGVDdXc2JOZUc4RndiNENIMGgzWkpqV291YWl3?=
 =?utf-8?B?Tmw5VXFWUEFlbEhRemR1ZnY0ZFRxbjY2ckFsRVl6TUN1TDBjb1IzVWozenV4?=
 =?utf-8?B?M2s0NkRXU1d5aHR4SXYrRWpScFBnRjZPSnAzWGNYOFR1ZXBYeFY3N3ptTnpl?=
 =?utf-8?B?cmtJTHAzRDcwZjBiNnlqVk5lN2lkMG9UQTUxTjZZV1V1Ly9PSkZNOUExK2dX?=
 =?utf-8?B?WmNqV1VkQkxkenVQcDY5T1REeld5L0tvMUhtWHNUd2R5Yk9WbEtYWThOd1NN?=
 =?utf-8?B?SGF4c096WTVVZ2lBdGhqbk82RllGd1dKNHJjaGlYUGtyYlV0OFhZdzNwc1dr?=
 =?utf-8?B?a0xYSjBQUUpuK1NrVW9YVUpOazNyT1gvQlRpQ28xR21CU3RsTHllcFAyUXM3?=
 =?utf-8?B?dUR1NCt1V1RRR2YyTG81WUhBV3VKQ2RvUFFXdlhyZ3JRZG5MeE1UcExscGRB?=
 =?utf-8?Q?XP9OvH3otH+7oUbqfJE5uNaer?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b3c72-4e86-4112-a156-08db86d16e75
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:23:46.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVilDr3EJx0EWSHG0MQ28ofur2NO6HN/3RffIYPqo0roy8lzA11sOL2ScYBs4kvrWPKVvR+dBepq/GZKchXf5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/17/23 09:18, Carlos Bilbao wrote:
> From: amd <amd@localhost.localdomain>

Please disregard this "From" label.

> 
> Fix two type mismatch errors encountered while compiling blk-iocost.c with
> GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> result of the division operation to (unsigned int) to match the expected
> format specifier %u in two seq_printf invocations.
> 
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   block/blk-iocost.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 495396425bad..4721009a3f03 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3032,7 +3032,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>   	struct ioc_gq *iocg = pd_to_iocg(pd);
>   
>   	if (dname && iocg->cfg_weight)
> -		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
> +		seq_printf(sf, "%s %u\n", dname, (unsigned int)(iocg->cfg_weight / (unsigned int)WEIGHT_ONE));
>   	return 0;
>   }
>   
> @@ -3042,7 +3042,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
>   	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
>   	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
>   
> -	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
> +	seq_printf(sf, "default %u\n", (unsigned int) (iocc->dfl_weight / (unsigned int)WEIGHT_ONE));
>   	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
>   			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
>   	return 0;

Thanks,
Carlos
