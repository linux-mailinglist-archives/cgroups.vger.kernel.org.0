Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9927B027B
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjI0LLd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjI0LL2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 07:11:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778CF194;
        Wed, 27 Sep 2023 04:11:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9Nv5N013740;
        Wed, 27 Sep 2023 11:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kiqCtFt1hCiuLydu12sCuA67PlG5HhCiVogQ9plk4vw=;
 b=etM6i+qPEoteLm5kIwnxHwvj6nWp/BMuTALEte0pUmiYtqLnw0Zm0GqNDq2QyRdnNAr9
 OIMA64ueOsQXlQ282ymT1acXPo3SOd1OhXLwJAY+O0UulkA0dC7VEakkwZCxtp9qd3p3
 nUKxstLfqxcqBXNss2ZIB67JTw1QIPf7uH2aFOO6YCH5hzs+Qfsba5qvTu400jBegfNr
 54zom5uuZaYcQMZB9/xi8dRpvhg6Yi71RQy3J+OF6SenNEDvAOkS2fK3LpHwf+8ytQSk
 /8c006qdxJpR3LMdjTmnzMZqR+rMKF5E5phlG0tteArgXfc0n/3q7ATOcYL0pa16yOee 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuh8be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 11:11:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RA0vb1030842;
        Wed, 27 Sep 2023 11:11:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfdq252-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 11:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvpwcRmWWbuhUh8CsmnDAB7xVAs6Hftbd5qwEEHO2xTZ5LMf9eM0Gue8at09yziPfQsN8/EQG7Hvuj44ot1hDB/ND2wh8pui9XP3+GAg1NHaexwueDb3NQHA2CTbttkw33uzqwqpVA5xF3FM7aBHKN97iozSjOMtaojosilT6lYPxv2SRYNQ4uTMO3pCAIOsQgs3LHf8UsXjM9impEYh8pc+LZLfczeV8ADPs/qM29pTk3GiSb4Wiquefsyr5C/ARIPxGhVmdXtk5OLnDUHCh45uNKV0+3J5lvSvxRUajpmX0BBQhJdal6sWGJpn/x3jUY1hgIahimLjm6QiJdlnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiqCtFt1hCiuLydu12sCuA67PlG5HhCiVogQ9plk4vw=;
 b=e7d9FWnPpD/CBglWo/sdIIyWaYTAXLaFOrbKux3/Tvw2W8Ca/ZaT649/xSINPwMSlmxXwxnkNC6JzZqxvqXwy3kDUEjPINWxpm+1+f/BJ0rdf0gQKihR8jsUBvsH1vIwYhib6PYMJzVDYEnfAnGIk8PGo6uUXpvigrYqWmQ45ME6TQFMm5KBRhUT8MbECyx15rG3wIJ+EuyYqty0eZGyg5CUPqY6jAFxnRef6XbaJsgt4jz6W8zbLTk5iEdwG0adUCI2Ucf1+6VJGDZpjCLmHA5GO0ZkpYC6Jjx0etDX0IFQXlTtaR4hqllAB60o8ENm9b+hJxpy8DOhGuE5rSXYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiqCtFt1hCiuLydu12sCuA67PlG5HhCiVogQ9plk4vw=;
 b=RPsuFjPNwvLdesu3hXmSN0F6MYWwoXxJn8U1VGXbG00QHIfsnRQcCLxnXq03d94OskiZHHnwzkwPSdBNhSx/ybd0fPhXUOihi4z4Mo4joX8sk6rueKmCupigi5qE2BjDWLWx6PLeC0K53OfYNaISRKhXCnn10RtkAWXbXdqQFUw=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 11:11:03 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 11:11:03 +0000
Message-ID: <c77e132a-da4b-a6e3-38d4-7ce00916eb28@oracle.com>
Date:   Wed, 27 Sep 2023 16:40:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [External] : [PATH v3] cgroup: add cgroup_favordynmods=
 command-line option
