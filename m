Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A78A6331
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfICH5Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 03:57:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICH5Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 03:57:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id c19so3736927edy.10
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XyH9fjGaETvp4a3MJs0cBMtWSSEc5LYuPiBn8RJcvKU=;
        b=MKH3mPNBi4p3Uq9gbHUx4XyYw1CGEZnMhDkzLRZx7lVA3RSgEIs68kuEb358zPx+CQ
         ehE050R/2OoMuNL2MSTulCU8vJDKUdr0vXsQmz6XLvXuwMopbaCECeOKp4sPNkyCJNAO
         r2X6vA+MwdTWkEnRVipH+zZhY3xhpW6rRxl4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XyH9fjGaETvp4a3MJs0cBMtWSSEc5LYuPiBn8RJcvKU=;
        b=HKCWrpSAiQ7UiWegJZSTH6/BcF1THiPz+TjVzdwxQZf15a42RPlL3sWGhJg70+DK4n
         sjvTHMJH2tmjJ764dkDTNG3VfoJw2cjx/1o41qQrrXQp6bw0eV9I9Z8hA50QuoKAJnSV
         YkxYjEOjlT0A2YXnFi/qfGwJEc7DLXL+36O/ipcloagoidy9pxQxytvWMCdYUQr9YKYx
         8Gvs+iV/b4KelUbD+Uw6b2UUI1lan604vR6Ec7gBpREyNTFzYx+IZJaB6Q8PNQGSqhjh
         r97LIKP4GtkH986ewY2c6GaU080e/6ut6D4tYr9H10pcFqVP7gn5046yhVl5m2FqDHMM
         rUkQ==
X-Gm-Message-State: APjAAAWc/ijNKG3A5a3LcKdYaKws3mi0xTnTmP3T2dwtmCP5H5grg9Nm
        gRgd0jLqKCdE22pc+Tigxlj/eQ==
X-Google-Smtp-Source: APXvYqz26Mae/q+g7jCEzVh2CCvBUR7e61Oli7pH4i+m6sIXlm6BLaKU1KIonUizirO+JYsng7b1wg==
X-Received: by 2002:a05:6402:148c:: with SMTP id e12mr7741960edv.62.1567497442431;
        Tue, 03 Sep 2019 00:57:22 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b17sm875141edn.33.2019.09.03.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:57:21 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:57:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com, daniel@ffwll.ch
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
Message-ID: <20190903075719.GK2112@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-2-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829060533.32315-2-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 29, 2019 at 02:05:18AM -0400, Kenny Ho wrote:
> To allow other subsystems to iterate through all stored DRM minors and
> act upon them.
> 
> Also exposes drm_minor_acquire and drm_minor_release for other subsystem
> to handle drm_minor.  DRM cgroup controller is the initial consumer of
> this new features.
> 
> Change-Id: I7c4b67ce6b31f06d1037b03435386ff5b8144ca5
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

Iterating over minors for cgroups sounds very, very wrong. Why do we care
whether a buffer was allocated through kms dumb vs render nodes?

I'd expect all the cgroup stuff to only work on drm_device, if it does
care about devices.

(I didn't look through the patch series to find out where exactly you're
using this, so maybe I'm off the rails here).
-Daniel

> ---
>  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
>  drivers/gpu/drm/drm_internal.h |  4 ----
>  include/drm/drm_drv.h          |  4 ++++
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 862621494a93..000cddabd970 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
>  
>  	return minor;
>  }
> +EXPORT_SYMBOL(drm_minor_acquire);
>  
>  void drm_minor_release(struct drm_minor *minor)
>  {
>  	drm_dev_put(minor->dev);
>  }
> +EXPORT_SYMBOL(drm_minor_release);
>  
>  /**
>   * DOC: driver instance overview
> @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
>  }
>  EXPORT_SYMBOL(drm_dev_set_unique);
>  
> +/**
> + * drm_minor_for_each - Iterate through all stored DRM minors
> + * @fn: Function to be called for each pointer.
> + * @data: Data passed to callback function.
> + *
> + * The callback function will be called for each @drm_minor entry, passing
> + * the minor, the entry and @data.
> + *
> + * If @fn returns anything other than %0, the iteration stops and that
> + * value is returned from this function.
> + */
> +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> +{
> +	return idr_for_each(&drm_minors_idr, fn, data);
> +}
> +EXPORT_SYMBOL(drm_minor_for_each);
> +
>  /*
>   * DRM Core
>   * The DRM core module initializes all global DRM objects and makes them
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index e19ac7ca602d..6bfad76f8e78 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
>  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
>  					struct dma_buf *dma_buf);
>  
> -/* drm_drv.c */
> -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> -void drm_minor_release(struct drm_minor *minor);
> -
>  /* drm_vblank.c */
>  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
>  void drm_vblank_cleanup(struct drm_device *dev);
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 68ca736c548d..24f8d054c570 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
>  
>  int drm_dev_set_unique(struct drm_device *dev, const char *name);
>  
> +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> +
> +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> +void drm_minor_release(struct drm_minor *minor);
>  
>  #endif
> -- 
> 2.22.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
