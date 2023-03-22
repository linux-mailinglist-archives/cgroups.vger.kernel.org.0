Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55336C4FDA
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCVQBk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCVQB1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 12:01:27 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295D6547B;
        Wed, 22 Mar 2023 09:01:16 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MFNVBd006536;
        Wed, 22 Mar 2023 09:01:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=B0cqh26iRx1ke3EBKYJdQfPpB7QOf1cZVgdjogUnTZo=;
 b=BO1oEEm8qDRmjKTcQRhHUeNV94+Pw0tbPmt3FF7jRMH+cc+4oLJ+IxkPvAgLP5a0bT6w
 7+kDZ5KMiHclznjJ59LE8DJmdjK1dcuOQY5dytqnZdA0G07DXPCrwJRTlgvZ6tT8IJTH
 pTESR2031Jg3JKSlftH5WvVPiPjkURmoaZtKsAaJPosRbqk0cCh4H/3Rwf5/TzVMAZDO
 TNB6bEgbkKInGZYfLicwOM5KvvHH86dNmj2v9U9CYsiBuW5SGMyUrW+pk/gRkTT+p1qA
 LXivOlWwumklEIBAYLE0OSZbj8K7JYGnYLuMrwnSegt5RzjPx9N13eY+fDu2vtVseSBR CQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3pdbdm1pu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmdQ2OFgNnsWgjdD/nJQhZmk/yNPz4A2q+geyekxErfMurNosYzBO5vOjXCgHCFpRplQT08mrM/4MhMs3+kbat/1EYeHpFcg+6b3xaAlnqrf51b08X1d1g7HLYgn6qJzmTpAmobiUcz8Ek9QFQi2HLRMvLLmVHA1pjehDqJOVh90s6JlznUH+2tVNH6Q1X0pwTqlBOZPjKv5uu7IvsIudWoZuoD3jbVoCdwcL6sBndYnfLTMv4M0HDp4M3xWax02XNP7o2ATcRZjLOmQtkFbrFT+z20ggQIyfGB+MJtVLFblA0Dk5JllPQKpY1KWsFsKd7vcFt4uF+suH3oOaeGWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0cqh26iRx1ke3EBKYJdQfPpB7QOf1cZVgdjogUnTZo=;
 b=JKUPkzZDO4sErxbUJW6/7bv6K/aeFT4exru25tUuyGj1kCEh21B/LV0BM66CVFRuOIDB6PRaKrtqZHphBdKJgMlJZjKPgEbgXVsvkiYda+kUr7UgKbT4Ng6BoLvtsVKE/UjvaDr2/sJirvm/frF3dBPeZY3GAkX+b/uhmuYhlFjV529q2hlw7bfvyJekD9PbLhmXJ+/4oUcD2zaH1b+HuEI6bfVMToRlxwrduYjBPFCogp6zl89CjQXiLjyA4A9Hdvuo8FyhVzr3hHfgVq0F+MDyGUD3PZLySd69qKb4OyJurX1RUnKrr7fxPzpiCMSASeSlGxU3kjsZF/uV52593w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0cqh26iRx1ke3EBKYJdQfPpB7QOf1cZVgdjogUnTZo=;
 b=rPvP+pAJL5mqzVTZk6eC0unUV2hKvxOoarKcIjG/h6XCc6vKK6N5ow92xDcnpB9kzbpsM+TnutHSqKABXiaz/tfjcYzvVl89Slv9BmWxL/wFFHB/WH9cyAwMBujRfvJh/CfEK+FMkbMcIFD0T9OFd12ZHN5/3d/nJqXEbWFPIeH65dLSwdXVyN7zT4kGomJqp2CxjSKLp8DGZL3iytTt3qikY395lms/T6dc/uKp8qoxrpy3UrS0FF2ua7QVVShdZXT8+UIGqF9+FCLZUQPghht6t66lTYgaAHo09DrFWz4i1GQzUUYsNMtnxlM5IqIgU+PP4D62xLrpMJ6GWat7qA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by CO6PR02MB7796.namprd02.prod.outlook.com (2603:10b6:303:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:00:58 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::cdaf:f99e:fb15:3978]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::cdaf:f99e:fb15:3978%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:00:58 +0000
