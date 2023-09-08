Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609379830D
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjIHHFZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Sep 2023 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjIHHFY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Sep 2023 03:05:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908119AE;
        Fri,  8 Sep 2023 00:05:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3886idF2017720;
        Fri, 8 Sep 2023 07:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vzUArHqkJev+Nd04DgnrSxOKaShq00tG6YTO6CUmYZI=;
 b=MrBHdfUUKULiL9TktAwsQSaseY7A3izeQTTqKtCgU3rWsqUKeRLg30Pn/6TfMz0iMn0w
 8GzwxVSSah4UrTipr3MEKF6vpcVmzL1dgVs8lVv5hClOEVFB2877sMwpGAbWy4TdWzz6
 aXqLckd6hFmw2VyAXgh08vY2aak21poSPOfV8HXduvs9gfUNP5COE7W4PuLK+UU2oEcS
 vWrFAOYcCBR+lHoaLMjo34MwjSmp62r07TJVnde/gx+vzscQsmbvEw8Oo1d9Qvqan9mz
 ch/hs7tQEj7LEHLHVioLI/75E3K9lk3I8xEKFgtfbgwO8oYaxKahKJBL2ejNLo0bnfXD sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syxkv00x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 07:04:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3886h5tR009437;
        Fri, 8 Sep 2023 07:04:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy111p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 07:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEkZzxUETqJMLdWfUzWGV6pt39hWfm/NvqgzZvLiX0tQ+hRPVV5j7TnaGpX5NwIc9Rb9VT/zRctD2tkV6ThmxzTgMXc2HboqRzd1DxdFtmKGgiZ24LWWGwOE/poQ48pg2xq1ofNActiCkHfVfal7AU/oOjgo2Kipqq9uyY6MI1eLJmH8GDXXN/6HyHZEOy2PeEo0WAvgPa1x5FaVQ6rqzbOs2d7xESSBri4OtG5OCdj7VtyTJCQhBJpVoPXMkIj5k9h/0MemWh+3Dl6rwnWYXNXR1KsSnCgLLmYPP+DoXleV3AKkELuwL2o+Xs00/bp9g4pe4ft7uRRJao9dExGVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzUArHqkJev+Nd04DgnrSxOKaShq00tG6YTO6CUmYZI=;
 b=F6C5+ymJjIit4faM/QwXche9Atc/uw0A8hJoLUiUBeNQQdAD214T66N/V7A6j5iMyqzVLZm8HawtjnrAf96nAm5NvJYWMRVyTiSmXWe3LnQIdTLwnKqyU3eXLIfpFCz4XIgQtJq5Ed/PTI/1+TZxWoGHWP8H25Sv2YKwn9iDTztAw0ZrwO8ss3vET0iI931ry8AGHznyBj7YzdkKN2aYTSv2xTKvb+jDNgvIgFxiDNv4siSvkq0zUe81TTllqOJZvyWTW8Jr5y7o1lfLVcPvShUCupcj4IvrjMmrMtXU1MFb8aFsuDRinQvhBA1iamel28m14GbWmtKtYI2H0MnJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzUArHqkJev+Nd04DgnrSxOKaShq00tG6YTO6CUmYZI=;
 b=vKzuSh4vwJItvT54IsnUp40vZm7sQoMBMiE3Lzz8xZM1bx3hExXdijQBiIMUPCkiwDpPuIYCs70fxpseafdGylJU9nlvIW1gs6qqA6R5O2MRZ/yfSQbo7H94ysnXJH80+c4cVyS16op+fQ8rvuef9C3EZf/Zz5eA4XC3XYgUfeo=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 07:04:37 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 07:04:36 +0000
Message-ID: <4f4404a3-0bc3-b75f-6ff6-1725fd252f87@oracle.com>
Date:   Fri, 8 Sep 2023 12:34:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     Luiz Capitulino <luizcap@amazon.com>,
        Waiman Long <longman@redhat.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lcapitulino@gmail.com
