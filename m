Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB8D1391
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfJIQHA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 12:07:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34577 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJIQHA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Oct 2019 12:07:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id p10so2557895edq.1
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WgjdvWgOLagIgEmMDnfLUUFkt/CiMBBLbiQnuzDeFo8=;
        b=Bj4Iyliz2hh0NrFqbUidg2ag7wtsswtuzHCLz54bauUYMfyKdW/BmngLh8Aoslj/CU
         qDcNkgIpxYPAQO7NrxDioJeFYuZZCbGwn+eTbdd+tOSyhZI4yG4se1piy32E/cRvrxLz
         wnwTuRLlbWsJyB6cDgImraEpKbbl6/mwrc2qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WgjdvWgOLagIgEmMDnfLUUFkt/CiMBBLbiQnuzDeFo8=;
        b=eywZ0VF4B74JanNhHRxA4fK+9KIJdKrCCR7Q6dIiM8DamrOiA/oDSTAISLc5ONcHhh
         bX5xwZMFRC5IyUIuURV2z1n4BorMGkKtqkT5olwpyKjGo+MuDa0K9ga1QU0ziv4zxDK7
         SbhBnz2RLhIIT19puibk1UGntKEdA8kYsQQrBgt4JzHfz4LNDJzeVDX1vTJhFQoltXuS
         Ip1WfkcIBgk0O70e6f0Nw3O6RvPYPomE7BiFNje9oVN/1mUY0VPD1V45t7I+KLw+Mkgi
         VSC7j4tv2/9vX14jXuQamkF1U4tIwzmpjFOkcE+/G4UgTUGN9wuXnRCdMw59QTRJh3ql
         4TaA==
X-Gm-Message-State: APjAAAVOQ4ynsLh/5dpYnYMh3G2UczpyDTMwusbfczMGM/Qd2Ji05Box
        clZ6x6OoRfjI6KmXT4g4QyPydw==
X-Google-Smtp-Source: APXvYqyuZohLeSpzWztkr2T1KKTB+XVi2pcKscokhxyYuYVKRhP9ieRmG4D7I5NKiLnB/HWjjqN/Lw==
X-Received: by 2002:a05:6402:650:: with SMTP id u16mr3706065edx.211.1570637215934;
        Wed, 09 Oct 2019 09:06:55 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id i1sm320771ejv.92.2019.10.09.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 09:06:55 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:06:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
Subject: Re: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
Message-ID: <20191009160652.GO16989@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
 <20191009103153.GU16989@phenom.ffwll.local>
 <ee873e89-48fd-c4c9-1ce0-73965f4ad2ba@amd.com>
 <20191009153429.GI16989@phenom.ffwll.local>
 <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 09, 2019 at 03:53:42PM +0000, Kuehling, Felix wrote:
