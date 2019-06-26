Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAA56EA7
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZQ0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:26:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37733 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQ0A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 12:26:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so4175681eds.4
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wXVB1ogimBYWCsj5DQaPz0snreLFCbqXwAA91GksFRM=;
        b=c8KcvE/hpjouZhYKOF3uLtFykHcEcpVLvvBpVIUXsZi0wrJrxqUx4Wm0qoNCPVBRWO
         q07kNqM1JArocbv2ehq8ELUvzlQv0gR9odfXS7dbz9chIhHV3CSq9/naQJdZFAExbyK8
         7wds33rr1eDTiWvZaSFAndq0GehUafr0na2zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wXVB1ogimBYWCsj5DQaPz0snreLFCbqXwAA91GksFRM=;
        b=YOVHwCJ7YWskmCjXfZ7GrX/ljMC7wOHB8P2sBMNXGJd/Tg4QTiOph22BHXrY+FVdT1
         m2fH9K/gaXYVcn7O16Vq9SlbgQ8u9vsve46kXtmutr0rzjbJY3oIKqT8uFcLcIbTrByC
         SZDhEcPggpjStTZmwa/7cN+GxKDSP5pLEcD8Pa2sDHe122hnQPj/4XCUJ7j59Wu+Nxp3
         xrWoEL5IGgs44dhdrmSxqXBNJ+ThZ/kR+ypEAbTHg/93EcERxVV51Bpl4reN8ZxUbyU7
         koznqJaknwGwAYl+EdUg5uH3z3c2n3uUlwFyws4FtCq8S3hOCo0oPngFc/EnBNPef7H6
         3HAA==
X-Gm-Message-State: APjAAAWcpkojX3FECoV5BGtqoPqaUZzpDhVUX4Vrm08FmAK6R3G0jho4
        glgqK9KPdBdWzgpUIC3kdxR2VA==
X-Google-Smtp-Source: APXvYqzQlj9V+SeQ0FWIGCTQ2ntaSXDwZPoXvLuVdAjI+YXcHuEHokcOswWUTbdEDjAk5LSXh9bj5Q==
X-Received: by 2002:a17:906:768a:: with SMTP id o10mr2890684ejm.159.1561566358047;
        Wed, 26 Jun 2019 09:25:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i6sm6041607eda.79.2019.06.26.09.25.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:25:57 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:25:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and
 control
Message-ID: <20190626162554.GU12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-10-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626150522.11618-10-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:20AM -0400, Kenny Ho wrote:
> The bandwidth is measured by keeping track of the amount of bytes moved
> by ttm within a time period.  We defined two type of bandwidth: burst
> and average.  Average bandwidth is calculated by dividing the total
> amount of bytes moved within a cgroup by the lifetime of the cgroup.
> Burst bandwidth is similar except that the byte and time measurement is
> reset after a user configurable period.
> 
> The bandwidth control is best effort since it is done on a per move
> basis instead of per byte.  The bandwidth is limited by delaying the
> move of a buffer.  The bandwidth limit can be exceeded when the next
> move is larger than the remaining allowance.
> 
> drm.burst_bw_period_in_us
>         A read-write flat-keyed file which exists on the root cgroup.
>         Each entry is keyed by the drm device's major:minor.
> 
>         Length of a period use to measure burst bandwidth in us.
>         One period per device.
> 
> drm.burst_bw_period_in_us.default
>         A read-only flat-keyed file which exists on the root cgroup.
>         Each entry is keyed by the drm device's major:minor.
> 
>         Default length of a period in us (one per device.)
> 
> drm.bandwidth.stats
>         A read-only nested-keyed file which exists on all cgroups.
>         Each entry is keyed by the drm device's major:minor.  The
>         following nested keys are defined.
> 
>           =================     ======================================
>           burst_byte_per_us     Burst bandwidth
>           avg_bytes_per_us      Average bandwidth
>           moved_byte            Amount of byte moved within a period
>           accum_us              Amount of time accumulated in a period
>           total_moved_byte      Byte moved within the cgroup lifetime
>           total_accum_us        Cgroup lifetime in us
>           byte_credit           Available byte credit to limit avg bw
>           =================     ======================================
> 
>         Reading returns the following::
>         226:1 burst_byte_per_us=23 avg_bytes_per_us=0 moved_byte=2244608
>         accum_us=95575 total_moved_byte=45899776 total_accum_us=201634590
>         byte_credit=13214278590464
>         226:2 burst_byte_per_us=10 avg_bytes_per_us=219 moved_byte=430080
>         accum_us=39350 total_moved_byte=65518026752 total_accum_us=298337721
>         byte_credit=9223372036854644735
> 
> drm.bandwidth.high
>         A read-write nested-keyed file which exists on all cgroups.
>         Each entry is keyed by the drm device's major:minor.  The
>         following nested keys are defined.
> 
>           ================  =======================================
>           bytes_in_period   Burst limit per period in byte
>           avg_bytes_per_us  Average bandwidth limit in bytes per us
>           ================  =======================================
> 
>         Reading returns the following::
> 
>         226:1 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
>         226:2 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
> 
> drm.bandwidth.default
>         A read-only nested-keyed file which exists on the root cgroup.
>         Each entry is keyed by the drm device's major:minor.  The
>         following nested keys are defined.
> 
>           ================  ========================================
>           bytes_in_period   Default burst limit per period in byte
>           avg_bytes_per_us  Default average bw limit in bytes per us
>           ================  ========================================
> 
>         Reading returns the following::
> 
>         226:1 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
>         226:2 bytes_in_period=9223372036854775807 avg_bytes_per_us=65536
> 
> Change-Id: Ie573491325ccc16535bb943e7857f43bd0962add
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

