Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101158EF97
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfHOPnI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 11:43:08 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39948 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfHOPnI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 11:43:08 -0400
Received: by mail-qk1-f181.google.com with SMTP id s145so2163573qke.7;
        Thu, 15 Aug 2019 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSR3T6Q49rCFXPPoyb9XFgF2ejksN7y0WyTo3YMYamM=;
        b=hyuuAh2CNIxYP3ggj8gDm8R4p/9az4kHrRaL6c7xkvVmp5KasB2iSYzUaAGIeZjGiM
         A95PrUyUJC+0/lW0z1W+odNW7+/4tOmRmm6g86Fh0uQd7iEZ7NQH9paD1ey8Ro+yUg4g
         y3VeNucMGXfPbFqNNe2fdHGkico4kMYi0IGp8QW1kdMhBhiJeExKMtbS0t6bdR0K3WmR
         I+szM8wY4iywtp965t3+afNr0ujT0/Y5OO7fs8HNBxXO9ilORnMG3/ZqeRVzaRoWWy1f
         y2cWJTQHxaLlPv/FNGs6kLzLnFQz0yqnp8YocfIMbukfVsK2R/XaBg8GPyF6ZzZ2cszC
         /M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSR3T6Q49rCFXPPoyb9XFgF2ejksN7y0WyTo3YMYamM=;
        b=EjloV0XjoAmOIvLGFfVPg1P84FlQFPrH/tvWIYhxhVvGEYmB/HVLIBRHcp4OVKqvwl
         BLRUocCrWnBKA/6mTqkfsQiuqJ5VKyvOfboQi2PeZ5KLDR67nAjw8QigSbKhZsFTpK3S
         4C9BBA/IU/KV7W+kP7OTt0OKmlB4xnIT48VWCz1vhEUPofFnDpq6aa59jN/tkKDqpilp
         E7GCVq3qwNjEH9TtvYIUJy7sc6LIb/gOTBw3Eq6wc7n7J0NCq+XWYuZ1ohDH6N+wQ0ZC
         BQVGroU/sPg3wgGLvsZkQv2eol2+HsSLWEZMh/zxQF/Y3yq6WJnnw1rJeIuvmfMX/5mF
         dT2Q==
X-Gm-Message-State: APjAAAW5KXfABT7cd3ki68psaNhwvzoGXwSg6oLSZ9gNl6SWQdeQRxJQ
        VRJZ2t+gDRKKsqh74HX2DTI=
X-Google-Smtp-Source: APXvYqxzLjuzQD27bfrn2cScIeA+V2HcpeVzSikxHaN5jBJPh/YwChCQxz2+g7+fHLFfxda2FIzOsw==
X-Received: by 2002:a37:270a:: with SMTP id n10mr4625997qkn.434.1565883786758;
        Thu, 15 Aug 2019 08:43:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id t2sm1529090qkm.34.2019.08.15.08.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 08:43:06 -0700 (PDT)
Date:   Thu, 15 Aug 2019 08:43:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/4] writeback, memcg: Implement cgroup_writeback_by_id()
Message-ID: <20190815154302.GB588936@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-4-tj@kernel.org>
 <20190815140535.GJ14313@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815140535.GJ14313@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 15, 2019 at 04:05:35PM +0200, Jan Kara wrote:
> > +int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
> > +			   enum wb_reason reason, struct wb_completion *done);
> > +int writeback_by_id(int id, unsigned long nr, enum wb_reason reason,
> > +		    struct wb_completion *done);
> 
> I guess this writeback_by_id() is stale? I didn't find it anywhere else...

Yes, removed.

Thanks.

-- 
tejun