> On 2019-10-09 11:34, Daniel Vetter wrote:
> > On Wed, Oct 09, 2019 at 03:25:22PM +0000, Kuehling, Felix wrote:
> >> On 2019-10-09 6:31, Daniel Vetter wrote:
> >>> On Tue, Oct 08, 2019 at 06:53:18PM +0000, Kuehling, Felix wrote:
> >>>> The description sounds reasonable to me and maps well to the CU masking
> >>>> feature in our GPUs.
> >>>>
> >>>> It would also allow us to do more coarse-grained masking for example to
> >>>> guarantee balanced allocation of CUs across shader engines or
> >>>> partitioning of memory bandwidth or CP pipes (if that is supported by
> >>>> the hardware/firmware).
> >>> Hm, so this sounds like the definition for how this cgroup is supposed to
> >>> work is "amd CU masking" (whatever that exactly is). And the abstract
> >>> description is just prettification on top, but not actually the real
> >>> definition you guys want.
> >> I think you're reading this as the opposite of what I was trying to say.
> >> Using CU masking is one possible implementation of LGPUs on AMD
> >> hardware. It's the one that Kenny implemented at the end of this patch
> >> series, and I pointed out some problems with that approach. Other ways
> >> to partition the hardware into LGPUs are conceivable. For example we're
> >> considering splitting it along the lines of shader engines, which is
> >> more coarse-grain and would also affect memory bandwidth available to
> >> each partition.
> > If this is supposed to be useful for admins then "other ways to partition
> > the hw are conceivable" is the problem. This should be unique&clear for
> > admins/end-users. Reading the implementation details and realizing that
> > the actual meaning is "amd CU masking" isn't good enough by far, since
> > that's meaningless on any other hw.
> >
> > And if there's other ways to implement this cgroup for amd, it's also
> > meaningless (to sysadmins/users) for amd hw.
> >
> >> We could also consider partitioning pipes in our command processor,
> >> although that is not supported by our current CP scheduler firmware.
> >>
> >> The bottom line is, the LGPU model proposed by Kenny is quite abstract
> >> and allows drivers implementing it a lot of flexibility depending on the
> >> capability of their hardware and firmware. We haven't settled on a final
> >> implementation choice even for AMD.
> > That abstract model of essentially "anything goes" is the problem here
> > imo. E.g. for cpu cgroups this would be similar to allowing the bitmaks to
> > mean "cpu core" on one machine "physical die" on the next and maybe
> > "hyperthread unit" on the 3rd. Useless for admins.
> >
> > So if we have a gpu bitmaks thing that might mean a command submissio pipe
> > on one hw (maybe matching what vk exposed, maybe not), some compute unit
> > mask on the next and something entirely different (e.g. intel has so
> > called GT slices with compute cores + more stuff around) on the 3rd vendor
> > then that's not useful for admins.
> 
> The goal is to partition GPU compute resources to eliminate as much 
> resource contention as possible between different partitions. Different 
> hardware will have different capabilities to implement this. No 
> implementation will be perfect. For example, even with CPU cores that 
> are supposedly well defined, you can still have different behaviours 
> depending on CPU cache architectures, NUMA and thermal management across 
> CPU cores. The admin will need some knowledge of their hardware 
> architecture to understand those effects that are not described by the 
> abstract model of cgroups.

That's not the point I was making. For cpu cgroups there's a very well
defined connection between the cpu bitmasks/numbers in cgroups and the cpu
bitmasks you use in various system calls (they match). And that stuff
works across vendors.

We need the same for gpus.

> The LGPU model is deliberately flexible, because GPU architectures are 
> much less standardized than CPU architectures. Expecting a common model 
> that is both very specific and applicable to to all GPUs is unrealistic, 
> in my opinion.

So pure abstraction isn't useful, we need to know what these bits mean.
Since if they e.g. mean vk pipes, then maybe I shouldn't be using those vk
pipes in my application anymore. Or we need to define that the userspace
driver needs to filter out any pipes that arent' accessible (if that's
possible, no idea).

cgroups that essentially have pure hw depedent meaning aren't useful.
Note: this is about the fundamental meaning, not about the more unclear
isolation guarantees (which are indeed hw specific on different cpu
platforms). We're not talking about "different gpus might have different
amounts of shared caches bitween different bitmasks". We're talking
"different gpus might assign completely differen meaning to these
bitmasks".
-Daniel

