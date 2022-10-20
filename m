Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA2605778
	for <lists+cgroups@lfdr.de>; Thu, 20 Oct 2022 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJTGkj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Oct 2022 02:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJTGkh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Oct 2022 02:40:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC5102DE4;
        Wed, 19 Oct 2022 23:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1YEO2KkuQZoS2Yt/3FyqA1WTWY0Bx/Z7M0FAVDJ+djNOESanFk8WxgICQj3r/eWH4LXxolFivp4OVnmMISWghnr7LZD8jMbdSXlBNSYIEoWRAgbp8PUFPAk/cv1a1QRFoDoBxPVP7vL6BLpL55xCSILA1tVOJx73iyGtw1K4A/OSbVQKC0AGsmHEkLh5RN+rvOyFlPdClCGtP0/BfMVGCMd5QDO53E1DuuLq+swHuQLkuEmGQC6/8NtxdkHKSEhK/Or/Oh61t66TtIaL7o1cYZnUxoKRe1mYhrpaxS6Mo/kStR1nka6h2luEWZpazLKbmnLdoeSouZXwoZUkcEFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRjd5gGc5dM0iyvE+7fKZbFCMXIeMKgSXAWDB/qHzew=;
 b=geJEY2vrFBFusflg4BX6Gvlx7OvJlvrwMRdhrIp9Ogadi+xwQ7f5RU2F5q9bzLiyAPr7w3WxHhOOeDX6shyTA0oRG6V4zRAZYgv2FZym05P27+4ez7LrAl6hFHJ3B4JRHIkNj3vSmnPcC3x2d2n1NGlIlzplirs1JpYjRWwvRxUyF/eew5mSgG96rE+PUQXgq+vdj071R4ZwFTVm8z3Kfk7WjEtVNUOXAX9bwzFx0c5P6FxCGUbpGFw2MGT8AGTuPRP4KYOcq2jEC1pUm1JvbQRrcUsFvlQgTiCuaH+hA7G1HxowsK/Lb72hcr6DzWca6zzkqlQ/U4cUjwKXCjkRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRjd5gGc5dM0iyvE+7fKZbFCMXIeMKgSXAWDB/qHzew=;
 b=5q4B6jvVBWsBrDUdudIjXVdr4hkFwGQ9v9NZFsY6/VWvFQY3Mk7eTOLy2DE6hHCNiXHcN/TgyQRLmB98norx5cfS+xOvOM18qDka9tHsECTc5QSPSbYtLGcd7N9/fv1PTYUxSYQuA1a/Z/4YvICwASaXArwZw4SnK4DWT7dZTzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 06:40:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 06:40:33 +0000
