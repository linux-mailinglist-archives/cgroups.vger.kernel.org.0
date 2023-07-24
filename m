Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059B75F8CB
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGXNrc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGXNrG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 09:47:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F6469E;
        Mon, 24 Jul 2023 06:44:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6oTOU011942;
        Mon, 24 Jul 2023 13:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/f4rAVigOcdaQGMxLbatsMRm6FWYKHMEfV7JzyxVa0w=;
 b=uyWi7UgT2/S4O3yOaQWzeEMStSqcUKqd3KnBZN0kyWj5TKzYsgNAZnLqsVgf3GJo9ATw
 kb8WhrbtLbqgmMSDK0/uPNi+1fBaH5l5sWnJpXOIPeSbVWd8BXHAyrkzkIbBYHJ/j0yw
 5vxRV5a2WMEVSvLYevqmOIOajsltnkFLCydYOtbph7+oSqFRByDV/QWrs4XSpfZZ5f38
 djMNLS8Ie04OMlsSreT5HzCMqCcbCRsNJq9fpSEhCBY2rzr8DSR4HTCtckhhFkaprHCj
 VZw41Exd+8jHbkYZvV5Z1jfRPYWDwWbaTCrlz4mm4icB/RvxrnELAuNHbkT5iThb8q/e Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070atq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:44:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OBuMqI028198;
        Mon, 24 Jul 2023 13:44:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9ptgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PttkSz1rDon1w5XQVEUrngFnf8KbsKkdUJWiWptRwZQ9XHnlhTF36x8KTkJxJbPMDzClNIFzsDmvSWOqtXc5Dkv1sqlW4TBMb4TDGZ5vdyc1WbtaMKmwXGmpgl2bTYcYXWmqCE/qmMz92QRZm07TaTVIVyhirl+D8becFI1yuSpU5SMlQP7fOg7dhj3ofKkHj9HH5ciA4l8UwhfTcm+tQlifbB3RHOcqDDw+sTBLYglQKBDXKLs9LkUJ74rngiT2pyaV824C/oRxuXkjhJ7+e3/yzPmNm0a/Fzfe8TUKZHlRG9HlbJyHgME+0K2Z30+ZLyyVLB1gyJdz3Kfu92GBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f4rAVigOcdaQGMxLbatsMRm6FWYKHMEfV7JzyxVa0w=;
 b=DBqt9s/cWayP40MxrEi2e+RJbuBuj8Aa7KNgqNfskjOT8xjo8nUdvxIDGDnau0q04eRT0WbUG3AHQZPLnM4i8ACHjhS6AFIbyI4ckF7RgOOK+rP69jTmUmTi3ieqjDRg9EylWBX2GumTCMz7cCqK2SDRDXo6uwtnoY9vLviIYqW2MJXWB+dDKq2fI9tnA+Ndkuj8Chn1X++9T9hmLc8+XYWMinK/qA9V1+BKlrTfAPMZ/sUr1c3z+qQoMr8k1noCM24G5tYk3J6NISyPER4DjZGHmFBFyfrvVHEQERQtqalwJXZR+kSRQ/8DX7NdI15f/TeyFJDUCNkK/WQ9Mb2PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f4rAVigOcdaQGMxLbatsMRm6FWYKHMEfV7JzyxVa0w=;
 b=e5tvg9UKNUKjKLynULS+1ER+pA0f3N7wbIdLY4yikl+T0KloM2RkJGG+pqIqLYU2NmhGQwP58jsYjNcb1UJhdv2pqZw8tpbkEblmLchddpn1J285guxF8pnuicT+aNHlCeLDd1axsRLN8XsDqOYa2hdD/rSLGOyJBQIQdPvaFPw=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 SJ0PR10MB7690.namprd10.prod.outlook.com (2603:10b6:a03:51a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 13:44:15 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 13:44:14 +0000
Message-ID: <7690e7b2-6e7f-6ff1-5249-72f497f82f7e@oracle.com>
Date:   Mon, 24 Jul 2023 19:14:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] misc_cgroup: Fix the obsolete comment around 'struct
 misc_res'
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, cgroups@vger.kernel.org
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        linux-kernel@vger.kernel.org
References: <20230724115425.1452383-1-kai.huang@intel.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20230724115425.1452383-1-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|SJ0PR10MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b65df6-af54-4de1-9e16-08db8c4c11b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVtKDaMibXUnHwWqIfKy/Om4FplLTstmMqS2qUT3/5sZlz1RllCEiD9YSlRbXxBZf1ZM9mlm9Mb1FMpxyD5sNQ2nlPp6PsMiBKFMCylsGq2kNb1MM1aj9w0zf4ORgqj3NrVR336p74lIrdjHClk0+K3sVBcObRURI7LUdv01+ZttB5FWVY6K7dajO4HdEVig5n5sbx/+zqyJA4J5wFmCbKvQkr7znw3pYverwYmcJ+wKc+loHXXQBcMH8l/ui4Zw187rIcECSpJWvKXhYYXrS3UPTSjnzFIfxft5K7KCI7ujvr3dTUhmrwc7eP5XxvEQIlVx2u3zMVVJw7ou6AWzrwe/AYZuMZXDk8NivfY/Zvvk6YCFhfm5GykY1onzuWO0ECRCdsuz3zWP3Yn53+S/DPXU2ANAblOwee0sBfB5r6mRMpNvZLCs5HKEBqzLQCJ2KnPtH103XwOBjPdh3Q2VMYy7DWVVmK8z3/AI+vvZ7e7IOhrlqj3bkns9WQtAiWSAHSY1QssxxVmqHZmcpmyUfAf7eACvbSW/yp+iQjhBqClK3xgiULwk7vw1NAnLjEotS8cdUVMxC9dNQR1Q5qphQWEIh6+JLrl1cbhoByjePaAhzpgdWu2rBYg6A8Mkvf5J9fSXoHJ8BrCUsZswaeMbYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(26005)(186003)(41300700001)(478600001)(6506007)(53546011)(86362001)(31696002)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(6512007)(6666004)(38100700002)(6486002)(966005)(5660300002)(2906002)(8676002)(8936002)(83380400001)(2616005)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWd1OEJWbTJtZHZyK215UzFkT2YrSGk0dlE1RzhLVURqaC9YN04venRZd0pv?=
 =?utf-8?B?YURramhDRUZBV2YwS3JvTFA3TXRVS3h1VGJSZ2hYaVFnZ2hKTFluTWR4d2Nu?=
 =?utf-8?B?a01BWE41WlpBUHA3MFBOQXM5MzlmS0NvRjJpTEtvT2Q0QklsSVR3d3gyZ3Qz?=
 =?utf-8?B?U3ZYTVltckZERExwMDl3QThKVnRkT1h5Q1k1R3ROTkdsTWJ0Z3NHRldmL0ta?=
 =?utf-8?B?R1l2M1A5UlZEbXB1bEpUVHpDRDI5QVB1RUtkMUxBWld4SnFTK1BUbjVpMFZS?=
 =?utf-8?B?dDlWYkZrQ1RqbkxPMHgydTNzMEc3NTlENS8rcTZxY0d6VE81QzlSQTMvODlC?=
 =?utf-8?B?MDF4aHR1TzlwMTRSS29DL2xPeW41c0hwTVg5OWxvUUhtVGdMVXNWdXU1ZGR3?=
 =?utf-8?B?OXNISHRhK0l3SS90V3ZjWElWYjlBRzJUc1kxUVNzeEdRMGFqUUFxYitUaDV5?=
 =?utf-8?B?VmlNMTA4SDFvazdUSWNucHo4eDROalZpbjQ3NllMZFpqSTBGOXJuT29zWDdQ?=
 =?utf-8?B?VlZqWnBOTmNwODhWR0s5RVorZXQxdk9NRkl6YzlkL3hSY0VUS2dsaFRTU3Zo?=
 =?utf-8?B?NUIrWHVvNzJIVWczR3pYV1BZMmJKWXFOZ0dkTFVMVmJtQ2pkQnQ2Rm9lY25O?=
 =?utf-8?B?RTJIU21Bd3U5ZVpobUloOVNVK3JVb1R3WG9CdEhaajdBM1l6MG5RZUQ5QWZB?=
 =?utf-8?B?N01zRTdLeGJWS1luNEYycmY2OVZSWE1CTUhFU09oU1lKNk1ETFhENVNpaHdE?=
 =?utf-8?B?bHdtM09aV0xSb0dPOEUraXVNUjBWSGo2TDkvTzhWNUhiN3ZmbE10ZWs3M2U4?=
 =?utf-8?B?VHhhOHo0MmpqQ0JxWStvdWQ3THRLbHF2eHgvRk11ZXVhb05KNDcwSm01TC9h?=
 =?utf-8?B?VTYyUURzSXJFVmNvbUFCNXRvc2pnMlhtbnFBRDhNeXpIb1o5cFZlSEZOQjdE?=
 =?utf-8?B?b1oyVmtldXFaWURzRlRpbUlkTUpHRkZKQXlMOXVoNU9aangwTFVpRVNjRkMz?=
 =?utf-8?B?TGpJc3l3UXBxMFJKc0NYc3ByY3JpMS9lMUVCbDlSM0dqc2pFN3c2Z1NDZ1gr?=
 =?utf-8?B?NzBMbU12UkJuK2JJVVlhWG1KUjdqaXVaU2Z0cmtPcUhaaHpXbEFrS04vZUF0?=
 =?utf-8?B?aEJEWFpUM0ZZWW00WFlGMm9rVURxMENzcDJnRlY2Z0pjcXZKK25Nb0hyeEM5?=
 =?utf-8?B?eitaTCtpaWFheCtLMnpmU3lpZEg1QjF4cmNwMHlXVkpaUjdKN1ZPd04yNWJK?=
 =?utf-8?B?dnVVOE9xT3dJMTJJelVDck9LaUgrQnVEM21XeFJJNEd0cVJwVEd5bVgvcFhV?=
 =?utf-8?B?RnZDRmMvczB1ZG9qM2xhdUpkcEdDc0dDUXY0cjdESU11QkVGUHVNRURYdUFX?=
 =?utf-8?B?eHg2TksxY0V2QjFlVWdjVHN2c2dFWW83TUFIVXN5VHEwTW5PZWFQeE4vRFA2?=
 =?utf-8?B?eHBSeHhkV3F3Q2dLQnRBYjBxaVFMSTR2L2pYWHIyQTJrdmgrWEwwazZpR1hz?=
 =?utf-8?B?bDFlQndTSFdYMlRlZUZUSGZ3VVlrcmdlMlBlcjFhY3lPUk9ubk9rK1lhQzJU?=
 =?utf-8?B?aVN2RXBNNCtmbURsV2RUYjNldXFHdFVtQ2xsT28rR1A5TVg4bno5N1Q2MDNJ?=
 =?utf-8?B?QVUxS1J1cDFsTy9VN05DMnkycDBIenRiR1JJenl4dkpKbXJ3cVpJZFBNVjln?=
 =?utf-8?B?WWVqcStKQmNsTTZZUloybG56ZFQxYnNVYXEvbUFPQmRUMGJZUUNBM0R2enVF?=
 =?utf-8?B?QTVRVXJBZUJnZEJkN2pUL0VpbnQzdzB1Rm9KYzFMT0NTK2s3OVFDVFBNSmI2?=
 =?utf-8?B?UTZPc2dsT2xUbDc1YXJvbGQrNjBhd1RYWVFlT1F5Q0VNNkRNM2lMdXk4cktq?=
 =?utf-8?B?VjhpR2V5dnVLdkYrUGFMRUJudDBTRTcyVSt5ZDVVNWNYTWlGdGNrQzlQck9G?=
 =?utf-8?B?aDVPc0lzOHluTzdkL2w0a2pQWWV4cGNiMzhQbzNwL1RuNlN2Qk5uVzBpTWhV?=
 =?utf-8?B?WFZsS2szR0U0bDdlRGlHeGpYYThLSGlOYTIrRm9QZlVYZUxOS2FJZ2tEdHRD?=
 =?utf-8?B?SnhBNnlCbjB1S1Jia0xzVG1aSWZuNFBOOUpldHo5UlRrcWROOWlrQzdrb2FM?=
 =?utf-8?B?ODNpb0szTk4xYWdsaWVuVWJIVU1TaUF6a0VWSmEyV3N3N1hxeXExV1dTbkxQ?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P/RWeKwjDhokweINZc6Cy+hGJvNpIiIBACyCg7WntLkhflvDp2VtYGLxENVGRpN9VIhVhX4hyEZYRSbXfwo0Frl7fsNf1llc3F2RPPNm0L1cDixdUuWUTfj51cs1uWTkK6tKilQ3t9kUBGXPG9sGTt11acsKhNJA5KO6A9TlbtmCQdZ9Xrgba99ng4boP1NN54FIP2zDt3vM535vu26hXdnVXjzDi6O4NMXvc/+uYCgekLI3f+ZPA9mn9HR0s9SHqQv7TA+skKR4468E9MhS/sDOpMRb/+RKuY0fs98755D5I/9IQhlnN8uHjgO0CNV2ciesgdoLmOJqvcqNKG6XVgqimArFkc06e1uTxs6YY3M3L/6wqF9J8CDt4UaXxHMjpQvL+0eDCI/8BTqBdpf4oEWGsAqqf0poKaJZwel2s2asrphKh9OVGI5SHGq4a56Ml0N+NbUMLuSJVMLMtfm0aaET9NQBdnyRBWJjdufoisjXJSdf5MQuE1UnFeBGfWKmVqwpeGLOQ3bvdFzmb6xFS6a8BgtA9An6uiW8PgViWvNs3XoEiT0gmSOyUM9aGlq96UGNKsmqDa+oFwVZbBBNWAPk1f54AFNuYVZJlUfLzH0TZt1P2BhHUJMu1RJNxf7mn11Rm9F1N0NDnV+615SpwuvZV+TpMTBsFA/FcFenKd2LzDxwI3FEWYqJ5P4e8IATfKmlBh7Igsi/p+eSicwXVNYHYX93tpV0dJvc81yC3E68vwXMsqyxjYnWJVJOfkdAmO1FyRHoW8oP2gfuRwvZjys3FcGHFyzJjtZGilf5Cc6DwvJ8Hg9mOsv3/PuLSFGxAuhJqGwkS6T22BCECpg5GNQHuHyrIGTVPLDTtDesIZsG41GkidhC047GTXIiAEih
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b65df6-af54-4de1-9e16-08db8c4c11b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:44:14.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX9KHgrl1aRT/X11i8YI4U8EKyKnMRkfZC2RMBOjbcDlqV7yJCuMRuYzSVCgit2MRuBHrXjpkLHVz4HlH8qYceBesaGT1LVtc39v24+mCcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240121
X-Proofpoint-GUID: VR0RfZ8XQ2aRpLXKte3Ge1FxEjmwUbeO
X-Proofpoint-ORIG-GUID: VR0RfZ8XQ2aRpLXKte3Ge1FxEjmwUbeO
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



On 7/24/23 17:24, Kai Huang wrote:
> The comment of the 'failed' member of 'struct misc_res' is obsolete
> since commit b03357528fd9 ("misc_cgroup: remove error log to avoid log
> flood"), which removed the 'failed' member from the structure.  Remove
> the obsolete comment.
> 
> Also add the missing comment for the 'events' field, which should come
> with commit f279294b3293 ("misc_cgroup: introduce misc.events to count
> failures") where the 'events' member was added.

This has been fixed by:
https://lore.kernel.org/lkml/20230718090834.1829191-1-kamalesh.babulal@oracle.com/

> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  include/linux/misc_cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index c238207d1615..41aa213a1125 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -31,7 +31,7 @@ struct misc_cg;
>   * struct misc_res: Per cgroup per misc type resource
>   * @max: Maximum limit on the resource.
>   * @usage: Current usage of the resource.
> - * @failed: True if charged failed for the resource in a cgroup.
> + * @events: Charge failure event counter of the resource.
>   */
>  struct misc_res {
>  	unsigned long max;
> 
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c

-- 
Thanks,
Kamalesh