Content-Language: en-US
To:     Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, mkoutny@suse.com
Cc:     lcapitulino@gmail.com
References: <20230926211617.42746-1-luizcap@amazon.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20230926211617.42746-1-luizcap@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b375f5-c9da-4994-55df-08dbbf4a6ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNIIXqEvozsBlqQ/AxHR1BqFb5lxEO1MxYsxzLm4hLQiDosE5pQlwrmQIfzLStHh9QqdgPyW43dphCy3cdy++aca7h9PoxJZTHSwJ9ctIJdED3IOGkS4zr9SDx7u+ogSKF+hPhDxamPp6Iq9goyM0ecngbCy6cXRBzSGMZwWtZeiIi+8V1gJMsfhRLclo/Up1ZrlUUssKrD7Q5rtX8v4wPhuwGZoM27YKHK7ROeQDvAEKJW34TeY2vi1AItw5KQ2r0i5dN92dnhIiSU9PRZyrp6kycIupWU2jjUvLXGlJ2H3eyrcA8VUDFAMWTYwAUcxxD1Ibc0lP0iaj9SQBEkcWOIOYZ+QRwLEHWnI5ED7LBngecBqvYYHyCECAf8Xe7KZZwEENiNvS1l48N3HeS/guA+E7sXqCSWe+1FJ6iPKZZRSc3sNAx3NUDW0tbHArNKj19DdO0O3fOuyM820lQEw8zMgiK80UEJbUQ0bhgqCyzcoDuvH+uLTdVbaWJm46q2rZgx3vxQwlVMKuQDqzOoKAsGcnywJZpJQX7OQbzGj+OauqCdY9RzTui3HKKlmhTQk1Az78pNrdrUvoNnaeHHfP/zbWzyWurz/1upu7JtN8zzdSZ0ceEjJf+KrLbxSRlZaD48DiPz6mkJsFOe1m92wnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(6666004)(478600001)(36756003)(26005)(2616005)(6486002)(86362001)(83380400001)(31696002)(38100700002)(5660300002)(53546011)(6506007)(6512007)(66476007)(66946007)(316002)(2906002)(4744005)(31686004)(66556008)(4326008)(41300700001)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3FxakJpUlZ6OWtobVYzZjBPcjNiRU0vejhXRGVQZm42bTJYTXJneUttVnJW?=
 =?utf-8?B?NjB4c0p0UVd6bCtpR1JSM2xqZ0p3aE50YkhnUEZEeUUzcXNvcEZWS09Gd25Y?=
 =?utf-8?B?WkJqNVhFV0c0UVJ0K0JobjY5NWpMY3NPRGtqRDdPRjFWa0psMDkyZDB1UGhs?=
 =?utf-8?B?bE1UWVJFdUNVVi9KektxUDVwT0pNQWRUWjNZRUlpVVJCZlEza2V2VXdTeEpF?=
 =?utf-8?B?S29Obzd6d1paVXRFdDVZdUFiOUxZYkR1OFpNQVR3OXpTNGw5YzUwaXpVTmN1?=
 =?utf-8?B?b0ZiZWJYSEtPRlBmdGxveStDTVpRakxidE9ELy9QK0VCd2JudDBOU3Z4MTFZ?=
 =?utf-8?B?bjB5bnMxOExoRE95UGJtazRBNVhUWG42RkJYbTI0MlJza2RuQjFqMS9zaWpv?=
 =?utf-8?B?MGVzNms0bTRXVHdwZGF1aDBTbDd4MFNLZGw5RnBUV0k2L3R0d2cwc3ZpUmhZ?=
 =?utf-8?B?TnoyMjBkTFBnZ25JMlpHdUNmdE52THlOb2htc2c3bWdwTWV5cXhUNUdLSG1R?=
 =?utf-8?B?dzBVenQrbVVkWDFoT1BNUzBhM1NIaFJxTHBVUmdzc3I0Y2xCQjlFTStIckxJ?=
 =?utf-8?B?YXZrSU9kTHV5aTBmL09wa2tVYTUwYkgvRFh1Tm5adTZySXphZkRuRFhZTkIx?=
 =?utf-8?B?alo3b0g3a0I3SjUyZEh3L2gzd1o3TnNyTXRkVWRmQU44YUVTMERWelN0NVZU?=
 =?utf-8?B?eUlvYUpzV3ZOR21QTHhVRmMxQ0szcGR0OVhwUjBJeXNaSGQ3ZlhxTE56clVw?=
 =?utf-8?B?VmM0NnE2KzI3Y2tXNE1JZGVUeUlWVHNiTzNyV1VqREdpbUhoQWlsMjFJbkVp?=
 =?utf-8?B?QzdNVmRuUThxMGdvanFCaTlneEYvOGgxbUp4NStNdDNBdWowS1B2MnpuT3JU?=
 =?utf-8?B?NmtOVkhhQTlRSGhiQ2V3aFlmaDR5VXJuUit4a1F3ZlY0dXNRSjVQTTNPeFhj?=
 =?utf-8?B?L2lEQW1qaEpoRmo4VThzWStSUDRRbFRsU2RwTS9RVmFqMUJZM2RQOTNwc1lS?=
 =?utf-8?B?Q21qTXNrenFIV1JKeklLcjF0SzJ6WUpDbXhqTmFjVUNxV1dhOTVhY2ZmRnFh?=
 =?utf-8?B?NDZla0FxQUpJNE9wcUNnYXFlc2N5Zk9QWDRvOEx4aDlSWnR2Sk9MKzJjZXhr?=
 =?utf-8?B?RitZUEppZmMxMTVVZVUvZmUzQ2d1bkxIMDZkSlIvQUg5SXV6UFc4U1I2UHlU?=
 =?utf-8?B?bEtWMVN4dktDajllYW5qd2dtalRmUWYyOHVPc2hYbGhuY1lMZCtFVEdMdEdh?=
 =?utf-8?B?bUlwdGtabGZjNjhaYnZ6S0tGMDY5OGpPNVNuTzREcXlpdU1WcjR4bnczWFZF?=
 =?utf-8?B?Nk16aHpOc3BUZ2RENkExRU1wNmpRbWhmRVJJSzdsczcwZHJjV2lYcVdzakFj?=
 =?utf-8?B?dFFuT1QrKzVQMXBodE9FZ28rV0p1aFdzYVppOWFPRnhRbGNTZkY2WFNVREZR?=
 =?utf-8?B?V0UrTGtsSE45TkUvUEFiWnErSUtNR2I3RDRLcHZ1RkNzMzZlWFVJcEU1M3pm?=
 =?utf-8?B?UFQ4bVo3TXlLNFNLVUVLMmljbm9JQWNIVXplcm5JZWNLNWFNdWdJVFg0MThG?=
 =?utf-8?B?YS83THlQWFpRRUk3V2NFYm92QXVOZmNqemtYVDhmZjg0d1BnN3grTDZ0b0ho?=
 =?utf-8?B?b1h1OEdLNEh6TXN1OFdmb3lIbHkvTm1xTnQ4dmNKZE1BM0c4OW8vbGJMSU1N?=
 =?utf-8?B?QXNUcjZxdHJJN0ZnN3pmK1lOUm82UlVZdTdJVEFzUnBkOWVpdjhSSVd5YitK?=
 =?utf-8?B?TmQ2UzVBZXhIUytyOVNzVlRxNVNtT0dCUlEvd29uVVB1MVdCUnNRckRmMEFX?=
 =?utf-8?B?VjZDZXYyODZIakNyMWRZUEl6SWRvMWtVdUlob0VKYVFLWE9pSmY5S2x1Y2Ji?=
 =?utf-8?B?OEF4T01nNTlLVVFxMExxOUxGcHRJakF1L0pTVVVLU0ZNK3paUGdXTDE5U0Yr?=
 =?utf-8?B?a0FDT2E3c3pMVnYrQkpXODRYaS9FVk1JL3VHclVUTXZmY1diVlhOZzZ4SmdB?=
 =?utf-8?B?RVJRYnVhS0pJZzBoN3pKcElkTWtaNE41WmZERERJVVFFaGZqMXFnRkJmTTRu?=
 =?utf-8?B?K2YveUFuZlJDNkFaRVU3VXY3WjNUMVJPMHEwWDFCcE9CTCtSNUxRZVphN2dF?=
 =?utf-8?B?Q3Ewc3AzYUNGcFFoTGNVUFRuMUJCUEN6OFZ4em1FUGVMN29zQVFDa1dWWGsv?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dlJqUlc1aVZ6ajV1UWNkQlVCc1c5SGZ0Smx5eERkWWR1a2pieFR6OGNGeS9u?=
 =?utf-8?B?QWtMSEtSd3hoQWNvOW1lSmkvamRWWm1hRUs1czRzK0FxRHlmaTJna1R6dlIw?=
 =?utf-8?B?cEZ4QzdQRWU4KzUwc1U1b2VtaUY1THFXOUx0cndhS1pxNWt5ODZBdldyMXdz?=
 =?utf-8?B?WGdwU2hPcjJFZ0lKN1dCd21DSUs4OXV5Ri84eGYzMmREUmV5cStwblBpTWhk?=
 =?utf-8?B?MWg2TUxxUy9HckpWVE50T3dvWFQvL1NScTk2Q3o3YXJMWGtoZG1tc3crcWF6?=
 =?utf-8?B?SFJqRk83YWxOd3Y5NkUyY1hpV2RtTU80U1RNY0NQL0g4YU9XT3NUWXhYemkr?=
 =?utf-8?B?Q1AvVnkvSmZjQVZuY2t4bHllcE44V25BdmYxdDZWRU9yZGI3NjFxYmh6eXJQ?=
 =?utf-8?B?TWd3K2dTcnVSdFoxVytSeWNYWHo3eHZmSkxoZS9IU24rT0ErMlJ0ZDdQbkQ5?=
 =?utf-8?B?ZllFNUwzNHFlTXphRG9WZGxqRGRFRmZibE16UkhhdmM0SXEvd3Z1M3dkSVcv?=
 =?utf-8?B?NFZVaVNlVGlNTEJnWDd5Myt1RmRlaXNJL0Y1Z2dZKzlNakxLaFFqbXNVNGVT?=
 =?utf-8?B?aXhoQVFjcTdSSklMZG0xcUxWS0UzZHB2TGorS2RiSHJKc3o1VTcrV1Qzc0Fh?=
 =?utf-8?B?L2NTczJlMmlZLzRhWWxha040RGY3RmR2MTR3NTVDTUhvQlJJQ2pqQkZkN1Zh?=
 =?utf-8?B?WXhRV2JLaFBpcUlxUzgyVVMyaVRVTm5Vd2hFYW5NQVAyZEdJNWlZNHpHZGtw?=
 =?utf-8?B?VUZQenpYbW92Sk11SXNRK1REbTZMTUpSdVZ5OHNpYTZiSDlXQXpVaXhidGJz?=
 =?utf-8?B?Q0dkVWF5cUhoYk5rRHhidEtBalU3V3N0Q0FlZ3ZhR3BjS1c5MEg5ODJXRkdu?=
 =?utf-8?B?ZnhjNU9IbVVJQUFVaXQ4ZTZMd0M5ZWh5S3VKbEp3RlJNYVlOY2IwVDhSTCt1?=
 =?utf-8?B?KzlKMVJtbDdubGZMS0JrbDhRdmk0OXVmUTNqZnRBYkxwdjBadjVTdFN4SUMy?=
 =?utf-8?B?ZEdDdjNKdFZuOC95ZmN6dGtpZFkxcmRJSVFTRnRUQk1XSFNrbUZlWlhIYlJV?=
 =?utf-8?B?amZKd3htOHJ5NkpaNlhVSFh3allERWpoVmtZWWVQVDNtYWsvdzhPQ2NaMElB?=
 =?utf-8?B?RTg4TlpPSXhXb3dmOVNiNzBFYmp1YTRJZEsrMmVjRVZ3L2dzUm9YMlRaT2h3?=
 =?utf-8?B?UEVoVDNYUTlnbUdxY1RqTUxONWdYL25QWk1MQTc1WkVMUXVlanh1VWhQY3lM?=
 =?utf-8?B?T3RyazliSDhMYkJwNkh3empGdU1HM2dXR1lIb0ZDZUs0bnRPdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b375f5-c9da-4994-55df-08dbbf4a6ed5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 11:11:01.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CSq6Kpo+sMql/8+FI1xx2X+n8/0bOTQdnIGRvmL1JZFkzPtTo7gYZw4JEZvVMlgBPEixZIVUW98o6kFOBtj494KoEkiRcBFaXGYNDOkLT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270093
X-Proofpoint-GUID: FP5_GHCyzudER52fRncKkFPdUiEswMdV
X-Proofpoint-ORIG-GUID: FP5_GHCyzudER52fRncKkFPdUiEswMdV
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 9/27/23 02:46, Luiz Capitulino wrote:
> We have a need of using favordynmods with cgroup v1, which doesn't support
> changing mount flags during remount. Enabling CONFIG_CGROUP_FAVOR_DYNMODS at
> build-time is not an option because we want to be able to selectively
> enable it for certain systems.
> 
> This commit addresses this by introducing the cgroup_favordynmods=
> command-line option. This option works for both cgroup v1 and v2 and also
> allows for disabling favorynmods when the kernel built with
> CONFIG_CGROUP_FAVOR_DYNMODS=y.
> 
> Also, note that when cgroup_favordynmods=true favordynmods is never
> disabled in cgroup_destroy_root().
> 
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>

The patch looks good to me, I have also boot tested it with combinations of
CONFIG_CGROUP_FAVOR_DYNMODS={y, n}, while passing the kernel parameter
cgroup_favordynmods={true, false} to the command line and works as expected.

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