Message-ID: <916c1255-26b0-05e8-96af-e5062512cb97@nutanix.com>
Date:   Wed, 22 Mar 2023 16:00:52 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230322142525.162469-1-flosch@nutanix.com>
 <ZBslZrtFISfYqV5l@dhcp22.suse.cz>
From:   Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <ZBslZrtFISfYqV5l@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|CO6PR02MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 906c7ba0-3ddd-4251-2f34-08db2aee9fed
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwSXbpYdsxKH6i6HJZqF2j3/M5/2u3RdUBepfUcArgs8dxWR7eh1FgHuaU+FpndyAOrotypl0b5e7myOxHbiXkDpHjKLUpsiHNHOuZHVtlxY4MXbW9ZrtXbff0/V3ZpgYyXAlWHIJC/sSx6Z1cXQ4FXl4Yq5HdWoH3h4pMbxggefIBtk5Sv3sA8tXUmgOJPVu52AGKublcMvIdBu6EBRNxNIfNM3gG3rkZJkZvfE1sZXt7tf5QIz4UoFn8rxvNzFHJvrfcpmLQirPIcq0yEP1OK8zzdRPJ8k4a9+VrZXT7/wsXOI1JIdUWtAt+M5eN0eAFqvJA9hPT0BNyuBOI3dyMooFH4CoiVQkOWHxj4MWe1LnPu70Rvqw5YPFBEhLN8vhnqKR7tnBaqlkCncG62eOnwmP4LFZ8LizlqY13oMi73uQgPlVwZNcCyA2e9VDG1aaSuhl4UdnC0lngVQqYbs8YXylvymUG9G6KQy3hyOi1jOCMZ40B3LeuOzB4QkAzI2ssGGo9BOjSCZaN+7e4+DTRPKKI5MG+e9MF1MK2M14RNHhoevzteU34IGnofLBl2jgnMzzdwZPlGtdWppg8C8msmf0zGVoR+gHb6F+nI0jmywdPMV5XDV4oMzazaLpNuFGwwCzH16vtjCr6UZ4n3at3HiKN9CH2Ei5AZsg16/Ua/oE1axOm0BIMP5ML08hA5R3zUnzIqfeo8SnEz3+SKFXehA0K5AR7BkTUtwOVqytik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(186003)(2616005)(38100700002)(2906002)(26005)(6506007)(53546011)(6512007)(31686004)(5660300002)(6666004)(8936002)(36756003)(86362001)(6486002)(41300700001)(66946007)(31696002)(66476007)(478600001)(6916009)(4326008)(8676002)(66556008)(54906003)(316002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0tNbXhLRFlaZ0htNUx3VFRqMGhFdUFSL1FCcEZqN21TZ3lSWGdid2tCcnFB?=
 =?utf-8?B?UXYvMzRuY0lmMm1YbkI2NnJkK1ZLYlZJN2h2aWhsMXk5Y1d6ellUZXBPcko1?=
 =?utf-8?B?b0VMalJWUmhDQVR5V29DZWNWQ3UrUVMrejVGRWZYRlZTSXNqbEE5RGxWNDdO?=
 =?utf-8?B?Uy8vRzdON2RndGNaWnRVcUdvKzY0MjhXaW1CTVBJSU1RdDNKaFZ3aTk0WTJP?=
 =?utf-8?B?dGpxcC9ybkMxK2Nzd3ZibWFrRTMveGNNQ3NCUzRhQ3Jhc3h1OXh6d29RSi84?=
 =?utf-8?B?UmxiSENFSVN5Q3JyYnhST1NVZFZxalZqaUJibVZ0SmNibytsWWlpWjhQRUJm?=
 =?utf-8?B?ZEJoaUZTR3JLQnRpTUFFZHZlcUlYcDRoRlRyNXZEcVlPQURsR3UzUUkybDc2?=
 =?utf-8?B?THVyMnpqbzV5Zmpod3RVSUQxeEZwVDNxOVpyN3pkYUlrVTF2RkQ2dzFXNUxO?=
 =?utf-8?B?em5RWTdUby9jYkt4M3BHamhrS0pPeGJmaW0yMVZBMXY3WVZHQmxIVjc1c2lt?=
 =?utf-8?B?MXB2b3psYlY1T0E3amlvUGRreGJpUE5HQ2RMa2tPTEpaRnNUTTlVZ2ZMbU5z?=
 =?utf-8?B?YWJLd1JWS01JWlgrWUtacWx6clMyUy82MWE2dWRQYlBYcndzTVYyRjEvUy9M?=
 =?utf-8?B?Y1pabW1oZUQrSmRFVTJxZHpsYnZ4SmhlVFVibS9VN00yTE5ycWkzZjNpWWxX?=
 =?utf-8?B?M0pOSmFMb2ZHcjU1R0FpdlROQlYvV05Edy9JcVVaUGlETUdmTTBPRWxMNGZ3?=
 =?utf-8?B?cmV2c2JwTnUySkNVNCtCMTZxZEsrRjhJZFVDR1FjaGRYSm9GSVZRenNwNW5D?=
 =?utf-8?B?aXFZN2hnWUhKUVlLVm45dHJWK3pOK3A3Vms1Z0lObUthQlQwekVDTFpWWWZ5?=
 =?utf-8?B?M05oU0xsaUJ0NDFsWHRaUmgxbjVkK0ozRzF4SGNhczhxNnZPKzFsUGVCNFFz?=
 =?utf-8?B?TGZGcnZTUHJJTkVGTW9MSkIvZklRK1FqTythOFdSUHZzWjdBYjdGZmQvemlX?=
 =?utf-8?B?eGVBdXEyMXZGZHF0UjBZNG1INUloN25GaFNDbTBkc2VJc1kybnB3SjljVVRX?=
 =?utf-8?B?aFlKcWd4endIZWZ6am5nYWhYNjcxVWZCVnNiS1ZiYUl4Yi9qUjBBeFExeW8y?=
 =?utf-8?B?SUlDOFNCY2twbHd1YndzbndQZFhTNyt0OE5WeXppakJNVXdkOWUrZC8xRmNt?=
 =?utf-8?B?TkNmSTJRbUVpUC8zNlRNWVhzR2hlQjFWTW1ZVk50Qi82Ny9OZ0VPWU05Tk1q?=
 =?utf-8?B?VE5ndW1ud21WR0hFVDNMREFhekV6WkhLdDB1cEVSVy96YXpXZTVyaUZ3UWE1?=
 =?utf-8?B?c1Y4ZlZNUk9WLzVGQ0xUQjB5WW9IZUIrd2hHamxlNWxiaStWZytiM3M4eVl2?=
 =?utf-8?B?MmpBUVdZQ2x3MTR1cmYxbk1wcThiaVdIQVZwMUd6a1BYS05ydmY3cDdwbGYz?=
 =?utf-8?B?a1VDNnFPb0ZRLzh4U05GMW4vdzNLRDhSRGhta1VUVzU5bkl0LzlkOUtRYTRX?=
 =?utf-8?B?V084bW13ZmJ0R1pOZUlBTTRnSEdiQmgyQ040YWVjLzlydjd5UFREMThaUUpW?=
 =?utf-8?B?dFUvVWRqWFBYVEpVdjBQVmJXOXU4NkNIeGl4UVc5REhsN0daVXBZOHZxb1o4?=
 =?utf-8?B?TWNNRmRqaHU2b04yTStqdklGRXFCQkNvbEc1aFFBUTNlS3laMG1TcU1pbzh1?=
 =?utf-8?B?WjNsNm01bmhhL1g1Zk1GY1hoZVFpS1pmeTNjYVFWWEVHaFR0dlJab2NyY2g1?=
 =?utf-8?B?cVFSaG1HK2x1MUptOG9WQ29nMmJhYnI2QWNkQkI5dExISmdQbnZTNmFtb1dh?=
 =?utf-8?B?Y1I4dFVoaXQ4U1FwTjRWRm0rdjJwcEVHN0Y0TGhRUm52V2psd2RSMlZvRGht?=
 =?utf-8?B?MEg3ZUJ1c0czeE9raXAzWk9zQnkydnpZVHdjRm5HbFh4M1FMRnlxSGp3U3B3?=
 =?utf-8?B?R2Q5cGhDMWpLS1Q0MWJIS2dEbUxRRXpieXVGcXhsMEVXYUNlcUp3aTEzSlZW?=
 =?utf-8?B?cEhPcVZ1a1JoVi83WmNhRSt0QTd3MFZIQlBrY1JjOWtMY1dzeDZHakYvWGM2?=
 =?utf-8?B?S3JjcGNaT2l1VVd0Nnh1RUV0MVRNRjl6Z0x5Nm9OVloxcmtBbnUvSkQzeEcw?=
 =?utf-8?B?WjI4bER3NmxaRDI2OWh3RWVIT1A4amNvZWZZbHdwOEFSQ3hBS2RHSms4anJT?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906c7ba0-3ddd-4251-2f34-08db2aee9fed
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:00:57.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCRnM1jabCx7SJNsBSAPkSdH7amKVpPprvtNRIhMM03jhEB0X1yBCI0s26cFajRuxHWLfPqc265VLR8WpF14GueRi2UAfOOrh1qAC1dRSsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7796
X-Proofpoint-GUID: XEmmhip7L68O94e9NF5pO-DCe8F441Mh
X-Proofpoint-ORIG-GUID: XEmmhip7L68O94e9NF5pO-DCe8F441Mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 22/03/2023 15:57, Michal Hocko wrote:
> On Wed 22-03-23 14:25:25, Florian Schmidt wrote:
>> cgroups v1 has a unique way of setting up memory pressure notifications:
>> the user opens "memory.pressure_level" of the cgroup they want to
>> monitor for pressure, then open "cgroup.event_control" and write the fd
>> (among other things) to that file. memory.pressure_level has no other
>> use, specifically it does not support any read or write operations.
>> Consequently, no handlers are provided, and the file ends up with
>> permissions 000. However, to actually use the mechanism, the subscribing
>> user must have read access to the file and open the fd for reading, see
>> memcg_write_event_control().
>>
>> This is all fine as long as the subscribing process runs as root and is
>> otherwise unconfined by further restrictions. However, if you add strict
>> access controls such as selinux, the permission bits will be enforced,
>> and opening memory.pressure_level for reading will fail, preventing the
>> process from subscribing, even as root.
>>
>>
>> There are several ways around this issue, but adding a dummy read
>> handler seems like the least invasive to me.
> 
> I was struggling to see how that addresses the problem because all you
> need is a read permission. But then I've looked into cgroup code and
> learned that permissions are constructed based on available callbacks
> (cgroup_file_mode). This would have made the review easier ;)

