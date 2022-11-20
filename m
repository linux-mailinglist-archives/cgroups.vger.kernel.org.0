Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3BE631530
	for <lists+cgroups@lfdr.de>; Sun, 20 Nov 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiKTQj2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Nov 2022 11:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTQj1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Nov 2022 11:39:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D107B1FF8D;
        Sun, 20 Nov 2022 08:39:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKFOEKU028077;
        Sun, 20 Nov 2022 16:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BwPMjvgEKJvf5iL/jRJ8hetzGrMpHPjuJ1RcuDoeJvg=;
 b=FXEkXI9mAmHjxlturQUELOjDAmimbCBIfiIHvgRDODA05HrI1d7i3iyxStvAw9duFJkn
 vfRRQCTVsXv5fJQA2ZPhyBGKyqDyw7q1IrWOKGLsABRGSWmlR3LgLCvRT+c9Zw4COJQs
 Ur0423mN/zYe8EfL2+hLwjtNlpU1UH3Mr9M3bsTuDz7rBEScGffGSlG9XEjBl0N1scM/
 pVypb7K1vsZqt1/Jl21DEf4w120Ew6TEGNe2yayQmDddq4UjjqIXvPIp/8550AZVveBr
 /qGS5rlxWURM/5O7B2GtzMTT2HLRCRyIAUJnJagDUNB1+8tKdcwhLUAvaH9zUm37pv6I vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57hwqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Nov 2022 16:39:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AKDH01t031381;
        Sun, 20 Nov 2022 16:39:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk30ykh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Nov 2022 16:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayzYTuabR/UxtWKlHo6WogE+6HpuB7qK8REv6ze032GjWk/4Dv8VHEmHnjdQwA1obVwnxYpbAZsaxhRy6ZiSVQN4scE/U+auMxJd/VuDDg9FkhIgJIfbgpPwp+9cVX0uiIioaQM9WtmVHL/IdoJp14XUKIZMlTWYyaBhv/OzPeEaXHUpKJxNbOzyKayK46YEJVCzf/x4sAJcVPsGMyMrzrH+5vW3sH3R/IPowDhMaROWHdOHF7ywJiTk1MrOLjF1vwIq/3H0slwYCNq9/kfq7oWKKHUQjEoKwt0G+UKWVq850mK1ve1x0LQywP1iOvBIai1ghuVexd4tRROoB/LHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwPMjvgEKJvf5iL/jRJ8hetzGrMpHPjuJ1RcuDoeJvg=;
 b=NEqkg/RNkcHuPkHFPkRPxEc7ddfYGLQoC7sHiYwnLAk9HkqTKma4ElGkj+zKlXMk8mHzN7+ct4d7twuLsD6P0arlbns5hhDUIiql8DL+YdCvECwcQAvrwOux4OktTrYP3lx59DM7Dvko2AVuzh9Q7mWW87keeBuz6dtXH5qWrKTrJh+6rJjnPgatQnFsPZC1fNyKvc6WdSZXxTixod/0kzp6/az+9WGJYelL8V7r3zIyziL5GdZFsXT0AyiRykwbErLqia3HOIhYBSu3NfDqMVMC9egIuMDv9f4aD6sYE4zolGClgMOfOjbzde2cOJt9E8bhzyyBtzEdeMqGynCCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPMjvgEKJvf5iL/jRJ8hetzGrMpHPjuJ1RcuDoeJvg=;
 b=0TDvinETzLHq7vG+XxN9wtGP4HN65Br3bWdGyXHXbwr04jtK3F/GdotxD6XVoIRTKzIF10J8farF6YaZJZSWibrdhEx5rlyGLq/0J9a4XGOFN7KS/dbbMQhmFHXhd5ruGF4WxcnpCRDKC/fZyUQXQM9VrF34bEcoqcd5Xmz16Ok=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 16:39:08 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::de:34cb:7d98:c34e]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::de:34cb:7d98:c34e%7]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 16:39:08 +0000