So I'm not too sure exposing this is a great idea, at least depending upon
what you're trying to do with it. There's a few concerns here:

- I think bo movement stats might be useful, but they're not telling you
  everything. Applications can also copy data themselves and put buffers
  where they want them, especially with more explicit apis like vk.

- which kind of moves are we talking about here? Eviction related bo moves
  seem not counted here, and if you have lots of gpus with funny
  interconnects you might also get other kinds of moves, not just system
  ram <-> vram.

- What happens if we slow down, but someone else needs to evict our
  buffers/move them (ttm is atm not great at this, but Christian König is
  working on patches). I think there's lots of priority inversion
  potential here.

- If the goal is to avoid thrashing the interconnects, then this isn't the
  full picture by far - apps can use copy engines and explicit placement,
  again that's how vulkan at least is supposed to work.

I guess these all boil down to: What do you want to achieve here? The
commit message doesn't explain the intended use-case of this.
-Daniel

> ---
>  drivers/gpu/drm/ttm/ttm_bo.c |   7 +
>  include/drm/drm_cgroup.h     |  13 ++
>  include/linux/cgroup_drm.h   |  14 ++
>  kernel/cgroup/drm.c          | 309 ++++++++++++++++++++++++++++++++++-
>  4 files changed, 340 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index e9f70547f0ad..f06c2b9d8a4a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -36,6 +36,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/drm_cgroup.h>
>  #include <linux/jiffies.h>
> +#include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
> @@ -1176,6 +1177,12 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
>  	 * Check whether we need to move buffer.
>  	 */
>  	if (!ttm_bo_mem_compat(placement, &bo->mem, &new_flags)) {
> +		unsigned int move_delay = drmcgrp_get_mem_bw_period_in_us(bo);
> +		move_delay /= 2000; /* check every half period in ms*/
> +		while (bo->bdev->ddev != NULL && !drmcgrp_mem_can_move(bo)) {
> +			msleep(move_delay);
> +		}
> +
>  		ret = ttm_bo_move_buffer(bo, placement, ctx);
>  		if (ret)
>  			return ret;
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> index 48ab5450cf17..9b1dbd6a4eca 100644
> --- a/include/drm/drm_cgroup.h
> +++ b/include/drm/drm_cgroup.h
> @@ -23,6 +23,8 @@ void drmcgrp_chg_mem(struct ttm_buffer_object *tbo);
>  void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo);
>  void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  		struct ttm_mem_reg *new_mem);
> +unsigned int drmcgrp_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo);
> +bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo);
>  
>  #else
>  static inline int drmcgrp_register_device(struct drm_device *device)
> @@ -69,5 +71,16 @@ static inline void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo,
>  		bool evict, struct ttm_mem_reg *new_mem)
>  {
>  }
> +
> +static inline unsigned int drmcgrp_get_mem_bw_period_in_us(
> +		struct ttm_buffer_object *tbo)
> +{
> +	return 0;
> +}
> +
> +static inline bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_CGROUP_DRM */
>  #endif /* __DRM_CGROUP_H__ */
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index 922529641df5..94828da2104a 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -14,6 +14,15 @@
>  /* limit defined per the way drm_minor_alloc operates */
>  #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
>  
> +enum drmcgrp_mem_bw_attr {
> +    DRMCGRP_MEM_BW_ATTR_BYTE_MOVED, /* for calulating 'instantaneous' bw */
> +    DRMCGRP_MEM_BW_ATTR_ACCUM_US,  /* for calulating 'instantaneous' bw */
> +    DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED,
> +    DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US,
> +    DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT,
> +    __DRMCGRP_MEM_BW_ATTR_LAST,
> +};
> +
>  struct drmcgrp_device_resource {
>  	/* for per device stats */
>  	s64			bo_stats_total_allocated;
> @@ -27,6 +36,11 @@ struct drmcgrp_device_resource {
>  	s64			mem_stats[TTM_PL_PRIV+1];
>  	s64			mem_peaks[TTM_PL_PRIV+1];
>  	s64			mem_stats_evict;
> +
> +	s64			mem_bw_stats_last_update_us;
> +	s64			mem_bw_stats[__DRMCGRP_MEM_BW_ATTR_LAST];
> +	s64			mem_bw_limits_bytes_in_period;
> +	s64			mem_bw_limits_avg_bytes_per_us;
>  };
>  
>  struct drmcgrp {
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 5f5fa6a2b068..bbc6612200a4 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -7,6 +7,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/mutex.h>
>  #include <linux/cgroup_drm.h>
> +#include <linux/ktime.h>
>  #include <linux/kernel.h>
>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_bo_driver.h>
> @@ -22,6 +23,12 @@ struct drmcgrp_device {
>  
>  	s64			bo_limits_total_allocated_default;
>  	size_t			bo_limits_peak_allocated_default;
> +
> +	s64			mem_bw_limits_period_in_us;
> +	s64			mem_bw_limits_period_in_us_default;
> +
> +	s64			mem_bw_bytes_in_period_default;
> +	s64			mem_bw_avg_bytes_per_us_default;
>  };
>  
>  #define DRMCG_CTF_PRIV_SIZE 3
> @@ -39,6 +46,8 @@ enum drmcgrp_res_type {
>  	DRMCGRP_TYPE_MEM,
>  	DRMCGRP_TYPE_MEM_EVICT,
>  	DRMCGRP_TYPE_MEM_PEAK,
> +	DRMCGRP_TYPE_BANDWIDTH,
> +	DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
>  };
>  
>  enum drmcgrp_file_type {
> @@ -54,6 +63,17 @@ static char const *ttm_placement_names[] = {
>  	[TTM_PL_PRIV]   = "priv",
>  };
>  
> +static char const *mem_bw_attr_names[] = {
> +	[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED] = "moved_byte",
> +	[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = "accum_us",
> +	[DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED] = "total_moved_byte",
> +	[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US] = "total_accum_us",
> +	[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT] = "byte_credit",
> +};
> +
> +#define MEM_BW_LIMITS_NAME_AVG "avg_bytes_per_us"
> +#define MEM_BW_LIMITS_NAME_BURST "bytes_in_period"
> +
>  /* indexed by drm_minor for access speed */
>  static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
>  
> @@ -86,6 +106,9 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
>  		if (!ddr)
>  			return -ENOMEM;
>  
> +		ddr->mem_bw_stats_last_update_us = ktime_to_us(ktime_get());
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = 1;
> +
>  		drmcgrp->dev_resources[minor] = ddr;
>  	}
>  
> @@ -96,6 +119,12 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
>  
>  		ddr->bo_limits_peak_allocated =
>  		  known_drmcgrp_devs[minor]->bo_limits_peak_allocated_default;
> +
> +		ddr->mem_bw_limits_bytes_in_period =
> +		  known_drmcgrp_devs[minor]->mem_bw_bytes_in_period_default;
> +
> +		ddr->mem_bw_limits_avg_bytes_per_us =
> +		  known_drmcgrp_devs[minor]->mem_bw_avg_bytes_per_us_default;
>  	}
>  
>  	return 0;
> @@ -143,6 +172,26 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
>  	return &drmcgrp->css;
>  }
>  
> +static inline void drmcgrp_mem_burst_bw_stats_reset(struct drm_device *dev)
> +{
> +	struct cgroup_subsys_state *pos;
> +	struct drmcgrp *node;
> +	struct drmcgrp_device_resource *ddr;
> +	int devIdx;
> +
> +	devIdx =  dev->primary->index;
> +
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
> +		node = css_drmcgrp(pos);
> +		ddr = node->dev_resources[devIdx];
> +
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] = 1;
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED] = 0;
> +	}
> +	rcu_read_unlock();
> +}
> +
>  static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  		struct seq_file *sf, enum drmcgrp_res_type type)
>  {
> @@ -179,6 +228,31 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  		}
>  		seq_puts(sf, "\n");
>  		break;
> +	case DRMCGRP_TYPE_BANDWIDTH:
> +		if (ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] == 0)
> +			seq_puts(sf, "burst_byte_per_us=NaN ");
> +		else
> +			seq_printf(sf, "burst_byte_per_us=%lld ",
> +				ddr->mem_bw_stats[
> +				DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]/
> +				ddr->mem_bw_stats[
> +				DRMCGRP_MEM_BW_ATTR_ACCUM_US]);
> +
> +		if (ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US] == 0)
> +			seq_puts(sf, "avg_bytes_per_us=NaN ");
> +		else
> +			seq_printf(sf, "avg_bytes_per_us=%lld ",
> +				ddr->mem_bw_stats[
> +				DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED]/
> +				ddr->mem_bw_stats[
> +				DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US]);
> +
> +		for (i = 0; i < __DRMCGRP_MEM_BW_ATTR_LAST; i++) {
> +			seq_printf(sf, "%s=%lld ", mem_bw_attr_names[i],
> +					ddr->mem_bw_stats[i]);
> +		}
> +		seq_puts(sf, "\n");
> +		break;
>  	default:
>  		seq_puts(sf, "\n");
>  		break;
> @@ -186,9 +260,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  }
>  
>  static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
> -		struct seq_file *sf, enum drmcgrp_res_type type)
> +		struct seq_file *sf, enum drmcgrp_res_type type, int minor)
>  {
> -	if (ddr == NULL) {
> +	if (ddr == NULL || known_drmcgrp_devs[minor] == NULL) {
>  		seq_puts(sf, "\n");
>  		return;
>  	}
> @@ -200,6 +274,17 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
>  	case DRMCGRP_TYPE_BO_PEAK:
>  		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
>  		break;
> +	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
> +		seq_printf(sf, "%lld\n",
> +			known_drmcgrp_devs[minor]->mem_bw_limits_period_in_us);
> +		break;
> +	case DRMCGRP_TYPE_BANDWIDTH:
> +		seq_printf(sf, "%s=%lld %s=%lld\n",
> +				MEM_BW_LIMITS_NAME_BURST,
> +				ddr->mem_bw_limits_bytes_in_period,
> +				MEM_BW_LIMITS_NAME_AVG,
> +				ddr->mem_bw_limits_avg_bytes_per_us);
> +		break;
>  	default:
>  		seq_puts(sf, "\n");
>  		break;
> @@ -223,6 +308,17 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
>  		seq_printf(sf, "%zu\n",
>  				ddev->bo_limits_peak_allocated_default);
>  		break;
> +	case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
> +		seq_printf(sf, "%lld\n",
> +				ddev->mem_bw_limits_period_in_us_default);
> +		break;
> +	case DRMCGRP_TYPE_BANDWIDTH:
> +		seq_printf(sf, "%s=%lld %s=%lld\n",
> +				MEM_BW_LIMITS_NAME_BURST,
> +				ddev->mem_bw_bytes_in_period_default,
> +				MEM_BW_LIMITS_NAME_AVG,
> +				ddev->mem_bw_avg_bytes_per_us_default);
> +		break;
>  	default:
>  		seq_puts(sf, "\n");
>  		break;
> @@ -251,7 +347,7 @@ int drmcgrp_bo_show(struct seq_file *sf, void *v)
>  			drmcgrp_print_stats(ddr, sf, type);
>  			break;
>  		case DRMCGRP_FTYPE_LIMIT:
> -			drmcgrp_print_limits(ddr, sf, type);
> +			drmcgrp_print_limits(ddr, sf, type, i);
>  			break;
>  		case DRMCGRP_FTYPE_DEFAULT:
>  			drmcgrp_print_default(ddev, sf, type);
> @@ -317,6 +413,9 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
>  	struct drmcgrp_device_resource *ddr;
>  	char *line;
>  	char sattr[256];
> +	char sval[256];
> +	char *nested;
> +	char *attr;
>  	s64 val;
>  	s64 p_max;
>  	int rc;
> @@ -381,6 +480,78 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
>  
>  			ddr->bo_limits_peak_allocated = val;
>  			break;
> +		case DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST:
> +			rc = drmcgrp_process_limit_val(sattr, false,
> +				ddev->mem_bw_limits_period_in_us_default,
> +				S64_MAX,
> +				&val);
> +
> +			if (rc || val < 2000) {
> +				drmcgrp_pr_cft_err(drmcgrp, cft_name, minor);
> +				continue;
> +			}
> +
> +			ddev->mem_bw_limits_period_in_us= val;
> +			drmcgrp_mem_burst_bw_stats_reset(ddev->dev);
> +			break;
> +		case DRMCGRP_TYPE_BANDWIDTH:
> +			nested = strstrip(sattr);
> +
> +			while (nested != NULL) {
> +				attr = strsep(&nested, " ");
> +
> +				if (sscanf(attr, MEM_BW_LIMITS_NAME_BURST"=%s",
> +							sval) == 1) {
> +					p_max = parent == NULL ? S64_MAX :
> +						parent->
> +						dev_resources[minor]->
> +						mem_bw_limits_bytes_in_period;
> +
> +					rc = drmcgrp_process_limit_val(sval,
> +						true,
> +						ddev->
> +						mem_bw_bytes_in_period_default,
> +						p_max,
> +						&val);
> +
> +					if (rc || val < 0) {
> +						drmcgrp_pr_cft_err(drmcgrp,
> +								cft_name,
> +								minor);
> +						continue;
> +					}
> +
> +					ddr->mem_bw_limits_bytes_in_period=val;
> +					continue;
> +				}
> +
> +				if (sscanf(attr, MEM_BW_LIMITS_NAME_AVG"=%s",
> +							sval) == 1) {
> +					p_max = parent == NULL ? S64_MAX :
> +						parent->
> +						dev_resources[minor]->
> +						mem_bw_limits_avg_bytes_per_us;
> +
> +					rc = drmcgrp_process_limit_val(sval,
> +						true,
> +						ddev->
> +					      mem_bw_avg_bytes_per_us_default,
> +						p_max,
> +						&val);
> +
> +					if (rc || val < 0) {
> +						drmcgrp_pr_cft_err(drmcgrp,
> +								cft_name,
> +								minor);
> +						continue;
> +					}
> +
> +					ddr->
> +					mem_bw_limits_avg_bytes_per_us=val;
> +					continue;
> +				}
> +			}
> +			break;
>  		default:
>  			break;
>  		}
> @@ -454,6 +625,41 @@ struct cftype files[] = {
>  		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_PEAK,
>  						DRMCGRP_FTYPE_STATS),
>  	},
> +	{
> +		.name = "burst_bw_period_in_us",
> +		.write = drmcgrp_bo_limit_write,
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
> +						DRMCGRP_FTYPE_LIMIT),
> +	},
> +	{
> +		.name = "burst_bw_period_in_us.default",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH_PERIOD_BURST,
> +						DRMCGRP_FTYPE_DEFAULT),
> +	},
> +	{
> +		.name = "bandwidth.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
> +						DRMCGRP_FTYPE_STATS),
> +	},
> +	{
> +		.name = "bandwidth.high",
> +		.write = drmcgrp_bo_limit_write,
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
> +						DRMCGRP_FTYPE_LIMIT),
> +	},
> +	{
> +		.name = "bandwidth.default",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BANDWIDTH,
> +						DRMCGRP_FTYPE_DEFAULT),
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -476,6 +682,10 @@ int drmcgrp_register_device(struct drm_device *dev)
>  	ddev->dev = dev;
>  	ddev->bo_limits_total_allocated_default = S64_MAX;
>  	ddev->bo_limits_peak_allocated_default = SIZE_MAX;
> +	ddev->mem_bw_limits_period_in_us_default = 200000;
> +	ddev->mem_bw_limits_period_in_us = 200000;
> +	ddev->mem_bw_bytes_in_period_default = S64_MAX;
> +	ddev->mem_bw_avg_bytes_per_us_default = 65536;
>  
>  	mutex_init(&ddev->mutex);
>  
> @@ -652,6 +862,27 @@ void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
>  }
>  EXPORT_SYMBOL(drmcgrp_unchg_mem);
>  
> +static inline void drmcgrp_mem_bw_accum(s64 time_us,
> +		struct drmcgrp_device_resource *ddr)
> +{
> +	s64 increment_us = time_us - ddr->mem_bw_stats_last_update_us;
> +	s64 new_credit = ddr->mem_bw_limits_avg_bytes_per_us * increment_us;
> +
> +	ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US]
> +		+= increment_us;
> +	ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_ACCUM_US]
> +		+= increment_us;
> +
> +	if ((S64_MAX - new_credit) >
> +			ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT])
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
> +			+= new_credit;
> +	else
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT] = S64_MAX;
> +
> +	ddr->mem_bw_stats_last_update_us = time_us;
> +}
> +
>  void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  		struct ttm_mem_reg *new_mem)
>  {
> @@ -661,6 +892,7 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  	int devIdx = dev->primary->index;
>  	int old_mem_type = old_bo->mem.mem_type;
>  	int new_mem_type = new_mem->mem_type;
> +	s64 time_us;
>  	struct drmcgrp_device_resource *ddr;
>  	struct drmcgrp_device *known_dev;
>  
> @@ -672,6 +904,14 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
>  	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
>  
> +	if (root_drmcgrp->dev_resources[devIdx] != NULL &&
> +			root_drmcgrp->dev_resources[devIdx]->
> +			mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] >=
> +			known_dev->mem_bw_limits_period_in_us)
> +		drmcgrp_mem_burst_bw_stats_reset(dev);
> +
> +	time_us = ktime_to_us(ktime_get());
> +
>  	mutex_lock(&known_dev->mutex);
>  	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
>  		ddr = drmcgrp->dev_resources[devIdx];
> @@ -684,7 +924,70 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  
>  		if (evict)
>  			ddr->mem_stats_evict++;
> +
> +		drmcgrp_mem_bw_accum(time_us, ddr);
> +
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]
> +			+= move_in_bytes;
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_TOTAL_BYTE_MOVED]
> +			+= move_in_bytes;
> +
> +		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
> +			-= move_in_bytes;
>  	}
>  	mutex_unlock(&known_dev->mutex);
>  }
>  EXPORT_SYMBOL(drmcgrp_mem_track_move);
> +
> +unsigned int drmcgrp_get_mem_bw_period_in_us(struct ttm_buffer_object *tbo)
> +{
> +	int devIdx;
> +
> +	//TODO replace with BUG_ON

Nah, WARN_ON, BUG_ON considered evil in code where it's avoidable.

> +	if (tbo->bdev->ddev == NULL)
> +		return 0;
> +
> +	devIdx = tbo->bdev->ddev->primary->index;
> +
> +	return (unsigned int) known_drmcgrp_devs[devIdx]->
> +		mem_bw_limits_period_in_us;
> +}
> +EXPORT_SYMBOL(drmcgrp_get_mem_bw_period_in_us);
> +
> +bool drmcgrp_mem_can_move(struct ttm_buffer_object *tbo)
> +{
> +	struct drm_device *dev = tbo->bdev->ddev;
> +	struct drmcgrp *drmcgrp = tbo->drmcgrp;
> +	int devIdx = dev->primary->index;
> +	s64 time_us;
> +	struct drmcgrp_device_resource *ddr;
> +	bool result = true;
> +
> +	if (root_drmcgrp->dev_resources[devIdx] != NULL &&
> +			root_drmcgrp->dev_resources[devIdx]->
> +			mem_bw_stats[DRMCGRP_MEM_BW_ATTR_ACCUM_US] >=
> +			known_drmcgrp_devs[devIdx]->
> +			mem_bw_limits_period_in_us)
> +		drmcgrp_mem_burst_bw_stats_reset(dev);
> +
> +	time_us = ktime_to_us(ktime_get());
> +
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		ddr = drmcgrp->dev_resources[devIdx];
> +
> +		drmcgrp_mem_bw_accum(time_us, ddr);
> +
> +		if (result &&
> +			(ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_MOVED]
> +			 >= ddr->mem_bw_limits_bytes_in_period ||
> +			ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
> +			 <= 0)) {
> +			result = false;
> +		}
> +	}
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(drmcgrp_mem_can_move);
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
