Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8256E87
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZQQS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:16:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39652 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQQS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 12:16:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so4102688edv.6
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lF6v0IWJ/meV6jMdQrTEV8UKmUJTABenSJ/qMYoG38U=;
        b=Gts3vRBWisopLQjynefMBig4B3OAbdINOM9VFgw3mm1kkZBwjhAcPz673NP0shl2Fr
         9PumjMR1KOdECTssPoixU8CQu+/2N50HNjAIaPFA9382AcMfJjAT66lNwE1ON1hJhjwA
         kx6Ax1OlbVdlnJ6cBNThKfr2YIIOLE3NtQhys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lF6v0IWJ/meV6jMdQrTEV8UKmUJTABenSJ/qMYoG38U=;
        b=HoRN2z0zxFXrMe6GnBP21uWj0pPM86Cw9Z4LqRh28E/N+bJ9UU5Ddy/9ZBKPYDc6YJ
         Eryi2Y4AnIpOouNtdejmAvLCvrpfc4b11bEyqQeAii/2OFireYcB4sDeormkPBSfHfy+
         ogpozE1lVwi0bWVAF5A2y21RZ8BDSG8PEbWSiaPz8AqefJhpFAWXPuWzvFKIObeHuR6X
         9PMBNX/EQrw1bYPnYKqeKzdML+t6YZaSZKYMQmgSaBsi4BLwuT3Ybw9LgrzvMi2uY4yB
         uVSL0UwKYYp8VzhK1vLGlSKA3SvZ9UrD0lV4fEGEr9or2wmi127d+iFMqyvthCpbgm7l
         mZUA==
X-Gm-Message-State: APjAAAWyJqsUKErqwW2R0g4s3AQGG90qiNJhVeHusooO4gb0hSp8MKgm
        SgcXh6RR6wWkBvtxFBle9lAHZA==
X-Google-Smtp-Source: APXvYqyePUpHxh/ltcY4LJZQK+1XHArMzcRsG8OJv07lLh+s2834/Tlhgyx+rSibQ8RA9ZDXeh+s9g==
X-Received: by 2002:a50:8828:: with SMTP id b37mr6452459edb.266.1561565775508;
        Wed, 26 Jun 2019 09:16:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c16sm5988825edc.58.2019.06.26.09.16.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:16:14 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:16:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 08/11] drm, cgroup: Add TTM buffer peak usage stats
Message-ID: <20190626161612.GT12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-9-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-9-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:19AM -0400, Kenny Ho wrote:
> drm.memory.peak.stats
>         A read-only nested-keyed file which exists on all cgroups.
>         Each entry is keyed by the drm device's major:minor.  The
>         following nested keys are defined.
> 
>           ======         ==============================================
>           system         Peak host memory used
>           tt             Peak host memory used by the device (GTT/GART)
>           vram           Peak Video RAM used by the drm device
>           priv           Other drm device specific memory peak usage
>           ======         ==============================================
> 
>         Reading returns the following::
> 
>         226:0 system=0 tt=0 vram=0 priv=0
>         226:1 system=0 tt=9035776 vram=17768448 priv=16809984
>         226:2 system=0 tt=9035776 vram=17768448 priv=16809984
> 
> Change-Id: I986e44533848f66411465bdd52105e78105a709a
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

Same concerns as with the previous patch, a bit too much ttm in here.
Otherwise looks like useful information, and wont need driver changes
anywhere.
-Daniel

> ---
>  include/linux/cgroup_drm.h |  1 +
>  kernel/cgroup/drm.c        | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index 141bea06f74c..922529641df5 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -25,6 +25,7 @@ struct drmcgrp_device_resource {
>  	s64			bo_stats_count_allocated;
>  
>  	s64			mem_stats[TTM_PL_PRIV+1];
> +	s64			mem_peaks[TTM_PL_PRIV+1];
>  	s64			mem_stats_evict;
>  };
>  
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 5aee42a628c1..5f5fa6a2b068 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -38,6 +38,7 @@ enum drmcgrp_res_type {
>  	DRMCGRP_TYPE_BO_COUNT,
>  	DRMCGRP_TYPE_MEM,
>  	DRMCGRP_TYPE_MEM_EVICT,
> +	DRMCGRP_TYPE_MEM_PEAK,
>  };
>  
>  enum drmcgrp_file_type {
> @@ -171,6 +172,13 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  	case DRMCGRP_TYPE_MEM_EVICT:
>  		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
>  		break;
> +	case DRMCGRP_TYPE_MEM_PEAK:
> +		for (i = 0; i <= TTM_PL_PRIV; i++) {
> +			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
> +					ddr->mem_peaks[i]);
> +		}
> +		seq_puts(sf, "\n");
> +		break;
>  	default:
>  		seq_puts(sf, "\n");
>  		break;
> @@ -440,6 +448,12 @@ struct cftype files[] = {
>  		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_EVICT,
>  						DRMCGRP_FTYPE_STATS),
>  	},
> +	{
> +		.name = "memory.peaks.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_PEAK,
> +						DRMCGRP_FTYPE_STATS),
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -608,6 +622,8 @@ void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
>  	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
>  		ddr = drmcgrp->dev_resources[devIdx];
>  		ddr->mem_stats[mem_type] += size;
> +		ddr->mem_peaks[mem_type] = max(ddr->mem_peaks[mem_type],
> +				ddr->mem_stats[mem_type]);
>  	}
>  	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
>  }
> @@ -662,6 +678,10 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  		ddr->mem_stats[old_mem_type] -= move_in_bytes;
>  		ddr->mem_stats[new_mem_type] += move_in_bytes;
>  
> +		ddr->mem_peaks[new_mem_type] = max(
> +				ddr->mem_peaks[new_mem_type],
> +				ddr->mem_stats[new_mem_type]);
> +
>  		if (evict)
>  			ddr->mem_stats_evict++;
>  	}
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
