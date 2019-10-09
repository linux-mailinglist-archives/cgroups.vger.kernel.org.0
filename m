Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3450CD0CD9
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 12:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJIKcA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 06:32:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46498 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKcA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Oct 2019 06:32:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3so1504337edw.13
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2019 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C09hf6FrUbFgNpbOyIyLe1LFZradLhmipE7Ti+d7/Fc=;
        b=FLYQUfwhwe39B/DVyFw2QiIK0b9aPWDeNshp65aTeEYRrp1oU7cow00fVQLlqp9jS6
         3irZkKftQJTOl6AxfXy8mkWgR15zu69fijOdg1hSzXE4qK8ZgRPeM1nvSWja1y4QLOTf
         pVTD5QRUtDG4s36v7AoqLjObLsBIX4dmQ6LOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C09hf6FrUbFgNpbOyIyLe1LFZradLhmipE7Ti+d7/Fc=;
        b=falTYxK8JGgH2Ht0JGi8xBhAiBU2cSTOOHPwxEItRYvaQt1AICLfAYt4mb3kksX/8m
         YvSG4/LTohHgKX1fe/OeIIEGBCBkar+fH8PG4KDmycxcznysQ8w6CRWmOYSyFojXmFHM
         ONARm/rMXT4vK5q9ioepw0huTzBc1CrydwMmOJ51oicmx6yfR5RAPPRimGad67GVaHkl
         RpEqm4/e7/fHX5yg1uTTW1ClE4HBOG8IbFjagknSfHFPxby+hpvh5sSuMgQs6aPodspz
         dA2w8nIFuWCIX7Fzwp11oFBEop/xK+s+dqQjb6e5E452BmMSfuAgWeq2msQYfR2aN0gS
         fvMA==
X-Gm-Message-State: APjAAAVpbP7zwpKvmNQTZ3sRhs0DVOM00cEUkTILo+avwsDhVZl9mWgV
        z0XdFUnZZeC1xAr8A1K1oG8SK6m/1Qo=
X-Google-Smtp-Source: APXvYqw6eBdluKZVzptk+2ysnQOd/2ld8j4pIJH1qyeQNv/7FOXPZf+S+7nqxwBebyBVHmmixXOO8A==
X-Received: by 2002:aa7:cb5a:: with SMTP id w26mr2275293edt.188.1570617117046;
        Wed, 09 Oct 2019 03:31:57 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p4sm291774eda.56.2019.10.09.03.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:31:55 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:31:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
Message-ID: <20191009103153.GU16989@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 08, 2019 at 06:53:18PM +0000, Kuehling, Felix wrote:
> On 2019-08-29 2:05 a.m., Kenny Ho wrote:
> > drm.lgpu
> >          A read-write nested-keyed file which exists on all cgroups.
> >          Each entry is keyed by the DRM device's major:minor.
> >
> >          lgpu stands for logical GPU, it is an abstraction used to
> >          subdivide a physical DRM device for the purpose of resource
> >          management.
> >
> >          The lgpu is a discrete quantity that is device specific (i.e.
> >          some DRM devices may have 64 lgpus while others may have 100
> >          lgpus.)  The lgpu is a single quantity with two representations
> >          denoted by the following nested keys.
> >
> >            =====     ========================================
> >            count     Representing lgpu as anonymous resource
> >            list      Representing lgpu as named resource
> >            =====     ========================================
> >
> >          For example:
> >          226:0 count=256 list=0-255
> >          226:1 count=4 list=0,2,4,6
> >          226:2 count=32 list=32-63
> >
> >          lgpu is represented by a bitmap and uses the bitmap_parselist
> >          kernel function so the list key input format is a
> >          comma-separated list of decimal numbers and ranges.
> >
> >          Consecutively set bits are shown as two hyphen-separated decimal
> >          numbers, the smallest and largest bit numbers set in the range.
> >          Optionally each range can be postfixed to denote that only parts
> >          of it should be set.  The range will divided to groups of
> >          specific size.
> >          Syntax: range:used_size/group_size
> >          Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> >
> >          The count key is the hamming weight / hweight of the bitmap.
> >
> >          Both count and list accept the max and default keywords.
> >
> >          Some DRM devices may only support lgpu as anonymous resources.
> >          In such case, the significance of the position of the set bits
> >          in list will be ignored.
> >
> >          This lgpu resource supports the 'allocation' resource
> >          distribution model.
> >
> > Change-Id: I1afcacf356770930c7f925df043e51ad06ceb98e
> > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> 
> The description sounds reasonable to me and maps well to the CU masking 
> feature in our GPUs.
> 
> It would also allow us to do more coarse-grained masking for example to 
> guarantee balanced allocation of CUs across shader engines or 
> partitioning of memory bandwidth or CP pipes (if that is supported by 
> the hardware/firmware).

