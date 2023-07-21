Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCF75D7AC
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGUWrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGUWrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 18:47:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E13A84;
        Fri, 21 Jul 2023 15:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxMAEGgfNEZ0nW7e1BQXE743jUeBr2lslnuolYaAFzOI++GamC6VNK69aWHE3eC+Mr5IxcrVIMuC8+xQkiBitVGq6dIHxo83DctFiRwpY3LOP3MNvSVZGhnKoXFg7YznZt+sI94+0jAhVTtSLPvDlpr56lel5AH8FpPgkbc5zELd2od/MlQnMgC80z3GFFbU0gF+RKGpnRQ4dNHe3wruZgeDbI0NoTDZP4PhmrIg3KTHXoAOKvCo5PcwEfeQs7OpytZcf2FIn2s/YwlLpxomcUVV7TGuWhQxSQOZ1xaUVeWWPICIKJjL53gqgscHXr4Bxklksf1JpC+JjrwptRLYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy3CkHHD08KXI1WtPjJHbxkoeubnMx5bYdUu1zKe7F8=;
 b=ihNnbZ7z8VZGpfEjpsa/XFXNFT0VvwwSRSY9uTvwYYtqdBDpZsNydWvlXXnG8mMTTewLeJxvOuLTjAHjyoLwI9F2lpX3IhPAGm6QUM4rptDXEst9UPT/kiXPiVnzCiTeAUhFzxdTEC2rmEii58UDN9NRaXykOjHRSKTjE558HizZ1+HC19vqFGZWmcRSpaZQh8tfCk8xiyFMmJjbT4dwZXLXxGyZjTDg5Pvj7SPnZZKRKf7nHkxTPwWMco7XDinGA4FpZ0vuKwqv+iQECV7orcPrI5nSlhAp4kdqyoJRp/iyPhdxd2iGyXnzHJHu/gzw7s9LyMuHykt/KLJ9bXKifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy3CkHHD08KXI1WtPjJHbxkoeubnMx5bYdUu1zKe7F8=;
 b=ZLLB0avLMM5yUjOxfrthheHk2x7t5dk4C2GbF/eWUaD8XpuDmk1az1hLDL9JTabhipngLwjnkvVHoIchdW6tOl31Y+UzjmaRgwcZMPOvhGpKHLA07sdk3aU/1dK4+O49JWdoIyUEWWWdyq25WNDPLYrG/yzJHoFWsRUN5uHNlNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 22:47:42 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 22:47:42 +0000
