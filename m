Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9419D41
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEJM3e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 08:29:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35562 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJM3e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 08:29:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so3349852wmj.0
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yOmfaZDryvShxOtHKjMJKj95UivcRPfaVojEmSu/26A=;
        b=XX1Qe9xLxmRzWMs+gM8Z3OzJUW6533qdU7KyOGjOO59uVAjoP22nZeT74wMTIxmEjL
         bBQqFceHazBDWjLjlceoGJ4UaRzWeLB6Sh+wXM0Pm7VsvvWPWikSFu05Pbhq1f8DmNoR
         Y9ZOuDB61jYyLbliSsk5yVS2lJvrGe/v2N+Qbh+QmmouUJCmDPkTDenRhQSnVWcZZxKp
         D+Q+7JrU2pirBR/Iw2+DPQdxu32ckw5QK5RGzmu3/Sf/EltuLq1aWcwptH7kqUhNqxJW
         2R1Pk+tFrWsiJg8MZ/pgy13vhmgqHePZR7lGAJ9VPIQTdQFY5i+GP6WOUbKwQJAKw79s
         E+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yOmfaZDryvShxOtHKjMJKj95UivcRPfaVojEmSu/26A=;
        b=F/AJ8MLG98ELqL1P/Aq7vgSzbhMq/99haaqBQwndhNCwsuqtkwprP2nVU/T4gAVMFK
         trmxRwOf4jIxY2v49ccM//vHTcoJ8YRckDaVgMgtiekT206dvq8U7GzyTZ4C4T6cKX3O
         iNQ2cfs+L3qzhKfOnZdwIIYbMZhz33EmdDiEG/2b+Lklxk1Lbv7u5qFOvtE/XRw4pqen
         83Tez0WNOBpRCAySARgL2glRhkVEd9D2chjLbAmMvWTgA9uWPl7+YLKFhX1o8E3f0n9a
         rtZLeRbLTyMmwLb6keklErKYmy+HHlCbKjQzmsEwL6aEHMz7q4wJILPf7hof6TnECGEb
         yCQA==
X-Gm-Message-State: APjAAAUESrB9s23/13ZTbpTNCzQsY8bXmC/BZVoeMuqtq+Lfqpm/CE7/
        w37KGXPpmPd93BJyp3aSW3c=
X-Google-Smtp-Source: APXvYqyxEtbRv3HqNx/5upYIgZ3OdagwpsTZAsDkRjHZc3C4exPNJlGgKuqk4nIYlBmfU0FrNp8AYA==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr7127140wmo.93.1557491371837;
        Fri, 10 May 2019 05:29:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id r64sm13028429wmr.0.2019.05.10.05.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:29:31 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH v2 5/5] drm, cgroup: Add peak GEM buffer allocation
 limit