Hm, so this sounds like the definition for how this cgroup is supposed to
work is "amd CU masking" (whatever that exactly is). And the abstract
description is just prettification on top, but not actually the real
definition you guys want.

I think adding a cgroup which is that much depending upon the hw
implementation of the first driver supporting it is not a good idea.
-Daniel

> 
> I can't comment on the code as I'm unfamiliar with the details of the 
> cgroup code.
> 
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> 
> > ---
> >   Documentation/admin-guide/cgroup-v2.rst |  46 ++++++++
> >   include/drm/drm_cgroup.h                |   4 +
> >   include/linux/cgroup_drm.h              |   6 ++
> >   kernel/cgroup/drm.c                     | 135 ++++++++++++++++++++++++
> >   4 files changed, 191 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 87a195133eaa..57f18469bd76 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1958,6 +1958,52 @@ DRM Interface Files
> >   	Set largest allocation for /dev/dri/card1 to 4MB
> >   	echo "226:1 4m" > drm.buffer.peak.max
> >   
> > +  drm.lgpu
> > +	A read-write nested-keyed file which exists on all cgroups.
> > +	Each entry is keyed by the DRM device's major:minor.
> > +
> > +	lgpu stands for logical GPU, it is an abstraction used to
> > +	subdivide a physical DRM device for the purpose of resource
> > +	management.
> > +
> > +	The lgpu is a discrete quantity that is device specific (i.e.
> > +	some DRM devices may have 64 lgpus while others may have 100
> > +	lgpus.)  The lgpu is a single quantity with two representations
> > +	denoted by the following nested keys.
> > +
> > +	  =====     ========================================
> > +	  count     Representing lgpu as anonymous resource
> > +	  list      Representing lgpu as named resource
> > +	  =====     ========================================
> > +
> > +	For example:
> > +	226:0 count=256 list=0-255
> > +	226:1 count=4 list=0,2,4,6
> > +	226:2 count=32 list=32-63
> > +
> > +	lgpu is represented by a bitmap and uses the bitmap_parselist
> > +	kernel function so the list key input format is a
> > +	comma-separated list of decimal numbers and ranges.
> > +
> > +	Consecutively set bits are shown as two hyphen-separated decimal
> > +	numbers, the smallest and largest bit numbers set in the range.
> > +	Optionally each range can be postfixed to denote that only parts
> > +	of it should be set.  The range will divided to groups of
> > +	specific size.
> > +	Syntax: range:used_size/group_size
> > +	Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> > +
> > +	The count key is the hamming weight / hweight of the bitmap.
> > +
> > +	Both count and list accept the max and default keywords.
> > +
> > +	Some DRM devices may only support lgpu as anonymous resources.
> > +	In such case, the significance of the position of the set bits
> > +	in list will be ignored.
> > +
> > +	This lgpu resource supports the 'allocation' resource
> > +	distribution model.
> > +
> >   GEM Buffer Ownership
> >   ~~~~~~~~~~~~~~~~~~~~
> >   
> > diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> > index 6d9707e1eb72..a8d6be0b075b 100644
> > --- a/include/drm/drm_cgroup.h
> > +++ b/include/drm/drm_cgroup.h
> > @@ -6,6 +6,7 @@
> >   
> >   #include <linux/cgroup_drm.h>
> >   #include <linux/workqueue.h>
> > +#include <linux/types.h>
> >   #include <drm/ttm/ttm_bo_api.h>
> >   #include <drm/ttm/ttm_bo_driver.h>
> >   
> > @@ -28,6 +29,9 @@ struct drmcg_props {
> >   	s64			mem_highs_default[TTM_PL_PRIV+1];
> >   
> >   	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
> > +
> > +	int			lgpu_capacity;
> > +        DECLARE_BITMAP(lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
> >   };
> >   
> >   #ifdef CONFIG_CGROUP_DRM
> > diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> > index c56cfe74d1a6..7b1cfc4ce4c3 100644
> > --- a/include/linux/cgroup_drm.h
> > +++ b/include/linux/cgroup_drm.h
> > @@ -14,6 +14,8 @@
> >   /* limit defined per the way drm_minor_alloc operates */
> >   #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
> >   
> > +#define MAX_DRMCG_LGPU_CAPACITY 256
> > +
> >   enum drmcg_mem_bw_attr {
> >   	DRMCG_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
> >   	DRMCG_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
> > @@ -32,6 +34,7 @@ enum drmcg_res_type {
> >   	DRMCG_TYPE_MEM_PEAK,
> >   	DRMCG_TYPE_BANDWIDTH,
> >   	DRMCG_TYPE_BANDWIDTH_PERIOD_BURST,
> > +	DRMCG_TYPE_LGPU,
> >   	__DRMCG_TYPE_LAST,
> >   };
> >   
> > @@ -58,6 +61,9 @@ struct drmcg_device_resource {
> >   	s64			mem_bw_stats[__DRMCG_MEM_BW_ATTR_LAST];
> >   	s64			mem_bw_limits_bytes_in_period;
> >   	s64			mem_bw_limits_avg_bytes_per_us;
> > +
> > +	s64			lgpu_used;
> > +	DECLARE_BITMAP(lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> >   };
> >   
> >   /**
> > diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> > index 0ea7f0619e25..18c4368e2c29 100644
> > --- a/kernel/cgroup/drm.c
> > +++ b/kernel/cgroup/drm.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/cgroup_drm.h>
> >   #include <linux/ktime.h>
> >   #include <linux/kernel.h>
> > +#include <linux/bitmap.h>
> >   #include <drm/drm_file.h>
> >   #include <drm/drm_drv.h>
> >   #include <drm/ttm/ttm_bo_api.h>
> > @@ -52,6 +53,9 @@ static char const *mem_bw_attr_names[] = {
> >   #define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
> >   #define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
> >   
> > +#define LGPU_LIMITS_NAME_LIST "list"
> > +#define LGPU_LIMITS_NAME_COUNT "count"
> > +
> >   static struct drmcg *root_drmcg __read_mostly;
> >   
> >   static int drmcg_css_free_fn(int id, void *ptr, void *data)
> > @@ -115,6 +119,10 @@ static inline int init_drmcg_single(struct drmcg *drmcg, struct drm_device *dev)
> >   	for (i = 0; i <= TTM_PL_PRIV; i++)
> >   		ddr->mem_highs[i] = dev->drmcg_props.mem_highs_default[i];
> >   
> > +	bitmap_copy(ddr->lgpu_allocated, dev->drmcg_props.lgpu_slots,
> > +			MAX_DRMCG_LGPU_CAPACITY);
> > +	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> > +
> >   	mutex_unlock(&dev->drmcg_mutex);
> >   	return 0;
> >   }
> > @@ -280,6 +288,14 @@ static void drmcg_print_limits(struct drmcg_device_resource *ddr,
> >   				MEM_BW_LIMITS_NAME_AVG,
> >   				ddr->mem_bw_limits_avg_bytes_per_us);
> >   		break;
> > +	case DRMCG_TYPE_LGPU:
> > +		seq_printf(sf, "%s=%lld %s=%*pbl\n",
> > +				LGPU_LIMITS_NAME_COUNT,
> > +				ddr->lgpu_used,
> > +				LGPU_LIMITS_NAME_LIST,
> > +				dev->drmcg_props.lgpu_capacity,
> > +				ddr->lgpu_allocated);
> > +		break;
> >   	default:
> >   		seq_puts(sf, "\n");
> >   		break;
> > @@ -314,6 +330,15 @@ static void drmcg_print_default(struct drmcg_props *props,
> >   				MEM_BW_LIMITS_NAME_AVG,
> >   				props->mem_bw_avg_bytes_per_us_default);
> >   		break;
> > +	case DRMCG_TYPE_LGPU:
> > +		seq_printf(sf, "%s=%d %s=%*pbl\n",
> > +				LGPU_LIMITS_NAME_COUNT,
> > +				bitmap_weight(props->lgpu_slots,
> > +					props->lgpu_capacity),
> > +				LGPU_LIMITS_NAME_LIST,
> > +				props->lgpu_capacity,
> > +				props->lgpu_slots);
> > +		break;
> >   	default:
> >   		seq_puts(sf, "\n");
> >   		break;
> > @@ -407,9 +432,21 @@ static void drmcg_value_apply(struct drm_device *dev, s64 *dst, s64 val)
> >   	mutex_unlock(&dev->drmcg_mutex);
> >   }
> >   
> > +static void drmcg_lgpu_values_apply(struct drm_device *dev,
> > +		struct drmcg_device_resource *ddr, unsigned long *val)
> > +{
> > +
> > +	mutex_lock(&dev->drmcg_mutex);
> > +	bitmap_copy(ddr->lgpu_allocated, val, MAX_DRMCG_LGPU_CAPACITY);
> > +	ddr->lgpu_used = bitmap_weight(ddr->lgpu_allocated, MAX_DRMCG_LGPU_CAPACITY);
> > +	mutex_unlock(&dev->drmcg_mutex);
> > +}
> > +
> >   static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
> >   		struct drm_device *dev, char *attrs)
> >   {
> > +	DECLARE_BITMAP(tmp_bitmap, MAX_DRMCG_LGPU_CAPACITY);
> > +	DECLARE_BITMAP(chk_bitmap, MAX_DRMCG_LGPU_CAPACITY);
> >   	enum drmcg_res_type type =
> >   		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
> >   	struct drmcg *drmcg = css_to_drmcg(of_css(of));
> > @@ -501,6 +538,83 @@ static void drmcg_nested_limit_parse(struct kernfs_open_file *of,
> >   				continue;
> >   			}
> >   			break; /* DRMCG_TYPE_MEM */
> > +		case DRMCG_TYPE_LGPU:
> > +			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) &&
> > +				strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) )
> > +				continue;
> > +
> > +                        if (!strcmp("max", sval) ||
> > +					!strcmp("default", sval)) {
> > +				if (parent != NULL)
> > +					drmcg_lgpu_values_apply(dev, ddr,
> > +						parent->dev_resources[minor]->
> > +						lgpu_allocated);
> > +				else
> > +					drmcg_lgpu_values_apply(dev, ddr,
> > +						props->lgpu_slots);
> > +
> > +				continue;
> > +			}
> > +
> > +			if (strncmp(sname, LGPU_LIMITS_NAME_COUNT, 256) == 0) {
> > +				p_max = parent == NULL ? props->lgpu_capacity:
> > +					bitmap_weight(
> > +					parent->dev_resources[minor]->
> > +					lgpu_allocated, props->lgpu_capacity);
> > +
> > +				rc = drmcg_process_limit_s64_val(sval,
> > +					false, p_max, p_max, &val);
> > +
> > +				if (rc || val < 0) {
> > +					drmcg_pr_cft_err(drmcg, rc, cft_name,
> > +							minor);
> > +					continue;
> > +				}
> > +
> > +				bitmap_zero(tmp_bitmap,
> > +						MAX_DRMCG_LGPU_CAPACITY);
> > +				bitmap_set(tmp_bitmap, 0, val);
> > +			}
> > +
> > +			if (strncmp(sname, LGPU_LIMITS_NAME_LIST, 256) == 0) {
> > +				rc = bitmap_parselist(sval, tmp_bitmap,
> > +						MAX_DRMCG_LGPU_CAPACITY);
> > +
> > +				if (rc) {
> > +					drmcg_pr_cft_err(drmcg, rc, cft_name,
> > +							minor);
> > +					continue;
> > +				}
> > +
> > +                        	bitmap_andnot(chk_bitmap, tmp_bitmap,
> > +					props->lgpu_slots,
> > +					MAX_DRMCG_LGPU_CAPACITY);
> > +
> > +                        	if (!bitmap_empty(chk_bitmap,
> > +						MAX_DRMCG_LGPU_CAPACITY)) {
> > +					drmcg_pr_cft_err(drmcg, 0, cft_name,
> > +							minor);
> > +					continue;
> > +				}
> > +			}
> > +
> > +
> > +                        if (parent != NULL) {
> > +				bitmap_and(chk_bitmap, tmp_bitmap,
> > +				parent->dev_resources[minor]->lgpu_allocated,
> > +				props->lgpu_capacity);
> > +
> > +				if (bitmap_empty(chk_bitmap,
> > +						props->lgpu_capacity)) {
> > +					drmcg_pr_cft_err(drmcg, 0,
> > +							cft_name, minor);
> > +					continue;
> > +				}
> > +			}
> > +
> > +			drmcg_lgpu_values_apply(dev, ddr, tmp_bitmap);
> > +
> > +			break; /* DRMCG_TYPE_LGPU */
> >   		default:
> >   			break;
> >   		} /* switch (type) */
> > @@ -606,6 +720,7 @@ static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *buf,
> >   			break;
> >   		case DRMCG_TYPE_BANDWIDTH:
> >   		case DRMCG_TYPE_MEM:
> > +		case DRMCG_TYPE_LGPU:
> >   			drmcg_nested_limit_parse(of, dm->dev, sattr);
> >   			break;
> >   		default:
> > @@ -731,6 +846,20 @@ struct cftype files[] = {
> >   		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_BANDWIDTH,
> >   						DRMCG_FTYPE_DEFAULT),
> >   	},
> > +	{
> > +		.name = "lgpu",
> > +		.seq_show = drmcg_seq_show,
> > +		.write = drmcg_limit_write,
> > +		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
> > +						DRMCG_FTYPE_LIMIT),
> > +	},
> > +	{
> > +		.name = "lgpu.default",
> > +		.seq_show = drmcg_seq_show,
> > +		.flags = CFTYPE_ONLY_ON_ROOT,
> > +		.private = DRMCG_CTF_PRIV(DRMCG_TYPE_LGPU,
> > +						DRMCG_FTYPE_DEFAULT),
> > +	},
> >   	{ }	/* terminate */
> >   };
> >   
> > @@ -744,6 +873,10 @@ struct cgroup_subsys drm_cgrp_subsys = {
> >   
> >   static inline void drmcg_update_cg_tree(struct drm_device *dev)
> >   {
> > +        bitmap_zero(dev->drmcg_props.lgpu_slots, MAX_DRMCG_LGPU_CAPACITY);
> > +        bitmap_fill(dev->drmcg_props.lgpu_slots,
> > +			dev->drmcg_props.lgpu_capacity);
> > +
> >   	/* init cgroups created before registration (i.e. root cgroup) */
> >   	if (root_drmcg != NULL) {
> >   		struct cgroup_subsys_state *pos;
> > @@ -800,6 +933,8 @@ void drmcg_device_early_init(struct drm_device *dev)
> >   	for (i = 0; i <= TTM_PL_PRIV; i++)
> >   		dev->drmcg_props.mem_highs_default[i] = S64_MAX;
> >   
> > +	dev->drmcg_props.lgpu_capacity = MAX_DRMCG_LGPU_CAPACITY;
> > +
> >   	drmcg_update_cg_tree(dev);
> >   }
> >   EXPORT_SYMBOL(drmcg_device_early_init);

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
