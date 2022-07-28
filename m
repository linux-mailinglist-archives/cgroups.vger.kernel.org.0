Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DC584473
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiG1Qzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiG1Qzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 12:55:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE5550A5;
        Thu, 28 Jul 2022 09:55:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so5522593pjh.0;
        Thu, 28 Jul 2022 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=/v3Gcn+hTL0SOyI/tztq8lNP5D0RrTqazuF4o/1KF3k=;
        b=KhZWRDXn2xsiTaRpuC25WJC2oEAedK39KKmcClr8IAYxJKLTnKimRaDfLzkdZcQN0O
         yhKQ1DOrbZYICCUCx7cFxq0fQbI3q/V/4/IcFYnleE9gemq31ZU9e+Vf8sryx0qKVHu0
         taudKvAkkTIflxzG55p9RIeN1ji5KjqbvTr8wRNt6/ybqVSm9CLEIHsh0B6c3nrqeJkb
         kz2oJruSwXOeZdvyOieGQotwUPsfmJWgVM38LrcLHIVXo0UQdqgPLqOhyf9ErM1VP0Mq
         kyD9+JIyR7g/q/CNR7jAn/+uArIZcSFGqY3L0dUPjQBvffcMuHTqB9eMgI79oKVC8wSH
         /R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=/v3Gcn+hTL0SOyI/tztq8lNP5D0RrTqazuF4o/1KF3k=;
        b=OXoi0Jw7HVvNcRlTB6vSVJeJouXG741tL6P3Z6LZZarPd1rRXV9xUkYxq76kGG9gXQ
         aGQoYXsg8NFkD2EhYrZDJuoPlSs+2gNNUqG34p4t4ipCkeSpYynvFwmkfR+N6Q9N2Qb2
         n0sWaCyh4R9xsGWz1E3cdwiFDhRRFrowuQcxAL2kmT3YgI7b7/RbvEUMi/Z4xr38BYRI
         G+MihBRrbqCjWpDMepwxR/g3j9UAHgYRCJ4ZHYxLntZy8LKa5olGZVdapuVEL3ZA4FFv
         Ad3Rl95RqxHVTh31rxeWO0FMgBCUUDgokQoETMC0F2WsPiA+5dogJPWZk2yOxxgtn5c1
         oqag==
X-Gm-Message-State: AJIora8xisGpsWUnRCIGwrK5mlBMMny7rjQGB3D0G8zgJIgojogcRhqY
        4G5UFBVUZ1/GhpRJyPTjAA0=
X-Google-Smtp-Source: AGRyM1v91WoHUfzBJ1uaof84UM74engDsn1pKS4xnYLdVfhv/5BBIuniD7LFRW3JxEk6r72ET/ecgw==
X-Received: by 2002:a17:902:7089:b0:16c:91d7:e422 with SMTP id z9-20020a170902708900b0016c91d7e422mr27423533plk.73.1659027335302;
        Thu, 28 Jul 2022 09:55:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f77-20020a623850000000b00528d41a998csm1066688pfa.15.2022.07.28.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:55:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 06:55:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        axboe@kernel.dk, ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RESEND v6 4/8] blk-throttle: fix io hung due to config
 updates
Message-ID: <YuK/hXnFA+qu5EMB@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-5-yukuai1@huaweicloud.com>
 <YuGGVxdlOVk/eF2l@slm.duckdns.org>
 <20220728093346.GA2281@blackbody.suse.cz>
 <0bbf3d0c-88c4-8120-3df3-960dda041864@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bbf3d0c-88c4-8120-3df3-960dda041864@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 28, 2022 at 06:34:44PM +0800, Yu Kuai wrote:
> Hi
> 
> 在 2022/07/28 17:33, Michal Koutný 写道:
> > On Wed, Jul 27, 2022 at 08:39:19AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > I'm not quiet sure this is correct. What if the limit keeps changing across
> > > different values? Then we'd be calculating the skipped amount based on the
> > > last configuration only which would be incorrect.
> > 
> > When one change of configuration is correct, then all changes must be
> > correct by induction. It's sufficient to take into account only the one
> > old config and the new one.
> > 
> > This __tg_update_skipped() calculates bytes_skipped with the limit
> > before the change and bytes_skipped are used (divided by) the new limit
> > in tg_with_in_bps_limit().
> > The accumulation of bytes_skipped across multiple changes (until slice
> > properly ends) is proportional to how bytes_allowed would grow over
> > time.
> > That's why I find this correct (I admit I had to look back into my
> > notes when this was first discussed).
> > 
> > HTH,
> > Michal
> > 
> 
> Hi, Tejun
> 
> Michal already explain it very well, please let me know if you still
> thinks there are better ways.

Ah, I see, so it's integrating into the skipped counters across multiple
updates. I think it can definitely use comments explaining how it's working
but that looks okay.

Thanks.

-- 
tejun
