Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087B6CF2D9
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjC2TQW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjC2TQW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 15:16:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E241FC8;
        Wed, 29 Mar 2023 12:16:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r7-20020a17090b050700b002404be7920aso15584499pjz.5;
        Wed, 29 Mar 2023 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680117381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2qh7XjFgypAL2kgZ/c2uWUMXWM5l/TX2xEZm0UsPCQ=;
        b=PcfWqe2OVHMzdKmVVolkt0xO/9xOIN5oG2Aa+RSisB/oeLmGNhZLLHQE/Wb7ysSRhR
         y3ZlqH6B9dg6vwwtugRcsZew8lhi8F+BsxM6CcXAyKBf0xagM/NfJ32XaHx84DRlGwnC
         vCq+66s1Pvf3QsCu9ST3TcNfx2EykErfC/N/QxJgZQNVTCyoEHZMC6uHMhy6SAPTDO3N
         MloXRtpwimLR4K8A72rz5peMu8rcArfukBvaSj4O1f9zAf/SY81Ne+T3VtgFg9Lps3xz
         11jVxauVOaLa1HMJ/keFmmqpliwQTNfYs8JBR4QnRmAZUEALbVI9VuqEPiv1KsZgECUd
         /+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2qh7XjFgypAL2kgZ/c2uWUMXWM5l/TX2xEZm0UsPCQ=;
        b=bRvDTH8uU5GtyGF7rpUpWW04hslXTXTSqiZ9lSu0HkeDb9mcUgs9ZRfa7J9l2al53L
         XdKujTIaC7zoNOqOzNbTUbzk6l/jBR4+Qj68mxFA8WlVTOObdZW7UM5CUS/VSF+584O+
         sOfrUczzukZfsCEkCTa/pgkDGBbiYwFwRLcHHtSQHS+uZNbKzizJbKAleD6wKs4Z2B8h
         rTUL9knCseKbdP9FzihDiZNKZQqVzsjr/yDXaF9ImdkcDgjxMGYbaD1cG7t7tM3sbZn1
         2FhZNaw9cwOavnh4DLhd4Sioa23+YvOWkNtY828eES0RRrCzJjF2GljGiikaxVt7NTRt
         Svxg==
X-Gm-Message-State: AAQBX9fnX/FE9vQ42jX5IG7WN6YIBV+tElN4Kces9rxYSXqfjThmn00w
        EVhVsgO8su9IjIi7VWy4sJ+FZdVPltU=
X-Google-Smtp-Source: AKy350Z6OU07Xn7NkqHwVYohL+McpGWe3dgaUhmpHmk4uxkfiaPRxYsZJ44ajBxhmBvZAXjO47D6hQ==
X-Received: by 2002:a17:90b:1c88:b0:233:f354:e7df with SMTP id oo8-20020a17090b1c8800b00233f354e7dfmr23159082pjb.18.1680117380447;
        Wed, 29 Mar 2023 12:16:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a828100b00233aacab89esm1742325pjn.48.2023.03.29.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:16:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 09:16:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: move bio cgroup punting into btrfs
Message-ID: <ZCSOgoe84BhiUZcn@slm.duckdns.org>
References: <20230327004954.728797-1-hch@lst.de>
 <512eaacf-3ff6-f4f9-c856-a0e03c027501@meta.com>
 <20230328233448.GA5486@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328233448.GA5486@lst.de>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Christoph.

I'm semi-offline for a few weeks, so please pardon the tardiness and
brevity.

On Wed, Mar 29, 2023 at 01:34:48AM +0200, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 05:18:43PM -0400, Chris Mason wrote:
> btrfs is the only place offloading writes from the per-cgroup writeback
> to it's own not cgroup aware workqueues.
>
> Offloading from one writeback thread to another threadpool to just
> offload back to another thread to not deadlock is obviously not
> an actual smart thing to do, and fortunately no one else is doing
> this.

We didn't really look deep into adding the support but Chris mentioned that
raid5/6 are likely to need something similar. Maybe this is because my grasp
of filesytsems is pretty weak but the pattern doesn't seem unreasonable to
me. There's some work to be done by a shread kthread and that sometimes can
fork out IOs which belong to specific cgroups.

> For btrfs it is on it's way out by not doing the offload just for
> checksumming in a little bit, and even for compression the right fix
> is just to allow more than one thread per device and cgroup.  I plan
> to look into that, but there's plenty higher priority work right now.

At least in the IO control and direct issue path, punting to just one thread
hasn't been a practical problem given that when the issuing thread needs to
be blocked, either the whole device or the cgroup needs to be throttled
anyway. Are you thinking about scenarios where substantial CPU cycles are
consumed for IOs (e.g. dm-crypt)?

Thanks.

-- 
tejun