References: <20230906005712.66461-1-luizcap@amazon.com>
 <5487ed0a-8483-0a92-c7c1-9ca3ed8e6162@oracle.com>
 <ac50c7a3-c2af-26c1-cdd3-0add6b299994@redhat.com>
 <a88173b8-0d87-37fe-3c4c-bd1d15d3f5bb@oracle.com>
 <e7675405-c910-340e-0679-0271dff76722@amazon.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <e7675405-c910-340e-0679-0271dff76722@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e23042-a063-4966-78c1-08dbb039dcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LITMLQakZ5yaBIPOXeMdTvR/v8Ij5Bt4pOLtYJNZzfXRfp65WgS8ZGI9ieZTgfekrIyKHjNtgkWy/WkGEDkfQZr3PSJARNFnWWJGEcHVo5ogg8H1K+SpCLRG8pzryiCvYaz4NR958jG5Wmz53rNCFgyIWN9vblhUiF0MS4htYVfV56ciTVnSvYuk/HLZ7xdtnc5tJF/IAChOAMayz4787H4SnxwkcOcL4g6dh+moY3Zrp9SFAwdc1LNJd2ushPEkLes0U44afpXAZhcH1XL0VuM8l+ftSOcN4nW6WCTCKsn8M0nxTUp2ZFRSvY7Jn9TpWIWy86njWq94C2xKE9WKixkQ7IKcsET2k1L1x6soJ63A0m/lZzmzbElSOgmJh+EIA0Bn6AzP61vIgOosrqCSvG58zrAQiamHqQ6a76dfQaiakQzI6zj/2BOFGzuE9JzkWQows9xdbtUY3Gz4/Kxxqofxt8t6DQAvZ//b64sqc1uxCkjm7jE65HFFNmsbjt+Kl9najBkZYx9/gBkpJWD4L4dVfAFYZz3nq1wiDkibyvzuLE6/5/1/MITzvC2UaTYLIbIEPHfHMzH6RffXsZdR4vMLfTUrIokuOiXyPbC/okOXpBgnQIyq1vLzhz+7tT5GNSCEorFCNZwXbEm+luqA0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(186009)(1800799009)(451199024)(2906002)(31696002)(86362001)(53546011)(2616005)(26005)(478600001)(36756003)(6506007)(6486002)(6666004)(6512007)(55236004)(38100700002)(83380400001)(41300700001)(31686004)(5660300002)(4326008)(8936002)(8676002)(316002)(44832011)(110136005)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdKVVlGbVcxa3ZUTjZpRHdXOFV4bkVmWUZRaWYybm5UUzJiN2V5ZGpMQzZr?=
 =?utf-8?B?MG9BVENjQkJwcnVkTEhveDFKRnNWVHpuNXh4SFdrQVVPT0QyYmRLdTI5UDFI?=
 =?utf-8?B?RGV1dXdidEV6czBwZFozMkdpd0FLWURnWC9TRnRnM2ljSTJqMXZJVmhzN3VG?=
 =?utf-8?B?TkUwYXNPSlNTQUlKWGVYc0VKdElrVHJDWjRUUjZJczZNTmVQbzZzOGV3NkxJ?=
 =?utf-8?B?RXFzaVdOWTliQ2tiSm41Qk1sOVg4Vjdtc1ZrM2VGR0xRRTlUSFNtbGoyNHJ2?=
 =?utf-8?B?M3pPM2xUdTJqZVh4RWZiMWc3dU1ldXRCMFdidk9ZZ0JnbHoyNEgxVFBPeWZp?=
 =?utf-8?B?QllORlpjWlJ2WGVUdDF4MjduNUk5NHJ3RGNMejRNeUtHMVZpUEt4OUVpcHF3?=
 =?utf-8?B?OEtJTnN3YmF4bjRLeDk0amlSbXFGRTBnT2hibGRkSU9pSndkZmw5bVpvS3ZZ?=
 =?utf-8?B?QnY5bERvelE2aTBkLy9qeFN1bUlWRE1OcDNEZmtnWGdNVE03NWdzMTRpMnlZ?=
 =?utf-8?B?YjJBZzRtRnFvTldJMDhLNW9qSUlGRWJpUDBrQ1hUZFhYTnNxU3QxaFlocDlu?=
 =?utf-8?B?bUFkbUU1UnFGWHFMUXh2YXY5MXdJRjJMTzFGeTRuK1Q5Ny81eVZ1amVhM0hy?=
 =?utf-8?B?d1c1WmsycGlGRjRsZFMyVVpqb21tL1orRjlOTTQ4OHhyclc3SVBOenpTMjFG?=
 =?utf-8?B?b2xCeGtOU1ZaR0J0UTRuUHFGRGROQ3hGdFRzVzh0UENUT1p3Ky9QTUdzdDZS?=
 =?utf-8?B?S3E3RnQrTHNnM3Y4L1BNTzJCd1B5bEtZWncwQkcySFVYeVBLUnhzOUNPOHEv?=
 =?utf-8?B?MzFSbzMwVWZ6NndXNjRha0NQU09RQWYrOWJ1VmNLK0Q3R29KTHIrdTgyU0Rm?=
 =?utf-8?B?cEh1ZXlnNHpxS0owU0ZsV1NscFdEVGtZTjh2b0VEM3ZlZnlSRmxJNXdKcUh4?=
 =?utf-8?B?M1M3RlFKbDJnN1NFUXJYRmZSQnBLdHNEek5hR09vYVRNb204bE9VaHd2RTFz?=
 =?utf-8?B?VG5iTTRLM0owd0dmSmFGbGM5Snd5QVpUVTVjMFlnTlBYeTBweTZ5TlNybG0v?=
 =?utf-8?B?cTI4Y3QyZElCcGFMeXVLWUdDWXVrajNOZWFtekd1YjE2eWJldjRDVURnejRD?=
 =?utf-8?B?a3BDSGRNME9xb0gyL0VYcGZKVUtUOE5GemladllTR2djZzJuamNpZEdiSFY5?=
 =?utf-8?B?ZFMvMHBRSDNjY1VDY0MrcjBOdExEejhQUUtaL1VJKzNvZGxWbHZmNkpseG44?=
 =?utf-8?B?TExVT1g4NkRkeVBFV3RRQ0trUW1MallTVjgxZnVwMThXTjkrZ2xEdDBMNDl4?=
 =?utf-8?B?VlZ0bmZCSzAySVdrc2tNeFFRSGI0Qm5iSWo0Y01SL01kc2c4cTdnOWdseFpX?=
 =?utf-8?B?ZC9wc2tvNzEyY1BRVVZBd3VvNHMyOGZMMHVJRkNsc3l4cVYvUjVaai90aGti?=
 =?utf-8?B?Kys3QkhuRFZyWFh3RDlFU1dEd0RJeUR1NEVOWC95QUxGOTVTVnpaMVpDU3Nm?=
 =?utf-8?B?NythNGIveEhzSDFJRldOSmVMb3ExbDY5RklESkMwdUQxNUNweHFxZ1lENXJ2?=
 =?utf-8?B?Q3Y1SGNBT1BJM2R0V01tRnpnYTFEbGFuZFNSSG9UeFlVaEQ0S3E4Y1l0RE5M?=
 =?utf-8?B?WDFtZUdCVUllb1NSejBkOG14WWtVY3ZXQTlFSXdiVzNsTWg4ZkJmNHc4SHJn?=
 =?utf-8?B?NUMzUXM2MzJDV1B4Z2EwZ0x2amxjVUtPY09VS1kyNVdzeDdFUWU0T0xsczJs?=
 =?utf-8?B?KytaTC9pdVphL09KaWpsdVNnRjBKdUFUcDZFZzljVXhsZW1pdTlUbkNieE90?=
 =?utf-8?B?RW9MbCtnNUhQamdkY3lUTmRBM09MalJEQWlwekRZaDdUVDB2K3RoMTNROG9G?=
 =?utf-8?B?Y2xvTElhcjVSejNOVlpCNkZPSTVRTjZ1MWhSb2JFaFRJTWkxbjQzQkxjQmZy?=
 =?utf-8?B?cUdCNUphZW9vMDdabGgxd0hzUHJqYUxFVFJrbDhTc3F2RmwzNE5qNEVDNDlI?=
 =?utf-8?B?TXR6cW5pV1lzZ0xjUnpxSGluT204azJyQk4zM3pxdXhkQzNURElnRWV0SVBZ?=
 =?utf-8?B?cUZIOGVOZkVQMHVwOFRISXJ1NWhLV0tEckJ3R0tybkVXZmhLRlRDTFhrWmov?=
 =?utf-8?B?ckVjQlFySDZJV0dHcHJBd3JocEJEdzkzTjZpTmFKdGlmVlhOdDVRMkZyWHdN?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SnVSNXkwMWkxVDdIUyt3UkQ1SDZmZ2RpMXhCNmVQZlowUGZ5cUh2UXZxejht?=
 =?utf-8?B?WkVrSVZnUi9jMTJQVkQvVmkvVC9KYW52SERNenpnbDd0QUxUcUdldFF2RzZL?=
 =?utf-8?B?OVIrbzdqVnppa0xqazMxYlAvL2d4N25GdXg1V3J1TFd2c3ZxWFdEc0dEdURx?=
 =?utf-8?B?TS9TZ3lEK2QwaHlzYmtXZmdKQXNGbkRjWndpUU14RjRnSnJhYjlTVHM2NjVu?=
 =?utf-8?B?T1pXODNxMFdqOFpZVjhSTW5EQ3ZBWnZVYkdrWDFMVUdhZnBzOUhRZHpiQ0tv?=
 =?utf-8?B?OTZ3eDJRUGlsNXRJTEJRTVAwQ3V4dWszVk9sNWI2N1pRQ0NIckNnU0xaWTRL?=
 =?utf-8?B?Y29Cem9BbjNWQzBSOE5yZzdOYVpLQ3M3SVduNEw3SVRUQzN3V2pubGIweHp6?=
 =?utf-8?B?akJURFAvSFdJTnE1N25wOVNob2NsaWJmOUpIRkZyc3BYamlLK0szV3BXS1Y4?=
 =?utf-8?B?OWIvUlZ2RWRGYjR6SmtNVVJ5aVdCUmQ4UUlDZ1UvaTFXTExWaFNVNDRDNXo2?=
 =?utf-8?B?bnIwalBsWXE4djhaRGZXd01NQ2V2ZkhyZFdURXVuU2dnVlVwZTNHOEZRVlQ3?=
 =?utf-8?B?ZW9CR0I2N1BGMEJrenZHaXJTTXZIaU94dUVRWUQ3VmZUdlFSeGhObEhJNzJU?=
 =?utf-8?B?SGdNOTRtR2FPc3BJRmxNU1FDUXhMZm5VRUJNL0VscVI5Tk9mK3BxTlJ5dTJD?=
 =?utf-8?B?TEVuM3pHYzQ0RmJhSE80ejk3NENpTkxZUGpXVmg4blg2bGlVMzZ3TWQ2Slh3?=
 =?utf-8?B?NGVSL2swTGwzVFMwbjY0UWQrTzd2dER3MEd2M25NNHRSUU51WVEyb0tDWlNh?=
 =?utf-8?B?aTRzMWY2aThONzNQakRtTUdQbU94dEovUDVTQ1VYSU1UcFFzcThhc1orVXR0?=
 =?utf-8?B?TDRoUk95QlB2ZGhsUUtsRHhVcWRwRGZaeGxSdUpIcjRyTjUwV3FKbUZNcU1u?=
 =?utf-8?B?UTh6bGViWGlMeGUzUW1BY1NBbXFKUWNGUzJyai9TZGlzN05zSnZRWlZwajl3?=
 =?utf-8?B?QjJJbjhZdnc3TC9OTnBHMTZmQ2lhQTJ5M0pTcmdYTHJtdTczQ1U5SWxoK3dM?=
 =?utf-8?B?bzZWUmk4WTE3c0dPeHFCVVJBNWhCMlNZWGlqNk93aFRoUVJ4NU9pU3h6MVRp?=
 =?utf-8?B?SlpSaVhvbSthM0FXa0E1TzlCbnpEbW1WS3lGR1RZM05rZlptK043SWdSbzAy?=
 =?utf-8?B?dGRCSFBNWkZ6cGNSZ25JcmxxK0I4cEJjSEVDNTZmS2RGQ0ZXQWFEQzhqTURx?=
 =?utf-8?Q?ZDPDYUUwphB7u4t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e23042-a063-4966-78c1-08dbb039dcb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:04:36.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOPN/tiwjS+R2tFZElyCC8WlVjBKaLb7ESRcud0++8x4YJWo8w7SxGaLMV/y0+7Q5cZo0SjRA74T/E9+pLcpqOPIej+wKNfTP8UeF4J8nII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=921
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080064
X-Proofpoint-GUID: EVcOhKNhsDpg2AxpAdS90fMKMwaC-Z3C
X-Proofpoint-ORIG-GUID: EVcOhKNhsDpg2AxpAdS90fMKMwaC-Z3C
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 9/8/23 00:17, Luiz Capitulino wrote:

