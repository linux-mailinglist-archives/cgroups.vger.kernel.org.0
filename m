Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978F86CA6B5
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC0OBP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Mar 2023 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjC0OAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Mar 2023 10:00:38 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102940CD;
        Mon, 27 Mar 2023 07:00:13 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RCDEbk010335;
        Mon, 27 Mar 2023 06:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Y8oMA2Kh90fJuaqHhLVsPbnGur2i+yIZVcZrAVQRP/A=;
 b=W4WeRm0IU4n37kzCd8POz3yWGzxUg7seVsLUW3V5IGq/j4nmbMPx1FZprJabu88hWENk
 v8vCB9gQFVJgqqhijHeu8auEFybDh8OkTnmnkOmMhFhbv5Nir5aXw9Nlo6BmyxneZ2Io
 NHVFh9tfCrOZUd3QF0zyvFcjDFg/1mIkOf5w+2S9VcWy9CbIHcTX5za9IswzbgGJw/Do
 8+Agdd9CokYXwCXHOdOFGKMdWA8euh7pZ1oypgvKJ+ABMP2rEc7zWp8OHaUMy936wp7S
 Qbhh6SmvktOMkrc2uWuOLxaSa/DIMZx4eChDY5KAxz1WUr5fZDJ6bOgW9VXfGPv/Bitp nw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3phy2jkx53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 06:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk6j3t4ChSS9xTsxGBIqO7ERe5YL+3r2ZkLeYs7qNxHpHpXdMgS366f82fBtp4VMbrBqBCiP7HXVnXYy4So22fUr9qYUynfxjSgNXMTys9KNUIs/kj3QNf338XeKng7Eu175WhGlM84GKw9KU9gTtn1M5LYyG/q29Niu2JBnZDNUytwZ+OmL8Uxvzbq8qoMC5jmY3djRjyyyoxRoxXpRSmqLF7FtaAKLPNZAS9liecUVkRQAA1un2CiNCnt25uTSTCONvDFSpofcza3eQK60P0uPFZs+ZNdR76KY4p1llzx0zGC/m0kHXFQ7Y2YWcueksDdTETkF4bztcVcgRAkQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8oMA2Kh90fJuaqHhLVsPbnGur2i+yIZVcZrAVQRP/A=;
 b=DYyYTeI7S4qQP93HYCKkADAlAufcdw8cpgucNmEqFN+4yVL0FfoR3snjYiBk0NcyDVNJdqZVxHcGL7caCGK9LYEbdLMLYNp3sqNata9rhcLAUuYKwVG5MCzk13p2Gs9gLmsuoLNmLdFOKQMRrw8krM3c+C/IDTAYwIE7zyHotKhCK5wsHrLKWzvPdIhFmrf6Y+GncPCxMILJ/5yU7uuBSAqSjMmgqPLCSOUYotPbgRQBkxpCvZgIitfVt3vmXW8KlzC1S9DoY7dxzc80Xszxu99KW/5RisyG3GcLK5kOTYJQlJ4jVBAFWsq73VqZfUlnncTO/wtvX/YN4oGkhoaoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8oMA2Kh90fJuaqHhLVsPbnGur2i+yIZVcZrAVQRP/A=;
 b=ejONGk/JR1bdBpcjQN9SClty6+JTvbF27IwWTmDZQ33r1ES1kH0jMg5fCPGrmBaaq412Yiiul1Tb7KK2YXWOI6YxVrX+F2oo5TIu6ZLrjB7PmbMG27zIWjLGUlPfErR+8JLdqP7LGmLRf/x0EWdGtFjOz57R7EFDD0tNDruk73cyx98BSkBGu1viNjw7j1Qc6ruUo0ik4VNuP2mLYE/kFw2jp9ruOuMnVXpzpbsTfuppSFt/y2dIcqUZtTe6xB8z8IzabqnSw96JxAGS8TQwIjRFlSmxyiCWn0oJ6e1Oce29VB4I3bshc5XIY8VlXhhQAf+FIcddss3/upr61MnmtA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by SJ0PR02MB7629.namprd02.prod.outlook.com (2603:10b6:a03:32c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 13:59:49 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e%6]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 13:59:49 +0000
Message-ID: <6f4420d0-2f86-7294-01e1-6806ef7e4686@nutanix.com>
Date:   Mon, 27 Mar 2023 14:59:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230322142525.162469-1-flosch@nutanix.com>
 <20230324150350.fu7itbqqvtjmyf3s@blackpad>
