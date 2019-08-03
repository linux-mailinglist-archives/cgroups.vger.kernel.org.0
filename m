Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F101D80712
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfHCPxx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Aug 2019 11:53:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39692 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfHCPxw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Aug 2019 11:53:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so57147119qkc.6;
        Sat, 03 Aug 2019 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wr1/jf7OC4N1CyD2pZrJRAsqKQhTrW81tkA/dMeoZYU=;
        b=E4xysODT5QEs0YiJh/6lyT4EBx4B7Mz7IMg6xczGcQ0G9Qk2AtE4TXZ+GCBgFJDEi1
         lLnFymeOoSvdAYvHJIdCSSrgbeDE4a17sW8u6K0mHvhTIQr7wv8IU/Sst4zTTu0Ui9p9
         jfnV5m2JmluBR+fiHIHyCypa6MemIx71M5jmKx6vtYPIEIc/gtcjHdvjaf5qkicR216B
         vr2TNHeSv9J9+fUNK7YQ/gOyrhWAGf5rfXuyH6O/uIOIbbVZkbs1h8vugk98ksEkGk+E
         kSQOd/o+FqbgLWKvjIyIdPT1Sa9ivX+Vce/lqYQCUaRKFWaUnKiHZKnPlvGognn7X6L+
         Xw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wr1/jf7OC4N1CyD2pZrJRAsqKQhTrW81tkA/dMeoZYU=;
        b=oAJMdL6UK+ZddtmyZsbBLrWBufvasDrn6uavDuGaXa3KqooltNNmYgG7mQV1wOAd+d
         Om6SROdQquOIEHnj59eUzikbbKbdQwWvg7ZFg6rsaENPNlqBs0kTUTJJn1+VamfXaxUF
         w7MuS8SItSyXsSkctXqfHeEZAFEUQj3wU+z0jcXv9CSKUYa7QS64FXgf1x7XUNuNpMdf
         wIvJJApFBBpmF1jnpLThM2wYtvB0HQVd90DwJ5UKu8R8+5hRjRlsAtq2/nFRV0+TfH59
         dhBCZFiIKvB6EjFUYdKf9+2mif1MI+nVCEmxPv9OJUEqoQdI5PA9NYsoMLvRDGripmzO
         a8xg==
X-Gm-Message-State: APjAAAWINjFwzOL3mWwM3owRzVmqMTOK9/JO4oeICzuDuwPPctQL2lLX
        ZpWWFjjnAYsGA2aZKc5Iqt8=
X-Google-Smtp-Source: APXvYqxgFYSi0U8M7Pxq58YMG2KJi0fk/qfGLpdfgkpRW+ewtu0h1e0nP4F1pryg35uOv1I+y7chQA==
X-Received: by 2002:a37:6085:: with SMTP id u127mr96259447qkb.25.1564847631510;
        Sat, 03 Aug 2019 08:53:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7cfa])
        by smtp.gmail.com with ESMTPSA id r205sm38568262qke.115.2019.08.03.08.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 08:53:50 -0700 (PDT)
Date:   Sat, 3 Aug 2019 08:53:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190803155349.GD136335@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
 <20190803153908.GA932@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803153908.GA932@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey, Matthew.

On Sat, Aug 03, 2019 at 08:39:08AM -0700, Matthew Wilcox wrote:
> On Sat, Aug 03, 2019 at 07:01:53AM -0700, Tejun Heo wrote:
> > There currently is no way to universally identify and lookup a bdi
> > without holding a reference and pointer to it.  This patch adds an
> > non-recycling bdi->id and implements bdi_get_by_id() which looks up
> > bdis by their ids.  This will be used by memcg foreign inode flushing.
> > 
> > I left bdi_list alone for simplicity and because while rb_tree does
> > support rcu assignment it doesn't seem to guarantee lossless walk when
> > walk is racing aginst tree rebalance operations.
> 
> This would seem like the perfect use for an allocating xarray.  That
> does guarantee lossless walk under the RCU lock.  You could get rid of the
> bdi_list too.

It definitely came to mind but there's a bunch of downsides to
recycling IDs or using radix tree for non-compacting allocations.

Thanks.

-- 
tejun