[...]

>>>> Consider a case where the kernel is compiled with
>>>> CONFIG_CGROUP_FAVOR_DYNMODS=n and kernel command line is passed with
>>>> cgroup_favordynmods=true, this would set the have_favordynmods to true.
>>>> In cgroup_favordynmods_setup(), should it return 0 with a pr_warn(),
>>>> when CONFIG_CGROUP_FAVOR_DYNMODS=n in the above case, or is this
>>>> expected behavior?
>>>
>>> According to the documentation of __setup:
>>>
>>> /*
>>>   * NOTE: __setup functions return values:
>>>   * @fn returns 1 (or non-zero) if the option argument is "handled"
>>>   * and returns 0 if the option argument is "not handled".
>>>   */
>>>
>>> So the return value should tell whether the input parameter is a recognizable true or false value, not whether it is true or false. kstrtobool returns 0 if it is a recognizable T/F value or -EINVAL otherwise. So the check is correct. I did double check that before I ack'ed the patch.
>>>
>>
>> Apologies for not being clear in the previous email. It was in two parts,
>> where the first one was more of a question, where if a kernel is compiled
>> with CONFIG_CGROUP_FAVOR_DYNMODS config option disabled and the user
>> attempts to pass cgroup_favordynmods=true in the kernel command line.
>>
>> In this scenario, the have_favordynmods is set to true regardless of
>> the CONFIG_CGROUP_FAVOR_DYNMODS config option being enabled/disabled in
>> the kernel. This allows the user to set CGRP_ROOT_FAVOR_DYNMODS flag
>> without enabling the CONFIG_CGROUP_FAVOR_DYNMODS kernel config.
> 
> Correct, that's exactly the goal of this patch: to give users the
> option to enable/disable favordynmods at boot-time regardless of
> CONFIG_FAVOR_DYNMODS.
> 
> This is especially useful with cgroup v1 where remounting with
> favordynmods is not supported.