> 
> Regards,
>    Felix
> 
> 
> > -Daniel
> >
> >> Regards,
> >>     Felix
> >>
> >>
> >>> I think adding a cgroup which is that much depending upon the hw
> >>> implementation of the first driver supporting it is not a good idea.
> >>> -Daniel
> >>>
> >>>> I can't comment on the code as I'm unfamiliar with the details of the
> >>>> cgroup code.
> >>>>
> >>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >>>>
> >>>>
> >>>>> ---
> >>>>>     Documentation/admin-guide/cgroup-v2.rst |  46 ++++++++
> >>>>>     include/drm/drm_cgroup.h                |   4 +
> >>>>>     include/linux/cgroup_drm.h              |   6 ++
> >>>>>     kernel/cgroup/drm.c                     | 135 ++++++++++++++++++++++++
> >>>>>     4 files changed, 191 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> >>>>> index 87a195133eaa..57f18469bd76 100644
> >>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>>>> @@ -1958,6 +1958,52 @@ DRM Interface Files
> >>>>>     	Set largest allocation for /dev/dri/card1 to 4MB
> >>>>>     	echo "226:1 4m" > drm.buffer.peak.max
> >>>>>     
> >>>>> +  drm.lgpu
> >>>>> +	A read-write nested-keyed file which exists on all cgroups.
> >>>>> +	Each entry is keyed by the DRM device's major:minor.
> >>>>> +
> >>>>> +	lgpu stands for logical GPU, it is an abstraction used to
> >>>>> +	subdivide a physical DRM device for the purpose of resource
> >>>>> +	management.
> >>>>> +
> >>>>> +	The lgpu is a discrete quantity that is device specific (i.e.
> >>>>> +	some DRM devices may have 64 lgpus while others may have 100
> >>>>> +	lgpus.)  The lgpu is a single quantity with two representations
> >>>>> +	denoted by the following nested keys.
> >>>>> +
> >>>>> +	  =====     ========================================
> >>>>> +	  count     Representing lgpu as anonymous resource
> >>>>> +	  list      Representing lgpu as named resource
> >>>>> +	  =====     ========================================
> >>>>> +
> >>>>> +	For example:
> >>>>> +	226:0 count=256 list=0-255
> >>>>> +	226:1 count=4 list=0,2,4,6
> >>>>> +	226:2 count=32 list=32-63
> >>>>> +
> >>>>> +	lgpu is represented by a bitmap and uses the bitmap_parselist
> >>>>> +	kernel function so the list key input format is a
> >>>>> +	comma-separated list of decimal numbers and ranges.
> >>>>> +
> >>>>> +	Consecutively set bits are shown as two hyphen-separated decimal
> >>>>> +	numbers, the smallest and largest bit numbers set in the range.
> >>>>> +	Optionally each range can be postfixed to denote that only parts
> >>>>> +	of it should be set.  The range will divided to groups of
> >>>>> +	specific size.
> >>>>> +	Syntax: range:used_size/group_size
> >>>>> +	Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> >>>>> +
> >>>>> +	The count key is the hamming weight / hweight of the bitmap.
> >>>>> +
> >>>>> +	Both count and list accept the max and default keywords.
> >>>>> +
> >>>>> +	Some DRM devices may only support lgpu as anonymous resources.
> >>>>> +	In such case, the significance of the position of the set bits
> >>>>> +	in list will be ignored.
> >>>>> +
> >>>>> +	This lgpu resource supports the 'allocation' resource
> >>>>> +	distribution model.
> >>>>> +
> >>>>>     GEM Buffer Ownership
> >>>>>     ~~~~~~~~~~~~~~~~~~~~
> >>>>>     
> >>>>> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> >>>>> index 6d9707e1eb72..a8d6be0b075b 100644
> >>>>> --- a/include/drm/drm_cgroup.h
> >>>>> +++ b/include/drm/drm_cgroup.h
> >>>>> @@ -6,6 +6,7 @@
> >>>>>     
> >>>>>     #include <linux/cgroup_drm.h>
> >>>>>     #include <linux/workqueue.h>
> >>>>> +#include <linux/types.h>
> >>>>>     #include <drm/ttm/ttm_bo_api.h>
> >>>>>     #include <drm/ttm/ttm_bo_driver.h>
> >>>>>     
> >>>>> @@ -28,6 +29,9 @@ struct drmcg_props {
> >>>>>     	s64			mem_highs_default[TTM_PL_PRIV+1];
> >>>>>     
> >>>>>     	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
> >>>>> +
> >>>>> +	int			lgpu_capacity;
> >>>>> +        DECLARE_BITMAP(lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
> >>>>>     };
> >>>>>     
> >>>>>     #ifdef CONFIG_CGROUP_DRM
> >>>>> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> >>>>> index c56cfe74d1a6..7b1cfc4ce4c3 100644
> >>>>> --- a/include/linux/cgroup_drm.h
> >>>>> +++ b/include/linux/cgroup_drm.h
> >>>>> @@ -14,6 +14,8 @@
> >>>>>     /* limit defined per the way drm_minor_alloc operates */
> >>>>>     #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
> >>>>>     
> >>>>> +#define MAX_DRMCG_LGPU_CAPACITY 256
> >>>>> +
> >>>>>     enum drmcg_mem_bw_attr {
> >>>>>     	DRMCG_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
> >>>>>     	DRMCG_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
> >>>>> @@ -32,6 +34,7 @@ enum drmcg_res_type {
> >>>>>     	DRMCG_TYPE_MEM_PEAK,
> >>>>>     	DRMCG_TYPE_BANDWIDTH,
> >>>>>     	DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
> >>>>> +	DRMCG_TYPE_LGPU,
> >>>>>     	__DRMCG_TYPE_LAST,
> >>>>>     };
> >>>>>     
> >>>>> @@ -58,6 +61,9 @@ struct drmcg_device_resource {
> >>>>>     	s64			mem_bw_stats[__DRMCG_MEM_BW_ATTR_LAST];
> >>>>>     	s64			mem_bw_limits_bytes_in_period;
> >>>>>     	s64			mem_bw_limits_avg_bytes_per_us;
> >>>>> +
> >>>>> +	s64			lgpu_used;
> >>>>> +	DECLARE_BITMAP(lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> >>>>>     };
> >>>>>     
> >>>>>     /**
> >>>>> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> >>>>> index 0ea7f0619e25..18c4368e2c29 100644
> >>>>> --- a/kernel/cgroup/drm.c
> >>>>> +++ b/kernel/cgroup/drm.c
> >>>>> @@ -9,6 +9,7 @@
> >>>>>     #include <linux/cgroup_drm.h>
> >>>>>     #include <linux/ktime.h>
> >>>>>     #include <linux/kernel.h>
> >>>>> +#include <linux/bitmap.h>
> >>>>>     #include <drm/drm_file.h>
> >>>>>     #include <drm/drm_drv.h>
> >>>>>     #include <drm/ttm/ttm_bo_api.h>
> >>>>> @@ -52,6 +53,9 @@ static char const *mem_bw_attr_names[] = {
> >>>>>     #define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
> >>>>>     #define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
> >>>>>     
> >>>>> +#define LGPU_LIMITS_NAME_LIST "list"
> >>>>> +#define LGPU_LIMITS_NAME_COUNT "count"
> >>>>> +
> >>>>>     static struct drmcg *root_drmcg __read_mostly;
> >>>>>     
> >>>>>     static int drmcg_css_free_fn(int id, void *ptr, void *data)
> >>>>> @@ -115,6 +119,10 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
> >>>>>     	for (i = 0; i <= TTM_PL_PRIV; i++)
> >>>>>     		ddr->mem_highs[i] = dev->drmcg_props.mem_highs_default[i];
> >>>>>     
> >>>>> +	bitmap_copy(ddr->lgpu_allocated, dev->drmcg_props.lgpu_slots,
> >>>>> +			MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +
> >>>>>     	mutex_unlock(&dev->drmcg_mutex);
> >>>>>     	return 0;
> >>>>>     }
> >>>>> @@ -280,6 +288,14 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
> >>>>>     				MEM_BW_LIMITS_NAME_AVG,
> >>>>>     				ddr->mem_bw_limits_avg_bytes_per_us);
> >>>>>     		break;
> >>>>> +	case DRMCG_TYPE_LGPU:
> >>>>> +		seq_printf(sf, "%s=%lld %s=%*pbl\n",
> >>>>> +				LGPU_LIMITS_NAME_COUNT,
> >>>>> +				ddr->lgpu_used,
> >>>>> +				LGPU_LIMITS_NAME_LIST,
> >>>>> +				dev->drmcg_props.lgpu_capacity,
> >>>>> +				ddr->lgpu_allocated);
> >>>>> +		break;
> >>>>>     	default:
> >>>>>     		seq_puts(sf, "\n");
> >>>>>     		break;
> >>>>> @@ -314,6 +330,15 @@ static void drmcg_print_default(struct drmcg_props *props,
> >>>>>     				MEM_BW_LIMITS_NAME_AVG,
> >>>>>     				props->mem_bw_avg_bytes_per_us_default);
> >>>>>     		break;
> >>>>> +	case DRMCG_TYPE_LGPU:
> >>>>> +		seq_printf(sf, "%s=%d %s=%*pbl\n",
> >>>>> +				LGPU_LIMITS_NAME_COUNT,
> >>>>> +				bitmap_weight(props->lgpu_slots,
> >>>>> +					props->lgpu_capacity),
> >>>>> +				LGPU_LIMITS_NAME_LIST,
> >>>>> +				props->lgpu_capacity,
> >>>>> +				props->lgpu_slots);
> >>>>> +		break;
> >>>>>     	default:
> >>>>>     		seq_puts(sf, "\n");
> >>>>>     		break;
> >>>>> @@ -407,9 +432,21 @@ static void drmcg_value_apply(struct drm_device *dev, s64 *dst, s64 val)
> >>>>>     	mutex_unlock(&dev->drmcg_mutex);
> >>>>>     }
> >>>>>     
> >>>>> +static void drmcg_lgpu_values_apply(struct drm_device *dev,
> >>>>> +		struct drmcg_device_resource *ddr, unsigned long *val)
> >>>>> +{
> >>>>> +
> >>>>> +	mutex_lock(&dev->drmcg_mutex);
> >>>>> +	bitmap_copy(ddr->lgpu_allocated, val, MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +	mutex_unlock(&dev->drmcg_mutex);
> >>>>> +}
> >>>>> +
> >>>>>     static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
> >>>>>     		struct drm_device *dev, char *attrs)
> >>>>>     {
> >>>>> +	DECLARE_BITMAP(tmp_bitmap, MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +	DECLARE_BITMAP(chk_bitmap, MAX_DRMCG_LGPU_CAPACITY);
> >>>>>     	enum drmcg_res_type type =
> >>>>>     		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
> >>>>>     	struct drmcg *drmcg = css_to_drmcg(of_css(of));
> >>>>> @@ -501,6 +538,83 @@ static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
> >>>>>     				continue;
> >>>>>     			}
> >>>>>     			break; /* DRMCG_TYPE_MEM */
> >>>>> +		case DRMCG_TYPE_LGPU:
> >>>>> +			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) &&
> >>>>> +				strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) )
> >>>>> +				continue;
> >>>>> +
> >>>>> +                        if (!strcmp("max", sval) ||
> >>>>> +					!strcmp("default", sval)) {
> >>>>> +				if (parent != NULL)
> >>>>> +					drmcg_lgpu_values_apply(dev, ddr,
> >>>>> +						parent->dev_resources[minor]->
> >>>>> +						lgpu_allocated);
> >>>>> +				else
> >>>>> +					drmcg_lgpu_values_apply(dev, ddr,
> >>>>> +						props->lgpu_slots);
> >>>>> +
> >>>>> +				continue;
> >>>>> +			}
> >>>>> +
> >>>>> +			if (strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) == 0) {
> >>>>> +				p_max = parent == NULL ? props->lgpu_capacity:
> >>>>> +					bitmap_weight(
> >>>>> +					parent->dev_resources[minor]->
> >>>>> +					lgpu_allocated, props->lgpu_capacity);
> >>>>> +
> >>>>> +				rc = drmcg_process_limit_s64_val(sval,
> >>>>> +					false, p_max, p_max, &val);
> >>>>> +
> >>>>> +				if (rc || val < 0) {
> >>>>> +					drmcg_pr_cft_err(drmcg, rc, cft_name,
> >>>>> +							minor);
> >>>>> +					continue;
> >>>>> +				}
> >>>>> +
> >>>>> +				bitmap_zero(tmp_bitmap,
> >>>>> +						MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +				bitmap_set(tmp_bitmap, 0, val);
> >>>>> +			}
> >>>>> +
> >>>>> +			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) == 0) {
> >>>>> +				rc = bitmap_parselist(sval, tmp_bitmap,
> >>>>> +						MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +
> >>>>> +				if (rc) {
> >>>>> +					drmcg_pr_cft_err(drmcg, rc, cft_name,
> >>>>> +							minor);
> >>>>> +					continue;
> >>>>> +				}
> >>>>> +
> >>>>> +                        	bitmap_andnot(chk_bitmap, tmp_bitmap,
> >>>>> +					props->lgpu_slots,
> >>>>> +					MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +
> >>>>> +                        	if (!bitmap_empty(chk_bitmap,
> >>>>> +						MAX_DRMCG_LGPU_CAPACITY)) {
> >>>>> +					drmcg_pr_cft_err(drmcg, 0, cft_name,
> >>>>> +							minor);
> >>>>> +					continue;
> >>>>> +				}
> >>>>> +			}
> >>>>> +
> >>>>> +
> >>>>> +                        if (parent != NULL) {
> >>>>> +				bitmap_and(chk_bitmap, tmp_bitmap,
> >>>>> +				parent->dev_resources[minor]->lgpu_allocated,
> >>>>> +				props->lgpu_capacity);
> >>>>> +
> >>>>> +				if (bitmap_empty(chk_bitmap,
> >>>>> +						props->lgpu_capacity)) {
> >>>>> +					drmcg_pr_cft_err(drmcg, 0,
> >>>>> +							cft_name, minor);
> >>>>> +					continue;
> >>>>> +				}
> >>>>> +			}
> >>>>> +
> >>>>> +			drmcg_lgpu_values_apply(dev, ddr, tmp_bitmap);
> >>>>> +
> >>>>> +			break; /* DRMCG_TYPE_LGPU */
> >>>>>     		default:
> >>>>>     			break;
> >>>>>     		} /* switch (type) */
> >>>>> @@ -606,6 +720,7 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
> >>>>>     			break;
> >>>>>     		case DRMCG_TYPE_BANDWIDTH:
> >>>>>     		case DRMCG_TYPE_MEM:
> >>>>> +		case DRMCG_TYPE_LGPU:
> >>>>>     			drmcg_nested_limit_parse(of, dm->dev, sattr);
> >>>>>     			break;
> >>>>>     		default:
> >>>>> @@ -731,6 +846,20 @@ struct cftype files[] = {
> >>>>>     		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
> >>>>>     						DRMCG_FTYPE_DEFAULT),
> >>>>>     	},
> >>>>> +	{
> >>>>> +		.name = "lgpu",
> >>>>> +		.seq_show = drmcg_seq_show,
> >>>>> +		.write = drmcg_limit_write,
> >>>>> +		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
> >>>>> +						DRMCG_FTYPE_LIMIT),
> >>>>> +	},
> >>>>> +	{
> >>>>> +		.name = "lgpu.default",
> >>>>> +		.seq_show = drmcg_seq_show,
> >>>>> +		.flags = CFTYPE_ONLY_ON_ROOT,
> >>>>> +		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
> >>>>> +						DRMCG_FTYPE_DEFAULT),
> >>>>> +	},
> >>>>>     	{ }	/* terminate */
> >>>>>     };
> >>>>>     
> >>>>> @@ -744,6 +873,10 @@ struct cgroup_subsys drm_cgrp_subsys = {
> >>>>>     
> >>>>>     static inline void drmcg_update_cg_tree(struct drm_device *dev)
> >>>>>     {
> >>>>> +        bitmap_zero(dev->drmcg_props.lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
> >>>>> +        bitmap_fill(dev->drmcg_props.lgpu_slots,
> >>>>> +			dev->drmcg_props.lgpu_capacity);
> >>>>> +
> >>>>>     	/* init cgroups created before registration (i.e. root cgroup) */
> >>>>>     	if (root_drmcg != NULL) {
> >>>>>     		struct cgroup_subsys_state *pos;
> >>>>> @@ -800,6 +933,8 @@ void drmcg_device_early_init(struct drm_device *dev)
> >>>>>     	for (i = 0; i <= TTM_PL_PRIV; i++)
> >>>>>     		dev->drmcg_props.mem_highs_default[i] = S64_MAX;
> >>>>>     
> >>>>> +	dev->drmcg_props.lgpu_capacity = MAX_DRMCG_LGPU_CAPACITY;
> >>>>> +
> >>>>>     	drmcg_update_cg_tree(dev);
> >>>>>     }
> >>>>>     EXPORT_SYMBOL(drmcg_device_early_init);

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
