Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EF62C2CD
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKPPll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Nov 2022 10:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKPPlN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Nov 2022 10:41:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E425A;
        Wed, 16 Nov 2022 07:41:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGF4Gwn024086;
        Wed, 16 Nov 2022 15:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rcAS/O7Cn4IuxKQIDgOTAD7UU2V1WYPHUwLpYvzLOzE=;
 b=YqaTpGu9XONh5LxE/PmpBOZ475UlDEuQzZQrNUZaWHxmA59PGvzaC8LBXQ8wPHpayjJV
 QDvm0AtqQTHDmqSkWoFF8eceylpq0npBrw431s4eNOKSwLv5M0pZN/uF4TJu5YtTneNY
 w05sVvAAxaRW/w2+qqgBNF0nooB5RWxSTfIUXjcl5zyh8jncdkdzW37eqBk9sSOCHnHk
 7CUWhSGqZxJXWFfiv03mJdmmVLB5aCAY28RmcobDqZPk4jCYANUgFBIrU0iZaBAgatr4
 sWtU+a9QxVUG3AETc8pJHpA/uQNNZlKXemGvWtqZvukPuP8OIxOM7PEZCCAovxd8l2o4 xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns5cdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:41:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGFV2cd012429;
        Wed, 16 Nov 2022 15:41:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xdvttn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jro6ABrVtci0SBxuSErscpFClSx40a8bBuTOOAV1f11v9Uj3DjpSRhsYF89eULa13SDcwsPdXp8nt5FepviLh3nogq2gkW0AECCbDRJ5mhUP0omNj10Wz5ZB7JmWqLKZCANoGGFSJXivDrwM3wkGQjnMWrMAS/52w8Xj+QoLcDB+3VdqAGcm0mlCFzAturLTy00nbYvrKHjf1xHRT1dxi+LOqEJadH9IhReniOJTFK+ym3hpsXawWoLk4e/SeZgEQKaYm8fOAylAvbaQ2nICzWJfhBKfbWR3Vf66ovzJPMbp2HpMJyieryZ4PjHtE+C3cpECJ3T043pA5+B/33eRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcAS/O7Cn4IuxKQIDgOTAD7UU2V1WYPHUwLpYvzLOzE=;
 b=ILRmQlniKIpMTBjtHyRlTUKQ9+80I40Ai6AQCQH2FU+hC+PtM8LV8OTmvMaP+O9NirAS9xGtd9W690KPRe4B/a5gluVLfpBaWAkQNr3cOJcGYMO40FSX+8daIVLq/RfxawaK2biy1IM3rPD96lq8G0oc50ygm0468rU6CMJHlfoVfh81tTCp5M9MLdbmrsaHXJCaeNKMVoo3IzRpuTAs3SFjR1vIgh0VrfJKPrtXh3yEx5wSM7cLnVuDs9jObm0TeSfQW48sTtwa9FILRh6O/7eTMNdFTi7po5OpFR2HIB2D70yjUHAUMfTqwHsQzPLukv6xArj7+hf28tqRseaISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcAS/O7Cn4IuxKQIDgOTAD7UU2V1WYPHUwLpYvzLOzE=;
 b=gJ7yuFd/YTifg6RwULgdj41mNNqI3uckT7QvixmdLWWC0zkxnurHi7VKpwmjbb4oxbi0v/rHynR9JAdCm+QGprxW4cIo7rq75mU8g/tU+J6h9u9IVniDF9Rbsx3Lc737fOXwFQy1N5moqYI5pnG4Kwj1G8gTBWtV+oqLFr3VY2U=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 15:40:59 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 15:40:58 +0000
