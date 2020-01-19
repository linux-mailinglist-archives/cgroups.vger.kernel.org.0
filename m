Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFC141DF6
	for <lists+cgroups@lfdr.de>; Sun, 19 Jan 2020 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgASNEO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jan 2020 08:04:14 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:6162
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgASNEO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 19 Jan 2020 08:04:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSmms3gtm/z/her+7dIUuhdsvERRp+SocQMHmMUeUfXoZfnrgFS7onSz3+Utps4QXkPWiVd4u8y1f0L11F+6YV92YqjQJkV/uSPzIiwz+meySTqSuBukObhx2OnEDbiQxTuw2iC0WFpNr8/30foqGK81xNFqLt1uRakwiyl0+J6XvI+8GElbkXdhOuhE5lV2TaoZ6jffo4n7yRNwhP45kH7np5NnSrXdcqvlYFw745+ano9EnCwILkkEJkZtaVYJ8RYMK80h3WMXMNTyKJKtryGRthncaZOpgjIXTkrnvTQuk/RT9VXXoy40HYmG6YowlI59WUvTVirNqF5L3Ls38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lc3KPrSxN4ypxUGuaIhLzwAb/+yrCobaCHQgDGRk9Q=;
 b=DWHf0VuQRO+x3TPdpg/JA8kT8/LtHSZ65OjwPhGm7yr2kX94ASfJ85dVUbjECo1JKanWFE+oi/rPFvyFStFqHW3mZ+OT2lthPcopjRCF0vfj8WIRbs3KKGPwNUl7mjWb4I/8bso2aCE0wUak8g/ZLEHdf9BOkHcKvUyyxja3O60bWd0S4okrsKu+SLSbxdwKMKvEHtZQ+xVd/DtDarTvdmjfbwDULP0016xoeqDPOhYtEUZyt6U3jIKK3MwkT+HxucN5u6SxXg9ObwVpQmbWOaYKQwRj3OgQxwZRFPiWoVVzo/g1jVsUDvcZcaMg9Y0Y9xEi7WHbApfwQIyvtHqKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lc3KPrSxN4ypxUGuaIhLzwAb/+yrCobaCHQgDGRk9Q=;
 b=iWTCYkYeY7NTtgfDfHmx4h66voULX2xbgR06XKj/F0tgzopXvax2aWlCfEuYAGwKNR/mKmJzVVFS8QvbjfEjtneF4zDzuP0mzEfrpFusRQZeNd/Yh8faEggDGYTeM0CUnS8VUzasAYQlVASKHlhMq0NiIMUgWYP/XbS1Zx46RKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1177.namprd12.prod.outlook.com (10.168.233.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Sun, 19 Jan 2020 13:04:05 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 13:04:05 +0000
Subject: Re: [PATCH RFC 3/3] drm/ttm: support memcg for ttm_tt
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Qiang Yu <qiang.yu@amd.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Kenny Ho <kenny.ho@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200113153543.24957-1-qiang.yu@amd.com>
 <20200113153543.24957-4-qiang.yu@amd.com>
 <f2075f28-94a2-1206-ba58-a3a6a32393f3@amd.com>
 <CAKGbVbv7P-S_NUYpqQ5opDbXBHRb4rq6m95372nOuZ8kMvGnBQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0164fcbf-393a-237f-69d7-aa26dabe6ad9@amd.com>
Date:   Sun, 19 Jan 2020 14:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAKGbVbv7P-S_NUYpqQ5opDbXBHRb4rq6m95372nOuZ8kMvGnBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0069.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::46) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR06CA0069.eurprd06.prod.outlook.com (2603:10a6:208:aa::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Sun, 19 Jan 2020 13:04:03 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4167b2c0-f824-4390-52c3-08d79ce01009
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:|DM5PR12MB1177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11776B089E2980CB409269EB83330@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(316002)(4326008)(31696002)(5660300002)(86362001)(45080400002)(36756003)(6486002)(8936002)(66946007)(8676002)(81156014)(54906003)(2616005)(66556008)(66476007)(6916009)(81166006)(52116002)(66574012)(53546011)(2906002)(478600001)(966005)(186003)(31686004)(6666004)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1177;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Hw3Z0mPHU48t+e0oEHQRfrWcxqBHQQkveTtRQqImAMXA0qUM9I8EJEcNxSQL0eMbtYRRI3pU4wz71BCn711SZpnfV93EYzaB5/dJuYIbJ41McZHDNvO7KCBweK3BzHdCAJONV15g5gmnXrGP1M5KZw9Fif4CCXyMXTXnMNVLN59OVlkuOXdQ+50SC2BgytCrAvczs8ctcvRFNgLMMlkZ/TkWjWgiE5A8rvHwYYVVUQEL5t5bIFrLuO0vsFrfWqv2C6oJ3USgqt/HZaqRKWTQ26O/3rNyUYZJ7NpwM9dcUbxC7PQAk3dis2SaGprG6aCKic0qgCEwwBze3UmzQXL2ZD42VTScQ0Om4BMbPbjrOWsrUlh27PQQ4G+ZRWCnKU9BMiOuaVwAtTkrZiz8HMoawrXh+QSha2uHRBlffZKbYb6SfWbJjhVzhoZqlmJgDJ5nkNMZuyqcm7vzHqEQTYJVXi8sF2alYpwH1qbwYHTcbw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4167b2c0-f824-4390-52c3-08d79ce01009
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 13:04:05.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvhTWEGuBBJ1WWCfeoFj+Jwao5QwMFo4aijXaVUrADrKzOJAwzaLs8mzV15dCqwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 19.01.20 um 03:47 schrieb Qiang Yu:
> On Mon, Jan 13, 2020 at 11:56 PM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 13.01.20 um 16:35 schrieb Qiang Yu:
>>> Charge TTM allocated system memory to memory cgroup which will
>>> limit the memory usage of a group of processes.
>> NAK to the whole approach. This belongs into the GEM or driver layer,
>> but not into TTM.
>>
> Sorry for responding late.
>
> GEM layer seems not a proper place to handle this as:
> 1. it is not aware of the back storage (system mem or device mem) unless
> we add this information up to GEM which I think is not appropriate
> 2. system memory allocated by GEM with drm_gem_get_pages() is already
> charged to memcg, it's only the ttm system memory not charged to memcg

The key point is that we already discussed this on the mailing list and 
GEM was agreed on to be the right place for this.

That's the reason why the Intel developers already proposed a way to 
expose the buffer location in GEM.

Please sync up with Kenny who is leading the development efforts and 
with the Intel developers before warming up an old discussion again.

Adding that to TTM is an absolute no-go from my maintainers perspective.

>
> Implement in driver like amdgpu is an option. But seems the problem is inside
> TTM which does not charge pages allocated by itself to memcg, won't it be
> better to solve it in TTM so that all drivers using it can benefit? Or you just
> think we should not rely on memcg for GPU system memory limitation?
>
>>> The memory is always charged to the control group of task which
>>> create this buffer object and when it's created. For example,
>>> when a buffer is created by process A and exported to process B,
>>> then process B populate this buffer, the memory is still charged
>>> to process A's memcg; if a buffer is created by process A when in
>>> memcg B, then A is moved to memcg C and populate this buffer, it
>>> will charge memcg B.
>> This is actually the most common use case for graphics application where
>> the X server allocates most of the backing store.
>>
>> So we need a better handling than just accounting the memory to whoever
>> allocated it first.
>>
> You mean the application based on DRI2 and X11 protocol draw? I think this
> is still reasonable to charge xserver for the memory, because xserver allocate
> the buffer and share to application which is its design and implementation
> nature. With DRI3, the buffer is allocated by application, also
> suitable for this
> approach.

That is a way to simplistic.

Again we already discussed this and the agreed compromise is to charge 
the application which is using the memory and not who has allocated it.

So you need to add the charge on importing a buffer and not just when it 
is created.

Regards,
Christian.

>
> Regards,
> Qiang
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/ttm/ttm_bo.c         | 10 ++++++++++
>>>    drivers/gpu/drm/ttm/ttm_page_alloc.c | 18 +++++++++++++++++-
>>>    drivers/gpu/drm/ttm/ttm_tt.c         |  3 +++
>>>    include/drm/ttm/ttm_bo_api.h         |  5 +++++
>>>    include/drm/ttm/ttm_tt.h             |  4 ++++
>>>    5 files changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index 8d91b0428af1..4e64846ee523 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -42,6 +42,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/atomic.h>
>>>    #include <linux/dma-resv.h>
>>> +#include <linux/memcontrol.h>
>>>
>>>    static void ttm_bo_global_kobj_release(struct kobject *kobj);
>>>
>>> @@ -162,6 +163,10 @@ static void ttm_bo_release_list(struct kref *list_kref)
>>>        if (!ttm_bo_uses_embedded_gem_object(bo))
>>>                dma_resv_fini(&bo->base._resv);
>>>        mutex_destroy(&bo->wu_mutex);
>>> +#ifdef CONFIG_MEMCG
>>> +     if (bo->memcg)
>>> +             css_put(&bo->memcg->css);
>>> +#endif
>>>        bo->destroy(bo);
>>>        ttm_mem_global_free(&ttm_mem_glob, acc_size);
>>>    }
>>> @@ -1330,6 +1335,11 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
>>>        }
>>>        atomic_inc(&ttm_bo_glob.bo_count);
>>>
>>> +#ifdef CONFIG_MEMCG
>>> +     if (bo->type == ttm_bo_type_device)
>>> +             bo->memcg = mem_cgroup_driver_get_from_current();
>>> +#endif
>>> +
>>>        /*
>>>         * For ttm_bo_type_device buffers, allocate
>>>         * address space from the device.
>>> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
>>> index b40a4678c296..ecd1831a1d38 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
>>> @@ -42,7 +42,7 @@
>>>    #include <linux/seq_file.h> /* for seq_printf */
>>>    #include <linux/slab.h>
>>>    #include <linux/dma-mapping.h>
>>> -
>>> +#include <linux/memcontrol.h>
>>>    #include <linux/atomic.h>
>>>
>>>    #include <drm/ttm/ttm_bo_driver.h>
>>> @@ -1045,6 +1045,11 @@ ttm_pool_unpopulate_helper(struct ttm_tt *ttm, unsigned mem_count_update)
>>>        ttm_put_pages(ttm->pages, ttm->num_pages, ttm->page_flags,
>>>                      ttm->caching_state);
>>>        ttm->state = tt_unpopulated;
>>> +
>>> +#ifdef CONFIG_MEMCG
>>> +     if (ttm->memcg)
>>> +             mem_cgroup_uncharge_drvmem(ttm->memcg, ttm->num_pages);
>>> +#endif
>>>    }
>>>
>>>    int ttm_pool_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>>> @@ -1059,6 +1064,17 @@ int ttm_pool_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>>>        if (ttm_check_under_lowerlimit(mem_glob, ttm->num_pages, ctx))
>>>                return -ENOMEM;
>>>
>>> +#ifdef CONFIG_MEMCG
>>> +     if (ttm->memcg) {
>>> +             gfp_t gfp_flags = GFP_USER;
>>> +             if (ttm->page_flags & TTM_PAGE_FLAG_NO_RETRY)
>>> +                     gfp_flags |= __GFP_RETRY_MAYFAIL;
>>> +             ret = mem_cgroup_charge_drvmem(ttm->memcg, gfp_flags, ttm->num_pages);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +#endif
>>> +
>>>        ret = ttm_get_pages(ttm->pages, ttm->num_pages, ttm->page_flags,
>>>                            ttm->caching_state);
>>>        if (unlikely(ret != 0)) {
>>> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
>>> index e0e9b4f69db6..1acb153084e1 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_tt.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
>>> @@ -233,6 +233,9 @@ void ttm_tt_init_fields(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
>>>        ttm->state = tt_unpopulated;
>>>        ttm->swap_storage = NULL;
>>>        ttm->sg = bo->sg;
>>> +#ifdef CONFIG_MEMCG
>>> +     ttm->memcg = bo->memcg;
>>> +#endif
>>>    }
>>>
>>>    int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
>>> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
>>> index 65e399d280f7..95a08e81a73e 100644
>>> --- a/include/drm/ttm/ttm_bo_api.h
>>> +++ b/include/drm/ttm/ttm_bo_api.h
>>> @@ -54,6 +54,8 @@ struct ttm_place;
>>>
>>>    struct ttm_lru_bulk_move;
>>>
>>> +struct mem_cgroup;
>>> +
>>>    /**
>>>     * struct ttm_bus_placement
>>>     *
>>> @@ -180,6 +182,9 @@ struct ttm_buffer_object {
>>>        void (*destroy) (struct ttm_buffer_object *);
>>>        unsigned long num_pages;
>>>        size_t acc_size;
>>> +#ifdef CONFIG_MEMCG
>>> +     struct mem_cgroup *memcg;
>>> +#endif
>>>
>>>        /**
>>>        * Members not needing protection.
>>> diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
>>> index c0e928abf592..10fb5a557b95 100644
>>> --- a/include/drm/ttm/ttm_tt.h
>>> +++ b/include/drm/ttm/ttm_tt.h
>>> @@ -33,6 +33,7 @@ struct ttm_tt;
>>>    struct ttm_mem_reg;
>>>    struct ttm_buffer_object;
>>>    struct ttm_operation_ctx;
>>> +struct mem_cgroup;
>>>
>>>    #define TTM_PAGE_FLAG_WRITE           (1 << 3)
>>>    #define TTM_PAGE_FLAG_SWAPPED         (1 << 4)
>>> @@ -116,6 +117,9 @@ struct ttm_tt {
>>>                tt_unbound,
>>>                tt_unpopulated,
>>>        } state;
>>> +#ifdef CONFIG_MEMCG
>>> +     struct mem_cgroup *memcg;
>>> +#endif
>>>    };
>>>
>>>    /**
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5d3b70a43b80444c550808d79c89e968%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637149988466853762&amp;sdata=ni3ku7nC%2FD5E8kivppfuuF7ZoiyfLQ8L3Y4j9IfHYUU%3D&amp;reserved=0