Oh, sorry, I forgot to mention that salient detail!
I didn't check whether that was a common pattern or not...


> 
> I have no issue with the patch. It would be great to hear from cgroup
> maintainers whether a concept of default permissions is something that
> would be useful also for other files.
> 
>> I'd be interested to hear:
>> (a) do you think there is a less invasive way? Alternatively, we could
>>      add a flag in cftype in include/linux/cgroup-defs.h, but that seems
>>      more invasive for what is a legacy interface.
>> (b) would you be interested to take this patch, or is it too niche a fix
>>      for a legacy subsystem?
> 
> After you add your s-o-b, feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> If cgroup people find a concept of default permissions for a cgroup file
> sound then this could be replaced by that approach but this is really an
> easy workaround.

Will do, once I know the path forward and construct a proper commit 
message, I'll add the s-o-b and ack.

>> ---
>>   mm/memcontrol.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 5abffe6f8389..e48c749d9724 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3734,6 +3734,16 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>>   	}
>>   }
>>   
>> +/*
>> + * This function doesn't do anything useful. Its only job is to provide a read
>> + * handler so that the file gets read permissions when it's created.
> 
> I would just reference cgroup_file_mode() in the comment to make our
> lifes easier and comment more helpful.

Ack.


> 
>> + */
>> +static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
>> +				     __always_unused void *v)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>>   #ifdef CONFIG_MEMCG_KMEM
>>   static int memcg_online_kmem(struct mem_cgroup *memcg)
>>   {
>> @@ -5064,6 +5074,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
>>   	},
>>   	{
>>   		.name = "pressure_level",
>> +		.seq_show = mem_cgroup_dummy_seq_show,
>>   	},
>>   #ifdef CONFIG_NUMA
>>   	{
>> -- 
>> 2.32.0
> 
