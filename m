Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C306473B9
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLHP7m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 10:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHP7k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 10:59:40 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E889AEA;
        Thu,  8 Dec 2022 07:59:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 6so1506729pgm.6;
        Thu, 08 Dec 2022 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0YLsvBKzhSCVgibbSxOvtb/WdQ/EJIsYcqmRJMPdrA=;
        b=LKqMi50ut5W+4QYLYDzZRJz8rOYDM1FZOI+bsaRUBjbfPxkaXOkGHv/B58zlQJCVp9
         MOjRUaRqxNz0nLVuO6/F76JbXbGZitk+2iyDmotSKGPXPoVVHHddmOrwt9KP6Mv6y5Xd
         SxD/qLNSLtneYFA9954fdAcCxDvWe7t+RaCdqX50dbiBJuc0xdbdRlVvJKMOZr6k2AeA
         UN4OLtD63b3uEgMi5eMop+qH9rGyXYzEIxZ1PinFgbvoWMIZ8pq6K8gfKFZ/b8EHRO6N
         rXk0i0ECbUePeDcBgMkYPccKs/o9Q4EQc3aSt5FYGtktl4E40BnuiUuFe8kE39ATlds/
         GDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0YLsvBKzhSCVgibbSxOvtb/WdQ/EJIsYcqmRJMPdrA=;
        b=p01k9VIyA0yWCShjml6FkmnPt8vCsCvHHJeUMDkO4GTJGDsx9OVzUvqyJ6MH6KKten
         +1Gnvsz2qTHoMc0HGi69hCleoP+ZkA92oKLTkGD9lNCxMiwjZIo4SaJXAbEjhAoEEtps
         JLjRWHcpsaKxdDE2Tx4TDGU7XsyC5/RncrhogMMszqFGi09WoTA3IuOjUSQyaPAXQqMz
         9DNP9zU9HfqPldmDN7cSImo6zBxXZk/oaao/qeTdlGqYgUP7tZdj982F3+8Nq4FG8AlQ
         itHwA5+hVjan7yOjxAUmFjJWdt9GeCX6e8GjgThzHJyTEVXV/EPUPvQuHiHX7Ernd+Gz
         mUuQ==
X-Gm-Message-State: ANoB5pnBVZWk2rSxif8tPhrfCDn/o/SjxjhtXZAtRy3dRCJ98z8ruKSW
        30OB2ZL3jkM+EOUE1C8NYtQ=
X-Google-Smtp-Source: AA0mqf5fUWNBxoR7bQr+SHUqc2hyMkzGP2cITTq2LBCg5GHCZkrG2V5QTuBQmVq/ebNqbnw1rkjP8A==
X-Received: by 2002:a62:648a:0:b0:572:76dd:3756 with SMTP id y132-20020a62648a000000b0057276dd3756mr78402506pfb.9.1670515178140;
        Thu, 08 Dec 2022 07:59:38 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001893a002107sm16781662plb.0.2022.12.08.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:59:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Dec 2022 05:59:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <Y5IJ6Nk56KPBhpfr@slm.duckdns.org>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
 <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
 <Y31sYFdA2lHIvjt3@slm.duckdns.org>
 <ec3754a6-3249-51ab-b659-fd795884e346@huaweicloud.com>
 <f227e4bd-c74b-a02e-2a02-11a1376ee4f9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f227e4bd-c74b-a02e-2a02-11a1376ee4f9@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 05, 2022 at 05:39:33PM +0800, Yu Kuai wrote:
> Hi, Tejun
> 
> 在 2022/11/23 18:22, Yu Kuai 写道:
> > Hi, Tejun
> > 
> > 在 2022/11/23 8:42, Tejun Heo 写道:
> > > On Tue, Nov 22, 2022 at 05:14:29PM -0700, Jens Axboe wrote:
> > > > > > Then match_strdup() and kfree() in match_NUMBER() can be replaced with
> > > > > > get_buffer() and put_buffer().
> > > > > 
> > > > > Sorry about the late reply. Yeah, something like this.
> > 
> 
> I wonder can we just use arary directly in stack? The max size is just
> 24 bytes, which should be fine:
> 
> HEX: "0xFFFFFFFFFFFFFFFF" --> 18
> DEC: "18446744073709551615" --> 20
> OCT: "01777777777777777777777" --> 23
> 
> Something like:
> #define U64_MAX_SIZE 23
> static int match_strdup_local(const substring_t *s, char *buf)
> {
> 	size_t len = s->to - s->from;
> 
> 	if (len > U64_MAX_SIZE)
> 		return -ERANGE;
> 
> 	if (!s->from)
> 		return -EINVAL;
> 
> 	memcpy(buf, s->from, len);
> 	buf[len] = '\0';
> 	return 0;
> }
> 
>  static int match_u64int(substring_t *s, u64 *result, int base)
>  {
> 	char buf[U64_MAX_SIZE + 1];
>  	int ret;
>  	u64 val;
> 
> 	ret = match_strdup_local(s, buf);
> 	if (ret)
> 		return ret;
>  	ret = kstrtoull(buf, base, &val);
>  	if (!ret)
>  		*result = val;;
>  	return ret;
>  }

Oh yeah, absolutely. That's much better.

Thanks.

-- 
tejun
