Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD29852FC
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2019 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbfHGSb4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Aug 2019 14:31:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37590 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfHGSbz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Aug 2019 14:31:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so66581096qkl.4;
        Wed, 07 Aug 2019 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vz8o0/Fg9HbJyVE2ylEHY7Bd2jvJ9o7HmByhNCHje8=;
        b=S/hC9pFyYsK3bBGpkS+QRQZx9iC78MlaFPdHy5dgV03bOA1Dd/SJhJT31pXIM/Vdpr
         pTggs2ww4s5HKZ6Rl822jfjP1lfNILksJxMEIOa1T+LCO8oErZSfUgyFzQR31AWOeOSi
         spJB4tB+m3qzO4p/d+Wyh9B9np+ZwkmgbeoAG2uGbxmQRjowE3F4Kc9wJwRI1Y52Qx9n
         n5/nIcew9FwUxZ1EQwHSBCBD4d/V6vY5SsokAC80mHelGqNJlGBMJsesOifrtC+/Dpu6
         5atcb/gJevn9CWlil28jn8uHgxtBr+UG4Ps4fouBx792PF2Ko3Zbv5IQY43ZLeBdoo6F
         xdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vz8o0/Fg9HbJyVE2ylEHY7Bd2jvJ9o7HmByhNCHje8=;
        b=l4bo27zyFJVyEqBM0j9QX7Zj7xbjvW8kZWZSZDTecmAPP0j8ztliLv7ssmqCSOPW76
         0o8Uq3ZVVCJdaXU6pqXd/m6noMtl2yDxP+Dad1o2TLeFmL2CZD339UATVzshAdmW2qCq
         4n2aM5yodDxgk4oB3mZej3DZrhkAt0ICLvlJjUfdLQfRX+eOi1sk9ex8ip36jfTZEJ2V
         8GRsqlUgZ8pCXm0u8ny893lnDoVBVQpwrMgRFE0l88h8LUqIS0BTtMsgfnZ63JVi75OD
         /fF5ZuVTUIxNLZeOUb0p/duDJ/IBScB3jBpd7VbiAy2IiXqT7CIvFBJsL7fvdKbeJ9XO
         fS/A==
X-Gm-Message-State: APjAAAVn6rKrcMF1h3Cs3D4/ACg4W+Koo5qTeCU9NIGPPADnNB8t9K9g
        vMONz6FHAXZCXy+UycLbhjo=
X-Google-Smtp-Source: APXvYqw2S8tifKu8V/Krxm/Xjt4iJUYrR46IiTCnMxoNFDowG4ynyeA1cuZ35IBd4uwpAyDAkgHk7A==
X-Received: by 2002:a37:c247:: with SMTP id j7mr9721021qkm.94.1565202714521;
        Wed, 07 Aug 2019 11:31:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::6ac7])
        by smtp.gmail.com with ESMTPSA id k74sm44829295qke.53.2019.08.07.11.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:31:53 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:31:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190807183151.GM136335@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
 <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 06, 2019 at 04:01:02PM -0700, Andrew Morton wrote:
> On Sat,  3 Aug 2019 07:01:53 -0700 Tejun Heo <tj@kernel.org> wrote:
> > There currently is no way to universally identify and lookup a bdi
> > without holding a reference and pointer to it.  This patch adds an
> > non-recycling bdi->id and implements bdi_get_by_id() which looks up
> > bdis by their ids.  This will be used by memcg foreign inode flushing.
> 
> Why is the id non-recycling?  Presumably to address some
> lifetime/lookup issues, but what are they?

The ID by itself is used to point to the bdi from cgroup and idr
recycles really aggressively.  Combined with, for example, loop device
based containers, stale pointing can become pretty common.  We're
having similar issues with cgroup IDs.

> Why was the IDR code not used?

Because of the rapid recycling.  In the longer term, I think we want
IDR to be able to support non-recycling IDs, or at least less
agressive recycling.

> > +struct backing_dev_info *bdi_get_by_id(u64 id)
> > +{
> > +	struct backing_dev_info *bdi = NULL;
> > +	struct rb_node **p;
> > +
> > +	spin_lock_irq(&bdi_lock);
> 
> Why irq-safe?  Everywhere else uses spin_lock_bh(&bdi_lock).

By mistake, I'll change them to bh.

Thanks.

-- 
tejun
