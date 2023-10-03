Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB297B7435
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJCWnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjJCWnL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 18:43:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30556A7;
        Tue,  3 Oct 2023 15:43:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4d32008510;
        Tue, 3 Oct 2023 22:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=z+oqPDeenvHcZsEUwqtwl/HybxqUtGhVEXsqep+UPAM=;
 b=YwINMiDq2Hu9EtOSakXcWXJCcOq5nA4WPve4xX3ue0fNsNupjpre2PAcrWYaUmpvSEK0
 mnpk3XJm5lYY/tPIZHqOglQa84T+19t5xuBtEYDQjLBk41yP1RnFX14v20PF6AyabhoA
 p9SOT7qcFYc9ad0cpBe9RFqK4VSajtO76QFC3BuvsiLEtN3hd9L6c6cL05tcSY6VNjgu
 JmBLmba8TxDslyNHzMeSKHN2ctixpigkD3xBqakNUzdwXzE5iAltE7fjI5U6zE9z+Sr/
 LWlF6za/2iXXcofaPCqEXh1i+c+/AP2eOQqpf+WJGGUfr48SfH4z9zukfSO1CiUEuhcn Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcdx51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 22:42:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393LwKLV008791;
        Tue, 3 Oct 2023 22:42:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea477g1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 22:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en9pGgYGKzQBJuQ5A6y78q+3zIuZXAjx1zinozMtZoYYovd4qtmQXjfeUeS1GxyOGdMVIsNQXW2qvmjvDOzr+j18W5M1M57Efq5vfHrh9jojX1D6bQesFOKMkFVREv2HXnwb4YaMCTcn8J7TRkVaK5C2q0PK/KR7l23SoBXAnV1Pm6m6seDFZgQRC8WClu3byk6KqNrBgt53yFbKYSdMGmXsUi7LhdJnmREZF02SogO+vjjER7msuZygj1+69+hZ2sAiw1inpUombLLElA7yzuz0H8w6sqsuO5xbDsCmPMOF8TWAUQ6r5ZWYGcu1/lAMMDhIbE5+at1wApXs7WULzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+oqPDeenvHcZsEUwqtwl/HybxqUtGhVEXsqep+UPAM=;
 b=eHl7O33zpF1KFmIS5F/3v3OWwL+mOQAtjvRgHf7EjnVEMJM9UVcz0NM+4byrEZCEMmQBVzSWZ0dmgDApuugXOEnc5hKVor9lEEqD3sMZ2iGwsKdqmIqqxC0BGwgOK7U7HjLLYRs8jAKjdXgvWJ/qWKe9Aie+PBOi/Oj05NAVVfvwxYCYp0pVdhcPOnNy+XrQ5Q5cyuFgcvSqk2kOHCpvxmJpMXuaGGofiWMu9hTY+umnI7wql2WPCPZtgK+0M8w7D22rTRtnKKno7T6hyH6N53OlmBHyE+DjPca3PMdXYs2zDixfJwidyhAMRJjUUtUZhtr3Fezn0j63YkSrs5+1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+oqPDeenvHcZsEUwqtwl/HybxqUtGhVEXsqep+UPAM=;
 b=DQ3ue8jHc3Lz6PG318N2Jdp7r32OdFe7h14RRNqPnWIsOaxlF5mQkSWf15b5qtW+j/Zh7OlNDVk9VGySLlTm/zQHeXxw/M2pVYkj6IFVH9ERyZRjnhjmDwmd42YWACHwLwD3iufCyeYvrgPh0ntnyd1mjYm98jaN99hMa8PJ4t4=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 22:42:18 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0%7]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 22:42:18 +0000