Content-Language: en-US
From:   Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <20230324150350.fu7itbqqvtjmyf3s@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|SJ0PR02MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 83713e37-0f3a-42cd-42c3-08db2ecb877a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTwQtqi5l5wSLTz+xLdy9ZHPun26ozx6MpVVctUxoCHiwCBegm8Zd6/uWo0NG99PajpBpu1yOnTN8tcaRsfZ/y5hCxmdU+GylZaJLR9hqlz0xjnljsPxY4Q8p2iyIXuiY1y5QfW+onuobWK9SA0b4RjwZDyx2fe9UmFaSogHHJR/sn1HuwbQQ9OaRGxwgHeq2F2P9ZAooD/fiEQthl2Y+zKtcrjXFlj/6wHmZfGhAIWiHq55+R/d4EXnGzP/0XCwLgNbp30SgHbTfQPpt1KYX4+4squZSmDYvv6axQNCo4sFMfZKJ9BfjTe4T9P/e/Nvrp36EjzRkneyjxddxUdo9hkADwg2UG7k4BeYOh9+U0AiZWLCMvDFoxxs3fZ8+cvu9MHhTm51ZRyiRDHw8lZaBttz6/rEX263JTWJ9u1rWyZGp9bzidb+NFU2rwyesC19BNv2K3TmA0AxR2Mbimo20oa/hOH8LuSEaeFFHnjNl1B8b9azw13d2WEtjWELcw3yu7STpmVPOIqrXLZY+4LfmviV/hUr0J7JMie4anD6rLDMqT7VwIVxVJtCz3Ruo9Yf5vW2GsP9bfozNxjhsiizNJeqZ5GNTnLef2soCCVAySXvS65HN5hRze2k3XH2slv419jbbTb343pL0hajmA3f4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(478600001)(54906003)(316002)(8936002)(5660300002)(31696002)(36756003)(86362001)(38100700002)(7416002)(2906002)(66556008)(66476007)(66946007)(8676002)(6916009)(41300700001)(4326008)(31686004)(186003)(2616005)(26005)(6512007)(6666004)(83380400001)(6506007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T296dkRnUVArS3d2VllGYU5aOG9JQ3ZVL0xGQ1QzZHRxblpYTHJic1J3Vk12?=
 =?utf-8?B?SzFuQmRNaUJYQm02TnpNRXpLNGRET1U0ZEFTOEZPaVdXN0FQWWMybmVwbERO?=
 =?utf-8?B?WVVpVGJkUDdwVC9nZ2tXM240aXlxTmFlRnV3L043bmxVOWFBNGFCbThHeURP?=
 =?utf-8?B?MGtLcFMzenpmZVNVNm1uZElSa1pYOG5SN2pyUnUvZ3B2ZkRmRGVQVGgzVWh5?=
 =?utf-8?B?TGlLUG1YajVKTnBoaGpiZXJjdzBvbUorMjgxZXVFLzZMa0tUQk5ZNGJuK0M4?=
 =?utf-8?B?enlLQjlFbDQwUUR6V2w1NXFJYm5sRi9MZURrRnBNbUk5ZUJpYXJvajdDUXZa?=
 =?utf-8?B?bWJEc3FQdWVoWWN0eGxidGxIS0l1am9zd3ArSnFHUU51bTAvYkNieXFIWWtt?=
 =?utf-8?B?NnRueVlNYUhtVU56ZlkwcGd3diswb3k3MS9kNEd1S21lc0VSaS95WFVXZ3J1?=
 =?utf-8?B?dlk4OUx2clpRanNmUFd2d29PemZVRTY1c0p3K3hlSGlpbXRsd3U5R2s5U1V1?=
 =?utf-8?B?TkVDaThCbUt4UGticnBSOTRVWGR6Tis4a3FYTHo4SE5GUythem5lVG1xbk8r?=
 =?utf-8?B?SHBkd2lqMm5lSXQzVXMwN1NuR1NSNitVUDZESFdWa05GRk9XaEJCcmdleVFh?=
 =?utf-8?B?cUtYSU5nN2h5SFpvUWM5SG14S1ltcXhrcloxV09BUW5xdjJudWJtNWlOV1Nj?=
 =?utf-8?B?MlZTTUcyN0pIZVBqYnYwRTZOTFhXWXdQbEJ2S2M3alZ4VE1pcy9TOFo2KytO?=
 =?utf-8?B?TmFXc3JaUXlFZkZxTGFvM1cwRm5VZjFWblk2T2VYTzNYeG13MjhRUko4RTJn?=
 =?utf-8?B?MXRvYmFTN2hPdHQwWGdvSUs2d0JydjRPTDV1VUJ4WHpueHExaW50SzR0UWV5?=
 =?utf-8?B?TnU3YmhMd0svK3VZUTVKUFpCMFlldm41MXJ1R1kvN284eVgvZlVpNGtJTU55?=
 =?utf-8?B?NUlob1Y0SEpHSmpiaDAxa252akprTVNkTWxTVit6WGxjcVMrVk1IcFN1eWVr?=
 =?utf-8?B?cm40VlE5aUdNS0FIV3FmQzE4YTltK2E0cVJtakgwOVk1Yjk3b3BWbnZ1L3VM?=
 =?utf-8?B?RkkyNEVsSDlNT2VISDlFZ0Z5ZDhONVExblQyOGRqN1l3Q1ZWVWk0dmNhVWZ5?=
 =?utf-8?B?andCaE1mVVhHaVp3eTA4OEhkOHRJSE5ybnBXOGZQOFRYbzRYVVMrS051UEt3?=
 =?utf-8?B?MFFlYm9OUWJkRUpNcDAveEpYY0VtODZHSkhFY3RSWWtPVnVKdDdhanlHN2dV?=
 =?utf-8?B?WGhGTmJkZk55RmMxZmN1QmFQaW5mVnFJWmlkdVdxYnNUd0xPdHBrZlQxQ0hs?=
 =?utf-8?B?dkVtUXg1ekdWYkVrMStMK0RiWGhFeFR6dnlMdVpObGNPQXpNTzgzRUp4NHQ0?=
 =?utf-8?B?ME12T0VZaGN5eCtIU1k1ZExGdHgwdTE5SjIxQy9lbXF2R21ITGhTM0tIQ1Br?=
 =?utf-8?B?N0VGSTN0a2d4dlhoYzdlS1VheUNSRzlHNHFjbEM5SFRvNzhDWEMvTGJadXZR?=
 =?utf-8?B?cmlFUHQ2aGFHc0trM1pCRkxIeGxxSUJibUpzN3pUaGpra1hFNS94ZmJjMDJy?=
 =?utf-8?B?VmJtM2tIMEtPbUFyRWFWb05PSmtQYmFBY2dtZzBiQ3VuR2hiMHdJZTRDRkpM?=
 =?utf-8?B?Z0ZWYllsUlcrWXRqS1ZqS1ZRTjBURTVXaVZhVVlFMkNUejVtOUZkOVdmdHRw?=
 =?utf-8?B?V3NqaEhraUo1V2srNVVVRUFKNURXUkliRjM3bVVtTVpFeXNSZ0JnbG4vMEtB?=
 =?utf-8?B?TkxZWEV4VnRubFRIY1Jhbi9xRVh2UTZsTjZybFhWeVE1NXVVbHlTemI3MG9v?=
 =?utf-8?B?MHB1SXhYZ1hwSUFOWStNZ1YwdkNkdVJuTHhMVkRFVFRQWlc3eDl2OXJ4UWEy?=
 =?utf-8?B?Q0lYSUlJK0dCVzZpK0F6WC9BckRjZ290NGNRRG90czVDQU56WllUWkxOMnFJ?=
 =?utf-8?B?OHI4QjdiWWp5c240N29wc3hWQ2VQNWxWOWNVd1hRc21QWmtpb0dsZ3ZrOGds?=
 =?utf-8?B?a1ZKRytJMFBFZFZZSm5qK1UzVlluZGc3Sy9KbGJBZW5ZR3ZjL3Q1YUh6ampE?=
 =?utf-8?B?NnhrZ0NsTk5ncmRxTWlQUG9kSlNhMmNwazNicy91SXVINHdBZDV2d3Voblg3?=
 =?utf-8?B?VjdRRlZjUmV3UkZXRnBwVDc1am5ZQTRyVnFORkF1Y09abXNzSTloTWNGUDRT?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83713e37-0f3a-42cd-42c3-08db2ecb877a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:59:49.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSt5OCEvB83rBl4SZg2NFJ8VMYGyGa4smz+rAqmd7pLVDeHTAfoJrekD1dM1Ma8OOk1/9pUIW/IIwECF1dHlT1A0cxT978bknJzNYj3gRtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7629
X-Proofpoint-GUID: updZuJLp8r7V3RxbuJolT82p6OJ0z8o0
X-Proofpoint-ORIG-GUID: updZuJLp8r7V3RxbuJolT82p6OJ0z8o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On 24/03/2023 15:03, Michal Koutný wrote:
> On Wed, Mar 22, 2023 at 02:25:25PM +0000, Florian Schmidt <flosch@nutanix.com> wrote:
>> cgroups v1 has a unique way of setting up memory pressure notifications:
> ...
>> There are several ways around this issue, but adding a dummy read
>> handler seems like the least invasive to me. I'd be interested to hear:
>> (a) do you think there is a less invasive way? Alternatively, we could
>>      add a flag in cftype in include/linux/cgroup-defs.h, but that seems
>>      more invasive for what is a legacy interface.
> 
> You can (as privileged user) modify file perms in userspace first (e.g.
> chmod o+r memory.pressure_level) and then it can used by non-privileged
> users. (Or do LSM prevent you from that too?)

That's true, we can work around this in userspace (though it means you 
need to give the process additional permissions, to change file 
permissions on top of just reading and writing).

Though considering that the memcg_write_event_control() explicitly 
checks whether the caller has read permissions on pressure_level, it 
felt sensible to me that the file would be created with read permissions 
in the first place, just like all the other files are created with 
permissions that are suitable for their immediate use without having to 
manually change permissions. The current implementation feels 
inconsistent in that way.


>> (b) would you be interested to take this patch, or is it too niche a fix
>>      for a legacy subsystem?
> 
> I'd rather not extend this "unique way" with additionally unique dummy
> helpers.

I understand that this is all code that has no modern user any more, 
which is why I tried to keep the fix as self-contained as possible.
Another option would be to have a special handler in cgroup_file_mode(), 
but that feels a lot klunkier to me, and leaks a v1-specific behaviour 
into the shared cgroup code.


Cheers,
Florian
