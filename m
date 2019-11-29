Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE91E10DA78
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2019 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2UKw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Nov 2019 15:10:52 -0500
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:26432
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfK2UKw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 29 Nov 2019 15:10:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYVXlRCcPEi3SJj4XEgl8MuubaWPpFAP47R24yzNBDjuSHvve3Tz3eSZQ30gRBs/sigeRZJpftdF/qjGH0DAI7f23PBfIKip48/nmaJieZ7QS0u9qqX5YHWOacE2r063Qq6q6FZuFsk1P+eT+LZP01F26cttIfP31zKu62HMgtdRjrAA5wopam8+skhht+SV8m0y6zRtcRhyjScZYf4fRt6m2ASAURVPWhuo6Xiak4vOlMCg3DrXJbIjApF9+TNg0AUSD0QZEdZbcF7A9HvQ65t2Hbta/3HVcjYRQQQ+QYO41DVoFFrGwGF7TINR5P0y1HaW4Fre8ByL22OHdzn3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMYoh1L/nswRC5J2bak673j2tmP7BBtku0I9XjgiYqk=;
 b=lypjIIVQwR9xwprXekNWJmhngezlZGCydQvJit+NXj/cUaABvoDI2NTaWL8IowRUbh2/4xKPd0kLGxNtnm/ijKw5szsQ9eystYaWRv/Y21sNbmTiVLs19gq4oiHgcTEBjgmj3lknXmSn6A36wgS7LB//JBtmOHPUqS+s6/YUE4lDAlfvKh+NRILts0yZ8MLWqqiqvaSy2/+2pQJbQAUlsWJyie/rkYoev/hYMCo3j/OO2DFq0IdlxTjPQ3/1bzIa/z4mOmPTTzyPu3owLmH6VBEZGiOWj3Sfhb/oRrUuMn+WryD2cvpIBlgvjw39byIstGw4AaSA1m//4ubDCkAOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMYoh1L/nswRC5J2bak673j2tmP7BBtku0I9XjgiYqk=;
 b=i9CVAI7Oy3ODfM1ewx4UkaQJZI3PVbe0JajgEr3nKnomkbi/hmfgw1iCGneCg1ECq3QbLznrxuOhi7fyiP+zFXK64ZnGcov82NOWZDggz4LE1dRUft2mjed1Ij+d9xgHmH0U4Je6oJLC35tMybfGiHDMsF6c/B2swIjgHCv/NlY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2985.namprd12.prod.outlook.com (20.178.29.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 20:10:10 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 20:10:10 +0000
Subject: Re: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
To:     "tj@kernel.org" <tj@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
Cc:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
 <20191009103153.GU16989@phenom.ffwll.local>
 <ee873e89-48fd-c4c9-1ce0-73965f4ad2ba@amd.com>
 <20191009153429.GI16989@phenom.ffwll.local>
 <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com>
 <20191009160652.GO16989@phenom.ffwll.local>
 <20191011171247.GC18794@devbig004.ftw2.facebook.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1a31dded-b386-0da4-3ff7-d6f4e767de75@amd.com>
Date:   Fri, 29 Nov 2019 15:10:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011171247.GC18794@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e6666af-1926-46be-4847-08d7750822ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:|DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29853C0AA791BEE793E1CA2F92460@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(2501003)(446003)(81166006)(81156014)(44832011)(31686004)(14444005)(11346002)(2616005)(110136005)(316002)(65956001)(186003)(58126008)(4001150100001)(50466002)(47776003)(6246003)(66556008)(53546011)(229853002)(8676002)(386003)(6506007)(52116002)(36916002)(2486003)(7736002)(26005)(76176011)(23676004)(54906003)(66946007)(3846002)(478600001)(6436002)(5660300002)(6512007)(99286004)(305945005)(14454004)(36756003)(86362001)(4326008)(8936002)(65806001)(31696002)(66476007)(66066001)(6116002)(25786009)(2870700001)(2906002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2985;H:DM6PR12MB3947.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7iRlcVK7cQeD4EjASIAnb9LKO5IgEKyH/B8MwLfgqnYbtfg9KJr1ezIf+7gCgCsKVjpB4m14y30Irx2ST9fAsv5cafDoN/5eDfqnCKxn7V8vxAX/zze8dV0QjDr+oDs/cKXoC8hU8Ko0bIX0sSrBScjl/ewDXqDBpquoxIs9TFKVykOCF+WuwePwCPbIs6p+2hwhDf2h9l05FaZDWoLKj/20yevB8QB1P332aksaFCG9/asCOGEa7/GBmVJB63QFdEkUzOdjy82uGjGvfGh0jZYp7ZjJUPp5axnWRua5mGrWDRk0A+acH1QeXVztFSA55lMUJ3cG1WtCcOoo1GjU9MhxyQomNbovjPbYaqsMb9QeetFte04R3DtaI7WRGhrsJ7nBwKyJ6sPqEUAsmcDODaCy7yAd663QcqGEsUCvFTJmRWBUPD0j4uEmHEPJO2V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6666af-1926-46be-4847-08d7750822ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 20:10:09.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8uB+9auv5bMZc2Uv5tshH9huEm/p8QGwQZkZTRRln/umqtDRZERTtgS4GoV7Zn9hfW2Mq41VIf6QIuUYaqyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2019-10-11 1:12 p.m., tj@kernel.org wrote:
> Hello, Daniel.
>
> On Wed, Oct 09, 2019 at 06:06:52PM +0200, Daniel Vetter wrote:
>> That's not the point I was making. For cpu cgroups there's a very well
>> defined connection between the cpu bitmasks/numbers in cgroups and the cpu
>> bitmasks you use in various system calls (they match). And that stuff
>> works across vendors.
> Please note that there are a lot of limitations even to cpuset.
> Affinity is easy to implement and seems attractive in terms of
> absolute isolation but it's inherently cumbersome and limited in
> granularity and can lead to surprising failure modes where contention
> on one cpu can't be resolved by the load balancer and leads to system
> wide slowdowns / stalls caused by the dependency chain anchored at the
> affinity limited tasks.
>
> Maybe this is a less of a problem for gpu workloads but in general the
> more constraints are put on scheduling, the more likely is the system
> to develop twisted dependency chains while other parts of the system
> are sitting idle.
>
> How does scheduling currently work when there are competing gpu
> workloads?  There gotta be some fairness provision whether that's unit
> allocation based or time slicing, right?

The scheduling of competing workloads on GPUs is handled in hardware and 
firmware. The Linux kernel and driver are not really involved. We have 
some knobs we can tweak in the driver (queue and pipe priorities, 
resource reservations for certain types of workloads), but they are 
pretty HW-specific and I wouldn't make any claims about fairness.

Regards,
   Felix

>    If that's the case, it might
> be best to implement proportional control on top of that.
> Work-conserving mechanisms are the most versatile, easiest to use and
> least likely to cause regressions.
>
> Thanks.
>
