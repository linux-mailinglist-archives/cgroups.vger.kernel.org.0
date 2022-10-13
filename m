Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE25FD512
	for <lists+cgroups@lfdr.de>; Thu, 13 Oct 2022 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJMGog (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Oct 2022 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMGof (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Oct 2022 02:44:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3E0DCAC4;
        Wed, 12 Oct 2022 23:44:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D6bBEE003902;
        Thu, 13 Oct 2022 06:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b85Bu+3p4+PkQd29v4zkvox2djnPtcsaA5vvIwcI/F4=;
 b=JRFHQXVSKVi25aJXOdqCaHLsWS3jl6WsjIcYGixBHDHch2zgYiRMPaHAcBCt8JJRY9Vs
 8953Rr/q1gci+pG1MfDJWiehxOF5tAp2/327oQtf9rZS5CA5r+tDdOPglgY+SBpnYFVK
 RcfVOXPPz17EcchZey/ztJko3HGCBeQwNvhvSmjntgXksTiTD9fefi868Bn+fllgO6ZE
 tq2oKEUGc6E3P15mnf4x+k5yGVMOfq9GJRckrQqzpKXz7PussFfnPYXZF3HViMccInd3
 aW03rjdOK9XhAend8Gg3kvpOsvIsV6k9U2YVQraHnd80e5bby04hN+8ucso4FGzHV03D Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6a6989hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 06:44:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29D5uKnF008591;
        Thu, 13 Oct 2022 06:44:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn5jtg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 06:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKjk7wPG7jr5AVOvKr2WVjlrFsFZYObQ/JWHvq9WcsBOl+o5iuKfvMU7FAkPa4k4pcDSBYlbpm1p6cq9S7CZiB1l7PyfeNnWSnDNEWGxNOyBpPDG6rbDTDL97QxA1VJueHjIylDnQEQT4RPhOn/zQ+4fXOaCQ1fYHIc0TA5bFyOz8AKzqAL5aFsVs/xOThWz2rAqdAgfAqroRC1AyIbOQcKs0b6amwCBlFUJF28lmfk2oIrUoQZapEea7SDB5sgH9CbhYyla/N5ZETFNGNBeiudv3IROEM1z28cqblzG5yWVp2ViiyPuJbzh/FRewHrs3dENqp7YwtwgI/HGBysICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b85Bu+3p4+PkQd29v4zkvox2djnPtcsaA5vvIwcI/F4=;
 b=iLTLI7B1d81IabgDGfwFj9X0MOA9G2bVz6Gdzn3fc/7oXUoEeZMoJ6zW2Da+3ZBVkzAhSEJQgPKITF9dI2HgkLys4ueLPX53comCOyfFBZdEtbxJvDK1k0ZlJ9sh7wqAPfvUh7w9GgInl81wm6oH0T7rHz7gwlq1ypTFLtBtVFVSHJz1nLGL5VMit8McEn7c6dAbIrXooNejOPy5Zob+6i6BOfP/46ddRkHuOccHbqFhprE5npUCUmlJQ6XERb8Pj1dhARh3eJJrTvcc48v3Slqv+9gBAZ3d77mahyjyxAvtIJP/2YuuNDWqw2Pwa/GTP4n7lD1tPLcrp7IhDgjTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b85Bu+3p4+PkQd29v4zkvox2djnPtcsaA5vvIwcI/F4=;
 b=JQyFymcuUuFe/ggTl8wS9Cbs3zPurKMOygBqpjHIqHfmpXISY8tXZ54aJ+WPv2LVlDFTpI1lq+LpI5eTZHorqHBNCGqR8DQaOz0s1HHIBbS7iZhGL1OIXmDHIgsMUXCa1v5dzKGi706sXIVMKU7Gs1b2r2iv4R92+FwIDEMWStE=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 BN0PR10MB5047.namprd10.prod.outlook.com (2603:10b6:408:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 06:44:19 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::f476:f40c:e762:48fd]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::f476:f40c:e762:48fd%6]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 06:44:19 +0000
Message-ID: <4ed23d48-6c83-d703-57a4-24cf9cc34eb9@oracle.com>
Date:   Thu, 13 Oct 2022 12:14:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: memcontrol: use mem_cgroup_is_root() helper
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
 <YzqWJ8D1rabeZ6TL@dhcp22.suse.cz>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <YzqWJ8D1rabeZ6TL@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|BN0PR10MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e24e05-8b98-4484-be14-08daace65ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNyYqZlih6xY7V3+iEfdWbKjaSQP2M+l0rt2+JNcbhWmMlAia1BTpXBbvMsIAuUzHjvK5aFPe54W5Dv54eeYcRjIfojKfASH4xUAqgfaH0flTcXpcKY9lX8s2QAJmbmZriZ4+ZEux+Cm0GsVL8qeb1yZZfT3JBXDx67/EH8BmE/CBff4FurEKqy1cpis/vciTrCHNe9z6rym+0cOdQ4HU1jdDN86X8LBSylX8Q/uFjimWI8/N4+GeuyEsJ4J0DeWo63ARJ/1IFXsY4qStm1k9rtN/by+WhN4Xe6z4atCSBfecAHvbPG3WbC1KZLBAahHpv6599W+Oe6UkgjOEKSDqQwiDM6CrAnrEa/SK/xG98X76XpO5GePO96oz3AUPh93OmUcQwwPDYAgT4tgZ3o0e8erH6xJg4L8OVPdBlp+0ZQIKc9AYm8lfta1jGopDdWWHlUd5oQPwhhLFhlftdzUdijlh69c4q4ISI154Z6LDvJhWkKNB65g1MDkJWzjqyGl2X4GIuEY1H3rw8t95kWJcTMLrYFYCob+cS/PLJo1M98Tu+ZW8Z6ulJS2QJN+JEpLLOObvDwyI61+cFePHisYVAGzlT3nK9Pxplo/L9C6AphvzSldGFt4hWokzP4dz0RLBBDzGuHGcjPIJXbi8xyCzw77bkWffLMI3dHRK/yil0QoLwvTImzUw2fXrkmyUpDdEraD/IHZ4Yv3XKHyB8oZNUXq5IWt5Mn9mTPehlBCBqPZD3risB+n88KMiKZgbmcv27OmtfOQBvZZoYASzes/STcHVDLzTOG/ovuxmWfRjoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(86362001)(31696002)(36756003)(53546011)(6506007)(38100700002)(6666004)(4326008)(41300700001)(26005)(44832011)(5660300002)(66476007)(8936002)(478600001)(6512007)(54906003)(6486002)(6916009)(66556008)(66946007)(316002)(8676002)(2616005)(2906002)(186003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZSSmRzRld2aUY5WEVjMkdzQW53eHJRSlV2dEsrRXJuaVJGaEtZNjF2enVv?=
 =?utf-8?B?dE1pMllMNW5oVmd0aDZna1BiTFlpdDdCbUJaZE5YRUdGNnA2R3JKTXR0UGM4?=
 =?utf-8?B?ZXFFQjNENDVpQzhwVmcySkZBS1NSekRZU1g3ZDdGYk96Y21WRnJzSVQ4Z3VP?=
 =?utf-8?B?OVVLbXV6QXhibHIwTHVRQ1REYVVneXRwYy9PRzM5alM3Z2NJVERXdDVLVXFF?=
 =?utf-8?B?N0ZySU81cXg3eGsrbUc1b2pRekFYd0J4MjVDbFcwQTBTOE1tckl3QXp3Tld1?=
 =?utf-8?B?UlkrSG42YzhGRzlZdnF5b0RsaG4vVUM2Uk9qSXROTDQrT040ZzZTZXBNdDZq?=
 =?utf-8?B?TlNRcTJPbnZTSmFIeUZhZEc3OGVCdnpwQzMwVW4yRWo2WlQ0QzU5cUhqMC9p?=
 =?utf-8?B?L01jQ1JoZlFvMXhtTE1mYnNrRDBPeDdTUGVSemh0dG9JSGNDNC9VVnFxNjZq?=
 =?utf-8?B?SW9LRDhFNXRKQUhHOVlrL2ZrQnFWRUFLSlhYbGNmZU5SOVRqbEtCRGFJYlh1?=
 =?utf-8?B?ZjZjU2x2SFhBOWtqNWpTVHo1V3JraTltL0s1VkZQMG5BOFVXNHdUQUJva1B4?=
 =?utf-8?B?NFRBSjY4OWZRUkpqTDVxTEQyLzJ5SUFHMGQrUVljaDlQOXhNQVpsWEw2Wldv?=
 =?utf-8?B?c253TjdoUWZRcFY1WXJodTkrYzZHTFpIdnc2bWY5UE1ieDR4cXNCVzNucGph?=
 =?utf-8?B?RjJhUEs5RW1DeVhzOC9iUHNucUxFY0pMSU1mZlNWT1hrUEt2bWNyYUhLWk9D?=
 =?utf-8?B?RkVqN2o1YmxOWlhqNlFjaUJ4dC93TXJlM1pTSXBtUEpqOXdmSldsWVhRRFZm?=
 =?utf-8?B?YXQwYk1qbXJZOVV4WHY1S2tFYjhLTzNNVSt3eWd2RzR3VlRUWlM2YlZYeDFN?=
 =?utf-8?B?cjBpR2ZDWkNjekZFWFgzK0VaRWdNRzh6SmhiR041VWE1WWN5WGYyK29LTzNy?=
 =?utf-8?B?TVJzeTYwTnFLQi9zTStDYzJXTGt0SXBvWmJpUVhFU1d2UWwzUE5WK2tsY3dx?=
 =?utf-8?B?dytBdlJhTnJreFJkK0JGbGVVMlU1RGlpYk51VkVTNWNTbk9JTGNkam9tVStM?=
 =?utf-8?B?eVlCbTB5b2d3MTg2TlRmSkZZMmpSdWtieUJWV1RtQVo4ZllROW43QkJaVFJ3?=
 =?utf-8?B?M21XUTA5dVN0RG5EK09rME54S29QT1p6eEJ1akVHS1Vyb2VGSVFScXZHbHd0?=
 =?utf-8?B?UFJoUy9aZVhNMjE5ZXM0QTc2czZYcVA4RGMyRDlmZ3hiamxyMmgva256M0pm?=
 =?utf-8?B?N2tEWXE3djFvOFJPQVRRWWJpVTlmYTVDdWZpYzN3L3QyMmtXVGY5K0FuUXM1?=
 =?utf-8?B?QzVQZlZ4NXBVL3FYeHdHc3VoNC9TaWdRWnZVQnJWMkdzZWdLTHlTRysyeWJR?=
 =?utf-8?B?SDBqUkNMbytYUFJRT09YOEo4aCtKRm9oU0Zad0FqSlZ3bkE1bU9ycjUyT3Bn?=
 =?utf-8?B?Rzk1Wk15WU1IdmVFTHJMQmlzdHVGZDFzTWN4bXpJSEVhWllueUZ2QWJobElY?=
 =?utf-8?B?N0FjQjdWNDl3ZUdUSHR1cTRNUnI4YlpvenVpc0VqWmhqSEZBWWJFZStiY0tP?=
 =?utf-8?B?L0R5VUE1cFZXYWdFUjFBeDJQcE56NU50QzIyZ09ySjRxa1hZWFpDcHlUekRB?=
 =?utf-8?B?UzVIOUk2bEtldUZMNWlFV3ZqbEU0M09yRTVDdStaWXlhVGtqTVlUSkduVFll?=
 =?utf-8?B?aGpBVGc3SlVNY0tJb0JndVNUSjl3dkkveDVWV3Vtb3dMTEx5NUsxNXJsZlJs?=
 =?utf-8?B?N1VvYnF3WVV2d0dab0xpU2hpQzQ0enl1WU0xZDVraUhPOFRBRU1TaEhkSzd4?=
 =?utf-8?B?ZHM4bGVTNlhEQ2hjQ0E5dW1zRG1KcHQ3TDlzSkl5aHR2U2ZYVlp2NFpva09P?=
 =?utf-8?B?R0xRcTcvTnRHT0pubW0weFNUU0ZDanRaeUlzc2s0OUU3NHNyV3o3WFNGTnlr?=
 =?utf-8?B?SGxpbllON1VnSWpzbDVLT2V0SWIwS21uQXI1Ui9paC9XRFdSUmdSazhDY3FT?=
 =?utf-8?B?dkhGek5FT0cxaEdzMjJNMVRKeFNGVXBzUCtQY1MyNG5seUtGc2IxRlVnUGJL?=
 =?utf-8?B?MlA1S2d2ZThOb2d3Q0lGbEZXcnEyWVpzSUVoWHU5QmQzYzEwRkV0WDdNeW9u?=
 =?utf-8?B?SkVtb1Z1TXA0aGVXQVFsODVBVzc0MWc1enczMGg1OFNNTmFQUTlUblZVazBY?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e24e05-8b98-4484-be14-08daace65ae5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 06:44:19.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxxTKB6ZNT1KdM4g8nqOrwOMhRMKt6QFzRjEXE1DH63M5PdqerTfELFdXSRp9iJ5XY3DV2Di8N6LOesy/ou5Uy/mqU+CQ3xcz/cYIsI9zzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210130040
X-Proofpoint-ORIG-GUID: 6BmFKXcnKt6VkCWBN4m2aa4BGr_-nx2w
X-Proofpoint-GUID: 6BmFKXcnKt6VkCWBN4m2aa4BGr_-nx2w
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+cc: Andrew Morton
Sorry, had missed akpm in the original patch.

On 10/3/22 13:28, Michal Hocko wrote:
> On Fri 30-09-22 19:14:33, Kamalesh Babulal wrote:
>> Replace the checks for memcg is root memcg, with mem_cgroup_is_root()
>> helper.
>>
>> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
> 

Michal Hocko/Muchun Song,

Thank you so much for the review.

>> ---
>>  mm/memcontrol.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b69979c9ced5..99b3d0cbd426 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1148,7 +1148,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>>  	 * cgroup root (root_mem_cgroup). So we have to handle
>>  	 * dead_memcg from cgroup root separately.
>>  	 */
>> -	if (last != root_mem_cgroup)
>> +	if (!mem_cgroup_is_root(last))
>>  		__invalidate_reclaim_iterators(root_mem_cgroup,
>>  						dead_memcg);
>>  }
>> @@ -1172,7 +1172,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>>  	struct mem_cgroup *iter;
>>  	int ret = 0;
>>  
>> -	BUG_ON(memcg == root_mem_cgroup);
>> +	BUG_ON(mem_cgroup_is_root(memcg));
>>  
>>  	for_each_mem_cgroup_tree(iter, memcg) {
>>  		struct css_task_iter it;
>> @@ -1201,7 +1201,7 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>>  	memcg = folio_memcg(folio);
>>  
>>  	if (!memcg)
>> -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
>> +		VM_BUG_ON_FOLIO(!mem_cgroup_is_root(lruvec_memcg(lruvec)), folio);
>>  	else
>>  		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
>>  }
>> @@ -1982,7 +1982,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>>  	rcu_read_lock();
>>  
>>  	memcg = mem_cgroup_from_task(victim);
>> -	if (memcg == root_mem_cgroup)
>> +	if (mem_cgroup_is_root(memcg))
>>  		goto out;
>>  
>>  	/*
>> @@ -2940,7 +2940,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>>  {
>>  	struct obj_cgroup *objcg = NULL;
>>  
>> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
>> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>>  		objcg = rcu_dereference(memcg->objcg);
>>  		if (objcg && obj_cgroup_tryget(objcg))
>>  			break;
>> @@ -7073,7 +7073,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>>  
>>  	rcu_read_lock();
>>  	memcg = mem_cgroup_from_task(current);
>> -	if (memcg == root_mem_cgroup)
>> +	if (mem_cgroup_is_root(memcg))
>>  		goto out;
>>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
>>  		goto out;
>> @@ -7208,7 +7208,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>>  		 * The root cgroup cannot be destroyed, so it's refcount must
>>  		 * always be >= 1.
>>  		 */
>> -		if (WARN_ON_ONCE(memcg == root_mem_cgroup)) {
>> +		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
>>  			VM_BUG_ON(1);
>>  			break;
>>  		}
>> @@ -7369,7 +7369,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>  
>>  	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>  		return nr_swap_pages;
>> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
>> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
>>  		nr_swap_pages = min_t(long, nr_swap_pages,
>>  				      READ_ONCE(memcg->swap.max) -
>>  				      page_counter_read(&memcg->swap));
>> @@ -7391,7 +7391,7 @@ bool mem_cgroup_swap_full(struct page *page)
>>  	if (!memcg)
>>  		return false;
>>  
>> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
>> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>>  		unsigned long usage = page_counter_read(&memcg->swap);
>>  
>>  		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
>> @@ -7556,7 +7556,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>>  		return true;
>>  
>>  	original_memcg = get_mem_cgroup_from_objcg(objcg);
>> -	for (memcg = original_memcg; memcg != root_mem_cgroup;
>> +	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
>>  	     memcg = parent_mem_cgroup(memcg)) {
>>  		unsigned long max = READ_ONCE(memcg->zswap_max);
>>  		unsigned long pages;
>>
>> base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
>> -- 
>> 2.34.3
> 

-- 
Thanks,
Kamalesh
