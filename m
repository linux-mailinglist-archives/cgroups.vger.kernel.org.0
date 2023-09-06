Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C67935E1
	for <lists+cgroups@lfdr.de>; Wed,  6 Sep 2023 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIFHEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Sep 2023 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIFHEs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Sep 2023 03:04:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B1CFA;
        Wed,  6 Sep 2023 00:04:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3866ssEc005124;
        Wed, 6 Sep 2023 07:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=59xsZZ3TPpxZJcNgps9giNm3BJaf1Qq91lXgRYkSeew=;
 b=dhAvNt8fpmnlj7QB0qHTnrrrHPbO0bBAzSjJaFMgilasiFBEqCx/bVg4HnZ+hw1RshXj
 yktMdEp7nUahDsuYqPBKC2gotfGggI+6yWsR8/pB8d8d/OXtXGpj6Y9BPzg1J8EztXFL
 HrXRuUNWdvYhx4Fjr1EUBACsZ4O7eEosEupZuvMg4Iu3BGuSI/LbutktDffTk4G6WfFB
 6NgJAaVnlNAwagV7aJSl9bmw121Nerhto/B5XYw9+pDUwmTdGBE4pKg2hu8VDJqBP2bp
 nZ/9UBSMxZGPtMFfCX07ro3XB6FAsteiQwzDo93PB5fPunZzDh7ryn2/mGArOz8ahzUz Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxmjkg0g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 07:04:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3865QLNK006548;
        Wed, 6 Sep 2023 06:59:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6a8wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 06:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ+/qvF1iCpD3HLfjLboNyD+uHZf8wTtyOs7wI/ttoxeynsmBY7dhdrJzMP+8IaPONFLSBdlAcVpW+DR+qLESBuv9ZzMhSV9awzINELtNy/vhOx4FJf/6+WqIBAQ0fOq5km9JfzfxAYGN12uvULjTRgyVzvun49+1IymCSCQCOrAxZFaZySeXkSXoR4T9pcXZbyBYJMii+npzcyWCag8YzEWbWByXfjwUtxCqVYS96Km50/6ayf0K8SGm3NuHuC81nNJrcriu9tz10X2Lf4MSRJGZgs6SIMlac9fy/Fo0hwxOS5x/rUG9ATeKDPmxeed6qExVimzSThqKKeqqba9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59xsZZ3TPpxZJcNgps9giNm3BJaf1Qq91lXgRYkSeew=;
 b=Wo4LaBiXz/T+1GrBvAw0Vu5sAhRoc5aUm4D2KVAmdkqWPec/7gezcGBVKf7quwshX5zemGg3xyGiCoae/8VVHd3obnGp1+MTQ/q7Ia79sY/pZwzSvDK24cMv2AIrlt4LLEn2m6W3+QcWP/1iIIZl1owlNywLKLB/WNzmzR+P66/Tzz5571QVvi2MRS9t4m5eJlQSkV1UlR+R7HHX1FZmg/Bt/XmIXvLwPcjR1xG96BCusTa82/le3RK0eUT+0nOhyRZNZU2e280ODSs2QAhHM0MwqZy/sKMcvIuMtw6a2U27hf9deHmvgl/aDvUIFsYbttzkVQXlx/2HL9YURUgS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xsZZ3TPpxZJcNgps9giNm3BJaf1Qq91lXgRYkSeew=;
 b=OAhm/gL6ROFp/v9rvQ/Tjc8CS3ulCE7rG7rfcE26lCmZBN851zO+YuPWrLmIXHumqnGmVCfL375+wVjd6WM92G4/e95kIFgYM4fA0hDHmj0PB4HOs2HMQeFWUDtnm7I1nDG2U5t5OrPU52Zo8t8vnFVmO+2t9NetWRNIQJ2RKB4=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 PH0PR10MB5705.namprd10.prod.outlook.com (2603:10b6:510:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 06:59:05 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 06:59:05 +0000
Message-ID: <5487ed0a-8483-0a92-c7c1-9ca3ed8e6162@oracle.com>
Date:   Wed, 6 Sep 2023 12:28:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
To:     Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com
Cc:     lcapitulino@gmail.com
References: <20230906005712.66461-1-luizcap@amazon.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20230906005712.66461-1-luizcap@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0222.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::9) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|PH0PR10MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab54b5e-74fc-457e-afaf-08dbaea6c1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIeWZBTfGml1Vy4HFayUEcBBF64EskTTMDlhZeet6i3+WwZSH0mJeHFQ7qx1Ji6XAHivx4DGQL6eWa86/1yPe6vobuYfR873XYcaxxhH9jIOoc2oJXyekH8KV9+P89Ld9hk90bIXEIiJbHFVDo+HgykRnq79UZhYlyP6o7dSqLG+CsgaflUAnHA7jP6moEWQR3S+gTjH1MHLLfCx1rMudp1r3cw7WX+y8JruoBW0n2SO0aJ+acvBswFJT6IIGVSG7ZPAlMfrOShRrqy78tmSi2vM4pZ6cZ6qD/CUDE/mrNo+tEamGZcIey8qMnR5RZp6250BEFb7Co1Rbzm7fmGrrPkmAmstObrpOlw00XcrtqmNUo9DZ01dIQlCDyzHcdWb2erqxplkXMAhwttflnRMmhAdbBUJfArbj8BEwy9h6qeFQvAn0rz3YPHuts6TgE6gEvCU9WmJQ1ITmf49f48fBrlvpQWPyV3LxLlEna0F8dxfomV5luZ4XNmc7GZ5NLdF8H2fA/my6PTDd/29X3BYBtJD+oR5M0yxYuXXyftrdkFFqOWOk96iQAZi3JJ2F6AzTMEClGGc1vEpJUX8OttMlPL3MhuYgkHrSCq29JOnzKuKxXCUe/6Wq9Exd4KmwE41pmZKDzbBS9+GfWF+ydmEYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199024)(1800799009)(186009)(44832011)(8936002)(5660300002)(41300700001)(66476007)(66556008)(316002)(2906002)(66946007)(31686004)(478600001)(6486002)(53546011)(6506007)(6512007)(2616005)(8676002)(83380400001)(4326008)(26005)(38100700002)(6666004)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtCNytiUUp0YnFuZGpETXB6S0o3cDZDWmRKcldOZlZmVC9KRnluUnJtcVdw?=
 =?utf-8?B?Q1dMamE2bUpocVJtYjdjWTdndXNCQ2JTMjB1NzkwTHFMTCtkL3hRUEpyOWx5?=
 =?utf-8?B?ZC8yTHdXeExNN1l1bzA1T2VvemE4V2hFNmRvMHk3UStsWVJGdWZ3STJCNGR3?=
 =?utf-8?B?WklWMEZ6ZmdaMWtjbHlyeVcyMzF6eVJOVkNEcnZUWkhnbCt4Mm83c25LU1JI?=
 =?utf-8?B?TjVFbVBlc0FlQWtKdzJZdUFWci9iY093VlJINklkV3M4ZGpobWU2a1p0SlJk?=
 =?utf-8?B?NVA5aVF1a0xHZWhCYm4zWXF4ZzQ4Z0huRW5OR0VFTmF3R29VUGFmdHVKVzVR?=
 =?utf-8?B?RFZNT3p6SGxZY2J1TEFzQ3RKWHZ3YmlTTVNFejdFaEUzaVVlbEkrOUJBWCtS?=
 =?utf-8?B?ZUtNbHp3TTBSNUtGbi9SbVBkRWFzai9vbGdEWDRPYUhteVlvQTJMdUx5ZVR0?=
 =?utf-8?B?YlRiNklWL053Mnl3SDlRV2lJczdnTVJWcFN3L2h2czVDeXh5SjMrNW5hcU9K?=
 =?utf-8?B?aUhxZmZ1OFB5MHhRN1BXN0RSV1FQbEJIWm8zUFI1YTNiaFgxU0ZDU1dlTlJ5?=
 =?utf-8?B?YmVISkV3WmtmUzd2MkN5dlN2UC9BUjdUcEdHZ3FBWkd5MTNzMnV1N0ZPZnVz?=
 =?utf-8?B?VDNtek16QzNQY0tKYXkzbmZTNmJiNGZJNThpU2lteTRIMGl4My9nbG1xOUNn?=
 =?utf-8?B?cVZBQjlHby9JK0V4bmhET0p0QWl1WVpHWmdVbTdxVzl5NHlaTmFUMlZWKzc2?=
 =?utf-8?B?Qk9yVFllOXlTYTk2blY5bkF1b1pxcUkrSTJoQ0FJMWV5V1pJN3dYZ25rbXND?=
 =?utf-8?B?VDRPN21BcmdtOGNSN2JDTWlxS1lrQTdRNkMvaHNhTFF1aG5WZWJYczR2RWNq?=
 =?utf-8?B?VEdUdjV0ajBydkszaGtUejN0NzBFRGJRTmM2R2NsOEV6dmNNbEpKcVFVWklS?=
 =?utf-8?B?Y0NmZDNvSHBuY2xXeE1aZzBiejFrZmpqbzFrNXRTcXFHc2M2OHNtL0NLdHJK?=
 =?utf-8?B?a3ZpWVc3dXRRa0xRNFptNVhPS3p0ZUlPbVFpZFhlVm5uMGFpMGpoZ0FEZG5u?=
 =?utf-8?B?dEdMcjhYNzVzUkNJS1UwT3hsNEJmMzhVc0xaaXk4UTA1Y2IxVFoxR283YVI2?=
 =?utf-8?B?dEFUTW5hRlNQcDlEUisvKzkxY0NNMWd3L0JEbG5CRTR5RHVBWld6b25UK0RB?=
 =?utf-8?B?dFVURzFwOUNLYThvUlFDR0RwaWFHaDdOa3UvY1o1NDl5VUZpVENNTjRqTlhO?=
 =?utf-8?B?OEV2c2dYUWs0dy9PNGZEbC9xbnlZMDQ3NjAwRnNUSXZ0SjlzL3pJcllKbDVX?=
 =?utf-8?B?Wjh1dGxmTVlWbVozd0JlV2J0N1ZHdytwREs5WkQ0V2FMNjg5WmJySzFOcm01?=
 =?utf-8?B?alNHRFdvZnJMazNYWWpGWnU3UDV1NWJiR2JDMDRNdktXVmw2WEQ0bDdqSll0?=
 =?utf-8?B?L2ticXo5czNlNDNrMHl1RGZ2OW5tcmkvR3YvbDUvczdvRHFaNHVma2tjaHIr?=
 =?utf-8?B?dlNCbVFHRm10Y05tL3hrMHo2TlBjTDVIbHpqN1E3ZnQxV0ZoamRhVTRtT3ZP?=
 =?utf-8?B?VjJOY2Q5VVU3TWhjSjhpbGdWczZtZGFlRnhhQ1NiS2xsZmd1eVhmZTNBN0JX?=
 =?utf-8?B?cTFJNTVWRDVsaWRpT1NBS1dOWG9xa3JUajlpUExaaGp1azN0OG1EN0FyT1hw?=
 =?utf-8?B?RzRGbldLd3F0d1diQ3NDZ3Y0TmlpeUtpejNVUVlIWTBRUXgrMHZpQW51WHhH?=
 =?utf-8?B?ZWZ3Yks3R1RWam1wS1RMallaWjdmQ240VGpCbW5Lc3VYZTNnL0FaN3p2U014?=
 =?utf-8?B?UmJOK3R0UzJTRE5sZTltK3dkbjYzajlQRkVJMHBPLzFCR3FpL0xUZ2gvbFN3?=
 =?utf-8?B?a2d4N3ZZRjlpbkxDdnJPbjZoVWNoR1BhUlJwNytWMG96c3ZkV2Zya2hGeHJW?=
 =?utf-8?B?NEw5bjZMOEIrZUhKK2JUYjJIRWRPdlV3WlZ6bi9KNmYzNlFKVUlhOU9Hb1ls?=
 =?utf-8?B?MTRVR1FCanZhU0VSN1JVMGwzcldMM1M1S1AzdkpVTWhEb25WUG5wKzExVzZ4?=
 =?utf-8?B?c0dBWkFMWWtSOUVSK0FTdHJTYlh1Tk9Ta0V1OFVONFY1b2JneXVSNkFNc0tR?=
 =?utf-8?B?dFZiOS9jOSs4ejAxbGViVm92VWFVRVVsT21hWXFWOGFHdlA3WDd2TmkrTkpp?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NlpTTWhybGRyZ2ErTFZQb1Ixemk4YnVMM0RRQ29YcTA3SUlOUEF0MlhxTkxR?=
 =?utf-8?B?QWFOcUJxSVpseml3VWpIWk1NaGk3ZlhXVnpqZEZueFFoaGNhWDQ5VnltNTZq?=
 =?utf-8?B?bHVUaWIzcTk2VHNOWGhZZ1ZzdHRzZ3ZaQjFnNWgxRmtGQkk1MDVBRVFFTGh4?=
 =?utf-8?B?U21xODZ0OWZIZ2o5bzZFV1lTK0JVUlhOUWUybnpGSHBvMU9oV1p5SU14RXBy?=
 =?utf-8?B?YVoxYjBtUi9nd2dHakd0c3JHYzdkNGF3clFFSlJDRHF3VC8zaDRicHd1elM0?=
 =?utf-8?B?U3JUNFBOcCtqVTl6SnZMakZ0ZkEyckduUjVSbXUxN21CTFdYb1dQdXgrazhN?=
 =?utf-8?B?d3BHUmZ5SlVJYnFYS0RtY09OWGgrMit2cXdmMDNlZnppeVdvL2ZybDYvekpJ?=
 =?utf-8?B?TDZwamt3OSswdW5Dak8zQ3NMY3BTa3htanhydkU4RGJZVE51UlQ3OFdCUXJi?=
 =?utf-8?B?eG11eU8vZTBQMVRIWVdPck8zYXlieTNTa2VtbjY2ZS84WmNIbGVWM3dQaE4y?=
 =?utf-8?B?K3FOK2pubXUrM3NHWmFyT0U0ZkwyVXpOcmorc3IvMHhUY1d4VUxLQ3ZqQUIx?=
 =?utf-8?B?NWdndThwTm5ycDJuZ2dRcG8vcmcvRmFOZFZuRFd3eXgzcTByOGZLTGpSTnd5?=
 =?utf-8?B?MzZ0ZEdKSlNOWkttdmg3bVoxR0tJcU9saHNYSTlZZmlNa0Q5Tm9JTzVTM3RZ?=
 =?utf-8?B?WS9UajV3anVaMVdDYWI0MWNPeVozWWxFY1U5cDNmSUZPdllYQThXZW8vWlcr?=
 =?utf-8?B?ZTRPOE8xL0U0eGpOUTZBbVNJUkpiUDBsL2lQRFZpWVFiQUo1ZDJkNXVOV1Zm?=
 =?utf-8?B?YkVLNEhQOS83TXEvY2FDSGVIVVphU2t5bncxMnh6VFNWU0ZUbmVOMkhTZmJ1?=
 =?utf-8?B?RFg4WHBpZGthcWRYUGVTZVN2bWtxOXdIZlBXSklEK3phajYyY0E1L3pJNXc3?=
 =?utf-8?B?Z042L1pqWk9FMDdFNUQvakdjVVYvR3VzZzdJRW5ZaG9ycUYvcEdhMzZIUGpH?=
 =?utf-8?B?NVNNSnVGN2VjWkNqc1pSWTJjWngySmZ4U2ZNR0dKYUttM1ZqaHEwVUdOSlVB?=
 =?utf-8?B?Nmc0YU0xMzFKZW1oNmp4MjBWemhQbkl1VWVlaHVzR1ovc2t1SjZTZ2YzbERD?=
 =?utf-8?B?RVBTZnMzdHpvSUxpQVhVWlU1YmtVZ1kzU3dMYU80Q3hyTFNoYmFsWTZkeitt?=
 =?utf-8?B?anR6SVNlNlhMMXJ4ajBraDBJUXlUM0FtSFNkekRLNXU5anI4QWduMkhpeDI1?=
 =?utf-8?Q?kh4TzW4JKDkW0h2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab54b5e-74fc-457e-afaf-08dbaea6c1e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 06:59:04.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C0/47yZynkBeqvgZ1pf/1bdF+XuzJ5uFp3miJX540h18rb/ldrvuDdkadd/IpKes+23qJtlnMNb/EfKH4mz8+oBe8sAX9ABgFciRqi18gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060057