Message-ID: <93557f79-c12c-3c3f-2c25-9ba50a618daa@amd.com>
Date:   Fri, 21 Jul 2023 17:32:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Content-Language: en-US
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd <amd@localhost.localdomain>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230717141852.153965-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590e5c2-160c-40de-3bb4-08db8a3c7e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDABnaRbaHRyjwKol08MUWbQi2BpdTHy4XMkjAIJe8aKj08hCVqBwtL2GGTLkDzSTAsjtDDZDifvq6oe4/dl1fI+P/XixW9rBF3ORFL+CcokyClCv+ZXUq7/9MlRluEXStLKvqKURm5Lq9fm0ksY7gC/bLgayiyqzDOjs8EoqLtmEDsUjC+/nQee57A+yPbfQJC2gZ/gFtwxN4hbmg+hecPjIZ2rUEG30OQRntIjVs+WIkAWAT3fnvGtNCzhzfk0dLMV3M14sO6ILTvyijOr/MqSPu102aVw8wQ0sSPpc5J2Zl5uM/XnTSm8QRJLkMW6h7ilxyARkUiDUv4XxhK9yBsRQwIzOUfBiEP3eObuc3QSLuuYCRc9i2tL+El5uDfY5AQuvZkAWmJotsIVdspSTv0MWdXPQgUF1J77Q+9H4NxRWcAaMdT7cKkIEvVGCVYAPn2V56vWj6+uV2uoIWAepraoNjevmEupVbizvLrTJK1c1LHouqs7SBFJH0Xg9M6b3uFgVbJbNzzGhbkIxlQKMtOBWhyOcFWvvjM+UajUe3GrMPsOYItVxWpJ8tMHDAXajt+wkZ/oL11oIEslwT/I8aALrIDAy6faDq/T6UVtv+wb4XiIS2aRtZouBVe9z1DDgpCZ9imDRROUfkQmbitC5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(31686004)(6512007)(6666004)(4326008)(66946007)(66556008)(66476007)(36756003)(6486002)(2906002)(31696002)(316002)(478600001)(86362001)(83380400001)(2616005)(186003)(38100700002)(6506007)(53546011)(5660300002)(8676002)(8936002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TSthRGdjdUFuREw4cXFIZVljbFJFL29Eb1ZRZkt4Nmx3YmJEZjlKWlYrNExj?=
 =?utf-8?B?dFgvTDlyeUVpSk5TNU44QzNiNE43Qm9kL29STk92bDVKZ2t6aSttNU9ndjY4?=
 =?utf-8?B?YzhHNkF3YUR2R3dFSXpUOEtjVG9tRitBZjNiTStxZ1ppcm9oekFSSjluMlg2?=
 =?utf-8?B?WnlrcEdTVE9IMWpLQUVxTC9XbmZ0L3R5ZFo2cmdQSG9SU3hjc3hrZU1QSll0?=
 =?utf-8?B?dldVUC9EQUJEUGVWcisyY0F4bEFHYm1EMi8yL2l6bkNiVmN2a1I0bGpJalpz?=
 =?utf-8?B?YktqOGpVblp6NmQ5L0RibUh0TmdwY0JSZnVaU21XUHZWWEYyekM1S0U1ZXNR?=
 =?utf-8?B?UWd5QjE5c0tqWXlvSFNmOTdERWR3SU1sSEdUakVGYWdsUDc5dnl4N2pucDRD?=
 =?utf-8?B?bTNHckF0S21hL0IvYkV2K3BLOEFwcjA5NDErQWFkeHd3ZWVHV2pMS25DRnFY?=
 =?utf-8?B?MDkvcCtuY3ZRZlJWTmpsZk50Y1BFT1FUMmwrU0pPS1JwM0g5cU1Ia08vSDlG?=
 =?utf-8?B?dHpjQnRkL3EvdGRzdTB3Uno1UjFqZEprUWhpZDJXU2tNTTd2aWMvYmt4bG40?=
 =?utf-8?B?UUNzWTV3Ni92ZlVGbHdQbWdGWm9OcExuSkVlU3VEMUxvZGxCTlJFdWJReEI4?=
 =?utf-8?B?U1Y2bURxRlpQS1ppbmpmaUtmdDlubDBCYjdIWWFKZG5wVTNSRG4zcWR0RHNO?=
 =?utf-8?B?ayt0UU9iOWNWS1VJTm14bUxUSnF0UWxELzNuS2E1TXEwd1lqQ3pIOVJPbTRR?=
 =?utf-8?B?L0s1bDFtR2FjS0tJQy9SVmdFUnFBU0xmcU1jRGNzWFF0UjI1TCtyekxQYVBa?=
 =?utf-8?B?OWhJeHdyQmEwT2FXbENZT0lybHZzWlM1NHJQdEcyZmhvRUNpcUpZVU9tbisv?=
 =?utf-8?B?cXp3V0xvYkRNcmtVYW9McUxEZmMwRFdXQ0ZXQXZaMzdjYUtIN1Z1QXU0MVF2?=
 =?utf-8?B?OUhzd3Fqb1JvYkdoZm0yUnJCcFdPWnNZUnFDVGl4eVBxeGVFK2I1MDhFNkF6?=
 =?utf-8?B?YmJsN0Z3TUYwaWQzV3VWUFRGdlFtdzRIMDgxZncyUW1oY1k5aHdmTmtCVG5D?=
 =?utf-8?B?SmV3blBmdzVwYzBhRldxKzlsS2NOMGx5aWdES0prVjlQNEJoSllyc3Zxa2hK?=
 =?utf-8?B?Q3NYMHdGNDZPTk10SGdLTVhnSkxRLzlSQVNFUTFmNzhhaGFNVGhZdzQ0Nzl6?=
 =?utf-8?B?T0RUWkVZUnFzOEgwSVJ2SysrVTBSdlFMd0VFRkF3MFNDT0JTdDEvVkRkNko1?=
 =?utf-8?B?RVFoTUtFRXVaM2QrNTZiOU9JN2I4ZTQvNnhuUjh6SlYwMzg3RFV6UWhNUVJ3?=
 =?utf-8?B?TnY0eGNwT25YZnpJLzYyVE5pMGR4M1lyT0t4MWFnV0VnUDFOTkJURkV3TDd2?=
 =?utf-8?B?cFlHT2tVNy9QelFDOTFYQ2JVVXR0L1FHZHRDRk42TFpqRlRoaVJzcmNRNkV3?=
 =?utf-8?B?MnN5NEdMeGRkSlNkMjNKS1RHdk1qQ0pZQmpFTmg5YnVId08vTFgvcXlVaHB5?=
 =?utf-8?B?TkRsWWduNFJiOTFidkpwekNIZklUYkNtdDgwbHpxRk04Rm9VVHJHWWlXdFlC?=
 =?utf-8?B?eURaQUlvYnk2ZGVkUDk1azh5blh5RGVvU0ZtMFNNcG1ZemJRZ0oycnpsbFJE?=
 =?utf-8?B?V1ZyWVNsVnZXR21rUTh6KzYxK3BPcm9rWlVHQkpXZlU1S0ZvSFNORFhjM1Ru?=
 =?utf-8?B?bnphRzl4amVveGsreXE2cFRhZXNnKyt6N3NiSEpEYmNnbGRlVnBNZGs5NnFp?=
 =?utf-8?B?K0ZzTVNZUmNXMGp3RGxrMmQrNzRjRkI1dDB0aHBybWJmeDExTmJ2VGJiVWZD?=
 =?utf-8?B?ejJuR3pXb3hmbTF1Qi9GNUhvaWNDbVhTME9KTGVacW5Ocit1TWJub3N1NDlQ?=
 =?utf-8?B?aDZuU1R1V1lQR0ZVT2FpWFVlUzVORU55MFRCQUxGMnFGYXVGdlpUbmUxcVp3?=
 =?utf-8?B?T2dpdFJNMVhibTRrUnBYUlFSUVVDVFNicUdRU2hETmVFQ2JrMmdHbEhNTVVM?=
 =?utf-8?B?dUx0UWZGOGloRXBSKzF2ZHZjQTBIeFA1WkV3RGVnWlFqUTd5ZGNiUW1BVlZq?=
 =?utf-8?B?NnV3K29wZ1FwR3RsSklIU3k0ajluWGFrRXVtTndTZTd0eGg2SXdjSXRHek5o?=
 =?utf-8?B?WldHZDFsNE4rdFE1aWFxYUd6alVlKzZZc2VlcTRjNU4xQUtqbnZQTlpyWUtW?=
 =?utf-8?Q?/RCAhXMdB2k+DwmnhDUdU89FXhsKQ/sNEx/h+qtpGT1k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590e5c2-160c-40de-3bb4-08db8a3c7e5b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 22:47:42.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5//ltjc+PGNumFauxqPAuaJCGPQ1HB1e6WO+J91PixcpfNqwh7N+3JqeqDXrCVY3K1oPgrZ2uLAM9jd/w0Xj/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/17/23 9:18 AM, Carlos Bilbao wrote:
> From: amd <amd@localhost.localdomain>
> 
> Fix two type mismatch errors encountered while compiling blk-iocost.c with
> GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> result of the division operation to (unsigned int) to match the expected
> format specifier %u in two seq_printf invocations.
> 
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
This should have been:

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

> ---
>  block/blk-iocost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 495396425bad..4721009a3f03 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3032,7 +3032,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>  	struct ioc_gq *iocg = pd_to_iocg(pd);
>  
>  	if (dname && iocg->cfg_weight)
> -		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
> +		seq_printf(sf, "%s %u\n", dname, (unsigned int)(iocg->cfg_weight / (unsigned int)WEIGHT_ONE));
>  	return 0;
>  }
>  
> @@ -3042,7 +3042,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
>  	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
>  	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
>  
> -	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
> +	seq_printf(sf, "default %u\n", (unsigned int) (iocc->dfl_weight / (unsigned int)WEIGHT_ONE));
>  	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
>  			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
>  	return 0;

Thanks,
Carlos
