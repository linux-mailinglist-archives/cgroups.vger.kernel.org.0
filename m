Return-Path: <cgroups+bounces-5024-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464F098EEAB
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 14:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C194B1F21BCC
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B8156C69;
	Thu,  3 Oct 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RK1ltBCO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E23146A73
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956996; cv=none; b=fdNHmb2ccefhELfYR2+R/+XEE0M7zkYKVUqsBcIi/sbfYIu14wnBHVVAGlm43Rzbw63+IRYlkrLmPs/GEb2zWtCJiarP8k/HL5JSSvhiqQz8bqZc6fvhS8/HrZEngxH5CG18h/iKWOaHezQgwajMVz6mE/zs9K/tH5TwJJngxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956996; c=relaxed/simple;
	bh=S9nYYA+ft7bnmvLPV9Xq5fVP9Vx11DcFu5nTQcirfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XelHdio8XDFNjZvIMw+2myDPtsJrgu4Jaf4eoBBlYVezmEGb60wAaYONiis9ghNvXL57aRDrR+TwFBgML4aKwTwUoP2BIWr0yEoJBngkvRJH0RZ6Fc+g5o67khayAxyaO0VD7rXxLsvflIvXIIm/DdxzG7A5DTlCH0qndCytnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RK1ltBCO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so941376f8f.3
        for <cgroups@vger.kernel.org>; Thu, 03 Oct 2024 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727956993; x=1728561793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0v3FxexH6o+k9zGs10MnvBoywhJ9dhmJJLFKjWBKLg=;
        b=RK1ltBCOKpMasL75F9bp60IhGt1HlAKoGHIWabpeiJBbvBAcg7lmIl6llxCWao9+qi
         kBBmAGqWd4qwbZiQAw6Ez4UkqYZaN0vL4jDTr/gHx8SVzyVIzW6Eja2icEkrXko1szz7
         XAKaWjrZzd6WwuJu79bjrkLGquBmaFK1Qf6Z7rTSRUb0D0e4vlNwWITrQCofPwx4TY1j
         0yrpH8m+BNkm0UsL5X3+gHJu0xsHZb7AQtFomLgk5bp1GCofFoGGZI9p875zlBqf5tF+
         UHS+GFJVoTK1LIZ4WmowAyEG1G5ZJ5AmEUbQCxaon5cwGKLKYDDj/kVBMicjNCyJFye4
         VcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956993; x=1728561793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0v3FxexH6o+k9zGs10MnvBoywhJ9dhmJJLFKjWBKLg=;
        b=RbwaPvs1d/MiIAYrQrQYdNIYHByn/0NceVEJYj7NHQboylvLymPu1NKHDmMpx5vsjp
         Cl7El50NAPcR7PYXUt46Abs8s5/VjoHuSH5HL3nAD+OCRoz6hlcKkp+h8tDi7aJOFuAX
         T1EbSbxYqsF5DlD0Bl7SMuOF5UWlwjkyYBMMtxrLD39ojHe011O8tL7G2ZxRg7c7DESi
         sDWlX7NXHJtvqYbKeEYUgmOwo6jut/CwH7mk0Xv8ZgazRs9Ou1nrr4ut2Dc1ekwMELBL
         jWwv0vGf5nFbF+EyqRy7L0VkrcRxGdxr2o8Gbybw7DIiHpZiDJGyFwHzvqk7CToSwKq+
         JnoA==
X-Forwarded-Encrypted: i=1; AJvYcCXDkpm7Ov0SkXQGyfAtGoiK54Ne35Yv5+NOogpsEBMUqERaPGQfUZU6SgNbHNUfeCzg5VnlsgSv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yp6Mlc5QJwTfyGmrKzEd+SUJmpYqS2pjFvx+GOurCAXQz3PQ
	VQokktw5XlxdA0dx/SykDeIxndBZDdASO7ku594D4pwMIcq892lb+b/hmrHYdxA=
X-Google-Smtp-Source: AGHT+IFdfQ8pVihlgtJc1iFCJTfVxzLCRaEka3dk4gA6mpMaHt4xXmFAwc1bV33dk9fxjbTpGaNSTw==
X-Received: by 2002:a5d:47c4:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37cfb8b5503mr6603502f8f.1.1727956992907;
        Thu, 03 Oct 2024 05:03:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7727f72fsm50006655e9.1.2024.10.03.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:03:12 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:03:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waiman Long <longman@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>