X-Proofpoint-ORIG-GUID: 9vFEksz4C-9x3fXGCSR0h111BEgf8AVb
X-Proofpoint-GUID: 9vFEksz4C-9x3fXGCSR0h111BEgf8AVb
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/6/23 06:27, Luiz Capitulino wrote:
[...]
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1fb7f562289d..2b7d74304606 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
>  static u16 have_release_callback __read_mostly;
>  static u16 have_canfork_callback __read_mostly;
>  
> +static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
> +
>  /* cgroup namespace for init task */
>  struct cgroup_namespace init_cgroup_ns = {
>  	.ns.count	= REFCOUNT_INIT(2),
> @@ -2243,9 +2245,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
>  	fc->user_ns = get_user_ns(ctx->ns->user_ns);
>  	fc->global = true;
>  
> -#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
> -	ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
> -#endif
> +	if (have_favordynmods)
> +		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
> +
>  	return 0;
>  }
>  
> @@ -6764,6 +6766,12 @@ static int __init enable_cgroup_debug(char *str)
>  }
>  __setup("cgroup_debug", enable_cgroup_debug);
>  
> +static int __init cgroup_favordynmods_setup(char *str)
> +{
> +	return (kstrtobool(str, &have_favordynmods) == 0);
> +}
> +__setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
> +
>  /**
>   * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
>   * @dentry: directory dentry of interest

Consider a case where the kernel is compiled with
CONFIG_CGROUP_FAVOR_DYNMODS=n and kernel command line is passed with
cgroup_favordynmods=true, this would set the have_favordynmods to true.
In cgroup_favordynmods_setup(), should it return 0 with a pr_warn(),
when CONFIG_CGROUP_FAVOR_DYNMODS=n in the above case, or is this
expected behavior?

-- 
Thanks,
Kamalesh