Message-ID: <77499370-bb0e-7f7e-ac1b-ad14f47578d9@amd.com>
Date:   Thu, 20 Oct 2022 08:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 02/17] drm: Track clients per owning process
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
 <20221019173254.3361334-3-tvrtko.ursulin@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221019173254.3361334-3-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0104.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::45) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bcb665-a850-4bff-3fba-08dab265fd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFQi2Cjv/7mG6sVQC5pcdzIOM5nyhQ5wW/mBWnrLW2G6tlYcPz1avai10XdfexRbAnaaM+4+WPC56r9vvs3T1jGTr4fvqTalutT4x2B/pt+cEDj5mwq6Xj6v/cD5CLm88KiQ3FIkZiJiDMmUXH2Y6LD0pcRtgKCsLjP/mNWWM/uOQ1Fv2Ku2Z8MF1sWICSMnGAXqTiJAcGUnPQGfU43q2k0XuBrA9Wo8AJe3N0lvNRjAquoBvVhQvVeBufD1dxv0kdGG/az3Aw2tb9lpqpkA/gQtCumYl3EagL6nalaxbXFf6KkvDHVEIsvFR791YPIBDWZ//VCV3oC8uxuBqy/N6Ngu4HjlkhfQoamt/CC6VXzyXMhNwIapH4byQ2/bP1K/ArFLLeULQhhrYhld4F6BkGIJXdXD+dTCoasmpxBjStMj45yxCXBhUUGFv16v54CClyJ3J3NPE+Wz2Gb7nYAU/Tf4PSzfYtQ15RvnkRWuB4SYWBIo9Hv0NoQhoX3LZKHCz/iR5NEVLlUJc0ZOqbdItidMsgO5A7i/g/VeqGJJCu1qWRS1ZTfCQLK8QEj/p3RwzaUbg/IHgVZ5bHJEV40sXUIT7A0pLH6VwZ0hP7y01/1yLvb1GZIaEkv/CYuS633LZMNKO11WiH0Zzba1jBTQ3JG+otQoXvAX5dI1OJqsLsoSteuZjmkPY4fMxqFnOddCIBsVLjlfq+p+JaX1C+EALxYAiAKXUl766OZ+HC97oCahwQmAICu3JrtbNPHDVR26cRA3oa+pI2MmF3KzbkTwioWXJGolEd4QR+r0s5TJNGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(186003)(478600001)(6486002)(31686004)(2616005)(2906002)(8936002)(38100700002)(83380400001)(36756003)(6666004)(5660300002)(316002)(7416002)(8676002)(41300700001)(6506007)(66946007)(66556008)(66476007)(4326008)(31696002)(6512007)(54906003)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BtRnJicHZnSVZOa0FweVExTWdlSmNjTDQwQ3JEeCtTV3Y0NjNvUDdBY1B1?=
 =?utf-8?B?dDg0cCt4aTZ6K1pPK1JZSUlYU2FwT0N5azdpM2NCajNnWjFzWE1Wazh3Yzkw?=
 =?utf-8?B?TU5qa3g1U1pEekx4b2tqVnk2VFNzaE16TGFXZHlJbkRvSXl1UXl5Wk9USitM?=
 =?utf-8?B?b0JnT3hBQmFHWXBwempJWEdDQjB2TWdvMktpeXVJTGNJTTNIelR6Smo5c0tW?=
 =?utf-8?B?Q3NVUURNWEp0U0o0bDFPbWh1cUVMVnBUREc2VUh0TUZWOC92Q2hXV1V2b0ZN?=
 =?utf-8?B?b2U4Y2FmODhDcFpoOXJQY1o0UVlqZHdvcmtIZEREWkhOZVVLZ2JEODVVWENu?=
 =?utf-8?B?MnU4WEpGbHRROTFvSHBzL1lmalpXTUh6azUzSytFZVhjOGNEQlNtdzVrSnNK?=
 =?utf-8?B?YWYxWnd6aCtYb0wzQVU2a0ZzLzIrejZScUZBZmZJTnJlUUZOTytOcEtYMlZM?=
 =?utf-8?B?NmExdEVreWJOVnNuUklQYUtvNjNWaVBiejJhUStyTDBOcWtrUTUxVVpzb2hU?=
 =?utf-8?B?eHZNK3h4eEdjT0c5bXFLSXA3MmV3Z2ppTUtMbWtlWXRaR29aWmxEUkd2cVVM?=
 =?utf-8?B?d0RWeE9JcStFS2VYT1ZzUXhvTVFUSVBaMVNmZnFFY0NuY0Rrd0RWOHlmRlVj?=
 =?utf-8?B?c2hUUXZmMmQwem1TRGJFckVqbmlPem9IMndNVzdDc1VseERUOEpRa3dGZTRu?=
 =?utf-8?B?a0NHdFY4QTJCTzY1cnZHVDYwcUEvbDJUazhPT0hLN0Rwc3l2bk95d0RLMHRq?=
 =?utf-8?B?Yy9EdjFPUmZEZ0NXYVIrWlNwUVk2MDFrVG1qdkNpY3RwVkNPL2VtS3Z6T3pW?=
 =?utf-8?B?YXJtOHBtOUY5a01McDlKRzhwMW12Qy9DVUtiMDlEM0QrTW5CTHJidXpOUGhL?=
 =?utf-8?B?eWRZZWNIbkFqMkI3eUVLVzBLRlJoODExZjFGQTg4bzZwSTRHeUxicFpZa3VH?=
 =?utf-8?B?R1krNE5YRmVGcVIrSnk0NlhQL3p5bHZBZWYzUHpYbHlUbFB5L2FDbk9FNFc1?=
 =?utf-8?B?QXJCT2lNMHZPNkQ1OTZwMUhMeEhnSmREUUtiTzJUZUFnWXkwdGVZVys3a2Jj?=
 =?utf-8?B?aFV5MDdnd201SS9PM3lwblgxdHowTkR3RmcwU1pnWmxnYmFPb0hEdERFa1pC?=
 =?utf-8?B?QzZId2VJUHRvN1E0RGNrN04yZHpPWjkrNWVLZVhxVW92NkNXUm43NzFOZnNr?=
 =?utf-8?B?S01kWURkSVhEOUxMazNMUnBiRmwyVEV2Mk4vc25MaDNtemxIL0NVQkozUkxw?=
 =?utf-8?B?b0ZDSnRhQ0tUWC9vUUdtdElRdllwZ0hTdEs5aXFKVWhpc0t1MFFwRFVoc2pp?=
 =?utf-8?B?MkJhajFlU2ZOdjJEYlZvUGdjbXFQQURhTnMyNTVQcmttYlQrSUEzakpsWW9i?=
 =?utf-8?B?eW5FSVc2alJQdjRPb1VOU2lmMGZnTVBGbVZvV1A5NjRhYnBjZlhxSHYzNmRP?=
 =?utf-8?B?ZkM4QnZVd2lzY2xxV0VrdWRRNm1ybmkwWlNPSlFGanEwV0VjOWx6MkRXRDdQ?=
 =?utf-8?B?TkZUeEI4eVFrTmNyYXJHeElndmNTQ2xsVGtTTlhKaVIvSFVGYm5CaDJucUVW?=
 =?utf-8?B?Y3BiWVBaTmdjVCtNbWY3T05STVNoQTdtaUk3MGN2TC9ESGptRnhodmZxY0sx?=
 =?utf-8?B?ZXR6RTdQN0lOakRyS0ZXQ3MzbHU4S1ZKSngrYTdkdzZCY3FXd1EvbFBoVHd2?=
 =?utf-8?B?S3hEYnNuMkhJdlVVZVRHMUpSbHgybDBBYW53MVp3VG1hYXh2ejlqY0dMSm1R?=
 =?utf-8?B?dy9vbHpXa29kYmdPL0p3UXdpL2hiOHI5Um9EZzNPNHZlQUxRSjh2ZGVHdnM5?=
 =?utf-8?B?Nmh5WGdFQjlQWkUrNVhEN0k4Ui9manNCSDlkMmRYRkUzWUoxQ08wSEV6ZlZC?=
 =?utf-8?B?Tmg4eWhURUMreWlWUTJwcW9Bb3FMWUJURXJxUHJkTWRGQU9wUFNGNmpsWDZD?=
 =?utf-8?B?Y2kraWRhV2pnYS9iNFcrWkJCVDN2NjdOTlBIc3QyaHprVE15VUJFS2pWcXR1?=
 =?utf-8?B?QkN0YkVTQmtNRWFoSzcwWHdOdFNrVkJlZHJJWG5tZHZVQklQem96NG9lRGhH?=
 =?utf-8?B?QkpKM0p1UGNGQjFPUmtUUVloSml2eVl6bHU3WnhDTXlUR3p2bWxVMVJ1WHNE?=
 =?utf-8?Q?2IqwIJQKlFzSc+XuCfTpI+Byv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bcb665-a850-4bff-3fba-08dab265fd38
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 06:40:33.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldqjbDHW4AByf1vZ+aYbKbckJMOoKVBnP6aCBCsFIVaUSB73fRLrTk8NDIOEf5Yj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 19.10.22 um 19:32 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> To enable propagation of settings from the cgroup drm controller to drm we
> need to start tracking which processes own which drm clients.
>
> Implement that by tracking the struct pid pointer of the owning process in
> a new XArray, pointing to a structure containing a list of associated
> struct drm_file pointers.
>
> Clients are added and removed under the filelist mutex and RCU list
> operations are used below it to allow for lockless lookup.