To:     Kenny Ho <Kenny.Ho@amd.com>, y2kenny@gmail.com,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, tj@kernel.org,
        sunnanyong@huawei.com, alexander.deucher@amd.com,
        brian.welty@intel.com
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-6-Kenny.Ho@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e5fbca82-9cea-de6b-da78-630e7b1902f6@gmail.com>
Date:   Fri, 10 May 2019 14:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509210410.5471-6-Kenny.Ho@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 09.05.19 um 23:04 schrieb Kenny Ho:
> This new drmcgrp resource limits the largest GEM buffer that can be
> allocated in a cgroup.
>
> Change-Id: I0830d56775568e1cf215b56cc892d5e7945e9f25
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ---
>   include/linux/cgroup_drm.h |  2 ++
>   kernel/cgroup/drm.c        | 59 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
>
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index fe14ba7bb1cf..57c07a148975 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -16,8 +16,10 @@
>   struct drmcgrp_device_resource {
>   	/* for per device stats */
>   	s64			bo_stats_total_allocated;
> +	size_t			bo_stats_peak_allocated;
>   
>   	s64			bo_limits_total_allocated;
> +	size_t			bo_limits_peak_allocated;

Why s64 for the total limit and size_t for the peak allocation?

Christian.

>   };
>   
>   struct drmcgrp {
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index bc3abff09113..5c7e1b8059ce 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -17,6 +17,7 @@ struct drmcgrp_device {
>   	struct mutex		mutex;
>   
>   	s64			bo_limits_total_allocated_default;
> +	size_t			bo_limits_peak_allocated_default;
>   };
>   
>   #define DRMCG_CTF_PRIV_SIZE 3
> @@ -24,6 +25,7 @@ struct drmcgrp_device {
>   
>   enum drmcgrp_res_type {
>   	DRMCGRP_TYPE_BO_TOTAL,
> +	DRMCGRP_TYPE_BO_PEAK,
>   };
>   
>   enum drmcgrp_file_type {
> @@ -72,6 +74,9 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int i)
>   	if (known_drmcgrp_devs[i] != NULL) {
>   		ddr->bo_limits_total_allocated =
>   		  known_drmcgrp_devs[i]->bo_limits_total_allocated_default;
> +
> +		ddr->bo_limits_peak_allocated =
> +		  known_drmcgrp_devs[i]->bo_limits_peak_allocated_default;
>   	}
>   
>   	return 0;
> @@ -131,6 +136,9 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>   	case DRMCGRP_TYPE_BO_TOTAL:
>   		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
>   		break;
> +	case DRMCGRP_TYPE_BO_PEAK:
> +		seq_printf(sf, "%zu\n", ddr->bo_stats_peak_allocated);
> +		break;
>   	default:
>   		seq_puts(sf, "\n");
>   		break;
> @@ -149,6 +157,9 @@ static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
>   	case DRMCGRP_TYPE_BO_TOTAL:
>   		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
>   		break;
> +	case DRMCGRP_TYPE_BO_PEAK:
> +		seq_printf(sf, "%zu\n", ddr->bo_limits_peak_allocated);
> +		break;
>   	default:
>   		seq_puts(sf, "\n");
>   		break;
> @@ -167,6 +178,9 @@ static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
>   	case DRMCGRP_TYPE_BO_TOTAL:
>   		seq_printf(sf, "%lld\n", ddev->bo_limits_total_allocated_default);
>   		break;
> +	case DRMCGRP_TYPE_BO_PEAK:
> +		seq_printf(sf, "%zu\n", ddev->bo_limits_peak_allocated_default);
> +		break;
>   	default:
>   		seq_puts(sf, "\n");
>   		break;
> @@ -182,6 +196,11 @@ static inline void drmcgrp_print_help(int cardNum, struct seq_file *sf,
>   		"Total amount of buffer allocation in bytes for card%d\n",
>   		cardNum);
>   		break;
> +	case DRMCGRP_TYPE_BO_PEAK:
> +		seq_printf(sf,
> +		"Largest buffer allocation in bytes for card%d\n",
> +		cardNum);
> +		break;
>   	default:
>   		seq_puts(sf, "\n");
>   		break;
> @@ -254,6 +273,10 @@ ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
>                                   if (val < 0) continue;
>   				ddr->bo_limits_total_allocated = val;
>   				break;
> +			case DRMCGRP_TYPE_BO_PEAK:
> +                                if (val < 0) continue;
> +				ddr->bo_limits_peak_allocated = val;
> +				break;
>   			default:
>   				break;
>   			}
> @@ -300,6 +323,33 @@ struct cftype files[] = {
>   		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
>   			DRMCGRP_FTYPE_MAX,
>   	},
> +	{
> +		.name = "buffer.peak.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_STATS,
> +	},
> +	{
> +		.name = "buffer.peak.default",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_DEFAULT,
> +	},
> +	{
> +		.name = "buffer.peak.help",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_HELP,
> +	},
> +	{
> +		.name = "buffer.peak.max",
> +		.write = drmcgrp_bo_limit_write,
> +		.seq_show = drmcgrp_bo_show,
> +		.private = (DRMCGRP_TYPE_BO_PEAK << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_MAX,
> +	},
>   	{ }	/* terminate */
>   };
>   
> @@ -323,6 +373,7 @@ int drmcgrp_register_device(struct drm_device *dev)
>   
>   	ddev->dev = dev;
>   	ddev->bo_limits_total_allocated_default = S64_MAX;
> +	ddev->bo_limits_peak_allocated_default = SIZE_MAX;
>   
>   	mutex_init(&ddev->mutex);
>   
> @@ -393,6 +444,11 @@ bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
>   			result = false;
>   			break;
>   		}
> +
> +		if (d->bo_limits_peak_allocated < size) {
> +			result = false;
> +			break;
> +		}
>   	}
>   	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
>   
> @@ -414,6 +470,9 @@ void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
>   		ddr = drmcgrp->dev_resources[devIdx];
>   
>   		ddr->bo_stats_total_allocated += (s64)size;
> +
> +		if (ddr->bo_stats_peak_allocated < (size_t)size)
> +			ddr->bo_stats_peak_allocated = (size_t)size;
>   	}
>   	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
>   }

