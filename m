Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12D7B00A4
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjI0Jij (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjI0JiI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 05:38:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE937CE6;
        Wed, 27 Sep 2023 02:37:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9Nvru013740;
        Wed, 27 Sep 2023 09:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3pHtfVrhyrYpVz7Uyzia9+xv6RJqcy7V3pjeyHE8YOo=;
 b=3s+oCdd44aaWrpJrMbcCPf1qkKsN+nWZ/ZXHJs+CIzWki8hxl03UKydXrTk6X+frgVBK
 dWvGrEVFwa05x3FSXYggPmsrn8sQG5eAP83FYgsad8SHnURix4lhS6XI97fFIQh2I7Hm
 2kVGyh5w0QAX4IpEKXacMXKzyzmtxEJYdZ3sfC7IOshu9Dr5dC3KYfxyLIlqy7O/HEua
 LHNwSxOCx5Fb43cR3tl3EkWluHlEcBfIZ4We+66hFLp8iY9BqmQIQPZwpEd11YPjn4J5
 ztV9XB5Yhgd3B54U2mU+kHOvtqnK00S13VJ1eKt10r9Dx1SzfWF9tX15o/nqy2ABK1TR pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuh2f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 09:37:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38R8Uiie040138;
        Wed, 27 Sep 2023 09:37:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf7few8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 09:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEhle3gzCu7Yh0r8frBR/q7t3TSc7r2U3BkK9jrpg3+Xzi49asvkCYFGVe1VrKlgmNS+00ZqkjtHt5p2z4C/DDU/joXLJpAbrdEHv+IeaJksFNhbZNM6HTf+EJQysRQdybfHe2DXh041yclOYLi00HL+2bor9pmwBMlbOzqrpiuOBzq5JdzASyA9llDW0uvbwSvLE1km8RcmcQ75/xJVqRFPZeSyJM8R1xqIiF0I+FtX26sHrOdE3Aj1b8v2v3Q7a4HHtLd5GOZqsPr+4H9oz+LfaTqq7Pg5NHOG9yVGIvlAqmzeNs7EMCMcXeCDTeP9dDt1ErjVRkUvIAxxhZNWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pHtfVrhyrYpVz7Uyzia9+xv6RJqcy7V3pjeyHE8YOo=;
 b=XwQEM2cO49G6omBIMRagIdS9N5ab4wE25/TIkq8TxillXQRZnjINr4DGgt5Ql2ZElU9uWjeCKWFGNGE3L7jvm4nuAGkGUemKsUfGzss3lEtm26qaCnSas2812pFIMx4EXXTE7WOUd5TXrlWvtJyjxScusTQWSDEvexCa31y2XgABXoMIGcVdsWVMPbN44jz7DwJTTxCQW3EJzrw8zhAwzCR8OosxmPqLDFsyAj7kvCSp6IsHpJAubpVHSUeWg2N6FuHqENDt0Hmc5GDyaJhnVU9pyVvdSil1u9A2ZFTMNMRn8Se+hZ3xPyANfGH4T8g1kUgNPXj3DPcYxJ99Z+nBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pHtfVrhyrYpVz7Uyzia9+xv6RJqcy7V3pjeyHE8YOo=;
 b=PUbTVdQmSZ25Eezg9NQwr8qmv7X0aKtIuQbskSBRk3jbY8WTa1YLe7uCA51pSiXz5F4nn3cqfrg+Bvhgekj+idX3w44rakWKhx+qikjtzIR+BE03ueWqbJr9qoAZGhABP7MM/vIfQfvR3SkF9BUl7HB2vxaqni+YkDH+uQlJLok=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 09:37:15 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 09:37:15 +0000
Message-ID: <aceadbf1-0345-2b7d-4468-c7c42ac15e03@oracle.com>
Date:   Wed, 27 Sep 2023 15:07:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH next] cgroup/cpuset: Cleanup signedness issue in
 cpu_exclusive_check()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