Thank you so much for explaining. I understand the idea of the
patch better now.

>> Shouldn't the cgroup_favordynmods kernel parameter be valid only when
>> the kernel is compiled with CONFIG_CGROUP_FAVOR_DYNMODS=y and allows the
>> user to only disable it in the kernel command line instead of allowing
>> them to set/unset have_favordynmods when CONFIG_CGROUP_FAVOR_DYNMODS is
>> disabled.
> 
> This was my first idea as well, but since we'd allow for enabling why
> not allow for disabling as well? Besides, the resulting code is
> fairly simple.

Agreed, If it's independent of CONFIG_CGROUP_FAVOR_DYNMODS config
option, providing both enable and disable, is useful.

>> If the above assumption is right, that's where the second part was of
>> email, where I was suggesting the restriction by using ifdef guards in
>> cgroup_favordynmods_setup(), something like:
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 2b7d74304606..5c7d1a0b1dbe 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -6768,7 +6768,11 @@ __setup("cgroup_debug", enable_cgroup_debug);
>>
>>   static int __init cgroup_favordynmods_setup(char *str)
>>   {
>> +#ifdef CGROUP_FAVOR_DYNMODS
>>          return (kstrtobool(str, &have_favordynmods) == 0);
>> +#endif
>> +       pr_warn("Favor Dynmods not supported\n");
>> +       return 0;
>>   }
> 
> Why should we do this? What's the benefit for the user?

This code was constructed on the idea of have_favordynmods, should
be available only when the kernel is compiled with CONFIG_CGROUP_FAVOR_DYNMODS
and it's of no benefit.
 
>>   __setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
>>

-- 
Thanks,
Kamalesh