Message-ID: <c1c5910c-8f5d-1eea-8bd7-7d79f5b5ee87@oracle.com>
Date:   Wed, 16 Nov 2022 21:10:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup/cpuset: Improve cpuset_css_alloc() description
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
References: <20221116054415.79157-1-kamalesh.babulal@oracle.com>
 <7eb8d6f9-b54c-aedc-982b-8ed2bddb948b@redhat.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <7eb8d6f9-b54c-aedc-982b-8ed2bddb948b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcbe5ad-0e41-42a0-9fdb-08dac7e8f4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y0Q/VNk5SI+DNUSujxRbc8QbMlwFyyz/oq4hBVITgyrtB2aHysKKZD9bL+XOHLmrYD+Q1yrFiJdMlQtqUFxOrPrU1IXJ4/PM0hArOsdv5gUDNbaSR7s5seMU7HEnwOhRRAQR2fw3KaatjRssijmqqBRVYgTk68BLF9ZrphqSap+JbzVEEPVdwrxZw4ZzCDLeK0eXwi4AVanIqFHRpjBpeKO07vPs1xng8fB2ac1DHq7vskPzdUQBrhFDpm2xY3YWg+cXVawohpKc1ZwRJJ7Z2qWBkODMMJ1Ded6R/sD2VWwzzWOm8nwEX+rMVYqKSk+02ET/zHRk2w6cMvdcRpIsqjauB/gKea8cddMvq+Lgcgwtglu0zL+7C9xCSS3YzIeoGB49XTKbx7HqrdgQEuWkUjC+zT7c2po/cbUv8XZ/7TAJfyl5dEWpX/JDC+Nd81rc6cmgJTM9rFDNH1AW5vZ+nTj/G36+15TOpKzHcCGeYiIYy7nsAyNBDDWLxjleVH4q5GDjbPvsmdYar8OAR30nP8c/ML0jdQu32Utvg0UvG+myj9malBUq6RnWAiKFdSppF7QW+WCj/jyAa9gxotHvXiJDLhKNFQ5MxP6KeoqXJpm08BTgYh+fEeSwDn3c2P1zjACGM89RuMfAyh3YLLVpNr5lCsmrd1Q+XB1ubVGkLFQwnGsLi8DYwzc6hlWwQ5Xv3Za7Wl5FjWFIut3aF9CI0M0w3pg3V5sHI76DMphUAtucH1SMH8VRstTFEgHm7+cGtsnT14uWGWiINCC9OnD56O6F1g3YggpDiiTDBDnqUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(6506007)(6666004)(6512007)(26005)(36756003)(186003)(86362001)(2616005)(41300700001)(66556008)(66946007)(66476007)(8676002)(53546011)(4326008)(31696002)(478600001)(6486002)(316002)(83380400001)(110136005)(2906002)(107886003)(38100700002)(5660300002)(31686004)(44832011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhxRm1kRzFFSE91c1lxU2xDN01jWEluMzZSOTd0TmtBSVkrMjZ3eUgwY2ls?=
 =?utf-8?B?ZTVTUWE5ZU10dm1EVEt6YnBXWkw0R21pbDdRcUE4elorQmFiWTFyZmhXMTZj?=
 =?utf-8?B?eUw4VEtWbnYwS1QrOGRobzhuK05ZaHIwcEZkaEhtY0dPdERaMHJXeFgwTkhZ?=
 =?utf-8?B?a3dDdlVJVStRbjlTVW8yTGJWQTVIR2sxVGliV3dVSjhiaXFaS1d6WlBSc1hS?=
 =?utf-8?B?aFY1WUZNRWRtYVhhTXZGV3FEWWhwNjQ2RFVKOHBRdVJDVUxKSFRJbW9sUERv?=
 =?utf-8?B?eW1lTEs3aTV4QWp2L3dTQTBzUytiQjdGVFBsbEU0eGdKamwvQmtCbUhmZHJG?=
 =?utf-8?B?aVNSTXU5Y0J6b1JVSys3SDJERnRwZWQ0dXpVVk5Pbk1JYlBkRkdINGd3ZHd2?=
 =?utf-8?B?VDhaWW8rOXpCNkN1L1d3b3VJQVdQdGxsQ0NSSWpWL3JTckNGOHZXcTY3bVFo?=
 =?utf-8?B?UXRXWExjYW1CQ0JsSnhDazF3eEd4czdyWXNKbFRBdDNMeDlyYjZtOFhCQnRE?=
 =?utf-8?B?eVcvb0JRQlZpaVQrTVNqR0FZMG1hNVNsR3JiR2ZBTEIra1U1TnZRRmp3N0dO?=
 =?utf-8?B?dUs2Szc3alpaOU14Y2FDak1EcW9uRTJBVVFJaHE4UWxqek5lZWlPVDB1MTNl?=
 =?utf-8?B?Z29PdFZzR2d0SnJkdFdRcVdURjV2OENLVzNyTk5xSmN0NjBVTFRUdE8zanNO?=
 =?utf-8?B?K0V6UStwclhhU091S0R0Q2lKMnBDSmJQQnRKTk8zV1N3Zjg1TmFFZkxKSnBj?=
 =?utf-8?B?Ykd6OGJkZHJneEczOWRyaFNjd1RaVlJLNmRub2VjWlVwcEJBR2ZyOHdCT1Vk?=
 =?utf-8?B?VVVLb3NLRE9BY3VyL0FKRC9CQk1tY09XY2ZNYTFDUDZSamliYXBFWkVPZ1NC?=
 =?utf-8?B?bzhXK08wbmM3ZGVxQ094Y3pkLzhJTUh6QTJPTElhVnlrWXYzNkwwZVpXSjRv?=
 =?utf-8?B?aVdwNzdZWXc1c2tBS2NlNC9uZkk2bE5WK0EreElZRnBZaE5pVUJtWjRTSXhK?=
 =?utf-8?B?YW5uU29YQ1dLbExzN3ZNVE9pVVBUR1lEWXFDSEpVUmI4Ym90WXpxV2gyYVN4?=
 =?utf-8?B?QWlGYTRuMCtDMzFGNHJMemxxa2huWm1oMnZ2S3ZrQkhGbDNnQXVsbHAxMEVi?=
 =?utf-8?B?SnpNZm84b0NNemJZQW1PR0IrWkhsczM1THgrRXNBYldGYzNOQ3FNTDltUnE3?=
 =?utf-8?B?TUx3NE12ajc5VHA5dGhTam51clg2ejJOekI2TlU4SjJHQUFRR0xCajBUMXJT?=
 =?utf-8?B?bWJzbUVHc0tHellzb3JqRjZzemJQZW5jMkpKTWxQOTI0ZGpESDhNTWs5WG51?=
 =?utf-8?B?cGUzOFl3ai9aM2ZLMHU5NmhZUjFnUzdpZTJveW1PMTBlWHNmYjRMeFhnQlM4?=
 =?utf-8?B?WXNtYUx0TGFTa294QXhTSTk4a3czZHg1MlFodnpWeHNGd21nNHEwZFp4VDI1?=
 =?utf-8?B?SmhzZ0JLMy84MklvYTdQTUNMckdlR1dkakVQdUdnd0tQYklqdWU1QzB6ZkxD?=
 =?utf-8?B?bjJFOUQ2Nnh1UWFXM3JTNWw1NE96VHBjOVg2dzloTmFNMlgvRGZpeDhJR2dx?=
 =?utf-8?B?NWZxZUR1a21LSFJkT01QaDRkOUMreDlVZ2lzV3pFamZhNGJKWm5TZWhsWWVv?=
 =?utf-8?B?cTZESGdXaXNZcTlzTzBzSXNQaDc1WUU5SG41ZnA3YWJDd2F6MUdVWW1JT0Fx?=
 =?utf-8?B?ak5GNWRJNW95NU13NlMvOEdFamFwMVQrTm9PQzRheWYwUVNUaFQrdTRObGtr?=
 =?utf-8?B?dExNVXJkYjBBYlpzLzF3YkdwdUxFUkxwUWhiak4yOHlmNlJsMjVCWGNsZDB6?=
 =?utf-8?B?c1l6R1YwT3ArVXJ0YXlQVW1zeU9WU2pPc1N6MXdpYmNYWUpvSDVQS3ZGTjBh?=
 =?utf-8?B?OUZ1QUtJYXlmaWZVZjYwWEprU2VBWEltRHZnQWFTNW9ROUpxb0ZFdk5nN3l0?=
 =?utf-8?B?Zno5UStWbVVyQ3U2MS9VbklhWTVIcjNrRFJ3cVVOMkpMV0w5RVJkcDJvTU1i?=
 =?utf-8?B?aU9PYVVUd2tNRU56RFdQeXVZNTdnV1dsQ0lUR0MrMXp0MExiTVVxZWRBVG82?=
 =?utf-8?B?NFFqb0I4L1lVamM0bXlMMENuT0JZelVCdk5zQW9SZFNyL3VqdkR5TzB4VEpD?=
 =?utf-8?B?QlNETHdPZ3VjUzErcmVkMWVmUnlGTVo5a25uU1RLSW9waGVNNlBGMVNzSHRX?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c2xDK1ZVd2RZcVpWRGJWTjlwMngrdnJyRWJNRUp2a3diTFY1SHRPYjFoYmd3?=
 =?utf-8?B?dzVqK3I2SDJkU256NTVjMkZsb2VSb0paS0tWNlhmRCsxVlNEWlRselcyREZt?=
 =?utf-8?B?VXIrb2RqdDB2eHVzS2tiZkFIdTl5c3BkM2FraFBUTWR3bnB4Um5WY3FVZzNr?=
 =?utf-8?B?U1gyayt0OVJmMUZFZUtYOFVTU0dyZlJGWlJpbGpLWVJYam55YjliZjczV1ly?=
 =?utf-8?B?TktSVWFqZW1GQTdUa01DOTFEVWV6VThzdTdPTE5xQi8rUENKOGlGK0ZmNG93?=
 =?utf-8?B?VnlsbUhLNlhSdERyNStTNGlpa3FsWnBydk9NSlo0b2JMOWhwbDg1dGI2bEpx?=
 =?utf-8?B?UjZSZ3F1R29VcVZhVm4vZkZnZ25WaFBBMjJlaC90ZlcyWjV0Zk9pSDZiMHhJ?=
 =?utf-8?B?eElNclRSZDBrOG1Cc2VPSU1uKzA1NHpIblBFck9sQjRFVVBwUXdwdSt4Ynhk?=
 =?utf-8?B?UFg2Q2NLdlNMSFJHU1pUcWM5Vnk5S0F3Q2hRUklHejN6ckhOeXlka2ZJY2hY?=
 =?utf-8?B?MG1TbnpJNTNzQ2oxY1hZWkRvV3lHY2NkamJ3VkFTdS9OckVTaU9tTEJ4V2tE?=
 =?utf-8?B?TS9jeS81UWNHbjZOd1hxUEI2ZVA3TDdxa3NzeElaTkVVU2kzM1Q5UDFvWTZZ?=
 =?utf-8?B?NGdjNFppTFFhTG5FR3FBLzI3M25RVzIzV20wUUNDeFBkOGVnWFBPNWxSYno5?=
 =?utf-8?B?TUNIZVFtem83dTZYWXBiOERidTFRaXBGeHRxb005MFl1LzB6NFZKUGxJOTRT?=
 =?utf-8?B?Qkhrci8vak1xdGp2aE8zd3ZacG50UzczWXN4R2liSGdQb2ZKbEZMMnFzdC9t?=
 =?utf-8?B?MjI2bzhhczdPSVFnMVE1cVhUL21kVkF4RC9JbTczdUMrbTRueDZNYjF0bXBn?=
 =?utf-8?B?OEFCOTFYY0tIVkYzYkVjNFRIdlRpMWEyMDVPdUpxVC9GQXYvZitVSjZUUHNZ?=
 =?utf-8?B?dkFpMzJ1alRacDg4b3pDWUhPTmw4NzFCZFB5S1cxT1l6NlpTeTh4Q3JKUjUy?=
 =?utf-8?B?eExaV3NMNlVjVDd4ZGorY2k0dkxQK2RKb2tacFFDV096YUp0Zk00ZTQyREtm?=
 =?utf-8?B?cVAyWnR2eW5TS1pZYzhyNWRFZlRzMTQzTFhSK2NHdUtzZkdldS9jZTJwNTg5?=
 =?utf-8?B?SlBMVGY1UGgxZXB1NXVyUTRPL2RBNkxiNEVuenFXVENZREZLU0h2c1p2UlpS?=
 =?utf-8?B?UVRpMzdQcTAxL0R0UWVYWDlkdTgyMzB5Y05ObEZvNkowelAxNG56c05OcU1E?=
 =?utf-8?Q?Kjk4XyX4jV/hBOG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcbe5ad-0e41-42a0-9fdb-08dac7e8f4e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 15:40:58.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTUQhDwQjWePFvJ2H0Vvp293Wh9h5zCu4DDHAkZ0qZrg304Upshz18AMSoxH4/W81/n7CMjX0/37izRsGWSWmETqBnpYBuBwwQxDfxTQ9ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160109
X-Proofpoint-GUID: 5LGLJHDyNRL7duM7SgMcs7B8TK5VoFBw
X-Proofpoint-ORIG-GUID: 5LGLJHDyNRL7duM7SgMcs7B8TK5VoFBw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 11/16/22 20:06, Waiman Long wrote:
> On 11/16/22 00:44, Kamalesh Babulal wrote:
>> Change the function argument in the description of cpuset_css_alloc()
>> from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
>> argument type was introduced by commit eb95419b023a ("cgroup: pass
>> around cgroup_subsys_state instead of cgroup in subsystem methods").
>> Also, add more information to its description.
>>
>> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>> ---
>>   kernel/cgroup/cpuset.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index b474289c15b8..aac790462e74 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3046,9 +3046,14 @@ static struct cftype dfl_files[] = {
>>   };
>>     -/*
>> - *    cpuset_css_alloc - allocate a cpuset css
>> - *    cgrp:    control group that the new cpuset will be part of
>> +/**
>> + * cpuset_css_alloc - Allocate a cpuset css
>> + * @parent_css: Parent css of the control group that the new cpuset will be
>> + *              part of
>> + * Return: cpuset css on success, -ENOMEM on failure.
>> + *
>> + * Allocate and initialize a new cpuset css, for non-root cpuset or return the
>> + * top cpuset css for root cpuset.
> Strictly speaking, it returns the css of top cpuset set for NULL input parameter.

Thank you for reviewing the patch. Does the following, rephrase, sound right:

Allocate and initialize a new cpuset css, for non-NULL @parent_css, return                             
top cpuset css otherwise.

>>    */
>>     static struct cgroup_subsys_state *
> 
> While at it, could you also remove the blank line between the comment and the function body.

Sure, will remove it.

-- 
Thanks,
Kamalesh