References: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::31) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fab2e67-d46d-4da1-05ff-08dbbf3d5448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uzYKsFvojZ/9eIXfK9p4wTIiDGydgTLrGaoUwmQ1/9KEZ3LhuGa4kdDyHxs3F/s4y5pj1a4WMGztudH8rdulkJHQ9YcN6CnnoNKbtOkGqz2gO4nbfOn1iFuyFdjprKsiRRLRYAoBYVZnxDbpmdyVoYSp2738F++j1oYs3DbKDCX5VpIMhEmCyRjrPW3c9vsU3Z2GlMHcm2PflXH8QV3rAJLbqeDUiw3jMGWrvkmingFtN/pd7FehsFqRUPAjz5ImdPPuBSL+xHvcGajatVa7Pyu6V80MdaRjrpbCrm10P0MeUK2bUO1rD8cLUJxcVdE8h3RxJUUI7DHuSQpAmoVPjYU6LNsZIoyaxaFDqtwm8MdUeRM/LwxRSNavroQWSFcBnRm2aCoN9znd7gxprI/5f638QQpHvuRRDc5kzsJOlE26sYb8lME2maM8Q21AqBZ0ucn1NIAn5+Pf2Perp2m1hZZzzyQrnskrZBds1on5R6uSRAVTWHf7ozMTy3PxN16SDprm/aJLz9heZ5cvUAYQw7zHWjFOxKCD5dTLO8bjRqLlo4kKeckg/bRbHpb0SjqZbxeQChtEI2h4ClkLD1K3M1UTEGmHXLLMXN5/g/r7Y5Ptsp+f4FZ1+MX43PsysjEz5L1KR2ElN8Z/Y0r07AGxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799009)(31686004)(316002)(66476007)(66556008)(110136005)(66946007)(7416002)(8676002)(6512007)(4326008)(8936002)(2906002)(41300700001)(44832011)(478600001)(26005)(6666004)(6486002)(6506007)(83380400001)(38100700002)(5660300002)(53546011)(2616005)(36756003)(966005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZ6ZTRIVUtCQWUrS0pJV2haODV6eG5USzZmTmtwdHZVM2k3WmtRbWc4Y2E0?=
 =?utf-8?B?V1IvclVYTldGTmFKRU8rM21QYzVCUVk3cVBtbTZhZnI1M2JSM016QnVmenlV?=
 =?utf-8?B?Q3JyZW5RaG5ISU04K09HemlxTk5aRHhWa1dUMXpkRHlEYlhkSUp6djZNUG5l?=
 =?utf-8?B?SCtiY2FBRUdOTXVDV0FaMzZ4Smw3SHdQemo4bXM4elJwNnZ5dHFMaGY2RUJ1?=
 =?utf-8?B?QzRuNVBuVFp3QzZPdmlHN09Gck4yeUdRdzVKSnI1Y0xJVVFNTXlTc2VYNWgr?=
 =?utf-8?B?ZVVRek1QN0wrT2xWZzRwR0pyZjIyYTdaa2NkbEd1eFkrQTd3Nm9ySDVVOGxa?=
 =?utf-8?B?aW01MllEWDVEMndwVlFQcE1tM3pVVUQ5MDMwVFFJd0lWaVg3V3dJZWhNY1g4?=
 =?utf-8?B?aml1LzJ1ZGpUaDZMbXlsN2duazVvMGp6QmRhSUE4V05TM21VNzREaTl0THlQ?=
 =?utf-8?B?VVkrODlNZmpRdDIvZEFSVCtSZTNwUm93d0xVeHBGbk9BaldvT3lydlM5LzFM?=
 =?utf-8?B?bFF2aGVsTmhYdnFzR3BOVU1HS3FjcVRUcS9yemRoajg2ckhjdW1RMlpqUEho?=
 =?utf-8?B?T245a05PS3Zhb21ISUV2RVY0azBDb1RSMndISGl5ZGpFL0lINGp4bitINUZz?=
 =?utf-8?B?ZzRRWnVOZ2hmOCt5VTFpSVVQQXl1UkJvMzNzVWhRYjRhSWg3ZHV2MUVSWDNi?=
 =?utf-8?B?Q3F0cU0zdDdoQVJPV1hVS21MZnZ5NyszV0hsYXBWa1BqUk9CV2VOaklGRytZ?=
 =?utf-8?B?MkR2aWpCdFpxd1N4U0JsYzlCTC9BSEtJY3kwZ05HRHNRNnNldmgwZlRsSmVu?=
 =?utf-8?B?SWVQRXZVYlhyc0RHUkJtSUxoMTZDVG1sZ2JQR3lDZUkwRWNiNXNrZ3h2OER6?=
 =?utf-8?B?dVRWT1FUWGFsVmV3NFloSUl4Vk0xMktWc0Z3UG01NFdzQWMwMVlYQ01sQzcz?=
 =?utf-8?B?QkQvYWpLZm85S0RzU3RGaFI3K2RKTVlUQS9Jd3dyQ0gxbTgvSzFOclRCQklE?=
 =?utf-8?B?dC9EQWd1bGdnak40bGtIdDZQUzA0UktCbCtjck1iWWp0QXE4TlVvT3NWNk40?=
 =?utf-8?B?QmdNa01jT0dvRkdmM3hVb09pZVJvRUlDL0NPQ1pDSnRqcE1XNy91N24yWCsx?=
 =?utf-8?B?bENUdnI0QWxpdFBwakpBRWpGcE1pNVVuMkszMklTYUcwMEphbHlTcUh2dXhP?=
 =?utf-8?B?REM4NWptZmhFTDgxblFSRmNqemhWbGQrTWNKY214a2ppUDl6cGphZ3Fmb1E0?=
 =?utf-8?B?SG0xQWxpVkdaVDF1M29MclFnZ2JiYSt2Wmg2dFBmT2dvbFdvKzBUcm5TaHgv?=
 =?utf-8?B?Tm1vOUlDM0xpWVdXMFp0a1dzTjlKWDZHZlhJSm1EQ3picG1KMlBpMXVzQklO?=
 =?utf-8?B?MG1pQVVuUW11MXorcVdmMTlxY1oydk5vY25wQ0JHMEJoQ2hoZ3FoS2RxcjBQ?=
 =?utf-8?B?YkVaT1B4SldNZ0NxL3F2VyttT05UTWoxdWp1ZHlCVUs3VldnL0FLcXlqZ3pp?=
 =?utf-8?B?MFFWZWhpTmZaNU5wYzJOLy8yd0xCeXYrTnVuVktBMzRnNjd0LzBzVlpyNUVl?=
 =?utf-8?B?TngvT2x4dG9mczAvQ0VnaDBtTFpIWFpYOEt2Uk9GUGIxQ2NRUVc0bkY1WXVk?=
 =?utf-8?B?Wm5ZOTEzRFhUUXpaUkd3NDdqQVJvNlVGSFZZckIzVzJaSWFJbGIzT3VZeVhW?=
 =?utf-8?B?YWpXN09JaWw3a0R4SVJDeXRzQytuL1Bjd0x4bXh6Q3pDSVZZZFB2WGRkZ2NP?=
 =?utf-8?B?bXZFOUFFZDVuTW1WNjN6T0wzVkZxM2VSVWdFeHVjbDRKRFJlV09wK05iOE8r?=
 =?utf-8?B?SU1sZkl5TDFKdDJwcWRzN3paamJlaXkySk0wSGFJL2xoMDVEMnVQVWJLdkdh?=
 =?utf-8?B?NmZGcHJSS0Y0dXBkU0tPblZ3VWlub0gwcUwzclRVMm9aMUh2L3UwSUJUVDlI?=
 =?utf-8?B?MnpRSmZWYXhyMUNRcm50c3VZTnNuNEttVkYwUXMvcVJaem5YaEZ1M2tuVGtF?=
 =?utf-8?B?ZHBGZW42amc0SS9NZlJlaitnSW8rdjNYam5rTTZSNGNBWU5LcnlvWGwvb0cw?=
 =?utf-8?B?cWIySGNKSEhRamdTL2RQNk1IUGlaZCtDVUwyZmRHbHcyaVllYTBLWis5RW8w?=
 =?utf-8?B?eUMwTmY3ZHk4R3pyT1VEcXJWNE9ybmtqcnN5TFc5d1JRTHRTTHpCT2xpdFB0?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c1cxa0o0dnlZakc4WXAxS01NQVVVN1prM0JDa1N2U01scmw5L3ExT2cvODFt?=
 =?utf-8?B?NkNKRWdleXk3QVVodGh4ckhlSjFFQzVmNHp0cHRMekFoMEVzMzA0K281MDRq?=
 =?utf-8?B?aHhEbUF3MEloOUg1bHgxN01FcFlCN3I3Z3JwZ3F2bm8rTC85bXVuYXdJbmE1?=
 =?utf-8?B?YTgyTGNCNGpFWkxxWjBrSkVkZlpORExicDZmQytEMDFxZVBhMHRFOGltTzF4?=
 =?utf-8?B?ZGY3UHdDSC94QmJQaVo2Zi9vSUJIZTNORDJubkhkNkhRemhPK3hlRkNxakt3?=
 =?utf-8?B?bmJQSU9IbEl0cEhVVkgwdzVraVhqQUNVTFYwNVFKSkJyWkM5VzlCM05GTUFS?=
 =?utf-8?B?MFdEdjN0S3RpQ2dlUmlXdm0rTjZnK1pZQkZzU0ZUbHY4SmxjemtFbkd1MGxK?=
 =?utf-8?B?VVVKZlVUVTlacm5XZzl5RjBsMVZtVHJSdTV1cnRMQ29lck0vZU53byswSGl0?=
 =?utf-8?B?Q2V6UXhGT29kSENDZ3BUeC93bEJHWFpIQmpSZ0htWWpwYzM1bytOWTZNMm9G?=
 =?utf-8?B?bkM3dHUzN2g0VTV0MGhWRnVGN3F4NCtZdzBBdDBNUFdBeVpBWnhZNzQxRk12?=
 =?utf-8?B?RSt4L0x1L1BVRTN5WXFyU2NYUGZlR1NQT3NHRzN3R3E4VDR5RHFkL3FKM3lZ?=
 =?utf-8?B?elMvR0hGa1Y4SXUrWENvR2hxSnZaZ1RSWFBuM2VrVklFeHpmV0tud3kvQ1VY?=
 =?utf-8?B?djUwZ0R1UnhGRjhuc1dkUmZaUDMydytjZ2lxSEh5V0R4ODNFaGZOUVpXSnAx?=
 =?utf-8?B?blhBWHJQWmZFSW1HbHVtMnhZTStFSkJrUzdXNU1BOXB2ckxNd2dkZm55SXpl?=
 =?utf-8?B?MThCRjFxckF5SG5mWXJiWjNpTVlESXBhZHdrVXE5em5LZjJROTRaMEgzWUFP?=
 =?utf-8?B?UWxYSC9ONWhLaHFKenZLWjRxTmtkQXJsdU5NOVJrdUhhR2pCdWVlNis3Nkgy?=
 =?utf-8?B?TnRnU3hHKzBJYlhRRDdpd0dRRFk3NG9TNFlPV3IraHlDSE5kUWtvYXdneDdu?=
 =?utf-8?B?VkRTajUzWDZtbVBvN0Y3eXZFY1lza2RQS0FDakoraEJRYmhFOWNuZVRBZDhl?=
 =?utf-8?B?ZmtRK2h1WVFDWW0rS3lkZVRGcDZUN0c5VFFjZDFDTHV4cWhPb2xVU3QwRXFZ?=
 =?utf-8?B?UHdmVnBkVUlvVjZTT2NRS24raWZWV3JEcXVLcEhWa1BDcTVyOFoyZUkzcS8z?=
 =?utf-8?B?M0lPVlk1TVJUczcwdlBlZGlOTzRwdDkzZ3RyTkZyeE5kWWF5STAzcUJmaG1K?=
 =?utf-8?B?ZmZVcW9LRzBic25Ec1RkRU01SFozQnlad1AxdzZ0OWc1ZVAxUzIrdkZqQ2Jr?=
 =?utf-8?Q?SwaIso6H22INo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fab2e67-d46d-4da1-05ff-08dbbf3d5448
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:37:13.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IogUuNzPdC2ojllJ2rwcp/foCuGReM8Da6+YRU2jPHMAQkZAhEQls6tM/0gsNdQcAGqva9tp+Qbqd9x+5N/X0a7me29C4zgXro585vhwj+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_04,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270078
X-Proofpoint-GUID: offEK1AqN4ciYNhVdZj7S1dKOXxakYTH
X-Proofpoint-ORIG-GUID: offEK1AqN4ciYNhVdZj7S1dKOXxakYTH
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/27/23 12:28, Harshit Mogalapalli wrote:
> Smatch complains about returning negative error codes from a type
> bool function.
> 
> kernel/cgroup/cpuset.c:705 cpu_exclusive_check() warn:
> 	signedness bug returning '(-22)'
> 
> The code works correctly, but it is confusing.  The current behavior is
> that cpu_exclusive_check() returns true if it's *NOT* exclusive.  Rename
> it to cpusets_are_exclusive() and reverse the returns so it returns true
> if it is exclusive and false if it's not.  Update both callers as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202309201706.2LhKdM6o-lkp@intel.com/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

The patch looks good to me, returning true on exclusive cpusets is more
intuitive. Renaming cpu_exclusive_check() to is_cpuset_exclusive() is
one other option, though, there is is_cpu_exclusive() function, which
sounds similar, and tests for the cpu exclusive bit in a given cpuset's
flag.

I don't have a strong opinion between the original function name and
the proposed rename.

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

> ---
> This is based on sattic analysis, only compile tested
> ---
>  kernel/cgroup/cpuset.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 15f399153a2e..afefddd33c3e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -719,18 +719,18 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
>  }
>  
>  /*
> - * cpu_exclusive_check() - check if two cpusets are exclusive
> + * cpusets_are_exclusive() - check if two cpusets are exclusive
>   *
> - * Return 0 if exclusive, -EINVAL if not
> + * Return true if exclusive, false if not
>   */
> -static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
> +static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>  {
>  	struct cpumask *xcpus1 = fetch_xcpus(cs1);
>  	struct cpumask *xcpus2 = fetch_xcpus(cs2);
>  
>  	if (cpumask_intersects(xcpus1, xcpus2))
> -		return -EINVAL;
> -	return 0;
> +		return false;
> +	return true;
>  }
>  
>  /*
> @@ -833,7 +833,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  	cpuset_for_each_child(c, css, par) {
>  		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
>  		    c != cur) {
> -			if (cpu_exclusive_check(trial, c))
> +			if (!cpusets_are_exclusive(trial, c))
>  				goto out;
>  		}
>  		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
> @@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			cpuset_for_each_child(child, css, parent) {
>  				if (child == cs)
>  					continue;
> -				if (cpu_exclusive_check(cs, child)) {
> +				if (!cpusets_are_exclusive(cs, child)) {
>  					exclusive = false;
>  					break;
>  				}

-- 
Thanks,
Kamalesh
