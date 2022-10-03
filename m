Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEC5F33BD
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJCQk2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJCQkJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 12:40:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C41ADB7;
        Mon,  3 Oct 2022 09:40:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 2so4552552pgl.7;
        Mon, 03 Oct 2022 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=9ee4zy4RkBCLXpL+JKk/4ZofQQA2htMYqURBy7ZeYvU=;
        b=CKJPy4Uewqo/YSJOPAe2d6CxIu2KBmc6h/tP9XP4IK7T5VK9xEh3MEwWAZe9xY66SH
         ySIs9v3huPVH3j7wos9zJYCwAcdngQ2AbsH+huitf4dGtkbrcPJL9dPYHCtwzChkLvCM
         vDw2vWysO3XbuzerYOv+YsWnpiuJaAJE3HyD2/Sbxad9FUFCnsUiFSg2PzuIn6LoOT9u
         Stsde1+6dbSK8Ot8xj8OoSrSm8PcKhgOzBhe/lpGHbY7ZoPT3aruv5+eMFubEyyNUUdg
         0qofEhC0+RNwovX7oFcrxEdxYCWUktDI5RQrVh+og06/ocfq0ZossVtSZij1PoYnUGV7
         Blog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9ee4zy4RkBCLXpL+JKk/4ZofQQA2htMYqURBy7ZeYvU=;
        b=i9aMe2cKlNyQ+yWHvohvyYpzpiUoXhaeJ1m8J9yz4GZiYxm4zU0bdHvB+jWFIkYLjh
         dbepeKLN1OlRzASghd4sHnJ0z6sEer15YlmKQK3yq7NOWBpyns94AS6jky8MYHRuEXqS
         rPS6+1TajGC+RcfavNeHRTGokd/qHc+GvDr9/JBrbopKopcPZ57fqPp2w78jfgo+gvHg
         6ILXqyuRcetvse24UV+EN50JxLTe4R9ViRlOZ9WL+yMicL/+IPRuhIwu0aV92Ow5xfRo
         pinQOrWID9lSsXjSE78AuMZJzitMXQ/sVOc+SVPDn4uxtktjKEEF437T5V5HOBCiOTJP
         ZfBQ==
X-Gm-Message-State: ACrzQf2RdJJYw+NbOWqWvDKZ2OIrZHxXOYVZfMK/mwmel1EiThnEgcSk
        al2Av9Xykqg2gjD6fFMOZ3w=
X-Google-Smtp-Source: AMsMyM5nr6EWOhB14bUG8yS5ghdC1g3ZWYUgkaCm9MJDD3GKWg9b02JkmOb6Ac2p/xc8H25rYhDEeA==
X-Received: by 2002:a63:1b4d:0:b0:439:db24:a3a6 with SMTP id b13-20020a631b4d000000b00439db24a3a6mr19752940pgm.539.1664815206648;
        Mon, 03 Oct 2022 09:40:06 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a4dc100b001efa9e83927sm10269982pjl.51.2022.10.03.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:40:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 06:40:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Message-ID: <YzsQZPONIJRgtf3o@slm.duckdns.org>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003154459.207538-2-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Waiman.

On Mon, Oct 03, 2022 at 11:44:57AM -0400, Waiman Long wrote:
> The lock-less list API is useful for dealing with list in a lock-less
> manner. However, one of the drawback of the current API is that there
> is not an easy way to determine if an entry has already been put into a
> lock-less list. This has to be tracked externally and the tracking will
> not be atomic unless some external synchronization logic is in place.
> 
> This patch introduces a new variant of the lock-less list terminated
> by a sentinel node instead of by NULL. The function names start with
> "sllist" instead of "llist". The advantage of this scheme is that we
> can atomically determine if an entry has been put into a lock-less
> list by looking at the next pointer of the llist_node. Of course, the
> callers must clear the next pointer when an entry is removed from the
> lockless list. This is done automatically when the sllist_for_each_safe
> or sllist_for_each_entry_safe iteraters are used. The non-safe versions
> of sllist iterator are not provided.

Any chance we can add sentinel to the existing llist instead of creating a
new variant? There's no real downside to always using sentinel, right?

Thanks.

-- 
tejun