On Wed, Oct 02, 2024 at 02:40:52PM -0400, Waiman Long wrote:
> 
> On 10/2/24 14:10, Dan Carpenter wrote:
> > On Wed, Oct 02, 2024 at 01:49:48PM -0400, Waiman Long wrote:
> > > > -	spin_unlock_irq(&ioc->lock);
> > > > +	spin_unlock(&ioc->lock);
> > > >    	return 0;
> > > >    }
> > > I would suggest adding a "lockdep_assert_irqs_disabled()" call before
> > > spin_lock() to confirm that irq is indeed disabled just in case the callers
> > > are changed in the future.
> > It's really hard to predict future bugs.  I doubt we'll add new callers.
> > Outputting this information to a struct seq_file *sf is pretty specific.
> > 
> > If there were a bug related to this, then wouldn't it be caught by lockdep?
> > 
> > The other idea is that we could catch bugs like this using static analysis.
> > Like every time we take the &ioc->lock, either IRQs should already be disabled
> > or we disable it ourselves.  I could write a Smatch check like this.
> > 
> > KTODO: add Smatch check to ensure IRQs are disabled for &ioc->lock
> 
> This is just a suggestion and it is fine if you don't think it is necessary.
> The call can also serve as a comment that irq should have been disabled at
> this point.

I mean it's good to think about preventing future bugs.  I just feel like when
it comes to adding asserts probably that's more useful when there are a lot of
call paths.  Meanwhile if we add a static checker rule then we're probably going
to find bugs.  Boom, maybe I've found one already?:

block/blk-iocost.c:3144 ioc_weight_write() warn: expected irq_disable for '&iocg->ioc->lock'

block/blk-iocost.c
  3090  static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
  3091                                  size_t nbytes, loff_t off)
  3092  {
  3093          struct blkcg *blkcg = css_to_blkcg(of_css(of));
  3094          struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
  3095          struct blkg_conf_ctx ctx;
  3096          struct ioc_now now;
  3097          struct ioc_gq *iocg;
  3098          u32 v;
  3099          int ret;
  3100  
  3101          if (!strchr(buf, ':')) {
  3102                  struct blkcg_gq *blkg;
  3103  
  3104                  if (!sscanf(buf, "default %u", &v) && !sscanf(buf, "%u", &v))
  3105                          return -EINVAL;
  3106  
  3107                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
  3108                          return -EINVAL;
  3109  
  3110                  spin_lock_irq(&blkcg->lock);

Here we disable IRQs.

  3111                  iocc->dfl_weight = v * WEIGHT_ONE;
  3112                  hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
  3113                          struct ioc_gq *iocg = blkg_to_iocg(blkg);
  3114  
  3115                          if (iocg) {
  3116                                  spin_lock(&iocg->ioc->lock);

So this is fine.

  3117                                  ioc_now(iocg->ioc, &now);
  3118                                  weight_updated(iocg, &now);
  3119                                  spin_unlock(&iocg->ioc->lock);
  3120                          }
  3121                  }
  3122                  spin_unlock_irq(&blkcg->lock);
  3123  
  3124                  return nbytes;
  3125          }
  3126  
  3127          blkg_conf_init(&ctx, buf);
  3128  
  3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
  3130          if (ret)
  3131                  goto err;
  3132  
  3133          iocg = blkg_to_iocg(ctx.blkg);
  3134  
  3135          if (!strncmp(ctx.body, "default", 7)) {
  3136                  v = 0;
  3137          } else {
  3138                  if (!sscanf(ctx.body, "%u", &v))
  3139                          goto einval;
  3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
  3141                          goto einval;
  3142          }
  3143  
  3144          spin_lock(&iocg->ioc->lock);

But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
fine.

  3145          iocg->cfg_weight = v * WEIGHT_ONE;
  3146          ioc_now(iocg->ioc, &now);
  3147          weight_updated(iocg, &now);
  3148          spin_unlock(&iocg->ioc->lock);
  3149  
  3150          blkg_conf_exit(&ctx);
  3151          return nbytes;
  3152  
  3153  einval:
  3154          ret = -EINVAL;
  3155  err:
  3156          blkg_conf_exit(&ctx);
  3157          return ret;
  3158  }

regards,
dan carpenter

