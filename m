Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422878CC54
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjH2Sox (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjH2So3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 14:44:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F71A4;
        Tue, 29 Aug 2023 11:44:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so2306233b3a.2;
        Tue, 29 Aug 2023 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693334666; x=1693939466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wRQp/5cBNehRizqtkTinmdKAq2BLV1uZRrSduBoGzQ=;
        b=eO3giI69gA6zCVBejdv1IiMWcFUWtOYFqcwri4XyLvhwMhJLoL64qD0pT6tIPchAH1
         MOFcBD2MkA/8nQjQsa0a/wa9veeDWnaUfKnc/mad86OjQ73leWKtlgnoU8u90jiAWVcu
         8JnJx+w2tQ9ZQnKLMah6N493MKPoMJlxvDZ2jIsEAvinTjftCUZX9587Hu1azKhfQJUU
         TL2yLsQ3McrnQQDOSwwR5x20hWW17gh6P1B3YgyfzBDjuvySmLoKAp7rgDHcbQssWzHs
         FxOiMijq7gnmJ79gFXBcpx95jUTEedU4wyddKuhbE1xX7p2CxXfnCeuRYtnFL7fqvElX
         /zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334666; x=1693939466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wRQp/5cBNehRizqtkTinmdKAq2BLV1uZRrSduBoGzQ=;
        b=GwjqTljDo43yUq15Z9gfcr+qp+KzxnEUR/YQwtRSrsbU6Z2JxcmXs127BsEw9ffWeY
         PTKQDvnkYAoongW6R4zyte2+hTUl8kZwbrM4Unbk2vFm3dBh466pxOWizgRZcymdtvRh
         AijHt95wrUQV2fSWR5hxwVUiDfks3C6QF6Je6HeZumc/Rddus1onfNNkmm7hx3HrOx4W
         +V+S2j9XmqkHx+9rFoPLd2ZP3b0YJn/mcjoZ4X0YxxNZXy6ADvLK3FlLJ3U9VWtUQvQ/
         maUd6IZ1UQQ4JP+DioQbsNvIxtLCV7jDJZDD3slclHCrPw2fiYjieoIVQMXHA1x4SfPt
         yPKw==
X-Gm-Message-State: AOJu0YybdUd/VwZjbZ1dpltlkfg7GsnAMy3Z0GsO+Guc7pW+CYoZwBe7
        3d+vmSZZ4WwjFdmJCkABdDk=
X-Google-Smtp-Source: AGHT+IFj/vKyxTOrqfXOhoGBFsBE++kcdb2Z1tiqAfT+c3JgcPzCAt3Y3NSYxmqcdxH06qVgNQO3ow==
X-Received: by 2002:a05:6a00:b54:b0:68a:69ba:6789 with SMTP id p20-20020a056a000b5400b0068a69ba6789mr105680pfo.16.1693334665640;
        Tue, 29 Aug 2023 11:44:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f05])
        by smtp.gmail.com with ESMTPSA id ey6-20020a056a0038c600b006828e49c04csm8843046pfb.75.2023.08.29.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:44:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 08:44:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZO48h7c9qwQxEPPA@slm.duckdns.org>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 25, 2023 at 09:05:46AM +0200, Michal Hocko wrote:
> > > I think that's how it was always meant to be when it was designed. The
> > > global rstat lock has always existed and was always available to
> > > userspace readers. The memory controller took a different path at some
> > > point with unified flushing, but that was mainly because of high
> > > concurrency from in-kernel flushers, not because userspace readers
> > > caused a problem. Outside of memcg, the core cgroup code has always
> > > exercised this global lock when reading cpu.stat since rstat's
> > > introduction. I assume there hasn't been any problems since it's still
> > > there.
> 
> I suspect nobody has just considered a malfunctioning or adversary
> workloads so far.
> 
> > > I was hoping Tejun would confirm/deny this.
> 
> Yes, that would be interesting to hear.

So, the assumptions in the original design were:

* Writers are high freq but readers are lower freq and can block.

* The global lock is mutex.

* Back-to-back reads won't have too much to do because it only has to flush
  what's been accumulated since the last flush which took place just before.

It's likely that the userspace side is gonna be just fine if we restore the
global lock to be a mutex and let them be. Most of the problems are caused
by trying to allow flushing from non-sleepable and kernel contexts. Would it
make sense to distinguish what can and can't wait and make the latter group
always use cached value? e.g. even in kernel, during oom kill, waiting
doesn't really matter and it can just wait to obtain the up-to-date numbers.

Thanks.

-- 
tejun
