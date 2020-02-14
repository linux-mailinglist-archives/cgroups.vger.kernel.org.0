Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9715E85D
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394384AbgBNQ7l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 11:59:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44976 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394342AbgBNQ7i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 11:59:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so11930019eds.11
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQET2SWePAJHC5EHLg4nL/UHPX4TOmdQlwDQSD1yBRU=;
        b=jxaDxrhTS2j/WU6i6mWG1dncKx/D05CV5ryV0kK43IO1YI14tc8bK+TW5WaEBW+WW9
         9aKHpU0z+5yJc32jHo2Ai0DLDakL0YS0brdcNRTIAeXMEeQqTHHIfxYnBe3N5H5pe6LZ
         pfa6rf4t33ie+jgBu4T/jqkzQpoBVCjbh0O8oyZfWsh6iVybWL45Uwep/F6I7/+Nhny1
         AykU27vVEgaPcFuyEHdXHPe9WRfTjbBXD90LMkkXOwHmUmWFiVF8DkKDxsRjO7gva/Rg
         nqH/wvz9zmFHTACXFf3MB1yK/jj/qiv7xqbvkbuBZ0jbEDDHg9ApVR1zt3sHMJ9dt9TZ
         hAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQET2SWePAJHC5EHLg4nL/UHPX4TOmdQlwDQSD1yBRU=;
        b=LtDau7ugKwNP9g+qtoFUAai0xEXQkP9JypWFw2H8IYEYvL7F0hvto6a/CVQcqRPAzJ
         BAKBJTqNCpWGLR/F52Ft4iqO9O/2D9tJI4KAtJ4CLy3lDc+2/EagomVnbmykSxgK3P2y
         NRI22HMc+X+3VBtJrwW+/IThxL/YLKh/QB+dfVlP8BjPXBV2XcQ4uim6j01f3DzHXAtl
         qH/z8FXt4UJK36XFa3a5Hul/iOfqVcxz9efAhisfuxTsG316E8HJHhCR6yu3DWE3vHkW
         6+fxNzuCA1Z4pmMGNuhu5zbw1wfus31dre+hZVkc+z/YqFB6Gr+69WcaQY7ryjvXnE86
         thDA==
X-Gm-Message-State: APjAAAWmOdCz1KOeL/6ph5cxyWyQVu7EswVrJwSZtO4h1xtQHeufViah
        u3smr/wSB9C3tbMvvfnDOugo3nJroFE0QNqZXJKeIg==
X-Google-Smtp-Source: APXvYqyi3xELtjIUkFA5b+C9V1wlrG14ep02SLUR8oDHucg/EPaG/bs9LwQcW5Dtf8EkVYEGXfIGJCng3QXNsvaF6fQ=
X-Received: by 2002:aa7:d1cf:: with SMTP id g15mr3644699edp.301.1581699574677;
 Fri, 14 Feb 2020 08:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20200214155650.21203-1-Kenny.Ho@amd.com> <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
In-Reply-To: <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Fri, 14 Feb 2020 10:59:23 -0600
Message-ID: <CAOFGe94=vqFEU_ULyoQ=WPz-JjcOEXTkrY8W7SsF2QeOxBfWEg@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        tj@kernel.org, alexander.deucher@amd.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com,
        Daniel Vetter <daniel@ffwll.ch>, nirmoy.das@amd.com,
        damon.mcdougall@amd.com, juan.zuniga-anaya@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 10:44 AM Jason Ekstrand <jason@jlekstrand.net> wrot=
e:
>
> Pardon my ignorance but I'm a bit confused by this.  What is a "logical G=
PU"?  What are we subdividing?  Are we carving up memory?  Compute power?  =
Both?
>
> If it's carving up memory, why aren't we just measuring it in megabytes?
>
> If it's carving up compute power, what's actually being carved up?  Time?=
  Execution units/waves/threads?  Even if that's the case, what advantage d=
oes it give to have it in terms of a fixed set of lgpus where each cgroup g=
ets to pick a fixed set.  Does affinity matter that much?  Why not just say=
 how many waves the GPU supports and that they have to be allocated in chun=
ks of 16 waves (pulling a number out of thin air) and let the cgroup specif=
y how many waves it wants.

One more question:  If I'm a userspace driver, and there are 14 lgpus
allocated to my cgroup, does that mean I have 14 GPUs?  Or does that
mean I have one GPU with 14 units of compute power?

> Don't get me wrong here.  I'm all for the notion of being able to use cgr=
oups to carve up GPU compute resources.  However, this sounds to me like th=
e most AMD-specific solution possible.  We (Intel) could probably do some s=
ort of carving up as well but we'd likely want to do it with preemption and=
 time-slicing rather than handing out specific EUs.

