Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACC3B5FC8
	for <lists+cgroups@lfdr.de>; Mon, 28 Jun 2021 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhF1OTt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Jun 2021 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhF1OTt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Jun 2021 10:19:49 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB64C061574;
        Mon, 28 Jun 2021 07:17:22 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r7so13619061qta.12;
        Mon, 28 Jun 2021 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vAguyIyi4MmUNdlCWw+ELLDz19W9ZtG5NXhufd99HQU=;
        b=ou9qWijqI8+uRu9wJxljIWLESJnGibgJlZ1RbImShcDy9ys4gRS9l4WX13763vB6o1
         JYtM7iFmX6tYN1xnyCqvBwoh3DV1nEe9s8ExkS7XaCO+6bnVGIJk2/0zmzghc7V7BIPy
         52vif2t67eC4ft8m9AqigMctzHoCFjQmhqbj3vQSF4zC2GHEu5KT6up2sHp5z6YDQN0y
         eHhJWR0+P8S9SC9MqmnfSvuCOto5l6Y0RRxPdsx8B4xvemH3LvFiAzHk3i4G0pmhIAja
         jG3ZKv0SZKOXE5TxMKShSOdKq9czRuZ9nniTCuv85w8uglqMShEaWC/85HkJdvP/TFmx
         xw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vAguyIyi4MmUNdlCWw+ELLDz19W9ZtG5NXhufd99HQU=;
        b=jKG4n0BfSnqviM5np3y1O4ivRElqJEUjywUG+pXw95P0n3e+4fauxwN5bbyCflkI57
         rvx6ic4ejqZgBGeQksqaG7mREm67ufaznJbHetVAQvDOFEMnbM5kctWzUnkzQZmRs45y
         gjNsTHVJ/z+t+ioa03t0uaMOXRmXSeHX3dCzeYrJRcNedOJ1bXVd3h99KcEP6Q82nJzM
         X82lLhbEh1EDvI5+MpJs3P7pHEuwq2TlVHPRqZ+JzvWIUdGiL2MjjhEnNep5RaJVfZQ1
         +Rj8N7y1B2rrp7B0Q+0AJFgIvJ+i+Cx6MCu3pU0CTuoRvwEBX9V5pYqdUwmci/+Niknu
         sQNw==
X-Gm-Message-State: AOAM533//+PB0xqEKLHpMnC8OtCT6uFihNJp0Uorrg6mGQhyX4JLus12
        2nMwvkociE7P42+eeRoInXEyWW8Dprk=
X-Google-Smtp-Source: ABdhPJyNwBsHos6I7IJOPlG9XtcqNTMTXUx/rehkBcgB+xJcMBgfooSu+WsH+JQVJryhhPEEKH8pGQ==
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr19216337qtd.73.1624889841494;
        Mon, 28 Jun 2021 07:17:21 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:85ab])
        by smtp.gmail.com with ESMTPSA id y7sm10651104qkp.103.2021.06.28.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:17:20 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:17:18 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
 <YNXvr81YFzbaTxCb@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNXvr81YFzbaTxCb@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Fri, Jun 25, 2021 at 05:01:03PM +0200, Michal Koutný wrote:
> Hi.
> 
> On Thu, Jun 10, 2021 at 10:39:44AM -0700, Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > The current code only associates with the existing blkcg when aio is
> > used to access the backing file. This patch covers all types of i/o to
> > the backing file and also associates the memcg so if the backing file is
> > on tmpfs, memory is charged appropriately.
> > 
> > This patch also exports cgroup_get_e_css and int_active_memcg so it
> > can be used by the loop module.
> 
> Wouldn't it be clearer to export (not explicitly inlined anymore)
> set_active_memcg() instead of the int_active_memcg that's rather an
> implementation detail?

Agreed that exporting int_active_memcg is an implementation detail,
but would this prevent set_active_memcg from being inlined? Is that
desireable?

> 
> > @@ -2111,13 +2112,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	}
> >  
> >  	/* always use the first bio's css */
> > +	cmd->blkcg_css = NULL;
> > +	cmd->memcg_css = NULL;
> >  #ifdef CONFIG_BLK_CGROUP
> > -	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
> > -		cmd->css = &bio_blkcg(rq->bio)->css;
> > -		css_get(cmd->css);
> > -	} else
> > +	if (rq->bio && rq->bio->bi_blkg) {
> > +		cmd->blkcg_css = &bio_blkcg(rq->bio)->css;
> > +#ifdef CONFIG_MEMCG
> > +		cmd->memcg_css =
> > +			cgroup_get_e_css(cmd->blkcg_css->cgroup,
> > +					&memory_cgrp_subsys);
> > +#endif
> > +	}
> >  #endif
> > -		cmd->css = NULL;
> >  	loop_queue_work(lo, cmd);
> 
> I see you dropped the cmd->blkcg_css reference (while rq is handled). Is
> it intentional?

Yes it is intentional. All requests (not just aio) go through the loop
worker which grabs the blkcg reference in loop_queue_work() on
construction. So I believe grabbing a reference per request is
unnecessary.