Message-ID: <819bdb10-2569-b7b1-b75b-168b77d1959f@oracle.com>
Date:   Sun, 20 Nov 2022 22:08:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: Fix typo in comment
Content-Language: en-US
To:     "haifeng.xu" <haifeng.xu@shopee.com>, tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221120155134.57193-1-haifeng.xu@shopee.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20221120155134.57193-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|PH7PR10MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b91b50-235e-4297-480f-08dacb15bebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrJ5IIK1i+Dn7gouEkfnG+GA8/zpaargqnVdsLwO+TL0MWJRirUdKugDij8p/oINp8tQMde7hsAqDESWwMY7BGz89EyV0iHwI86uh2PheOmwIKWkvLCznkpJcy+YtYM3hI54ageEBfwd74NV4ecdJJfHBjKh/CVf5stJhO2FVK48yhWiSmgYPNXrwMD6+BfJwIninuHbT81KMcHHqokmVPZPVhwhVhOI4Rh2qNhW3KmxmQGQZXbp3U6O4vafvuO2woui+JsEy0jmSJzZXtUv0qc4ItSvru8JpT6o4zu/7fd86zDGptZLhELQc1vE1Zay61K+DDRow0C1sNeWsO9+p9UWPCBg/SEKMu7yCqNkrRA05wzUQfUdY19Hcn5V8nMwQcmvvn/jeVsSP4yBKACb9MKXjBUrvdd2Rc3URB2bZ18oGjCgLBsBnjd0wZlChH6OOld8D7HtyUPHerm8AM6UPToPTEU6iriLYOGEN8EjpluCF6ILUDv2YKfGsTFlvqiNLRTPsCXu58tR81oUuT9854Ngl3S/r1sF/9UToRh277hgXAvHEfstayXy+lVf02UV0KPAubI7p58B+45CNL02nvXguYCVIzB4dbCMet/JiAdNC54yeU+iKMdk+pQ2tN05jTXzCcPb3RgZoK1GsR3eBqzda9ZAh2H989GZaR4UfA4kQKWBkEt7u3Z6A63v/tqy4FaijKtR6MjLUAZMF7zR63Pbj12EjtA1MlFzwrgPUDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(83380400001)(26005)(6512007)(186003)(2616005)(86362001)(31696002)(38100700002)(4744005)(2906002)(44832011)(41300700001)(4326008)(5660300002)(8936002)(8676002)(66476007)(6506007)(316002)(478600001)(66946007)(66556008)(53546011)(6666004)(6486002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJCY0NxZ3loWjBFdkRhN0pCM2U4YUJaOXM1Z0d1VUtVaElOTnFJVTBnTGVB?=
 =?utf-8?B?N0RQYWtyTUFxazZuNU1zMTgxVGo4S3JsQ0MrRW5TYTlVbXNTelU1eFMyNWZJ?=
 =?utf-8?B?c2lWMXJ3WTRXZS9QRGhBRTRMR3N6bnQybkFQRTdLQWhCM1JRTkh6UlRPcW9v?=
 =?utf-8?B?Q292d2VxR2g3UFlqMTdteEExOUFuNFUyMksyaFdUYXI1Ym9BaG5yd29aakli?=
 =?utf-8?B?LzlkSFRvTzgyYUJIbzRjNnl4aGV2V2V6TTQ5L09SWFJiZWxVcXZQM1hTcUxk?=
 =?utf-8?B?NWhQcStabCtGRURxcEU3NUIvS2gvMVBadjE5RGpSS2VrSFVkY3RTNWFwUU9N?=
 =?utf-8?B?MXM0K29NTFI2MzhsRGFPZ3NLckZDMkZTNHNGcWYxMjBSaW9oZjQ0K0R0MG9q?=
 =?utf-8?B?S0d4RW4rL1dMc29BeE9LRzQzaTBWSkRqWFJpclV4U29jNXNyTllXK00zaERz?=
 =?utf-8?B?a3drbW9DdlpNWEtUQkVnd0lTcFJWVC9tT0dZVWVUbmp5SzE5c0d1WlJzTjlr?=
 =?utf-8?B?cVRwWGM0KzM5S014SCtnWlplcmtIYkQxaGhPS04rYWpZTGYyeHVMUmVEREVU?=
 =?utf-8?B?Nk5hL1ZXc0MxNVB0MWNXdTFvN0dZcFpaOWVnYUVUaVZZTkZXNjljMEtlTE1K?=
 =?utf-8?B?SXQyb0crTlVkd0hZWlpPT3R6SFIxakRpbXRjdmNyMkpEeUJjUzM2NXh1dzhU?=
 =?utf-8?B?SDdja2tMNzNORTJpNVZkUjN1RFpHSzhjM1lCeURkY1lJWXg3dDFNQnNDZkJS?=
 =?utf-8?B?MzErUmxaclAzRzBlTURuUHl2QzkvYnExT0FOZEovY2gxVmxXNnpnSUpFRm1l?=
 =?utf-8?B?SFlOUGJLTXFpSDZDeWtsUmxIdkxieWF3YU8rSjlQekxENmQ4WUhrY01JOVhS?=
 =?utf-8?B?ZzhNSEw0VW1RYTJQUENaV3ZKdXkyTnZjTU9xVXUrWm41L3ZVM3ZZODNadHl1?=
 =?utf-8?B?WDRzRk0zdEN6SDdRNkdxMVZlOXR4ckc5Nk9GRkM4bk5GYjRYWHZyTlJLSTJL?=
 =?utf-8?B?QzRubGRYcW1sSHEyWmlOOVZVRUJYNFBUQXNkQUJrbUVlanZQa2FHT3pLZGkx?=
 =?utf-8?B?MG4vZVlXR0hlak9jem8yTmRjanFIR1BFWlNQWFlybk55MjcvTnlrbytWY2tZ?=
 =?utf-8?B?ZlhFMDMra0NvbzVueksrZjdydWV0YXgwV2JSY2k5eTJURDdnUElQRjNtaUNp?=
 =?utf-8?B?djlCaFp4eUNnS1Z2a0tZc0FETUxvamNjRjRTT2UrTTJENzFlU1I0b290NmlT?=
 =?utf-8?B?eVhscFIrUFlSWm9DcDNhekJyTWd1Y1Nub0dXVGhsYy9Fcm9NNGgzTUwvTGJV?=
 =?utf-8?B?SDZmeVFwUHl5RFlDcWtHTklpU2tmYnhpa1ZQRnE3L3VyV2haY1NLYkI3bHAv?=
 =?utf-8?B?U0QwOFUzQlRiZHlPcXVQNHlMTllhd1U5N3pCWnJRRlNUNnFZc0k0K0o4YkY2?=
 =?utf-8?B?REE0T0NVNEgvY2UyUFh6M3RadnN2RlhLK3c3SkMzUDNqdllUZ3BCQkJyQXlu?=
 =?utf-8?B?bnBFWnhYNlMzUGZ3SGJQVyt1RGpkSnRGUkJaTDdlb3l5c0pGc2pUSUc2OURJ?=
 =?utf-8?B?SU0wTUJzam9LZlY4UFhzYzZvQW01Sm8rMDkwU3doQWpndEJyOWhTTS9EUlhy?=
 =?utf-8?B?d292a2JHVHN6K1YwS2ZXWG1wUk5qcGJjVitIbEVDMUlpa1U0WDhJUC9ZUFNH?=
 =?utf-8?B?em5PQ2pIUG1HMmtyN1NOdnY0bjBRdjI0NFZBUVpQV1NVR0FrRStCRXlCQWtY?=
 =?utf-8?B?SzA4S0wvTnNEZzB5eS8wRUx6TFlwRDZtSnhnM25lRU9vcjhFa0Q0MGFvOEdQ?=
 =?utf-8?B?eWY2emZmWUFaRFZNZGZpSnl1cDFudGFpYWk4TEJmNGkrV25BdmFpRTlyeGZO?=
 =?utf-8?B?ZTgwTEtWY0hJallHek1DdklqMkFna2gvUmZaaU9xRVdZVEdnbXZFVk1SMDVT?=
 =?utf-8?B?cEppbko3MHFLS05pbThiSytIUkFCUU5RbDBhV0FvbUlVZ28vU2VkTHRIUm80?=
 =?utf-8?B?M3lnTGwzL0VwTGRpUk5BVVJ0ZDJ3c1NkUEJHYjFBVGZ3Zkd4NHVlREQ0V3py?=
 =?utf-8?B?enl2YW04Si9Nb25NcUF0ZGpTMHRqcmE1RlFYNzJwcGlsMVlzUzZHYUdwSlNP?=
 =?utf-8?B?QlIwanBJc2N4U0t5NFp1N0xNQkVaSktSMlkxSGVGOXpJNWsrMmpaWFhiZnYz?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWdLOWJUbm94cVM2YWN0NmJNK1V1SEFiWWQwY1JIazdwY3BCNVZhbnR5U0ZD?=
 =?utf-8?B?OVRjWlBHZmo4b3pJckpaeTd2WUtFK3c3NExGbzVxYklLR2lGdGQzWERXUWlH?=
 =?utf-8?B?NkxBYXA2UzIzTG5WamZFN2QwcHd5TDB4bldNYlk1NUZ0MVJ1UGxwWDdCWHg4?=
 =?utf-8?B?NDJwbWhHS1VCd0NwZm12dkhERm0zVnVaRU1FR2I2ZytkWkdhejdQNW1wN3Ny?=
 =?utf-8?B?MGtpUDhqS3lNYWhKWWp3SHFNaHhHNWV2ekNZTTVTdlZVWTdPMWc5THVkYitp?=
 =?utf-8?B?a0R1cHQvZWZ0VXhQOU1rMHdpRG02T3hrdC9MblNXQkZWNk5ic2gzVW5aWFpU?=
 =?utf-8?B?M3F6TEp4ZC9BdXlpZVFRY3BPTzdmV0hzYUw5SnJXWVMvckQ0dzN0bVY3N0U0?=
 =?utf-8?B?d0VRMHhCWndoRXZseGtJc1NxaVR1MDRvc3g5c2s1ZDNFa3g0VFFVZFVDc0ZP?=
 =?utf-8?B?dUtwemp3V0U3Q21NSVYwSTltN3VMMC9VMGxKU2ZnN2NQeGhmaUZ4a3psTnZz?=
 =?utf-8?B?T0N4M0hiOXBNMTFibW9HSG9ndHgyS0NTRWhjUE9Eb2Uzeks2L0ltOTJ2cmJR?=
 =?utf-8?B?Y29jRldFS0tEeGU4SG9xMVJtTEdwN1VOd2JYSUM4YnJNTllWbDFMWGgwRjNj?=
 =?utf-8?B?cVlTWklTb3FqakZSOHUwN0NYc2JFNm4zb1oxUHlUT08wMnU4elJpLzhrbFRr?=
 =?utf-8?B?M2VRc0NEUkZ3L0xUUTZsSEttcEpCQUtENHZYVTFkY3Y2YkUyNWt1Z3hacVhw?=
 =?utf-8?B?UitJVDdGMDErWVlSeDhXeGpIOHA3ZTIrcDVaTFJseFg1eFZIVG1lUHUvaHV4?=
 =?utf-8?B?dENrQnU1NVUrTXRmQStnQSsxZU9Wd242TmRVcEZPUVJGSldHYVhIRVJmeTNm?=
 =?utf-8?B?TzJZd3JpY2VveGt2aHpJWlhyQzB3MmNVNGVieDM2dytRREhBRWwwdHR1Mnp1?=
 =?utf-8?B?d01aSDhwTW1oUm0vemo2cUdVL2NoYjhaZGFUMFRCMGR5Y2h4VGR0NGxMbUEy?=
 =?utf-8?B?OTBjOFU0b1l0bkpodGRYb1hETU96blBPT2hvbmF5WWdVbGxYWEFEdG1RczZI?=
 =?utf-8?B?SEcwRm9SZFVCQ251N0FEa0xOSkhvVHlMTnE1Tyt6K2xFYmJxOUNYcE4zeTBH?=
 =?utf-8?B?K044aGg3RWw4aFc4YmZyc1JwMjBVUXRpT200S0JiRFhPenB6QkxNQ2xjbm1a?=
 =?utf-8?B?dW8yUFZmZGtkcmxrZzZ2dG1ZSERkaUlEd012dEk3R3M5bDdtZEwxdHFTU0ND?=
 =?utf-8?Q?NmvW77Rc6MThhz+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b91b50-235e-4297-480f-08dacb15bebe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 16:39:08.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkUxXy8BPNIV25P/GgJoRt4fLnHSFtr3VkZptZWCT5YfnX6GrgXXZl7T+KxkJNj5P877+lSJEYmKuB1C70jqAZi6adWtAC6J0AHFWDkvwXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=911 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211200142
X-Proofpoint-ORIG-GUID: vrAa9MIcrRDxcNbtFb_4C4SbYLnUW6bD
X-Proofpoint-GUID: vrAa9MIcrRDxcNbtFb_4C4SbYLnUW6bD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 11/20/22 21:21, haifeng.xu wrote:
> Replace iff with if.
> 
> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> ---
>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index f2743a476190..93c5e50b1392 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -814,7 +814,7 @@ static bool css_set_populated(struct css_set *cset)
>   * One of the css_sets associated with @cgrp is either getting its first
>   * task or losing the last.  Update @cgrp->nr_populated_* accordingly.  The
>   * count is propagated towards root so that a given cgroup's
> - * nr_populated_children is zero iff none of its descendants contain any
> + * nr_populated_children is zero if none of its descendants contain any
>   * tasks.
>   *
>   * @cgrp's interface file "cgroup.populated" is zero if both

iff abbreviates to if and only if and it's a valid usage.

-- 
Thanks,
Kamalesh