Ok, so "most AMD-specific solution possible" probably wasn't fair.
However, it does seem like an unnecessarily rigid solution to me.
Maybe there's something I'm not getting?

--Jason

> --Jason
>
>
> On Fri, Feb 14, 2020 at 9:57 AM Kenny Ho <Kenny.Ho@amd.com> wrote:
>>
>> drm.lgpu
>>       A read-write nested-keyed file which exists on all cgroups.
>>       Each entry is keyed by the DRM device's major:minor.
>>
>>       lgpu stands for logical GPU, it is an abstraction used to
>>       subdivide a physical DRM device for the purpose of resource
>>       management.  This file stores user configuration while the
>>       drm.lgpu.effective reflects the actual allocation after
>>       considering the relationship between the cgroups and their
>>       configurations.
>>
>>       The lgpu is a discrete quantity that is device specific (i.e.
>>       some DRM devices may have 64 lgpus while others may have 100
>>       lgpus.)  The lgpu is a single quantity that can be allocated
>>       in three different ways denoted by the following nested keys.
>>
>>         =3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>         weight    Allocate by proportion in relationship with
>>                   active sibling cgroups
>>         count     Allocate by amount statically, treat lgpu as
>>                   anonymous resources
>>         list      Allocate statically, treat lgpu as named
>>                   resource
>>         =3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>
>>       For example:
>>       226:0 weight=3D100 count=3D256 list=3D0-255
>>       226:1 weight=3D100 count=3D4 list=3D0,2,4,6
>>       226:2 weight=3D100 count=3D32 list=3D32-63
>>       226:3 weight=3D100 count=3D0 list=3D
>>       226:4 weight=3D500 count=3D0 list=3D
>>
>>       lgpu is represented by a bitmap and uses the bitmap_parselist
>>       kernel function so the list key input format is a
>>       comma-separated list of decimal numbers and ranges.
>>
>>       Consecutively set bits are shown as two hyphen-separated decimal
>>       numbers, the smallest and largest bit numbers set in the range.
>>       Optionally each range can be postfixed to denote that only parts
>>       of it should be set.  The range will divided to groups of
>>       specific size.
>>       Syntax: range:used_size/group_size
>>       Example: 0-1023:2/256 =3D=3D> 0,1,256,257,512,513,768,769
>>
>>       The count key is the hamming weight / hweight of the bitmap.
>>
>>       Weight, count and list accept the max and default keywords.
>>
>>       Some DRM devices may only support lgpu as anonymous resources.
>>       In such case, the significance of the position of the set bits
>>       in list will be ignored.
>>
>>       The weight quantity is only in effect when static allocation
>>       is not used (by setting count=3D0) for this cgroup.  The weight
>>       quantity distributes lgpus that are not statically allocated by
>>       the siblings.  For example, given siblings cgroupA, cgroupB and
>>       cgroupC for a DRM device that has 64 lgpus, if cgroupA occupies
>>       0-63, no lgpu is available to be distributed by weight.
>>       Similarly, if cgroupA has list=3D0-31 and cgroupB has list=3D16-63=
,
>>       cgroupC will be starved if it tries to allocate by weight.
>>
>>       On the other hand, if cgroupA has weight=3D100 count=3D0, cgroupB
>>       has list=3D16-47, and cgroupC has weight=3D100 count=3D0, then 32
>>       lgpus are available to be distributed evenly between cgroupA
>>       and cgroupC.  In drm.lgpu.effective, cgroupA will have
>>       list=3D0-15 and cgroupC will have list=3D48-63.
>>
>>       This lgpu resource supports the 'allocation' and 'weight'
>>       resource distribution model.
>>
>> drm.lgpu.effective
>>       A read-only nested-keyed file which exists on all cgroups.
>>       Each entry is keyed by the DRM device's major:minor.
>>
>>       lgpu stands for logical GPU, it is an abstraction used to
>>       subdivide a physical DRM device for the purpose of resource
>>       management.  This file reflects the actual allocation after
>>       considering the relationship between the cgroups and their
>>       configurations in drm.lgpu.
>>
>> Change-Id: Idde0ef9a331fd67bb9c7eb8ef9978439e6452488
>> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  80 ++++++
>>  include/drm/drm_cgroup.h                |   3 +
>>  include/linux/cgroup_drm.h              |  22 ++
>>  kernel/cgroup/drm.c                     | 324 +++++++++++++++++++++++-
>>  4 files changed, 427 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/adm=
in-guide/cgroup-v2.rst
>> index ce5dc027366a..d8a41956e5c7 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2120,6 +2120,86 @@ DRM Interface Files
>>         Set largest allocation for /dev/dri/card1 to 4MB
>>         echo "226:1 4m" > drm.buffer.peak.max
>>
>> +  drm.lgpu
>> +       A read-write nested-keyed file which exists on all cgroups.
>> +       Each entry is keyed by the DRM device's major:minor.
>> +
>> +       lgpu stands for logical GPU, it is an abstraction used to
>> +       subdivide a physical DRM device for the purpose of resource
>> +       management.  This file stores user configuration while the
>> +        drm.lgpu.effective reflects the actual allocation after
>> +        considering the relationship between the cgroups and their
>> +        configurations.
>> +
>> +       The lgpu is a discrete quantity that is device specific (i.e.
>> +       some DRM devices may have 64 lgpus while others may have 100
>> +       lgpus.)  The lgpu is a single quantity that can be allocated
>> +        in three different ways denoted by the following nested keys.
>> +
>> +         =3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +         weight    Allocate by proportion in relationship with
>> +                    active sibling cgroups
>> +         count     Allocate by amount statically, treat lgpu as
>> +                    anonymous resources
>> +         list      Allocate statically, treat lgpu as named
>> +                    resource
>> +         =3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +       For example:
>> +       226:0 weight=3D100 count=3D256 list=3D0-255
>> +       226:1 weight=3D100 count=3D4 list=3D0,2,4,6
>> +       226:2 weight=3D100 count=3D32 list=3D32-63
>> +       226:3 weight=3D100 count=3D0 list=3D
>> +       226:4 weight=3D500 count=3D0 list=3D
>> +
>> +       lgpu is represented by a bitmap and uses the bitmap_parselist
>> +       kernel function so the list key input format is a
>> +       comma-separated list of decimal numbers and ranges.
>> +
>> +       Consecutively set bits are shown as two hyphen-separated decimal
>> +       numbers, the smallest and largest bit numbers set in the range.
>> +       Optionally each range can be postfixed to denote that only parts
>> +       of it should be set.  The range will divided to groups of
>> +       specific size.
>> +       Syntax: range:used_size/group_size
>> +       Example: 0-1023:2/256 =3D=3D> 0,1,256,257,512,513,768,769
>> +
>> +       The count key is the hamming weight / hweight of the bitmap.
>> +
>> +       Weight, count and list accept the max and default keywords.
>> +
>> +       Some DRM devices may only support lgpu as anonymous resources.
>> +       In such case, the significance of the position of the set bits
>> +       in list will be ignored.
>> +
>> +       The weight quantity is only in effect when static allocation
>> +       is not used (by setting count=3D0) for this cgroup.  The weight
>> +       quantity distributes lgpus that are not statically allocated by
>> +       the siblings.  For example, given siblings cgroupA, cgroupB and
>> +       cgroupC for a DRM device that has 64 lgpus, if cgroupA occupies
>> +       0-63, no lgpu is available to be distributed by weight.
>> +       Similarly, if cgroupA has list=3D0-31 and cgroupB has list=3D16-=
63,
>> +       cgroupC will be starved if it tries to allocate by weight.
>> +
>> +       On the other hand, if cgroupA has weight=3D100 count=3D0, cgroup=
B
>> +       has list=3D16-47, and cgroupC has weight=3D100 count=3D0, then 3=
2
>> +       lgpus are available to be distributed evenly between cgroupA
>> +       and cgroupC.  In drm.lgpu.effective, cgroupA will have
>> +       list=3D0-15 and cgroupC will have list=3D48-63.
>> +
>> +       This lgpu resource supports the 'allocation' and 'weight'
>> +       resource distribution model.
>> +
>> +  drm.lgpu.effective
>> +       A read-only nested-keyed file which exists on all cgroups.
>> +       Each entry is keyed by the DRM device's major:minor.
>> +
>> +       lgpu stands for logical GPU, it is an abstraction used to
>> +       subdivide a physical DRM device for the purpose of resource
>> +       management.  This file reflects the actual allocation after
>> +        considering the relationship between the cgroups and their
>> +        configurations in drm.lgpu.
>> +
>>  GEM Buffer Ownership
>>  ~~~~~~~~~~~~~~~~~~~~
>>
>> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
>> index 2b41d4d22e33..619a110cc748 100644
>> --- a/include/drm/drm_cgroup.h
>> +++ b/include/drm/drm_cgroup.h
>> @@ -17,6 +17,9 @@ struct drmcg_props {
>>
>>         s64                     bo_limits_total_allocated_default;
>>         s64                     bo_limits_peak_allocated_default;
>> +
>> +       int                     lgpu_capacity;
>> +       DECLARE_BITMAP(lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
>>  };
>>
>>  void drmcg_bind(struct drm_minor (*(*acq_dm)(unsigned int minor_id)),
>> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
>> index eae400f3d9b4..bb09704e7f71 100644
>> --- a/include/linux/cgroup_drm.h
>> +++ b/include/linux/cgroup_drm.h
>> @@ -11,10 +11,14 @@
>>  /* limit defined per the way drm_minor_alloc operates */
>>  #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
>>
>> +#define MAX_DRMCG_LGPU_CAPACITY 256
>> +
>>  enum drmcg_res_type {
>>         DRMCG_TYPE_BO_TOTAL,
>>         DRMCG_TYPE_BO_PEAK,
>>         DRMCG_TYPE_BO_COUNT,
>> +       DRMCG_TYPE_LGPU,
>> +       DRMCG_TYPE_LGPU_EFF,
>>         __DRMCG_TYPE_LAST,
>>  };
>>
>> @@ -32,6 +36,24 @@ struct drmcg_device_resource {
>>         s64                     bo_limits_peak_allocated;
>>
>>         s64                     bo_stats_count_allocated;
>> +
>> +       /**
>> +        * Logical GPU
>> +        *
>> +        * *_cfg are properties configured by users
>> +        * *_eff are the effective properties being applied to the hardw=
are
>> +         * *_stg is used to calculate _eff before applying to _eff
>> +        * after considering the entire hierarchy
>> +        */
>> +       DECLARE_BITMAP(lgpu_stg, MAX_DRMCG_LGPU_CAPACITY);
>> +       /* user configurations */
>> +       s64                     lgpu_weight_cfg;
>> +       DECLARE_BITMAP(lgpu_cfg, MAX_DRMCG_LGPU_CAPACITY);
>> +       /* effective lgpu for the cgroup after considering
>> +        * relationship with other cgroup
>> +        */
>> +       s64                     lgpu_count_eff;
>> +       DECLARE_BITMAP(lgpu_eff, MAX_DRMCG_LGPU_CAPACITY);
>>  };
>>
>>  /**
>> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
>> index 5fcbbc13fa1c..a4e88a3704bb 100644
>> --- a/kernel/cgroup/drm.c
>> +++ b/kernel/cgroup/drm.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/mutex.h>
>>  #include <linux/kernel.h>
>> +#include <linux/bitmap.h>
>>  #include <linux/cgroup_drm.h>
>>  #include <drm/drm_file.h>
>>  #include <drm/drm_drv.h>
>> @@ -41,6 +42,10 @@ enum drmcg_file_type {
>>         DRMCG_FTYPE_DEFAULT,
>>  };
>>
>> +#define LGPU_LIMITS_NAME_LIST "list"
>> +#define LGPU_LIMITS_NAME_COUNT "count"
>> +#define LGPU_LIMITS_NAME_WEIGHT "weight"
>> +
>>  /**
>>   * drmcg_bind - Bind DRM subsystem to cgroup subsystem
>>   * @acq_dm: function pointer to the drm_minor_acquire function
>> @@ -98,6 +103,13 @@ static inline int init_drmcg_single(struct drmcg *dr=
mcg, struct drm_device *dev)
>>         ddr->bo_limits_peak_allocated =3D
>>                 dev->drmcg_props.bo_limits_peak_allocated_default;
>>
>> +       bitmap_copy(ddr->lgpu_cfg, dev->drmcg_props.lgpu_slots,
>> +                       MAX_DRMCG_LGPU_CAPACITY);
>> +       bitmap_copy(ddr->lgpu_stg, dev->drmcg_props.lgpu_slots,
>> +                       MAX_DRMCG_LGPU_CAPACITY);
>> +
>> +       ddr->lgpu_weight_cfg =3D CGROUP_WEIGHT_DFL;
>> +
>>         return 0;
>>  }
>>
>> @@ -121,6 +133,120 @@ static inline void drmcg_update_cg_tree(struct drm=
_device *dev)
>>         mutex_unlock(&cgroup_mutex);
>>  }
>>
>> +static void drmcg_calculate_effective_lgpu(struct drm_device *dev,
>> +               const unsigned long *free_static,
>> +               const unsigned long *free_weighted,
>> +               struct drmcg *parent_drmcg)
>> +{
>> +       int capacity =3D dev->drmcg_props.lgpu_capacity;
>> +       DECLARE_BITMAP(lgpu_unused, MAX_DRMCG_LGPU_CAPACITY);
>> +       DECLARE_BITMAP(lgpu_by_weight, MAX_DRMCG_LGPU_CAPACITY);
>> +       struct drmcg_device_resource *parent_ddr;
>> +       struct drmcg_device_resource *ddr;
>> +       int minor =3D dev->primary->index;
>> +       struct cgroup_subsys_state *pos;
>> +       struct drmcg *child;
>> +       s64 weight_sum =3D 0;
>> +       s64 unused;
>> +
>> +       parent_ddr =3D parent_drmcg->dev_resources[minor];
>> +
>> +       if (bitmap_empty(parent_ddr->lgpu_cfg, capacity))
>> +               /* no static cfg, use weight for calculating the effecti=
ve */
>> +               bitmap_copy(parent_ddr->lgpu_stg, free_weighted, capacit=
y);
>> +       else
>> +               /* lgpu statically configured, use the overlap as effect=
ive */
>> +               bitmap_and(parent_ddr->lgpu_stg, free_static,
>> +                               parent_ddr->lgpu_cfg, capacity);
>> +
>> +       /* calculate lgpu available for distribution by weight for child=
ren */
>> +       bitmap_copy(lgpu_unused, parent_ddr->lgpu_stg, capacity);
>> +       css_for_each_child(pos, &parent_drmcg->css) {
>> +               child =3D css_to_drmcg(pos);
>> +               ddr =3D child->dev_resources[minor];
>> +
>> +               if (bitmap_empty(ddr->lgpu_cfg, capacity))
>> +                       /* no static allocation, participate in weight d=
ist */
>> +                       weight_sum +=3D ddr->lgpu_weight_cfg;
>> +               else
>> +                       /* take out statically allocated lgpu by sibling=
s */
>> +                       bitmap_andnot(lgpu_unused, lgpu_unused, ddr->lgp=
u_cfg,
>> +                                       capacity);
>> +       }
>> +
>> +       unused =3D bitmap_weight(lgpu_unused, capacity);
>> +
>> +       css_for_each_child(pos, &parent_drmcg->css) {
>> +               child =3D css_to_drmcg(pos);
>> +               ddr =3D child->dev_resources[minor];
>> +
>> +               bitmap_zero(lgpu_by_weight, capacity);
>> +               /* no static allocation, participate in weight distribut=
ion */
>> +               if (bitmap_empty(ddr->lgpu_cfg, capacity)) {
>> +                       int c;
>> +                       int p =3D 0;
>> +
>> +                       for (c =3D ddr->lgpu_weight_cfg * unused / weigh=
t_sum;
>> +                                       c > 0; c--) {
>> +                               p =3D find_next_bit(lgpu_unused, capacit=
y, p);
>> +                               if (p < capacity) {
>> +                                       clear_bit(p, lgpu_unused);
>> +                                       set_bit(p, lgpu_by_weight);
>> +                               }
>> +                       }
>> +
>> +               }
>> +
>> +               drmcg_calculate_effective_lgpu(dev, parent_ddr->lgpu_stg=
,
>> +                               lgpu_by_weight, child);
>> +       }
>> +}
>> +
>> +static void drmcg_apply_effective_lgpu(struct drm_device *dev)
>> +{
>> +       int capacity =3D dev->drmcg_props.lgpu_capacity;
>> +       int minor =3D dev->primary->index;
>> +       struct drmcg_device_resource *ddr;
>> +       struct cgroup_subsys_state *pos;
>> +       struct drmcg *drmcg;
>> +
>> +       if (root_drmcg =3D=3D NULL) {
>> +               WARN_ON(root_drmcg =3D=3D NULL);
>> +               return;
>> +       }
>> +
>> +       rcu_read_lock();
>> +
>> +       /* process the entire cgroup tree from root to simplify the algo=
rithm */
>> +       drmcg_calculate_effective_lgpu(dev, dev->drmcg_props.lgpu_slots,
>> +                       dev->drmcg_props.lgpu_slots, root_drmcg);
>> +
>> +       /* apply changes to effective only if there is a change */
>> +       css_for_each_descendant_pre(pos, &root_drmcg->css) {
>> +               drmcg =3D css_to_drmcg(pos);
>> +               ddr =3D drmcg->dev_resources[minor];
>> +
>> +               if (!bitmap_equal(ddr->lgpu_stg, ddr->lgpu_eff, capacity=
)) {
>> +                       bitmap_copy(ddr->lgpu_eff, ddr->lgpu_stg, capaci=
ty);
>> +                       ddr->lgpu_count_eff =3D
>> +                               bitmap_weight(ddr->lgpu_eff, capacity);
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +}
>> +
>> +static void drmcg_apply_effective(enum drmcg_res_type type,
>> +               struct drm_device *dev, struct drmcg *changed_drmcg)
>> +{
>> +       switch (type) {
>> +       case DRMCG_TYPE_LGPU:
>> +               drmcg_apply_effective_lgpu(dev);
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +}
>> +
>>  /**
>>   * drmcg_register_dev - register a DRM device for usage in drm cgroup
>>   * @dev: DRM device
>> @@ -143,7 +269,13 @@ void drmcg_register_dev(struct drm_device *dev)
>>         {
>>                 dev->driver->drmcg_custom_init(dev, &dev->drmcg_props);
>>
>> +               WARN_ON(dev->drmcg_props.lgpu_capacity !=3D
>> +                               bitmap_weight(dev->drmcg_props.lgpu_slot=
s,
>> +                                       MAX_DRMCG_LGPU_CAPACITY));
>> +
>>                 drmcg_update_cg_tree(dev);
>> +
>> +               drmcg_apply_effective(DRMCG_TYPE_LGPU, dev, root_drmcg);
>>         }
>>         mutex_unlock(&drmcg_mutex);
>>  }
>> @@ -297,7 +429,8 @@ static void drmcg_print_stats(struct drmcg_device_re=
source *ddr,
>>  }
>>
>>  static void drmcg_print_limits(struct drmcg_device_resource *ddr,
>> -               struct seq_file *sf, enum drmcg_res_type type)
>> +               struct seq_file *sf, enum drmcg_res_type type,
>> +               struct drm_device *dev)
>>  {
>>         if (ddr =3D=3D NULL) {
>>                 seq_puts(sf, "\n");
>> @@ -311,6 +444,25 @@ static void drmcg_print_limits(struct drmcg_device_=
resource *ddr,
>>         case DRMCG_TYPE_BO_PEAK:
>>                 seq_printf(sf, "%lld\n", ddr->bo_limits_peak_allocated);
>>                 break;
>> +       case DRMCG_TYPE_LGPU:
>> +               seq_printf(sf, "%s=3D%lld %s=3D%d %s=3D%*pbl\n",
>> +                               LGPU_LIMITS_NAME_WEIGHT,
>> +                               ddr->lgpu_weight_cfg,
>> +                               LGPU_LIMITS_NAME_COUNT,
>> +                               bitmap_weight(ddr->lgpu_cfg,
>> +                                       dev->drmcg_props.lgpu_capacity),
>> +                               LGPU_LIMITS_NAME_LIST,
>> +                               dev->drmcg_props.lgpu_capacity,
>> +                               ddr->lgpu_cfg);
>> +               break;
>> +       case DRMCG_TYPE_LGPU_EFF:
>> +               seq_printf(sf, "%s=3D%lld %s=3D%*pbl\n",
>> +                               LGPU_LIMITS_NAME_COUNT,
>> +                               ddr->lgpu_count_eff,
>> +                               LGPU_LIMITS_NAME_LIST,
>> +                               dev->drmcg_props.lgpu_capacity,
>> +                               ddr->lgpu_eff);
>> +               break;
>>         default:
>>                 seq_puts(sf, "\n");
>>                 break;
>> @@ -329,6 +481,17 @@ static void drmcg_print_default(struct drmcg_props =
*props,
>>                 seq_printf(sf, "%lld\n",
>>                         props->bo_limits_peak_allocated_default);
>>                 break;
>> +       case DRMCG_TYPE_LGPU:
>> +               seq_printf(sf, "%s=3D%d %s=3D%d %s=3D%*pbl\n",
>> +                               LGPU_LIMITS_NAME_WEIGHT,
>> +                               CGROUP_WEIGHT_DFL,
>> +                               LGPU_LIMITS_NAME_COUNT,
>> +                               bitmap_weight(props->lgpu_slots,
>> +                                       props->lgpu_capacity),
>> +                               LGPU_LIMITS_NAME_LIST,
>> +                               props->lgpu_capacity,
>> +                               props->lgpu_slots);
>> +               break;
>>         default:
>>                 seq_puts(sf, "\n");
>>                 break;
>> @@ -358,7 +521,7 @@ static int drmcg_seq_show_fn(int id, void *ptr, void=
 *data)
>>                 drmcg_print_stats(ddr, sf, type);
>>                 break;
>>         case DRMCG_FTYPE_LIMIT:
>> -               drmcg_print_limits(ddr, sf, type);
>> +               drmcg_print_limits(ddr, sf, type, minor->dev);
>>                 break;
>>         case DRMCG_FTYPE_DEFAULT:
>>                 drmcg_print_default(&minor->dev->drmcg_props, sf, type);
>> @@ -415,6 +578,115 @@ static int drmcg_process_limit_s64_val(char *sval,=
 bool is_mem,
>>         return rc;
>>  }
>>
>> +static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
>> +               struct drm_device *dev, char *attrs)
>> +{
>> +       DECLARE_BITMAP(tmp_bitmap, MAX_DRMCG_LGPU_CAPACITY);
>> +       DECLARE_BITMAP(chk_bitmap, MAX_DRMCG_LGPU_CAPACITY);
>> +       enum drmcg_res_type type =3D
>> +               DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
>> +       struct drmcg *drmcg =3D css_to_drmcg(of_css(of));
>> +       struct drmcg_props *props =3D &dev->drmcg_props;
>> +       char *cft_name =3D of_cft(of)->name;
>> +       int minor =3D dev->primary->index;
>> +       char *nested =3D strstrip(attrs);
>> +       struct drmcg_device_resource *ddr =3D
>> +               drmcg->dev_resources[minor];
>> +       char *attr;
>> +       char sname[256];
>> +       char sval[256];
>> +       s64 val;
>> +       int rc;
>> +
>> +       while (nested !=3D NULL) {
>> +               attr =3D strsep(&nested, " ");
>> +
>> +               if (sscanf(attr, "%255[^=3D]=3D%255[^=3D]", sname, sval)=
 !=3D 2)
>> +                       continue;
>> +
>> +               switch (type) {
>> +               case DRMCG_TYPE_LGPU:
>> +                       if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) &=
&
>> +                               strncmp(sname, LGPU_LIMITS_NAME_COUNT, 2=
56) &&
>> +                               strncmp(sname, LGPU_LIMITS_NAME_WEIGHT, =
256))
>> +                               continue;
>> +
>> +                       if (strncmp(sname, LGPU_LIMITS_NAME_WEIGHT, 256)=
 &&
>> +                                       (!strcmp("max", sval) ||
>> +                                       !strcmp("default", sval))) {
>> +                               bitmap_copy(ddr->lgpu_cfg, props->lgpu_s=
lots,
>> +                                               props->lgpu_capacity);
>> +
>> +                               continue;
>> +                       }
>> +
>> +                       if (strncmp(sname, LGPU_LIMITS_NAME_WEIGHT, 256)=
 =3D=3D 0) {
>> +                               rc =3D drmcg_process_limit_s64_val(sval,
>> +                                       false, CGROUP_WEIGHT_DFL,
>> +                                       CGROUP_WEIGHT_MAX, &val);
>> +
>> +                               if (rc || val < CGROUP_WEIGHT_MIN ||
>> +                                               val > CGROUP_WEIGHT_MAX)=
 {
>> +                                       drmcg_pr_cft_err(drmcg, rc, cft_=
name,
>> +                                                       minor);
>> +                                       continue;
>> +                               }
>> +
>> +                               ddr->lgpu_weight_cfg =3D val;
>> +                               continue;
>> +                       }
>> +
>> +                       if (strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) =
=3D=3D 0) {
>> +                               rc =3D drmcg_process_limit_s64_val(sval,
>> +                                       false, props->lgpu_capacity,
>> +                                       props->lgpu_capacity, &val);
>> +
>> +                               if (rc || val < 0) {
>> +                                       drmcg_pr_cft_err(drmcg, rc, cft_=
name,
>> +                                                       minor);
>> +                                       continue;
>> +                               }
>> +
>> +                               bitmap_zero(tmp_bitmap,
>> +                                               MAX_DRMCG_LGPU_CAPACITY)=
;
>> +                               bitmap_set(tmp_bitmap, 0, val);
>> +                       }
>> +
>> +                       if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) =
=3D=3D 0) {
>> +                               rc =3D bitmap_parselist(sval, tmp_bitmap=
,
>> +                                               MAX_DRMCG_LGPU_CAPACITY)=
;
>> +
>> +                               if (rc) {
>> +                                       drmcg_pr_cft_err(drmcg, rc, cft_=
name,
>> +                                                       minor);
>> +                                       continue;
>> +                               }
>> +
>> +                               bitmap_andnot(chk_bitmap, tmp_bitmap,
>> +                                       props->lgpu_slots,
>> +                                       MAX_DRMCG_LGPU_CAPACITY);
>> +
>> +                               /* user setting does not intersect with
>> +                                * available lgpu */
>> +                               if (!bitmap_empty(chk_bitmap,
>> +                                               MAX_DRMCG_LGPU_CAPACITY)=
) {
>> +                                       drmcg_pr_cft_err(drmcg, 0, cft_n=
ame,
>> +                                                       minor);
>> +                                       continue;
>> +                               }
>> +                       }
>> +
>> +                       bitmap_copy(ddr->lgpu_cfg, tmp_bitmap,
>> +                                       props->lgpu_capacity);
>> +
>> +                       break; /* DRMCG_TYPE_LGPU */
>> +               default:
>> +                       break;
>> +               } /* switch (type) */
>> +       }
>> +}
>> +
>> +
>>  /**
>>   * drmcg_limit_write - parse cgroup interface files to obtain user conf=
ig
>>   *
>> @@ -499,9 +771,15 @@ static ssize_t drmcg_limit_write(struct kernfs_open=
_file *of, char *buf,
>>
>>                         ddr->bo_limits_peak_allocated =3D val;
>>                         break;
>> +               case DRMCG_TYPE_LGPU:
>> +                       drmcg_nested_limit_parse(of, dm->dev, sattr);
>> +                       break;
>>                 default:
>>                         break;
>>                 }
>> +
>> +               drmcg_apply_effective(type, dm->dev, drmcg);
>> +
>>                 mutex_unlock(&dm->dev->drmcg_mutex);
>>
>>                 mutex_lock(&drmcg_mutex);
>> @@ -560,12 +838,51 @@ struct cftype files[] =3D {
>>                 .private =3D DRMCG_CTF_PRIV(DRMCG_TYPE_BO_COUNT,
>>                                                 DRMCG_FTYPE_STATS),
>>         },
>> +       {
>> +               .name =3D "lgpu",
>> +               .seq_show =3D drmcg_seq_show,
>> +               .write =3D drmcg_limit_write,
>> +               .private =3D DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
>> +                                               DRMCG_FTYPE_LIMIT),
>> +       },
>> +       {
>> +               .name =3D "lgpu.default",
>> +               .seq_show =3D drmcg_seq_show,
>> +               .flags =3D CFTYPE_ONLY_ON_ROOT,
>> +               .private =3D DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
>> +                                               DRMCG_FTYPE_DEFAULT),
>> +       },
>> +       {
>> +               .name =3D "lgpu.effective",
>> +               .seq_show =3D drmcg_seq_show,
>> +               .private =3D DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU_EFF,
>> +                                               DRMCG_FTYPE_LIMIT),
>> +       },
>>         { }     /* terminate */
>>  };
>>
>> +static int drmcg_online_fn(int id, void *ptr, void *data)
>> +{
>> +       struct drm_minor *minor =3D ptr;
>> +       struct drmcg *drmcg =3D data;
>> +
>> +       if (minor->type !=3D DRM_MINOR_PRIMARY)
>> +               return 0;
>> +
>> +       drmcg_apply_effective(DRMCG_TYPE_LGPU, minor->dev, drmcg);
>> +
>> +       return 0;
>> +}
>> +
>> +static int drmcg_css_online(struct cgroup_subsys_state *css)
>> +{
>> +       return drm_minor_for_each(&drmcg_online_fn, css_to_drmcg(css));
>> +}
>> +
>>  struct cgroup_subsys drm_cgrp_subsys =3D {
>>         .css_alloc      =3D drmcg_css_alloc,
>>         .css_free       =3D drmcg_css_free,
>> +       .css_online     =3D drmcg_css_online,
>>         .early_init     =3D false,
>>         .legacy_cftypes =3D files,
>>         .dfl_cftypes    =3D files,
>> @@ -585,6 +902,9 @@ void drmcg_device_early_init(struct drm_device *dev)
>>         dev->drmcg_props.bo_limits_total_allocated_default =3D S64_MAX;
>>         dev->drmcg_props.bo_limits_peak_allocated_default =3D S64_MAX;
>>
>> +       dev->drmcg_props.lgpu_capacity =3D MAX_DRMCG_LGPU_CAPACITY;
>> +       bitmap_fill(dev->drmcg_props.lgpu_slots, MAX_DRMCG_LGPU_CAPACITY=
);
>> +
>>         drmcg_update_cg_tree(dev);
>>  }
>>  EXPORT_SYMBOL(drmcg_device_early_init);
>> --
>> 2.25.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
