Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E574E7CE
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGKHVH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGKHVF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 03:21:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDAFBE;
        Tue, 11 Jul 2023 00:21:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJCDvv018412;
        Tue, 11 Jul 2023 07:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ebLVeOUlpytLFAmzJ5EjQmskib1IpMrPVPaYwst7VIg=;
 b=xCgkVOpu6rMN/02MbTltLES360G2ZbnGLXv7rCutZiAwRRmLGQVinuvZdKoc6M3WdHh3
 s793kQtFbO/CM5eF/02Yd7zWCkAlO4bzZBy+AQ9dK+VcK+CmaSsb/2EZGkHjEtUBHyXS
 lbKh7M7kUOd9oaflMx5On0oklJO/lGoQPqOdM0U9yBuwZV3ZcM7eCRGSIKFFzWSFt6NY
 pmOfGV1/hkL628DpAyFitowzGM/SF0ZaW2GiJdW2F2NjxfrnOdVQvMnd0NUrpudJXDZh
 Tc+XbdDEFUbvltB2k3JF4CF0f0BpeNPJqnzI0rZCjnsDQ0cXHbxf6yd3ZOMUS5eKZTlF pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtv57m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 07:20:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36B62lrP022918;
        Tue, 11 Jul 2023 07:20:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx84fgy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 07:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaX9IIGXW4k0Wm70TKPZ5rSZ4p80pxoPaq9qUxlqxF+qLLuR1NWBnKXCA+Skfu9WQ6xD/p3h3tXdyjmMSnhHcbUEUqr+NG2OdKDpRms59lhzkmxoAt8pbdTm0B0nZWJNvupjTcgmd/e6KA+srJ5YQzFtD6gYwCdkTW4RXPhS4BJV0lc4ByvAra7/+3hF5tPNk1f9mWxTbmU3nMRqhiAtGhdPQuZyMEmbRFnRvymNpBDl466NRKGpyL7SniBNYJhpSeYkvHGyPmkAQD9ZUKcXej5S9d7d5zCFAP1d+/ETf4ZxquZmDGPSk8M+mM0ajjOXUHtkZWTxJjBYrbBA7E3HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebLVeOUlpytLFAmzJ5EjQmskib1IpMrPVPaYwst7VIg=;
 b=AmfoODHWqPV+2ZRKsmUHvcvCSim5Qvn/4DRe8npL91INV9TSCi5M11zv/YCo9hqhR9MqrpfC31xKyqAugpcFXb/5qhQkoIM1NDoWt8rzD0Shm1W2LyMkqjeT9FvcdiaFWpeMWnUjiUI7s3zvf5iD4eTUCltBcjZnmswhEFhpT6Mdd08C4A4t+EKntr1TrZvsPYqywcy1/Uw5HUlLBVNnoKjdVsz83U3SDYtu1aygVgMyF4dyZoe4maGqfcFP59btpiDX4qvzUOJnm+PV2X+mN6w9igizJaNWjbjHnKO2Zvn2Skkoi2t+lXt8tpsNY4PJPs3p/HLos07tygj3f/crOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebLVeOUlpytLFAmzJ5EjQmskib1IpMrPVPaYwst7VIg=;
 b=g62R17IMMVaoCGVN1cdF6ck8gm50qb7Sj9dlNChq6/R0s3QQjoRau0WhiR4RSS/dmYhvbDfAPiutdGX8Qqpx9lXnuHHcNtsmX1ObURR+Z63YcUQw6m6KbAGFsZ51VfcZlLk3v25HBSz5VIIvzJfCz5ARzHlBAFZp/AtgFDITWZo=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 07:20:27 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::4637:ca64:1a63:584a]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::4637:ca64:1a63:584a%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:20:26 +0000