That won't work easily like this. The problem is that file_priv->pid is 
usually not accurate these days:

 From the debugfs clients file:

       systemd-logind   773   0   y    y     0          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
              firefox  2945 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
               chrome 35940 128   n    n  1000          0
               chrome 35940   0   n    y  1000          1
               chrome 35940   0   n    y  1000          2
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0
                 Xorg  1639 128   n    n  1000          0

This is with glxgears and a bunch other OpenGL applications running.

The problem is that for most applications the X/Wayland server is now 
opening the render node. The only exceptions in this case are apps using 
DRI2 (VA-API?).

I always wanted to fix this and actually track who is using the file 
descriptor instead of who opened it, but never had the time to do this.

I think you need to fix this problem first. And BTW: and unsigned long 
doesn't work as PID either with containers.

Regards,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> ---
>   drivers/gpu/drm/Makefile     |  1 +
>   drivers/gpu/drm/drm_cgroup.c | 60 ++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_file.c   | 18 ++++++++---
>   include/drm/drm_clients.h    | 31 +++++++++++++++++++
>   include/drm/drm_file.h       |  4 +++
>   5 files changed, 110 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_cgroup.c
>   create mode 100644 include/drm/drm_clients.h
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 6e55c47288e4..0719970d17ee 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -59,6 +59,7 @@ drm-$(CONFIG_DRM_LEGACY) += \
>   	drm_scatter.o \
>   	drm_vm.o
>   drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
> +drm-$(CONFIG_CGROUP_DRM) += drm_cgroup.o
>   drm-$(CONFIG_COMPAT) += drm_ioc32.o
>   drm-$(CONFIG_DRM_PANEL) += drm_panel.o
>   drm-$(CONFIG_OF) += drm_of.o
> diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
> new file mode 100644
> index 000000000000..a31ff1d593ab
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_cgroup.c
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2022 Intel Corporation
> + */
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_clients.h>
> +
> +static DEFINE_XARRAY(drm_pid_clients);
> +
> +void drm_clients_close(struct drm_file *file_priv)
> +{
> +	unsigned long pid = (unsigned long)file_priv->pid;
> +	struct drm_device *dev = file_priv->minor->dev;
> +	struct drm_pid_clients *clients;
> +
> +	lockdep_assert_held(&dev->filelist_mutex);
> +
> +	clients = xa_load(&drm_pid_clients, pid);
> +	list_del_rcu(&file_priv->clink);
> +	if (atomic_dec_and_test(&clients->num)) {
> +		xa_erase(&drm_pid_clients, pid);
> +		kfree_rcu(clients, rcu);
> +	}
> +}
> +
> +int drm_clients_open(struct drm_file *file_priv)
> +{
> +	unsigned long pid = (unsigned long)file_priv->pid;
> +	struct drm_device *dev = file_priv->minor->dev;
> +	struct drm_pid_clients *clients;
> +	bool new_client = false;
> +
> +	lockdep_assert_held(&dev->filelist_mutex);
> +
> +	clients = xa_load(&drm_pid_clients, pid);
> +	if (!clients) {
> +		clients = kmalloc(sizeof(*clients), GFP_KERNEL);
> +		if (!clients)
> +			return -ENOMEM;
> +		atomic_set(&clients->num, 0);
> +		INIT_LIST_HEAD(&clients->file_list);
> +		init_rcu_head(&clients->rcu);
> +		new_client = true;
> +	}
> +	atomic_inc(&clients->num);
> +	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
> +	if (new_client) {
> +		void *xret;
> +
> +		xret = xa_store(&drm_pid_clients, pid, clients, GFP_KERNEL);
> +		if (xa_err(xret)) {
> +			list_del_init(&file_priv->clink);
> +			kfree(clients);
> +			return PTR_ERR(clients);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index a8b4d918e9a3..ce58d5c513db 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -40,6 +40,7 @@
>   #include <linux/slab.h>
>   
>   #include <drm/drm_client.h>
> +#include <drm/drm_clients.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_print.h>
> @@ -298,6 +299,7 @@ static void drm_close_helper(struct file *filp)
>   
>   	mutex_lock(&dev->filelist_mutex);
>   	list_del(&file_priv->lhead);
> +	drm_clients_close(file_priv);
>   	mutex_unlock(&dev->filelist_mutex);
>   
>   	drm_file_free(file_priv);
> @@ -349,10 +351,8 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
>   
>   	if (drm_is_primary_client(priv)) {
>   		ret = drm_master_open(priv);
> -		if (ret) {
> -			drm_file_free(priv);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_free;
>   	}
>   
>   	filp->private_data = priv;
> @@ -360,6 +360,9 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
>   	priv->filp = filp;
>   
>   	mutex_lock(&dev->filelist_mutex);
> +	ret = drm_clients_open(priv);
> +	if (ret)
> +		goto err_unlock;
>   	list_add(&priv->lhead, &dev->filelist);
>   	mutex_unlock(&dev->filelist_mutex);
>   
> @@ -387,6 +390,13 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
>   #endif
>   
>   	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&dev->filelist_mutex);
> +err_free:
> +	drm_file_free(priv);
> +
> +	return ret;
>   }
>   
>   /**
> diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
> new file mode 100644
> index 000000000000..4ae553a03d1e
> --- /dev/null
> +++ b/include/drm/drm_clients.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2022 Intel Corporation
> + */
> +
> +#ifndef _DRM_CLIENTS_H_
> +#define _DRM_CLIENTS_H_
> +
> +#include <drm/drm_file.h>
> +
> +struct drm_pid_clients {
> +	atomic_t num;
> +	struct list_head file_list;
> +	struct rcu_head rcu;
> +};
> +
> +#if IS_ENABLED(CONFIG_CGROUP_DRM)
> +void drm_clients_close(struct drm_file *file_priv);
> +int drm_clients_open(struct drm_file *file_priv);
> +#else
> +static inline void drm_clients_close(struct drm_file *file_priv)
> +{
> +}
> +
> +static inline int drm_clients_open(struct drm_file *file_priv)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index d780fd151789..0965eb111f24 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -268,6 +268,10 @@ struct drm_file {
>   	/** @minor: &struct drm_minor for this file. */
>   	struct drm_minor *minor;
>   
> +#if IS_ENABLED(CONFIG_CGROUP_DRM)
> +	struct list_head clink;
> +#endif
> +
>   	/**
>   	 * @object_idr:
>   	 *