Date:   Tue, 3 Oct 2023 15:42:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231003224214.GE314430@monkey>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
 <20231003171329.GB314430@monkey>
 <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
 <20231003183928.GC20979@cmpxchg.org>
 <CAKEwX=O8X+ZRNEzzs+NYBAh9QJLObxKPOpmFo-ci4Aw=MR=0+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=O8X+ZRNEzzs+NYBAh9QJLObxKPOpmFo-ci4Aw=MR=0+Q@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: a77e8400-e079-4d95-0d3d-08dbc461ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xit92ukVHGLDPjJSXGAY/l00iQK3KO6pfrS5EnsA3eO9snCWgxe2uRgDmWxwVswg522AbkHMDgoxVprycpV7Zg67K2jrIpkbVjrUDbNeZ/rKUteqepswtm7IkDstINapTgM1E6NoijGCsuEtufn83zCptAEUugXTw7GKemvyNP62zYpu5GRklTflucq2eORM2UMp8Uj33KNQwz6HhhljJSDG2Az6Eh+SiJcLqbsFeaNNWhRmQ+X5ZcxwHwLeHLHDcPcleMrt5crLQqC0P1frwZGO4iLyyrPL7mnTAtPShLeGiribC8pguipJOQO0MbtAEY1Mw2w1XUXVm0IiRr5jrj472uLPrc6Gg6FY3USCpjyRQlitwYtSw2gDLLXFJvbwcXVdBzXj+ZAm06fZlfjwXst+6gnJ6JnW8/CsfcTJGa8bo0j0ZIPwuxJPvQm7Ki4f9gcBCK3eqVapdUb42GxvaRqnkjR80IPZeEw5W+dHQ/ZSYn9AWLkAOjKwY6qfTXKZ5uSZEB0qMu88rcZCcGiPVcP0CfodurxiebIbTieui54QS5FNKlVsxzoWnBteQkiy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2906002)(6666004)(86362001)(38100700002)(66946007)(1076003)(6916009)(6506007)(33716001)(478600001)(66476007)(6486002)(26005)(33656002)(83380400001)(9686003)(15650500001)(44832011)(316002)(5660300002)(8676002)(41300700001)(53546011)(4326008)(8936002)(7416002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtxUk9hajZEZDJUeWNUTHJPRWtPVEswK3ZPT2RUaTBQbDJLZElHd1l0Y1Mw?=
 =?utf-8?B?SjYyNE9KeWxrMk90Wk55ZXNjVUZicnRKN1FTUHBRbmkyRk5udFB4NjVScXZG?=
 =?utf-8?B?bm44ZXh5NlBTQWJ3ZVgvTG5ycHZXYmhwWXRoejV5bkNINmM0cEc2Mmh6TkVU?=
 =?utf-8?B?U1ZoQXJFYWFmbWR6bjFuWENURG5xamtoVGRRWEwyLzJzeUw4WThyNW5pSENj?=
 =?utf-8?B?V09rbHZ0dlNjU1g3SndtOHFTT2V4R2IxKzVzSWRNT1JCcGhwL3RPdzVJQlNO?=
 =?utf-8?B?cjZldmI1UHhyVHdwWGQ1ck9Hcm1zem0xZnhLbnhPYmRmZSt0aHpySDB4clVK?=
 =?utf-8?B?K0JGOW9GT1Q2WTQrUnF2NWY0YjhTbGs4SExpQnJkWS9PajdoWEdDNjNHUlpt?=
 =?utf-8?B?Ty9Qd0xFMWxOTEMxdklJZ1MxV1NCSHZNUlk4QzlDcER6blJyMVUrUVNONk1Z?=
 =?utf-8?B?Um5FTjk5SkdLbnZUZTNJOS8waTYyR3V1Q0tkYkZ5YlhYLzd4RTdSbkhtNjUw?=
 =?utf-8?B?V2NrdTVhRUFvczdqTGZVNjN3RkNuYlUxbUp6U0lPN08zQ1k4Ry9mc3JyN1A2?=
 =?utf-8?B?VXJPWGtZdnlBczNnTyt6clRsSW5oSDJEVEZrWEdsZEtyTzcrQW1CZ0N0ZzFI?=
 =?utf-8?B?Wlhyb2pZeTdLK1NCKzhOVzRFVE52WWdMWXZNVGRhYVJBcmxxSkFiOTBBM0pL?=
 =?utf-8?B?RE9nanhFR3BDWHVvV2wwUmlLamsvYlZVKzAzQUNZNGc1TUVWZ0pyb1lhMHZQ?=
 =?utf-8?B?N2MrSXlnV3BkaWRSYnMxSTBYQzV4dHY3Mkt0RVluSE5CQkVlVGdOejBGMkFq?=
 =?utf-8?B?RDdnZncyR20xNDNBdUlaTkkvcmpzSVBQRkV5cElvWjcrNjVWeFlldUt2clhJ?=
 =?utf-8?B?c1ltU2RKQ2ZLNEkrQXhxaG8yYzZqeGtyK0hvT2plS2hTejA1dWxmbDVTLzcx?=
 =?utf-8?B?eEVLU3RBZTdMN3liNEdkQ0ZBZjI0OHR3em4yT1krSVNVZUdYV09mSHl0SUtB?=
 =?utf-8?B?bzVmOUpGRzI1ZEJacCtBV1dwQ3FwQlg4cEVWK2lsNklDK3RPUWRMZ3VuZlYv?=
 =?utf-8?B?UmtiVW4rcUZkWkNnWEpPQm45YUU4clVJMkF1bEplbDQ0cDhpNE0rdk9CSlBF?=
 =?utf-8?B?cW1ORGlDYmJlb0xJdEx1ZFZBVjNDTElYUmZ1ak9lOGhKUWJidXp6TUVwOCtL?=
 =?utf-8?B?SENqMzJHV2RyTWNjcFNWdWN0WlYraW9Vb3R4U2thTHpLYmNVNlNQZnVzcGtE?=
 =?utf-8?B?amNTZnFDZ2NqQWNMdCtXUUhMM0pSK3NqT2MyVjVjSDMzanBZTDFBUWxmaExa?=
 =?utf-8?B?cmNFNDBra3ZPbTZya3Nxa041Z2ptUStSK0FobWhzQ2V3bHNTRnQ4azUwMzNY?=
 =?utf-8?B?T3RMWEpNZjZIdmY0RlJMOFJrcjIvWE1WeFFqY1BSR1MzRzR5S1hvNW1FSHgx?=
 =?utf-8?B?VWZGcFJlc05taFUxU2N3Ylh2S2FUd0NyZVdNbGZ1Vi9WU1UwYXhVZjZFMWFQ?=
 =?utf-8?B?VFBTSy9rbkJsUE1yRXU3bGt0bUZhdWNESWl6RkZmazBTMFQxS3VWb3VsL0FS?=
 =?utf-8?B?YUlPMUdNLzFDU0djLzN3eTNmY2NCak1meCt4VE5VRnRGRk1ucXExbzlRdVpX?=
 =?utf-8?B?K2g2dDU1VUlsNUd2TmJHQU9kQ1BGRElSTnpZS2NCVlR1aC90aW9YT1I5d1lx?=
 =?utf-8?B?K2psTm9Da1V4T1l5aENxV240MVVRdml5QU1yKzBxdDBpR1FlOTBaVXBvNHpt?=
 =?utf-8?B?cGRaUHNYZTdEMkx4RXlTMnZjc3d6RHlIL0xkT0JGZzE1dDYySTlTR2wyWHhh?=
 =?utf-8?B?M2V0aFZTbnhvU2YxNStJU2tyVW91NElGY0dGRmRBNHB6Y1c5anpJcGc0OU1O?=
 =?utf-8?B?d0Z5ZC9Ua0tPemFuTGNvVFhpcDM4N2ZTYTJSeWdqSEN0UHowZ3Bza3VBUlBp?=
 =?utf-8?B?d2xGaldFNWVUS0R5WnNBQ0N3UFhkR1hVWmh0RVFMUkM2QzhUVnREblc3SkFl?=
 =?utf-8?B?aFpEa2pwcGlxenpKT21LVUg1aE53eHdVWWFSNU5FZUl4MFR3ZFd1Ym5BK1VE?=
 =?utf-8?B?bmdNdHRLQlRrSnZRd05SYk5BOE5NYkxNTUJIWkVjZ1RVL01wbGx1UXh0cjBD?=
 =?utf-8?Q?oXvRsbOJwRG1sDuW5111fahc8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkl2Z01zeHUyY0tUV0JPUVZLbm94RVRyUGJEQ2x5OFF0akVwYWFYWHJXbzA0?=
 =?utf-8?B?YWEzb0VoZGtnZmIzUjhJaGNKUy9Ubnd2S2dMVjRtZzZPQ2EvUVFRTW9XVnNM?=
 =?utf-8?B?UzF0TEdQdGdhVWlaS3F4T0xPRjZSd21CczhSWURzUDV2L1c5STcreTJwWjBN?=
 =?utf-8?B?emp3R3pXVTduWnRJTHRKampEVTRML3JnWmg2SzVTRFVBZ3lCbmdXbzdDMENx?=
 =?utf-8?B?WFhUSkVSeU40eWhuL1EwdkJlS2FES1BBcG80TE9WVlp6MjdGUkpRUmROK2dt?=
 =?utf-8?B?Z3Q1bzdvOUNBOUcrWW9zSjREalVyVTJBZGgzNytGZk94WVJpZ0RMYXlyTXZK?=
 =?utf-8?B?c2FQQTRLRko2bmhwTHp1aVZuNFN4RnZwR0daZkR0MVhqMkwrSmlQRGZMNHND?=
 =?utf-8?B?aTNzNGs3YWxSV3RLUy9uVlRscDFMVWp3VXhmNWhiMys5ZU1WSXUvOVF3NDg4?=
 =?utf-8?B?czRKVUlnVlBodjBzSm4zVllzdTBwQ2N2eS85SWhTUkphSm00Qkt6UEt0enhq?=
 =?utf-8?B?Zkk2VCsrbndsd0R1R0Z0OGdpZ2FHcGp2YmZJcFdEdWVFeXJFME1aZXZ4NEJy?=
 =?utf-8?B?bXVvazVyWllCK1ZQUGs1bHpaT2dQanB6RVg0aWpheG1FMWxFNDBCenlRTnRT?=
 =?utf-8?B?WUNEcXNkZFhLbHV0bUtFeExBdGdlRFVhaXRDUWpLcXNtVWJPWUpQQUJPWHRj?=
 =?utf-8?B?RWIrclVoSnhOUDVxR0RLMFloaWpCZWMrd3lSVFphR0tBNTlpNisxRmV1MWtx?=
 =?utf-8?B?ODBXZ2ZrbXdWcmU1azJuZ1JpTUZSSnN3NXpFdnRVVy9vbDJ4cldGNW5aWHAx?=
 =?utf-8?B?a2lBTHIwVUpzclRwVnM4YjBGaitTUDhpZjR3cGIvR3FsZHdLVG5IUlNEM25T?=
 =?utf-8?B?REVhMW4rRTdMYVE4Q2xBeGlvUDYyQWFmcTZ1OWRpNFAyQnUveGxjR0c5eDAv?=
 =?utf-8?B?bzV2MWpjR09zV25lR0V0U01LS0N5M2psbTZER3g3VEllNUN1OWlJMTdHSFVJ?=
 =?utf-8?B?blFsRVlSZkR1MFVLVHpPZ0ZVNDU1THVQTy9aeTNGUFBKN3NnU0ozbDBWcldF?=
 =?utf-8?B?endsQjhxdlRqUUs3Y1o3K1BVZ2FUWmRRazFHeTExbGErcjVTdHRzeVBVamZV?=
 =?utf-8?B?N2VKbHB0TFZySjlwOEs2cjJWRW11c1JRRDBEaHNhNlIxaWhOMnRTUjVUTG5t?=
 =?utf-8?B?aGVacGpFblVMYmEvQlJhcnp0UENwOXZ5Z25Fc0J4eVJLb0d2VnVyVGxrTFZq?=
 =?utf-8?B?dVNLTWJBYkI3cmVtakkxdEEzbGR2K0IyemprUXM3UkVkQU9IUlN3c0pDVEJl?=
 =?utf-8?B?K2hXOWhBU2hMRml6L1dUdFZHcUFkS1lsVU5FejNucFg1NUl1UVFIN0xpWkxK?=
 =?utf-8?B?dHJKN0ZZdzk1WEFDNUZOZ20vQkxaTTU5bkVXZEpxbTBNSzRuVTFYM2YwL1Bs?=
 =?utf-8?B?UngzWjRONVV0NHBvSE8vM244dDNUVHowQ2kxc3lnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77e8400-e079-4d95-0d3d-08dbc461ffb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 22:42:18.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m40MocCBmaeAdyF4Eb5Qyt9yq+d79f9L8AUPH1fo2D/Q3iwpB/lfeI8+5OXptliqCuyl6+w6P2r2oU9VdgKegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030171
X-Proofpoint-GUID: KHCnNThw5t_5jtOpAa6HNK7GXxf11Y6R
X-Proofpoint-ORIG-GUID: KHCnNThw5t_5jtOpAa6HNK7GXxf11Y6R
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/03/23 15:09, Nhat Pham wrote:
> On Tue, Oct 3, 2023 at 11:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Tue, Oct 03, 2023 at 11:01:24AM -0700, Nhat Pham wrote:
> > > On Tue, Oct 3, 2023 at 10:13 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > On 10/02/23 17:18, Nhat Pham wrote:
> > > >
> > > > IIUC, huge page usage is charged in alloc_hugetlb_folio and uncharged in
> > > > free_huge_folio.  During migration, huge pages are allocated via
> > > > alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there is no
> > > > charging for the migration target page and we uncharge the source page.
> > > > It looks like there will be no charge for the huge page after migration?
> > > >
> > >
> > > Ah I see! This is a bit subtle indeed.
> > >
> > > For the hugetlb controller, it looks like they update the cgroup info
> > > inside move_hugetlb_state(), which calls hugetlb_cgroup_migrate()
> > > to transfer the hugetlb cgroup info to the destination folio.
> > >
> > > Perhaps we can do something analogous here.
> > >
> > > > If my analysis above is correct, then we may need to be careful about
> > > > this accounting.  We may not want both source and target pages to be
> > > > charged at the same time.
> > >
> > > We can create a variant of mem_cgroup_migrate that does not double
> > > charge, but instead just copy the mem_cgroup information to the new
> > > folio, and then clear that info from the old folio. That way the memory
> > > usage counters are untouched.
> > >
> > > Somebody with more expertise on migration should fact check me
> > > of course :)
> >
> > The only reason mem_cgroup_migrate() double charges right now is
> > because it's used by replace_page_cache_folio(). In that context, the
> > isolation of the old page isn't quite as thorough as with migration,
> > so it cannot transfer and uncharge directly. This goes back a long
> > time: 0a31bc97c80c3fa87b32c091d9a930ac19cd0c40
> >
> > If you rename the current implementation to mem_cgroup_replace_page()
> > for that one caller, you can add a mem_cgroup_migrate() variant which
> > is charge neutral and clears old->memcg_data. This can be used for
> > regular and hugetlb page migration. Something like this (totally
> > untested):
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a4d3282493b6..17ec45bf3653 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7226,29 +7226,14 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
> >         if (mem_cgroup_disabled())
> >                 return;
> >
> > -       /* Page cache replacement: new folio already charged? */
> > -       if (folio_memcg(new))
> > -               return;
> > -
> >         memcg = folio_memcg(old);
> >         VM_WARN_ON_ONCE_FOLIO(!memcg, old);
> >         if (!memcg)
> >                 return;
> >
> > -       /* Force-charge the new page. The old one will be freed soon */
> > -       if (!mem_cgroup_is_root(memcg)) {
> > -               page_counter_charge(&memcg->memory, nr_pages);
> > -               if (do_memsw_account())
> > -                       page_counter_charge(&memcg->memsw, nr_pages);
> > -       }
> > -
> > -       css_get(&memcg->css);
> > +       /* Transfer the charge and the css ref */
> >         commit_charge(new, memcg);
> > -
> > -       local_irq_save(flags);
> > -       mem_cgroup_charge_statistics(memcg, nr_pages);
> > -       memcg_check_events(memcg, folio_nid(new));
> > -       local_irq_restore(flags);
> > +       old->memcg_data = 0;
> >  }
> >
> >  DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
> >
> 
> Ah, I like this. Will send a fixlet based on this :)
> I was scratching my head trying to figure out why we were
> doing the double charging in the first place. Thanks for the context,
> Johannes!

Be sure to check for code similar to this in folio_migrate_flags:

void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
{
...
	if (!folio_test_hugetlb(folio))
		mem_cgroup_migrate(folio, newfolio);
}

There are many places where hugetlb is special cased.
-- 
Mike Kravetz