Message-ID: <eafa31d1-9ead-75eb-a715-9012c233daa9@oracle.com>
Date:   Tue, 11 Jul 2023 12:50:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: put cgroup_tryget_css() inside
 CONFIG_CGROUP_SCHED
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, sfr@canb.auug.org.au, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <20230711023820.3854596-1-linmiaohe@huawei.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20230711023820.3854596-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 93218d7f-bf4d-41b8-337e-08db81df4c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amWoeHi6pW9cYVNRXjIpuYCEZ63hc745gw4SfE8YekdS2n/z47W/ZsOGh5x2IPvtbVGxVvX8TUG1Dx3OE5SKlFWp9nzsMEiREdEO3dyw8IwPF+oNmO78EnL2+EFECnjQQ62oth0Uzux2olq7KnlJ6mLvxDSIn7ikExrESeo1W8LOEqt0NsSraZF8ktu0RHgDLVFY167FqkZDP+F9HeYnFVtXVuIXFdwlis/YkJIevccTIaFjbMs31r1SObX5wVR6WeyvHT3xZGxNAZadadm2IZ4VNBSo9a4PJbCdJXun7/8Of51AhfIJQScGtp0NkgT83G3VlyO805mzXn2SNFHQcB5UUT2p18u3epudZ/UjxyUTbbn0Fj2MpPyFcHnsWFSXKpZArdvK/pfuD8f5KQMqAy7Kl5m73b4v4AMRxKEXmTq1dESO5TUH8o4JDgu6+7v/ZRfox+2Vp+q0R6u8cFwcBued9mudTW/XPDUZf0QKeFS+/AL8GqDm7CyT3N9SXwbA49kUDNb0VrORDmSsMhLohBm7JkurTfsxdVShP6dAQEhDdyvrrqYWg9irE77kXGG6OpM0EuqpjZ7NemgG+HMy/L6LdQY4NiYKqyDV89y0dHyfRnkwdon0mLR23izEleV/7ATjwsbhZtZWP/72a98zzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(31686004)(2906002)(4744005)(86362001)(31696002)(8676002)(8936002)(4326008)(36756003)(478600001)(6486002)(6512007)(6666004)(2616005)(186003)(6506007)(316002)(38100700002)(26005)(66946007)(41300700001)(66556008)(83380400001)(44832011)(66476007)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0pXbCtuM1NheHBBWGJQWjdpTU1mcTMyeUhvb0pPa2hmSnQ4UjlpRi9NRUNs?=
 =?utf-8?B?aEkrMDRsRmt5bzYyOStnSld1NzRhWW9xWkp6SnhqdndUYytnQlpYNzlJMDZN?=
 =?utf-8?B?WDFVSGV1U05ueFNTejZ0em9BR0F4MXR2MXB1bmFtQjNLUmJUdlJoZ1N4TlZt?=
 =?utf-8?B?U1hpSmovYzdrMk8yVlVHL0U2ckFXclpwbWJOR1N0T2tZL2FVRXlxWldnMUVS?=
 =?utf-8?B?UHNvRzk5V2RuNXpIeXM2em91UThwY3kvNDhrcU95L0MwdCtscFFlUVI2RnBJ?=
 =?utf-8?B?Z2lQNC93L3VtZmFkdkVUMzZxVXovTHd6UW54MkZYcE9FYmlINXJUbk9ZcEFo?=
 =?utf-8?B?cXhFc1g0Q09pa0dwU3VyWVNaSWU2OXViSDdxRnRtSm1wUkNGSnB5QjhLSDEr?=
 =?utf-8?B?TGtMb1BFM25jZmZIR2hNV1NpNjRwUG0xNDc1T2tkZUh0cWYrdElDRzJKdTNk?=
 =?utf-8?B?cTZGcHRKREgwaWxTUURyMW5ONnJPb2xqa1BrZEhFaXNtcUlHZDkrcVlMUUVU?=
 =?utf-8?B?WjlyVEd3U1Z2WmpiTnVERmtyeTBoWXl1dlRhRXZUN0xFdlhNekNIdjJ5UlUr?=
 =?utf-8?B?OE01K0gvSHB6bHE5VEliM003UjRrSkRvcDhvUWl5YlBxZk02cUVoYmxjdHRs?=
 =?utf-8?B?enBpcGdIdjdGRk8vUGRkL2tTZUdlb3ppUEEwc3VrM3VMcUlxa1Roc2w2dXVx?=
 =?utf-8?B?bGZnbEtXOUREK3UvMW1KR0swazFyVE1weUFON1dBWVljMFFEcGh4aTVaR0c1?=
 =?utf-8?B?bjA5OXR1dDdiYUMrQ2I0MmtGbUtBd3Jwc0VaeHpRazMveFZ6bEd6M01USnhZ?=
 =?utf-8?B?SHJvTkI5ZlVpNkhCVXc0UlRaTFlLbUFaR3ZVV3ZzOHJnVTBqWlk5TDNYVnpU?=
 =?utf-8?B?RTBkVTBTRlVLeWlrMnZXZzFTNm02R2lTMGh5Sk5waUpzRkVzQ2UvWjhsT3Fx?=
 =?utf-8?B?YVc0RFBKN1hiZ0VSSUhXQnhsc1RQeHBBSmJ0bWhmMFRWZXFVMEFlQ2tLUndM?=
 =?utf-8?B?VzhaZnF1Y1libkRGUWZpTHAxYWxnUCtDdklXTmZWM2VjQUFTQkNlaDBWOEk4?=
 =?utf-8?B?djlyN3VLL0pzTGV6cFN6KzlhczZ1RDVQYkJTSDU1ZHdhOGVUYllZZlBJQTM2?=
 =?utf-8?B?VkZLZXZlOHZDTUhoWWQvSXMxZDJIV3d4V0d0Z2orYTVvZzhzdThjYmpLVm0x?=
 =?utf-8?B?eTYvYlNRcWtaNXJkNUxXMGM3dlhRSlZhNEs4OTZWTjA2Z2owaXViaFRhTUJ6?=
 =?utf-8?B?OGhZUHgyNzBBVEplTVcrbjBQRGRkUkVWZWdKK3IzU2RkUFRwczJQeGs1dGxr?=
 =?utf-8?B?MDVUNXUrVVh5ZkZrNzJNcWdWdGtDa1lUSThUSW9EWUpnbmRuMHpYOFMrMWlW?=
 =?utf-8?B?NWoxSmdBME1Ta1RkVnE2Z0dVc2JwTFZIaHMwbGh3RTN2elBhelBSQ3pvcGp2?=
 =?utf-8?B?Z0FodUJWUWtwa2ZvSzVEWVdyMWZQaTJ6cmVXNmpmd1BTNWpVOW9MTWRCWEZk?=
 =?utf-8?B?MXJlL2hnNDNxSmRyUzFIbDNkTVcxOFBveGdIaktrazVoalJYemJ6c29oUE1E?=
 =?utf-8?B?ekRwV3F2aFpGeXBhb0dCcU5PejkzcFVNTzRFZ0JSOWF4bVVrUW05VCtBMUpt?=
 =?utf-8?B?YUtadUZmOHUvb3NlTG9nYS9yYnVLdWZPakc5N0lRTWgrdFJLL085eTJLSUE0?=
 =?utf-8?B?aW5BenNzMVRGVVJQRUZIQWNBSDNaOXFTV0NuY2hjK1QwVzBHZW9NRUR5SEUr?=
 =?utf-8?B?ZUhMMlQxODZWZkRQb1dWbEFkMTlBUUZJb2hxRXk2Rm9IMVBENlBySnlMRkVN?=
 =?utf-8?B?azExd2c3VUdkdkVZOENRMDlUVDBnYWRSUzRFTzZvQXQvdXU1NExNN20vQlVE?=
 =?utf-8?B?a1VwT3djVm1vNXg1Ti9oZnZwc2FjRHFyK09mQ0t1RlFqSkhVRDh2Znh4WEVq?=
 =?utf-8?B?YmFWWHlvc29zTGZoWEtWZ1ZLeXEvdFJiOGhFMkhtSFpNS09KVlRVRXd0c2FB?=
 =?utf-8?B?MEMvaEVHYXBXT1FGRVo3ZDBnWlRmWjNqaFNHZXJ2UUM3dXZzR2YrREpwOEFF?=
 =?utf-8?B?dlZaUEhXbzRVNVJlaG5EVFBJZ0J6dnZoRHJ4bGYwRmdRRnZvQzB0S0NOMmQw?=
 =?utf-8?B?QkZIalhqZWN2WE9iZ0J0OU4zL1c5aTl3QjEyWmwweW16L0dyV2xzZGpEUVcr?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VC84OFBPemtxL1U3Zm1oMlJvaG01UnhzSHRnemdlTGN4NFJValBOVytEcmNO?=
 =?utf-8?B?SEhpVDRla0QyQjY3ei8wWWdRN3d6c0lweE56K3R1NFNuRXA5VEpCRGpZbWkv?=
 =?utf-8?B?ZFNqUWY4SXVQRlVRLytnaWxDSXlSdDZHaUpzTllJK0hFRWRoaVYwYzh5VFV0?=
 =?utf-8?B?QmdiWHd3cFkzdTJNTm9tU2VnV1pBUGJxOUlUTEo0WG9kd1lsdEoxR1FZYjlI?=
 =?utf-8?B?QnBNR1ZnTTRoKzVRM211R1FNdHozRU9FUWtGVk53K2RhWFgvQmdNMENUTVla?=
 =?utf-8?B?SElyd2pBWVpGUnMyOTl4TmtaR0xQdzY5NWkyTHZlcFVlT21GSlJUdlVydFFQ?=
 =?utf-8?B?R0F4L0lxS3RucWlENHZTQyt1bXlzbklqWENYSlpUbms4ME92SDFJV1BMOUs0?=
 =?utf-8?B?VVY1NXB5NGlNbnhyTGRxZ2ZQVTB5KzRaMUx5MG9VdnhpVXVGTVJWcUdDWlBH?=
 =?utf-8?B?R2I0Y0VmaXl2MXhUR1h1bUVIcFZUVHoxNVJrOVRmbGxIVGtnVlN6RC80UG56?=
 =?utf-8?B?OW9Ob3NDQUxiQmhCVXNCS3pTMUVSOHd6ZzRRbGlvbWVHWU9veE92UUt3ZEJ5?=
 =?utf-8?B?b3JoNWl6bWtxUUxkbWYyN1hQZ0ZLUG1oMTc3VkVmK3Ftam1MMHVwcXZUOGtE?=
 =?utf-8?B?bUdld0I4L1BVTU1qeDZXbTBOT3I5K1JqbWxnZGtYU2UwRlkrT3RERkpYQnpx?=
 =?utf-8?B?L1FBK0t3WkhQZXZDWEtIRjVpU1c5MEJobXNpeFpJQ2dPcEkvVTFnWTVmQzd1?=
 =?utf-8?B?dnM4cTAxc2tDUER4VHg4M1lrbURNWVduQzl6T3JqUXpNd2dEN09pdFN0QWkw?=
 =?utf-8?B?azBLM0RvcngxTk9pVFJYSlI5a1RvUDR0MDZkRGxLaktPdWJQL0ZHVk1iY0l4?=
 =?utf-8?B?bGFEeFRWN0k2c2h0dXlYV215YUpZN1NRelF1QTlSUkVJZzZEWFg0emp1TjlY?=
 =?utf-8?B?bnplQlhnbHJENzEwZCtlOUkvY0lZeVZkaUZPU2phdG1NU2dUV25tZGJVclAy?=
 =?utf-8?B?OVFnbktUa0Y3VmYyV1ZHMm1LeGJFTXJJUXd3RFM5SnY4NXg4bTNMMWFvZjdP?=
 =?utf-8?B?MVVneEp1b1RDYlRzU0tEcTNZUFRBeVVmSjdHTmdFK3grRDVjRVlUeW51ZHFy?=
 =?utf-8?B?NkxhR0tqNDU0ZVlCcmFTUTFEVTB1ZmlyZ1dZZXVGb1ZTTGRSS0JNOTJzZ3BX?=
 =?utf-8?B?eFJwUlczTnltd0ZUR1RuK0hWdTR1N1VSRE5TOFRQUmhKKzZ3Mkg5dnM2WEty?=
 =?utf-8?Q?d9RaEi5XOgGqdkr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93218d7f-bf4d-41b8-337e-08db81df4c67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:20:26.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ycp0BGjxgMPWVPKSdW+qKCD03sGoviRZekXkmMpmVYNJzuvohvn91jjqhNWoympPRFZHeqb3ztRITZvw0zV7xMRUErTvskDrv2wp4EHO8Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110064
X-Proofpoint-GUID: 6CTx5ruR6T3sU6D4CqNcNvOCDVA193sU
X-Proofpoint-ORIG-GUID: 6CTx5ruR6T3sU6D4CqNcNvOCDVA193sU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 7/11/23 08:08, Miaohe Lin wrote:
> Put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED to fix the warning
> of 'cgroup_tryget_css' defined but not used [-Wunused-function] when
> CONFIG_CGROUP_SCHED is disabled.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 44 +++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Looks good to me, given that the only caller cgroup_extra_stat_show() is
guarded within CONFIG_CGROUP_SCHED (linux-next tree), it makes sense to,
also move cgroup_tryget_css() within the same ifdef block.

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
